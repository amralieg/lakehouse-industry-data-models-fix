-- Schema for Domain: population_health_cohort | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort` COMMENT 'Population Health Cohort Management domain for dynamic cohort definitions and membership tracking.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` (
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_cohort_definition',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: ML-powered cohort definitions must reference their underlying AI model for FDA SaMD governance, bias monitoring, and regulatory compliance. Population health leaders need model lineage for cohort crit',
    `cohort_definition_code` BIGINT COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `criteria_logic` STRING COMMENT 'description',
    `last_refresh_at` TIMESTAMP COMMENT 'description',
    `population_health_cohort_cohort_definition_description` STRING COMMENT 'description',
    `population_health_cohort_cohort_definition_status` STRING COMMENT 'description',
    `refresh_frequency` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_cohort_definition PRIMARY KEY(`population_health_cohort_cohort_definition_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` (
    `population_health_cohort_cohort_membership_id` BIGINT COMMENT 'Primary key for population_health_cohort_cohort_membership',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Patients are stratified into population health cohorts based on AI risk scores. Tracking which risk score triggered cohort inclusion is required for care management auditability and risk stratificatio',
    `mpi_record_id` BIGINT COMMENT 'description',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'description',
    `added_at` TIMESTAMP COMMENT 'description',
    `exclusion_reason` STRING COMMENT 'description',
    `inclusion_reason` STRING COMMENT 'description',
    `membership_end_date` DATE COMMENT 'description',
    `membership_start_date` DATE COMMENT 'description',
    `population_health_cohort_cohort_membership_status` STRING COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_cohort_membership PRIMARY KEY(`population_health_cohort_cohort_membership_id`)
) COMMENT 'Table tracking patient membership in cohorts over time.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` (
    `population_health_cohort_dynamic_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_dynamic_cohort_definition',
    `clinical_ai_dynamic_cohort_definition_id` BIGINT COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `last_evaluated_at` TIMESTAMP COMMENT 'description',
    `member_count` BIGINT COMMENT 'description',
    `refresh_schedule_cron` STRING COMMENT 'description',
    `source_tables` STRING COMMENT 'description',
    `sql_predicate` STRING COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_dynamic_cohort_definition PRIMARY KEY(`population_health_cohort_dynamic_cohort_definition_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_population_health_cohort_cohort_membership_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort` SET TAGS ('dbx_domain' = 'population_health_cohort');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ALTER COLUMN `population_health_cohort_cohort_definition_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_membership_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_membership_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_dynamic_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_dynamic_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
