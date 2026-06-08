-- Schema for Domain: databricks_governance | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance` COMMENT 'Added Unity Catalog tags, RLS predicates, SCD Type 2, Delta TBLPROPERTIES, liquid clustering, and HIPAA retention annotations to all tables.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` (
    `uc_tag_definitions_id` BIGINT COMMENT 'Primary key for uc_tag_definitions',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: uc_tag_definitions is currently siloed with no FK connections. Adding universal_controls_id follows the same governance hub pattern used by all peer products (databricks_governance_uc_tag_definitions2',
    `allowed_values` STRING COMMENT 'Pipe-delimited list of permitted values for enum-type tags (e.g., restricted|confidential|internal|public). Empty for freetext or non-enum value types.',
    `audit_frequency` STRING COMMENT 'How frequently objects tagged with this definition should be audited for compliance. Drives automated governance scanning schedules.',
    `catalog_name` STRING COMMENT 'The Unity Catalog catalog where this tag definition is registered. Supports multi-catalog governance in environments with separate catalogs per domain or environment.',
    `column_mask_function` STRING COMMENT 'Fully qualified name of the Unity Catalog column mask function to apply when this tag is present on a column, enabling dynamic data masking for PHI/PII protection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag definition was first registered in Unity Catalog. Used for governance audit trail.',
    `delta_tblproperty_key` STRING COMMENT 'The Delta TBLPROPERTIES key that this tag maps to when applied, enabling automated Delta table configuration (e.g., delta.deletedFileRetentionDuration for retention-tagged tables).',
    `delta_tblproperty_value` STRING COMMENT 'The default Delta TBLPROPERTIES value to set when this tag is applied to a table, enabling governance-driven table configuration automation.',
    `uc_tag_definitions_description` STRING COMMENT 'Detailed business description of the tags purpose, usage guidelines, and governance implications for data stewards and analysts.',
    `display_name` STRING COMMENT 'Human-readable display label for the tag shown in Unity Catalog UI and governance reports.',
    `effective_from_date` DATE COMMENT 'Date from which this tag definition is valid and can be applied to Unity Catalog securables. Supports versioned governance policy rollouts.',
    `effective_to_date` DATE COMMENT 'Date after which this tag definition is no longer valid for new assignments. Null indicates currently active with no planned retirement.',
    `governance_domain` STRING COMMENT 'The healthcare data governance domain this tag applies to (e.g., patient, encounter, clinical, billing). Aligns with the 22 enterprise data domains.',
    `hipaa_relevance` STRING COMMENT 'Maps this tag to a HIPAA data classification tier, indicating whether the tag is used to identify Protected Health Information (PHI), Personally Identifiable Information (PII), Payment Card Industry (PCI) data, or other sensitive categories.',
    `is_inheritable` BOOLEAN COMMENT 'Indicates whether this tag value propagates automatically from parent objects (catalog to schema, schema to table, table to column) in Unity Catalog hierarchy.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this tag must be applied to all objects within its scope before publishing to production catalogs. Enforces governance completeness.',
    `is_system_managed` BOOLEAN COMMENT 'Indicates whether this tag is managed by the Databricks platform (system tags) versus custom-defined by the healthcare organizations governance team.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this tag definition, including changes to allowed values, scope, or metadata.',
    `liquid_clustering_hint` STRING COMMENT 'Recommended liquid clustering column expression for tables tagged with this definition. Guides automated optimization of Delta tables for query performance.',
    `metastore_identifier` STRING COMMENT 'Identifier of the Unity Catalog metastore where this tag definition resides. Enables cross-metastore governance coordination in multi-region healthcare deployments.',
    `notification_on_violation` BOOLEAN COMMENT 'Indicates whether a governance alert should be triggered when an object within scope is missing this required tag or has an invalid tag value.',
    `owning_team` STRING COMMENT 'The data governance team or stewardship group responsible for maintaining this tag definition and its allowed values.',
    `propagation_rule` STRING COMMENT 'Defines how this tag propagates through data lineage in Unity Catalog. Downstream propagation ensures derived datasets inherit PHI/PII classifications from source tables.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or compliance standard this tag supports (e.g., HIPAA, HITRUST CSF, SOC 2, PCI DSS, GDPR). Multiple frameworks separated by pipe delimiter.',
    `retention_policy_code` STRING COMMENT 'Code referencing the applicable HIPAA data retention policy when this tag is applied. Links to organizational retention schedules (e.g., 6-year minimum for PHI under HIPAA).',
    `rls_predicate_template` STRING COMMENT 'Template expression for row-level security predicates that should be applied when this tag is present on a table or column. Used by Databricks dynamic views and RLS policies.',
    `scd_type` STRING COMMENT 'Specifies the Slowly Changing Dimension strategy associated with objects tagged with this definition. Type 2 is standard for PHI audit trail compliance under HIPAA.',
    `sort_order` STRING COMMENT 'Numeric ordering for display purposes when presenting tag definitions in governance dashboards and Unity Catalog UI.',
    `uc_tag_definitions_status` STRING COMMENT 'Current lifecycle status of the tag definition within Unity Catalog governance. Deprecated tags remain for historical reference but cannot be newly applied.',
    `tag_category` STRING COMMENT 'High-level category grouping for the tag definition, used to organize tags by their governance purpose within the Unity Catalog metadata layer.',
    `tag_name` STRING COMMENT 'The unique machine-readable name of the tag as registered in Unity Catalog. Must conform to UC naming rules (lowercase alphanumeric with underscores, max 128 characters).',
    `tag_scope` STRING COMMENT 'The Unity Catalog securable object level at which this tag can be applied (e.g., catalog, schema, table, column, volume, or registered model).',
    `usage_guidance` STRING COMMENT 'Prescriptive guidance for data stewards on when and how to apply this tag, including examples and edge cases specific to healthcare data governance.',
    `value_type` STRING COMMENT 'The expected data type for values assigned to this tag, constraining what values are valid when the tag is applied to a securable object.',
    `version_number` STRING COMMENT 'Sequential version number tracking changes to this tag definition over time. Incremented when allowed values, scope, or governance rules change.',
    CONSTRAINT pk_uc_tag_definitions PRIMARY KEY(`uc_tag_definitions_id`)
) COMMENT 'UC tag definitions for Unity Catalog.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` (
    `rls_predicates_id` BIGINT COMMENT 'Primary key for rls_predicates',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: rls_predicates is currently siloed with no FK connections. Adding universal_controls_id follows the same governance hub pattern used by all peer products (databricks_governance_rls_predicates2, databr',
    `approved_by` STRING COMMENT 'The identity of the compliance officer, data steward, or security administrator who approved this RLS predicate for production enforcement.',
    `delta_tblproperties` STRING COMMENT 'JSON-formatted Delta TBLPROPERTIES metadata associated with this predicates target table, including liquid clustering keys and SCD Type 2 configuration relevant to predicate evaluation.',
    `rls_predicates_description` STRING COMMENT 'Business-friendly explanation of what this RLS predicate does, why it exists, and which compliance requirement it satisfies.',
    `effective_end_date` DATE COMMENT 'The date after which this RLS predicate is no longer enforced. Null indicates an open-ended, indefinitely active predicate.',
    `effective_start_date` DATE COMMENT 'The date from which this RLS predicate becomes active and begins enforcing row-level access controls.',
    `enforcement_mode` STRING COMMENT 'Determines how the predicate is enforced: strict blocks access, permissive logs violations but allows access, audit_only records access patterns without restriction.',
    `hipaa_data_category` STRING COMMENT 'The HIPAA data classification category that this predicate is designed to protect, aligning with organizational data governance policies.',
    `last_evaluated_at` TIMESTAMP COMMENT 'Timestamp of the most recent query execution where this RLS predicate was evaluated, used for monitoring predicate activity and identifying stale rules.',
    `predicate_expression` STRING COMMENT 'The SQL boolean expression that defines the row-level filter condition applied at query time. Example: facility_id IN (SELECT facility_id FROM user_facility_access WHERE user = CURRENT_USER()).',
    `predicate_name` STRING COMMENT 'Human-readable unique name identifying this RLS predicate rule within the Unity Catalog governance framework.',
    `predicate_type` STRING COMMENT 'Classification of the predicate behavior indicating whether it filters rows, masks column values, redacts PHI, restricts access, or applies conditional logic.',
    `principal_identifier` STRING COMMENT 'The specific user, group name, service principal application ID, or role name that this predicate targets. Supports wildcards for group-based policies.',
    `principal_type` STRING COMMENT 'The type of security principal (identity) to which this RLS predicate applies within the Databricks workspace.',
    `priority_order` STRING COMMENT 'Numeric priority determining the order in which overlapping predicates are evaluated. Lower numbers indicate higher priority.',
    `retention_days` STRING COMMENT 'The number of days that audit logs for this predicates enforcement actions must be retained per HIPAA and organizational compliance requirements.',
    `scope` STRING COMMENT 'The hierarchical scope at which this predicate is enforced: individual table, entire schema, full catalog, or logical business domain.',
    `rls_predicates_status` STRING COMMENT 'Current lifecycle state of the RLS predicate indicating whether it is actively enforced, in draft, pending approval, deprecated, or inactive.',
    `target_catalog` STRING COMMENT 'The Databricks Unity Catalog catalog name to which this RLS predicate applies (e.g., healthcare_silver, healthcare_gold).',
    `target_schema` STRING COMMENT 'The schema (database) within the Unity Catalog catalog to which this RLS predicate is bound.',
    `target_table` STRING COMMENT 'The specific table or view within the target schema to which this RLS predicate is applied for row-level filtering.',
    `unity_catalog_tag` STRING COMMENT 'Key-value tag string applied to this predicate within Unity Catalog for governance classification, searchability, and policy grouping (e.g., compliance=hipaa, domain=clinical).',
    CONSTRAINT pk_rls_predicates PRIMARY KEY(`rls_predicates_id`)
) COMMENT 'Sample RLS predicate examples for HIPAA.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` (
    `databricks_governance_delta_tblproperties_id` BIGINT COMMENT 'Primary key for databricks_governance_delta_tblproperties',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: Delta TBLPROPERTIES definitions implement universal governance controls. Each property configuration is governed by a specific control policy.',
    `applied_by` STRING COMMENT 'Identity of the user or service principal that last applied this TBLPROPERTIES configuration.',
    `approval_status` STRING COMMENT 'Governance approval status for this TBLPROPERTIES configuration change, ensuring changes to PHI table properties undergo proper review.',
    `auto_compact_enabled` BOOLEAN COMMENT 'Indicates whether automatic compaction is enabled to consolidate small files after writes.',
    `catalog_name` STRING COMMENT 'Name of the Unity Catalog catalog containing the governed table. Aligns with Databricks three-level namespace (catalog.schema.table).',
    `change_data_feed_enabled` BOOLEAN COMMENT 'Indicates whether Delta Change Data Feed is enabled, allowing downstream consumers to track row-level changes for incremental processing.',
    `column_masking_policy` STRING COMMENT 'Name of the column masking policy applied to sensitive columns in this table (e.g., masking SSN, MRN, or other PHI identifiers for non-privileged users).',
    `compliance_framework` STRING COMMENT 'Primary regulatory compliance framework driving this property configuration. [ENUM-REF-CANDIDATE: HIPAA|HITRUST|SOC2|PCI_DSS|NIST|CMS|GDPR|ISO_27001|STATE_PRIVACY — promote to reference product]',
    `contains_phi` BOOLEAN COMMENT 'Indicates whether this table contains Protected Health Information subject to HIPAA Privacy and Security Rules.',
    `contains_pii` BOOLEAN COMMENT 'Indicates whether this table contains Personally Identifiable Information requiring privacy protections.',
    `data_classification_level` STRING COMMENT 'Overall data classification level assigned to this table per organizational data governance policy, driving access controls and encryption requirements.',
    `data_domain` STRING COMMENT 'The healthcare data domain this table belongs to (e.g., patient, encounter, clinical, billing, pharmacy). Used for domain-based governance and access policies.',
    `data_owner` STRING COMMENT 'Business data owner responsible for the table content, quality, and access authorization decisions.',
    `data_steward` STRING COMMENT 'Technical data steward responsible for day-to-day data quality monitoring and issue resolution for this table.',
    `deleted_file_retention_duration` STRING COMMENT 'Duration for which deleted data files are retained before VACUUM can remove them. Must align with HIPAA retention requirements for PHI tables.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when this TBLPROPERTIES configuration became effective. Supports SCD Type 2 tracking of property changes over time.',
    `effective_to` TIMESTAMP COMMENT 'Timestamp when this TBLPROPERTIES configuration was superseded or retired. NULL indicates currently active configuration.',
    `hipaa_retention_days` STRING COMMENT 'Number of days this table must retain data per HIPAA regulatory requirements. Minimum 2190 days (6 years) for PHI-containing tables per 45 CFR 164.530(j).',
    `is_current` BOOLEAN COMMENT 'Indicates whether this is the currently active TBLPROPERTIES configuration for the table (SCD Type 2 current record flag).',
    `last_applied_timestamp` TIMESTAMP COMMENT 'Timestamp when this property was last successfully applied to the Delta table via ALTER TABLE SET TBLPROPERTIES.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of column names used for liquid clustering on this table (e.g., patient_id,encounter_date).',
    `liquid_clustering_enabled` BOOLEAN COMMENT 'Indicates whether Databricks liquid clustering is enabled for this table, replacing traditional partitioning and ZORDER for improved query performance.',
    `log_retention_duration` STRING COMMENT 'Duration for which Delta transaction log entries are retained (e.g., interval 30 days). Controls time-travel capability window.',
    `min_reader_version` STRING COMMENT 'Minimum Delta Lake reader protocol version required to read this table. Higher versions enable features like column mapping and deletion vectors.',
    `min_writer_version` STRING COMMENT 'Minimum Delta Lake writer protocol version required to write to this table. Higher versions enable features like change data feed and generated columns.',
    `notes` STRING COMMENT 'Free-text notes explaining the business rationale for this property configuration, including any regulatory justification or exception documentation.',
    `optimize_write_enabled` BOOLEAN COMMENT 'Indicates whether auto-optimize write is enabled to coalesce small files during writes for improved read performance.',
    `property_category` STRING COMMENT 'Classification of the property by governance function: retention for data lifecycle, versioning for protocol versions, optimization for performance tuning, security for access controls, compliance for regulatory settings, clustering for liquid clustering configuration.',
    `property_key` STRING COMMENT 'The TBLPROPERTIES key name (e.g., delta.logRetentionDuration, delta.deletedFileRetentionDuration, delta.enableChangeDataFeed). [ENUM-REF-CANDIDATE: delta.logRetentionDuration|delta.deletedFileRetentionDuration|delta.enableChangeDataFeed|delta.autoOptimize.optimizeWrite|delta.autoOptimize.autoCompact|delta.minReaderVersion|delta.minWriterVersion|delta.columnMapping.mode — promote to reference product]',
    `property_value` DECIMAL(18,2) COMMENT 'The configured value for the TBLPROPERTIES key (e.g., interval 30 days, true, 2).',
    `retention_policy_name` STRING COMMENT 'Name of the organizational data retention policy governing this table (e.g., HIPAA_6_Year, CMS_10_Year, Operational_3_Year).',
    `rls_predicate_function` STRING COMMENT 'Name or expression of the row-level security predicate function applied to this table for fine-grained access control based on user attributes (e.g., restricting PHI access by care team membership).',
    `scd_type` STRING COMMENT 'The Slowly Changing Dimension strategy applied to this table: type_1 for overwrite, type_2 for historical versioning with effective dates, type_3 for previous value columns, append_only for immutable event logs, none for static reference data.',
    `schema_name` STRING COMMENT 'Name of the schema (database) within the catalog where the governed table resides.',
    `table_name` STRING COMMENT 'Name of the Delta table to which these TBLPROPERTIES apply.',
    `target_file_size_mb` STRING COMMENT 'Target file size in megabytes for OPTIMIZE operations, balancing read performance with write amplification.',
    `unity_catalog_tag_json` STRING COMMENT 'JSON string containing Unity Catalog key-value tags applied to this table for governance classification, lineage tracking, and discovery (e.g., domain, data_owner, sensitivity_level).',
    `vacuum_frequency_hours` STRING COMMENT 'Recommended frequency in hours for running VACUUM operations on this table to reclaim storage while respecting retention requirements.',
    CONSTRAINT pk_databricks_governance_delta_tblproperties PRIMARY KEY(`databricks_governance_delta_tblproperties_id`)
) COMMENT 'Delta table TBLPROPERTIES for retention and versioning.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` (
    `hipaa_retention_annotations_id` BIGINT COMMENT 'Primary key for hipaa_retention_annotations',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: HIPAA retention annotations implement universal governance controls. Each annotation is governed by a specific control policy.',
    `annotation_code` STRING COMMENT 'Unique business code identifying this retention annotation rule, used as a Unity Catalog tag key for Delta tables.',
    `annotation_description` STRING COMMENT 'Detailed explanation of the retention annotations purpose, scope, and applicability to PHI data assets within the Databricks lakehouse.',
    `annotation_name` STRING COMMENT 'Human-readable name of the HIPAA retention annotation, displayed in Unity Catalog governance dashboards and compliance reports.',
    `applicable_domain` STRING COMMENT 'The healthcare data domain(s) this retention annotation targets (e.g., patient, clinical, billing, pharmacy, radiology, laboratory). Supports comma-separated multi-domain assignment.',
    `applicable_record_type` STRING COMMENT 'The type of health record this annotation applies to (e.g., medical record, billing record, consent form, radiology image, lab result, prescription).',
    `applies_to_minors` BOOLEAN COMMENT 'Indicates whether this retention annotation includes extended retention rules for records of minor patients, which often require retention until age of majority plus standard period.',
    `approval_date` DATE COMMENT 'Date on which this retention annotation was formally approved for enforcement.',
    `approved_by` STRING COMMENT 'Name or title of the authority who approved this retention annotation for production use within the governance framework.',
    `audit_frequency` STRING COMMENT 'How frequently compliance audits verify that data tagged with this annotation adheres to the defined retention and disposal requirements.',
    `data_classification_level` STRING COMMENT 'The data classification tier this annotation applies to, aligning with organizational information security policy and HIPAA sensitivity requirements.',
    `delta_tblproperty_key` STRING COMMENT 'The Delta TBLPROPERTIES key used to embed retention metadata directly into the Delta table definition for automated lifecycle management.',
    `delta_tblproperty_value` DECIMAL(18,2) COMMENT 'The value set for the Delta TBLPROPERTIES retention key, encoding the retention period and disposal action for automated enforcement.',
    `disposal_action` STRING COMMENT 'The action to be taken when the retention period expires: physical deletion, anonymization, archival to cold storage, pseudonymization, or encrypted archival.',
    `disposal_verification_required` BOOLEAN COMMENT 'Indicates whether disposal of data under this annotation requires formal verification and sign-off by a compliance officer or privacy officer.',
    `effective_date` DATE COMMENT 'Date from which this retention annotation becomes active and enforceable within the Unity Catalog governance framework.',
    `enforcement_mode` STRING COMMENT 'How the retention policy is enforced: automated via scheduled jobs, manual review and action, or hybrid combining automated flagging with manual approval.',
    `exception_approval_required` BOOLEAN COMMENT 'Indicates whether any deviation from this retention annotation (early disposal or extended retention) requires formal approval from the Privacy Officer or compliance committee.',
    `expiration_date` DATE COMMENT 'Date after which this retention annotation is no longer active, typically due to regulatory changes or policy updates. NULL indicates no planned expiration.',
    `hipaa_retention_annotations_status` STRING COMMENT 'Current lifecycle status of this retention annotation definition within the governance framework.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this retention annotation to ensure continued alignment with current regulations and organizational policy.',
    `legal_hold_override` BOOLEAN COMMENT 'Indicates whether this annotation can be overridden by a legal hold, suspending the retention clock during litigation or regulatory investigation.',
    `liquid_clustering_recommendation` STRING COMMENT 'Recommended liquid clustering columns for Delta tables under this retention annotation, optimizing query performance for compliance audit and retention lifecycle queries.',
    `next_review_date` DATE COMMENT 'Date by which this retention annotation must be reviewed again, ensuring ongoing regulatory compliance and policy currency.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, implementation guidance, or exception handling instructions for this retention annotation.',
    `notification_days_before_expiry` STRING COMMENT 'Number of days before retention period expiration that automated notifications are sent to data stewards and compliance officers for review.',
    `phi_category` STRING COMMENT 'Category of PHI data to which this retention annotation applies, enabling granular retention policies by data sensitivity type.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulation mandating this retention requirement (e.g., CMS, HHS, state Department of Health, FDA, DEA).',
    `regulatory_citation` STRING COMMENT 'Specific legal citation or regulation section number mandating this retention period (e.g., 45 CFR §164.530(j), 42 CFR §482.24).',
    `responsible_role` STRING COMMENT 'The organizational role responsible for maintaining and enforcing this retention annotation (e.g., Privacy Officer, Chief Compliance Officer, Data Steward, HIM Director).',
    `retention_period_days` STRING COMMENT 'Granular retention period in days for cases where year-level precision is insufficient, such as short-term operational PHI or research interim data.',
    `retention_period_years` STRING COMMENT 'Minimum number of years that data tagged with this annotation must be retained before eligible for disposal, per HIPAA and state law requirements.',
    `retention_start_event` STRING COMMENT 'The business event that triggers the start of the retention clock (e.g., date of last encounter, date of patient death, date of record creation, date of discharge).',
    `rls_predicate_template` STRING COMMENT 'Template SQL predicate for row-level security enforcement on tables tagged with this retention annotation, restricting access based on user attributes and data sensitivity.',
    `scd_type` STRING COMMENT 'The SCD strategy applied to tables governed by this retention annotation, determining how historical versions are maintained in the lakehouse.',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code where this retention rule applies, since state laws may impose longer retention than federal HIPAA minimums. NULL indicates federal-level applicability.',
    `supersedes_annotation_code` STRING COMMENT 'The annotation_code of the previous version that this annotation supersedes, enabling traceability of retention policy evolution.',
    `unity_catalog_tag_key` STRING COMMENT 'The exact tag key name applied to Delta tables and columns in Databricks Unity Catalog to enforce this retention annotation programmatically.',
    `unity_catalog_tag_value` DECIMAL(18,2) COMMENT 'The tag value assigned in Unity Catalog when this retention annotation is applied (e.g., 6_years, 10_years_from_last_encounter).',
    `version_number` STRING COMMENT 'Version number of this retention annotation, incremented when regulatory changes or policy updates require modification of retention parameters.',
    CONSTRAINT pk_hipaa_retention_annotations PRIMARY KEY(`hipaa_retention_annotations_id`)
) COMMENT 'HIPAA retention annotation definitions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`universal_controls` (
    `universal_controls_id` BIGINT COMMENT 'Primary key for universal_controls',
    `catalog_name` STRING COMMENT 'The Databricks Unity Catalog name where this control is registered and enforced.',
    `control_code` STRING COMMENT 'Unique business code for referencing this control in policies and audit trails (e.g., RLS-001, RET-042).',
    `control_name` STRING COMMENT 'Human-readable name of the governance control definition (e.g., PHI Column Masking, HIPAA 6-Year Retention).',
    `control_status` STRING COMMENT 'Current lifecycle status of this governance control definition.',
    `control_type` STRING COMMENT 'Category of the governance control: Unity Catalog tag definition, row-level security predicate, Delta table property, HIPAA retention annotation, liquid clustering configuration, or SCD Type 2 tracking pattern.',
    `data_classification_level` STRING COMMENT 'The data classification level this control enforces or applies to, aligned with organizational data governance policy.',
    `delta_tblproperties_json` STRING COMMENT 'JSON object containing Delta Lake TBLPROPERTIES key-value pairs to apply (e.g., {delta.deletedFileRetentionDuration: interval 180 days, delta.logRetentionDuration: interval 2190 days}).',
    `domain_scope` STRING COMMENT 'The healthcare data domain(s) this control applies to (e.g., patient, clinical, billing). Supports comma-separated values for cross-domain controls.',
    `effective_end_date` DATE COMMENT 'Date after which this governance control is no longer active. Null indicates indefinite applicability.',
    `effective_start_date` DATE COMMENT 'Date from which this governance control becomes active and enforceable.',
    `enforcement_mode` STRING COMMENT 'Whether the control is actively enforced (blocking non-compliant access), in audit-only mode (logging violations without blocking), or disabled.',
    `hipaa_retention_days` STRING COMMENT 'Number of days data must be retained per HIPAA regulations. Standard is 2190 days (6 years) for most PHI; state laws may require longer.',
    `last_review_date` DATE COMMENT 'Date when this governance control was last reviewed for accuracy and regulatory alignment.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of column names used for Delta Lake liquid clustering optimization on target tables (e.g., patient_id, encounter_date).',
    `owner_group` STRING COMMENT 'The organizational group or team responsible for maintaining and reviewing this governance control (e.g., Data Governance Office, Information Security).',
    `priority_rank` STRING COMMENT 'Numeric priority for conflict resolution when multiple controls apply to the same object. Lower numbers take precedence.',
    `retention_policy_reference` STRING COMMENT 'Citation to the specific regulatory or organizational retention policy governing this control (e.g., HIPAA 45 CFR 164.530(j), State of CA H&S Code 123145).',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of this control for continued relevance and compliance alignment.',
    `rls_filter_function` STRING COMMENT 'Fully qualified name of the SQL function implementing the RLS filter logic, registered in Unity Catalog.',
    `rls_predicate_expression` STRING COMMENT 'SQL boolean expression used as a row filter for row-level security enforcement (e.g., facility_id IN (SELECT facility_id FROM user_access WHERE user = CURRENT_USER())).',
    `scd_tracking_columns` STRING COMMENT 'Comma-separated list of columns monitored for changes that trigger SCD Type 2 versioning (e.g., status, address, insurance_plan_id).',
    `scd_type` STRING COMMENT 'The SCD strategy applied to tables governed by this control: Type 1 (overwrite), Type 2 (versioned history), Type 3 (previous value column), or hybrid.',
    `schema_name` STRING COMMENT 'The schema (database) within Unity Catalog to which this control applies. Null indicates catalog-wide applicability.',
    `tag_allowed_values` STRING COMMENT 'Pipe-delimited list of permitted values for the Unity Catalog tag (e.g., restricted|confidential|internal|public). Empty for free-text tags.',
    `tag_key` STRING COMMENT 'The key portion of a Unity Catalog tag definition (e.g., phi_classification, data_owner, retention_days). Applicable when control_type is uc_tag.',
    `target_object_pattern` STRING COMMENT 'Regex or glob pattern identifying the tables, views, or columns this control targets (e.g., *.patient.*, clinical.note_*).',
    `universal_controls_description` STRING COMMENT 'Detailed narrative explaining the purpose, scope, and business rationale for this governance control.',
    CONSTRAINT pk_universal_controls PRIMARY KEY(`universal_controls_id`)
) COMMENT 'Metadata table for UC tag definitions, RLS predicates, Delta TBLPROPERTIES, and HIPAA retention annotations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` (
    `databricks_governance_uc_tag_definitions_id` BIGINT COMMENT 'Primary key for databricks_governance_uc_tag_definitions',
    `databricks_governance_uc_tag_definitions2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.uc_tag_definitions. Business justification: Deployment-specific UC tag definition links to canonical tag definition in uc_tag_definitions. This establishes the prefixed table as an instance/deployment of the canonical definition.',
    `databricks_governance_uc_tag_definitions_description` STRING COMMENT 'UC tag definitions for Unity Catalog',
    `tag_identifier` BIGINT COMMENT 'description',
    `tags` STRING COMMENT 'description',
    CONSTRAINT pk_databricks_governance_uc_tag_definitions PRIMARY KEY(`databricks_governance_uc_tag_definitions_id`)
) COMMENT 'Table defining UC tag definitions for columns.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` (
    `databricks_governance_rls_predicates_id` BIGINT COMMENT 'Primary key for databricks_governance_rls_predicates',
    `databricks_governance_rls_predicates2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.rls_predicates. Business justification: Deployment-specific RLS predicate links to canonical predicate definition in rls_predicates. Establishes the prefixed table as an instance of the canonical definition.',
    `databricks_governance_rls_predicates_description` STRING COMMENT 'RLS predicate examples for row‑level security',
    `predicate_expression` STRING COMMENT 'description',
    `predicate_identifier` BIGINT COMMENT 'description',
    `predicate_sql` STRING COMMENT 'STRING',
    CONSTRAINT pk_databricks_governance_rls_predicates PRIMARY KEY(`databricks_governance_rls_predicates_id`)
) COMMENT 'Table storing example RLS predicate definitions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` (
    `databricks_governance_delta_tblproperties2_id` BIGINT COMMENT 'Primary key for databricks_governance_delta_tblproperties2',
    `databricks_governance_delta_tblproperties_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.databricks_governance_delta_tblproperties. Business justification: Extended Delta TBLPROPERTIES v2 references the base TBLPROPERTIES definition. Establishes version lineage between property definition iterations.',
    `approved_by` STRING COMMENT 'Identity of the governance officer or data owner who approved this property configuration, supporting HIPAA accountability requirements.',
    `auto_compact_enabled` BOOLEAN COMMENT 'Indicates whether automatic compaction (auto-compact) is enabled to consolidate small files after writes.',
    `catalog_name` STRING COMMENT 'Name of the Unity Catalog catalog containing the Delta table. Used for three-level namespace resolution in Databricks governance.',
    `change_reason` STRING COMMENT 'Business justification or reason for the most recent change to this table property configuration.',
    `contains_phi` BOOLEAN COMMENT 'Indicates whether this Delta table contains Protected Health Information subject to HIPAA privacy and security rules.',
    `contains_pii` BOOLEAN COMMENT 'Indicates whether this Delta table contains Personally Identifiable Information requiring privacy protections.',
    `data_classification_level` STRING COMMENT 'The data classification level assigned to the table per organizational information security policy, determining access controls and handling requirements.',
    `data_owner` STRING COMMENT 'The business data owner responsible for the table content, data quality, and access authorization decisions.',
    `data_steward` STRING COMMENT 'The data steward responsible for day-to-day data quality management and metadata maintenance of this table.',
    `databricks_governance_delta_tblproperties2_status` STRING COMMENT 'Current status of this table property configuration record.',
    `deleted_file_retention_duration` STRING COMMENT 'Duration for which deleted data files are retained before physical removal, supporting time travel and HIPAA audit requirements.',
    `domain_name` STRING COMMENT 'The healthcare business domain this table belongs to (e.g., patient, encounter, clinical, billing, pharmacy) for governance and ownership tracking.',
    `effective_date` DATE COMMENT 'Date when this table property configuration became effective.',
    `expiration_date` DATE COMMENT 'Date when this table property configuration expires or requires review. Null for indefinite configurations.',
    `hipaa_retention_days` STRING COMMENT 'Number of days data must be retained per HIPAA regulations. Healthcare organizations must retain PHI for a minimum of 6 years (2190 days) from date of creation or last effective date.',
    `is_drift_detected` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between the configured property value and the actual Delta table property during the last validation.',
    `is_liquid_clustering_enabled` BOOLEAN COMMENT 'Indicates whether liquid clustering is enabled for this Delta table to support automatic data layout optimization.',
    `is_rls_enabled` BOOLEAN COMMENT 'Indicates whether row-level security predicates are actively enforced on this Delta table.',
    `last_validated_timestamp` TIMESTAMP COMMENT 'Timestamp when this property configuration was last validated against the actual Delta table settings for drift detection.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of columns used for Delta Lake liquid clustering to optimize query performance without manual partitioning.',
    `log_retention_duration` STRING COMMENT 'Duration for which Delta transaction log entries are retained, enabling time travel queries and audit trail compliance.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the table property configuration, exceptions, or special handling instructions.',
    `optimize_write_enabled` BOOLEAN COMMENT 'Indicates whether Delta auto-optimize write is enabled to coalesce small files during writes for improved read performance.',
    `property_category` STRING COMMENT 'Classification category of the table property for governance grouping (retention, clustering, optimization, security, compliance, performance).',
    `property_key` STRING COMMENT 'The key name of the Delta TBLPROPERTIES setting (e.g., delta.deletedFileRetentionDuration, delta.logRetentionDuration, delta.autoOptimize.optimizeWrite).',
    `property_value` DECIMAL(18,2) COMMENT 'The configured value for the Delta table property key (e.g., interval 30 days, true, 365 days).',
    `retention_policy_name` STRING COMMENT 'Name of the organizational data retention policy governing this table (e.g., PHI-6Year, Financial-7Year, Research-Indefinite).',
    `rls_predicate_expression` STRING COMMENT 'SQL predicate expression used for row-level security filtering in Unity Catalog. Restricts data access based on user attributes (e.g., facility_id = current_user_facility()).',
    `scd_type` STRING COMMENT 'The Slowly Changing Dimension strategy applied to this table for tracking historical changes (Type 1 overwrites, Type 2 adds versioned rows, Type 3 adds previous-value columns).',
    `schema_name` STRING COMMENT 'Name of the schema (database) within the catalog where the Delta table resides.',
    `source_system` STRING COMMENT 'The operational source system that populates the Delta table (e.g., Epic EHR, Cerner Millennium, SAP S/4HANA) for lineage tracking.',
    `table_name` STRING COMMENT 'Name of the Delta table to which these properties apply.',
    `target_file_size_bytes` BIGINT COMMENT 'Target file size in bytes for Delta optimize operations, balancing read performance with write amplification.',
    `unity_catalog_tag_json` STRING COMMENT 'JSON string containing Unity Catalog governance tags applied to this table (e.g., data_classification, phi_indicator, domain, owner). Stored as string to avoid complex types.',
    CONSTRAINT pk_databricks_governance_delta_tblproperties2 PRIMARY KEY(`databricks_governance_delta_tblproperties2_id`)
) COMMENT 'Table storing Delta table properties such as retention and clustering.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` (
    `databricks_governance_uc_tag_definitions2_id` BIGINT COMMENT 'Primary key for uc_tag_definitions',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: UC tag definitions implement universal governance controls. universal_controls is the master governance control table that consolidates all patterns. Each tag definition is governed by a specific cont',
    `allowed_values` STRING COMMENT 'Pipe-delimited list of allowed enumerated values for this tag when data_type is enum. Empty if the tag accepts free-form values. Example: restricted|confidential|internal|public for data classification tags.',
    `audit_frequency` STRING COMMENT 'How often tag assignments should be reviewed for accuracy and completeness. Drives governance audit scheduling for HIPAA and Joint Commission compliance.',
    `catalog_name` STRING COMMENT 'The Unity Catalog catalog where this tag definition is registered. Supports multi-catalog governance in environments with separate catalogs per domain or environment.',
    `column_mask_function` STRING COMMENT 'Fully qualified name of the Unity Catalog column mask function to apply when this tag is present on a column. Used for dynamic data masking of PHI/PII columns based on user privileges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag definition was first created in the governance catalog. Supports audit trail for tag lifecycle management.',
    `data_type` STRING COMMENT 'The expected data type for values assigned to this tag. Constrains what values can be set when the tag is applied to a securable object.',
    `delta_tblproperty_key` STRING COMMENT 'The Delta TBLPROPERTIES key that this tag maps to when applied to a table. Enables automatic propagation of governance metadata into Delta table properties (e.g., delta.deletedFileRetentionDuration, delta.logRetentionDuration).',
    `delta_tblproperty_value` DECIMAL(18,2) COMMENT 'The default value to set for the associated Delta TBLPROPERTIES key when this tag is applied. Supports automated governance enforcement through table property configuration.',
    `display_name` STRING COMMENT 'Human-readable display label for the tag shown in Unity Catalog UI and governance reports.',
    `effective_from` DATE COMMENT 'Date from which this tag definition becomes available for use in Unity Catalog. Supports phased rollout of new governance tags across the healthcare data platform.',
    `effective_from_date` DATE COMMENT 'Date from which this tag definition is valid and can be applied to Unity Catalog securables. Supports versioned governance policy rollouts.',
    `effective_to_date` DATE COMMENT 'Date after which this tag definition is no longer valid for new assignments. Null indicates currently active with no planned retirement.',
    `effective_until` DATE COMMENT 'Date after which this tag definition is no longer valid for new assignments. Null indicates the tag has no planned retirement date.',
    `governance_domain` STRING COMMENT 'The healthcare data domain this tag definition is primarily associated with (e.g., patient, clinical, billing, pharmacy). Aligns with the 22 enterprise data domains for domain-level governance reporting.',
    `hipaa_relevance` STRING COMMENT 'Maps this tag to a HIPAA data protection category, indicating whether the tag is used to identify Protected Health Information (PHI), Personally Identifiable Information (PII), Payment Card Industry (PCI) data, other sensitive data, or is not privacy-related.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this record represents the current active version of the tag definition (true) or a historical version (false). Supports SCD Type 2 pattern for governance metadata versioning.',
    `is_inheritable` BOOLEAN COMMENT 'Indicates whether this tag value propagates automatically from parent securables (catalog to schema, schema to table, table to column) in Unity Catalog hierarchy.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this tag must be applied to all securables within its scope before a data asset can be promoted to production. Supports mandatory governance tagging policies.',
    `is_system_managed` BOOLEAN COMMENT 'Indicates whether this tag is automatically managed by the platform (true) or manually assigned by data stewards (false). System-managed tags are populated by automated governance pipelines.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this tag definition. Tracks governance metadata changes for compliance audit purposes.',
    `liquid_clustering_hint` STRING COMMENT 'Comma-separated list of recommended clustering columns when this tag is applied to a table. Guides Delta liquid clustering configuration for optimal query performance on healthcare workloads (e.g., patient_id,encounter_date).',
    `metastore_identifier` STRING COMMENT 'Identifier of the Unity Catalog metastore where this tag definition resides. Enables cross-metastore governance coordination in multi-region healthcare deployments.',
    `notification_on_violation` BOOLEAN COMMENT 'Indicates whether a governance alert should be triggered when an object within scope is missing this required tag or has an invalid tag value.',
    `owner_group` STRING COMMENT 'The organizational group or team responsible for maintaining this tag definition (e.g., Data Governance Office, Privacy Office, Security Team, Clinical Informatics). Establishes accountability for tag lifecycle management.',
    `owning_team` STRING COMMENT 'The data governance team or stewardship group responsible for maintaining this tag definition and its allowed values.',
    `propagation_policy` STRING COMMENT 'Defines how tag values behave when inherited across the Unity Catalog hierarchy. Inherit copies parent value; override allows child to replace; merge combines parent and child values; none prevents propagation.',
    `propagation_rule` STRING COMMENT 'Defines how this tag propagates through data lineage in Unity Catalog. Downstream propagation ensures derived datasets inherit PHI/PII classifications from source tables.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or standard this tag supports (e.g., HIPAA, HITRUST CSF, SOC 2, PCI DSS, GDPR, Joint Commission). Links governance tags to specific compliance obligations.',
    `retention_days` STRING COMMENT 'Default data retention period in days associated with this tag for HIPAA compliance. When applied to a table, signals the minimum retention requirement (e.g., 2555 days for 7-year medical record retention).',
    `retention_policy_code` STRING COMMENT 'Code referencing the applicable HIPAA data retention policy when this tag is applied. Links to organizational retention schedules (e.g., 6-year minimum for PHI under HIPAA).',
    `rls_predicate_template` STRING COMMENT 'Optional SQL predicate template associated with this tag for Row-Level Security enforcement. When this tag is applied to a table, the RLS predicate is activated to filter rows based on user context (e.g., facility access, care team membership).',
    `scd_type` STRING COMMENT 'Indicates the SCD strategy associated with this tag when applied to tables. Governs how historical changes are tracked in the Delta lakehouse (Type 1 overwrite, Type 2 versioned rows, Type 3 previous value column, or full snapshot).',
    `sort_order` STRING COMMENT 'Numeric ordering for display purposes in governance dashboards and tag selection interfaces. Lower numbers appear first within a tag category.',
    `tag_category` STRING COMMENT 'High-level category grouping for the tag definition, used to organize tags by their governance purpose within the Unity Catalog metadata layer.',
    `tag_name` STRING COMMENT 'The unique machine-readable name of the tag as registered in Unity Catalog. Must conform to UC naming rules (lowercase alphanumeric with underscores, max 128 characters).',
    `tag_scope` STRING COMMENT 'The Unity Catalog securable object level at which this tag can be applied (e.g., catalog, schema, table, column, volume, or registered model).',
    `uc_tag_definitions_description` STRING COMMENT 'Detailed business description of the tags purpose, usage guidelines, and governance implications. Displayed to data stewards and analysts when applying or reviewing tags in Unity Catalog.',
    `uc_tag_definitions_status` STRING COMMENT 'Current lifecycle status of the tag definition. Active tags can be applied to securables; deprecated tags are being phased out; draft tags are under review; retired tags are no longer available for new assignments.',
    `usage_guidance` STRING COMMENT 'Prescriptive instructions for data stewards on when and how to apply this tag, including examples of correct and incorrect usage in the healthcare data context.',
    `validation_rule` STRING COMMENT 'Regular expression or validation logic applied to tag values at assignment time. Ensures data stewards enter conformant values (e.g., date format for retention dates, valid classification levels).',
    `value_type` STRING COMMENT 'The expected data type for values assigned to this tag, constraining what values are valid when the tag is applied to a securable object.',
    `version_number` STRING COMMENT 'Sequential version number tracking changes to this tag definition over time. Incremented when allowed values, scope, or governance rules change.',
    CONSTRAINT pk_databricks_governance_uc_tag_definitions2 PRIMARY KEY(`databricks_governance_uc_tag_definitions2_id`)
) COMMENT 'Table for UC tag definitions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` (
    `databricks_governance_rls_predicates2_id` BIGINT COMMENT 'Primary key for rls_predicates',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: RLS predicate definitions implement universal governance controls. Each predicate is governed by a specific control policy defined in universal_controls.',
    `approval_date` DATE COMMENT 'Date when this RLS predicate was formally approved for deployment.',
    `approved_by` STRING COMMENT 'The identity of the compliance officer, data steward, or security administrator who approved this RLS predicate for production enforcement.',
    `audit_log_enabled` BOOLEAN COMMENT 'Indicates whether access attempts filtered by this predicate are logged to the Unity Catalog audit log for compliance monitoring.',
    `catalog_name` STRING COMMENT 'Name of the Databricks Unity Catalog where this RLS predicate is applied.',
    `column_mask_function_name` STRING COMMENT 'Fully qualified name of the SQL function registered in Unity Catalog that implements column masking logic for sensitive attributes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RLS predicate record was first created in the governance catalog.',
    `data_domain` STRING COMMENT 'The healthcare data domain this predicate protects (e.g., patient, clinical, billing, pharmacy, laboratory, radiology).',
    `delta_tblproperties` STRING COMMENT 'JSON-formatted Delta TBLPROPERTIES metadata associated with this predicates target table, including liquid clustering keys and SCD Type 2 configuration relevant to predicate evaluation.',
    `department_scope` STRING COMMENT 'Department-level scope restriction defining which clinical or administrative departments this predicate covers.',
    `effective_end_date` DATE COMMENT 'The date after which this RLS predicate is no longer enforced. Null indicates an open-ended, indefinitely active predicate.',
    `effective_start_date` DATE COMMENT 'The date from which this RLS predicate becomes active and begins enforcing row-level access controls.',
    `enforcement_mode` STRING COMMENT 'Determines how the predicate is enforced: strict blocks access, permissive logs violations but allows access, audit_only records access patterns without restriction.',
    `facility_scope` STRING COMMENT 'Comma-separated list of facility identifiers or wildcard pattern defining the organizational scope of this predicate (e.g., specific hospitals, clinics, or care sites).',
    `filter_function_name` STRING COMMENT 'Fully qualified name of the SQL function registered in Unity Catalog that implements the row filter logic.',
    `hipaa_category` STRING COMMENT 'HIPAA data classification category that this predicate is designed to protect, aligning with PHI, PII, PCI, or general sensitive data.',
    `hipaa_data_category` STRING COMMENT 'The HIPAA data classification category that this predicate is designed to protect, aligning with organizational data governance policies.',
    `is_default_predicate` BOOLEAN COMMENT 'Indicates whether this predicate serves as the default row filter when no more specific predicate matches the requesting principal.',
    `justification` STRING COMMENT 'Business rationale documenting why this RLS predicate was created, supporting HIPAA minimum necessary compliance and audit requirements.',
    `last_evaluated_at` TIMESTAMP COMMENT 'Timestamp of the most recent query execution where this RLS predicate was evaluated, used for monitoring predicate activity and identifying stale rules.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this predicate to ensure continued appropriateness and HIPAA compliance.',
    `next_review_date` DATE COMMENT 'Date when this predicate is next due for periodic compliance review.',
    `predicate_expression` STRING COMMENT 'The SQL boolean expression that defines the row-level filter condition applied at query time. Example: facility_id IN (SELECT facility_id FROM user_facility_access WHERE user = CURRENT_USER()).',
    `predicate_name` STRING COMMENT 'Human-readable unique name identifying this RLS predicate rule within the Unity Catalog governance framework.',
    `predicate_type` STRING COMMENT 'Classification of the predicate behavior indicating whether it filters rows, masks column values, redacts PHI, restricts access, or applies conditional logic.',
    `principal_identifier` STRING COMMENT 'The specific user, group name, service principal application ID, or role name that this predicate targets. Supports wildcards for group-based policies.',
    `principal_type` STRING COMMENT 'The type of security principal (identity) to which this RLS predicate applies within the Databricks workspace.',
    `priority_order` STRING COMMENT 'Numeric priority determining the order in which overlapping predicates are evaluated. Lower numbers indicate higher priority.',
    `retention_days` STRING COMMENT 'The number of days that audit logs for this predicates enforcement actions must be retained per HIPAA and organizational compliance requirements.',
    `rls_predicates_description` STRING COMMENT 'Business-friendly explanation of what this RLS predicate does, why it exists, and which compliance requirement it satisfies.',
    `rls_predicates_status` STRING COMMENT 'Current lifecycle state of the RLS predicate indicating whether it is actively enforced, in draft, pending approval, deprecated, or inactive.',
    `schema_name` STRING COMMENT 'Name of the schema (database) within the Unity Catalog where the target table resides.',
    `scope` STRING COMMENT 'The hierarchical scope at which this predicate is enforced: individual table, entire schema, full catalog, or logical business domain.',
    `source_policy_reference` STRING COMMENT 'Reference to the organizational data governance policy or HIPAA policy document that mandates this row-level security control.',
    `table_name` STRING COMMENT 'Name of the table to which this row-level security predicate is applied for data access filtering.',
    `target_catalog` STRING COMMENT 'The Databricks Unity Catalog catalog name to which this RLS predicate applies (e.g., healthcare_silver, healthcare_gold).',
    `target_principal_name` STRING COMMENT 'Name or identifier of the security principal (user, group, or service principal) that this predicate governs.',
    `target_principal_type` STRING COMMENT 'Type of security principal (user, group, or service principal) to which this RLS predicate applies.',
    `target_schema` STRING COMMENT 'The schema (database) within the Unity Catalog catalog to which this RLS predicate is bound.',
    `target_table` STRING COMMENT 'The specific table or view within the target schema to which this RLS predicate is applied for row-level filtering.',
    `unity_catalog_tag` STRING COMMENT 'Key-value tag string applied to this predicate within Unity Catalog for governance classification, searchability, and policy grouping (e.g., compliance=hipaa, domain=clinical).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RLS predicate record was last modified.',
    CONSTRAINT pk_databricks_governance_rls_predicates2 PRIMARY KEY(`databricks_governance_rls_predicates2_id`)
) COMMENT 'Table for RLS predicate examples.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` (
    `databricks_governance_delta_tblproperties3_id` BIGINT COMMENT 'Primary key for databricks_governance_delta_tblproperties3',
    `databricks_governance_delta_tblproperties_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.databricks_governance_delta_tblproperties. Business justification: Extended Delta TBLPROPERTIES v3 references the base TBLPROPERTIES definition. Establishes version lineage between property definition iterations.',
    `approval_date` DATE COMMENT 'Date when this TBLPROPERTIES configuration was formally approved through the governance review process.',
    `approval_status` STRING COMMENT 'Approval status of this configuration change within the data governance review workflow.',
    `approved_by` STRING COMMENT 'Identity of the data governance officer or committee member who approved this TBLPROPERTIES configuration.',
    `auto_compact_enabled` BOOLEAN COMMENT 'Whether automatic small file compaction is enabled after writes to maintain optimal file sizes for query performance.',
    `auto_optimize_write_enabled` BOOLEAN COMMENT 'Whether Delta auto-optimize for write operations is enabled, coalescing small files automatically during writes.',
    `catalog_name` STRING COMMENT 'Name of the Databricks Unity Catalog where the governed table resides. Used to scope governance policies to the correct catalog boundary.',
    `change_data_feed_enabled` BOOLEAN COMMENT 'Whether Delta Change Data Feed is enabled to capture row-level changes for downstream CDC processing and audit compliance.',
    `checkpoint_interval` STRING COMMENT 'Number of Delta commits between automatic checkpoints. Controls metadata read performance for large tables.',
    `column_mask_function` STRING COMMENT 'Name of the Unity Catalog column masking function applied to sensitive PHI/PII columns in this table for dynamic data masking.',
    `compliance_framework` STRING COMMENT 'Primary regulatory compliance framework driving this table property configuration. [ENUM-REF-CANDIDATE: HIPAA|HITRUST|SOC2|NIST|PCI_DSS|ISO_27001|GDPR|STATE_PRIVACY — promote to reference product]',
    `contains_phi_flag` BOOLEAN COMMENT 'Indicates whether this table contains Protected Health Information subject to HIPAA Privacy and Security Rules.',
    `contains_pii_flag` BOOLEAN COMMENT 'Indicates whether this table contains Personally Identifiable Information requiring enhanced access controls and audit logging.',
    `data_classification_level` STRING COMMENT 'Security classification level assigned to this table per organizational data governance policy, driving access controls and encryption requirements.',
    `data_owner` STRING COMMENT 'Business data owner responsible for this tables content, quality, and access authorization decisions.',
    `data_steward` STRING COMMENT 'Technical data steward responsible for day-to-day data quality management and metadata maintenance of this table.',
    `databricks_governance_delta_tblproperties3_status` STRING COMMENT 'Current status of this TBLPROPERTIES configuration record indicating whether it is actively enforced.',
    `deleted_file_retention_duration` STRING COMMENT 'Duration for which deleted data files are retained before physical removal, enabling time travel and compliance with HIPAA data retention mandates.',
    `domain_name` STRING COMMENT 'The healthcare data domain this table belongs to (e.g., patient, encounter, clinical, billing) for Unity Catalog domain-based governance.',
    `effective_from_date` DATE COMMENT 'Date from which this TBLPROPERTIES configuration becomes effective and is enforced on the target table.',
    `effective_to_date` DATE COMMENT 'Date until which this TBLPROPERTIES configuration remains effective. NULL indicates currently active with no planned expiration.',
    `enable_deletion_vectors` BOOLEAN COMMENT 'Whether deletion vectors are enabled for this table to improve DELETE/UPDATE/MERGE performance without rewriting entire files.',
    `hipaa_retention_days` STRING COMMENT 'Number of days this table must retain data per HIPAA regulatory requirements. Drives delta.logRetentionDuration and delta.deletedFileRetentionDuration settings. Minimum 2,190 days (6 years) for covered entities.',
    `last_applied_timestamp` TIMESTAMP COMMENT 'Timestamp when this TBLPROPERTIES configuration was last successfully applied to the target Delta table via ALTER TABLE SET TBLPROPERTIES.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of column names used for liquid clustering on this Delta table (e.g., patient_id,encounter_date).',
    `liquid_clustering_enabled` BOOLEAN COMMENT 'Indicates whether Delta Lake liquid clustering is enabled for this table to optimize query performance without manual partitioning.',
    `log_retention_duration` STRING COMMENT 'Duration for which Delta transaction log entries are retained. Must meet or exceed HIPAA minimum retention requirements for PHI-containing tables.',
    `min_reader_version` STRING COMMENT 'Minimum Delta Lake reader protocol version required to read this table, controlling feature compatibility.',
    `min_writer_version` STRING COMMENT 'Minimum Delta Lake writer protocol version required to write to this table, controlling feature compatibility.',
    `notes` STRING COMMENT 'Free-text notes documenting the business rationale or technical justification for this TBLPROPERTIES configuration.',
    `property_category` STRING COMMENT 'Classification category of the Delta table property for governance grouping and reporting purposes.',
    `property_key` STRING COMMENT 'The key name of the Delta TBLPROPERTIES setting (e.g., delta.autoOptimize.optimizeWrite, delta.logRetentionDuration, delta.deletedFileRetentionDuration, delta.enableChangeDataFeed).',
    `property_value` DECIMAL(18,2) COMMENT 'The configured value for the Delta TBLPROPERTIES key (e.g., true, 30 days, interval 7 days).',
    `rls_policy_name` STRING COMMENT 'Name of the row-level security policy applied to this table within Unity Catalog for HIPAA minimum necessary access enforcement.',
    `rls_predicate_expression` STRING COMMENT 'SQL predicate expression used for row-level security filtering on this table, restricting data access based on user attributes (e.g., care_site_id, department_id).',
    `scd_type` STRING COMMENT 'Indicates the Slowly Changing Dimension strategy applied to this table for historical data tracking. Type 2 is standard for PHI audit trail compliance.',
    `schema_name` STRING COMMENT 'Name of the schema (database) within the Unity Catalog that contains the governed table.',
    `table_name` STRING COMMENT 'Fully qualified name of the Delta table to which these TBLPROPERTIES settings apply.',
    `target_file_size_bytes` BIGINT COMMENT 'Target file size in bytes for optimize and auto-compact operations to achieve optimal query performance.',
    `unity_catalog_tag_json` STRING COMMENT 'JSON-formatted string of key-value tags applied to this table in Unity Catalog for governance classification (e.g., domain, data_owner, compliance_framework).',
    `vacuum_retention_hours` STRING COMMENT 'Number of hours of data file retention before VACUUM can permanently remove unreferenced files. Must align with HIPAA retention requirements for PHI tables.',
    CONSTRAINT pk_databricks_governance_delta_tblproperties3 PRIMARY KEY(`databricks_governance_delta_tblproperties3_id`)
) COMMENT 'Table for Delta TBLPROPERTIES settings.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` (
    `databricks_governance_hipaa_retention_annotations_id` BIGINT COMMENT 'Primary key for databricks_governance_hipaa_retention_annotations',
    `hipaa_retention_annotations_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.hipaa_retention_annotations. Business justification: Deployment-specific HIPAA retention annotation links to canonical annotation definition. Establishes the prefixed table as an instance of the canonical definition.',
    `annotation_identifier` BIGINT COMMENT 'description',
    `databricks_governance_hipaa_retention_annotations_description` STRING COMMENT 'HIPAA retention annotations for audit‑ready tables',
    `retention_period` STRING COMMENT 'STRING',
    `retention_policy` STRING COMMENT 'description',
    CONSTRAINT pk_databricks_governance_hipaa_retention_annotations PRIMARY KEY(`databricks_governance_hipaa_retention_annotations_id`)
) COMMENT 'HIPAA retention annotation definitions table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` (
    `rls_examples_id` BIGINT COMMENT 'Primary key for rls_examples',
    `databricks_governance_rls_predicates2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.rls_predicates. Business justification: RLS examples demonstrate specific predicate patterns defined in rls_predicates. Each example implements/illustrates a canonical predicate definition. Example-specific fields (example_sql, test_query, ',
    `access_pattern` STRING COMMENT 'The access control pattern this RLS example demonstrates, indicating the dimension along which row-level filtering is applied.',
    `access_role` STRING COMMENT 'The security role or group to which this RLS predicate example applies (e.g., clinical_staff, billing_analyst, facility_admin).',
    `applicable_regulation` STRING COMMENT 'The primary regulatory framework driving this RLS requirement (e.g., HIPAA, 42 CFR Part 2, state privacy law, HITRUST CSF).',
    `approval_required` BOOLEAN COMMENT 'Indicates whether changes to this RLS rule require formal approval from the privacy officer or security committee before deployment.',
    `data_classification` STRING COMMENT 'The data classification level of the data being protected by this RLS rule, determining the sensitivity tier.',
    `data_domain` STRING COMMENT 'The healthcare data domain this RLS rule protects (e.g., patient, clinical, billing, pharmacy, laboratory). Aligns with the 22 enterprise data domains.',
    `delta_tblproperties_json` STRING COMMENT 'JSON representation of Delta TBLPROPERTIES relevant to this RLS rule, including liquid clustering keys and optimization hints for the protected table.',
    `effective_end_date` DATE COMMENT 'Date after which this RLS rule example is no longer effective. Null indicates the rule is open-ended.',
    `effective_start_date` DATE COMMENT 'Date from which this RLS rule example becomes effective and should be enforced in the governance framework.',
    `enforcement_mode` STRING COMMENT 'Current enforcement mode of the RLS predicate: enforced blocks access, audit_only logs without blocking, disabled turns off the rule, testing validates without production impact.',
    `example_sql` STRING COMMENT 'Complete SQL example demonstrating how to implement this RLS predicate in Databricks SQL, including CREATE FUNCTION or row filter syntax.',
    `expected_row_count_reduction_pct` DECIMAL(18,2) COMMENT 'The expected percentage of rows filtered out when this RLS predicate is applied, used for performance impact assessment and capacity planning.',
    `hipaa_retention_days` STRING COMMENT 'The minimum retention period in days for the data protected by this RLS rule, as required by HIPAA record retention policies.',
    `last_reviewed_date` DATE COMMENT 'Date when this RLS rule was last reviewed for accuracy and continued applicability as part of periodic access control audits.',
    `liquid_clustering_keys` STRING COMMENT 'Comma-separated list of columns used for Delta liquid clustering on the target table, relevant for RLS predicate performance optimization.',
    `minimum_necessary_scope` STRING COMMENT 'Description of how this RLS rule implements the HIPAA minimum necessary standard, limiting access to only the PHI needed for the users role.',
    `next_review_date` DATE COMMENT 'Date when this RLS rule is next scheduled for periodic review, ensuring ongoing compliance with access control policies.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, implementation guidance, or exception documentation for this RLS rule example.',
    `owner_group` STRING COMMENT 'The governance team or security group responsible for maintaining and approving changes to this RLS rule (e.g., information_security, privacy_office, compliance).',
    `phi_indicator` BOOLEAN COMMENT 'Indicates whether this RLS rule protects data classified as Protected Health Information under HIPAA regulations.',
    `pii_indicator` BOOLEAN COMMENT 'Indicates whether this RLS rule protects data classified as Personally Identifiable Information.',
    `predicate_expression` STRING COMMENT 'The SQL predicate expression that defines the row-level filter logic (e.g., facility_id IN (SELECT facility_id FROM user_facility_access WHERE user = CURRENT_USER())).',
    `priority_order` STRING COMMENT 'Numeric priority determining the order of evaluation when multiple RLS rules apply to the same table. Lower numbers are evaluated first.',
    `rule_code` STRING COMMENT 'Unique business code for the RLS rule example, used for cross-referencing in governance policies and audit trails.',
    `rule_name` STRING COMMENT 'Human-readable name identifying the RLS rule example, used for documentation and governance catalog display.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the RLS rule example within the governance workflow.',
    `rule_type` STRING COMMENT 'Classification of the RLS rule mechanism indicating how data access is controlled at the row level.',
    `scd_type` STRING COMMENT 'The SCD strategy applied to the target table, informing how historical RLS predicate evaluation should handle versioned rows.',
    `target_catalog` STRING COMMENT 'The Unity Catalog catalog name to which this RLS predicate applies (e.g., healthcare_silver, healthcare_gold).',
    `target_column` STRING COMMENT 'The column name used in the RLS filter predicate expression, if the rule filters on a specific column value.',
    `target_schema` STRING COMMENT 'The Unity Catalog schema (database) name to which this RLS predicate applies.',
    `target_table` STRING COMMENT 'The specific table or view name in Unity Catalog to which this RLS predicate is applied.',
    `test_query` STRING COMMENT 'SQL query used to validate that the RLS predicate is correctly filtering rows for the specified role, used in governance testing workflows.',
    `unity_catalog_tag_key` STRING COMMENT 'The Unity Catalog governance tag key associated with this RLS rule for automated policy discovery and classification.',
    `unity_catalog_tag_value` DECIMAL(18,2) COMMENT 'The Unity Catalog governance tag value paired with the tag key, enabling tag-based RLS policy binding.',
    `use_case_description` STRING COMMENT 'Detailed narrative describing the business use case this RLS example addresses, such as facility-based access restriction or department-level PHI segmentation.',
    `version_number` STRING COMMENT 'Version number of this RLS rule definition, incremented each time the predicate expression or scope is modified.',
    CONSTRAINT pk_rls_examples PRIMARY KEY(`rls_examples_id`)
) COMMENT 'Sample RLS predicate examples for role‑based access.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` (
    `hipaa_retention_id` BIGINT COMMENT 'Primary key for hipaa_retention',
    `hipaa_retention_annotations_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.hipaa_retention_annotations. Business justification: HIPAA retention policy instances reference their canonical annotation definition. hipaa_retention tracks applied policies while hipaa_retention_annotations defines the annotation types. Retention-spec',
    `applies_to_minors` BOOLEAN COMMENT 'Indicates whether this retention policy applies to records of minor patients, which often have extended retention requirements (e.g., until age of majority plus standard retention period).',
    `approval_date` DATE COMMENT 'Date on which this retention policy annotation was formally approved for enforcement.',
    `approved_by` STRING COMMENT 'Name or identifier of the compliance officer or governance committee member who approved this retention policy annotation.',
    `automation_job_name` STRING COMMENT 'Name of the Databricks workflow or job responsible for automated enforcement of this retention policy, including archival and disposal operations.',
    `catalog_name` STRING COMMENT 'Name of the Databricks Unity Catalog where the retention-annotated data asset resides.',
    `data_classification_level` STRING COMMENT 'Security classification level of the data asset governed by this retention policy, aligned with organizational data governance framework.',
    `delta_tblproperties_key` STRING COMMENT 'The TBLPROPERTIES key set on the Delta table to encode HIPAA retention metadata for governance automation and compliance scanning.',
    `delta_tblproperties_value` DECIMAL(18,2) COMMENT 'The TBLPROPERTIES value encoding retention period, disposal method, and compliance references for automated governance enforcement on the Delta table.',
    `disposal_certification_required` BOOLEAN COMMENT 'Indicates whether formal certification of data destruction is required upon disposal, typically mandated for restricted PHI data assets.',
    `disposal_method` STRING COMMENT 'Approved method for disposing of data after the retention period expires, ensuring compliance with HIPAA requirements for PHI destruction.',
    `effective_from` DATE COMMENT 'Date from which this HIPAA retention annotation becomes effective and enforceable on the governed data asset.',
    `effective_until` DATE COMMENT 'Date on which this retention annotation expires or is superseded. Null indicates the policy remains in effect indefinitely until explicitly revoked.',
    `enforcement_mechanism` STRING COMMENT 'Method by which the retention policy is enforced on the data asset, whether through automated Delta Lake lifecycle management, manual periodic review, or a combination.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this retention annotation represents an exception to the standard 7-year HIPAA retention period due to state law, research requirements, or other regulatory mandates.',
    `exception_justification` STRING COMMENT 'Documented business or regulatory justification for any deviation from the standard HIPAA retention period, required for audit purposes.',
    `hipaa_retention_status` STRING COMMENT 'Current lifecycle status of the HIPAA retention annotation, indicating whether the policy is actively enforced, under review, or has been superseded.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review confirming that the retention annotation and its enforcement mechanisms are functioning correctly.',
    `last_scan_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated scan that evaluated records in the governed asset against this retention policy.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the data asset is currently under legal hold, which suspends all retention-based disposal actions regardless of retention period expiration.',
    `legal_hold_reason` STRING COMMENT 'Description of the legal matter or litigation requiring the hold, documented for audit trail purposes when disposal is suspended.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of columns used for Delta Lake liquid clustering on the governed table, optimizing query performance for retention-period-based data access patterns.',
    `minimum_retention_date` DATE COMMENT 'Earliest date on which data governed by this policy may be considered for disposal, calculated from the retention start event plus the applicable retention period.',
    `minor_retention_extension_years` STRING COMMENT 'Additional years of retention required for minor patient records beyond the standard period, typically extending until the patient reaches age of majority plus the base retention period.',
    `next_review_date` DATE COMMENT 'Date of the next scheduled compliance review for this retention policy, ensuring periodic validation of retention enforcement.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, implementation guidance, or historical commentary about this retention policy annotation.',
    `owning_department` STRING COMMENT 'Business department or organizational unit that owns the data asset and is accountable for compliance with this retention policy.',
    `phi_category` STRING COMMENT 'Category of PHI contained in the governed data asset, used to determine applicable retention rules and disposal requirements under HIPAA.',
    `policy_code` STRING COMMENT 'Unique business code identifying the retention policy for programmatic reference and Unity Catalog tag assignment.',
    `policy_name` STRING COMMENT 'Human-readable name of the HIPAA retention policy annotation applied to a data asset or table within the Unity Catalog.',
    `policy_type` STRING COMMENT 'Classification of the retention policy by the type of Protected Health Information (PHI) it governs, determining specific retention rules and disposal procedures.',
    `record_count_at_last_scan` BIGINT COMMENT 'Number of records in the governed data asset as of the most recent retention compliance scan, used for capacity planning and disposal impact assessment.',
    `records_eligible_for_disposal` BIGINT COMMENT 'Number of records identified as having exceeded their retention period and eligible for disposal at the last scan, pending legal hold and exception checks.',
    `regulatory_basis` STRING COMMENT 'Specific regulatory citation or legal basis requiring this retention period (e.g., 45 CFR §164.530(j), state medical records retention statute).',
    `responsible_privacy_officer` STRING COMMENT 'Name of the HIPAA Privacy Officer or designated individual responsible for oversight and enforcement of this retention policy.',
    `retention_period_years` STRING COMMENT 'Number of years that records must be retained from the retention start event date, per HIPAA minimum of 6 years for policies and 7 years for medical records depending on state law.',
    `retention_start_event` STRING COMMENT 'The business event that triggers the start of the retention countdown period, determining when the retention clock begins for records governed by this policy.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled compliance reviews of this retention policy annotation.',
    `rls_predicate_expression` STRING COMMENT 'The row-level security predicate applied to the governed table to restrict access to retained PHI data based on user attributes or group membership.',
    `scd_type` STRING COMMENT 'The SCD strategy applied to the governed table, relevant for retention as Type 2 tables retain historical versions that must also comply with HIPAA retention periods.',
    `schema_name` STRING COMMENT 'Name of the schema (database) within the Unity Catalog containing the data asset subject to this retention policy.',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code indicating the jurisdiction whose retention laws apply, as many states require retention periods exceeding the HIPAA federal minimum.',
    `state_retention_override_years` STRING COMMENT 'State-mandated retention period that overrides the federal HIPAA minimum when the state requirement is longer (e.g., 10 years in some states for medical records).',
    `table_name` STRING COMMENT 'Name of the specific Delta table or view within the schema to which this HIPAA retention annotation is applied.',
    `unity_catalog_tag_key` STRING COMMENT 'The key name of the Unity Catalog tag applied to the governed table or column (e.g., hipaa_retention_7_years) for automated governance enforcement.',
    `unity_catalog_tag_value` DECIMAL(18,2) COMMENT 'The value assigned to the Unity Catalog governance tag, typically encoding the retention duration and policy reference for programmatic enforcement.',
    `version_number` STRING COMMENT 'Version number of this retention policy annotation, incremented when policy parameters are modified to maintain full audit history per SCD Type 2 tracking.',
    CONSTRAINT pk_hipaa_retention PRIMARY KEY(`hipaa_retention_id`)
) COMMENT 'HIPAA retention annotation (hipaa_retention_7_years).';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` (
    `databricks_governance_uc_tags_id` BIGINT COMMENT 'Primary key for databricks_governance_uc_tags',
    `databricks_governance_uc_tag_definitions2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.uc_tag_definitions. Business justification: Applied UC tag instances should reference their canonical tag definition. databricks_governance_uc_tags represents tag applications to assets, while uc_tag_definitions defines the tag types. No column',
    `allowed_values` STRING COMMENT 'Pipe-delimited list of permissible values for this tag key when the tag is constrained to an enumeration. Null for free-text tags. Enforced at tag assignment time.',
    `asset_type` STRING COMMENT 'The type of Unity Catalog securable object to which this tag definition applies. Determines the scope and applicability of the tag within the catalog hierarchy. [ENUM-REF-CANDIDATE: catalog|schema|table|view|column|volume|function|model|connection — promote to reference product]',
    `audit_log_enabled` BOOLEAN COMMENT 'Indicates whether access to assets bearing this tag generates detailed audit log entries. Required for HIPAA audit trail compliance on PHI-tagged assets.',
    `business_domain` STRING COMMENT 'The healthcare business domain this tag is associated with (e.g., patient, encounter, clinical, billing, pharmacy). Aligns with the 22 enterprise data domains.',
    `catalog_name` STRING COMMENT 'The name of the Unity Catalog instance where this tag is registered. Supports multi-catalog environments for dev/test/prod separation or organizational boundaries.',
    `column_name` STRING COMMENT 'The specific column name when the tag is applied at column-level granularity. Null for table-level, schema-level, or catalog-level tags.',
    `created_by_principal` STRING COMMENT 'The identity principal (user or service principal) who originally created this tag definition. Supports accountability in governance workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag definition was first created in Unity Catalog. Part of the governance audit trail.',
    `data_classification_level` STRING COMMENT 'The data sensitivity classification level this tag represents or enforces. Aligns with the organizations four-tier data classification framework for HIPAA compliance.',
    `databricks_governance_uc_tags_description` STRING COMMENT 'Human-readable description of the tags purpose, usage guidelines, and governance implications. Displayed in Unity Catalog UI for data consumers and stewards.',
    `delta_tblproperties_json` STRING COMMENT 'JSON-encoded Delta Lake TBLPROPERTIES associated with this tag definition, including optimization hints, auto-compaction settings, and change data feed configuration.',
    `effective_from_date` DATE COMMENT 'The date from which this tag definition becomes active and enforceable. Supports phased governance rollouts and policy versioning.',
    `effective_to_date` DATE COMMENT 'The date after which this tag definition is no longer active. Null for currently active tags. Enables time-bounded governance policies.',
    `enforcement_mode` STRING COMMENT 'Determines whether the tag triggers active enforcement (blocking non-compliant access), audit-only logging, or is temporarily disabled for maintenance.',
    `hipaa_retention_days` STRING COMMENT 'The number of days this tagged data must be retained per HIPAA and organizational retention policies. Drives automated lifecycle management and purge scheduling in Delta Lake.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this tag is mandatory for the specified asset type per organizational governance policy. Required tags trigger compliance alerts if missing.',
    `liquid_clustering_keys` STRING COMMENT 'Comma-separated list of column names recommended for Delta Lake liquid clustering when this tag is applied. Optimizes query performance for common access patterns in healthcare analytics.',
    `masking_policy_name` STRING COMMENT 'Name of the Unity Catalog column masking function applied when this tag is present. Enables dynamic data masking for PHI/PII columns based on user privileges.',
    `object_name` STRING COMMENT 'The fully qualified name of the specific data object (table, view, column, volume, or function) to which this tag instance is applied.',
    `owner_principal` STRING COMMENT 'The identity principal (user, group, or service principal) responsible for maintaining this tag definition and its governance policies.',
    `phi_indicator` BOOLEAN COMMENT 'Flag indicating whether this tag identifies or classifies data as Protected Health Information under HIPAA. Used to enforce PHI-specific access controls and retention policies.',
    `pii_subcategory` STRING COMMENT 'Specific subcategory of PII classification when the tag marks personally identifiable information. Enables granular privacy controls and de-identification workflows. [ENUM-REF-CANDIDATE: pii_name|pii_email|pii_phone|pii_address|pii_identifier|pii_financial|pii_dob|pii_health|pii_biometric|pii_device — promote to reference product]',
    `propagation_rule` STRING COMMENT 'Defines how this tag propagates through data lineage. Controls whether tags flow to downstream consumers, upstream sources, both directions, or remain static.',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework or standard this tag supports (e.g., HIPAA, HITRUST CSF, SOC 2, PCI DSS, state privacy laws). Links governance tags to compliance obligations.',
    `rls_predicate_expression` STRING COMMENT 'The SQL predicate expression used for row-level security filtering when this tag is applied. Enables dynamic data masking and access restriction based on user attributes.',
    `scd_type` STRING COMMENT 'The SCD strategy applied to the tagged asset for historical data tracking. Type 2 is standard for PHI audit trail requirements under HIPAA.',
    `schema_name` STRING COMMENT 'The schema (database) name within the catalog where the tagged asset resides. Null for catalog-level tags.',
    `steward_principal` STRING COMMENT 'The identity principal designated as data steward for assets bearing this tag. Responsible for data quality and compliance oversight.',
    `tag_category` STRING COMMENT 'High-level classification of the tags purpose within the governance framework. Used to group and filter tags by their functional role in the data governance program.',
    `tag_key` STRING COMMENT 'The key name of the Unity Catalog tag as registered in the tag schema. Must conform to Unity Catalog naming rules (lowercase alphanumeric with underscores, max 127 characters). Examples include phi_classification, hipaa_retention_days, data_owner.',
    `tag_scope` STRING COMMENT 'Indicates whether the tag was directly applied to this asset, inherited from a parent object in the catalog hierarchy, or propagated via lineage.',
    `tag_status` STRING COMMENT 'Current lifecycle status of this tag definition within the governance framework. Controls whether the tag is actively enforced, under review, or deprecated.',
    `tag_value` DECIMAL(18,2) COMMENT 'The value assigned to the tag key for a specific data asset. May contain classification levels, retention periods, owner names, or other governance metadata. Maximum 256 characters per Unity Catalog constraints.',
    `updated_by_principal` STRING COMMENT 'The identity principal who last modified this tag definition. Supports change tracking and governance accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag definition was last modified. Tracks governance policy evolution over time.',
    `validation_regex` STRING COMMENT 'Regular expression pattern used to validate tag values at assignment time. Ensures data quality and consistency of governance metadata.',
    `version_number` STRING COMMENT 'Sequential version number for this tag definition. Incremented when tag properties are modified, supporting audit trail and rollback capabilities.',
    CONSTRAINT pk_databricks_governance_uc_tags PRIMARY KEY(`databricks_governance_uc_tags_id`)
) COMMENT 'Add UC tag definitions for Unity Catalog.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` (
    `uc_tag_definition_id` BIGINT COMMENT 'Primary key for uc_tag_definition',
    `databricks_governance_uc_tag_definitions2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.uc_tag_definitions. Business justification: Simplified UC tag definition (singular) references the canonical uc_tag_definitions table. Links the column-level tag definition to the broader tag definition catalog.',
    `allowed_values` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `is_required` BOOLEAN COMMENT 'description',
    `tag_category` STRING COMMENT 'description',
    `tag_definition_identifier` BIGINT COMMENT 'description',
    `uc_tag_definition_description` STRING COMMENT 'description',
    CONSTRAINT pk_uc_tag_definition PRIMARY KEY(`uc_tag_definition_id`)
) COMMENT 'Unity Catalog column-level tag definitions for PHI/PII classification. Maps pii_phi, pii_pii, and pii_sensitive tags to columns enabling dynamic data masking and row-level security policies for HIPAA compliance.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate` (
    `rls_predicate_id` BIGINT COMMENT 'description',
    `databricks_governance_rls_predicates2_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.rls_predicates. Business justification: Simplified RLS predicate (singular) references the canonical rls_predicates table. Links the individual predicate to the broader predicate catalog.',
    `effective_date` DATE COMMENT 'description',
    `expiration_date` DATE COMMENT 'description',
    `filter_purpose` STRING COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `predicate_expression` STRING COMMENT 'description',
    `principal_type` STRING COMMENT 'description',
    CONSTRAINT pk_rls_predicate PRIMARY KEY(`rls_predicate_id`)
) COMMENT 'Row-Level Security predicate definitions for Unity Catalog. Defines filter conditions applied per user group/role to restrict PHI access based on care site, department, or patient consent status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` (
    `databricks_governance_delta_tblproperties4_id` BIGINT COMMENT 'Primary key for databricks_governance_delta_tblproperties4',
    `databricks_governance_delta_tblproperties_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.databricks_governance_delta_tblproperties. Business justification: Extended Delta TBLPROPERTIES v4 references the base TBLPROPERTIES definition. Establishes version lineage between property definition iterations.',
    `auto_optimize_enabled` BOOLEAN COMMENT 'description',
    `databricks_governance_delta_tblproperties4_description` STRING COMMENT 'Delta table properties (OPTIMIZE, ZORDER, etc.)',
    `liquid_clustering_keys` STRING COMMENT 'description',
    `optimize_write_enabled` BOOLEAN COMMENT 'description',
    `property_identifier` BIGINT COMMENT 'description',
    `property_key` STRING COMMENT 'description',
    `property_value` DECIMAL(18,2) COMMENT 'description',
    `scd_type` STRING COMMENT 'description',
    `tblproperties_identifier` BIGINT COMMENT 'description',
    `tblproperties_json` STRING COMMENT 'description',
    CONSTRAINT pk_databricks_governance_delta_tblproperties4 PRIMARY KEY(`databricks_governance_delta_tblproperties4_id`)
) COMMENT 'Delta Lake table properties configuration for healthcare tables. Defines TBLPROPERTIES including liquid clustering keys, optimize write settings, SCD Type 2 merge patterns, and Z-ordering columns for query performance.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` (
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Primary key for hipaa_retention_annotation',
    `hipaa_retention_annotations_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.hipaa_retention_annotations. Business justification: Simplified HIPAA retention annotation (singular) references the canonical hipaa_retention_annotations table. Links the individual annotation to the broader annotation catalog.',
    `destruction_method` STRING COMMENT 'description',
    `legal_hold_eligible` BOOLEAN COMMENT 'description',
    `notes` STRING COMMENT 'description',
    `phi_category` STRING COMMENT 'description',
    `regulatory_basis` STRING COMMENT 'description',
    `retention_annotation_identifier` BIGINT COMMENT 'description',
    `retention_period_years` STRING COMMENT 'description',
    `state_override_years` STRING COMMENT 'description',
    CONSTRAINT pk_hipaa_retention_annotation PRIMARY KEY(`hipaa_retention_annotation_id`)
) COMMENT 'HIPAA data retention policy annotations per table. Defines minimum and maximum retention periods, destruction methods, legal hold applicability, and regulatory basis for healthcare data lifecycle management.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config` (
    `scd_type2_config_id` BIGINT COMMENT 'Primary key for scd_type2_config',
    `scd_configuration_id` BIGINT COMMENT 'description',
    `business_key_columns` STRING COMMENT 'description',
    `merge_key_expression` STRING COMMENT 'description',
    `tracked_columns` STRING COMMENT 'description',
    CONSTRAINT pk_scd_type2_config PRIMARY KEY(`scd_type2_config_id`)
) COMMENT 'SCD Type 2 slowly changing dimension configuration for healthcare dimension tables. Defines which columns trigger new versions, effective date columns, and merge key specifications for Delta Lake MERGE operations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` (
    `liquid_clustering_config_id` BIGINT COMMENT 'Primary key for liquid_clustering_config',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: Liquid clustering configurations implement universal governance controls. Each clustering config is governed by a specific control policy.',
    `clustering_columns` STRING COMMENT 'description',
    `clustering_config_identifier` BIGINT COMMENT 'description',
    `estimated_query_improvement_pct` STRING COMMENT 'description',
    `rationale` STRING COMMENT 'description',
    CONSTRAINT pk_liquid_clustering_config PRIMARY KEY(`liquid_clustering_config_id`)
) COMMENT 'Liquid clustering configuration for Delta Lake tables. Specifies clustering columns optimized for healthcare query patterns such as patient_id, encounter_date, care_site_id for automatic data layout optimization.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration` (
    `scd_configuration_id` BIGINT COMMENT 'description',
    `universal_controls_id` BIGINT COMMENT 'Foreign key linking to databricks_governance.universal_controls. Business justification: SCD configurations implement universal governance controls. Each SCD config is governed by a specific control policy.',
    `business_key_columns` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `hash_diff_enabled` BOOLEAN COMMENT 'description',
    `merge_strategy` STRING COMMENT 'description',
    `scd_type` STRING COMMENT 'description',
    `tracking_columns` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_scd_configuration PRIMARY KEY(`scd_configuration_id`)
) COMMENT 'Defines SCD Type 2 slowly changing dimension configurations for healthcare dimension tables, specifying business key columns, tracking columns, effective date columns, and merge strategies for maintaining full history of patient, provider, and organizational changes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` ADD CONSTRAINT `fk_databricks_governance_uc_tag_definitions_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` ADD CONSTRAINT `fk_databricks_governance_rls_predicates_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_delta_tblproperties_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` ADD CONSTRAINT `fk_databricks_governance_hipaa_retention_annotations_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_uc_tag_definitions_databricks_governance_uc_tag_definitions2_id` FOREIGN KEY (`databricks_governance_uc_tag_definitions2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2`(`databricks_governance_uc_tag_definitions2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_rls_predicates_databricks_governance_rls_predicates2_id` FOREIGN KEY (`databricks_governance_rls_predicates2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2`(`databricks_governance_rls_predicates2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_delta_tblproperties2_databricks_governance_delta_tblproperties_id` FOREIGN KEY (`databricks_governance_delta_tblproperties_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties`(`databricks_governance_delta_tblproperties_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_uc_tag_definitions2_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_rls_predicates2_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_delta_tblproperties3_databricks_governance_delta_tblproperties_id` FOREIGN KEY (`databricks_governance_delta_tblproperties_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties`(`databricks_governance_delta_tblproperties_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_hipaa_retention_annotations_hipaa_retention_annotations_id` FOREIGN KEY (`hipaa_retention_annotations_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations`(`hipaa_retention_annotations_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` ADD CONSTRAINT `fk_databricks_governance_rls_examples_databricks_governance_rls_predicates2_id` FOREIGN KEY (`databricks_governance_rls_predicates2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2`(`databricks_governance_rls_predicates2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ADD CONSTRAINT `fk_databricks_governance_hipaa_retention_hipaa_retention_annotations_id` FOREIGN KEY (`hipaa_retention_annotations_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations`(`hipaa_retention_annotations_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_uc_tags_databricks_governance_uc_tag_definitions2_id` FOREIGN KEY (`databricks_governance_uc_tag_definitions2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2`(`databricks_governance_uc_tag_definitions2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` ADD CONSTRAINT `fk_databricks_governance_uc_tag_definition_databricks_governance_uc_tag_definitions2_id` FOREIGN KEY (`databricks_governance_uc_tag_definitions2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2`(`databricks_governance_uc_tag_definitions2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate` ADD CONSTRAINT `fk_databricks_governance_rls_predicate_databricks_governance_rls_predicates2_id` FOREIGN KEY (`databricks_governance_rls_predicates2_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2`(`databricks_governance_rls_predicates2_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` ADD CONSTRAINT `fk_databricks_governance_databricks_governance_delta_tblproperties4_databricks_governance_delta_tblproperties_id` FOREIGN KEY (`databricks_governance_delta_tblproperties_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties`(`databricks_governance_delta_tblproperties_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` ADD CONSTRAINT `fk_databricks_governance_hipaa_retention_annotation_hipaa_retention_annotations_id` FOREIGN KEY (`hipaa_retention_annotations_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations`(`hipaa_retention_annotations_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config` ADD CONSTRAINT `fk_databricks_governance_scd_type2_config_scd_configuration_id` FOREIGN KEY (`scd_configuration_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration`(`scd_configuration_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` ADD CONSTRAINT `fk_databricks_governance_liquid_clustering_config_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration` ADD CONSTRAINT `fk_databricks_governance_scd_configuration_universal_controls_id` FOREIGN KEY (`universal_controls_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`universal_controls`(`universal_controls_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`databricks_governance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`databricks_governance` SET TAGS ('dbx_domain' = 'databricks_governance');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` ALTER COLUMN `uc_tag_definitions_id` SET TAGS ('dbx_business_glossary_term' = 'uc_tag_definitions Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definitions` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` SET TAGS ('dbx_subdomain' = 'security_policies');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` ALTER COLUMN `rls_predicates_id` SET TAGS ('dbx_business_glossary_term' = 'rls_predicates Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicates` ALTER COLUMN `predicate_expression` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` ALTER COLUMN `databricks_governance_delta_tblproperties_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_delta_tblproperties Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` SET TAGS ('dbx_subdomain' = 'retention_compliance');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` ALTER COLUMN `hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'hipaa_retention_annotations Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`universal_controls` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`universal_controls` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`universal_controls` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'universal_controls Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` ALTER COLUMN `databricks_governance_uc_tag_definitions_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_uc_tag_definitions Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions` ALTER COLUMN `databricks_governance_uc_tag_definitions2_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Tag Definitions Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` SET TAGS ('dbx_subdomain' = 'security_policies');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` ALTER COLUMN `databricks_governance_rls_predicates_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_rls_predicates Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates` ALTER COLUMN `databricks_governance_rls_predicates2_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicates Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` ALTER COLUMN `databricks_governance_delta_tblproperties2_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_delta_tblproperties2 Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` ALTER COLUMN `databricks_governance_delta_tblproperties_id` SET TAGS ('dbx_business_glossary_term' = 'Databricks Governance Delta Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties2` ALTER COLUMN `rls_predicate_expression` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` ALTER COLUMN `databricks_governance_uc_tag_definitions2_id` SET TAGS ('dbx_business_glossary_term' = 'uc_tag_definitions Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` SET TAGS ('dbx_subdomain' = 'security_policies');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` ALTER COLUMN `databricks_governance_rls_predicates2_id` SET TAGS ('dbx_business_glossary_term' = 'rls_predicates Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2` ALTER COLUMN `predicate_expression` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` ALTER COLUMN `databricks_governance_delta_tblproperties3_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_delta_tblproperties3 Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties3` ALTER COLUMN `databricks_governance_delta_tblproperties_id` SET TAGS ('dbx_business_glossary_term' = 'Databricks Governance Delta Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` SET TAGS ('dbx_subdomain' = 'retention_compliance');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` ALTER COLUMN `databricks_governance_hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_hipaa_retention_annotations Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations` ALTER COLUMN `hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Retention Annotations Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` SET TAGS ('dbx_subdomain' = 'security_policies');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` ALTER COLUMN `rls_examples_id` SET TAGS ('dbx_business_glossary_term' = 'rls_examples Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_examples` ALTER COLUMN `databricks_governance_rls_predicates2_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicates Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` SET TAGS ('dbx_subdomain' = 'retention_compliance');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `hipaa_retention_id` SET TAGS ('dbx_business_glossary_term' = 'hipaa_retention Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Retention Annotations Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `responsible_privacy_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention` ALTER COLUMN `responsible_privacy_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` ALTER COLUMN `databricks_governance_uc_tags_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_uc_tags Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags` ALTER COLUMN `databricks_governance_uc_tag_definitions2_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Tag Definitions Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` SET TAGS ('dbx_subdomain' = 'access_classification');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` ALTER COLUMN `uc_tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'uc_tag_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition` ALTER COLUMN `databricks_governance_uc_tag_definitions2_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Tag Definitions Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate` SET TAGS ('dbx_subdomain' = 'security_policies');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate` ALTER COLUMN `databricks_governance_rls_predicates2_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicates Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` ALTER COLUMN `databricks_governance_delta_tblproperties4_id` SET TAGS ('dbx_business_glossary_term' = 'databricks_governance_delta_tblproperties4 Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4` ALTER COLUMN `databricks_governance_delta_tblproperties_id` SET TAGS ('dbx_business_glossary_term' = 'Databricks Governance Delta Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` SET TAGS ('dbx_subdomain' = 'retention_compliance');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'hipaa_retention_annotation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation` ALTER COLUMN `hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Retention Annotations Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config` ALTER COLUMN `scd_type2_config_id` SET TAGS ('dbx_business_glossary_term' = 'scd_type2_config Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` ALTER COLUMN `liquid_clustering_config_id` SET TAGS ('dbx_business_glossary_term' = 'liquid_clustering_config Identifier');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration` SET TAGS ('dbx_subdomain' = 'storage_configuration');
ALTER TABLE `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration` ALTER COLUMN `universal_controls_id` SET TAGS ('dbx_business_glossary_term' = 'Universal Controls Id (Foreign Key)');
