-- Schema for Domain: data_governance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`data_governance` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`data_governance`.`catalog_metadata` (
    `catalog_metadata_id` BIGINT COMMENT 'Primary key for catalog metadata entry',
    `asset_name` STRING COMMENT 'Name of the cataloged data asset',
    `asset_domain` STRING COMMENT 'Domain the asset belongs to',
    `asset_type` STRING COMMENT 'Type of asset (table, view, file)',
    `catalog_metadata_description` STRING COMMENT 'Business description of the asset',
    `classification` STRING COMMENT 'Data classification level',
    `schema_definition` STRING COMMENT 'Schema definition reference',
    `created_at` TIMESTAMP COMMENT 'When the catalog entry was created',
    `updated_at` TIMESTAMP COMMENT 'When the catalog entry was last updated',
    CONSTRAINT pk_catalog_metadata PRIMARY KEY(`catalog_metadata_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`data_governance`.`data_quality_rule` (
    `data_quality_rule_id` BIGINT COMMENT 'Primary key for data quality rule',
    `catalog_metadata_id` BIGINT COMMENT 'Asset the rule applies to',
    `rule_name` STRING COMMENT 'Name of the data quality rule',
    `rule_type` STRING COMMENT 'Type of rule (completeness, uniqueness, validity)',
    `rule_expression` STRING COMMENT 'Expression or check definition',
    `threshold` DECIMAL(18,2) COMMENT 'Pass/fail threshold for the rule',
    `severity` STRING COMMENT 'Severity level on failure',
    `is_active` BOOLEAN COMMENT 'Whether the rule is active',
    CONSTRAINT pk_data_quality_rule PRIMARY KEY(`data_quality_rule_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`data_governance`.`data_lineage` (
    `data_lineage_id` BIGINT COMMENT 'Primary key for lineage record',
    `catalog_metadata_id` BIGINT COMMENT 'Source asset',
    `target_catalog_metadata_id` BIGINT COMMENT 'Target asset',
    `transformation` STRING COMMENT 'Transformation applied between source and target',
    `pipeline_name` STRING COMMENT 'Pipeline or job producing the lineage',
    `created_at` TIMESTAMP COMMENT 'When the lineage record was captured',
    CONSTRAINT pk_data_lineage PRIMARY KEY(`data_lineage_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`data_governance`.`data_ownership` (
    `data_ownership_id` BIGINT COMMENT 'Primary key for ownership record',
    `catalog_metadata_id` BIGINT COMMENT 'Asset that is owned',
    `owner_name` STRING COMMENT 'Name of the data owner',
    `steward_name` STRING COMMENT 'Name of the data steward',
    `owning_team` STRING COMMENT 'Team responsible for the asset',
    `contact_email` STRING COMMENT 'Contact email for ownership',
    `effective_from` TIMESTAMP COMMENT 'When ownership became effective',
    CONSTRAINT pk_data_ownership PRIMARY KEY(`data_ownership_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_quality_rule` ADD CONSTRAINT `fk_data_governance_data_quality_rule_catalog_metadata_id` FOREIGN KEY (`catalog_metadata_id`) REFERENCES `vibe_automotive_v1`.`data_governance`.`catalog_metadata`(`catalog_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_lineage` ADD CONSTRAINT `fk_data_governance_data_lineage_catalog_metadata_id` FOREIGN KEY (`catalog_metadata_id`) REFERENCES `vibe_automotive_v1`.`data_governance`.`catalog_metadata`(`catalog_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_lineage` ADD CONSTRAINT `fk_data_governance_data_lineage_target_catalog_metadata_id` FOREIGN KEY (`target_catalog_metadata_id`) REFERENCES `vibe_automotive_v1`.`data_governance`.`catalog_metadata`(`catalog_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_ownership` ADD CONSTRAINT `fk_data_governance_data_ownership_catalog_metadata_id` FOREIGN KEY (`catalog_metadata_id`) REFERENCES `vibe_automotive_v1`.`data_governance`.`catalog_metadata`(`catalog_metadata_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`data_governance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_automotive_v1`.`data_governance` SET TAGS ('dbx_domain' = 'data_governance');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`catalog_metadata` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`catalog_metadata` ALTER COLUMN `catalog_metadata_id` SET TAGS ('dbx_governance' = 'catalog');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_quality_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_quality_rule` ALTER COLUMN `data_quality_rule_id` SET TAGS ('dbx_governance' = 'quality');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_lineage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_lineage` ALTER COLUMN `data_lineage_id` SET TAGS ('dbx_governance' = 'lineage');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_ownership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`data_governance`.`data_ownership` ALTER COLUMN `data_ownership_id` SET TAGS ('dbx_governance' = 'ownership');
