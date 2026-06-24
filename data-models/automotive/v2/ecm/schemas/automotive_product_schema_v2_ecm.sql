-- Schema for Domain: product | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`product` COMMENT 'SSOT for the commercial vehicle product catalog and program portfolio. Owns nameplate definitions, model year program plans, option and package configurations, BOM (Bill of Materials) product structures, MSRP price books, feature-to-market availability matrices, and SKU (Stock Keeping Unit) structures. Distinct from engineering (which owns technical design data) and vehicle (which owns VIN-level production instances).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`bom_header` (
    `bom_header_id` BIGINT COMMENT '',
    `bom_id` BIGINT COMMENT '',
    `adas_level` STRING COMMENT '',
    `alternative_bom_group` STRING COMMENT '',
    `approved_by` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `base_unit_of_measure` STRING COMMENT '',
    `bom_status` STRING COMMENT '',
    `bom_type` STRING COMMENT '',
    `bom_usage` STRING COMMENT '',
    `change_number` STRING COMMENT '',
    `configuration_profile` STRING COMMENT '',
    `connectivity_package` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT '',
    `effective_from_date` DATE COMMENT '',
    `effective_to_date` DATE COMMENT '',
    `emissions_standard` STRING COMMENT '',
    `engineering_release_date` DATE COMMENT '',
    `eop_date` DATE COMMENT '',
    `homologation_status` STRING COMMENT '',
    `is_configurable` BOOLEAN COMMENT '',
    `lot_size_minimum` STRING COMMENT '',
    `market_region` STRING COMMENT '',
    `model_year` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `msrp_base_amount` DECIMAL(18,2) COMMENT '',
    `nameplate_code` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `online_configurator_linked_flag` BOOLEAN COMMENT '',
    `plant_code` STRING COMMENT '',
    `powertrain_type` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `safety_certification_level` STRING COMMENT '',
    `sop_date` DATE COMMENT '',
    `standard_cost_amount` DECIMAL(18,2) COMMENT '',
    `sustainability_score` DECIMAL(18,2) COMMENT '',
    `total_assembly_weight_kg` DECIMAL(18,2) COMMENT '',
    `total_component_count` STRING COMMENT '',
    `variant_code` STRING COMMENT '',
    `vin_pattern` STRING COMMENT '',
    `warranty_program_code` STRING COMMENT '',
    CONSTRAINT pk_bom_header PRIMARY KEY(`bom_header_id`)
) COMMENT 'Product-level BOM (Bill of Materials) header record representing the commercial product structure for a given SKU or model year program. Captures BOM number, BOM type (commercial/engineering/service), effective date range, revision level, plant applicability, BOM status (active/superseded/obsolete), and total component count. This is the commercial BOM owned by the product domain — distinct from the engineering BOM managed in Teamcenter/Windchill, which is owned by the engineering domain. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`product_bom_line` (
    `product_bom_line_id` BIGINT COMMENT '',
    `bom_header_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT '',
    `component_code` STRING COMMENT '',
    `component_description` STRING COMMENT '',
    `component_quantity` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `effective_from_date` DATE COMMENT '',
    `effective_to_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `is_optional_flag` BOOLEAN COMMENT '',
    `item_category` STRING COMMENT '',
    `line_number` STRING COMMENT '',
    `option_code` STRING COMMENT '',
    `part_description` STRING COMMENT '',
    `part_number` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `quantity_per` DECIMAL(18,2) COMMENT '',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'Quantity of the component required per parent assembly.',
    `scrap_percentage` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_product_bom_line PRIMARY KEY(`product_bom_line_id`)
) COMMENT 'Individual component line items within a product BOM (Bill of Materials). Captures BOM line number, part number, part description, part type (raw material/sub-assembly/purchased component/fastener), quantity per vehicle, unit of measure, effective date range, plant applicability, alternative item group, scrap factor percentage, and PPAP (Production Part Approval Process) status. Enables product cost rollup, MRP (Material Requirements Planning) explosion, and supply chain sourcing alignment. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`product_segment` (
    `product_segment_id` BIGINT COMMENT '',
    `parent_segment_product_segment_id` BIGINT COMMENT '',
    `adas_level_range` STRING COMMENT '',
    `annual_sales_volume_target` STRING COMMENT '',
    `body_style_category` STRING COMMENT '',
    `cafe_fleet_category` STRING COMMENT '',
    `cargo_volume_range_cu_ft` STRING COMMENT '',
    `competitive_set_definition` STRING COMMENT '',
    `connectivity_capability` BOOLEAN COMMENT '',
    `created_by_user` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `emissions_standard_target` STRING COMMENT '',
    `esg_segment_classification` STRING COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `homologation_regions` STRING COMMENT '',
    `industry_classification_code` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `lifecycle_status` STRING COMMENT '',
    `market_positioning_tier` STRING COMMENT '',
    `market_share_target_pct` DECIMAL(18,2) COMMENT '',
    `modified_by_user` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `ncap_rating_applicability` STRING COMMENT '',
    `ota_update_capability` BOOLEAN COMMENT '',
    `powertrain_category` STRING COMMENT '',
    `price_range_max_usd` DECIMAL(18,2) COMMENT '',
    `price_range_min_usd` DECIMAL(18,2) COMMENT '',
    `primary_use_case` STRING COMMENT '',
    `regulatory_category` STRING COMMENT '',
    `sae_classification_code` STRING COMMENT '',
    `seating_capacity_range` STRING COMMENT '',
    `segment_code` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
    `segment_name` STRING COMMENT '',
    `strategic_priority` STRING COMMENT '',
    `subscription_eligible_flag` BOOLEAN COMMENT '',
    `target_customer_profile` STRING COMMENT '',
    CONSTRAINT pk_product_segment PRIMARY KEY(`product_segment_id`)
) COMMENT 'Reference classification of vehicle market segments used to position nameplates competitively (e.g., Compact Car, Midsize SUV, Full-Size Pickup, Commercial Van, Luxury Sedan, Electric Crossover). Captures segment code, segment name, segment hierarchy level, parent segment, SAE/industry classification code, competitive set definition, and applicable regulatory category. Used in market planning, competitive benchmarking, CAFE fleet averaging, and sales reporting. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`catalog_publication` (
    `catalog_publication_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `catalog_employee_id` BIGINT COMMENT '',
    `catalog_version_id` BIGINT COMMENT '',
    `primary_catalog_employee_id` BIGINT COMMENT '',
    `superseded_by_publication_catalog_publication_id` BIGINT COMMENT '',
    `approval_timestamp` TIMESTAMP COMMENT '',
    `approved_by_user_name` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT '',
    `digital_storefront_flag` BOOLEAN COMMENT '',
    `distribution_confirmation_flag` BOOLEAN COMMENT '',
    `distribution_confirmation_timestamp` TIMESTAMP COMMENT '',
    `distribution_method` STRING COMMENT '',
    `distribution_retry_count` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `esg_disclosure_included_flag` BOOLEAN COMMENT '',
    `file_checksum` STRING COMMENT '',
    `file_name` STRING COMMENT '',
    `file_size_bytes` BIGINT COMMENT '',
    `language_code` STRING COMMENT '',
    `last_distribution_error` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `model_year` STRING COMMENT '',
    `nameplate_count` STRING COMMENT '',
    `priority_level` STRING COMMENT '',
    `publication_date` DATE COMMENT '',
    `publication_format` STRING COMMENT '',
    `publication_notes` STRING COMMENT '',
    `publication_number` STRING COMMENT '',
    `publication_status` STRING COMMENT '',
    `publication_type` STRING COMMENT '',
    `published_by_user_name` STRING COMMENT '',
    `recall_reason` STRING COMMENT '',
    `recall_timestamp` TIMESTAMP COMMENT '',
    `record_count` STRING COMMENT '',
    `regulatory_filing_date` DATE COMMENT '',
    `regulatory_filing_reference` STRING COMMENT '',
    `regulatory_filing_required_flag` BOOLEAN COMMENT '',
    `target_channel` STRING COMMENT '',
    `target_country_code` STRING COMMENT '',
    `target_region` STRING COMMENT '',
    `target_system` STRING COMMENT '',
    `trim_count` STRING COMMENT '',
    `validation_error_count` STRING COMMENT '',
    `validation_status` STRING COMMENT '',
    `validation_warning_count` STRING COMMENT '',
    CONSTRAINT pk_catalog_publication PRIMARY KEY(`catalog_publication_id`)
) COMMENT 'Tracks the formal publication events of the commercial product catalog to downstream consumers — dealer ordering systems (DMS), consumer configurators, sales portals, and regulatory filings. Captures publication ID, catalog version, publication type (dealer/consumer/regulatory/internal), target system/channel, publication date, effective date range, published-by user, publication status (draft/approved/published/recalled), and distribution confirmation. Provides an audit trail of when and to whom catalog versions were released. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`package_availability` (
    `package_availability_id` BIGINT COMMENT '',
    `aftersales_option_package_id` BIGINT COMMENT '',
    `catalog_publication_id` BIGINT COMMENT '',
    `dealership_id` BIGINT COMMENT '',
    `allocation_quantity` STRING COMMENT '',
    `availability_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discontinuation_date` DATE COMMENT '',
    `end_date` DATE COMMENT '',
    `is_orderable` BOOLEAN COMMENT '',
    `launch_date` DATE COMMENT '',
    `market_region` STRING COMMENT '',
    `order_constraint` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_package_availability PRIMARY KEY(`package_availability_id`)
) COMMENT 'Associates an option package with a dealership, capturing the availability status and launch date for that package at the dealer. Each record links one option package to one dealership and stores attributes that belong only to this relationship.. Existence Justification: Dealerships actively manage which option packages they carry, setting an availability status and launch date for each package. Each option package can be offered by many dealerships, and each dealership can offer many option packages, creating a many‑to‑many relationship that carries its own attributes. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` (
    `pricing_condition_assignment_id` BIGINT COMMENT '',
    `billing_price_condition_id` BIGINT COMMENT '',
    `catalog_version_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `calculation_type` STRING COMMENT '',
    `condition_status` STRING COMMENT '',
    `condition_type` STRING COMMENT '',
    `condition_value` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `priority_rank` STRING COMMENT '',
    CONSTRAINT pk_pricing_condition_assignment PRIMARY KEY(`pricing_condition_assignment_id`)
) COMMENT 'Represents the assignment of a pricing condition to a specific vehicle SKU. Each record links one SKU to one pricing condition and captures attributes that exist only in the context of this assignment, such as the condition value and its validity period.. Existence Justification: A pricing condition (e.g., discount, tax, freight) can be applied to many vehicle SKUs, and each SKU can have multiple pricing conditions such as MSRP, discounts, taxes, and fees. The pricing team actively creates, updates, and deletes these assignments, and each assignment carries attributes like value, validity dates, type, and status. This operational management makes the relationship a true many‑to‑many business entity. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`catalog_version` (
    `catalog_version_id` BIGINT COMMENT '',
    `previous_catalog_version_id` BIGINT COMMENT '',
    `msrp_price_book_id` BIGINT COMMENT '',
    `approval_status` STRING COMMENT '',
    `approved_by` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `catalog_type` STRING COMMENT '',
    `change_summary` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `data_governance_ref` STRING COMMENT '',
    `ecommerce_version_flag` BOOLEAN COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `esg_content_version` STRING COMMENT '',
    `is_current` BOOLEAN COMMENT '',
    `market_segment` STRING COMMENT '',
    `region_coverage` STRING COMMENT '',
    `release_notes` STRING COMMENT '',
    `sku_structure_code` BIGINT COMMENT '',
    `catalog_version_status` STRING COMMENT '',
    `total_models` STRING COMMENT '',
    `total_options` STRING COMMENT '',
    `updated_by` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `version_name` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    `version_source_system` STRING COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_catalog_version PRIMARY KEY(`catalog_version_id`)
) COMMENT 'Master reference table for catalog_version. Referenced by catalog_version_id. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key for sku',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` (
    `aftersales_model_year_program_id` BIGINT COMMENT '',
    `connected_services_tier` STRING COMMENT 'Tier of connected services available for this model year program',
    CONSTRAINT pk_aftersales_model_year_program PRIMARY KEY(`aftersales_model_year_program_id`)
) COMMENT 'SUPERSEDED: Use vehicle.vehicle_model_year_program as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` (
    `aftersales_option_package_id` BIGINT COMMENT '',
    `ota_updatable_flag` BOOLEAN COMMENT 'Whether this option package includes OTA-updatable features',
    CONSTRAINT pk_aftersales_option_package PRIMARY KEY(`aftersales_option_package_id`)
) COMMENT 'SUPERSEDED: Use vehicle.vehicle_option_package as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` (
    `msrp_price_book_id` BIGINT COMMENT 'Primary key for msrp_price_book',
    CONSTRAINT pk_msrp_price_book PRIMARY KEY(`msrp_price_book_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` (
    `aftersales_trim_level_id` BIGINT COMMENT '',
    `self_service_eligible_flag` BOOLEAN COMMENT 'Whether this trim level is eligible for self-service portal features',
    CONSTRAINT pk_aftersales_trim_level PRIMARY KEY(`aftersales_trim_level_id`)
) COMMENT 'SUPERSEDED: Use vehicle.vehicle_trim_level as the single source of truth.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` ADD CONSTRAINT `fk_product_product_segment_parent_segment_product_segment_id` FOREIGN KEY (`parent_segment_product_segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`product_segment`(`product_segment_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_superseded_by_publication_catalog_publication_id` FOREIGN KEY (`superseded_by_publication_catalog_publication_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` ADD CONSTRAINT `fk_product_package_availability_aftersales_option_package_id` FOREIGN KEY (`aftersales_option_package_id`) REFERENCES `vibe_automotive_v1`.`product`.`aftersales_option_package`(`aftersales_option_package_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` ADD CONSTRAINT `fk_product_package_availability_catalog_publication_id` FOREIGN KEY (`catalog_publication_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` ADD CONSTRAINT `fk_product_pricing_condition_assignment_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` ADD CONSTRAINT `fk_product_pricing_condition_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_automotive_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` ADD CONSTRAINT `fk_product_catalog_version_previous_catalog_version_id` FOREIGN KEY (`previous_catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` ADD CONSTRAINT `fk_product_catalog_version_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_automotive_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_subdomain' = 'bill_structure');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `msrp_base_amount` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_subdomain' = 'bill_structure');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_classification' = 'rate');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_esg_relevant' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` ALTER COLUMN `market_share_target_pct` SET TAGS ('dbx_classification' = 'rate');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` ALTER COLUMN `price_range_max_usd` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_segment` ALTER COLUMN `price_range_min_usd` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `catalog_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `catalog_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `primary_catalog_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `primary_catalog_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_masking_policy' = 'mask_in_nonprod');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_nonprod_masked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_masking_policy' = 'mask_in_nonprod');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_nonprod_masked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_association_edges' = 'product.option_package,dealer.dealership');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,billing.price_condition');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_value` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_source_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_eprocurement_linked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` SET TAGS ('dbx_source_system' = 'DMS');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` SET TAGS ('dbx_SAP_CS' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'sku Identifier');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` SET TAGS ('dbx_ssot_owner' = 'vehicle.vehicle_model_year_program');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_model_year_program` ALTER COLUMN `connected_services_tier` SET TAGS ('dbx_business_glossary_term' = 'Connected Services Tier');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` SET TAGS ('dbx_ssot_owner' = 'vehicle.vehicle_option_package');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_option_package` ALTER COLUMN `ota_updatable_flag` SET TAGS ('dbx_business_glossary_term' = 'OTA Updatable Flag');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_source_system' = 'DMS');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_SAP_CS' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'msrp_price_book Identifier');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` SET TAGS ('dbx_subdomain' = 'program_planning');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` SET TAGS ('dbx_ssot_owner' = 'vehicle.vehicle_trim_level');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`product`.`aftersales_trim_level` ALTER COLUMN `self_service_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Self Service Eligible Flag');
