-- Schema for Domain: assortment | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`assortment` COMMENT 'Merchandise planning, category management, product assortment optimization, and planogram execution. Manages space allocation, facings, new item introductions, SKU rationalization, and localized assortments by store cluster. Supports seasonal planning and category captain collaboration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the merchandise category. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: In grocery retail, each category (Produce, Dairy, Bakery) maps to a department cost center for shrink allocation, labor budgeting, and category P&L reporting. Category managers and finance analysts re',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchy. Null for top-level departments.',
    `supplier_id` BIGINT COMMENT 'Reference to the lead vendor designated as category captain for this category. Category captains collaborate on assortment planning, space allocation, and promotional strategy.',
    `average_shelf_life_days` STRING COMMENT 'Average shelf life in days for products in this category. Used for inventory planning and shrink management.',
    `category_code` STRING COMMENT 'Business identifier code for the category used across systems and reporting. Typically alphanumeric code assigned by merchandising team.. Valid values are `^[A-Z0-9]{4,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the category scope, including product types, brands, and assortment guidelines.',
    `category_name` STRING COMMENT 'Full business name of the merchandise category (e.g., Yogurt, Fresh Produce, Bakery).',
    `category_status` STRING COMMENT 'Current lifecycle status of the category. Active categories are available for assortment planning and SKU assignment.. Valid values are `active|inactive|pending|discontinued`',
    `category_type` STRING COMMENT 'Classification of the category node type within the merchandise hierarchy.. Valid values are `department|class|subclass|category|sub_category`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was first created in the system.',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether this category is eligible for direct store delivery from vendors, bypassing the distribution center.',
    `effective_end_date` DATE COMMENT 'Date when this category was discontinued or became inactive. Null for currently active categories.',
    `effective_start_date` DATE COMMENT 'Date when this category became active and available for assortment planning.',
    `endcap_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this category are eligible for end-of-aisle endcap promotional displays.',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target GMROI ratio for this category. Measures gross margin dollars returned for every dollar invested in inventory. Used for category performance evaluation.',
    `haccp_required_flag` BOOLEAN COMMENT 'Indicates whether this category requires HACCP food safety protocols for handling and storage.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the category tree (1=Department, 2=Class, 3=Subclass, 4=Category, 5=Sub-Category).',
    `hierarchy_path` STRING COMMENT 'Full path from root to this category (e.g., Grocery > Dairy > Yogurt). Used for navigation and rollup reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was last updated.',
    `localized_assortment_flag` BOOLEAN COMMENT 'Indicates whether this category supports localized assortment variations by store cluster based on demographics and regional preferences.',
    `markdown_strategy` STRING COMMENT 'Pricing markdown strategy for clearance and slow-moving items in this category.. Valid values are `aggressive|moderate|conservative|none`',
    `minimum_facings` STRING COMMENT 'Minimum number of product facings (front-facing units on shelf) required for this category to maintain visual merchandising standards.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this category requires USDA organic certification for included products.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this category contains perishable items requiring cold chain management and FIFO inventory practices.',
    `planogram_required_flag` BOOLEAN COMMENT 'Indicates whether this category requires formal planogram execution for visual merchandising and space allocation.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this category includes store-owned private label brand products.',
    `replenishment_method` STRING COMMENT 'Primary replenishment method for this category: CAO (Computer-Assisted Ordering), manual ordering, vendor-managed inventory, or cross-dock.. Valid values are `cao|manual|vendor_managed|cross_dock`',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this category has seasonal assortment variations (e.g., holiday baking, summer grilling, back-to-school).',
    `shrink_rate_percent` DECIMAL(18,2) COMMENT 'Expected inventory shrink rate percentage for this category due to theft, spoilage, or damage. Used for financial planning and loss prevention.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this category are eligible for purchase using SNAP/EBT benefits.',
    `space_allocation_square_feet` DECIMAL(18,2) COMMENT 'Standard space allocation norm for this category in square feet. Used for planogram planning and store layout design.',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for products in this category (ambient, refrigerated, frozen, or multi-temperature).. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this category are eligible for purchase using WIC benefits.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Master hierarchy of merchandise categories used for assortment planning and category management. Represents the full category tree from department down to sub-category level (e.g., Grocery > Dairy > Yogurt). Owned by the assortment domain as the SSOT for category structure. Includes category captain designation, GMROI targets, space allocation norms, and seasonal planning flags. Aligns with Oracle Retail Merchandising System item hierarchy.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`planogram` (
    `planogram_id` BIGINT COMMENT 'Unique identifier for the planogram. Primary key for the planogram data product.',
    `category_id` BIGINT COMMENT 'Reference to the merchandise subcategory within the broader category. Provides finer-grained classification for space allocation and assortment optimization.',
    `primary_planogram_category_id` BIGINT COMMENT 'Reference to the merchandise category this planogram represents. Links to the product category hierarchy for assortment planning and category management.',
    `store_cluster_id` BIGINT COMMENT 'Reference to the store cluster or format group this planogram is designed for. Enables localized assortments by store type, size, or demographic profile.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram was approved. Captures approval event in the planogram lifecycle for audit and compliance tracking.',
    `compliance_required_flag` BOOLEAN COMMENT 'Indicates whether strict compliance to this planogram is mandatory. True for corporate-mandated sets, false for suggested guidelines. Drives store execution accountability.',
    `compliance_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable variance percentage from the planogram specification before a store is considered non-compliant. Used for compliance scoring and audit thresholds.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram record was first created in the system. Audit field for data lineage and lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date when this planogram is scheduled to be replaced or retired. Nullable for open-ended planograms. Supports lifecycle management and reset planning.',
    `effective_start_date` DATE COMMENT 'Date when this planogram becomes active and should be implemented in stores. Supports seasonal resets and promotional timing.',
    `estimated_weekly_sales_amount` DECIMAL(18,2) COMMENT 'Projected weekly sales revenue in dollars for all SKUs (Stock Keeping Units) in this planogram. Supports space-to-sales ratio analysis and fixture ROI evaluation.',
    `estimated_weekly_sales_units` STRING COMMENT 'Projected weekly sales volume in units for all SKUs (Stock Keeping Units) in this planogram. Used for space productivity forecasting and GMROI (Gross Margin Return on Investment) analysis.',
    `fixture_depth_inches` DECIMAL(18,2) COMMENT 'Total depth of the fixture in inches. Constrains product depth and facing orientation for shelf placement.',
    `fixture_height_inches` DECIMAL(18,2) COMMENT 'Total height of the fixture in inches. Determines vertical space available for product placement and shelf allocation.',
    `fixture_type` STRING COMMENT 'Type of physical store fixture or display unit this planogram is designed for. Gondola for standard aisle shelving units, cooler for refrigerated cases, freezer for frozen food cases, pallet for floor stacks, display rack for specialty merchandisers, pegboard for hanging items, shelf for general shelving. [ENUM-REF-CANDIDATE: gondola|endcap|cooler|freezer|pallet|display_rack|pegboard|shelf — 8 candidates stripped; promote to reference product]',
    `fixture_width_inches` DECIMAL(18,2) COMMENT 'Total width of the fixture in inches. Critical dimension for space planning and ensuring planogram fits physical store layout.',
    `image_url` STRING COMMENT 'URL (Uniform Resource Locator) or file path to the visual rendering or photograph of the planogram. Provides reference image for store teams during reset execution.',
    `layout_orientation` STRING COMMENT 'Primary orientation of product placement within the planogram. Horizontal for side-by-side shelf arrangements, vertical for top-to-bottom brand blocking, mixed for combination layouts.. Valid values are `horizontal|vertical|mixed`',
    `merchandising_strategy` STRING COMMENT 'Primary merchandising strategy applied in this planogram. Brand blocking groups products by manufacturer, price point arranges by cost tiers, size progression orders by package size, color blocking groups by visual appeal, cross merchandising combines complementary categories.. Valid values are `brand_blocking|price_point|size_progression|color_blocking|cross_merchandising`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram record was last modified. Audit field for change tracking and version control.',
    `notes` STRING COMMENT 'Free-text notes or special instructions for store execution teams. May include setup guidance, display requirements, or merchandising tips for implementing the planogram.',
    `planogram_name` STRING COMMENT 'Human-readable name or title of the planogram, typically describing the category, fixture, or section it represents (e.g., Cereal Aisle Endcap Q1 2024).',
    `planogram_number` STRING COMMENT 'Business identifier for the planogram, typically used in space planning systems and store communications. Externally-known unique code for this visual merchandise display plan.',
    `planogram_status` STRING COMMENT 'Current lifecycle status of the planogram. Draft indicates work-in-progress, approved indicates ready for deployment, active indicates currently in use in stores, inactive indicates temporarily suspended, archived indicates historical record.. Valid values are `draft|approved|active|inactive|archived`',
    `planogram_type` STRING COMMENT 'Classification of the planogram by merchandising purpose. Standard for regular shelf sets, promotional for temporary displays, seasonal for holiday or seasonal merchandise, endcap for end-of-aisle displays, power aisle for high-traffic promotional zones, checkout for point-of-sale impulse areas.. Valid values are `standard|promotional|seasonal|endcap|power_aisle|checkout`',
    `private_label_facing_pct` DECIMAL(18,2) COMMENT 'Percentage of total facings allocated to private label or store-owned brand products. Key metric for private label penetration and margin optimization strategy.',
    `space_planning_system_code` STRING COMMENT 'Identifier or code from the source space planning system (e.g., Blue Yonder, JDA, Oracle Retail) where this planogram was designed. Supports system integration and data lineage.',
    `total_capacity_units` STRING COMMENT 'Total product capacity of the fixture in units, summing all SKU (Stock Keeping Unit) positions and depths. Represents maximum inventory that can be displayed on the fixture at full stock.',
    `total_facing_count` STRING COMMENT 'Total number of product facings (product fronts visible to shoppers) across all shelves in this planogram. Key metric for space productivity and SKU (Stock Keeping Unit) representation.',
    `total_shelf_count` STRING COMMENT 'Total number of shelves or levels within the fixture. Used for vertical space allocation and capacity planning.',
    `total_sku_count` STRING COMMENT 'Total number of unique SKUs (Stock Keeping Units) included in this planogram. Measures assortment breadth and variety for the fixture.',
    `version_number` STRING COMMENT 'Version number of the planogram, incremented with each revision. Supports change tracking and rollback capabilities for space planning iterations.',
    CONSTRAINT pk_planogram PRIMARY KEY(`planogram_id`)
) COMMENT 'Visual merchandise display plan defining the exact placement, facings, and shelf positions of SKUs within a store fixture or gondola section. Captures planogram version, effective dates, fixture type, total shelf capacity, and compliance status. Includes position-level detail: individual SKU slots with shelf number, bay number, facing count, capacity, and display orientation for each product placement. Source of truth for space planning and shelf execution. Derived from Oracle Retail and space planning tools (e.g., Blue Yonder, JDA).';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the merchandise assortment plan. Primary key for the assortment plan entity.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: In multi-banner grocery retailers, assortment plans are banner-specific — private label penetration targets, brand mix, and category strategies differ by banner (e.g., Kroger vs. Fred Meyer). Banner-l',
    `category_id` BIGINT COMMENT 'Identifier for the merchandise category this assortment plan covers (e.g., Fresh Produce, Dairy, Bakery, Private Label Snacks).',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Assortment plans are built for specific fiscal periods; assortment_plan carries denormalized fiscal_year and fiscal_quarter. Linking to fiscal_period enables period-close assortment reporting, financi',
    `planogram_id` BIGINT COMMENT 'Identifier for the visual merchandise display plan (planogram) that defines shelf layout and product placement for this assortment plan.',
    `store_cluster_id` BIGINT COMMENT 'Identifier for the store cluster or banner this assortment plan applies to. Store clusters group locations with similar demographics, size, and customer preferences for localized assortment optimization.',
    `actual_sku_count` STRING COMMENT 'Actual number of unique SKUs approved and included in the final assortment plan after merchandise planning review.',
    `approval_date` DATE COMMENT 'Date when the assortment plan was approved by merchandise planning leadership and authorized for execution.',
    `assortment_strategy` STRING COMMENT 'Strategic approach for this assortment plan: broad (wide variety), focused (narrow depth), premium (high-end), value (price-focused), seasonal (time-limited), or promotional (event-driven).. Valid values are `broad|focused|premium|value|seasonal|promotional`',
    `cost_plan_amount` DECIMAL(18,2) COMMENT 'Planned cost of goods sold (COGS) for this assortment plan during the planning period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assortment plan record was first created in the Oracle Retail Merchandising System.',
    `discontinued_item_count` STRING COMMENT 'Number of SKUs being discontinued or removed from the assortment compared to the previous planning period.',
    `effective_end_date` DATE COMMENT 'Date when this assortment plan expires and transitions to the next planning period. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this assortment plan becomes active and the approved SKU (Stock Keeping Unit) set should be available in stores.',
    `gmroi_target` DECIMAL(18,2) COMMENT 'Target GMROI (Gross Margin Return on Investment) ratio for this assortment plan, calculated as gross margin divided by average inventory investment. Key metric for assortment productivity.',
    `inventory_investment_plan` DECIMAL(18,2) COMMENT 'Planned average inventory investment at cost required to support this assortment plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assortment plan record was last updated in the Oracle Retail Merchandising System.',
    `localization_level` STRING COMMENT 'Geographic granularity of this assortment plan: national (all stores), regional (multi-state), cluster (store groups), or store (individual location).. Valid values are `national|regional|cluster|store`',
    `margin_plan_amount` DECIMAL(18,2) COMMENT 'Planned gross margin (sales minus cost) for this assortment plan during the planning period.',
    `margin_plan_percent` DECIMAL(18,2) COMMENT 'Planned gross margin percentage (margin divided by sales) target for this assortment plan.',
    `new_item_count` STRING COMMENT 'Number of new SKUs being introduced in this assortment plan that were not in the previous periods assortment.',
    `notes` STRING COMMENT 'Free-text notes and comments about the assortment plan, including strategic rationale, market conditions, competitive considerations, and special instructions.',
    `plan_code` STRING COMMENT 'Unique business identifier code for the assortment plan used for external reference and reporting.',
    `plan_name` STRING COMMENT 'Business-friendly name for the assortment plan, typically including category and season identifiers (e.g., Spring 2024 Fresh Produce Assortment).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the assortment plan: draft (being created), in_review (under merchandise planning review), approved (ready for execution), active (currently in effect), completed (planning period ended), or cancelled (plan abandoned).. Valid values are `draft|in_review|approved|active|completed|cancelled`',
    `planning_period_type` STRING COMMENT 'Type of planning horizon for this assortment plan (season, quarter, year, promotional event, or ad circular cycle).. Valid values are `season|quarter|year|promotional_event|ad_circular`',
    `planning_season` STRING COMMENT 'Season identifier for seasonal assortment plans (e.g., Spring 2024, Holiday 2024, Back to School 2024).',
    `private_label_sales_plan_percent` DECIMAL(18,2) COMMENT 'Target percentage of total sales plan that should come from private label products in this assortment.',
    `private_label_sku_count` STRING COMMENT 'Number of private label (store-owned brand) SKUs included in this assortment plan. Used for private label penetration tracking.',
    `sales_plan_amount` DECIMAL(18,2) COMMENT 'Planned sales revenue target for this assortment plan during the planning period. Used for financial planning and GMROI (Gross Margin Return on Investment) calculation.',
    `space_allocation_linear_feet` DECIMAL(18,2) COMMENT 'Total shelf space allocated to this assortment plan measured in linear feet. Used for planogram execution and space productivity analysis.',
    `target_sku_count` STRING COMMENT 'Planned number of unique SKUs (Stock Keeping Units) to be carried in this assortment plan. Used for SKU rationalization and space planning.',
    `total_facings` STRING COMMENT 'Total number of product facings (product fronts visible on shelf) allocated across all SKUs in this assortment plan.',
    `turn_rate_target` DECIMAL(18,2) COMMENT 'Target inventory turn rate (number of times inventory is sold and replaced during the planning period) for this assortment plan.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Merchandise assortment plan defining the approved set of SKUs for a category within a store cluster or banner for a planning period. Captures plan name, planning horizon (season/quarter/year), target SKU count, space allocation in linear feet, GMROI target, sales plan, and approval status. Created during merchandise planning cycles in Oracle Retail Merchandising System.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`assortment_item` (
    `assortment_item_id` BIGINT COMMENT 'Unique identifier for the assortment item record. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Reference to the merchandise subcategory for finer-grained assortment segmentation. Enables detailed space allocation and assortment breadth analysis within categories.',
    `brand_id` BIGINT COMMENT 'FK to product.brand',
    `new_item_intro_id` BIGINT COMMENT 'Foreign key linking to assortment.new_item_intro. Business justification: An assortment_item with new_item_flag=true originates from a new_item_intro lifecycle record. Adding new_item_intro_id to assortment_item creates a direct traceable link from the approved assortment l',
    `plan_id` BIGINT COMMENT 'Reference to the parent assortment plan that this item belongs to. Links this SKU inclusion decision to the broader merchandise planning strategy.',
    `planogram_id` BIGINT COMMENT 'Reference to the planogram that defines the physical shelf layout for this assortment item. Links assortment strategy to visual merchandising execution.',
    `primary_assortment_category_id` BIGINT COMMENT 'Reference to the merchandise category this item belongs to. Links assortment decisions to category management strategies and category captain collaboration.',
    `store_cluster_id` BIGINT COMMENT 'Reference to the store cluster for which this assortment item is defined. Enables localized assortment strategies by grouping stores with similar demographics, format, or demand patterns.',
    `store_location_id` BIGINT COMMENT 'Reference to an individual store for store-specific assortment overrides. Null when the item applies to the entire cluster; populated for hyper-local exceptions.',
    `supplier_id` BIGINT COMMENT 'Reference to the primary vendor or supplier for this SKU. Supports vendor assortment analysis, category captain collaboration, and DSD item management.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: An authorized assortment item must link to the vendor_item record to enable replenishment order generation, cost-based margin reporting, and vendor compliance checks. Category managers and replenishme',
    `approval_date` DATE COMMENT 'Date when this assortment item was approved for inclusion in the plan. Tracks decision timing and supports audit trails for assortment changes.',
    `approved_by` STRING COMMENT 'Name or identifier of the merchandising manager or category manager who approved this assortment item inclusion. Supports governance and accountability for assortment decisions.',
    `assortment_tier` STRING COMMENT 'Strategic importance tier of this SKU within the assortment. Defines priority for space allocation, inventory investment, and promotional support.. Valid values are `tier_1_must_carry|tier_2_recommended|tier_3_optional|tier_4_test`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assortment item record was first created in the system. Supports audit trails and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when this assortment item is discontinued or removed from the plan. Null for ongoing items. Enables SKU rationalization, seasonal exits, and planned discontinuations.',
    `effective_start_date` DATE COMMENT 'Date when this assortment item becomes active and should be carried in stores. Supports phased rollouts, seasonal transitions, and new item introduction timing.',
    `gtin` STRING COMMENT 'Global trade item number (UPC, EAN, or GTIN-14) for the product. Enables cross-enterprise product identification and EDI transactions with suppliers.. Valid values are `^[0-9]{8,14}$`',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this SKU within the assortment plan. Indicates whether the item is actively carried, newly introduced, discontinued, or represents a localized override decision. [ENUM-REF-CANDIDATE: active|discontinued|new|localized_add|localized_remove|pending|seasonal_inactive — 7 candidates stripped; promote to reference product]',
    `introduction_date` DATE COMMENT 'Date when this SKU was first introduced into the assortment. Enables new item maturity analysis and time-to-productivity measurement.',
    `last_review_date` DATE COMMENT 'Date when this assortment item was last reviewed for performance and continued inclusion. Supports ongoing assortment optimization and ensures regular evaluation cycles.',
    `localization_source` STRING COMMENT 'Primary driver for localized assortment decision. Identifies the business factor that triggered inclusion or exclusion of this SKU at the local level. [ENUM-REF-CANDIDATE: demographic_demand|local_supplier|store_format|competitive_response|customer_request|test_market|ethnic_community — 7 candidates stripped; promote to reference product]',
    `merchandising_role` STRING COMMENT 'Strategic role this SKU plays in the assortment. Defines whether the item is a core year-round offering, seasonal rotation, localized for demographic demand, ethnic specialty, private-label brand, promotional driver, or test item. [ENUM-REF-CANDIDATE: core|seasonal|local|ethnic|private_label|promotional|test — 7 candidates stripped; promote to reference product]',
    `minimum_facings` STRING COMMENT 'Minimum number of product facings (front-facing units on shelf) required for this SKU. Drives planogram execution and ensures adequate shelf presence for sales velocity and customer visibility.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assortment item record was last modified. Tracks changes to assortment decisions and supports change management processes.',
    `new_item_flag` BOOLEAN COMMENT 'Indicates whether this is a new item introduction within the current planning cycle. Supports new item performance tracking and innovation pipeline management.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this assortment item represents a localized override to the standard cluster plan. True when a store or sub-cluster has deviated from the base assortment strategy.',
    `override_justification` STRING COMMENT 'Business rationale for localized assortment override. Captures the reason for deviation from standard plan such as demographic demand, competitive response, local supplier availability, or store format requirements.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this SKU is a store-owned private-label brand product. Supports private-label penetration analysis and margin optimization strategies.',
    `rationalization_candidate_flag` BOOLEAN COMMENT 'Indicates whether this SKU has been identified as a candidate for removal during SKU rationalization analysis. Flags underperforming items for review and potential discontinuation.',
    `rationalization_reason` STRING COMMENT 'Primary reason this SKU is flagged for rationalization. Captures the business driver for potential discontinuation such as poor sales velocity, margin erosion, or assortment duplication. [ENUM-REF-CANDIDATE: low_sales|low_margin|duplication|supplier_exit|quality_issues|regulatory|space_optimization — 7 candidates stripped; promote to reference product]',
    `recommended_facings` STRING COMMENT 'Optimal number of facings recommended by space planning algorithms based on sales velocity, margin, and shelf capacity. Guides planogram design and space allocation decisions.',
    `season_code` STRING COMMENT 'Seasonal period or event this SKU is associated with. Enables seasonal assortment transitions, promotional calendar alignment, and year-over-year seasonal performance comparison. [ENUM-REF-CANDIDATE: spring|summer|fall|winter|holiday|back_to_school|easter|fourth_of_july — 8 candidates stripped; promote to reference product]',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this SKU is a seasonal item with recurring annual availability windows. Supports seasonal planning, space resets, and inventory flow management.',
    `shelf_position_code` STRING COMMENT 'Recommended shelf position or merchandising location for this SKU. Indicates optimal vertical and horizontal placement to maximize visibility, accessibility, and sales performance. [ENUM-REF-CANDIDATE: eye_level|reach_level|stoop_level|endcap|gondola_end|power_aisle|checkout — 7 candidates stripped; promote to reference product]',
    `sku` STRING COMMENT 'Internal stock keeping unit identifier for the product included in this assortment. The unique item-level identifier used across merchandising, inventory, and POS systems.. Valid values are `^[A-Z0-9]{6,14}$`',
    `space_allocation_linear_feet` DECIMAL(18,2) COMMENT 'Allocated shelf space for this SKU measured in linear feet. Drives planogram design and ensures space allocation aligns with sales velocity and strategic importance.',
    CONSTRAINT pk_assortment_item PRIMARY KEY(`assortment_item_id`)
) COMMENT 'Individual SKU included in an approved assortment plan, representing both standard plan items and localized overrides at the store-cluster or individual-store level. Captures SKU/GTIN, inclusion status (active, discontinued, new, localized-add, localized-remove), merchandising role (core, seasonal, local, ethnic, private-label), minimum facings, recommended shelf position, effective date range, override justification, and localization source (demographic demand, local supplier, store format). Serves as the single line-level detail record for all assortment decisions including hyper-local merchandising strategies, SKU rationalization outputs, and new item introduction placements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`store_cluster` (
    `store_cluster_id` BIGINT COMMENT 'Unique identifier for the store cluster. Primary key.',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: Clusters are built around store format (supermarket vs. small-format vs. fuel+grocery). Format-level cluster analysis, assortment depth strategy, and SKU rationalization all require knowing the primar',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Clusters align to regional boundaries for regional assortment reporting and promotional calendar coordination. Regional VPs use cluster-to-region mapping for comp-sales and assortment performance repo',
    `assortment_depth_strategy` STRING COMMENT 'Strategic approach to SKU (Stock Keeping Unit) selection and variety within categories for this cluster. Narrow-deep offers fewer brands with more sizes/flavors; broad-shallow offers many brands with limited variety per brand.. Valid values are `narrow_deep|broad_shallow|balanced|premium_focused|value_focused`',
    `average_store_size_sqft` DECIMAL(18,2) COMMENT 'Mean selling square footage of stores in this cluster. Used for space planning and planogram capacity estimation.',
    `average_weekly_sales` DECIMAL(18,2) COMMENT 'Mean weekly sales volume across stores in this cluster. Used for volume-based assortment planning and inventory allocation. Business-sensitive financial metric.',
    `climate_zone` STRING COMMENT 'Predominant climate classification for the cluster geography. Influences seasonal assortment planning for weather-dependent categories such as beverages, apparel, and outdoor products.. Valid values are `tropical|subtropical|temperate|continental|polar`',
    `cluster_code` STRING COMMENT 'Business identifier code for the store cluster used in merchandising and planning systems. Externally visible identifier used in Oracle Retail and Blue Yonder systems.. Valid values are `^[A-Z0-9]{3,12}$`',
    `cluster_manager_email` STRING COMMENT 'Business email address of the cluster manager for operational communication and escalation. Business-confidential contact information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cluster_manager_name` STRING COMMENT 'Name of the category manager or merchandising leader responsible for assortment strategy and performance for this cluster.',
    `cluster_name` STRING COMMENT 'Descriptive name of the store cluster for business user identification and reporting purposes.',
    `cluster_status` STRING COMMENT 'Current lifecycle status of the store cluster. Active clusters are in use for assortment planning, inactive clusters are temporarily disabled, pending clusters are under review, and archived clusters are historical.. Valid values are `active|inactive|pending|archived`',
    `cluster_type` STRING COMMENT 'Classification of the clustering methodology used to group stores. Demographic clusters group by customer profile, volume clusters by sales tier, format clusters by store size/layout, geographic clusters by region, competitive clusters by market dynamics, and hybrid clusters use multiple factors.. Valid values are `demographic|volume|format|geographic|competitive|hybrid`',
    `clustering_methodology` STRING COMMENT 'Description of the analytical approach and business rules used to define cluster membership. May reference statistical models, business criteria, or hybrid approaches.',
    `competitive_intensity` STRING COMMENT 'Assessment of competitive pressure in the markets served by this cluster. High-intensity clusters may require more aggressive promotional assortments and pricing strategies.. Valid values are `low|moderate|high|very_high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store cluster record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when this cluster definition was retired or superseded. Null for currently active clusters. Enables historical cluster analysis and transition tracking.',
    `effective_start_date` DATE COMMENT 'Date when this cluster definition became active and available for assortment planning and planogram assignment. Supports temporal analysis and historical reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store cluster record was most recently updated. Enables change tracking and data freshness monitoring.',
    `last_refresh_date` DATE COMMENT 'Date when the cluster definition and membership were last recalculated or reviewed. Used to track data freshness and trigger next refresh cycle.',
    `localization_level` STRING COMMENT 'Degree of assortment customization applied to this cluster. National clusters use standard assortments; hyper-local clusters have highly tailored selections reflecting unique community preferences.. Valid values are `national|regional|local|hyper_local`',
    `member_store_count` STRING COMMENT 'Total number of stores currently assigned to this cluster. Used for assortment scale planning and distribution allocation.',
    `methodology_version` STRING COMMENT 'Version identifier for the clustering algorithm or business rules applied. Enables tracking of methodology changes over time and impact analysis.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `new_item_introduction_priority` STRING COMMENT 'Sequencing priority for rolling out new SKUs (Stock Keeping Units) to stores in this cluster. First-wave clusters receive new items earliest; test-only clusters are used for market testing before broader rollout.. Valid values are `first_wave|second_wave|third_wave|test_only|excluded`',
    `next_refresh_date` DATE COMMENT 'Planned date for the next cluster review and update cycle. Supports proactive planning and resource allocation for cluster maintenance.',
    `notes` STRING COMMENT 'Free-text field for additional context, special considerations, or strategic rationale for cluster definition and management. Supports knowledge transfer and decision documentation.',
    `performance_tier` STRING COMMENT 'Performance classification based on sales productivity, profitability, and strategic importance. Platinum and gold tiers receive priority for new item introductions and promotional support.. Valid values are `platinum|gold|silver|bronze|developing`',
    `planogram_template_set` STRING COMMENT 'Reference to the collection of planogram (visual merchandise display plan) templates assigned to this cluster. Links cluster to specific shelf layout and facing strategies.',
    `primary_category_focus` STRING COMMENT 'Dominant merchandise categories or departments emphasized in this clusters assortment strategy, such as fresh produce, organic, ethnic foods, or premium selections.',
    `primary_demographic_profile` STRING COMMENT 'Dominant customer demographic characteristics of stores in this cluster, such as income level, household composition, age distribution, or ethnicity mix. Used for targeted assortment selection.',
    `private_label_penetration_target` DECIMAL(18,2) COMMENT 'Target percentage of sales from private-label (store-owned brand) products for this cluster. Used to guide assortment mix and shelf space allocation decisions.',
    `refresh_frequency` STRING COMMENT 'Cadence at which cluster membership and definitions are reviewed and updated. Aligns with merchandise planning cycles and seasonal resets.. Valid values are `weekly|monthly|quarterly|semi_annual|annual|ad_hoc`',
    `seasonal_reset_schedule` STRING COMMENT 'Timing and frequency of major seasonal assortment resets and planogram changes for this cluster. Aligns with holiday periods, weather transitions, and promotional calendars.',
    `sku_rationalization_score` DECIMAL(18,2) COMMENT 'Metric indicating the degree of SKU optimization and elimination of low-performing items in this cluster. Higher scores indicate more streamlined, efficient assortments.',
    `store_format_mix` STRING COMMENT 'Distribution of store formats within the cluster, such as supermarket, hypermarket, convenience, or specialty formats. Informs format-specific assortment strategies.',
    CONSTRAINT pk_store_cluster PRIMARY KEY(`store_cluster_id`)
) COMMENT 'Grouping of stores with similar demographic, geographic, volume, or format characteristics used to define localized assortments and targeted planogram assignments. Captures cluster name, cluster type (demographic, volume, format, geographic, competitive), number of member stores, store membership list with effective dating, clustering methodology version, refresh frequency, and effective date range. Enables differentiated assortment strategies by market segment. Managed within Oracle Retail and Blue Yonder category management tools.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`new_item_intro` (
    `new_item_intro_id` BIGINT COMMENT 'Unique identifier for the new item introduction record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: New item introduction pipeline reporting requires brand-level aggregation (new items by brand, brand penetration targets, private label vs national brand mix). brand_name is a denormalized text field;',
    `category_id` BIGINT COMMENT 'Identifier of the merchandise subcategory for more granular classification of the new item.',
    `cost_schedule_id` BIGINT COMMENT 'Foreign key linking to vendor.cost_schedule. Business justification: Before authorizing a new item into the assortment, buyers must confirm an approved cost schedule exists. This link enables margin validation during new item review by pulling unit_cost, allowances, an',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.format. Business justification: New item introductions are format-eligible — a new premium item may launch only in full supermarket format, not small-format stores. Format eligibility is tracked during the item review process and dr',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: A new item introduction is evaluated and approved in the context of a specific assortment plan — the plan defines the approved SKU set for a category within a store cluster, and new item introductions',
    `planogram_id` BIGINT COMMENT 'Identifier of the planogram where the new item has been assigned shelf space and facings.',
    `primary_new_category_id` BIGINT COMMENT 'Identifier of the merchandise category to which the new item belongs.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Once a new item introduction is approved and the product master is created, the intro record must link to the product_item for new item performance tracking, launch compliance reporting, and post-laun',
    `store_cluster_id` BIGINT COMMENT 'Identifier of the store cluster or group where the new item will be introduced, supporting localized assortment strategies.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier submitting the new item for introduction.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: New item introductions are frequently governed by a trade agreement specifying slotting fees, promotional commitments, and exclusivity terms. Finance and category teams require this link to reconcile ',
    `approval_date` DATE COMMENT 'Date when the category buyer or category captain approved the new item for introduction.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one case for distribution center handling.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The wholesale cost per unit that the retailer will pay to the vendor for the new item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the new item introduction record was first created in the system.',
    `expected_annual_sales_units` STRING COMMENT 'Forecasted number of units expected to be sold annually for the new item, used for planning and performance tracking.',
    `expected_gross_margin_percent` DECIMAL(18,2) COMMENT 'Projected gross margin percentage for the new item, calculated as (retail price - cost) / retail price * 100.',
    `first_receipt_date` DATE COMMENT 'Actual date when the first shipment of the new item was received at a store or distribution center.',
    `first_ship_date` DATE COMMENT 'Actual date when the first shipment of the new item was sent from the vendor or distribution center.',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number for global supply chain identification of the new item.. Valid values are `^[0-9]{14}$`',
    `initial_order_quantity` STRING COMMENT 'The quantity of units ordered for the initial stocking of the new item across the distribution network.',
    `introduction_status` STRING COMMENT 'Current lifecycle status of the new item introduction process from vendor submission through store activation. [ENUM-REF-CANDIDATE: submitted|under_review|approved|rejected|planogram_assigned|in_transit|received|active — 8 candidates stripped; promote to reference product]',
    `is_organic_certified` BOOLEAN COMMENT 'Indicates whether the new item has USDA organic certification (True) or not (False).',
    `is_private_label` BOOLEAN COMMENT 'Indicates whether the new item is a store-owned private label brand (True) or a national/CPG brand (False).',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether the new item is a seasonal product (True) or a year-round item (False).',
    `item_description` STRING COMMENT 'Detailed description of the new item including features, ingredients, or specifications.',
    `item_name` STRING COMMENT 'The marketing name or product title of the new item being introduced.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the new item introduction record was last updated or modified.',
    `number_of_facings` STRING COMMENT 'The number of product fronts allocated to the new item on the shelf for visibility and inventory capacity.',
    `package_size` STRING COMMENT 'The size or quantity of the item package (e.g., 16 oz, 500 ml, 12 count).',
    `rejection_reason` STRING COMMENT 'Explanation provided when a new item introduction is rejected, including business rationale.',
    `requires_refrigeration` BOOLEAN COMMENT 'Indicates whether the new item requires cold chain temperature-controlled storage and handling (True) or not (False).',
    `review_completion_date` DATE COMMENT 'Date when the category review process was completed and a decision was made on the new item.',
    `review_start_date` DATE COMMENT 'Date when the category review process began for the new item introduction.',
    `season_code` STRING COMMENT 'The seasonal period or event associated with the new item introduction if it is a seasonal product.. Valid values are `spring|summer|fall|winter|holiday|back_to_school`',
    `shelf_position` STRING COMMENT 'Specific shelf location assigned to the new item within the planogram (e.g., aisle, shelf level, position).',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'One-time fee paid by the vendor to secure shelf space and distribution for the new item.',
    `submission_date` DATE COMMENT 'Date when the vendor submitted the new item introduction request to the retailer for review.',
    `suggested_retail_price` DECIMAL(18,2) COMMENT 'Vendor-recommended retail price for the new item at point of sale.',
    `target_launch_date` DATE COMMENT 'Planned date when the new item should be available for sale in stores.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure for ordering and inventory management of the new item. [ENUM-REF-CANDIDATE: each|case|pound|kilogram|ounce|liter|gallon|pack — 8 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit Universal Product Code assigned to the new item for point-of-sale scanning.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_new_item_intro PRIMARY KEY(`new_item_intro_id`)
) COMMENT 'New item introduction record tracking the lifecycle of a new SKU from vendor submission through category review, buyer approval, planogram slotting, and first store receipt. Captures item name, UPC/GTIN, vendor, category, slotting fee amount, target launch date, first ship date, initial order quantity, and introduction status. Supports private-label and CPG new item workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT 'Unique identifier for the space allocation record. Primary key.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Space allocation is executed at the department level — Produce gets X linear feet, Deli gets Y. Department-level space productivity reports (sales per linear foot by department) and reset labor planni',
    `fixture_id` BIGINT COMMENT 'Foreign key linking to assortment.fixture. Business justification: Space allocation defines approved linear footage, shelf count, and display positions — all of which are physically assigned to a specific store fixture (gondola, endcap, cooler, etc.). Adding fixture_',
    `planogram_id` BIGINT COMMENT 'Identifier of the planogram (visual merchandise display plan) that implements this space allocation. Links to the planogram master data.',
    `category_id` BIGINT COMMENT 'Identifier of the product category for which space is allocated. Links to the product category hierarchy.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Space allocations with promotional tie-ins (promotional_tie_in_flag exists on space_allocation) must reference the governing campaign for vendor funding reconciliation and promotional ROI reporting. G',
    `store_cluster_id` BIGINT COMMENT 'Identifier of the store cluster (group of stores with similar characteristics) to which this space allocation applies. Used for localized assortment planning.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store to which this space allocation applies. Links to the store master data.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor funding or sponsoring the space allocation. Applicable when vendor_funded_flag is true. Links to vendor master data.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Vendor-funded space allocations (vendor_funded_flag=true) are contractually governed by a trade agreement specifying shelf space commitments, duration, and payment terms. Trade spend reconciliation an',
    `aisle_number` STRING COMMENT 'Aisle number within the store where the space allocation is located. Used for store navigation, planogram execution, and space mapping.',
    `allocation_code` STRING COMMENT 'Business identifier code for the space allocation record. Used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `allocation_priority` STRING COMMENT 'Priority level of the space allocation. High-priority allocations receive preferential space and visibility (e.g., high-margin categories, promotional items). Used for space optimization and conflict resolution.. Valid values are `high|medium|low`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the space allocation. Indicates whether the allocation is in planning, approved for execution, actively in use, temporarily suspended, expired, or cancelled.. Valid values are `draft|approved|active|suspended|expired|cancelled`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation was approved. Used for audit trail and lifecycle tracking.',
    `bay_number` STRING COMMENT 'Bay or section number within the aisle where the space allocation is located. Provides precise fixture location for planogram execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when the space allocation expires or is scheduled to be replaced. Nullable for open-ended allocations. Used for endcap rotation scheduling and seasonal space adjustments.',
    `effective_start_date` DATE COMMENT 'Date when the space allocation becomes active and effective. Used for planogram execution scheduling and space transition planning.',
    `endcap_position` STRING COMMENT 'Physical position of the endcap display within the store. Endcaps are high-visibility promotional displays at the end of aisles. Position affects traffic flow and sales lift. [ENUM-REF-CANDIDATE: front_left|front_right|mid_left|mid_right|back_left|back_right|not_applicable — 7 candidates stripped; promote to reference product]',
    `facing_count` STRING COMMENT 'Total number of product facings (product fronts visible on shelf) allocated to the category or sub-category. Determines SKU (Stock Keeping Unit) capacity and visual merchandising impact.',
    `featured_sku` STRING COMMENT 'Primary SKU (Stock Keeping Unit) featured in the endcap or promotional display. Used for endcap rotation scheduling and promotional tie-in tracking.. Valid values are `^[0-9]{8,14}$`',
    `gondola_section_count` STRING COMMENT 'Number of gondola sections (standard 4-foot shelving units) allocated to the category or sub-category. Used for planogram development and space planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the space allocation record was last modified. Used for audit trail and change tracking.',
    `linear_feet_allocated` DECIMAL(18,2) COMMENT 'Total linear footage allocated to the category or sub-category. Measured horizontally across shelves and fixtures. Key metric for space productivity analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments about the space allocation. Used for special instructions, merchandising guidelines, or execution notes.',
    `promotional_tie_in_flag` BOOLEAN COMMENT 'Indicates whether the space allocation is tied to a specific promotional campaign or ad circular (weekly promotional flyer). True if promotional, false otherwise.',
    `season_name` STRING COMMENT 'Name of the season for seasonal space allocations (e.g., Holiday 2024, Back-to-School 2024, Summer 2024). Applicable when seasonal_flag is true.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether the space allocation is seasonal (e.g., holiday, back-to-school, summer). True if seasonal, false if year-round.',
    `shelf_count` STRING COMMENT 'Number of shelves allocated to the category or sub-category within the fixture. Determines vertical space capacity.',
    `shelf_height_inches` DECIMAL(18,2) COMMENT 'Total vertical height in inches of the shelving allocated to the category or sub-category. Used for vertical space planning and fixture capacity calculation.',
    `square_footage_allocated` DECIMAL(18,2) COMMENT 'Total square footage allocated to the category or sub-category. Used for floor space planning and productivity measurement.',
    `target_gmroi_per_linear_foot` DECIMAL(18,2) COMMENT 'Target Gross Margin Return on Investment (GMROI) per linear foot for the space allocation. Used for category space productivity analysis and performance benchmarking. Measures profitability per unit of space.',
    `temperature_zone` STRING COMMENT 'Temperature control zone for the space allocation. Applicable for perishable categories requiring coolers or freezers. Supports cold chain (temperature-controlled supply chain) compliance.. Valid values are `ambient|refrigerated|frozen|not_applicable`',
    `vendor_funded_flag` BOOLEAN COMMENT 'Indicates whether the space allocation is funded by a vendor through slotting fees (vendor payment for shelf space) or promotional allowances. True if vendor-funded, false otherwise.',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Space allocation record defining the approved linear footage, shelf count, square footage, and display assignments for a category or sub-category within a store or store cluster. Covers all fixture types including gondola sections, endcaps (end-of-aisle displays), coolers, freezer cases, and promotional displays. Captures allocated linear feet, number of shelves, gondola sections, endcap position assignments (featured SKU/category, assignment dates, promotional tie-in), fixture type, seasonal space adjustments, vendor-funded indicators, and effective date ranges. Drives planogram development, category space productivity (GMROI per linear foot) analysis, and high-visibility promotional display management including endcap rotation scheduling.';

CREATE OR REPLACE TABLE `grocery_ecm`.`assortment`.`fixture` (
    `fixture_id` BIGINT COMMENT 'Unique identifier for the physical store fixture. Primary key.',
    `planogram_id` BIGINT COMMENT 'Identifier of the planogram (visual merchandise display plan) currently assigned to this fixture. Links logical merchandise plans to physical store infrastructure.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Fixtures belong to specific store departments (refrigerated cases in Dairy, gondolas in Center Store). Department-level fixture inventory, maintenance scheduling, and planogram compliance audits all r',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Grocery store fixtures (refrigeration cases, gondolas, display units) are capitalized as fixed assets. This link enables depreciation tracking, asset lifecycle management, and physical inventory recon',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Grocery store fixture procurement and installation are capital projects tracked as internal orders. Linking fixture to internal_order enables capex tracking, budget vs. actual spend analysis, and sett',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where this fixture is installed.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the fixture meets ADA (Americans with Disabilities Act) accessibility requirements for height and reach ranges.',
    `aisle_number` STRING COMMENT 'Aisle identifier where the fixture is located within the store layout.',
    `bay_number` STRING COMMENT 'Bay or section number within the aisle, providing precise fixture location for planogram execution and inventory management.',
    `condition_status` STRING COMMENT 'Current physical condition of the fixture: excellent, good, fair, poor, needs repair, or out of service. Used for maintenance prioritization and capital planning.. Valid values are `excellent|good|fair|poor|needs_repair|out_of_service`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixture record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the fixture was permanently removed from service or decommissioned.',
    `decommission_reason` STRING COMMENT 'Reason for decommissioning the fixture, such as end of life, store remodel, equipment failure, or format change.',
    `energy_star_certified_flag` BOOLEAN COMMENT 'Indicates whether the fixture (particularly refrigerated or frozen units) is Energy Star certified for energy efficiency.',
    `fire_safety_compliant_flag` BOOLEAN COMMENT 'Indicates whether the fixture meets fire safety code requirements for materials and placement.',
    `fixture_code` STRING COMMENT 'Business identifier or code assigned to the fixture for operational reference and planogram assignment.',
    `fixture_name` STRING COMMENT 'Descriptive name or label for the fixture, often used for store associate reference and planogram communication.',
    `fixture_type` STRING COMMENT 'Type of physical fixture: gondola (standard shelving unit in aisle), endcap (end-of-aisle display), cooler (refrigerated case), freezer case (frozen goods case), wine rack, or specialty display unit.. Valid values are `gondola|endcap|cooler|freezer_case|wine_rack|specialty_display`',
    `height_inches` DECIMAL(18,2) COMMENT 'Total height of the fixture in inches from floor to top shelf.',
    `installation_date` DATE COMMENT 'Date when the fixture was installed in the store, used for asset lifecycle tracking and maintenance scheduling.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or inspection performed on the fixture, particularly important for refrigerated and frozen units.',
    `last_planogram_reset_date` DATE COMMENT 'Date when the fixture was last reset or re-merchandised according to a planogram.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or vendor who produced the fixture.',
    `model_number` STRING COMMENT 'Manufacturer model number or SKU (Stock Keeping Unit) of the fixture, used for parts ordering and warranty management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixture record was last modified in the system.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next maintenance or inspection of the fixture.',
    `notes` STRING COMMENT 'Free-text notes or comments about the fixture, including special handling instructions, historical issues, or configuration details.',
    `number_of_shelves` STRING COMMENT 'Total count of shelves or levels available on the fixture for product placement.',
    `operational_status` STRING COMMENT 'Current operational status of the fixture: active (in use), inactive (temporarily not in use), under maintenance, or decommissioned (permanently removed).. Valid values are `active|inactive|under_maintenance|decommissioned`',
    `planogram_compliance_status` STRING COMMENT 'Indicates whether the fixture is currently set according to the assigned planogram: compliant, non-compliant, pending reset, or not applicable.. Valid values are `compliant|non_compliant|pending_reset|not_applicable`',
    `planogram_effective_date` DATE COMMENT 'Date when the current planogram assignment became effective on this fixture.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original purchase cost of the fixture in USD (United States Dollars), used for capital asset tracking and depreciation calculations.',
    `purchase_date` DATE COMMENT 'Date when the fixture was purchased by the company.',
    `refrigerant_type` STRING COMMENT 'Type of refrigerant used in refrigerated or frozen fixtures, required for EPA (Environmental Protection Agency) compliance and environmental reporting.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific fixture unit, used for warranty claims and asset tracking.',
    `shelf_depth_inches` DECIMAL(18,2) COMMENT 'Depth of shelves in inches, determining the size of products that can be accommodated and the number of facings per SKU (Stock Keeping Unit).',
    `temperature_range_max_fahrenheit` DECIMAL(18,2) COMMENT 'Maximum temperature in Fahrenheit that the fixture maintains, applicable to refrigerated and frozen fixtures for food safety compliance.',
    `temperature_range_min_fahrenheit` DECIMAL(18,2) COMMENT 'Minimum temperature in Fahrenheit that the fixture maintains, applicable to refrigerated and frozen fixtures for food safety compliance.',
    `temperature_zone` STRING COMMENT 'Temperature control classification of the fixture: ambient (room temperature), refrigerated (cold chain for fresh produce and dairy), or frozen (freezer case for frozen goods). Critical for cold chain compliance and perishable inventory management.. Valid values are `ambient|refrigerated|frozen`',
    `total_linear_feet` DECIMAL(18,2) COMMENT 'Total linear footage of shelf space available on the fixture, calculated across all shelves. Critical metric for space allocation and planogram capacity planning.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty on the fixture expires.',
    `width_inches` DECIMAL(18,2) COMMENT 'Total width of the fixture in inches, representing the horizontal span of the unit.',
    CONSTRAINT pk_fixture PRIMARY KEY(`fixture_id`)
) COMMENT 'Physical store fixture master record representing a gondola, endcap, cooler, freezer case, wine rack, or specialty display unit within a specific store. Captures fixture type, aisle and bay location, number of shelves, total linear footage, depth, temperature zone (ambient, refrigerated, frozen), installation date, condition status, and current planogram assignment. Serves as the physical anchor for planogram placement and space allocation records. Referenced by planogram and space_allocation to connect logical merchandise plans to physical store infrastructure.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`assortment`.`category` ADD CONSTRAINT `fk_assortment_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ADD CONSTRAINT `fk_assortment_planogram_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ADD CONSTRAINT `fk_assortment_planogram_primary_planogram_category_id` FOREIGN KEY (`primary_planogram_category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ADD CONSTRAINT `fk_assortment_planogram_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ADD CONSTRAINT `fk_assortment_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ADD CONSTRAINT `fk_assortment_plan_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ADD CONSTRAINT `fk_assortment_plan_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_new_item_intro_id` FOREIGN KEY (`new_item_intro_id`) REFERENCES `grocery_ecm`.`assortment`.`new_item_intro`(`new_item_intro_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_primary_assortment_category_id` FOREIGN KEY (`primary_assortment_category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `grocery_ecm`.`assortment`.`plan`(`plan_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_primary_new_category_id` FOREIGN KEY (`primary_new_category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `grocery_ecm`.`assortment`.`fixture`(`fixture_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`assortment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`assortment` SET TAGS ('dbx_domain' = 'assortment');
ALTER TABLE `grocery_ecm`.`assortment`.`category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`category` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Vendor ID');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `average_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Average Shelf Life Days');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'department|class|subclass|category|sub_category');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `endcap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Endcap Eligible Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `haccp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Required Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `localized_assortment_flag` SET TAGS ('dbx_business_glossary_term' = 'Localized Assortment Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `markdown_strategy` SET TAGS ('dbx_business_glossary_term' = 'Markdown Strategy');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `markdown_strategy` SET TAGS ('dbx_value_regex' = 'aggressive|moderate|conservative|none');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `minimum_facings` SET TAGS ('dbx_business_glossary_term' = 'Minimum Facings');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `planogram_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram Required Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'cao|manual|vendor_managed|cross_dock');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `shrink_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Shrink Rate Percent');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `space_allocation_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Square Feet');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`assortment`.`category` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` SET TAGS ('dbx_subdomain' = 'space_merchandising');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Subcategory ID');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `primary_planogram_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `compliance_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tolerance Percentage');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `estimated_weekly_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weekly Sales Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `estimated_weekly_sales_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weekly Sales (Units)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `fixture_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Fixture Depth (Inches)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `fixture_height_inches` SET TAGS ('dbx_business_glossary_term' = 'Fixture Height (Inches)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `fixture_type` SET TAGS ('dbx_business_glossary_term' = 'Fixture Type');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `fixture_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Fixture Width (Inches)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Planogram Image URL (Uniform Resource Locator)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `layout_orientation` SET TAGS ('dbx_business_glossary_term' = 'Layout Orientation');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `layout_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|mixed');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `merchandising_strategy` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Strategy');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `merchandising_strategy` SET TAGS ('dbx_value_regex' = 'brand_blocking|price_point|size_progression|color_blocking|cross_merchandising');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planogram Notes');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_name` SET TAGS ('dbx_business_glossary_term' = 'Planogram Name');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_number` SET TAGS ('dbx_business_glossary_term' = 'Planogram Number');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_status` SET TAGS ('dbx_business_glossary_term' = 'Planogram Status');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|inactive|archived');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_type` SET TAGS ('dbx_business_glossary_term' = 'Planogram Type');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `planogram_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|seasonal|endcap|power_aisle|checkout');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `private_label_facing_pct` SET TAGS ('dbx_business_glossary_term' = 'Private Label Facing Percentage');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `space_planning_system_code` SET TAGS ('dbx_business_glossary_term' = 'Space Planning System Code');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `total_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Units)');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `total_facing_count` SET TAGS ('dbx_business_glossary_term' = 'Total Facing Count');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `total_shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Total Shelf Count');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) Count');
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan ID');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `actual_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Stock Keeping Unit (SKU) Count');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Approval Date');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `assortment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Assortment Strategy Type');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `assortment_strategy` SET TAGS ('dbx_value_regex' = 'broad|focused|premium|value|seasonal|promotional');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `cost_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Plan Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `discontinued_item_count` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Item Count');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `gmroi_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Target');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `inventory_investment_plan` SET TAGS ('dbx_business_glossary_term' = 'Inventory Investment Plan Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `localization_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Localization Level');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `localization_level` SET TAGS ('dbx_value_regex' = 'national|regional|cluster|store');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `margin_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Plan Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `margin_plan_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Plan Percentage');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `new_item_count` SET TAGS ('dbx_business_glossary_term' = 'New Item Introduction Count');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Notes');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Code');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Name');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Status');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|completed|cancelled');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'season|quarter|year|promotional_event|ad_circular');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `planning_season` SET TAGS ('dbx_business_glossary_term' = 'Planning Season');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `private_label_sales_plan_percent` SET TAGS ('dbx_business_glossary_term' = 'Private Label Sales Plan Percentage');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `private_label_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Private Label Stock Keeping Unit (SKU) Count');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `sales_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Plan Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `space_allocation_linear_feet` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation in Linear Feet');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `target_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Keeping Unit (SKU) Count');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `total_facings` SET TAGS ('dbx_business_glossary_term' = 'Total Product Facings');
ALTER TABLE `grocery_ecm`.`assortment`.`plan` ALTER COLUMN `turn_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turn Rate Target');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Subcategory ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Intro Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `primary_assortment_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `assortment_tier` SET TAGS ('dbx_business_glossary_term' = 'Assortment Tier');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `assortment_tier` SET TAGS ('dbx_value_regex' = 'tier_1_must_carry|tier_2_recommended|tier_3_optional|tier_4_test');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Introduction Date');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `localization_source` SET TAGS ('dbx_business_glossary_term' = 'Localization Source');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `merchandising_role` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Role');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `minimum_facings` SET TAGS ('dbx_business_glossary_term' = 'Minimum Facings');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `new_item_flag` SET TAGS ('dbx_business_glossary_term' = 'New Item Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `rationalization_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Rationalization Candidate Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `rationalization_reason` SET TAGS ('dbx_business_glossary_term' = 'Rationalization Reason');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `recommended_facings` SET TAGS ('dbx_business_glossary_term' = 'Recommended Facings');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `shelf_position_code` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position Code');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,14}$');
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ALTER COLUMN `space_allocation_linear_feet` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Linear Feet');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Identifier (ID)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `assortment_depth_strategy` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Strategy');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `assortment_depth_strategy` SET TAGS ('dbx_value_regex' = 'narrow_deep|broad_shallow|balanced|premium_focused|value_focused');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `average_store_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Average Store Size (Square Feet)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `average_weekly_sales` SET TAGS ('dbx_business_glossary_term' = 'Average Weekly Sales (USD)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `average_weekly_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `climate_zone` SET TAGS ('dbx_value_regex' = 'tropical|subtropical|temperate|continental|polar');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Code');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Cluster Manager Email Address');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Cluster Manager Name');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_name` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Name');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_status` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Status');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_type` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Type');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `cluster_type` SET TAGS ('dbx_value_regex' = 'demographic|volume|format|geographic|competitive|hybrid');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `clustering_methodology` SET TAGS ('dbx_business_glossary_term' = 'Clustering Methodology');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intensity Level');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cluster Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cluster Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cluster Refresh Date');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `localization_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Localization Level');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `localization_level` SET TAGS ('dbx_value_regex' = 'national|regional|local|hyper_local');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `member_store_count` SET TAGS ('dbx_business_glossary_term' = 'Member Store Count');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Clustering Methodology Version');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `methodology_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `new_item_introduction_priority` SET TAGS ('dbx_business_glossary_term' = 'New Item Introduction Priority');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `new_item_introduction_priority` SET TAGS ('dbx_value_regex' = 'first_wave|second_wave|third_wave|test_only|excluded');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `next_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cluster Refresh Date');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cluster Notes');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Cluster Performance Tier');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|developing');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `planogram_template_set` SET TAGS ('dbx_business_glossary_term' = 'Planogram Template Set Identifier');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `primary_category_focus` SET TAGS ('dbx_business_glossary_term' = 'Primary Category Focus');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `primary_demographic_profile` SET TAGS ('dbx_business_glossary_term' = 'Primary Demographic Profile');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `private_label_penetration_target` SET TAGS ('dbx_business_glossary_term' = 'Private Label Penetration Target (Percentage)');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cluster Refresh Frequency');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `seasonal_reset_schedule` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Reset Schedule');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `sku_rationalization_score` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Rationalization Score');
ALTER TABLE `grocery_ecm`.`assortment`.`store_cluster` ALTER COLUMN `store_format_mix` SET TAGS ('dbx_business_glossary_term' = 'Store Format Mix');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` SET TAGS ('dbx_subdomain' = 'category_planning');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Introduction ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Subcategory ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `cost_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Schedule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `primary_new_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `expected_annual_sales_units` SET TAGS ('dbx_business_glossary_term' = 'Expected Annual Sales Units');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `expected_annual_sales_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `expected_gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Gross Margin Percent');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `expected_gross_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `first_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'First Receipt Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `first_ship_date` SET TAGS ('dbx_business_glossary_term' = 'First Ship Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `initial_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Initial Order Quantity');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `introduction_status` SET TAGS ('dbx_business_glossary_term' = 'Introduction Status');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `is_organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Organic Certified');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Is Private Label');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `number_of_facings` SET TAGS ('dbx_business_glossary_term' = 'Number of Facings');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `requires_refrigeration` SET TAGS ('dbx_business_glossary_term' = 'Requires Refrigeration');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = 'spring|summer|fall|winter|holiday|back_to_school');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `suggested_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` SET TAGS ('dbx_subdomain' = 'space_merchandising');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Fixture Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Code');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Status');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|expired|cancelled');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `bay_number` SET TAGS ('dbx_business_glossary_term' = 'Bay Number');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `endcap_position` SET TAGS ('dbx_business_glossary_term' = 'Endcap Position');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Facing Count');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `featured_sku` SET TAGS ('dbx_business_glossary_term' = 'Featured SKU (Stock Keeping Unit)');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `featured_sku` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `gondola_section_count` SET TAGS ('dbx_business_glossary_term' = 'Gondola Section Count');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `linear_feet_allocated` SET TAGS ('dbx_business_glossary_term' = 'Linear Feet Allocated');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Notes');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `promotional_tie_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Tie-In Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `shelf_height_inches` SET TAGS ('dbx_business_glossary_term' = 'Shelf Height Inches');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `square_footage_allocated` SET TAGS ('dbx_business_glossary_term' = 'Square Footage Allocated');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `target_gmroi_per_linear_foot` SET TAGS ('dbx_business_glossary_term' = 'Target GMROI (Gross Margin Return on Investment) Per Linear Foot');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|not_applicable');
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ALTER COLUMN `vendor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funded Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` SET TAGS ('dbx_subdomain' = 'space_merchandising');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Fixture ID');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Current Planogram (POG) ID');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Compliant Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `bay_number` SET TAGS ('dbx_business_glossary_term' = 'Bay Number');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|needs_repair|out_of_service');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `energy_star_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Star Certified Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fire_safety_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Compliant Flag');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixture_code` SET TAGS ('dbx_business_glossary_term' = 'Fixture Code');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixture_name` SET TAGS ('dbx_business_glossary_term' = 'Fixture Name');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixture_type` SET TAGS ('dbx_business_glossary_term' = 'Fixture Type');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `fixture_type` SET TAGS ('dbx_value_regex' = 'gondola|endcap|cooler|freezer_case|wine_rack|specialty_display');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Fixture Height (Inches)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `last_planogram_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Last Planogram (POG) Reset Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `number_of_shelves` SET TAGS ('dbx_business_glossary_term' = 'Number of Shelves');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_maintenance|decommissioned');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `planogram_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Status');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `planogram_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_reset|not_applicable');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `planogram_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Effective Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Purchase Cost');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `refrigerant_type` SET TAGS ('dbx_business_glossary_term' = 'Refrigerant Type');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `shelf_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Shelf Depth (Inches)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `temperature_range_max_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `temperature_range_min_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `total_linear_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Linear Feet');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Fixture Width (Inches)');
