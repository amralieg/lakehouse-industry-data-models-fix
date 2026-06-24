-- Schema for Domain: product | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 22:46:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_retail_v1`.`product` COMMENT 'Authoritative catalog of all merchandise including SKUs, UPCs, GTINs, EANs, product hierarchies (department, category, subcategory), attributes, descriptions, images, private label vs. national brands, and assortment depth and breadth classifications. Managed via PIM (Product Information Management) and MDM systems. Supports category management, new item setup, and product lifecycle from introduction to discontinuation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key for the SKU record',
    `item_hierarchy_id` BIGINT COMMENT 'FK to item hierarchy',
    `uom_id` BIGINT COMMENT 'FK to unit of measure',
    `vendor_id` BIGINT COMMENT 'FK to primary vendor',
    `age_restriction_flag` BOOLEAN COMMENT 'Indicates if age restriction applies to this SKU',
    `country_of_origin` STRING COMMENT 'Country where the item is manufactured or sourced',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cube` DECIMAL(18,2) COMMENT 'Cubic volume of the item for storage calculations',
    `sku_description` STRING COMMENT 'Full description of the SKU',
    `dimension_unit_of_measure` STRING COMMENT 'Unit of measure for length/width/height dimensions',
    `discontinuation_date` DATE COMMENT 'Date when the SKU is discontinued',
    `ean` STRING COMMENT 'European Article Number barcode',
    `effective_date` DATE COMMENT 'Date when the SKU becomes active',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Gross weight including packaging',
    `gtin` STRING COMMENT 'Global Trade Item Number',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates if the item is classified as hazardous material',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the item',
    `hi` STRING COMMENT 'Number of layers high on a pallet',
    `image_url` STRING COMMENT 'URL to the primary product image',
    `internal_item_number` STRING COMMENT 'Internal item identifier used by the organization',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the item',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the SKU (e.g. active, discontinued, pending)',
    `minimum_age_requirement` STRING COMMENT 'Minimum age required to purchase this item',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `net_weight` DECIMAL(18,2) COMMENT 'Net weight of the item without packaging',
    `pack_size` STRING COMMENT 'Number of individual units in a pack',
    `private_label_flag` BOOLEAN COMMENT 'Indicates if this is a private label/store brand item',
    `shelf_life_days` STRING COMMENT 'Number of days the item remains sellable',
    `short_description` STRING COMMENT 'Short description for POS and labels',
    `stackable_flag` BOOLEAN COMMENT 'Indicates if the item can be stacked during storage',
    `temperature_requirement` STRING COMMENT 'Temperature storage requirement (e.g. ambient, chilled, frozen)',
    `ti` STRING COMMENT 'Number of cases per pallet layer (tie)',
    `upc` STRING COMMENT 'Universal Product Code',
    `vendor_item_number` STRING COMMENT 'Vendor-assigned item number',
    `volume` DECIMAL(18,2) COMMENT 'Volume of the item',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume',
    `weight_unit_of_measure` STRING COMMENT 'Unit of measure for weight',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the item',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock keeping unit - the most granular sellable/stockable item in the product master.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_hierarchy` (
    `item_hierarchy_id` BIGINT COMMENT 'Primary key for item hierarchy node',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center',
    `gl_account_id` BIGINT COMMENT 'FK to general ledger account',
    `parent_hierarchy_node_item_hierarchy_id` BIGINT COMMENT 'Self-referencing FK to parent hierarchy node',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `allows_direct_sku_assignment` BOOLEAN COMMENT 'Whether SKUs can be directly assigned to this node',
    `assortment_breadth_target` STRING COMMENT 'Target number of distinct SKUs in assortment',
    `assortment_depth_target` STRING COMMENT 'Target depth of inventory per SKU',
    `category_manager_name` STRING COMMENT 'Name of the category manager responsible',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score for this hierarchy node',
    `effective_end_date` DATE COMMENT 'End date of validity for this hierarchy node',
    `effective_start_date` DATE COMMENT 'Start date of validity for this hierarchy node',
    `external_reference_code` STRING COMMENT 'External system reference code',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `hierarchy_description` STRING COMMENT 'Description of the hierarchy node',
    `hierarchy_level` STRING COMMENT 'Level within the hierarchy (e.g. division, department, class, subclass)',
    `hierarchy_node_code` STRING COMMENT 'Code identifier for the hierarchy node',
    `hierarchy_node_name` STRING COMMENT 'Display name of the hierarchy node',
    `hierarchy_path` STRING COMMENT 'Full materialized path from root to this node',
    `hierarchy_type` STRING COMMENT 'Type of hierarchy (e.g. merchandise, financial, planning)',
    `is_leaf_node` BOOLEAN COMMENT 'Whether this is a leaf node with no children',
    `last_modified_by` STRING COMMENT 'User who last modified this record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `lead_time_days` STRING COMMENT 'Default lead time in days for items in this category',
    `lifecycle_status` STRING COMMENT 'Status of the hierarchy node (active, inactive, pending)',
    `markdown_cadence` STRING COMMENT 'Default markdown cadence for items in this category',
    `minimum_order_quantity` STRING COMMENT 'Default minimum order quantity for this category',
    `omnichannel_enabled` BOOLEAN COMMENT 'Whether items in this category are available across all channels',
    `planner_name` STRING COMMENT 'Name of the planner responsible for this category',
    `pricing_strategy` STRING COMMENT 'Default pricing strategy for items in this category',
    `private_label_penetration_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of private label penetration',
    `replenishment_method` STRING COMMENT 'Default replenishment method for this category',
    `safety_stock_weeks` DECIMAL(18,2) COMMENT 'Default safety stock in weeks of supply',
    `seasonality_indicator` STRING COMMENT 'Seasonality classification for this category',
    `sort_order` STRING COMMENT 'Display sort order among siblings',
    `strategic_classification` STRING COMMENT 'Strategic classification (e.g. growth, maintain, exit)',
    `target_gross_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for this category',
    CONSTRAINT pk_item_hierarchy PRIMARY KEY(`item_hierarchy_id`)
) COMMENT 'Hierarchical classification of products into departments, categories, subcategories, and classes.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`attribute` (
    `attribute_id` BIGINT COMMENT 'Primary key for the attribute record',
    `sku_id` BIGINT COMMENT 'FK to the SKU this attribute belongs to',
    `approved_by` STRING COMMENT 'User who approved this attribute value',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the attribute was approved',
    `attribute_group` STRING COMMENT 'Grouping category for the attribute',
    `attribute_status` STRING COMMENT 'Status of the attribute (active, pending, deprecated)',
    `certification_body` STRING COMMENT 'Certifying body if the attribute is certified',
    `certification_date` DATE COMMENT 'Date of certification',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor for unit transformations',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score for this attribute',
    `data_type` STRING COMMENT 'Data type of the attribute value (string, numeric, boolean, date)',
    `display_order` STRING COMMENT 'Display order for UI rendering',
    `effective_end_date` DATE COMMENT 'End date of attribute validity',
    `effective_start_date` DATE COMMENT 'Start date of attribute validity',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `is_certified` BOOLEAN COMMENT 'Whether this attribute value is certified',
    `is_comparable` BOOLEAN COMMENT 'Whether this attribute can be used for product comparison',
    `is_regulatory_required` BOOLEAN COMMENT 'Whether this attribute is required by regulation',
    `is_required` BOOLEAN COMMENT 'Whether this attribute is mandatory for the SKU',
    `is_searchable` BOOLEAN COMMENT 'Whether this attribute is indexed for search',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `locale` STRING COMMENT 'Locale for localized attribute values',
    `attribute_name` STRING COMMENT 'Name of the attribute',
    `notes` STRING COMMENT 'Free-text notes about the attribute',
    `regulatory_reference` STRING COMMENT 'Reference to regulatory requirement',
    `source_system_code` STRING COMMENT 'Code in the source system',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the attribute value',
    `validation_rule` STRING COMMENT 'Validation rule expression for the attribute value',
    `value` DECIMAL(18,2) COMMENT 'Numeric value of the attribute when applicable',
    CONSTRAINT pk_attribute PRIMARY KEY(`attribute_id`)
) COMMENT 'Extended product attributes providing flexible key-value metadata for SKUs.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`product_brand` (
    `product_brand_id` BIGINT COMMENT 'Primary key for the product brand',
    `vendor_id` BIGINT COMMENT 'FK to the primary vendor for this brand',
    `average_margin_percent` DECIMAL(18,2) COMMENT 'Average margin percentage across brand products',
    `brand_code` STRING COMMENT 'Short code identifier for the brand',
    `brand_description` STRING COMMENT 'Detailed description of the brand',
    `brand_name` STRING COMMENT 'Display name of the brand',
    `brand_status` STRING COMMENT 'Current status (active, inactive, pending)',
    `brand_tier` STRING COMMENT 'Tier classification (premium, mid-tier, value)',
    `brand_type` STRING COMMENT 'Type of brand (national, private_label, licensed)',
    `country_of_origin_code` STRING COMMENT 'Country of origin for the brand',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discontinuation_date` DATE COMMENT 'Date when the brand was discontinued',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `is_exclusive` BOOLEAN COMMENT 'Whether this brand is exclusive to the retailer',
    `is_licensed` BOOLEAN COMMENT 'Whether this is a licensed brand',
    `is_private_label` BOOLEAN COMMENT 'Whether this is a private label brand',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `launch_date` DATE COMMENT 'Date the brand was launched',
    `lead_time_days` STRING COMMENT 'Default lead time in days for brand products',
    `license_expiration_date` DATE COMMENT 'Expiration date of the brand license',
    `logo_asset_url` STRING COMMENT 'URL to the brand logo asset',
    `minimum_order_quantity` STRING COMMENT 'Default minimum order quantity for brand products',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `owner_country_code` STRING COMMENT 'Country code of the brand owner',
    `owner_name` STRING COMMENT 'Name of the brand owner',
    `portfolio_group` STRING COMMENT 'Portfolio grouping for brand management',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality rating score for the brand',
    `return_rate_percent` DECIMAL(18,2) COMMENT 'Average return rate percentage for brand products',
    `sustainability_certification` STRING COMMENT 'Sustainability certification held by the brand',
    `target_customer_segment` STRING COMMENT 'Target customer segment for the brand',
    `website_url` STRING COMMENT 'Brand website URL',
    CONSTRAINT pk_product_brand PRIMARY KEY(`product_brand_id`)
) COMMENT '[SSOT Owner] Authoritative source for product brand master data. Defines brand identity, ownership, licensing, and commercial attributes used across merchandising and supply chain.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_variant` (
    `item_variant_id` BIGINT COMMENT 'Primary key for item variant/substitution record',
    `associate_id` BIGINT COMMENT 'FK to associate who created the variant relationship',
    `sku_id` BIGINT COMMENT 'FK to the primary SKU in the variant relationship',
    `target_item_sku_id` BIGINT COMMENT 'FK to the target/substitute SKU',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the variant relationship was approved',
    `auto_substitute_flag` BOOLEAN COMMENT 'Whether automatic substitution is allowed',
    `channel_applicability` STRING COMMENT 'Channels where this variant relationship applies',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_consent_required_flag` BOOLEAN COMMENT 'Whether customer consent is needed for substitution',
    `display_sequence` STRING COMMENT 'Display sequence for variant ordering',
    `effective_end_date` DATE COMMENT 'End date of the variant relationship',
    `effective_start_date` DATE COMMENT 'Start date of the variant relationship',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `inventory_interchangeable_flag` BOOLEAN COMMENT 'Whether inventory is interchangeable between variants',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Free-text notes about the variant relationship',
    `price_differential_amount` DECIMAL(18,2) COMMENT 'Price difference between primary and target item',
    `relationship_status` STRING COMMENT 'Status of the variant relationship',
    `relationship_type` STRING COMMENT 'Type of relationship (variant, substitute, upgrade, downgrade)',
    `source_system_code` STRING COMMENT 'Source system code',
    `substitution_priority_rank` STRING COMMENT 'Priority rank for substitution selection',
    `substitution_type` STRING COMMENT 'Type of substitution (equivalent, upgrade, similar)',
    `variant_dimension_type` STRING COMMENT 'Dimension type that differentiates variants (size, color, flavor)',
    `variant_dimension_value` DECIMAL(18,2) COMMENT 'Numeric value of the variant dimension when applicable',
    `variant_ean` STRING COMMENT 'EAN of the variant item',
    `variant_group_code` STRING COMMENT 'Group code linking related variants',
    `variant_gtin` STRING COMMENT 'GTIN of the variant item',
    `variant_upc` STRING COMMENT 'UPC of the variant item',
    CONSTRAINT pk_item_variant PRIMARY KEY(`item_variant_id`)
) COMMENT 'Relationships between SKUs representing variants, substitutes, and cross-sell associations.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`image` (
    `image_id` BIGINT COMMENT 'Primary key for the image record',
    `sku_id` BIGINT COMMENT 'FK to the SKU this image belongs to',
    `associate_id` BIGINT COMMENT 'FK to the associate who uploaded the image',
    `alt_text` STRING COMMENT 'Alternative text for accessibility',
    `approval_status` STRING COMMENT 'Approval status of the image',
    `approved_by` STRING COMMENT 'User who approved the image',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the image was approved',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Aspect ratio of the image (width divided by height)',
    `background_color` STRING COMMENT 'Background color of the image',
    `caption` STRING COMMENT 'Caption text for the image',
    `cdn_asset_reference` STRING COMMENT 'CDN asset reference identifier',
    `channel_applicability` STRING COMMENT 'Channels where this image is used',
    `color_profile` STRING COMMENT 'Color profile (sRGB, Adobe RGB, CMYK)',
    `copyright_holder` STRING COMMENT 'Copyright holder of the image',
    `dpi` STRING COMMENT 'Dots per inch resolution',
    `expiration_date` DATE COMMENT 'Date when the image usage rights expire',
    `file_format` STRING COMMENT 'File format (JPEG, PNG, WEBP, TIFF)',
    `file_size_kb` DECIMAL(18,2) COMMENT 'File size in kilobytes',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `has_transparency` BOOLEAN COMMENT 'Whether the image has transparency',
    `image_type` STRING COMMENT 'Type of image (hero, lifestyle, detail, swatch)',
    `is_active` BOOLEAN COMMENT 'Whether the image is currently active',
    `is_primary` BOOLEAN COMMENT 'Whether this is the primary image for the SKU',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `license_type` STRING COMMENT 'Type of image license',
    `locale` STRING COMMENT 'Locale for localized images',
    `mobile_optimized` BOOLEAN COMMENT 'Whether the image is optimized for mobile',
    `photographer_credit` STRING COMMENT 'Photographer credit',
    `planogram_eligible` BOOLEAN COMMENT 'Whether the image can be used in planograms',
    `print_ready` BOOLEAN COMMENT 'Whether the image is print-ready quality',
    `quality_score` DECIMAL(18,2) COMMENT 'Automated quality score for the image',
    `resolution_height` STRING COMMENT 'Height in pixels',
    `resolution_width` STRING COMMENT 'Width in pixels',
    `seo_keywords` STRING COMMENT 'SEO keywords associated with the image',
    `sequence_number` STRING COMMENT 'Display sequence number',
    `upload_timestamp` TIMESTAMP COMMENT 'Timestamp when the image was uploaded',
    `url` STRING COMMENT 'URL to the image asset',
    `usage_rights_notes` STRING COMMENT 'Notes about usage rights and restrictions',
    `vendor_image_code` STRING COMMENT 'Vendor-provided image code',
    `view_angle` STRING COMMENT 'View angle of the image (front, back, side, top)',
    `zoom_enabled` BOOLEAN COMMENT 'Whether zoom functionality is enabled for this image',
    CONSTRAINT pk_image PRIMARY KEY(`image_id`)
) COMMENT 'Product image assets with metadata for digital channels, print, and planogram rendering.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` (
    `item_lifecycle_event_id` BIGINT COMMENT 'Primary key for the lifecycle event',
    `associate_id` BIGINT COMMENT 'FK to the approving associate',
    `buyer_id` BIGINT COMMENT 'FK to the buyer responsible',
    `location_id` BIGINT COMMENT 'FK to the store location affected',
    `primary_item_associate_id` BIGINT COMMENT 'FK to the primary associate for this item',
    `sku_id` BIGINT COMMENT 'FK to the SKU',
    `vendor_id` BIGINT COMMENT 'FK to the vendor',
    `actual_launch_date` DATE COMMENT 'Actual launch date of the item',
    `approval_status` STRING COMMENT 'Approval status of the lifecycle event',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of approval',
    `compliance_reference_number` STRING COMMENT 'Reference number for compliance tracking',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discontinuation_date` DATE COMMENT 'Date of discontinuation',
    `effective_date` DATE COMMENT 'Effective date of the lifecycle change',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the event occurred',
    `event_type` STRING COMMENT 'Type of lifecycle event (introduction, discontinuation, reactivation, status_change)',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `is_private_label` BOOLEAN COMMENT 'Whether the item is private label',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `new_status` STRING COMMENT 'New status after the event',
    `prior_status` STRING COMMENT 'Status before the event',
    `reason_code` STRING COMMENT 'Reason code for the lifecycle change',
    `reason_description` STRING COMMENT 'Description of the reason',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Whether the event is compliance-driven',
    `requestor_name` STRING COMMENT 'Name of the person who requested the change',
    `source_system_event_code` STRING COMMENT 'Event code in the source system',
    `supporting_notes` STRING COMMENT 'Supporting notes for the lifecycle event',
    `target_launch_date` DATE COMMENT 'Target launch date',
    `workflow_stage` STRING COMMENT 'Current workflow stage',
    CONSTRAINT pk_item_lifecycle_event PRIMARY KEY(`item_lifecycle_event_id`)
) COMMENT 'Tracks lifecycle state transitions for SKUs including introduction, activation, discontinuation, and recall events.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`product_compliance` (
    `product_compliance_id` BIGINT COMMENT 'Primary key for product compliance record',
    `associate_id` BIGINT COMMENT 'FK to compliance officer',
    `sku_id` BIGINT COMMENT 'FK to the SKU',
    `age_restriction_required` BOOLEAN COMMENT 'Whether age restriction is required for sale',
    `allergen_declaration_compliant` BOOLEAN COMMENT 'Whether allergen declaration is compliant',
    `certification_number` STRING COMMENT 'Certification number',
    `certifying_body` STRING COMMENT 'Name of the certifying body',
    `compliance_status` STRING COMMENT 'Current compliance status',
    `compliance_type` STRING COMMENT 'Type of compliance (food_safety, hazmat, environmental, labeling)',
    `country_code` STRING COMMENT 'Country code for the compliance requirement',
    `country_of_origin_compliant` BOOLEAN COMMENT 'Whether country of origin labeling is compliant',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Effective date of compliance certification',
    `expiry_date` DATE COMMENT 'Expiry date of compliance certification',
    `fda_food_facility_registration` STRING COMMENT 'FDA food facility registration number',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification code',
    `import_license_number` STRING COMMENT 'Import license number',
    `last_audit_date` DATE COMMENT 'Date of last compliance audit',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `minimum_age_years` STRING COMMENT 'Minimum age in years for purchase',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `next_audit_date` DATE COMMENT 'Date of next scheduled audit',
    `notes` STRING COMMENT 'Free-text compliance notes',
    `nutrition_labeling_compliant` BOOLEAN COMMENT 'Whether nutrition labeling is compliant',
    `organic_certification` STRING COMMENT 'Organic certification details',
    `prop_65_chemical_list` STRING COMMENT 'List of Prop 65 chemicals present',
    `prop_65_warning_required` BOOLEAN COMMENT 'Whether Prop 65 warning is required',
    `recall_date` DATE COMMENT 'Date of recall if applicable',
    `recall_reason` STRING COMMENT 'Reason for recall',
    `recall_severity_level` STRING COMMENT 'Severity level of recall',
    `recall_status` STRING COMMENT 'Status of recall',
    `region_code` STRING COMMENT 'Region code for the compliance requirement',
    `responsible_party_contact` STRING COMMENT 'Contact information for responsible party',
    `sustainability_certification` STRING COMMENT 'Sustainability certification details',
    `tariff_classification_code` STRING COMMENT 'Harmonized tariff classification code',
    `test_report_number` STRING COMMENT 'Test report reference number',
    `testing_laboratory` STRING COMMENT 'Name of the testing laboratory',
    CONSTRAINT pk_product_compliance PRIMARY KEY(`product_compliance_id`)
) COMMENT 'Regulatory compliance records for products including certifications, hazmat classifications, and safety requirements.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`recall` (
    `recall_id` BIGINT COMMENT 'Primary key for the recall record',
    `associate_id` BIGINT COMMENT 'FK to the recall coordinator',
    `cost_center_id` BIGINT COMMENT 'FK to cost center for recall expenses',
    `gl_account_id` BIGINT COMMENT 'FK to GL account for recall costs',
    `location_id` BIGINT COMMENT 'FK to affected store location',
    `sku_id` BIGINT COMMENT 'FK to the recalled SKU',
    `vendor_id` BIGINT COMMENT 'FK to the vendor of the recalled product',
    `affected_date_range_end` DATE COMMENT 'End date of affected production range',
    `affected_date_range_start` DATE COMMENT 'Start date of affected production range',
    `affected_lot_numbers` STRING COMMENT 'Lot numbers affected by the recall',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Amount charged back to vendor',
    `class` STRING COMMENT 'Classification of recall severity (Class I, II, III)',
    `completion_date` DATE COMMENT 'Date when recall was completed',
    `coordinator_email` STRING COMMENT 'Email of the recall coordinator',
    `coordinator_phone` STRING COMMENT 'Phone number of the recall coordinator',
    `corrective_action_plan` STRING COMMENT 'Description of corrective action plan',
    `country_of_origin_code` STRING COMMENT 'Country of origin of recalled product',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_notification_method` STRING COMMENT 'Method used to notify customers',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the recall',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `hazard_description` STRING COMMENT 'Description of the hazard',
    `initiation_date` DATE COMMENT 'Date the recall was initiated',
    `is_private_label` BOOLEAN COMMENT 'Whether the recalled item is private label',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `press_release_url` STRING COMMENT 'URL to the press release',
    `public_announcement_date` DATE COMMENT 'Date of public announcement',
    `reason` STRING COMMENT 'Reason for the recall',
    `recall_status` STRING COMMENT 'Current status of the recall',
    `recall_type` STRING COMMENT 'Type of recall (voluntary, mandatory, market_withdrawal)',
    `recovery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of affected units recovered',
    `reference_number` STRING COMMENT 'External reference number',
    `regulatory_body` STRING COMMENT 'Regulatory body overseeing the recall',
    `regulatory_case_number` STRING COMMENT 'Regulatory case number',
    `regulatory_notification_date` DATE COMMENT 'Date regulatory body was notified',
    `remedy_type` STRING COMMENT 'Type of remedy offered (refund, replacement, repair)',
    `root_cause_analysis` STRING COMMENT 'Root cause analysis findings',
    `scope` STRING COMMENT 'Scope of the recall (national, regional, store-level)',
    `units_affected` BIGINT COMMENT 'Total number of units affected',
    `units_in_customer_hands` BIGINT COMMENT 'Number of units already in customer possession',
    `units_recovered` BIGINT COMMENT 'Number of units recovered so far',
    CONSTRAINT pk_recall PRIMARY KEY(`recall_id`)
) COMMENT 'Product recall events tracking affected items, regulatory notifications, and recovery progress.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_bundle` (
    `item_bundle_id` BIGINT COMMENT 'Primary key for the item bundle',
    `sku_id` BIGINT COMMENT 'FK to the bundle SKU',
    `associate_id` BIGINT COMMENT 'FK to the associate who created the bundle',
    `location_id` BIGINT COMMENT 'FK to store location where bundle is available',
    `vendor_id` BIGINT COMMENT 'FK to the vendor',
    `assortment_category` STRING COMMENT 'Assortment category for the bundle',
    `bundle_description` STRING COMMENT 'Description of the bundle',
    `bundle_name` STRING COMMENT 'Name of the bundle',
    `bundle_price_amount` DECIMAL(18,2) COMMENT 'Price of the bundle',
    `bundle_status` STRING COMMENT 'Status of the bundle (active, inactive, draft)',
    `bundle_type` STRING COMMENT 'Type of bundle (fixed, configurable, mix_and_match)',
    `channel_availability` STRING COMMENT 'Channels where the bundle is available',
    `component_quantity` DECIMAL(18,2) COMMENT 'Quantity of the component in the bundle',
    `component_sequence` STRING COMMENT 'Sequence order of the component',
    `component_sku` STRING COMMENT 'SKU code of the component item',
    `component_substitution_allowed` BOOLEAN COMMENT 'Whether component substitution is allowed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code for pricing',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount on the bundle',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage on the bundle',
    `effective_end_date` DATE COMMENT 'End date of bundle availability',
    `effective_start_date` DATE COMMENT 'Start date of bundle availability',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `inventory_deduction_method` STRING COMMENT 'How inventory is deducted (component_level, bundle_level)',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `loyalty_points_eligible` BOOLEAN COMMENT 'Whether the bundle earns loyalty points',
    `maximum_purchase_quantity` STRING COMMENT 'Maximum quantity per purchase',
    `minimum_purchase_quantity` STRING COMMENT 'Minimum quantity per purchase',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `pricing_method` STRING COMMENT 'Pricing method (fixed, calculated, dynamic)',
    `promotion_eligible` BOOLEAN COMMENT 'Whether the bundle is eligible for promotions',
    `return_policy_code` STRING COMMENT 'Return policy code applicable to the bundle',
    `returnable` BOOLEAN COMMENT 'Whether the bundle is returnable',
    CONSTRAINT pk_item_bundle PRIMARY KEY(`item_bundle_id`)
) COMMENT 'Product bundles and kits composed of multiple component SKUs sold together.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`gtin_registry` (
    `gtin_registry_id` BIGINT COMMENT 'Primary key for the GTIN registry record',
    `associate_id` BIGINT COMMENT 'FK to the data steward responsible',
    `sku_id` BIGINT COMMENT 'FK to the SKU',
    `barcode_image_url` STRING COMMENT 'URL to the barcode image',
    `barcode_symbology` STRING COMMENT 'Barcode symbology type (EAN-13, UPC-A, ITF-14)',
    `check_digit` STRING COMMENT 'Check digit of the GTIN',
    `child_gtin_quantity` STRING COMMENT 'Number of child GTINs contained',
    `country_of_sale` STRING COMMENT 'Country where the GTIN is registered for sale',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discontinuation_date` DATE COMMENT 'Date when the GTIN was discontinued',
    `effective_date` DATE COMMENT 'Effective date of the GTIN registration',
    `gdsn_last_sync_timestamp` TIMESTAMP COMMENT 'Last synchronization with GDSN',
    `gdsn_publication_status` STRING COMMENT 'GDSN publication status',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `gross_weight_unit` STRING COMMENT 'Unit of measure for gross weight',
    `gross_weight_value` DECIMAL(18,2) COMMENT 'Gross weight value',
    `gs1_company_prefix` STRING COMMENT 'GS1 company prefix',
    `gtin` STRING COMMENT 'Global Trade Item Number',
    `gtin_type` STRING COMMENT 'Type of GTIN (GTIN-8, GTIN-12, GTIN-13, GTIN-14)',
    `is_base_unit` BOOLEAN COMMENT 'Whether this is the base unit GTIN',
    `is_consumer_unit` BOOLEAN COMMENT 'Whether this is a consumer-facing unit',
    `is_orderable_unit` BOOLEAN COMMENT 'Whether this unit is orderable',
    `is_variable_measure` BOOLEAN COMMENT 'Whether this is a variable measure item',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `net_content_unit` STRING COMMENT 'Unit of measure for net content',
    `net_content_value` DECIMAL(18,2) COMMENT 'Net content value',
    `package_depth_value` DECIMAL(18,2) COMMENT 'Package depth',
    `package_dimension_unit` STRING COMMENT 'Unit of measure for package dimensions',
    `package_height_value` DECIMAL(18,2) COMMENT 'Package height',
    `package_width_value` DECIMAL(18,2) COMMENT 'Package width',
    `packaging_level` STRING COMMENT 'Packaging level (each, inner_pack, case, pallet)',
    `parent_gtin` STRING COMMENT 'Parent GTIN for hierarchical packaging',
    `registration_status` STRING COMMENT 'Registration status of the GTIN',
    `regulatory_compliance_status` STRING COMMENT 'Regulatory compliance status',
    `replacement_gtin` STRING COMMENT 'Replacement GTIN if discontinued',
    CONSTRAINT pk_gtin_registry PRIMARY KEY(`gtin_registry_id`)
) COMMENT 'Global Trade Item Number registry maintaining barcode and packaging hierarchy data for all sellable units.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_nutritional` (
    `item_nutritional_id` BIGINT COMMENT 'Primary key for nutritional information',
    `sku_id` BIGINT COMMENT 'FK to the SKU',
    `associate_id` BIGINT COMMENT 'FK to the associate who validated the data',
    `added_sugars_g` DECIMAL(18,2) COMMENT 'Added sugars in grams per serving',
    `allergen_declaration` STRING COMMENT 'Full allergen declaration text',
    `calcium_mg` DECIMAL(18,2) COMMENT 'Calcium in milligrams per serving',
    `calories_from_fat` STRING COMMENT 'Calories from fat per serving',
    `calories_per_serving` STRING COMMENT 'Total calories per serving',
    `cholesterol_mg` DECIMAL(18,2) COMMENT 'Cholesterol in milligrams per serving',
    `contains_eggs` BOOLEAN COMMENT 'Whether the product contains eggs',
    `contains_fish` BOOLEAN COMMENT 'Whether the product contains fish',
    `contains_milk` BOOLEAN COMMENT 'Whether the product contains milk',
    `contains_peanuts` BOOLEAN COMMENT 'Whether the product contains peanuts',
    `contains_shellfish` BOOLEAN COMMENT 'Whether the product contains shellfish',
    `contains_soybeans` BOOLEAN COMMENT 'Whether the product contains soybeans',
    `contains_tree_nuts` BOOLEAN COMMENT 'Whether the product contains tree nuts',
    `contains_wheat` BOOLEAN COMMENT 'Whether the product contains wheat',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dietary_fiber_g` DECIMAL(18,2) COMMENT 'Dietary fiber in grams per serving',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `ingredient_statement` STRING COMMENT 'Full ingredient statement',
    `iron_mg` DECIMAL(18,2) COMMENT 'Iron in milligrams per serving',
    `is_gluten_free` BOOLEAN COMMENT 'Whether the product is gluten free',
    `is_halal_certified` BOOLEAN COMMENT 'Whether the product is halal certified',
    `is_kosher_certified` BOOLEAN COMMENT 'Whether the product is kosher certified',
    `is_non_gmo_verified` BOOLEAN COMMENT 'Whether the product is non-GMO verified',
    `is_organic_certified` BOOLEAN COMMENT 'Whether the product is organic certified',
    `is_vegan` BOOLEAN COMMENT 'Whether the product is vegan',
    `is_vegetarian` BOOLEAN COMMENT 'Whether the product is vegetarian',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `monounsaturated_fat_g` DECIMAL(18,2) COMMENT 'Monounsaturated fat in grams per serving',
    `nutritional_data_effective_date` DATE COMMENT 'Effective date of nutritional data',
    `nutritional_data_expiration_date` DATE COMMENT 'Expiration date of nutritional data validity',
    `nutritional_data_source` STRING COMMENT 'Source of nutritional data',
    `organic_certification_body` STRING COMMENT 'Organic certification body name',
    `polyunsaturated_fat_g` DECIMAL(18,2) COMMENT 'Polyunsaturated fat in grams per serving',
    `potassium_mg` DECIMAL(18,2) COMMENT 'Potassium in milligrams per serving',
    `protein_g` DECIMAL(18,2) COMMENT 'Protein in grams per serving',
    `saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fat in grams per serving',
    `serving_size_unit` STRING COMMENT 'Unit of measure for serving size',
    `serving_size_value` DECIMAL(18,2) COMMENT 'Serving size value',
    `servings_per_container` DECIMAL(18,2) COMMENT 'Number of servings per container',
    `sodium_mg` DECIMAL(18,2) COMMENT 'Sodium in milligrams per serving',
    `total_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrates in grams per serving',
    `total_fat_g` DECIMAL(18,2) COMMENT 'Total fat in grams per serving',
    `total_sugars_g` DECIMAL(18,2) COMMENT 'Total sugars in grams per serving',
    `trans_fat_g` DECIMAL(18,2) COMMENT 'Trans fat in grams per serving',
    `vitamin_d_mcg` DECIMAL(18,2) COMMENT 'Vitamin D in micrograms per serving',
    CONSTRAINT pk_item_nutritional PRIMARY KEY(`item_nutritional_id`)
) COMMENT 'Nutritional facts, allergen declarations, and dietary certifications for food and consumable products.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`item_cross_reference` (
    `item_cross_reference_id` BIGINT COMMENT 'Primary key for cross-reference record',
    `associate_id` BIGINT COMMENT 'FK to the associate who created the mapping',
    `sku_id` BIGINT COMMENT 'FK to the internal SKU',
    `superseded_by_reference_item_cross_reference_id` BIGINT COMMENT 'Self-referencing FK to superseding cross-reference',
    `vendor_id` BIGINT COMMENT 'FK to the vendor',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor between internal and external UOM',
    `created_by_user` STRING COMMENT 'User who created the record',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cross_reference_status` STRING COMMENT 'Status of the cross-reference (active, inactive, pending)',
    `cross_reference_type` STRING COMMENT 'Type of cross-reference (vendor, competitor, legacy, partner)',
    `effective_end_date` DATE COMMENT 'End date of the cross-reference validity',
    `effective_start_date` DATE COMMENT 'Start date of the cross-reference validity',
    `external_item_description` STRING COMMENT 'Description of the item in the external system',
    `external_item_number` STRING COMMENT 'Item number in the external system',
    `external_system_instance` STRING COMMENT 'Instance of the external system',
    `external_system_name` STRING COMMENT 'Name of the external system',
    `external_unit_of_measure` STRING COMMENT 'Unit of measure in the external system',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `internal_unit_of_measure` STRING COMMENT 'Internal unit of measure',
    `is_primary_reference` BOOLEAN COMMENT 'Whether this is the primary cross-reference',
    `last_modified_by_user` STRING COMMENT 'User who last modified the record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_used_date` DATE COMMENT 'Date the cross-reference was last used',
    `mapping_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score of the mapping',
    `mapping_source` STRING COMMENT 'Source of the mapping (manual, automated, vendor_provided)',
    `notes` STRING COMMENT 'Free-text notes',
    `trading_partner_name` STRING COMMENT 'Name of the trading partner',
    `upc_ean_gtin` STRING COMMENT 'UPC/EAN/GTIN associated with the cross-reference',
    `usage_count` BIGINT COMMENT 'Number of times this cross-reference has been used',
    `validation_date` DATE COMMENT 'Date the mapping was last validated',
    `validation_status` STRING COMMENT 'Validation status of the cross-reference',
    CONSTRAINT pk_item_cross_reference PRIMARY KEY(`item_cross_reference_id`)
) COMMENT 'Cross-reference mappings between internal SKU identifiers and external system item numbers.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`uom` (
    `uom_id` BIGINT COMMENT 'Primary key for unit of measure',
    `base_uom_id` BIGINT COMMENT 'FK to the base UOM for conversion',
    `class` STRING COMMENT 'Class of UOM (weight, volume, length, count)',
    `uom_code` STRING COMMENT 'Short code for the UOM',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor to base unit',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score',
    `uom_description` STRING COMMENT 'Description of the UOM',
    `effective_end_date` DATE COMMENT 'End date of UOM validity',
    `effective_start_date` DATE COMMENT 'Start date of UOM validity',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `gs1_uom_code` STRING COMMENT 'GS1 standard UOM code',
    `inverse_conversion_factor` DECIMAL(18,2) COMMENT 'Inverse conversion factor from base unit',
    `is_base_unit` BOOLEAN COMMENT 'Whether this is the base unit for its class',
    `is_consumer_unit` BOOLEAN COMMENT 'Whether this is a consumer-facing unit',
    `is_fractional_allowed` BOOLEAN COMMENT 'Whether fractional quantities are allowed',
    `is_inventory_tracked` BOOLEAN COMMENT 'Whether inventory is tracked in this UOM',
    `is_orderable` BOOLEAN COMMENT 'Whether this UOM is orderable',
    `is_variable_measure` BOOLEAN COMMENT 'Whether this is a variable measure UOM',
    `iso_uom_code` STRING COMMENT 'ISO standard UOM code',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `lifecycle_status` STRING COMMENT 'Lifecycle status (active, deprecated, retired)',
    `modified_by_user` STRING COMMENT 'User who last modified this record',
    `uom_name` STRING COMMENT 'Display name of the UOM',
    `precision_decimal_places` STRING COMMENT 'Number of decimal places for precision',
    `sort_order` STRING COMMENT 'Display sort order',
    `superseded_by_uom_code` STRING COMMENT 'UOM code that supersedes this one',
    `symbol` STRING COMMENT 'Symbol for the UOM (kg, lb, ea)',
    `unece_code` STRING COMMENT 'UN/ECE Recommendation 20 code',
    `uom_type` STRING COMMENT 'Type of UOM (selling, buying, storage)',
    `usage_context` STRING COMMENT 'Context where this UOM is used',
    CONSTRAINT pk_uom PRIMARY KEY(`uom_id`)
) COMMENT 'Unit of measure master data defining measurement units, conversions, and packaging hierarchies.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` (
    `category_campaign_plan_id` BIGINT COMMENT 'Primary key for category campaign plan',
    `associate_id` BIGINT COMMENT 'FK to the approving associate',
    `campaign_id` BIGINT COMMENT 'FK to the marketing campaign',
    `item_hierarchy_id` BIGINT COMMENT 'FK to the item hierarchy (category)',
    `actual_revenue_amount` DECIMAL(18,2) COMMENT 'Actual revenue generated',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual spend amount',
    `actual_units_sold` BIGINT COMMENT 'Actual units sold during campaign',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp of approval',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Budget allocated for this category in the campaign',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `media_weight_percent` DECIMAL(18,2) COMMENT 'Percentage of media weight allocated to this category',
    `performance_priority_rank` STRING COMMENT 'Priority rank for performance evaluation',
    `plan_status` STRING COMMENT 'Status of the plan (draft, approved, active, completed)',
    `promotional_depth_percent` DECIMAL(18,2) COMMENT 'Promotional depth percentage',
    `target_revenue_goal` DECIMAL(18,2) COMMENT 'Target revenue goal for the category',
    `target_units_goal` BIGINT COMMENT 'Target units goal',
    CONSTRAINT pk_category_campaign_plan PRIMARY KEY(`category_campaign_plan_id`)
) COMMENT 'Plans linking marketing campaigns to product categories with budget allocation and performance targets.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`assortment` (
    `assortment_id` BIGINT COMMENT 'Primary key for the assortment record',
    `fulfillment_node_id` BIGINT COMMENT 'FK to the fulfillment node',
    `sku_id` BIGINT COMMENT 'FK to the SKU',
    `allocation_priority` STRING COMMENT 'Priority for allocation',
    `assignment_effective_date` DATE COMMENT 'Effective date of the assortment assignment',
    `assignment_end_date` DATE COMMENT 'End date of the assortment assignment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_received_date` DATE COMMENT 'Date the item was last received at this node',
    `max_stock_quantity` STRING COMMENT 'Maximum stock quantity for this assortment',
    `min_stock_quantity` STRING COMMENT 'Minimum stock quantity for this assortment',
    `replenishment_lead_time_days` STRING COMMENT 'Lead time in days for replenishment',
    `stocking_status` STRING COMMENT 'Stocking status (active, discontinued, seasonal)',
    CONSTRAINT pk_assortment PRIMARY KEY(`assortment_id`)
) COMMENT 'SKU-to-fulfillment-node assignment defining which products are stocked at which locations.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`product`.`category_kpi_target` (
    `category_kpi_target_id` BIGINT COMMENT 'Primary key for category KPI target',
    `item_hierarchy_id` BIGINT COMMENT 'FK to the item hierarchy (category)',
    `kpi_definition_id` BIGINT COMMENT 'FK to the KPI definition',
    `alert_threshold` DECIMAL(18,2) COMMENT 'Threshold value that triggers an alert',
    `configuration_notes` STRING COMMENT 'Configuration notes for the KPI target',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'End date of the target validity',
    `effective_start_date` DATE COMMENT 'Start date of the target validity',
    `generic_monetary_dummy` DECIMAL(18,2) COMMENT 'Placeholder monetary attribute added by mutator to ensure change.',
    `is_active` BOOLEAN COMMENT 'Whether the target is currently active',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `measurement_frequency` STRING COMMENT 'How often the KPI is measured (daily, weekly, monthly)',
    `responsible_role` STRING COMMENT 'Role responsible for achieving the target',
    `target_value` DECIMAL(18,2) COMMENT 'Target value for the KPI',
    CONSTRAINT pk_category_kpi_target PRIMARY KEY(`category_kpi_target_id`)
) COMMENT 'KPI targets set at the product category level for performance measurement and accountability.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_retail_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_parent_hierarchy_node_item_hierarchy_id` FOREIGN KEY (`parent_hierarchy_node_item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` ADD CONSTRAINT `fk_product_attribute_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` ADD CONSTRAINT `fk_product_item_variant_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` ADD CONSTRAINT `fk_product_item_variant_target_item_sku_id` FOREIGN KEY (`target_item_sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`image` ADD CONSTRAINT `fk_product_image_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` ADD CONSTRAINT `fk_product_product_compliance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`recall` ADD CONSTRAINT `fk_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` ADD CONSTRAINT `fk_product_item_bundle_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_nutritional` ADD CONSTRAINT `fk_product_item_nutritional_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` ADD CONSTRAINT `fk_product_item_cross_reference_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` ADD CONSTRAINT `fk_product_item_cross_reference_superseded_by_reference_item_cross_reference_id` FOREIGN KEY (`superseded_by_reference_item_cross_reference_id`) REFERENCES `vibe_retail_v1`.`product`.`item_cross_reference`(`item_cross_reference_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`uom` ADD CONSTRAINT `fk_product_uom_base_uom_id` FOREIGN KEY (`base_uom_id`) REFERENCES `vibe_retail_v1`.`product`.`uom`(`uom_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` ADD CONSTRAINT `fk_product_category_campaign_plan_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` ADD CONSTRAINT `fk_product_assortment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `vibe_retail_v1`.`product`.`sku`(`sku_id`);
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` ADD CONSTRAINT `fk_product_category_kpi_target_item_hierarchy_id` FOREIGN KEY (`item_hierarchy_id`) REFERENCES `vibe_retail_v1`.`product`.`item_hierarchy`(`item_hierarchy_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_retail_v1`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`sku` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`sku` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ALTER COLUMN `category_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ALTER COLUMN `category_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ALTER COLUMN `planner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`item_hierarchy` ALTER COLUMN `planner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`attribute` ALTER COLUMN `attribute_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_ssot_role' = 'authoritative');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_ssot_owner' = 'product.product_brand');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_ssot_concept' = 'brand');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`product_brand` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_variant` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`image` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`image` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`image` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`image` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`image` ALTER COLUMN `mobile_optimized` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`image` ALTER COLUMN `mobile_optimized` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`item_lifecycle_event` ALTER COLUMN `requestor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`product_compliance` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` ALTER COLUMN `coordinator_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` ALTER COLUMN `coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` ALTER COLUMN `coordinator_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`product`.`recall` ALTER COLUMN `coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_bundle` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `vibe_retail_v1`.`product`.`gtin_registry` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`gtin_registry` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`item_nutritional` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_nutritional` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `vibe_retail_v1`.`product`.`item_nutritional` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_nutritional` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`item_cross_reference` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`uom` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`product`.`uom` SET TAGS ('dbx_subdomain' = 'item_master');
ALTER TABLE `vibe_retail_v1`.`product`.`uom` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`uom` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` SET TAGS ('dbx_association_edges' = 'product.item_hierarchy,marketing.campaign');
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`category_campaign_plan` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` SET TAGS ('dbx_association_edges' = 'product.sku,fulfillment.node');
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`assortment` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` SET TAGS ('dbx_association_edges' = 'product.item_hierarchy,analytics.kpi_definition');
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `vibe_retail_v1`.`product`.`category_kpi_target` SET TAGS ('dbx_catalog_name' = 'retail_ecm');
