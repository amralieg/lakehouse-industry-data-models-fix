-- Schema for Domain: clinical_ai | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical_ai` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` (
    `patient_risk_score_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `mlflow_run_id` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_patient_risk_score PRIMARY KEY(`patient_risk_score_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` (
    `clinical_nlp_result_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `mlflow_run_id` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_clinical_nlp_result PRIMARY KEY(`clinical_nlp_result_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` (
    `care_gap_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `mlflow_run_id` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_care_gap PRIMARY KEY(`care_gap_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` (
    `model_inference_log_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `mlflow_run_id` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_model_inference_log PRIMARY KEY(`model_inference_log_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` (
    `feature_store_entity_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `mlflow_run_id` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_feature_store_entity PRIMARY KEY(`feature_store_entity_id`)
) COMMENT '';

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical_ai` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical_ai` SET TAGS ('pii_domain' = 'clinical_ai');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_is_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `demographics_id` SET TAGS ('pii_role' = 'patient_ref');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `mlflow_run_id` SET TAGS ('pii_role' = 'mlflow_lineage');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `created_at` SET TAGS ('pii_role' = 'audit_ts');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_is_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_role' = 'patient_ref');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `mlflow_run_id` SET TAGS ('pii_role' = 'mlflow_lineage');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `created_at` SET TAGS ('pii_role' = 'audit_ts');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_gap_id` SET TAGS ('pii_is_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_role' = 'patient_ref');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `mlflow_run_id` SET TAGS ('pii_role' = 'mlflow_lineage');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `created_at` SET TAGS ('pii_role' = 'audit_ts');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_inference_log_id` SET TAGS ('pii_is_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_role' = 'patient_ref');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_run_id` SET TAGS ('pii_role' = 'mlflow_lineage');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `created_at` SET TAGS ('pii_role' = 'audit_ts');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_store_entity_id` SET TAGS ('pii_is_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `demographics_id` SET TAGS ('pii_role' = 'patient_ref');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `mlflow_run_id` SET TAGS ('pii_role' = 'mlflow_lineage');
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `created_at` SET TAGS ('pii_role' = 'audit_ts');
