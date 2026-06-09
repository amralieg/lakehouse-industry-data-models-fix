-- Schema for Domain: shared | Business: Consumer Goods | Version: v1_ecm
-- Generated on: 2026-05-05 09:07:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`shared` COMMENT 'Shared domain (auto-created for table region)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`shared`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `parent_region_id` BIGINT COMMENT 'Identifier of the immediate parent region in the geographic hierarchy.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total land area of the region expressed in square kilometres.',
    `climate_zone` STRING COMMENT 'Primary climate classification of the region.',
    `region_code` STRING COMMENT 'Internal alphanumeric code used to reference the region within the enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the region record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for transactions in the region.',
    `region_description` STRING COMMENT 'Free‑form description providing additional context about the region.',
    `effective_from` DATE COMMENT 'Date when the region became valid for business use.',
    `effective_until` DATE COMMENT 'Date when the region ceases to be valid (null if open‑ended).',
    `external_reference` STRING COMMENT 'Reference identifier from external standards such as UN M49 or World Bank.',
    `gdp_usd` DECIMAL(18,2) COMMENT 'Estimated annual GDP of the region expressed in US dollars.',
    `geographic_center_name` STRING COMMENT 'Name of the city or landmark that best represents the regions center.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the region within the geographic hierarchy (e.g., 1 = continent, 2 = country).',
    `is_cross_border` BOOLEAN COMMENT 'True if the region spans more than one sovereign country.',
    `iso_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code for the country containing the region.',
    `iso_region_code` STRING COMMENT 'Standardized region code as defined by ISO 3166‑2.',
    `latitude_center` DOUBLE COMMENT 'Latitude coordinate of the regions geographic centroid.',
    `longitude_center` DOUBLE COMMENT 'Longitude coordinate of the regions geographic centroid.',
    `median_income_usd` DECIMAL(18,2) COMMENT 'Median annual household income within the region, expressed in US dollars.',
    `region_name` STRING COMMENT 'Human‑readable name of the region (e.g., "Midwest", "Bavaria").',
    `population` BIGINT COMMENT 'Estimated resident population of the region.',
    `primary_language` STRING COMMENT 'Most commonly spoken language in the region.',
    `region_status` STRING COMMENT 'Current operational status of the region.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier representing the primary time zone of the region.',
    `region_type` STRING COMMENT 'Category that defines the hierarchical level of the region.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the region record.',
    `urbanization_rate` DECIMAL(18,2) COMMENT 'Percentage of the regions population living in urban areas.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Master reference table for region. Referenced by region_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`shared`.`region` ADD CONSTRAINT `fk_shared_region_parent_region_id` FOREIGN KEY (`parent_region_id`) REFERENCES `consumer_goods_ecm`.`shared`.`region`(`region_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `consumer_goods_ecm`.`shared`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`shared`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
