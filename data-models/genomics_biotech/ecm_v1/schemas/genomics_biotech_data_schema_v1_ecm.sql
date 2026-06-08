-- Schema for Domain: data | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`data` COMMENT 'Governs enterprise data management including data catalogs, data quality rules, master data governance policies, data sharing agreements, genomic data access controls, and FAIR (Findable, Accessible, Interoperable, Reusable) compliance for genomic datasets';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`quality_rule` (
    `quality_rule_id` BIGINT COMMENT 'Unique identifier for the data quality rule. Primary key for the quality rule catalog.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Quality rules target specific instruments for automated validation (e.g., Q30 thresholds for NovaSeq 6000). Enables instrument-specific QC rule execution in LIMS workflows. Genomics labs routinely con',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Quality rules monitor reagent specifications (concentration, purity, sterility) for automated QC. Real business need: continuous quality monitoring of reagent products per GMP requirements.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Product specifications define quality acceptance criteria that become automated quality rules. NGS sequencers require Q30 score rules, arrays need probe intensity thresholds. Quality validation protoc',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Quality rules validating transcript annotations, exon boundary integrity, or coding sequence completeness must specify annotation release version (GENCODE v38 vs v42 have different transcript sets); c',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Quality rules validating genomic coordinates, variant positions, or alignment metrics must specify reference genome build (GRCh38 vs GRCh37) to ensure correct validation logic; critical for variant ca',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Quality rules validate data compliance with metadata schemas and standards. Many quality_rules can validate one metadata_schema. This FK links the quality rule to the metadata schema it validates, ens',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level quality rules enforce lot-specific performance criteria. Flow cell lots must meet cluster density thresholds, reagent lots require purity specs. Manufacturing QC, lot release testing, and ce',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Software releases include embedded quality rules. Variant callers have built-in quality filters (QUAL>30, DP>10), alignment software has mapping quality thresholds. Release notes document rule changes',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Product specifications define acceptance criteria that become automated quality rules. Spec says read length ≥150bp, quality rule enforces it. Spec defines LOD ≤10 copies/mL, rule validates it. Design',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Quality rules checking variant clinical significance or population frequency thresholds must lock to specific ClinVar/gnomAD versions; monthly ClinVar releases reclassify variants, so rules must versi',
    `parent_quality_rule_id` BIGINT COMMENT 'Self-referencing FK on quality_rule (parent_quality_rule_id)',
    `alert_threshold_breach_count` STRING COMMENT 'Number of consecutive executions where this rule failed to meet its threshold. Used to trigger escalation workflows after sustained violations.',
    `business_impact` STRING COMMENT 'Description of downstream business consequences if this rule is violated (e.g., regulatory non-compliance, incorrect clinical reports, revenue leakage, patient safety risk).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rule record was first created in the catalog. Immutable audit field required for regulatory compliance.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation, Standard Operating Procedure (SOP), or knowledge base article explaining this rules business context, validation logic, and remediation procedures.. Valid values are `^https?://.*$`',
    `effective_end_date` DATE COMMENT 'Date when this rule version was retired or superseded. Null for currently active rules. Enables historical rule analysis and compliance reporting.',
    `effective_start_date` DATE COMMENT 'Date when this rule version became active and began enforcing data quality checks. Supports temporal rule management and compliance auditing.',
    `enforcement_action` STRING COMMENT 'Automated action taken when rule fails: block (halt pipeline), warn (continue with warning), quarantine (isolate bad records), log (record only), alert (notify stakeholders).. Valid values are `block|warn|quarantine|log|alert`',
    `execution_frequency` STRING COMMENT 'How often this rule is evaluated: real-time (streaming/DLT), batch at scheduled intervals, or on-demand for ad-hoc validation.. Valid values are `real_time|batch_hourly|batch_daily|batch_weekly|on_demand`',
    `execution_platform` STRING COMMENT 'Technical platform or framework used to execute this rule (e.g., Databricks Delta Live Tables, Great Expectations, AWS Deequ, custom Spark job).. Valid values are `databricks_dlt|databricks_job|great_expectations|deequ|custom_spark`',
    `fair_principle` STRING COMMENT 'Which FAIR data principle this rule supports for genomic datasets: Findable (metadata completeness), Accessible (access control validation), Interoperable (format/standard compliance), Reusable (provenance/license checks).. Valid values are `findable|accessible|interoperable|reusable`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this rule is currently active and being enforced in data pipelines. False for deprecated or temporarily disabled rules.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this rule is automatically enforced by data pipelines (true) or requires manual validation (false).',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this rule. Used to monitor rule execution health and identify stale validations.',
    `last_failure_count` BIGINT COMMENT 'Number of records that failed validation in the most recent rule execution. Used for impact assessment and prioritization.',
    `last_pass_rate` DECIMAL(18,2) COMMENT 'Pass rate (0.0000 to 1.0000) from the most recent rule execution. Represents the proportion of records that satisfied the rule. Used for trend analysis and alerting.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this rule record. Updated on every change to support audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this rule record. Updated on every change to support audit trail and change tracking.',
    `regulatory_requirement` STRING COMMENT 'Citation of specific regulatory requirement, compliance framework, or industry standard this rule supports (e.g., FDA 21 CFR Part 11, CLIA, CAP, GDPR Article 5, HIPAA Security Rule).',
    `remediation_guidance` STRING COMMENT 'Step-by-step instructions for data stewards or engineers to investigate and remediate rule violations. May include links to Standard Operating Procedures (SOPs) or runbooks.',
    `rule_category` STRING COMMENT 'Business domain category this rule applies to, enabling domain-specific rule management and governance workflows.. Valid values are `genomic|clinical|operational|regulatory|master_data|transactional`',
    `rule_code` STRING COMMENT 'Standardized unique code identifier for the rule following pattern DQR-{DOMAIN}-{NUMBER}, enabling cross-system reference and traceability.. Valid values are `^DQR-[A-Z]{3}-[0-9]{4}$`',
    `rule_description` STRING COMMENT 'Detailed business description of what the rule validates, why it matters, and the expected data behavior. Should be understandable by non-technical stakeholders.',
    `rule_expression` STRING COMMENT 'The executable logic or SQL expression that defines the rule validation. May contain Spark SQL syntax, Python validation logic, or declarative constraint definition.',
    `rule_name` STRING COMMENT 'Human-readable name of the data quality rule. Should be descriptive and follow organizational naming conventions.',
    `rule_owner` STRING COMMENT 'Name or identifier of the business data steward or domain owner accountable for defining and maintaining this rule.',
    `rule_steward_email` STRING COMMENT 'Email contact for the data steward responsible for this rule. Used for automated alerts and remediation workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `rule_type` STRING COMMENT 'Category of data quality dimension this rule enforces: completeness (non-null checks), uniqueness (duplicate detection), validity (format/range checks), consistency (cross-field logic), timeliness (freshness checks), or referential integrity (FK validation).. Valid values are `completeness|uniqueness|validity|consistency|timeliness|referential_integrity`',
    `rule_version` STRING COMMENT 'Semantic version number of the rule logic (format: vMAJOR.MINOR.PATCH). Incremented when rule expression or thresholds change, enabling audit trail and rollback.. Valid values are `^v[0-9]+.[0-9]+.[0-9]+$`',
    `severity_level` STRING COMMENT 'Impact severity of rule violations: critical (blocks pipeline/report release), major (requires immediate remediation), minor (tracked for improvement), warning (informational only).. Valid values are `critical|major|minor|warning`',
    `tags` STRING COMMENT 'Comma-separated list of custom tags for rule categorization, search, and filtering (e.g., genomic,NGS,FASTQ, clinical,IVD,FDA, PII,GDPR). Supports flexible rule discovery and governance workflows.',
    `target_asset_name` STRING COMMENT 'Fully qualified name of the target data asset (table, view, or dataset) this rule validates. Format: {catalog}.{schema}.{table} for Databricks Unity Catalog assets.',
    `target_column_name` STRING COMMENT 'Specific column or attribute name within the target asset that this rule validates. Null if rule applies to entire asset or multiple columns.',
    `target_domain` STRING COMMENT 'The data domain this rule applies to (e.g., Sequencing, Sample Management, Clinical Genomics, Customer). Maps to enterprise data domain taxonomy.',
    `threshold_operator` STRING COMMENT 'Comparison operator applied between actual metric and threshold value to determine rule compliance.. Valid values are `greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|not_equal`',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value (e.g., percentage for pass rates, count for record volumes, days for timeliness checks). [ENUM-REF-CANDIDATE: percentage|count|ratio|seconds|minutes|hours|days — 7 candidates stripped; promote to reference product]',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold for rule pass/fail determination. Interpretation depends on threshold_operator (e.g., pass rate >= 0.95 means 95% of records must pass).',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this rule record. Supports audit trail and accountability.',
    CONSTRAINT pk_quality_rule PRIMARY KEY(`quality_rule_id`)
) COMMENT 'Master catalog of enterprise data quality rules applied to genomic and operational datasets across all domains. Captures rule name, rule type (completeness, uniqueness, validity, consistency, timeliness, referential integrity), target asset or domain, rule expression or logic, severity level (critical/major/minor), expected threshold, remediation guidance, and active status. Supports automated DQ enforcement in Databricks pipelines and FAIR interoperability compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` (
    `quality_assessment_id` BIGINT COMMENT 'Unique identifier for the data quality assessment execution run. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Instruments undergo periodic data quality assessments for GxP compliance and qualification maintenance. Required for regulatory audits (FDA 21 CFR Part 11). Tracks instrument performance over time aga',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Quality assessments of sequencing runs, BAM/CRAM files, and variant callsets must record which reference genome was used for alignment and variant calling to enable reproducibility audits and regulato',
    `instrument_run_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_run. Business justification: Every sequencing run undergoes quality assessment (cluster density, Q30, PhiX error rate). Core operational workflow in genomics labs. Enables run-level QC reporting and pass/fail decisions for downst',
    `previous_quality_assessment_id` BIGINT COMMENT 'Self-referencing FK on quality_assessment (previous_quality_assessment_id)',
    `accuracy_score` DECIMAL(18,2) COMMENT 'Data accuracy dimension score, measuring correctness of values against reference data (0.00 to 100.00).',
    `assessed_by_system` STRING COMMENT 'Name of the system or pipeline that executed the assessment (e.g., Databricks_DQ_Pipeline, Great_Expectations, Manual_Review).',
    `assessed_by_user` STRING COMMENT 'Username or system account that executed the quality assessment (e.g., data_steward_id, automated_pipeline_service).',
    `assessment_notes` STRING COMMENT 'Free-text notes or comments about the assessment run, including context, exceptions, or manual review findings.',
    `assessment_result` STRING COMMENT 'Overall pass/fail result of the quality assessment based on threshold comparison: pass, fail, or conditional_pass.. Valid values are `pass|fail|conditional_pass`',
    `assessment_run_number` STRING COMMENT 'Business-friendly identifier for the quality assessment run, formatted as QA-YYYYMMDD-HHMMSS.. Valid values are `^QA-[0-9]{8}-[0-9]{6}$`',
    `assessment_scope` STRING COMMENT 'Scope of data evaluated: full dataset, sample subset, incremental (new records only), or targeted (specific columns/rules).. Valid values are `full|sample|incremental|targeted`',
    `assessment_status` STRING COMMENT 'Current execution status of the quality assessment run: completed, failed, in_progress, cancelled, or partial.. Valid values are `completed|failed|in_progress|cancelled|partial`',
    `assessment_type` STRING COMMENT 'Type of quality assessment execution: automated pipeline, manual review, hybrid, scheduled, or on-demand.. Valid values are `automated|manual|hybrid|scheduled|on_demand`',
    `completeness_score` DECIMAL(18,2) COMMENT 'Data completeness dimension score, measuring presence of required values (0.00 to 100.00).',
    `compliance_framework` STRING COMMENT 'Regulatory or compliance framework this assessment validates against (e.g., HIPAA, GDPR, CLIA, FDA_21_CFR_Part_11, FAIR_Principles).',
    `consistency_score` DECIMAL(18,2) COMMENT 'Data consistency dimension score, measuring uniformity across related datasets (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quality assessment record was first created in the system, in ISO 8601 format.',
    `critical_failures_count` STRING COMMENT 'Number of critical quality rule failures that require immediate remediation (e.g., PHI exposure, regulatory non-compliance).',
    `data_domain` STRING COMMENT 'Business domain to which the assessed asset belongs (e.g., Sequencing, Clinical Genomics, Sample Management).',
    `data_steward_notified_flag` BOOLEAN COMMENT 'Indicates whether the data steward was notified of assessment results (True/False).',
    `execution_duration_seconds` DECIMAL(18,2) COMMENT 'Total time taken to complete the quality assessment run, measured in seconds.',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the quality assessment run was executed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `failure_summary` STRING COMMENT 'Summary description of key quality rule failures and their business impact.',
    `fair_compliance_flag` BOOLEAN COMMENT 'Indicates whether the assessed genomic dataset meets FAIR (Findable, Accessible, Interoperable, Reusable) principles (True/False).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this quality assessment record was last modified, in ISO 8601 format.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when data steward or stakeholders were notified of assessment results, in ISO 8601 format.',
    `overall_dq_score` DECIMAL(18,2) COMMENT 'Composite data quality score for this assessment, calculated as percentage of rules passed (0.00 to 100.00).',
    `pass_fail_threshold` DECIMAL(18,2) COMMENT 'Minimum data quality score required for the assessment to be considered passing (0.00 to 100.00).',
    `phi_exposure_detected_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information exposure or non-compliance was detected during assessment (True/False).',
    `records_assessed_count` BIGINT COMMENT 'Total number of data records evaluated during this quality assessment run.',
    `records_failed_count` BIGINT COMMENT 'Number of data records that failed one or more quality rules during this assessment.',
    `remediation_actions_triggered` STRING COMMENT 'Comma-separated list of automated remediation actions triggered by this assessment (e.g., data_quarantine, alert_steward, block_pipeline).',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether data remediation actions are required based on assessment results (True/False).',
    `rule_set_name` STRING COMMENT 'Name of the data quality rule set applied during this assessment (e.g., NGS_Data_Validation, Clinical_PHI_Compliance).',
    `rule_set_version` STRING COMMENT 'Semantic version of the quality rule set applied (e.g., 1.2.3).. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `rules_failed_count` STRING COMMENT 'Number of quality rules that failed validation during this assessment.',
    `rules_passed_count` STRING COMMENT 'Number of quality rules that passed validation during this assessment.',
    `rules_warning_count` STRING COMMENT 'Number of quality rules that generated warnings (non-critical issues) during this assessment.',
    `sample_size` BIGINT COMMENT 'Number of records in the sample if assessment_scope is sample; null for full assessments.',
    `target_asset_name` STRING COMMENT 'Fully qualified name of the data asset being assessed (e.g., database.schema.table or domain.product).',
    `target_asset_type` STRING COMMENT 'Type of data asset being assessed: table, view, dataset, domain, product, or pipeline.. Valid values are `table|view|dataset|domain|product|pipeline`',
    `timeliness_score` DECIMAL(18,2) COMMENT 'Data timeliness dimension score, measuring currency and availability when needed (0.00 to 100.00).',
    `total_rules_executed` STRING COMMENT 'Total number of data quality rules executed during this assessment run.',
    `uniqueness_score` DECIMAL(18,2) COMMENT 'Data uniqueness dimension score, measuring absence of duplicate records (0.00 to 100.00).',
    `validity_score` DECIMAL(18,2) COMMENT 'Data validity dimension score, measuring conformance to defined formats and business rules (0.00 to 100.00).',
    CONSTRAINT pk_quality_assessment PRIMARY KEY(`quality_assessment_id`)
) COMMENT 'Transactional record of each data quality assessment execution run against a data asset or domain. Captures assessment run ID, target asset, quality rule set applied, execution timestamp, pass/fail counts per rule, overall DQ score, critical failures, remediation actions triggered, and assessed-by (automated pipeline or manual review). Provides the operational DQ audit trail for genomic datasets, clinical data, and enterprise master data.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`quality_issue` (
    `quality_issue_id` BIGINT COMMENT 'Unique identifier for the data quality issue record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Quality issues are tracked to specific instruments for trend analysis and preventive maintenance triggers. Enables instrument-level quality trending and service escalation. Required for GxP instrument',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that detected or reported the quality issue, enabling accountability and follow-up communication.',
    `quality_rule_id` BIGINT COMMENT 'Identifier of the data quality rule that was violated or triggered this issue, linking to the rule definition in the data quality framework.',
    `tertiary_quality_verified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who verified that the quality issue resolution was effective and the data now meets quality standards.',
    `root_cause_quality_issue_id` BIGINT COMMENT 'Self-referencing FK on quality_issue (root_cause_quality_issue_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value found in the data that violated the quality rule, enabling comparison with expected value for root cause analysis (may be NULL, malformed, or out-of-range).',
    `affected_record_count` BIGINT COMMENT 'Number of data records impacted by this quality issue, quantifying the scope of the problem for prioritization and remediation planning.',
    `affected_record_identifiers` STRING COMMENT 'Comma-separated list or JSON array of primary key values for records affected by this issue, enabling direct navigation to problematic data for remediation (truncated if exceeds storage limit).',
    `assigned_date` DATE COMMENT 'Date when the quality issue was assigned to a data steward for remediation, marking the start of active resolution efforts.',
    `business_impact` STRING COMMENT 'Assessment of the business impact caused by this quality issue, including effects on clinical reporting, regulatory submissions, research accuracy, customer deliverables, or operational decisions.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the quality issue, resolution process, or special circumstances that do not fit structured fields.',
    `compliance_impact_flag` BOOLEAN COMMENT 'Boolean indicator whether this quality issue impacts regulatory compliance (FDA, CLIA, CAP, GDPR, HIPAA) or audit requirements, requiring elevated attention and documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality issue record was first created in the data quality management system, establishing the audit trail start point.',
    `data_domain` STRING COMMENT 'Business data domain where the quality issue was identified (e.g., Sequencing, Sample Management, Clinical Genomics, Bioinformatics, Quality and Compliance), enabling domain-specific trend analysis.',
    `detected_date` DATE COMMENT 'Date when the quality issue was first identified, establishing the timeline for issue age and Service Level Agreement (SLA) tracking.',
    `detected_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the quality issue was first identified, enabling detailed audit trail and time-to-resolution metrics.',
    `detection_method` STRING COMMENT 'Method by which the quality issue was identified: automated_rule (scheduled DQ check), manual_review (steward inspection), user_report (end-user feedback), reconciliation (cross-system comparison), profiling (data discovery scan).. Valid values are `automated_rule|manual_review|user_report|reconciliation|profiling`',
    `expected_value` DECIMAL(18,2) COMMENT 'The correct or expected value according to the data quality rule or business standard, providing a reference for remediation (e.g., required metadata field, valid enumeration value, correct format).',
    `fair_compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether this quality issue violates FAIR (Findable, Accessible, Interoperable, Reusable) principles for genomic data sharing and metadata standards (e.g., missing required metadata, non-standard ontology terms).',
    `issue_description` STRING COMMENT 'Detailed narrative description of the quality issue, including specific examples of violations, business context, and potential downstream impact on genomic analysis or regulatory compliance.',
    `issue_number` STRING COMMENT 'Human-readable business identifier for the quality issue, formatted as DQ-YYYYMMDD sequence for tracking and reference in communications.. Valid values are `^DQ-[0-9]{8}$`',
    `issue_type` STRING COMMENT 'Category of data quality dimension violated: completeness (missing data), accuracy (incorrect values), consistency (conflicting data across sources), validity (format/constraint violations), timeliness (stale/outdated data), uniqueness (duplicate records).. Valid values are `completeness|accuracy|consistency|validity|timeliness|uniqueness`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this quality issue record, enabling change tracking and audit trail for all modifications throughout the issue lifecycle.',
    `preventive_action` STRING COMMENT 'Description of preventive actions implemented to avoid recurrence of similar quality issues (e.g., enhanced validation rules, updated Standard Operating Procedure (SOP), additional training, system configuration changes).',
    `priority` STRING COMMENT 'Business priority for remediation based on severity, affected systems, regulatory deadlines, and business impact. Urgent: immediate action required; High: resolve within 24 hours; Normal: standard SLA; Low: backlog.. Valid values are `urgent|high|normal|low`',
    `quality_issue_status` STRING COMMENT 'Current lifecycle state of the quality issue: open (newly identified), assigned (steward assigned), in_progress (under remediation), resolved (fix applied pending verification), closed (verified and complete), rejected (false positive or accepted risk).. Valid values are `open|assigned|in_progress|resolved|closed|rejected`',
    `resolution_action` STRING COMMENT 'Detailed description of the remediation action taken to resolve the quality issue (e.g., corrected missing metadata, updated variant classification, merged duplicate records, fixed referential integrity).',
    `resolution_date` DATE COMMENT 'Date when the quality issue was resolved and remediation actions were completed, enabling time-to-resolution metrics and SLA compliance tracking.',
    `resolution_method` STRING COMMENT 'Method used to resolve the issue: data_correction (fixed data values), rule_adjustment (modified DQ rule), source_system_fix (corrected at source), accepted_exception (documented business exception), false_positive (rule triggered incorrectly).. Valid values are `data_correction|rule_adjustment|source_system_fix|accepted_exception|false_positive`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the quality issue was resolved, providing detailed audit trail for compliance and performance analysis.',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause of the quality issue for trend analysis and preventive action: data_entry_error, system_integration (ETL/interface issue), process_gap (missing SOP), rule_misconfiguration, data_migration (conversion issue), external_source (vendor data quality).. Valid values are `data_entry_error|system_integration|process_gap|rule_misconfiguration|data_migration|external_source`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings, documenting why the quality issue occurred and what systemic factors contributed to the problem.',
    `severity` STRING COMMENT 'Business impact severity of the quality issue. Critical: blocks regulatory submission or patient safety; High: impacts clinical reporting; Medium: affects analytics accuracy; Low: cosmetic or minor metadata issues.. Valid values are `critical|high|medium|low`',
    `source_column` STRING COMMENT 'Specific column or field name within the source table where the quality issue was identified, enabling field-level remediation.',
    `source_system` STRING COMMENT 'Name of the operational system or data source where the quality issue was detected (e.g., LabVantage LIMS, Illumina BaseSpace, SAP S/4HANA QM, Benchling, Veeva Vault).',
    `source_table` STRING COMMENT 'Fully qualified name of the data asset (database table, file, or dataset) containing the quality issue, enabling precise traceability to the affected data structure.',
    `target_resolution_date` DATE COMMENT 'Target date by which the quality issue should be resolved, based on Service Level Agreement (SLA), severity, and business requirements.',
    `verification_status` STRING COMMENT 'Status of post-resolution verification: pending (awaiting verification), verified (fix confirmed effective), failed (issue persists or recurred, requires re-work).. Valid values are `pending|verified|failed`',
    `verified_date` DATE COMMENT 'Date when the quality issue resolution was verified as effective, completing the issue lifecycle and enabling closure.',
    CONSTRAINT pk_quality_issue PRIMARY KEY(`quality_issue_id`)
) COMMENT 'Transactional record of individual data quality issues identified during assessment runs or manual review — including missing genomic metadata, invalid variant classifications, duplicate sample records, broken referential integrity between clinical specimens and test orders, and non-conformant FAIR metadata. Captures issue ID, source asset, rule violated, affected records count, severity, assigned steward, resolution status, resolution date, and root cause category.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` (
    `mdm_policy_id` BIGINT COMMENT 'Unique identifier for the master data governance policy record.',
    `superseded_mdm_policy_id` BIGINT COMMENT 'Self-referencing FK on mdm_policy (superseded_mdm_policy_id)',
    `access_control_level` STRING COMMENT 'The default data classification level for data governed by this policy: public (no restrictions), internal (internal use only), confidential (business-sensitive), or restricted (PII/PHI/PCI requiring strict access controls).. Valid values are `public|internal|confidential|restricted`',
    `anonymization_required` BOOLEAN COMMENT 'Indicates whether data governed by this policy must be anonymized or de-identified before use in research, analytics, or sharing. True if anonymization is required, False otherwise.',
    `approval_date` DATE COMMENT 'The date on which the policy was formally approved by the approving authority.',
    `approver_name` STRING COMMENT 'The full name of the individual who approved the policy.',
    `approving_authority` STRING COMMENT 'The role, committee, or individual responsible for approving and authorizing this policy (e.g., Chief Data Officer, Data Governance Council, Quality Assurance Director).',
    `archival_required` BOOLEAN COMMENT 'Indicates whether data must be archived (moved to long-term storage) rather than deleted after the retention period expires. True if archival is required, False if deletion is permitted.',
    `compliance_framework` STRING COMMENT 'The regulatory or industry framework(s) to which this policy is aligned, such as GDPR (General Data Protection Regulation), HIPAA (Health Insurance Portability and Accountability Act), GxP (Good Practice Regulations), FAIR (Findable Accessible Interoperable Reusable), CLIA (Clinical Laboratory Improvement Amendments), CAP (College of American Pathologists), ISO 13485, ISO 15189, or IVDR (In Vitro Diagnostic Regulation). Multiple frameworks may be listed.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit patient or subject consent is required before data governed by this policy can be collected, processed, or shared. True if consent is mandatory, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy record was first created in the system.',
    `cross_border_transfer_allowed` BOOLEAN COMMENT 'Indicates whether data governed by this policy may be transferred across international borders. True if cross-border transfer is permitted (subject to applicable safeguards), False if data must remain within the originating jurisdiction.',
    `data_domain` STRING COMMENT 'The primary data domain to which this policy applies (e.g., Sequencing, Sample Management, Clinical Genomics, Bioinformatics, Quality and Compliance, Customer, Finance).',
    `data_quality_threshold` DECIMAL(18,2) COMMENT 'The minimum acceptable data quality score (as a percentage) for data governed by this policy. Applicable for quality-type policies. For example, 95.00 means 95% completeness or accuracy is required.',
    `effective_date` DATE COMMENT 'The date on which the policy becomes enforceable and binding.',
    `enforcement_mechanism` STRING COMMENT 'The method or system by which this policy is enforced (e.g., automated data quality rules in LIMS, access control lists in data catalog, manual review by QA, workflow gates in MES).',
    `entity_type` STRING COMMENT 'The specific master data entity type governed by this policy (e.g., Patient, Sample, Reagent Lot, Genomic Variant, Instrument, Assay, Test Order).',
    `exception_process` STRING COMMENT 'The documented process for requesting and approving exceptions to this policy, including escalation path and approval authority.',
    `expiration_date` DATE COMMENT 'The date on which the policy ceases to be in effect. Null for policies with no defined end date.',
    `fair_compliant` BOOLEAN COMMENT 'Indicates whether this policy enforces FAIR (Findable, Accessible, Interoperable, Reusable) principles for genomic datasets. True if FAIR compliance is required, False otherwise.',
    `last_review_date` DATE COMMENT 'The date on which the policy was most recently reviewed by the governance authority.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy record was last modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next policy review, calculated from last_review_date plus review_cycle_months.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the policy, including rationale for specific provisions or historical context.',
    `phi_applicable` BOOLEAN COMMENT 'Indicates whether this policy governs data that contains Protected Health Information (PHI) as defined by HIPAA. True if PHI is in scope, False otherwise.',
    `pii_applicable` BOOLEAN COMMENT 'Indicates whether this policy governs data that contains Personally Identifiable Information (PII) as defined by GDPR and other privacy regulations. True if PII is in scope, False otherwise.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the policy, following the format MDM-POL-XXXX.. Valid values are `^MDM-POL-[A-Z0-9]{4,12}$`',
    `policy_name` STRING COMMENT 'The official name of the master data governance policy.',
    `policy_owner` STRING COMMENT 'The role or department responsible for maintaining and enforcing this policy (e.g., Data Governance Office, Quality Assurance, Regulatory Affairs).',
    `policy_scope` STRING COMMENT 'The domain, entity, or data asset to which this policy applies (e.g., Patient, Sample, Reagent Lot, Genomic Variant, Sequencing Run).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy: draft (being developed), active (in force), under_review (being revised), suspended (temporarily inactive), or retired (no longer applicable).. Valid values are `draft|active|under_review|suspended|retired`',
    `policy_text` STRING COMMENT 'The full text of the governance policy, including rules, standards, and procedures that govern the master data entity or domain.',
    `policy_type` STRING COMMENT 'The category of master data governance policy: retention (data lifecycle), access (authorization controls), quality (data quality rules), privacy (PII/PHI protection), fair (Findable Accessible Interoperable Reusable compliance for genomic datasets), or traceability (chain-of-custody and lineage).. Valid values are `retention|access|quality|privacy|fair|traceability`',
    `policy_url` STRING COMMENT 'The URL or document management system link where the full policy document is stored and accessible.. Valid values are `^https?://.*$`',
    `policy_version` STRING COMMENT 'The version number of the policy, following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented with each revision.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `related_sop_reference` STRING COMMENT 'Reference to the Standard Operating Procedure (SOP) document that provides detailed operational instructions for implementing this policy.',
    `retention_period_years` STRING COMMENT 'The number of years that data governed by this policy must be retained before it is eligible for archival or deletion. Applicable for retention-type policies.',
    `retired_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy was retired and ceased to be active. Null if the policy is still active or under review.',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which the policy must be reviewed and revalidated (e.g., 12 for annual review, 24 for biennial).',
    `traceability_required` BOOLEAN COMMENT 'Indicates whether full chain-of-custody and data lineage traceability is required for data governed by this policy. True if traceability is mandatory, False otherwise.',
    CONSTRAINT pk_mdm_policy PRIMARY KEY(`mdm_policy_id`)
) COMMENT 'Master data governance policy record defining the rules, standards, and procedures governing master data entities across Genomics Biotech — including patient/subject identity resolution, sample chain-of-custody standards, reagent lot traceability requirements, and genomic data retention policies. Captures policy name, scope (domain or entity), policy type (retention, access, quality, privacy, FAIR), policy text, effective date, review cycle, approving authority, and compliance framework linkage (GDPR, HIPAA, GxP).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` (
    `genomic_access_control_id` BIGINT COMMENT 'Unique identifier for the genomic access control policy record. Primary key.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Access control policies for genomic datasets are genome-build-specific; dbGaP/EGA accessions and consent forms reference specific assemblies. Data use agreements and IRB protocols specify allowed geno',
    `license_entitlement_id` BIGINT COMMENT 'Foreign key linking to product.license_entitlement. Business justification: Software licenses control access to analysis features and datasets. Clinical interpretation module license restricts access to ClinVar-annotated variants, oncology license enables somatic variant call',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Genomic access control policies are governed by broader master data management policies. Many genomic_access_control policies can be governed by one mdm_policy. This FK establishes the governance hier',
    `parent_genomic_access_control_id` BIGINT COMMENT 'Self-referencing FK on genomic_access_control (parent_genomic_access_control_id)',
    `access_tier` STRING COMMENT 'Classification tier defining the level of access restriction applied to the genomic data. Open = publicly accessible, Registered = requires registration, Controlled = requires DAC approval, Restricted = highest security with IRB and consent requirements.. Valid values are `open|registered|controlled|restricted`',
    `approval_authority_name` STRING COMMENT 'Name of the individual or committee that approved this access control policy.',
    `approval_date` DATE COMMENT 'Date on which this access control policy was formally approved by the designated authority.',
    `audit_logging_required_flag` BOOLEAN COMMENT 'Indicates whether comprehensive audit logging of all data access events is required for compliance and security monitoring.',
    `authorized_roles` STRING COMMENT 'Comma-separated list of roles authorized to access the genomic data under this policy. Examples include Principal Investigator, Bioinformatician, Clinical Geneticist, Data Analyst.',
    `authorized_user_groups` STRING COMMENT 'Comma-separated list of user groups or organizational units authorized to access the genomic data under this policy. May include research teams, clinical departments, or external collaborators.',
    `consent_requirement_flag` BOOLEAN COMMENT 'Indicates whether explicit patient or participant consent is required for access to the genomic data governed by this policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access control policy record was first created in the system.',
    `data_access_committee_contact_email` STRING COMMENT 'Email address for contacting the Data Access Committee for access requests and inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_access_committee_name` STRING COMMENT 'Name of the Data Access Committee responsible for reviewing and approving access requests for controlled-access genomic data.',
    `data_use_limitation_codes` STRING COMMENT 'Comma-separated list of GA4GH Data Use Ontology (DUO) codes specifying permitted and restricted uses of the genomic data. Examples: GRU (General Research Use), HMB (Health/Medical/Biomedical), DS (Disease-Specific Research).',
    `data_use_limitation_description` STRING COMMENT 'Human-readable description of the data use limitations and restrictions governing access to the genomic data.',
    `dbgap_accession_number` STRING COMMENT 'dbGaP study accession number if the genomic dataset is registered with NIH dbGaP for controlled-access data sharing.. Valid values are `^phs[0-9]{6}(.v[0-9]+)?(.p[0-9]+)?$`',
    `deidentification_method` STRING COMMENT 'Method used to deidentify the genomic data to protect participant privacy. None indicates identifiable data.. Valid values are `none|safe_harbor|expert_determination|pseudonymization|anonymization`',
    `effective_end_date` DATE COMMENT 'Date on which this access control policy expires or is no longer enforceable. Null indicates an open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date on which this access control policy becomes effective and enforceable.',
    `ega_accession_number` STRING COMMENT 'EGA study or dataset accession number if the genomic dataset is registered with EGA for controlled-access data sharing in Europe.. Valid values are `^EGA(S|D)[0-9]{11}$`',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether encryption at rest and in transit is required for the genomic data governed by this policy.',
    `fair_compliance_flag` BOOLEAN COMMENT 'Indicates whether this access control policy is designed to support FAIR principles for genomic data sharing and reuse.',
    `ga4gh_passport_compatible_flag` BOOLEAN COMMENT 'Indicates whether this access control policy is compatible with GA4GH Passport standard for federated identity and access management.',
    `geographic_restriction` STRING COMMENT 'Geographic or jurisdictional restrictions on data access, specified as comma-separated ISO 3166-1 alpha-3 country codes. Empty if no geographic restrictions apply.',
    `irb_approval_number` STRING COMMENT 'IRB protocol approval number authorizing the collection, storage, and access to the genomic data under this policy.',
    `irb_expiration_date` DATE COMMENT 'Date on which the IRB approval expires, requiring renewal or policy suspension.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this access control policy record was last modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of this access control policy for continued relevance and compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this access control policy.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this access control policy.',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether the genomic dataset contains Protected Health Information (PHI) as defined by HIPAA, requiring additional privacy safeguards.',
    `policy_document_url` STRING COMMENT 'URL or file path to the full policy document detailing the access control requirements and procedures.',
    `policy_identifier` STRING COMMENT 'Business-readable unique identifier for the access control policy, used for external reference and audit trails.. Valid values are `^GAC-[A-Z0-9]{8,12}$`',
    `policy_name` STRING COMMENT 'Human-readable name of the access control policy describing its purpose and scope.',
    `policy_owner_email` STRING COMMENT 'Email address of the policy owner for inquiries and policy management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `policy_owner_name` STRING COMMENT 'Name of the individual or role responsible for maintaining and enforcing this access control policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the access control policy indicating whether it is actively enforced.. Valid values are `draft|active|suspended|expired|revoked`',
    `policy_type` STRING COMMENT 'Classification of the access control policy based on the type of genomic resource being governed.. Valid values are `dataset|data_asset|biobank_specimen|clinical_report|variant_database|research_project`',
    `policy_version` STRING COMMENT 'Version number of this access control policy, incremented with each revision.. Valid values are `^v[0-9]+.[0-9]+$`',
    `publication_moratorium_end_date` DATE COMMENT 'Date on which the publication moratorium expires, allowing public disclosure of research findings.',
    `publication_moratorium_flag` BOOLEAN COMMENT 'Indicates whether a publication moratorium period is in effect, restricting public disclosure of research findings derived from the genomic data.',
    `target_dataset_identifier` STRING COMMENT 'Identifier of the genomic dataset or data asset to which this access control policy applies. May reference WGS/WES datasets, VCF repositories, or clinical genomic databases.',
    CONSTRAINT pk_genomic_access_control PRIMARY KEY(`genomic_access_control_id`)
) COMMENT 'Master record governing access control policies for genomic datasets — including WGS/WES data, variant call files (VCF), clinical genomic reports, and biobank specimen data. Captures access control policy ID, target dataset or data asset, access tier (open/registered/controlled/restricted), authorized user groups or roles, consent requirement linkage, IRB approval reference, dbGaP/EGA accession if applicable, data use limitation codes (DUL), and policy effective dates. Implements FAIR accessibility and GA4GH Passport-compatible access governance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`access_request` (
    `access_request_id` BIGINT COMMENT 'Unique identifier for the genomic data access request. Primary key for the access request record.',
    `data_use_agreement_id` BIGINT COMMENT 'Identifier linking this access request to the executed Data Use Agreement governing permitted uses and restrictions.',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to data.dpia. Business justification: Access requests for high-risk genomic data processing may be subject to Data Protection Impact Assessments. Many access_requests can be covered by one DPIA. This FK links the operational access reques',
    `employee_id` BIGINT COMMENT 'Identifier of the individual researcher or principal investigator submitting the access request.',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Access requests are submitted against specific genomic access control policies. Many access_requests reference one genomic_access_control policy. The access_request captures request-specific data (req',
    `instrument_run_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_run. Business justification: Access requests for controlled genomic data reference specific runs (dbGaP, EGA submissions). Enables run-level data access governance and consent tracking. Required for NIH Genomic Data Sharing Polic',
    `dataset_id` BIGINT COMMENT 'Identifier of the primary genomic dataset, clinical data collection, or biobank resource being requested for access.',
    `amended_access_request_id` BIGINT COMMENT 'Self-referencing FK on access_request (amended_access_request_id)',
    `access_duration_months` STRING COMMENT 'Total duration in months for which data access is granted, typically ranging from 12 to 36 months.',
    `access_grant_expiry_date` DATE COMMENT 'Date when the approved data access expires and the requester must cease data use or request renewal.',
    `access_grant_start_date` DATE COMMENT 'Effective date when approved data access begins and the requester may commence data use.',
    `approval_conditions` STRING COMMENT 'Specific terms, restrictions, or conditions attached to the approved access, such as publication embargo, data destruction requirements, or usage limitations.',
    `approving_authority` STRING COMMENT 'Name or identifier of the Data Access Committee (DAC) member or governance body that authorized the access decision.',
    `collaboration_agreement_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal collaboration agreement with the data custodian is required as a condition of access.',
    `commercial_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requester intends to use the genomic data for commercial purposes or product development.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the access request record was first created in the data governance system.',
    `data_return_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requester must return or destroy the data upon completion of the research or access expiry.',
    `data_sensitivity_level` STRING COMMENT 'Classification of the requested dataset sensitivity level determining access control requirements: public (open access), registered (registration required), or controlled (DAC approval required).. Valid values are `public|registered|controlled`',
    `data_use_statement` STRING COMMENT 'Detailed description of the intended research use, scientific objectives, and analytical methods for the requested genomic data.',
    `decision_date` DATE COMMENT 'Date when the final approval or rejection decision was communicated to the requester.',
    `dsar_reference_number` STRING COMMENT 'Reference number if this access request is related to a GDPR Data Subject Access Request for an individuals own genomic data.',
    `gdpr_lawful_basis` STRING COMMENT 'Legal basis under GDPR Article 6 justifying the processing of personal genomic data for this access request.. Valid values are `consent|legitimate_interest|public_task|scientific_research`',
    `irb_approval_date` DATE COMMENT 'Date when the Institutional Review Board or ethics committee approved the research protocol.',
    `irb_approval_number` STRING COMMENT 'Reference number of the ethics committee or IRB approval authorizing the proposed research involving human subjects data.',
    `irb_expiry_date` DATE COMMENT 'Date when the current IRB approval expires and requires renewal for continued research.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the access request record was most recently updated.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the access request record.',
    `phi_included_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requested dataset contains Protected Health Information subject to HIPAA regulations.',
    `priority_level` STRING COMMENT 'Priority classification for Data Access Committee review, with urgent requests receiving accelerated processing.. Valid values are `routine|expedited|urgent`',
    `publication_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the requester is required to publish research findings as a condition of data access.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the Data Access Committee for rejecting the access request.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the access request, formatted as AR-YYYYNNNN where YYYY is year and NNNN is sequential number.. Valid values are `^AR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the access request in the Data Access Committee (DAC) review workflow. [ENUM-REF-CANDIDATE: pending|under_review|approved|rejected|expired|withdrawn|revoked — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the access request indicating whether it is a new access request, renewal of existing access, amendment to approved access, or emergency access request.. Valid values are `new_access|renewal|amendment|emergency_access`',
    `requester_email` STRING COMMENT 'Primary email address of the requester for communication regarding the access request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_institution` STRING COMMENT 'Name of the academic, research, or clinical institution with which the requester is affiliated.',
    `requester_name` STRING COMMENT 'Full legal name of the individual researcher or principal investigator submitting the access request.',
    `requester_orcid` STRING COMMENT 'ORCID persistent digital identifier for the requester, enabling unique identification across research systems.. Valid values are `^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]$`',
    `research_purpose_category` STRING COMMENT 'High-level classification of the research purpose for the data access request aligned with GA4GH Data Use Ontology categories.. Valid values are `disease_specific|methods_development|population_research|commercial|control`',
    `review_completion_date` DATE COMMENT 'Date when the Data Access Committee completed its review and reached a decision on the access request.',
    `review_start_date` DATE COMMENT 'Date when the Data Access Committee (DAC) formally began review of the access request.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the access request was formally submitted to the Data Access Committee (DAC) for review.',
    `target_dataset_name` STRING COMMENT 'Human-readable name of the genomic dataset or clinical data collection being requested.',
    `turnaround_time_days` STRING COMMENT 'Target number of days for Data Access Committee to complete review and reach a decision on the access request.',
    CONSTRAINT pk_access_request PRIMARY KEY(`access_request_id`)
) COMMENT 'Transactional record of each formal request submitted by internal or external researchers to access controlled genomic datasets, clinical data, or restricted biobank resources. Captures request ID, requester identity, requesting institution, target dataset(s), intended use statement, IRB/ethics approval reference, data use agreement linkage, request submission date, review status (pending/approved/rejected/expired), approving authority, approval date, and access grant expiry. Supports GA4GH Data Access Committee (DAC) workflows and GDPR data subject access request (DSAR) processing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` (
    `fair_assessment_id` BIGINT COMMENT 'Unique identifier for the FAIR compliance assessment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team who conducted the FAIR assessment.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: FAIR F1/F3 assessments require genomic datasets to include unambiguous genome build metadata in persistent identifiers and resource descriptions; NIH Data Management and Sharing Policy mandates genome',
    `instrument_run_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_run. Business justification: Run outputs undergo FAIR assessments before repository submission (SRA, EGA, GEO). Enables run-level FAIR compliance tracking and NIH DMSP reporting. Required for federally-funded genomics research da',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: FAIR assessments evaluate compliance with metadata standards and schemas. Many fair_assessments can evaluate one metadata_schema. The fair_assessment.metadata_standard_used (STRING) should be removed ',
    `asset_id` BIGINT COMMENT 'Identifier of the genomic dataset or data asset being assessed for FAIR compliance.',
    `previous_fair_assessment_id` BIGINT COMMENT 'Self-referencing FK on fair_assessment (previous_fair_assessment_id)',
    `accessible_a1_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for A1 principle: Data and metadata are retrievable by their identifier using a standardized communications protocol. Score range 0.00 to 5.00.',
    `accessible_a2_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for A2 principle: Metadata are accessible even when the data are no longer available. Score range 0.00 to 5.00.',
    `assessment_date` DATE COMMENT 'Date when the FAIR compliance assessment was conducted.',
    `assessment_identifier` STRING COMMENT 'Human-readable business identifier for the FAIR assessment, used for external reference and reporting.. Valid values are `^FAIR-[A-Z0-9]{8,12}$`',
    `assessment_methodology` STRING COMMENT 'Standardized methodology or framework used to conduct the FAIR assessment (e.g., FAIRsFAIR, RDA FAIR Maturity Indicators).. Valid values are `FAIRsFAIR|RDA_FAIR_Maturity_Indicators|FAIR_Evaluator|Custom_Internal|NIH_DMSP_Checklist`',
    `assessment_notes` STRING COMMENT 'Additional notes, observations, or context captured during the FAIR assessment process.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the FAIR assessment record.. Valid values are `draft|in_progress|completed|approved|rejected|under_review`',
    `assessor_name` STRING COMMENT 'Name of the data steward, bioinformatician, or compliance officer who performed the assessment.',
    `community_standard_compliance` STRING COMMENT 'Domain-relevant community standards the data asset complies with (e.g., GA4GH standards, MIAME for microarray, MINSEQE for sequencing).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FAIR assessment record was first created in the system.',
    `data_license` STRING COMMENT 'License governing the reuse of the data asset (e.g., CC0, CC-BY, CC-BY-NC, custom institutional license).',
    `data_repository_url` STRING COMMENT 'URL of the public or institutional repository where the data asset is registered or deposited (e.g., NCBI SRA, ENA, dbGaP, Zenodo).',
    `elixir_fair_compliant` BOOLEAN COMMENT 'Indicates whether the assessed data asset meets ELIXIR FAIR data obligations for European genomic data infrastructure.',
    `findable_f1_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for F1 principle: Data are assigned globally unique and persistent identifiers. Score range 0.00 to 5.00.',
    `findable_f2_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for F2 principle: Data are described with rich metadata. Score range 0.00 to 5.00.',
    `findable_f3_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for F3 principle: Metadata clearly and explicitly include the identifier of the data they describe. Score range 0.00 to 5.00.',
    `findable_f4_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for F4 principle: Metadata are registered or indexed in a searchable resource. Score range 0.00 to 5.00.',
    `identified_gaps` STRING COMMENT 'Detailed narrative of specific FAIR principle gaps identified during the assessment (e.g., missing persistent identifiers, incomplete metadata, lack of standardized vocabularies).',
    `interoperable_i1_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for I1 principle: Data and metadata use a formal, accessible, shared, and broadly applicable language for knowledge representation. Score range 0.00 to 5.00.',
    `interoperable_i2_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for I2 principle: Data and metadata use vocabularies that follow FAIR principles. Score range 0.00 to 5.00.',
    `interoperable_i3_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for I3 principle: Data and metadata include qualified references to other data and metadata. Score range 0.00 to 5.00.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FAIR assessment record was last updated or modified.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic FAIR compliance reassessment of the data asset.',
    `nih_dmsp_compliant` BOOLEAN COMMENT 'Indicates whether the assessed data asset meets NIH Data Management and Sharing Policy requirements for FAIR data sharing.',
    `ontology_terms_used` STRING COMMENT 'List of ontologies or controlled vocabularies used in metadata (e.g., Gene Ontology, SNOMED CT, LOINC, Human Phenotype Ontology).',
    `overall_fair_maturity_level` STRING COMMENT 'Aggregate FAIR maturity classification based on all dimension scores, aligned with capability maturity model levels.. Valid values are `not_fair|initial|managed|defined|quantitatively_managed|optimizing`',
    `overall_fair_score` DECIMAL(18,2) COMMENT 'Composite FAIR maturity score calculated as weighted or simple average of all F, A, I, R dimension scores. Score range 0.00 to 5.00.',
    `persistent_identifier_assigned` BOOLEAN COMMENT 'Indicates whether a globally unique and persistent identifier (e.g., DOI, ARK, Handle) has been assigned to the data asset.',
    `persistent_identifier_value` DECIMAL(18,2) COMMENT 'The actual persistent identifier value assigned to the data asset (e.g., DOI: 10.1234/example, ARK: ark:/12345/abc).',
    `provenance_documented` BOOLEAN COMMENT 'Indicates whether detailed data provenance (origin, processing history, transformations) is documented for the data asset.',
    `recommended_remediation_actions` STRING COMMENT 'Actionable recommendations to address identified FAIR gaps and improve maturity scores (e.g., implement DOI assignment, enrich metadata with ontology terms, publish to public repository).',
    `reusable_r1_1_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for R1.1 principle: Data and metadata are released with a clear and accessible data usage license. Score range 0.00 to 5.00.',
    `reusable_r1_2_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for R1.2 principle: Data and metadata are associated with detailed provenance. Score range 0.00 to 5.00.',
    `reusable_r1_3_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for R1.3 principle: Data and metadata meet domain-relevant community standards. Score range 0.00 to 5.00.',
    `reusable_r1_score` DECIMAL(18,2) COMMENT 'FAIR maturity score for R1 principle: Data and metadata are richly described with a plurality of accurate and relevant attributes. Score range 0.00 to 5.00.',
    `target_asset_name` STRING COMMENT 'Name of the genomic dataset or data asset being assessed (e.g., WGS cohort, variant database, sequencing run collection).',
    `target_asset_type` STRING COMMENT 'Classification of the data asset being assessed for FAIR compliance. [ENUM-REF-CANDIDATE: genomic_dataset|reference_genome|variant_database|sequencing_run|bioinformatics_pipeline|clinical_dataset|research_dataset — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_fair_assessment PRIMARY KEY(`fair_assessment_id`)
) COMMENT 'Transactional record of FAIR (Findable, Accessible, Interoperable, Reusable) compliance assessments conducted on genomic datasets and data assets. Captures assessment ID, target data asset, assessment date, FAIR maturity scores per dimension (F1–F4, A1–A2, I1–I3, R1–R3), overall FAIR maturity level, identified gaps, recommended remediation actions, assessor identity, and assessment methodology (FAIRsFAIR, RDA FAIR Maturity Indicators). Supports NIH Data Management and Sharing Policy compliance and ELIXIR FAIR data obligations.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` (
    `metadata_schema_id` BIGINT COMMENT 'Unique identifier for the metadata schema record. Primary key.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Metadata schemas for genomic data assets must specify supported genome builds; coordinate systems, contig naming conventions, and sequence dictionaries differ between assemblies. GA4GH Phenopackets an',
    `parent_schema_metadata_schema_id` BIGINT COMMENT 'Reference to a parent or base schema from which this schema inherits or extends. Null if this is a root schema.',
    `parent_metadata_schema_id` BIGINT COMMENT 'Self-referencing FK on metadata_schema (parent_metadata_schema_id)',
    `applicable_data_asset_types` STRING COMMENT 'Comma-separated list of data asset types to which this schema applies (e.g., sequencing runs, variant calls, clinical specimens, bioinformatics pipelines).',
    `approval_date` DATE COMMENT 'The date on which this schema version was formally approved by the data governance board or schema authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee who approved this schema version for production use.',
    `backward_compatible` BOOLEAN COMMENT 'Indicates whether this schema version is backward compatible with previous versions. True if data conforming to older versions remains valid.',
    `change_log` STRING COMMENT 'Summary of changes, enhancements, or fixes introduced in this schema version compared to the previous version.',
    `controlled_vocabulary_reference` STRING COMMENT 'Reference to the controlled vocabulary, ontology, or code system used by this schema (e.g., SNOMED CT, LOINC, HPO, SO). Ensures semantic consistency.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this metadata schema record was first created in the system.',
    `deprecation_date` DATE COMMENT 'The date on which this schema version was deprecated and marked for retirement. Null if schema is still active.',
    `effective_date` DATE COMMENT 'The date from which this schema version became active and approved for use in production systems.',
    `fair_compliance_level` STRING COMMENT 'Assessment of how well this schema supports FAIR (Findable, Accessible, Interoperable, Reusable) principles for genomic data sharing.. Valid values are `full|partial|minimal|non_compliant`',
    `interoperability_standard` STRING COMMENT 'The overarching interoperability framework or standard this schema aligns with (e.g., HL7 FHIR, GA4GH, ISO 23494, CDISC). Enables cross-system data exchange.',
    `is_extensible` BOOLEAN COMMENT 'Indicates whether this schema allows custom extensions or additional fields beyond the core specification. True if extensible, False if strictly defined.',
    `mandatory_fields` STRING COMMENT 'Comma-separated list of field names that are required by this schema. Used for validation and compliance checking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this metadata schema record was last modified or updated.',
    `optional_fields` STRING COMMENT 'Comma-separated list of field names that are optional in this schema. Provides flexibility for diverse use cases.',
    `regulatory_alignment` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance requirements this schema supports (e.g., HIPAA, GDPR, FDA 21 CFR Part 11, CLIA).',
    `retirement_date` DATE COMMENT 'The date on which this schema version was fully retired and removed from production use. Null if not yet retired.',
    `schema_description` STRING COMMENT 'Detailed textual description of the purpose, scope, and intended use cases for this metadata schema.',
    `schema_documentation_url` STRING COMMENT 'URL pointing to the official documentation, user guide, or specification document for this schema.',
    `schema_format` STRING COMMENT 'The technical format or serialization standard used to represent this schema (e.g., JSON Schema, XML Schema, RDF, Avro). [ENUM-REF-CANDIDATE: json|xml|rdf|csv|avro|parquet|protobuf — 7 candidates stripped; promote to reference product]',
    `schema_name` STRING COMMENT 'The official name of the metadata schema or standard (e.g., GA4GH Phenopackets, ISA-Tab, MIMARKS, Dublin Core).',
    `schema_namespace` STRING COMMENT 'The namespace or domain under which this schema is defined, preventing naming collisions with other schemas.',
    `schema_owner` STRING COMMENT 'Name or identifier of the individual, team, or organization responsible for maintaining and governing this schema.',
    `schema_status` STRING COMMENT 'Current lifecycle status of the metadata schema. Active schemas are approved for production use; deprecated schemas are being phased out.. Valid values are `active|deprecated|draft|retired|under_review`',
    `schema_steward` STRING COMMENT 'Name or identifier of the data steward responsible for day-to-day schema quality, compliance, and issue resolution.',
    `schema_type` STRING COMMENT 'Classification of the schema by its primary domain of application within genomics and biotechnology operations. [ENUM-REF-CANDIDATE: genomic|phenotypic|clinical|operational|experimental|reference|interoperability — 7 candidates stripped; promote to reference product]',
    `schema_uri` STRING COMMENT 'Globally unique URI or URL where the authoritative definition of this schema can be accessed. Supports schema resolution and validation.',
    `schema_version` STRING COMMENT 'Version identifier of the metadata schema (e.g., v2.0, 1.3.5). Tracks schema evolution and compatibility.',
    `usage_count` BIGINT COMMENT 'The number of data assets or records currently tagged with or governed by this metadata schema. Indicates schema adoption.',
    `validation_rules` STRING COMMENT 'Description or reference to the validation rules and constraints enforced by this schema (e.g., data type checks, cardinality, value ranges).',
    CONSTRAINT pk_metadata_schema PRIMARY KEY(`metadata_schema_id`)
) COMMENT 'Master catalog of metadata schemas and standards applied to genomic and operational data assets at Genomics Biotech — including GA4GH Phenopackets, ISA-Tab, MIMARKS/MIMS, Dublin Core, and internal schema definitions. Captures schema name, version, applicable data asset types, mandatory fields, controlled vocabulary references, interoperability standard (HL7 FHIR, GA4GH, ISO 23494), schema owner, effective date, and deprecation status. Governs metadata standardization for FAIR interoperability compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique identifier for the data retention and disposal policy record.',
    `regulatory_classification_id` BIGINT COMMENT 'Foreign key linking to product.regulatory_classification. Business justification: Regulatory classification dictates data retention periods. FDA Class II IVD devices require different retention than RUO products. IVDR Class C has stricter requirements than Class A. Regulatory audit',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Different SKU categories generate data with different retention requirements. IVD reagent SKUs require 21 CFR Part 11 retention (years), RUO software SKUs have shorter periods. Regulatory audits, cust',
    `superseded_by_policy_retention_policy_id` BIGINT COMMENT 'Reference to the retention policy that replaces this policy when status is superseded. Null if policy is still active or not replaced.',
    `superseded_retention_policy_id` BIGINT COMMENT 'Self-referencing FK on retention_policy (superseded_retention_policy_id)',
    `access_control_level` STRING COMMENT 'Data classification level determining access controls for data governed by this policy: public (unrestricted), internal (employees only), confidential (need-to-know), restricted (highly sensitive, role-based access).. Valid values are `public|internal|confidential|restricted`',
    `applies_to_phi` BOOLEAN COMMENT 'Indicates whether this retention policy governs data containing Protected Health Information (PHI) subject to HIPAA privacy and security rules (True) or non-PHI data (False).',
    `applies_to_pii` BOOLEAN COMMENT 'Indicates whether this retention policy governs data containing Personally Identifiable Information (PII) subject to GDPR, CCPA, or other privacy regulations (True) or non-PII data (False).',
    `approval_date` DATE COMMENT 'Date when this retention policy was formally approved by the governance committee, legal, or executive leadership.',
    `approved_by_name` STRING COMMENT 'Name of the individual or committee that formally approved this retention policy (e.g., Data Governance Committee, Chief Compliance Officer).',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether all access, modification, and disposal actions on data governed by this policy must be logged in an immutable audit trail (True) or audit logging is optional (False).',
    `backup_retention_period_days` STRING COMMENT 'Number of days that backup copies of data governed by this policy must be retained, which may differ from primary data retention period for disaster recovery purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention policy record was first created in the system.',
    `data_asset_category` STRING COMMENT 'Category or type of data asset this policy applies to (e.g., Genomic Raw Data (FASTQ/BAM), Clinical Genomic Reports, Patient PHI, Research ELN Records, GxP Batch Records, Financial Data, Quality Control Data, Instrument Calibration Records).',
    `data_domain` STRING COMMENT 'Enterprise data domain this policy governs (e.g., Sequencing, Clinical Genomics, Quality and Compliance, Finance, Research and Development, Customer).',
    `data_sharing_permitted` BOOLEAN COMMENT 'Indicates whether data governed by this policy may be shared externally with research partners, regulatory agencies, or public repositories (True) or must remain internal only (False).',
    `disposal_approval_required` BOOLEAN COMMENT 'Indicates whether formal approval from data owner, legal, or compliance is required before data disposal can proceed (True) or if disposal can be automated (False).',
    `disposal_method` STRING COMMENT 'Method by which data is disposed at end of retention period: secure_deletion (cryptographic erasure), anonymization (de-identification for research), archival (long-term cold storage), physical_destruction (media destruction), transfer_to_archive (move to external archive).. Valid values are `secure_deletion|anonymization|archival|physical_destruction|transfer_to_archive`',
    `effective_date` DATE COMMENT 'Date when this retention policy version became active and enforceable across the organization.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether data assets governed by this policy must be encrypted at rest and in transit throughout the retention period (True) or encryption is optional (False).',
    `expiration_date` DATE COMMENT 'Date when this retention policy version is scheduled to expire or be superseded by a new version. Null indicates no planned expiration.',
    `fair_compliance_required` BOOLEAN COMMENT 'Indicates whether data assets governed by this policy must comply with FAIR data principles for genomic datasets (True), typically for research and public data sharing, or not required (False).',
    `geographic_scope` STRING COMMENT 'Geographic regions or jurisdictions where this retention policy applies (e.g., USA, EUR, Global, California Only). Uses 3-letter country codes or region identifiers.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this retention policy is currently active and being enforced (True) or inactive (False). Derived from policy_status for quick filtering.',
    `last_review_date` DATE COMMENT 'Date when this retention policy was last reviewed and approved by the policy owner or governance committee.',
    `legal_basis` STRING COMMENT 'Legal or regulatory authority mandating this retention policy (e.g., CLIA 42 CFR 493.1105, HIPAA 45 CFR 164.530, GxP 21 CFR Part 11, GDPR Article 5(1)(e), ISO 13485:2016 Section 4.2.5, SOX Section 802).',
    `litigation_hold_override` BOOLEAN COMMENT 'Indicates whether this retention policy can be overridden by a litigation hold order (True), suspending disposal until legal matter is resolved, or policy is absolute (False).',
    `maximum_retention_period_days` STRING COMMENT 'Maximum number of days the data asset may be retained before mandatory disposal or anonymization is required (e.g., GDPR storage limitation principle). Null indicates no maximum limit (permanent retention).',
    `minimum_retention_period_days` STRING COMMENT 'Minimum number of days the data asset must be retained to satisfy legal, regulatory, or business requirements before disposal is permitted.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention policy record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this retention policy to ensure ongoing compliance and relevance.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the retention policy used for cross-system reference and reporting.',
    `policy_description` STRING COMMENT 'Detailed description of the retention policy purpose, scope, and business rationale, including specific regulatory requirements and business justification.',
    `policy_name` STRING COMMENT 'Human-readable name of the retention policy (e.g., CLIA Clinical Data 10-Year Retention, GxP Batch Record Permanent Retention).',
    `policy_owner_department` STRING COMMENT 'Department or business unit responsible for this retention policy (e.g., Data Governance, Quality and Compliance, Legal, Information Security).',
    `policy_owner_name` STRING COMMENT 'Name of the individual or role responsible for maintaining and enforcing this retention policy (e.g., Chief Data Officer, VP Quality Assurance, Director Regulatory Affairs).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the retention policy: draft (under development), active (in force), suspended (temporarily inactive), retired (no longer applicable), superseded (replaced by newer policy).. Valid values are `draft|active|suspended|retired|superseded`',
    `policy_type` STRING COMMENT 'Classification of the retention policy basis: regulatory (mandated by law/regulation), legal (litigation hold), operational (business continuity), business (strategic value), or research (scientific archive).. Valid values are `regulatory|legal|operational|business|research`',
    `policy_version` STRING COMMENT 'Version identifier of this retention policy document (e.g., 1.0, 2.3, v2024.1) for change tracking and audit purposes.',
    `retention_trigger_event` STRING COMMENT 'Business event that starts the retention clock (e.g., Date of Last Patient Contact, Batch Release Date, Study Completion Date, Invoice Payment Date, Data Creation Date). Defines when the retention period begins counting.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this retention policy must be reviewed and revalidated to ensure continued regulatory compliance and business relevance.',
    `storage_location_constraint` STRING COMMENT 'Geographic or infrastructure constraints on where data governed by this policy may be stored (e.g., US Data Centers Only, EU Region Only, On-Premises Only, No Cloud Storage). Null indicates no constraint.',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Master record defining data retention and disposal policies for each data asset category at Genomics Biotech — including genomic raw data (FASTQ/BAM), clinical genomic reports, patient PHI, research ELN records, GxP batch records, and financial data. Captures policy name, applicable data asset types, minimum retention period, maximum retention period, legal basis (CLIA, HIPAA, GxP 21 CFR Part 11, GDPR), disposal method (secure deletion, anonymization, archival), review cycle, and policy owner.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`dpia` (
    `dpia_id` BIGINT COMMENT 'Unique identifier for the Data Protection Impact Assessment record. Primary key for DPIA tracking and audit trail.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Privacy impact assessments for genomic data processing must document which genome builds are in scope; re-identification risk varies by build due to public reference availability and population databa',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Data Protection Impact Assessments evaluate compliance with master data governance policies. Many DPIAs can assess compliance with one mdm_policy. This FK links the DPIA assessment to the MDM policy b',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: DPIAs assess data processing activities including retention practices. One DPIA references one retention_policy that governs the data retention period. The dpia.data_retention_period (STRING) should b',
    `superseded_dpia_id` BIGINT COMMENT 'Self-referencing FK on dpia (superseded_dpia_id)',
    `approval_date` DATE COMMENT 'Date on which the DPIA was formally approved by the designated authority (e.g., Data Governance Committee, Chief Privacy Officer, DPO).',
    `approval_status` STRING COMMENT 'Current approval status of the DPIA in the governance workflow. Approved status indicates the processing activity may proceed with documented risk mitigation measures. [ENUM-REF-CANDIDATE: draft|under_review|dpo_review|approved|rejected|conditional_approval|revision_required — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved the DPIA (e.g., Chief Privacy Officer, Data Governance Committee Chair, DPO).',
    `automated_decision_making_flag` BOOLEAN COMMENT 'Indicates whether the processing involves automated decision-making or profiling with legal or significant effects (e.g., AI-driven variant interpretation, automated clinical risk scoring). True if automated decision-making is used.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DPIA record was first created in the system. Part of audit trail for regulatory compliance.',
    `cross_border_transfer_flag` BOOLEAN COMMENT 'Indicates whether the processing involves transfer of personal data outside the European Economic Area (EEA) or to third countries. True if cross-border transfer occurs.',
    `data_categories` STRING COMMENT 'Categories of personal data involved in the processing activity (e.g., genomic data, Protected Health Information (PHI), biometric data, clinical assay results, patient identifiers, research consent records). Pipe-separated list.',
    `data_subject_consultation_flag` BOOLEAN COMMENT 'Indicates whether data subjects or their representatives were consulted during the DPIA process, as required where appropriate under GDPR Article 35(9). True if consultation occurred.',
    `data_subject_consultation_summary` STRING COMMENT 'Summary of data subject consultation activities, including feedback received and how it was incorporated into the DPIA and risk mitigation strategy.',
    `data_subjects_description` STRING COMMENT 'Description of the categories of data subjects whose data is processed (e.g., patients, clinical trial participants, research subjects, healthcare providers, laboratory technicians).',
    `data_volume_scale` STRING COMMENT 'Scale of data processing in terms of number of data subjects or volume of genomic data. Large-scale processing triggers mandatory DPIA under GDPR Article 35(3)(b).. Valid values are `small_scale|medium_scale|large_scale|very_large_scale`',
    `dpo_consultation_date` DATE COMMENT 'Date on which the Data Protection Officer was consulted regarding the DPIA. DPO consultation is mandatory under GDPR Article 35(2).',
    `dpo_consultation_outcome` STRING COMMENT 'Outcome of the DPO consultation, including DPO advice, recommendations, and any concerns raised regarding the processing activity.',
    `fair_compliance_flag` BOOLEAN COMMENT 'Indicates whether the genomic data processing activity complies with FAIR principles for scientific data management and stewardship. True if FAIR-compliant.',
    `hipaa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the processing activity complies with HIPAA requirements for Protected Health Information (PHI) in the United States. True if HIPAA-compliant.',
    `identified_risks` STRING COMMENT 'Detailed list of identified risks to data subject rights and freedoms (e.g., unauthorized access to genomic data, re-identification risk, discrimination based on genetic information, data breach exposure). Pipe-separated or structured text.',
    `irb_approval_number` STRING COMMENT 'IRB approval number for research activities involving human subjects, if applicable. Required for clinical research and genomic studies involving patient data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the DPIA record. Tracks changes to risk assessments, mitigation measures, or approval status.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the DPIA, documenting ongoing compliance monitoring and risk reassessment.',
    `legal_basis` STRING COMMENT 'The legal basis under GDPR Article 6 that justifies the processing of personal data (e.g., consent, legal obligation, legitimate interests). For special category data, additional Article 9 basis must be documented.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `necessity_assessment` STRING COMMENT 'Assessment of the necessity of the data processing for the stated purpose, demonstrating that the processing is essential and cannot be achieved through less intrusive means.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the DPIA. Regular reviews are required when processing operations change or new risks emerge.',
    `processing_activity_description` STRING COMMENT 'Detailed description of the data processing activity, including purpose, scope, data flows, systems involved, and business context.',
    `processing_activity_name` STRING COMMENT 'Name of the data processing activity being assessed (e.g., Whole Genome Sequencing (WGS) Data Analysis Pipeline, Clinical Genomic Report Generation, Research Biobank Sample Storage).',
    `processing_purpose` STRING COMMENT 'The specific purpose for which personal data is processed (e.g., clinical diagnosis, research and development, product commercialization, regulatory submission).',
    `proportionality_assessment` STRING COMMENT 'Assessment of the proportionality of the data processing in relation to the purpose, ensuring that the processing is not excessive and that data subject rights are adequately protected.',
    `reference_number` STRING COMMENT 'Human-readable business identifier for the DPIA, used in regulatory submissions and internal documentation. Format: DPIA-YYYY-####.. Valid values are `^DPIA-[0-9]{4}-[0-9]{4}$`',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and updating the DPIA to ensure continued compliance and relevance as processing activities or risks evolve.. Valid values are `annual|biannual|quarterly|ad_hoc|continuous`',
    `risk_assessment_summary` STRING COMMENT 'Summary of the risk assessment findings, including identified risks to data subject rights and freedoms, likelihood and severity analysis, and overall risk rating.',
    `risk_mitigation_measures` STRING COMMENT 'Measures implemented to mitigate identified risks (e.g., encryption, pseudonymization, access controls, data minimization, anonymization techniques, secure data transfer protocols, audit logging).',
    `special_category_data_flag` BOOLEAN COMMENT 'Indicates whether the processing involves special categories of personal data under GDPR Article 9 (genetic data, health data, biometric data). True if special category data is processed.',
    `special_category_legal_basis` STRING COMMENT 'Additional legal basis under GDPR Article 9 for processing special categories of personal data (genetic, health, biometric). Required when special_category_data_flag is True.',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date on which the supervisory authority was consulted regarding the high-risk processing activity, if required under GDPR Article 36.',
    `supervisory_authority_consultation_required_flag` BOOLEAN COMMENT 'Indicates whether prior consultation with the supervisory authority is required under GDPR Article 36 due to high residual risk. True if consultation is required.',
    `supervisory_authority_response` STRING COMMENT 'Response received from the supervisory authority following consultation, including any guidance, conditions, or restrictions imposed on the processing activity.',
    `systematic_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the processing involves systematic monitoring of data subjects (e.g., continuous genomic data collection, longitudinal clinical studies). True if systematic monitoring occurs.',
    `third_party_processors` STRING COMMENT 'List of third-party data processors involved in the processing activity (e.g., cloud service providers, bioinformatics service vendors, contract research organizations). Pipe-separated list.',
    `transfer_mechanism` STRING COMMENT 'Legal mechanism used for cross-border data transfers (e.g., Standard Contractual Clauses (SCC), Binding Corporate Rules (BCR), adequacy decision, explicit consent). Required when cross_border_transfer_flag is True.',
    CONSTRAINT pk_dpia PRIMARY KEY(`dpia_id`)
) COMMENT 'Data Protection Impact Assessment (DPIA) master record for high-risk data processing activities involving genomic data, patient PHI, and sensitive research data at Genomics Biotech. Captures DPIA ID, processing activity description, data categories involved (genomic, clinical, biometric), risk assessment findings, identified risks and mitigations, necessity and proportionality assessment, DPO consultation outcome, supervisory authority consultation requirement, approval status, and review date. Required under GDPR Article 35 for large-scale genomic data processing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`glossary_term` (
    `glossary_term_id` BIGINT COMMENT 'Unique identifier for the business glossary term record.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Business glossary terms for gene-specific concepts (e.g., "BRCA1 pathogenic variant", "TP53 hotspot region") must link to canonical gene models to provide unambiguous HGNC symbol, genomic coordinates,',
    `parent_glossary_term_id` BIGINT COMMENT 'Self-referencing FK on glossary_term (parent_glossary_term_id)',
    `access_restriction_notes` STRING COMMENT 'Free-text description of any special access controls, data use limitations, or consent requirements that apply to data governed by this term.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the glossary term indicating its approval state and usability within the enterprise data catalog.. Valid values are `draft|under_review|approved|deprecated|retired`',
    `approved_by` STRING COMMENT 'Name of the governance authority or individual who formally approved this glossary term for enterprise use.',
    `approved_date` DATE COMMENT 'Date when the glossary term was formally approved by the data governance authority.',
    `change_log` STRING COMMENT 'Chronological record of changes made to this glossary term definition, including dates, authors, and descriptions of modifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this glossary term record was first created in the enterprise data catalog system.',
    `data_retention_period_days` STRING COMMENT 'Number of days that data governed by this term must be retained to meet regulatory, legal, or business requirements.',
    `data_sensitivity_level` STRING COMMENT 'Classification level indicating the sensitivity of data governed by this term, determining access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `data_steward_email` STRING COMMENT 'Email address of the data steward for inquiries and clarifications regarding this glossary term.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_steward_name` STRING COMMENT 'Full name of the individual assigned as the data steward responsible for maintaining the accuracy and currency of this glossary term definition.',
    `definition` STRING COMMENT 'The authoritative, detailed business definition of the term that establishes its meaning and usage across the enterprise.',
    `effective_from_date` DATE COMMENT 'Date from which this glossary term definition becomes active and authoritative for use across the enterprise.',
    `effective_to_date` DATE COMMENT 'Date when this glossary term definition ceases to be active; null indicates the term is currently active with no planned end date.',
    `external_reference_url` STRING COMMENT 'Web link to external documentation, standards, or resources that provide additional context or authoritative definitions for this term.',
    `fair_compliance_flag` BOOLEAN COMMENT 'Indicates whether this glossary term and its associated data assets comply with FAIR (Findable, Accessible, Interoperable, Reusable) principles for genomic data sharing.',
    `industry_standard_reference` STRING COMMENT 'Reference to industry standards, ontologies, or nomenclatures that define this term (e.g., SNOMED CT, LOINC, HGVS, ClinVar, dbSNP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this glossary term record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this glossary term was last reviewed by the data steward or governance authority.',
    `linked_attributes` STRING COMMENT 'Comma-separated list of specific attribute or column names across data products that are tagged with or governed by this glossary term.',
    `linked_data_assets` STRING COMMENT 'Comma-separated list of data product names, table names, or data asset identifiers that use or reference this glossary term.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this glossary term definition.',
    `notes` STRING COMMENT 'Additional free-text notes, clarifications, or contextual information about this glossary term that do not fit into other structured fields.',
    `owning_domain` STRING COMMENT 'The primary data domain responsible for defining and maintaining this glossary term. [ENUM-REF-CANDIDATE: sequencing|sample_management|instrument|reagent_and_consumable|bioinformatics|clinical_genomics|research_and_development|customer|order_management|supply_chain|manufacturing|quality_and_compliance|finance|workforce|reference_genomics|data — 16 candidates stripped; promote to reference product]',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether data governed by this term contains Protected Health Information subject to HIPAA privacy and security requirements.',
    `pii_flag` BOOLEAN COMMENT 'Indicates whether data governed by this term contains Personally Identifiable Information subject to privacy regulations such as GDPR.',
    `regulatory_reference` STRING COMMENT 'Citation of regulatory standards, guidelines, or frameworks that define or govern the use of this term (e.g., FDA Guidance, CLIA, CAP, GDPR, HIPAA).',
    `related_terms` STRING COMMENT 'Comma-separated list of related glossary term names that have semantic relationships or contextual connections to this term.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this glossary term to ensure definition accuracy and relevance.',
    `short_definition` STRING COMMENT 'A concise summary definition of the term suitable for tooltips, quick reference, and user interface display (typically under 200 characters).',
    `source_system` STRING COMMENT 'Name of the operational system or authoritative source from which this glossary term definition was derived (e.g., Benchling, LabVantage LIMS, Veeva Vault).',
    `synonyms` STRING COMMENT 'Comma-separated list of alternative names, abbreviations, or aliases for this term used across the organization or industry (e.g., NGS, Next-Gen Sequencing, Next-Generation Sequencing).',
    `term_category` STRING COMMENT 'High-level classification of the glossary term indicating the business domain or functional area it belongs to. [ENUM-REF-CANDIDATE: clinical|sequencing|bioinformatics|quality|regulatory|manufacturing|research|customer|general — 9 candidates stripped; promote to reference product]',
    `term_code` STRING COMMENT 'Unique business code or abbreviation for the glossary term used for system integration and cross-referencing (e.g., VUS, LIBPREP, FLOWCELL).',
    `term_name` STRING COMMENT 'The canonical name of the business term as it appears in the enterprise glossary (e.g., Variant of Uncertain Significance, Library Preparation, Flow Cell, CRISPR Off-Target).',
    `usage_context` STRING COMMENT 'Description of the business contexts, processes, or scenarios where this term is typically used (e.g., clinical reporting, variant calling pipelines, regulatory submissions).',
    `usage_examples` STRING COMMENT 'Concrete examples demonstrating how this term is used in business communications, reports, or data assets.',
    `version_number` STRING COMMENT 'Version identifier for this glossary term definition, incremented when the definition or metadata is updated (e.g., 1.0, 1.1, 2.0).',
    CONSTRAINT pk_glossary_term PRIMARY KEY(`glossary_term_id`)
) COMMENT 'Enterprise business glossary master record defining authoritative definitions for genomics and biotechnology business terms used across Genomics Biotechs data catalog — including terms like variant of uncertain significance (VUS), library preparation, flow cell, CRISPR off-target, analytical sensitivity, FAIR compliance, and data use limitation. Captures term name, definition, synonyms, related terms, owning domain, steward, approval status, effective date, and linked data assets or attributes.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` (
    `catalog_tag_id` BIGINT COMMENT 'Unique identifier for the catalog tag record. Primary key for the catalog tag entity.',
    `glossary_term_id` BIGINT COMMENT 'Foreign key linking to data.glossary_term. Business justification: Catalog tags used for data asset classification may be formally defined in the enterprise business glossary. One catalog_tag references one glossary_term for its authoritative definition. This FK link',
    `parent_tag_catalog_tag_id` BIGINT COMMENT 'Reference to the parent tag in a hierarchical tag taxonomy. Enables multi-level tag classification (e.g., genomics > sequencing > WGS). Null for top-level tags.',
    `parent_catalog_tag_id` BIGINT COMMENT 'Self-referencing FK on catalog_tag (parent_catalog_tag_id)',
    `allows_multiple_values` BOOLEAN COMMENT 'Indicates whether multiple instances of this tag can be applied to a single data asset. True for tags like genomics_assay_type (a dataset may contain both WGS and WES data), false for mutually exclusive tags like sensitivity_level.',
    `applicable_asset_types` STRING COMMENT 'Comma-separated list of data asset types to which this tag can be applied. Examples: dataset, table, column, pipeline, report, genomic_file, variant_call, sequencing_run.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether applying this tag to a data asset requires formal approval from a data steward or governance committee. True for sensitive or regulatory tags (e.g., PHI, clinical-grade), false for general classification tags.',
    `catalog_tag_description` STRING COMMENT 'Detailed business definition and purpose of the tag, including usage guidelines and examples of data assets to which this tag should be applied.',
    `catalog_tag_status` STRING COMMENT 'Current lifecycle status of the tag. Active tags are available for use. Deprecated tags are discouraged but still valid. Proposed tags are under review. Retired tags are no longer valid and should be removed from assets.. Valid values are `active|deprecated|proposed|retired`',
    `compliance_framework` STRING COMMENT 'The regulatory or compliance framework that mandates or recommends the use of this tag. Examples: HIPAA, GDPR, FDA 21 CFR Part 11, ISO 13485, GxP, NIH Genomic Data Sharing Policy. Null for non-regulatory tags.',
    `controlled_vocabulary_source` STRING COMMENT 'The authoritative source or ontology from which this tag is derived. Examples: GA4GH Data Use Ontology, OBO Foundry, NCIT (NCI Thesaurus), internal governance committee, ISO 13485.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tag record was first created in the catalog. Used for audit trail and temporal analysis.',
    `data_sharing_restriction` STRING COMMENT 'Indicates the level of restriction on sharing data assets tagged with this tag. No_restriction allows public sharing. Internal_only restricts to organization. Controlled_access requires approval. Embargo restricts until a date. Consent_required mandates patient consent.. Valid values are `no_restriction|internal_only|controlled_access|embargo|consent_required`',
    `display_color` STRING COMMENT 'Hexadecimal color code used for visual representation of this tag in the data catalog user interface. Enables color-coded tag categories for improved user experience.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `display_icon` STRING COMMENT 'Name or reference to the icon used for visual representation of this tag in the data catalog user interface. Examples: dna-helix, shield, microscope, database.',
    `effective_end_date` DATE COMMENT 'The date on which this tag was deprecated or retired. Null for active tags. Used for temporal governance and historical analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this tag became active and available for application to data assets. Used for temporal governance and audit trail.',
    `fair_principle_alignment` STRING COMMENT 'Indicates which FAIR principle(s) this tag supports. Values: Findable, Accessible, Interoperable, Reusable, or combinations. Used to track FAIR compliance of genomic datasets.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this tag must be applied to applicable data assets as part of data governance policy. True for required tags (e.g., sensitivity classification), false for optional tags.',
    `is_system_generated` BOOLEAN COMMENT 'Indicates whether this tag is automatically applied by data catalog automation, lineage tools, or metadata scanners (true), or manually curated by data stewards (false).',
    `last_modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified this tag record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tag record was last modified. Used for audit trail and change tracking.',
    `ontology_uri` STRING COMMENT 'The canonical URI or IRI reference to the term in the external ontology or controlled vocabulary, enabling semantic interoperability and FAIR compliance.',
    `owner_steward_email` STRING COMMENT 'The email address of the data steward responsible for this tag. Used for governance inquiries and tag change requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_steward_name` STRING COMMENT 'The name of the data steward or governance team responsible for maintaining the definition, usage guidelines, and lifecycle of this tag.',
    `related_tags` STRING COMMENT 'Comma-separated list of related tag codes that are semantically associated with this tag. Used for tag recommendation and faceted navigation. Example: WGS tag may be related to variant-calling, BAM-format, FASTQ-format.',
    `search_weight` STRING COMMENT 'Numeric weight assigned to this tag for search ranking and relevance scoring in the data catalog. Higher weights boost assets with this tag in search results. Used to prioritize high-value or frequently-used tags.',
    `synonyms` STRING COMMENT 'Comma-separated list of alternative names or synonyms for this tag. Used to improve search recall and accommodate different terminology across business units. Example: WGS may have synonyms whole-genome-sequencing, complete-genome.',
    `tag_category` STRING COMMENT 'High-level classification of the tag type. Genomics_assay_type includes WGS, WES, RNA-seq, array. Data_use_restriction includes clinical-grade, RUO. FAIR_principle includes findable, accessible, interoperable, reusable. Sensitivity_level includes PHI, de-identified. Domain includes sequencing, bioinformatics, clinical. Regulatory_classification includes IVD, LDT, GxP.. Valid values are `genomics_assay_type|data_use_restriction|fair_principle|sensitivity_level|domain|regulatory_classification`',
    `tag_code` STRING COMMENT 'Short alphanumeric code or abbreviation for the tag, used for programmatic reference and API integration. Must be unique within the catalog.',
    `tag_level` STRING COMMENT 'The depth level of this tag in the hierarchical taxonomy. Top-level tags are level 1, their children are level 2, and so on. Used for faceted navigation and drill-down search.',
    `tag_name` STRING COMMENT 'The canonical name of the tag used for classification and discovery in the enterprise data catalog. Examples include WGS, WES, RNA-seq, array, CRISPR, clinical-grade, research-use-only, FAIR-compliant.',
    `usage_count` STRING COMMENT 'The number of data assets currently tagged with this tag. Updated periodically to support tag popularity analysis and catalog search optimization.',
    `created_by` STRING COMMENT 'The username or identifier of the user or system that created this tag record. Used for audit trail and governance accountability.',
    CONSTRAINT pk_catalog_tag PRIMARY KEY(`catalog_tag_id`)
) COMMENT 'Reference master for controlled vocabulary tags and classification labels applied to data assets in the enterprise data catalog — including genomics-specific tags (WGS, WES, RNA-seq, array, CRISPR, clinical-grade, research-use-only), FAIR tags, sensitivity tags, and domain tags. Captures tag name, tag category, description, applicable asset types, controlled vocabulary source (GA4GH, OBO Foundry, internal), and active status. Enables faceted search and discovery in the data catalog.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` (
    `asset_tag_assignment_id` BIGINT COMMENT 'Unique identifier for the asset tag assignment record. Primary key for the asset tag assignment entity.',
    `catalog_tag_id` BIGINT COMMENT 'Reference to the catalog tag being assigned. Links to the tag definition in the enterprise tag taxonomy.',
    `asset_id` BIGINT COMMENT 'Reference to the data asset being tagged. Links to the data asset catalog entry that this tag is assigned to.',
    `parent_assignment_asset_tag_assignment_id` BIGINT COMMENT 'Reference to the parent tag assignment from which this assignment was inherited. Null for root assignments. Supports traceability of tag propagation through asset hierarchies.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created the tag assignment. For automated assignments, references the service account or machine learning model identifier.',
    `quaternary_asset_deactivated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who deactivated the tag assignment. Null for active assignments. Supports accountability and audit trail for classification changes.',
    `tertiary_asset_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved the tag assignment. Null if not yet approved or approval not required. Links to the data steward or governance authority.',
    `superseded_asset_tag_assignment_id` BIGINT COMMENT 'Self-referencing FK on asset_tag_assignment (superseded_asset_tag_assignment_id)',
    `algorithm_version` STRING COMMENT 'Version identifier of the classification algorithm used. Supports reproducibility and audit of automated tagging decisions. Null for manual assignments.',
    `approval_date` DATE COMMENT 'Date when the tag assignment was approved. Null if not yet approved or approval not required. Supports audit trail and governance reporting.',
    `approval_status` STRING COMMENT 'Approval state of the tag assignment within the governance workflow. Approved indicates steward has validated the assignment, rejected indicates assignment was declined, pending indicates awaiting approval, not_required indicates no approval workflow applies.. Valid values are `approved|rejected|pending|not_required`',
    `assigned_by_role` STRING COMMENT 'Role or function of the entity that assigned the tag. Captures the business context of who or what performed the assignment, supporting governance workflows and approval chains. [ENUM-REF-CANDIDATE: data_steward|data_owner|data_custodian|system_admin|ml_classifier|api_service|data_scientist|compliance_officer — 8 candidates stripped; promote to reference product]',
    `assignment_date` DATE COMMENT 'Date when the tag was assigned to the data asset. Represents the business-effective date of the tag assignment, which may differ from the system creation timestamp.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the tag assignment. Active indicates the tag is currently applied and visible, inactive indicates temporarily disabled, pending_review indicates awaiting data steward approval, rejected indicates assignment was reviewed and declined, superseded indicates replaced by a newer assignment, archived indicates historical record retained for audit purposes.. Valid values are `active|inactive|pending_review|rejected|superseded|archived`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the tag assignment was created in the system. Captures the exact moment the assignment record was persisted, supporting audit trail and temporal analysis.',
    `assignment_type` STRING COMMENT 'Method by which the tag was assigned to the data asset. Manual indicates steward-assigned, automated indicates machine learning or rule-based classification, inherited indicates propagation from parent asset, suggested indicates recommendation pending approval, bulk_import indicates batch assignment from external source, system_generated indicates automatic assignment during asset registration.. Valid values are `manual|automated|inherited|suggested|bulk_import|system_generated`',
    `business_criticality` STRING COMMENT 'Business importance level associated with this tag assignment. Critical indicates essential for core operations, high indicates significant business impact, medium indicates moderate importance, low indicates minimal impact, not_assessed indicates pending evaluation.. Valid values are `critical|high|medium|low|not_assessed`',
    `classification_algorithm` STRING COMMENT 'Name or identifier of the automated classification algorithm or machine learning model used for automated tag assignments. Null for manual assignments. Examples include rule-based classifier, natural language processing model, or pattern matching engine.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level of the tag assignment, expressed as a decimal between 0 and 1. For automated assignments, represents the machine learning model confidence. For manual assignments, may represent steward certainty rating. Higher values indicate greater confidence in the tag applicability.',
    `data_sharing_restriction` STRING COMMENT 'Data sharing constraint associated with this tag assignment. Unrestricted allows broad sharing, internal_only limits to organization, restricted_partners allows approved collaborators, regulatory_approval_required mandates authority consent, prohibited blocks all external sharing.. Valid values are `unrestricted|internal_only|restricted_partners|regulatory_approval_required|prohibited`',
    `deactivation_date` DATE COMMENT 'Date when the tag assignment was deactivated or removed. Null for active assignments. Supports audit trail and historical analysis of asset classification changes.',
    `deactivation_reason` STRING COMMENT 'Free-text explanation for why the tag assignment was deactivated. May include business justification, data quality issues, or classification corrections. Null for active assignments.',
    `effective_from_date` DATE COMMENT 'Date from which the tag assignment is effective. Supports temporal validity and historical tracking of tag assignments. Enables point-in-time queries of asset classification state.',
    `effective_to_date` DATE COMMENT 'Date until which the tag assignment is effective. Null indicates the assignment is currently active with no planned end date. Supports temporal validity and lifecycle management of tag assignments.',
    `fair_accessible_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment contributes to FAIR Accessible principle compliance. True if the tag supports access control or data sharing agreement classification.',
    `fair_findable_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment contributes to FAIR Findable principle compliance. True if the tag enhances discoverability of genomic datasets through standardized metadata.',
    `fair_interoperable_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment contributes to FAIR Interoperable principle compliance. True if the tag uses standardized vocabularies or ontologies enabling cross-system integration.',
    `fair_reusable_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment contributes to FAIR Reusable principle compliance. True if the tag provides licensing, provenance, or usage context metadata supporting data reuse.',
    `gdpr_relevant_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment is relevant for GDPR compliance. True if the tag identifies personal data, special category data, or data subject rights applicability.',
    `hipaa_relevant_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment is relevant for HIPAA compliance. True if the tag identifies Protected Health Information (PHI) or supports HIPAA security rule requirements.',
    `last_reviewed_date` DATE COMMENT 'Date when the tag assignment was last reviewed by a data steward. Null if never reviewed. Supports audit trail and demonstrates governance diligence.',
    `ontology_term` STRING COMMENT 'Specific term or concept from the referenced ontology that this tag represents. Provides human-readable label for the ontology concept.',
    `ontology_uri` STRING COMMENT 'Uniform Resource Identifier linking the tag to a formal ontology or controlled vocabulary. Supports semantic interoperability and FAIR compliance by grounding tags in standardized knowledge representations.',
    `propagation_depth` STRING COMMENT 'Number of levels in the asset hierarchy to which this tag assignment should propagate. Null or zero indicates no propagation. Positive integer indicates maximum depth of inheritance.',
    `propagation_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment should be propagated to child or related data assets. True enables inheritance of tags through asset hierarchies, supporting consistent classification across related datasets.',
    `quality_dimension` STRING COMMENT 'Data quality dimension that this tag assignment supports or measures. Enables quality-focused asset discovery and quality rule association.. Valid values are `accuracy|completeness|consistency|timeliness|validity|uniqueness`',
    `retention_impact_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment affects data retention requirements. True if the tag triggers specific retention policies or legal hold requirements.',
    `review_due_date` DATE COMMENT 'Date by which the tag assignment should be reviewed by a data steward. Null if no review is required. Supports governance workflows and ensures tag accuracy over time.',
    `review_notes` STRING COMMENT 'Free-text notes captured during the most recent review of the tag assignment. May include steward observations, justification for approval or rejection, or recommendations for future classification.',
    `review_required_flag` BOOLEAN COMMENT 'Indicates whether the tag assignment requires periodic review or steward validation. True for assignments that need governance oversight, false for trusted assignments. Supports data quality and governance workflows.',
    `source_reference_code` STRING COMMENT 'External identifier or reference key from the source system. Enables traceability back to the originating system and supports reconciliation during data integration.',
    `source_system` STRING COMMENT 'Name or identifier of the system that originated the tag assignment. Examples include data catalog platform, metadata management tool, or external classification service. Supports data lineage and integration tracking.',
    CONSTRAINT pk_asset_tag_assignment PRIMARY KEY(`asset_tag_assignment_id`)
) COMMENT 'Association entity linking data assets to catalog tags, capturing the many-to-many relationship between data assets and their classification labels. Captures assignment ID, data asset reference, tag reference, assignment date, assigned by (automated classification or manual steward), confidence score for automated tagging, and active status. Enables multi-dimensional data asset discovery and FAIR findability compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` (
    `access_control_dpia_assessment_id` BIGINT COMMENT 'Primary key for the access_control_dpia_assessment association',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to the Data Protection Impact Assessment under which this access control policy is evaluated',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to the genomic access control policy being assessed in this DPIA evaluation',
    `assessment_date` DATE COMMENT 'Date on which this specific access control policy was assessed within the DPIA scope. Explicitly identified in detection phase relationship data.',
    `assessment_outcome` STRING COMMENT 'The formal outcome of the DPIA assessment for this specific access control policy. Explicitly identified in detection phase relationship data.',
    `assessor_name` STRING COMMENT 'Name of the individual or team who conducted this specific access control policy assessment within the DPIA. Explicitly identified in detection phase relationship data.',
    `compliance_status` STRING COMMENT 'Current compliance status of this access control policy relative to the DPIA requirements. Explicitly identified in detection phase relationship data.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this access control policy within the DPIA scope. Explicitly identified in detection phase relationship data.',
    `remediation_actions_required` STRING COMMENT 'Specific remediation actions required for this access control policy as determined by the DPIA assessment. Explicitly identified in detection phase relationship data.',
    `risk_level_assigned` STRING COMMENT 'Risk level assigned to this specific access control policy during the DPIA evaluation, reflecting the assessed risk to data subject rights and freedoms. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_access_control_dpia_assessment PRIMARY KEY(`access_control_dpia_assessment_id`)
) COMMENT 'This association product represents the Assessment event between genomic_access_control and dpia. It captures the formal evaluation of whether a specific access control policy adequately protects data subjects as assessed within a Data Protection Impact Assessment. Each record links one genomic access control policy to one DPIA with assessment-specific attributes including risk findings, compliance determinations, and remediation requirements that exist only in the context of this evaluation relationship.. Existence Justification: In genomics biotechnology data governance, access control policies for genomic datasets must undergo Data Protection Impact Assessment when processing involves high-risk activities. A single DPIA scope routinely covers multiple genomic datasets with distinct access policies (e.g., a whole-genome sequencing DPIA assesses policies for WGS data, VCF files, and clinical reports). Conversely, a single access control policy is reassessed across multiple DPIAs as regulations evolve, new risks emerge, or processing activities change. The business actively manages these assessment relationships with specific outcomes, risk levels, and remediation requirements for each policy-DPIA pairing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`dataset` (
    `dataset_id` BIGINT COMMENT 'Primary key for dataset',
    `derived_from_dataset_id` BIGINT COMMENT 'Self-referencing FK on dataset (derived_from_dataset_id)',
    `access_level` STRING COMMENT 'Access control classification governing who may view or download the dataset.',
    `checksum` STRING COMMENT 'MD5 checksum used to verify data integrity.',
    `compliance_status` STRING COMMENT 'Current compliance state of the dataset with regulatory and internal policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dataset record was first created in the catalog.',
    `data_processing_pipeline` STRING COMMENT 'Name or identifier of the pipeline that processed the raw data into this dataset.',
    `data_quality_notes` STRING COMMENT 'Free‑form notes on data quality issues or observations.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall data quality assessment.',
    `data_source` STRING COMMENT 'Narrative description of the original data source or instrument.',
    `dataset_category` STRING COMMENT 'Higher‑level grouping (e.g., research, clinical trial, reference).',
    `dataset_code` STRING COMMENT 'Business‑assigned code that uniquely identifies the dataset across systems.',
    `dataset_type` STRING COMMENT 'Category describing the scientific nature of the dataset.',
    `dataset_description` STRING COMMENT 'Free‑form description providing context and content summary.',
    `effective_from` DATE COMMENT 'Date when the dataset became officially available for use.',
    `effective_until` DATE COMMENT 'Date when the dataset is scheduled to be retired or become unavailable (null if indefinite).',
    `file_format` STRING COMMENT 'Technical file format of the dataset (e.g., FASTQ, BAM, VCF, CSV).',
    `geographic_region` STRING COMMENT 'Three‑letter country code indicating the primary region associated with the dataset.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the dataset has been marked as deprecated.',
    `is_public` BOOLEAN COMMENT 'True if the dataset is publicly accessible; otherwise false.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent user access to the dataset.',
    `license_expiration_date` DATE COMMENT 'Date when the dataset license expires.',
    `license_type` STRING COMMENT 'Legal license governing dataset usage.',
    `dataset_name` STRING COMMENT 'Human‑readable name of the dataset.',
    `owner_email` STRING COMMENT 'Contact email of the dataset owner.',
    `owner_name` STRING COMMENT 'Name of the individual or team responsible for the dataset.',
    `record_count` BIGINT COMMENT 'Number of individual records or entries contained in the dataset.',
    `retention_period_days` STRING COMMENT 'Number of days the dataset must be retained according to policy.',
    `sensitivity_classification` STRING COMMENT 'Data sensitivity tier used for compliance and security handling.',
    `size_bytes` BIGINT COMMENT 'Total size of the dataset in bytes.',
    `source_system` STRING COMMENT 'Originating operational system or instrument that produced the dataset.',
    `dataset_status` STRING COMMENT 'Current lifecycle state of the dataset.',
    `storage_location` STRING COMMENT 'Physical or logical path where the dataset files are stored.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dataset record.',
    `version` STRING COMMENT 'Version identifier for the dataset, reflecting updates or re‑releases.',
    `version_number` STRING COMMENT 'Incremental integer version of the dataset.',
    CONSTRAINT pk_dataset PRIMARY KEY(`dataset_id`)
) COMMENT 'Master reference table for dataset. Referenced by target_dataset_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` (
    `data_use_agreement_id` BIGINT COMMENT 'Primary key for data_use_agreement',
    `amended_data_use_agreement_id` BIGINT COMMENT 'Self-referencing FK on data_use_agreement (amended_data_use_agreement_id)',
    `agreement_name` STRING COMMENT 'Human‑readable title of the data use agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the agreement by the organization.',
    `agreement_type` STRING COMMENT 'Category of the agreement indicating its primary business purpose.',
    `allowed_uses` STRING COMMENT 'Free‑text list of specific analyses or activities permitted under the agreement.',
    `amendment_date` DATE COMMENT 'Date the latest amendment was executed.',
    `amendment_number` STRING COMMENT 'Sequential number of the most recent amendment to the agreement.',
    `audit_log_reference` STRING COMMENT 'Identifier linking to the detailed audit log for this agreement.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the agreement.',
    `compliance_requirements` STRING COMMENT 'Regulatory or policy requirements the agreement must satisfy (e.g., GDPR, HIPAA).',
    `confidentiality_level` STRING COMMENT 'Sensitivity classification of the data as defined by internal policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `data_access_approval_date` DATE COMMENT 'Date on which access to the data was formally approved.',
    `data_access_approver` STRING COMMENT 'Name of the individual who approved data access.',
    `data_access_approver_email` STRING COMMENT 'Email address of the approver for audit purposes.',
    `data_access_level` STRING COMMENT 'Level of access granted to the data under the agreement.',
    `data_category` STRING COMMENT 'High‑level classification of the data covered by the agreement.',
    `data_encryption_required` BOOLEAN COMMENT 'Indicates whether data must be encrypted in transit and at rest.',
    `data_quality_requirements` STRING COMMENT 'Minimum quality thresholds (e.g., coverage, error rate) the data must meet.',
    `data_retention_period_days` STRING COMMENT 'Number of days the data may be retained after the agreement expires.',
    `data_security_measures` STRING COMMENT 'Description of technical and organizational safeguards required for the data.',
    `data_sharing_agreement` STRING COMMENT 'Reference code linking to any supplemental data‑sharing addendum.',
    `data_transfer_mechanism` STRING COMMENT 'Method by which the data will be transferred to the recipient.',
    `data_use_purpose` STRING COMMENT 'Narrative description of the intended scientific or commercial purpose for which the data may be used.',
    `effective_from` DATE COMMENT 'Date on which the agreement becomes legally binding.',
    `effective_until` DATE COMMENT 'Date on which the agreement expires or terminates; null for open‑ended agreements.',
    `expiration_notice_sent` BOOLEAN COMMENT 'True if a notice of upcoming expiration has been sent to the counter‑party.',
    `is_commercial` BOOLEAN COMMENT 'True if the agreement permits commercial exploitation of the data.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the data may be shared with other parties (true = exclusive).',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code governing the legal jurisdiction of the agreement.',
    `last_review_date` DATE COMMENT 'Date the agreement was last reviewed for compliance or renewal.',
    `legal_entity` STRING COMMENT 'Name of the organization that is a party to the agreement.',
    `notice_period_days` STRING COMMENT 'Number of days prior to expiration that notice must be provided.',
    `renewal_option` STRING COMMENT 'Whether the agreement renews automatically, requires manual renewal, or does not renew.',
    `restrictions` STRING COMMENT 'Any limitations or prohibitions on data usage (e.g., no commercial redistribution).',
    `signed_by_email` STRING COMMENT 'Email address of the individual signer for electronic correspondence.',
    `signed_by_name` STRING COMMENT 'Legal name of the individual who signed the agreement.',
    `signed_date` DATE COMMENT 'Date the agreement was signed by the authorized party.',
    `data_use_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.',
    `termination_clause` STRING COMMENT 'Text describing conditions under which the agreement may be terminated early.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the agreement record.',
    `version_number` STRING COMMENT 'Incremental version of the agreement document.',
    CONSTRAINT pk_data_use_agreement PRIMARY KEY(`data_use_agreement_id`)
) COMMENT 'Master reference table for data_use_agreement. Referenced by data_use_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_parent_quality_rule_id` FOREIGN KEY (`parent_quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ADD CONSTRAINT `fk_data_quality_assessment_previous_quality_assessment_id` FOREIGN KEY (`previous_quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ADD CONSTRAINT `fk_data_quality_issue_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ADD CONSTRAINT `fk_data_quality_issue_root_cause_quality_issue_id` FOREIGN KEY (`root_cause_quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ADD CONSTRAINT `fk_data_mdm_policy_superseded_mdm_policy_id` FOREIGN KEY (`superseded_mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ADD CONSTRAINT `fk_data_genomic_access_control_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ADD CONSTRAINT `fk_data_genomic_access_control_parent_genomic_access_control_id` FOREIGN KEY (`parent_genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_data_use_agreement_id` FOREIGN KEY (`data_use_agreement_id`) REFERENCES `genomics_biotech_ecm`.`data`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_dataset_id` FOREIGN KEY (`dataset_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dataset`(`dataset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_amended_access_request_id` FOREIGN KEY (`amended_access_request_id`) REFERENCES `genomics_biotech_ecm`.`data`.`access_request`(`access_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_previous_fair_assessment_id` FOREIGN KEY (`previous_fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ADD CONSTRAINT `fk_data_metadata_schema_parent_schema_metadata_schema_id` FOREIGN KEY (`parent_schema_metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ADD CONSTRAINT `fk_data_metadata_schema_parent_metadata_schema_id` FOREIGN KEY (`parent_metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ADD CONSTRAINT `fk_data_retention_policy_superseded_by_policy_retention_policy_id` FOREIGN KEY (`superseded_by_policy_retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ADD CONSTRAINT `fk_data_retention_policy_superseded_retention_policy_id` FOREIGN KEY (`superseded_retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ADD CONSTRAINT `fk_data_dpia_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ADD CONSTRAINT `fk_data_dpia_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ADD CONSTRAINT `fk_data_dpia_superseded_dpia_id` FOREIGN KEY (`superseded_dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ADD CONSTRAINT `fk_data_glossary_term_parent_glossary_term_id` FOREIGN KEY (`parent_glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ADD CONSTRAINT `fk_data_catalog_tag_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ADD CONSTRAINT `fk_data_catalog_tag_parent_tag_catalog_tag_id` FOREIGN KEY (`parent_tag_catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ADD CONSTRAINT `fk_data_catalog_tag_parent_catalog_tag_id` FOREIGN KEY (`parent_catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_catalog_tag_id` FOREIGN KEY (`catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_parent_assignment_asset_tag_assignment_id` FOREIGN KEY (`parent_assignment_asset_tag_assignment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`asset_tag_assignment`(`asset_tag_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_superseded_asset_tag_assignment_id` FOREIGN KEY (`superseded_asset_tag_assignment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`asset_tag_assignment`(`asset_tag_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ADD CONSTRAINT `fk_data_access_control_dpia_assessment_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ADD CONSTRAINT `fk_data_access_control_dpia_assessment_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` ADD CONSTRAINT `fk_data_dataset_derived_from_dataset_id` FOREIGN KEY (`derived_from_dataset_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dataset`(`dataset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ADD CONSTRAINT `fk_data_data_use_agreement_amended_data_use_agreement_id` FOREIGN KEY (`amended_data_use_agreement_id`) REFERENCES `genomics_biotech_ecm`.`data`.`data_use_agreement`(`data_use_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`data` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `genomics_biotech_ecm`.`data` SET TAGS ('dbx_domain' = 'data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `parent_quality_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `alert_threshold_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Breach Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Statement');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Enforcement Action');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'block|warn|quarantine|log|alert');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Execution Frequency');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_value_regex' = 'real_time|batch_hourly|batch_daily|batch_weekly|on_demand');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `execution_platform` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Execution Platform');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `execution_platform` SET TAGS ('dbx_value_regex' = 'databricks_dlt|databricks_job|great_expectations|deequ|custom_spark');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `fair_principle` SET TAGS ('dbx_business_glossary_term' = 'FAIR (Findable Accessible Interoperable Reusable) Principle Alignment');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `fair_principle` SET TAGS ('dbx_value_regex' = 'findable|accessible|interoperable|reusable');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Enforcement Indicator');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `last_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `last_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Failure Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `last_pass_rate` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Pass Rate');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `remediation_guidance` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Remediation Guidance');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'genomic|clinical|operational|regulatory|master_data|transactional');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^DQR-[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Expression');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Owner');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Steward Email Address');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_steward_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_steward_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'completeness|uniqueness|validity|consistency|timeliness|referential_integrity');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Severity Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Rule Classification Tags');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `target_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Target Data Asset Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `target_column_name` SET TAGS ('dbx_business_glossary_term' = 'Target Column Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Data Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Threshold Operator');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|not_equal');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Threshold Unit');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Threshold Value');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `previous_quality_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessed_by_system` SET TAGS ('dbx_business_glossary_term' = 'Assessed By System');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Assessed By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_run_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Run Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_run_number` SET TAGS ('dbx_value_regex' = '^QA-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_value_regex' = 'full|sample|incremental|targeted');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'completed|failed|in_progress|cancelled|partial');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid|scheduled|on_demand');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Completeness Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `consistency_score` SET TAGS ('dbx_business_glossary_term' = 'Consistency Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `critical_failures_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Failures Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `data_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `data_steward_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Notified Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Seconds)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `failure_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Summary');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `fair_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `overall_dq_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Data Quality (DQ) Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `pass_fail_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Threshold');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `phi_exposure_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Exposure Detected Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `records_assessed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Assessed Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `records_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Failed Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `remediation_actions_triggered` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Triggered');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Set Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rules_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Failed Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rules_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Passed Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `rules_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Warning Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `target_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Target Asset Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `target_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Target Asset Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `target_asset_type` SET TAGS ('dbx_value_regex' = 'table|view|dataset|domain|product|pipeline');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `timeliness_score` SET TAGS ('dbx_business_glossary_term' = 'Timeliness Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `total_rules_executed` SET TAGS ('dbx_business_glossary_term' = 'Total Rules Executed');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `uniqueness_score` SET TAGS ('dbx_business_glossary_term' = 'Uniqueness Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ALTER COLUMN `validity_score` SET TAGS ('dbx_business_glossary_term' = 'Validity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Detected By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `tertiary_quality_verified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `tertiary_quality_verified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `tertiary_quality_verified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `root_cause_quality_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `affected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Record Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `affected_record_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Affected Record Identifiers');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `compliance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `data_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_rule|manual_review|user_report|reconciliation|profiling');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `fair_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable Accessible Interoperable Reusable (FAIR) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_value_regex' = '^DQ-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'completeness|accuracy|consistency|validity|timeliness|uniqueness');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `quality_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `quality_issue_status` SET TAGS ('dbx_value_regex' = 'open|assigned|in_progress|resolved|closed|rejected');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'data_correction|rule_adjustment|source_system_fix|accepted_exception|false_positive');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'data_entry_error|system_integration|process_gap|rule_misconfiguration|data_migration|external_source');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `source_column` SET TAGS ('dbx_business_glossary_term' = 'Source Column Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `source_table` SET TAGS ('dbx_business_glossary_term' = 'Source Table Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed');
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verified Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` SET TAGS ('dbx_subdomain' = 'governance_framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Policy Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `superseded_mdm_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `anonymization_required` SET TAGS ('dbx_business_glossary_term' = 'Anonymization Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `archival_required` SET TAGS ('dbx_business_glossary_term' = 'Archival Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `cross_border_transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Allowed Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `data_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `data_quality_threshold` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Threshold (Percentage)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `exception_process` SET TAGS ('dbx_business_glossary_term' = 'Exception Process');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `fair_compliant` SET TAGS ('dbx_business_glossary_term' = 'Findable Accessible Interoperable Reusable (FAIR) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `phi_applicable` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `pii_applicable` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^MDM-POL-[A-Z0-9]{4,12}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_scope` SET TAGS ('dbx_business_glossary_term' = 'Policy Scope');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|retired');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_text` SET TAGS ('dbx_business_glossary_term' = 'Policy Text');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'retention|access|quality|privacy|fair|traceability');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `related_sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Standard Operating Procedure (SOP) Reference');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retired Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`mdm_policy` ALTER COLUMN `traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Traceability Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` SET TAGS ('dbx_subdomain' = 'access_management');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `license_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'License Entitlement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `parent_genomic_access_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier Classification');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'open|registered|controlled|restricted');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `audit_logging_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `authorized_roles` SET TAGS ('dbx_business_glossary_term' = 'Authorized Roles');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `authorized_user_groups` SET TAGS ('dbx_business_glossary_term' = 'Authorized User Groups');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `consent_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Requirement Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_access_committee_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Data Access Committee (DAC) Contact Email');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_access_committee_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_access_committee_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_access_committee_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_access_committee_name` SET TAGS ('dbx_business_glossary_term' = 'Data Access Committee (DAC) Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_use_limitation_codes` SET TAGS ('dbx_business_glossary_term' = 'Data Use Limitation (DUL) Codes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `data_use_limitation_description` SET TAGS ('dbx_business_glossary_term' = 'Data Use Limitation Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `dbgap_accession_number` SET TAGS ('dbx_business_glossary_term' = 'Database of Genotypes and Phenotypes (dbGaP) Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `dbgap_accession_number` SET TAGS ('dbx_value_regex' = '^phs[0-9]{6}(.v[0-9]+)?(.p[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_business_glossary_term' = 'Deidentification Method');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_value_regex' = 'none|safe_harbor|expert_determination|pseudonymization|anonymization');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `ega_accession_number` SET TAGS ('dbx_business_glossary_term' = 'European Genome-phenome Archive (EGA) Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `ega_accession_number` SET TAGS ('dbx_value_regex' = '^EGA(S|D)[0-9]{11}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `fair_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable Accessible Interoperable Reusable (FAIR) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `ga4gh_passport_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Alliance for Genomics and Health (GA4GH) Passport Compatible Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `ga4gh_passport_compatible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `ga4gh_passport_compatible_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Policy Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Policy Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `phi_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document URL');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_identifier` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_identifier` SET TAGS ('dbx_value_regex' = '^GAC-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Email');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|revoked');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'dataset|data_asset|biobank_specimen|clinical_report|variant_database|research_project');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `publication_moratorium_end_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Moratorium End Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `publication_moratorium_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Moratorium Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ALTER COLUMN `target_dataset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Target Dataset Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` SET TAGS ('dbx_subdomain' = 'access_management');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Access Request Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `data_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Target Dataset Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `amended_access_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `access_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Access Duration in Months');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `access_grant_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `access_grant_start_date` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Start Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `collaboration_agreement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `commercial_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Use Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `data_return_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Return Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'public|registered|controlled');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `data_use_statement` SET TAGS ('dbx_business_glossary_term' = 'Data Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `dsar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Access Request (DSAR) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|public_task|scientific_research');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `irb_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `phi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|expedited|urgent');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `publication_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Access Request Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^AR-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'new_access|renewal|amendment|emergency_access');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_institution` SET TAGS ('dbx_business_glossary_term' = 'Requester Institution');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Full Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_orcid` SET TAGS ('dbx_business_glossary_term' = 'Requester Open Researcher and Contributor Identifier (ORCID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `requester_orcid` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `research_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Research Purpose Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `research_purpose_category` SET TAGS ('dbx_value_regex' = 'disease_specific|methods_development|population_research|commercial|control');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `target_dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Target Dataset Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Days');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` SET TAGS ('dbx_subdomain' = 'governance_framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `fair_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'FAIR (Findable, Accessible, Interoperable, Reusable) Assessment ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Target Data Asset ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `previous_fair_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `accessible_a1_score` SET TAGS ('dbx_business_glossary_term' = 'Accessible A1 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `accessible_a2_score` SET TAGS ('dbx_business_glossary_term' = 'Accessible A2 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'FAIR Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_identifier` SET TAGS ('dbx_business_glossary_term' = 'FAIR Assessment Business Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_identifier` SET TAGS ('dbx_value_regex' = '^FAIR-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'FAIR Assessment Methodology');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'FAIRsFAIR|RDA_FAIR_Maturity_Indicators|FAIR_Evaluator|Custom_Internal|NIH_DMSP_Checklist');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'FAIR Assessment Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'FAIR Assessment Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected|under_review');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `community_standard_compliance` SET TAGS ('dbx_business_glossary_term' = 'Community Standard Compliance');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `data_license` SET TAGS ('dbx_business_glossary_term' = 'Data Usage License');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `data_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Data Repository URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `elixir_fair_compliant` SET TAGS ('dbx_business_glossary_term' = 'ELIXIR FAIR Data Compliant');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `findable_f1_score` SET TAGS ('dbx_business_glossary_term' = 'Findable F1 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `findable_f2_score` SET TAGS ('dbx_business_glossary_term' = 'Findable F2 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `findable_f3_score` SET TAGS ('dbx_business_glossary_term' = 'Findable F3 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `findable_f4_score` SET TAGS ('dbx_business_glossary_term' = 'Findable F4 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `identified_gaps` SET TAGS ('dbx_business_glossary_term' = 'Identified FAIR Compliance Gaps');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `interoperable_i1_score` SET TAGS ('dbx_business_glossary_term' = 'Interoperable I1 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `interoperable_i2_score` SET TAGS ('dbx_business_glossary_term' = 'Interoperable I2 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `interoperable_i3_score` SET TAGS ('dbx_business_glossary_term' = 'Interoperable I3 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next FAIR Assessment Due Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `nih_dmsp_compliant` SET TAGS ('dbx_business_glossary_term' = 'NIH (National Institutes of Health) DMSP (Data Management and Sharing Policy) Compliant');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `ontology_terms_used` SET TAGS ('dbx_business_glossary_term' = 'Ontology Terms Used');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `overall_fair_maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Overall FAIR Maturity Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `overall_fair_maturity_level` SET TAGS ('dbx_value_regex' = 'not_fair|initial|managed|defined|quantitatively_managed|optimizing');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `overall_fair_score` SET TAGS ('dbx_business_glossary_term' = 'Overall FAIR Composite Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `persistent_identifier_assigned` SET TAGS ('dbx_business_glossary_term' = 'Persistent Identifier Assigned');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `persistent_identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Persistent Identifier Value');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `provenance_documented` SET TAGS ('dbx_business_glossary_term' = 'Provenance Documented');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `recommended_remediation_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Actions');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `reusable_r1_1_score` SET TAGS ('dbx_business_glossary_term' = 'Reusable R1.1 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `reusable_r1_2_score` SET TAGS ('dbx_business_glossary_term' = 'Reusable R1.2 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `reusable_r1_3_score` SET TAGS ('dbx_business_glossary_term' = 'Reusable R1.3 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `reusable_r1_score` SET TAGS ('dbx_business_glossary_term' = 'Reusable R1 Maturity Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `target_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Target Data Asset Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ALTER COLUMN `target_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Target Data Asset Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `parent_schema_metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Schema Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `parent_metadata_schema_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `applicable_data_asset_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Data Asset Types');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `backward_compatible` SET TAGS ('dbx_business_glossary_term' = 'Backward Compatible Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `change_log` SET TAGS ('dbx_business_glossary_term' = 'Change Log');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `controlled_vocabulary_reference` SET TAGS ('dbx_business_glossary_term' = 'Controlled Vocabulary Reference');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `fair_compliance_level` SET TAGS ('dbx_business_glossary_term' = 'FAIR Compliance Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `fair_compliance_level` SET TAGS ('dbx_value_regex' = 'full|partial|minimal|non_compliant');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `interoperability_standard` SET TAGS ('dbx_business_glossary_term' = 'Interoperability Standard');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `is_extensible` SET TAGS ('dbx_business_glossary_term' = 'Is Extensible Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `mandatory_fields` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Fields');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `optional_fields` SET TAGS ('dbx_business_glossary_term' = 'Optional Fields');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `regulatory_alignment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Alignment');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_description` SET TAGS ('dbx_business_glossary_term' = 'Schema Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Schema Documentation Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_format` SET TAGS ('dbx_business_glossary_term' = 'Schema Format');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_name` SET TAGS ('dbx_business_glossary_term' = 'Schema Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_namespace` SET TAGS ('dbx_business_glossary_term' = 'Schema Namespace');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_owner` SET TAGS ('dbx_business_glossary_term' = 'Schema Owner');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_status` SET TAGS ('dbx_business_glossary_term' = 'Schema Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|retired|under_review');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_steward` SET TAGS ('dbx_business_glossary_term' = 'Schema Steward');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_type` SET TAGS ('dbx_business_glossary_term' = 'Schema Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_uri` SET TAGS ('dbx_business_glossary_term' = 'Schema Uniform Resource Identifier (URI)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Schema Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ALTER COLUMN `validation_rules` SET TAGS ('dbx_business_glossary_term' = 'Validation Rules');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` SET TAGS ('dbx_subdomain' = 'governance_framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `regulatory_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `superseded_by_policy_retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `superseded_retention_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `applies_to_phi` SET TAGS ('dbx_business_glossary_term' = 'Applies to Protected Health Information (PHI) Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `applies_to_pii` SET TAGS ('dbx_business_glossary_term' = 'Applies to Personally Identifiable Information (PII) Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `backup_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Backup Retention Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `data_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Data Asset Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `data_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `data_sharing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `disposal_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Disposal Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'secure_deletion|anonymization|archival|physical_destruction|transfer_to_archive');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `fair_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'FAIR (Findable, Accessible, Interoperable, Reusable) Compliance Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `litigation_hold_override` SET TAGS ('dbx_business_glossary_term' = 'Litigation Hold Override Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|superseded');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'regulatory|legal|operational|business|research');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ALTER COLUMN `storage_location_constraint` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Constraint');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` SET TAGS ('dbx_subdomain' = 'governance_framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Impact Assessment (DPIA) ID');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `superseded_dpia_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'DPIA Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'DPIA Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `automated_decision_making_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision Making Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'DPIA Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `cross_border_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Data Transfer Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Involved');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_subject_consultation_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Consultation Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_subject_consultation_summary` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Consultation Summary');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_subjects_description` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_volume_scale` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Scale');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `data_volume_scale` SET TAGS ('dbx_value_regex' = 'small_scale|medium_scale|large_scale|very_large_scale');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `dpo_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Consultation Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `dpo_consultation_outcome` SET TAGS ('dbx_business_glossary_term' = 'DPO Consultation Outcome');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `fair_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `hipaa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `identified_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Risks');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'DPIA Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last DPIA Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Necessity Assessment');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next DPIA Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `processing_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `processing_activity_name` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'DPIA Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^DPIA-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'DPIA Review Frequency');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|ad_hoc|continuous');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `risk_mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Measures');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `special_category_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `special_category_legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Special Category Data Legal Basis');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `supervisory_authority_consultation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `supervisory_authority_response` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Response');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `systematic_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Systematic Monitoring Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `third_party_processors` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Processors');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ALTER COLUMN `transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Mechanism');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Glossary Term Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `parent_glossary_term_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|deprecated|retired');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `change_log` SET TAGS ('dbx_business_glossary_term' = 'Change Log');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Email Address');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `definition` SET TAGS ('dbx_business_glossary_term' = 'Term Definition');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `fair_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'FAIR Compliance Flag (Findable, Accessible, Interoperable, Reusable)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `industry_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Reference');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `linked_attributes` SET TAGS ('dbx_business_glossary_term' = 'Linked Attributes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `linked_data_assets` SET TAGS ('dbx_business_glossary_term' = 'Linked Data Assets');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `owning_domain` SET TAGS ('dbx_business_glossary_term' = 'Owning Domain');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `phi_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `related_terms` SET TAGS ('dbx_business_glossary_term' = 'Related Terms');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `short_definition` SET TAGS ('dbx_business_glossary_term' = 'Short Definition');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Synonyms');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `term_category` SET TAGS ('dbx_business_glossary_term' = 'Term Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Term Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `usage_examples` SET TAGS ('dbx_business_glossary_term' = 'Usage Examples');
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `catalog_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Tag Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Glossary Term Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `parent_tag_catalog_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tag Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `parent_catalog_tag_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `allows_multiple_values` SET TAGS ('dbx_business_glossary_term' = 'Allows Multiple Values');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `applicable_asset_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Types');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required for Tag Application');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `catalog_tag_description` SET TAGS ('dbx_business_glossary_term' = 'Tag Description');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `catalog_tag_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `catalog_tag_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|proposed|retired');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `controlled_vocabulary_source` SET TAGS ('dbx_business_glossary_term' = 'Controlled Vocabulary Source');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restriction Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_value_regex' = 'no_restriction|internal_only|controlled_access|embargo|consent_required');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `display_color` SET TAGS ('dbx_business_glossary_term' = 'Display Color Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `display_color` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `display_icon` SET TAGS ('dbx_business_glossary_term' = 'Display Icon Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `fair_principle_alignment` SET TAGS ('dbx_business_glossary_term' = 'FAIR (Findable, Accessible, Interoperable, Reusable) Principle Alignment');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Tag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `is_system_generated` SET TAGS ('dbx_business_glossary_term' = 'Is System Generated Tag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `ontology_uri` SET TAGS ('dbx_business_glossary_term' = 'Ontology Uniform Resource Identifier (URI)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `owner_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Data Steward Email Address');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `owner_steward_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `owner_steward_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `owner_steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `owner_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Data Steward Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `related_tags` SET TAGS ('dbx_business_glossary_term' = 'Related Tags');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `search_weight` SET TAGS ('dbx_business_glossary_term' = 'Search Weight');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Tag Synonyms');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `tag_category` SET TAGS ('dbx_business_glossary_term' = 'Tag Category');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `tag_category` SET TAGS ('dbx_value_regex' = 'genomics_assay_type|data_use_restriction|fair_principle|sensitivity_level|domain|regulatory_classification');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `tag_code` SET TAGS ('dbx_business_glossary_term' = 'Tag Code');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `tag_level` SET TAGS ('dbx_business_glossary_term' = 'Tag Hierarchy Level');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Tag Usage Count');
ALTER TABLE `genomics_biotech_ecm`.`data`.`catalog_tag` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `asset_tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `catalog_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Tag Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Data Asset Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `parent_assignment_asset_tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `quaternary_asset_deactivated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deactivated By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `quaternary_asset_deactivated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `quaternary_asset_deactivated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `tertiary_asset_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `tertiary_asset_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `tertiary_asset_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `superseded_asset_tag_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|not_required');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assigned_by_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Role');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|rejected|superseded|archived');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'manual|automated|inherited|suggested|bulk_import|system_generated');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Business Criticality');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `classification_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Classification Algorithm');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restriction');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|internal_only|restricted_partners|regulatory_approval_required|prohibited');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `fair_accessible_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Accessible Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `fair_findable_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Findable Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `fair_interoperable_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Interoperable Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `fair_reusable_flag` SET TAGS ('dbx_business_glossary_term' = 'Findable, Accessible, Interoperable, Reusable (FAIR) Reusable Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `gdpr_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `hipaa_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `ontology_term` SET TAGS ('dbx_business_glossary_term' = 'Ontology Term');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `ontology_uri` SET TAGS ('dbx_business_glossary_term' = 'Ontology Uniform Resource Identifier (URI)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `propagation_depth` SET TAGS ('dbx_business_glossary_term' = 'Propagation Depth');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `propagation_flag` SET TAGS ('dbx_business_glossary_term' = 'Propagation Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `quality_dimension` SET TAGS ('dbx_business_glossary_term' = 'Quality Dimension');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `quality_dimension` SET TAGS ('dbx_value_regex' = 'accuracy|completeness|consistency|timeliness|validity|uniqueness');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `retention_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Review Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` SET TAGS ('dbx_subdomain' = 'access_management');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` SET TAGS ('dbx_association_edges' = 'data.genomic_access_control,data.dpia');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `access_control_dpia_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Access Control Dpia Assessment - Access Control Dpia Assessment Id');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Access Control Dpia Assessment - Dpia Id');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Access Control Dpia Assessment - Genomic Access Control Id');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `remediation_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Required');
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_control_dpia_assessment` ALTER COLUMN `risk_level_assigned` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Assigned');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` ALTER COLUMN `dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Dataset Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` ALTER COLUMN `derived_from_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`dataset` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` SET TAGS ('dbx_subdomain' = 'metadata_services');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `data_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Identifier');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `amended_data_use_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `data_access_approver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `data_access_approver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `data_access_approver_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `data_access_approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `signed_by_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `signed_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`data`.`data_use_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_pii_name' = 'true');
