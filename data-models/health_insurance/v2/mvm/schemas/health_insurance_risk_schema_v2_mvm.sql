-- Schema for Domain: risk | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'Primary key for member risk score record.',
    `identity_id` BIGINT COMMENT 'FK to member identity.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: CMS risk adjustment (HCC/RAPS) is calculated per policy/coverage period. Risk analysts and compliance teams must tie each risk score to the specific policy it was submitted for, enabling payment recon',
    `raps_submission_id` BIGINT COMMENT 'Foreign key linking to risk.raps_submission. Business justification: Individual member risk scores are submitted to CMS via RAPS batch submissions. Adding raps_submission_id to member_risk_score links each risk score record to the specific RAPS submission batch it was ',
    `audit_user` STRING COMMENT 'User who last audited the score.',
    `cms_published_score` DECIMAL(18,2) COMMENT 'CMS-published risk adjustment score.',
    `cms_submission_status` STRING COMMENT 'Status of CMS submission for this score.',
    `corrective_action` STRING COMMENT 'Corrective action taken if score variance detected.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `demographic_factor_score` DECIMAL(18,2) COMMENT 'Demographic component of risk score.',
    `diagnosis_count` STRING COMMENT 'Number of diagnoses contributing to score.',
    `effective_timestamp` TIMESTAMP COMMENT 'When the score became effective.',
    `expiration_date` DATE COMMENT 'Date the score expires.',
    `is_manual_override` BOOLEAN COMMENT 'Whether score was manually overridden.',
    `manual_override_reason` STRING COMMENT 'Reason for manual override.',
    `model_name` STRING COMMENT 'Name of the risk model used.',
    `model_version` STRING COMMENT 'Version of the risk model.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year for risk adjustment.',
    `plan_calculated_score` DECIMAL(18,2) COMMENT 'Plan-calculated risk score before CMS reconciliation.',
    `record_status` STRING COMMENT 'Status of the risk score record.',
    `resubmission_reference` STRING COMMENT 'Reference ID for resubmitted scores.',
    `risk_adjustment_factor_category` DOUBLE COMMENT 'Category of risk adjustment factor.',
    `risk_score_code` DOUBLE COMMENT 'Coded risk score value.',
    `risk_score_confidence_score` DECIMAL(18,2) COMMENT 'Confidence level of the risk score.',
    `risk_score_label` DOUBLE COMMENT 'Label for the risk score tier.',
    `risk_score_notes` DOUBLE COMMENT 'Notes associated with risk score.',
    `risk_score_source` DOUBLE COMMENT 'Source system of the risk score.',
    `risk_score_status` DOUBLE COMMENT 'Current status of the risk score.',
    `risk_score_type` DOUBLE COMMENT 'Type classification of risk score.',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric risk score value.',
    `score_components` DOUBLE COMMENT 'Breakdown of score components.',
    `score_effective_date` DATE COMMENT 'Date the score becomes effective.',
    `score_variance` DECIMAL(18,2) COMMENT 'Variance between plan and CMS scores.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `variance_category` STRING COMMENT 'Category of score variance.',
    CONSTRAINT pk_member_risk_score PRIMARY KEY(`member_risk_score_id`)
) COMMENT 'Stores individual member risk scores calculated via CMS-HCC or prospective models for risk adjustment and payment reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` (
    `hcc_mapping_id` BIGINT COMMENT 'Primary key.',
    `age_adjustment_factor` DECIMAL(18,2) COMMENT 'Age-based adjustment factor.',
    `coefficient` DECIMAL(18,2) COMMENT 'HCC coefficient for risk score calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `demographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Demographic-based adjustment.',
    `disease_interaction_group` STRING COMMENT 'Disease interaction group code.',
    `effective_date` DATE COMMENT 'Mapping effective date.',
    `expiration_date` DATE COMMENT 'Mapping expiration date.',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'Gender-based adjustment factor.',
    `hcc_code` STRING COMMENT 'Hierarchical Condition Category code.',
    `hcc_description` STRING COMMENT 'Description of the HCC.',
    `hcc_mapping_status` STRING COMMENT 'Status of the mapping record.',
    `hierarchy_level` STRING COMMENT 'Level in the HCC hierarchy.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code.',
    `icd10_description` STRING COMMENT 'Description of the ICD-10 code.',
    `interaction_flag` BOOLEAN COMMENT 'Whether this HCC participates in disease interactions.',
    `is_excluded` BOOLEAN COMMENT 'Whether this mapping is excluded from scoring.',
    `is_mapped` BOOLEAN COMMENT 'Whether the ICD-10 code is mapped to an HCC.',
    `last_review_date` DATE COMMENT 'Date of last clinical review.',
    `last_updated_by` STRING COMMENT 'User who last updated the mapping.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `mapping_source` STRING COMMENT 'Source of the mapping (CMS, internal).',
    `model_year` STRING COMMENT 'CMS model year for the mapping.',
    `notes` STRING COMMENT 'Additional notes.',
    `parent_hcc_code` STRING COMMENT 'Parent HCC in the hierarchy.',
    `plan_type_adjustment_factor` DECIMAL(18,2) COMMENT 'Plan type adjustment factor.',
    `region_adjustment_factor` DECIMAL(18,2) COMMENT 'Regional adjustment factor.',
    `review_status` STRING COMMENT 'Clinical review status.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight contribution to risk score.',
    `source_version` STRING COMMENT 'Version of the source mapping file.',
    CONSTRAINT pk_hcc_mapping PRIMARY KEY(`hcc_mapping_id`)
) COMMENT 'Maps ICD-10 diagnosis codes to CMS Hierarchical Condition Categories (HCCs) for risk adjustment scoring.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` (
    `raps_submission_id` BIGINT COMMENT 'Primary key.',
    `accepted_record_count` STRING COMMENT 'Number of records accepted by CMS.',
    `batch_number` STRING COMMENT 'Submission batch identifier.',
    `cms_acknowledgment_status` STRING COMMENT 'CMS acknowledgment status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `error_disposition` STRING COMMENT 'Disposition of submission errors.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year.',
    `plan_contract_number` STRING COMMENT 'CMS contract number.',
    `plan_type` STRING COMMENT 'Type of plan submitted.',
    `raps_submission_status` STRING COMMENT 'Overall submission status.',
    `rejected_record_count` STRING COMMENT 'Number of records rejected.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Calculated risk adjustment factor.',
    `risk_adjustment_year` STRING COMMENT 'Year of risk adjustment.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregate risk score for submission.',
    `submission_file_checksum` STRING COMMENT 'File integrity checksum.',
    `submission_file_name` STRING COMMENT 'Name of submitted file.',
    `submission_timestamp` TIMESTAMP COMMENT 'When submission was sent.',
    `submission_user_name` STRING COMMENT 'User who submitted.',
    `total_record_count` DECIMAL(18,2) COMMENT 'Total records in submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_raps_submission PRIMARY KEY(`raps_submission_id`)
) COMMENT 'Tracks Risk Adjustment Processing System (RAPS) submissions to CMS for Medicare Advantage risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` (
    `radv_audit_id` BIGINT COMMENT 'Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: RADV audits validate risk scores against a specific policy year and coverage period. CMS auditors require the policy record to confirm coverage dates, plan type, and premium amounts align with submitt',
    `raps_submission_id` BIGINT COMMENT 'Foreign key linking to risk.raps_submission. Business justification: CMS RADV audits are triggered to validate the accuracy of risk adjustment data submitted via RAPS. Each RADV audit is associated with a specific RAPS submission (or set of submissions for a given cont',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: CMS RADV audits identify the rendering provider whose clinical documentation supports the audited HCC. Auditors must contact the rendering provider for medical records. Role-prefix rendering_ distin',
    `audit_end_timestamp` TIMESTAMP COMMENT 'When audit ended.',
    `audit_error_description` STRING COMMENT 'Description of audit errors.',
    `audit_error_flag` BOOLEAN COMMENT 'Whether errors were found.',
    `audit_notes` STRING COMMENT 'Audit notes.',
    `audit_source` STRING COMMENT 'Source of audit.',
    `audit_start_timestamp` TIMESTAMP COMMENT 'When audit started.',
    `audit_status` STRING COMMENT 'Current audit status.',
    `audit_type` STRING COMMENT 'Type of RADV audit.',
    `audit_updated_by` STRING COMMENT 'User who last updated.',
    `audit_year` STRING COMMENT 'Year of audit.',
    `cms_findings` STRING COMMENT 'CMS audit findings.',
    `currency_code` STRING COMMENT 'Currency code.',
    `extrapolated_payment_error` DECIMAL(18,2) COMMENT 'Extrapolated payment error amount.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount.',
    `hcc_mapping_version` STRING COMMENT 'HCC mapping version used.',
    `medical_record_receipt_date` DATE COMMENT 'Date medical records received.',
    `medical_record_request_status` STRING COMMENT 'Status of medical record request.',
    `record_created` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated` TIMESTAMP COMMENT 'Record update timestamp.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor.',
    `sampled_member_count` STRING COMMENT 'Number of members sampled.',
    `validated_hcc_count` STRING COMMENT 'Number of validated HCCs.',
    CONSTRAINT pk_radv_audit PRIMARY KEY(`radv_audit_id`)
) COMMENT 'Tracks CMS Risk Adjustment Data Validation (RADV) audits including medical record reviews and payment error calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` (
    `score_hcc_assignment_id` BIGINT COMMENT 'Primary key for the risk_score_hcc_assignment association',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to the specific HCC mapping record (ICD-10 to HCC with model year and coefficient) assigned to this member score.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to the member risk score record that this HCC contributes to.',
    `contribution_weight` DECIMAL(18,2) COMMENT 'The weighted contribution of this specific HCC to the members total RAF score. Derived from the HCC coefficient adjusted for demographic and interaction factors specific to this member-HCC pairing. Belongs to the assignment, not to the score or the mapping alone.',
    `effective_date` DATE COMMENT 'The date on which this HCC assignment became effective for the members risk score calculation period. Distinct from the hcc_mapping effective_date (which governs the mapping rule) and the score effective_timestamp (which governs the overall score).',
    `hcc_codes` STRING COMMENT 'Comma-separated HCC codes contributing to score. [Moved from member_risk_score: This denormalized comma-separated STRING column is the flattened representation of the M:N relationship being replaced by this association table. Once risk_score_hcc_assignment is in place, individual HCC codes are accessible via JOIN to hcc_mapping. Retaining hcc_codes creates a data quality risk (divergence between the string and the junction records) and prevents proper RADV audit traceability.]',
    `inclusion_reason` STRING COMMENT 'The clinical or administrative basis for including this HCC in the members risk score. Required for RADV audit defense to demonstrate that each HCC assignment is supported by adequate medical record documentation.',
    `is_primary_hcc` BOOLEAN COMMENT 'Indicates whether this HCC is the dominant condition driver for the members risk score. Used in RADV audit prioritization to identify the highest-impact HCC assignments for clinical documentation review.',
    CONSTRAINT pk_score_hcc_assignment PRIMARY KEY(`score_hcc_assignment_id`)
) COMMENT 'This association product represents the Assignment (Role) between member_risk_score and hcc_mapping. It captures the specific contribution of each Hierarchical Condition Category to an individual members risk adjustment factor score, as required for CMS RADV audit documentation. Each record links one member_risk_score to one hcc_mapping and carries the contribution weight, primacy flag, effective date, and inclusion reason that exist only in the context of this specific member-HCC assignment.. Existence Justification: In Medicare Advantage risk adjustment, a members RAF (Risk Adjustment Factor) score is computed as the sum of contributions from multiple HCC codes — a single member risk score record is built from many HCC mappings, and a single HCC mapping (e.g., HCC 85 - Congestive Heart Failure) contributes to thousands of member risk scores across the plan. CMS requires plans to document and defend each individual HCC-to-member assignment during RADV audits, meaning this relationship is actively created, maintained, and audited as an operational business record. The current denormalized `hcc_codes` STRING column on `member_risk_score` is a known data quality gap that prevents proper audit traceability and must be replaced by a proper junction table.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_raps_submission_id` FOREIGN KEY (`raps_submission_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`raps_submission`(`raps_submission_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ADD CONSTRAINT `fk_risk_score_hcc_assignment_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ADD CONSTRAINT `fk_risk_score_hcc_assignment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Raps Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('dbx_business_glossary_term' = 'CMS Published Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Override');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('dbx_business_glossary_term' = 'Plan Calculated Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Confidence');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_label` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Label');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_components` SET TAGS ('dbx_business_glossary_term' = 'Score Components');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_variance` SET TAGS ('dbx_business_glossary_term' = 'Score Variance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('dbx_business_glossary_term' = 'Coefficient');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Demographic Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Group');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'HCC Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Interaction Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('dbx_business_glossary_term' = 'Is Mapped');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Parent HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Region Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_year` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission File Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_business_glossary_term' = 'Submission User Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `total_record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `radv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'RADV Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Raps Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `cms_findings` SET TAGS ('dbx_business_glossary_term' = 'CMS Findings');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `extrapolated_payment_error` SET TAGS ('dbx_business_glossary_term' = 'Extrapolated Payment Error');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `hcc_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `sampled_member_count` SET TAGS ('dbx_business_glossary_term' = 'Sampled Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `validated_hcc_count` SET TAGS ('dbx_business_glossary_term' = 'Validated HCC Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` SET TAGS ('dbx_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` SET TAGS ('dbx_association_edges' = 'risk.member_risk_score,risk.hcc_mapping');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `score_hcc_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Assignment - Risk Score Hcc Assignment Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Assignment - Hcc Mapping Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Assignment - Member Risk Score Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `contribution_weight` SET TAGS ('dbx_business_glossary_term' = 'HCC Contribution Weight');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'HCC Assignment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `hcc_codes` SET TAGS ('dbx_business_glossary_term' = 'HCC Codes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'HCC Inclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_hcc_assignment` ALTER COLUMN `is_primary_hcc` SET TAGS ('dbx_business_glossary_term' = 'Primary HCC Indicator');
