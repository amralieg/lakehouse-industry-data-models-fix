-- Schema for Domain: product | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`product` COMMENT 'Single source of truth for all finished goods master data across the F&B portfolio — SKUs, GTINs, UPCs, BOMs, formulations, recipes, nutritional panels, allergen matrices, packaging specifications, shelf life, and product lifecycle management (PLM) from NPD through commercialization and discontinuation. Governs product hierarchy from brand down to individual pack size and variant.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the Stock Keeping Unit. Primary key for the SKU master data product.',
    `brand_id` BIGINT COMMENT 'Reference to the brand under which this SKU is marketed and sold.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Every SKU in the F&B portfolio belongs to a product category (e.g., Beverages, Snacks, Dairy, Packaged Foods). The category table is the canonical master reference for product categories. Adding categ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity assignment per SKU needed for inter‑company profit/loss consolidation and tax reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account mapping required for sales posting per SKU; essential for financial reporting of product sales.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Each SKU belongs to a node in the product hierarchy, enabling classification and reporting. Adding product_hierarchy_id FK eliminates redundant category fields.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Required for SKU‑level supplier assignment used in sourcing decisions, cost modeling, and supplier scorecard reporting.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Required for regulatory product registration tracking; each SKU must be linked to its product registration record for label compliance and market approval.',
    `abv` DECIMAL(18,2) COMMENT 'Alcohol by volume percentage for alcoholic beverage products. Null for non-alcoholic products.',
    `allergen_matrix` STRING COMMENT 'Comprehensive list of major food allergens present in or potentially cross-contaminating the product (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame).',
    `brix_target` DECIMAL(18,2) COMMENT 'Target Brix measurement representing sugar content percentage for beverages and fruit products. Used for quality control and formulation.',
    `calories_per_serving` STRING COMMENT 'Total caloric content per serving as declared on the nutritional panel.',
    `clean_label_flag` BOOLEAN COMMENT 'Indicates whether the product meets clean label criteria with minimal, recognizable ingredients and no artificial additives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'Date when the SKU was or will be discontinued and removed from active production and distribution.',
    `ean` STRING COMMENT '13-digit European Article Number barcode identifier used internationally for retail product identification.. Valid values are `^[0-9]{13}$`',
    `flavor_variety` STRING COMMENT 'Specific flavor, variety, or variant of the product (e.g., Original, Chocolate, Strawberry, Spicy, Mild).',
    `form_factor` STRING COMMENT 'Physical form and preparation state of the product (Ready to Eat, Ready to Drink, Concentrate, Powder, Frozen, Refrigerated, Shelf Stable, Fresh). [ENUM-REF-CANDIDATE: ready to eat|ready to drink|concentrate|powder|frozen|refrigerated|shelf stable|fresh — 8 candidates stripped; promote to reference product]',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether the product meets gluten-free labeling requirements (less than 20 ppm gluten).',
    `gtin` STRING COMMENT 'Global Trade Item Number used for international product identification. Can be GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14.. Valid values are `^[0-9]{8}|[0-9]{12}|[0-9]{13}|[0-9]{14}$`',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified halal by a recognized halal certification body.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified kosher by a recognized kosher certification agency.',
    `launch_date` DATE COMMENT 'Date when the SKU was first introduced to market and made available for sale.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was last modified or updated.',
    `net_volume` DECIMAL(18,2) COMMENT 'Net volume of the product contents for liquid or pourable products.',
    `net_weight` DECIMAL(18,2) COMMENT 'Net weight of the product contents excluding packaging.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether the product is verified as non-genetically modified organism (Non-GMO Project Verified or equivalent).',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified organic by USDA or equivalent organic certification body.',
    `pack_size` STRING COMMENT 'Consumer-facing pack size description (e.g., Single Serve, Family Pack, 6-Pack, 12-Pack, Case).',
    `packaging_type` STRING COMMENT 'Primary packaging format and material (e.g., Bottle, Can, Pouch, Box, Bag, Jar, Tray, Carton).',
    `ph_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH level (acidity measure) for the product. Critical for food safety and quality control.',
    `ph_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH level (acidity measure) for the product. Critical for food safety and quality control.',
    `plm_stage` STRING COMMENT 'Current stage in the Product Lifecycle Management process (Concept, Development, Validation, Commercialization, Growth, Maturity, Decline). [ENUM-REF-CANDIDATE: concept|development|validation|commercialization|growth|maturity|decline — 7 candidates stripped; promote to reference product]',
    `product_description` STRING COMMENT 'Detailed description of the product including key features, ingredients, and usage occasions.',
    `product_line` STRING COMMENT 'Product line or sub-brand classification within the brand portfolio (e.g., Premium, Organic, Kids, Family Size).',
    `product_name` STRING COMMENT 'Full marketing name of the finished good product as it appears on packaging and in consumer-facing materials.',
    `product_status` STRING COMMENT 'Current lifecycle status of the SKU (Active, Discontinued, On Hold, Seasonal, Pending Launch, Phase Out).. Valid values are `active|discontinued|on hold|seasonal|pending launch|phase out`',
    `recyclable_flag` BOOLEAN COMMENT 'Indicates whether the primary packaging is recyclable through standard municipal recycling programs.',
    `serving_size` STRING COMMENT 'Standard serving size as declared on the nutritional panel with unit of measure (e.g., 1 cup (240ml), 28g, 1 bottle).',
    `servings_per_container` DECIMAL(18,2) COMMENT 'Number of servings contained in the package as declared on the nutritional panel.',
    `shelf_life_days` STRING COMMENT 'Number of days the product maintains quality and safety from production date under proper storage conditions.',
    `sku_code` STRING COMMENT 'Business identifier code for the SKU used across systems and operations. Alphanumeric code typically 6-20 characters.. Valid values are `^[A-Z0-9]{6,20}$`',
    `storage_temperature_max` DECIMAL(18,2) COMMENT 'Maximum storage temperature in Celsius required to maintain product quality and safety.',
    `storage_temperature_min` DECIMAL(18,2) COMMENT 'Minimum storage temperature in Celsius required to maintain product quality and safety.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for net weight or volume (grams, kilograms, ounces, pounds, milliliters, liters, fluid ounces, gallons, each, count). [ENUM-REF-CANDIDATE: g|kg|mg|oz|lb|ml|l|fl oz|gal|ea|count — 11 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit Universal Product Code barcode identifier used primarily in North America for retail scanning.. Valid values are `^[0-9]{12}$`',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the product contains no animal-derived ingredients or by-products.',
    `vegetarian_flag` BOOLEAN COMMENT 'Indicates whether the product is suitable for vegetarian diets (no meat, poultry, fish, or slaughter by-products).',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Master record for every Stock Keeping Unit (SKU) in the F&B portfolio — the single source of truth for finished-good identity. Captures SKU code, GTIN/UPC/EAN barcodes, brand, sub-brand, product line, flavor/variety, pack size, net weight/volume, unit of measure, form factor (RTD, RTE, concentrate, powder, frozen), ABV where applicable, Brix target, pH range, product status (active, discontinued, on-hold, seasonal), launch date, discontinuation date, PLM stage, and product hierarchy classification. Anchor entity for the entire product domain and primary join key for all downstream domains (sales, supply, manufacturing, quality).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for each node in the product hierarchy structure. Primary key for the product hierarchy entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Product hierarchy nodes are organized by brand architecture in F&B portfolio management. Brand managers use hierarchy-to-brand mapping for brand P&L reporting, portfolio governance, and brand architec',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Product hierarchy nodes (especially at the category and subcategory levels) should reference the canonical category master to ensure consistent category classification across the product hierarchy and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeting process allocates cost‑center budgets to product categories; hierarchy node links to cost_center for expense planning.',
    `parent_node_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the hierarchy structure. Null for top-level Division nodes. Enables recursive hierarchy traversal and roll-up reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product hierarchy nodes (brand, category, sub-category) map to profit centers for brand P&L and segment reporting in F&B. Hierarchy already has cost_center but lacks profit_center, which is essential ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: F&B portfolio strategy and NPD explicitly map product hierarchy nodes to consumer segments for innovation platform targeting and channel strategy. target_consumer_segment is a denormalized text fiel',
    `allergen_category` STRING COMMENT 'High-level allergen classification for products in this hierarchy node (e.g., Contains Dairy, Gluten-Free, Nut-Free Facility). Used for allergen matrix management and regulatory labeling compliance. [ENUM-REF-CANDIDATE: contains_milk|contains_eggs|contains_fish|contains_shellfish|contains_tree_nuts|contains_peanuts|contains_wheat|contains_soybeans|allergen_free — promote to reference product]',
    `brand_owner` STRING COMMENT 'Legal entity or business unit that owns the brand or product line represented by this hierarchy node. Used for financial reporting, royalty tracking, and portfolio management.',
    `category_captain_flag` BOOLEAN COMMENT 'Indicates whether this brand or product line holds category captain status with key retail partners. Category captains lead category management initiatives and planogram optimization.',
    `channel_strategy` STRING COMMENT 'Primary distribution channel strategy for products in this hierarchy node. Retail includes grocery and mass merchandisers; DSD is Direct Store Delivery; foodservice includes restaurants and institutions; ecommerce includes online retail; convenience includes c-stores and gas stations; club includes warehouse clubs; natural includes natural/organic specialty stores. [ENUM-REF-CANDIDATE: retail|foodservice|dsd|ecommerce|convenience|club|natural|specialty — 8 candidates stripped; promote to reference product]',
    `clean_label_flag` BOOLEAN COMMENT 'Indicates whether products under this hierarchy node meet clean label criteria (minimal processing, recognizable ingredients, no artificial additives). Used for marketing positioning and consumer segmentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Source system of record for this hierarchy node (e.g., SAP S/4HANA MM, Oracle PLM, Internal MDM). Used for data lineage and reconciliation.',
    `depth` STRING COMMENT 'Numeric depth of this node in the hierarchy tree, with Division=1, Category=2, etc. Used for hierarchy navigation and reporting level filtering.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchy node ceases to be effective. Null for currently active nodes. Enables historical reporting and supports product portfolio restructuring over time.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchy node becomes effective for product classification and reporting. Supports time-variant hierarchy structures for historical analysis.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle status of this hierarchy node. Active nodes are in use for classification and reporting; inactive nodes are historical; pending nodes are planned but not yet launched; discontinued nodes represent retired product lines.. Valid values are `active|inactive|pending|discontinued`',
    `innovation_platform_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node represents an innovation platform for New Product Development (NPD). Innovation platforms receive priority for R&D investment and accelerated commercialization.',
    `iri_category_code` STRING COMMENT 'IRI syndicated data category code mapping for this hierarchy node. Enables integration with IRI panel data and assortment analytics. Aligns with IRI category taxonomy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was last updated. Used for change tracking and data quality monitoring.',
    `level_code` STRING COMMENT 'Code indicating the level of this node within the product hierarchy structure. Defines whether this node represents a Division, Category, Sub-Category, Brand, Sub-Brand, Product Line, Variant, or Pack Size. [ENUM-REF-CANDIDATE: DIVISION|CATEGORY|SUBCATEGORY|BRAND|SUBBRAND|PRODUCTLINE|VARIANT|PACKSIZE — 8 candidates stripped; promote to reference product]',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this hierarchy node record. Used for audit trail and accountability.',
    `nielsen_category_code` STRING COMMENT 'Nielsen syndicated data category code mapping for this hierarchy node. Enables integration with Nielsen market tracking data and competitive benchmarking. Aligns with Nielsen category taxonomy.',
    `node_code` STRING COMMENT 'Business identifier code for this hierarchy node. Used for reporting, integration with Nielsen/IRI syndicated data, and cross-system references.',
    `node_description` STRING COMMENT 'Detailed description of this hierarchy node, including its scope, purpose, and business context within the product portfolio.',
    `node_name` STRING COMMENT 'Human-readable name for this hierarchy node. Examples: Beverages, Ready to Drink (RTD), Premium Cola Brand, Diet Variant, 12oz Can.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether products under this hierarchy node carry organic certification (USDA Organic, EU Organic, etc.). Used for regulatory compliance and marketing claims.',
    `path` STRING COMMENT 'Full hierarchical path from root to this node, typically formatted as slash-delimited string (e.g., /Beverages/RTD/Premium Cola/Diet/12oz). Enables efficient ancestor queries and reporting roll-ups.',
    `portfolio_tier` STRING COMMENT 'Strategic portfolio classification for this hierarchy node. Core brands receive sustained investment; growth brands receive accelerated investment; emerging brands are in test-and-learn phase; harvest brands are managed for cash flow; divest brands are planned for exit.. Valid values are `core|growth|emerging|harvest|divest`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node represents private label products manufactured for retail partners under their brand names.',
    `regulatory_category` STRING COMMENT 'FDA or USDA regulatory category for products in this hierarchy node (e.g., Conventional Food, Dietary Supplement, Meat Product, Beverage - Non-Alcoholic). Determines applicable regulatory requirements and labeling standards.',
    `sort_order` STRING COMMENT 'Numeric sort sequence for displaying this node among its siblings at the same hierarchy level. Used for consistent ordering in reports, planograms, and user interfaces.',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether products under this hierarchy node carry third-party sustainability certifications (Rainforest Alliance, Fair Trade, B Corp, etc.). Used for ESG reporting and marketing claims.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the multi-level product classification hierarchy from corporate portfolio down to individual SKU variant: Division → Category → Sub-Category → Brand → Sub-Brand → Product Line → Variant → Pack Size. Each node carries a hierarchy level code, parent node reference, hierarchy path string, and effective date range. Used for reporting roll-ups, trade promotion planning, category management, and planogram slotting. Aligns with Nielsen/IRI category taxonomy for syndicated data integration.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`bill_of_materials` (
    `bill_of_materials_id` BIGINT COMMENT 'Primary key for bill_of_materials',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In multi-entity F&B companies, BOMs are scoped to legal entities (company codes) for intercompany manufacturing, transfer pricing, and legal entity cost reporting. SAP-standard BOM management always a',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: FSMA and HACCP compliance require each BOM to be governed by a facility food safety plan. The BOM carries `haccp_critical_flag` and `regulatory_approval_required_flag`, signaling direct food safety pl',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing site or plant that owns and uses this BOM. BOMs may be plant-specific due to equipment capabilities, ingredient sourcing, or regional formulation requirements.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: In F&B ERP/MES (SAP, Oracle), BOM and Routing are the two master data objects that together define how to manufacture a product. BOM defines WHAT materials are needed; Routing defines HOW and WHERE to',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or semi-finished product that this BOM defines. Links to the product master data.',
    `specification_id` BIGINT COMMENT 'Reference to the detailed product specification document in the document management system (e.g., TraceGains, Veeva Vault). Contains full formulation details, processing instructions, quality parameters, and packaging specifications.',
    `work_center_id` BIGINT COMMENT 'Reference to the specific production line or manufacturing cell where this BOM is executed. Nullable if the BOM is not line-specific. Used for line-specific formulations or equipment constraints.',
    `allergen_declaration` STRING COMMENT 'Comma-separated list of major food allergens present in this formulation. Derived from ingredient specifications and used for labeling compliance. Examples: milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who granted final approval for this BOM. Used for accountability and audit trails.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The standard batch size or production quantity for which this BOM is defined. All ingredient quantities in the BOM line items are expressed relative to this base quantity. Typically represents one production batch or one unit of finished good.',
    `base_unit_of_measure` STRING COMMENT 'The unit of measure for the base quantity. Defines whether the BOM is expressed per kilogram, liter, each (unit), case, or other standard measure. [ENUM-REF-CANDIDATE: kg|lb|g|oz|l|ml|gal|ea|case|pallet — 10 candidates stripped; promote to reference product]',
    `batch_size_maximum` DECIMAL(18,2) COMMENT 'The largest production batch size that can be manufactured using this BOM. Driven by equipment capacity, mixing vessel size, or quality control limits.',
    `batch_size_minimum` DECIMAL(18,2) COMMENT 'The smallest production batch size that can be manufactured using this BOM. Driven by equipment constraints, minimum order quantities (MOQ) for ingredients, or quality requirements.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, externally known and used across manufacturing, procurement, and quality systems. Unique within the manufacturing site or globally depending on business rules.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Draft BOMs are under development, pending approval BOMs are awaiting PLM or quality sign-off, approved BOMs have passed review, active BOMs are in production use, inactive BOMs are temporarily suspended, and obsolete BOMs are retired.. Valid values are `draft|pending_approval|approved|active|inactive|obsolete`',
    `bom_type` STRING COMMENT 'Classification of the BOM based on its manufacturing context. Production BOMs are for standard in-house manufacturing, co-pack BOMs are for third-party co-packing arrangements, toll manufacturing BOMs are for contract manufacturing, rework BOMs are for reprocessing, sample BOMs are for R&D samples, and trial BOMs are for new product development trials.. Valid values are `production|co_pack|toll_manufacturing|rework|sample|trial`',
    `clean_label_flag` BOOLEAN COMMENT 'Indicates whether this formulation meets clean label criteria, typically defined as containing only recognizable, simple ingredients without artificial additives, preservatives, or highly processed components. Used for marketing and consumer positioning.',
    `contains_gmo_flag` BOOLEAN COMMENT 'Indicates whether this formulation contains genetically modified ingredients. Used for labeling compliance and consumer transparency.',
    `cost_estimate_amount` DECIMAL(18,2) COMMENT 'Estimated cost of goods sold (COGS) for producing one base quantity of this BOM. Calculated from ingredient costs, packaging costs, and manufacturing overhead. Used for pricing, margin analysis, and product profitability.',
    `cost_estimate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cost estimate amount. Typically the local currency of the manufacturing plant.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the system. Used for audit trails and data lineage.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM version is no longer valid for production. Nullable for currently active BOMs with no planned end date. Used for phasing out old formulations and managing product transitions.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM version becomes valid and can be used for production planning and manufacturing execution. Supports BOM versioning and change management.',
    `haccp_critical_flag` BOOLEAN COMMENT 'Indicates whether this BOM contains HACCP critical control points that require monitoring and documentation during production. Used for food safety management and regulatory compliance.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation is certified halal by a recognized halal certification body. Requires ingredient compliance with Islamic dietary laws and manufacturing process oversight.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation is certified kosher by a recognized kosher certification agency. Requires ingredient compliance and manufacturing process oversight.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was last updated. Used for change tracking and audit trails.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, formulation rationale, or change history notes. Used by R&D, quality, and operations teams for context and knowledge transfer.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation meets organic certification standards (e.g., USDA Organic, EU Organic). Requires all ingredients to be certified organic and manufacturing processes to comply with organic handling requirements.',
    `plm_approval_date` DATE COMMENT 'The date when the BOM received final PLM approval. Nullable for BOMs that have not yet been approved.',
    `plm_approval_status` STRING COMMENT 'Approval status from the PLM system indicating whether this BOM has passed cross-functional review by R&D, quality, regulatory, and operations teams. Required before a BOM can be activated for production.. Valid values are `not_submitted|under_review|approved|rejected|conditional_approval`',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this formulation requires pre-market regulatory approval or notification before production and sale. Applicable for novel ingredients, health claims, or regulated product categories.',
    `revision_date` DATE COMMENT 'The date when this BOM revision was created or last modified. Used for audit trails and change tracking.',
    `revision_number` STRING COMMENT 'Version identifier for the BOM. Incremented each time the formulation is changed. Supports traceability and change history for regulatory compliance and quality management.. Valid values are `^[A-Z0-9]{1,10}$`',
    `shelf_life_days` STRING COMMENT 'Expected shelf life of the finished product produced from this BOM, measured in days from production date. Used for inventory management, distribution planning, and expiration date calculation.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the finished product to maintain quality and safety throughout its shelf life. Examples: ambient, refrigerated 2-8C, frozen below -18C, protect from light, keep dry.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected production yield as a percentage of input materials. Accounts for normal manufacturing losses, evaporation, spillage, and waste. Used for material planning and cost calculations. A yield of 95.00 means 95% of input materials result in finished product.',
    CONSTRAINT pk_bill_of_materials PRIMARY KEY(`bill_of_materials_id`)
) COMMENT 'Bill of Materials (BOM) header record defining the formulation structure for each finished good or semi-finished SKU. Captures BOM number, BOM type (production, co-pack, toll manufacturing), base quantity, unit of measure, effective date range, revision number, PLM approval status, and the owning plant or manufacturing site. Links to BOM line items for individual ingredient quantities. Sourced from SAP S/4HANA PP module and TraceGains specification management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity.',
    `approved_vendor_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_vendor_list. Business justification: During BOM validation and MRP planning, procurement teams verify each BOM line component against the AVL to ensure only approved suppliers are used. This link enforces approved-source compliance per c',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header that this line belongs to. Links the component to the finished good SKU.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the primary or preferred supplier for this component, used for procurement planning and vendor management.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Each BOM line component is sourced under a specific purchase contract governing price, quality, and availability. Buyers use this link during MRP and procurement planning to verify contract coverage f',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: BOM line items in F&B directly reference raw material ingredients. This link drives allergen management, cost rollup, and regulatory compliance reporting. Every F&B domain expert expects bom_line comp',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Each BOM line item (ingredient/component) has an incoming quality specification — moisture content, particle size, microbial limits for raw materials. F&B procurement and quality teams use this link f',
    `allergen_type` STRING COMMENT 'Specific allergen classification if critical_allergen_flag is true (e.g., milk, eggs, peanuts, tree nuts, soy, wheat, fish, shellfish, sesame). Multiple allergens separated by semicolon.',
    `base_uom` STRING COMMENT 'The base unit of measure for the component quantity (e.g., KG, LB, L, GAL, EA, M, FT).',
    `bom_line_status` STRING COMMENT 'Current lifecycle status of this BOM line (active, inactive, pending approval, obsolete).. Valid values are `active|inactive|pending|obsolete`',
    `change_number` STRING COMMENT 'The engineering change order or product lifecycle management (PLM) change number that authorized this BOM line modification, used for traceability and compliance.',
    `component_category` STRING COMMENT 'Classification of the component type within the BOM structure (e.g., raw material, ingredient, packaging, label, co-product). [ENUM-REF-CANDIDATE: raw_material|ingredient|flavoring|preservative|packaging|label|co_product|other — 8 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the component cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per base unit of measure for this component, used for Cost of Goods Sold (COGS) calculation and variance analysis.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where this component is sourced or manufactured, used for regulatory compliance and supply chain transparency.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was first created in the system.',
    `critical_allergen_flag` BOOLEAN COMMENT 'Indicates whether this component contains or is derived from a major food allergen (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) requiring allergen matrix tracking and labeling compliance.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM line is no longer effective, used for component phase-out and reformulation management.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM line becomes effective and should be used in production planning and execution.',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether this component is certified gluten-free (less than 20 ppm gluten), used for gluten-free product formulation and FDA labeling compliance.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether this component is certified halal per Islamic dietary law, used for halal product manufacturing and labeling.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this component is classified as a hazardous material requiring special handling, storage, and disposal procedures.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether this component is certified kosher by a recognized kosher certification agency, used for kosher product manufacturing and labeling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was last updated or modified.',
    `lead_time_offset_days` STRING COMMENT 'The number of days before production start that this component must be available, used for procurement planning and scheduling.',
    `line_number` STRING COMMENT 'Sequential line number within the parent BOM, used for ordering and referencing specific components in the bill of materials.',
    `lot_size_multiple` DECIMAL(18,2) COMMENT 'The lot size increment in which this component must be ordered (e.g., multiples of 100 units), used for procurement planning.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity required by the supplier for this component, used for procurement planning and inventory optimization.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether this component is verified as non-GMO, used for clean label claims and consumer transparency.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this component, such as handling requirements, substitution rules, or quality specifications.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this component is certified organic per USDA National Organic Program standards, used for organic product certification and labeling.',
    `quantity_per_base_uom` DECIMAL(18,2) COMMENT 'The quantity of this component required to produce one unit of the parent finished good, expressed in the base unit of measure.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'The expected scrap or waste percentage for this component during production, used to adjust procurement quantities.',
    `shelf_life_days` STRING COMMENT 'The shelf life of this component in days from receipt, used for First Expired First Out (FEFO) inventory management and quality control.',
    `storage_condition` STRING COMMENT 'Required storage condition for this component (e.g., ambient, refrigerated, frozen, controlled temperature, dry) to maintain quality and safety.. Valid values are `ambient|refrigerated|frozen|controlled_temperature|dry|other`',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether this component is free from all animal-derived ingredients, used for vegan product formulation and labeling.',
    `yield_factor_percent` DECIMAL(18,2) COMMENT 'The expected yield percentage for this component, representing the usable output relative to input quantity.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual component line within a Bill of Materials (BOM), specifying each raw material, ingredient, flavoring, preservative, or packaging component required to produce one batch of the parent SKU. Captures component item number, quantity per base UOM, scrap/yield factor, component category (raw material, packaging, label, co-product), lead-offset, and whether the component is a critical allergen. Enables COGS calculation, procurement planning, and allergen matrix derivation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`formulation` (
    `formulation_id` BIGINT COMMENT 'Unique identifier for the product formulation record. Primary key for the formulation entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: F&B R&D formulation costs (ingredients, lab trials, regulatory testing) are tracked to R&D cost centers for budget vs. actual reporting and capitalization decisions. Finance controllers require formul',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Formulations are validated and approved for specific manufacturing plants based on equipment capabilities (UHT, retort, homogenization). Regulatory submissions (FDA, USDA) are plant-specific. F&B qual',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Formulation approval is tied to regulatory product registration; linking enables traceability of approved formulations to their registration.',
    `sku_id` BIGINT COMMENT 'Reference to the finished good SKU that this formulation produces. Links formulation to the product master.',
    `allergen_declaration` STRING COMMENT 'Comma-separated list of major allergens present in this formulation per FDA/FALCPA requirements: milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame. Used for labeling and compliance.',
    `approved_by` STRING COMMENT 'Name or identifier of the R&D scientist, quality manager, or regulatory specialist who approved this formulation for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulation was formally approved for production. Critical for compliance and traceability.',
    `batch_size` DECIMAL(18,2) COMMENT 'Standard production batch size for this formulation in kilograms or liters. Used for scaling ingredient quantities and production planning.',
    `batch_size_unit` STRING COMMENT 'Unit of measure for batch size: kg (kilogram), L (liter), gal (gallon), lb (pound).. Valid values are `kg|L|gal|lb`',
    `clean_label_compliant_flag` BOOLEAN COMMENT 'Indicates whether this formulation meets clean label criteria (no artificial ingredients, preservatives, or additives). True if compliant, False otherwise.',
    `cooling_temperature` DECIMAL(18,2) COMMENT 'Target cooling temperature in degrees Celsius after thermal processing. Critical for product safety and quality preservation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulation record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this formulation version becomes effective for production use. Used for version control and transition planning.',
    `expiration_date` DATE COMMENT 'Date when this formulation version is no longer valid for production. Null for active formulations without planned obsolescence.',
    `formulation_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to this formulation specification. Used across R&D, PLM, and manufacturing systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `formulation_name` STRING COMMENT 'Human-readable name or title of the formulation specification. Typically includes product name and variant descriptor.',
    `formulation_status` STRING COMMENT 'Current lifecycle status of the formulation: draft (in development), under_review (pending approval), approved (ready for use), active (in production), obsolete (no longer used), superseded (replaced by newer version).. Valid values are `draft|under_review|approved|active|obsolete|superseded`',
    `formulation_type` STRING COMMENT 'Classification of the formulation stage: bench (lab-scale R&D), pilot (pilot plant trial), commercial (approved for production), experimental (early research), prototype (concept validation), scale_up (transitioning to commercial scale).. Valid values are `bench|pilot|commercial|experimental|prototype|scale_up`',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether this formulation meets gluten-free standards (less than 20 ppm gluten per FDA). True if gluten-free, False otherwise.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation is halal certified per recognized halal certification authority. True if certified, False otherwise.',
    `holding_time` DECIMAL(18,2) COMMENT 'Required holding time in minutes at specified temperature or condition before next processing step. Critical for chemical reactions, flavor development, or safety.',
    `homogenization_pressure` DECIMAL(18,2) COMMENT 'Target homogenization pressure in pounds per square inch (PSI) for emulsion stability and particle size reduction. Critical for dairy and beverage products.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation is kosher certified per recognized kosher certification authority. True if certified, False otherwise.',
    `mixing_speed` DECIMAL(18,2) COMMENT 'Target mixing speed in revolutions per minute (RPM) for blending operations. Critical for achieving proper dispersion and emulsification.',
    `mixing_time` DECIMAL(18,2) COMMENT 'Required mixing or blending time in minutes to achieve homogeneous formulation. Critical process parameter for quality consistency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulation record was last modified. Used for audit trail and change tracking.',
    `moisture_content_target` DECIMAL(18,2) COMMENT 'Target moisture content as percentage of total weight. Critical for shelf life, texture, and microbial stability in dry and semi-moist products.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether this formulation is verified non-GMO per Non-GMO Project or equivalent standards. True if non-GMO, False otherwise.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this formulation is certified organic per USDA NOP or equivalent standards. True if certified, False otherwise.',
    `pasteurization_temperature` DECIMAL(18,2) COMMENT 'Target pasteurization temperature in degrees Celsius for thermal processing. Critical control point (CCP) under HACCP for pathogen elimination.',
    `pasteurization_time` DECIMAL(18,2) COMMENT 'Target pasteurization hold time in seconds at specified temperature. Critical control point (CCP) under HACCP for achieving required lethality.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted for this formulation. Required for compliance tracking and audit trails.',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status for this formulation: pending (under review), approved (cleared for production), rejected (not approved), conditional (approved with restrictions), not_required (no regulatory review needed).. Valid values are `pending|approved|rejected|conditional|not_required`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority that approved this formulation: FDA (US Food and Drug Administration), USDA (US Department of Agriculture), EFSA (European Food Safety Authority), FSANZ (Food Standards Australia New Zealand), Health_Canada, ANVISA (Brazil).. Valid values are `FDA|USDA|EFSA|FSANZ|Health_Canada|ANVISA`',
    `target_brix` DECIMAL(18,2) COMMENT 'Target sugar content measurement in degrees Brix for this formulation. Critical quality parameter for beverages and sweet products. Measured as percentage of dissolved solids.',
    `target_ph_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH (acidity/alkalinity) level for this formulation. Critical for food safety, shelf life, and organoleptic properties. Scale 0-14.',
    `target_ph_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH (acidity/alkalinity) level for this formulation. Critical for food safety, shelf life, and organoleptic properties. Scale 0-14.',
    `target_viscosity` DECIMAL(18,2) COMMENT 'Target viscosity measurement for this formulation in centipoise (cP). Critical for product texture, mouthfeel, and processing characteristics.',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether this formulation contains no animal-derived ingredients or by-products. True if vegan, False otherwise.',
    `version_number` STRING COMMENT 'Version identifier for this formulation specification. Incremented with each revision or reformulation. Format: major.minor (e.g., 1.0, 2.3).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `viscosity_unit` STRING COMMENT 'Unit of measure for viscosity specification: cP (centipoise), mPa·s (millipascal-second), Pa·s (pascal-second).. Valid values are `cP|mPa_s|Pa_s`',
    `water_activity_aw` DECIMAL(18,2) COMMENT 'Target water activity (Aw) level for this formulation. Scale 0.0-1.0. Critical food safety parameter controlling microbial growth. Values below 0.85 inhibit most pathogens.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage from raw materials to finished product. Accounts for processing losses, evaporation, and waste. Used for cost calculation and material planning.',
    CONSTRAINT pk_formulation PRIMARY KEY(`formulation_id`)
) COMMENT 'Approved product formulation and recipe specification managed through PLM and TraceGains. Captures formulation code, version, formulation type (bench, pilot, commercial), target Brix, target pH, target viscosity, moisture content, water activity (Aw), processing parameters (pasteurization temperature/time, homogenization pressure), yield percentage, batch size, and regulatory approval status. Distinct from BOM in that it captures the scientific/R&D specification rather than the manufacturing component list.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`nutritional_panel` (
    `nutritional_panel_id` BIGINT COMMENT 'Primary key for nutritional_panel',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: In F&B PLM, nutritional facts panels are derived from and must be traceable to the specific approved formulation version they were calculated from. When a formulation changes (e.g., ingredient substit',
    `nutrition_label_id` BIGINT COMMENT 'Foreign key linking to regulatory.nutrition_label. Business justification: The internal nutritional panel (product spec) drives the regulatory nutrition label submission. Regulatory affairs teams reconcile internal panel data against the submitted regulatory nutrition label ',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Nutritional panels must align with regulatory product registration data for compliance reporting and label generation.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which this nutritional panel applies. Links to the product SKU master data.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Nutritional panel values (fat%, protein%, sodium) must be validated against quality specifications through laboratory analysis. FDA 21 CFR Part 101 requires nutritional label accuracy within analytica',
    `added_sugars_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for added sugars per serving.',
    `added_sugars_grams` DECIMAL(18,2) COMMENT 'Added sugar content per serving, expressed in grams. Required under updated FDA regulations (2016+).',
    `allergen_statement` STRING COMMENT 'Full allergen declaration statement as it appears on the nutritional panel or label (e.g., Contains: Milk, Soy, Wheat). Critical for food safety and regulatory compliance.',
    `approval_date` DATE COMMENT 'Date on which this nutritional panel was formally approved for use on product packaging and labeling.',
    `approved_by` STRING COMMENT 'Name or identifier of the regulatory affairs or quality assurance personnel who approved this nutritional panel for use.',
    `calcium_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for calcium per serving.',
    `calcium_milligrams` DECIMAL(18,2) COMMENT 'Calcium content per serving, expressed in milligrams. Mandatory nutrient under updated FDA regulations.',
    `calories_from_fat` DECIMAL(18,2) COMMENT 'Calories derived from fat per serving. Required in some jurisdictions (e.g., older FDA format), optional in others.',
    `calories_per_serving` DECIMAL(18,2) COMMENT 'Total caloric energy per serving, expressed in kilocalories (kcal).',
    `cholesterol_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for cholesterol per serving.',
    `cholesterol_milligrams` DECIMAL(18,2) COMMENT 'Cholesterol content per serving, expressed in milligrams.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional panel record was first created in the system.',
    `dietary_fiber_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for dietary fiber per serving.',
    `dietary_fiber_grams` DECIMAL(18,2) COMMENT 'Dietary fiber content per serving, expressed in grams.',
    `effective_date` DATE COMMENT 'Date from which this nutritional panel version becomes effective and must be used on product packaging and labeling.',
    `expiration_date` DATE COMMENT 'Date after which this nutritional panel version is no longer valid and must be replaced. Nullable for current active panels.',
    `fda_submission_reference` STRING COMMENT 'Reference number or identifier for the FDA submission or notification associated with this nutritional panel. Critical for FSMA compliance and audit trail.',
    `ingredient_statement` STRING COMMENT 'Full ingredient list as it appears on the nutritional panel or label, in descending order of predominance by weight.',
    `iron_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for iron per serving.',
    `iron_milligrams` DECIMAL(18,2) COMMENT 'Iron content per serving, expressed in milligrams. Mandatory nutrient under updated FDA regulations.',
    `lab_analysis_reference` STRING COMMENT 'Reference number or identifier for the third-party laboratory analysis report that substantiates the nutritional values declared on this panel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional panel record was last updated or modified.',
    `monounsaturated_fat_grams` DECIMAL(18,2) COMMENT 'Monounsaturated fat content per serving, expressed in grams. Voluntary declaration in most jurisdictions.',
    `panel_format_standard` STRING COMMENT 'The regulatory format standard that this nutritional panel follows (e.g., FDA Nutrition Facts, EU Nutrition Declaration, Health Canada Nutrition Facts).. Valid values are `FDA Nutrition Facts|EU Nutrition Declaration|Health Canada Nutrition Facts|Codex|LATAM|APAC Custom`',
    `panel_status` STRING COMMENT 'Current lifecycle status of the nutritional panel record (draft, pending approval, approved, active, superseded, retired).. Valid values are `draft|pending_approval|approved|active|superseded|retired`',
    `panel_version` STRING COMMENT 'Version number of the nutritional panel to track changes over time due to formulation updates or regulatory changes. Format: major.minor (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `polyunsaturated_fat_grams` DECIMAL(18,2) COMMENT 'Polyunsaturated fat content per serving, expressed in grams. Voluntary declaration in most jurisdictions.',
    `potassium_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for potassium per serving.',
    `potassium_milligrams` DECIMAL(18,2) COMMENT 'Potassium content per serving, expressed in milligrams. Mandatory nutrient under updated FDA regulations.',
    `protein_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for protein per serving. Optional unless a protein claim is made.',
    `protein_grams` DECIMAL(18,2) COMMENT 'Protein content per serving, expressed in grams.',
    `regulatory_jurisdiction` STRING COMMENT 'Country or regulatory jurisdiction for which this nutritional panel is formatted and compliant. Uses ISO 3166-1 alpha-3 country codes. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|GBR|DEU|FRA|ITA|ESP|AUS|JPN|CHN|IND — 13 candidates stripped; promote to reference product]',
    `rounding_method` STRING COMMENT 'The rounding methodology applied to nutritional values per regulatory requirements (e.g., FDA Standard, EU Standard, Custom).. Valid values are `FDA Standard|EU Standard|Custom`',
    `saturated_fat_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for saturated fat per serving.',
    `saturated_fat_grams` DECIMAL(18,2) COMMENT 'Saturated fat content per serving, expressed in grams.',
    `serving_size` STRING COMMENT 'The standardized serving size for this product as displayed on the nutritional panel, including unit of measure (e.g., 1 cup (240 mL), 2 cookies (30g)).',
    `serving_size_grams` DECIMAL(18,2) COMMENT 'Numeric serving size expressed in grams for standardized analysis and comparison across products.',
    `servings_per_container` DECIMAL(18,2) COMMENT 'Number of servings contained in the package. May be a decimal for products with variable servings (e.g., about 2.5).',
    `sodium_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for sodium per serving.',
    `sodium_milligrams` DECIMAL(18,2) COMMENT 'Sodium content per serving, expressed in milligrams.',
    `sugar_alcohols_grams` DECIMAL(18,2) COMMENT 'Sugar alcohol content per serving, expressed in grams. Voluntary declaration unless a sugar-related claim is made.',
    `total_carbohydrate_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for total carbohydrate per serving.',
    `total_carbohydrate_grams` DECIMAL(18,2) COMMENT 'Total carbohydrate content per serving, expressed in grams.',
    `total_fat_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for total fat per serving, based on a 2,000 calorie diet (FDA) or reference intake (EU).',
    `total_fat_grams` DECIMAL(18,2) COMMENT 'Total fat content per serving, expressed in grams.',
    `total_sugars_grams` DECIMAL(18,2) COMMENT 'Total sugar content per serving, expressed in grams. Includes naturally occurring and added sugars.',
    `trans_fat_grams` DECIMAL(18,2) COMMENT 'Trans fat content per serving, expressed in grams. Must be declared even if no daily value is established.',
    `usda_submission_reference` STRING COMMENT 'Reference number or identifier for the USDA submission or approval associated with this nutritional panel, applicable for meat, poultry, and egg products.',
    `vitamin_a_iu` DECIMAL(18,2) COMMENT 'Vitamin A content per serving, expressed in international units. Voluntary under updated FDA regulations but may be required in other jurisdictions.',
    `vitamin_c_milligrams` DECIMAL(18,2) COMMENT 'Vitamin C content per serving, expressed in milligrams. Voluntary under updated FDA regulations but may be required in other jurisdictions.',
    `vitamin_d_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for Vitamin D per serving.',
    `vitamin_d_micrograms` DECIMAL(18,2) COMMENT 'Vitamin D content per serving, expressed in micrograms. Mandatory nutrient under updated FDA regulations.',
    CONSTRAINT pk_nutritional_panel PRIMARY KEY(`nutritional_panel_id`)
) COMMENT 'Regulatory nutritional facts panel data for each SKU per applicable jurisdiction (FDA Nutrition Facts, EU Nutrition Declaration, Health Canada). Captures serving size, servings per container, calories, total fat, saturated fat, trans fat, cholesterol, sodium, total carbohydrate, dietary fiber, total sugars, added sugars, protein, and all required vitamins/minerals with % Daily Value. Tracks panel version, effective date, regulatory jurisdiction, and FDA/USDA submission reference. Critical for FSMA compliance and retailer item setup.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`packaging_spec` (
    `packaging_spec_id` BIGINT COMMENT 'Unique identifier for the packaging specification record.',
    `packaging_compliance_id` BIGINT COMMENT 'Foreign key linking to regulatory.packaging_compliance. Business justification: Packaging compliance verification requires each packaging spec to reference the compliance record for material and recycling regulations.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Packaging specs define container dimensions, fill volumes, and closure types that constrain which production lines are qualified to run them. F&B production planners and packaging engineers explicitly',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU this packaging specification applies to.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier providing the packaging materials or components.',
    `barrier_properties` STRING COMMENT 'Description of the packaging barrier characteristics (oxygen barrier, moisture barrier, light barrier, gas barrier) critical for shelf life preservation.',
    `bio_based_content_percent` DECIMAL(18,2) COMMENT 'Percentage of bio-based or renewable material content in the packaging, supporting clean label and sustainability initiatives.',
    `bpa_free_flag` BOOLEAN COMMENT 'Indicates whether the packaging is free from Bisphenol A (BPA), supporting clean label and consumer health claims.',
    `cases_per_layer` STRING COMMENT 'Number of cases in one horizontal layer on a pallet, used for pallet pattern optimization and warehouse slotting.',
    `child_resistant_flag` BOOLEAN COMMENT 'Indicates whether the packaging meets child-resistant packaging standards per CPSC regulations (applicable for certain products).',
    `closure_type` STRING COMMENT 'Type of closure or sealing mechanism (e.g., screw cap, snap lid, pull tab, peel seal, twist-off, cork, pump dispenser).',
    `compostable_certified_flag` BOOLEAN COMMENT 'Indicates whether the packaging is certified compostable per ASTM D6400 or EN 13432 standards.',
    `container_type` STRING COMMENT 'Specific form of the packaging container (e.g., bottle, can, pouch, jar, tray, carton, bag, tube).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of one packaging unit in the companys base currency, used for Cost of Goods Sold (COGS) calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per unit (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depth_mm` DECIMAL(18,2) COMMENT 'Depth of the packaging container in millimeters, used for logistics cube optimization and planogram design.',
    `diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of cylindrical packaging containers in millimeters (applicable for bottles, cans, jars).',
    `effective_date` DATE COMMENT 'Date when this packaging specification became or will become active for production use.',
    `fill_volume_ml` DECIMAL(18,2) COMMENT 'Nominal fill volume of liquid or semi-liquid products in milliliters, as declared on the label.',
    `food_contact_approved_flag` BOOLEAN COMMENT 'Indicates whether the packaging material is approved for direct food contact per FDA and EU regulations.',
    `freezer_safe_flag` BOOLEAN COMMENT 'Indicates whether the packaging is suitable for freezer storage without material degradation or product quality loss.',
    `gross_weight_g` DECIMAL(18,2) COMMENT 'Total weight including product and packaging in grams, used for freight cost calculation and logistics planning.',
    `height_mm` DECIMAL(18,2) COMMENT 'Height of the packaging container in millimeters, used for logistics cube optimization and planogram design.',
    `label_panel_count` STRING COMMENT 'Number of distinct label panels on the packaging (front, back, side panels) used for regulatory compliance and marketing content.',
    `layers_per_pallet` STRING COMMENT 'Number of vertical layers stacked on a standard pallet, used for pallet pattern optimization and transportation planning.',
    `material_type` STRING COMMENT 'Primary material composition of the packaging component (e.g., PET, HDPE, glass, aluminum, paperboard, flexible film). [ENUM-REF-CANDIDATE: PET|HDPE|LDPE|PP|PS|PVC|glass|aluminum|steel|paperboard|corrugated|flexible_film|multi_layer_laminate|biodegradable — 14 candidates stripped; promote to reference product]',
    `microwave_safe_flag` BOOLEAN COMMENT 'Indicates whether the packaging is certified safe for microwave heating, relevant for Ready-to-Eat (RTE) products.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging specification record was last modified.',
    `net_weight_g` DECIMAL(18,2) COMMENT 'Net weight of the product content excluding packaging in grams, as declared on the nutritional panel.',
    `obsolete_date` DATE COMMENT 'Date when this packaging specification was or will be retired from active use.',
    `packaging_level` STRING COMMENT 'Hierarchical level of packaging: primary (consumer unit), secondary (case/carton), tertiary (pallet), or display (shelf-ready packaging).. Valid values are `primary|secondary|tertiary|display`',
    `packaging_spec_status` STRING COMMENT 'Current lifecycle status of the packaging specification in the Product Lifecycle Management (PLM) system.. Valid values are `active|pending_approval|obsolete|discontinued|under_revision`',
    `pallet_pattern` STRING COMMENT 'Description of the case arrangement pattern on the pallet (e.g., column stack, interlocked, pinwheel) for load stability and cube optimization.',
    `pallet_ti_hi` STRING COMMENT 'Pallet configuration expressed as Ti (cases per layer) x Hi (layers per pallet), standard logistics notation.. Valid values are `^[0-9]{1,2}x[0-9]{1,2}$`',
    `pcr_content_percent` DECIMAL(18,2) COMMENT 'Percentage of post-consumer recycled material in the packaging, used for sustainability reporting and environmental compliance.',
    `recyclability_code` STRING COMMENT 'Resin identification code (1-7) indicating the material recyclability classification per ISO 1043 and local recycling standards.. Valid values are `^[1-7]$|^[1-7]-[A-Z]{2,6}$`',
    `spec_code` STRING COMMENT 'Unique business identifier for the packaging specification used in Product Lifecycle Management (PLM) and Manufacturing Execution System (MES).. Valid values are `^PKG-[A-Z0-9]{8,12}$`',
    `spec_version` STRING COMMENT 'Version number of the packaging specification to track revisions and changes over time.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `srp_configuration` STRING COMMENT 'Configuration type for shelf-ready packaging that allows direct placement on retail shelves without additional unpacking.. Valid values are `full_case|half_case|tray|wrap|none`',
    `tamper_evident_flag` BOOLEAN COMMENT 'Indicates whether the packaging includes tamper-evident features (e.g., safety seal, breakable cap, shrink band) per FDA requirements.',
    `tare_weight_g` DECIMAL(18,2) COMMENT 'Weight of the empty packaging material in grams, used for sustainability reporting and material cost analysis.',
    `units_per_case` STRING COMMENT 'Number of consumer units (primary packages) contained in one secondary case or carton.',
    `width_mm` DECIMAL(18,2) COMMENT 'Width of the packaging container in millimeters, used for logistics cube optimization and planogram design.',
    CONSTRAINT pk_packaging_spec PRIMARY KEY(`packaging_spec_id`)
) COMMENT 'Packaging specification for each SKU covering primary, secondary, and tertiary packaging. Captures packaging material type (PET, HDPE, glass, aluminum, paperboard, flexible film), container dimensions (height, width, depth, diameter), net weight, gross weight, fill volume, closure type, label panel count, recyclability code, PCR (post-consumer recycled) content percentage, shelf-ready packaging (SRP) configuration, and pallet pattern. Used for sustainability reporting, logistics cube optimization, and retailer compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` (
    `shelf_life_spec_id` BIGINT COMMENT 'Unique identifier for the shelf life specification record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Major F&B retailers (Walmart, Kroger, Costco) mandate retailer-specific minimum remaining shelf life (MRSL) at receipt. retailer_compliance_notes signals customer-specific requirements. This FK enab',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Shelf life specifications are validated per manufacturing plant because process capability (retort temperature, UHT equipment, cold-chain infrastructure) directly determines achievable shelf life. FSM',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Shelf life data is a mandatory component of product registration dossiers (FDA, EFSA). The shelf_life_spec carries `open_dating_regulation` and `fsma_204_traceability_flag`, confirming regulatory subm',
    `sku_id` BIGINT COMMENT 'Reference to the SKU this shelf life specification applies to. Links to the product SKU master data.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Shelf life specifications are validated against quality specifications — micro limits (TPC, Listeria), sensory scores, and chemical parameters define shelf life endpoints. F&B regulatory and quality t',
    `accelerated_testing_flag` BOOLEAN COMMENT 'Indicates whether the shelf life was determined using accelerated shelf life testing methods rather than real-time aging studies.',
    `approval_date` DATE COMMENT 'Date on which this shelf life specification was formally approved by quality assurance.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether uninterrupted cold chain (refrigerated or frozen) is required from production through distribution to maintain shelf life and safety.',
    `consumer_date_format` STRING COMMENT 'Format pattern for the consumer-facing date label (e.g., MM/DD/YYYY, DD-MMM-YYYY). Must comply with regional open-dating regulations.. Valid values are `^[A-Z]{2,10}(/[A-Z]{2,10})*$`',
    `consumer_date_label_type` STRING COMMENT 'Type of date label printed on consumer packaging. Best By indicates peak quality date, Use By indicates safety date, Sell By is for retailer inventory management, Expires On indicates absolute expiration.. Valid values are `best_by|use_by|sell_by|expires_on`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shelf life specification record was first created in the system.',
    `date_calculation_method` STRING COMMENT 'Method used to calculate the best-by or use-by date. Manufacture_plus_offset adds shelf life days to manufacture date, fixed_calendar uses a predetermined calendar date, batch_specific requires manual entry per batch.. Valid values are `manufacture_plus_offset|fixed_calendar|batch_specific`',
    `dc_receiving_standard` STRING COMMENT 'Specific receiving standard or policy that distribution centers must enforce when accepting this product (e.g., minimum remaining shelf life percentage, temperature verification requirements).',
    `effective_date` DATE COMMENT 'Date from which this shelf life specification becomes effective and must be applied to production batches.',
    `expiration_date` DATE COMMENT 'Date after which this shelf life specification is no longer valid. Null for specifications with no planned end date.',
    `frozen_shelf_life_days` STRING COMMENT 'Shelf life in days when product is stored in frozen conditions. Null if product is not suitable for freezing.',
    `fsma_204_traceability_flag` BOOLEAN COMMENT 'Indicates whether this product is subject to FSMA 204 enhanced traceability requirements for foods on the Food Traceability List.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this shelf life specification. Specifications should be reviewed regularly to ensure continued validity.',
    `light_sensitivity_flag` BOOLEAN COMMENT 'Indicates whether the product is sensitive to light exposure and requires storage in dark or light-protected conditions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shelf life specification record was last modified.',
    `mrsl_days` STRING COMMENT 'Minimum number of days of remaining shelf life required at the time of shipment to customers or distribution centers. Used to enforce retailer receiving standards (e.g., Walmart 2/3 life remaining policy).',
    `next_review_date` DATE COMMENT 'Date on which the next periodic review of this shelf life specification is scheduled.',
    `open_dating_regulation` STRING COMMENT 'Reference to the specific open-dating regulation that governs date labeling for this product (e.g., state-level US requirements, EU 1169/2011 Article 9). May vary by jurisdiction.',
    `post_opening_shelf_life_days` STRING COMMENT 'Number of days the product remains safe and of acceptable quality after the package is opened by the consumer. Null if not applicable or if product is single-serve.',
    `quality_hold_threshold_days` STRING COMMENT 'Number of days before expiration at which inventory should be placed on quality hold for review or disposition. Used to prevent shipment of short-dated product.',
    `retailer_compliance_notes` STRING COMMENT 'Free-text notes documenting specific retailer requirements or compliance considerations (e.g., Walmart 2/3 life remaining policy, Target temperature monitoring requirements).',
    `rotation_rule` STRING COMMENT 'Inventory rotation method to be applied. FIFO (First In First Out) rotates by receipt date, FEFO (First Expired First Out) rotates by expiration date, LIFO (Last In First Out) is rarely used in food and beverage.. Valid values are `FIFO|FEFO|LIFO`',
    `shelf_life_spec_status` STRING COMMENT 'Current lifecycle status of the shelf life specification. Draft specifications are under development, active specifications are in use, superseded specifications have been replaced by newer versions, and obsolete specifications are no longer valid.. Valid values are `draft|active|superseded|obsolete`',
    `shelf_life_testing_protocol` STRING COMMENT 'Reference to the laboratory testing protocol or study used to establish the shelf life specification. Links to quality assurance documentation.',
    `specification_version` STRING COMMENT 'Version number of this shelf life specification, incremented when specification parameters change.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `storage_humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity percentage allowed during storage to prevent product degradation. Null if humidity control is not required.',
    `storage_humidity_min_percent` DECIMAL(18,2) COMMENT 'Minimum relative humidity percentage required during storage to prevent product degradation. Null if humidity control is not required.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain product quality and safety throughout shelf life. Exceeding this temperature may compromise product integrity.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain product quality and safety throughout shelf life. Critical for cold chain integrity.',
    `temperature_excursion_tolerance_hours` STRING COMMENT 'Maximum number of hours the product can tolerate temperature excursions outside the specified range without compromising safety or quality. Null if no tolerance is allowed.',
    `total_shelf_life_days` STRING COMMENT 'Total number of days from manufacture date to end of shelf life (best-by or use-by date). Critical for FEFO inventory rotation and retailer compliance.',
    CONSTRAINT pk_shelf_life_spec PRIMARY KEY(`shelf_life_spec_id`)
) COMMENT 'Shelf life and storage condition specifications for each SKU, critical for FSMA 204 traceability compliance and retailer receiving standards. Captures total shelf life (days), minimum remaining shelf life at shipment (MRSL), best-by date calculation method (manufacture date + offset vs. fixed calendar), storage temperature range (min/max °C), humidity requirements, light sensitivity, FIFO/FEFO rotation rule, consumer-facing date format (Best By, Use By, Sell By), open-dating regulation compliance (state-level US, EU 1169/2011), and shelf life testing protocol reference. Governs FEFO inventory rotation, DC receiving standards, retailer compliance (e.g., Walmart 2/3 life remaining policy), and cold chain integrity requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Unique identifier for the label specification record. Primary key for the label specification entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: F&B label specs are often retailer/distributor-specific for private label and co-branded products. distributor_name and distributor_address are denormalized account attributes. This FK supports pr',
    `label_approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_approval. Business justification: Label approval workflow mandates linking each label spec to its approved label record to ensure regulatory compliance before printing.',
    `nutritional_panel_id` BIGINT COMMENT 'Foreign key linking to product.nutritional_panel. Business justification: A label specification must reference the specific nutritional panel it displays. In F&B, the label artwork incorporates the FDA/USDA Nutrition Facts panel, and the label spec must be tied to the appro',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: A label specification is physically applied to a specific packaging configuration. The label dimensions (label_height_mm, label_width_mm on label_spec) are designed to fit the specific container dimen',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which this label specification applies. Links label artwork and compliance requirements to the specific product variant.',
    `adhesive_type` STRING COMMENT 'Type of adhesive used on the label. Critical for packaging line performance and consumer experience, especially for refrigerated or frozen products.. Valid values are `permanent|removable|freezer_grade|high_tack|low_tack`',
    `allergen_warning_text` STRING COMMENT 'Mandatory allergen declaration text listing major food allergens present in the product or manufacturing facility. Required by FSMA (Food Safety Modernization Act) and FALCPA (Food Allergen Labeling and Consumer Protection Act).',
    `artwork_approval_date` DATE COMMENT 'Date when the label artwork received final approval and was released for production use.',
    `artwork_approval_status` STRING COMMENT 'Current approval status of the label artwork in the PLM workflow. Tracks progression through legal, regulatory, and quality reviews before production release. [ENUM-REF-CANDIDATE: draft|pending_review|legal_review|regulatory_review|approved|rejected|obsolete — 7 candidates stripped; promote to reference product]',
    `artwork_file_path` STRING COMMENT 'File system path or URI to the approved digital artwork file for this label specification. Used by printing vendors and packaging lines.',
    `barcode_type` STRING COMMENT 'Type of barcode symbology used on the label for product identification and traceability. Must align with retail and supply chain scanning requirements.. Valid values are `UPC-A|EAN-13|ITF-14|GS1-128|QR|DataMatrix`',
    `barcode_value` DECIMAL(18,2) COMMENT 'Numeric value encoded in the barcode. Typically the GTIN (Global Trade Item Number), UPC (Universal Product Code), or EAN (European Article Number) for the SKU.',
    `clean_label_flag` BOOLEAN COMMENT 'Indicates whether the product qualifies for clean label marketing claims. True if the product contains only recognizable, simple ingredients without artificial additives.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code identifying where the product was manufactured or produced. Required for customs and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this label specification becomes active and must be used on production runs. Supports phased label transitions and regulatory compliance deadlines.',
    `expiration_date` DATE COMMENT 'Date when this label specification is no longer valid and must be replaced. Supports label version lifecycle management and regulatory update compliance.',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether the product meets gluten-free standards and may display gluten-free claims on the label.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified halal by a recognized Islamic authority and may display halal certification marks on the label.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified kosher by a recognized rabbinical authority and may display kosher certification symbols on the label.',
    `label_height_mm` DECIMAL(18,2) COMMENT 'Physical height of the label in millimeters. Critical for printing specifications and packaging line setup.',
    `label_type` STRING COMMENT 'Classification of the label by its position and purpose on the product packaging. Determines which regulatory and marketing content is required. [ENUM-REF-CANDIDATE: front_panel|back_panel|nutrition_panel|ingredient_panel|neck_label|cap_label|case_label|pallet_label|promotional_sticker — 9 candidates stripped; promote to reference product]',
    `label_version` STRING COMMENT 'Version identifier for the label specification. Tracks revisions and updates to label artwork, claims, or regulatory text. Incremented with each approved change.. Valid values are `^[A-Z0-9]{1,20}$`',
    `label_width_mm` DECIMAL(18,2) COMMENT 'Physical width of the label in millimeters. Critical for printing specifications and packaging line setup.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code for the primary language used on the label. Required for multi-market products and bilingual labeling requirements.. Valid values are `^[a-z]{2}$`',
    `mandatory_claim_text` STRING COMMENT 'Legally required text that must appear on the label per regulatory jurisdiction. Includes statements mandated by FDA, USDA, EFSA, or other governing bodies.',
    `manufacturer_address` STRING COMMENT 'Physical address of the manufacturer or distributor. Required on label for consumer contact and regulatory traceability.',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer or distributor responsible for the product. Required on label per FDA and USDA regulations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this label specification record was last modified. Used for audit trail and change tracking.',
    `net_quantity_statement` STRING COMMENT 'Regulatory-compliant statement of the net quantity of contents in the package. Must include both metric and US customary units where required by jurisdiction.',
    `non_gmo_flag` BOOLEAN COMMENT 'Indicates whether the product is certified as non-GMO and eligible to display non-GMO claims on the label.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the product is certified organic by USDA or equivalent authority and may display organic certification marks on the label.',
    `print_vendor_code` STRING COMMENT 'Identifier for the approved printing vendor responsible for producing this label. Used for vendor management and quality traceability.. Valid values are `^[A-Z0-9]{1,20}$`',
    `qr_code_url` STRING COMMENT 'URL encoded in the QR code on the label. Typically links to product information, traceability data, or consumer engagement content.. Valid values are `^https?://.*$`',
    `recycling_instructions` STRING COMMENT 'Consumer-facing instructions for proper disposal and recycling of the package and label. Required in many jurisdictions for environmental compliance.',
    `regulatory_jurisdiction` STRING COMMENT 'Three-letter ISO country code identifying the regulatory jurisdiction for which this label specification is designed. Determines applicable food safety and labeling laws.. Valid values are `^[A-Z]{3}$`',
    `special_handling_instructions` STRING COMMENT 'Instructions for special handling, storage, or preparation of the product. Examples include refrigeration requirements, shake before use, or heating instructions.',
    `substrate_material` STRING COMMENT 'Type of material used for the label substrate. Impacts sustainability reporting, recycling instructions, and environmental compliance.. Valid values are `paper|plastic|foil|biodegradable|compostable`',
    `sustainability_claim_text` STRING COMMENT 'Marketing claims related to sustainability, environmental impact, or corporate social responsibility. Must be substantiated per FTC (Federal Trade Commission) Green Guides.',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the product is certified vegan and contains no animal-derived ingredients or by-products.',
    CONSTRAINT pk_label_spec PRIMARY KEY(`label_spec_id`)
) COMMENT 'Label specification and artwork management record for each SKU per market/jurisdiction. Captures label version, label type (front panel, back panel, neck label, cap label, case label), regulatory jurisdiction, language, label dimensions, mandatory claim text, marketing claims (clean label, non-GMO, organic, kosher, halal), warning statements, country of origin declaration, net quantity statement, manufacturer/distributor name and address, and artwork approval status. Tracks FDA/USDA/EFSA label compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`product_standard_cost` (
    `product_standard_cost_id` BIGINT COMMENT 'Primary key for standard_cost',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to product.bill_of_materials. Business justification: Standard cost roll-ups in F&B are directly derived from the Bill of Materials — raw material costs, yield factors, and scrap percentages from BOM lines feed into the standard cost calculation. The pro',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the cost center responsible for this product cost. Links to the organizational unit that owns the cost build-up and variance accountability.',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the manufacturing plant or production site where this cost applies. Standard costs can vary by production location due to regional labor rates, overhead allocation, and sourcing differences.',
    `profit_center_id` BIGINT COMMENT 'Foreign key reference to the profit center for internal profitability reporting. Enables brand-level or category-level margin analysis and Return on Investment (ROI) tracking.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Annual standard cost setting in F&B uses contracted raw material and packaging prices as inputs. Linking product_standard_cost to the governing purchase_contract enables finance and procurement to tra',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: Standard cost calculations in F&B explicitly reference the routing to capture labor and overhead rates per operation. Routing defines standard production time per work center, which drives direct_labo',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master data. Links this cost record to the specific finished good product.',
    `approval_date` DATE COMMENT 'The date on which this standard cost was formally approved for use in financial reporting and pricing decisions. Part of the cost governance audit trail.',
    `copacker_toll_fee` DECIMAL(18,2) COMMENT 'Third-party manufacturing fee per unit when production is outsourced to a co-packer or toll manufacturer. Includes processing fee, packaging service, and contract manufacturing markup. Zero for internally manufactured SKUs.',
    `cost_estimate_number` STRING COMMENT 'Unique identifier for the costing run or cost estimate that generated this standard cost. Provides traceability to the source costing calculation and supports audit requirements.',
    `cost_status` STRING COMMENT 'Lifecycle status of the cost record: draft (under development), approved (validated but not yet active), active (currently in use for valuation), superseded (replaced by newer version), or archived (historical record).. Valid values are `draft|approved|active|superseded|archived`',
    `cost_variance_per_unit` DECIMAL(18,2) COMMENT 'Difference between current standard cost per unit and prior period cost per unit. Positive values indicate cost increases; negative values indicate cost reductions. Key metric for cost management and margin protection.',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage change in standard cost per unit compared to prior period. Calculated as (cost_variance_per_unit / prior_period_cost_per_unit) * 100. Used for executive dashboards and cost escalation alerts.',
    `cost_version` STRING COMMENT 'Identifies the type of cost record: current standard (active production cost), prior year (historical comparison), budget (annual plan), forecast (updated projection), planned (future state), or actual (realized cost). Enables variance analysis and cost trend tracking.. Valid values are `current_standard|prior_year|budget|forecast|planned|actual`',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'Standard production batch or lot size used as the basis for cost calculation. Affects fixed cost allocation per unit. Typically expressed in cases or production units.',
    `costing_method` STRING COMMENT 'Inventory valuation method applied to this SKU: standard (predetermined cost), average (moving average), First In First Out (FIFO), Last In First Out (LIFO), or weighted average. Determines how inventory is valued on the balance sheet.. Valid values are `standard|average|fifo|lifo|weighted_average`',
    `costing_run_date` DATE COMMENT 'The date on which the cost estimate was executed and this standard cost was calculated. Supports cost history tracking and regulatory compliance for cost substantiation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was first created in the system. Part of the audit trail for cost data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the standard cost is denominated (e.g., USD, EUR, GBP). Critical for multi-currency operations and consolidation.. Valid values are `^[A-Z]{3}$`',
    `direct_labor_cost` DECIMAL(18,2) COMMENT 'Direct labor cost per unit allocated from production operations including line operators, batch technicians, and quality inspectors. Based on standard labor hours and wage rates per manufacturing routing.',
    `effective_date` DATE COMMENT 'The date from which this standard cost becomes active and is used for valuation, pricing, and financial reporting. Supports cost roll-forward and period-over-period variance analysis.',
    `expiration_date` DATE COMMENT 'The date on which this standard cost record is superseded by a new cost version. Nullable for open-ended current standard costs.',
    `freight_in_cost` DECIMAL(18,2) COMMENT 'Inbound freight and logistics cost per unit to deliver raw materials and packaging to the production site. Includes transportation, handling, and customs duties. Part of landed cost calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost record was last updated. Supports change tracking and cost variance investigation.',
    `manufacturing_overhead_cost` DECIMAL(18,2) COMMENT 'Allocated manufacturing overhead per unit including utilities, equipment depreciation, plant supervision, maintenance, quality assurance, and facility costs. Allocated based on cost center rates and activity drivers per Good Manufacturing Practice (GMP) standards.',
    `notes` STRING COMMENT 'Free-text field for cost accountants to document assumptions, adjustments, or special circumstances affecting this cost record (e.g., commodity hedging impact, one-time tooling amortization, co-packer contract changes).',
    `packaging_cost` DECIMAL(18,2) COMMENT 'Total cost of all packaging materials per unit including primary packaging (bottles, pouches, wrappers), secondary packaging (cartons, trays), and tertiary packaging (pallets, shrink wrap). Sourced from BOM packaging line items.',
    `price_control_indicator` STRING COMMENT 'SAP price control flag: S (standard price - cost remains fixed until manually updated) or V (moving average price - cost recalculated with each goods receipt). Determines inventory valuation behavior.. Valid values are `S|V`',
    `prior_period_cost_per_unit` DECIMAL(18,2) COMMENT 'Total standard cost per unit from the previous costing period. Enables period-over-period variance analysis and cost trend tracking for Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) reporting.',
    `raw_material_cost` DECIMAL(18,2) COMMENT 'Total cost of all raw materials and ingredients per unit as defined in the Bill of Materials (BOM). Includes commodity costs, agricultural inputs, and base formulation components. Key driver of Cost of Goods Sold (COGS).',
    `total_standard_cost_per_case` DECIMAL(18,2) COMMENT 'Fully-loaded standard cost per case or shipping unit. Calculated as total_standard_cost_per_unit multiplied by units per case. Primary cost metric for trade promotion Return on Investment (ROI) analysis and Distribution Center (DC) valuation.',
    `total_standard_cost_per_unit` DECIMAL(18,2) COMMENT 'Fully-loaded standard cost per individual unit (e.g., per bottle, per pouch, per bar). Sum of raw material, packaging, direct labor, manufacturing overhead, co-packer fee, and freight-in costs. Used for unit-level profitability analysis and Recommended Selling Price (RSP) calculation.',
    `units_per_case` STRING COMMENT 'Number of individual consumer units (bottles, pouches, bars) contained in one case or shipping unit. Used to convert between unit-level and case-level cost metrics.',
    `valuation_class` STRING COMMENT 'SAP valuation class code that determines the General Ledger (GL) accounts to which inventory and Cost of Goods Sold (COGS) transactions are posted. Links product costing to financial accounting.',
    CONSTRAINT pk_product_standard_cost PRIMARY KEY(`product_standard_cost_id`)
) COMMENT 'Standard cost record for each SKU capturing the fully-loaded COGS build-up: raw material cost, packaging cost, direct labor, manufacturing overhead, co-pack/toll manufacturing fee, freight-in, and total standard cost per case and per unit. Tracks cost version (current standard, prior year, budget, forecast), effective date, plant/production site, currency, and variance to prior period. Owned by product domain as the authoritative product-level cost attribute; feeds pricing strategy (RSP, EDLP), trade promotion ROI, and financial reporting. Sourced from SAP S/4HANA CO module.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for category',
    `parent_category_id` BIGINT COMMENT 'Identifier of the immediate parent category for hierarchical organization.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: F&B category management and trade marketing require mapping product categories to consumer segments for portfolio strategy, assortment planning, and Nielsen/IRI reporting. target_market is a denorma',
    `allergen_info` STRING COMMENT 'Allergen statements applicable to the category (e.g., contains nuts, gluten‑free).',
    `category_code` STRING COMMENT 'Short alphanumeric code used to reference the category in external systems.',
    `category_description` STRING COMMENT 'Detailed textual description of the category.',
    `category_name` STRING COMMENT 'Human‑readable name of the product category.',
    `category_status` STRING COMMENT 'Current lifecycle status of the category.',
    `category_type` STRING COMMENT 'High‑level classification of the category (e.g., Food, Beverage).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the category becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer valid (null if indefinite).',
    `hierarchy_level` STRING COMMENT 'Depth of the category within the category tree (root = 0).',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether items in this category are perishable (true) or non‑perishable (false).',
    `marketing_description` STRING COMMENT 'Consumer‑facing description used in marketing materials.',
    `nutritional_profile` STRING COMMENT 'Standard nutritional characteristics for the category (e.g., high protein, low sugar).',
    `packaging_type` STRING COMMENT 'Standard packaging format for items in this category.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification governing the category (e.g., GRAS, FDA approved).',
    `shelf_life_days` STRING COMMENT 'Typical shelf life of products within this category, expressed in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Master reference table for category. Referenced by category_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `food_beverage_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_node_hierarchy_id` FOREIGN KEY (`parent_node_hierarchy_id`) REFERENCES `food_beverage_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `food_beverage_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_nutritional_panel_id` FOREIGN KEY (`nutritional_panel_id`) REFERENCES `food_beverage_ecm`.`product`.`nutritional_panel`(`nutritional_panel_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_packaging_spec_id` FOREIGN KEY (`packaging_spec_id`) REFERENCES `food_beverage_ecm`.`product`.`packaging_spec`(`packaging_spec_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'item_definition');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `abv` SET TAGS ('dbx_business_glossary_term' = 'Alcohol by Volume (ABV)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `allergen_matrix` SET TAGS ('dbx_business_glossary_term' = 'Allergen Matrix');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `brix_target` SET TAGS ('dbx_business_glossary_term' = 'Brix Target');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `calories_per_serving` SET TAGS ('dbx_business_glossary_term' = 'Calories per Serving');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `clean_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `flavor_variety` SET TAGS ('dbx_business_glossary_term' = 'Flavor or Variety');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Form Factor');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}|[0-9]{12}|[0-9]{13}|[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `net_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Volume');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `ph_max` SET TAGS ('dbx_business_glossary_term' = 'pH Maximum');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `ph_min` SET TAGS ('dbx_business_glossary_term' = 'pH Minimum');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `plm_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Stage');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|on hold|seasonal|pending launch|phase out');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `recyclable_flag` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `serving_size` SET TAGS ('dbx_business_glossary_term' = 'Serving Size');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `servings_per_container` SET TAGS ('dbx_business_glossary_term' = 'Servings per Container');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_max` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_min` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `vegetarian_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'item_definition');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `parent_node_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `allergen_category` SET TAGS ('dbx_business_glossary_term' = 'Allergen Category Classification');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `brand_owner` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `category_captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `channel_strategy` SET TAGS ('dbx_business_glossary_term' = 'Channel Strategy');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `clean_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth Level');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `innovation_platform_flag` SET TAGS ('dbx_business_glossary_term' = 'Innovation Platform Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `iri_category_code` SET TAGS ('dbx_business_glossary_term' = 'Information Resources Inc (IRI) Category Code');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Code');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `nielsen_category_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Category Code');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path String');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `portfolio_tier` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Tier Classification');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `portfolio_tier` SET TAGS ('dbx_value_regex' = 'core|growth|emerging|harvest|divest');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category Classification');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` SET TAGS ('dbx_subdomain' = 'recipe_composition');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Document ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `batch_size_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `batch_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|inactive|obsolete');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'production|co_pack|toll_manufacturing|rework|sample|trial');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `clean_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `contains_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Genetically Modified Organism (GMO) Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `cost_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Amount');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `cost_estimate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `cost_estimate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Currency');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `cost_estimate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `haccp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Critical Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `plm_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `plm_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Approval Status');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `plm_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|under_review|approved|rejected|conditional_approval');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'recipe_composition');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `component_category` SET TAGS ('dbx_business_glossary_term' = 'Component Category');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `critical_allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `lot_size_multiple` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Multiple');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO (Genetically Modified Organism) Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `quantity_per_base_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Component Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_temperature|dry|other');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `yield_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Factor Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` SET TAGS ('dbx_subdomain' = 'recipe_composition');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Batch Size');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_value_regex' = 'kg|L|gal|lb');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `clean_label_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `cooling_temperature` SET TAGS ('dbx_business_glossary_term' = 'Cooling Temperature in Celsius');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Expiration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Formulation Name');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_status` SET TAGS ('dbx_business_glossary_term' = 'Formulation Status');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|obsolete|superseded');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_value_regex' = 'bench|pilot|commercial|experimental|prototype|scale_up');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `holding_time` SET TAGS ('dbx_business_glossary_term' = 'Holding Time in Minutes');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `homogenization_pressure` SET TAGS ('dbx_business_glossary_term' = 'Homogenization Pressure in PSI');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `mixing_speed` SET TAGS ('dbx_business_glossary_term' = 'Mixing Speed in RPM');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `mixing_time` SET TAGS ('dbx_business_glossary_term' = 'Mixing Time in Minutes');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `moisture_content_target` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Target Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO (Genetically Modified Organism) Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `pasteurization_temperature` SET TAGS ('dbx_business_glossary_term' = 'Pasteurization Temperature');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `pasteurization_time` SET TAGS ('dbx_business_glossary_term' = 'Pasteurization Time in Seconds');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|FSANZ|Health_Canada|ANVISA');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `target_brix` SET TAGS ('dbx_business_glossary_term' = 'Target Brix (Sugar Content)');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `target_ph_max` SET TAGS ('dbx_business_glossary_term' = 'Target pH (Potential of Hydrogen) Maximum');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `target_ph_min` SET TAGS ('dbx_business_glossary_term' = 'Target pH (Potential of Hydrogen) Minimum');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `target_viscosity` SET TAGS ('dbx_business_glossary_term' = 'Target Viscosity');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Number');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_value_regex' = 'cP|mPa_s|Pa_s');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `water_activity_aw` SET TAGS ('dbx_business_glossary_term' = 'Water Activity (Aw)');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Formulation Yield Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `nutritional_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Panel Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `added_sugars_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `added_sugars_grams` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `allergen_statement` SET TAGS ('dbx_business_glossary_term' = 'Allergen Statement');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `calcium_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Calcium Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `calcium_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Calcium in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `calories_from_fat` SET TAGS ('dbx_business_glossary_term' = 'Calories From Fat');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `calories_per_serving` SET TAGS ('dbx_business_glossary_term' = 'Calories Per Serving');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `cholesterol_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Cholesterol Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `cholesterol_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Cholesterol in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `dietary_fiber_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Dietary Fiber Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `dietary_fiber_grams` SET TAGS ('dbx_business_glossary_term' = 'Dietary Fiber in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `fda_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Submission Reference');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `ingredient_statement` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Statement');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `iron_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Iron Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `iron_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Iron in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `lab_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Reference');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `monounsaturated_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Monounsaturated Fat in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_format_standard` SET TAGS ('dbx_business_glossary_term' = 'Panel Format Standard');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_format_standard` SET TAGS ('dbx_value_regex' = 'FDA Nutrition Facts|EU Nutrition Declaration|Health Canada Nutrition Facts|Codex|LATAM|APAC Custom');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|superseded|retired');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_version` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Panel Version');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `panel_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `polyunsaturated_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Polyunsaturated Fat in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `potassium_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Potassium Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `potassium_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Potassium in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `protein_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Protein Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `protein_grams` SET TAGS ('dbx_business_glossary_term' = 'Protein in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `rounding_method` SET TAGS ('dbx_business_glossary_term' = 'Rounding Method');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `rounding_method` SET TAGS ('dbx_value_regex' = 'FDA Standard|EU Standard|Custom');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `saturated_fat_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `saturated_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `serving_size` SET TAGS ('dbx_business_glossary_term' = 'Serving Size');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `serving_size_grams` SET TAGS ('dbx_business_glossary_term' = 'Serving Size in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `servings_per_container` SET TAGS ('dbx_business_glossary_term' = 'Servings Per Container');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `sodium_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Sodium Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `sodium_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Sodium in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `sugar_alcohols_grams` SET TAGS ('dbx_business_glossary_term' = 'Sugar Alcohols in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `total_carbohydrate_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `total_carbohydrate_grams` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `total_fat_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Fat Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `total_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Total Fat in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `total_sugars_grams` SET TAGS ('dbx_business_glossary_term' = 'Total Sugars in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `trans_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Trans Fat in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `usda_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'USDA (United States Department of Agriculture) Submission Reference');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `vitamin_a_iu` SET TAGS ('dbx_business_glossary_term' = 'Vitamin A in International Units (IU)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `vitamin_c_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C in Milligrams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `vitamin_d_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Vitamin D Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `vitamin_d_micrograms` SET TAGS ('dbx_business_glossary_term' = 'Vitamin D in Micrograms');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Compliance Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier ID');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `barrier_properties` SET TAGS ('dbx_business_glossary_term' = 'Barrier Properties');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `bio_based_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Bio-Based Content Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `bpa_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Bisphenol A (BPA) Free Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `cases_per_layer` SET TAGS ('dbx_business_glossary_term' = 'Cases Per Layer');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `child_resistant_flag` SET TAGS ('dbx_business_glossary_term' = 'Child-Resistant Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `compostable_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Compostable Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `depth_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Depth (Millimeters)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Diameter (Millimeters)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `fill_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume (Milliliters)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `food_contact_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Contact Approved Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `freezer_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Freezer Safe Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `gross_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Grams)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Height (Millimeters)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `label_panel_count` SET TAGS ('dbx_business_glossary_term' = 'Label Panel Count');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `layers_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Layers Per Pallet');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Type');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `microwave_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Microwave Safe Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `net_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Grams)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_level` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|display');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_spec_status` SET TAGS ('dbx_value_regex' = 'active|pending_approval|obsolete|discontinued|under_revision');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `pallet_pattern` SET TAGS ('dbx_business_glossary_term' = 'Pallet Pattern');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `pallet_ti_hi` SET TAGS ('dbx_business_glossary_term' = 'Pallet Ti-Hi Configuration');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `pallet_ti_hi` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}x[0-9]{1,2}$');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `pcr_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Post-Consumer Recycled (PCR) Content Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `recyclability_code` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Code');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `recyclability_code` SET TAGS ('dbx_value_regex' = '^[1-7]$|^[1-7]-[A-Z]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification Code');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_value_regex' = '^PKG-[A-Z0-9]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `spec_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `spec_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `srp_configuration` SET TAGS ('dbx_business_glossary_term' = 'Shelf-Ready Packaging (SRP) Configuration');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `srp_configuration` SET TAGS ('dbx_value_regex' = 'full_case|half_case|tray|wrap|none');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `tamper_evident_flag` SET TAGS ('dbx_business_glossary_term' = 'Tamper-Evident Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `tare_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Grams)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Container Width (Millimeters)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `accelerated_testing_flag` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Testing Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `consumer_date_format` SET TAGS ('dbx_business_glossary_term' = 'Consumer Date Format Pattern');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `consumer_date_format` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}(/[A-Z]{2,10})*$');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `consumer_date_label_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer-Facing Date Label Type');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `consumer_date_label_type` SET TAGS ('dbx_value_regex' = 'best_by|use_by|sell_by|expires_on');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `date_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Best-By Date Calculation Method');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `date_calculation_method` SET TAGS ('dbx_value_regex' = 'manufacture_plus_offset|fixed_calendar|batch_specific');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `dc_receiving_standard` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Receiving Standard');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `frozen_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Frozen Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `fsma_204_traceability_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) 204 Traceability Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `light_sensitivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitivity Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `mrsl_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (MRSL) at Shipment (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `open_dating_regulation` SET TAGS ('dbx_business_glossary_term' = 'Open Dating Regulation Reference');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `post_opening_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Post-Opening Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `quality_hold_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Threshold (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `retailer_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Retailer Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'FIFO|FEFO|LIFO');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `shelf_life_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `shelf_life_spec_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|obsolete');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `shelf_life_testing_protocol` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Testing Protocol Reference');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Humidity (Percent)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Humidity (Percent)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `temperature_excursion_tolerance_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Tolerance (Hours)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `total_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Total Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `nutritional_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Panel Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `adhesive_type` SET TAGS ('dbx_business_glossary_term' = 'Adhesive Type');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `adhesive_type` SET TAGS ('dbx_value_regex' = 'permanent|removable|freezer_grade|high_tack|low_tack');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `allergen_warning_text` SET TAGS ('dbx_business_glossary_term' = 'Allergen Warning Text');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `artwork_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Artwork Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `artwork_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Artwork Approval Status');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `artwork_file_path` SET TAGS ('dbx_business_glossary_term' = 'Artwork File Path');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `barcode_type` SET TAGS ('dbx_value_regex' = 'UPC-A|EAN-13|ITF-14|GS1-128|QR|DataMatrix');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `barcode_value` SET TAGS ('dbx_business_glossary_term' = 'Barcode Value');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `clean_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Label Height in Millimeters');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_business_glossary_term' = 'Label Version Code');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Label Width in Millimeters');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `mandatory_claim_text` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Claim Text');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `net_quantity_statement` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity Statement');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `non_gmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO (Genetically Modified Organism) Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `print_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Print Vendor Code');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `print_vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `qr_code_url` SET TAGS ('dbx_business_glossary_term' = 'QR (Quick Response) Code URL');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `qr_code_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `recycling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Recycling Instructions');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `substrate_material` SET TAGS ('dbx_business_glossary_term' = 'Substrate Material Type');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `substrate_material` SET TAGS ('dbx_value_regex' = 'paper|plastic|foil|biodegradable|compostable');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `sustainability_claim_text` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Claim Text');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` SET TAGS ('dbx_subdomain' = 'recipe_composition');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `product_standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `copacker_toll_fee` SET TAGS ('dbx_business_glossary_term' = 'Co-Packer / Toll Manufacturing Fee');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Number');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|superseded|archived');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_variance_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Per Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_version` SET TAGS ('dbx_value_regex' = 'current_standard|prior_year|budget|forecast|planned|actual');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `costing_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `costing_method` SET TAGS ('dbx_value_regex' = 'standard|average|fifo|lifo|weighted_average');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `costing_run_date` SET TAGS ('dbx_business_glossary_term' = 'Costing Run Date');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `direct_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Direct Labor Cost');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `freight_in_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight-In Cost');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `manufacturing_overhead_cost` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Overhead Cost');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Notes');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `prior_period_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Cost Per Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Cost');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `total_standard_cost_per_case` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cost Per Case');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `total_standard_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cost Per Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `food_beverage_ecm`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`category` SET TAGS ('dbx_subdomain' = 'item_definition');
ALTER TABLE `food_beverage_ecm`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`category` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
