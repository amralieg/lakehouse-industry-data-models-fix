-- Schema for Domain: delta_tblproperties | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`delta_tblproperties` COMMENT 'Delta TBLPROPERTIES templates.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config` (
    `delta_tblproperties_liquid_clustering_config_id` BIGINT COMMENT 'Primary key for delta_tblproperties_liquid_clustering_config',
    `databricks_governance_delta_tblproperties_id` BIGINT COMMENT 'description',
    `liquid_clustering_config_id` BIGINT COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `estimated_cardinality` BIGINT COMMENT 'description',
    `query_pattern_justification` STRING COMMENT 'description',
    CONSTRAINT pk_delta_tblproperties_liquid_clustering_config PRIMARY KEY(`delta_tblproperties_liquid_clustering_config_id`)
) COMMENT 'Defines liquid clustering configurations for Delta tables in the healthcare lakehouse, specifying clustering columns optimized for common healthcare query patterns such as patient_id + encounter_date, provider_id + service_date, or claim_id + payer_id combinations.';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`delta_tblproperties` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`delta_tblproperties` SET TAGS ('dbx_domain' = 'delta_tblproperties');
ALTER TABLE `healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config` ALTER COLUMN `delta_tblproperties_liquid_clustering_config_id` SET TAGS ('dbx_business_glossary_term' = 'delta_tblproperties_liquid_clustering_config Identifier');
