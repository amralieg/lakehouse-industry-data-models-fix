-- Schema for Domain: research_clinical_trial_matching | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`research_clinical_trial_matching` COMMENT 'Clinical trial matching domain with eligibility criteria tables.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria` (
    `research_clinical_trial_matching_eligibility_criteria_id` BIGINT COMMENT 'Primary key for research_clinical_trial_matching_eligibility_criteria',
    `research_study_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_research_clinical_trial_matching_eligibility_criteria PRIMARY KEY(`research_clinical_trial_matching_eligibility_criteria_id`)
) COMMENT 'Table for trial eligibility criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` (
    `research_clinical_trial_matching_eligibility_evaluation_id` BIGINT COMMENT 'Primary key for research_clinical_trial_matching_eligibility_evaluation',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Clinical trial eligibility evaluation consumes AI-generated patient risk scores to assess disease severity criteria. Trial matching systems use risk stratification to pre-screen candidates per FDA/IRB',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Precision medicine trial matching requires linking eligibility evaluations to the specific genomic test result that informed the decision. Regulatory (FDA companion diagnostics) and operational workfl',
    `mpi_record_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Clinical trial screening requires post-acute context (e.g., within 30 days post-discharge from SNF). Research coordinators evaluate eligibility against active post-acute episodes for rehabilitation,',
    `research_clinical_trial_matching_eligibility_criteria_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_research_clinical_trial_matching_eligibility_evaluation PRIMARY KEY(`research_clinical_trial_matching_eligibility_evaluation_id`)
) COMMENT 'Table for patient eligibility evaluation results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria` (
    `research_clinical_trial_matching_trial_eligibility_criteria_id` BIGINT COMMENT 'Primary key for research_clinical_trial_matching_trial_eligibility_criteria',
    `research_study_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_research_clinical_trial_matching_trial_eligibility_criteria PRIMARY KEY(`research_clinical_trial_matching_trial_eligibility_criteria_id`)
) COMMENT 'Table for trial eligibility criteria definitions';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_evaluation_research_clinical_trial_matching_eligibility_criteria_id` FOREIGN KEY (`research_clinical_trial_matching_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria`(`research_clinical_trial_matching_eligibility_criteria_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`research_clinical_trial_matching` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`research_clinical_trial_matching` SET TAGS ('dbx_domain' = 'research_clinical_trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'research_clinical');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria` ALTER COLUMN `research_clinical_trial_matching_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'research_clinical_trial_matching_eligibility_criteria Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'research_clinical');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ALTER COLUMN `research_clinical_trial_matching_eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'research_clinical_trial_matching_eligibility_evaluation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'research_clinical');
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `research_clinical_trial_matching_trial_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'research_clinical_trial_matching_trial_eligibility_criteria Identifier');
