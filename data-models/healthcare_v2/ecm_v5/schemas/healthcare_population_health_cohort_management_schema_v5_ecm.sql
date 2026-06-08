-- Schema for Domain: population_health_cohort_management | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_management` COMMENT 'Population Health Cohort Management domain.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` (
    `population_health_cohort_management_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_management_cohort_definition',
    `ai_cohort_definition_id` BIGINT COMMENT 'description',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: Population health cohort definitions must trace to the AI model powering them for FDA SaMD governance, model drift monitoring, and regulatory audit trails. Domain experts expect this for responsible A',
    `employee_id` BIGINT COMMENT 'description',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_program. Business justification: Cohort definitions are created specifically to identify eligible patients for RPM programs (e.g., CHF patients for remote monitoring). Links cohort criteria to the target intervention program for po',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: When AI model versions change, population health teams must identify affected cohort definitions for re-evaluation. Critical for model lifecycle management and reproducibility compliance.',
    `cohort_description` STRING COMMENT 'description',
    `cohort_type_code` STRING COMMENT 'description',
    `created_ts` TIMESTAMP COMMENT 'description',
    `definition_logic_sql` STRING COMMENT 'description',
    `effective_end_date` DATE COMMENT 'description',
    `effective_start_date` DATE COMMENT 'description',
    `exclusion_criteria_json` STRING COMMENT 'description',
    `inclusion_criteria_json` STRING COMMENT 'description',
    `last_refresh_ts` TIMESTAMP COMMENT 'description',
    `refresh_frequency_code` STRING COMMENT 'description',
    `status_code` STRING COMMENT 'description',
    `target_population_size` BIGINT COMMENT 'description',
    `updated_ts` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_management_cohort_definition PRIMARY KEY(`population_health_cohort_management_cohort_definition_id`)
) COMMENT 'Defines dynamic or static patient cohorts for population health management programs, quality initiatives, and research. Supports SQL-based logic, inclusion/exclusion criteria, and refresh scheduling.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` (
    `population_health_cohort_management_cohort_membership_id` BIGINT COMMENT 'Primary key for population_health_cohort_management_cohort_membership',
    `ai_cohort_membership_id` BIGINT COMMENT 'description',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Care managers reviewing cohort members need the specific risk score calculation that drove inclusion/stratification. Required for risk-stratified care management workflows and value-based care reporti',
    `mpi_record_id` BIGINT COMMENT 'description',
    `population_health_cohort_management_cohort_definition_id` BIGINT COMMENT 'description',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Precision medicine cohorts require tracking which genomic test result qualified a patient for inclusion. Supports regulatory audit of genomic-based cohort composition, re-evaluation on amended results',
    `created_ts` TIMESTAMP COMMENT 'description',
    `exclusion_reason_code` STRING COMMENT 'description',
    `inclusion_reason_code` STRING COMMENT 'description',
    `last_evaluated_ts` TIMESTAMP COMMENT 'description',
    `membership_end_date` DATE COMMENT 'description',
    `membership_start_date` DATE COMMENT 'description',
    `membership_status_code` STRING COMMENT 'description',
    `risk_score` DECIMAL(18,2) COMMENT 'description',
    `updated_ts` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_population_health_cohort_management_cohort_membership PRIMARY KEY(`population_health_cohort_management_cohort_membership_id`)
) COMMENT 'Tracks individual patient membership in defined cohorts over time, including membership status, risk scores, inclusion/exclusion reasons, and linkage to AI model inference that drove membership decisions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_membership_population_health_cohort_management_cohort_definition_id` FOREIGN KEY (`population_health_cohort_management_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition`(`population_health_cohort_management_cohort_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort_management` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`population_health_cohort_management` SET TAGS ('dbx_domain' = 'population_health_cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `population_health_cohort_management_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_management_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `population_health_cohort_management_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `population_health_cohort_management_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Source Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Source Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` SET TAGS ('dbx_subdomain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_management_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `population_health_cohort_management_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `population_health_cohort_management_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Genomic Test Result Id (Foreign Key)');
