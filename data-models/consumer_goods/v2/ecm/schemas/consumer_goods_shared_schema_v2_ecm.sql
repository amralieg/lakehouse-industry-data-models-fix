-- Schema for Domain: shared | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`shared` COMMENT 'Shared domain (auto-created for table region)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `jurisdiction_id` BIGINT COMMENT 'FK to regulatory jurisdiction',
    `parent_region_id` BIGINT COMMENT 'FK to parent region for hierarchy',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Area in square kilometers',
    `climate_zone` STRING COMMENT 'Climate zone classification',
    `region_code` STRING COMMENT 'Region code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Default currency code for region',
    `region_description` STRING COMMENT 'Region description',
    `effective_from` DATE COMMENT 'Effective start date',
    `effective_until` DATE COMMENT 'Effective end date',
    `external_reference` STRING COMMENT 'External system reference code',
    `gdp_usd` DECIMAL(18,2) COMMENT 'GDP in USD',
    `geographic_center_name` STRING COMMENT 'Name of geographic center point',
    `hierarchy_level` STRING COMMENT 'Level in region hierarchy',
    `is_cross_border` BOOLEAN COMMENT 'Whether region spans multiple borders',
    `iso_country_code` STRING COMMENT 'ISO country code',
    `iso_region_code` STRING COMMENT 'ISO region/subdivision code',
    `latitude_center` DOUBLE COMMENT 'Center latitude coordinate',
    `longitude_center` DOUBLE COMMENT 'Center longitude coordinate',
    `median_income_usd` DECIMAL(18,2) COMMENT 'Median income in USD',
    `region_name` STRING COMMENT 'Region name',
    `population` BIGINT COMMENT 'Population count',
    `primary_language` STRING COMMENT 'Primary language spoken',
    `region_status` STRING COMMENT 'Region status (active/inactive)',
    `time_zone` STRING COMMENT 'Time zone identifier',
    `region_type` STRING COMMENT 'Region type (country, state, metro, etc.)',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `urbanization_rate` DECIMAL(18,2) COMMENT 'Urbanization rate percentage',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Geographic region hierarchy for market and operational segmentation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`country` (
    `country_id` BIGINT COMMENT 'Primary key',
    `region_id` BIGINT COMMENT 'FK to region',
    `capital_city` STRING COMMENT 'Capital city name',
    `continent` STRING COMMENT 'Continent name',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Default currency code',
    `dialing_code` STRING COMMENT 'International dialing code',
    `gdp_usd` DECIMAL(18,2) COMMENT 'GDP in USD',
    `is_active` BOOLEAN COMMENT 'Active status',
    `is_eu_member` BOOLEAN COMMENT 'EU membership flag',
    `iso_alpha2_code` STRING COMMENT 'ISO 3166-1 alpha-2 code',
    `iso_alpha3_code` STRING COMMENT 'ISO 3166-1 alpha-3 code',
    `iso_numeric_code` STRING COMMENT 'ISO 3166-1 numeric code',
    `country_name` STRING COMMENT 'Country name',
    `official_language` STRING COMMENT 'Official language',
    `population` BIGINT COMMENT 'Population',
    `time_zone_offset` STRING COMMENT 'Primary time zone offset',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_country PRIMARY KEY(`country_id`)
) COMMENT 'Country master reference data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`currency` (
    `currency_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `currency_code` STRING COMMENT 'ISO 4217 currency code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `decimal_places` STRING COMMENT 'Number of decimal places',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate to USD',
    `is_active` BOOLEAN COMMENT 'Active status',
    `iso_numeric_code` STRING COMMENT 'ISO 4217 numeric code',
    `currency_name` STRING COMMENT 'Currency name',
    `rate_effective_date` DATE COMMENT 'Date exchange rate is effective',
    `symbol` STRING COMMENT 'Currency symbol',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_currency PRIMARY KEY(`currency_id`)
) COMMENT 'Currency master reference data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` (
    `unit_of_measure_id` BIGINT COMMENT 'Primary key',
    `region_id` BIGINT COMMENT '',
    `base_uom_code` STRING COMMENT 'Base UOM code for conversion',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor to base UOM',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `unit_of_measure_description` STRING COMMENT 'Description',
    `is_active` BOOLEAN COMMENT 'Active status',
    `iso_code` STRING COMMENT 'ISO standard code',
    `uom_category` STRING COMMENT 'Category (weight, volume, length, etc.)',
    `uom_code` STRING COMMENT 'UOM code',
    `uom_name` STRING COMMENT 'UOM name',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_unit_of_measure PRIMARY KEY(`unit_of_measure_id`)
) COMMENT 'Unit of measure master reference data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`language` (
    `language_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `language_code` STRING COMMENT 'ISO 639-1 language code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `is_active` BOOLEAN COMMENT 'Active status',
    `language_name` STRING COMMENT 'Language name',
    `native_name` STRING COMMENT 'Language name in native script',
    `script_code` STRING COMMENT 'ISO 15924 script code',
    `text_direction` STRING COMMENT 'Text direction (LTR/RTL)',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_language PRIMARY KEY(`language_id`)
) COMMENT 'Language master reference data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Primary key',
    `region_id` BIGINT COMMENT '',
    `calendar_date` DATE COMMENT 'Calendar date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `day_of_week` STRING COMMENT 'Day of week (1=Mon)',
    `fiscal_period` STRING COMMENT 'Fiscal period/month',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter',
    `fiscal_week` STRING COMMENT 'Fiscal week number',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `holiday_name` STRING COMMENT 'Holiday name if applicable',
    `is_business_day` BOOLEAN COMMENT 'Whether it is a business day',
    `is_holiday` BOOLEAN COMMENT 'Whether it is a holiday',
    `month` STRING COMMENT 'Calendar month',
    `season` STRING COMMENT 'Season classification',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `week` STRING COMMENT 'ISO calendar week',
    `year` STRING COMMENT 'Calendar year',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Fiscal and operational calendar reference';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ADD CONSTRAINT `fk_shared_region_parent_region_id` FOREIGN KEY (`parent_region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`country` ADD CONSTRAINT `fk_shared_country_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` ADD CONSTRAINT `fk_shared_unit_of_measure_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` ADD CONSTRAINT `fk_shared_calendar_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_consumer_goods_v1`.`shared`.`region`(`region_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` SET TAGS ('dbx_subdomain' = 'geographic_hierarchy');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `latitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `latitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `longitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `longitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`region` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`country` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`country` SET TAGS ('dbx_subdomain' = 'geographic_hierarchy');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`country` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`country` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` SET TAGS ('dbx_subdomain' = 'reference_standards');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` ALTER COLUMN `sku_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`currency` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_subdomain' = 'reference_standards');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` ALTER COLUMN `region_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`unit_of_measure` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` SET TAGS ('dbx_subdomain' = 'reference_standards');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` ALTER COLUMN `sku_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`language` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` SET TAGS ('dbx_subdomain' = 'reference_standards');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` ALTER COLUMN `region_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` ALTER COLUMN `region_id` SET TAGS ('dbx_created_by' = 'create_link');
ALTER TABLE `vibe_consumer_goods_v1`.`shared`.`calendar` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
