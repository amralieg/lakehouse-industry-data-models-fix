-- Schema for Domain: population_health_cohort_mgmt | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_mgmt` COMMENT 'Population Health Cohort Management domain with dynamic cohort definition and membership tracking';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` (
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_mgmt_cohort_definition',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: AI-driven population health cohorts require traceability to the governing model card for FDA SaMD compliance, bias monitoring, and clinical AI governance audits.',
    `ai_cohort_definition_id` BIGINT COMMENT 'description',
    `population_cohort_definition_ai_cohort_definition_id` BIGINT COMMENT 'description',
    `population_segment_id` BIGINT COMMENT 'description',
    `cohort_type` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `definition_sql` STRING COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `last_refresh_ts` TIMESTAMP COMMENT 'description',
    `population_health_cohort_mgmt_cohort_definition_description` STRING COMMENT 'description',
    `refresh_frequency` STRING COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_mgmt_cohort_definition PRIMARY KEY(`population_health_cohort_mgmt_cohort_definition_id`)
) COMMENT 'Table defining dynamic cohorts';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` (
    `population_health_cohort_mgmt_cohort_membership_id` BIGINT COMMENT 'Primary key for population_health_cohort_mgmt_cohort_membership',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Care managers reviewing cohort rosters need the specific AI risk score that triggered patient inclusion for clinical decision-making, outreach prioritization, and audit trail compliance.',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: Genomic-stratified population health management requires tracking which genomic profile qualified a patient for cohort inclusion (e.g., BRCA1+ cohort, pharmacogenomic risk groups). Supports precision ',
    `mpi_record_id` BIGINT COMMENT 'description',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'description',
    `inclusion_reason` STRING COMMENT 'description',
    `is_current` BOOLEAN COMMENT 'description',
    `membership_end_date` DATE COMMENT 'description',
    `membership_start_date` DATE COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_mgmt_cohort_membership PRIMARY KEY(`population_health_cohort_mgmt_cohort_membership_id`)
) COMMENT 'Table tracking cohort membership';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` (
    `population_health_cohort_mgmt_dynamic_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_mgmt_dynamic_cohort_definition',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: Dynamic cohorts evaluated by ML models in real-time require model card linkage for AI governance, version tracking, and regulatory compliance under FDA SaMD frameworks.',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'description',
    `evaluation_schedule` STRING COMMENT 'description',
    `filter_expression` STRING COMMENT 'description',
    `is_dynamic` BOOLEAN COMMENT 'description',
    `last_evaluated_ts` TIMESTAMP COMMENT 'description',
    `member_count` BIGINT COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_mgmt_dynamic_cohort_definition PRIMARY KEY(`population_health_cohort_mgmt_dynamic_cohort_definition_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_membership_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_dynamic_cohort_definition_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort_mgmt` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort_mgmt` SET TAGS ('dbx_domain' = 'population_health_cohort_mgmt');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_mgmt_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `population_health_cohort_mgmt_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_mgmt_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `population_health_cohort_mgmt_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `population_health_cohort_mgmt_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_dynamic_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_mgmt_dynamic_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
