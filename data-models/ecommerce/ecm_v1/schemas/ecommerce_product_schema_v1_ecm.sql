-- Schema for Domain: product | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`product` COMMENT 'Authoritative source for the entire product catalog, SKU master data, product attributes, digital assets, taxonomy, and product lifecycle management. Manages UPC, EAN, ASIN identifiers, PDP and PLP content, product enrichment, variants, cross-sell/upsell relationships, and CPSC compliance metadata. Integrates with PIM systems for catalog governance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`catalog_item` (
    `catalog_item_id` BIGINT COMMENT 'Unique identifier for the catalog item. Primary key for the product catalog master record.',
    `brand_id` BIGINT COMMENT 'FK to product.brand',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Preferred carrier for this catalog item; required for carrier compliance checks and shipping cost estimation reports.',
    `category_id` BIGINT COMMENT 'FK to product.product_category',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: REQUIRED: Product detail pages pull rich HTML content from CMS; linking catalog items to content items drives PDP rendering.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Default Seller Assignment for catalog items, needed for pricing, fulfillment routing and sales reporting; obvious to marketplace operators.',
    `asin` STRING COMMENT '10-character alphanumeric unique identifier used for product catalog management in Amazon-style marketplaces.. Valid values are `^[A-Z0-9]{10}$`',
    `color` STRING COMMENT 'Primary color or color variant of the product, used for product differentiation, filtering, and variant management.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured or assembled, required for customs, tariffs, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `cpsc_compliance_status` STRING COMMENT 'Indicates whether the product meets CPSC safety standards and regulations, critical for product safety compliance and recall management.. Valid values are `compliant|non_compliant|exempt|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog item record was first created in the system, used for audit trail and data lineage tracking.',
    `ean` STRING COMMENT '13-digit international product identifier used globally for retail scanning and supply chain tracking.. Valid values are `^[0-9]{13}$`',
    `end_of_life_date` DATE COMMENT 'The date when the product will be or was discontinued and removed from active catalog, used for inventory planning and clearance strategies.',
    `height_cm` DECIMAL(18,2) COMMENT 'Product height dimension in centimeters, used for packaging, shipping, and warehouse storage optimization.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers for classifying traded products, used for customs clearance, tariff calculation, and international trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `is_age_restricted` BOOLEAN COMMENT 'Indicates whether the product has age restrictions for purchase (e.g., alcohol, tobacco, mature content), requiring age verification at checkout.',
    `is_hazardous_material` BOOLEAN COMMENT 'Indicates whether the product is classified as hazardous material requiring special handling, shipping restrictions, and compliance documentation per CPSC and DOT regulations.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether the product is eligible for return under the standard Return Merchandise Authorization (RMA) policy.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the product is subject to sales tax, VAT, or other consumption taxes in applicable jurisdictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog item record was last updated, used for change tracking, data freshness monitoring, and incremental ETL processing.',
    `launch_date` DATE COMMENT 'The date when the product was first made available for sale on the platform, used for new product performance tracking and lifecycle analytics.',
    `length_cm` DECIMAL(18,2) COMMENT 'Product length dimension in centimeters, used for packaging, shipping, and warehouse storage optimization.',
    `lifecycle_status` STRING COMMENT 'Current state of the product in its lifecycle. Active products are available for sale, discontinued products are phased out, draft products are under development, archived products are historical records.. Valid values are `active|inactive|discontinued|draft|archived|pending_approval`',
    `manufacturer_name` STRING COMMENT 'The legal name of the company that manufactures the product, used for supplier management and compliance tracking.',
    `manufacturer_part_number` STRING COMMENT 'The unique part number assigned by the manufacturer, used for warranty claims, technical support, and supplier coordination.',
    `material_composition` STRING COMMENT 'Description of the materials used in the product construction (e.g., 100% Cotton, Stainless Steel), used for product specifications and compliance labeling.',
    `minimum_age_requirement` STRING COMMENT 'The minimum age in years required to purchase this product, enforced during checkout for age-restricted items.',
    `model_number` STRING COMMENT 'The specific model identifier assigned by the manufacturer, used for product differentiation and technical specifications lookup.',
    `pim_source_code` STRING COMMENT 'Unique identifier of this product in the source PIM system, used for data lineage and system integration reconciliation.',
    `pim_source_system` STRING COMMENT 'Name of the Product Information Management system that is the authoritative source for this catalog item master data.',
    `product_name` STRING COMMENT 'The primary display name of the product shown on Product Detail Pages (PDP) and Product Listing Pages (PLP). Used for customer-facing search and discovery.',
    `product_subcategory` STRING COMMENT 'Granular subcategory classification within the product taxonomy, enabling precise product discovery and merchandising strategies.',
    `product_title` STRING COMMENT 'Extended product title optimized for Search Engine Optimization (SEO) and Search Engine Marketing (SEM), including key attributes and brand information.',
    `product_type` STRING COMMENT 'High-level classification of the product category (e.g., Electronics, Apparel, Home & Garden), used for catalog organization and merchandising.',
    `return_window_days` STRING COMMENT 'Number of days from delivery date within which the customer can initiate a return under the RMA policy.',
    `size` STRING COMMENT 'Size designation of the product (e.g., Small, Medium, Large, or numeric sizes), used for apparel, footwear, and size-variant products.',
    `sku` STRING COMMENT 'Unique alphanumeric identifier for the product used across inventory, order management, and fulfillment systems. The authoritative SKU master identifier.. Valid values are `^[A-Z0-9]{8,20}$`',
    `tax_code` STRING COMMENT 'Tax classification code used to determine applicable sales tax, VAT, or GST rates for the product in different jurisdictions.',
    `upc` STRING COMMENT '12-digit barcode identifier used for retail scanning and inventory tracking in North America.. Valid values are `^[0-9]{12}$`',
    `warranty_duration_months` STRING COMMENT 'Duration of the manufacturer or seller warranty in months, used for warranty claim validation and customer service.',
    `warranty_type` STRING COMMENT 'Type of warranty coverage provided with the product (manufacturer warranty, seller warranty, extended warranty, or no warranty).. Valid values are `manufacturer|seller|extended|none`',
    `weight_kg` DECIMAL(18,2) COMMENT 'Product weight in kilograms, used for shipping cost calculation, carrier selection, and warehouse capacity planning.',
    `width_cm` DECIMAL(18,2) COMMENT 'Product width dimension in centimeters, used for packaging, shipping, and warehouse storage optimization.',
    CONSTRAINT pk_catalog_item PRIMARY KEY(`catalog_item_id`)
) COMMENT 'Core master entity representing a sellable product in the e-commerce catalog. Serves as the authoritative SKU master record, capturing product identity, UPC/EAN/ASIN identifiers, brand, manufacturer, model number, product type, lifecycle status (active, discontinued, draft, archived), launch date, end-of-life date, and PIM system source reference. This is the SSOT for all product identity data across the platform.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Specific carrier service assigned to SKU for fulfillment planning and SLA performance monitoring.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the parent catalog item. Each SKU maps to exactly one catalog product.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Needed for inventory valuation accounting; each SKU posts inventory movements to its specific GL account for COGS and stock balance.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Seller SKU Ownership links each SKU to its owning seller for inventory, compliance and fulfillment decisions; standard in multi‑seller marketplaces.',
    `supplier_id` BIGINT COMMENT 'Reference to the primary supplier or vendor for this SKU.',
    `age_restriction_flag` BOOLEAN COMMENT 'Indicates whether this SKU has age verification requirements (e.g., alcohol, tobacco, adult content).',
    `asin` STRING COMMENT '10-character alphanumeric unique identifier used for product identification in Amazon-style marketplaces.. Valid values are `^[A-Z0-9]{10}$`',
    `bopis_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for buy online, pick up in store fulfillment.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where this SKU was manufactured or produced.. Valid values are `^[A-Z]{3}$`',
    `cpsc_compliant_flag` BOOLEAN COMMENT 'Indicates whether this SKU meets CPSC product safety standards and testing requirements.',
    `cpsc_tracking_label` STRING COMMENT 'CPSC-required tracking label containing manufacturer, production date, batch, and cohort information for childrens products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'Date when this SKU was discontinued and removed from active catalog. Null for active SKUs.',
    `dtc_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for direct-to-consumer shipping from distribution centers.',
    `ean` STRING COMMENT '13-digit European Article Number for international product identification and barcode scanning.. Valid values are `^[0-9]{13}$`',
    `fba_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for FBA-style fulfillment services (stored in marketplace fulfillment centers).',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this SKU is classified as hazardous material requiring special handling and shipping restrictions.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the SKU in centimeters, used for packaging and shipping optimization.',
    `launch_date` DATE COMMENT 'Date when this SKU was first made available for sale.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the SKU in centimeters, used for packaging and shipping optimization.',
    `lot_controlled_flag` BOOLEAN COMMENT 'Indicates whether this SKU is tracked by lot or batch number for quality control and traceability.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number for this SKU, used for supplier ordering and warranty claims.',
    `minimum_age_years` STRING COMMENT 'Minimum age in years required to purchase this SKU. Null if no age restriction applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was last modified.',
    `moq` STRING COMMENT 'Minimum order quantity required when purchasing this SKU from the supplier.',
    `packaging_type` STRING COMMENT 'Type of packaging required for this SKU (e.g., standard, fragile, oversized, gift wrap, bulk, refrigerated).. Valid values are `standard|fragile|oversized|gift_wrap|bulk|refrigerated`',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this SKU is perishable and requires temperature-controlled storage and expedited fulfillment.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether each unit of this SKU is tracked by unique serial number for warranty, recall, or anti-counterfeiting purposes.',
    `shelf_life_days` STRING COMMENT 'Number of days this SKU remains sellable from receipt date. Null for non-perishable items.',
    `sku_code` STRING COMMENT 'Unique alphanumeric code identifying this specific sellable variant. The atomic unit tracked by inventory and order systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU (active, inactive, discontinued, pending approval, blocked, seasonal).. Valid values are `active|inactive|discontinued|pending_approval|blocked|seasonal`',
    `unit_of_measure` STRING COMMENT 'Sellable unit of measure for this SKU (e.g., each, case, pack, box). [ENUM-REF-CANDIDATE: each|case|pack|box|pallet|dozen|pair|set — 8 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit Universal Product Code for North American retail scanning and inventory tracking.. Valid values are `^[0-9]{12}$`',
    `variant_color` STRING COMMENT 'Color dimension of the variant (e.g., Blue, Red, Black, Navy).',
    `variant_material` STRING COMMENT 'Material composition of the variant (e.g., Cotton, Polyester, Leather, Stainless Steel).',
    `variant_name` STRING COMMENT 'Human-readable name describing this specific variant (e.g., Blue Cotton T-Shirt - Size M).',
    `variant_size` STRING COMMENT 'Size dimension of the variant (e.g., S, M, L, XL, 32x34, 10.5).',
    `variant_style` STRING COMMENT 'Style or design dimension of the variant (e.g., Crew Neck, V-Neck, Slim Fit, Classic).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the SKU in kilograms, used for shipping cost calculation and carrier selection.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the SKU in centimeters, used for packaging and shipping optimization.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock Keeping Unit record representing a specific, orderable variant of a catalog item. Captures the unique SKU code, variant dimensions (size, color, material, style), sellable unit of measure, weight, dimensions (length, width, height), packaging type, hazmat flag, age restriction flag, country of origin, and fulfillment eligibility flags (FBA-eligible, BOPIS-eligible, DTC-eligible). Each SKU maps to exactly one catalog item and is the atomic unit tracked by inventory and order systems.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the product category node in the hierarchical taxonomy. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeting and expense allocation per product category uses a cost center; linking enables category‑level cost tracking in financial reports.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category node in the hierarchy. Null for root-level categories. Enables tree traversal and multi-level category structures.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory Mapping Report requires each product category to reference the primary regulation governing that category, enabling category-level compliance audits.',
    `average_margin_percent` DECIMAL(18,2) COMMENT 'Average gross margin percentage for products in this category. Used for pricing strategy, promotional planning, and financial forecasting. Business-confidential metric.',
    `category_code` STRING COMMENT 'Unique alphanumeric business identifier for the category. Used for system integration, API (Application Programming Interface) calls, and internal catalog management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `category_description` STRING COMMENT 'Detailed textual description of the category displayed on PLP (Product Listing Page) headers. Provides context and improves SEO (Search Engine Optimization) content richness.',
    `category_name` STRING COMMENT 'Human-readable name of the product category displayed on Product Listing Pages (PLP) and navigation menus. Used for customer-facing catalog browsing.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Default commission rate percentage applied to marketplace seller transactions for products in this category. Used for GMV (Gross Merchandise Value) and seller disbursement calculations.',
    `created_by_user_code` BIGINT COMMENT 'Identifier of the user or system account that created the category record. Used for audit trail and governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system. Used for audit trail and data lineage tracking.',
    `default_shipping_class` STRING COMMENT 'Default shipping class for products in this category. Used for carrier selection, rate calculation, and SLA (Service Level Agreement) determination in TMS (Transportation Management System).. Valid values are `standard|expedited|freight|oversized|cold_chain`',
    `depth_level` STRING COMMENT 'Numeric depth of the category node in the hierarchy tree. Root categories are level 0 or 1. Used for tree traversal algorithms and display logic.',
    `display_order` STRING COMMENT 'Numeric sequence controlling the sort order of categories within the same parent level. Lower values appear first in navigation menus and PLP (Product Listing Page).',
    `effective_end_date` DATE COMMENT 'Date when the category is scheduled to be deactivated or archived. Null for indefinite categories. Used for seasonal category management.',
    `effective_start_date` DATE COMMENT 'Date when the category becomes active and visible to customers. Used for scheduled category launches and merchandising campaigns.',
    `external_code` STRING COMMENT 'Identifier from the source Product Information Management (PIM) system or ERP (Enterprise Resource Planning) system. Used for data integration and reconciliation.',
    `full_path` STRING COMMENT 'Complete hierarchical path from root to current node, typically slash-delimited (e.g., Electronics/Smartphones/Android Phones). Used for breadcrumb navigation and SEO (Search Engine Optimization).',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification for products in this category. Used for shipping restrictions, carrier selection in TMS (Transportation Management System), and warehouse handling in WMS (Warehouse Management System).. Valid values are `none|flammable|corrosive|toxic|explosive|radioactive`',
    `icon_url` STRING COMMENT 'URL to the category icon or glyph stored in CDN (Content Delivery Network). Used for compact navigation menus and mobile interfaces.. Valid values are `^https?://.*.(svg|png|ico)$`',
    `image_url` STRING COMMENT 'URL to the category thumbnail or banner image stored in CDN (Content Delivery Network). Used for visual navigation tiles and PLP (Product Listing Page) headers.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the category is currently active and visible to customers. Inactive categories are hidden from navigation and search but retained for historical data.',
    `is_featured` BOOLEAN COMMENT 'Boolean flag indicating whether this category is promoted as a featured category on the homepage or main navigation. Used for merchandising campaigns.',
    `is_leaf` BOOLEAN COMMENT 'Boolean flag indicating whether this category is a terminal node (leaf) with no child categories. Leaf categories typically contain SKU (Stock Keeping Unit) assignments.',
    `is_navigable` BOOLEAN COMMENT 'Boolean flag indicating whether this category appears in customer-facing navigation menus. Hidden categories may exist for internal classification only.',
    `is_searchable` BOOLEAN COMMENT 'Boolean flag indicating whether this category is included in site search indexing and autocomplete suggestions. Used to control search faceting.',
    `meta_description` STRING COMMENT 'HTML meta description tag content for the category page. Displayed in search engine results snippets to improve CTR (Click-Through Rate).',
    `meta_keywords` STRING COMMENT 'Comma-separated list of keywords associated with the category for search engine indexing and internal search relevance tuning.',
    `meta_title` STRING COMMENT 'HTML meta title tag content for the category page. Optimized for search engine ranking and displayed in browser tabs and search results.',
    `product_count` STRING COMMENT 'Total number of active SKU (Stock Keeping Unit) products currently assigned to this category. Used for merchandising analytics and empty category detection.',
    `requires_age_verification` BOOLEAN COMMENT 'Boolean flag indicating whether products in this category require age verification at checkout (e.g., alcohol, tobacco). Used for compliance with FTC (Federal Trade Commission) and state regulations.',
    `requires_cpsc_compliance` BOOLEAN COMMENT 'Boolean flag indicating whether products in this category must comply with CPSC (Consumer Product Safety Commission) safety standards. Used for product onboarding validation.',
    `return_window_days` STRING COMMENT 'Default number of days customers have to return products in this category. Used for RMA (Return Merchandise Authorization) policy enforcement and customer service.',
    `seo_slug` STRING COMMENT 'URL-friendly lowercase hyphenated string used in category page URLs for SEO (Search Engine Optimization) and clean URL structure (e.g., electronics-smartphones).. Valid values are `^[a-z0-9-]+$`',
    `taxonomy_standard` STRING COMMENT 'Industry classification standard used for this category (e.g., GS1 Global Product Classification, UNSPSC, eCl@ss). Supports multi-taxonomy mapping for B2B (Business to Business) and marketplace integration.. Valid values are `GS1|UNSPSC|eCl@ss|internal|custom`',
    `updated_by_user_code` BIGINT COMMENT 'Identifier of the user or system account that last modified the category record. Used for audit trail and change management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was last modified. Used for change tracking, cache invalidation, and ETL (Extract Transform Load) incremental processing.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical taxonomy node defining the classification structure for the product catalog. Stores category name, category code, parent category reference (for tree traversal), depth level, full path string, display order, SEO slug, meta title, meta description, is_leaf flag, and active status. Supports multi-level category trees (e.g., Electronics > Smartphones > Android Phones) used for PLP navigation, search faceting, and catalog governance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`attribute_definition` (
    `attribute_definition_id` BIGINT COMMENT 'Unique identifier for the attribute definition within the Product Information Management (PIM) system. Primary key.',
    `allowed_values_list` STRING COMMENT 'Comma-separated or JSON list of allowed values for enum and multi-select attributes. Defines the controlled vocabulary for categorical attributes.',
    `applicable_category_scope` STRING COMMENT 'Comma-separated list of product category codes or taxonomy nodes to which this attribute applies. Defines the scope of attribute applicability across the catalog.',
    `attribute_code` STRING COMMENT 'Machine-readable unique code for the attribute, used as the technical identifier in API calls and data integrations. Typically snake_case format.. Valid values are `^[a-z0-9_]{2,64}$`',
    `attribute_group` STRING COMMENT 'High-level classification of the attribute for PIM governance (e.g., Core, Marketing, Technical, Compliance, Digital Asset). Used for attribute set management.',
    `attribute_name` STRING COMMENT 'Human-readable name of the attribute displayed in the PIM system and administrative interfaces.',
    `attribute_status` STRING COMMENT 'Current lifecycle status of the attribute definition. Active attributes are available for product enrichment; deprecated attributes are phased out; draft attributes are under review; archived attributes are retained for historical data.. Valid values are `active|deprecated|draft|archived`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this attribute is required for regulatory compliance (e.g., Consumer Product Safety Commission (CPSC) metadata, General Data Protection Regulation (GDPR) consent tracking).',
    `compliance_standard` STRING COMMENT 'Name of the regulatory standard or governing body that mandates this attribute (e.g., CPSC, GDPR, ISO 27001, PCI DSS). Null for non-compliance attributes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribute definition record was first created in the PIM system.',
    `data_type` STRING COMMENT 'The data type that defines the structure and validation rules for attribute values. Determines how the attribute is stored, validated, and rendered on Product Detail Page (PDP) and Product Listing Page (PLP). [ENUM-REF-CANDIDATE: string|numeric|boolean|enum|multi_select|date|rich_text — 7 candidates stripped; promote to reference product]',
    `default_value` DECIMAL(18,2) COMMENT 'Default value automatically populated for this attribute when a new product is created in the PIM system. Null if no default is defined.',
    `display_group` STRING COMMENT 'Logical grouping of attributes for organized presentation on PDP and PLP (e.g., Technical Specifications, Dimensions, Compliance). Used to structure attribute rendering.',
    `display_label` STRING COMMENT 'Customer-facing label for the attribute displayed on PDP and PLP. May differ from the internal attribute name for better user experience.',
    `display_order` STRING COMMENT 'Numeric sort order for attribute presentation within its display group. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date when this attribute definition is deprecated or retired. Null for currently active attributes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this attribute definition becomes active and available for use in product catalog enrichment.',
    `external_attribute_code` STRING COMMENT 'Identifier for this attribute in external systems or third-party integrations (e.g., vendor PIM, industry standard attribute codes). Used for cross-system mapping.',
    `facet_display_type` STRING COMMENT 'UI component type used to render this attribute as a filter facet on PLP (e.g., checkbox for multi-select, slider for numeric ranges, swatch for colors).. Valid values are `checkbox|radio|dropdown|slider|swatch`',
    `help_text` STRING COMMENT 'Instructional text or tooltip displayed to catalog managers during product enrichment to guide accurate data entry.',
    `is_comparable` BOOLEAN COMMENT 'Indicates whether this attribute is displayed in side-by-side product comparison views to help customers evaluate alternatives.',
    `is_filterable` BOOLEAN COMMENT 'Indicates whether this attribute can be used as a facet filter on Product Listing Page (PLP) to narrow search results.',
    `is_localizable` BOOLEAN COMMENT 'Indicates whether this attribute supports multi-language or region-specific values for international catalog management.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this attribute must be populated for a product to be considered complete and publishable. Drives catalog enrichment completeness scoring.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether this attribute is indexed by the Search and Recommendation Engine for product discovery and relevance ranking.',
    `is_system_attribute` BOOLEAN COMMENT 'Indicates whether this attribute is a core system attribute managed by the PIM platform (e.g., SKU, UPC, ASIN) versus a custom business attribute.',
    `is_unique` BOOLEAN COMMENT 'Indicates whether attribute values must be unique across all products (e.g., UPC, EAN, ASIN identifiers). Enforces uniqueness constraints during catalog enrichment.',
    `is_visible_on_pdp` BOOLEAN COMMENT 'Indicates whether this attribute is displayed on the Product Detail Page (PDP) for customer viewing.',
    `last_modified_by` STRING COMMENT 'Username or user identifier of the PIM administrator who last modified this attribute definition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribute definition record was last updated in the PIM system.',
    `notes` STRING COMMENT 'Free-text notes or comments about this attribute definition for internal PIM governance and documentation purposes.',
    `search_weight` STRING COMMENT 'Numeric weight assigned to this attribute for search relevance ranking. Higher weights increase the attributes influence on search result ordering.',
    `source_system` STRING COMMENT 'Name of the upstream system or data source from which this attribute definition originated (e.g., PIM, ERP, external vendor catalog). Used for data lineage tracking.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for numeric attributes (e.g., kg, cm, liters, watts). Null for non-numeric attributes.',
    `validation_max_value` DECIMAL(18,2) COMMENT 'Maximum allowed value for numeric attributes. Used to enforce data quality rules during catalog enrichment.',
    `validation_min_value` DECIMAL(18,2) COMMENT 'Minimum allowed value for numeric attributes. Used to enforce data quality rules during catalog enrichment.',
    `validation_regex_pattern` STRING COMMENT 'Regular expression pattern used to validate string attribute values. Enforces format rules such as SKU patterns, UPC format, or custom identifiers.',
    `version_number` STRING COMMENT 'Version number of the attribute definition, incremented with each modification. Supports change tracking and audit trail for PIM governance.',
    `created_by` STRING COMMENT 'Username or user identifier of the PIM administrator who created this attribute definition.',
    CONSTRAINT pk_attribute_definition PRIMARY KEY(`attribute_definition_id`)
) COMMENT 'Master definition of a product attribute within the PIM system, forming the schema for dynamic product data. Captures attribute name, attribute code, data type (string, numeric, boolean, enum, multi-select, date, rich_text), unit of measure, validation rules (min/max values, regex pattern, allowed values list), is_required flag, is_searchable flag, is_filterable flag, is_comparable flag, display group, display order, display label, help text, and applicable product category scope. Drives dynamic attribute rendering on PDP and PLP pages, powers faceted search configuration, and governs catalog enrichment completeness scoring.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`attribute_value` (
    `attribute_value_id` BIGINT COMMENT 'Unique identifier for the product attribute value record. Primary key.',
    `attribute_definition_id` BIGINT COMMENT 'Reference to the attribute definition that describes the type and metadata of this attribute.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Attribute-level compliance tracking links hazardous attribute values to the governing compliance obligation for safety reporting.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU or catalog item to which this attribute value is assigned.',
    `compliance_flag` STRING COMMENT 'Indicates whether this attribute value meets regulatory compliance requirements such as Consumer Product Safety Commission (CPSC) standards, GDPR data accuracy, or industry-specific regulations.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `compliance_notes` STRING COMMENT 'Additional notes or documentation related to compliance status, including references to certifications, test results, or regulatory submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this attribute value record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A numeric score (0-100) representing the completeness and accuracy of the attribute value. Used to prioritize enrichment efforts and ensure high-quality Product Detail Page (PDP) content.',
    `display_order` STRING COMMENT 'The sequence order in which this attribute value should be displayed on the Product Detail Page (PDP) relative to other attributes.',
    `effective_end_date` DATE COMMENT 'The date after which this attribute value is no longer effective. Supports time-based attribute changes such as seasonal specifications or regulatory updates.',
    `effective_start_date` DATE COMMENT 'The date from which this attribute value becomes effective and should be displayed on Product Detail Page (PDP) and used in search and filtering.',
    `enrichment_status` STRING COMMENT 'The current status of the attribute value in the enrichment workflow. Tracks whether the value has been validated, enriched, or requires further action.. Valid values are `pending|in_progress|enriched|validated|rejected|incomplete`',
    `enrichment_timestamp` TIMESTAMP COMMENT 'The date and time when the attribute value was last enriched or validated in the PIM system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this attribute value is currently active and should be used in product display, search, and analytics.',
    `is_comparable` BOOLEAN COMMENT 'Indicates whether this attribute value should be displayed in product comparison tools to help customers evaluate similar products.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether this attribute value is indexed for search and faceted navigation on Product Listing Page (PLP) and search results.',
    `is_variant_defining` BOOLEAN COMMENT 'Indicates whether this attribute value defines a product variant (e.g., size, color) that creates a distinct SKU within a product family.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this attribute value record was last updated or modified.',
    `locale_code` STRING COMMENT 'The locale or language code for localized attribute values, following ISO 639-1 language and ISO 3166-1 country format (e.g., en_US, fr_FR, de_DE). Supports multi-language Product Detail Page (PDP) and Product Listing Page (PLP) content.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `raw_value` DECIMAL(18,2) COMMENT 'The raw string representation of the attribute value as captured from the source system or enrichment process.',
    `source_system` STRING COMMENT 'The system of record from which this attribute value originated, such as PIM, ERP, or third-party data provider.',
    `typed_value_boolean` BOOLEAN COMMENT 'The attribute value when the attribute type is boolean. Used for yes/no or true/false product characteristics.',
    `typed_value_date` DATE COMMENT 'The attribute value when the attribute type is date. Used for time-based product attributes such as release date or expiration date.',
    `typed_value_numeric` DECIMAL(18,2) COMMENT 'The attribute value when the attribute type is numeric. Enables range filtering and comparison operations.',
    `typed_value_string` STRING COMMENT 'The attribute value when the attribute type is string or text. Used for faceted search and filtering.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for numeric attribute values, such as kg, cm, liters, watts, etc. Enables consistent product comparison.',
    CONSTRAINT pk_attribute_value PRIMARY KEY(`attribute_value_id`)
) COMMENT 'Stores the actual attribute values assigned to a specific SKU or catalog item as managed in the PIM system. Captures the SKU or catalog item reference, attribute definition reference, raw value (string), typed value (numeric, boolean, date as applicable), unit of measure, locale/language code for localized values, source system, enrichment status, and last enrichment timestamp. Enables faceted search, product comparison, and PDP attribute display.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`product_digital_asset` (
    `product_digital_asset_id` BIGINT COMMENT 'Unique identifier for the product digital asset record. Primary key for this entity.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: REQUIRED: Central Digital Asset Management links SKU assets to DAM for consistent image/video reuse across channels.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU this digital asset belongs to. Links asset to product master data.',
    `accessibility_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the asset meets WCAG accessibility standards (alt text, captions, transcripts). Required for regulatory compliance.',
    `asset_type` STRING COMMENT 'Classification of the digital asset media type. Determines rendering and display logic on PDP and PLP pages.. Valid values are `image|video|document|3d_model|ar_asset|360_spin`',
    `content_type` STRING COMMENT 'Specific content classification within the asset type. Distinguishes between hero images, lifestyle images, product titles, SEO metadata, and other content elements for PDP/PLP presentation. [ENUM-REF-CANDIDATE: hero_image|lifestyle_image|thumbnail|product_video|size_chart|instruction_manual|warranty_document|product_title|short_description|long_description|bullet_points|seo_meta_title|seo_meta_description|seo_canonical_url|seo_keywords|structured_data_markup — 16 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the digital asset record was first created in the system. Audit trail for content lifecycle tracking.',
    `enrichment_completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0-100) measuring content enrichment quality and completeness. Calculated based on presence of required attributes, SEO metadata, and multi-locale coverage.',
    `external_asset_code` STRING COMMENT 'Unique identifier from the source system or external DAM platform. Enables cross-system reconciliation and integration.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the digital asset is currently active and available for use. Supports soft-delete and content lifecycle management.',
    `locale_code` STRING COMMENT 'Language and region code for multi-locale content support (e.g., en_US, fr_FR, de_DE). Enables international catalog syndication.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the digital asset record was last modified. Tracks content update activity for governance and audit purposes.',
    `source_system` STRING COMMENT 'Name of the upstream system that provided the digital asset (e.g., PIM, DAM, vendor portal). Used for data lineage and integration tracking.',
    `tags_metadata` STRING COMMENT 'Comma-separated list of descriptive tags for asset categorization and search. Supports content discovery and filtering in DAM systems.',
    `usage_rights_notes` STRING COMMENT 'Free-text notes describing usage restrictions, attribution requirements, or special licensing terms. Supports legal compliance and rights management.',
    `version_number` STRING COMMENT 'Sequential version number for the digital asset. Increments with each update to support version control and rollback capabilities.',
    CONSTRAINT pk_product_digital_asset PRIMARY KEY(`product_digital_asset_id`)
) COMMENT 'Unified content and media asset entity serving as the single source of truth for ALL product presentation content on PDP and PLP pages. Manages both digital media (hero images, lifestyle images, videos, 360-degree spins, AR/3D models, size charts, PDFs) and all textual marketing content (product titles, short descriptions, long descriptions with HTML/rich text, bullet points, SEO meta titles, SEO meta descriptions, SEO canonical URLs, SEO keywords, structured data markup/JSON-LD). Captures asset type, content type, file/CDN URL, resolution, alt text, locale/language code, content status (draft, approved, published, archived), sort order, is_primary flag, rights/license metadata, content author, publishing timestamps, and enrichment completeness score. Supports multi-locale content for international catalog syndication. Governed by PIM/DAM systems for enrichment quality and brand consistency. This is the SSOT for all product content — no other entity in this domain stores product titles, descriptions, or SEO metadata.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Unique identifier for the product bundle. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the brand or manufacturer of the bundle. Used for brand-specific merchandising, reporting, and vendor management.',
    `category_id` BIGINT COMMENT 'Reference to the product taxonomy category this bundle belongs to. Used for navigation, search filtering, and merchandising.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Bundle sales are posted to a specific revenue GL account; linking ensures correct revenue recognition for bundled offerings.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller offering this bundle. Supports multi-seller marketplace models and Fulfillment By Amazon (FBA)-style operations.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the bundle was approved for publication by merchandising or compliance teams. Supports governance workflows and Sarbanes-Oxley (SOX) audit requirements.',
    `bundle_code` STRING COMMENT 'Externally-known unique business identifier for the bundle, used in catalog systems, order management, and fulfillment. Typically alphanumeric SKU-style code.. Valid values are `^[A-Z0-9]{6,20}$`',
    `bundle_description` STRING COMMENT 'Detailed marketing description of the bundle, including value proposition, contents summary, and usage scenarios. Displayed on PDP for customer decision-making.',
    `bundle_name` STRING COMMENT 'Human-readable name of the bundle displayed on Product Detail Pages (PDP) and Product Listing Pages (PLP).',
    `bundle_status` STRING COMMENT 'Current lifecycle status of the bundle in the catalog. Controls visibility and sellability across channels.. Valid values are `draft|active|inactive|discontinued|out_of_stock|pending_approval`',
    `bundle_type` STRING COMMENT 'Classification of the bundle structure: fixed bundle (pre-defined items), configurable bundle (customer selects components), gift set (curated collection), kit (assembly required), promotional bundle (limited-time offer), subscription box (recurring delivery).. Valid values are `fixed_bundle|configurable_bundle|gift_set|kit|promotional_bundle|subscription_box`',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of regulatory certifications and compliance standards the bundle meets (e.g., Consumer Product Safety Commission (CPSC), CE, RoHS, FDA). Required for cross-border trade and marketplace listing approval.',
    `component_count` STRING COMMENT 'Total number of distinct Stock Keeping Units (SKUs) included in the bundle. Used for fulfillment complexity scoring and customer messaging.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the bundle is manufactured or assembled. Required for customs, tariffs, and World Trade Organization (WTO) compliance.. Valid values are `^[A-Z]{3}$`',
    `created_by_user_code` BIGINT COMMENT 'Reference to the user or system account that created the bundle record. Supports audit trails and General Data Protection Regulation (GDPR) data lineage requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bundle record was first created in the Product Information Management (PIM) system. Used for catalog audit trails and data lineage.',
    `cross_sell_bundle_ids` STRING COMMENT 'Comma-separated list of bundle IDs recommended for cross-sell on PDP. Supports recommendation engine and Average Order Value (AOV) optimization.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bundle price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discontinued_timestamp` TIMESTAMP COMMENT 'Timestamp when the bundle was marked as discontinued. Used for product lifecycle reporting and inventory liquidation planning.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the bundle compared to sum-of-parts or list price. Used for promotional messaging and Return on Ad Spend (ROAS) calculations.',
    `effective_end_date` DATE COMMENT 'Date when the bundle is no longer available for sale. Nullable for evergreen bundles. Used for limited-time offers and seasonal discontinuation.',
    `effective_start_date` DATE COMMENT 'Date when the bundle becomes available for sale. Used for seasonal launches, promotional campaigns, and catalog planning.',
    `harmonized_tariff_code` STRING COMMENT 'International trade classification code for customs and duty calculation. Required for cross-border e-commerce and Electronic Data Interchange (EDI) with customs authorities.. Valid values are `^d{6,10}$`',
    `image_url` STRING COMMENT 'URL of the primary product image for the bundle, hosted on Content Delivery Network (CDN). Used for PDP, PLP, and digital marketing assets.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `is_configurable` BOOLEAN COMMENT 'Indicates whether customers can customize bundle components (select variants, add-ons, or substitutions) at purchase time.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether the bundle is eligible for return under the standard Return Merchandise Authorization (RMA) policy. Some bundles (e.g., personalized, perishable) may be non-returnable.',
    `is_subscription_eligible` BOOLEAN COMMENT 'Indicates whether the bundle can be purchased as a recurring subscription with automated replenishment.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the bundle is virtual (components shipped separately) or physical (pre-packaged as single unit). Impacts fulfillment strategy and Warehouse Management System (WMS) pick-pack-ship logic.',
    `list_price` DECIMAL(18,2) COMMENT 'Manufacturers suggested retail price (MSRP) or original price before discounts. Used to calculate savings and display strikethrough pricing.',
    `maximum_quantity` STRING COMMENT 'Maximum number of bundle units a customer can purchase in a single order. Used to prevent inventory depletion and manage promotional limits.',
    `minimum_quantity` STRING COMMENT 'Minimum number of bundle units a customer must purchase in a single order. Supports bulk-buy and wholesale scenarios.',
    `modified_by_user_code` BIGINT COMMENT 'Reference to the user or system account that last modified the bundle record. Supports change management and SOX compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bundle record. Supports change data capture (CDC) and incremental Extract Transform Load (ETL) processes.',
    `package_dimensions_cm` STRING COMMENT 'Physical dimensions of the bundle package in LxWxH format (centimeters). Used for warehouse slotting, cartonization, and Less Than Truck Load (LTL) / Full Truck Load (FTL) planning.. Valid values are `^d+(.d+)?xd+(.d+)?xd+(.d+)?$`',
    `price` DECIMAL(18,2) COMMENT 'Selling price of the bundle in the base currency. For sum-of-parts strategy, this may be calculated; for fixed price, this is the set amount.',
    `pricing_strategy` STRING COMMENT 'Method used to calculate bundle price: fixed price (single price regardless of components), sum-of-parts (total of individual SKU prices), discounted (percentage off sum-of-parts), tiered (price varies by quantity), dynamic (algorithmic pricing).. Valid values are `fixed_price|sum_of_parts|discounted|tiered|dynamic`',
    `return_window_days` STRING COMMENT 'Number of days from delivery date during which the bundle can be returned. Supports Customer Lifetime Value (CLTV) and Net Promoter Score (NPS) optimization.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases for Search Engine Optimization (SEO) and internal site search relevance ranking. Improves Click-Through Rate (CTR) and Conversion Rate (CVR).',
    `shipping_class` STRING COMMENT 'Shipping method classification for the bundle. Determines carrier eligibility, Service Level Agreement (SLA) targets, and last-mile delivery options.. Valid values are `standard|expedited|freight|hazmat|oversized|cold_chain`',
    `short_description` STRING COMMENT 'Concise summary of the bundle for display on PLP, search results, and mobile views. Typically 150-200 characters.',
    `tax_code` STRING COMMENT 'Tax classification code for the bundle, used to determine applicable sales tax, VAT, or GST rates. Integrates with Enterprise Resource Planning (ERP) tax engines.. Valid values are `^[A-Z0-9]{4,10}$`',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Combined shipping weight of all bundle components in kilograms. Used for carrier selection, freight cost calculation, and Transportation Management System (TMS) route optimization.',
    `upsell_bundle_ids` STRING COMMENT 'Comma-separated list of higher-value bundle IDs recommended for upsell. Supports Gross Merchandise Value (GMV) growth and Customer Acquisition Cost (CAC) recovery.',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines product bundles and kits offered as a single sellable unit composed of multiple SKUs. Captures bundle code, bundle name, bundle type (fixed bundle, configurable bundle, gift set, kit), bundle description, bundle status, pricing strategy (fixed price, sum-of-parts, discounted), bundle price, minimum quantity, maximum quantity, is_virtual flag, and effective date range. Enables cross-sell and upsell mechanics, promotional bundling, and FBA-style fulfillment of multi-item packages.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`bundle_component` (
    `bundle_component_id` BIGINT COMMENT 'Unique identifier for the bundle component association record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle component must reference its parent bundle to establish hierarchy; existing model only links component SKUs, missing bundle reference.',
    `sku_id` BIGINT COMMENT 'Reference to the individual component SKU that is part of the bundle.',
    `primary_bundle_sku_id` BIGINT COMMENT 'Reference to the parent bundle product SKU that contains this component.',
    `supplier_id` BIGINT COMMENT 'Reference to the primary supplier for this component. Used for procurement, vendor management, and supply chain traceability.',
    `assembly_instruction_text` STRING COMMENT 'Textual instructions for warehouse staff on how to assemble or package this component within the bundle. Used during pick-pack-ship operations.',
    `component_price_override` DECIMAL(18,2) COMMENT 'Optional component-level pricing override for this SKU within the bundle context. Used when the component has a different price when sold as part of the bundle versus standalone. Null if standard component pricing applies.',
    `component_quantity` DECIMAL(18,2) COMMENT 'The quantity of this component SKU required in the bundle. Supports fractional quantities for items sold by weight or volume.',
    `component_role` STRING COMMENT 'The functional role of this component within the bundle (e.g., primary product, accessory, optional add-on, complementary item, replacement part, or sample).. Valid values are `primary|accessory|optional|complementary|replacement|sample`',
    `component_status` STRING COMMENT 'Current lifecycle status of this component within the bundle. Active components are available for sale, inactive are temporarily unavailable, discontinued are permanently removed, and pending are awaiting approval.. Valid values are `active|inactive|discontinued|pending`',
    `component_volume_m3` DECIMAL(18,2) COMMENT 'The volume of this component in cubic meters. Used for calculating total bundle volume for warehouse space planning and shipping container optimization.',
    `component_weight_kg` DECIMAL(18,2) COMMENT 'The weight of this component in kilograms. Used for calculating total bundle weight for shipping cost estimation and carrier selection.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where this component was manufactured or produced. Used for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `cpsc_compliance_flag` BOOLEAN COMMENT 'Indicates whether this component meets Consumer Product Safety Commission (CPSC) safety standards and compliance requirements. True if compliant, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bundle component association record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `display_sequence` STRING COMMENT 'The order in which this component should be displayed in the bundle configurator UI, Product Detail Page (PDP), and fulfillment documentation. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'The date after which this component is no longer part of the bundle. Null for components with no planned end date. Used for time-bound bundle configurations and product lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this component becomes part of the bundle. Used for time-bound bundle configurations and seasonal product changes.',
    `hs_code` STRING COMMENT 'Harmonized System code for this component used for international trade classification, customs duties, and tariff determination.',
    `inventory_reservation_priority` STRING COMMENT 'Priority level for reserving inventory for this component during bundle order processing. Lower numbers indicate higher priority. Used by Warehouse Management System (WMS) for allocation logic.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this component is classified as hazardous material requiring special handling, packaging, and shipping compliance. True if hazardous, False otherwise.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this component is mandatory for the bundle. True if the component must be included, False if it is optional or can be removed by the customer.',
    `is_substitutable` BOOLEAN COMMENT 'Indicates whether this component can be substituted with an alternative SKU during fulfillment if out of stock. True if substitution is allowed, False otherwise.',
    `is_visible_to_customer` BOOLEAN COMMENT 'Indicates whether this component is visible to the customer on the Product Detail Page (PDP) and Product Listing Page (PLP). False for hidden components like packaging materials or promotional inserts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bundle component association record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_time_days` STRING COMMENT 'The number of days required to procure or manufacture this component from the time an order is placed. Used for inventory replenishment planning and bundle availability forecasting.',
    `minimum_order_quantity` STRING COMMENT 'The minimum quantity of this component that must be ordered from the supplier. Used for procurement planning and supplier contract compliance.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this bundle component record. Used for audit trail and data governance.',
    `substitution_group_code` STRING COMMENT 'Code identifying the substitution group for this component. Components with the same substitution group code can be interchanged during fulfillment. Null if component is not substitutable.',
    CONSTRAINT pk_bundle_component PRIMARY KEY(`bundle_component_id`)
) COMMENT 'Association entity defining the individual SKU components that make up a product bundle. Captures bundle reference, component SKU reference, component quantity, component role (primary, accessory, optional), is_substitutable flag, substitution group code, display order, and component-level pricing override. Supports bundle assembly in fulfillment, component-level inventory reservation, and bundle configurator UI logic.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`relation` (
    `relation_id` BIGINT COMMENT 'Primary key for relation',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller who submitted or owns this product relationship. Applicable for seller-submitted relations in marketplace models. Nullable for platform-curated relationships.',
    `sku_id` BIGINT COMMENT 'Identifier of the source catalog item (SKU) from which the relationship originates. This is the product displayed on the PDP or cart page that triggers the recommendation.',
    `target_sku_id` BIGINT COMMENT 'Identifier of the target catalog item (SKU) being recommended or related. This is the product suggested to the customer based on the source SKU.',
    `approval_status` STRING COMMENT 'Current approval state of the product relationship in the merchandising workflow. Applicable for seller-submitted or algorithmically-generated relations requiring manual review before activation.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Username or identifier of the merchandising team member who approved the product relationship for activation. Supports audit trail and accountability for manual curation decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the product relationship was approved by the merchandising team. Supports audit trail and Service Level Agreement (SLA) tracking for approval workflows.',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Percentage of customers who clicked on the related product recommendation when displayed, calculated as clicks divided by impressions. Used to measure recommendation effectiveness and optimize display logic.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage of customers who purchased the related product after clicking the recommendation, calculated as purchases divided by clicks. Key performance indicator (KPI) for recommendation quality and revenue impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the product relationship record was first created in the system. Supports audit trail and data lineage tracking.',
    `display_position` STRING COMMENT 'Ordinal position in which the related product should appear in the recommendation widget on the Product Detail Page (PDP) or cart page. Lower numbers indicate higher priority placement.',
    `effective_end_date` DATE COMMENT 'Date after which the product relationship is no longer active and should not be displayed. Nullable for open-ended relationships. Supports time-bound merchandising campaigns and product lifecycle management.',
    `effective_start_date` DATE COMMENT 'Date from which the product relationship becomes active and eligible for display in recommendation widgets. Supports time-bound merchandising campaigns and seasonal promotions.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the product relationship is currently active and should be displayed in recommendation widgets. True means active, False means inactive or suppressed.',
    `last_performance_update_timestamp` TIMESTAMP COMMENT 'Date and time when the performance metrics (impressions, clicks, conversions, revenue) were last refreshed from the analytics pipeline. Supports data freshness monitoring and Extract Transform Load (ETL) orchestration.',
    `merchandising_notes` STRING COMMENT 'Free-text notes from merchandising team explaining the rationale for the product relationship, special handling instructions, or campaign context. Supports manual curation workflows and knowledge transfer.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the product relationship record was last modified. Supports audit trail, change tracking, and incremental Extract Transform Load (ETL) processing.',
    `priority_rank` STRING COMMENT 'Business priority ranking assigned by merchandising team to override algorithmic display position. Lower numbers indicate higher priority. Used for strategic product placement and promotional campaigns.',
    `relation_source` STRING COMMENT 'Origin or method by which the product relationship was created. Indicates whether the relation was manually curated by merchandising team, generated algorithmically by recommendation engine, submitted by marketplace seller, or derived from specific ML techniques (collaborative filtering, content-based, hybrid).. Valid values are `manual_curation|algorithmic|seller_submitted|collaborative_filtering|content_based|hybrid`',
    `relation_type` STRING COMMENT 'Type of product-to-product relationship. Defines the nature of the recommendation: cross_sell (complementary product), upsell (higher-value alternative), frequently_bought_together (bundle suggestion), accessory (add-on item), replacement (substitute product), spare_part (component or part).. Valid values are `cross_sell|upsell|frequently_bought_together|accessory|replacement|spare_part`',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue in base currency generated from purchases of the related product that were attributed to this recommendation relationship. Used to measure Return on Ad Spend (ROAS) and recommendation engine effectiveness.',
    `strength_score` DECIMAL(18,2) COMMENT 'Numeric score representing the strength or confidence of the product relationship, typically ranging from 0.0000 to 1.0000. Higher scores indicate stronger associations and higher likelihood of conversion. Used by recommendation algorithms to rank suggestions.',
    `total_clicks` BIGINT COMMENT 'Cumulative count of times customers clicked on the related product recommendation. Used to calculate Click-Through Rate (CTR) and Conversion Rate (CVR).',
    `total_conversions` BIGINT COMMENT 'Cumulative count of times customers purchased the related product after clicking the recommendation. Used to calculate Conversion Rate (CVR) and measure revenue attribution.',
    `total_impressions` BIGINT COMMENT 'Cumulative count of times the related product recommendation was displayed to customers. Used to calculate Click-Through Rate (CTR) and assess recommendation reach.',
    CONSTRAINT pk_relation PRIMARY KEY(`relation_id`)
) COMMENT 'Defines curated product-to-product relationships between catalog items to power recommendation widgets, accessory suggestions, and replacement/spare part lookups on PDP and cart pages. Stores source catalog item reference, target catalog item reference, relation type (cross_sell, upsell, frequently_bought_together, accessory, replacement, spare_part, compatible_with), relation strength score, display position, effective date range, is_active flag, and relation source (manual_curation, algorithmic, seller_submitted). Integrates with the recommendation engine for personalized suggestions and supports merchandising team curation workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique identifier for the brand. Primary key for the brand master record.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: REQUIRED: Brand logos are stored as DAM assets; linking enables brand‑wide logo updates and compliance tracking.',
    `parent_brand_id` BIGINT COMMENT 'Foreign key reference to the parent brand if this brand is a sub-brand or brand extension. Null for top-level brands. Enables brand hierarchy modeling for conglomerates and brand families.',
    `category_id` BIGINT COMMENT 'Foreign key reference to the primary product category or taxonomy node most commonly associated with this brand. Used for brand-filtered Product Listing Pages (PLP) and merchandising.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand‑level profitability reporting requires linking each brand to a profit center to aggregate revenue and expenses per brand.',
    `approval_date` DATE COMMENT 'The date when the brand was approved for use in the catalog by the merchandising or brand governance team. Null if brand is still pending approval. Format: yyyy-MM-dd.',
    `average_rating` DECIMAL(18,2) COMMENT 'Aggregated average customer rating for all products under this brand, on a scale of 0.00 to 5.00. Calculated from product reviews. Used for brand reputation scoring and search ranking.',
    `brand_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the brand in internal systems, reporting, and integrations. Typically 2-20 uppercase characters.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `brand_description` STRING COMMENT 'Marketing description of the brand, including brand story, heritage, and value proposition. Used for brand pages and Search Engine Optimization (SEO).',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears in the catalog and on Product Detail Pages (PDP) and Product Listing Pages (PLP).',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand in the catalog. Active brands are visible in search and Product Listing Pages (PLP). Inactive and discontinued brands are hidden. Pending approval brands are under review. Suspended brands are temporarily blocked.. Valid values are `active|inactive|pending_approval|suspended|discontinued`',
    `compliance_certification` STRING COMMENT 'Comma-separated list of compliance certifications held by the brand (e.g., ISO 9001, Fair Trade, Organic, GOTS, B-Corp). Used for compliance filtering and regulatory reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the brand was founded or is headquartered. Used for country-of-origin filtering and compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the Product Information Management (PIM) system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `discontinuation_date` DATE COMMENT 'The date when the brand was discontinued and removed from active catalog merchandising. Null for active brands. Used for historical reporting and compliance. Format: yyyy-MM-dd.',
    `featured_rank` STRING COMMENT 'Merchandising rank used to determine the display order of brands on featured brand pages and promotional campaigns. Lower numbers indicate higher priority. Null if not featured.',
    `is_exclusive` BOOLEAN COMMENT 'Boolean flag indicating whether the brand is sold exclusively on this e-commerce platform. Exclusive brands are featured in marketing campaigns and receive preferential merchandising.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the brand has been verified by the platform as an authentic, authorized brand. Verified brands receive trust badges on Product Detail Pages (PDP) and higher search ranking.',
    `manufacturer_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country where products under this brand are manufactured. Used for tariff classification and World Trade Organization (WTO) compliance.. Valid values are `^[A-Z]{3}$`',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturing entity that produces products under this brand. Used for Consumer Product Safety Commission (CPSC) compliance reporting and product recall management.',
    `meta_description` STRING COMMENT 'Search Engine Optimization (SEO) meta description tag for the brand landing page. Used for search engine result snippets and Click-Through Rate (CTR) optimization.',
    `meta_title` STRING COMMENT 'Search Engine Optimization (SEO) meta title tag for the brand landing page. Used for organic search ranking and Click-Through Rate (CTR) optimization.',
    `owner_type` STRING COMMENT 'Classification of the entity that owns and controls the brand. Values: manufacturer (brand owned by product manufacturer), distributor (brand owned by distribution partner), marketplace_seller (brand owned by third-party seller), private_label (brand owned by the e-commerce platform).. Valid values are `manufacturer|distributor|marketplace_seller|private_label`',
    `registration_date` DATE COMMENT 'The date when the brand was first registered in the Product Information Management (PIM) system and made available for catalog association. Format: yyyy-MM-dd.',
    `search_keywords` STRING COMMENT 'Comma-separated list of search keywords and synonyms associated with the brand. Used by the Search and Recommendation Engine for query expansion and Search Engine Optimization (SEO).',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Numeric sustainability rating for the brand on a scale of 0.00 to 5.00, based on environmental and social governance criteria. Used for eco-conscious customer filtering and Environmental, Social, and Governance (ESG) reporting.',
    `tier` STRING COMMENT 'Market positioning tier of the brand. Used for pricing strategy, merchandising, and customer segmentation. Values: luxury (high-end designer), premium (aspirational quality), standard (mainstream), value (budget-friendly), private_label (retailer-owned).. Valid values are `luxury|premium|standard|value|private_label`',
    `total_reviews` STRING COMMENT 'Total count of customer reviews submitted for all products under this brand. Used for brand trust signals and Net Promoter Score (NPS) analysis.',
    `total_skus` STRING COMMENT 'Total count of active Stock Keeping Units (SKU) associated with this brand in the catalog. Used for brand breadth analysis and merchandising planning.',
    `trademark_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction where the trademark is registered. Format: ISO 3166-1 alpha-3.. Valid values are `^[A-Z]{3}$`',
    `trademark_number` STRING COMMENT 'Official trademark registration number issued by the national trademark office. Used for intellectual property verification and counterfeit prevention.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified the brand record. Used for audit trail and accountability in compliance with Sarbanes-Oxley Act (SOX) and General Data Protection Regulation (GDPR).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was last modified in the Product Information Management (PIM) system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `website_url` STRING COMMENT 'Official website URL of the brand. Used for external brand reference links and customer research.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for product brands represented in the catalog. Captures brand name, brand code, brand logo URL, brand description, brand website URL, brand country of origin, brand tier (luxury, premium, standard, private_label), is_verified flag, is_exclusive flag, brand owner type (manufacturer, distributor, marketplace_seller, private_label), brand status, and brand registration date. Serves as the SSOT for brand identity referenced by catalog items and used in brand-filtered search and PLP brand pages.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`compliance_certification` (
    `compliance_certification_id` BIGINT COMMENT 'Unique identifier for the compliance certification record. Primary key for the compliance certification data product.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the catalog item (SKU) that this certification applies to. Links to the product catalog master data.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Compliance certification costs are recorded against a GL account; linking allows tracking certification expenses per catalog item.',
    `age_warning_flag` BOOLEAN COMMENT 'Boolean indicator of whether the product requires an age-related warning label (e.g., not suitable for children under 3 years due to choking hazard). True if age warning is required, False otherwise.',
    `applicable_market` STRING COMMENT 'The geographic market or jurisdiction where this certification is valid and recognized. Use 3-letter ISO country codes (e.g., USA, DEU, GBR) or regional codes (e.g., EUR for European Union).',
    `batch_lot_number` STRING COMMENT 'The manufacturing batch or lot number to which this certification applies. Used when certifications are batch-specific rather than SKU-wide.',
    `certification_cost` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain this certification, including testing fees, application fees, and laboratory charges. Used for cost accounting and vendor management.',
    `certification_document_url` STRING COMMENT 'The URL or file path to the digital copy of the certification document, test report, or compliance declaration. Used for audit trails and regulatory reporting.',
    `certification_number` STRING COMMENT 'The unique certification or registration number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Valid (active and in force), Expired (past expiry date), Pending (application submitted, awaiting approval), Revoked (withdrawn by issuing body), Suspended (temporarily invalid).. Valid values are `valid|expired|pending|revoked|suspended`',
    `certification_type` STRING COMMENT 'The type of regulatory or safety certification. CPSC (Consumer Product Safety Commission), CE (Conformité Européenne), FCC (Federal Communications Commission), RoHS (Restriction of Hazardous Substances), UL (Underwriters Laboratories), FDA (Food and Drug Administration), REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals), California Prop 65 (Safe Drinking Water and Toxic Enforcement Act). [ENUM-REF-CANDIDATE: CPSC|CE|FCC|RoHS|UL|FDA|REACH|California Prop 65 — 8 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for additional compliance information, special conditions, exemptions, or notes related to the certification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance certification record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the certification cost (e.g., USD, EUR, GBP). [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CAD|AUD — 7 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications with no expiration (perpetual validity).',
    `hazard_category` STRING COMMENT 'The classification of potential hazards associated with the product (e.g., choking hazard, flammability, chemical exposure, electrical shock, sharp edges). Used for CPSC compliance and consumer safety warnings.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued by the certifying body. This is the principal business event timestamp for the certification lifecycle.',
    `issuing_body` STRING COMMENT 'The name of the regulatory authority, testing laboratory, or certification organization that issued the certification (e.g., CPSC, UL, TÜV, SGS, Intertek).',
    `listing_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether this certification makes the product eligible for marketplace listing. True if certification is sufficient for listing, False if additional certifications are required.',
    `mandatory_flag` BOOLEAN COMMENT 'Boolean indicator of whether this certification is legally mandatory for sale in the applicable market. True if mandatory, False if voluntary or optional.',
    `minimum_age_years` STRING COMMENT 'The minimum recommended or required age in years for safe use of the product. Nullable if no age restriction applies.',
    `renewal_date` DATE COMMENT 'The date by which the certification must be renewed to maintain validity. Used for proactive compliance management and renewal workflows.',
    `responsible_party_address` STRING COMMENT 'The full mailing address of the responsible party. Required for CPSC compliance and regulatory reporting.',
    `responsible_party_contact_email` STRING COMMENT 'The email address of the responsible party for certification inquiries and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_contact_phone` STRING COMMENT 'The phone number of the responsible party for certification inquiries and regulatory correspondence.',
    `responsible_party_name` STRING COMMENT 'The name of the legal entity or individual responsible for ensuring product compliance and maintaining the certification (e.g., manufacturer, importer, private labeler).',
    `revocation_date` DATE COMMENT 'The date on which the certification was revoked by the issuing body. Nullable if certification has never been revoked.',
    `revocation_reason` STRING COMMENT 'The reason provided by the issuing body for revoking the certification (e.g., product defect discovered, non-compliance with standard, fraudulent application).',
    `scope_of_certification` STRING COMMENT 'A description of what aspects of the product are covered by this certification (e.g., electrical safety only, full product compliance, packaging materials only).',
    `standard_reference` STRING COMMENT 'The specific regulatory standard or technical specification that the product was tested against (e.g., ASTM F963, EN 71, IEC 60950, 16 CFR Part 1500).',
    `test_report_number` STRING COMMENT 'The unique identifier of the laboratory test report that supports this certification. Links to the underlying test data and results.',
    `testing_laboratory` STRING COMMENT 'The name of the accredited testing laboratory that performed the compliance testing (e.g., UL, Intertek, SGS, TÜV, Bureau Veritas).',
    `updated_by` STRING COMMENT 'The username or identifier of the user or system that last modified this certification record. Used for audit trails and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance certification record was last modified. Used for audit trails and change tracking.',
    `created_by` STRING COMMENT 'The username or identifier of the user or system that created this certification record. Used for audit trails and accountability.',
    CONSTRAINT pk_compliance_certification PRIMARY KEY(`compliance_certification_id`)
) COMMENT 'Stores CPSC and regulatory compliance certifications and safety metadata for catalog items. Captures catalog item reference, certification type (CPSC, CE, FCC, RoHS, UL, FDA, REACH, California Prop 65), certification number, issuing body, issue date, expiry date, certification status (valid, expired, pending, revoked), applicable market/jurisdiction, hazard category, age warning flag (e.g., choking hazard), and document URL. Mandatory for marketplace listing eligibility and regulatory reporting to CPSC and FTC.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`product_listing` (
    `product_listing_id` BIGINT COMMENT 'Unique identifier for the product listing record. Primary key for the product listing entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: REQUIRED: Listings can be part of a marketing campaign; linking enables listing‑level spend and conversion attribution.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: REQUIRED: Marketplace listings use CMS‑managed content items for titles and descriptions, enabling version control and SEO.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Listing Compliance Audit uses this FK to verify each listing satisfies its specific regulatory obligation, supporting the Listing Compliance Dashboard.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the seller or merchant account that owns this listing. Relevant for marketplace channels where multiple sellers can list the same SKU. For first-party (1P) listings, this references the companys own seller account.',
    `sku_id` BIGINT COMMENT 'Reference to the master SKU in the product catalog that this listing represents.',
    `age_restriction` STRING COMMENT 'The minimum age required to purchase this product, if applicable. Common values: 18 (alcohol, tobacco), 21 (certain regulated products), 13 (COPPA compliance for digital products). Null indicates no age restriction.',
    `average_rating` DECIMAL(18,2) COMMENT 'The average customer rating for this listing on a scale of 0.00 to 5.00. Aggregated from customer reviews and used to calculate listing quality score, influence buy box eligibility, and impact conversion rate. Null if no reviews exist.',
    `brand_name` STRING COMMENT 'The brand name displayed for this listing on the channel. May differ from master catalog brand if channel-specific branding or private label strategies are used.',
    `buy_box_eligible_flag` BOOLEAN COMMENT 'Indicates whether this listing is eligible to compete for the buy box on marketplace channels. The buy box is the prominent Add to Cart section on a product page. Eligibility is determined by factors such as price competitiveness, fulfillment method, seller performance metrics, and inventory availability.',
    `category_path` STRING COMMENT 'The hierarchical category path where this listing is classified within the channels taxonomy. Format typically follows a breadcrumb structure (e.g., Electronics > Computers > Laptops). Used for browse navigation and category-based search filtering.',
    `channel_code` STRING COMMENT 'The sales channel where this product listing is published. Examples: WEB (website), MOBILE (mobile app), MARKETPLACE (third-party marketplace), B2B (business-to-business portal), BOPIS (Buy Online Pick Up In Store), SOCIAL (social commerce platform).. Valid values are `WEB|MOBILE|MARKETPLACE|B2B|BOPIS|SOCIAL`',
    `channel_listing_code` STRING COMMENT 'The unique identifier assigned by the sales channel for this listing. For Amazon-style marketplaces, this would be the ASIN (Amazon Standard Identification Number). For other channels, this is the channels native product identifier.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The percentage commission charged by the marketplace or channel for sales through this listing. Used to calculate Gross Merchandise Value (GMV) and net revenue. Expressed as a percentage (e.g., 15.00 for 15%).',
    `compare_at_price` DECIMAL(18,2) COMMENT 'The original or suggested retail price shown for comparison purposes to highlight discounts. Used to calculate savings percentage displayed on PDP and Product Listing Page (PLP). Null if no comparison pricing is used.',
    `condition_type` STRING COMMENT 'The physical condition of the product being sold through this listing. New: brand new in original packaging; Refurbished: restored to working condition; Used: previously owned; Open Box: new but packaging opened; Damaged: functional but with cosmetic or minor defects.. Valid values are `new|refurbished|used|open_box|damaged`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this product listing record was first created in the system. Used for audit trail, data lineage tracking, and compliance with SOX (Sarbanes-Oxley Act) and GDPR (General Data Protection Regulation) requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the listing price. Examples: USD, EUR, GBP, JPY, CAD.. Valid values are `^[A-Z]{3}$`',
    `ean_code` STRING COMMENT 'The 13-digit European Article Number barcode identifier for the product. Commonly used in international markets. Equivalent to UPC but with an additional digit for country code.. Valid values are `^[0-9]{13}$`',
    `end_date` DATE COMMENT 'The date when this listing will be or was deactivated and removed from the channel. Null indicates no planned end date. Used for seasonal products, limited-time offers, or product lifecycle management.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this listing is featured or promoted on the channels homepage, category pages, or marketing campaigns. Featured listings receive higher visibility and priority in search and recommendation algorithms.',
    `fulfillment_method` STRING COMMENT 'The fulfillment strategy for orders placed through this listing. FBM: Fulfilled By Merchant (seller ships); FBA: Fulfillment By Amazon-style (marketplace fulfillment center ships); 3PL: Third-Party Logistics provider; DROPSHIP: direct from manufacturer; BOPIS: Buy Online Pick Up In Store.. Valid values are `FBM|FBA|3PL|DROPSHIP|BOPIS`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the product is classified as hazardous material requiring special handling, labeling, and shipping restrictions. Examples include batteries, flammable liquids, aerosols, and chemicals. Compliance with Consumer Product Safety Commission (CPSC) and transportation regulations is required.',
    `inventory_quantity` STRING COMMENT 'The current available inventory quantity allocated to this listing on the channel. This may be a subset of total warehouse inventory based on channel allocation rules and safety stock policies. Used to determine Out of Stock (OOS) status and listing suppression.',
    `last_sold_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent order placed for this listing. Used to identify slow-moving inventory, calculate Daily Sales Rate (DSR), and trigger automated repricing or suppression rules.',
    `listing_status` STRING COMMENT 'Current operational status of the product listing on the channel. Active: live and purchasable; Suppressed: hidden due to quality or compliance issues; Pending: awaiting approval or activation; Inactive: manually disabled; Suspended: temporarily blocked; Archived: permanently removed.. Valid values are `active|suppressed|pending|inactive|suspended|archived`',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers unique part number for the product. Used for product identification, catalog matching, and compliance reporting. Distinct from SKU, UPC, and EAN.',
    `maximum_order_quantity` STRING COMMENT 'The maximum number of units a customer can purchase in a single order for this listing. Used to prevent overselling, manage high-demand products, or enforce promotional limits. Null indicates no maximum limit.',
    `minimum_order_quantity` STRING COMMENT 'The minimum number of units a customer must purchase in a single order for this listing. Commonly used in B2B channels or bulk purchase scenarios. Null or 1 for standard retail listings.',
    `price` DECIMAL(18,2) COMMENT 'The current selling price for this product listing on the channel, in the channels default currency. This is the price displayed to customers and may differ from the master catalog price due to channel-specific pricing strategies, promotions, or marketplace fees.',
    `promotional_badge` STRING COMMENT 'A marketing badge or label displayed on the listing to highlight special offers or features. Examples: Best Seller, Limited Time Offer, Free Shipping, New Arrival, Exclusive. Used to increase Click-Through Rate (CTR) and Conversion Rate (CVR).',
    `quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0-100) representing the overall quality of the listing based on factors such as content completeness, image quality, keyword optimization, customer reviews, conversion rate (CVR), and compliance with channel guidelines. Higher scores improve search ranking and buy box eligibility.',
    `restricted_shipping_regions` STRING COMMENT 'Comma-separated list of geographic regions (country codes, state codes, or postal code patterns) where this listing cannot be shipped due to regulatory, legal, or business restrictions. Examples: CA,NY,HI for US states, DEU,FRA for countries.',
    `review_count` STRING COMMENT 'The total number of customer reviews submitted for this listing. Higher review counts increase customer trust and improve search ranking. Used in conjunction with average rating for social proof.',
    `search_keywords` STRING COMMENT 'Channel-specific search keywords and tags used to optimize product discoverability in the channels search and recommendation engine. Supports SEO (Search Engine Optimization) and SEM (Search Engine Marketing) strategies. Comma-separated or space-separated list.',
    `shipping_dimensions` STRING COMMENT 'The package dimensions in format Length x Width x Height with unit (e.g., 30x20x10 cm). Used for shipping cost calculation, warehouse space planning, and carrier compatibility checks.',
    `shipping_weight_kg` DECIMAL(18,2) COMMENT 'The total weight of the product including packaging, measured in kilograms. Used for shipping cost calculation, carrier selection, and logistics planning by the Transportation Management System (TMS).',
    `start_date` DATE COMMENT 'The date when this listing was first activated and made available for purchase on the channel. Used for lifecycle tracking and performance analysis.',
    `suppression_reason` STRING COMMENT 'Explanation for why the listing status is suppressed. Common reasons include: missing required attributes, policy violations, quality issues, pricing errors, inventory unavailability, restricted product category, or failed compliance checks (e.g., CPSC safety standards, PCI DSS for payment-related products).',
    `total_units_sold` STRING COMMENT 'The cumulative number of units sold through this listing since activation. Used for Best Seller Rank (BSR) calculation, inventory forecasting, and performance reporting.',
    `upc_code` STRING COMMENT 'The 12-digit Universal Product Code barcode identifier for the product. Required for many retail and marketplace channels. Used for inventory tracking, point-of-sale scanning, and catalog integration.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this product listing record was last modified. Tracks changes to listing attributes such as price, status, inventory, or content. Used for change data capture (CDC), audit trail, and synchronization with downstream systems.',
    CONSTRAINT pk_product_listing PRIMARY KEY(`product_listing_id`)
) COMMENT 'Represents a marketplace or channel-specific product listing that maps a SKU to a specific sales channel (website, mobile app, marketplace, B2B portal, BOPIS). Captures SKU reference, channel code, channel-specific listing ID (e.g., ASIN for Amazon-style marketplace), listing status (active, suppressed, pending, inactive), listing title override, listing description override, listing price, buy box eligibility flag, listing quality score, suppression reason, and listing created/updated timestamps. Distinct from catalog_item as it models channel-specific presentation and eligibility.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`identifier` (
    `identifier_id` BIGINT COMMENT 'Unique identifier for the product identifier record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the catalog item or SKU (Stock Keeping Unit) that this identifier is associated with.',
    `marketplace_listing_id` BIGINT COMMENT 'The identifier of the marketplace or sales channel where this identifier is used. Relevant for marketplace sellers who may have different identifiers across multiple platforms (e.g., Amazon, eBay, Walmart Marketplace). Null for identifiers not specific to a marketplace.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Identifier Registry requires each product identifier to be tied to the applicable regulation (e.g., barcode standards) for legal labeling compliance.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the seller or vendor who provided or uses this identifier. Relevant for marketplace models where multiple sellers may have their own SKU schemes. Null for identifiers managed centrally by the platform.',
    `barcode_format` STRING COMMENT 'The physical barcode symbology or format used to encode this identifier for scanning and automated data capture. Examples include EAN-13, UPC-A, Code 128, QR Code, Data Matrix, ITF-14. NONE if no barcode representation exists. [ENUM-REF-CANDIDATE: EAN_13|UPC_A|CODE_128|QR_CODE|DATA_MATRIX|ITF_14|NONE — 7 candidates stripped; promote to reference product]',
    `check_digit` STRING COMMENT 'The check digit or validation character used to verify the integrity of the identifier value. Commonly used in UPC, EAN, and GTIN codes to detect data entry or transmission errors. Null if the identifier type does not use check digits.',
    `compliance_certification` STRING COMMENT 'Certification or compliance standard associated with this identifier. Examples include CPSC compliance for consumer products, FDA registration for food/drugs, CE marking for European products, or FCC certification for electronics. Null if not applicable.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the product associated with this identifier is manufactured or originates. Used for customs classification, trade compliance, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this product identifier record was first created in the system. Used for audit trail and data lineage tracking.',
    `customs_classification_code` STRING COMMENT 'Harmonized System (HS) code used for international trade and customs classification. This code determines tariffs, duties, and regulatory requirements for cross-border shipments. Typically 6-10 digits depending on country-specific extensions.',
    `effective_end_date` DATE COMMENT 'The date on which this identifier ceases to be active or valid. Null indicates the identifier is currently active with no planned end date. Supports temporal tracking and identifier lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this identifier becomes active and valid for use. Supports temporal tracking of identifier assignments and changes over time.',
    `external_reference_url` STRING COMMENT 'A URL link to an external registry, database, or authority where additional information about this identifier can be found. Examples include GS1 registry lookup, manufacturer product pages, or regulatory databases.',
    `gtin_type` STRING COMMENT 'The specific GTIN format used for this identifier. GTIN-8 (8 digits), GTIN-12 (UPC, 12 digits), GTIN-13 (EAN, 13 digits), GTIN-14 (case/pallet level, 14 digits). NONE if the identifier is not a GTIN.. Valid values are `GTIN_8|GTIN_12|GTIN_13|GTIN_14|NONE`',
    `identifier_status` STRING COMMENT 'Current lifecycle status of the product identifier. ACTIVE indicates the identifier is currently in use; INACTIVE indicates it is no longer used; DEPRECATED indicates it has been replaced by a newer identifier; PENDING indicates it is awaiting verification or activation; SUSPENDED indicates temporary deactivation.. Valid values are `ACTIVE|INACTIVE|DEPRECATED|PENDING|SUSPENDED`',
    `identifier_type` STRING COMMENT 'The type or classification of the product identifier. Indicates the standard or system that issued the identifier (e.g., UPC for Universal Product Code, EAN for European Article Number, ASIN for Amazon Standard Identification Number, GTIN for Global Trade Item Number, ISBN for International Standard Book Number, MPN for Manufacturer Part Number, HS_CODE for Harmonized System code for customs, SELLER_SKU for marketplace seller SKU, INTERNAL_SKU for internal SKU). [ENUM-REF-CANDIDATE: UPC|EAN|ASIN|GTIN|ISBN|MPN|HS_CODE|SELLER_SKU|INTERNAL_SKU|CUSTOM — 10 candidates stripped; promote to reference product]',
    `identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier value or code. This is the unique alphanumeric string that represents the product in the specified identifier system (e.g., the 12-digit UPC code, the 13-digit EAN, the 10-character ASIN).',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is the primary or preferred identifier for the product. True if this is the main identifier used for product lookup and display; False otherwise.',
    `is_serialized` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier includes serialization at the unit level. True if the identifier uniquely identifies an individual item instance (e.g., GTIN + serial number for track-and-trace); False if it identifies a product type or SKU only.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier has been verified for accuracy and validity. True if the identifier has been validated against the issuing authority or external registry; False if unverified or pending validation.',
    `issuing_authority` STRING COMMENT 'The organization or system that issued or assigned this identifier. Examples include GS1 for UPC/EAN/GTIN, Amazon for ASIN, manufacturer name for MPN, or internal system name for internal SKUs.',
    `lot_number` STRING COMMENT 'The lot or batch number associated with this identifier, used for grouping products manufactured or received together. Relevant for quality control, recalls, and expiration tracking. Null if not applicable.',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system process that last modified this product identifier record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this product identifier record was last modified or updated. Used for audit trail, change tracking, and data synchronization.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this product identifier. May include information about identifier assignment rationale, special handling instructions, or historical context.',
    `packaging_level` STRING COMMENT 'The level of packaging hierarchy that this identifier represents. EACH for individual consumer unit, INNER_PACK for multi-packs, CASE for shipping cases, PALLET for pallet-level, DISPLAY_UNIT for retail display units. Used for supply chain and logistics optimization.. Valid values are `EACH|INNER_PACK|CASE|PALLET|DISPLAY_UNIT`',
    `serial_number` STRING COMMENT 'The unique serial number assigned to an individual unit of the product, used in conjunction with the base identifier for item-level traceability. Null if the identifier is not serialized or if serialization is tracked separately.',
    `source_system` STRING COMMENT 'The name or code of the source system from which this identifier record originated. Examples include PIM (Product Information Management System), OMS (Order Management System), marketplace integration systems, or EDI (Electronic Data Interchange) feeds.',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when this identifier was last verified or validated against the issuing authority or external registry. Used for data quality auditing and compliance tracking.',
    `created_by` STRING COMMENT 'The username or identifier of the user or system process that created this product identifier record. Used for audit trail and accountability.',
    CONSTRAINT pk_identifier PRIMARY KEY(`identifier_id`)
) COMMENT 'Stores all external and internal product identifiers associated with a catalog item or SKU, serving as the identifier registry. Captures catalog item or SKU reference, identifier type (UPC, EAN, ASIN, GTIN, ISBN, MPN, HS_code, seller_SKU, internal_SKU), identifier value, issuing authority, is_primary flag, is_verified flag, effective start date, effective end date, and source system. Enables cross-system product matching, EDI integration, customs classification, and marketplace syndication.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` (
    `seller_sku_mapping_id` BIGINT COMMENT 'Unique identifier for the seller SKU mapping record. Primary key for the seller SKU mapping entity.',
    `agent_id` BIGINT COMMENT 'Reference to the catalog operations agent or system user who performed manual review or approval of this mapping. Null for automated mappings that did not require human intervention.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the platforms authoritative catalog item (ASIN-equivalent) that this seller SKU has been mapped to. Enables buy box competition and GMV attribution. Null when mapping status is unmapped or pending_review.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller who submitted this product listing. Links to the seller master record in the Seller Management Portal.',
    `auto_remap_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this seller SKU is eligible for automatic remapping if the canonical catalog item is merged or deprecated. False requires manual seller intervention for catalog changes.',
    `canonical_brand_name` STRING COMMENT 'The authoritative brand name from the platforms canonical catalog for the mapped item. Used to detect brand mismatches and potential intellectual property violations.',
    `canonical_category_path` STRING COMMENT 'The authoritative product category hierarchy path from the platforms canonical taxonomy that the mapped catalog item belongs to. Used for category compliance validation.',
    `compliance_check_status` STRING COMMENT 'Status of regulatory and policy compliance validation for this seller SKU mapping. Includes CPSC product safety, intellectual property, restricted product category, and marketplace policy checks.. Valid values are `passed|failed|pending|not_required`',
    `compliance_failure_reason` STRING COMMENT 'Detailed explanation of compliance check failures including specific regulations violated, policy breaches, or safety concerns. Null when compliance_check_status is passed or not_required.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this seller SKU mapping record was first created in the system. Used for audit trails and data lineage tracking.',
    `gmv_attribution_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether sales of this seller SKU are included in GMV reporting and seller commission calculations. False may indicate mapping is pending or rejected.',
    `image_match_score` DECIMAL(18,2) COMMENT 'Computer vision similarity score (0.0000 to 1.0000) comparing seller-provided product images to canonical catalog item images. Used when image_match mapping method is applied.',
    `is_buy_box_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this mapped seller SKU is eligible to compete for the buy box on the product detail page. False may indicate seller performance issues, policy violations, or pricing problems.',
    `is_duplicate_listing` BOOLEAN COMMENT 'Boolean flag indicating whether this seller SKU was identified as a duplicate of an existing seller listing for the same canonical catalog item. True indicates the seller is attempting to create multiple listings for the same product.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this seller SKU mapping record was most recently updated. Tracks any changes to mapping status, canonical item reference, or metadata.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent manual or automated review of this mapping. Used for audit trails and re-review scheduling.',
    `mapping_confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0.0000 to 1.0000) indicating the certainty of the mapping between seller SKU and canonical catalog item. Higher scores indicate stronger match signals. Used to prioritize manual review queue.',
    `mapping_method` STRING COMMENT 'The technique or algorithm used to establish the mapping between seller SKU and canonical catalog item. Exact_barcode_match is highest confidence; manual_review indicates human intervention was required.. Valid values are `exact_barcode_match|fuzzy_title_match|image_match|manual_review|seller_declaration`',
    `mapping_source_system` STRING COMMENT 'The system or integration channel through which the seller submitted this SKU for mapping (e.g., Seller Portal UI, API, EDI, Bulk Upload). Used for channel performance analysis.',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the seller SKU mapping. Mapped indicates successful linkage to canonical catalog; pending_review requires manual intervention; rejected indicates failed mapping with reason; unmapped indicates no match found.. Valid values are `mapped|pending_review|rejected|unmapped`',
    `mapping_timestamp` TIMESTAMP COMMENT 'The date and time when the seller SKU was successfully mapped to the canonical catalog item. Represents the business event time when the mapping became effective for buy box competition.',
    `priority_level` STRING COMMENT 'Processing priority assigned to this mapping request based on seller tier, product category importance, or business rules. High priority mappings are reviewed first in the manual review queue.. Valid values are `high|medium|low|standard`',
    `rejection_notes` STRING COMMENT 'Free-text explanation provided by the reviewer detailing the specific reasons for rejection and guidance for seller remediation. Null when mapping status is not rejected.',
    `rejection_reason` STRING COMMENT 'Categorical reason code explaining why a seller SKU mapping was rejected. Used for seller feedback, catalog quality governance, and compliance reporting. Null when mapping status is not rejected. [ENUM-REF-CANDIDATE: duplicate_listing|prohibited_product|insufficient_product_data|barcode_mismatch|category_violation|quality_standards_failure|intellectual_property_violation|other — 8 candidates stripped; promote to reference product]',
    `seller_brand_name` STRING COMMENT 'The brand name as declared by the seller in their listing submission. Used for brand validation and intellectual property compliance checks during mapping.',
    `seller_category_path` STRING COMMENT 'The product category hierarchy path as declared by the seller in their listing submission. Used for category validation and mismatch detection during mapping.',
    `seller_ean_code` STRING COMMENT 'The 13-digit EAN barcode provided by the seller for exact barcode matching to canonical catalog items. Used in international marketplace operations.. Valid values are `^[0-9]{13}$`',
    `seller_product_title` STRING COMMENT 'The product title or name as provided by the seller in their listing submission. Used for fuzzy matching and manual review processes.',
    `seller_sku_code` STRING COMMENT 'The sellers own SKU or product identifier code used in their internal catalog system. This is the seller-provided reference that must be mapped to the platforms canonical catalog.',
    `seller_upc_code` STRING COMMENT 'The 12-digit UPC barcode provided by the seller for exact barcode matching to canonical catalog items. Critical for automated mapping via exact_barcode_match method.. Valid values are `^[0-9]{12}$`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the seller originally submitted this SKU listing for mapping. Used to calculate mapping SLA performance and queue aging metrics.',
    `title_match_score` DECIMAL(18,2) COMMENT 'Natural language processing similarity score (0.0000 to 1.0000) comparing seller product title to canonical catalog item title. Used when fuzzy_title_match mapping method is applied.',
    CONSTRAINT pk_seller_sku_mapping PRIMARY KEY(`seller_sku_mapping_id`)
) COMMENT 'Maps marketplace seller-submitted product listings to the platforms canonical catalog items, enabling multi-seller catalog deduplication and buy box competition. Captures seller reference, seller SKU code, seller-provided product title, mapped canonical catalog item reference, mapping status (mapped, pending_review, rejected, unmapped), confidence score, mapping method (exact_barcode_match, fuzzy_title_match, image_match, manual_review), reviewer reference, rejection reason, and mapping timestamp. Critical for marketplace GMV attribution, catalog quality governance, preventing duplicate listings, and ensuring sellers compete on the same canonical product page.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` (
    `brand_seller_agreement_id` BIGINT COMMENT 'Primary key for the brand_seller_agreement association',
    `brand_id` BIGINT COMMENT 'Foreign key linking to the brand master record',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to the seller profile master record',
    `agreement_end_date` DATE COMMENT 'Date when the brand‑seller agreement expires or is terminated',
    `agreement_start_date` DATE COMMENT 'Date when the brand‑seller agreement becomes effective',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage of each sale retained by the marketplace from this brand‑seller agreement',
    `exclusive_agreement_flag` BOOLEAN COMMENT 'Indicates whether the agreement grants exclusive selling rights to the seller for the brand',
    CONSTRAINT pk_brand_seller_agreement PRIMARY KEY(`brand_seller_agreement_id`)
) COMMENT 'This association product represents the contractual agreement between a brand and a seller profile. It captures exclusivity flags, commission rates, and the start and end dates of the agreement for each brand‑seller pairing.. Existence Justification: A brand can be sold by multiple seller profiles and a seller profile can sell multiple brands. The marketplace manages a contract for each brand‑seller pairing that records exclusivity, commission rates, and agreement start/end dates. This relationship is actively created, updated, and terminated by business users.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` (
    `sku_asset_assignment_id` BIGINT COMMENT 'Primary key for the sku_asset_assignment association',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to Digital Asset',
    `sku_id` BIGINT COMMENT 'Foreign key linking to SKU',
    `brand_compliance_flag` BOOLEAN COMMENT 'Indicates if the asset complies with brand guidelines for the SKU',
    `is_primary` BOOLEAN COMMENT 'Indicates if this asset is the primary representation for the SKU',
    `license_expiration_date` DATE COMMENT 'Expiration date of the asset license',
    `license_type` STRING COMMENT 'Type of license governing asset usage',
    `rights_holder` STRING COMMENT 'Entity that holds the rights for the asset',
    `seo_score` DECIMAL(18,2) COMMENT 'SEO relevance score for the asset when used on the SKU page',
    `usage_rights_notes` STRING COMMENT 'Free‑form notes about usage rights',
    CONSTRAINT pk_sku_asset_assignment PRIMARY KEY(`sku_asset_assignment_id`)
) COMMENT 'Association product representing the assignment of digital assets to SKUs. It captures which assets are primary for a SKU, licensing information, SEO score, and compliance flags. Each record links one SKU to one digital asset with attributes that belong only to the relationship.. Existence Justification: Each SKU can be linked to multiple digital assets (images, videos, banners) and each digital asset can be used by multiple SKUs. The association is actively managed in a product‑digital‑asset table that stores attributes such as primary flag, licensing details, SEO score, and brand compliance. This operational entity is therefore a true many‑to‑many relationship.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`regulation_compliance` (
    `regulation_compliance_id` BIGINT COMMENT 'Primary key for the product_regulation_compliance association',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to catalog_item',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to regulation',
    `compliance_status` STRING COMMENT 'Current compliance state of the product for the regulation (e.g., compliant, non‑compliant, pending)',
    `evidence_url` STRING COMMENT 'Link to evidence document or audit artifact supporting the compliance status',
    CONSTRAINT pk_regulation_compliance PRIMARY KEY(`regulation_compliance_id`)
) COMMENT 'Association representing the compliance relationship between a catalog item and a regulation. Captures the compliance status and supporting evidence for each product‑regulation pair.. Existence Justification: Each catalog item may need to satisfy multiple regulations (e.g., data privacy, payment security) and each regulation applies to many catalog items. The compliance team actively creates, updates, and deletes records linking a product to a regulation, tracking compliance status and evidence for each link.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` (
    `brand_compliance_enrollment_id` BIGINT COMMENT 'Primary key for the brand_compliance_enrollment association',
    `brand_id` BIGINT COMMENT 'Foreign key linking to the brand',
    `program_id` BIGINT COMMENT 'Foreign key linking to the compliance program',
    `enrollment_date` DATE COMMENT 'Date the brand was enrolled in the compliance program',
    `program_status` STRING COMMENT 'Current status of the brand within the compliance program (e.g., active, pending, completed)',
    CONSTRAINT pk_brand_compliance_enrollment PRIMARY KEY(`brand_compliance_enrollment_id`)
) COMMENT 'Represents the enrollment of a brand in a compliance program, capturing when the brand joined the program and its current status. Each record links one brand to one compliance program and stores attributes that belong only to this relationship.. Existence Justification: Brands are actively enrolled in compliance programs, and each program includes many brands. The enrollment is managed as a distinct business process with enrollment dates and status tracked for each brand‑program link. This many‑to‑many relationship is a core operational entity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ADD CONSTRAINT `fk_product_attribute_value_attribute_definition_id` FOREIGN KEY (`attribute_definition_id`) REFERENCES `ecommerce_ecm`.`product`.`attribute_definition`(`attribute_definition_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ADD CONSTRAINT `fk_product_attribute_value_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ADD CONSTRAINT `fk_product_product_digital_asset_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `ecommerce_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_primary_bundle_sku_id` FOREIGN KEY (`primary_bundle_sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ADD CONSTRAINT `fk_product_relation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ADD CONSTRAINT `fk_product_relation_target_sku_id` FOREIGN KEY (`target_sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_category_id` FOREIGN KEY (`category_id`) REFERENCES `ecommerce_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ADD CONSTRAINT `fk_product_compliance_certification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ADD CONSTRAINT `fk_product_product_listing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ADD CONSTRAINT `fk_product_identifier_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ADD CONSTRAINT `fk_product_seller_sku_mapping_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ADD CONSTRAINT `fk_product_brand_seller_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ADD CONSTRAINT `fk_product_sku_asset_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `ecommerce_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ADD CONSTRAINT `fk_product_regulation_compliance_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `ecommerce_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ADD CONSTRAINT `fk_product_brand_compliance_enrollment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `ecommerce_ecm`.`product`.`brand`(`brand_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item ID');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `category_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `asin` SET TAGS ('dbx_business_glossary_term' = 'Amazon Standard Identification Number (ASIN)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `asin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `cpsc_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Compliance Status');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `cpsc_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending_review');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life Date');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `is_hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|draft|archived|pending_approval');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `pim_source_code` SET TAGS ('dbx_business_glossary_term' = 'Product Information Management (PIM) Source ID');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `pim_source_system` SET TAGS ('dbx_business_glossary_term' = 'Product Information Management (PIM) Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `product_title` SET TAGS ('dbx_business_glossary_term' = 'Product Title');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `warranty_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration Months');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'manufacturer|seller|extended|none');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms');
ALTER TABLE `ecommerce_ecm`.`product`.`catalog_item` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `age_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `asin` SET TAGS ('dbx_business_glossary_term' = 'Amazon Standard Identification Number (ASIN)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `asin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `bopis_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `cpsc_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `cpsc_tracking_label` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Tracking Label');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `dtc_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct to Consumer (DTC) Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `fba_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment By Amazon (FBA) Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (cm)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (cm)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `lot_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Controlled Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `minimum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'standard|fragile|oversized|gift_wrap|bulk|refrigerated');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Status');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|blocked|seasonal');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `variant_color` SET TAGS ('dbx_business_glossary_term' = 'Variant Color');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `variant_material` SET TAGS ('dbx_business_glossary_term' = 'Variant Material');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `variant_name` SET TAGS ('dbx_business_glossary_term' = 'Variant Name');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `variant_size` SET TAGS ('dbx_business_glossary_term' = 'Variant Size');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `variant_style` SET TAGS ('dbx_business_glossary_term' = 'Variant Style');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `ecommerce_ecm`.`product`.`sku` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (cm)');
ALTER TABLE `ecommerce_ecm`.`product`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`product`.`category` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Category Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `average_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Margin Percentage');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `average_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `default_shipping_class` SET TAGS ('dbx_business_glossary_term' = 'Default Shipping Class');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `default_shipping_class` SET TAGS ('dbx_value_regex' = 'standard|expedited|freight|oversized|cold_chain');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `depth_level` SET TAGS ('dbx_business_glossary_term' = 'Category Depth Level');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order Sequence');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External System ID');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `full_path` SET TAGS ('dbx_business_glossary_term' = 'Category Full Path');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Classification');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_value_regex' = 'none|flammable|corrosive|toxic|explosive|radioactive');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `icon_url` SET TAGS ('dbx_business_glossary_term' = 'Category Icon URL');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `icon_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(svg|png|ico)$');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Category Image URL');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Status Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Category Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `is_leaf` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Category Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `is_navigable` SET TAGS ('dbx_business_glossary_term' = 'Is Navigable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `meta_description` SET TAGS ('dbx_business_glossary_term' = 'SEO (Search Engine Optimization) Meta Description');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `meta_keywords` SET TAGS ('dbx_business_glossary_term' = 'SEO (Search Engine Optimization) Meta Keywords');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `meta_title` SET TAGS ('dbx_business_glossary_term' = 'SEO (Search Engine Optimization) Meta Title');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `product_count` SET TAGS ('dbx_business_glossary_term' = 'Product Count');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `requires_age_verification` SET TAGS ('dbx_business_glossary_term' = 'Requires Age Verification Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `requires_cpsc_compliance` SET TAGS ('dbx_business_glossary_term' = 'Requires CPSC (Consumer Product Safety Commission) Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `seo_slug` SET TAGS ('dbx_business_glossary_term' = 'SEO (Search Engine Optimization) URL Slug');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `seo_slug` SET TAGS ('dbx_value_regex' = '^[a-z0-9-]+$');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `taxonomy_standard` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Standard');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `taxonomy_standard` SET TAGS ('dbx_value_regex' = 'GS1|UNSPSC|eCl@ss|internal|custom');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Attribute Definition ID');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `allowed_values_list` SET TAGS ('dbx_business_glossary_term' = 'Allowed Values List');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `applicable_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Category Scope');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_code` SET TAGS ('dbx_business_glossary_term' = 'Attribute Code');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_code` SET TAGS ('dbx_value_regex' = '^[a-z0-9_]{2,64}$');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_group` SET TAGS ('dbx_business_glossary_term' = 'Attribute Group');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_name` SET TAGS ('dbx_business_glossary_term' = 'Attribute Name');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_status` SET TAGS ('dbx_business_glossary_term' = 'Attribute Status');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `attribute_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|archived');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `default_value` SET TAGS ('dbx_business_glossary_term' = 'Default Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `display_group` SET TAGS ('dbx_business_glossary_term' = 'Display Group');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `display_label` SET TAGS ('dbx_business_glossary_term' = 'Display Label');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `external_attribute_code` SET TAGS ('dbx_business_glossary_term' = 'External Attribute ID');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `facet_display_type` SET TAGS ('dbx_business_glossary_term' = 'Facet Display Type');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `facet_display_type` SET TAGS ('dbx_value_regex' = 'checkbox|radio|dropdown|slider|swatch');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `help_text` SET TAGS ('dbx_business_glossary_term' = 'Help Text');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_comparable` SET TAGS ('dbx_business_glossary_term' = 'Is Comparable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_filterable` SET TAGS ('dbx_business_glossary_term' = 'Is Filterable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_localizable` SET TAGS ('dbx_business_glossary_term' = 'Is Localizable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_system_attribute` SET TAGS ('dbx_business_glossary_term' = 'Is System Attribute Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_unique` SET TAGS ('dbx_business_glossary_term' = 'Is Unique Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `is_visible_on_pdp` SET TAGS ('dbx_business_glossary_term' = 'Is Visible on Product Detail Page (PDP) Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `search_weight` SET TAGS ('dbx_business_glossary_term' = 'Search Weight');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `validation_max_value` SET TAGS ('dbx_business_glossary_term' = 'Validation Maximum Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `validation_min_value` SET TAGS ('dbx_business_glossary_term' = 'Validation Minimum Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `validation_regex_pattern` SET TAGS ('dbx_business_glossary_term' = 'Validation Regular Expression (Regex) Pattern');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `attribute_value_id` SET TAGS ('dbx_business_glossary_term' = 'Product Attribute Value ID');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `attribute_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Attribute Definition ID');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `enrichment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Status');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `enrichment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|enriched|validated|rejected|incomplete');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `enrichment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `is_comparable` SET TAGS ('dbx_business_glossary_term' = 'Is Comparable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `is_variant_defining` SET TAGS ('dbx_business_glossary_term' = 'Is Variant Defining Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `raw_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Attribute Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `typed_value_boolean` SET TAGS ('dbx_business_glossary_term' = 'Typed Boolean Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `typed_value_date` SET TAGS ('dbx_business_glossary_term' = 'Typed Date Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `typed_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Typed Numeric Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `typed_value_string` SET TAGS ('dbx_business_glossary_term' = 'Typed String Value');
ALTER TABLE `ecommerce_ecm`.`product`.`attribute_value` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `product_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Product Digital Asset ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `accessibility_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'image|video|document|3d_model|ar_asset|360_spin');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `enrichment_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Completeness Score');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `external_asset_code` SET TAGS ('dbx_business_glossary_term' = 'External Asset ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `tags_metadata` SET TAGS ('dbx_business_glossary_term' = 'Tags Metadata');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `usage_rights_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`product_digital_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Code');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_description` SET TAGS ('dbx_business_glossary_term' = 'Bundle Description');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Status');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|discontinued|out_of_stock|pending_approval');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Bundle Type');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'fixed_bundle|configurable_bundle|gift_set|kit|promotional_bundle|subscription_box');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `component_count` SET TAGS ('dbx_business_glossary_term' = 'Component Count');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `cross_sell_bundle_ids` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Bundle Identifiers (IDs)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `discontinued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^d{6,10}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Primary Image Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Is Configurable Bundle Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `is_returnable` SET TAGS ('dbx_business_glossary_term' = 'Is Returnable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `is_subscription_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Subscription Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Bundle Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `package_dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Dimensions in Centimeters (cm)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `package_dimensions_cm` SET TAGS ('dbx_value_regex' = '^d+(.d+)?xd+(.d+)?xd+(.d+)?$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Bundle Price');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'fixed_price|sum_of_parts|discounted|tiered|dynamic');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window in Days');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `shipping_class` SET TAGS ('dbx_business_glossary_term' = 'Shipping Class');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `shipping_class` SET TAGS ('dbx_value_regex' = 'standard|expedited|freight|hazmat|oversized|cold_chain');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Bundle Short Description');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle` ALTER COLUMN `upsell_bundle_ids` SET TAGS ('dbx_business_glossary_term' = 'Upsell Bundle Identifiers (IDs)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `bundle_component_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component ID');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `primary_bundle_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `assembly_instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Assembly Instruction Text');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_price_override` SET TAGS ('dbx_business_glossary_term' = 'Component Price Override');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_role` SET TAGS ('dbx_business_glossary_term' = 'Component Role');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_role` SET TAGS ('dbx_value_regex' = 'primary|accessory|optional|complementary|replacement|sample');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Component Volume in Cubic Meters (m³)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `component_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Component Weight in Kilograms (kg)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `cpsc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `inventory_reservation_priority` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reservation Priority');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `is_substitutable` SET TAGS ('dbx_business_glossary_term' = 'Is Substitutable Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `is_visible_to_customer` SET TAGS ('dbx_business_glossary_term' = 'Is Visible to Customer Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `ecommerce_ecm`.`product`.`bundle_component` ALTER COLUMN `substitution_group_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Group Code');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `relation_id` SET TAGS ('dbx_business_glossary_term' = 'Relation Identifier');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Source Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `target_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CVR)');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `display_position` SET TAGS ('dbx_business_glossary_term' = 'Display Position');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `last_performance_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `merchandising_notes` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `relation_source` SET TAGS ('dbx_business_glossary_term' = 'Relation Source');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `relation_source` SET TAGS ('dbx_value_regex' = 'manual_curation|algorithmic|seller_submitted|collaborative_filtering|content_based|hybrid');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `relation_type` SET TAGS ('dbx_business_glossary_term' = 'Relation Type');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `relation_type` SET TAGS ('dbx_value_regex' = 'cross_sell|upsell|frequently_bought_together|accessory|replacement|spare_part');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attributed');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relation Strength Score');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `total_clicks` SET TAGS ('dbx_business_glossary_term' = 'Total Clicks');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `total_conversions` SET TAGS ('dbx_business_glossary_term' = 'Total Conversions');
ALTER TABLE `ecommerce_ecm`.`product`.`relation` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Logo Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `parent_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Category Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Approval Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Brand Average Customer Rating');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|discontinued');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Certification');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Brand Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Brand Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `featured_rank` SET TAGS ('dbx_business_glossary_term' = 'Brand Featured Rank');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Brand Exclusive Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Brand Verified Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `manufacturer_country` SET TAGS ('dbx_business_glossary_term' = 'Brand Manufacturer Country');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `manufacturer_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Manufacturer Name');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `meta_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Meta Description');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `meta_title` SET TAGS ('dbx_business_glossary_term' = 'Brand Meta Title');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Type');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'manufacturer|distributor|marketplace_seller|private_label');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Registration Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Brand Search Keywords');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Sustainability Score');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|standard|value|private_label');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `total_reviews` SET TAGS ('dbx_business_glossary_term' = 'Brand Total Customer Reviews');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `total_skus` SET TAGS ('dbx_business_glossary_term' = 'Brand Total Stock Keeping Units (SKUs)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `trademark_country` SET TAGS ('dbx_business_glossary_term' = 'Brand Trademark Country');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `trademark_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `trademark_number` SET TAGS ('dbx_business_glossary_term' = 'Brand Trademark Registration Number');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Brand Record Updated By User');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Brand Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`product`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Expense General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `age_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Warning Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Number');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'valid|expired|pending|revoked|suspended');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `listing_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Listing Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `minimum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_address` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Address');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Email');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Phone');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `scope_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Scope of Certification');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`compliance_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `product_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Product Listing ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Rating');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `buy_box_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Box Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Path');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'WEB|MOBILE|MARKETPLACE|B2B|BOPIS|SOCIAL');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `channel_listing_code` SET TAGS ('dbx_business_glossary_term' = 'Channel-Specific Listing ID');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `compare_at_price` SET TAGS ('dbx_business_glossary_term' = 'Compare At Price');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'new|refurbished|used|open_box|damaged');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `ean_code` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `ean_code` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Listing End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'FBM|FBA|3PL|DROPSHIP|BOPIS');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `inventory_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inventory Quantity');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `last_sold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sold Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'active|suppressed|pending|inactive|suspended|archived');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Listing Price');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `promotional_badge` SET TAGS ('dbx_business_glossary_term' = 'Promotional Badge');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Listing Quality Score');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `restricted_shipping_regions` SET TAGS ('dbx_business_glossary_term' = 'Restricted Shipping Regions');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Review Count');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `shipping_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Shipping Dimensions');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `shipping_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipping Weight (Kilograms)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `total_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Total Units Sold');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`product`.`product_listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier ID');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace ID');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `barcode_format` SET TAGS ('dbx_business_glossary_term' = 'Barcode Format');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'Check Digit');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `customs_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Classification Code (HS Code)');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference URL (Uniform Resource Locator)');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `gtin_type` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Type');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `gtin_type` SET TAGS ('dbx_value_regex' = 'GTIN_8|GTIN_12|GTIN_13|GTIN_14|NONE');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_business_glossary_term' = 'Identifier Status');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DEPRECATED|PENDING|SUSPENDED');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Is Serialized Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'EACH|INNER_PACK|CASE|PALLET|DISPLAY_UNIT');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`identifier` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_sku_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Stock Keeping Unit (SKU) Mapping Identifier');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Canonical Catalog Item Identifier');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `auto_remap_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Remap Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `canonical_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Canonical Brand Name');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `canonical_category_path` SET TAGS ('dbx_business_glossary_term' = 'Canonical Category Path');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `compliance_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Failure Reason');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `gmv_attribution_enabled` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) Attribution Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `image_match_score` SET TAGS ('dbx_business_glossary_term' = 'Image Match Score');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `is_buy_box_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Buy Box Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `is_duplicate_listing` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Listing Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Mapping Confidence Score');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_method` SET TAGS ('dbx_business_glossary_term' = 'Mapping Method');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_method` SET TAGS ('dbx_value_regex' = 'exact_barcode_match|fuzzy_title_match|image_match|manual_review|seller_declaration');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_source_system` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source System');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_value_regex' = 'mapped|pending_review|rejected|unmapped');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `mapping_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mapping Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|standard');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `rejection_notes` SET TAGS ('dbx_business_glossary_term' = 'Rejection Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Brand Name');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_category_path` SET TAGS ('dbx_business_glossary_term' = 'Seller Category Path');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_ean_code` SET TAGS ('dbx_business_glossary_term' = 'Seller European Article Number (EAN)');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_ean_code` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_product_title` SET TAGS ('dbx_business_glossary_term' = 'Seller Product Title');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_sku_code` SET TAGS ('dbx_business_glossary_term' = 'Seller Stock Keeping Unit (SKU) Code');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_upc_code` SET TAGS ('dbx_business_glossary_term' = 'Seller Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `seller_upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`product`.`seller_sku_mapping` ALTER COLUMN `title_match_score` SET TAGS ('dbx_business_glossary_term' = 'Title Match Score');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` SET TAGS ('dbx_association_edges' = 'product.brand,seller.seller_profile');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `brand_seller_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Brand Seller Agreement Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Brand Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Seller Profile Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Agreement End Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Agreement Start Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Commission Rate');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `exclusive_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Seller Agreement - Exclusive Agreement Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_seller_agreement` ALTER COLUMN `exclusive_agreement_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` SET TAGS ('dbx_subdomain' = 'product_bundling');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,content.digital_asset');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `sku_asset_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Asset Assignment - Sku Asset Assignment Id');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Asset Assignment - Digital Asset Id');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Asset Assignment - Sku Id');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `brand_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Flag');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `seo_score` SET TAGS ('dbx_business_glossary_term' = 'SEO Score');
ALTER TABLE `ecommerce_ecm`.`product`.`sku_asset_assignment` ALTER COLUMN `usage_rights_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Notes');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` SET TAGS ('dbx_association_edges' = 'product.catalog_item,compliance.regulation');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `regulation_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Product Regulation Compliance - Product Regulation Compliance Id');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Regulation Compliance - Catalog Item Id');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Regulation Compliance - Regulation Id');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_sensitive' = 'true');
ALTER TABLE `ecommerce_ecm`.`product`.`regulation_compliance` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` SET TAGS ('dbx_association_edges' = 'product.brand,compliance.compliance_program');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ALTER COLUMN `brand_compliance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Enrollment - Brand Compliance Enrollment Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Enrollment - Brand Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Enrollment - Compliance Program Id');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `ecommerce_ecm`.`product`.`brand_compliance_enrollment` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
