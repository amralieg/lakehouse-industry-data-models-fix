-- Schema for Domain: product | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`product` COMMENT 'SSOT for the commercial vehicle product catalog and program portfolio. Owns nameplate definitions, model year program plans, option and package configurations, BOM (Bill of Materials) product structures, MSRP price books, feature-to-market availability matrices, and SKU (Stock Keeping Unit) structures. Distinct from engineering (which owns technical design data) and vehicle (which owns VIN-level production instances).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`bom_header` (
    `bom_header_id` BIGINT COMMENT '',
    `bom_id` BIGINT COMMENT '',
    `catalog_version_id` BIGINT COMMENT 'Foreign key linking to product.catalog_version. Business justification: A BOM header represents a commercial product structure that is published and versioned through the catalog lifecycle. Each BOM header is associated with a specific catalog version that governs its com',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering Change Management: when an ECO is approved, the product BOM header is revised. Change impact analysis, audit trails, and regulatory compliance reporting require direct traceability from a ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: BOM headers in automotive are plant-specific — a product BOM is released to a specific manufacturing plant for production execution. Plant-specific BOM management is standard SAP PP practice; plant_co',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: A BOM header represents a specific commercial vehicle product configuration that is positioned within a market segment (e.g., compact SUV, full-size truck, commercial van). The product_segment table i',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: The product SKU (catalog-configured vehicle/part) must resolve to an inventory SKU master record to enable stock queries, MRP planning, and goods movements. Automotive operations require this link to ',
    `adas_level` STRING COMMENT '',
    `alternative_bom_group` STRING COMMENT '',
    `approved_by` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `base_unit_of_measure` STRING COMMENT '',
    `bom_status` STRING COMMENT '',
    `bom_type` STRING COMMENT '',
    `bom_usage` STRING COMMENT '',
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
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: BOM line components must map to inventory SKU master records for MRP explosion, procurement planning, and goods receipt processing. Automotive MRP systems explode BOM lines against sku_master to gener',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`segment` (
    `segment_id` BIGINT COMMENT '',
    `parent_segment_product_segment_id` BIGINT COMMENT '',
    `adas_level_range` STRING COMMENT '',
    `annual_sales_volume_target` STRING COMMENT '',
    `body_style_category` STRING COMMENT '',
    `cafe_fleet_category` STRING COMMENT '',
    `cargo_volume_range_cu_ft` STRING COMMENT '',
    `segment_code` STRING COMMENT '',
    `competitive_set_definition` STRING COMMENT '',
    `connectivity_capability` BOOLEAN COMMENT '',
    `created_by_user` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
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
    `segment_name` STRING COMMENT '',
    `ncap_rating_applicability` STRING COMMENT '',
    `ota_update_capability` BOOLEAN COMMENT '',
    `powertrain_category` STRING COMMENT '',
    `price_range_max_usd` DECIMAL(18,2) COMMENT '',
    `price_range_min_usd` DECIMAL(18,2) COMMENT '',
    `primary_use_case` STRING COMMENT '',
    `regulatory_category` STRING COMMENT '',
    `sae_classification_code` STRING COMMENT '',
    `seating_capacity_range` STRING COMMENT '',
    `strategic_priority` STRING COMMENT '',
    `subscription_eligible_flag` BOOLEAN COMMENT '',
    `target_customer_profile` STRING COMMENT '',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Reference classification of vehicle market segments used to position nameplates competitively (e.g., Compact Car, Midsize SUV, Full-Size Pickup, Commercial Van, Luxury Sedan, Electric Crossover). Captures segment code, segment name, segment hierarchy level, parent segment, SAE/industry classification code, competitive set definition, and applicable regulatory category. Used in market planning, competitive benchmarking, CAFE fleet averaging, and sales reporting. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`catalog_publication` (
    `catalog_publication_id` BIGINT COMMENT '',
    `catalog_version_id` BIGINT COMMENT '',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Catalog publications (price lists, product specs) require regulatory filing in many markets (e.g., EU type approval publications, NHTSA filings). The three denormalized filing columns on catalog_publi',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`catalog_version` (
    `catalog_version_id` BIGINT COMMENT '',
    `msrp_price_book_id` BIGINT COMMENT '',
    `previous_catalog_version_id` BIGINT COMMENT '',
    `approval_status` STRING COMMENT '',
    `approved_by` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `catalog_type` STRING COMMENT '',
    `catalog_version_status` STRING COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` (
    `msrp_price_book_id` BIGINT COMMENT 'Primary key for msrp_price_book',
    CONSTRAINT pk_msrp_price_book PRIMARY KEY(`msrp_price_book_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `vibe_automotive_v1`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` ADD CONSTRAINT `fk_product_segment_parent_segment_product_segment_id` FOREIGN KEY (`parent_segment_product_segment_id`) REFERENCES `vibe_automotive_v1`.`product`.`segment`(`segment_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_superseded_by_publication_catalog_publication_id` FOREIGN KEY (`superseded_by_publication_catalog_publication_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` ADD CONSTRAINT `fk_product_package_availability_catalog_publication_id` FOREIGN KEY (`catalog_publication_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` ADD CONSTRAINT `fk_product_catalog_version_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `vibe_automotive_v1`.`product`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` ADD CONSTRAINT `fk_product_catalog_version_previous_catalog_version_id` FOREIGN KEY (`previous_catalog_version_id`) REFERENCES `vibe_automotive_v1`.`product`.`catalog_version`(`catalog_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_automotive_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` SET TAGS ('dbx_subdomain' = 'bill_materials');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `msrp_base_amount` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`bom_header` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` SET TAGS ('dbx_subdomain' = 'bill_materials');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `vibe_automotive_v1`.`product`.`product_bom_line` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_classification' = 'rate');
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` SET TAGS ('dbx_subdomain' = 'catalog_pricing');
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` ALTER COLUMN `market_share_target_pct` SET TAGS ('dbx_classification' = 'rate');
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` ALTER COLUMN `price_range_max_usd` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`segment` ALTER COLUMN `price_range_min_usd` SET TAGS ('dbx_monetary' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` SET TAGS ('dbx_subdomain' = 'catalog_pricing');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_masking_policy' = 'mask_in_nonprod');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_nonprod_masked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_masking_policy' = 'mask_in_nonprod');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_nonprod_masked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`package_availability` SET TAGS ('dbx_subdomain' = 'catalog_pricing');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`catalog_version` SET TAGS ('dbx_subdomain' = 'catalog_pricing');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` SET TAGS ('dbx_subdomain' = 'bill_materials');
ALTER TABLE `vibe_automotive_v1`.`product`.`msrp_price_book` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'msrp_price_book Identifier');
