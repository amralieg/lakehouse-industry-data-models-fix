-- Schema for Domain: product | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`product` COMMENT 'Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT '',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Identifier for the cost center associated with this sku record (cost center id).',
    `hierarchy_id` BIGINT COMMENT '',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: SKUs have a preferred/primary production line assignment used in Master Production Scheduling (MPS), capacity planning, and OEE reporting by SKU. This is standard ERP master data (SAP production versi',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: SKUs have a primary sourcing plant assignment in ERP (SAP MRP plant). Used in supply network planning, standard cost rollups, country-of-manufacture regulatory filings, and trade compliance. Role-pref',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: sku.packaging_material_type is a free-text STRING (e.g., HDPE, glass, aluminum) that denormalizes the primary packaging material. The material master is the authoritative source for material pro',
    `supplier_id` BIGINT COMMENT '',
    `supplier_site_id` BIGINT COMMENT '',
    `product_category_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT '',
    `sku_code` STRING COMMENT '',
    `color` STRING COMMENT 'Color of the sku color.',
    `country_of_origin` STRING COMMENT 'The country of origin of the sku.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
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
    `portfolio_classification` STRING COMMENT '',
    `product_form` STRING COMMENT '',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: hierarchy.brand_code is a STRING that references the brand associated with a hierarchy node. In CPG product hierarchies, nodes at the brand level are directly associated with brand master records. pro',
    `parent_hierarchy_id` BIGINT COMMENT '',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: hierarchy.category_code is a STRING that references the product category taxonomy. The category table is the authoritative source for product categories with its own PK (category_id) and category_code',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product hierarchy nodes (division, category, segment) map to profit centers for financial reporting alignment in consumer goods. The hierarchy entity already carries a denormalized profit_center_code ',
    `approved_date` DATE COMMENT '',
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
    `manufacturing_facility_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: product_bom.material_number is a STRING field representing the finished-good material number (SAP-style) for the product being described by the BOM. This is a direct reference to material.material_cod',
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
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: In CPG/FMCG, BOM line items represent specific materials (raw ingredients, packaging components, etc.) used in production. bom_line.component_item_number is a STRING material code that directly refere',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: BOM line items in CPG/FMCG frequently represent packaging components (bottles, caps, labels, cartons). When a bom_line represents a packaging component (bom_item_category = packaging), it should ref',
    `product_bom_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: BOM line items in consumer goods manufacturing reference the work center where a component is consumed (operation-specific component assignment in SAP PP). Used in production scheduling, cost allocati',
    `alternative_item_group` STRING COMMENT '',
    `alternative_priority` STRING COMMENT '',
    `bom_item_category` STRING COMMENT '',
    `bulk_material_flag` BOOLEAN COMMENT '',
    `change_number` STRING COMMENT '',
    `co_product_flag` BOOLEAN COMMENT '',
    `component_cost_usd` DECIMAL(18,2) COMMENT '',
    `component_description` STRING COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` (
    `packaging_spec_id` BIGINT COMMENT 'Primary key',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Packaging specs are qualified per manufacturing facility due to equipment constraints (fill speeds, tooling). New product introduction and engineering change orders require knowing which packaging spe',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: packaging_spec.material_composition is a free-text STRING describing the packaging material (e.g., HDPE, glass, FSC-certified cardboard). The material table is the authoritative material master ',
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
    CONSTRAINT pk_packaging_spec PRIMARY KEY(`packaging_spec_id`)
) COMMENT 'Product packaging specifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Primary key',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Label specs are facility-scoped in consumer goods — GMP and FDA 21 CFR Part 211 require knowing which label version is approved at each manufacturing site. Artwork management and regulatory submission',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: label_spec.substrate_material is a free-text STRING describing the physical substrate of the label (e.g., polypropylene film, paper, PET). The material master contains authoritative data on mate',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: A label specification is physically applied to a specific packaging component (e.g., a front label on a bottle, a back label on a carton). The label_spec should reference the packaging_spec it is desi',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Label specs in consumer goods are produced by designated print/label suppliers. Linking label_spec to supplier enables label supplier management, artwork approval workflows tied to supplier capabiliti',
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
    `usage_instructions` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `veeva_document_reference` STRING COMMENT '',
    `warning_statements` STRING COMMENT '',
    CONSTRAINT pk_label_spec PRIMARY KEY(`label_spec_id`)
) COMMENT 'Label specifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: brand.primary_category is a free-text STRING describing the brands primary product category (e.g., Hair Care, Skin Care, Beverages). The product_category table is the authoritative category mas',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand P&L reporting is a core consumer goods business process — each brand maps to a profit center for tracking A&P spend, revenue, and gross margin. Brand managers and finance teams run brand-level P',
    `architecture_type` STRING COMMENT '',
    `brand_status` STRING COMMENT '',
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
    `brand_name` STRING COMMENT '',
    `nps_tracking_enabled` BOOLEAN COMMENT '',
    `owner_division` STRING COMMENT '',
    `owner_entity` STRING COMMENT '',
    `parent_brand_code` STRING COMMENT '',
    `plm_stage` STRING COMMENT '',
    `positioning_statement` STRING COMMENT '',
    `primary_country_code` STRING COMMENT '',
    `regulatory_classification` STRING COMMENT '',
    `short_name` STRING COMMENT '',
    `social_media_handle` STRING COMMENT '',
    `source_system_brand_code` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `sustainability_certification` STRING COMMENT '',
    `target_consumer_segment` STRING COMMENT '',
    `tier` STRING COMMENT '',
    `trade_promotion_eligible` BOOLEAN COMMENT '',
    `trademark_jurisdiction` STRING COMMENT '',
    `trademark_registration_ref` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `website_url` STRING COMMENT '',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Product brand master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`certification` (
    `certification_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: In CPG/FMCG, certifications (e.g., Leaping Bunny, Rainforest Alliance, B-Corp) are frequently granted at the brand level rather than individual SKU level. The certification table currently only has sk',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification costs (audit fees, renewal fees, lab testing) are budgeted and tracked against cost centers in consumer goods sustainability and regulatory programs. The certification entity already tra',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Product certifications (organic, kosher, halal, RSPO) are facility-scoped — a certification is only valid when produced at a certified facility. Certification body audits and retailer compliance repor',
    `sku_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Retailer-mandated certifications (e.g., Walmart sustainability, Costco organic) are a named compliance process in consumer goods. certification already has retailer_requirement_flag; adding trade_acco',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`product_category` (
    `product_category_id` BIGINT COMMENT 'Primary key',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: The `category` table (PK: category_id, described as Product category hierarchy) is currently siloed — no existing FK points to it. In CPG/FMCG, multiple category hierarchies coexist: internal produc',
    `parent_category_product_category_id` BIGINT COMMENT '',
    `parent_product_category_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Category management in consumer goods requires category-level P&L reporting. Product categories map to profit centers for revenue and margin tracking by category. The profit_center entity already carr',
    `business_unit` STRING COMMENT '',
    `category_code` STRING COMMENT '',
    `category_description` STRING COMMENT '',
    `category_name` STRING COMMENT '',
    `category_status` STRING COMMENT '',
    `classification` STRING COMMENT '',
    `classification_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `display_order` STRING COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `hierarchy_path` STRING COMMENT '',
    `image_url` STRING COMMENT '',
    `is_leaf` BOOLEAN COMMENT '',
    `marketing_tag` STRING COMMENT '',
    `product_category_status` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    CONSTRAINT pk_product_category PRIMARY KEY(`product_category_id`)
) COMMENT 'Product categories';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`material` (
    `material_id` BIGINT COMMENT 'Primary key',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Material valuation class determines GL account for inventory valuation and COGS posting — a standard ERP/SAP pattern in consumer goods. Enables automatic account determination for raw material, packag',
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
    `material_status` STRING COMMENT '',
    `material_type` STRING COMMENT '',
    `material_name` STRING COMMENT '',
    `packaging_type` STRING COMMENT '',
    `regulatory_status` STRING COMMENT '',
    `shelf_life_days` STRING COMMENT '',
    `standard_cost` DECIMAL(18,2) COMMENT '',
    `storage_temperature_c` DECIMAL(18,2) COMMENT '',
    `unit_conversion_factor` DECIMAL(18,2) COMMENT '',
    `upc` STRING COMMENT '',
    `v2_added_flag` BOOLEAN COMMENT 'Added by v2 mutator to ensure change',
    `volume_l` DECIMAL(18,2) COMMENT '',
    `weight_kg` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Material master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for category',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Product category hierarchy';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_hierarchy_id` FOREIGN KEY (`parent_hierarchy_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`brand`(`brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`category`(`category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_category_product_category_id` FOREIGN KEY (`parent_category_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ADD CONSTRAINT `fk_product_product_category_parent_product_category_id` FOREIGN KEY (`parent_product_category_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`product_category`(`product_category_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ADD CONSTRAINT `fk_product_material_parent_material_id` FOREIGN KEY (`parent_material_id`) REFERENCES `vibe_consumer_goods_v1`.`product`.`material`(`material_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Production Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`sku` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`gtin_registry` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`hierarchy` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` SET TAGS ('dbx_subdomain' = 'material_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_ssot_superseded_by' = 'manufacturing.manufacturing_bom');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_bom` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'material_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`bom_line` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` SET TAGS ('dbx_subdomain' = 'material_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`packaging_spec` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`label_spec` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_ssot_superseded_by' = 'marketing.marketing_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`brand` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`certification` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'External Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`product_category` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` SET TAGS ('dbx_subdomain' = 'material_composition');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`material` ALTER COLUMN `v2_added_flag` SET TAGS ('dbx_generated' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'category Identifier');
