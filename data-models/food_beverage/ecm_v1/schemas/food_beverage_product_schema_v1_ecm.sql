-- Schema for Domain: product | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`product` COMMENT 'Single source of truth for all finished goods master data across the F&B portfolio — SKUs, GTINs, UPCs, BOMs, formulations, recipes, nutritional panels, allergen matrices, packaging specifications, shelf life, and product lifecycle management (PLM) from NPD through commercialization and discontinuation. Governs product hierarchy from brand down to individual pack size and variant.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the Stock Keeping Unit. Primary key for the SKU master data product.',
    `brand_id` BIGINT COMMENT 'Reference to the brand under which this SKU is marketed and sold.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity assignment per SKU needed for inter‑company profit/loss consolidation and tax reporting.',
    `cost_plus_model_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_plus_model. Business justification: Cost‑Plus Pricing Model linkage needed to apply a markup model to individual SKUs for margin planning.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Links a SKU to its ESG disclosure record for regulatory reporting (e.g., EU CSRD, GRI).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account mapping required for sales posting per SKU; essential for financial reporting of product sales.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Each SKU belongs to a node in the product hierarchy, enabling classification and reporting. Adding product_hierarchy_id FK eliminates redundant category fields.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Tracks which ESG initiative a SKU participates in; used in annual sustainability performance dashboards.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Required for SKU‑level packaging sustainability reporting; product packaging spec references a packaging profile for carbon/waste metrics.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for Price List Assignment process where each SKU is linked to a governing price list for channel pricing governance.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Geographic Price Zone assignment ties each SKU to a zone for region‑specific pricing rules.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Required for SKU‑level supplier assignment used in sourcing decisions, cost modeling, and supplier scorecard reporting.',
    `procedure_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_procedure. Business justification: Pricing Procedure Assignment in SAP: each SKU follows a specific pricing procedure for calculation rules.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Product Owner assignment in SKU lifecycle governance report.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`gtin_registry` (
    `gtin_registry_id` BIGINT COMMENT 'Unique identifier for each GTIN registry record. Primary key for the GTIN registry data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Associates GTIN registry changes with employee, needed for traceability and audit logs.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master data product. Links the GTIN to the specific product SKU it represents.',
    `activation_date` DATE COMMENT 'The date on which this GTIN became active and available for commercial use in transactions, scanning, and EDI. May differ from assignment date if there is a staging period.',
    `assignment_date` DATE COMMENT 'The date on which this GTIN was officially assigned to the SKU and packaging level. Marks the beginning of the GTINs lifecycle in the registry.',
    `barcode_symbology` STRING COMMENT 'The specific barcode encoding format used to represent this GTIN on the physical packaging. Determines the visual barcode pattern printed on labels and packaging materials.. Valid values are `UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|GS1 DataBar`',
    `brand_owner_gln` STRING COMMENT 'The 13-digit GS1 Global Location Number identifying the legal entity that owns the brand associated with this GTIN. Used for supply chain partner identification and EDI transactions.. Valid values are `^[0-9]{13}$`',
    `cases_per_pallet` STRING COMMENT 'The standard number of cases stacked on one pallet when this GTIN represents a pallet-level packaging tier. Used for transportation planning and warehouse slotting.',
    `check_digit` STRING COMMENT 'The single-digit checksum calculated using the GS1 check digit algorithm to validate the integrity of the GTIN. Always the last digit of the GTIN.. Valid values are `^[0-9]{1}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GTIN registry record was first created in the system. Used for audit trail and data lineage tracking.',
    `ean` STRING COMMENT 'The 13-digit EAN barcode number used internationally (especially Europe) for consumer unit scanning. Equivalent to GTIN-13 format.. Valid values are `^[0-9]{13}$`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'The total weight of the trade item including product, packaging, and any inner materials, expressed in kilograms. Used for logistics planning, freight calculations, and warehouse capacity management.',
    `gs1_company_prefix` STRING COMMENT 'The unique company prefix assigned by GS1 to the brand owner or manufacturer. This prefix is the first segment of all GTINs issued by this company and identifies the organization globally within the GS1 system.. Valid values are `^[0-9]{6,12}$`',
    `gs1_registration_date` DATE COMMENT 'The date on which this GTIN was registered with GS1. Required for compliance with GS1 standards and for inclusion in the GS1 Global Registry.',
    `gs1_registration_status` STRING COMMENT 'Indicates whether this GTIN has been formally registered with GS1 and is in good standing. Registration is required for global trade and ensures GTIN uniqueness across the industry.. Valid values are `registered|pending_registration|not_registered|registration_expired`',
    `gtin` STRING COMMENT 'The complete GTIN value assigned to this SKU at this packaging level. May be GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14 (ITF-14 case code). This is the authoritative barcode identifier used for scanning, EDI transactions, and retailer item setup.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `gtin_change_reason` STRING COMMENT 'Free-text explanation of why this GTIN was assigned or changed. GS1 rules require a new GTIN when there are material changes to formulation, net content, allergens, or packaging that affect consumer purchasing decisions.',
    `gtin_status` STRING COMMENT 'Current lifecycle status of this GTIN assignment. Active GTINs are in commercial use, pending are awaiting launch, reserved are allocated but not yet assigned, retired are discontinued, and recalled are withdrawn from market.. Valid values are `active|inactive|pending|reserved|retired|recalled`',
    `gtin_type` STRING COMMENT 'The specific GTIN format variant used for this trade item. GTIN-8 for small items, GTIN-12 for UPC (North America consumer units), GTIN-13 for EAN (international consumer units), GTIN-14 for case and pallet codes.. Valid values are `GTIN-8|GTIN-12|GTIN-13|GTIN-14`',
    `is_base_unit` BOOLEAN COMMENT 'Boolean flag indicating whether this GTIN represents the base unit of measure for inventory and sales tracking. Typically the each or consumer unit level. All other packaging levels are multiples of the base unit.',
    `is_consumer_unit` BOOLEAN COMMENT 'Boolean flag indicating whether this GTIN represents a consumer-facing unit intended for individual sale at retail point of sale. Consumer units require full regulatory labeling including nutritional panels and allergen declarations.',
    `is_orderable` BOOLEAN COMMENT 'Boolean flag indicating whether this GTIN can be ordered directly by customers or retailers. Some GTINs (e.g., display shippers) may be non-orderable and exist only for scanning and tracking purposes.',
    `item_reference` STRING COMMENT 'The company-assigned portion of the GTIN that uniquely identifies the specific product within the company prefix namespace. Combined with company prefix and check digit to form the complete GTIN.',
    `manufacturer_gln` STRING COMMENT 'The 13-digit GS1 Global Location Number identifying the physical manufacturing location or co-packer that produces the item with this GTIN. May differ from brand owner for toll manufacturing arrangements.. Valid values are `^[0-9]{13}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this GTIN registry record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `net_content_uom` STRING COMMENT 'The unit of measure for the net content value. Must comply with regulatory requirements for the target market (metric for most international markets, US customary for USA). [ENUM-REF-CANDIDATE: g|kg|mg|oz|lb|ml|l|fl_oz|gal|count|each — 11 candidates stripped; promote to reference product]',
    `net_content_value` DECIMAL(18,2) COMMENT 'The numeric quantity of product contained in this packaging level, expressed in the unit specified by net_content_uom. Required for regulatory labeling and consumer transparency.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'The weight of the product itself excluding all packaging materials, expressed in kilograms. Required for nutritional labeling calculations and regulatory compliance.',
    `package_depth_cm` DECIMAL(18,2) COMMENT 'The front-to-back depth dimension of the trade item packaging in centimeters. Used for warehouse slotting, planogram design, and transportation cube calculations.',
    `package_height_cm` DECIMAL(18,2) COMMENT 'The vertical dimension of the trade item packaging in centimeters. Used for warehouse slotting, planogram design, and transportation cube calculations.',
    `package_width_cm` DECIMAL(18,2) COMMENT 'The horizontal width dimension of the trade item packaging in centimeters. Used for warehouse slotting, planogram design, and transportation cube calculations.',
    `packaging_level` STRING COMMENT 'The hierarchical packaging tier that this GTIN represents within the product packaging hierarchy. Each level from consumer unit up to pallet requires a unique GTIN for supply chain traceability and EDI transactions. [ENUM-REF-CANDIDATE: each|consumer_unit|inner_pack|display_shipper|case|master_case|pallet|mixed_pallet — 8 candidates stripped; promote to reference product]',
    `predecessor_gtin` STRING COMMENT 'The previous GTIN that this GTIN replaces, if applicable. Used to maintain continuity in sales history and retailer item setup when a GTIN change is required per GS1 rules.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `requires_freezing` BOOLEAN COMMENT 'Boolean flag indicating whether this trade item must be stored and transported under frozen conditions. Drives frozen supply chain and warehouse requirements.',
    `requires_refrigeration` BOOLEAN COMMENT 'Boolean flag indicating whether this trade item must be stored and transported under refrigerated conditions to maintain food safety and quality. Drives cold chain logistics requirements.',
    `retirement_date` DATE COMMENT 'The date on which this GTIN was retired from active use due to product discontinuation, packaging change, or formulation change requiring a new GTIN per GS1 rules. Nullable for active GTINs.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'The maximum safe storage temperature for this trade item in degrees Celsius. Critical for cold chain compliance and food safety management per HACCP principles.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'The minimum safe storage temperature for this trade item in degrees Celsius. Critical for cold chain compliance and food safety management per HACCP principles.',
    `target_market` STRING COMMENT 'The primary country or market for which this GTIN and packaging configuration is intended. Uses ISO 3166-1 alpha-3 country codes. Important for regulatory compliance and retailer setup.. Valid values are `^[A-Z]{3}$`',
    `units_per_case` STRING COMMENT 'The number of consumer units (each) contained within one case when this GTIN represents a case-level packaging tier. Used for order quantity calculations and warehouse management.',
    `upc` STRING COMMENT 'The 12-digit UPC-A barcode number used primarily in North America for consumer unit scanning at point of sale. Subset of GTIN-12 format.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_gtin_registry PRIMARY KEY(`gtin_registry_id`)
) COMMENT 'Authoritative registry of all Global Trade Item Numbers (GTINs), UPCs, EANs, and ITF-14 case codes assigned to each SKU across all packaging levels (each, inner pack, case, pallet). Tracks GS1 company prefix, GTIN-8/12/13/14 variants, barcode symbology, packaging level (consumer unit, display shipper, master case, pallet), assignment date, and GS1 registration status. Enables barcode scanning, EDI transactions, and retailer item setup.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for each node in the product hierarchy structure. Primary key for the product hierarchy entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeting process allocates cost‑center budgets to product categories; hierarchy node links to cost_center for expense planning.',
    `parent_node_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the hierarchy structure. Null for top-level Division nodes. Enables recursive hierarchy traversal and roll-up reporting.',
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
    `target_consumer_segment` STRING COMMENT 'Primary consumer demographic or psychographic segment targeted by products in this hierarchy node. Examples: Health-Conscious Millennials, Family Households, Premium Adult Consumers. Used for marketing strategy and trade promotion planning.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the multi-level product classification hierarchy from corporate portfolio down to individual SKU variant: Division → Category → Sub-Category → Brand → Sub-Brand → Product Line → Variant → Pack Size. Each node carries a hierarchy level code, parent node reference, hierarchy path string, and effective date range. Used for reporting roll-ups, trade promotion planning, category management, and planogram slotting. Aligns with Nielsen/IRI category taxonomy for syndicated data integration.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`bill_of_materials` (
    `bill_of_materials_id` BIGINT COMMENT 'Primary key for bill_of_materials',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks employee owning formulation for BOM, needed in formulation approval and cost allocation.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing site or plant that owns and uses this BOM. BOMs may be plant-specific due to equipment capabilities, ingredient sourcing, or regional formulation requirements.',
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
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header that this line belongs to. Links the component to the finished good SKU.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the primary or preferred supplier for this component, used for procurement planning and vendor management.',
    `allergen_type` STRING COMMENT 'Specific allergen classification if critical_allergen_flag is true (e.g., milk, eggs, peanuts, tree nuts, soy, wheat, fish, shellfish, sesame). Multiple allergens separated by semicolon.',
    `base_uom` STRING COMMENT 'The base unit of measure for the component quantity (e.g., KG, LB, L, GAL, EA, M, FT).',
    `bom_line_status` STRING COMMENT 'Current lifecycle status of this BOM line (active, inactive, pending approval, obsolete).. Valid values are `active|inactive|pending|obsolete`',
    `change_number` STRING COMMENT 'The engineering change order or product lifecycle management (PLM) change number that authorized this BOM line modification, used for traceability and compliance.',
    `component_category` STRING COMMENT 'Classification of the component type within the BOM structure (e.g., raw material, ingredient, packaging, label, co-product). [ENUM-REF-CANDIDATE: raw_material|ingredient|flavoring|preservative|packaging|label|co_product|other — 8 candidates stripped; promote to reference product]',
    `component_description` STRING COMMENT 'Human-readable description of the component material, including brand, grade, or specification details.',
    `component_item_number` STRING COMMENT 'The material number or SKU code of the component (raw material, ingredient, packaging, label, or co-product) required for production.',
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
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Nutritional panels must align with regulatory product registration data for compliance reporting and label generation.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which this nutritional panel applies. Links to the product SKU master data.',
    `added_sugars_dv_percent` DECIMAL(18,2) COMMENT 'Percentage of the daily value for added sugars per serving.',
    `added_sugars_grams` DECIMAL(18,2) COMMENT 'Added sugar content per serving, expressed in grams. Required under updated FDA regulations (2016+).',
    `additional_nutrients_json` STRING COMMENT 'JSON-formatted string capturing additional vitamins, minerals, and nutrients not covered by standard fields (e.g., Vitamin B6, B12, Zinc, Magnesium, Folate). Allows flexibility for jurisdiction-specific or voluntary nutrient declarations.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ensures packaging approval accountability for each SKU, used in packaging change control process.',
    `packaging_compliance_id` BIGINT COMMENT 'Foreign key linking to regulatory.packaging_compliance. Business justification: Packaging compliance verification requires each packaging spec to reference the compliance record for material and recycling regulations.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captures employee approving shelf life spec, used in quality assurance and compliance audits.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU this shelf life specification applies to. Links to the product SKU master data.',
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
    `specification_code` STRING COMMENT 'Business identifier for the shelf life specification, typically used in quality management and PLM systems.. Valid values are `^SLS-[A-Z0-9]{6,12}$`',
    `specification_version` STRING COMMENT 'Version number of this shelf life specification, incremented when specification parameters change.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `storage_humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity percentage allowed during storage to prevent product degradation. Null if humidity control is not required.',
    `storage_humidity_min_percent` DECIMAL(18,2) COMMENT 'Minimum relative humidity percentage required during storage to prevent product degradation. Null if humidity control is not required.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain product quality and safety throughout shelf life. Exceeding this temperature may compromise product integrity.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain product quality and safety throughout shelf life. Critical for cold chain integrity.',
    `temperature_excursion_tolerance_hours` STRING COMMENT 'Maximum number of hours the product can tolerate temperature excursions outside the specified range without compromising safety or quality. Null if no tolerance is allowed.',
    `total_shelf_life_days` STRING COMMENT 'Total number of days from manufacture date to end of shelf life (best-by or use-by date). Critical for FEFO inventory rotation and retailer compliance.',
    CONSTRAINT pk_shelf_life_spec PRIMARY KEY(`shelf_life_spec_id`)
) COMMENT 'Shelf life and storage condition specifications for each SKU, critical for FSMA 204 traceability compliance and retailer receiving standards. Captures total shelf life (days), minimum remaining shelf life at shipment (MRSL), best-by date calculation method (manufacture date + offset vs. fixed calendar), storage temperature range (min/max °C), humidity requirements, light sensitivity, FIFO/FEFO rotation rule, consumer-facing date format (Best By, Use By, Sell By), open-dating regulation compliance (state-level US, EU 1169/2011), and shelf life testing protocol reference. Governs FEFO inventory rotation, DC receiving standards, retailer compliance (e.g., Walmart 2/3 life remaining policy), and cold chain integrity requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`npd_project` (
    `npd_project_id` BIGINT COMMENT 'Unique identifier for the NPD project record. Primary key.',
    `brand_id` BIGINT COMMENT 'Identifier of the brand under which the resulting product will be marketed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NPD projects track incurred expenses against a dedicated cost center for project cost control and variance analysis.',
    `sku_id` BIGINT COMMENT 'Identifier of the existing SKU being reformulated or renovated. Null for net-new products.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: New product development projects must be linked to the regulatory registration they will generate, enabling tracking of submission status and deadlines.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Project profit performance is measured by assigning the NPD project to a profit center for revenue and margin reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assigns R&D lead employee for NPD project, required for project governance and resource planning.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: NPD projects set specific sustainability targets (carbon, water) that are tracked in the sustainability_target table.',
    `actual_launch_date` DATE COMMENT 'Actual date when the product was commercially launched. Null if not yet launched.',
    `business_case_approved_flag` BOOLEAN COMMENT 'Indicates whether the business case for this project has been formally approved by leadership.',
    `capital_investment_required` DECIMAL(18,2) COMMENT 'Total capital investment required for equipment, tooling, or facility modifications to support the new product.',
    `consumer_acceptance_score` DECIMAL(18,2) COMMENT 'Overall consumer acceptance score from sensory panel testing, typically on a scale of 1-9 (hedonic scale) or percentage acceptance.',
    `consumer_testing_completion_date` DATE COMMENT 'Date when consumer testing was completed. Null if not yet completed or not applicable.',
    `consumer_testing_required_flag` BOOLEAN COMMENT 'Indicates whether consumer sensory testing or market research is required for this project.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPD project record was first created in the PLM system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for target COGS and RSP amounts.. Valid values are `^[A-Z]{3}$`',
    `estimated_cogs_impact` DECIMAL(18,2) COMMENT 'Estimated change in COGS per unit resulting from reformulation (positive for cost increase, negative for cost reduction).',
    `estimated_incremental_revenue` DECIMAL(18,2) COMMENT 'Projected incremental annual revenue expected from the new product launch in the first full year.',
    `gate_decision` STRING COMMENT 'Decision outcome from the most recent gate review (Go: proceed to next stage, Conditional Go: proceed with conditions, Hold: pause, Kill: terminate, Recycle: return to previous stage).. Valid values are `go|conditional_go|hold|kill|recycle`',
    `gate_stage` STRING COMMENT 'Current stage-gate milestone in the NPD process (Gate 0: Idea, Gate 1: Concept, Gate 2: Feasibility, Gate 3: Development, Gate 4: Validation, Gate 5: Launch, Post-Launch Review). [ENUM-REF-CANDIDATE: gate_0|gate_1|gate_2|gate_3|gate_4|gate_5|post_launch_review — 7 candidates stripped; promote to reference product]',
    `innovation_type` STRING COMMENT 'Classification of the innovation level: breakthrough (new-to-world), platform (new-to-company), derivative (line extension), or packaging-only change.. Valid values are `breakthrough|platform|derivative|packaging_only`',
    `last_gate_review_date` DATE COMMENT 'Date of the most recent stage-gate review meeting for this project.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPD project record was last updated in the PLM system.',
    `marketing_lead` STRING COMMENT 'Name of the marketing manager responsible for brand positioning, consumer insights, and go-to-market strategy for the project.',
    `next_gate_review_date` DATE COMMENT 'Scheduled date for the next stage-gate review meeting.',
    `project_close_date` DATE COMMENT 'Date when the NPD project was formally closed after commercialization or cancellation.',
    `project_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the NPD project for tracking and reference across PLM, ERP, and project management systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `project_description` STRING COMMENT 'Detailed description of the NPD project objectives, scope, and key deliverables.',
    `project_name` STRING COMMENT 'Human-readable name of the NPD project describing the innovation or renovation initiative.',
    `project_priority` STRING COMMENT 'Business priority level assigned to the NPD project for resource allocation and portfolio management.. Valid values are `critical|high|medium|low`',
    `project_sponsor` STRING COMMENT 'Name of the executive or senior leader sponsoring and accountable for the NPD project.',
    `project_start_date` DATE COMMENT 'Date when the NPD project was officially initiated and resources allocated.',
    `project_status` STRING COMMENT 'Current lifecycle status of the NPD project in the stage-gate process from concept through commercialization. [ENUM-REF-CANDIDATE: concept|feasibility|development|validation|launch|commercialized|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the NPD project type indicating the nature of the product development initiative. [ENUM-REF-CANDIDATE: new_sku|line_extension|reformulation|repack|cost_reduction|seasonal_limited_edition|co_brand — 7 candidates stripped; promote to reference product]',
    `reformulation_flag` BOOLEAN COMMENT 'Indicates whether this project involves reformulation of an existing SKU (True) or is a net-new product (False).',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was received. Null if not yet approved or not applicable.',
    `regulatory_review_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory review and approval is required for this project due to formulation changes, new ingredients, or label claims.',
    `regulatory_submission_date` DATE COMMENT 'Date when regulatory submission was filed with FDA, USDA, or other governing body. Null if not applicable.',
    `target_cogs` DECIMAL(18,2) COMMENT 'Target cost of goods sold per unit for the new product, used for financial feasibility and margin planning.',
    `target_distribution_channel` STRING COMMENT 'Primary distribution channel targeted for the new product launch. [ENUM-REF-CANDIDATE: retail|foodservice|direct_to_consumer|e_commerce|club|convenience|mass_merchandiser — 7 candidates stripped; promote to reference product]',
    `target_launch_date` DATE COMMENT 'Planned date for commercial launch of the product resulting from this NPD project.',
    `target_market_geography` STRING COMMENT 'Geographic market or region where the product will be launched (e.g., USA, CAN, MEX, EUR).',
    `target_rsp` DECIMAL(18,2) COMMENT 'Target recommended selling price per unit for the new product at retail.',
    CONSTRAINT pk_npd_project PRIMARY KEY(`npd_project_id`)
) COMMENT 'New Product Development (NPD) project record tracking each innovation or renovation initiative from concept through commercialization. Captures project code, project name, project type (new SKU, line extension, reformulation, repack, cost reduction, seasonal limited edition, co-brand), target launch date, actual launch date, project sponsor, R&D lead, marketing lead, estimated COGS target, RSP target, target distribution channel, target market/geography, project status, gate review history, and estimated incremental revenue. Links to the resulting SKU(s) upon commercialization. Also governs reformulation requests including estimated COGS impact, regulatory review requirements, and consumer testing needs. Sourced from PLM system.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Launch event coordination requires linking each lifecycle event to the marketing campaign that supports it, enabling the Launch Calendar report.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Lifecycle events (e.g., GTIN change) trigger regulatory notifications; linking to product registration ensures updates are recorded and reported.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies employee responsible for lifecycle event, required for change impact and regulatory notification reports.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master data product. Identifies which finished good this lifecycle event applies to.',
    `approval_date` DATE COMMENT 'Date on which the lifecycle event was formally approved by the appropriate governance body (e.g., product committee, quality board, regulatory affairs). Used for compliance audit and SOX evidence.',
    `approval_reference_number` STRING COMMENT 'Reference identifier for the formal approval document, change request, or workflow instance that authorized this lifecycle event. Links to PLM, quality management, or regulatory systems for traceability.',
    `comments` STRING COMMENT 'Free-text field for additional context, special instructions, lessons learned, or cross-references to related events. Used for knowledge capture and future portfolio reviews.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this lifecycle event record was first created in the data platform. Used for audit trail and data lineage.',
    `customer_notification_date` DATE COMMENT 'Date on which customer notification was completed (e.g., EDI 832 Price/Sales Catalog sent, ASN updated, or direct communication sent). Null if notification is not required or still pending.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this lifecycle event requires formal notification to retail customers, distributors, or foodservice partners. True for discontinuations, allergen changes, or major repacks.',
    `customer_notification_status` STRING COMMENT 'Current status of the customer notification process for this lifecycle event. Tracks whether downstream partners (retailers, distributors, 3PLs) have been informed of the change.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `effective_end_date` DATE COMMENT 'The date until which the prior product state remains valid or the date by which old inventory must be depleted. Null for permanent changes with no transition period. Used for sell-through planning and recall traceability.',
    `effective_start_date` DATE COMMENT 'The date from which the new product state (post-event) is effective in the market, distribution network, or production system. Used for cutover planning and inventory management (FEFO/FIFO).',
    `event_date` DATE COMMENT 'The calendar date on which the lifecycle state change became effective in the market or production system. This is the business event date, distinct from system audit timestamps.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the lifecycle event, used for cross-functional communication and audit trail references. Format: LCE-XXXXXXXXXX.. Valid values are `^LCE-[0-9]{10}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the lifecycle event was recorded in the system, including timezone. Used for detailed audit trail and event sequencing.',
    `event_type` STRING COMMENT 'Classification of the lifecycle state change. Defines the nature of the transition: launch (new product introduction), reformulation (recipe or ingredient change), repack (packaging change without formula change), label_change (artwork or claims update), temporary_discontinuation (planned pause), permanent_discontinuation (end of life), reactivation (return from discontinuation), seasonal_rotation (planned seasonal availability change), regulatory_hold (compliance-driven suspension), specification_change (non-formula attribute update). [ENUM-REF-CANDIDATE: launch|reformulation|repack|label_change|temporary_discontinuation|permanent_discontinuation|reactivation|seasonal_rotation|regulatory_hold|specification_change — 10 candidates stripped; promote to reference product]',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of this lifecycle event in the companys reporting currency. Positive for cost savings or revenue opportunities; negative for write-offs, obsolescence, or lost sales. Used for portfolio management and business case validation.',
    `impact_assessment_completed_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a formal cross-functional impact assessment (covering quality, supply chain, finance, regulatory, and commercial) was completed before this lifecycle event was approved.',
    `impact_assessment_reference` STRING COMMENT 'Reference identifier for the impact assessment document or workflow instance. Links to PLM or quality management system for detailed analysis and stakeholder sign-offs.',
    `inventory_write_off_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this lifecycle event triggers an inventory write-off or obsolescence charge. True for permanent discontinuations, regulatory holds, or major reformulations requiring disposal of existing stock.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this lifecycle event record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `new_allergen_matrix` STRING COMMENT 'Comma-separated list or structured representation of allergens declared for the SKU after this lifecycle event. Used to track allergen additions, removals, or cross-contamination risk changes.',
    `new_gtin` STRING COMMENT 'The 14-digit GTIN assigned to the SKU after this lifecycle event. Used when a material change (formula, packaging, allergen) requires a new GTIN per GS1 standards.. Valid values are `^[0-9]{14}$`',
    `new_plm_stage` STRING COMMENT 'The PLM stage or product status that the SKU transitioned to as a result of this lifecycle event. Captures the to state in the state transition.',
    `new_product_name` STRING COMMENT 'The consumer-facing product name or description that became effective after this lifecycle event. Used for rebranding, label updates, or marketing claim changes.',
    `new_shelf_life_days` STRING COMMENT 'The number of days of shelf life assigned to the SKU after this lifecycle event. Used when reformulation, packaging change, or preservative adjustment impacts product stability.',
    `new_upc` STRING COMMENT 'The 12-digit UPC assigned to the SKU after this lifecycle event. Used when packaging or product changes require a new UPC.. Valid values are `^[0-9]{12}$`',
    `prior_allergen_matrix` STRING COMMENT 'Comma-separated list or structured representation of allergens (e.g., milk, eggs, peanuts, tree nuts, soy, wheat, fish, shellfish) that were declared for the SKU before this lifecycle event. Critical for reformulation and regulatory hold events.',
    `prior_gtin` STRING COMMENT 'The 14-digit GTIN that was assigned to the SKU before this lifecycle event. Captured for repack, label change, or reformulation events where GTIN may change per GS1 standards.. Valid values are `^[0-9]{14}$`',
    `prior_plm_stage` STRING COMMENT 'The PLM stage or product status that the SKU was in immediately before this lifecycle event occurred. Captures the from state in the state transition for historical analysis.',
    `prior_product_name` STRING COMMENT 'The consumer-facing product name or description that was in use before this lifecycle event. Captured for label change, reformulation, or rebranding events.',
    `prior_shelf_life_days` STRING COMMENT 'The number of days of shelf life that was assigned to the SKU before this lifecycle event. Captured for reformulation or specification change events that impact product stability.',
    `prior_upc` STRING COMMENT 'The 12-digit UPC that was assigned to the SKU before this lifecycle event. Captured for North American market SKUs undergoing repack or label changes.. Valid values are `^[0-9]{12}$`',
    `regulatory_notification_date` DATE COMMENT 'Date on which the regulatory authority was formally notified of this lifecycle event. Null if no notification was required. Used for compliance audit and FSMA traceability.',
    `regulatory_notification_reference` STRING COMMENT 'Reference number or confirmation code received from the regulatory authority upon notification submission. Used for audit trail and compliance evidence.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this lifecycle event requires formal notification to regulatory authorities (FDA, USDA, EFSA, etc.). True for events impacting food safety, allergens, or nutritional claims.',
    `responsible_business_unit` STRING COMMENT 'Name or code of the business unit, division, or brand team that owns and initiated this lifecycle event. Used for accountability, reporting hierarchy, and cross-functional coordination.',
    `supply_chain_notification_date` DATE COMMENT 'Date on which internal supply chain systems (ERP, WMS, MES) were updated and stakeholders notified of the lifecycle event. Used for operational readiness tracking.',
    `supply_chain_notification_status` STRING COMMENT 'Current status of internal supply chain notification for this lifecycle event. Tracks whether manufacturing, distribution centers, and logistics partners have been informed and systems updated.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `triggering_reason_code` STRING COMMENT 'Standardized code representing the primary business driver or root cause that initiated this lifecycle event. Used for trend analysis, portfolio management, and regulatory inquiries. [ENUM-REF-CANDIDATE: regulatory_change|cost_reduction|consumer_complaint|market_exit|retailer_delisting|quality_issue|supply_disruption|strategic_portfolio_review|innovation_pipeline|seasonal_demand|competitive_response|sustainability_initiative|allergen_management|nutrition_improvement|packaging_optimization|end_of_contract|low_sales_volume|manufacturing_constraint|ingredient_availability|merger_acquisition|brand_rationalization|channel_strategy — 22 candidates stripped; promote to reference product]',
    `triggering_reason_description` STRING COMMENT 'Free-text detailed explanation of the specific circumstances, business context, or regulatory requirement that triggered this lifecycle event. Provides narrative detail beyond the standardized reason code.',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Transactional record of each significant lifecycle state change for a SKU — launch, reformulation, repack, label change, temporary discontinuation, permanent discontinuation, reactivation, seasonal rotation, or regulatory hold. Captures event type, event date, triggering reason (regulatory change, cost reduction, consumer complaint, market exit, retailer delisting), responsible business unit, approval reference, prior/new attribute values changed, and downstream notification status. Provides full audit trail of SKU history for regulatory inquiries (FDA recall traceability), quality investigations, commercial portfolio reviews, and SOX compliance evidence.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`label_spec` (
    `label_spec_id` BIGINT COMMENT 'Unique identifier for the label specification record. Primary key for the label specification entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links artwork approval to employee for GMP and brand compliance reporting.',
    `label_approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_approval. Business justification: Label approval workflow mandates linking each label spec to its approved label record to ensure regulatory compliance before printing.',
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
    `distributor_address` STRING COMMENT 'Physical address of the distributor if different from the manufacturer. Required for co-packed or toll manufactured products.',
    `distributor_name` STRING COMMENT 'Legal name of the distributor if different from the manufacturer. Used when products are co-packed or toll manufactured.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Records employee approving standard cost, essential for cost control and finance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the cost center responsible for this product cost. Links to the organizational unit that owns the cost build-up and variance accountability.',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the manufacturing plant or production site where this cost applies. Standard costs can vary by production location due to regional labor rates, overhead allocation, and sourcing differences.',
    `profit_center_id` BIGINT COMMENT 'Foreign key reference to the profit center for internal profitability reporting. Enables brand-level or category-level margin analysis and Return on Investment (ROI) tracking.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`substitution_rule` (
    `substitution_rule_id` BIGINT COMMENT 'Primary key for substitution_rule',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links employee approving substitution rule, required for regulatory and allergen compliance tracking.',
    `sku_id` BIGINT COMMENT 'The SKU that can replace the source SKU. References the replacement product that can be used when the source SKU is unavailable or being phased out.',
    `source_sku_id` BIGINT COMMENT 'The SKU that is being substituted or replaced. References the original product requested in order fulfillment, production, or distribution scenarios.',
    `allergen_compatibility_verified_flag` BOOLEAN COMMENT 'Indicates whether the allergen matrices of source and substitute SKUs have been reviewed and confirmed compatible. Critical for food safety and regulatory compliance under Food Safety Modernization Act (FSMA) and allergen labeling requirements.',
    `applicable_channels` STRING COMMENT 'Comma-separated list of sales and distribution channels where this substitution rule applies. Examples include retail, foodservice, e-commerce, Direct Store Delivery (DSD), distributor, export. Empty or null indicates rule applies to all channels.',
    `applicable_customer_segments` STRING COMMENT 'Comma-separated list of customer segments or account types to which this substitution rule applies. Examples include national_accounts, regional_chains, independent_retailers, club_stores. Empty or null indicates rule applies to all customer types.',
    `applicable_regions` STRING COMMENT 'Comma-separated list of geographic regions, countries, or market areas where this substitution rule is valid. Uses ISO 3166-1 alpha-3 country codes or internal region codes. Empty or null indicates global applicability.',
    `approval_date` DATE COMMENT 'The date when this substitution rule was formally approved for use in business operations.',
    `approval_status` STRING COMMENT 'Current approval state of the substitution rule. Draft indicates rule is being created; pending_approval indicates awaiting review; approved indicates active and usable; rejected indicates not authorized; suspended indicates temporarily disabled; expired indicates past effective end date.. Valid values are `draft|pending_approval|approved|rejected|suspended|expired`',
    `auto_substitute_flag` BOOLEAN COMMENT 'Indicates whether this substitution can be applied automatically by order management or warehouse management systems without manual approval. True enables automatic substitution; false requires manual review and authorization for each substitution instance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this substitution rule record was first created in the system. Supports audit trail and data lineage requirements.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the customer must be notified when this substitution is applied to their order. True requires notification via Electronic Data Interchange (EDI) Advanced Shipping Notice (ASN) or other communication channel; false allows silent substitution.',
    `effective_end_date` DATE COMMENT 'The date when this substitution rule expires and is no longer valid. Null indicates an open-ended rule with no expiration.',
    `effective_start_date` DATE COMMENT 'The date when this substitution rule becomes active and can be applied in order fulfillment, production planning, or distribution operations.',
    `last_used_date` DATE COMMENT 'The most recent date when this substitution rule was applied in a business transaction. Used to identify inactive rules that may be candidates for archival.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this substitution rule record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this substitution rule record was last updated. Supports audit trail and change management requirements.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business rationale for this substitution rule. May include details about customer agreements, supply chain constraints, or quality considerations.',
    `nutritional_equivalence_verified_flag` BOOLEAN COMMENT 'Indicates whether the nutritional panels of source and substitute SKUs have been compared and confirmed substantially equivalent. Important for institutional foodservice contracts and nutritional program compliance.',
    `price_adjustment_type` STRING COMMENT 'Defines how pricing is handled when substitution occurs. no_adjustment uses standard substitute SKU price; match_source charges the original source SKU price; use_substitute charges the substitute SKU price; percentage_discount applies a discount percentage; fixed_discount applies a fixed amount discount.. Valid values are `no_adjustment|match_source|use_substitute|percentage_discount|fixed_discount`',
    `price_adjustment_value` DECIMAL(18,2) COMMENT 'Numeric value for price adjustment when price_adjustment_type is percentage_discount or fixed_discount. For percentage_discount, represents the discount percentage (e.g., 5.00 for 5% off). For fixed_discount, represents the discount amount in base currency.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preference order when multiple substitutes exist for the same source SKU. Lower numbers indicate higher priority. Used by order management systems to select the optimal substitute.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory or compliance review is required before this substitution can be executed. True for substitutions involving formula changes, allergen differences, or claims substantiation that require Food and Drug Administration (FDA) or United States Department of Agriculture (USDA) review.',
    `substitution_direction` STRING COMMENT 'Indicates whether the substitution is one-way (source can be replaced by substitute only) or bidirectional (either SKU can replace the other). Bidirectional typically applies to equivalent products.. Valid values are `one_way|bidirectional`',
    `substitution_ratio` DECIMAL(18,2) COMMENT 'Conversion factor for quantity substitution. Indicates how many units of the substitute SKU are needed to replace one unit of the source SKU. For example, 1.5 means 1.5 units of substitute replace 1 unit of source.',
    `substitution_reason` STRING COMMENT 'Business reason for establishing this substitution rule. Discontinuation indicates source SKU is being phased out; supply_shortage indicates temporary unavailability; cost_optimization indicates more economical alternative; quality_improvement indicates enhanced product; regulatory_change indicates compliance-driven substitution; packaging_change or formulation_change indicate product updates; seasonal_transition indicates seasonal variant swap; inventory_depletion indicates planned stock runout; customer_request indicates retailer-mandated equivalent. [ENUM-REF-CANDIDATE: discontinuation|supply_shortage|cost_optimization|quality_improvement|regulatory_change|packaging_change|formulation_change|seasonal_transition|inventory_depletion|customer_request — 10 candidates stripped; promote to reference product]',
    `substitution_type` STRING COMMENT 'Classification of the substitution relationship. Equivalent indicates functionally identical products; upgrade indicates higher-value replacement; downgrade indicates lower-value replacement; temporary indicates short-term substitution during supply disruptions; permanent indicates supersession due to discontinuation; seasonal indicates time-bound substitution for seasonal variants.. Valid values are `equivalent|upgrade|downgrade|temporary|permanent|seasonal`',
    `usage_count` STRING COMMENT 'Cumulative count of how many times this substitution rule has been applied in actual order fulfillment, production, or distribution transactions. Used for substitution effectiveness analysis and fill rate optimization.',
    `created_by` STRING COMMENT 'Name or identifier of the user who created this substitution rule record. Typically a supply chain planner, product manager, or demand planner.',
    CONSTRAINT pk_substitution_rule PRIMARY KEY(`substitution_rule_id`)
) COMMENT 'Approved product substitution and supersession rules defining which SKUs can replace others in order fulfillment, production, or distribution scenarios. Captures source SKU, substitute SKU, substitution type (equivalent, upgrade, temporary, permanent), substitution direction (one-way, bidirectional), effective date range, applicable channels, priority rank, and approval status. Supports order management fill-rate optimization, inventory depletion of discontinued SKUs, supply continuity during shortages, and retailer-mandated equivalent item programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`production_assignment` (
    `production_assignment_id` BIGINT COMMENT 'Primary key for the production_assignment association',
    `asset_id` BIGINT COMMENT 'Foreign key linking to Asset',
    `sku_id` BIGINT COMMENT 'Foreign key linking to SKU',
    `effective_end_date` DATE COMMENT 'Date when the SKU assignment to the asset ends',
    `effective_start_date` DATE COMMENT 'Date when the SKU assignment to the asset becomes effective',
    CONSTRAINT pk_production_assignment PRIMARY KEY(`production_assignment_id`)
) COMMENT 'Represents the assignment of a SKU to a production asset for a specific time period. Captures when the SKU is scheduled to be produced on the asset.. Existence Justification: A SKU can be manufactured on multiple production assets and an asset can produce many different SKUs. The assignment of a SKU to an asset is scheduled with start and end dates for capacity planning and traceability, and these assignments are actively created and maintained by production planners.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`inventory_allocation` (
    `inventory_allocation_id` BIGINT COMMENT 'Primary key for the inventory_allocation association',
    `sku_id` BIGINT COMMENT 'Foreign key linking to SKU',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to storage location',
    `best_before_date` DATE COMMENT 'Best‑before date for the SKU at this location',
    `quantity_available` BIGINT COMMENT 'Units of the SKU available for allocation or sale',
    `quantity_in_transit` BIGINT COMMENT 'Units en route to the location but not yet received',
    `quantity_on_hand` BIGINT COMMENT 'Current total units of the SKU physically present at the location',
    `quantity_reserved` BIGINT COMMENT 'Units reserved for pending orders or allocations',
    `shelf_life_expiration_date` DATE COMMENT 'Expiration date based on product shelf‑life for the batch stored at this location',
    `stock_age_days` STRING COMMENT 'Number of days the stock has been stored at the location',
    CONSTRAINT pk_inventory_allocation PRIMARY KEY(`inventory_allocation_id`)
) COMMENT 'This association captures the allocation of a SKU to a specific storage location, including quantities on hand, reserved amounts, in‑transit stock, and shelf‑life dates. Each record links one SKU to one storage location and stores attributes that belong only to the SKU‑location relationship.. Existence Justification: A SKU can be stocked in multiple storage locations, and each storage location can hold many different SKUs. The inventory management process actively creates and updates records that capture quantities, reservation status, and shelf‑life information for each SKU‑location pair. This relationship is managed as a distinct business entity used for allocation, replenishment, and compliance reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`product_production_bom` (
    `product_production_bom_id` BIGINT COMMENT 'Primary key for the production_bom association',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the Plant',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM',
    `bom_version` STRING COMMENT 'Version identifier of the BOM for this SKU‑plant pair',
    `valid_from_date` DATE COMMENT 'Date when this BOM version becomes effective',
    `valid_to_date` DATE COMMENT 'Date when this BOM version expires',
    CONSTRAINT pk_product_production_bom PRIMARY KEY(`product_production_bom_id`)
) COMMENT 'Represents the manufacturing Bill of Materials linking a SKU to a plant. Each record captures the version, status, and validity period of the BOM for that SKU‑plant pair.. Existence Justification: A SKU can be manufactured at multiple plants, and each plant can produce many SKUs. The business maintains a versioned Bill of Materials per SKU‑plant combination with validity dates, status, and version information, which is actively created and managed by manufacturing planners.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Primary key for category',
    `parent_category_id` BIGINT COMMENT 'Identifier of the immediate parent category for hierarchical organization.',
    `allergen_info` STRING COMMENT 'Allergen statements applicable to the category (e.g., contains nuts, gluten‑free).',
    `category_code` STRING COMMENT 'Short alphanumeric code used to reference the category in external systems.',
    `category_name` STRING COMMENT 'Human‑readable name of the product category.',
    `category_type` STRING COMMENT 'High‑level classification of the category (e.g., Food, Beverage).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category record was first created in the system.',
    `category_description` STRING COMMENT 'Detailed textual description of the category.',
    `effective_from` DATE COMMENT 'Date when the category becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the category is retired or no longer valid (null if indefinite).',
    `hierarchy_level` STRING COMMENT 'Depth of the category within the category tree (root = 0).',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether items in this category are perishable (true) or non‑perishable (false).',
    `marketing_description` STRING COMMENT 'Consumer‑facing description used in marketing materials.',
    `nutritional_profile` STRING COMMENT 'Standard nutritional characteristics for the category (e.g., high protein, low sugar).',
    `packaging_type` STRING COMMENT 'Standard packaging format for items in this category.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification governing the category (e.g., GRAS, FDA approved).',
    `shelf_life_days` STRING COMMENT 'Typical shelf life of products within this category, expressed in days.',
    `category_status` STRING COMMENT 'Current lifecycle status of the category.',
    `target_market` STRING COMMENT 'Primary geographic market(s) where the category is sold.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category record.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Master reference table for category. Referenced by category_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `food_beverage_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ADD CONSTRAINT `fk_product_gtin_registry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_node_hierarchy_id` FOREIGN KEY (`parent_node_hierarchy_id`) REFERENCES `food_beverage_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ADD CONSTRAINT `fk_product_bill_of_materials_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `food_beverage_ecm`.`product`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ADD CONSTRAINT `fk_product_nutritional_panel_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ADD CONSTRAINT `fk_product_packaging_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ADD CONSTRAINT `fk_product_shelf_life_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ADD CONSTRAINT `fk_product_npd_project_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ADD CONSTRAINT `fk_product_lifecycle_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ADD CONSTRAINT `fk_product_label_spec_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ADD CONSTRAINT `fk_product_product_standard_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ADD CONSTRAINT `fk_product_substitution_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ADD CONSTRAINT `fk_product_substitution_rule_source_sku_id` FOREIGN KEY (`source_sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ADD CONSTRAINT `fk_product_production_assignment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ADD CONSTRAINT `fk_product_inventory_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ADD CONSTRAINT `fk_product_product_production_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `food_beverage_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `food_beverage_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `food_beverage_ecm`.`product`.`category`(`category_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `cost_plus_model_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Plus Model Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`sku` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN) Registry ID');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Activation Date');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Assignment Date');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `barcode_symbology` SET TAGS ('dbx_business_glossary_term' = 'Barcode Symbology');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `barcode_symbology` SET TAGS ('dbx_value_regex' = 'UPC-A|EAN-13|EAN-8|ITF-14|GS1-128|GS1 DataBar');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Global Location Number (GLN)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `brand_owner_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `cases_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Cases Per Pallet');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_business_glossary_term' = 'GTIN Check Digit');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `check_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_business_glossary_term' = 'GS1 Company Prefix');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_company_prefix` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_registration_date` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registration Date');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_registration_status` SET TAGS ('dbx_business_glossary_term' = 'GS1 Registration Status');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gs1_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending_registration|not_registered|registration_expired');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_change_reason` SET TAGS ('dbx_business_glossary_term' = 'GTIN Change Reason');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_status` SET TAGS ('dbx_business_glossary_term' = 'GTIN Status');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|reserved|retired|recalled');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_type` SET TAGS ('dbx_business_glossary_term' = 'GTIN Type');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `gtin_type` SET TAGS ('dbx_value_regex' = 'GTIN-8|GTIN-12|GTIN-13|GTIN-14');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `is_base_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Base Unit Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `is_consumer_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Consumer Unit Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Is Orderable Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `item_reference` SET TAGS ('dbx_business_glossary_term' = 'Item Reference Number');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `manufacturer_gln` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Global Location Number (GLN)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `manufacturer_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `net_content_uom` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `net_content_value` SET TAGS ('dbx_business_glossary_term' = 'Net Content Value');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (kg)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `package_depth_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Depth in Centimeters (cm)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `package_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height in Centimeters (cm)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `package_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width in Centimeters (cm)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `packaging_level` SET TAGS ('dbx_business_glossary_term' = 'Packaging Level');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `predecessor_gtin` SET TAGS ('dbx_business_glossary_term' = 'Predecessor GTIN');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `predecessor_gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `requires_freezing` SET TAGS ('dbx_business_glossary_term' = 'Requires Freezing Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `requires_refrigeration` SET TAGS ('dbx_business_glossary_term' = 'Requires Refrigeration Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'GTIN Retirement Date');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature in Celsius');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature in Celsius');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Country Code');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `units_per_case` SET TAGS ('dbx_business_glossary_term' = 'Units Per Case');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`product`.`gtin_registry` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `parent_node_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node Identifier (ID)');
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
ALTER TABLE `food_beverage_ecm`.`product`.`hierarchy` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` SET TAGS ('dbx_subdomain' = 'formulation_engineering');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`bill_of_materials` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
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
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'formulation_engineering');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `component_category` SET TAGS ('dbx_business_glossary_term' = 'Component Category');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `food_beverage_ecm`.`product`.`bom_line` ALTER COLUMN `component_item_number` SET TAGS ('dbx_business_glossary_term' = 'Component Item Number');
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
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` SET TAGS ('dbx_subdomain' = 'formulation_engineering');
ALTER TABLE `food_beverage_ecm`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
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
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `nutritional_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Panel Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `added_sugars_dv_percent` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars Daily Value (DV) Percent');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `added_sugars_grams` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars in Grams');
ALTER TABLE `food_beverage_ecm`.`product`.`nutritional_panel` ALTER COLUMN `additional_nutrients_json` SET TAGS ('dbx_business_glossary_term' = 'Additional Nutrients JSON');
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
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`packaging_spec` ALTER COLUMN `packaging_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Compliance Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
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
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Specification Code');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = '^SLS-[A-Z0-9]{6,12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Humidity (Percent)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Humidity (Percent)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `temperature_excursion_tolerance_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Tolerance (Hours)');
ALTER TABLE `food_beverage_ecm`.`product`.`shelf_life_spec` ALTER COLUMN `total_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Total Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `npd_project_id` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Project ID');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Existing Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Lead Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `business_case_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Case Approved Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `capital_investment_required` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Required');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `capital_investment_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `consumer_acceptance_score` SET TAGS ('dbx_business_glossary_term' = 'Consumer Acceptance Score');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `consumer_acceptance_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `consumer_testing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Testing Completion Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `consumer_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Testing Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `estimated_cogs_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost of Goods Sold (COGS) Impact');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `estimated_cogs_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `estimated_incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Incremental Revenue');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `estimated_incremental_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `gate_decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `gate_decision` SET TAGS ('dbx_value_regex' = 'go|conditional_go|hold|kill|recycle');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Gate Stage');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `innovation_type` SET TAGS ('dbx_business_glossary_term' = 'Innovation Type');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `innovation_type` SET TAGS ('dbx_value_regex' = 'breakthrough|platform|derivative|packaging_only');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `last_gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Gate Review Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `marketing_lead` SET TAGS ('dbx_business_glossary_term' = 'Marketing Lead');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `next_gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Review Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_close_date` SET TAGS ('dbx_business_glossary_term' = 'Project Close Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsor');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `reformulation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reformulation Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `regulatory_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_cogs` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Goods Sold (COGS)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Distribution Channel');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_market_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Market Geography');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_rsp` SET TAGS ('dbx_business_glossary_term' = 'Target Recommended Selling Price (RSP)');
ALTER TABLE `food_beverage_ecm`.`product`.`npd_project` ALTER COLUMN `target_rsp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Comments');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Number');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^LCE-[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Type');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `impact_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Completed Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `impact_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Reference Number');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `inventory_write_off_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Write-Off Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_allergen_matrix` SET TAGS ('dbx_business_glossary_term' = 'New Allergen Matrix');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_gtin` SET TAGS ('dbx_business_glossary_term' = 'New Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_plm_stage` SET TAGS ('dbx_business_glossary_term' = 'New Product Lifecycle Management (PLM) Stage');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_product_name` SET TAGS ('dbx_business_glossary_term' = 'New Product Name');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'New Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_upc` SET TAGS ('dbx_business_glossary_term' = 'New Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `new_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_allergen_matrix` SET TAGS ('dbx_business_glossary_term' = 'Prior Allergen Matrix');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_gtin` SET TAGS ('dbx_business_glossary_term' = 'Prior Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_plm_stage` SET TAGS ('dbx_business_glossary_term' = 'Prior Product Lifecycle Management (PLM) Stage');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_product_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Product Name');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Prior Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_upc` SET TAGS ('dbx_business_glossary_term' = 'Prior Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `prior_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `regulatory_notification_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Reference Number');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `supply_chain_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Notification Date');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `supply_chain_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Notification Status');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `supply_chain_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `triggering_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason Code');
ALTER TABLE `food_beverage_ecm`.`product`.`lifecycle_event` ALTER COLUMN `triggering_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Triggering Reason Description');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` SET TAGS ('dbx_subdomain' = 'packaging_labeling');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Label Specification ID');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `distributor_address` SET TAGS ('dbx_business_glossary_term' = 'Distributor Address');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `distributor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `distributor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`label_spec` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
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
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `product_standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`product`.`product_standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
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
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rule Identifier');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `source_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Source Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `allergen_compatibility_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Compatibility Verified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sales Channels');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `applicable_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segments');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geographic Regions');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|suspended|expired');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `auto_substitute_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Substitution Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rule Notes');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `nutritional_equivalence_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Equivalence Verified Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `price_adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Type');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `price_adjustment_type` SET TAGS ('dbx_value_regex' = 'no_adjustment|match_source|use_substitute|percentage_discount|fixed_discount');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `price_adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Value');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Substitution Priority Rank');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_direction` SET TAGS ('dbx_business_glossary_term' = 'Substitution Direction');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_direction` SET TAGS ('dbx_value_regex' = 'one_way|bidirectional');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_ratio` SET TAGS ('dbx_business_glossary_term' = 'Substitution Ratio');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'equivalent|upgrade|downgrade|temporary|permanent|seasonal');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Substitution Usage Count');
ALTER TABLE `food_beverage_ecm`.`product`.`substitution_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,maintenance.asset');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ALTER COLUMN `production_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Production Assignment - Production Assignment Id');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Production Assignment - Asset Id');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Production Assignment - Sku Id');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production Assignment - Effective End Date');
ALTER TABLE `food_beverage_ecm`.`product`.`production_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Assignment - Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` SET TAGS ('dbx_association_edges' = 'product.sku,inventory.storage_location');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `inventory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Allocation Id');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Sku Id');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation - Storage Location Id');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration');
ALTER TABLE `food_beverage_ecm`.`product`.`inventory_allocation` ALTER COLUMN `stock_age_days` SET TAGS ('dbx_business_glossary_term' = 'Stock Age');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` SET TAGS ('dbx_subdomain' = 'formulation_engineering');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` SET TAGS ('dbx_association_edges' = 'product.sku,manufacturing.plant');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `product_production_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Production Bom - Bom Id');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Production Bom - Plant Id');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Production Bom - Sku Id');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Status');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'BOM Version');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Valid From');
ALTER TABLE `food_beverage_ecm`.`product`.`product_production_bom` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Valid To');
ALTER TABLE `food_beverage_ecm`.`product`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`product`.`category` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `food_beverage_ecm`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier');
