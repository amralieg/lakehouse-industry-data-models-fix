-- Schema for Domain: reporting | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`reporting` COMMENT 'Manages statutory, GAAP, IFRS 17, and management reporting definitions, report schedules, data mart configurations, regulatory filing templates (NAIC annual/quarterly statements, Schedule S, Exhibit 5/6/7), and report distribution. Owns report metadata, not the underlying financial data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_definition` (
    `report_definition_id` BIGINT COMMENT 'Unique identifier for the report definition. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: Agencies are statutory reporting entities for NAIC filings, state appointments, production roll-ups, hierarchical reporting. Real business need: agency-level regulatory compliance and management repor',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to agent.compliance_event. Business justification: Compliance events trigger regulatory reports: SAR filings, FINRA disclosures, state DOI notifications, internal audit reports. Real business need: regulatory disclosure and compliance monitoring repor',
    `gaap_report_config_id` BIGINT COMMENT 'Foreign key linking to reporting.gaap_report_config. Business justification: GAAP-specific report_definitions reference gaap_report_config for reporting parameters. Cardinality: 1 report → 1 config (if GAAP-specific), 1 config → many reports. Adding FK links GAAP reports to th',
    `ifrs17_report_config_id` BIGINT COMMENT 'Foreign key linking to reporting.ifrs17_report_config. Business justification: IFRS 17-specific report_definitions reference ifrs17_report_config for reporting parameters. Cardinality: 1 report → 1 config (if IFRS 17-specific), 1 config → many reports. Adding FK links IFRS 17 re',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to agent.incentive_program. Business justification: Incentive programs require tracking reports: qualification reports, payout reports, FINRA non-cash compensation disclosures. Real business need: program administration and regulatory compliance report',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Regulatory filings (NAIC Annual Statement Schedule T, Exhibit 5) and management reports require product-level detail. Statutory exhibits, profitability reports, and experience studies are generated FO',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Rate filings, version-specific compliance reports, and actuarial analyses target exact plan versions. Real business need: regulatory filings reference specific plan versions for rate approvals, actuar',
    `predecessor_report_definition_id` BIGINT COMMENT 'Foreign key reference to the previous version of this report definition, enabling version history tracking. Null for the first version.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Producer-specific reports are core to Life Insurance operations: commission statements, production dashboards, compliance monitoring (Form U4/U5), state appointment filings. Producers are reporting en',
    `production_activity_id` BIGINT COMMENT 'Foreign key linking to agent.production_activity. Business justification: Production metrics feed management reports: monthly production dashboards, commission reports, forecasting models, incentive tracking. Real business process: sales performance monitoring and compensat',
    `parent_report_definition_id` BIGINT COMMENT 'Self-referencing FK on report_definition (parent_report_definition_id)',
    `approval_date` DATE COMMENT 'Date on which this report definition was formally approved for production use.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the report definition: draft (under development), pending_review (awaiting approval), approved (active and in use), deprecated (no longer recommended but still available), archived (retired and no longer generated).. Valid values are `draft|pending_review|approved|deprecated|archived`',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a detailed audit trail of report generation, data lineage, and user access must be maintained for this report (True) or not (False). Typically True for statutory and regulatory reports.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the report output: public (publicly disclosed), internal (internal use only), confidential (sensitive business information), restricted (highly sensitive, limited access).. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this report definition record was first created in the system.',
    `data_mart_source` STRING COMMENT 'Name or identifier of the data mart, data warehouse layer, or analytical database that sources the data for this report (e.g., financial_reporting_mart, statutory_accounting_mart, actuarial_valuation_mart).',
    `data_quality_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum acceptable data quality score (as a percentage, 0.00-100.00) that must be met before this report can be generated and distributed. Reports failing this threshold trigger data quality alerts.',
    `distribution_list` STRING COMMENT 'Comma-separated list of email addresses or distribution group names to which this report should be automatically distributed upon generation.',
    `effective_end_date` DATE COMMENT 'Date on which this report definition is no longer effective and should be replaced by a newer version. Null if currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this report definition becomes effective and should be used for report generation. Supports versioning and regulatory change management.',
    `estimated_generation_time_minutes` STRING COMMENT 'Estimated time in minutes required to generate this report from data extraction through final output. Used for scheduling and capacity planning.',
    `filing_deadline_rule` STRING COMMENT 'Business rule describing when the report must be filed relative to the reporting period end (e.g., 60 days after year-end, 45 days after quarter-end, March 1 annually). Used to calculate actual filing deadlines.',
    `frequency` STRING COMMENT 'Scheduled frequency at which this report is generated and filed: annual, quarterly, monthly, weekly, daily, or ad_hoc (on-demand).. Valid values are `annual|quarterly|monthly|weekly|daily|ad_hoc`',
    `generation_schedule_cron` STRING COMMENT 'Cron expression defining the automated schedule for report generation (e.g., 0 0 1 1 * ? for annually on January 1st at midnight). Used by report scheduling systems.',
    `last_generated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful generation of this report. Used for monitoring and operational tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this report definition record was last updated. Used for change tracking and audit purposes.',
    `legal_entity_scope` STRING COMMENT 'Defines the legal entity coverage of the report: single_entity (one legal entity), consolidated (parent and subsidiaries), segment (specific business segment or line of business), or all_entities (enterprise-wide across all legal entities).. Valid values are `single_entity|consolidated|segment|all_entities`',
    `line_of_business` STRING COMMENT 'Specific line of business or product segment this report covers (e.g., Life Insurance, Annuities, Variable Products, Group Life, Individual Life). Null if report spans all lines of business.',
    `next_scheduled_generation_timestamp` TIMESTAMP COMMENT 'Timestamp of the next scheduled generation of this report based on the generation schedule. Used for planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, known issues, or historical context related to this report definition. Used by report administrators and business owners.',
    `owning_business_unit` STRING COMMENT 'Name of the business unit, department, or function responsible for producing and maintaining this report (e.g., Corporate Finance, Actuarial, Regulatory Reporting, Tax).',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this report requires formal reconciliation to source systems or other reports before distribution (True) or not (False). Typically True for financial and statutory reports.',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory authority requiring this report (e.g., NAIC, SEC, State Department of Insurance - New York, IRS, FINRA). Null for internal management reports.',
    `report_code` STRING COMMENT 'Business identifier code for the report definition, used for external reference and system integration (e.g., NAIC_ANNUAL_STMT, GAAP_Q1, IFRS17_CSM).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `report_complexity_score` STRING COMMENT 'Numeric score (1-10) representing the technical and business complexity of this report, considering data sources, calculations, regulatory requirements, and review processes. Used for resource planning and risk assessment.',
    `report_description` STRING COMMENT 'Detailed business description of the report purpose, content, audience, and key metrics or schedules included. Provides context for report users and data stewards.',
    `report_name` STRING COMMENT 'Full business name of the report definition (e.g., NAIC Annual Statement - Life and Annuity, GAAP Quarterly Financial Report).',
    `report_output_format` STRING COMMENT 'Primary file format in which the report is generated and delivered: PDF, Excel, CSV, XML, XBRL (eXtensible Business Reporting Language for regulatory filings), HTML, or Word. [ENUM-REF-CANDIDATE: PDF|Excel|CSV|XML|XBRL|HTML|Word — 7 candidates stripped; promote to reference product]',
    `report_template_reference` STRING COMMENT 'Reference to the standard template or form used for this report (e.g., NAIC Annual Statement Blank - Life/A&H, SEC Form 10-K, Schedule S, Exhibit 5, Exhibit 6, Exhibit 7). Links to document management system or regulatory filing system.',
    `report_type` STRING COMMENT 'Classification of the report by accounting or reporting framework: statutory (SAP-based), GAAP (Generally Accepted Accounting Principles), IFRS 17 (International Financial Reporting Standards 17), management (internal decision support), regulatory (non-statutory regulatory filings), or internal (ad-hoc/operational).. Valid values are `statutory|gaap|ifrs17|management|regulatory|internal`',
    `reporting_framework` STRING COMMENT 'Specific accounting or regulatory framework governing this report: NAIC Statutory Accounting Principles (NAIC_SAP), US Generally Accepted Accounting Principles (US_GAAP), International Financial Reporting Standards 17 (IFRS17), Sarbanes-Oxley Act (SOX), Long Duration Targeted Improvements (LDTI), Principle-Based Reserving (PBR), or internal management framework. [ENUM-REF-CANDIDATE: NAIC_SAP|US_GAAP|IFRS17|SOX|LDTI|PBR|internal — 7 candidates stripped; promote to reference product]',
    `retention_period_years` STRING COMMENT 'Number of years this report and its underlying data must be retained to meet regulatory, legal, and business requirements.',
    `sox_scope_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this report is within the scope of Sarbanes-Oxley Act (SOX) internal controls and must undergo SOX compliance testing (True) or not (False).',
    `version_number` STRING COMMENT 'Semantic version number of this report definition (e.g., 1.0, 2.1, 3.0.1). Incremented when report structure, logic, or regulatory requirements change.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `xbrl_taxonomy_version` STRING COMMENT 'Version of the XBRL taxonomy used for this report if output format is XBRL (e.g., US-GAAP-2023, NAIC-SAP-2023). Null if XBRL is not used.',
    CONSTRAINT pk_report_definition PRIMARY KEY(`report_definition_id`)
) COMMENT 'Master catalog of all report definitions managed by the reporting domain — statutory (NAIC annual/quarterly statements), GAAP, IFRS 17, management, and regulatory reports. Captures report name, report type (statutory/GAAP/IFRS17/management/regulatory), reporting framework, legal entity scope, frequency (annual/quarterly/monthly/ad-hoc), owning business unit, effective date range, regulatory authority, and approval status. SSOT for report metadata — does NOT store underlying financial data.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_schedule` (
    `report_schedule_id` BIGINT COMMENT 'Unique identifier for the report schedule record. Primary key.',
    `job_role_id` BIGINT COMMENT 'Reference to the role or individual authorized to approve this report before distribution, typically a finance officer, actuary, or compliance manager.',
    `employee_id` BIGINT COMMENT 'Reference to the individual or role responsible for managing this schedule, ensuring timely execution, and addressing any issues.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition that this schedule executes. Links to the report metadata and template configuration.',
    `tertiary_report_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this schedule record, supporting accountability and audit requirements.',
    `superseded_report_schedule_id` BIGINT COMMENT 'Self-referencing FK on report_schedule (superseded_report_schedule_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the report output requires formal approval or sign-off before distribution or regulatory submission.',
    `blackout_period_end_date` DATE COMMENT 'End date of the blackout period, after which the schedule resumes normal execution cadence.',
    `blackout_period_start_date` DATE COMMENT 'Start date of any blackout period during which this schedule is suspended, typically for year-end close, system maintenance, or regulatory quiet periods.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit, division, or legal entity for which this report schedule is configured, supporting multi-entity reporting structures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was first created in the system, supporting audit trails and change tracking.',
    `data_mart_source` STRING COMMENT 'Name or identifier of the data mart, data warehouse layer, or analytical database from which this report sources its data.',
    `distribution_list` STRING COMMENT 'Comma-separated list of email addresses or distribution group identifiers to which the completed report is automatically sent upon successful execution.',
    `effective_end_date` DATE COMMENT 'Date on which this schedule is retired or superseded, supporting historical tracking and regulatory compliance for discontinued reports.',
    `effective_start_date` DATE COMMENT 'Date from which this schedule becomes active and begins executing according to its cadence, supporting phased rollout of new reporting requirements.',
    `execution_window_end_time` TIMESTAMP COMMENT 'Latest timestamp by which the report execution must complete, ensuring timely availability for downstream processes and review.',
    `execution_window_start_time` TIMESTAMP COMMENT 'Earliest timestamp at which the report execution may begin, supporting batch processing windows and system resource management.',
    `filing_deadline_date` DATE COMMENT 'External regulatory or statutory deadline by which the report must be filed with governing bodies such as NAIC, state departments of insurance, SEC, or IRS.',
    `frequency_cadence` STRING COMMENT 'Recurring frequency at which the report is scheduled to run: daily, weekly, monthly, quarterly, annual, or ad-hoc (on-demand).. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `ifrs17_compliance_flag` BOOLEAN COMMENT 'Indicates whether this schedule must comply with IFRS 17 insurance contracts standard, applicable for entities reporting under international accounting frameworks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this schedule record, supporting change tracking and version control.',
    `last_successful_run_date` DATE COMMENT 'The most recent date on which this report schedule completed successfully without errors.',
    `ldti_compliance_flag` BOOLEAN COMMENT 'Indicates whether this schedule must comply with FASB ASC 944 Long Duration Targeted Improvements (LDTI) requirements for liability measurement and disclosure.',
    `naic_schedule_reference` STRING COMMENT 'Reference to the specific NAIC annual or quarterly statement schedule (e.g., Schedule S, Exhibit 5, Exhibit 6, Exhibit 7) that this schedule produces.',
    `next_scheduled_run_date` DATE COMMENT 'The next calendar date on which this report is scheduled to execute, based on the frequency cadence and any blackout periods.',
    `notification_email` STRING COMMENT 'Primary email address to which execution status notifications, error alerts, and completion confirmations are sent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this schedule, determining execution order and resource allocation when multiple reports are queued.. Valid values are `critical|high|medium|low`',
    `regulatory_submission_deadline` TIMESTAMP COMMENT 'Precise timestamp (including time zone) by which the regulatory submission must be received by the governing authority, accounting for electronic filing system cutoffs.',
    `report_due_date` DATE COMMENT 'Internal business due date by which the report must be completed and available for review, prior to any external filing deadline.',
    `report_template_version` STRING COMMENT 'Version identifier of the report template or layout used by this schedule, supporting template change management and audit trails.',
    `reporting_period_offset_days` STRING COMMENT 'Number of days after period end before the report is scheduled to run, allowing time for data finalization, reconciliation, and close processes.',
    `reporting_period_type` STRING COMMENT 'Type of period used for this schedule: calendar year/quarter, fiscal year/quarter, policy year, or contract year, aligning with accounting and actuarial conventions.. Valid values are `calendar|fiscal|policy_year|contract_year`',
    `retry_count_limit` STRING COMMENT 'Maximum number of automatic retry attempts allowed if the scheduled report execution fails, before escalating to manual intervention.',
    `schedule_code` STRING COMMENT 'Unique business code or identifier for the schedule, often used in regulatory filings and cross-system references.',
    `schedule_description` STRING COMMENT 'Detailed business description of the schedule purpose, scope, audience, and any special instructions or dependencies.',
    `schedule_name` STRING COMMENT 'Business-friendly name for this report schedule instance, used for identification and tracking in the reporting calendar.',
    `schedule_notes` STRING COMMENT 'Free-text field for operational notes, special instructions, known issues, or historical context related to this schedule.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule: active (in production), suspended (temporarily paused), retired (no longer used), or pending (awaiting activation).. Valid values are `active|suspended|retired|pending`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by reporting framework: statutory (SAP), GAAP, IFRS 17, management reporting, regulatory filing, or internal analytics.. Valid values are `statutory|gaap|ifrs17|management|regulatory|internal`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this schedule is subject to SOX internal controls over financial reporting, requiring additional audit trails and approval workflows.',
    CONSTRAINT pk_report_schedule PRIMARY KEY(`report_schedule_id`)
) COMMENT 'Defines the recurring production schedule for each report definition — capturing scheduled run date, due date, filing deadline, regulatory submission deadline, frequency cadence, blackout periods, and schedule owner. Manages the reporting calendar for all statutory, GAAP, IFRS 17, and management reports. Tracks next scheduled run, last successful run, and schedule status (active/suspended/retired).';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_run` (
    `report_run_id` BIGINT COMMENT 'Unique identifier for each individual report production execution event. Primary key for the report run transaction.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Report execution instances generating contract-level detail reports (valuation reports, contract status reports, regulatory extracts) must reference specific contracts for data lineage, audit trails, ',
    `parent_run_report_run_id` BIGINT COMMENT 'Reference to the original report run if this is a retry or restatement. Maintains lineage for corrected or re-executed reports.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated this report run for manual or ad-hoc executions. Null for scheduled or system-triggered runs.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition that was executed in this run. Links to the report metadata and template configuration.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each report_run is executed for a specific reporting_period. Cardinality: 1 run → 1 period, 1 period → many runs. Adding FK links execution to the period being reported. Columns reporting_period_start',
    `report_schedule_id` BIGINT COMMENT 'Reference to the report schedule that triggered this run for automated executions. Null for manual or ad-hoc runs.',
    `report_version_id` BIGINT COMMENT 'Foreign key linking to reporting.report_version. Business justification: Each report_run produces a report_version output artifact. The run creates the version. Cardinality: 1 run → 1 version (at completion). Adding FK links execution to its output. Column version_number (',
    `rerun_report_run_id` BIGINT COMMENT 'Self-referencing FK on report_run (rerun_report_run_id)',
    `approval_required_indicator` BOOLEAN COMMENT 'Flag indicating whether this report requires management or actuarial approval before distribution or filing. Common for regulatory submissions.',
    `approval_status` STRING COMMENT 'Current approval status for reports requiring review. Tracks the approval workflow state for regulatory and management reports.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the report was approved. Critical for audit trails and regulatory compliance documentation.',
    `archive_date` DATE COMMENT 'Date when this report run was archived to long-term storage. Used for retention policy management and storage optimization.',
    `comments` STRING COMMENT 'Free-text comments or notes about this report run. Used for documenting special circumstances, data quality issues, or restatement reasons.',
    `data_as_of_date` DATE COMMENT 'The point-in-time date for which the report data represents the business state. Critical for regulatory filings and historical analysis.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score (0-100) for the source data used in this report run. Based on completeness, accuracy, and consistency checks.',
    `data_source_system` STRING COMMENT 'Primary source system or data mart from which the report data was extracted (e.g., Policy Administration System, Actuarial Valuation System, Financial Data Warehouse).',
    `distribution_list` STRING COMMENT 'Comma-separated list of recipients or distribution groups to whom this report was sent. Used for audit trails and access tracking.',
    `distribution_timestamp` TIMESTAMP COMMENT 'Timestamp when the report was distributed to recipients. Tracks the completion of the full report lifecycle including delivery.',
    `error_code` STRING COMMENT 'Standardized error code for failed report runs. Enables categorization and automated alerting for common failure patterns.',
    `error_message` STRING COMMENT 'Detailed error or exception message captured when a report run fails. Used for troubleshooting and operational support.',
    `filing_deadline_date` DATE COMMENT 'Required submission deadline for regulatory filings. Critical for compliance monitoring and timely submission to avoid penalties.',
    `filing_jurisdiction` STRING COMMENT 'State or regulatory jurisdiction to which this report will be filed (e.g., NY, CA, TX for state insurance departments, or SEC for variable products).',
    `output_file_path` STRING COMMENT 'Storage location or URI where the generated report output file is stored. Used for retrieval and distribution.',
    `output_file_size_bytes` BIGINT COMMENT 'Size of the generated report file in bytes. Used for storage management and transmission planning.',
    `output_format` STRING COMMENT 'File format in which the report was generated. Regulatory filings often require specific formats (e.g., NAIC XML, PDF for annual statements).. Valid values are `pdf|excel|csv|xml|json|html`',
    `priority_level` STRING COMMENT 'Execution priority assigned to this report run. Regulatory filings and executive reports typically receive higher priority for resource allocation.. Valid values are `critical|high|normal|low`',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation checks performed against control totals or prior period reports. Critical for financial and actuarial reports.. Valid values are `reconciled|variance_detected|pending|not_required`',
    `record_count` BIGINT COMMENT 'Total number of data records or rows processed and included in the generated report output. Used for data quality validation and reconciliation.',
    `regulatory_filing_indicator` BOOLEAN COMMENT 'Flag indicating whether this report run is intended for submission to a regulatory body (NAIC, state insurance department, SEC, FINRA).',
    `report_type` STRING COMMENT 'Classification of the report being executed (e.g., NAIC Annual Statement, Quarterly Statement, Schedule S, Exhibit 5, Management Dashboard, Actuarial Valuation Report).',
    `reporting_framework` STRING COMMENT 'Accounting or regulatory framework under which this report was produced. Critical for insurance companies managing multiple reporting standards (SAP, GAAP, IFRS 17).. Valid values are `statutory|gaap|ifrs17|management|regulatory|internal`',
    `retention_expiry_date` DATE COMMENT 'Date when this report run is eligible for deletion per retention policies. Regulatory reports typically have 7-10 year retention requirements.',
    `retry_count` STRING COMMENT 'Number of times this report run has been retried after initial failure. Used for operational monitoring and alerting thresholds.',
    `run_completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the report execution process completed (successfully or with failure). Null for in-progress runs.',
    `run_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from run initiation to completion. Used for performance analysis and SLA monitoring.',
    `run_number` STRING COMMENT 'Business-friendly identifier for this report execution, often used for external reference and audit trails. May follow organizational numbering conventions.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the report execution process was initiated. Used for performance monitoring and operational audit trails.',
    `run_status` STRING COMMENT 'Current lifecycle status of the report execution. Tracks the operational state from initiation through completion or failure.. Valid values are `initiated|in_progress|completed|failed|cancelled|suspended`',
    `trigger_type` STRING COMMENT 'Mechanism that initiated this report run. Distinguishes between automated scheduled runs, user-initiated manual runs, regulatory filing demands, and system-triggered executions.. Valid values are `scheduled|manual|regulatory_demand|ad_hoc|system_event|exception`',
    CONSTRAINT pk_report_run PRIMARY KEY(`report_run_id`)
) COMMENT 'Transactional record of each individual report production execution — capturing run timestamp, triggered-by (scheduled/manual/regulatory demand), run status (initiated/in-progress/completed/failed/cancelled), data-as-of date, reporting period start/end, version number, run duration, record count, and completion timestamp. Provides the operational audit trail for every report generation event across all frameworks.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_version` (
    `report_version_id` BIGINT COMMENT 'Unique identifier for each report version record. Primary key.',
    `report_definition_id` BIGINT COMMENT 'Reference to the parent report definition that this version belongs to. Links to the report catalog entry.',
    `superseded_version_report_version_id` BIGINT COMMENT 'Reference to the previous report version that this version replaces or supersedes. Null for the initial version. Enables version lineage tracking and restatement audit trails.',
    `prior_report_version_id` BIGINT COMMENT 'Self-referencing FK on report_version (prior_report_version_id)',
    `accounting_basis` STRING COMMENT 'The accounting framework under which this report version was prepared. SAP = Statutory Accounting Principles (NAIC); GAAP = Generally Accepted Accounting Principles (US GAAP); IFRS17 = International Financial Reporting Standard 17; Management = internal management reporting basis; Tax = tax accounting basis.. Valid values are `SAP|GAAP|IFRS17|management|tax`',
    `approval_date` DATE COMMENT 'The date on which the approver granted final approval for this report version. Marks the official authorization for filing or distribution.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time of final approval. Provides exact audit trail for regulatory compliance and internal controls.',
    `approver_name` STRING COMMENT 'Full name of the individual who provided final approval for this report version. Typically a senior executive (CFO, Chief Actuary, CEO) with signatory authority for regulatory filings.',
    `approver_title` STRING COMMENT 'Job title or role of the approver (e.g., Chief Financial Officer (CFO), Chief Executive Officer (CEO), Chief Actuary). Confirms signatory authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this report version record was first created in the system. Audit trail for record creation.',
    `data_extraction_timestamp` TIMESTAMP COMMENT 'The date and time when the underlying data for this report version was extracted from the source system(s). Critical for understanding data freshness and as-of timing.',
    `data_source_system` STRING COMMENT 'The primary source system or data mart from which the data for this report version was extracted (e.g., Policy Administration System, Actuarial Valuation System, General Ledger, Financial Data Mart). Enables data lineage tracking.',
    `distribution_date` DATE COMMENT 'The date this report version was distributed to stakeholders (board of directors, regulators, external auditors, reinsurers, etc.). Null if not yet distributed.',
    `distribution_list` STRING COMMENT 'Comma-separated list or description of recipients who received this report version (e.g., Board of Directors, State DOI, External Auditor, Reinsurers). Supports audit trail for report dissemination.',
    `distribution_status` STRING COMMENT 'Current distribution state of this report version. Pending = awaiting distribution; Distributed = sent to intended recipients; Recalled = withdrawn after distribution; Archived = retired from active use.. Valid values are `pending|distributed|recalled|archived`',
    `filing_confirmation_number` STRING COMMENT 'Confirmation or tracking number issued by the regulatory authority upon receipt of the filing. Serves as proof of submission and reference for follow-up.',
    `filing_date` DATE COMMENT 'The date this report version was officially filed with the regulatory authority (e.g., state Department of Insurance, NAIC, SEC). Null if not yet filed or if this is an internal-only version.',
    `filing_method` STRING COMMENT 'The method or channel used to submit this report version to the regulatory authority. Electronic = online submission system; Portal = regulatory web portal; Paper = physical mail; Email = email submission; Fax = facsimile transmission.. Valid values are `electronic|paper|portal|email|fax`',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active version of the report. True = current version; False = superseded or historical version. Only one version per report definition should be current at any time.',
    `materiality_assessment` STRING COMMENT 'Assessment of whether the changes in this version are material to the financial statements or regulatory filing. Material = significant impact requiring disclosure; Immaterial = minor impact not requiring separate disclosure; Not Applicable = initial version or no changes.. Valid values are `material|immaterial|not_applicable`',
    `notes` STRING COMMENT 'Free-text notes or comments about this report version. May include special instructions, known issues, or context for reviewers and auditors.',
    `preparer_email` STRING COMMENT 'Email address of the report preparer for follow-up questions and audit inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'Full name of the individual or team responsible for preparing this report version. Required for audit trail and accountability in regulatory filings.',
    `preparer_title` STRING COMMENT 'Job title or role of the preparer (e.g., Senior Actuary, Financial Reporting Manager, Controller). Provides context for preparer authority and expertise.',
    `report_format` STRING COMMENT 'The output format or template used for this report version (e.g., NAIC Annual Statement, Schedule S, Exhibit 5, Exhibit 6, Exhibit 7, 10-K, 10-Q, internal dashboard). Identifies the regulatory or management template applied.',
    `report_output_checksum` STRING COMMENT 'Cryptographic hash (e.g., MD5, SHA-256) of the report output file. Ensures file integrity and detects tampering or corruption.',
    `report_output_file_format` STRING COMMENT 'The file format of the generated report output. PDF = Portable Document Format; XLSX = Excel spreadsheet; XML = Extensible Markup Language; HTML = web page; CSV = comma-separated values; JSON = JavaScript Object Notation.. Valid values are `PDF|XLSX|XML|HTML|CSV|JSON`',
    `report_output_file_path` STRING COMMENT 'The file system path or cloud storage location where the generated report output file (PDF, Excel, XML, etc.) is stored. Enables retrieval of the physical report artifact.',
    `report_output_file_size_bytes` BIGINT COMMENT 'The size of the generated report output file in bytes. Useful for storage management and transmission planning.',
    `reporting_period_end_date` DATE COMMENT 'The ending date of the financial or operational period covered by this report version. For annual statements, typically December 31; for quarterly, the last day of the quarter.',
    `reporting_period_start_date` DATE COMMENT 'The beginning date of the financial or operational period covered by this report version. For annual statements, typically January 1; for quarterly, the first day of the quarter.',
    `restatement_category` STRING COMMENT 'Classification of the type of restatement or amendment. Error Correction = correction of a prior period error; Change in Estimate = revision of accounting estimate; Change in Principle = change in accounting policy; Reclassification = presentation change without impact on net income or equity; Other = other types of amendments.. Valid values are `error_correction|change_in_estimate|change_in_principle|reclassification|other`',
    `restatement_reason` STRING COMMENT 'Detailed explanation of why this report version was restated or amended. Required for amended and restated versions to document the nature of the correction or revision. Null for initial and final versions that are not restatements.',
    `review_date` DATE COMMENT 'The date on which the reviewer completed their review of this report version. Critical for audit trail and timeline reconstruction.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this report version for accuracy and completeness before approval. Part of the control framework for financial reporting.',
    `reviewer_title` STRING COMMENT 'Job title or role of the reviewer (e.g., Chief Actuary, VP Finance, Compliance Officer). Establishes reviewer authority level.',
    `validation_error_count` STRING COMMENT 'The number of validation errors detected in this report version. Zero indicates a clean report; non-zero requires review and correction.',
    `validation_error_details` STRING COMMENT 'Detailed description of validation errors encountered, including error codes, messages, and affected data elements. Null if no errors detected.',
    `validation_status` STRING COMMENT 'Result of automated validation checks performed on this report version. Passed = all validation rules satisfied; Failed = one or more validation errors detected; Pending = validation in progress; Not Applicable = no validation rules defined.. Valid values are `passed|failed|pending|not_applicable`',
    `version_date` DATE COMMENT 'The date this specific version of the report was created or generated. Represents the as-of date for this version snapshot.',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this report output (e.g., 1.0, 2.1, Q1-2024-v3). Supports both numeric and alphanumeric versioning schemes.',
    `version_timestamp` TIMESTAMP COMMENT 'Precise date and time when this report version was generated or finalized. Provides audit trail granularity for regulatory compliance.',
    `version_type` STRING COMMENT 'Classification of the version status indicating the maturity and regulatory standing of the report output. Draft = work in progress; Preliminary = initial submission pending review; Final = approved and filed; Amended = correction to previously filed final; Restated = material revision requiring reissuance; Corrected = minor fix to previously filed version.. Valid values are `draft|preliminary|final|amended|restated|corrected`',
    CONSTRAINT pk_report_version PRIMARY KEY(`report_version_id`)
) COMMENT 'Tracks the full version history of each report output — capturing version number, version type (draft/preliminary/final/amended/restated), version date, preparer, reviewer, approver, approval date, reason for restatement or amendment, and superseded version reference. Enables regulatory audit trails for NAIC filings, GAAP financials, and IFRS 17 disclosures where version control and restatement history are mandatory.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` (
    `statutory_filing_id` BIGINT COMMENT 'Unique identifier for the statutory regulatory filing record.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: State statutory filings (Annual Statement, Quarterly filings) require direct contract references for Schedule A (annuity exhibits), reserve certifications, actuarial opinions, and regulatory examinati',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to agent.appointment. Business justification: Appointment data is core to state regulatory filings: new appointments, renewals, terminations must be filed with state DOI. Real regulatory requirement: mandatory state appointment notifications per ',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to agent.compliance_event. Business justification: Compliance events must be disclosed in statutory filings: Form U5 termination disclosures, state DOI notifications, regulatory action reporting. Real regulatory requirement: mandatory disclosure of di',
    `filing_template_id` BIGINT COMMENT 'Foreign key linking to reporting.filing_template. Business justification: Each statutory_filing is based on a specific filing_template. Cardinality: 1 filing → 1 template, 1 template → many filings. Adding FK links filing to the template it follows. No columns removed (fili',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key linking to policy.in_force_policy. Business justification: Statutory filings reference sample policies for exhibit documentation, rate filing support, product approval evidence. Regulatory requirement. Role-prefixed to indicate sampling purpose.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (insurance company or subsidiary) submitting this statutory filing.',
    `license_id` BIGINT COMMENT 'Foreign key linking to agent.license. Business justification: License data feeds mandatory state DOI filings: license renewals, continuing education compliance, appointment notifications, terminations. Real regulatory requirement: state insurance department repo',
    `prior_filing_statutory_filing_id` BIGINT COMMENT 'Reference to the previous statutory filing record that this filing amends or supersedes, establishing amendment lineage.',
    `rbc_calculation_id` BIGINT COMMENT 'Foreign key linking to finance.rbc_calculation. Business justification: Statutory filings reference specific RBC calculations for regulatory submission. Required for NAIC Annual Statement Schedule S (RBC Report) preparation. Domain experts expect direct linkage between th',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Statutory filings (Annual Statement, Quarterly Statement, RBC filing) are submitted to satisfy specific regulatory obligations. The statutory_filing product currently lacks a direct obligation referen',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each statutory_filing is for a specific reporting_period. Cardinality: 1 filing → 1 period, 1 period → many filings. Adding FK links filing to the period being filed. Columns filing_period_start_date,',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: Statutory filings (Annual Statement, quarterly statements) incorporate reserve calculations from specific valuation runs. Schedule S, Schedule T, and other exhibits require traceability to the actuari',
    `amended_statutory_filing_id` BIGINT COMMENT 'Self-referencing FK on statutory_filing (amended_statutory_filing_id)',
    `acceptance_date` DATE COMMENT 'Date the regulatory authority formally accepted the statutory filing as complete and compliant.',
    `acknowledgment_date` DATE COMMENT 'Date the regulatory authority acknowledged receipt of the statutory filing.',
    `actuarial_opinion_attached` BOOLEAN COMMENT 'Indicates whether an appointed actuary opinion on reserves is attached to this statutory filing, as required for annual statements.',
    `amendment_number` STRING COMMENT 'Sequential number indicating which amendment this represents if the filing has been resubmitted. Zero or null for original submission; increments with each amendment.',
    `approval_date` DATE COMMENT 'Date the statutory filing received internal approval for submission to the regulatory authority.',
    `audit_opinion_attached` BOOLEAN COMMENT 'Indicates whether an independent auditor opinion is attached to this statutory filing, as required for annual statements of companies exceeding premium thresholds.',
    `certification_date` DATE COMMENT 'Date the certifying officer signed the certification statement for this statutory filing.',
    `certification_statement` STRING COMMENT 'Text of the officer certification statement attesting to the accuracy and completeness of the statutory filing, as required by state insurance laws.',
    `certifying_officer_name` STRING COMMENT 'Name of the company officer (typically CEO, CFO, or appointed actuary) who signed the certification statement for this statutory filing.',
    `certifying_officer_title` STRING COMMENT 'Official title of the certifying officer (e.g., Chief Executive Officer, Chief Financial Officer, Appointed Actuary).',
    `confirmation_number` STRING COMMENT 'Confirmation or tracking number issued by the regulatory authority or iSite+ system upon successful submission of the statutory filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this statutory filing record was first created in the system.',
    `document_count` STRING COMMENT 'Total number of documents or files included in the statutory filing submission package.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the statutory filing must be submitted. Annual statements typically due March 1; quarterly statements due 45 days after quarter end; RBC reports due March 1.',
    `filing_format` STRING COMMENT 'Technical format in which the statutory filing was submitted. XML for structured iSite+ submissions; PDF for scanned documents; Excel for supplemental schedules; paper for physical submissions.. Valid values are `pdf|xml|excel|paper`',
    `filing_notes` STRING COMMENT 'Internal notes or comments regarding the statutory filing, including special circumstances, regulatory inquiries, or follow-up actions required.',
    `filing_number` STRING COMMENT 'External business identifier assigned to the statutory filing by the regulatory authority or internal tracking system.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the statutory filing. Draft indicates preparation in progress; submitted means filed with regulator; accepted confirms regulatory approval; rejected indicates non-compliance requiring correction; amended represents resubmission after changes; withdrawn indicates voluntary retraction.. Valid values are `draft|submitted|accepted|rejected|amended|withdrawn`',
    `filing_type` STRING COMMENT 'Type of statutory regulatory filing submitted to NAIC or state Department of Insurance (DOI). Annual statement covers full year financial condition; quarterly statement provides interim updates; Schedule S reports reinsurance transactions; Exhibits 5/6/7 detail policy and contract information; RBC (Risk-Based Capital) report demonstrates capital adequacy; ORSA (Own Risk and Solvency Assessment) summary documents enterprise risk management. [ENUM-REF-CANDIDATE: annual_statement|quarterly_statement|schedule_s|exhibit_5|exhibit_6|exhibit_7|rbc_report|orsa_summary — 8 candidates stripped; promote to reference product]',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether this statutory filing represents consolidated financial information for multiple legal entities within an insurance group, as opposed to a single-entity filing.',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code uniquely identifying the insurance legal entity for regulatory reporting purposes.. Valid values are `^[0-9]{5}$`',
    `preparer_contact_email` STRING COMMENT 'Email address of the preparer for regulatory follow-up questions or clarifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_contact_phone` STRING COMMENT 'Phone number of the preparer for regulatory follow-up questions or clarifications.',
    `preparer_name` STRING COMMENT 'Name of the individual or team responsible for preparing the statutory filing content.',
    `regulatory_contact_email` STRING COMMENT 'Email address of the regulatory contact for correspondence regarding this statutory filing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the regulatory examiner or analyst at the state DOI assigned to review this statutory filing.',
    `rejection_date` DATE COMMENT 'Date the regulatory authority rejected the statutory filing due to errors, omissions, or non-compliance.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory authority for rejecting the statutory filing, including specific deficiencies or compliance issues that must be corrected.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the statutory filing before submission, typically a senior actuary or finance officer.',
    `state_jurisdiction` STRING COMMENT 'State Department of Insurance jurisdiction to which this statutory filing is submitted. Typically the domiciliary state of the legal entity.',
    `submission_date` DATE COMMENT 'Date the statutory filing was submitted to the regulatory authority.',
    `submission_method` STRING COMMENT 'Method used to submit the statutory filing to the regulatory authority. iSite+ is the NAIC electronic filing system; paper represents physical mail submission; electronic portal covers state-specific systems; email for supplemental submissions.. Valid values are `isite_plus|paper|electronic_portal|email`',
    `total_pages` STRING COMMENT 'Total page count across all documents in the statutory filing submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this statutory filing record was last modified in the system.',
    CONSTRAINT pk_statutory_filing PRIMARY KEY(`statutory_filing_id`)
) COMMENT 'Master record for each statutory regulatory filing submitted to the NAIC or state DOI — capturing filing type (annual statement, quarterly statement, Schedule S, Exhibit 5/6/7, RBC report, ORSA), filing period, legal entity, state jurisdiction, submission method (NAIC iSite+/paper), submission date, acknowledgment date, filing status (draft/submitted/accepted/rejected/amended), and regulatory contact. SSOT for statutory filing metadata distinct from compliance.regulatory_filing which tracks broader regulatory obligations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`filing_template` (
    `filing_template_id` BIGINT COMMENT 'Unique identifier for the regulatory filing template record. Primary key.',
    `superseded_by_template_filing_template_id` BIGINT COMMENT 'Reference to the filing template that replaces this one, if status is superseded.',
    `superseded_filing_template_id` BIGINT COMMENT 'Self-referencing FK on filing_template (superseded_filing_template_id)',
    `approval_date` DATE COMMENT 'Date when this filing template version was approved for use by the regulatory authority or internal governance.',
    `confidentiality_level` STRING COMMENT 'Data classification level for filings produced using this template.. Valid values are `public|confidential|restricted`',
    `contact_email` STRING COMMENT 'Email address for inquiries or support related to this filing template.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing template record was first created in the system.',
    `data_mart_source` STRING COMMENT 'Name or identifier of the data mart configuration that provides source data for this filing template.',
    `due_date_rule` STRING COMMENT 'Business rule describing when filings using this template are due (e.g., 60 days after year-end, March 1 annually).',
    `effective_end_date` DATE COMMENT 'Date when this filing template version is superseded or retired. Null indicates currently active template.',
    `effective_start_date` DATE COMMENT 'Date when this filing template version becomes effective and must be used for regulatory submissions.',
    `filing_category` STRING COMMENT 'Accounting or regulatory framework category for the filing (Statutory Accounting Principles (SAP), Generally Accepted Accounting Principles (GAAP), International Financial Reporting Standards (IFRS) 17, Risk-Based Capital (RBC), state-specific, federal).. Valid values are `statutory|gaap|ifrs17|rbc|state_specific|federal`',
    `filing_frequency` STRING COMMENT 'Required submission frequency for filings using this template.. Valid values are `annual|quarterly|monthly|semi_annual|ad_hoc`',
    `instructions_url` STRING COMMENT 'URL or file path to detailed instructions for completing filings using this template.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code representing the regulatory jurisdiction (e.g., US state code, country code).. Valid values are `^[A-Z]{2,3}$`',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision or update to this filing template.',
    `late_filing_penalty` STRING COMMENT 'Description of penalties or consequences for late submission of filings using this template.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this filing is mandatory (true) or optional (false) for the applicable entities.',
    `product_line_scope` STRING COMMENT 'Insurance product lines covered by this filing template (e.g., life, annuity, accident and health, all lines). Pipe-separated list for multiple lines.',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory authority requiring this filing (e.g., NAIC, State Department of Insurance, SEC).',
    `revision_notes` STRING COMMENT 'Summary of changes made in the most recent template revision.',
    `schedule_identifier` STRING COMMENT 'Official schedule or exhibit identifier from regulatory framework (e.g., Schedule S, Exhibit 5, Exhibit 6, Exhibit 7).',
    `submission_method` STRING COMMENT 'Required method for submitting completed filings using this template.. Valid values are `online_portal|email|ftp|api|mail`',
    `template_code` STRING COMMENT 'Business identifier code for the filing template (e.g., NAIC_ANNUAL_STMT, SCHEDULE_S, EXHIBIT_5).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_description` STRING COMMENT 'Detailed description of the filing template purpose, content requirements, and regulatory context.',
    `template_file_path` STRING COMMENT 'Storage location or URL where the blank template file is maintained.',
    `template_format` STRING COMMENT 'Technical file format required for the filing submission (eXtensible Business Reporting Language (XBRL), Extensible Markup Language (XML), Portable Document Format (PDF), Excel, Comma-Separated Values (CSV), JavaScript Object Notation (JSON)).. Valid values are `xbrl|xml|pdf|excel|csv|json`',
    `template_name` STRING COMMENT 'Full descriptive name of the regulatory filing template.',
    `template_owner` STRING COMMENT 'Business unit or role responsible for maintaining and updating this filing template.',
    `template_status` STRING COMMENT 'Current lifecycle status of the filing template.. Valid values are `active|deprecated|draft|retired|superseded`',
    `template_type` STRING COMMENT 'Classification of the filing template by regulatory reporting category.. Valid values are `annual_statement|quarterly_statement|schedule|exhibit|rbc_report|supplemental`',
    `template_version` STRING COMMENT 'Version number of the filing template (e.g., 2023.1, 1.0.5) to track regulatory updates and revisions.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing template record was last modified.',
    `validation_rules_url` STRING COMMENT 'URL or file path to the validation rules document or schema for this filing template.',
    `xbrl_taxonomy_version` STRING COMMENT 'Version of the XBRL taxonomy schema applicable to this template, if format is XBRL.',
    CONSTRAINT pk_filing_template PRIMARY KEY(`filing_template_id`)
) COMMENT 'Master catalog of regulatory filing templates — NAIC annual statement blanks, quarterly statement blanks, Schedule S (reinsurance), Exhibit 5 (life insurance in force), Exhibit 6 (accident and health), Exhibit 7 (annuities), RBC report templates, and state-specific supplemental filing templates. Captures template name, template type, applicable regulatory authority, effective period, version, and template format (XBRL/XML/PDF). Owned by reporting domain as the SSOT for filing structure metadata.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_package` (
    `report_package_id` BIGINT COMMENT 'Unique identifier for the report package. Primary key.',
    `template_id` BIGINT COMMENT 'Reference to the template definition used to assemble this package. Templates define the standard structure and constituent reports for recurring package types (e.g., NAIC Annual Statement template, Board Quarterly template).',
    `prior_period_package_report_package_id` BIGINT COMMENT 'Reference to the report package for the immediately preceding period (e.g., Q3 2023 package for a Q4 2023 package, or 2022 annual package for a 2023 annual package). Enables period-over-period comparison and trend analysis.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each report_package is assembled for a specific reporting_period. Cardinality: 1 package → 1 period, 1 period → many packages. Adding FK links package to the period being reported. Columns reporting_p',
    `prior_period_report_package_id` BIGINT COMMENT 'Self-referencing FK on report_package (prior_period_report_package_id)',
    `actual_filing_date` DATE COMMENT 'The date on which the package was actually filed with the regulatory authority. Null if not yet filed. Used to track on-time vs. late filings.',
    `amendment_reason` STRING COMMENT 'Explanation of why the package was amended or restated. Null for original filings. Required for amendments to provide transparency to regulators and stakeholders.',
    `approval_date` DATE COMMENT 'The date on which the package received final approval. Null if not yet approved or approval not required. Critical for SOX compliance and audit trail.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before filing or distribution (True for regulatory filings and board packages, False for internal management reports).',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who provided final approval for the package (e.g., Chief Financial Officer (CFO), Chief Actuary, Controller). Null if not yet approved or approval not required.',
    `archive_location` STRING COMMENT 'File path, URL, or document management system reference where the final package artifacts are archived for long-term retention and audit purposes.',
    `certification_date` DATE COMMENT 'The date on which the executive certification was signed. Null if not yet certified or certification not required. Required for SOX compliance documentation.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether executive certification is required for this package under SOX Section 302 or similar regulatory requirements (True for public company financial statements, False for internal reports).',
    `certified_by` STRING COMMENT 'Name or identifier of the executive who certified the accuracy and completeness of the package (typically CFO or CEO for SOX certifications). Null if not yet certified or certification not required.',
    `constituent_report_count` STRING COMMENT 'The number of individual report definitions included in this package (e.g., a NAIC Annual Statement package may contain 20+ exhibits and schedules).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this report package record was first created in the system. Part of the audit trail for package lifecycle tracking.',
    `data_as_of_timestamp` TIMESTAMP COMMENT 'The timestamp indicating when the underlying data was extracted or frozen for this package. Critical for understanding data currency and for reconciliation purposes.',
    `data_mart_source` STRING COMMENT 'The name or identifier of the data mart or reporting database from which the constituent reports draw their data (e.g., Statutory_Reporting_Mart, GAAP_Financial_Mart, IFRS17_Mart).',
    `distribution_date` DATE COMMENT 'The date on which the package was distributed to stakeholders. Null if not yet distributed. Tracks when recipients received the final package.',
    `distribution_list` STRING COMMENT 'Comma-separated list of email addresses or distribution group names to which the completed package should be sent. Confidential to protect internal distribution practices.',
    `filing_confirmation_number` STRING COMMENT 'Confirmation or tracking number provided by the regulatory authority upon successful filing. Used for audit trail and follow-up inquiries.',
    `filing_deadline_date` DATE COMMENT 'The regulatory deadline by which this package must be filed with the governing authority (e.g., March 1 for NAIC Annual Statements, May 15 for quarterly statements).',
    `filing_jurisdiction` STRING COMMENT 'The primary regulatory jurisdiction or state Department of Insurance to which this package is filed (e.g., NY, CA, TX). For multi-state filings, this is the domiciliary state.',
    `filing_method` STRING COMMENT 'The method by which the package was or will be filed (Electronic submission via NAIC portal, Paper filing, State-specific portal, Email, or Hybrid approach).. Valid values are `ELECTRONIC|PAPER|PORTAL|EMAIL|HYBRID`',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this package is an amendment or restatement of a previously filed package (True) or an original filing (False).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this report package record. Part of the audit trail for change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this report package record was last updated. Tracks the most recent change to package metadata or status.',
    `package_code` STRING COMMENT 'Short code or identifier for the package type used for system reference and categorization.',
    `package_description` STRING COMMENT 'Detailed description of the package purpose, scope, and contents. Provides context for users and auditors about what this package represents and why it was assembled.',
    `package_name` STRING COMMENT 'Business name of the report package (e.g., Q4 2023 NAIC Annual Statement, 2023 IFRS 17 Disclosure Package, Board Quarterly Reporting Package).',
    `package_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this package (e.g., Includes restatement of Q2 reserves, First filing under new LDTI standards, Expedited filing due to regulatory inquiry).',
    `package_status` STRING COMMENT 'Current lifecycle status of the report package indicating its stage in the production and filing workflow (Draft, In Preparation, Under Review, Approved, Filed with regulators, Distributed to stakeholders, Archived, or Cancelled). [ENUM-REF-CANDIDATE: DRAFT|IN_PREPARATION|UNDER_REVIEW|APPROVED|FILED|DISTRIBUTED|ARCHIVED|CANCELLED — 8 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Classification of the report package indicating the reporting framework and purpose (e.g., NAIC Annual Statement, GAAP Financial Statements, IFRS 17 Disclosure, Board Reporting, Management Reporting). [ENUM-REF-CANDIDATE: NAIC_ANNUAL|NAIC_QUARTERLY|GAAP_FINANCIAL|IFRS17_DISCLOSURE|STATUTORY|MANAGEMENT|BOARD|REGULATORY_AD_HOC — 8 candidates stripped; promote to reference product]',
    `package_version` STRING COMMENT 'Version number of the package, incremented for each revision or restatement. Version 1 is the initial submission; subsequent versions represent amendments or corrections.',
    `reporting_framework` STRING COMMENT 'The accounting or reporting framework under which this package is prepared (Statutory Accounting Principles (SAP), Generally Accepted Accounting Principles (GAAP), International Financial Reporting Standards (IFRS) 17, Management, or other Regulatory framework).. Valid values are `STATUTORY|GAAP|IFRS17|MANAGEMENT|REGULATORY`',
    `retention_expiry_date` DATE COMMENT 'The date after which this package may be purged from active systems per document retention policies. Typically 7-10 years for regulatory filings per SOX and state insurance regulations.',
    `target_audience` STRING COMMENT 'The primary intended audience or recipient group for this report package (Regulators, Board of Directors, Executive Management, External Auditors, Rating Agencies, Investors, Internal Audit, or Actuarial teams). [ENUM-REF-CANDIDATE: REGULATOR|BOARD|EXECUTIVE_MANAGEMENT|EXTERNAL_AUDITOR|RATING_AGENCY|INVESTOR|INTERNAL_AUDIT|ACTUARIAL — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this report package record. Part of the audit trail for accountability and traceability.',
    CONSTRAINT pk_report_package PRIMARY KEY(`report_package_id`)
) COMMENT 'Represents a logical grouping of related reports assembled for a specific reporting cycle or regulatory submission — e.g., the full NAIC Annual Statement package (all exhibits, schedules, and supplemental filings), a board reporting package, or an IFRS 17 disclosure package. Captures package name, package type, reporting period, constituent report definitions, package status, and distribution list. Enables coordinated production and delivery of multi-report regulatory submissions.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_distribution` (
    `report_distribution_id` BIGINT COMMENT 'Unique identifier for each report distribution event. Primary key for the report distribution transactional record.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who initiated or authorized the report distribution.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition that was distributed. Links to the report metadata catalog.',
    `report_recipient_id` BIGINT COMMENT 'Foreign key linking to reporting.report_recipient. Business justification: Each distribution event delivers to a specific report_recipient. Cardinality: 1 distribution → 1 recipient, 1 recipient → many distributions. Adding FK links distribution to the recipient master. Colu',
    `report_version_id` BIGINT COMMENT 'Foreign key linking to reporting.report_version. Business justification: Each distribution event distributes a specific report_version. Cardinality: 1 distribution → 1 version, 1 version → many distributions. Adding FK links distribution to the artifact being distributed. ',
    `redistribution_report_distribution_id` BIGINT COMMENT 'Self-referencing FK on report_distribution (redistribution_report_distribution_id)',
    `access_expiration_date` DATE COMMENT 'Date after which recipient access to the distributed report expires, applicable for portal-based distributions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report distribution was approved, supporting audit trail and compliance requirements.',
    `confidentiality_classification` STRING COMMENT 'Data classification level of the distributed report (public, internal, confidential, or restricted) governing handling and access controls.. Valid values are `public|internal|confidential|restricted`',
    `delivery_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when delivery was confirmed or acknowledged by the recipient system or individual.',
    `delivery_status` STRING COMMENT 'Current status of the distribution delivery (sent, successfully delivered, failed, acknowledged by recipient, bounced, or pending).. Valid values are `sent|delivered|failed|acknowledged|bounced|pending`',
    `digital_signature_applied_indicator` BOOLEAN COMMENT 'Flag indicating whether a digital signature was applied to ensure report authenticity and non-repudiation.',
    `distribution_channel` STRING COMMENT 'The delivery mechanism used to distribute the report (email, secure portal, SFTP, physical print, regulatory submission portal, or API).. Valid values are `email|portal|sftp|print|regulatory_submission|api`',
    `distribution_cost_amount` DECIMAL(18,2) COMMENT 'Cost associated with the distribution event, including printing, postage, or transmission fees.',
    `distribution_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the distribution cost amount.. Valid values are `^[A-Z]{3}$`',
    `distribution_format` STRING COMMENT 'File format or medium in which the report was distributed (PDF, Excel, XML, HTML, CSV, or printed hard copy).. Valid values are `pdf|excel|xml|html|csv|printed`',
    `distribution_notes` STRING COMMENT 'Free-form notes or comments regarding the distribution event, including special instructions or contextual information.',
    `distribution_number` STRING COMMENT 'Business-facing unique identifier for this distribution event, used for tracking and audit trail purposes.',
    `distribution_priority` STRING COMMENT 'Priority level assigned to the distribution event, affecting processing and delivery sequence.. Valid values are `urgent|high|normal|low`',
    `distribution_timestamp` TIMESTAMP COMMENT 'Date and time when the report distribution was initiated or sent. Primary business event timestamp for the distribution transaction.',
    `encryption_applied_indicator` BOOLEAN COMMENT 'Flag indicating whether encryption was applied to the report during distribution for security purposes.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the distribution failed, including technical error messages or delivery exceptions.',
    `file_size_bytes` BIGINT COMMENT 'Size of the distributed report file in bytes, used for transmission tracking and storage management.',
    `filing_deadline_date` DATE COMMENT 'Regulatory deadline date by which the report must be filed, applicable for regulatory submissions.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient last accessed or downloaded the distributed report.',
    `recipient_access_count` STRING COMMENT 'Number of times the recipient has accessed or downloaded the distributed report, used for engagement tracking.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution record was first created in the system.',
    `record_source_system` STRING COMMENT 'Name or identifier of the source system that generated this distribution record (e.g., reporting platform, distribution management system).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution record was last modified in the system.',
    `regulatory_filing_indicator` BOOLEAN COMMENT 'Flag indicating whether this distribution constitutes an official regulatory filing submission (True) or an internal/external non-regulatory distribution (False).',
    `report_period_end_date` DATE COMMENT 'Ending date of the reporting period covered by the distributed report.',
    `report_period_start_date` DATE COMMENT 'Beginning date of the reporting period covered by the distributed report.',
    `report_type` STRING COMMENT 'Classification of the report distributed (e.g., NAIC Annual Statement, Quarterly Statement, Schedule S, Exhibit 5, Exhibit 6, Exhibit 7, management dashboard, board package).',
    `reporting_framework` STRING COMMENT 'Accounting or regulatory framework under which the report was prepared (Statutory Accounting Principles, Generally Accepted Accounting Principles, International Financial Reporting Standards 17, or Management Reporting).. Valid values are `statutory|gaap|ifrs17|management`',
    `retry_count` STRING COMMENT 'Number of delivery retry attempts made for failed distributions.',
    `scheduled_distribution_date` DATE COMMENT 'Planned date for the report distribution, used for tracking adherence to reporting schedules and regulatory deadlines.',
    `submission_confirmation_number` STRING COMMENT 'Confirmation or tracking number received from the regulatory portal or recipient system upon successful submission.',
    CONSTRAINT pk_report_distribution PRIMARY KEY(`report_distribution_id`)
) COMMENT 'Transactional record of each report distribution event — capturing report version, distribution channel (email/portal/SFTP/print/regulatory submission), recipient type (internal executive/board/regulator/auditor/reinsurer), recipient identity, distribution date, delivery status (sent/delivered/failed/acknowledged), and confidentiality classification. Manages the end-to-end delivery audit trail for all statutory, GAAP, IFRS 17, and management report outputs.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_recipient` (
    `report_recipient_id` BIGINT COMMENT 'Unique identifier for the report recipient record. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: Agencies receive consolidated production reports, regulatory filings, compliance summaries, hierarchical performance reports. Real business process: agency management and oversight reporting distribut',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: Report recipients include policyholders, insureds, contract owners, and beneficiaries who receive regulatory notices (e.g., annual statements, NAIC disclosures), policy performance reports, and compli',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Producers receive automated distribution of commission statements, production reports, compliance notifications, training reminders. Real business process: agent network communication and regulatory d',
    `delegate_report_recipient_id` BIGINT COMMENT 'Self-referencing FK on report_recipient (delegate_report_recipient_id)',
    `access_level` STRING COMMENT 'Level of access granted to the recipient, determining the scope and detail of reports they may receive.. Valid values are `full|summary|restricted|confidential`',
    `active_status` STRING COMMENT 'Current status of the recipient record indicating whether they are authorized to receive reports.. Valid values are `active|inactive|suspended|pending_approval`',
    `approval_date` DATE COMMENT 'Date when the recipients access to reports was approved by the appropriate authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this recipients access to reports.',
    `city` STRING COMMENT 'City name for the recipients mailing address.',
    `confidentiality_agreement_date` DATE COMMENT 'Date when the confidentiality or non-disclosure agreement was executed.',
    `confidentiality_agreement_flag` BOOLEAN COMMENT 'Indicates whether the recipient has signed a confidentiality or non-disclosure agreement.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the recipients location (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipient record was first created in the system.',
    `delivery_frequency` STRING COMMENT 'Frequency at which reports are delivered to this recipient.. Valid values are `on_demand|daily|weekly|monthly|quarterly|annually`',
    `delivery_method` STRING COMMENT 'Preferred method for delivering report outputs to the recipient.. Valid values are `email|secure_portal|physical_mail|sftp|api`',
    `effective_end_date` DATE COMMENT 'Date after which the recipient is no longer authorized to receive report outputs. Null indicates no end date.',
    `effective_start_date` DATE COMMENT 'Date from which the recipient is authorized to receive report outputs.',
    `email_address` STRING COMMENT 'Primary email address for delivering report outputs to the recipient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether report outputs must be encrypted before delivery to this recipient.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction code for external regulators (e.g., state DOI code, NAIC jurisdiction identifier).',
    `last_delivery_date` DATE COMMENT 'Date when a report was most recently delivered to this recipient.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipient record was most recently updated.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address for physical report delivery.',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address (suite, floor, department).',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code for which this recipient is authorized to receive reports. Applicable for regulatory recipients.. Valid values are `^[0-9]{5}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes or special instructions related to report delivery for this recipient.',
    `organization_name` STRING COMMENT 'Name of the organization or entity the recipient represents (e.g., state Department of Insurance, external audit firm, reinsurance company).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the recipient.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the recipients mailing address.',
    `recipient_type` STRING COMMENT 'Classification of the recipient indicating whether they are an internal stakeholder, external regulator, auditor, reinsurer, board member, or rating agency.. Valid values are `internal_stakeholder|external_regulator|external_auditor|reinsurer|board_member|rating_agency`',
    `report_format_preference` STRING COMMENT 'Preferred file format for report delivery (e.g., PDF, Excel, CSV, XML).. Valid values are `pdf|excel|csv|xml|json|html`',
    `role_title` STRING COMMENT 'Job title or functional role of the recipient (e.g., Chief Financial Officer, Chief Risk Officer, State Insurance Commissioner, Lead Auditor).',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates whether this recipient relationship is subject to SOX compliance requirements for financial reporting.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code for the recipients mailing address (e.g., NY, CA, ON).',
    CONSTRAINT pk_report_recipient PRIMARY KEY(`report_recipient_id`)
) COMMENT 'Master record for all authorized recipients of report outputs — internal stakeholders (CFO, CRO, board members, actuaries), external regulators (state DOI, NAIC, SEC, FINRA), auditors (external/internal), and reinsurers. Captures recipient name, recipient type, organization, role, contact details, applicable report definitions, access level, and active status. Governs who is authorized to receive each report type.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` (
    `gaap_report_config_id` BIGINT COMMENT 'Unique identifier for the GAAP report configuration record.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity or business unit for which this GAAP report is prepared.',
    `superseded_gaap_report_config_id` BIGINT COMMENT 'Self-referencing FK on gaap_report_config (superseded_gaap_report_config_id)',
    `applicable_asc_standards` STRING COMMENT 'Comma-separated list of ASC standards applicable to this configuration (e.g., ASC 944, ASC 320, ASC 815, ASU 2018-12).',
    `approval_date` DATE COMMENT 'The date on which this GAAP report configuration was formally approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for this configuration (pending, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this GAAP report configuration.',
    `claim_liability_estimation_method` STRING COMMENT 'The approach used to estimate claim liabilities including Incurred But Not Reported (IBNR) reserves (case reserves, IBNR, actuarial estimate, paid plus case).. Valid values are `case_reserves|ibnr|actuarial_estimate|paid_plus_case`',
    `config_code` STRING COMMENT 'Short alphanumeric code uniquely identifying this configuration for system reference and reporting automation.',
    `config_name` STRING COMMENT 'Business-friendly name for this GAAP reporting configuration (e.g., Q4 2023 Consolidated GAAP, Annual 2024 Statutory Entity).',
    `consolidation_scope` STRING COMMENT 'Defines the organizational scope of consolidation for this GAAP report (legal entity, consolidated group, segment, division).. Valid values are `legal_entity|consolidated_group|segment|division`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GAAP report configuration record was first created in the system.',
    `dac_amortization_method` STRING COMMENT 'The method used to amortize deferred acquisition costs under GAAP (e.g., straight-line, interest method, benefit ratio, constant level).. Valid values are `straight_line|interest_method|benefit_ratio|constant_level`',
    `derivative_accounting_method` STRING COMMENT 'The accounting treatment for derivative instruments in this configuration (hedge accounting, fair value through earnings, not applicable).. Valid values are `hedge_accounting|fair_value_through_earnings|not_applicable`',
    `discount_rate_methodology` STRING COMMENT 'The approach used to determine discount rates for liability measurement (upper-medium grade, risk-free, locked-in, current).. Valid values are `upper_medium_grade|risk_free|locked_in|current`',
    `effective_date` DATE COMMENT 'The date from which this GAAP report configuration becomes effective and is used for financial reporting.',
    `expiration_date` DATE COMMENT 'The date on which this GAAP report configuration is no longer effective and is superseded or retired.',
    `fair_value_hierarchy_disclosure_flag` BOOLEAN COMMENT 'Indicates whether fair value hierarchy disclosures (Level 1, 2, 3) are required in this configuration.',
    `foreign_exchange_translation_method` STRING COMMENT 'The method used to translate foreign currency financial statements (current rate, temporal, not applicable).. Valid values are `current_rate|temporal|not_applicable`',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency for this GAAP report (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `gaap_report_config_status` STRING COMMENT 'Current lifecycle status of this GAAP report configuration (active, inactive, draft, archived, superseded).. Valid values are `active|inactive|draft|archived|superseded`',
    `gaap_sap_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether this configuration includes reconciliation between GAAP and SAP reporting bases.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions and balances are eliminated in this reporting configuration.',
    `investment_valuation_basis` STRING COMMENT 'The valuation method applied to investment assets in this GAAP report (fair value, amortized cost, equity method, cost).. Valid values are `fair_value|amortized_cost|equity_method|cost`',
    `ldti_cohort_grouping_basis` STRING COMMENT 'The basis on which LDTI cohorts are defined for liability measurement (e.g., issue year, issue quarter, product line, contract type).. Valid values are `issue_year|issue_quarter|product_line|contract_type`',
    `ldti_effective_flag` BOOLEAN COMMENT 'Indicates whether ASU 2018-12 LDTI standard is effective and applied in this reporting configuration.',
    `market_risk_benefit_accounting_flag` BOOLEAN COMMENT 'Indicates whether market risk benefits (guarantees on variable annuities) are accounted for under LDTI MRB guidance.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this GAAP report configuration record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GAAP report configuration record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this GAAP report configuration.',
    `presentation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the presentation currency for this GAAP report (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reinsurance_accounting_treatment` STRING COMMENT 'The accounting method applied to reinsurance contracts in this configuration (deposit method, risk transfer, proportional, non-proportional).. Valid values are `deposit_method|risk_transfer|proportional|non_proportional`',
    `reporting_frequency` STRING COMMENT 'Cadence at which this GAAP report is produced (monthly, quarterly, annual, semi-annual).. Valid values are `monthly|quarterly|annual|semi-annual`',
    `reporting_period_end_date` DATE COMMENT 'The last day of the accounting period covered by this GAAP report configuration.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the accounting period covered by this GAAP report configuration.',
    `reserve_basis` STRING COMMENT 'The reserve calculation methodology applied in this GAAP report (GAAP, LDTI, pre-LDTI, statutory).. Valid values are `gaap|ldti|pre_ldti|statutory`',
    `revenue_recognition_method` STRING COMMENT 'The method used to recognize premium revenue in this GAAP report (premium received, earned premium, deposit method, investment contract).. Valid values are `premium_received|earned_premium|deposit_method|investment_contract`',
    `segment_reporting_flag` BOOLEAN COMMENT 'Indicates whether this configuration includes segment-level reporting per ASC 280.',
    `separate_account_treatment` STRING COMMENT 'Defines how separate account assets and liabilities are presented in the GAAP financial statements (on-balance-sheet, off-balance-sheet, hybrid).. Valid values are `on_balance_sheet|off_balance_sheet|hybrid`',
    `created_by` STRING COMMENT 'Identifier of the user or system process that created this GAAP report configuration record.',
    CONSTRAINT pk_gaap_report_config PRIMARY KEY(`gaap_report_config_id`)
) COMMENT 'Master configuration record defining GAAP financial reporting parameters — capturing reporting entity, applicable ASC standards (ASC 944, ASC 320, ASC 815, ASU 2018-12 LDTI), reporting period, consolidation scope, intercompany elimination rules, DAC amortization method, LDTI cohort grouping basis, and GAAP vs SAP reconciliation flags. Owns the GAAP reporting metadata that governs how GAAP financial statements are structured and produced.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` (
    `ifrs17_report_config_id` BIGINT COMMENT 'Unique identifier for the IFRS 17 report configuration record. Primary key.',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: IFRS 17 reporting requires cohort-level tracking and disclosure. The report configuration must reference the cohort definition to ensure consistent grouping of contracts for CSM calculation, onerous c',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `parent_config_ifrs17_report_config_id` BIGINT COMMENT 'Reference to the parent IFRS 17 configuration from which this configuration was derived or superseded. Nullable for original configurations.',
    `superseded_ifrs17_report_config_id` BIGINT COMMENT 'Self-referencing FK on ifrs17_report_config (superseded_ifrs17_report_config_id)',
    `acquisition_cash_flow_allocation` STRING COMMENT 'The level at which insurance acquisition cash flows are allocated: portfolio level, contract group level, or individual contract level.. Valid values are `portfolio_level|contract_group_level|individual_contract_level`',
    `approval_date` DATE COMMENT 'Date on which this IFRS 17 reporting configuration was formally approved by the appropriate governance body or authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this IFRS 17 reporting configuration.',
    `cohort_granularity` STRING COMMENT 'The level of granularity at which insurance contract cohorts are defined for grouping purposes (e.g., annual, quarterly, monthly, or by product line).. Valid values are `annual|quarterly|monthly|product_line`',
    `config_code` STRING COMMENT 'Unique alphanumeric code identifying this IFRS 17 configuration for system integration and cross-reference purposes.',
    `config_description` STRING COMMENT 'Detailed textual description of the purpose, scope, and key characteristics of this IFRS 17 reporting configuration.',
    `config_name` STRING COMMENT 'Business-friendly name for this IFRS 17 reporting configuration, used to identify the configuration across reporting periods and systems.',
    `config_status` STRING COMMENT 'Current lifecycle status of the IFRS 17 report configuration indicating whether it is in draft, actively used for reporting, temporarily suspended, or archived.. Valid values are `draft|active|suspended|archived`',
    `contract_boundary_definition` STRING COMMENT 'Detailed definition of the contract boundary criteria applied to determine which cash flows are included in the measurement of insurance contracts.',
    `coverage_unit_definition` STRING COMMENT 'Detailed definition of the coverage units used for CSM amortization, specifying the quantity of insurance contract services provided in each period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this IFRS 17 report configuration record was first created in the system.',
    `csm_amortization_basis` STRING COMMENT 'The systematic basis elected for amortizing the Contractual Service Margin (CSM) over the coverage period, such as coverage units, time-based, sum assured, or premium-based allocation.. Valid values are `coverage_units|time_based|sum_assured|premium_based`',
    `discount_rate_curve_selection` STRING COMMENT 'Specification of the discount rate curve methodology and source used for present value calculations, including whether top-down or bottom-up approach is applied and the reference yield curve.',
    `effective_date` DATE COMMENT 'Date from which this IFRS 17 reporting configuration becomes effective and is applied to insurance contract measurements.',
    `experience_adjustment_frequency` STRING COMMENT 'The frequency at which experience adjustments are made to update estimates of future cash flows and risk adjustments.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `expiration_date` DATE COMMENT 'Date on which this IFRS 17 reporting configuration ceases to be effective. Nullable for open-ended configurations.',
    `functional_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the functional currency of the entity for which this configuration applies.. Valid values are `^[A-Z]{3}$`',
    `investment_component_separation_flag` BOOLEAN COMMENT 'Indicates whether investment components are separated from insurance components in the presentation of insurance revenue and expenses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this IFRS 17 report configuration record was last updated or modified.',
    `loss_component_tracking_flag` BOOLEAN COMMENT 'Indicates whether loss components are separately tracked for onerous contract groups as required by IFRS 17.',
    `measurement_model` STRING COMMENT 'The elected IFRS 17 measurement model for this configuration: General Measurement Model (GMM), Premium Allocation Approach (PAA), or Variable Fee Approach (VFA).. Valid values are `GMM|PAA|VFA`',
    `oci_election` STRING COMMENT 'Election for presenting insurance finance income or expenses: entirely in profit or loss, or disaggregated between profit or loss and Other Comprehensive Income (OCI).. Valid values are `profit_or_loss|other_comprehensive_income`',
    `onerous_contract_threshold` DECIMAL(18,2) COMMENT 'The threshold value or percentage used to identify onerous contracts at initial recognition, where fulfillment cash flows exceed premiums received.',
    `paa_eligibility_criteria` STRING COMMENT 'Detailed criteria used to determine whether insurance contracts are eligible for the simplified Premium Allocation Approach (PAA), including coverage period and materiality thresholds.',
    `reinsurance_held_treatment` STRING COMMENT 'The elected treatment for reinsurance contracts held under IFRS 17, specifying how reinsurance recoveries and risk mitigation are measured and presented.. Valid values are `proportionate_coverage|risk_mitigation|separate_measurement`',
    `reporting_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which IFRS 17 reports are presented (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reporting_segment` STRING COMMENT 'The business or geographic segment to which this IFRS 17 configuration applies, enabling segment-level reporting and analysis.',
    `risk_adjustment_confidence_level` DECIMAL(18,2) COMMENT 'The confidence level percentage used when the risk adjustment methodology is confidence level-based (e.g., 75.00 for 75% confidence level). Nullable if not applicable.',
    `risk_adjustment_methodology` STRING COMMENT 'The methodology elected for calculating the risk adjustment for non-financial risk, such as confidence level approach, cost of capital, or margin over best estimate.. Valid values are `confidence_level|cost_of_capital|margin_over_best_estimate`',
    `transition_approach` STRING COMMENT 'The transition approach elected for initial application of IFRS 17: full retrospective application, modified retrospective approach, or fair value approach.. Valid values are `full_retrospective|modified_retrospective|fair_value`',
    `version_number` STRING COMMENT 'Version identifier for this IFRS 17 configuration, enabling tracking of configuration changes and version control over time.',
    `vfa_eligibility_criteria` STRING COMMENT 'Detailed criteria used to determine whether insurance contracts with direct participation features are eligible for the Variable Fee Approach (VFA) measurement model.',
    CONSTRAINT pk_ifrs17_report_config PRIMARY KEY(`ifrs17_report_config_id`)
) COMMENT 'Master configuration record defining IFRS 17 reporting parameters — capturing insurance contract group (ICG) definitions, measurement model elections (GMM/PAA/VFA), CSM amortization basis, risk adjustment methodology, discount rate curve selection, OCI option elections, transition approach (full retrospective/modified retrospective/fair value), and reporting currency. SSOT for IFRS 17 reporting metadata that governs how IFRS 17 insurance contract measurements are structured.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` (
    `statutory_exhibit_id` BIGINT COMMENT 'Unique identifier for the statutory exhibit record. Primary key for the statutory exhibit entity.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Schedule A (Annuity Exhibit) and other statutory exhibits require direct contract references for line-item population, audit trails, and regulatory examinations. Essential for NAIC Annual Statement pr',
    `pbr_model_segment_id` BIGINT COMMENT 'Foreign key linking to actuarial.pbr_model_segment. Business justification: PBR exhibits (VM-20 documentation) require model segment detail for regulatory review. Statutory exhibits must disclose the segmentation approach, credibility determinations, and reserve results by mo',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: NAIC statutory exhibits (Schedule T - Separate Accounts, Exhibit 5 - Life Insurance) require product-level detail. Statutory reporting aggregates reserves, premiums, and claims by product plan. Essent',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: Statutory exhibits (Schedule S) report treaty-level detail including ceded premiums, reserves, and claims. Exhibits must reference treaties for Part 1 (summary by treaty), Part 2 (ceded reinsurance pr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Statutory exhibits may require vendor-specific disclosures (e.g., Schedule Y Part 2 for material service providers, investment manager disclosures). Annual statutory filing requires disclosure of mate',
    `superseded_statutory_exhibit_id` BIGINT COMMENT 'Self-referencing FK on statutory_exhibit (superseded_statutory_exhibit_id)',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether detailed audit trails and supporting documentation must be maintained for data reported in this exhibit. True if audit trail is required for regulatory examination, False otherwise.',
    `automation_level` STRING COMMENT 'Indicates the degree of automation in the exhibit preparation process. Manual exhibits require significant human intervention; fully automated exhibits are generated directly from source systems with minimal manual adjustment.. Valid values are `manual|semi_automated|fully_automated`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this statutory exhibit record was first created in the system. Audit field for data lineage and governance.',
    `data_retention_years` STRING COMMENT 'The number of years that data for this exhibit must be retained to meet regulatory and compliance requirements. Typically ranges from 5 to 10 years depending on exhibit type and state requirements.',
    `data_source_domain` STRING COMMENT 'The primary business domain or system that provides source data for this exhibit (e.g., Policy, Claims, Investment, Reinsurance, Actuarial). Identifies the upstream data domain responsible for populating this exhibit.',
    `effective_date` DATE COMMENT 'The date when this exhibit definition became effective for regulatory filing purposes. Represents when the exhibit was first required or when the current version of instructions took effect.',
    `exhibit_code` STRING COMMENT 'Official NAIC code identifying the specific exhibit or schedule (e.g., EX5, EX6, EX7, SCHD_S, SCHD_D, SCHD_F). This is the regulatory identifier used in statutory filings.. Valid values are `^[A-Z0-9]{1,10}$`',
    `exhibit_complexity_level` STRING COMMENT 'Assessment of the technical and data complexity involved in preparing this exhibit. Low complexity exhibits require basic data aggregation; very high complexity exhibits require actuarial modeling, stochastic projections, or complex reconciliations.. Valid values are `low|medium|high|very_high`',
    `exhibit_instructions` STRING COMMENT 'High-level instructions or guidance for completing this exhibit, including scope, definitions, and special reporting requirements. Captures exhibit-level metadata and filing instructions.',
    `exhibit_name` STRING COMMENT 'Full descriptive name of the statutory exhibit or schedule (e.g., Exhibit 5 - Life Insurance In Force, Exhibit 6 - Accident and Health Insurance, Exhibit 7 - Annuities, Schedule S - Reinsurance, Schedule D - Investments, Schedule F - Reinsurance).',
    `exhibit_owner` STRING COMMENT 'The business function or department responsible for preparing and filing this exhibit (e.g., Actuarial, Finance, Investment, Reinsurance). Identifies the organizational owner of the exhibit.',
    `exhibit_section` STRING COMMENT 'The major section or category within the annual statement where this exhibit appears (e.g., Assets, Liabilities, Income, Capital and Surplus, Supplemental Exhibits).',
    `exhibit_status` STRING COMMENT 'Current lifecycle status of the exhibit definition. Active exhibits are currently required for filing; superseded exhibits have been replaced by newer versions; deprecated exhibits are no longer required; pending exhibits are approved but not yet effective.. Valid values are `active|superseded|deprecated|pending`',
    `exhibit_type` STRING COMMENT 'Classification of the statutory filing component as an exhibit, schedule, or supplemental filing.. Valid values are `exhibit|schedule|supplemental`',
    `expiration_date` DATE COMMENT 'The date when this exhibit definition expires or is superseded by a new version. Null if the exhibit is currently active with no planned expiration.',
    `filing_frequency` STRING COMMENT 'The regulatory frequency at which this exhibit must be filed with state insurance departments.. Valid values are `annual|quarterly|semi_annual|monthly`',
    `gaap_reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether a reconciliation between SAP and GAAP is required for this exhibit. True if GAAP reconciliation must be provided, False otherwise.',
    `lob_scope` STRING COMMENT 'The line(s) of business this exhibit applies to (e.g., Life, Accident and Health, Annuities, All Lines). Defines which product portfolios must report under this exhibit.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this exhibit is mandatory for all life insurance companies or optional/conditional based on business activities. True if required for all filers, False if conditional.',
    `naic_version` STRING COMMENT 'The NAIC annual statement version year that defines this exhibit structure (e.g., 2023, 2024). Tracks which version of NAIC instructions this exhibit definition follows.. Valid values are `^[0-9]{4}$`',
    `pbr_applicable_flag` BOOLEAN COMMENT 'Indicates whether this exhibit is subject to Principle-Based Reserving (PBR) requirements under VM-20 and VM-21. True if PBR applies, False for formula-based reserves.',
    `related_schedules` STRING COMMENT 'Comma-separated list of related exhibit codes or schedules that have dependencies or cross-references with this exhibit (e.g., Schedule S relates to Exhibit 5, Schedule D relates to investment exhibits).',
    `sap_basis_flag` BOOLEAN COMMENT 'Indicates whether this exhibit must be prepared using Statutory Accounting Principles (SAP) as prescribed by NAIC. True for SAP-basis exhibits, False for exhibits using other accounting frameworks.',
    `statement_type` STRING COMMENT 'Indicates whether this exhibit is required for annual statements, quarterly statements, or both.. Valid values are `annual|quarterly`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this statutory exhibit record was last modified. Audit field for tracking changes to exhibit definitions and instructions.',
    `xbrl_taxonomy_code` STRING COMMENT 'The XBRL taxonomy code or namespace used for electronic filing of this exhibit. Supports structured data submission to state insurance departments and NAIC.',
    CONSTRAINT pk_statutory_exhibit PRIMARY KEY(`statutory_exhibit_id`)
) COMMENT 'Master record for each statutory exhibit and schedule within the NAIC annual/quarterly statement framework — Exhibit 5 (life insurance in force), Exhibit 6 (A&H), Exhibit 7 (annuities), Schedule S (reinsurance ceded/assumed), Schedule D (investments), Schedule F (reinsurance), and supplemental exhibits. Captures exhibit code, exhibit name, applicable statement type, line-of-business scope, data source domain, and exhibit-level instructions. Defines the structural metadata for each statutory exhibit.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` (
    `report_line_definition_id` BIGINT COMMENT 'Unique identifier for the report line definition record.',
    `account_value_id` BIGINT COMMENT 'Foreign key linking to annuity.account_value. Business justification: Statutory exhibit line items (Schedule A line 1 Account Value, line 2 CSV, line 3 Death Benefit) map directly to account_value records for automated population, reconciliation, and audit trails.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Report line definitions map to specific GL accounts in the chart of accounts. Essential for automated report generation, financial statement mapping, and regulatory exhibit preparation. Domain experts',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Report lines calculate product-specific metrics (reserves by product, premiums by plan, claims by product). Statutory and GAAP reports aggregate at product level. Real business need: NAIC Annual State',
    `report_definition_id` BIGINT COMMENT 'Reference to the parent report definition that contains this line item.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Report lines track rider-specific metrics (rider premium income, rider claims, rider reserves) for statutory supplements and rider profitability reports. Real business need: NAIC Annual Statement Exhi',
    `separate_account_fund_id` BIGINT COMMENT 'Foreign key linking to product.separate_account_fund. Business justification: Report lines track separate account fund performance (fund returns, fund balances, fund flows) for statutory separate account reporting (Schedule D Part 1B) and GAAP investment disclosures. Real busin',
    `statutory_exhibit_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_exhibit. Business justification: Report_line_definitions can reference statutory_exhibit to indicate which exhibit/schedule they belong to. Cardinality: 1 line → 1 exhibit, 1 exhibit → many lines. Adding FK links report lines to the ',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Report lines break out by underwriting class for mortality experience studies, profitability analysis by risk class, and pricing studies. Real business need: actuarial experience reports analyze morta',
    `parent_report_line_definition_id` BIGINT COMMENT 'Self-referencing FK on report_line_definition (parent_report_line_definition_id)',
    `approval_date` DATE COMMENT 'Date when this line definition was formally approved for use in production reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this line definition.',
    `calculation_formula` STRING COMMENT 'Technical formula or expression defining how the line item value is calculated, including references to other line codes or source fields.',
    `calculation_logic_description` STRING COMMENT 'Business-readable description of the calculation, aggregation, or transformation logic applied to derive the line item value from source data.',
    `change_reason` STRING COMMENT 'Business justification or regulatory driver for changes to this line definition.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary line items (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `data_type` STRING COMMENT 'The data type of the value reported in this line item.. Valid values are `monetary|percentage|count|text|date`',
    `display_order` STRING COMMENT 'Numeric sequence controlling the presentation order of line items within the report.',
    `effective_date` DATE COMMENT 'Date from which this line definition becomes active and applicable for report generation.',
    `expiration_date` DATE COMMENT 'Date after which this line definition is no longer valid, supporting versioning of report structures over time.',
    `footnote_reference` STRING COMMENT 'Reference to associated footnotes, disclosures, or explanatory notes that provide additional context for this line item.',
    `hierarchy_level` STRING COMMENT 'Numeric indicator of the depth level in the report line hierarchy (e.g., 1 for top-level, 2 for second-level, etc.).',
    `is_calculated` BOOLEAN COMMENT 'Flag indicating whether this line value is calculated from other line items rather than sourced directly from operational data.',
    `is_required` BOOLEAN COMMENT 'Flag indicating whether this line item is mandatory for regulatory compliance or optional for management reporting.',
    `is_subtotal` BOOLEAN COMMENT 'Flag indicating whether this line represents a subtotal or intermediate sum within the report structure.',
    `is_total` BOOLEAN COMMENT 'Flag indicating whether this line represents a grand total or final sum within the report structure.',
    `line_category` STRING COMMENT 'High-level financial statement category to which this line item belongs.. Valid values are `asset|liability|equity|revenue|expense|disclosure`',
    `line_code` STRING COMMENT 'Unique alphanumeric code identifying the specific line item within the report structure (e.g., NAIC Annual Statement line codes, GAAP disclosure line codes).. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `line_description` STRING COMMENT 'Full business description of the report line item, explaining what financial or operational metric is being reported.',
    `line_number` STRING COMMENT 'Sequential or hierarchical numbering of the line item within the report (e.g., 1, 1.1, 1.1.1, 2.3.4) used for ordering and display.. Valid values are `^[0-9]{1,10}(.[0-9]{1,3})?$`',
    `line_short_name` STRING COMMENT 'Abbreviated or display name for the line item used in user interfaces and condensed reports.',
    `line_subcategory` STRING COMMENT 'Detailed subcategory or classification within the line category (e.g., invested assets, policy reserves, premium income).',
    `notes` STRING COMMENT 'Additional comments, implementation guidance, or special instructions related to this line definition.',
    `parent_line_code` STRING COMMENT 'Line code of the parent line item in hierarchical report structures, establishing the roll-up relationship.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific regulatory requirement, accounting standard, or statutory provision that mandates this line item (e.g., NAIC Annual Statement Blank Line 1, ASC 944-210-45-1).',
    `report_line_definition_status` STRING COMMENT 'Current lifecycle status of the report line definition.. Valid values are `active|inactive|draft|deprecated|pending_approval`',
    `report_type` STRING COMMENT 'Classification of the reporting framework to which this line definition applies.. Valid values are `statutory|gaap|ifrs17|management|regulatory`',
    `rounding_rule` STRING COMMENT 'Specification of how the line item value should be rounded for display (e.g., to nearest thousand, million, or two decimal places).. Valid values are `none|thousands|millions|nearest_dollar|two_decimals`',
    `sign_convention` STRING COMMENT 'Indicates whether the line item value should be displayed as positive, negative, or absolute value in the report output.. Valid values are `positive|negative|absolute`',
    `source_domain` STRING COMMENT 'The business data domain from which the underlying data for this line item is sourced (e.g., Policy, Claims, Investment, Actuarial).',
    `source_field_mapping` STRING COMMENT 'Technical mapping specification identifying the source data product and field(s) that populate this report line (e.g., policy.face_amount, claims.paid_amount).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for non-monetary line items (e.g., policies, contracts, percentage points).',
    `validation_rule` STRING COMMENT 'Business rule or constraint that must be satisfied for the line item value to be considered valid (e.g., must equal sum of components, must be non-negative).',
    `version_number` STRING COMMENT 'Version identifier for the line definition, supporting change management and regulatory compliance tracking.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    CONSTRAINT pk_report_line_definition PRIMARY KEY(`report_line_definition_id`)
) COMMENT 'Master catalog of individual report line items and disclosure elements within each report definition — capturing line code, line description, applicable report/exhibit, data element mapping (source domain and field), calculation logic description, sign convention, rounding rule, and regulatory reference. Defines the metadata for every line item in NAIC statement blanks, GAAP financial statement disclosures, and IFRS 17 roll-forward schedules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`management_report_config` (
    `management_report_config_id` BIGINT COMMENT 'Unique identifier for the management report configuration record.',
    `workflow_id` BIGINT COMMENT 'Identifier of the approval workflow process used for this report, if approval is required.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center this report is scoped to, if applicable. Null indicates enterprise-wide.',
    `distribution_channel_id` BIGINT COMMENT 'Identifier of the distribution channel this report is scoped to, if applicable. Null indicates all channels.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity this report is scoped to, if applicable. Null indicates enterprise-wide scope.',
    `product_line_id` BIGINT COMMENT 'Identifier of the product line this report is scoped to, if applicable. Null indicates all product lines.',
    `superseded_management_report_config_id` BIGINT COMMENT 'Self-referencing FK on management_report_config (superseded_management_report_config_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the report requires formal approval before distribution (typically true for board and executive reports).',
    `comparison_basis` STRING COMMENT 'The baseline used for variance analysis in the report: budget (annual budget), prior period (same period last year or prior month/quarter), plan (strategic plan), forecast (latest forecast), or none (no comparison).. Valid values are `budget|prior_period|plan|forecast|none`',
    `confidentiality_level` STRING COMMENT 'Data classification level of the report content, governing access controls and distribution restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this report configuration record was first created in the system.',
    `dashboard_integration` BOOLEAN COMMENT 'Indicates whether this report is integrated into an executive or operational dashboard.',
    `data_mart_source` STRING COMMENT 'Name or identifier of the data mart or analytical database that serves as the primary data source for this report.',
    `data_refresh_schedule` STRING COMMENT 'Cron expression or human-readable schedule describing when the underlying data mart is refreshed for this report.',
    `distribution_list` STRING COMMENT 'Comma-separated list of email addresses or distribution group names that receive this report upon generation.',
    `drill_down_enabled` BOOLEAN COMMENT 'Indicates whether the report supports interactive drill-down to lower levels of detail.',
    `effective_date` DATE COMMENT 'Date from which this report configuration became or will become active.',
    `expiration_date` DATE COMMENT 'Date on which this report configuration is scheduled to expire or be retired. Null indicates no planned expiration.',
    `kpi_definitions_included` STRING COMMENT 'Comma-separated list or description of the KPI definitions included in this report (e.g., NBV, APE, CLTV, ROI, RBC ratio, lapse rate, persistency).',
    `last_generated_timestamp` TIMESTAMP COMMENT 'Timestamp when this report was most recently generated successfully.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who most recently modified this report configuration record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this report configuration record was most recently modified.',
    `management_report_config_status` STRING COMMENT 'Current lifecycle status of the report configuration: active (in production use), inactive (temporarily suspended), draft (under development), deprecated (scheduled for retirement), archived (historical record only).. Valid values are `active|inactive|draft|deprecated|archived`',
    `next_scheduled_run` TIMESTAMP COMMENT 'Timestamp when this report is next scheduled to be generated.',
    `owning_business_unit` STRING COMMENT 'Name of the business unit or department that owns and maintains this report definition.',
    `report_category` STRING COMMENT 'Broad category of the report content: financial (financial metrics), operational (operational KPIs), strategic (strategic initiatives), risk (risk metrics), compliance (regulatory compliance), performance (business performance).. Valid values are `financial|operational|strategic|risk|compliance|performance`',
    `report_code` STRING COMMENT 'Unique business identifier code for the management report, used for system references and automation.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `report_description` STRING COMMENT 'Detailed description of the report purpose, content, and intended use cases.',
    `report_format` STRING COMMENT 'Primary output format for the report distribution.. Valid values are `pdf|excel|powerpoint|html|csv|tableau`',
    `report_frequency` STRING COMMENT 'Scheduled frequency at which this management report is generated and distributed.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `report_name` STRING COMMENT 'Full descriptive name of the management report as displayed to business users.',
    `report_owner_email` STRING COMMENT 'Email address of the report owner for inquiries and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_owner_name` STRING COMMENT 'Full name of the individual responsible for the business content and accuracy of this report.',
    `report_template_path` STRING COMMENT 'File system path or URI to the report template file used for rendering this management report.',
    `report_type` STRING COMMENT 'Classification of the management report by intended audience and purpose: board (board of directors), executive (C-suite), LOB (line of business), departmental (functional department), ALM (Asset Liability Management), profitability (product/channel profitability analysis).. Valid values are `board|executive|lob|departmental|alm|profitability`',
    `reporting_hierarchy_type` STRING COMMENT 'Primary organizational hierarchy dimension used for report aggregation and drill-down: legal entity, product line, distribution channel, cost center, geographic region, or organizational unit.. Valid values are `legal_entity|product_line|distribution_channel|cost_center|geographic|organizational`',
    `retention_period_months` STRING COMMENT 'Number of months that generated report instances must be retained per records retention policy.',
    `version_number` STRING COMMENT 'Version number of the report configuration, incremented with each significant change to report structure or logic.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this report configuration record.',
    CONSTRAINT pk_management_report_config PRIMARY KEY(`management_report_config_id`)
) COMMENT 'Master configuration record for internal management reporting — capturing report name, management report type (board/executive/LOB/departmental/ALM/profitability), reporting hierarchy (legal entity/product line/distribution channel/cost center), KPI definitions included, comparison basis (budget/prior period/plan), frequency, and owning business unit. Defines the structural metadata for management reporting distinct from statutory and GAAP frameworks.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_period` (
    `report_period_id` BIGINT COMMENT 'Unique identifier for the reporting period. Primary key for the report period reference master.',
    `parent_period_report_period_id` BIGINT COMMENT 'Reference to the parent reporting period in a hierarchical period structure (e.g., monthly period rolls up to quarterly period, quarterly to annual). Null for top-level periods.',
    `primary_prior_period_report_period_id` BIGINT COMMENT 'Reference to the immediately preceding reporting period of the same type (e.g., prior quarter for quarterly periods, prior month for monthly periods). Used for period-over-period comparisons and variance analysis.',
    `prior_report_period_id` BIGINT COMMENT 'Self-referencing FK on report_period (prior_report_period_id)',
    `actuarial_opinion_required` BOOLEAN COMMENT 'Boolean flag indicating whether an actuarial opinion on reserves is required for this reporting period (True) or not (False). Required annually per NAIC Model Regulation.',
    `audit_required` BOOLEAN COMMENT 'Boolean flag indicating whether an external audit is required for financial statements produced for this reporting period (True) or not (False). Typically True for annual periods.',
    `business_days_in_period` STRING COMMENT 'The number of business days (excluding weekends and holidays) within this reporting period. Used for daily rate calculations and operational metrics normalization.',
    `calendar_days_in_period` STRING COMMENT 'The total number of calendar days within this reporting period. Used for time-weighted calculations and accrual computations.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) within the calendar year. Null for non-monthly periods.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter number (1-4) within the calendar year. Null for non-quarterly periods.',
    `calendar_year` STRING COMMENT 'The calendar year to which this reporting period belongs (e.g., 2024). Used for calendar year-based aggregations and statutory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reporting period record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this reporting period definition became effective and available for use in report configurations and data mart processing.',
    `expiration_date` DATE COMMENT 'The date on which this reporting period definition expires and is no longer valid for new report configurations. Null for active periods.',
    `fiscal_month` STRING COMMENT 'The fiscal month number (1-12) within the fiscal year. Null for non-monthly periods.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number (1-4) within the fiscal year. Null for non-quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reporting period belongs (e.g., 2024). Used for fiscal year-based aggregations and comparisons.',
    `gaap_reporting_due_date` DATE COMMENT 'The internal or external deadline by which GAAP financial statements must be completed for this period (e.g., SEC 10-K/10-Q filing deadlines for public companies).',
    `ifrs17_reporting_due_date` DATE COMMENT 'The deadline by which IFRS 17 financial statements must be completed for this period, applicable for entities reporting under international standards.',
    `is_month_end` BOOLEAN COMMENT 'Boolean flag indicating whether this period represents a month-end (True) or not (False). Month-end periods are used for internal management reporting and operational metrics.',
    `is_quarter_end` BOOLEAN COMMENT 'Boolean flag indicating whether this period represents a fiscal or calendar quarter-end (True) or not (False). Quarter-end periods typically require regulatory quarterly statement filings.',
    `is_year_end` BOOLEAN COMMENT 'Boolean flag indicating whether this period represents a fiscal or calendar year-end (True) or not (False). Year-end periods typically require additional disclosures and audit procedures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reporting period record was last updated or modified.',
    `naic_statement_type` STRING COMMENT 'The type of NAIC statutory statement required for this period: annual (Annual Statement / Yellow Book) or quarterly (Quarterly Statement). Null for non-statutory periods.. Valid values are `annual|quarterly`',
    `period_close_date` DATE COMMENT 'The date on which the reporting period was officially closed and no further transactions were accepted. Null if the period is still open.',
    `period_code` STRING COMMENT 'Business identifier code for the reporting period (e.g., 2024Q1, 2024M03, 2024A). Used as the external reference key across all reporting systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `period_description` STRING COMMENT 'Additional descriptive text providing context about this reporting period, including any special circumstances, restatements, or reporting exceptions.',
    `period_end_date` DATE COMMENT 'The last calendar date included in this reporting period. Defines the ending boundary of the period for transaction inclusion and valuation. Also known as the valuation date or as-of date.',
    `period_lock_date` DATE COMMENT 'The date on which the reporting period was locked for final reporting and no further adjustments are permitted. Null if the period has not been locked.',
    `period_name` STRING COMMENT 'Human-readable name of the reporting period (e.g., First Quarter 2024, March 2024, Annual 2024).',
    `period_start_date` DATE COMMENT 'The first calendar date included in this reporting period. Defines the beginning boundary of the period for transaction inclusion and valuation.',
    `period_status` STRING COMMENT 'Current lifecycle status of the reporting period: open (accepting transactions and adjustments), closed (no further transactions, adjustments allowed), locked (finalized, no changes permitted), archived (historical, read-only).. Valid values are `open|closed|locked|archived`',
    `period_type` STRING COMMENT 'Classification of the reporting period granularity: annual (full year), quarterly (Q1-Q4), monthly (M01-M12), semi-annual (H1/H2), year-to-date (YTD), or inception-to-date (ITD).. Valid values are `annual|quarterly|monthly|semi_annual|ytd|inception_to_date`',
    `reporting_framework` STRING COMMENT 'The accounting or regulatory framework for which this period is applicable: statutory (SAP), GAAP (US Generally Accepted Accounting Principles), IFRS 17 (International Financial Reporting Standards 17), management (internal), Solvency II, PBR (Principle-Based Reserving), LDTI (Long Duration Targeted Improvements). Multiple frameworks may share the same period definition.. Valid values are `statutory|gaap|ifrs17|management|[ENUM-REF-CANDIDATE: statutory|gaap|ifrs17|management|solvency_ii|pbr|ldti|sap — promote to reference product]`',
    `sarbanes_oxley_certification_required` BOOLEAN COMMENT 'Boolean flag indicating whether Sarbanes-Oxley Act Section 302 and 404 certifications are required for this reporting period (True) or not (False). Applicable for public companies.',
    `statutory_filing_due_date` DATE COMMENT 'The regulatory deadline by which statutory reports (NAIC Annual Statement, quarterly statements) must be filed with state insurance departments for this period.',
    CONSTRAINT pk_report_period PRIMARY KEY(`report_period_id`)
) COMMENT 'Reference master defining all reporting periods used across statutory, GAAP, IFRS 17, and management reporting frameworks — capturing period code, period type (annual/quarterly/monthly/semi-annual/YTD), period start date, period end date, fiscal year, calendar year, reporting framework applicability, and period status (open/closed/locked). Provides the authoritative reporting calendar dimension used across all report definitions and data mart configurations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_approval` (
    `report_approval_id` BIGINT COMMENT 'Unique identifier for each report approval event in the sign-off workflow. Primary key for the report approval transaction.',
    `primary_predecessor_approval_report_approval_id` BIGINT COMMENT 'Reference to the immediately preceding approval event in the workflow chain for this report instance. Enables reconstruction of the complete approval sequence.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who performed this approval action. Links to the enterprise identity management system.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition being approved. Links to the report_definition product to identify which report template or configuration is subject to this approval event.',
    `report_run_id` BIGINT COMMENT 'Unique identifier for the specific report execution or generation instance being approved. Distinguishes between multiple runs of the same report definition and version.',
    `report_version_id` BIGINT COMMENT 'Foreign key linking to reporting.report_version. Business justification: Each approval event approves a specific report_version in a multi-stage workflow. Cardinality: 1 approval → 1 version, 1 version → many approvals. Adding FK links approval to the artifact being approv',
    `prior_report_approval_id` BIGINT COMMENT 'Self-referencing FK on report_approval (prior_report_approval_id)',
    `approval_action` STRING COMMENT 'The decision or action taken by the approver at this stage. Determines whether the report progresses to the next approval level, is sent back for corrections, or is rejected.. Valid values are `approved|rejected|returned_for_revision|conditionally_approved|withdrawn`',
    `approval_comments` STRING COMMENT 'Free-text comments, notes, or feedback provided by the approver regarding their decision. May include reasons for rejection, conditions for approval, or clarifications requested.',
    `approval_due_date` DATE COMMENT 'Target or deadline date by which this approval stage must be completed. Used for workflow management and escalation triggers to ensure timely regulatory filing.',
    `approval_duration_hours` DECIMAL(18,2) COMMENT 'Elapsed time in hours between when the approval request was sent and when the approval action was completed. Used for workflow performance analysis and SLA (Service Level Agreement) monitoring.',
    `approval_method` STRING COMMENT 'The channel or interface through which the approval was submitted (e.g., web portal, mobile app, email workflow, API integration). Tracks user experience and system integration patterns.. Valid values are `web_portal|mobile_app|email_workflow|api|manual_entry`',
    `approval_sequence_number` STRING COMMENT 'Sequential order of this approval event within the overall workflow for this report instance. Enables tracking of the chronological progression through the approval chain.',
    `approval_stage` STRING COMMENT 'The hierarchical level or role in the approval workflow at which this approval event occurred. Represents the multi-level sign-off chain required for statutory filings, GAAP (Generally Accepted Accounting Principles) financials, and IFRS (International Financial Reporting Standards) 17 disclosures. [ENUM-REF-CANDIDATE: preparer|reviewer|controller|cfo|appointed_actuary|board|compliance_officer|external_auditor — 8 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current lifecycle status of this approval event. Tracks whether the approval is awaiting action, actively being reviewed, finalized, or invalidated.. Valid values are `pending|in_progress|completed|cancelled|expired`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the approval action was recorded in the system. Critical for audit trail, regulatory compliance, and establishing the timeline of the sign-off chain.',
    `approver_email` STRING COMMENT 'Business email address of the approver. Used for notification, audit trail, and contact purposes in the approval workflow.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full legal name of the individual who approved or rejected the report at this stage. Captured for audit trail and regulatory attestation purposes.',
    `approver_title` STRING COMMENT 'Official job title or role designation of the approver (e.g., Chief Financial Officer, Appointed Actuary, Controller, VP Finance). Establishes authority level for the approval.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to the detailed audit log or trail record for this approval event. Enables traceability to the full system audit history.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this approval record was first created in the database. Part of the standard audit trail for all transactional records.',
    `delegated_approval_flag` BOOLEAN COMMENT 'Indicates whether this approval was performed by a delegate acting on behalf of the primary approver. True if delegated, False if performed by the primary approver directly.',
    `delegated_from_name` STRING COMMENT 'Full name of the primary approver who delegated their approval authority. Maintains transparency in the approval chain when delegation occurs.',
    `delegation_end_date` DATE COMMENT 'Effective end date of the delegation period. After this date, the delegate no longer has authority to approve on behalf of the primary approver.',
    `delegation_start_date` DATE COMMENT 'Effective start date of the delegation period during which the delegate is authorized to approve on behalf of the primary approver.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device (computer, tablet, mobile) used to submit the approval. Supports device-based access control and forensic audit trails.',
    `digital_signature_method` STRING COMMENT 'The authentication or signature technology used to capture the approvers digital signature (e.g., PKI certificate, biometric, SSO authentication). Establishes the security level of the approval.. Valid values are `pki_certificate|biometric|sso_authentication|hardware_token|other`',
    `digital_signature_reference` STRING COMMENT 'Reference identifier or hash linking to the digital signature artifact stored in the secure signature repository. Provides non-repudiation and cryptographic proof of approval.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this approval event was escalated to a higher authority due to missed deadlines, policy exceptions, or other exceptional circumstances. True if escalated, False otherwise.',
    `escalation_reason` STRING COMMENT 'Explanation of why this approval was escalated to a higher authority or expedited through the workflow. Populated only when escalation_flag is True.',
    `ip_address` STRING COMMENT 'IP address from which the approval action was submitted. Captured for security audit, fraud detection, and access control verification purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this approval record was most recently updated. Tracks the last change to any field in the record for audit and data lineage purposes.',
    `notes` STRING COMMENT 'Additional free-form notes or metadata related to this approval event. May include system-generated messages, workflow context, or administrative annotations.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request notification was sent to the approver. Used to track workflow timing and approver responsiveness.',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether this report approval is for a regulatory filing submission (True) or an internal management report (False). Regulatory filings require stricter approval controls and audit trails.',
    `rejection_reason_code` STRING COMMENT 'Standardized code categorizing the primary reason for rejection or return-for-revision. Enables root cause analysis and process improvement tracking. [ENUM-REF-CANDIDATE: data_quality_issue|calculation_error|policy_violation|incomplete_disclosure|formatting_error|timing_issue|other — 7 candidates stripped; promote to reference product]',
    `rejection_reason_description` STRING COMMENT 'Detailed explanation of why the report was rejected or returned for revision. Provides specific guidance to the preparer for corrective action.',
    `reminder_count` STRING COMMENT 'Number of reminder notifications sent to the approver before the approval action was completed. Tracks workflow efficiency and potential bottlenecks.',
    `reporting_period_end_date` DATE COMMENT 'The ending date of the financial or operational period covered by the report being approved (e.g., 2024-03-31 for Q1 2024 report).',
    `reporting_period_start_date` DATE COMMENT 'The beginning date of the financial or operational period covered by the report being approved (e.g., 2024-01-01 for Q1 2024 report).',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this report approval is within the scope of SOX (Sarbanes-Oxley Act) internal control requirements. True if SOX-scoped, False otherwise.',
    CONSTRAINT pk_report_approval PRIMARY KEY(`report_approval_id`)
) COMMENT 'Transactional record of each formal report review and approval event in the sign-off workflow — capturing report version, approval stage (preparer/reviewer/controller/CFO/appointed-actuary/board), approver identity, approval action (approved/rejected/returned-for-revision), approval date, comments, and digital signature reference. Manages the multi-level sign-off chain required for statutory filings, GAAP financials, and IFRS 17 disclosures.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_exception` (
    `report_exception_id` BIGINT COMMENT 'Unique identifier for the report exception record. Primary key for the report exception entity.',
    `account_value_id` BIGINT COMMENT 'Foreign key linking to annuity.account_value. Business justification: Valuation exceptions (reserve calculation errors, negative CSV, RBC calculation failures, GMWB benefit base mismatches) must reference the specific account_value record for investigation, correction, ',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Data quality exceptions, reconciliation breaks, and validation failures during report generation must reference the specific contract causing the issue for remediation, root cause analysis, and audit ',
    `rule_id` BIGINT COMMENT 'Identifier of the automated validation rule or reconciliation check that detected the exception, if applicable.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key linking to policy.in_force_policy. Business justification: Data quality exceptions trace to specific policy records (missing beneficiary, invalid status, reserve error). Operational necessity for exception resolution and audit trail. Creating new FK.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition that was being produced when this exception was detected.',
    `report_line_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_line_definition. Business justification: Exceptions can be specific to report_line_definition. Cardinality: 1 exception → 1 line, 1 line → many exceptions. Adding FK links exceptions to the specific line item affected. Column affected_report',
    `report_run_id` BIGINT COMMENT 'Foreign key linking to reporting.report_run. Business justification: Exceptions are detected during a specific report_run execution. Cardinality: 1 exception → 1 run, 1 run → many exceptions. Adding FK links exceptions to the execution that detected them. No columns re',
    `related_report_exception_id` BIGINT COMMENT 'Self-referencing FK on report_exception (related_report_exception_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value, amount, or condition found in the report data that triggered the exception.',
    `affected_legal_entity` STRING COMMENT 'Legal entity or company code whose data is affected by this exception.',
    `affected_line_of_business` STRING COMMENT 'Line of business (e.g., Individual Life, Group Annuity, Variable Universal Life) affected by the exception.',
    `affected_reporting_period` STRING COMMENT 'The reporting period (e.g., 2023-Q4, 2023-12) for which the report was being generated when the exception was detected.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was assigned to an individual or team for resolution.',
    `assigned_to_email` STRING COMMENT 'Email address of the individual or team assigned to resolve the exception.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assigned_to_name` STRING COMMENT 'Full name of the individual or team currently assigned to investigate and resolve the exception.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this exception to detailed audit trail records for compliance and investigation purposes.',
    `corrective_action` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar exceptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exception record was first created in the system.',
    `detection_method` STRING COMMENT 'Method by which the exception was identified (automated validation rule, reconciliation process, manual review, or system alert).. Valid values are `automated_validation|reconciliation_process|manual_review|system_alert`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected by the report generation or validation process.',
    `exception_category` STRING COMMENT 'High-level categorization of where in the report production pipeline the exception occurred.. Valid values are `source_data|transformation|reconciliation|validation|calculation|output`',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception, including what was expected versus what was found, and the business impact.',
    `exception_number` STRING COMMENT 'Business-friendly unique identifier for the exception, formatted as EXC-YYYYMMDD-NNNN for tracking and reference in communications.. Valid values are `^EXC-[0-9]{8}-[0-9]{4}$`',
    `exception_severity` STRING COMMENT 'Severity level of the exception indicating impact on report accuracy and filing readiness. Critical exceptions block report approval; major exceptions require review; minor exceptions are informational.. Valid values are `critical|major|minor`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception in the resolution workflow.. Valid values are `open|in_progress|resolved|closed|waived`',
    `exception_type` STRING COMMENT 'Classification of the exception identifying the nature of the data quality or processing issue encountered during report production.. Valid values are `data_gap|reconciliation_break|threshold_breach|missing_source_data|validation_failure|calculation_error`',
    `expected_value` DECIMAL(18,2) COMMENT 'The expected value, amount, or condition that should have been present in the report data.',
    `impact_on_filing` STRING COMMENT 'Assessment of how the exception impacts the ability to file the report with regulatory authorities.. Valid values are `blocks_filing|requires_disclosure|informational_only|no_impact`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the exception record was last updated.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context related to the exception.',
    `resolution_action` STRING COMMENT 'Type of action taken to resolve the exception.. Valid values are `data_correction|source_system_fix|manual_adjustment|waiver_approved|process_improvement`',
    `resolution_description` STRING COMMENT 'Detailed explanation of how the exception was resolved, including corrective actions taken and root cause analysis.',
    `resolution_due_date` DATE COMMENT 'Target date by which the exception must be resolved to meet report filing deadlines.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was marked as resolved.',
    `resolved_by_email` STRING COMMENT 'Email address of the individual who resolved the exception.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `resolved_by_name` STRING COMMENT 'Full name of the individual who resolved the exception.',
    `root_cause` STRING COMMENT 'Identified root cause of the exception after investigation (e.g., system defect, data entry error, timing issue, process gap).',
    `source_record_identifier` STRING COMMENT 'Primary key or unique identifier of the source record(s) involved in the exception for traceability.',
    `source_system` STRING COMMENT 'Name of the source system or data mart from which the problematic data originated.',
    `source_table` STRING COMMENT 'Specific source table or dataset where the data quality issue was identified.',
    `sox_reportable_flag` BOOLEAN COMMENT 'Indicates whether the exception represents a material weakness or significant deficiency that must be reported under SOX compliance requirements.',
    `threshold_breached` STRING COMMENT 'Description of the data quality threshold or tolerance limit that was exceeded, triggering the exception.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Numeric difference between expected and actual values for monetary or quantitative exceptions.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between expected and actual values, calculated as (actual - expected) / expected * 100.',
    `waiver_approved_by_name` STRING COMMENT 'Full name of the authorized individual who approved the waiver.',
    `waiver_approved_flag` BOOLEAN COMMENT 'Indicates whether a waiver was approved allowing the report to proceed despite the exception remaining unresolved.',
    `waiver_justification` STRING COMMENT 'Business justification for approving a waiver and allowing the report to proceed with the exception unresolved.',
    CONSTRAINT pk_report_exception PRIMARY KEY(`report_exception_id`)
) COMMENT 'Transactional record of data quality exceptions, validation failures, and reconciliation breaks identified during report production — capturing exception type (data gap/reconciliation break/threshold breach/missing source data), affected report definition, affected line item, exception severity (critical/major/minor), detection date, resolution status, resolution description, and resolved-by. Manages the exception workflow that must be cleared before a report version can be approved and filed.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` (
    `rbc_filing_id` BIGINT COMMENT 'Unique identifier for the RBC filing record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Risk-Based Capital filings require contract-level detail for C1 (asset risk), C3 (interest rate risk), and operational risk calculations on annuity portfolios. Essential for NAIC RBC reporting, capita',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (insurance company) submitting the RBC filing.',
    `employee_id` BIGINT COMMENT 'User ID of the individual who created the RBC filing record in the system.',
    `prior_filing_rbc_filing_id` BIGINT COMMENT 'Reference to the previous RBC filing record that this filing amends or supersedes.',
    `rbc_calculation_id` BIGINT COMMENT 'Foreign key linking to finance.rbc_calculation. Business justification: RBC filings are based on specific RBC calculations performed in finance. Direct operational dependency for regulatory submission. Removes denormalized RBC calculation results from filing table, enforc',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each rbc_filing is for a specific reporting_period. Cardinality: 1 filing → 1 period, 1 period → many filings. Adding FK links RBC filing to the period being filed. Columns filing_year, filing_quarter',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: RBC filings use reserve amounts from specific valuation runs for the C1 and C2 risk components. The RBC calculation requires traceability to the actuarial valuation that produced the reserve balances ',
    `amended_rbc_filing_id` BIGINT COMMENT 'Self-referencing FK on rbc_filing (amended_rbc_filing_id)',
    `action_level_category` STRING COMMENT 'RBC action level category based on the RBC ratio: no action required, company action level, regulatory action level, authorized control level, or mandatory control level.. Valid values are `no_action|company_action|regulatory_action|authorized_control|mandatory_control`',
    `amendment_reason` STRING COMMENT 'Explanation for why the filing was amended or corrected after initial submission.',
    `approval_date` DATE COMMENT 'Date the RBC filing was approved by internal governance (e.g., CFO, Board) before submission.',
    `approved_by_name` STRING COMMENT 'Name of the executive who approved the RBC filing for submission.',
    `approved_by_title` STRING COMMENT 'Title of the executive who approved the RBC filing (e.g., Chief Financial Officer, Chief Executive Officer).',
    `confidentiality_level` STRING COMMENT 'Data classification level for the RBC filing document and associated data.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RBC filing record was first created in the system.',
    `filing_date` DATE COMMENT 'Date the RBC filing was submitted to the NAIC and state Department of Insurance.',
    `filing_notes` STRING COMMENT 'Free-text notes or comments related to the RBC filing, including special circumstances or regulatory correspondence.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the RBC filing submission.. Valid values are `draft|submitted|accepted|rejected|amended|withdrawn`',
    `filing_type` STRING COMMENT 'Type of filing submission: original, amended, corrected, or supplemental.. Valid values are `original|amended|corrected|supplemental`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the RBC filing record was last updated in the system.',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code identifying the legal entity for regulatory reporting.. Valid values are `^[0-9]{5}$`',
    `operational_risk_charge` DECIMAL(18,2) COMMENT 'Additional charge for operational risk added to the RBC calculation.',
    `preparer_email` STRING COMMENT 'Email address of the individual who prepared the RBC filing for regulatory follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'Name of the individual or firm that prepared the RBC filing.',
    `preparer_phone` STRING COMMENT 'Phone number of the individual who prepared the RBC filing for regulatory contact.',
    `preparer_title` STRING COMMENT 'Professional title of the individual who prepared the RBC filing (e.g., Chief Actuary, CFO).',
    `regulatory_acceptance_date` DATE COMMENT 'Date the RBC filing was formally accepted by the state Department of Insurance.',
    `regulatory_authority` STRING COMMENT 'Name of the state Department of Insurance or regulatory authority receiving the filing.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this RBC filing is within the scope of SOX internal controls and audit requirements.',
    `state_of_domicile` STRING COMMENT 'Two-letter US state code where the insurance company is domiciled and primarily regulated.. Valid values are `^[A-Z]{2}$`',
    `submission_method` STRING COMMENT 'Method used to submit the RBC filing (electronic portal, paper, XML, XBRL).. Valid values are `electronic|paper|xml|xbrl`',
    `trend_test_result` STRING COMMENT 'Result of the RBC trend test, which compares current year adjusted RBC to prior year to identify negative trends.. Valid values are `pass|fail|not_applicable`',
    CONSTRAINT pk_rbc_filing PRIMARY KEY(`rbc_filing_id`)
) COMMENT 'Master record for each Risk-Based Capital (RBC) filing submitted to the NAIC and state DOI — capturing legal entity, filing year, RBC action level (no action/company action/regulatory action/authorized control/mandatory control), total adjusted capital (TAC), authorized control level RBC, company action level RBC, RBC ratio, filing date, and filing status. Distinct from the actuarial RBC calculation (owned by finance domain) — this record owns the filing metadata and submission lifecycle.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` (
    `report_reconciliation_id` BIGINT COMMENT 'Unique identifier for the report reconciliation record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: GAAP-to-Statutory reconciliations, reserve roll-forwards, and account value reconciliations require contract-level detail for variance analysis, audit support, and SOX compliance. Critical for financi',
    `employee_id` BIGINT COMMENT 'The system user identifier of the individual who approved this reconciliation.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key linking to policy.in_force_policy. Business justification: GAAP/Statutory reconciliations drill to sample policies for variance investigation and audit support. Audit requirement. Role-prefixed to indicate sampling purpose in reconciliation process.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which this reconciliation is being performed.',
    `primary_report_employee_id` BIGINT COMMENT 'The system user identifier of the individual who prepared this reconciliation.',
    `prior_period_reconciliation_report_reconciliation_id` BIGINT COMMENT 'Reference to the reconciliation record for the immediately preceding reporting period, enabling period-over-period analysis.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each reconciliation is performed for a specific reporting_period. Cardinality: 1 reconciliation → 1 period, 1 period → many reconciliations. Adding FK links reconciliation to the period being reconcil',
    `reviewer_user_employee_id` BIGINT COMMENT 'The system user identifier of the individual who reviewed this reconciliation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Reconciliations often reference specific journal entries that created reconciling items between reporting frameworks (GAAP/SAP/IFRS). Required for audit trail, SOX compliance, and reconciliation docum',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: GAAP-to-Statutory reconciliations trace reserve differences back to specific valuation runs. Auditors require documentation of which actuarial valuation produced each basis (GAAP vs. Stat) for reconci',
    `prior_period_report_reconciliation_id` BIGINT COMMENT 'Self-referencing FK on report_reconciliation (prior_period_report_reconciliation_id)',
    `approval_date` DATE COMMENT 'The date on which this reconciliation was approved.',
    `approver_name` STRING COMMENT 'The full name of the individual who approved this reconciliation for final sign-off.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether a detailed audit trail is required for this reconciliation, typically for regulatory or SOX compliance purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which all monetary amounts in this reconciliation are denominated.. Valid values are `^[A-Z]{3}$`',
    `external_auditor_name` STRING COMMENT 'The name of the external audit firm that reviewed this reconciliation, if applicable.',
    `external_auditor_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation has been reviewed by external auditors as part of the annual audit process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reconciliation record was last modified or updated.',
    `line_of_business` STRING COMMENT 'The line of business to which this reconciliation applies, such as Life, Annuity, Group, or Variable products.',
    `preparation_date` DATE COMMENT 'The date on which this reconciliation was prepared.',
    `preparer_email` STRING COMMENT 'The email address of the individual who prepared this reconciliation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The full name of the individual who prepared this reconciliation.',
    `reconciliation_description` STRING COMMENT 'A detailed textual description of the purpose, scope, and methodology of this reconciliation.',
    `reconciliation_notes` STRING COMMENT 'Additional notes, comments, or observations related to this reconciliation, including explanations of significant variances or unusual items.',
    `reconciliation_number` STRING COMMENT 'Business-facing unique identifier or reference number for the reconciliation, used for tracking and audit purposes.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation process, indicating whether it is in draft, under review, approved, rejected, pending sign-off, or completed.. Valid values are `Draft|In_Review|Approved|Rejected|Pending_Sign_Off|Completed`',
    `reconciliation_type` STRING COMMENT 'The type of cross-framework reconciliation being performed, such as GAAP-to-SAP, IFRS 17-to-GAAP bridge, management-to-statutory, or inter-entity eliminations.. Valid values are `GAAP_to_SAP|IFRS17_to_GAAP|Management_to_Statutory|Inter_Entity_Elimination|SAP_to_Tax|GAAP_to_IFRS17`',
    `reconciling_item_count` STRING COMMENT 'The total number of individual reconciling items included in this reconciliation.',
    `review_date` DATE COMMENT 'The date on which this reconciliation was reviewed.',
    `reviewer_email` STRING COMMENT 'The email address of the individual who reviewed this reconciliation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reviewer_name` STRING COMMENT 'The full name of the individual who reviewed this reconciliation.',
    `sign_off_status` STRING COMMENT 'Indicates the current sign-off status of the reconciliation, tracking whether preparer, reviewer, and approver have all signed off.. Valid values are `Not_Signed_Off|Preparer_Signed|Reviewer_Signed|Fully_Signed_Off`',
    `source_balance_amount` DECIMAL(18,2) COMMENT 'The starting balance from the source reporting framework before reconciling items are applied.',
    `source_framework` STRING COMMENT 'The originating reporting framework from which the reconciliation starts (e.g., GAAP, SAP, IFRS 17, Management, Tax).. Valid values are `GAAP|SAP|IFRS17|Management|Tax`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation is within the scope of Sarbanes-Oxley Act compliance and internal control testing.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to supporting documentation, workpapers, or file locations that provide detailed evidence for this reconciliation.',
    `target_balance_amount` DECIMAL(18,2) COMMENT 'The ending balance in the target reporting framework after all reconciling items have been applied.',
    `target_framework` STRING COMMENT 'The destination reporting framework to which the reconciliation is being performed (e.g., GAAP, SAP, IFRS 17, Management, Tax).. Valid values are `GAAP|SAP|IFRS17|Management|Tax`',
    `total_reconciling_items_amount` DECIMAL(18,2) COMMENT 'The sum of all reconciling item amounts that bridge the source balance to the target balance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the expected target balance and the actual target balance, indicating any unresolved discrepancies.',
    `variance_tolerance_threshold` DECIMAL(18,2) COMMENT 'The acceptable variance threshold amount for this reconciliation. Variances exceeding this threshold require investigation and resolution.',
    `variance_within_tolerance_flag` BOOLEAN COMMENT 'Indicates whether the variance amount is within the acceptable tolerance threshold (True) or exceeds it (False).',
    CONSTRAINT pk_report_reconciliation PRIMARY KEY(`report_reconciliation_id`)
) COMMENT 'Transactional record of formal reconciliations performed between reporting frameworks — GAAP-to-SAP reconciliation, IFRS 17-to-GAAP bridge, management-to-statutory reconciliation, and inter-entity eliminations. Captures reconciliation type, reporting period, starting balance by framework, reconciling items (with descriptions and amounts), ending balance, preparer, reviewer, and sign-off status. Provides the audit trail for cross-framework reconciliation required by external auditors and regulators.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_control` (
    `report_control_id` BIGINT COMMENT 'Unique identifier for the internal control over financial reporting (ICFR) specific to the reporting production process.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition to which this control applies.',
    `compensating_report_control_id` BIGINT COMMENT 'Self-referencing FK on report_control (compensating_report_control_id)',
    `compensating_control_description` STRING COMMENT 'Description of the compensating control activities implemented to address the risk during remediation.',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether compensating controls are in place to mitigate risk while the primary control is deficient or being remediated.',
    `control_code` STRING COMMENT 'Unique business identifier for the control, typically following organizational control numbering standards.. Valid values are `^[A-Z0-9]{4,20}$`',
    `control_description` STRING COMMENT 'Detailed description of the control activity, including procedures performed and evidence obtained.',
    `control_documentation_reference` STRING COMMENT 'Reference to the location or document management system identifier where detailed control documentation is stored.',
    `control_frequency` STRING COMMENT 'How often the control is performed during the reporting period.. Valid values are `daily|weekly|monthly|quarterly|annually|on-demand`',
    `control_name` STRING COMMENT 'Descriptive name of the internal control activity.',
    `control_nature` STRING COMMENT 'Indicates whether the control is performed manually by personnel, automatically by system, or a combination of both.. Valid values are `manual|automated|semi-automated`',
    `control_objective` STRING COMMENT 'The specific financial reporting assertion or risk that this control is designed to address.',
    `control_owner_department` STRING COMMENT 'Business unit or department to which the control owner belongs.',
    `control_owner_email` STRING COMMENT 'Email address of the control owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `control_owner_name` STRING COMMENT 'Name of the individual responsible for executing and maintaining the control.',
    `control_status` STRING COMMENT 'Current operational status of the control in the ICFR framework.. Valid values are `active|inactive|suspended|under-review`',
    `control_type` STRING COMMENT 'Classification of the control based on its timing and purpose in the control framework.. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system.',
    `deficiency_description` STRING COMMENT 'Detailed description of the control deficiency, including root cause and potential impact on financial reporting.',
    `deficiency_identified_flag` BOOLEAN COMMENT 'Indicates whether any control deficiency was identified during the most recent testing period.',
    `deficiency_severity` STRING COMMENT 'Severity classification of the identified control deficiency per SOX and PCAOB standards.. Valid values are `material-weakness|significant-deficiency|control-deficiency|none`',
    `deficiency_type` STRING COMMENT 'Classification of the identified control deficiency as design-related, operating-related, or both.. Valid values are `design-deficiency|operating-deficiency|both|none`',
    `effective_end_date` DATE COMMENT 'Date when this control was retired or superseded, null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this control became effective and operational in the ICFR framework.',
    `financial_statement_assertion` STRING COMMENT 'The primary financial statement assertion addressed by this control per audit standards.. Valid values are `existence|completeness|accuracy|valuation|rights-and-obligations|presentation-and-disclosure`',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this control is designated as a key control for financial statement assertions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was most recently updated.',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested for operating effectiveness.',
    `last_test_performed_by` STRING COMMENT 'Name of the auditor or testing personnel who conducted the most recent control test.',
    `last_test_result` STRING COMMENT 'Outcome of the most recent control testing, indicating whether the control operated effectively or deficiencies were identified.. Valid values are `effective|deficient|material-weakness|significant-deficiency|not-tested`',
    `next_scheduled_test_date` DATE COMMENT 'Planned date for the next control effectiveness testing cycle.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the control, testing, or remediation activities.',
    `remediation_completion_date` DATE COMMENT 'Actual date when remediation activities were completed and the control was restored to effective operation.',
    `remediation_owner_name` STRING COMMENT 'Name of the individual responsible for executing the remediation plan.',
    `remediation_plan` STRING COMMENT 'Detailed plan outlining the steps, resources, and timeline for remediating the control deficiency.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether remediation action is required to address identified control deficiencies.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts to address identified control deficiencies.. Valid values are `not-started|in-progress|completed|validated|not-applicable`',
    `remediation_target_date` DATE COMMENT 'Target completion date for remediation activities to address the control deficiency.',
    `risk_rating` STRING COMMENT 'Assessment of the inherent risk level associated with the process or assertion this control addresses.. Valid values are `critical|high|medium|low`',
    `sample_size` STRING COMMENT 'Number of items or instances tested during the most recent control testing cycle.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this control is within the scope of SOX 404 compliance testing and certification.',
    `testing_frequency` STRING COMMENT 'How often the control effectiveness is tested by internal audit or external auditors.. Valid values are `quarterly|semi-annually|annually|on-demand`',
    `testing_method` STRING COMMENT 'The audit or testing procedure used to evaluate the operating effectiveness of the control.. Valid values are `inquiry|observation|inspection|reperformance|walkthrough`',
    CONSTRAINT pk_report_control PRIMARY KEY(`report_control_id`)
) COMMENT 'Master record of internal controls over financial reporting (ICFR) specific to the reporting production process — capturing control name, control type (preventive/detective), control objective, applicable report definition, control owner, control frequency, testing method, last test date, test result (effective/deficient/material-weakness), and remediation status. Supports SOX ICFR compliance for the financial reporting close process distinct from the broader compliance.sox_control entity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`close_calendar` (
    `close_calendar_id` BIGINT COMMENT 'Unique identifier for the financial close calendar record. Primary key for the close calendar entity.',
    `dependency_close_calendar_id` BIGINT COMMENT 'Reference to another close calendar record that must complete before this phase can proceed. Used for cross-entity or cross-framework dependencies (e.g., legal entity sub-close must complete before consolidated close).',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Each close_calendar is defined for a specific reporting_period. Cardinality: 1 close_calendar → 1 period, 1 period → potentially many close_calendars (different frameworks). Adding FK links close cale',
    `prior_period_close_calendar_id` BIGINT COMMENT 'Self-referencing FK on close_calendar (prior_period_close_calendar_id)',
    `actuarial_opinion_attached_flag` BOOLEAN COMMENT 'Indicates whether an appointed actuarys opinion on reserves is attached to reports from this close cycle. True = actuarial opinion included, False = no actuarial opinion. Required for annual statutory statements.',
    `approval_date` DATE COMMENT 'The date on which the close cycle was formally approved. Null if approval is pending or not required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal management or regulatory approval is required before this close cycle can be marked complete. True = approval required, False = no approval needed.',
    `approver_name` STRING COMMENT 'Full name of the individual authorized to approve completion of this close cycle (e.g., Chief Financial Officer, Chief Actuary, Controller).',
    `audit_opinion_attached_flag` BOOLEAN COMMENT 'Indicates whether an external auditors opinion is attached to reports from this close cycle. True = audit opinion included, False = no audit opinion. Typically true for annual statutory statements.',
    `certification_date` DATE COMMENT 'The date on which the certifying officer signed the certification statement. Null if certification is pending or not required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether executive certification (e.g., CEO/CFO certification under SOX or state insurance law) is required for reports produced from this close cycle. True = certification required, False = not required.',
    `certifying_officer_name` STRING COMMENT 'Full name of the executive officer who certifies the accuracy and completeness of reports from this close cycle (typically CEO, CFO, or Chief Actuary).',
    `close_cycle_code` STRING COMMENT 'Standardized code for the close cycle (e.g., Q1-2024-SAP, M12-2023-GAAP, FY2024-IFRS17). Used for system integration and reporting automation.',
    `close_cycle_name` STRING COMMENT 'Business name for the financial close cycle (e.g., Q1 2024 Statutory Close, December 2023 GAAP Close, FY2024 IFRS 17 Annual Close). Human-readable identifier for the close period.',
    `close_frequency` STRING COMMENT 'The cadence at which this close cycle occurs (e.g., Monthly for monthly close, Quarterly for quarterly regulatory filings, Annual for year-end statutory statements).. Valid values are `Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc`',
    `close_phase` STRING COMMENT 'The current phase of the financial close process. Sub-Ledger Close = operational system close (policy admin, claims, billing), General Ledger Close = GL reconciliation and journal entries, Actuarial Close = reserve calculations and valuations, Consolidation = legal entity consolidation, Management Review = internal review and approval, Regulatory Review = compliance and audit review, Filing = submission to regulatory authorities, Complete = close cycle finalized. [ENUM-REF-CANDIDATE: Sub-Ledger Close|General Ledger Close|Actuarial Close|Consolidation|Management Review|Regulatory Review|Filing|Complete — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this close calendar record was first created in the system. Used for audit trail and data lineage.',
    `data_mart_source` STRING COMMENT 'The name or identifier of the data mart or data warehouse that provides source data for reports generated from this close cycle (e.g., Statutory Data Mart, GAAP Reporting Warehouse, Actuarial Valuation Mart).',
    `filing_deadline_date` DATE COMMENT 'The regulatory or internal deadline by which all reports for this close cycle must be filed or delivered. Drives the entire close calendar timeline.',
    `fiscal_month` STRING COMMENT 'The fiscal month within the year (1-12). Null for quarterly or annual-only close cycles. Used for monthly management reporting.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the year (1, 2, 3, or 4). Null for annual-only close cycles. Used for quarterly regulatory filings and trend analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this close cycle belongs (e.g., 2024). Used for year-over-year analysis and annual reporting aggregation.',
    `ifrs17_compliance_flag` BOOLEAN COMMENT 'Indicates whether this close cycle must comply with IFRS 17 insurance contracts standard. True = IFRS 17 applies, False = not applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this close calendar record was most recently updated. Used for audit trail and change tracking.',
    `ldti_compliance_flag` BOOLEAN COMMENT 'Indicates whether this close cycle must comply with FASB ASC 944 Long Duration Targeted Improvements (LDTI) requirements. True = LDTI applies, False = pre-LDTI or not applicable.',
    `legal_entity_scope` STRING COMMENT 'The legal entity or entities covered by this close cycle (e.g., ABC Life Insurance Company, Consolidated Group, XYZ Annuity Subsidiary). Defines the reporting boundary.',
    `line_of_business` STRING COMMENT 'The insurance line of business covered by this close cycle (e.g., Life, Annuity, Accident & Health, All Lines). Used for segmented reporting and analysis.',
    `naic_company_code` STRING COMMENT 'The five-digit NAIC company code for the legal entity. Required for statutory filings and regulatory identification.. Valid values are `^[0-9]{5}$`',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or context about this close cycle (e.g., Delayed due to system outage, Includes restatement of prior period, First close under new LDTI standard).',
    `overall_close_status` STRING COMMENT 'The overall status of the entire close cycle across all phases. Open = close cycle initiated but not started, In Progress = one or more phases underway, Complete = all phases finished and reports filed, Delayed = behind schedule, Failed = critical error requiring restart, Cancelled = close cycle aborted.. Valid values are `Open|In Progress|Complete|Delayed|Failed|Cancelled`',
    `pbr_compliance_flag` BOOLEAN COMMENT 'Indicates whether this close cycle includes Principle-Based Reserving (PBR) calculations and disclosures. True = PBR applies, False = formula reserves only.',
    `phase_actual_completion_date` DATE COMMENT 'The actual date on which the current close phase was completed. Null if phase is still in progress. Used for cycle time analysis and process improvement.',
    `phase_due_date` DATE COMMENT 'The scheduled completion date for the current close phase. Defines the deadline by which this phase must be completed to meet downstream dependencies and filing deadlines.',
    `phase_owner_department` STRING COMMENT 'The business unit or department responsible for the current phase (e.g., Actuarial, Finance - Statutory Reporting, Corporate Accounting, Regulatory Compliance).',
    `phase_owner_email` STRING COMMENT 'Primary email contact for the phase owner. Used for notifications, escalations, and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `phase_owner_name` STRING COMMENT 'Full name of the individual or team responsible for completing the current close phase (e.g., Actuarial Valuation Team, Controller - Statutory Reporting).',
    `phase_start_date` DATE COMMENT 'The scheduled start date for the current close phase. Defines when work on this phase is expected to begin.',
    `phase_status` STRING COMMENT 'Current execution status of the close phase. Not Started = phase has not begun, In Progress = work is underway, Complete = phase finished successfully, Delayed = behind schedule, Blocked = waiting on dependency, On Hold = temporarily suspended.. Valid values are `Not Started|In Progress|Complete|Delayed|Blocked|On Hold`',
    `predecessor_phase` STRING COMMENT 'The close phase that must be completed before the current phase can begin. Defines upstream dependencies in the close process workflow (e.g., Sub-Ledger Close must complete before General Ledger Close can start).',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether formal reconciliation between source systems and reporting outputs is required for this close cycle. True = reconciliation mandatory, False = reconciliation not required.',
    `reporting_framework` STRING COMMENT 'The accounting or regulatory framework governing this close cycle. SAP = Statutory Accounting Principles, GAAP = Generally Accepted Accounting Principles, IFRS17 = International Financial Reporting Standard 17, Management = internal management reporting, Regulatory = specific regulatory filings, Tax = tax basis reporting.. Valid values are `SAP|GAAP|IFRS17|Management|Regulatory|Tax`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this close cycle is within the scope of SOX Section 404 internal control testing and certification. True = SOX controls apply, False = not subject to SOX.',
    `state_jurisdiction` STRING COMMENT 'The state insurance department jurisdiction for statutory filings (e.g., New York, Texas, Delaware). Defines which states regulatory requirements apply.',
    CONSTRAINT pk_close_calendar PRIMARY KEY(`close_calendar_id`)
) COMMENT 'Master record defining the financial close calendar for each reporting period — capturing close cycle name, reporting period, close phase (sub-ledger close/GL close/actuarial close/consolidation/review/filing), phase start date, phase due date, phase owner, dependencies on upstream close phases, and phase status (open/in-progress/complete/delayed). Governs the end-to-end financial close process timeline that drives report production across statutory, GAAP, and IFRS 17 frameworks.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`close_task` (
    `close_task_id` BIGINT COMMENT 'Unique identifier for the financial close task record. Primary key for the close task entity.',
    `blocking_dependency_task_id` BIGINT COMMENT 'Reference to another close task that must be completed before this task can begin. Defines task sequencing and critical path within the close calendar.',
    `close_calendar_id` BIGINT COMMENT 'Foreign key linking to reporting.close_calendar. Business justification: Each close_task is part of a close_calendar. Cardinality: 1 task → 1 calendar, 1 calendar → many tasks. Adding FK links tasks to the calendar they belong to. Columns reporting_period_start_date, repor',
    `sox_control_id` BIGINT COMMENT 'Reference to the specific internal control or SOX control that this task supports. Links task execution to the control testing and compliance framework.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key linking to policy.in_force_policy. Business justification: Period-end close tasks target specific policies for review (large face amounts, unusual transactions, manual reserve adjustments). Close process operational reality. Creating new FK.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who is responsible for completing this close task. Primary point of accountability for task execution.',
    `report_schedule_id` BIGINT COMMENT 'Reference to the parent report schedule that this close task belongs to. Links the task to the broader reporting calendar and schedule.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the user responsible for reviewing and approving the completed task. Required for tasks with approval workflows.',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: Close tasks include running and reviewing actuarial valuation runs as part of the financial close process. The close calendar must track which valuation run was executed for each reporting period to e',
    `predecessor_close_task_id` BIGINT COMMENT 'Self-referencing FK on close_task (predecessor_close_task_id)',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Date and time when work on the task actually began. Used to measure cycle time and identify delays in task initiation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the task output was formally approved by the reviewer. Represents final sign-off for tasks requiring approval.',
    `assigned_owner_email` STRING COMMENT 'Email address of the task owner, used for automated notifications, reminders, and escalation communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assigned_owner_name` STRING COMMENT 'Full name of the individual assigned to complete the close task. Provides human-readable identification for reporting and communication.',
    `assigned_team` STRING COMMENT 'Business unit, department, or functional team responsible for the task (e.g., Actuarial, Financial Reporting, Tax, Reinsurance Accounting).',
    `comments` STRING COMMENT 'Free-text field for task owner or reviewer to document issues, observations, variances, or other relevant information about task execution.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the task was marked as complete. Used to calculate task duration and close cycle metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the close task record was first created in the system. Audit trail for task lifecycle tracking.',
    `data_source_system` STRING COMMENT 'Name of the upstream system or application that provides input data for this close task (e.g., Policy Administration System, Actuarial Valuation System, General Ledger).',
    `dependency_status` STRING COMMENT 'Current state of prerequisite task dependencies. Indicates whether the task is ready to start or is blocked waiting for upstream tasks.. Valid values are `no_dependencies|dependencies_met|waiting_on_dependencies|dependency_failed`',
    `due_date` DATE COMMENT 'Target completion date for the close task. Used to track on-time performance and identify overdue tasks requiring escalation.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Actual time spent completing the task, measured in hours. Used for capacity planning, efficiency analysis, and process improvement.',
    `escalation_date` DATE COMMENT 'Date when the task was escalated to management or senior stakeholders. Used to track escalation response time and resolution.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator that the task has been escalated to management due to delays, issues, or risk to the close timeline. Triggers heightened monitoring and intervention.',
    `escalation_reason` STRING COMMENT 'Explanation of why the task was escalated, including specific issues, blockers, or risks that require management attention.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Planned or expected time to complete the task, measured in hours. Used for resource planning and schedule development.',
    `evidence_document_path` STRING COMMENT 'File system path or document management system reference to the evidence artifacts supporting task completion (e.g., reconciliation workpapers, approval emails, system screenshots).',
    `evidence_required_flag` BOOLEAN COMMENT 'Indicator that the task requires documented evidence of completion for audit, compliance, or control testing purposes.',
    `issue_description` STRING COMMENT 'Detailed description of any problems, errors, or exceptions encountered during task execution. Used for issue tracking and resolution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the close task record was most recently updated. Tracks changes to task status, assignments, or other attributes.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity or insurance company for which this close task is being performed. Supports multi-entity close processes.',
    `line_of_business` STRING COMMENT 'Insurance product line or business segment that this close task relates to (e.g., Individual Life, Group Annuities, Variable Universal Life). Used for segmented reporting and analysis.',
    `priority_level` STRING COMMENT 'Business priority assigned to the task, indicating urgency and importance within the close calendar. Critical tasks typically have regulatory or external filing dependencies.. Valid values are `critical|high|medium|low`',
    `resolution_notes` STRING COMMENT 'Documentation of how issues or blockers were resolved, including corrective actions taken and preventive measures implemented.',
    `reviewer_name` STRING COMMENT 'Full name of the individual assigned to review the close task output. Provides accountability for quality control and approval.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work on this close task should begin, based on the close calendar and dependency sequencing.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicator that this task is part of a SOX-controlled process requiring documented evidence, segregation of duties, and audit trail retention.',
    `task_category` STRING COMMENT 'Reporting framework or compliance category that this task supports. Aligns the task with specific accounting standards or regulatory requirements. [ENUM-REF-CANDIDATE: statutory|gaap|ifrs17|management|regulatory|sox|internal — 7 candidates stripped; promote to reference product]',
    `task_instructions` STRING COMMENT 'Detailed procedural guidance or step-by-step instructions for completing the close task. May reference standard operating procedures or work instructions.',
    `task_name` STRING COMMENT 'Descriptive name of the close task that clearly identifies the work to be performed (e.g., Post Actuarial Reserve Adjustments, Reconcile Premium Receivables, Validate DAC Amortization).',
    `task_number` STRING COMMENT 'Business-facing unique identifier or reference number for the close task, used for tracking and communication purposes.',
    `task_status` STRING COMMENT 'Current lifecycle status of the close task. Tracks progression through the close workflow and identifies tasks requiring attention or intervention.. Valid values are `not_started|in_progress|complete|overdue|blocked|cancelled`',
    `task_type` STRING COMMENT 'Classification of the close task by its functional nature. Determines the workflow, approval requirements, and system interactions for the task.. Valid values are `journal_entry|reconciliation|actuarial_upload|data_validation|report_sign_off|filing_submission`',
    CONSTRAINT pk_close_task PRIMARY KEY(`close_task_id`)
) COMMENT 'Transactional record of each individual task within the financial close calendar — capturing task name, task type (journal entry/reconciliation/actuarial upload/data validation/report sign-off/filing submission), assigned owner, due date, completion date, task status (not-started/in-progress/complete/overdue/blocked), blocking dependencies, and escalation flag. Provides the operational workflow management for the reporting close process.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`segment_definition` (
    `segment_definition_id` BIGINT COMMENT 'Unique identifier for the reporting segment definition. Primary key for the segment definition catalog.',
    `parent_segment_definition_id` BIGINT COMMENT 'Reference to the parent segment in the hierarchy. Null for top-level segments. Enables hierarchical roll-up of financial and operational data.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reporting segments are defined by product for IFRS17 cohort tracking, GAAP product groupings, and segment reporting. Real business need: IFRS17 CSM amortization by product cohort, ASC 944 product-leve',
    `primary_predecessor_segment_definition_id` BIGINT COMMENT 'Reference to the prior version of this segment definition that this version supersedes. Null for initial versions. Enables version lineage tracking.',
    `aggregation_rule` STRING COMMENT 'Business rule or SQL logic defining how detailed data is aggregated into this segment. May reference policy attributes, product codes, distribution hierarchies, or geographic mappings.',
    `approval_date` DATE COMMENT 'Date on which the segment definition was formally approved by the governance authority. Required for SOX compliance and audit trail.',
    `approval_status` STRING COMMENT 'Governance approval status for this segment definition. Ensures only approved segments are used in regulatory and financial reporting.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by_name` STRING COMMENT 'Full name of the individual (typically CFO, Chief Actuary, or Controller) who approved this segment definition for use in financial reporting.',
    `confidentiality_level` STRING COMMENT 'Data classification level for reports using this segment: public (external disclosure), internal (internal use only), confidential (management only), or restricted (executive/board only).. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment definition record was first created in the system. Part of the audit trail for governance and compliance.',
    `data_mart_source` STRING COMMENT 'Name or identifier of the data mart or data warehouse layer that sources data for this segment (e.g., actuarial_data_mart, financial_reporting_mart, policy_data_mart).',
    `distribution_channel_type` STRING COMMENT 'Type of distribution channel (e.g., career agent, independent agent, broker, bank, direct-to-consumer, worksite) for distribution-channel segment types.',
    `effective_end_date` DATE COMMENT 'Date on which this segment definition ceases to be active. Null for currently active segments. Enables historical segment analysis and restated financials.',
    `effective_start_date` DATE COMMENT 'Date from which this segment definition becomes active and applicable for financial and operational reporting. Supports temporal segmentation changes.',
    `exclusion_criteria` STRING COMMENT 'Business rules defining what data is explicitly excluded from this segment (e.g., reinsurance ceded, discontinued products, non-admitted assets).',
    `gaap_product_classification` STRING COMMENT 'GAAP product classification under ASC 944 and LDTI: traditional long-duration (whole life, term), limited-payment (paid-up policies), universal life (UL, IUL, VUL), investment contract (deferred annuities without mortality risk), or short-duration (accident and health).. Valid values are `traditional_long_duration|limited_payment|universal_life|investment_contract|short_duration`',
    `geographic_scope` STRING COMMENT 'Geographic scope of the segment (e.g., state code, region name, country code) for geographic segment types. Supports state-level statutory reporting.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this segment within its hierarchy (1 = top level, higher numbers = more granular). Enables roll-up aggregation from detailed segments to summary segments.',
    `ifrs17_contract_group_identifier` STRING COMMENT 'Unique identifier for the IFRS 17 contract group (cohort of insurance contracts with similar risk characteristics issued within one year). Required for IFRS 17 CSM and liability measurement.',
    `ifrs17_onerous_flag` BOOLEAN COMMENT 'Indicates whether this IFRS 17 contract group is classified as onerous (expected to generate losses) at initial recognition. Onerous contracts are measured differently under IFRS 17.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this segment definition record. Supports change tracking and audit requirements.',
    `last_used_date` DATE COMMENT 'Most recent date this segment was used in a report run. Helps identify obsolete segments for retirement.',
    `line_of_business_code` STRING COMMENT 'Standard code identifying the line of business (e.g., individual life, group life, individual annuity, group annuity, accident and health) for line-of-business segment types.',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code for the legal entity to which this segment applies. Used for statutory reporting and regulatory filings.. Valid values are `^[0-9]{5}$`',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, change history, special instructions, or business rationale for this segment definition.',
    `owning_business_unit` STRING COMMENT 'Name or code of the business unit (e.g., Individual Life, Group Annuity, Reinsurance) that owns and governs this segment definition.',
    `pbr_applicability_flag` BOOLEAN COMMENT 'Indicates whether this segment is subject to Principle-Based Reserving (PBR) under VM-20 and VM-21. PBR applies to term life and universal life products issued after the effective date.',
    `product_category` STRING COMMENT 'High-level product category (e.g., term life, whole life, universal life, indexed universal life, fixed annuity, variable annuity, fixed indexed annuity) for product-group segment types.',
    `rbc_category` STRING COMMENT 'Risk-Based Capital category for this segment (e.g., C1 asset risk, C2 insurance risk, C3 interest rate risk, C4 business risk). Used in RBC calculations and capital adequacy reporting.',
    `reinsurance_treaty_scope` STRING COMMENT 'Indicates whether this segment includes direct business only, assumed reinsurance, ceded reinsurance, or net (direct plus assumed minus ceded). Critical for reinsurance accounting and Schedule S reporting.',
    `reporting_framework` STRING COMMENT 'Primary accounting or reporting framework for which this segment is defined: statutory (SAP), GAAP (US Generally Accepted Accounting Principles), IFRS 17 (International Financial Reporting Standards 17), management (internal), or regulatory (NAIC, state-specific).. Valid values are `statutory|gaap|ifrs17|management|regulatory`',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the segment across all reporting frameworks. Used as a business key in reports and data marts.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `segment_description` STRING COMMENT 'Detailed business description of the segment, including scope, inclusion/exclusion criteria, and business rationale for the segmentation.',
    `segment_name` STRING COMMENT 'Full descriptive name of the reporting segment as it appears in financial statements and management reports.',
    `segment_owner_email` STRING COMMENT 'Email address of the segment owner for inquiries and approval workflows related to segment definition changes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `segment_owner_name` STRING COMMENT 'Full name of the business owner responsible for defining and maintaining this segment (typically an actuarial, finance, or reporting manager).',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition: active (in use), inactive (temporarily disabled), pending approval (awaiting governance review), superseded (replaced by a newer definition), or retired (no longer used).. Valid values are `active|inactive|pending_approval|superseded|retired`',
    `segment_type` STRING COMMENT 'Classification of the segment dimension: line of business (e.g., individual life, group annuity), legal entity (e.g., insurance company, reinsurance subsidiary), product group (e.g., term life, variable annuity), distribution channel (e.g., career agent, broker), geographic (e.g., state, region), or IFRS 17 contract group (cohort of contracts with similar risk characteristics).. Valid values are `line_of_business|legal_entity|product_group|distribution_channel|geographic|ifrs17_contract_group`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this segment is within the scope of SOX internal controls testing. Segments used in external financial reporting are typically SOX-scoped.',
    `statutory_line_of_business` STRING COMMENT 'Statutory line of business as defined by NAIC SAP (e.g., ordinary life, credit life, group life, individual annuity, group annuity, accident and health). Maps to specific Annual Statement schedules.',
    `usage_count` STRING COMMENT 'Number of active report definitions that reference this segment. Used to assess segment importance and impact of changes.',
    `version_number` STRING COMMENT 'Sequential version number of this segment definition. Incremented with each approved change to support change tracking and historical analysis.',
    CONSTRAINT pk_segment_definition PRIMARY KEY(`segment_definition_id`)
) COMMENT 'Master catalog of reporting segments used across statutory, GAAP, IFRS 17, and management reporting — capturing segment name, segment type (line of business/legal entity/product group/distribution channel/geographic/IFRS 17 contract group), segment hierarchy level, applicable reporting framework, effective date range, and segment owner. Defines the authoritative segmentation dimensions used to slice financial and operational data across all report definitions.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` (
    `report_access_policy_id` BIGINT COMMENT 'Unique identifier for the report access policy record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for maintaining and reviewing this access policy.',
    `primary_report_employee_id` BIGINT COMMENT 'Identifier of the user who revoked or terminated this access policy.',
    `report_definition_id` BIGINT COMMENT 'Reference to the report definition governed by this access policy. Links to the specific report template, schedule, or filing definition whose access is being controlled.',
    `tertiary_report_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this access policy record.',
    `superseded_report_access_policy_id` BIGINT COMMENT 'Self-referencing FK on report_access_policy (superseded_report_access_policy_id)',
    `access_count` STRING COMMENT 'Total number of times access has been exercised under this policy since grant date. Used for usage monitoring and policy review.',
    `access_grant_date` DATE COMMENT 'Date on which access was granted under this policy. Represents the authorization or approval date.',
    `access_restrictions` STRING COMMENT 'Additional restrictions or conditions applied to this access policy, such as time-of-day limitations, IP address restrictions, or specific data element masking requirements.',
    `access_role` STRING COMMENT 'The role or job function authorized under this policy (e.g., Actuarial Analyst, CFO, Compliance Officer, State Regulator, External Auditor).',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether access under this policy requires explicit approval for each use (true) or is automatically granted based on role (false).',
    `approver_role` STRING COMMENT 'Role or title of the individual authorized to approve access requests under this policy (e.g., Chief Actuary, CFO, Compliance Director).',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether all access events under this policy must be logged and retained for audit purposes.',
    `authorized_party_type` STRING COMMENT 'Classification of the party type authorized by this policy: internal employee, internal contractor, external regulator (state DOI, NAIC, SEC), external auditor, external reinsurer, or board member.. Valid values are `internal_employee|internal_contractor|external_regulator|external_auditor|external_reinsurer|board_member`',
    `confidentiality_agreement_date` DATE COMMENT 'Date on which the authorized party signed the required confidentiality or non-disclosure agreement.',
    `confidentiality_agreement_required_flag` BOOLEAN COMMENT 'Indicates whether the authorized party must sign a confidentiality or non-disclosure agreement before access is granted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access policy record was first created in the system.',
    `data_classification_level` STRING COMMENT 'Classification level of the report data governed by this policy: restricted (highly sensitive, PII/PHI), confidential (business-sensitive), internal (general business use), public (externally disclosable).. Valid values are `restricted|confidential|internal|public`',
    `effective_end_date` DATE COMMENT 'Date on which this access policy expires or is terminated. Null indicates an open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date from which this access policy becomes active and enforceable.',
    `expiry_date` DATE COMMENT 'Scheduled expiration date for periodic review or renewal of this access policy, distinct from effective_end_date which represents actual termination.',
    `jurisdiction_scope` STRING COMMENT 'Regulatory jurisdiction(s) or geographic scope to which this access policy applies (e.g., New York, California, Federal SEC, All States). Pipe-separated list for multiple jurisdictions.',
    `last_access_date` DATE COMMENT 'Most recent date on which access was exercised under this policy. Used for policy review and dormant access identification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this access policy record was most recently updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this access policy.',
    `legal_entity_scope` STRING COMMENT 'Legal entity or entities to which this access policy applies. May reference NAIC company codes or internal legal entity identifiers. Pipe-separated for multiple entities.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this access policy.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this access policy.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the access policy, used for external reference and audit trails.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `policy_name` STRING COMMENT 'Descriptive name of the access control policy, clearly identifying its purpose and scope.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the access policy: active (in force), suspended (temporarily inactive), expired (past end date), revoked (terminated early), pending_approval (awaiting authorization).. Valid values are `active|suspended|expired|revoked|pending_approval`',
    `policy_type` STRING COMMENT 'Type of access granted by this policy: view (read-only access), prepare (create/edit report), approve (authorize for submission), distribute (send to recipients), certify (officer certification), audit (regulatory examination).. Valid values are `view|prepare|approve|distribute|certify|audit`',
    `review_frequency_months` STRING COMMENT 'Number of months between required periodic reviews of this access policy to ensure continued appropriateness and compliance.',
    `revocation_date` DATE COMMENT 'Date on which this access policy was revoked or terminated.',
    `revocation_reason` STRING COMMENT 'Explanation for why this access policy was revoked or terminated early, if applicable. Includes reasons such as role change, employment termination, security incident, or policy violation.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this access policy is within the scope of SOX compliance controls and audit requirements.',
    CONSTRAINT pk_report_access_policy PRIMARY KEY(`report_access_policy_id`)
) COMMENT 'Master record defining access control policies governing who may view, produce, approve, or distribute each report definition — capturing policy name, applicable report definition, access role (viewer/preparer/approver/distributor), authorized party type (internal role/external regulator/auditor), data classification level (restricted/confidential/internal/public), access grant date, expiry date, and policy owner. Governs report-level data access in compliance with confidentiality and regulatory requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`filing_content` (
    `filing_content_id` BIGINT COMMENT 'Unique identifier for this filing content record representing the inclusion of a specific exhibit in a specific filing',
    `statutory_exhibit_id` BIGINT COMMENT 'Foreign key linking to the statutory exhibit included in this filing',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to the statutory filing that contains this exhibit',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this specific exhibit was approved for inclusion in this statutory filing',
    `completion_status` STRING COMMENT 'Current completion status of this specific exhibit within the context of this filing, tracking the preparation workflow from initial draft through final approval',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing content record was first created in the system',
    `data_as_of_date` DATE COMMENT 'The effective date of the data contained in this exhibit for this specific filing, which may vary by exhibit even within the same filing period',
    `exhibit_sequence_number` STRING COMMENT 'The sequential order in which this exhibit appears within the statutory filing package, determining the presentation order for regulatory submission',
    `page_number` STRING COMMENT 'The starting page number where this exhibit begins within the assembled statutory filing document',
    `preparer_name` STRING COMMENT 'Name of the individual or team responsible for preparing this specific exhibit for inclusion in this filing',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved this specific exhibit for inclusion in this filing',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing content record was last modified',
    CONSTRAINT pk_filing_content PRIMARY KEY(`filing_content_id`)
) COMMENT 'This association product represents the inclusion of statutory exhibits and schedules within regulatory filings submitted to NAIC or state DOI. It captures the assembly and composition of statutory filings, tracking which exhibits appear in which filings, their sequence, completion status, and preparer/reviewer information. Each record links one statutory filing to one statutory exhibit with attributes that exist only in the context of this filing assembly relationship.. Existence Justification: In insurance regulatory reporting, statutory filings are composite documents assembled from multiple standardized exhibits and schedules (Exhibit 5, 6, 7, Schedule S, Schedule D, etc.). A single filing contains multiple exhibits, and the same exhibit definition (e.g., Schedule S - Reinsurance) appears in multiple filings across different periods, legal entities, and filing types (annual, quarterly, amended). The business actively manages the assembly process, tracking which exhibits are complete, their sequence in the filing package, preparer/reviewer assignments, and approval status for each exhibit-filing combination.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`reporting`.`package_content` (
    `package_content_id` BIGINT COMMENT 'Unique identifier for each package content record. Primary key.',
    `report_package_id` BIGINT COMMENT 'Foreign key linking to the report package that contains this report version',
    `report_version_id` BIGINT COMMENT 'Foreign key linking to the specific report version included in this package',
    `content_notes` STRING COMMENT 'Free-text field for additional context about this specific inclusion (e.g., Use final version only, Awaiting CFO signature, Cross-reference to Exhibit B on page 47).',
    `content_status` STRING COMMENT 'Current status of this content item within the package assembly workflow (Included = active in package, Pending Review = awaiting approval, Approved = finalized, Excluded = removed from package, Superseded = replaced by newer version).',
    `exclusion_reason` STRING COMMENT 'If content_status is Excluded or Superseded, explanation of why this report version was removed from the package or replaced. Null for active content.',
    `included_by` STRING COMMENT 'Name or identifier of the report coordinator or system user who added this report version to the package. Provides audit trail for package assembly decisions.',
    `inclusion_date` DATE COMMENT 'The date this report version was added to the package. Tracks the timeline of package assembly and content finalization.',
    `inclusion_reason` STRING COMMENT 'Business justification for including this specific report version in the package (e.g., Required by NAIC Annual Statement filing, Board requested supplemental analysis, Amended to correct prior period error). Explicitly identified in detection phase.',
    `inclusion_timestamp` TIMESTAMP COMMENT 'Precise date and time when this report version was added to the package. Provides exact audit trail for regulatory compliance.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this report version is required by regulation or policy for this package type (true) or is optional/supplemental (false). Used to validate package completeness before filing.',
    `page_range` STRING COMMENT 'The page number range this report version occupies in the assembled package document (e.g., 15-23, 1-1 for single page). Used for table of contents generation and cross-reference management. Explicitly identified in detection phase.',
    `section_title` STRING COMMENT 'The display title or section heading under which this report version appears in the assembled package (e.g., Section II: Balance Sheet, Exhibit A: Statutory Reserves). May differ from the report versions native title to fit package structure. Explicitly identified in detection phase.',
    `sequence_number` STRING COMMENT 'The ordinal position of this report version within the package, determining the presentation order in the assembled submission (e.g., 1 for cover page, 2 for executive summary, 3 for balance sheet). Explicitly identified in detection phase.',
    `version_role` STRING COMMENT 'The functional role this report version plays within the package context (e.g., Primary Exhibit, Supporting Schedule, Supplemental Disclosure). The same report version may serve different roles in different packages. Explicitly identified in detection phase.',
    CONSTRAINT pk_package_content PRIMARY KEY(`package_content_id`)
) COMMENT 'This association product represents the inclusion relationship between report packages and report versions. It captures the business logic of assembling multi-report regulatory submissions by tracking which specific report versions are included in each package, their sequence, presentation context, and inclusion rationale. Each record links one report package to one report version with attributes that exist only in the context of this inclusion relationship.. Existence Justification: In insurance reporting operations, report packages are curated collections assembled for specific regulatory submissions or stakeholder audiences (e.g., NAIC Annual Statement, board package, audit package). Report coordinators actively manage package content by selecting specific report versions, determining their sequence and presentation context, and tracking inclusion rationale. The same report version (e.g., a GAAP income statement) is routinely included in multiple packages serving different purposes, and each package contains multiple report versions. This is an operational many-to-many relationship with explicit business management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_gaap_report_config_id` FOREIGN KEY (`gaap_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`gaap_report_config`(`gaap_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_ifrs17_report_config_id` FOREIGN KEY (`ifrs17_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`ifrs17_report_config`(`ifrs17_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_predecessor_report_definition_id` FOREIGN KEY (`predecessor_report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ADD CONSTRAINT `fk_reporting_report_definition_parent_report_definition_id` FOREIGN KEY (`parent_report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ADD CONSTRAINT `fk_reporting_report_schedule_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ADD CONSTRAINT `fk_reporting_report_schedule_superseded_report_schedule_id` FOREIGN KEY (`superseded_report_schedule_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_parent_run_report_run_id` FOREIGN KEY (`parent_run_report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_report_schedule_id` FOREIGN KEY (`report_schedule_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ADD CONSTRAINT `fk_reporting_report_run_rerun_report_run_id` FOREIGN KEY (`rerun_report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ADD CONSTRAINT `fk_reporting_report_version_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ADD CONSTRAINT `fk_reporting_report_version_superseded_version_report_version_id` FOREIGN KEY (`superseded_version_report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ADD CONSTRAINT `fk_reporting_report_version_prior_report_version_id` FOREIGN KEY (`prior_report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_filing_template_id` FOREIGN KEY (`filing_template_id`) REFERENCES `life_insurance_ecm`.`reporting`.`filing_template`(`filing_template_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_prior_filing_statutory_filing_id` FOREIGN KEY (`prior_filing_statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ADD CONSTRAINT `fk_reporting_statutory_filing_amended_statutory_filing_id` FOREIGN KEY (`amended_statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ADD CONSTRAINT `fk_reporting_filing_template_superseded_by_template_filing_template_id` FOREIGN KEY (`superseded_by_template_filing_template_id`) REFERENCES `life_insurance_ecm`.`reporting`.`filing_template`(`filing_template_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ADD CONSTRAINT `fk_reporting_filing_template_superseded_filing_template_id` FOREIGN KEY (`superseded_filing_template_id`) REFERENCES `life_insurance_ecm`.`reporting`.`filing_template`(`filing_template_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ADD CONSTRAINT `fk_reporting_report_package_prior_period_package_report_package_id` FOREIGN KEY (`prior_period_package_report_package_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_package`(`report_package_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ADD CONSTRAINT `fk_reporting_report_package_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ADD CONSTRAINT `fk_reporting_report_package_prior_period_report_package_id` FOREIGN KEY (`prior_period_report_package_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_package`(`report_package_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ADD CONSTRAINT `fk_reporting_report_distribution_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ADD CONSTRAINT `fk_reporting_report_distribution_report_recipient_id` FOREIGN KEY (`report_recipient_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_recipient`(`report_recipient_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ADD CONSTRAINT `fk_reporting_report_distribution_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ADD CONSTRAINT `fk_reporting_report_distribution_redistribution_report_distribution_id` FOREIGN KEY (`redistribution_report_distribution_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_distribution`(`report_distribution_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ADD CONSTRAINT `fk_reporting_report_recipient_delegate_report_recipient_id` FOREIGN KEY (`delegate_report_recipient_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_recipient`(`report_recipient_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ADD CONSTRAINT `fk_reporting_gaap_report_config_superseded_gaap_report_config_id` FOREIGN KEY (`superseded_gaap_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`gaap_report_config`(`gaap_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ADD CONSTRAINT `fk_reporting_ifrs17_report_config_parent_config_ifrs17_report_config_id` FOREIGN KEY (`parent_config_ifrs17_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`ifrs17_report_config`(`ifrs17_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ADD CONSTRAINT `fk_reporting_ifrs17_report_config_superseded_ifrs17_report_config_id` FOREIGN KEY (`superseded_ifrs17_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`ifrs17_report_config`(`ifrs17_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ADD CONSTRAINT `fk_reporting_statutory_exhibit_superseded_statutory_exhibit_id` FOREIGN KEY (`superseded_statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_statutory_exhibit_id` FOREIGN KEY (`statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ADD CONSTRAINT `fk_reporting_report_line_definition_parent_report_line_definition_id` FOREIGN KEY (`parent_report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ADD CONSTRAINT `fk_reporting_management_report_config_superseded_management_report_config_id` FOREIGN KEY (`superseded_management_report_config_id`) REFERENCES `life_insurance_ecm`.`reporting`.`management_report_config`(`management_report_config_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ADD CONSTRAINT `fk_reporting_report_period_parent_period_report_period_id` FOREIGN KEY (`parent_period_report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ADD CONSTRAINT `fk_reporting_report_period_primary_prior_period_report_period_id` FOREIGN KEY (`primary_prior_period_report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ADD CONSTRAINT `fk_reporting_report_period_prior_report_period_id` FOREIGN KEY (`prior_report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_primary_predecessor_approval_report_approval_id` FOREIGN KEY (`primary_predecessor_approval_report_approval_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_approval`(`report_approval_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_report_run_id` FOREIGN KEY (`report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ADD CONSTRAINT `fk_reporting_report_approval_prior_report_approval_id` FOREIGN KEY (`prior_report_approval_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_approval`(`report_approval_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_report_line_definition_id` FOREIGN KEY (`report_line_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_line_definition`(`report_line_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_report_run_id` FOREIGN KEY (`report_run_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_run`(`report_run_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ADD CONSTRAINT `fk_reporting_report_exception_related_report_exception_id` FOREIGN KEY (`related_report_exception_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_exception`(`report_exception_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_prior_filing_rbc_filing_id` FOREIGN KEY (`prior_filing_rbc_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`rbc_filing`(`rbc_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ADD CONSTRAINT `fk_reporting_rbc_filing_amended_rbc_filing_id` FOREIGN KEY (`amended_rbc_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`rbc_filing`(`rbc_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_prior_period_reconciliation_report_reconciliation_id` FOREIGN KEY (`prior_period_reconciliation_report_reconciliation_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_reconciliation`(`report_reconciliation_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ADD CONSTRAINT `fk_reporting_report_reconciliation_prior_period_report_reconciliation_id` FOREIGN KEY (`prior_period_report_reconciliation_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_reconciliation`(`report_reconciliation_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ADD CONSTRAINT `fk_reporting_report_control_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ADD CONSTRAINT `fk_reporting_report_control_compensating_report_control_id` FOREIGN KEY (`compensating_report_control_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_control`(`report_control_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ADD CONSTRAINT `fk_reporting_close_calendar_dependency_close_calendar_id` FOREIGN KEY (`dependency_close_calendar_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_calendar`(`close_calendar_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ADD CONSTRAINT `fk_reporting_close_calendar_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_period`(`report_period_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ADD CONSTRAINT `fk_reporting_close_calendar_prior_period_close_calendar_id` FOREIGN KEY (`prior_period_close_calendar_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_calendar`(`close_calendar_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_blocking_dependency_task_id` FOREIGN KEY (`blocking_dependency_task_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_task`(`close_task_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_close_calendar_id` FOREIGN KEY (`close_calendar_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_calendar`(`close_calendar_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_report_schedule_id` FOREIGN KEY (`report_schedule_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ADD CONSTRAINT `fk_reporting_close_task_predecessor_close_task_id` FOREIGN KEY (`predecessor_close_task_id`) REFERENCES `life_insurance_ecm`.`reporting`.`close_task`(`close_task_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ADD CONSTRAINT `fk_reporting_segment_definition_parent_segment_definition_id` FOREIGN KEY (`parent_segment_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ADD CONSTRAINT `fk_reporting_segment_definition_primary_predecessor_segment_definition_id` FOREIGN KEY (`primary_predecessor_segment_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ADD CONSTRAINT `fk_reporting_report_access_policy_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_definition`(`report_definition_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ADD CONSTRAINT `fk_reporting_report_access_policy_superseded_report_access_policy_id` FOREIGN KEY (`superseded_report_access_policy_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_access_policy`(`report_access_policy_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ADD CONSTRAINT `fk_reporting_filing_content_statutory_exhibit_id` FOREIGN KEY (`statutory_exhibit_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_exhibit`(`statutory_exhibit_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ADD CONSTRAINT `fk_reporting_filing_content_statutory_filing_id` FOREIGN KEY (`statutory_filing_id`) REFERENCES `life_insurance_ecm`.`reporting`.`statutory_filing`(`statutory_filing_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ADD CONSTRAINT `fk_reporting_package_content_report_package_id` FOREIGN KEY (`report_package_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_package`(`report_package_id`);
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ADD CONSTRAINT `fk_reporting_package_content_report_version_id` FOREIGN KEY (`report_version_id`) REFERENCES `life_insurance_ecm`.`reporting`.`report_version`(`report_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`reporting` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `life_insurance_ecm`.`reporting` SET TAGS ('dbx_domain' = 'reporting');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `gaap_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Gaap Report Config Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `ifrs17_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Ifrs17 Report Config Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `predecessor_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `production_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Production Activity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `parent_report_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|deprecated|archived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `data_quality_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Threshold (Percentage)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `estimated_generation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Generation Time (Minutes)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `filing_deadline_rule` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Rule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daily|ad_hoc');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `generation_schedule_cron` SET TAGS ('dbx_business_glossary_term' = 'Generation Schedule (Cron Expression)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `last_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Generated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `legal_entity_scope` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `legal_entity_scope` SET TAGS ('dbx_value_regex' = 'single_entity|consolidated|segment|all_entities');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `next_scheduled_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Generation Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Report Complexity Score');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_output_format` SET TAGS ('dbx_business_glossary_term' = 'Report Output Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Template Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|regulatory|internal');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_definition` ALTER COLUMN `xbrl_taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'eXtensible Business Reporting Language (XBRL) Taxonomy Version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Role Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Owner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `superseded_report_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `blackout_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `blackout_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `execution_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Execution Window End Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `execution_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Execution Window Start Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `frequency_cadence` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cadence');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `frequency_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `ifrs17_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `last_successful_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `ldti_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `naic_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `next_scheduled_run_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Run Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `regulatory_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Deadline');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `report_template_version` SET TAGS ('dbx_business_glossary_term' = 'Report Template Version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `reporting_period_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Offset Days');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'calendar|fiscal|policy_year|contract_year');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `retry_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Retry Count Limit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|retired|pending');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|regulatory|internal');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_schedule` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_run_id` SET TAGS ('dbx_business_glossary_term' = 'Report Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `parent_run_report_run_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Report Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Report Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `rerun_report_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `approval_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Report Archive Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Report Run Comments');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `data_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Data As-Of Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Report Run Error Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Report Run Error Message');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Deadline Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report Output File Path');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `output_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Report Output File Size in Bytes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `output_format` SET TAGS ('dbx_business_glossary_term' = 'Report Output Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `output_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|csv|xml|json|html');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Report Run Priority Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Report Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|variance_detected|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Report Record Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `regulatory_filing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|regulatory|internal');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Report Run Retry Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Run Completion Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Report Run Duration in Seconds');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Report Run Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Run Start Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Report Run Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|failed|cancelled|suspended');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Report Trigger Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'scheduled|manual|regulatory_demand|ad_hoc|system_event|exception');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Report Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `superseded_version_report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `prior_report_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_business_glossary_term' = 'Accounting Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `accounting_basis` SET TAGS ('dbx_value_regex' = 'SAP|GAAP|IFRS17|management|tax');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `approver_title` SET TAGS ('dbx_business_glossary_term' = 'Approver Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `data_extraction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|recalled|archived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `filing_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email|fax');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_value_regex' = 'material|immaterial|not_applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_checksum` SET TAGS ('dbx_business_glossary_term' = 'Report Output Checksum');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_file_format` SET TAGS ('dbx_business_glossary_term' = 'Report Output File Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_file_format` SET TAGS ('dbx_value_regex' = 'PDF|XLSX|XML|HTML|CSV|JSON');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report Output File Path');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `report_output_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Report Output File Size in Bytes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `restatement_category` SET TAGS ('dbx_business_glossary_term' = 'Restatement Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `restatement_category` SET TAGS ('dbx_value_regex' = 'error_correction|change_in_estimate|change_in_principle|reclassification|other');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `reviewer_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `validation_error_details` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Details');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `version_date` SET TAGS ('dbx_business_glossary_term' = 'Version Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `version_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|restated|corrected');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_template_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `prior_filing_statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Filing Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `rbc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Rbc Calculation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `amended_statutory_filing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `actuarial_opinion_attached` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion Attached');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `audit_opinion_attached` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Attached');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `certifying_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Officer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `certifying_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `certifying_officer_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Officer Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_format` SET TAGS ('dbx_business_glossary_term' = 'Filing Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|excel|paper');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|withdrawn');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Filing');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Contact Email');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Contact Phone');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'isite_plus|paper|electronic_portal|email');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `total_pages` SET TAGS ('dbx_business_glossary_term' = 'Total Pages');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `filing_template_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `superseded_by_template_filing_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `superseded_filing_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `due_date_rule` SET TAGS ('dbx_business_glossary_term' = 'Due Date Rule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `filing_category` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|rbc|state_specific|federal');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semi_annual|ad_hoc');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `instructions_url` SET TAGS ('dbx_business_glossary_term' = 'Instructions Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `late_filing_penalty` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Penalty');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Filing Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `schedule_identifier` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|ftp|api|mail');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_file_path` SET TAGS ('dbx_business_glossary_term' = 'Template File Path');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_format` SET TAGS ('dbx_business_glossary_term' = 'Template Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_format` SET TAGS ('dbx_value_regex' = 'xbrl|xml|pdf|excel|csv|json');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_owner` SET TAGS ('dbx_business_glossary_term' = 'Template Owner');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|retired|superseded');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'annual_statement|quarterly_statement|schedule|exhibit|rbc_report|supplemental');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `template_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `validation_rules_url` SET TAGS ('dbx_business_glossary_term' = 'Validation Rules Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_template` ALTER COLUMN `xbrl_taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'eXtensible Business Reporting Language (XBRL) Taxonomy Version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `report_package_id` SET TAGS ('dbx_business_glossary_term' = 'Report Package Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Report Package Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `prior_period_package_report_package_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Report Package Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `prior_period_report_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `actual_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Filing Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `certified_by` SET TAGS ('dbx_business_glossary_term' = 'Certified By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `certified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `constituent_report_count` SET TAGS ('dbx_business_glossary_term' = 'Constituent Report Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `data_as_of_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data As-Of Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `filing_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'ELECTRONIC|PAPER|PORTAL|EMAIL|HYBRID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Report Package Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Report Package Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Report Package Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_notes` SET TAGS ('dbx_business_glossary_term' = 'Report Package Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Report Package Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Report Package Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `package_version` SET TAGS ('dbx_business_glossary_term' = 'Report Package Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'STATUTORY|GAAP|IFRS17|MANAGEMENT|REGULATORY');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_package` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed By User ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'Report Recipient Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Report Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `redistribution_report_distribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `access_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `delivery_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|acknowledged|bounced|pending');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `digital_signature_applied_indicator` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Applied Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'email|portal|sftp|print|regulatory_submission|api');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cost Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cost Currency Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_format` SET TAGS ('dbx_business_glossary_term' = 'Distribution Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|xml|html|csv|printed');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_priority` SET TAGS ('dbx_business_glossary_term' = 'Distribution Priority');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `distribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `encryption_applied_indicator` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `recipient_access_count` SET TAGS ('dbx_business_glossary_term' = 'Recipient Access Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `regulatory_filing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `scheduled_distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Distribution Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_distribution` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `report_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'Report Recipient Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `delegate_report_recipient_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'full|summary|restricted|confidential');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `confidentiality_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `confidentiality_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_value_regex' = 'on_demand|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|secure_portal|physical_mail|sftp|api');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `last_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'internal_stakeholder|external_regulator|external_auditor|reinsurer|board_member|rating_agency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `report_format_preference` SET TAGS ('dbx_business_glossary_term' = 'Report Format Preference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `report_format_preference` SET TAGS ('dbx_value_regex' = 'pdf|excel|csv|xml|json|html');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_recipient` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `gaap_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Report Configuration ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `superseded_gaap_report_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `applicable_asc_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Accounting Standards Codification (ASC) Standards');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `claim_liability_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Liability Estimation Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `claim_liability_estimation_method` SET TAGS ('dbx_value_regex' = 'case_reserves|ibnr|actuarial_estimate|paid_plus_case');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_value_regex' = 'legal_entity|consolidated_group|segment|division');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Amortization Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|interest_method|benefit_ratio|constant_level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `derivative_accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Derivative Accounting Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `derivative_accounting_method` SET TAGS ('dbx_value_regex' = 'hedge_accounting|fair_value_through_earnings|not_applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `discount_rate_methodology` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Methodology');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `discount_rate_methodology` SET TAGS ('dbx_value_regex' = 'upper_medium_grade|risk_free|locked_in|current');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `fair_value_hierarchy_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Disclosure Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `foreign_exchange_translation_method` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Translation Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `foreign_exchange_translation_method` SET TAGS ('dbx_value_regex' = 'current_rate|temporal|not_applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `gaap_report_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `gaap_report_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|superseded');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `gaap_sap_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) to Statutory Accounting Principles (SAP) Reconciliation Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `investment_valuation_basis` SET TAGS ('dbx_business_glossary_term' = 'Investment Valuation Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `investment_valuation_basis` SET TAGS ('dbx_value_regex' = 'fair_value|amortized_cost|equity_method|cost');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `ldti_cohort_grouping_basis` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Cohort Grouping Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `ldti_cohort_grouping_basis` SET TAGS ('dbx_value_regex' = 'issue_year|issue_quarter|product_line|contract_type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `ldti_effective_flag` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Effective Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `market_risk_benefit_accounting_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Benefit (MRB) Accounting Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Presentation Currency Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `presentation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reinsurance_accounting_treatment` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Accounting Treatment');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reinsurance_accounting_treatment` SET TAGS ('dbx_value_regex' = 'deposit_method|risk_transfer|proportional|non_proportional');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reinsurance_accounting_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reinsurance_accounting_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semi-annual');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'gaap|ldti|pre_ldti|statutory');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'premium_received|earned_premium|deposit_method|investment_contract');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `segment_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `separate_account_treatment` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Treatment');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `separate_account_treatment` SET TAGS ('dbx_value_regex' = 'on_balance_sheet|off_balance_sheet|hybrid');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `separate_account_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `separate_account_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`gaap_report_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `ifrs17_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'IFRS 17 Report Configuration ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `parent_config_ifrs17_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Configuration ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `superseded_ifrs17_report_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `acquisition_cash_flow_allocation` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cash Flow Allocation');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `acquisition_cash_flow_allocation` SET TAGS ('dbx_value_regex' = 'portfolio_level|contract_group_level|individual_contract_level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `cohort_granularity` SET TAGS ('dbx_business_glossary_term' = 'Cohort Granularity');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `cohort_granularity` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|product_line');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|archived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `contract_boundary_definition` SET TAGS ('dbx_business_glossary_term' = 'Contract Boundary Definition');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `coverage_unit_definition` SET TAGS ('dbx_business_glossary_term' = 'Coverage Unit Definition');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `csm_amortization_basis` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Amortization Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `csm_amortization_basis` SET TAGS ('dbx_value_regex' = 'coverage_units|time_based|sum_assured|premium_based');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `discount_rate_curve_selection` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Curve Selection');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `experience_adjustment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Experience Adjustment Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `experience_adjustment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `investment_component_separation_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Component Separation Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `loss_component_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Tracking Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `measurement_model` SET TAGS ('dbx_business_glossary_term' = 'Measurement Model');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `measurement_model` SET TAGS ('dbx_value_regex' = 'GMM|PAA|VFA');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `oci_election` SET TAGS ('dbx_business_glossary_term' = 'Other Comprehensive Income (OCI) Election');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `oci_election` SET TAGS ('dbx_value_regex' = 'profit_or_loss|other_comprehensive_income');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `onerous_contract_threshold` SET TAGS ('dbx_business_glossary_term' = 'Onerous Contract Threshold');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `paa_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Premium Allocation Approach (PAA) Eligibility Criteria');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reinsurance_held_treatment` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Held Treatment');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reinsurance_held_treatment` SET TAGS ('dbx_value_regex' = 'proportionate_coverage|risk_mitigation|separate_measurement');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reinsurance_held_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reinsurance_held_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `risk_adjustment_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Confidence Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `risk_adjustment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Methodology');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `risk_adjustment_methodology` SET TAGS ('dbx_value_regex' = 'confidence_level|cost_of_capital|margin_over_best_estimate');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `transition_approach` SET TAGS ('dbx_business_glossary_term' = 'Transition Approach');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `transition_approach` SET TAGS ('dbx_value_regex' = 'full_retrospective|modified_retrospective|fair_value');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`ifrs17_report_config` ALTER COLUMN `vfa_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Variable Fee Approach (VFA) Eligibility Criteria');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Exhibit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pbr Model Segment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `superseded_statutory_exhibit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Years');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `data_source_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Source Domain');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_code` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Complexity Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_complexity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_instructions` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Instructions');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_name` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_owner` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Owner');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_section` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Section');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_status` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_status` SET TAGS ('dbx_value_regex' = 'active|superseded|deprecated|pending');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_type` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `exhibit_type` SET TAGS ('dbx_value_regex' = 'exhibit|schedule|supplemental');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|semi_annual|monthly');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `gaap_reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reconciliation Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `lob_scope` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Filing Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `naic_version` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `naic_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `pbr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `related_schedules` SET TAGS ('dbx_business_glossary_term' = 'Related Schedules');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `sap_basis_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Basis Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`statutory_exhibit` ALTER COLUMN `xbrl_taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Extensible Business Reporting Language (XBRL) Taxonomy Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `account_value_id` SET TAGS ('dbx_business_glossary_term' = 'Account Value Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `separate_account_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Sep Account Fund Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Exhibit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `parent_report_line_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `calculation_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Calculation Logic Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Line Data Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'monetary|percentage|count|text|date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `footnote_reference` SET TAGS ('dbx_business_glossary_term' = 'Footnote Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `is_calculated` SET TAGS ('dbx_business_glossary_term' = 'Is Calculated Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `is_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Is Subtotal Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `is_total` SET TAGS ('dbx_business_glossary_term' = 'Is Total Indicator');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_category` SET TAGS ('dbx_business_glossary_term' = 'Report Line Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_category` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense|disclosure');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Report Line Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Report Line Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Report Line Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}(.[0-9]{1,3})?$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_short_name` SET TAGS ('dbx_business_glossary_term' = 'Report Line Short Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `line_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Report Line Subcategory');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Definition Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `parent_line_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_line_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Line Definition Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_line_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|pending_approval');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|regulatory');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'none|thousands|millions|nearest_dollar|two_decimals');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `sign_convention` SET TAGS ('dbx_business_glossary_term' = 'Sign Convention');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `sign_convention` SET TAGS ('dbx_value_regex' = 'positive|negative|absolute');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `source_domain` SET TAGS ('dbx_business_glossary_term' = 'Source Data Domain');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `source_field_mapping` SET TAGS ('dbx_business_glossary_term' = 'Source Field Mapping');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_line_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `management_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Management Report Configuration ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `superseded_management_report_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `comparison_basis` SET TAGS ('dbx_business_glossary_term' = 'Comparison Basis');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `comparison_basis` SET TAGS ('dbx_value_regex' = 'budget|prior_period|plan|forecast|none');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `dashboard_integration` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Integration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `data_refresh_schedule` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Schedule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `drill_down_enabled` SET TAGS ('dbx_business_glossary_term' = 'Drill Down Enabled');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `kpi_definitions_included` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definitions Included');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `last_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Generated Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `management_report_config_status` SET TAGS ('dbx_business_glossary_term' = 'Report Configuration Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `management_report_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|archived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `next_scheduled_run` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Run');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_category` SET TAGS ('dbx_business_glossary_term' = 'Report Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_category` SET TAGS ('dbx_value_regex' = 'financial|operational|strategic|risk|compliance|performance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|powerpoint|html|csv|tableau');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Email');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_template_path` SET TAGS ('dbx_business_glossary_term' = 'Report Template Path');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Management Report Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'board|executive|lob|departmental|alm|profitability');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `reporting_hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Hierarchy Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `reporting_hierarchy_type` SET TAGS ('dbx_value_regex' = 'legal_entity|product_line|distribution_channel|cost_center|geographic|organizational');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Months');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`management_report_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `parent_period_report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Period Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `primary_prior_period_report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `prior_report_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `actuarial_opinion_required` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion Required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `business_days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Business Days in Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `calendar_days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Calendar Days in Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `gaap_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Reporting Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `ifrs17_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) 17 Reporting Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `is_month_end` SET TAGS ('dbx_business_glossary_term' = 'Is Month End Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `is_quarter_end` SET TAGS ('dbx_business_glossary_term' = 'Is Quarter End Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `is_year_end` SET TAGS ('dbx_business_glossary_term' = 'Is Year End Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `naic_statement_type` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Statement Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `naic_statement_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_close_date` SET TAGS ('dbx_business_glossary_term' = 'Period Close Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|archived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semi_annual|ytd|inception_to_date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|[ENUM-REF-CANDIDATE: statutory|gaap|ifrs17|management|solvency_ii|pbr|ldti|sap — promote to reference product]');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `sarbanes_oxley_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Required');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_period` ALTER COLUMN `statutory_filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `report_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `primary_predecessor_approval_report_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Approval Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `report_run_id` SET TAGS ('dbx_business_glossary_term' = 'Report Instance Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Report Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `prior_report_approval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_action` SET TAGS ('dbx_value_regex' = 'approved|rejected|returned_for_revision|conditionally_approved|withdrawn');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_due_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Approval Duration in Hours');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_method` SET TAGS ('dbx_business_glossary_term' = 'Approval Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_method` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|email_workflow|api|manual_entry');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|expired');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `approver_title` SET TAGS ('dbx_business_glossary_term' = 'Approver Job Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `delegated_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegated Approval Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `delegated_from_name` SET TAGS ('dbx_business_glossary_term' = 'Delegated From Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `delegated_from_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `delegation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `delegation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `digital_signature_method` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `digital_signature_method` SET TAGS ('dbx_value_regex' = 'pki_certificate|biometric|sso_authentication|hardware_token|other');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date and Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date and Time');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_approval` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `report_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Report Exception Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `account_value_id` SET TAGS ('dbx_business_glossary_term' = 'Account Value Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `report_run_id` SET TAGS ('dbx_business_glossary_term' = 'Report Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `related_report_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `affected_legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Affected Legal Entity');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `affected_line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Affected Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `affected_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Affected Reporting Period');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_to_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_to_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_to_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_validation|reconciliation_process|manual_review|system_alert');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_value_regex' = 'source_data|transformation|reconciliation|validation|calculation|output');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|waived');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'data_gap|reconciliation_break|threshold_breach|missing_source_data|validation_failure|calculation_error');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `impact_on_filing` SET TAGS ('dbx_business_glossary_term' = 'Impact on Filing');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `impact_on_filing` SET TAGS ('dbx_value_regex' = 'blocks_filing|requires_disclosure|informational_only|no_impact');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'data_correction|source_system_fix|manual_adjustment|waiver_approved|process_improvement');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolution_due_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolved_by_email` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolved_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolved_by_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolved_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `resolved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `source_record_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `source_table` SET TAGS ('dbx_business_glossary_term' = 'Source Table');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `sox_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breached');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `waiver_approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `waiver_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_exception` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `rbc_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Filing ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `prior_filing_rbc_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Filing ID');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `rbc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Rbc Calculation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `amended_rbc_filing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `action_level_category` SET TAGS ('dbx_business_glossary_term' = 'Action Level Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `action_level_category` SET TAGS ('dbx_value_regex' = 'no_action|company_action|regulatory_action|authorized_control|mandatory_control');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|withdrawn');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'original|amended|corrected|supplemental');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `operational_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Charge');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `regulatory_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `state_of_domicile` SET TAGS ('dbx_business_glossary_term' = 'State of Domicile');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `state_of_domicile` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|xml|xbrl');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `trend_test_result` SET TAGS ('dbx_business_glossary_term' = 'Trend Test Result');
ALTER TABLE `life_insurance_ecm`.`reporting`.`rbc_filing` ALTER COLUMN `trend_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `report_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Report Reconciliation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `prior_period_reconciliation_report_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Reconciliation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Source Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `prior_period_report_reconciliation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `external_auditor_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_description` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Draft|In_Review|Approved|Rejected|Pending_Sign_Off|Completed');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'GAAP_to_SAP|IFRS17_to_GAAP|Management_to_Statutory|Inter_Entity_Elimination|SAP_to_Tax|GAAP_to_IFRS17');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reconciling_item_count` SET TAGS ('dbx_business_glossary_term' = 'Reconciling Item Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'Not_Signed_Off|Preparer_Signed|Reviewer_Signed|Fully_Signed_Off');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `source_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Source Balance Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `source_framework` SET TAGS ('dbx_business_glossary_term' = 'Source Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `source_framework` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|Management|Tax');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `target_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Balance Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `target_framework` SET TAGS ('dbx_business_glossary_term' = 'Target Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `target_framework` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|Management|Tax');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `total_reconciling_items_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reconciling Items Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `variance_tolerance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance Threshold');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_reconciliation` ALTER COLUMN `variance_within_tolerance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Within Tolerance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `report_control_id` SET TAGS ('dbx_business_glossary_term' = 'Report Control Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `compensating_report_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `compensating_control_description` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Reference');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|on-demand');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'manual|automated|semi-automated');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Department');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under-review');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Identified Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Severity');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_value_regex' = 'material-weakness|significant-deficiency|control-deficiency|none');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_type` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `deficiency_type` SET TAGS ('dbx_value_regex' = 'design-deficiency|operating-deficiency|both|none');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assertion');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_value_regex' = 'existence|completeness|accuracy|valuation|rights-and-obligations|presentation-and-disclosure');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `last_test_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Test Performed By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Test Result');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `last_test_result` SET TAGS ('dbx_value_regex' = 'effective|deficient|material-weakness|significant-deficiency|not-tested');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `next_scheduled_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Test Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|validated|not-applicable');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `remediation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Target Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annually|annually|on-demand');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_business_glossary_term' = 'Testing Method');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_control` ALTER COLUMN `testing_method` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance|walkthrough');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `dependency_close_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Close Calendar Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `prior_period_close_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `actuarial_opinion_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion Attached Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `audit_opinion_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Attached Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `certifying_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Officer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Close Cycle Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Close Cycle Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_frequency` SET TAGS ('dbx_business_glossary_term' = 'Close Frequency');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `close_phase` SET TAGS ('dbx_business_glossary_term' = 'Close Phase');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `ifrs17_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 17 (IFRS 17) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `ldti_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `legal_entity_scope` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `overall_close_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Close Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `overall_close_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Complete|Delayed|Failed|Cancelled');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `pbr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Actual Completion Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_due_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Phase Owner Department');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Phase Owner Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_start_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Complete|Delayed|Blocked|On Hold');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `predecessor_phase` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Phase');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'SAP|GAAP|IFRS17|Management|Regulatory|Tax');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_calendar` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `close_task_id` SET TAGS ('dbx_business_glossary_term' = 'Close Task Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `blocking_dependency_task_id` SET TAGS ('dbx_business_glossary_term' = 'Blocking Dependency Task Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `close_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Close Calendar Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `predecessor_close_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'no_dependencies|dependencies_met|waiting_on_dependencies|dependency_failed');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Path');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `evidence_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_instructions` SET TAGS ('dbx_business_glossary_term' = 'Task Instructions');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|overdue|blocked|cancelled');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`close_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'journal_entry|reconciliation|actuarial_upload|data_validation|report_sign_off|filing_submission');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` SET TAGS ('dbx_subdomain' = 'framework_configuration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `parent_segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `primary_predecessor_segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Segment Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `aggregation_rule` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Rule');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `data_mart_source` SET TAGS ('dbx_business_glossary_term' = 'Data Mart Source');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `distribution_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `gaap_product_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Product Classification');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `gaap_product_classification` SET TAGS ('dbx_value_regex' = 'traditional_long_duration|limited_payment|universal_life|investment_contract|short_duration');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `ifrs17_contract_group_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Contract Group Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `ifrs17_onerous_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Onerous Contract Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `line_of_business_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `pbr_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Applicability Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `reinsurance_treaty_scope` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|management|regulatory');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Email Address');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|retired');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'line_of_business|legal_entity|product_group|distribution_channel|geographic|ifrs17_contract_group');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `statutory_line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Line of Business');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`segment_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `report_access_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Report Access Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `primary_report_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `tertiary_report_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `superseded_report_access_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `access_count` SET TAGS ('dbx_business_glossary_term' = 'Access Count');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `access_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `access_role` SET TAGS ('dbx_business_glossary_term' = 'Access Role');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `authorized_party_type` SET TAGS ('dbx_business_glossary_term' = 'Authorized Party Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `authorized_party_type` SET TAGS ('dbx_value_regex' = 'internal_employee|internal_contractor|external_regulator|external_auditor|external_reinsurer|board_member');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `confidentiality_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `confidentiality_agreement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Required Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiry Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `last_access_date` SET TAGS ('dbx_business_glossary_term' = 'Last Access Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `legal_entity_scope` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Scope');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Access Policy Code');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Access Policy Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Access Policy Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_approval');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Access Policy Type');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'view|prepare|approve|distribute|certify|audit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`report_access_policy` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` SET TAGS ('dbx_association_edges' = 'reporting.statutory_filing,reporting.statutory_exhibit');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `filing_content_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Content Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Content - Statutory Exhibit Id');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Content - Statutory Filing Id');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Completion Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `data_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Data As-Of Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `exhibit_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Sequence Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Starting Page Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Preparer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`reporting`.`filing_content` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` SET TAGS ('dbx_subdomain' = 'report_production');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` SET TAGS ('dbx_association_edges' = 'reporting.report_package,reporting.report_version');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `package_content_id` SET TAGS ('dbx_business_glossary_term' = 'Package Content Identifier');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `report_package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Content - Report Package Id');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `report_version_id` SET TAGS ('dbx_business_glossary_term' = 'Package Content - Report Version Id');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `content_notes` SET TAGS ('dbx_business_glossary_term' = 'Content Notes');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `included_by` SET TAGS ('dbx_business_glossary_term' = 'Included By');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Reason');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `inclusion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Timestamp');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Content Flag');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `page_range` SET TAGS ('dbx_business_glossary_term' = 'Page Range');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `section_title` SET TAGS ('dbx_business_glossary_term' = 'Section Title');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Content Sequence Number');
ALTER TABLE `life_insurance_ecm`.`reporting`.`package_content` ALTER COLUMN `version_role` SET TAGS ('dbx_business_glossary_term' = 'Version Role in Package');
