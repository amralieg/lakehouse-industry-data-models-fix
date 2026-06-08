-- Schema for Domain: metadata | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`metadata` COMMENT '';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`metadata`.`industry_outcome_plugin` (
    `industry_outcome_plugin_id` BIGINT COMMENT 'Primary key for industry_outcome_plugin',
    `attachment_point` STRING COMMENT 'The base data model entity to which this plugin attaches its output without modifying base tables (supports clean plugin keying per VREQ-022).',
    `auroc_score` DECIMAL(18,2) COMMENT 'The AUROC performance metric from the most recent model validation, indicating discriminative ability (0.5 = random, 1.0 = perfect).',
    `base_table_target` STRING COMMENT 'Fully qualified name of the base model table whose primary key the plugin references for output storage (e.g., patient.patient, encounter.encounter).',
    `bias_review_date` DATE COMMENT 'Date of the most recent algorithmic fairness and bias review assessing disparate impact across demographic groups.',
    `clinical_domain` STRING COMMENT 'The clinical or operational domain this plugin targets (e.g., sepsis, readmission, mortality, falls, pressure injury, length of stay). [ENUM-REF-CANDIDATE: sepsis|readmission|mortality|falls|pressure_injury|los|deterioration|ade — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this plugin registration record was first created in the metadata catalog.',
    `effective_end_date` DATE COMMENT 'Date after which this plugin version is no longer approved for production use (null if currently active).',
    `effective_start_date` DATE COMMENT 'Date from which this plugin version is approved for production use in clinical or operational workflows.',
    `execution_frequency` STRING COMMENT 'How often the plugin is scheduled to compute or refresh its outcome scores.',
    `fda_clearance_number` STRING COMMENT 'FDA 510(k) or De Novo clearance number if the plugin is classified as a Software as a Medical Device (SaMD).',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the plugin has been assessed and confirmed compliant with HIPAA privacy and security requirements for PHI handling.',
    `industry_outcome_plugin_code` STRING COMMENT 'Unique business identifier code for the plugin used in system integrations and API references (e.g., READMISSION_FORECAST, SEPSIS_SCORE, MORTALITY_RISK).',
    `industry_outcome_plugin_description` STRING COMMENT 'Detailed narrative describing the plugins purpose, methodology, and intended clinical or operational use case.',
    `industry_outcome_plugin_name` STRING COMMENT 'Human-readable display name of the industry outcome plugin (e.g., 30-Day Readmission Forecast, Sepsis Early Warning Score).',
    `industry_outcome_plugin_status` STRING COMMENT 'Current lifecycle state of the plugin within the enterprise deployment pipeline.',
    `input_feature_count` STRING COMMENT 'Number of input features or variables consumed by the plugin model for score computation.',
    `model_algorithm` STRING COMMENT 'The machine learning or statistical algorithm used by the plugin (e.g., logistic regression, gradient boosting, neural network, rules-based).',
    `output_data_type` STRING COMMENT 'The data type of the plugins computed output (numeric score, probability, categorical label, binary flag, or ordinal rank).',
    `plugin_type` STRING COMMENT 'Category of the outcome plugin indicating its analytical function (predictive model, scoring algorithm, classification engine, risk stratification, or quality measure).',
    `positive_predictive_value` DECIMAL(18,2) COMMENT 'Proportion of positive predictions that are true positives from the most recent validation run.',
    `regulatory_clearance_flag` BOOLEAN COMMENT 'Indicates whether the plugin has received FDA clearance or other regulatory approval as a clinical decision support tool.',
    `requires_real_time_data_flag` BOOLEAN COMMENT 'Indicates whether the plugin requires streaming or real-time data feeds (e.g., vital signs, lab results) versus batch historical data.',
    `retention_days` STRING COMMENT 'Number of days plugin output scores are retained before archival, aligned with HIPAA minimum retention requirements and Delta TBLPROPERTIES retention policies.',
    `score_range_max` DECIMAL(18,2) COMMENT 'The maximum possible value in the plugins output score range, used for normalization and interpretation.',
    `score_range_min` DECIMAL(18,2) COMMENT 'The minimum possible value in the plugins output score range, used for normalization and interpretation.',
    `score_threshold` DECIMAL(18,2) COMMENT 'The threshold value above which the plugin output triggers a clinical alert or workflow action.',
    `sensitivity` DECIMAL(18,2) COMMENT 'True positive rate of the model — proportion of actual positives correctly identified.',
    `training_cohort_size` BIGINT COMMENT 'Number of patient records or encounters used in the most recent model training cohort.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this plugin registration record was last modified.',
    `validation_date` DATE COMMENT 'Date of the most recent model performance validation or recalibration assessment.',
    `vendor_name` STRING COMMENT 'Name of the vendor or internal team that developed and maintains the plugin algorithm.',
    `version_number` STRING COMMENT 'Semantic version number of the plugin (major.minor.patch) following standard versioning conventions.',
    CONSTRAINT pk_industry_outcome_plugin PRIMARY KEY(`industry_outcome_plugin_id`)
) COMMENT 'Table storing industry outcome plugin metadata (e.g., readmission_forecast, sepsis_score).';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`metadata` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`metadata` SET TAGS ('dbx_domain' = 'metadata');
ALTER TABLE `healthcare_ecm_v1`.`metadata`.`industry_outcome_plugin` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`metadata`.`industry_outcome_plugin` ALTER COLUMN `industry_outcome_plugin_id` SET TAGS ('dbx_business_glossary_term' = 'industry_outcome_plugin Identifier');
