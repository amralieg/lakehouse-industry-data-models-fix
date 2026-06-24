-- Schema for Domain: product | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`product` COMMENT 'Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Identifier for the cost center associated with this sku record (cost center id).',
    `gl_account_id` BIGINT COMMENT '',
    `hierarchy_id` BIGINT COMMENT '',
    `innovation_brief_id` BIGINT COMMENT '',
    `marketing_brand_id` BIGINT COMMENT '',
    `rd_project_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `supplier_site_id` BIGINT COMMENT '',
    `product_brand_id` BIGINT COMMENT '',
    `product_category_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT '',
    `category_id` BIGINT COMMENT '',
    `sku_group_id` BIGINT COMMENT '',
    `sku_code` STRING COMMENT '',
    `color` STRING COMMENT 'Color of the sku color.',
    `country_of_origin` STRING COMMENT 'The country of origin of the sku.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `default_supply_network_node_id` BIGINT COMMENT '',
    `discontinuation_date` DATE COMMENT '',
    `ean` STRING COMMENT '',
    `fefo_threshold_pct` DECIMAL(18,2) COMMENT '',
    `generated_flag` BOOLEAN COMMENT 'Auto‑generated flag for v2 rebuild',
    `gross_weight_kg` DECIMAL(18,2) COMMENT '',
    `gtin` STRING COMMENT '',
    `inci_declaration` STRING COMMENT '',
    `is_hazardous` BOOLEAN COMMENT '',
    `is_recyclable_packaging` BOOLEAN COMMENT '',
    `is_regulated_product` BOOLEAN COMMENT '',
    `is_sustainable` BOOLEAN COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `launch_date` DATE COMMENT '',
    `lifecycle_stage` STRING COMMENT '',
    `msrp` DECIMAL(18,2) COMMENT '',
    `net_content` DECIMAL(18,2) COMMENT '',
    `net_content_uom` STRING COMMENT '',
    `net_weight_kg` DECIMAL(18,2) COMMENT '',
    `pack_size` STRING COMMENT '',
    `packaging_material_type` STRING COMMENT '',
    `portfolio_classification` STRING COMMENT '',
    `product_form` STRING COMMENT '',
    `product_lca_id` BIGINT COMMENT '',
    `product_name` STRING COMMENT '',
    `regulatory_category` STRING COMMENT '',
    `scent` STRING COMMENT '',
    `short_description` STRING COMMENT '',
    `sku_status` STRING COMMENT '',
    `standard_cost` DECIMAL(18,2) COMMENT '',
    `storage_conditions` STRING COMMENT '',
    `sub_brand` STRING COMMENT '',
    `subcategory` STRING COMMENT '',
    `target_demographic` STRING COMMENT '',
    `total_shelf_life_days` STRING COMMENT '',
    `upc` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `variant` STRING COMMENT '',
    `volume_ml` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock keeping unit master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` (
    `gtin_registry_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `activation_date` DATE COMMENT '',
    `assignment_date` DATE COMMENT '',
    `barcode_symbology` STRING COMMENT '',
    `brand_name` STRING COMMENT '',
    `brand_owner_gln` STRING COMMENT '',
    `cases_per_pallet` STRING COMMENT '',
    `check_digit` STRING COMMENT '',
    `country_of_origin` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_pool_publication_date` DATE COMMENT '',
    `data_pool_published` BOOLEAN COMMENT '',
    `ean_value` DECIMAL(18,2) COMMENT '',
    `edi_eligible` BOOLEAN COMMENT '',
    `gpc_brick_code` STRING COMMENT '',
    `gs1_company_prefix` STRING COMMENT '',
    `gs1_member_org` STRING COMMENT '',
    `gs1_registration_reference` STRING COMMENT '',
    `gs1_registry_published` BOOLEAN COMMENT '',
    `gtin_format` STRING COMMENT '',
    `gtin_value` DECIMAL(18,2) COMMENT '',
    `indicator_digit` STRING COMMENT '',
    `inner_packs_per_case` STRING COMMENT '',
    `is_consumer_unit` BOOLEAN COMMENT '',
    `is_orderable` BOOLEAN COMMENT '',
    `is_scannable` BOOLEAN COMMENT '',
    `is_variable_measure` BOOLEAN COMMENT '',
    `item_reference_number` STRING COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `net_content_uom` STRING COMMENT '',
    `net_content_value` DECIMAL(18,2) COMMENT '',
    `packaging_level` STRING COMMENT '',
    `plm_lifecycle_stage` STRING COMMENT '',
    `product_category` STRING COMMENT '',
    `product_description` STRING COMMENT '',
    `registration_status` STRING COMMENT '',
    `retirement_date` DATE COMMENT '',
    `source_system_key` STRING COMMENT '',
    `target_market_country` STRING COMMENT '',
    `units_per_case` STRING COMMENT '',
    `upc_value` DECIMAL(18,2) COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_gtin_registry PRIMARY KEY(`gtin_registry_id`)
) COMMENT 'GTIN registry for product identification';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `parent_hierarchy_id` BIGINT COMMENT '',
    `approved_date` DATE COMMENT '',
    `brand_code` STRING COMMENT '',
    `category_code` STRING COMMENT '',
    `channel_applicability` STRING COMMENT '',
    `consumer_segment` STRING COMMENT '',
    `cpsc_regulated` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `division_code` STRING COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `external_reference_code` STRING COMMENT '',
    `gmp_standard` STRING COMMENT '',
    `gpc_brick_code` STRING COMMENT '',
    `gpc_brick_name` STRING COMMENT '',
    `ibp_planning_level` BOOLEAN COMMENT '',
    `inci_applicable` BOOLEAN COMMENT '',
    `iri_category_code` STRING COMMENT '',
    `is_leaf_node` BOOLEAN COMMENT '',
    `language_code` STRING COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `level_name` STRING COMMENT '',
    `market_share_reportable` BOOLEAN COMMENT '',
    `nielsen_category_code` STRING COMMENT '',
    `node_code` STRING COMMENT '',
    `node_description` STRING COMMENT '',
    `node_name` STRING COMMENT '',
    `node_status` STRING COMMENT '',
    `path` STRING COMMENT '',
    `plm_lifecycle_stage` STRING COMMENT '',
    `profit_center_code` STRING COMMENT '',
    `reach_regulated` BOOLEAN COMMENT '',
    `regulatory_framework` STRING COMMENT '',
    `sort_order` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `source_system_node_code` STRING COMMENT '',
    `sustainability_flag` BOOLEAN COMMENT '',
    `tax_category_code` STRING COMMENT '',
    `trade_promotion_eligible` BOOLEAN COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Product hierarchy structure';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` (
    `product_bom_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `alternative_bom` STRING COMMENT '',
    `approved_date` DATE COMMENT '',
    `base_quantity` DECIMAL(18,2) COMMENT '',
    `base_uom` STRING COMMENT '',
    `bom_category` STRING COMMENT '',
    `bom_description` STRING COMMENT '',
    `bom_level` STRING COMMENT '',
    `bom_number` STRING COMMENT '',
    `bom_type` STRING COMMENT '',
    `change_number` STRING COMMENT '',
    `component_count` STRING COMMENT '',
    `costing_relevance` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `deletion_flag` BOOLEAN COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `formulation_code` STRING COMMENT '',
    `gmp_compliant` BOOLEAN COMMENT '',
    `is_configurable` BOOLEAN COMMENT '',
    `is_phantom` BOOLEAN COMMENT '',
    `last_changed_by` STRING COMMENT '',
    `last_changed_timestamp` TIMESTAMP COMMENT '',
    `lot_size_from` DECIMAL(18,2) COMMENT '',
    `lot_size_to` DECIMAL(18,2) COMMENT '',
    `lot_size_uom` STRING COMMENT '',
    `material_number` STRING COMMENT '',
    `mrp_relevance` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `plant_code` STRING COMMENT '',
    `plm_status` STRING COMMENT '',
    `production_version` STRING COMMENT '',
    `reach_compliant` BOOLEAN COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `rspo_certified` BOOLEAN COMMENT '',
    `source_system_bom_code` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `version` STRING COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_product_bom PRIMARY KEY(`product_bom_id`)
) COMMENT 'Product bill of materials';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Primary key',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `product_bom_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `alternative_item_group` STRING COMMENT '',
    `alternative_priority` STRING COMMENT '',
    `bom_item_category` STRING COMMENT '',
    `bulk_material_flag` BOOLEAN COMMENT '',
    `change_number` STRING COMMENT '',
    `co_product_flag` BOOLEAN COMMENT '',
    `component_cost_usd` DECIMAL(18,2) COMMENT '',
    `component_description` STRING COMMENT '',
    `component_item_number` STRING COMMENT '',
    `component_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `fixed_quantity_flag` BOOLEAN COMMENT '',
    `hazardous_material_flag` BOOLEAN COMMENT '',
    `inci_name` STRING COMMENT '',
    `is_alternative_item` BOOLEAN COMMENT '',
    `is_critical_component` BOOLEAN COMMENT '',
    `issue_method` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_offset_days` STRING COMMENT '',
    `line_number` STRING COMMENT '',
    `line_status` STRING COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT '',
    `operation_number` BIGINT COMMENT '',
    `phantom_item_flag` BOOLEAN COMMENT '',
    `reach_registration_number` STRING COMMENT '',
    `recursive_bom_flag` BOOLEAN COMMENT '',
    `required_quantity` DECIMAL(18,2) COMMENT '',
    `scrap_percentage` DECIMAL(18,2) COMMENT '',
    `sds_document_number` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `storage_location` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `usage_probability_pct` DECIMAL(18,2) COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `valid_from_date` DATE COMMENT '',
    `valid_to_date` DATE COMMENT '',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'BOM line items';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` (
    `product_formulation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `research_formulation_id` BIGINT COMMENT '',
    `sds_id` BIGINT COMMENT '',
    `active_ingredient_name` STRING COMMENT '',
    `active_ingredient_pct` DECIMAL(18,2) COMMENT '',
    `allergen_declaration` STRING COMMENT '',
    `approval_date` DATE COMMENT '',
    `bom_reference_code` STRING COMMENT '',
    `color_description` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `formulation_code` STRING COMMENT '',
    `formulation_name` STRING COMMENT '',
    `formulation_type` STRING COMMENT '',
    `fragrance_code` STRING COMMENT '',
    `gmp_compliance_flag` BOOLEAN COMMENT '',
    `inci_declaration` STRING COMMENT '',
    `intended_use` STRING COMMENT '',
    `is_cruelty_free` BOOLEAN COMMENT '',
    `is_fragrance_free` BOOLEAN COMMENT '',
    `is_vegan` BOOLEAN COMMENT '',
    `lab_notebook_reference` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_stage` STRING COMMENT '',
    `obsolescence_date` DATE COMMENT '',
    `ph_max` DECIMAL(18,2) COMMENT '',
    `ph_min` DECIMAL(18,2) COMMENT '',
    `preservative_system` STRING COMMENT '',
    `product_category` STRING COMMENT '',
    `rd_project_code` STRING COMMENT '',
    `reach_registration_number` STRING COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `regulatory_classification` STRING COMMENT '',
    `rspo_certified` BOOLEAN COMMENT '',
    `source_system_code` STRING COMMENT '',
    `stability_period_months` STRING COMMENT '',
    `storage_condition` STRING COMMENT '',
    `total_solid_content_pct` DECIMAL(18,2) COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `version_number` STRING COMMENT '',
    `viscosity_max_cps` DECIMAL(18,2) COMMENT '',
    `viscosity_min_cps` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_product_formulation PRIMARY KEY(`product_formulation_id`)
) COMMENT 'Product formulation master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` (
    `product_formulation_ingredient_id` BIGINT COMMENT 'Primary key',
    `product_formulation_id` BIGINT COMMENT '',
    `raw_material_spec_id` BIGINT COMMENT '',
    `allergen_declaration` STRING COMMENT '',
    `approved_by` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `cas_number` STRING COMMENT '',
    `concentration_max_pct` DECIMAL(18,2) COMMENT '',
    `concentration_min_pct` DECIMAL(18,2) COMMENT '',
    `concentration_nominal_pct` DECIMAL(18,2) COMMENT '',
    `concentration_uom` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `ec_number` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `fda_status` STRING COMMENT '',
    `ghs_hazard_classification` STRING COMMENT '',
    `grade_specification` STRING COMMENT '',
    `halal_status` STRING COMMENT '',
    `ifra_compliance_status` STRING COMMENT '',
    `inci_name` STRING COMMENT '',
    `ingredient_function` STRING COMMENT '',
    `ingredient_name` STRING COMMENT '',
    `ingredient_status` STRING COMMENT '',
    `is_active_ingredient` BOOLEAN COMMENT '',
    `is_fragrance_allergen` BOOLEAN COMMENT '',
    `is_natural_origin` BOOLEAN COMMENT '',
    `is_palm_derived` BOOLEAN COMMENT '',
    `is_prohibited_substance` BOOLEAN COMMENT '',
    `is_restricted_substance` BOOLEAN COMMENT '',
    `line_number` STRING COMMENT '',
    `natural_origin_index` DECIMAL(18,2) COMMENT '',
    `origin_country_code` STRING COMMENT '',
    `physical_form` STRING COMMENT '',
    `reach_registration_number` STRING COMMENT '',
    `reach_registration_status` STRING COMMENT '',
    `regulatory_limit_reference` STRING COMMENT '',
    `regulatory_max_concentration_pct` DECIMAL(18,2) COMMENT '',
    `sds_reference_number` STRING COMMENT '',
    `sds_version` STRING COMMENT '',
    `supplier_code` STRING COMMENT '',
    `supplier_material_code` STRING COMMENT '',
    `svhc_flag` BOOLEAN COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `vegan_status` STRING COMMENT '',
    CONSTRAINT pk_product_formulation_ingredient PRIMARY KEY(`product_formulation_ingredient_id`)
) COMMENT 'Formulation ingredients';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` (
    `product_packaging_spec_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `approval_status` STRING COMMENT '',
    `artwork_ref` STRING COMMENT '',
    `color` STRING COMMENT '',
    `component_type` STRING COMMENT '',
    `country_of_origin` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `ean` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `finish` STRING COMMENT '',
    `gross_weight_g` DECIMAL(18,2) COMMENT '',
    `gtin` STRING COMMENT '',
    `hazmat_flag` BOOLEAN COMMENT '',
    `height_mm` DECIMAL(18,2) COMMENT '',
    `hi` STRING COMMENT '',
    `is_fsc_certified` BOOLEAN COMMENT '',
    `is_rspo_certified` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `length_mm` DECIMAL(18,2) COMMENT '',
    `lifecycle_status` STRING COMMENT '',
    `material_composition` STRING COMMENT '',
    `moq` STRING COMMENT '',
    `packaging_level` STRING COMMENT '',
    `pcr_content_pct` DECIMAL(18,2) COMMENT '',
    `print_method` STRING COMMENT '',
    `qty_per_parent` STRING COMMENT '',
    `recyclability_code` STRING COMMENT '',
    `regulatory_compliance_flag` BOOLEAN COMMENT '',
    `spec_code` STRING COMMENT '',
    `spec_name` STRING COMMENT '',
    `supplier_tooling_ref` STRING COMMENT '',
    `tare_weight_g` DECIMAL(18,2) COMMENT '',
    `ti` STRING COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `upc` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `version_number` STRING COMMENT '',
    `width_mm` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_product_packaging_spec PRIMARY KEY(`product_packaging_spec_id`)
) COMMENT 'Product packaging specifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` (
    `plm_transition_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `product_brand_id` BIGINT COMMENT '',
    `product_formulation_id` BIGINT COMMENT '',
    `rd_project_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `approval_reference` STRING COMMENT '',
    `comments` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `from_stage_code` STRING COMMENT '',
    `gate_criteria_detail` STRING COMMENT '',
    `gate_criteria_validation_result` STRING COMMENT '',
    `gate_review_notes` STRING COMMENT '',
    `is_fast_track` BOOLEAN COMMENT '',
    `product_category_code` STRING COMMENT '',
    `regulatory_submission_reference` STRING COMMENT '',
    `regulatory_submission_required` BOOLEAN COMMENT '',
    `revised_launch_date` DATE COMMENT '',
    `source_system_code` STRING COMMENT '',
    `source_system_transition_code` STRING COMMENT '',
    `stage_entry_date` DATE COMMENT '',
    `stage_exit_date` DATE COMMENT '',
    `target_launch_date` DATE COMMENT '',
    `to_stage_code` STRING COMMENT '',
    `transition_date` DATE COMMENT '',
    `transition_reason_code` STRING COMMENT '',
    `transition_reason_description` STRING COMMENT '',
    `transition_reference_number` STRING COMMENT '',
    `transition_status` STRING COMMENT '',
    `transition_timestamp` TIMESTAMP COMMENT '',
    `transition_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `waiver_reference` STRING COMMENT '',
    CONSTRAINT pk_plm_transition PRIMARY KEY(`plm_transition_id`)
) COMMENT 'PLM stage transitions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `allergen_declaration` STRING COMMENT '',
    `approval_status` STRING COMMENT '',
    `artwork_file_reference` STRING COMMENT '',
    `barcode_placement` STRING COMMENT '',
    `barcode_type` STRING COMMENT '',
    `certification_marks` STRING COMMENT '',
    `claim_text` STRING COMMENT '',
    `color_profile` STRING COMMENT '',
    `country_of_origin` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `digital_watermark_enabled` BOOLEAN COMMENT '',
    `distributor_name` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gtin` STRING COMMENT '',
    `ingredient_declaration_text` STRING COMMENT '',
    `is_primary_label` BOOLEAN COMMENT '',
    `label_approval_date` DATE COMMENT '',
    `label_dimensions` STRING COMMENT '',
    `label_type` STRING COMMENT '',
    `label_version` STRING COMMENT '',
    `language_code` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lot_code_format` STRING COMMENT '',
    `mandatory_regulatory_statements` STRING COMMENT '',
    `manufacturer_address` STRING COMMENT '',
    `manufacturer_name` STRING COMMENT '',
    `market_country_code` STRING COMMENT '',
    `net_content_declaration` STRING COMMENT '',
    `nutrition_facts_required` BOOLEAN COMMENT '',
    `plm_change_order_number` STRING COMMENT '',
    `print_process` STRING COMMENT '',
    `recycling_symbol_code` STRING COMMENT '',
    `regulatory_framework` STRING COMMENT '',
    `regulatory_registration_number` STRING COMMENT '',
    `shelf_life_statement` STRING COMMENT '',
    `substrate_material` STRING COMMENT '',
    `usage_instructions` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `veeva_document_reference` STRING COMMENT '',
    `warning_statements` STRING COMMENT '',
    CONSTRAINT pk_label_spec PRIMARY KEY(`label_spec_id`)
) COMMENT 'Label specifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` (
    `product_claim_id` BIGINT COMMENT 'Primary key',
    `claim_substantiation_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `applicable_markets` STRING COMMENT '',
    `approval_date` DATE COMMENT '',
    `certification_body` STRING COMMENT '',
    `certification_expiry_date` DATE COMMENT '',
    `certification_number` STRING COMMENT '',
    `channel` STRING COMMENT '',
    `claim_code` STRING COMMENT '',
    `claim_scope` STRING COMMENT '',
    `claim_status` STRING COMMENT '',
    `claim_text` STRING COMMENT '',
    `claim_type` STRING COMMENT '',
    `claim_value` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT '',
    `environmental_claim_standard` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `fda_reviewed` BOOLEAN COMMENT '',
    `ftc_compliant` BOOLEAN COMMENT '',
    `inci_ingredient_ref` STRING COMMENT '',
    `language_code` STRING COMMENT '',
    `legal_reviewed` BOOLEAN COMMENT '',
    `legal_reviewer` STRING COMMENT '',
    `marketing_approved` BOOLEAN COMMENT '',
    `next_review_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `plm_stage` STRING COMMENT '',
    `quantitative_claim` BOOLEAN COMMENT '',
    `regulatory_body` STRING COMMENT '',
    `review_frequency_days` STRING COMMENT '',
    `scientific_reviewer` STRING COMMENT '',
    `source_system_claim_code` STRING COMMENT '',
    `substantiation_method` STRING COMMENT '',
    `subtype` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `value_unit` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    `withdrawal_date` DATE COMMENT '',
    `withdrawal_reason` STRING COMMENT '',
    CONSTRAINT pk_product_claim PRIMARY KEY(`product_claim_id`)
) COMMENT 'Product claims';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` (
    `product_brand_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `architecture_type` STRING COMMENT '',
    `brand_name` STRING COMMENT '',
    `brand_status` STRING COMMENT '',
    `brand_tier` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `distribution_channel` STRING COMMENT '',
    `divestiture_date` DATE COMMENT '',
    `ean_prefix` STRING COMMENT '',
    `equity_methodology` STRING COMMENT '',
    `geographic_scope` STRING COMMENT '',
    `gmp_certification_ref` STRING COMMENT '',
    `is_licensed_brand` BOOLEAN COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `launch_date` DATE COMMENT '',
    `launch_year` STRING COMMENT '',
    `license_expiry_date` DATE COMMENT '',
    `msrp_currency_code` STRING COMMENT '',
    `nps_tracking_enabled` BOOLEAN COMMENT '',
    `owner_division` STRING COMMENT '',
    `owner_entity` STRING COMMENT '',
    `parent_brand_code` STRING COMMENT '',
    `plm_stage` STRING COMMENT '',
    `positioning_statement` STRING COMMENT '',
    `primary_category` STRING COMMENT '',
    `primary_country_code` STRING COMMENT '',
    `regulatory_classification` STRING COMMENT '',
    `short_name` STRING COMMENT '',
    `social_media_handle` STRING COMMENT '',
    `source_system_brand_code` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `sustainability_certification` STRING COMMENT '',
    `target_consumer_segment` STRING COMMENT '',
    `trade_promotion_eligible` BOOLEAN COMMENT '',
    `trademark_jurisdiction` STRING COMMENT '',
    `trademark_registration_ref` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `website_url` STRING COMMENT '',
    CONSTRAINT pk_product_brand PRIMARY KEY(`product_brand_id`)
) COMMENT 'Product brand master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` (
    `sku_substitution_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `to_sku_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `approval_status` STRING COMMENT '',
    `atp_substitution_enabled` BOOLEAN COMMENT '',
    `auto_substitution_allowed` BOOLEAN COMMENT '',
    `channel_code` STRING COMMENT '',
    `cogs_impact_pct` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_approval_required` BOOLEAN COMMENT '',
    `demand_history_normalization` BOOLEAN COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_bidirectional` BOOLEAN COMMENT '',
    `market_code` STRING COMMENT '',
    `plm_change_order_ref` STRING COMMENT '',
    `price_adjustment_pct` DECIMAL(18,2) COMMENT '',
    `priority_rank` STRING COMMENT '',
    `quantity_conversion_factor` DECIMAL(18,2) COMMENT '',
    `reason_code` STRING COMMENT '',
    `regulatory_change_ref` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `source_system_record_code` STRING COMMENT '',
    `substitution_notes` STRING COMMENT '',
    `substitution_scope` STRING COMMENT '',
    `substitution_status` STRING COMMENT '',
    `substitution_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `veeva_document_reference` STRING COMMENT '',
    CONSTRAINT pk_sku_substitution PRIMARY KEY(`sku_substitution_id`)
) COMMENT 'SKU substitution rules';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` (
    `pack_hierarchy_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cumulative_quantity` STRING COMMENT '',
    `display_ready_flag` BOOLEAN COMMENT '',
    `ean` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `gross_weight_kg` DECIMAL(18,2) COMMENT '',
    `gtin` STRING COMMENT '',
    `height_cm` DECIMAL(18,2) COMMENT '',
    `hi_count` STRING COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `length_cm` DECIMAL(18,2) COMMENT '',
    `max_stack_height` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `moq` STRING COMMENT '',
    `net_weight_kg` DECIMAL(18,2) COMMENT '',
    `orderable_flag` BOOLEAN COMMENT '',
    `pack_hierarchy_status` STRING COMMENT '',
    `packaging_material` STRING COMMENT '',
    `pallet_type` STRING COMMENT '',
    `quantity_per_level` STRING COMMENT '',
    `recyclable_flag` BOOLEAN COMMENT '',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT '',
    `shippable_flag` BOOLEAN COMMENT '',
    `stackable_flag` BOOLEAN COMMENT '',
    `tare_weight_kg` DECIMAL(18,2) COMMENT '',
    `ti_count` STRING COMMENT '',
    `upc` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `volume_cubic_cm` DECIMAL(18,2) COMMENT '',
    `width_cm` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_pack_hierarchy PRIMARY KEY(`pack_hierarchy_id`)
) COMMENT 'Pack hierarchy structure';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`certification` (
    `certification_id` BIGINT COMMENT 'Primary key',
    `product_formulation_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `applicable_channels` STRING COMMENT '',
    `applicable_markets` STRING COMMENT '',
    `audit_date` DATE COMMENT '',
    `audit_result` STRING COMMENT '',
    `body` STRING COMMENT '',
    `certificate_document_reference` STRING COMMENT '',
    `certificate_number` STRING COMMENT '',
    `certification_status` STRING COMMENT '',
    `certification_type` STRING COMMENT '',
    `claim_text` STRING COMMENT '',
    `consumer_facing_flag` BOOLEAN COMMENT '',
    `cost_amount` DECIMAL(18,2) COMMENT '',
    `cost_currency_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `issue_date` DATE COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `logo_file_reference` STRING COMMENT '',
    `logo_usage_approved` BOOLEAN COMMENT '',
    `next_audit_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `renewal_date` DATE COMMENT '',
    `retailer_requirement_flag` BOOLEAN COMMENT '',
    `scope` STRING COMMENT '',
    `standard_version` STRING COMMENT '',
    `sustainability_pillar` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `verification_url` STRING COMMENT '',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Product certifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` (
    `product_registration_id` BIGINT COMMENT 'Primary key',
    `shopper_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `registration_date` DATE COMMENT '',
    `registration_source` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `warranty_status` STRING COMMENT '',
    `product_registration_status` STRING COMMENT 'Lifecycle status of the product_registration record',
    `effective_date` DATE COMMENT 'Date the product_registration becomes effective',
    `expiration_date` DATE COMMENT 'Date the product_registration expires',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity associated with the product_registration',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the product_registration',
    `product_registration_description` STRING COMMENT 'Free-text description of the product_registration',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the product_registration was created',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the product_registration was last updated',
    CONSTRAINT pk_product_registration PRIMARY KEY(`product_registration_id`)
) COMMENT 'Consumer product registrations';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` (
    `vmi_sku_assignment_id` BIGINT COMMENT 'Primary key',
    `customer_vmi_agreement_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `forecast_sharing_cadence` STRING COMMENT '',
    `max_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT '',
    `min_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT '',
    `replenishment_frequency` STRING COMMENT '',
    `replenishment_lead_time_days` STRING COMMENT '',
    `safety_stock_weeks` DECIMAL(18,2) COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `vmi_sku_assignment_status` STRING COMMENT '',
    `effective_date` STRING COMMENT '',
    CONSTRAINT pk_vmi_sku_assignment PRIMARY KEY(`vmi_sku_assignment_id`)
) COMMENT 'VMI SKU assignments';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` (
    `freight_contract_assignment_id` BIGINT COMMENT 'Primary key',
    `carrier_contract_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `agreed_rate` DECIMAL(18,2) COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `volume_commitment` DECIMAL(18,2) COMMENT '',
    `freight_contract_assignment_status` STRING COMMENT '',
    `expiration_date` STRING COMMENT '',
    `created_at` STRING COMMENT '',
    `updated_at` STRING COMMENT '',
    CONSTRAINT pk_freight_contract_assignment PRIMARY KEY(`freight_contract_assignment_id`)
) COMMENT 'Freight contract SKU assignments';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key',
    `sku_id` BIGINT COMMENT '',
    `supplier_contract_id` BIGINT COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT '',
    `price_uom` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `validity_end_date` DATE COMMENT '',
    `validity_start_date` DATE COMMENT '',
    `supply_agreement_status` STRING COMMENT '',
    `effective_date` STRING COMMENT '',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Supply agreements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key',
    `parent_category_id` BIGINT COMMENT '',
    `classification_type` STRING COMMENT '',
    `category_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `category_description` STRING COMMENT '',
    `display_order` STRING COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `image_url` STRING COMMENT '',
    `is_leaf` BOOLEAN COMMENT '',
    `marketing_tag` STRING COMMENT '',
    `category_name` STRING COMMENT '',
    `category_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Product categories';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`material` (
    `material_id` BIGINT COMMENT 'Primary key',
    `parent_material_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `allergen_info` STRING COMMENT '',
    `base_uom` STRING COMMENT '',
    `brand_name` STRING COMMENT '',
    `material_code` STRING COMMENT '',
    `country_of_origin` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `material_description` STRING COMMENT '',
    `ean` STRING COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `gtin` STRING COMMENT '',
    `hazardous_flag` BOOLEAN COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_stage` STRING COMMENT '',
    `material_group` STRING COMMENT '',
    `material_type` STRING COMMENT '',
    `material_name` STRING COMMENT '',
    `packaging_type` STRING COMMENT '',
    `regulatory_status` STRING COMMENT '',
    `shelf_life_days` STRING COMMENT '',
    `standard_cost` DECIMAL(18,2) COMMENT '',
    `material_status` STRING COMMENT '',
    `storage_temperature_c` DECIMAL(18,2) COMMENT '',
    `unit_conversion_factor` DECIMAL(18,2) COMMENT '',
    `upc` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `volume_l` DECIMAL(18,2) COMMENT '',
    `weight_kg` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Material master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` (
    `sku_group_id` BIGINT COMMENT 'Primary key',
    `parent_group_id` BIGINT COMMENT '',
    `parent_sku_group_id` BIGINT COMMENT '',
    `average_price` DECIMAL(18,2) COMMENT '',
    `sku_group_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `sku_group_description` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `is_default` BOOLEAN COMMENT '',
    `last_audit_date` DATE COMMENT '',
    `sku_group_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `packaging_type` STRING COMMENT '',
    `product_count` STRING COMMENT '',
    `regulatory_status` STRING COMMENT '',
    `sku_group_status` STRING COMMENT '',
    `total_weight_kg` DECIMAL(18,2) COMMENT '',
    `sku_group_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_sku_group PRIMARY KEY(`sku_group_id`)
) COMMENT 'SKU groupings';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_category` (
    `product_category_id` BIGINT COMMENT 'Primary key',
    `parent_category_id` BIGINT COMMENT '',
    `parent_product_category_id` BIGINT COMMENT '',
    `business_unit` STRING COMMENT '',
    `category_code` STRING COMMENT '',
    `category_description` STRING COMMENT '',
    `category_name` STRING COMMENT '',
    `classification` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `hierarchy_path` STRING COMMENT '',
    `is_leaf` BOOLEAN COMMENT '',
    `source_system_code` STRING COMMENT '',
    `product_category_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_product_category PRIMARY KEY(`product_category_id`)
) COMMENT 'Product category hierarchy';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_sku_group_id` FOREIGN KEY (`sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_hierarchy_id` FOREIGN KEY (`parent_hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ADD CONSTRAINT `fk_product_product_formulation_ingredient_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ADD CONSTRAINT `fk_product_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_product_brand_id` FOREIGN KEY (`product_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_brand`(`product_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ADD CONSTRAINT `fk_product_plm_transition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ADD CONSTRAINT `fk_product_product_claim_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ADD CONSTRAINT `fk_product_sku_substitution_to_sku_id` FOREIGN KEY (`to_sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ADD CONSTRAINT `fk_product_pack_hierarchy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_product_formulation_id` FOREIGN KEY (`product_formulation_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_formulation`(`product_formulation_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ADD CONSTRAINT `fk_product_product_registration_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ADD CONSTRAINT `fk_product_vmi_sku_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ADD CONSTRAINT `fk_product_freight_contract_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_parent_material_id` FOREIGN KEY (`parent_material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ADD CONSTRAINT `fk_product_sku_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ADD CONSTRAINT `fk_product_sku_group_parent_sku_group_id` FOREIGN KEY (`parent_sku_group_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku_group`(`sku_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_product_category_id` FOREIGN KEY (`parent_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_mutated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_ssot_superseded_by' = 'manufacturing.manufacturing_bom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` SET TAGS ('dbx_ssot' = 'product.product_formulation');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` SET TAGS ('dbx_ssot' = 'product.product_formulation_ingredient');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` SET TAGS ('dbx_ssot' = 'product.product_packaging_spec');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_packaging_spec` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`plm_transition` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'structure_specification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` SET TAGS ('dbx_ssot' = 'product.product_claim');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_claim` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` SET TAGS ('dbx_ssot_reference' = 'marketing.marketing_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_ssot_superseded_by' = 'marketing.marketing_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_brand` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` SET TAGS ('dbx_subdomain' = 'assignment_rules');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_substitution` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`pack_hierarchy` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_subdomain' = 'lifecycle_compliance');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_association_edges' = 'product.sku,consumer.shopper');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` SET TAGS ('dbx_ssot' = 'product.product_registration');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_status` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_status` SET TAGS ('dbx_classification' = 'status');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_status` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_classification' = 'date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_classification' = 'date');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `quantity` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `quantity` SET TAGS ('dbx_classification' = 'measure');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `quantity` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `amount` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `amount` SET TAGS ('dbx_classification' = 'measure');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `amount` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_description` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_description` SET TAGS ('dbx_classification' = 'text');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `product_registration_description` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `created_at` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `created_at` SET TAGS ('dbx_classification' = 'audit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `created_at` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `updated_at` SET TAGS ('dbx_derived' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `updated_at` SET TAGS ('dbx_classification' = 'audit');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_registration` ALTER COLUMN `updated_at` SET TAGS ('dbx_source' = 'business_context');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_subdomain' = 'assignment_rules');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,customer.customer_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `vmi_sku_assignment_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_subdomain' = 'assignment_rules');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,logistics.carrier_contract');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `freight_contract_assignment_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`freight_contract_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'assignment_rules');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'product.sku,procurement.supplier_contract');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `supply_agreement_status` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_expanded_by' = 'VREQ-023');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku_group` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
