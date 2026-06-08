-- Schema for Domain: implementation | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`implementation` COMMENT '';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`implementation`.`implementation_hipaa_retention_annotations` (
    `implementation_hipaa_retention_annotations_id` BIGINT COMMENT 'Primary key for implementation_hipaa_retention_annotations',
    `annotation_code` STRING COMMENT 'Unique business code identifying this retention annotation rule, used for cross-referencing in Unity Catalog tags and Delta table properties.',
    `annotation_name` STRING COMMENT 'Human-readable name describing the retention annotation rule, used in governance dashboards and compliance reports.',
    `applies_to_historical_data` BOOLEAN COMMENT 'Indicates whether this retention annotation applies retroactively to existing historical data or only to data created after the effective date.',
    `approval_date` DATE COMMENT 'Date when this retention annotation was formally approved and became effective for governance enforcement.',
    `approved_by` STRING COMMENT 'Name or role of the compliance officer, privacy officer, or data governance committee member who approved this retention annotation.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether access to data governed by this annotation must be logged in an audit trail per HIPAA Security Rule requirements.',
    `breach_notification_required` BOOLEAN COMMENT 'Indicates whether unauthorized access to data governed by this annotation triggers HIPAA breach notification requirements under the Breach Notification Rule.',
    `data_domain` STRING COMMENT 'The healthcare data domain to which this retention annotation applies (e.g., patient, encounter, clinical, billing, claim, pharmacy, laboratory, radiology, etc.). [ENUM-REF-CANDIDATE: patient|encounter|provider|clinical|order|pharmacy|laboratory|radiology|scheduling|billing|claim|supply|facility|workforce|quality|research|reference|compliance|finance|insurance|consent|interoperability — promote to reference product]',
    `data_product_name` STRING COMMENT 'The specific data product (table) within the domain that this retention annotation governs, aligned with Unity Catalog naming conventions.',
    `de_identification_method` STRING COMMENT 'The HIPAA-approved de-identification method to be applied when data transitions from active retention to anonymized archive (Safe Harbor removes 18 identifiers; Expert Determination uses statistical methods).',
    `delta_tblproperties_json` STRING COMMENT 'JSON string containing Databricks Delta TBLPROPERTIES to be applied to the governed table, including retention-related settings such as delta.deletedFileRetentionDuration and delta.logRetentionDuration.',
    `disposal_method` STRING COMMENT 'The approved method for disposing of data after the retention period expires, ensuring HIPAA-compliant destruction or de-identification of PHI.',
    `effective_date` DATE COMMENT 'Date from which this retention annotation rule becomes active and enforceable in the data governance framework.',
    `encryption_at_rest_required` BOOLEAN COMMENT 'Indicates whether data governed by this annotation must be encrypted at rest per HIPAA Security Rule addressable implementation specifications.',
    `exception_criteria` STRING COMMENT 'Description of conditions under which the standard retention period may be extended or shortened (e.g., ongoing litigation, research protocols, minor patient records).',
    `expiration_date` DATE COMMENT 'Date after which this retention annotation is no longer valid and must be reviewed or replaced. NULL indicates no expiration (perpetual applicability).',
    `implementation_hipaa_retention_annotations_status` STRING COMMENT 'Current lifecycle status of this retention annotation indicating whether it is actively enforced, in draft, under review, deprecated, or archived.',
    `last_review_date` DATE COMMENT 'Date when this retention annotation was last reviewed by the compliance or privacy officer for accuracy and regulatory alignment.',
    `legal_hold_eligible` BOOLEAN COMMENT 'Indicates whether data governed by this annotation may be subject to legal hold, which suspends the normal retention disposal schedule during litigation or investigation.',
    `liquid_clustering_columns` STRING COMMENT 'Comma-separated list of column names recommended for Delta Lake liquid clustering on the governed table, optimizing query performance for retention-related access patterns.',
    `minimum_necessary_applies` BOOLEAN COMMENT 'Indicates whether the HIPAA minimum necessary standard applies to disclosures of data governed by this annotation, limiting access to only the information needed for a specific purpose.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this retention annotation, calculated from last review date plus review frequency.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, implementation guidance, or rationale for this retention annotation configuration.',
    `patient_age_group` STRING COMMENT 'Indicates whether the retention rule applies to adult records, minor records (which often have extended retention until age of majority plus standard period), or all patient records.',
    `phi_classification` STRING COMMENT 'Data classification level indicating whether the governed data contains PHI, PII, PCI, sensitive business data, or is public, driving retention and access control requirements.',
    `priority_level` STRING COMMENT 'Relative priority of this retention annotation for enforcement scheduling, with critical indicating highest regulatory risk if non-compliant.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulation mandating this retention requirement (e.g., CMS, HHS, state Department of Health, The Joint Commission, FDA).',
    `regulatory_citation` STRING COMMENT 'Specific legal citation or regulation section number mandating the retention period (e.g., 45 CFR §164.530(j), state-specific medical records retention statute).',
    `retention_period_days` STRING COMMENT 'Granular retention period expressed in days for precise Delta Lake lifecycle management and automated purge scheduling.',
    `retention_period_years` STRING COMMENT 'Minimum number of years the data must be retained per HIPAA and applicable state regulations. Typical values range from 6 to 10 years for medical records, varying by state law.',
    `retention_start_event` STRING COMMENT 'The business event that triggers the start of the retention clock (e.g., date of last encounter, date of record creation, date of patient discharge, date of claim closure).',
    `review_frequency_months` STRING COMMENT 'How often (in months) this retention annotation should be reviewed for regulatory compliance updates, typically annually (12 months) or semi-annually (6 months).',
    `rls_predicate_expression` STRING COMMENT 'SQL predicate expression used for Databricks row-level security filtering on the governed data product, restricting access to PHI based on user roles and data sensitivity.',
    `scd_type` STRING COMMENT 'The SCD strategy applied to the governed data product, indicating how historical changes are tracked (Type 1 overwrites, Type 2 maintains full history, Type 3 stores previous value).',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code where this retention rule applies, as state laws may impose longer retention periods than federal HIPAA minimums. NULL indicates federal-level applicability.',
    `unity_catalog_tag_key` STRING COMMENT 'The tag key to be applied in Databricks Unity Catalog for governance classification (e.g., hipaa_retention, data_classification, phi_indicator).',
    `unity_catalog_tag_value` DECIMAL(18,2) COMMENT 'The tag value to be applied in Databricks Unity Catalog corresponding to the tag key, enabling automated governance policy enforcement.',
    `version_number` STRING COMMENT 'Version number of this retention annotation, incremented each time the rule is modified, supporting SCD Type 2 history tracking.',
    CONSTRAINT pk_implementation_hipaa_retention_annotations PRIMARY KEY(`implementation_hipaa_retention_annotations_id`)
) COMMENT 'Table for HIPAA retention annotations.';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`implementation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`implementation` SET TAGS ('dbx_domain' = 'implementation');
ALTER TABLE `healthcare_ecm_v1`.`implementation`.`implementation_hipaa_retention_annotations` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`implementation`.`implementation_hipaa_retention_annotations` ALTER COLUMN `implementation_hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'implementation_hipaa_retention_annotations Identifier');
