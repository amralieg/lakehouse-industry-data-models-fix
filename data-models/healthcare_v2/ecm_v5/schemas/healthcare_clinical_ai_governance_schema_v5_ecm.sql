-- Schema for Domain: clinical_ai_governance | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai_governance` COMMENT 'Clinical AI Governance domain with model_card, bias_monitoring, fda_samd tables';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card` (
    `clinical_ai_governance_model_card_id` BIGINT COMMENT 'Primary key for clinical_ai_governance_model_card',
    `model_version_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_clinical_ai_governance_model_card PRIMARY KEY(`clinical_ai_governance_model_card_id`)
) COMMENT 'Table storing model cards';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring` (
    `clinical_ai_governance_bias_monitoring_id` BIGINT COMMENT 'Primary key for clinical_ai_governance_bias_monitoring',
    `model_version_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_clinical_ai_governance_bias_monitoring PRIMARY KEY(`clinical_ai_governance_bias_monitoring_id`)
) COMMENT 'Table tracking bias monitoring metrics';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd` (
    `clinical_ai_governance_fda_samd_id` BIGINT COMMENT 'Primary key for clinical_ai_governance_fda_samd',
    `model_version_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_clinical_ai_governance_fda_samd PRIMARY KEY(`clinical_ai_governance_fda_samd_id`)
) COMMENT 'Table for FDA SAMD submissions';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_ai_governance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_ai_governance` SET TAGS ('dbx_domain' = 'clinical_ai_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card` SET TAGS ('dbx_subdomain' = 'clinical_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card` ALTER COLUMN `clinical_ai_governance_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_governance_model_card Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring` SET TAGS ('dbx_subdomain' = 'clinical_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring` ALTER COLUMN `clinical_ai_governance_bias_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_governance_bias_monitoring Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd` SET TAGS ('dbx_subdomain' = 'clinical_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd` ALTER COLUMN `clinical_ai_governance_fda_samd_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_governance_fda_samd Identifier');
