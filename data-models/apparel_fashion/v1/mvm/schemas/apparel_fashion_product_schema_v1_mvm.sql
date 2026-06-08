-- Schema for Domain: product | Business: Apparel Fashion | Version: v1_mvm
-- Generated on: 2026-05-05 18:07:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`product` COMMENT 'Single source of truth for all apparel and fashion product definitions including SKUs, UPCs, styles, colorways, sizes, BOMs, tech packs, material compositions, and MSRP. Owns the master product catalog from concept through commercialization across athletic, lifestyle, and luxury clothing, footwear, and accessories. Integrates with PLM systems (Infor PLM, Centric PLM) for design-to-production lifecycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`style` (
    `style_id` BIGINT COMMENT 'Unique identifier for the style. Primary key representing the foundational design unit in Product Lifecycle Management (PLM) systems before colorway and size differentiation.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Style is the master product entity and should have a direct FK to brand. Currently only sku.brand_id exists, but style-level brand assignment is essential for product master data management. Style doe',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Style has style_category and subcategory (STRING) columns that should be normalized to the category hierarchy. Currently only sku.category_id exists, but style is the master entity and should own the ',
    `collection_id` BIGINT COMMENT 'Foreign key linking to product.collection. Business justification: Style should have a direct FK to its primary collection. Currently style has collection_name (STRING) which should be normalized. While colorway.collection_id exists, style is the master entity and sh',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Styles are designed and managed by specific departments (merchandising, design) tracked as cost centers. Essential for allocating product development overhead, budget tracking, and departmental perfor',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Style-level wholesale exclusivity (e.g., a Costco-exclusive style, a department-store-exclusive silhouette) is a standard apparel wholesale practice. The style table has is_exclusive flag but no FK id',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Styles require HS classification for international trade compliance, customs declarations, and duty rate determination. Every imported/exported style must have an HS code assigned during product devel',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Styles are planned for specific profit centers (brand/channel/region combinations). Critical for P&L reporting, margin analysis by segment, and strategic assortment planning decisions in multi-brand o',
    `size_scale_id` BIGINT COMMENT 'Foreign key linking to product.size_scale. Business justification: Style should reference its applicable size_scale at the master level. Currently only sku.size_scale_id exists, but the size scale is determined at style design time, not SKU level. This enables proper',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Merchandising teams design styles for specific customer segments (e.g., Gen-Z athleisure, luxury high-net-worth). Product development briefs explicitly identify target segments. This link enables segm',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved the style for commercialization. Used for accountability, governance, and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the style was approved for commercialization and moved from development to active status. Key milestone in PLM workflow and governance.',
    `care_instructions` STRING COMMENT 'Garment care and washing instructions. Required for consumer product labeling and compliance with FTC Care Labeling Rule.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Standard Cost of Goods Sold (COGS) for the style including materials, labor, and manufacturing overhead. Foundation for margin analysis, Initial Markup (IMU), and profitability reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the style is manufactured. Required for customs, duty calculation, and country-of-origin labeling compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the style record was first created in the PLM or master data system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP (e.g., USD, EUR, GBP). Supports multi-currency pricing and international operations.. Valid values are `^[A-Z]{3}$`',
    `design_owner` STRING COMMENT 'Name or identifier of the designer or design team responsible for creating the style. Used for attribution, collaboration tracking, and design portfolio management.',
    `discontinuation_date` DATE COMMENT 'Date when the style is discontinued and removed from active assortment. Used for lifecycle management, markdown planning, and inventory liquidation strategies.',
    `division` STRING COMMENT 'Business division or brand line to which the style belongs. Used for P&L reporting, brand portfolio management, and organizational accountability.',
    `gender` STRING COMMENT 'Target gender demographic for the style. Critical for merchandising, assortment planning, and store allocation.. Valid values are `mens|womens|unisex|youth|kids|infant`',
    `is_core_style` BOOLEAN COMMENT 'Boolean flag indicating whether this is a core, never-out-of-stock (NOS) style that is continuously replenished. Core styles receive priority in inventory allocation and replenishment planning.',
    `is_exclusive` BOOLEAN COMMENT 'Boolean flag indicating whether the style is exclusive to specific channels, retailers, or markets. Used for channel conflict management and partnership agreements.',
    `launch_date` DATE COMMENT 'Planned or actual date when the style is launched to market and becomes available for sale. Key milestone for merchandising, marketing campaigns, and inventory planning.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from Purchase Order (PO) placement to delivery. Used for Time and Action (TNA) calendar planning and On Time In Full (OTIF) performance tracking.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the Product Lifecycle Management (PLM) workflow. Governs visibility, ordering, and operational processes across design, sourcing, production, and sales channels. [ENUM-REF-CANDIDATE: concept|development|sample|commercialized|active|phasing_out|discontinued — 7 candidates stripped; promote to reference product]',
    `material_composition` STRING COMMENT 'Primary fabric or material composition of the style (e.g., 100% Cotton, 80% Polyester 20% Elastane). Required for compliance labeling per FTC Textile Fiber Products Identification Act and sustainability reporting.',
    `minimum_order_quantity` STRING COMMENT 'Minimum Order Quantity (MOQ) required by the manufacturer or supplier for production of this style. Critical for buy planning and Open-to-Buy (OTB) budgeting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the style record was last modified. Used for change tracking, audit compliance, and data synchronization across systems.',
    `msrp` DECIMAL(18,2) COMMENT 'Manufacturers Suggested Retail Price for the style at launch. Baseline for pricing strategy, markdown planning, and Gross Margin Return on Investment (GMROI) analysis.',
    `product_type` STRING COMMENT 'High-level classification of the style by market positioning and intended use case. Aligns with brand portfolio segmentation strategy.. Valid values are `athletic|lifestyle|luxury|performance|casual|formal`',
    `safety_certification` STRING COMMENT 'Product safety certifications and compliance standards met by the style. Required for consumer product safety and regulatory compliance.',
    `season_code` STRING COMMENT 'Season identifier for the style (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Critical for collection planning, Open-to-Buy (OTB) management, and lifecycle tracking.. Valid values are `^(SS|FW|SP|FA|HO)[0-9]{2}$`',
    `silhouette` STRING COMMENT 'Design silhouette or fit profile of the style (e.g., slim fit, relaxed fit, oversized, tailored). Key attribute for product differentiation and customer preference matching.',
    `style_description` STRING COMMENT 'Detailed narrative description of the style including design features, aesthetic attributes, and intended use. Used for marketing copy and product catalogs.',
    `style_name` STRING COMMENT 'Human-readable marketing name or title of the style. Used in catalogs, e-commerce, and merchandising communications.',
    `style_number` STRING COMMENT 'Externally-known unique business identifier for the style. Used across PLM, merchandising, and supply chain systems. Typically alphanumeric code assigned during design phase.. Valid values are `^[A-Z0-9]{6,12}$`',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical certifications held by the style (e.g., GOTS, OEKO-TEX, BCI, Fair Trade). Supports ESG reporting and consumer transparency initiatives.',
    `target_channel` STRING COMMENT 'Intended sales and distribution channel strategy for the style. Supports Direct-to-Consumer (DTC), wholesale, retail, and omnichannel planning. May include multiple channels separated by delimiter.',
    `tech_pack_reference` STRING COMMENT 'Reference identifier or document link to the technical specification package (tech pack) containing detailed construction, measurements, and manufacturing instructions.',
    `wholesale_price` DECIMAL(18,2) COMMENT 'Wholesale price offered to retail partners and distributors. Used for B2B pricing, margin analysis, and wholesale channel profitability.',
    CONSTRAINT pk_style PRIMARY KEY(`style_id`)
) COMMENT 'Core master entity representing a unique apparel or footwear style — the foundational design unit in PLM (Infor PLM, Centric PLM). Captures style number, name, gender, silhouette, product type (athletic, lifestyle, luxury), category, subcategory, division, season, collection, lifecycle stage (concept, development, commercialized, discontinued), target channel (DTC, wholesale, retail), MSRP, and design ownership. This is the top-level product identity before colorway and size differentiation. Parent entity in the style→colorway→SKU hierarchy.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`colorway` (
    `colorway_id` BIGINT COMMENT 'Unique identifier for the colorway. Primary key for the colorway entity.',
    `collection_id` BIGINT COMMENT 'Reference to the collection that this colorway belongs to. Collections group related styles and colorways for merchandising and marketing purposes.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Colorway development (color matching, dyeing trials, print development) incurs costs allocated to design or merchandising cost centers. Necessary for tracking color development expenses and department',
    `season_id` BIGINT COMMENT 'Reference to the season in which this colorway is launched or relevant. Links to the merchandising season master data.',
    `style_id` BIGINT COMMENT 'Reference to the parent style that this colorway belongs to. A style may have multiple colorways.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Colorway assortment planning targets specific customer segments (e.g., teen-girl colorways vs. professional-women colorways). Merchandising teams make segment-specific colorway decisions for seasonal ',
    `age_group` STRING COMMENT 'The target age group for the colorway. Used for merchandising and assortment planning.. Valid values are `adult|youth|toddler|infant`',
    `color_family` STRING COMMENT 'The broad color family or category that the colorway belongs to, used for filtering and search in e-commerce and merchandising systems. [ENUM-REF-CANDIDATE: red|blue|green|yellow|orange|purple|pink|brown|black|white|gray|multi — 12 candidates stripped; promote to reference product]',
    `color_standard` STRING COMMENT 'The color standard system used to define the colorway (e.g., Pantone, Natural Color System (NCS), RAL, CMYK, RGB, HEX).. Valid values are `Pantone|NCS|RAL|CMYK|RGB|HEX`',
    `color_story` STRING COMMENT 'The thematic narrative or inspiration behind the colorway, often tied to seasonal trends, brand campaigns, or design concepts (e.g., Ocean Breeze, Urban Jungle, Retro Revival).',
    `colorway_code` STRING COMMENT 'Unique business identifier for the colorway, typically a short alphanumeric code used in Product Lifecycle Management (PLM) systems, Oracle Retail, and across supply chain operations.. Valid values are `^[A-Z0-9]{3,12}$`',
    `colorway_name` STRING COMMENT 'Human-readable name for the colorway, often descriptive and marketing-friendly (e.g., Midnight Navy, Sunset Orange, Forest Green).',
    `colorway_status` STRING COMMENT 'Current lifecycle status of the colorway. Active colorways are available for sale; discontinued colorways are no longer produced; carry-over colorways continue from a previous season; pending colorways are in development.. Valid values are `active|inactive|discontinued|carry-over|pending|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the colorway record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the Manufacturers Suggested Retail Price (MSRP) (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discontinuation_date` DATE COMMENT 'The date when the colorway was discontinued or removed from active production. Null if the colorway is still active.',
    `exclusivity_description` STRING COMMENT 'Details about the exclusivity arrangement, such as the specific retailer, channel, or region where the colorway is exclusively available.',
    `finish_type` STRING COMMENT 'The surface finish or texture applied to the colorway (e.g., matte, glossy, metallic, satin). Relevant for footwear, accessories, and certain apparel categories.. Valid values are `matte|glossy|metallic|satin|textured|embossed`',
    `gender_target` STRING COMMENT 'The target gender demographic for the colorway. Used for merchandising, assortment planning, and marketing segmentation.. Valid values are `mens|womens|unisex|boys|girls|infant`',
    `hex_color_code` STRING COMMENT 'The hexadecimal color code for the primary color, used for digital representation in e-commerce and marketing materials.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `image_url` STRING COMMENT 'The URL or file path to the primary product image for this colorway, used in e-commerce, Point of Sale (POS), and marketing materials.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the colorway is exclusive to a specific channel, retailer, or region. True for exclusive colorways, False for general distribution.',
    `is_limited_edition` BOOLEAN COMMENT 'Indicates whether the colorway is a limited edition release with restricted production quantities. True for limited editions, False for standard releases.',
    `launch_date` DATE COMMENT 'The date when the colorway was officially launched or made available for sale. Used for Time and Action (TNA) calendar tracking.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified the colorway record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the colorway record was last modified. Used for audit trail and change tracking.',
    `msrp` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for products in this colorway. Used as the baseline for pricing strategies and markdown calculations.',
    `oracle_retail_item_code` STRING COMMENT 'The unique identifier for this colorway in Oracle Retail Merchandising System. Used for integration with merchandising, allocation, and pricing modules.',
    `pantone_code` STRING COMMENT 'The Pantone Matching System (PMS) code for the primary color, used for precise color matching in manufacturing and printing.. Valid values are `^[A-Z0-9s-]{3,20}$`',
    `plm_system_code` STRING COMMENT 'The unique identifier for this colorway in the source Product Lifecycle Management (PLM) system (Infor PLM or Centric PLM). Used for system integration and traceability.',
    `primary_color` STRING COMMENT 'The dominant color of the colorway. This is the main color that defines the visual appearance of the product.',
    `print_pattern` STRING COMMENT 'Description of any print or pattern applied to the colorway (e.g., Floral, Geometric, Camouflage, Solid). Null for solid colors without patterns.',
    `swatch_image_url` STRING COMMENT 'The URL or file path to the color swatch image for this colorway, used for color selection in e-commerce and merchandising tools.',
    `tertiary_color` STRING COMMENT 'The third accent color of the colorway, if applicable. Used for multi-color designs.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created the colorway record. Used for audit trail and accountability.',
    CONSTRAINT pk_colorway PRIMARY KEY(`colorway_id`)
) COMMENT 'Represents a specific color variant of a style, combining the style with a defined color palette. Tracks colorway code, colorway name, primary color, secondary color, color standard (Pantone, NCS), color story, season relevance, colorway status (active, discontinued, carry-over), and launch date. A style may have multiple colorways; each colorway is a distinct sellable variant managed in PLM and Oracle Retail.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU. Primary key representing the atomic sellable unit at the intersection of style, colorway, and size.',
    `brand_id` BIGINT COMMENT 'Reference to the brand under which this SKU is marketed. Supports multi-brand portfolio management.',
    `category_id` BIGINT COMMENT 'Reference to the merchandise hierarchy category. Classifies the SKU into the product taxonomy for reporting and planning.',
    `collection_id` BIGINT COMMENT 'Reference to the seasonal collection or product line that this SKU belongs to. Links to collection planning and merchandising.',
    `colorway_id` BIGINT COMMENT 'Reference to the colorway variant of the style. Defines the specific color combination applied to this SKU.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: SKU-to-GL account mapping drives inventory valuation, COGS posting, and revenue recognition in apparel ERP (SAP/Oracle Retail). Every apparel finance team expects SKUs to be mapped to GL accounts for ',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: SKUs are the unit of customs classification in apparel operations. Every SKU crossing borders requires HS code for customs entry, duty calculation, and trade compliance. Critical for landed cost accur',
    `size_scale_id` BIGINT COMMENT 'Foreign key linking to product.size_scale. Business justification: SKU represents the atomic sellable unit at the intersection of style, colorway, and size. Currently has size_code and size_label as strings, but no FK to the size_scale master. Size_scale defines the ',
    `style_id` BIGINT COMMENT 'Reference to the parent style that this SKU belongs to. Links to the style master which defines the base product design.',
    `age_group` STRING COMMENT 'Target age demographic for the product. Complements gender classification for merchandising and safety compliance.. Valid values are `adult|youth|toddler|infant`',
    `ats_flag` BOOLEAN COMMENT 'Indicates whether the SKU is currently available for sale across channels. Drives e-commerce availability and order promising.',
    `care_instructions` STRING COMMENT 'Garment care and washing instructions as required on product labels. Includes washing, drying, ironing, and dry cleaning guidance.',
    `color_code` STRING COMMENT 'Short alphanumeric code representing the color variant. Used in SKU construction and merchandising systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `color_name` STRING COMMENT 'Marketing-friendly name of the color variant for customer-facing displays and e-commerce.',
    `cost` DECIMAL(18,2) COMMENT 'The landed cost of the SKU including manufacturing, materials, labor, and freight. Used for margin and profitability analysis.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured. Required for customs, labeling, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SKU record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and cost fields. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `discontinuation_date` DATE COMMENT 'The date when the SKU was or will be discontinued from the active catalog. Used for clearance planning and inventory liquidation.',
    `ean` STRING COMMENT '13-digit EAN barcode identifier used for international retail distribution and point-of-sale operations.. Valid values are `^[0-9]{13}$`',
    `gender` STRING COMMENT 'Target gender demographic for the product. Used for merchandising, assortment planning, and customer segmentation.. Valid values are `mens|womens|unisex|boys|girls|infant`',
    `gsp_eligible` BOOLEAN COMMENT 'Indicates whether the SKU qualifies for GSP duty-free treatment based on country of origin and product classification.',
    `gtin` STRING COMMENT '14-digit global trade item number for supply chain and logistics tracking across international markets.. Valid values are `^[0-9]{14}$`',
    `height_cm` DECIMAL(18,2) COMMENT 'The height dimension of the packaged SKU in centimeters. Used for carton planning and warehouse space optimization.',
    `imu_percent` DECIMAL(18,2) COMMENT 'The initial markup percentage calculated as (MSRP - Cost) / MSRP. Key metric for pricing strategy and profitability.',
    `launch_date` DATE COMMENT 'The date when the SKU was first made available for sale. Used for product lifecycle analysis and merchandising planning.',
    `length_cm` DECIMAL(18,2) COMMENT 'The length dimension of the packaged SKU in centimeters. Used for carton planning and warehouse space optimization.',
    `material_composition` STRING COMMENT 'Detailed description of fabric and material composition with percentages. Required for labeling compliance and sustainability reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this SKU record was last modified. Used for change tracking and data synchronization.',
    `msrp` DECIMAL(18,2) COMMENT 'The recommended retail price set by the manufacturer. Used as baseline for pricing strategies and markdown calculations.',
    `nos_flag` BOOLEAN COMMENT 'Indicates whether the SKU is designated as a never-out-of-stock item requiring continuous replenishment and high service levels.',
    `product_type` STRING COMMENT 'High-level classification of the product into apparel, footwear, or accessories. Drives business rules and fulfillment logic.. Valid values are `apparel|footwear|accessories`',
    `rfid_tag_reference` STRING COMMENT 'RFID tag identifier for automated inventory tracking, anti-theft, and supply chain visibility. Enables real-time location tracking.. Valid values are `^[A-F0-9]{24}$`',
    `season_code` STRING COMMENT 'Season and year code for collection planning. Format: SS24 (Spring/Summer 2024), FW24 (Fall/Winter 2024).. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `size_run_position` STRING COMMENT 'Numeric position of this size within the size curve or size run. Used for allocation and assortment planning.',
    `sku_code` STRING COMMENT 'The business identifier for the SKU. Externally-known unique code used across all systems for inventory, order, and e-commerce references.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU. Controls visibility, ordering, and inventory management across all channels.. Valid values are `active|inactive|discontinued|pending|seasonal`',
    `sustainability_certification` STRING COMMENT 'Comma-separated list of sustainability certifications held by the product. Examples: GOTS, OEKO-TEX, BCI, Fair Trade, Bluesign.',
    `upc` STRING COMMENT '12-digit UPC barcode identifier for point-of-sale scanning and inventory tracking. Standard barcode format for retail operations.. Valid values are `^[0-9]{12}$`',
    `weight_kg` DECIMAL(18,2) COMMENT 'The weight of the SKU in kilograms. Used for shipping cost calculation, freight planning, and logistics optimization.',
    `wholesale_price` DECIMAL(18,2) COMMENT 'The price at which the SKU is sold to wholesale partners and distributors. Used for B2B pricing and margin analysis.',
    `width_cm` DECIMAL(18,2) COMMENT 'The width dimension of the packaged SKU in centimeters. Used for carton planning and warehouse space optimization.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'The atomic sellable unit in apparel — a unique Stock Keeping Unit representing the intersection of style, colorway, and size. Stores SKU code, UPC/EAN barcode, RFID tag reference, size label, size run position, weight, dimensions, country of origin, HS code, GSP eligibility, MSRP, cost (COGS), IMU, ATS flag, NOS flag, and active/inactive status. SSOT for all downstream inventory, order, and e-commerce references. Sourced from SAP S/4HANA MM and PLM systems.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`size_scale` (
    `size_scale_id` BIGINT COMMENT 'Unique identifier for the size scale. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Size scales are typically defined per product category in apparel (e.g., Mens Tops uses XS-XXL, Footwear uses numeric 6-13, Bottoms uses waist measurements). Size_scale currently has product_cat',
    `brand_applicability` STRING COMMENT 'Comma-separated list of brand codes or names this size scale is applicable to. Allows for brand-specific sizing standards (e.g., luxury brands may use different scales than athletic brands).',
    `conversion_table_reference` STRING COMMENT 'Reference identifier or URL to the size conversion table that maps this scale to other regional or brand scales. Enables cross-market size normalization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this size scale record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field.',
    `default_for_category` BOOLEAN COMMENT 'Indicates whether this size scale is the default scale for its product category and gender combination. Used to auto-populate size scales during product creation in PLM systems.',
    `effective_end_date` DATE COMMENT 'The date after which this size scale is no longer effective and should not be used for new products. Nullable for open-ended scales. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date from which this size scale becomes effective and available for use in product catalog and merchandising operations. Format: yyyy-MM-dd.',
    `erp_system_code` STRING COMMENT 'External identifier for this size scale in the ERP system (SAP S/4HANA). Used for integration with merchandising, allocation, and inventory management modules.',
    `fit_model_reference` STRING COMMENT 'Reference identifier to the fit model or body form specifications used to validate this size scale. Links to sample development and fit approval processes.',
    `gender_applicability` STRING COMMENT 'The gender or demographic segment this size scale is designed for (mens, womens, unisex, boys, girls, infant, toddler). Aligns with product categorization and merchandising hierarchy. [ENUM-REF-CANDIDATE: mens|womens|unisex|boys|girls|infant|toddler — 7 candidates stripped; promote to reference product]',
    `grading_rule_reference` STRING COMMENT 'Reference identifier to the grading rule set used for pattern grading across sizes in this scale. Links to technical design specifications in PLM systems.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this size scale is currently active and available for use in product creation and merchandising. False indicates the scale is deprecated or retired.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this size scale record. Audit trail field for governance and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this size scale record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for change tracking.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the size scale: draft (under development), active (in use), deprecated (phasing out), retired (no longer used). Governs availability for new product assignments.. Valid values are `draft|active|deprecated|retired`',
    `measurement_system` STRING COMMENT 'The regional measurement system or standard used for this size scale (US, EU, UK, JP, CN, AU, KR, INT for International). Determines the sizing convention and labeling standards. [ENUM-REF-CANDIDATE: US|EU|UK|JP|CN|AU|KR|INT — 8 candidates stripped; promote to reference product]',
    `measurement_unit` STRING COMMENT 'The unit of measurement used for size specifications in this scale (inches, centimeters, waist_inseam for bottoms, chest_length for tops, not_applicable for alpha or one-size scales).. Valid values are `inches|centimeters|waist_inseam|chest_length|not_applicable`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or business context related to this size scale. Used for internal documentation and knowledge transfer.',
    `plm_system_code` STRING COMMENT 'External identifier for this size scale in the PLM system (Infor PLM, Centric PLM). Used for integration and synchronization with design and product development systems.',
    `regional_market` STRING COMMENT 'Comma-separated list of 3-letter ISO country codes where this size scale is used (e.g., USA,CAN,MEX for North America). Enables regional size mapping and localization.. Valid values are `^[A-Z]{3}(,[A-Z]{3})*$`',
    `size_chart_url` STRING COMMENT 'URL or file path to the customer-facing size chart document or image for this scale. Used for e-commerce display and customer service reference.',
    `size_count` STRING COMMENT 'Total number of distinct sizes in this scale. Derived from the size_labels field but stored for quick reference and allocation planning.',
    `size_increment` STRING COMMENT 'The increment or step between consecutive sizes in numeric scales (e.g., 2 for waist sizes 28,30,32,34). Not applicable for alpha scales.',
    `size_labels` STRING COMMENT 'Ordered comma-separated list of size labels in this scale run (e.g., XS,S,M,L,XL,XXL or 28,30,32,34,36,38,40 or 6,8,10,12,14). Order represents the size progression from smallest to largest.',
    `size_range_end` STRING COMMENT 'The largest size label in this scale (e.g., XXL, 40, 14). Represents the upper bound of the size run.',
    `size_range_start` STRING COMMENT 'The smallest size label in this scale (e.g., XS, 28, 6). Represents the lower bound of the size run.',
    `size_scale_code` STRING COMMENT 'Business identifier code for the size scale (e.g., MENS_TOPS_US, WOMENS_BOTTOMS_EU, FOOTWEAR_UK). Used as the externally-known unique code for this size scale across systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `size_scale_description` STRING COMMENT 'Detailed description of the size scale, including its intended use, product categories, and any special characteristics or measurement guidelines.',
    `size_scale_name` STRING COMMENT 'Human-readable name of the size scale (e.g., Mens Tops US Standard, Womens Bottoms EU, Footwear UK Sizing). Provides clear business context for the size run.',
    `size_type` STRING COMMENT 'Classification of the size labeling system: alpha (XS-XXL), numeric (28-40, 6-14), hybrid (combination of alpha and numeric), or one_size. Determines display and conversion logic.. Valid values are `alpha|numeric|hybrid|one_size`',
    `version_number` STRING COMMENT 'Version number of this size scale definition. Incremented with each modification to support change history and rollback capabilities.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this size scale record. Audit trail field for governance and compliance.',
    CONSTRAINT pk_size_scale PRIMARY KEY(`size_scale_id`)
) COMMENT 'Defines the size run and size labeling system used for a product category or brand (e.g., XS-XXL, 28-40 waist, EU 36-46, US 6-14, One Size). Captures size scale code, size scale name, measurement system (US, EU, UK, JP), size labels ordered by run position, gender applicability, product category applicability, and regional market mapping. Enables consistent size normalization across channels and geographies.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the product category. Primary key for the product category entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product categories are managed by specific merchandising departments tracked as cost centers. Essential for allocating category management costs, planning budgets, and evaluating departmental efficien',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Product categories determine GL account assignment for inventory classification and COGS reporting in apparel ERP. Category-to-GL mapping drives automatic account determination for footwear vs apparel',
    `parent_category_id` BIGINT COMMENT 'Reference to the immediate parent category in the merchandise hierarchy. Null for top-level divisions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product categories roll up to profit centers for segment P&L reporting. Critical for analyzing profitability by category within brand/channel/region segments, supporting strategic assortment and inves',
    `age_group` STRING COMMENT 'Target age demographic for products within this category. Influences sizing, design, and marketing strategies.. Valid values are `adult|youth|kids|infant|toddler`',
    `category_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the category within the merchandising hierarchy. Used as business key across Oracle Retail, PLM, and e-commerce systems.. Valid values are `^[A-Z0-9]{2,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the product category including scope, product types included, and merchandising guidelines.',
    `category_name` STRING COMMENT 'Full descriptive name of the product category as displayed in merchandising, e-commerce, and reporting systems.',
    `category_status` STRING COMMENT 'Current lifecycle status of the category. Inactive categories are excluded from new product assignments and assortment planning.. Valid values are `active|inactive|pending|discontinued|seasonal_hold`',
    `category_type` STRING COMMENT 'High-level classification of the product category by major product type. Aligns with design and sourcing organizational structure.. Valid values are `clothing|footwear|accessories|equipment|licensed|private_label`',
    `channel_applicability` STRING COMMENT 'Comma-separated list of sales channels where this category is active: retail, e-commerce, wholesale, outlet, DTC (Direct-to-Consumer).',
    `color_palette_strategy` STRING COMMENT 'Color assortment strategy for this category. Core colors are year-round; seasonal and trend colors change by collection.. Valid values are `core|seasonal|trend|limited_edition`',
    `country_of_origin_primary` STRING COMMENT 'Primary country of origin for products in this category (ISO 3166-1 alpha-3 code). Influences sourcing strategy and compliance labeling.. Valid values are `^[A-Z]{3}$`',
    `cpsc_regulated` BOOLEAN COMMENT 'Indicates whether products in this category are subject to CPSC safety standards (e.g., childrens sleepwear flammability, drawstring regulations).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was first created in the system. Used for audit trail and data lineage.',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Average import duty rate percentage for products in this category. Used for LDP (Landed Duty Paid) cost calculations.',
    `ecommerce_display_sequence` STRING COMMENT 'Sort order for displaying this category in e-commerce navigation menus and product listing pages.',
    `effective_end_date` DATE COMMENT 'Date when this category is discontinued or deactivated. Null for ongoing categories. Used for historical reporting and compliance.',
    `effective_start_date` DATE COMMENT 'Date when this category becomes active for product assignment and merchandising planning. Supports seasonal category activation.',
    `ftc_labeling_required` BOOLEAN COMMENT 'Indicates whether products in this category require FTC textile and apparel labeling (fiber content, country of origin, care instructions).',
    `gender` STRING COMMENT 'Primary gender segmentation for this category. Used for assortment planning, allocation, and merchandising strategy. [ENUM-REF-CANDIDATE: mens|womens|unisex|boys|girls|infant|toddler — 7 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'Numeric level of this category within the merchandise hierarchy. Typically: 1=Division, 2=Department, 3=Class, 4=Subclass, 5=Segment.',
    `hs_code_prefix` STRING COMMENT 'Common HS Code prefix for products in this category. Used for customs classification, duty calculation, and international trade compliance.. Valid values are `^[0-9]{2,6}$`',
    `is_licensed` BOOLEAN COMMENT 'Indicates whether products in this category require licensing agreements (e.g., sports leagues, entertainment properties).',
    `is_private_label` BOOLEAN COMMENT 'Indicates whether this category contains private label (own brand) products versus licensed or third-party brands.',
    `is_sustainable` BOOLEAN COMMENT 'Indicates whether this category is designated for sustainable or eco-friendly products meeting GOTS, BCI, or OEKO-TEX standards.',
    `is_web_visible` BOOLEAN COMMENT 'Indicates whether this category is visible on e-commerce storefronts. Inactive or wholesale-only categories may be hidden from web.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this category record. Used for change tracking and data synchronization.',
    `lead_time_days` STRING COMMENT 'Average production and delivery lead time in days from PO (Purchase Order) placement to warehouse receipt. Used for TNA (Time and Action) planning.',
    `margin_target_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for products within this category. Used for pricing strategy and financial planning.',
    `markdown_risk_level` STRING COMMENT 'Historical markdown risk classification based on sell-through rate (STR) and inventory turnover patterns. Influences OTB (Open-to-Buy) planning.. Valid values are `low|medium|high|very_high`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this category record. Supports audit and accountability requirements.',
    `moq_units` STRING COMMENT 'Typical minimum order quantity in units required by suppliers for this category. Influences buy plan sizing.',
    `oracle_retail_category_code` STRING COMMENT 'External category identifier from Oracle Retail Merchandising System. Used for system integration and data synchronization.',
    `plm_category_code` STRING COMMENT 'External category identifier from Infor PLM or Centric PLM systems. Links merchandising categories to design and development workflows.',
    `product_line` STRING COMMENT 'Strategic product line classification indicating brand positioning and target market segment.. Valid values are `athletic|lifestyle|luxury|performance|casual|formal`',
    `replenishment_strategy` STRING COMMENT 'Inventory replenishment approach for this category. NOS (Never Out of Stock) applies to core basics; fashion items use allocation-driven strategies.. Valid values are `basic|fashion|seasonal|never_out_of_stock|allocation_driven`',
    `season_applicability` STRING COMMENT 'Primary seasonal classification for merchandising and inventory planning. Determines collection planning cycles.. Valid values are `spring|summer|fall|winter|all_season|holiday`',
    `size_scale_type` STRING COMMENT 'Standard sizing system used for products in this category: numeric (2-16), alpha (XS-XXL), footwear (US/EU/UK), one-size, or custom.. Valid values are `numeric|alpha|footwear|one_size|custom`',
    `sustainability_certification` STRING COMMENT 'Comma-separated list of applicable sustainability certifications: GOTS, OEKO-TEX, BCI, Fair Trade, Bluesign, Cradle to Cradle.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical classification taxonomy for all apparel and fashion products. Defines the multi-level category tree (division → department → class → subclass) used across merchandising, PLM, and retail systems. Stores category code, category name, level in hierarchy, parent category, gender, product type (clothing, footwear, accessories), channel applicability, and Oracle Retail category mapping. Enables consistent product classification across OMS, WMS, and e-commerce.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials record. Primary key for the BOM product.',
    `colorway_id` BIGINT COMMENT 'Reference to the specific colorway variant of the style. Links to the colorway master product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BOM development and costing activities are performed by product development or technical design departments tracked as cost centers. Necessary for allocating pre-production costs and tracking departme',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: BOMs determine material cost GL account assignments for standard costing and variance analysis. Apparel cost accountants require BOM-to-GL mapping to post material costs, CMT costs, and duty costs to ',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: BOMs determine material composition and country of origin, which drive HS classification and duty rates. Linking BOM to HS code enables accurate costing, duty estimation, and trade compliance validati',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season for which this BOM is designed. Links to the season master product.',
    `style_id` BIGINT COMMENT 'Reference to the parent style for which this BOM is defined. Links to the style master product.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: BOMs in apparel are factory-specific — construction methods, CMT costs, and material sourcing vary by factory. The same style may have different BOMs for different factories. The existing bom.vendor_i',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier or factory responsible for manufacturing this product. Links to the supplier master product.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, typically assigned by the PLM system. Used for external communication with suppliers and factories.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM indicating its approval state and readiness for production use.. Valid values are `draft|submitted|approved|production|obsolete|cancelled`',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended use case: engineering BOM for design, manufacturing BOM for production, costing BOM for financial analysis, or planning BOM for procurement.. Valid values are `engineering|manufacturing|costing|planning`',
    `cmt_cost` DECIMAL(18,2) COMMENT 'Total labor and manufacturing cost charged by the factory for cutting, making, and trimming the garment. Does not include material costs.',
    `cost_approval_status` STRING COMMENT 'Approval status of the cost buildup by finance or merchandising teams. Approved costs are used for margin analysis and pricing decisions.. Valid values are `pending|approved|rejected|under_review`',
    `cost_approved_date` DATE COMMENT 'Date when the cost buildup was approved. Used for audit trail and version control.',
    `cost_version` STRING COMMENT 'Version identifier for the cost buildup to track changes in costing assumptions, material prices, or factory quotes over time.',
    `costing_stage` STRING COMMENT 'Stage of the costing process indicating the maturity and accuracy of cost data: initial estimate during design, preliminary costing after sampling, final costing before production, or actual costing post-production.. Valid values are `initial_estimate|preliminary_costing|final_costing|actual_costing`',
    `country_of_origin` STRING COMMENT 'Country where the product is manufactured. Used for customs documentation, duty calculation, and trade compliance. Three-letter ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the PLM system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all cost fields in this BOM record. Supports multi-currency costing for global sourcing.. Valid values are `USD|EUR|GBP|CNY|JPY|INR`',
    `cut_cost` DECIMAL(18,2) COMMENT 'Labor cost component for cutting fabric and materials. Part of the CMT cost breakdown.',
    `duty_cost` DECIMAL(18,2) COMMENT 'Import duty cost per unit calculated by applying the duty rate to the FOB cost. Varies by destination country and trade agreements.',
    `duty_rate` DECIMAL(18,2) COMMENT 'Import duty rate percentage applied to the product based on its HS Code and country of origin. Used to calculate duty cost.',
    `effective_date` DATE COMMENT 'Date from which this BOM version becomes active and valid for production or costing purposes.',
    `expiration_date` DATE COMMENT 'Date after which this BOM version is no longer valid. Null indicates an open-ended BOM with no planned obsolescence.',
    `fabric_content_percentage` STRING COMMENT 'Detailed breakdown of fabric composition by material type and percentage (e.g., 60% Cotton, 40% Polyester). Required for FTC labeling compliance and OEKO-TEX certification.',
    `fob_cost` DECIMAL(18,2) COMMENT 'Total cost of the product at the port of origin, including materials, CMT, and factory overhead. Excludes freight, duty, and landed costs.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost per unit to ship the product from the factory to the destination warehouse or distribution center.',
    `imu_percentage` DECIMAL(18,2) COMMENT 'Initial markup percentage calculated as (MSRP - LDP Cost) / MSRP. Key profitability metric for merchandising and pricing decisions.',
    `ldp_cost` DECIMAL(18,2) COMMENT 'Total landed cost per unit including FOB, freight, duty, and all other costs to deliver the product to the destination warehouse. Represents the true COGS.',
    `lead_time_days` STRING COMMENT 'Number of days required from purchase order placement to product delivery at the destination warehouse. Used for supply chain planning and TNA calendar.',
    `make_cost` DECIMAL(18,2) COMMENT 'Labor cost component for sewing and assembling the garment. Part of the CMT cost breakdown.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this BOM record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was last modified. Used for audit trail and change tracking.',
    `moq` STRING COMMENT 'Minimum order quantity required by the supplier or factory to manufacture this product at the quoted cost. Critical for buy planning and allocation.',
    `msrp` DECIMAL(18,2) COMMENT 'Suggested retail price for the product. Used to calculate Initial Markup (IMU) and Maintained Markup (MMU) metrics.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to the BOM, costing assumptions, or material sourcing.',
    `primary_fabric_type` STRING COMMENT 'Dominant fabric material used in the product (e.g., Cotton, Polyester, Wool, Silk, Nylon). Used for merchandising classification and sustainability reporting.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical certifications applicable to the BOM materials (e.g., GOTS, BCI, OEKO-TEX, Fair Trade). Supports ESG reporting and brand commitments.',
    `target_cogs` DECIMAL(18,2) COMMENT 'Target cost of goods sold set during product development to achieve desired margin objectives. Used as a benchmark against actual LDP cost.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Sum of all raw material, fabric, trim, and component costs required to manufacture one unit of the product. Expressed in the costing currency.',
    `trim_cost` DECIMAL(18,2) COMMENT 'Labor cost component for finishing, trimming, and quality inspection. Part of the CMT cost breakdown.',
    `version` STRING COMMENT 'Version number of the BOM to track revisions and changes throughout the product lifecycle. Supports version control for design iterations.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this BOM record. Used for accountability and audit purposes.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of Materials and Product Costing master for a style or colorway — the single authoritative record of all raw materials, fabrics, trims, labels, and components required to manufacture the product, combined with complete product cost buildup. Captures BOM version, effective date, BOM status (draft, approved, production), and all cost components: total material cost, CMT cost breakdown (cut, make, trim), FOB cost, LDP (Landed Duty Paid) cost, duty rate, freight cost, target COGS, costing stage (initial estimate, final costing, actual), cost version, cost approval status, and IMU/MMU calculation inputs. Fabric content percentage supports FTC labeling compliance. Managed in Infor PLM and Centric PLM costing modules. SSOT for product costing, material composition, and cost buildup — no other product in this domain stores cost data. Critical for sourcing decisions, margin management, and regulatory labeling.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity.',
    `bom_id` BIGINT COMMENT 'Reference to the parent BOM header that this line belongs to. Links the line item to its parent product or style BOM.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Individual BOM line items (fabric, trim, packaging) map to distinct GL accounts for granular material cost breakdown reporting. Apparel cost accountants require line-level GL assignment to split fabri',
    `material_id` BIGINT COMMENT 'Reference to the material master record. Links to the specific fabric, trim, component, or packaging material used in this BOM line.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this material. Links to the supplier master for sourcing and procurement.',
    `approved_date` DATE COMMENT 'Date when this BOM line was approved for production use. Part of the BOM change control and approval workflow.',
    `bom_line_status` STRING COMMENT 'Current lifecycle status of the BOM line. Tracks whether the line is active for production, pending approval, or has been obsoleted or superseded by a newer version.. Valid values are `active|inactive|pending_approval|obsolete|superseded`',
    `change_reason` STRING COMMENT 'Textual explanation for why this BOM line was added, modified, or inactivated. Supports change management and audit trail for BOM revisions.',
    `color_specification` STRING COMMENT 'Color code or description for the material. May reference Pantone codes, supplier color names, or internal color standards.',
    `compliance_status` STRING COMMENT 'Current compliance status of the material against regulatory and safety standards. Tracks whether material meets FTC labeling, CPSC safety, and restricted substance requirements.. Valid values are `compliant|non_compliant|pending_review|exempted`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the material is manufactured or sourced. Required for customs, duty calculations, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM line record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Enables multi-currency BOM costing and landed cost calculations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which this BOM line becomes active and valid for production. Supports BOM versioning and change management.',
    `expiration_date` DATE COMMENT 'Date after which this BOM line is no longer valid for production. Nullable for open-ended BOM lines. Supports phase-out of materials and BOM change control.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this BOM line calculated as quantity per unit multiplied by unit cost. Represents the material cost contribution to one finished unit.',
    `hs_code` STRING COMMENT 'International harmonized commodity code for the material. Used for customs classification, duty calculation, and international trade documentation.. Valid values are `^[0-9]{6,10}$`',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether this material is on the critical path for production. True if delays in this material would delay the entire production schedule.',
    `is_sustainable` BOOLEAN COMMENT 'Flag indicating whether the material meets sustainability criteria such as organic, recycled, or certified sustainable sourcing.',
    `lead_time_days` STRING COMMENT 'Number of days required to procure or source this material from the supplier. Critical for production planning and TNA calendar management.',
    `line_number` STRING COMMENT 'Sequential line number within the BOM header. Determines the ordering and sequence of materials in the bill of materials.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM line record was last modified. Tracks the most recent update for change tracking and audit purposes.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material. Impacts procurement planning and inventory management.',
    `notes` STRING COMMENT 'Free-form notes or comments about this BOM line. May include special instructions, sourcing notes, or technical specifications.',
    `placement_description` STRING COMMENT 'Textual description of where the material is used or placed on the garment. Examples: front panel, back yoke, sleeve cuff, center front zipper, care label at side seam.',
    `quantity_per_unit` DECIMAL(18,2) COMMENT 'Amount of material required to produce one finished unit of the parent product. Critical for material planning, costing, and procurement calculations.',
    `restricted_substance_tested` BOOLEAN COMMENT 'Flag indicating whether the material has been tested for restricted substances per OEKO-TEX or similar standards. Critical for product safety and regulatory compliance.',
    `size_specification` STRING COMMENT 'Size or dimension specification for the material component. Examples: button diameter, zipper length, label dimensions.',
    `supplier_material_reference` STRING COMMENT 'Suppliers own material code or reference number. Used for cross-referencing with vendor catalogs and purchase orders.',
    `sustainability_certification` STRING COMMENT 'Type of sustainability certification held by the material. Examples: GOTS for organic cotton, BCI for better cotton, OEKO-TEX for chemical safety, GRS for recycled content.. Valid values are `GOTS|BCI|OEKO-TEX|GRS|FSC|none`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for the material. Used for BOM costing, COGS calculation, and margin analysis. Business-confidential pricing data.',
    `unit_of_measure` STRING COMMENT 'Unit in which the material quantity is measured. Aligns with supplier ordering units and manufacturing consumption tracking. [ENUM-REF-CANDIDATE: meter|yard|kilogram|gram|piece|each|dozen|set — 8 candidates stripped; promote to reference product]',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Expected material waste or scrap percentage during manufacturing. Used to adjust material requirements for procurement and yield planning.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual line item within a Bill of Materials, representing a single material, fabric, trim, or component. Stores BOM line number, material type (shell fabric, lining, zipper, button, label, hang tag, packaging), material code, supplier material reference, unit of measure, quantity per unit, placement description, color specification, and unit cost. Enables granular costing, sourcing, and material compliance tracking at the component level.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`tech_pack` (
    `tech_pack_id` BIGINT COMMENT 'Unique identifier for the tech pack. Primary key. Inferred role: MASTER_RESOURCE (technical specification document for a style). This entity represents the comprehensive design, construction, fit, graded measurement, and dimensional specification document used to communicate all manufacturing and fit requirements to factories.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: Tech pack has bom_reference (STRING) which should be normalized to a FK to bom.bom_id. Tech packs and BOMs are tightly coupled in apparel product development - the tech pack defines construction and t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tech pack creation is a technical design activity with costs allocated to technical design cost centers. Essential for tracking pre-production labor costs and evaluating technical design department ef',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: Tech packs specify manufacturing routing for operation sequences, SAM calculations, and line balancing. Critical for factory issuance and production planning. No existing routing reference on tech_pac',
    `size_scale_id` BIGINT COMMENT 'Foreign key linking to product.size_scale. Business justification: Tech pack has size_range (STRING) and base_size (STRING) which should reference the size_scale master. Tech packs define grading rules and measurement specs that are based on a specific size scale. Th',
    `style_id` BIGINT COMMENT 'Reference to the parent style that this tech pack specifies. Links to the style master in the product domain.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Tech packs are physically issued to specific supplier factories for production. Sourcing and compliance teams track which factory received each tech pack version for IP control, factory qualification,',
    `approval_date` DATE COMMENT 'Date on which this tech pack version was approved for factory issuance. Key milestone in the product development timeline.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this tech pack version for issuance to factory. Tracks approval authority.',
    `base_size` STRING COMMENT 'The base size from which all grading is calculated. All measurements in this tech pack are specified for the base size, and grade rules define increments for other sizes.',
    `care_instructions` STRING COMMENT 'Garment care and maintenance instructions using ISO 3758 care symbols. Specifies washing, drying, ironing, bleaching, and dry cleaning requirements.',
    `construction_description` STRING COMMENT 'Detailed narrative description of garment construction methods, assembly sequence, and structural details. Communicates how the garment is built.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tech pack record was first created in the system. Audit trail for record creation.',
    `fabric_weight_gsm` DECIMAL(18,2) COMMENT 'Fabric weight in grams per square meter. Key specification for fabric quality and performance characteristics.',
    `fit_evaluation_criteria` STRING COMMENT 'Detailed criteria for evaluating fit during sample approval process. Defines acceptable fit characteristics, critical fit points, and pass/fail criteria for fit sessions.',
    `fit_model_reference` STRING COMMENT 'Identifier or name of the fit model used for sample evaluation and fit approval. Ensures consistency in fit assessment across samples.',
    `fit_type` STRING COMMENT 'Intended fit classification for the garment. Defines the silhouette and ease allowances in measurements.. Valid values are `slim|regular|relaxed|oversized|athletic|compression`',
    `gender` STRING COMMENT 'Gender classification for fit and sizing purposes. Determines applicable size ranges and fit standards.. Valid values are `mens|womens|unisex|kids_boys|kids_girls`',
    `grade_rules` STRING COMMENT 'Grading increment specifications defining how measurements change per size step. Specifies the dimensional increment (positive or negative) for each measurement point as sizes increase or decrease from the base size.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this tech pack version is currently active and in use. False indicates obsolete or superseded versions.',
    `issued_to_factory_date` DATE COMMENT 'Date on which this tech pack was officially issued to the manufacturing factory. Marks the start of factory production preparation.',
    `labeling_requirements` STRING COMMENT 'Comprehensive labeling requirements including content labels, care labels, brand labels, size labels, country of origin, and regulatory compliance labels per FTC Textile and Wool Acts.',
    `material_composition` STRING COMMENT 'Fiber content and material composition percentages for the primary fabric (e.g., 60% Cotton, 40% Polyester). Required for labeling compliance.',
    `measurement_points` STRING COMMENT 'Comprehensive list of all measurement points with descriptions and base size values. Includes body measurements (chest, waist, hip, inseam, sleeve length, etc.) and garment measurements (length, width, circumference at key points).',
    `measurement_unit` STRING COMMENT 'Unit of measure used for all dimensional measurements in this tech pack (centimeters or inches). Ensures consistency across all measurement points.. Valid values are `cm|inches`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tech pack record was last modified. Audit trail for record updates.',
    `product_category` STRING COMMENT 'High-level product category classification for this tech pack: apparel, footwear, or accessories.. Valid values are `apparel|footwear|accessories`',
    `product_type` STRING COMMENT 'Specific product type within the category (e.g., t-shirt, jacket, sneaker, handbag). Defines the construction and measurement requirements.',
    `revision_notes` STRING COMMENT 'Detailed notes describing changes made in this version compared to the previous version. Tracks evolution of specifications through the development cycle.',
    `sample_type` STRING COMMENT 'Type of sample this tech pack version supports: proto (initial prototype), fit (fit sample), PP (pre-production), SMS (sample management system sample), size-set (full size range sample), or production. Aligns with T&A calendar milestones. [ENUM-REF-CANDIDATE: proto|fit|pp|pre_production|sms|size_set|production — 7 candidates stripped; promote to reference product]',
    `seam_allowance_cm` DECIMAL(18,2) COMMENT 'Standard seam allowance measurement in centimeters. Defines the fabric margin beyond the seam line for construction.',
    `season_code` STRING COMMENT 'Season identifier for which this tech pack is designed (e.g., SS24, FW24). Links to merchandising season planning.',
    `special_instructions` STRING COMMENT 'Additional special instructions or notes for factory regarding unique construction techniques, quality requirements, or handling procedures.',
    `stitch_type` STRING COMMENT 'Primary stitch type(s) used in garment construction, using ISO 4915 stitch classification (e.g., 301 lockstitch, 504 overedge, 401 chainstitch).',
    `sustainability_notes` STRING COMMENT 'Notes regarding sustainable materials, ethical manufacturing requirements, or environmental compliance specifications (GOTS, OEKO-TEX, BCI, etc.).',
    `tech_pack_name` STRING COMMENT 'Human-readable name or title of the tech pack, typically including style name and season reference.',
    `tech_pack_number` STRING COMMENT 'The externally-known unique business identifier for this tech pack document. Used for communication with factories and internal teams. Managed in Centric PLM.',
    `tech_pack_status` STRING COMMENT 'Current lifecycle status of the tech pack document. Tracks progression from draft through approval to factory issuance.. Valid values are `draft|in_review|approved|issued_to_factory|revised|obsolete`',
    `tna_calendar_reference` STRING COMMENT 'Reference identifier linking this tech pack to its Time and Action calendar. TNA calendar tracks all critical milestones from design through production delivery.',
    `tolerance_range` STRING COMMENT 'Acceptable tolerance range for measurements, typically expressed as +/- value. Defines quality acceptance criteria for dimensional accuracy.',
    `version_number` STRING COMMENT 'Version identifier for this tech pack. Tech packs are versioned as they evolve through design iterations, sample approvals, and factory feedback cycles.',
    CONSTRAINT pk_tech_pack PRIMARY KEY(`tech_pack_id`)
) COMMENT 'Technical specification and fit package for a style — the single comprehensive design, construction, fit, graded measurement, and dimensional specification document used to communicate all manufacturing and fit requirements to factories. Captures tech pack version, construction details, stitch type, seam allowance, care instructions (ISO 3758 symbols), labeling requirements, base size measurements, grade rules (increment per size), measurement point descriptions (chest, waist, hip, inseam, sleeve length, etc.), tolerance ranges by measurement point, fit model reference, and fit evaluation criteria for sample approval (PP sample, pre-production, size-set). Managed in Centric PLM. Links to BOM and T&A calendar. SSOT for ALL dimensional, construction, grading, and fit specifications — no other product in this domain stores measurement or grading data.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`material` (
    `material_id` BIGINT COMMENT 'Unique identifier for the material record. Primary key for the material master data product.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Materials map to GL accounts for raw material inventory valuation and purchase price variance posting in apparel procurement. SAP MM/Oracle standard costing requires material-to-GL account mapping for',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Raw materials (fabrics, trims, components) are imported goods requiring HS classification for customs clearance and duty calculation. Material-level HS codes support accurate BOM costing and supplier ',
    `bci_certified` BOOLEAN COMMENT 'Indicates whether the cotton content is sourced through Better Cotton Initiative. True if certified, False otherwise.',
    `care_instructions` STRING COMMENT 'Recommended care and maintenance instructions for the material (e.g., Machine Wash Cold, Dry Clean Only, Do Not Bleach). Used for product labeling and consumer guidance.',
    `color_code` STRING COMMENT 'Standardized color reference code (e.g., Pantone TPX, supplier color code) for precise color matching and quality control.. Valid values are `^[A-Z0-9-]{4,15}$`',
    `color_name` STRING COMMENT 'Marketing or descriptive name of the material color (e.g., Navy Blazer, Sunset Orange, Natural Undyed).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_unit_of_measure` STRING COMMENT 'Unit of measure for the standard cost (meter, yard, kilogram, piece, roll, unit).. Valid values are `meter|yard|kilogram|piece|roll|unit`',
    `cotton_percentage` DECIMAL(18,2) COMMENT 'Percentage of cotton fiber in the material composition. Used for sustainability reporting and sourcing decisions.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the material is manufactured or sourced. Required for customs, duty calculation, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_date` DATE COMMENT 'Date when the material record was first created in the system. Used for audit trail and material lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date after which this material is no longer available for new product development. Nullable for materials with indefinite availability.',
    `effective_start_date` DATE COMMENT 'Date from which this material is available for use in product development and sourcing. Supports time-based material availability.',
    `fiber_composition` STRING COMMENT 'Detailed breakdown of fiber content by percentage (e.g., 100% Organic Cotton, 60% Cotton 40% Polyester, 100% Full Grain Leather). Required for labeling compliance.',
    `finish_treatment` STRING COMMENT 'Description of any chemical or mechanical finish applied to the material (e.g., Water Repellent, Anti-Microbial, Enzyme Wash, Brushed, Calendered).',
    `gots_certified` BOOLEAN COMMENT 'Indicates whether the material is certified under Global Organic Textile Standard. True if certified, False otherwise.',
    `last_modified_date` DATE COMMENT 'Date when the material record was last updated. Used for change tracking and data governance.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from order placement to material receipt. Used for production planning and inventory management.',
    `material_category` STRING COMMENT 'High-level grouping of the material for procurement and inventory purposes (fabric, trim, accessory, component, packaging).. Valid values are `fabric|trim|accessory|component|packaging`',
    `material_code` STRING COMMENT 'Externally-known unique alphanumeric code for the material used across PLM, sourcing, and manufacturing systems. Business identifier for material lookup and BOM references.. Valid values are `^[A-Z0-9]{8,20}$`',
    `material_description` STRING COMMENT 'Detailed textual description of the material including construction, hand feel, performance characteristics, and intended use. Supports design and sourcing decisions.',
    `material_name` STRING COMMENT 'Human-readable name of the material (e.g., Organic Cotton Jersey, Italian Leather, YKK Zipper).',
    `material_status` STRING COMMENT 'Current lifecycle status of the material (active, inactive, discontinued, pending_approval, restricted, obsolete). Controls availability for new product development and sourcing.. Valid values are `active|inactive|discontinued|pending_approval|restricted|obsolete`',
    `material_type` STRING COMMENT 'Classification of the material by construction or category (woven fabric, knit fabric, leather, synthetic, trim, hardware, packaging, label, thread, elastic). [ENUM-REF-CANDIDATE: woven|knit|leather|synthetic|trim|hardware|packaging|label|thread|elastic — 10 candidates stripped; promote to reference product]',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this material. Critical for procurement planning and cost optimization.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (meter, yard, kilogram, piece, roll, unit).. Valid values are `meter|yard|kilogram|piece|roll|unit`',
    `oeko_tex_certified` BOOLEAN COMMENT 'Indicates whether the material is certified under OEKO-TEX Standard 100 for harmful substance testing. True if certified, False otherwise.',
    `polyester_percentage` DECIMAL(18,2) COMMENT 'Percentage of polyester fiber in the material composition. Tracked for performance characteristics and sustainability metrics.',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of recycled material content (post-consumer or post-industrial). Critical for sustainability goals and eco-labeling.',
    `restricted_substance_compliant` BOOLEAN COMMENT 'Indicates whether the material complies with restricted substance lists (e.g., REACH, California Prop 65, CPSIA). True if compliant, False otherwise.',
    `season_code` STRING COMMENT 'Season or collection code for which this material was developed or is primarily used (e.g., SS24, FW24, HOLIDAY23).. Valid values are `^[A-Z0-9]{2,10}$`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the material in the base currency. Used for costing, budgeting, and Bill of Materials (BOM) calculations.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the material to maintain quality (e.g., Store in cool, dry place, Avoid direct sunlight, Temperature controlled).',
    `supplier_material_code` STRING COMMENT 'Material code or reference number used by the supplier. Facilitates cross-referencing and order accuracy.',
    `sustainability_certification` STRING COMMENT 'Comma-separated list of sustainability certifications held by the material (e.g., GOTS, OEKO-TEX Standard 100, BCI, GRS, Bluesign). Critical for brand sustainability commitments and consumer transparency.',
    `test_report_reference` STRING COMMENT 'Reference number or identifier for quality and compliance test reports (e.g., lab test reports, certification documents). Links to external document management systems.',
    `weight_gsm` DECIMAL(18,2) COMMENT 'Weight of the material measured in grams per square meter. Key specification for fabric performance, drape, and costing.',
    `width_cm` DECIMAL(18,2) COMMENT 'Usable width of the material in centimeters. Used for yield calculations and cutting room planning.',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master record for all raw materials, fabrics, and trims used in product manufacturing. Stores material code, material name, material type (woven, knit, leather, synthetic, trim), fiber composition (cotton %, polyester %, etc.), weight (GSM), width, finish, sustainability certifications (GOTS, OEKO-TEX, BCI), country of origin, HS code, and approved supplier list. SSOT for material identity referenced by BOM lines and sourcing. Managed in Infor PLM material library.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`sample` (
    `sample_id` BIGINT COMMENT 'Unique identifier for the product sample record. Primary key.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: Product sample has bom_version (STRING) which should be normalized to a FK to bom.bom_id. Samples are produced according to a specific BOM version for material and construction validation. This normal',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Sample tracks physical product samples throughout the design-to-production lifecycle. Currently has colorway as STRING but no FK to the colorway master entity. Samples are physical instances of a spec',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sample development costs (materials, labor, shipping) are allocated to design or product development cost centers. Critical for tracking pre-production expenses, managing sample budgets, and calculati',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Sample costs are posted to specific GL accounts (product development expense) separate from production COGS in apparel. Finance teams track sample expenditure by GL account for design budget control a',
    `season_id` BIGINT COMMENT 'Reference to the season or collection this sample belongs to.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Physical samples are shipped internationally from factories to design/merchandising teams for fit approval, quality review, and line reviews. Tracking sample shipments is critical for development time',
    `size_scale_id` BIGINT COMMENT 'Foreign key linking to product.size_scale. Business justification: A product sample is produced in a specific size within a defined size scale (e.g., a proto sample made in size M of the XS-XXL scale, or a fit sample in size 32 of the 28-40 waist scale). prod',
    `style_id` BIGINT COMMENT 'Reference to the parent style that this sample represents.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Proto, fit, and PP samples are physically produced at a specific supplier factory. Sample approval workflows and factory qualification processes require knowing which supplier factory made each sample',
    `tech_pack_id` BIGINT COMMENT 'Foreign key linking to product.tech_pack. Business justification: Product sample has tech_pack_version (STRING) which should be normalized to a FK to tech_pack.tech_pack_id. Samples are produced according to a specific tech pack version for fit and construction vali',
    `actual_delivery_date` DATE COMMENT 'Actual date when the sample was received, used to track OTIF (On Time In Full) performance.',
    `approved_date` DATE COMMENT 'Date when the sample received final approval for progression to next stage or production.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred to produce this sample, including materials, labor, and shipping.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the sample cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fit_comments` STRING COMMENT 'Detailed feedback and observations from the fit evaluation session, including specific adjustments needed.',
    `fit_evaluation_result` STRING COMMENT 'Outcome of the fit evaluation process for fit samples, determining if the sample meets graded measurement specifications.. Valid values are `pass|fail|conditional|not_evaluated`',
    `iteration_number` STRING COMMENT 'Sequential iteration number tracking how many times this sample has been revised or resubmitted (e.g., 1st sample, 2nd sample, 3rd sample).',
    `location` STRING COMMENT 'Current physical location or storage area where the sample is kept (e.g., design studio, sample room, warehouse).',
    `material_composition` STRING COMMENT 'Detailed description of the fabric and material composition used in the sample (e.g., 60% Cotton, 40% Polyester), required for labeling compliance.',
    `measurement_chest_cm` DECIMAL(18,2) COMMENT 'Graded measurement specification for chest circumference in centimeters, critical for fit evaluation.',
    `measurement_hip_cm` DECIMAL(18,2) COMMENT 'Graded measurement specification for hip circumference in centimeters, critical for fit evaluation.',
    `measurement_length_cm` DECIMAL(18,2) COMMENT 'Graded measurement specification for garment length in centimeters (e.g., center back length, inseam), critical for fit evaluation.',
    `measurement_waist_cm` DECIMAL(18,2) COMMENT 'Graded measurement specification for waist circumference in centimeters, critical for fit evaluation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was last modified or updated.',
    `notes` STRING COMMENT 'General notes and observations about the sample, including design feedback, production challenges, or special instructions.',
    `photo_url` STRING COMMENT 'URL or file path to digital photographs of the sample for visual reference and documentation.',
    `quality_defects` STRING COMMENT 'Detailed description of any quality defects identified during inspection, including severity and location.',
    `quality_inspection_result` STRING COMMENT 'Outcome of the quality inspection process evaluating construction, stitching, finishing, and overall workmanship.. Valid values are `pass|fail|conditional`',
    `requested_date` DATE COMMENT 'Date when the sample was requested from the factory or design team.',
    `sample_code` STRING COMMENT 'Unique business identifier for the sample used across PLM and production systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the approval and evaluation workflow. [ENUM-REF-CANDIDATE: requested|in_development|submitted|approved|rejected|on_hold|archived — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample based on its purpose in the design-to-production lifecycle. Proto samples are initial design prototypes, fit samples are used for fit evaluation, salesman samples are for sales presentations, production samples validate final manufacturing, pre-production samples (PP) verify production readiness, and SMS (Sample Management System) samples are tracked through the sample management system.. Valid values are `proto|fit|salesman|production|pre_production|sms`',
    `size` STRING COMMENT 'The size specification of the sample garment (e.g., S, M, L, XL, or numeric sizing).',
    `submitted_date` DATE COMMENT 'Date when the sample was submitted for review and approval.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical certifications applicable to this sample (e.g., GOTS, BCI, OEKO-TEX, Fair Trade), supporting responsible sourcing initiatives.',
    `target_delivery_date` DATE COMMENT 'Expected date for sample delivery based on TNA (Time and Action) calendar milestones.',
    `wash_test_completed` BOOLEAN COMMENT 'Indicates whether the sample has undergone wash testing to evaluate colorfastness, shrinkage, and durability.',
    `wash_test_result` STRING COMMENT 'Outcome of wash testing evaluation for colorfastness, shrinkage, and fabric integrity.. Valid values are `pass|fail|not_tested`',
    `weight_grams` DECIMAL(18,2) COMMENT 'Physical weight of the sample garment in grams, used for shipping calculations and product specifications.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Tracks physical product samples throughout the design-to-production lifecycle including proto samples, fit samples, salesman samples, and production samples. Includes graded measurement specifications and fit evaluation data for each sample iteration.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`collection` (
    `collection_id` BIGINT COMMENT 'Unique identifier for the collection. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Collection has brand_code (STRING) which should be normalized to a FK to brand.brand_id. Collections are brand-specific in apparel fashion (e.g., Nike Spring 2024, Adidas Originals Fall 2024). This no',
    `category_id` BIGINT COMMENT 'FK to product.product_category',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Collections are launched by specific legal entities in multi-brand apparel groups, determining OTB budget ownership, currency, and statutory reporting entity. Company code on collection is required fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Collection development costs (design, merchandising, planning) are allocated to merchandising or design cost centers. Essential for tracking collection development expenses and evaluating departmental',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Exclusive wholesale collections (e.g., a Target-exclusive capsule, Nordstrom-exclusive collaboration) are a core apparel wholesale business model. Merchandising and sales teams need to track which who',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Collections map to GL accounts for seasonal revenue and OTB budget tracking. Apparel finance teams report P&L by collection; this FK enables direct GL posting for collection-level financial performanc',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Collections are planned and reported by profit center (brand/channel/region). Critical for P&L reporting by collection, margin analysis, and strategic investment decisions in multi-brand or multi-chan',
    `season_id` BIGINT COMMENT 'FK to merchandising.season',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Collections are planned with explicit target customer segments for marketing campaigns and channel strategies. Seasonal line reviews, OTB planning, and campaign briefs all reference the target segment',
    `actual_launch_date` DATE COMMENT 'Actual date when the collection was made available for sale or distribution.',
    `approved_by` STRING COMMENT 'User identifier who approved the collection for commercialization.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection was approved for commercialization.',
    `average_unit_retail` DECIMAL(18,2) COMMENT 'Average retail price per unit across all SKUs in the collection. Confidential pricing information.',
    `collaboration_partner` STRING COMMENT 'Name of external partner or designer for collaboration collections (e.g., celebrity, artist, brand partnership).',
    `collection_code` STRING COMMENT 'Externally-known unique business identifier for the collection used across PLM, merchandising, and retail systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `collection_name` STRING COMMENT 'Human-readable name of the collection for marketing and merchandising purposes.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the collection: Planning (concept phase), Design (creative development), Development (pre-production), Commercialized (ready for market), Active (in-market), Closed (end of lifecycle), or Cancelled. [ENUM-REF-CANDIDATE: PLANNING|DESIGN|DEVELOPMENT|COMMERCIALIZED|ACTIVE|CLOSED|CANCELLED — 7 candidates stripped; promote to reference product]',
    `collection_type` STRING COMMENT 'Classification of the collection: Core (evergreen), Capsule (focused drop), Collaboration (designer partnership), Limited Edition, or Seasonal.. Valid values are `CORE|CAPSULE|COLLABORATION|LIMITED_EDITION|SEASONAL`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection record was first created in the system.',
    `creative_direction_notes` STRING COMMENT 'Detailed creative direction, design inspiration, and aesthetic guidance for the collection. Confidential business information.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for collection pricing (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `end_of_life_date` DATE COMMENT 'Date when the collection is planned to be discontinued or phased out from active selling.',
    `gender_target` STRING COMMENT 'Target gender demographic for the collection: Mens, Womens, Unisex, Kids, or Youth.. Valid values are `MENS|WOMENS|UNISEX|KIDS|YOUTH`',
    `geographic_market` STRING COMMENT 'Primary geographic market or region for which the collection is designed (e.g., North America, Europe, Asia Pacific).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the collection is currently active and available for business operations.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified the collection record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection record was last modified.',
    `merchandising_system_code` STRING COMMENT 'Unique identifier for the collection in the Oracle Retail Merchandising System.',
    `otb_budget_amount` DECIMAL(18,2) COMMENT 'Open-to-Buy budget allocated for the collection, representing planned inventory investment. Confidential financial data.',
    `planned_launch_date` DATE COMMENT 'Planned date for the collection to be available for sale or distribution.',
    `planning_system_code` STRING COMMENT 'Unique identifier for the collection in the Anaplan merchandise planning system.',
    `plm_system_code` STRING COMMENT 'Unique identifier for the collection in the source PLM system (Centric PLM or Infor PLM).',
    `price_tier` STRING COMMENT 'Price positioning tier for the collection: Entry, Mid, Premium, or Luxury.. Valid values are `ENTRY|MID|PREMIUM|LUXURY`',
    `season_year` STRING COMMENT 'Calendar year for which the collection is designed and launched.',
    `sustainability_certification_type` STRING COMMENT 'Type of sustainability certification achieved by the collection (e.g., GOTS, OEKO-TEX, BCI, Bluesign, Cradle to Cradle, Fair Trade, Organic Content, Recycled Content). [ENUM-REF-CANDIDATE: GOTS|OEKO-TEX|BCI|BLUESIGN|CRADLE_TO_CRADLE|FAIR_TRADE|ORGANIC_CONTENT|RECYCLED_CONTENT — promote to reference product]',
    `sustainability_certified` BOOLEAN COMMENT 'Indicates whether the collection has achieved sustainability certification (e.g., GOTS, OEKO-TEX, BCI).',
    `target_channel` STRING COMMENT 'Primary sales channel for which the collection is designed: Direct-to-Consumer (DTC), Wholesale, Retail, E-Commerce, Outlet, or Department Store.. Valid values are `DTC|WHOLESALE|RETAIL|ECOMMERCE|OUTLET|DEPARTMENT_STORE`',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for the collection, used in merchandise financial planning. Confidential financial metric.',
    `theme` STRING COMMENT 'Creative theme or inspiration for the collection, used for marketing and merchandising storytelling.',
    `total_sku_count` STRING COMMENT 'Total number of SKUs (style-color-size combinations) in the collection.',
    `total_style_count` STRING COMMENT 'Total number of unique styles included in the collection.',
    CONSTRAINT pk_collection PRIMARY KEY(`collection_id`)
) COMMENT 'Defines a seasonal or thematic product collection grouping styles for a specific season, brand, and channel. Captures collection code, collection name, season (SS, FW, Resort, Pre-Fall), year, brand, target channel (DTC, wholesale, retail), launch date, theme, creative direction notes, total style count, and collection status (planning, design, commercialized, closed). Managed in Centric PLM and Anaplan collection planning. Links to merchandising OTB plans.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`msrp_price` (
    `msrp_price_id` BIGINT COMMENT 'Unique identifier for the MSRP price record. Primary key for the MSRP price entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: MSRP prices are legal-entity-specific in multi-country apparel groups due to VAT, transfer pricing, and local market regulations. Company code on msrp_price ensures correct currency, tax treatment, an',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Segment-specific pricing is standard in apparel — loyalty member pricing, student pricing, and VIP segment pricing are distinct MSRP strategies. Price management teams create segment-differentiated pr',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which this MSRP price is defined. Links to the product SKU master.',
    `style_id` BIGINT COMMENT 'Reference to the style for which this MSRP price is defined. Used when pricing is set at style level rather than SKU level.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the MSRP price record. Tracks the price through the approval process before activation.. Valid values are `draft|pending_approval|approved|rejected|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this MSRP price was approved. Part of the approval workflow audit trail.',
    `aur_target` DECIMAL(18,2) COMMENT 'The target average unit retail price expected to be achieved after markdowns and promotions. Used for financial planning and Open-to-Buy (OTB) calculations.',
    `channel_applicability` STRING COMMENT 'Indicates which sales channels this MSRP applies to: Direct-to-Consumer (DTC), wholesale, retail stores, or e-commerce. Supports multi-channel pricing strategies.. Valid values are `all|dtc|wholesale|retail|ecommerce`',
    `competitor_benchmark_price` DECIMAL(18,2) COMMENT 'Reference price from competitor analysis used to inform MSRP positioning. Supports competitive pricing strategy and market positioning.',
    `cost_basis` DECIMAL(18,2) COMMENT 'The cost of goods sold (COGS) or landed cost used as the basis for calculating the initial markup percentage. Business-confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this MSRP price record was first created in the system. Part of the record lifecycle audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP amount (e.g., USD, EUR, GBP, CNY, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this MSRP price expires and is no longer valid. Null indicates an open-ended price with no planned expiration.',
    `effective_start_date` DATE COMMENT 'The date from which this MSRP price becomes active and valid for use in pricing and merchandising systems.',
    `imu_percentage` DECIMAL(18,2) COMMENT 'The initial markup percentage calculated as the difference between MSRP and cost, expressed as a percentage of MSRP. Key metric for profitability planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this MSRP price record was last updated. Part of the record lifecycle audit trail.',
    `market_code` STRING COMMENT 'Three-letter ISO country code representing the market or region where this MSRP applies (e.g., USA, CAN, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `minimum_advertised_price` DECIMAL(18,2) COMMENT 'The minimum price at which retailers are allowed to advertise this product. Used to protect brand positioning and prevent price erosion in wholesale channels.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The suggested retail price amount set by the manufacturer for this SKU or style in the specified market and currency. This is the recommended selling price to consumers.',
    `notes` STRING COMMENT 'Free-text notes or comments about this MSRP price record. Used for documenting special pricing considerations, exceptions, or business context.',
    `price_change_reason` STRING COMMENT 'The business reason for creating or updating this MSRP record. Supports price change audit trail and analysis. [ENUM-REF-CANDIDATE: new_product|cost_change|market_adjustment|competitive_response|seasonal|promotional|correction — 7 candidates stripped; promote to reference product]',
    `price_point_strategy` STRING COMMENT 'The pricing strategy classification for this MSRP: penetration (low to gain share), premium (high for exclusivity), competitive (market-aligned), value (cost-plus), or psychological (charm pricing).. Valid values are `penetration|premium|competitive|value|psychological`',
    `price_tier` STRING COMMENT 'Classification of the product price positioning within the assortment (good/better/best framework). Used for merchandising and assortment planning.. Valid values are `good|better|best|premium|luxury|entry`',
    `price_zone` STRING COMMENT 'Geographic or market-based pricing zone code used for regional price differentiation within a country or market. Supports localized pricing strategies.. Valid values are `^[A-Z0-9]{1,10}$`',
    `recommended_markdown_percentage` DECIMAL(18,2) COMMENT 'Suggested markdown percentage for promotional or clearance pricing. Used for planning maintained markup (MMU) and sell-through rate (STR) targets.',
    `season_code` STRING COMMENT 'Code representing the fashion season or collection period for which this MSRP is set (e.g., SS24, FW24, HOLIDAY24). Links pricing to merchandising calendar.. Valid values are `^[A-Z0-9]{2,10}$`',
    `source_record_reference` STRING COMMENT 'The unique identifier of this MSRP price record in the source system. Used for data lineage and reconciliation.',
    `source_system` STRING COMMENT 'The operational system of record from which this MSRP price originated (Oracle Retail Price Management, SAP S/4HANA SD, Centric PLM, manual entry, or Anaplan).. Valid values are `oracle_retail|sap_sd|centric_plm|manual|anaplan`',
    `vat_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the MSRP amount includes VAT or other consumption taxes. True if tax-inclusive, false if tax-exclusive.',
    `wholesale_price` DECIMAL(18,2) COMMENT 'The price at which the product is sold to wholesale partners or distributors. Typically lower than MSRP to allow retailer margin. Business-confidential.',
    CONSTRAINT pk_msrp_price PRIMARY KEY(`msrp_price_id`)
) COMMENT 'Manufacturers Suggested Retail Price record for a SKU or style by market, currency, and effective date range. Stores MSRP amount, currency code, market/region, price tier (good/better/best), effective start and end dates, initial markup (IMU) percentage, average unit retail (AUR) target, and price approval status. Supports multi-currency and multi-market pricing for DTC, wholesale, and retail channels. Managed in Oracle Retail Price Management and SAP S/4HANA SD. SSOT for product-level suggested pricing; actual selling prices and markdowns are owned by the merchandising domain.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` (
    `cost_sheet_id` BIGINT COMMENT 'Unique identifier for the cost sheet record. Primary key.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: A cost sheet in apparel is derived from or validated against a Bill of Materials — the BOM defines the material quantities and unit costs that feed into the cost sheets fabric_cost, material_cost, an',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cost sheets are prepared per legal entity in multi-entity apparel groups, determining currency, tax jurisdiction, and transfer pricing treatment. Company code on cost_sheet is required for correct sta',
    `duty_calculation_id` BIGINT COMMENT 'Foreign key linking to logistics.duty_calculation. Business justification: Cost sheets incorporate estimated landed duty costs during product development. Linking to actual duty calculations enables variance analysis between estimated and actual duty, improving costing accur',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost sheets drive GL account determination for COGS, freight, duty, and overhead postings in apparel costing. Finance teams use cost sheet GL mapping to ensure correct account assignment when cost she',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Multi-GAAP apparel groups maintain parallel cost sheets per accounting ledger (IFRS vs local GAAP). Linking cost_sheet to ledger enables correct valuation method application and parallel accounting fo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cost sheets are prepared for specific profit center contexts (market/channel pricing strategies). Essential for calculating landed costs and target margins by segment, supporting pricing decisions in ',
    `season_id` BIGINT COMMENT 'Reference to the season or collection for which this cost sheet applies.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) if cost sheet is SKU-level rather than style-level.',
    `style_id` BIGINT COMMENT 'Reference to the style or product design for which this cost sheet is prepared.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Cost sheets in apparel are negotiated at factory level — CMT and labor costs vary by factory. Sourcing teams compare factory-level cost sheets for vendor selection and margin analysis. The existing pr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Cost sheets are negotiated with a vendor legal entity for payment terms, currency, and vendor performance reporting. Finance and sourcing teams need vendor-level cost sheet aggregation for spend analy',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Cost sheets in apparel are frequently prepared per wholesale account because each account has negotiated incoterms, payment terms, and destination-specific duty rates. Finance and sales ops teams gene',
    `actual_cogs` DECIMAL(18,2) COMMENT 'Actual Cost of Goods Sold realized after production and delivery, used for financial reporting and variance analysis.',
    `approved_date` DATE COMMENT 'Date when the cost sheet was officially approved for use in production planning and financial forecasting.',
    `cmt_cost` DECIMAL(18,2) COMMENT 'Cut, Make, and Trim cost representing the labor and manufacturing service charges for cutting fabric, assembling garment, and finishing operations.',
    `cost_sheet_number` STRING COMMENT 'Business identifier or document number for the cost sheet, used for external reference and tracking.',
    `cost_sheet_status` STRING COMMENT 'Current approval and workflow status of the cost sheet within the PLM and costing approval process.. Valid values are `draft|submitted|under_review|approved|rejected|obsolete`',
    `costing_stage` STRING COMMENT 'Stage in the costing lifecycle indicating the maturity and accuracy of the cost data (e.g., initial estimate during design, final costing before production, actual costing post-production).. Valid values are `initial_estimate|preliminary_costing|final_costing|actual_costing|revised_costing`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing the country where the product is manufactured, used for customs and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all cost amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `destination_country` STRING COMMENT 'Three-letter ISO country code representing the destination market or country of import for this cost sheet.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which this cost sheet becomes effective and applicable for production orders and financial planning.',
    `expiration_date` DATE COMMENT 'Date when this cost sheet expires and is no longer valid, typically due to material cost changes or new negotiations.',
    `fabric_cost` DECIMAL(18,2) COMMENT 'Cost of fabric materials used in the garment or product, subset of total material cost.',
    `fob_cost` DECIMAL(18,2) COMMENT 'Free On Board cost representing the total cost of the product at the port of origin, including manufacturing and local logistics but excluding international freight and duties.',
    `freight_cost` DECIMAL(18,2) COMMENT 'International freight and shipping cost from origin port to destination port or warehouse.',
    `hs_code` STRING COMMENT 'Harmonized System code used for international trade classification and customs duty determination.',
    `imu_percent` DECIMAL(18,2) COMMENT 'Initial Markup percentage calculated as (MSRP - COGS) / MSRP, representing the planned gross margin at initial retail price.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities and costs between buyer and seller for shipping and delivery. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `labor_cost` DECIMAL(18,2) COMMENT 'Direct labor cost for manufacturing operations, may overlap with or be part of CMT cost depending on costing methodology.',
    `ldp_cost` DECIMAL(18,2) COMMENT 'Landed Duty Paid cost representing the total delivered cost including FOB, freight, duties, and all logistics costs to the destination warehouse.',
    `lead_time_days` STRING COMMENT 'Production lead time in days from order placement to delivery, associated with this cost sheet.',
    `material_cost` DECIMAL(18,2) COMMENT 'Total cost of all raw materials including fabrics, trims, accessories, and packaging materials used in the product.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost sheet record was last modified or updated.',
    `moq` STRING COMMENT 'Minimum Order Quantity required by the factory or supplier for this cost sheet to be valid.',
    `msrp` DECIMAL(18,2) COMMENT 'Manufacturers Suggested Retail Price for the product, used to calculate Initial Markup (IMU) and margin targets.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the cost sheet, including assumptions, special conditions, or variance explanations.',
    `overhead_cost` DECIMAL(18,2) COMMENT 'Manufacturing overhead and indirect costs allocated to the product including factory utilities, supervision, and facility costs.',
    `packaging_cost` DECIMAL(18,2) COMMENT 'Cost of packaging materials including polybags, hangtags, cartons, and shipping materials.',
    `payment_terms` STRING COMMENT 'Payment terms negotiated with the factory or supplier (e.g., Net 30, Net 60, Letter of Credit).',
    `target_cogs` DECIMAL(18,2) COMMENT 'Target Cost of Goods Sold established by merchandising and finance teams to achieve desired margin objectives.',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage established by merchandising and finance for this product or style.',
    `trim_cost` DECIMAL(18,2) COMMENT 'Cost of trims and accessories such as buttons, zippers, labels, threads, and embellishments.',
    `version` STRING COMMENT 'Version number or identifier for the cost sheet, allowing tracking of revisions and updates over time.',
    `wholesale_price` DECIMAL(18,2) COMMENT 'Wholesale selling price to retail partners and distributors, distinct from MSRP and used for B2B channel pricing.',
    CONSTRAINT pk_cost_sheet PRIMARY KEY(`cost_sheet_id`)
) COMMENT 'Detailed product costing record capturing all cost components for a style or SKU including FOB cost, CMT cost (cut, make, trim), material cost, duty rate, freight cost, LDP (Landed Duty Paid) cost, and target COGS. Tracks cost version, costing stage (initial estimate, final costing, actual), season, and cost approval status. Enables IMU and MMU calculation. Managed in Infor PLM costing module and SAP S/4HANA CO.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`product`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Brands in apparel groups are owned by specific legal entities (company codes) for IP ownership, royalty accounting, and brand P&L statutory reporting. This FK is fundamental for brand-level financial ',
    `parent_brand_id` BIGINT COMMENT 'Reference to the parent brand if this is a sub-brand or brand extension. Null for standalone brands.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand-level profit center assignment is standard in apparel for brand P&L reporting, marketing spend allocation, and management accounting. Every apparel finance team tracks revenue and costs by brand',
    `brand_code` STRING COMMENT 'Short alphanumeric code used internally to identify the brand in systems, SKUs, and reporting. Typically 2-10 uppercase characters.',
    `brand_description` STRING COMMENT 'Detailed narrative description of the brands identity, heritage, values, and market positioning used for internal reference and external marketing.',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears on products, marketing materials, and legal documents.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand indicating whether it is actively marketed, discontinued, or in transition.',
    `classification` STRING COMMENT 'Primary market classification of the brand indicating its positioning and target segment within the apparel and fashion industry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'The date when the brand was officially discontinued or retired from active marketing and sales. Null for active brands.',
    `founding_year` STRING COMMENT 'The year the brand was established or founded, used for heritage marketing and brand storytelling.',
    `launch_date` DATE COMMENT 'The date when the brand was officially launched to the market or introduced to consumers.',
    `license_end_date` DATE COMMENT 'The date when the brand license agreement expires or is set to be renewed. Null for perpetual or owned brands.',
    `license_start_date` DATE COMMENT 'The date when the brand license agreement became effective. Applicable only for licensed brands.',
    `license_type` STRING COMMENT 'Indicates the ownership and licensing model for the brand (owned outright, licensed from another entity, licensed to partners, or joint venture).',
    `licensor_name` STRING COMMENT 'Name of the entity that owns the brand intellectual property if the brand is licensed in. Null for owned brands.',
    `logo_url` STRING COMMENT 'URL or file path to the official brand logo image file used in digital and print materials.',
    `manager_email` STRING COMMENT 'Email address of the brand manager for internal communication and coordination.',
    `manager_name` STRING COMMENT 'Name of the individual responsible for managing the brand strategy, marketing, and performance.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the brand was founded or is headquartered.',
    `product_categories` STRING COMMENT 'Comma-separated list of primary product categories the brand offers (e.g., footwear, apparel, accessories, equipment).',
    `social_media_handles` STRING COMMENT 'JSON or comma-separated string containing the brands official social media account handles across platforms (Instagram, Facebook, Twitter, TikTok, etc.).',
    `sustainability_certifications` STRING COMMENT 'Comma-separated list of sustainability and ethical certifications the brand has achieved (e.g., B Corp, Fair Trade Certified, GOTS, OEKO-TEX, bluesign).',
    `sustainability_certified` BOOLEAN COMMENT 'Indicates whether the brand holds recognized sustainability certifications (e.g., B Corp, Fair Trade, GOTS, bluesign).',
    `tagline` STRING COMMENT 'Official marketing tagline or slogan associated with the brand, used in advertising and promotional materials.',
    `target_age_range` STRING COMMENT 'Primary age demographic range the brand targets, expressed as a range or category (e.g., 18-35, youth, mature).',
    `target_gender` STRING COMMENT 'Primary gender demographic the brand targets with its product offerings.',
    `tier` STRING COMMENT 'Price and quality positioning tier of the brand within the portfolio, used for merchandising and pricing strategy.',
    `trademark_registration_country` STRING COMMENT 'Three-letter ISO country code representing the primary jurisdiction where the brand trademark is registered.',
    `trademark_registration_number` STRING COMMENT 'Official trademark registration number issued by the relevant intellectual property office for the brand name and logo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was last modified or updated in the system.',
    `website_url` STRING COMMENT 'Official website URL for the brands primary digital presence and e-commerce platform.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ADD CONSTRAINT `fk_product_size_scale_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ADD CONSTRAINT `fk_product_sample_tech_pack_id` FOREIGN KEY (`tech_pack_id`) REFERENCES `apparel_fashion_ecm`.`product`.`tech_pack`(`tech_pack_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `design_owner` SET TAGS ('dbx_business_glossary_term' = 'Design Owner');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|youth|kids|infant');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `is_core_style` SET TAGS ('dbx_business_glossary_term' = 'Core Style Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Style Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `msrp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'athletic|lifestyle|luxury|performance|casual|formal');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA|HO)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `silhouette` SET TAGS ('dbx_business_glossary_term' = 'Silhouette');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `style_description` SET TAGS ('dbx_business_glossary_term' = 'Style Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `style_name` SET TAGS ('dbx_business_glossary_term' = 'Style Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `style_number` SET TAGS ('dbx_business_glossary_term' = 'Style Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `style_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `tech_pack_reference` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Price');
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'adult|youth|toddler|infant');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `color_family` SET TAGS ('dbx_business_glossary_term' = 'Color Family');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `color_standard` SET TAGS ('dbx_business_glossary_term' = 'Color Standard');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `color_standard` SET TAGS ('dbx_value_regex' = 'Pantone|NCS|RAL|CMYK|RGB|HEX');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `color_story` SET TAGS ('dbx_business_glossary_term' = 'Color Story');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_name` SET TAGS ('dbx_business_glossary_term' = 'Colorway Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_status` SET TAGS ('dbx_business_glossary_term' = 'Colorway Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `colorway_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|carry-over|pending|archived');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `exclusivity_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `finish_type` SET TAGS ('dbx_business_glossary_term' = 'Finish Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `finish_type` SET TAGS ('dbx_value_regex' = 'matte|glossy|metallic|satin|textured|embossed');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|boys|girls|infant');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `hex_color_code` SET TAGS ('dbx_business_glossary_term' = 'Hexadecimal (HEX) Color Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `hex_color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `is_limited_edition` SET TAGS ('dbx_business_glossary_term' = 'Limited Edition Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `oracle_retail_item_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Retail Item Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `pantone_code` SET TAGS ('dbx_business_glossary_term' = 'Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `pantone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9s-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `primary_color` SET TAGS ('dbx_business_glossary_term' = 'Primary Color');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `print_pattern` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `swatch_image_url` SET TAGS ('dbx_business_glossary_term' = 'Swatch Image Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `tertiary_color` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Color');
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'adult|youth|toddler|infant');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `ats_flag` SET TAGS ('dbx_business_glossary_term' = 'Available to Sell (ATS) Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `color_name` SET TAGS ('dbx_business_glossary_term' = 'Color Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|boys|girls|infant');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gsp_eligible` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `imu_percent` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `imu_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `nos_flag` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `rfid_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `rfid_tag_reference` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{24}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `size_run_position` SET TAGS ('dbx_business_glossary_term' = 'Size Run Position');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|seasonal');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Price');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `brand_applicability` SET TAGS ('dbx_business_glossary_term' = 'Brand Applicability');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `conversion_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Conversion Table Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `default_for_category` SET TAGS ('dbx_business_glossary_term' = 'Default for Category Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `erp_system_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `fit_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Fit Model Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `grading_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Grading Rule Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `measurement_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement System');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'inches|centimeters|waist_inseam|chest_length|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `regional_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Market');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `regional_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(,[A-Z]{3})*$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_chart_url` SET TAGS ('dbx_business_glossary_term' = 'Size Chart Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_count` SET TAGS ('dbx_business_glossary_term' = 'Size Count');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_increment` SET TAGS ('dbx_business_glossary_term' = 'Size Increment');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_labels` SET TAGS ('dbx_business_glossary_term' = 'Size Labels');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_range_end` SET TAGS ('dbx_business_glossary_term' = 'Size Range End');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_range_start` SET TAGS ('dbx_business_glossary_term' = 'Size Range Start');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_scale_code` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_scale_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_scale_name` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_type` SET TAGS ('dbx_business_glossary_term' = 'Size Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `size_type` SET TAGS ('dbx_value_regex' = 'alpha|numeric|hybrid|one_size');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'adult|youth|kids|infant|toddler');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|seasonal_hold');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'clothing|footwear|accessories|equipment|licensed|private_label');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `color_palette_strategy` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Strategy');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `color_palette_strategy` SET TAGS ('dbx_value_regex' = 'core|seasonal|trend|limited_edition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `country_of_origin_primary` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Primary');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `country_of_origin_primary` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `cpsc_regulated` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Regulated');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `ecommerce_display_sequence` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Display Sequence');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `ftc_labeling_required` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Labeling Required');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Segmentation');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `hs_code_prefix` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Prefix');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `hs_code_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `is_licensed` SET TAGS ('dbx_business_glossary_term' = 'Licensed Product Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Private Label Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Category Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `is_web_visible` SET TAGS ('dbx_business_glossary_term' = 'Web Visible Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `margin_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `markdown_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `markdown_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `oracle_retail_category_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Retail Category Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `plm_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Category Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'athletic|lifestyle|luxury|performance|casual|formal');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Strategy');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_value_regex' = 'basic|fashion|seasonal|never_out_of_stock|allocation_driven');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `season_applicability` SET TAGS ('dbx_business_glossary_term' = 'Season Applicability');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `season_applicability` SET TAGS ('dbx_value_regex' = 'spring|summer|fall|winter|all_season|holiday');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `size_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `size_scale_type` SET TAGS ('dbx_value_regex' = 'numeric|alpha|footwear|one_size|custom');
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|production|obsolete|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|costing|planning');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cost_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cost_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cost_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cost_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `costing_stage` SET TAGS ('dbx_business_glossary_term' = 'Costing Stage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `costing_stage` SET TAGS ('dbx_value_regex' = 'initial_estimate|preliminary_costing|final_costing|actual_costing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CNY|JPY|INR');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cut_cost` SET TAGS ('dbx_business_glossary_term' = 'Cut Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `cut_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `duty_cost` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `duty_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `duty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `fabric_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fabric Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `fob_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `make_cost` SET TAGS ('dbx_business_glossary_term' = 'Make Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `make_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Modified By');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `primary_fabric_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Fabric Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `target_cogs` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `target_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `trim_cost` SET TAGS ('dbx_business_glossary_term' = 'Trim Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `trim_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Created By');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete|superseded');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `color_specification` SET TAGS ('dbx_business_glossary_term' = 'Color Specification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempted');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `is_sustainable` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `placement_description` SET TAGS ('dbx_business_glossary_term' = 'Placement Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `quantity_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `restricted_substance_tested` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Tested Indicator');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `size_specification` SET TAGS ('dbx_business_glossary_term' = 'Size Specification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `supplier_material_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'GOTS|BCI|OEKO-TEX|GRS|FSC|none');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tech_pack_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `base_size` SET TAGS ('dbx_business_glossary_term' = 'Base Size');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `construction_description` SET TAGS ('dbx_business_glossary_term' = 'Construction Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `fabric_weight_gsm` SET TAGS ('dbx_business_glossary_term' = 'Fabric Weight (GSM)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `fit_evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluation Criteria');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `fit_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Fit Model Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `fit_type` SET TAGS ('dbx_business_glossary_term' = 'Fit Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `fit_type` SET TAGS ('dbx_value_regex' = 'slim|regular|relaxed|oversized|athletic|compression');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids_boys|kids_girls');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `grade_rules` SET TAGS ('dbx_business_glossary_term' = 'Grade Rules');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `issued_to_factory_date` SET TAGS ('dbx_business_glossary_term' = 'Issued to Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `labeling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirements');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `measurement_points` SET TAGS ('dbx_business_glossary_term' = 'Measurement Points');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'cm|inches');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `seam_allowance_cm` SET TAGS ('dbx_business_glossary_term' = 'Seam Allowance (cm)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `stitch_type` SET TAGS ('dbx_business_glossary_term' = 'Stitch Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `sustainability_notes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tech_pack_name` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tech_pack_number` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tech_pack_status` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tech_pack_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|issued_to_factory|revised|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tna_calendar_reference` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (TNA) Calendar Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `tolerance_range` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Range');
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `bci_certified` SET TAGS ('dbx_business_glossary_term' = 'Better Cotton Initiative (BCI) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,15}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `color_name` SET TAGS ('dbx_business_glossary_term' = 'Color Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `cost_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Cost Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `cost_unit_of_measure` SET TAGS ('dbx_value_regex' = 'meter|yard|kilogram|piece|roll|unit');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `cotton_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cotton Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `fiber_composition` SET TAGS ('dbx_business_glossary_term' = 'Fiber Composition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_business_glossary_term' = 'Finish Treatment');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `gots_certified` SET TAGS ('dbx_business_glossary_term' = 'Global Organic Textile Standard (GOTS) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'fabric|trim|accessory|component|packaging');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|restricted|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_value_regex' = 'meter|yard|kilogram|piece|roll|unit');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `oeko_tex_certified` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `polyester_percentage` SET TAGS ('dbx_business_glossary_term' = 'Polyester Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `restricted_substance_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `supplier_material_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `weight_gsm` SET TAGS ('dbx_business_glossary_term' = 'Weight Grams per Square Meter (GSM)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width Centimeters (CM)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `tech_pack_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `fit_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluation Comments');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `fit_evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluation Result');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `fit_evaluation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_evaluated');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `iteration_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Iteration Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Sample Physical Location');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `measurement_chest_cm` SET TAGS ('dbx_business_glossary_term' = 'Chest Measurement in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `measurement_hip_cm` SET TAGS ('dbx_business_glossary_term' = 'Hip Measurement in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `measurement_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length Measurement in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `measurement_waist_cm` SET TAGS ('dbx_business_glossary_term' = 'Waist Measurement in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Sample Photo URL');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `quality_defects` SET TAGS ('dbx_business_glossary_term' = 'Quality Defects Description');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Requested Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|fit|salesman|production|pre_production|sms');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Submitted Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Target Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `wash_test_completed` SET TAGS ('dbx_business_glossary_term' = 'Wash Test Completed Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `wash_test_result` SET TAGS ('dbx_business_glossary_term' = 'Wash Test Result');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `wash_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`product`.`sample` ALTER COLUMN `weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight in Grams');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `category_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `season_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `average_unit_retail` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `average_unit_retail` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'CORE|CAPSULE|COLLABORATION|LIMITED_EDITION|SEASONAL');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `creative_direction_notes` SET TAGS ('dbx_business_glossary_term' = 'Creative Direction Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `creative_direction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'MENS|WOMENS|UNISEX|KIDS|YOUTH');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `merchandising_system_code` SET TAGS ('dbx_business_glossary_term' = 'Merchandising System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `otb_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Open-to-Buy (OTB) Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `otb_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `planned_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `planning_system_code` SET TAGS ('dbx_business_glossary_term' = 'Planning System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'ENTRY|MID|PREMIUM|LUXURY');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `sustainability_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Type [ENUM-REF-CANDIDATE: GOTS|OEKO-TEX|BCI|BLUESIGN|CRADLE_TO_CRADLE|FAIR_TRADE|ORGANIC_CONTENT|RECYCLED_CONTENT — promote to reference product]');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `sustainability_certified` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `target_channel` SET TAGS ('dbx_value_regex' = 'DTC|WHOLESALE|RETAIL|ECOMMERCE|OUTLET|DEPARTMENT_STORE');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percent');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Collection Theme');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ALTER COLUMN `total_style_count` SET TAGS ('dbx_business_glossary_term' = 'Total Style Count');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `msrp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP) Price ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|expired');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `aur_target` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR) Target');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'all|dtc|wholesale|retail|ecommerce');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `competitor_benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Competitor Benchmark Price');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `competitor_benchmark_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `cost_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `imu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `minimum_advertised_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advertised Price (MAP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP) Amount');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_point_strategy` SET TAGS ('dbx_business_glossary_term' = 'Price Point Strategy');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_point_strategy` SET TAGS ('dbx_value_regex' = 'penetration|premium|competitive|value|psychological');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'good|better|best|premium|luxury|entry');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_zone` SET TAGS ('dbx_business_glossary_term' = 'Price Zone');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `price_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `recommended_markdown_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recommended Markdown (MD) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'oracle_retail|sap_sd|centric_plm|manual|anaplan');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `vat_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Inclusive Flag');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Price');
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `cost_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Sheet ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `duty_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Calculation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `actual_cogs` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `cost_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Sheet Number');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `cost_sheet_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Sheet Status');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `cost_sheet_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `costing_stage` SET TAGS ('dbx_business_glossary_term' = 'Costing Stage');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `costing_stage` SET TAGS ('dbx_value_regex' = 'initial_estimate|preliminary_costing|final_costing|actual_costing|revised_costing');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `fabric_cost` SET TAGS ('dbx_business_glossary_term' = 'Fabric Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `imu_percent` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percent');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Overhead Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `target_cogs` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percent');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `trim_cost` SET TAGS ('dbx_business_glossary_term' = 'Trim Cost');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Cost Sheet Version');
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ALTER COLUMN `wholesale_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Price');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` SET TAGS ('dbx_subdomain' = 'style_design');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `license_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `license_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `licensor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `target_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `target_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`product`.`brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_confidential' = 'true');
