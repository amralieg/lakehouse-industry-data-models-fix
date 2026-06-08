-- Schema for Domain: uc_tags | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`uc_tags` COMMENT 'UC tag definitions for Unity Catalog.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`uc_tags`.`industry_outcome_plugin_registry` (
    `industry_outcome_plugin_registry_id` BIGINT COMMENT 'Primary key for industry_outcome_plugin_registry',
    `industry_outcome_plugin_id` BIGINT COMMENT 'description',
    `industry_outcome_plugin_registry_description` STRING COMMENT 'description',
    `installed_date` DATE COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `mlflow_model_uri` STRING COMMENT 'description',
    `plugin_version` STRING COMMENT 'description',
    CONSTRAINT pk_industry_outcome_plugin_registry PRIMARY KEY(`industry_outcome_plugin_registry_id`)
) COMMENT 'Registry of industry outcome plugins that attach to the base healthcare model without modifying base tables. Tracks plugin models like readmission_forecast, sepsis_score, and their FK attachment points to base model surrogate keys.';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`uc_tags` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`uc_tags` SET TAGS ('dbx_domain' = 'uc_tags');
ALTER TABLE `healthcare_ecm_v1`.`uc_tags`.`industry_outcome_plugin_registry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`uc_tags`.`industry_outcome_plugin_registry` ALTER COLUMN `industry_outcome_plugin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'industry_outcome_plugin_registry Identifier');
