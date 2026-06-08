-- Schema for Domain: store | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`store` COMMENT 'Physical retail locations including supermarkets, pharmacies, fuel centers, and micro-fulfillment centers (MFCs). Manages store profiles, layouts, departments, gondolas, endcaps, backrooms, operating hours, formats, service capabilities, and regional hierarchy. Supports store clustering, comp sales performance tracking, and site selection.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`store_location` (
    `store_location_id` BIGINT COMMENT 'Unique identifier for the physical retail location. Primary key for the store_location entity. This is the single source of truth (SSOT) for store identity across the enterprise and the anchor entity for all store-domain relationships.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Cash handling and bank reconciliation require each store to reference its dedicated bank account.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Store locations have a textual banner_name; adding store_location.banner_id FK creates a proper reference to the banner master table, enables consistent reporting, and removes the redundant banner_nam',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Store‑level expense reporting requires linking each store to its primary cost center for P&L and budget variance analysis.',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: REQUIRED: Store replenishment planning needs the primary DC assignment to calculate inbound logistics; experts expect a dc_facility_id on each store for routing and capacity planning.',
    `district_id` BIGINT COMMENT 'Foreign key linking to store.district. Business justification: Each store belongs to a district; adding district_id creates the hierarchical link without redundancy.',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Store format is a master reference; replace string format_type with FK to store_format for consistency and normalization.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.payment_gateway. Business justification: Required for POS settlement reporting: each store is assigned a payment gateway that processes its transactions, needed for daily settlement batch generation and compliance audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Daily sales posting uses a default GL account per store; linking enables automated journal entry generation.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tax and regulatory filings require each store to be linked to its legal entity for jurisdictional compliance.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Pricing zone assignment per store drives zone‑specific price strategies; required for Price Zone Performance Report and zone‑based price optimization.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability dashboards aggregate sales by profit center; each store must be assigned to a profit center for store‑wide profit reporting.',
    `program_config_id` BIGINT COMMENT 'Foreign key linking to loyalty.program_config. Business justification: Required for store‑level loyalty program settings used in earn‑rate calculations, store‑specific promotions, and compliance reporting; a store manager configures the program per store.',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: Allows direct regional performance reporting and inventory allocation per store without traversing district hierarchy.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: REQUIRED: Assortment planning assigns each store to a store cluster for category mix, planogram templates, and performance reporting; linking store_location to store_cluster enables cluster‑based asso',
    `accepts_snap_ebt` BOOLEAN COMMENT 'Indicates whether this store is authorized to accept SNAP (Supplemental Nutrition Assistance Program) benefits via EBT (Electronic Benefits Transfer). Impacts payment processing, regulatory compliance, and customer accessibility.',
    `accepts_wic` BOOLEAN COMMENT 'Indicates whether this store is authorized to accept WIC (Women, Infants, and Children) program benefits. Impacts product assortment, POS configuration, and regulatory compliance.',
    `address_line1` STRING COMMENT 'Primary street address of the store location. Used for customer navigation, delivery routing, and regulatory reporting. Classified as confidential organizational contact data.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite number, building identifier, or cross-street. Classified as confidential organizational contact data.',
    `backroom_square_footage` DECIMAL(18,2) COMMENT 'Square footage of storage and receiving areas behind the sales floor. Used for inventory capacity planning, replenishment strategy, and operational efficiency analysis.',
    `city` STRING COMMENT 'City or municipality where the store is located. Used for geographic analysis, market segmentation, and regulatory compliance.',
    `closure_date` DATE COMMENT 'The date this store location permanently ceased operations. Null for active stores. Used for historical analysis, lease obligation tracking, and asset disposition planning.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX). Used for international operations, currency handling, and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store location record was first created in the system. Used for data lineage, audit trails, and compliance reporting.',
    `email_address` STRING COMMENT 'Primary email address for store-level communication. Used for customer inquiries, vendor coordination, and internal communications. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency contact number for the store location. Used for after-hours incidents, security alerts, and facility emergencies. Classified as confidential organizational contact data.. Valid values are `^+?[0-9]{10,15}$`',
    `gross_square_footage` DECIMAL(18,2) COMMENT 'Total building square footage including sales floor, backroom, offices, restrooms, and mechanical spaces. Used for facility management, lease agreements, and property tax calculations.',
    `has_bakery` BOOLEAN COMMENT 'Indicates whether this store includes an in-store bakery. Impacts food safety compliance, production scheduling, and fresh product assortment.',
    `has_deli` BOOLEAN COMMENT 'Indicates whether this store includes a deli department with prepared foods. Impacts food safety compliance (HACCP), staffing, and merchandising strategy.',
    `has_floral` BOOLEAN COMMENT 'Indicates whether this store includes a floral department. Impacts perishable inventory management, vendor relationships, and seasonal merchandising.',
    `has_fuel_center` BOOLEAN COMMENT 'Indicates whether this store location includes a fuel center. Impacts environmental compliance (EPA), pricing strategy, and loyalty program integration.',
    `has_meat_department` BOOLEAN COMMENT 'Indicates whether this store includes a full-service meat department with butchers. Impacts USDA compliance, cold chain management, and staffing.',
    `has_organic_section` BOOLEAN COMMENT 'Indicates whether this store includes a dedicated organic and natural foods section. Impacts merchandising strategy, vendor relationships, and customer segmentation.',
    `has_pharmacy` BOOLEAN COMMENT 'Indicates whether this store location includes a licensed pharmacy department. Impacts regulatory compliance (DEA, State Boards of Pharmacy, HIPAA), staffing requirements, and service offerings.',
    `has_seafood` BOOLEAN COMMENT 'Indicates whether this store includes a fresh seafood department. Impacts cold chain management, HACCP compliance, and specialized staffing requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store location record was last updated. Used for change tracking, data quality monitoring, and audit trails.',
    `last_remodel_date` DATE COMMENT 'The date of the most recent major remodel or renovation. Used to track capital investment cycles, assess store modernization status, and plan future remodel schedules.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the store location. Used for mapping, proximity analysis, delivery routing, and trade area modeling.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the store location. Used for mapping, proximity analysis, delivery routing, and trade area modeling.',
    `opening_date` DATE COMMENT 'The date this store location first opened for business. Used for calculating store maturity, comp sales eligibility (typically requires 12+ months of operation), and anniversary planning.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the store location. Determines whether the store is open for business, undergoing changes, or closed. Critical for inventory allocation, workforce scheduling, and customer communication. [ENUM-REF-CANDIDATE: active|temporarily_closed|permanently_closed|under_construction|under_remodel|pre_opening|seasonal — 7 candidates stripped; promote to reference product]',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the store location. Impacts financial reporting, capital expenditure planning, and operational control.. Valid values are `owned|leased|franchised|licensed`',
    `parking_spaces_count` STRING COMMENT 'Total number of customer parking spaces available at this location. Impacts site selection, customer convenience, and omnichannel pickup capacity.',
    `phone_number` STRING COMMENT 'Primary customer-facing phone number for the store. Used for customer inquiries, order status, and pharmacy consultations. Classified as confidential organizational contact data.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the store location. Used for delivery zone mapping, demographic analysis, and trade area definition. Classified as confidential organizational contact data.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `selling_square_footage` DECIMAL(18,2) COMMENT 'Square footage of customer-accessible sales floor area. Excludes backroom, offices, and non-selling spaces. Used for sales productivity metrics (sales per square foot), space planning, and merchandising allocation.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, ON). Used for tax jurisdiction determination, regulatory compliance, and regional reporting.. Valid values are `^[A-Z]{2}$`',
    `store_name` STRING COMMENT 'Human-readable name of the store location, often including neighborhood or landmark identifiers (e.g., Downtown Main Street, Riverside Plaza). Used for customer communication and internal reference.',
    `store_number` STRING COMMENT 'Externally-known business identifier for the store location. Used in all customer-facing communications, signage, and operational systems. Typically a 4-6 digit numeric code assigned sequentially or by region.. Valid values are `^[0-9]{4,6}$`',
    `supports_curbside_pickup` BOOLEAN COMMENT 'Indicates whether this store offers curbside pickup service for online orders (click-and-collect). Impacts omnichannel fulfillment strategy, parking allocation, and staffing.',
    `supports_home_delivery` BOOLEAN COMMENT 'Indicates whether this store serves as a fulfillment center for home delivery orders. Impacts last mile delivery (LMD) operations, inventory allocation, and order management system (OMS) integration.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the store location (e.g., America/New_York, America/Chicago). Used for scheduling, reporting, and operational coordination across regions.',
    CONSTRAINT pk_store_location PRIMARY KEY(`store_location_id`)
) COMMENT 'Master record for every physical retail location operated by Grocery, including supermarkets, pharmacies, fuel centers, and micro-fulfillment centers (MFCs). Captures store number, banner name, format type (superstore, neighborhood market, express), ownership type (owned/leased), gross and selling square footage, opening date, remodel date, closure date, operational status, primary phone number, email, and emergency contact information. This is the SSOT for store identity across the enterprise and the anchor entity for all store-domain relationships. Every cross-domain reference to a physical store resolves to this product.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`format` (
    `format_id` BIGINT COMMENT 'Unique identifier for the store format. Primary key.',
    `annual_revenue_target_max` DECIMAL(18,2) COMMENT 'Maximum annual revenue target for stores of this format, in USD. Used for comp sales performance tracking and store clustering.',
    `annual_revenue_target_min` DECIMAL(18,2) COMMENT 'Minimum annual revenue target for stores of this format, in USD. Used for comp sales performance tracking and store clustering.',
    `bakery_included` BOOLEAN COMMENT 'Indicates whether stores of this format include an in-store bakery department.',
    `capital_investment_typical` DECIMAL(18,2) COMMENT 'Typical total capital investment required to build or convert a store to this format, in USD. Used for new store budgeting and format conversion ROI analysis.',
    `checkout_lane_count_max` STRING COMMENT 'Maximum number of POS (Point of Sale) checkout lanes in stores of this format.',
    `checkout_lane_count_min` STRING COMMENT 'Minimum number of POS (Point of Sale) checkout lanes in stores of this format.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was first created in the system.',
    `deli_included` BOOLEAN COMMENT 'Indicates whether stores of this format include a deli department with prepared foods and sliced meats.',
    `department_count_max` STRING COMMENT 'Maximum number of merchandise departments typically found in stores of this format.',
    `department_count_min` STRING COMMENT 'Minimum number of merchandise departments typically found in stores of this format.',
    `effective_end_date` DATE COMMENT 'Date when this store format definition was discontinued or superseded. Null for currently active formats.',
    `effective_start_date` DATE COMMENT 'Date when this store format definition became effective and available for use in store planning and operations.',
    `endcap_count_typical` STRING COMMENT 'Typical number of endcap display locations in stores of this format. Endcaps are high-visibility end-of-aisle promotional displays.',
    `format_category` STRING COMMENT 'High-level classification of the store format type used for strategic segmentation and portfolio analysis.. Valid values are `superstore|neighborhood_market|express|warehouse_club|fuel_only|pharmacy_standalone`',
    `format_code` STRING COMMENT 'Short alphanumeric code representing the store format (e.g., SS for Superstore, NM for Neighborhood Market, EXP for Express). Used as a business identifier in operational systems and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `format_description` STRING COMMENT 'Detailed description of the store format including its purpose, target customer segment, and key differentiators.',
    `format_name` STRING COMMENT 'Full descriptive name of the store format (e.g., Superstore, Neighborhood Market, Express Convenience, Warehouse Club, Fuel-Only).',
    `format_status` STRING COMMENT 'Current lifecycle status of the store format in the portfolio. Active formats are in production use; pilot formats are being tested; discontinued formats are no longer used for new stores.. Valid values are `active|inactive|pilot|discontinued`',
    `fresh_produce_included` BOOLEAN COMMENT 'Indicates whether stores of this format carry fresh produce departments with perishable inventory.',
    `fuel_center_included` BOOLEAN COMMENT 'Indicates whether stores of this format typically include an attached fuel center.',
    `gondola_count_typical` STRING COMMENT 'Typical number of gondola shelving units in stores of this format. Gondolas are the primary shelving units in store aisles.',
    `headcount_typical` STRING COMMENT 'Typical total employee headcount for stores of this format, used for labor planning and budgeting.',
    `home_delivery_enabled` BOOLEAN COMMENT 'Indicates whether stores of this format support last-mile delivery (LMD) services to customer homes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was last updated in the system.',
    `meat_seafood_included` BOOLEAN COMMENT 'Indicates whether stores of this format include fresh meat and seafood departments with butcher services.',
    `mfc_enabled` BOOLEAN COMMENT 'Indicates whether stores of this format include or are co-located with a Micro-Fulfillment Center (MFC) for automated online order fulfillment.',
    `online_pickup_enabled` BOOLEAN COMMENT 'Indicates whether stores of this format support click-and-collect online order pickup services (curbside or in-store).',
    `operating_hours_typical` STRING COMMENT 'Typical daily operating hours for stores of this format (e.g., 6am-11pm, 24/7). Used for labor scheduling and customer communication.',
    `parking_spaces_max` STRING COMMENT 'Maximum number of customer parking spaces typically provided for stores of this format.',
    `parking_spaces_min` STRING COMMENT 'Minimum number of customer parking spaces required for stores of this format, used for site selection and zoning compliance.',
    `pharmacy_included` BOOLEAN COMMENT 'Indicates whether stores of this format typically include a full-service pharmacy department.',
    `planogram_template_family` STRING COMMENT 'Identifier for the planogram template family used by this store format. Planograms are visual merchandise display plans that define product placement on shelves and fixtures.',
    `self_checkout_enabled` BOOLEAN COMMENT 'Indicates whether stores of this format typically include self-checkout capabilities.',
    `selling_area_percentage` DECIMAL(18,2) COMMENT 'Percentage of total square footage allocated to customer-facing selling area (excluding backroom, receiving, offices). Used for space productivity analysis.',
    `sku_count_max` STRING COMMENT 'Maximum number of unique SKUs (Stock Keeping Units) typically carried in stores of this format. Used for assortment planning and inventory management.',
    `sku_count_min` STRING COMMENT 'Minimum number of unique SKUs (Stock Keeping Units) typically carried in stores of this format. Used for assortment planning and inventory management.',
    `sku_count_typical` STRING COMMENT 'Typical or average number of unique SKUs (Stock Keeping Units) carried in stores of this format. Used as the baseline for assortment planning.',
    `square_footage_max` STRING COMMENT 'Maximum total retail square footage for stores in this format, measured in square feet. Used for site selection and capital planning.',
    `square_footage_min` STRING COMMENT 'Minimum total retail square footage for stores in this format, measured in square feet. Used for site selection and capital planning.',
    `square_footage_typical` STRING COMMENT 'Typical or average retail square footage for stores in this format, measured in square feet. Used as the baseline for new store planning and format conversion analysis.',
    `staffing_model_template` STRING COMMENT 'Identifier for the workforce staffing model template used for stores of this format, defining typical headcount, roles, and scheduling patterns.',
    CONSTRAINT pk_format PRIMARY KEY(`format_id`)
) COMMENT 'Reference classification of store formats used across the Grocery banner portfolio (e.g., Superstore 100K+ sqft, Neighborhood Market 40-60K sqft, Express/Convenience 10-15K sqft, Warehouse Club, Fuel-Only). Defines format-level attributes such as typical square footage range, standard department count and mix, default service capability set, planogram template family, typical SKU count range, and staffing model template. Used for store clustering, comp sales grouping, assortment planning, new store capital budgeting, and format conversion analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`region` (
    `region_id` BIGINT COMMENT 'Unique identifier for the region. Primary key.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the primary distribution center serving this region for replenishment and supply chain operations.',
    `division_id` BIGINT COMMENT 'Reference to the parent division or banner under which this region operates.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Region pricing zone determines zone‑wide pricing rules for all stores in the region; used in Regional Pricing Performance and budgeting.',
    `annual_ebitda_target_usd` DECIMAL(18,2) COMMENT 'Planned annual EBITDA target for the region in US dollars, representing operational profitability goal.',
    `annual_revenue_target_usd` DECIMAL(18,2) COMMENT 'Planned annual revenue target for the region in US dollars, used for P&L accountability and performance tracking.',
    `comp_sales_reporting_flag` BOOLEAN COMMENT 'Indicates whether this region is included in comp sales (same-store sales) performance reporting and analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was first created in the system.',
    `district_count` STRING COMMENT 'Total number of districts currently assigned to this region.',
    `effective_end_date` DATE COMMENT 'Date when this region was closed, consolidated, or otherwise ceased operations. Null for active regions.',
    `effective_start_date` DATE COMMENT 'Date when this region became active and operational within the organizational hierarchy.',
    `geographic_boundary_definition` STRING COMMENT 'Textual description of the geographic coverage of the region, typically listing states, metro areas, or counties included (e.g., NY, NJ, CT, PA eastern counties).',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or historical notes about the region.',
    `primary_state_code` STRING COMMENT 'Two-letter US state code representing the primary or largest state within the regions geographic boundary (e.g., NY, CA, TX).. Valid values are `^[A-Z]{2}$`',
    `promotional_calendar_code` STRING COMMENT 'Code identifying the promotional calendar or ad circular schedule applicable to this region.. Valid values are `^[A-Z0-9]{2,6}$`',
    `region_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the region for operational use and reporting (e.g., NE, SW, MW01).. Valid values are `^[A-Z0-9]{2,10}$`',
    `region_name` STRING COMMENT 'Full business name of the region (e.g., Northeast Region, Southwest Region).',
    `region_status` STRING COMMENT 'Current lifecycle status of the region: active (operational), inactive (closed or suspended), planned (future region), consolidating (merging into another region).. Valid values are `active|inactive|planned|consolidating`',
    `region_type` STRING COMMENT 'Classification of the region based on its organizational purpose: geographic (standard market region), operational (distribution-focused), strategic (growth/pilot region), or test (sandbox region).. Valid values are `geographic|operational|strategic|test`',
    `regional_office_address_line1` STRING COMMENT 'First line of the street address for the regional headquarters or administrative office.',
    `regional_office_address_line2` STRING COMMENT 'Second line of the street address for the regional headquarters (suite, floor, building).',
    `regional_office_city` STRING COMMENT 'City where the regional headquarters or administrative office is located.',
    `regional_office_phone` STRING COMMENT 'Primary contact phone number for the regional headquarters.. Valid values are `^+?[0-9]{10,15}$`',
    `regional_office_postal_code` STRING COMMENT 'ZIP or postal code for the regional headquarters location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `regional_office_state_code` STRING COMMENT 'Two-letter US state code for the regional headquarters location.. Valid values are `^[A-Z]{2}$`',
    `store_count` STRING COMMENT 'Total number of stores (all formats) currently operating within this region.',
    `time_zone` STRING COMMENT 'Primary time zone for the regions operations (e.g., EST, CST, MST, PST).. Valid values are `^[A-Z]{3,4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was last modified.',
    `workforce_headcount` STRING COMMENT 'Total number of employees (full-time and part-time) assigned to stores and facilities within this region.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Geographic and organizational hierarchy node representing a regional grouping of districts and stores under a Regional Vice President. Captures region code, region name, VP assignment (employee reference), geographic boundary definition (state/metro groupings), parent division or banner, number of districts, total store count, and active/inactive status. Serves as the primary roll-up level for comp sales reporting, regional pricing zones, promotional planning, workforce organizational structure, and P&L accountability.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`district` (
    `district_id` BIGINT COMMENT 'Unique identifier for the district organizational hierarchy node. Primary key.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the primary DC (Distribution Center) that services the majority of stores in this district. Used for supply chain planning and replenishment routing.',
    `region_id` BIGINT COMMENT 'Reference to the parent region in the organizational hierarchy. Districts roll up to regions for executive oversight and strategic planning.',
    `address_line_1` STRING COMMENT 'Primary street address line for the district office or administrative location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information for the district office. Organizational contact data classified as confidential.',
    `annual_sales_target` DECIMAL(18,2) COMMENT 'Planned annual sales revenue target for the district in USD. Used for budget planning, performance evaluation, and incentive compensation calculations.',
    `city` STRING COMMENT 'City where the district office is located. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the district office location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was first created in the system. Used for audit trail and data lineage tracking.',
    `district_code` STRING COMMENT 'Business identifier code for the district, used in operational reporting and external communications. Typically alphanumeric format assigned by corporate planning.. Valid values are `^[A-Z0-9]{3,10}$`',
    `district_name` STRING COMMENT 'Human-readable name of the district, often reflecting geographic coverage or regional designation (e.g., Metro Atlanta District, Northern California District).',
    `district_status` STRING COMMENT 'Current operational status of the district. Active districts have full operational authority; inactive districts are closed or suspended; consolidating districts are merging with others; restructuring districts are undergoing boundary or leadership changes.. Valid values are `active|inactive|consolidating|restructuring`',
    `effective_end_date` DATE COMMENT 'Date when the current district configuration will end or ended. Null for currently active configurations. Used for temporal hierarchy management and historical reporting.',
    `effective_start_date` DATE COMMENT 'Date when the current district configuration became effective. Used for time-based hierarchy queries and historical analysis of organizational changes.',
    `email_address` STRING COMMENT 'Primary email address for district-level communication and operational correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `established_date` DATE COMMENT 'Date when the district was officially established in the organizational hierarchy. Used for tenure analysis and historical reporting.',
    `geographic_coverage_description` STRING COMMENT 'Textual description of the geographic area covered by this district, including cities, counties, or regional boundaries. Used for territory planning and market analysis.',
    `labor_budget_hours` DECIMAL(18,2) COMMENT 'Total budgeted labor hours per week across all stores in the district. Used for workforce planning, scheduling optimization, and labor cost management.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special considerations, or operational context about the district. Used for qualitative information not captured in structured fields.',
    `performance_tier` STRING COMMENT 'Classification of district performance based on composite metrics including Comp Sales (Comparable Store Sales), Shrink (Inventory Loss), GMROI (Gross Margin Return on Investment), and NPS (Net Promoter Score). Used for resource allocation and incentive compensation.. Valid values are `platinum|gold|silver|bronze|developing`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the district office or district manager. Used for operational communication and escalation.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'Postal code (ZIP code in USA) for the district office location. Organizational contact data classified as confidential.. Valid values are `^d{5}(-d{4})?$`',
    `shrink_target_percentage` DECIMAL(18,2) COMMENT 'Target shrink rate as a percentage of sales for the district. Shrink represents inventory loss from theft, spoilage, or damage. District managers are accountable for maintaining shrink below this threshold.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code for the district office location. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{2}$`',
    `store_count` STRING COMMENT 'Total number of active stores currently assigned to this district. Typically ranges from 8 to 15 stores per district for effective span of control.',
    `time_zone` STRING COMMENT 'Primary time zone for the district, used for scheduling, reporting cutoffs, and operational coordination. Follows IANA time zone database naming convention. [ENUM-REF-CANDIDATE: America/New_York|America/Chicago|America/Denver|America/Los_Angeles|America/Phoenix|America/Anchorage|Pacific/Honolulu — 7 candidates stripped; promote to reference product]',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Aggregate selling square footage across all stores in the district. Used for productivity analysis, sales per square foot benchmarking, and capacity planning.',
    `updated_by_user` STRING COMMENT 'Username or employee identifier of the user who last modified this district record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was last modified. Used for audit trail, change tracking, and data freshness monitoring.',
    CONSTRAINT pk_district PRIMARY KEY(`district_id`)
) COMMENT 'Organizational hierarchy node below region, grouping a set of stores (typically 8-15) under a District Manager. Captures district code, district name, district manager employee reference, parent region reference, store count, geographic coverage description, performance tier classification, and active status. Used for operational oversight, labor scheduling aggregation, shrink accountability, weekly sales performance benchmarking, and district manager performance evaluation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`department` (
    `department_id` BIGINT COMMENT 'Unique identifier for the department. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category management reporting and department-level assortment planning require linking each store department (Produce, Deli, Bakery) to its governing assortment category. Retail-grocery category manag',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Department‑level expense allocation uses a dedicated cost center for detailed cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each department (produce, pharmacy, deli, fuel) posts revenue and COGS to a distinct GL account. gl_account_code on department is a denormalized representation of the GL account entity. Replacing it w',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Each store department maps to a primary item_hierarchy node (e.g., Dairy department → Dairy hierarchy node) for planogram assignment, category management, and department-level P&L reporting. Grocery c',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Pharmacy department records must link to the licensed pharmacy_location for DEA/state board regulatory reporting, labor scheduling, and planogram management. A grocery pharmacy director needs to map t',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: In grocery retail, each department (deli, produce, pharmacy, bakery) operates under a governing price rule defining margin floors, price endings, and markdown strategies. Department-level price rule a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each department (pharmacy, deli, fuel center) is tracked as a profit center for margin analysis in grocery retail. profit_center_code on department is a denormalized representation. A proper FK enable',
    `supplier_id` BIGINT COMMENT 'Identifier of the lead vendor designated as category captain for this department, responsible for category management insights and assortment recommendations.',
    `backroom_capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Total storage capacity in cubic feet allocated to this department in the backroom area.',
    `backroom_cooler_flag` BOOLEAN COMMENT 'Indicates whether the department has dedicated refrigerated storage in the backroom for cold chain inventory management.',
    `backroom_freezer_flag` BOOLEAN COMMENT 'Indicates whether the department has dedicated frozen storage in the backroom for frozen product inventory management.',
    `backroom_storage_zone` STRING COMMENT 'Designated backroom storage area identifier assigned to this department for inventory staging and replenishment.',
    `cooler_door_count` STRING COMMENT 'Number of refrigerated display doors allocated to this department for temperature-controlled products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was first created in the system.',
    `department_name` STRING COMMENT 'Human-readable name of the department (e.g., Produce, Bakery, Deli, Pharmacy, Frozen Foods, General Merchandise).',
    `department_number` STRING COMMENT 'Business identifier for the department, typically a 2-4 digit code used in store operations and reporting.. Valid values are `^[0-9]{2,4}$`',
    `department_status` STRING COMMENT 'Current operational status of the department within the store.. Valid values are `active|inactive|seasonal|remodel`',
    `department_type` STRING COMMENT 'Classification of the department based on operational characteristics: perishable (fresh produce, meat, dairy), center_store (shelf-stable goods), service (deli, bakery, floral), pharmacy (prescription and OTC medications), fuel (fuel center operations).. Valid values are `perishable|center_store|service|pharmacy|fuel`',
    `effective_end_date` DATE COMMENT 'Date when this department configuration ceased to be effective, null for currently active departments.',
    `effective_start_date` DATE COMMENT 'Date when this department configuration became effective in the store.',
    `endcap_count` STRING COMMENT 'Number of end-of-aisle display positions (endcaps) allocated to this department for promotional merchandise.',
    `fifo_lane_count` STRING COMMENT 'Number of FIFO rotation lanes configured in the backroom storage zone to ensure proper inventory rotation and minimize spoilage.',
    `gondola_count` STRING COMMENT 'Number of gondola shelving units allocated to this department for product display.',
    `haccp_classification` STRING COMMENT 'HACCP food safety classification indicating whether the department handles critical control point products requiring enhanced food safety monitoring and documentation.. Valid values are `critical|non_critical|not_applicable`',
    `labor_standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard weekly labor hours allocated to this department based on sales volume and operational complexity, used for workforce scheduling and labor budgeting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was last updated in the system.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this department carries USDA organic certified products requiring special handling and segregation.',
    `planogram_family` STRING COMMENT 'Planogram template family or category assigned to this department for visual merchandise display planning and fixture layout standardization.',
    `pos_department_code` STRING COMMENT 'Department code used in POS transaction processing and sales reporting systems for revenue attribution.',
    `private_label_focus_flag` BOOLEAN COMMENT 'Indicates whether this department has a strategic focus on private label (store-owned brand) product assortment and merchandising.',
    `replenishment_method` STRING COMMENT 'Primary inventory replenishment method used for this department: CAO (Computer-Assisted Ordering), manual ordering, DSD (Direct Store Delivery), or cross-dock distribution.. Valid values are `cao|manual|dsd|cross_dock`',
    `shrink_budget_target_percent` DECIMAL(18,2) COMMENT 'Target shrink rate (inventory loss from theft, spoilage, or damage) expressed as a percentage of sales, used for loss prevention planning and performance evaluation.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this department are generally eligible for purchase using SNAP/EBT benefits.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total sales floor area allocated to this department in square feet, used for space productivity analysis and planogram planning.',
    `temperature_zone` STRING COMMENT 'Primary temperature control zone classification for products in this department, critical for cold chain compliance and food safety.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this department are generally eligible for purchase using WIC benefits.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Operational department within a store such as Produce, Bakery, Deli, Pharmacy, Floral, Frozen Foods, or General Merchandise. Captures department number, name, type classification (perishable, center-store, service), assigned manager, allocated square footage, gondola count, endcap count, cooler door count, planogram family, shrink budget target, HACCP classification, and backroom storage zone configuration (capacity, cooler/freezer flags, FIFO lane count). Supports labor scheduling, category performance reporting, replenishment planning, food safety compliance, and fixture inventory tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`operating_hours` (
    `operating_hours_id` BIGINT COMMENT 'Unique identifier for the operating hours record. Primary key for this entity.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: operating_hours already tracks pharmacy_open_time, pharmacy_close_time, and pharmacy lunch break times. A direct FK to pharmacy_location enables the pharmacy scheduling system to retrieve its specific',
    `bakery_close_time` TIMESTAMP COMMENT 'The time when the in-store bakery department closes for fresh baked goods service. Format HH:MM in 24-hour notation. Null if bakery is not available at this location.',
    `bakery_open_time` TIMESTAMP COMMENT 'The time when the in-store bakery department opens for fresh baked goods service. Format HH:MM in 24-hour notation. Null if bakery is not available at this location.',
    `closure_reason` STRING COMMENT 'The reason for store closure when is_closed is True. Holiday for recognized holidays, weather for severe weather events, emergency for unplanned incidents, renovation for planned maintenance, staffing for labor shortages, inventory for physical inventory counts, special_event for community events. [ENUM-REF-CANDIDATE: holiday|weather|emergency|renovation|staffing|inventory|special_event — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this operating hours record was first created in the system. Used for audit trail and data lineage.',
    `customer_service_close_time` TIMESTAMP COMMENT 'The time when the customer service desk closes for returns, money orders, lottery, and other services. Format HH:MM in 24-hour notation. Null if customer service desk is not staffed separately.',
    `customer_service_open_time` TIMESTAMP COMMENT 'The time when the customer service desk opens for returns, money orders, lottery, and other services. Format HH:MM in 24-hour notation. Null if customer service desk is not staffed separately.',
    `day_of_week` STRING COMMENT 'The day of the week for recurring weekly operating hours schedules. Used in conjunction with or independently from effective_date for standard weekly patterns. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — 7 candidates stripped; promote to reference product]',
    `deli_close_time` TIMESTAMP COMMENT 'The time when the in-store deli department closes for fresh food service. Format HH:MM in 24-hour notation. Null if deli is not available at this location.',
    `deli_open_time` TIMESTAMP COMMENT 'The time when the in-store deli department opens for fresh food service. Format HH:MM in 24-hour notation. Null if deli is not available at this location.',
    `delivery_cutoff_time` TIMESTAMP COMMENT 'The latest time by which same-day or next-day delivery orders must be placed for fulfillment from this store location. Format HH:MM in 24-hour notation. Supports last mile delivery (LMD) operations.',
    `effective_date` DATE COMMENT 'The specific calendar date for which these operating hours are effective. Used for date-specific overrides such as holidays or special events.',
    `fuel_center_close_time` TIMESTAMP COMMENT 'The time when the fuel center closes for customer fueling. Format HH:MM in 24-hour notation. Null indicates fuel center is closed or not available at this location.',
    `fuel_center_open_time` TIMESTAMP COMMENT 'The time when the fuel center opens for customer fueling. Format HH:MM in 24-hour notation. Null indicates fuel center is closed or not available at this location.',
    `holiday_name` STRING COMMENT 'The name of the holiday when schedule_type is holiday. Examples include Thanksgiving, Christmas, New Years Day, Independence Day. Used for customer communication and workforce scheduling.',
    `is_24_hour_store` BOOLEAN COMMENT 'Indicates whether the store operates 24 hours per day. True if store never closes, False if store has defined open and close times.',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the store is completely closed on this date or day of week. True if closed all day, False if open for any period.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this operating hours record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about these operating hours. May include reasons for changes, special instructions, or customer communication details.',
    `online_ordering_enabled` BOOLEAN COMMENT 'Indicates whether online ordering for pickup or delivery is available during these operating hours. True if omnichannel order fulfillment is active, False if disabled.',
    `operating_hours_status` STRING COMMENT 'Current lifecycle status of this operating hours record. Active indicates currently in effect, inactive for historical records, pending for future scheduled changes, superseded when replaced by a newer record.. Valid values are `active|inactive|pending|superseded`',
    `pharmacy_close_time` TIMESTAMP COMMENT 'The time when the in-store pharmacy closes for prescription services. Format HH:MM in 24-hour notation. Null indicates pharmacy is closed or not available at this location.',
    `pharmacy_lunch_break_end` STRING COMMENT 'The end time of the pharmacy lunch break closure period. Format HH:MM in 24-hour notation. Required by some State Boards of Pharmacy for single-pharmacist locations.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `pharmacy_lunch_break_start` STRING COMMENT 'The start time of the pharmacy lunch break closure period. Format HH:MM in 24-hour notation. Required by some State Boards of Pharmacy for single-pharmacist locations.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `pharmacy_open_time` TIMESTAMP COMMENT 'The time when the in-store pharmacy opens for prescription services. Format HH:MM in 24-hour notation. Null indicates pharmacy is closed or not available at this location.',
    `pickup_window_end_time` TIMESTAMP COMMENT 'The latest time when curbside or in-store pickup orders can be collected by customers. Format HH:MM in 24-hour notation. Supports omnichannel click-and-collect fulfillment slot availability.',
    `pickup_window_start_time` TIMESTAMP COMMENT 'The earliest time when curbside or in-store pickup orders can be collected by customers. Format HH:MM in 24-hour notation. Supports omnichannel click-and-collect fulfillment slot availability.',
    `priority` STRING COMMENT 'Priority ranking for resolving conflicts when multiple operating hours records apply to the same store and date. Lower numbers indicate higher priority. Date-specific overrides typically have priority 1, standard weekly schedules have priority 10.',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when these operating hours were published to customer-facing channels. Used for audit trail and customer communication tracking.',
    `published_to_website` BOOLEAN COMMENT 'Indicates whether these operating hours have been published to the customer-facing store locator and website. True if visible to customers, False if internal only.',
    `schedule_type` STRING COMMENT 'Classification of the operating hours schedule. Standard represents normal weekly hours, holiday represents holiday overrides, special_event for promotional events, temporary for short-term changes, seasonal for recurring seasonal adjustments, emergency for unplanned closures or modifications.. Valid values are `standard|holiday|special_event|temporary|seasonal|emergency`',
    `senior_hours_end_time` TIMESTAMP COMMENT 'The end time for dedicated senior citizen and vulnerable population shopping hours. Format HH:MM in 24-hour notation. Null if no senior hours are offered.',
    `senior_hours_start_time` TIMESTAMP COMMENT 'The start time for dedicated senior citizen and vulnerable population shopping hours. Format HH:MM in 24-hour notation. Null if no senior hours are offered.',
    `source_system` STRING COMMENT 'The operational system of record that originated this operating hours data. Examples include Oracle Retail, SAP Retail, or proprietary store management systems.',
    `special_event_name` STRING COMMENT 'The name of the special event when schedule_type is special_event. Examples include Grand Opening, Anniversary Sale, Community Day. Used for promotional planning and extended hours justification.',
    `store_close_time` TIMESTAMP COMMENT 'The time when the main store closes to customer shopping. Format HH:MM in 24-hour notation. Null indicates store is closed for the day.',
    `store_open_time` TIMESTAMP COMMENT 'The time when the main store opens for customer shopping. Format HH:MM in 24-hour notation. Null indicates store is closed for the day.',
    CONSTRAINT pk_operating_hours PRIMARY KEY(`operating_hours_id`)
) COMMENT 'Scheduled and actual operating hours for each store location by day of week and date, including holiday overrides. Captures open time, close time, pharmacy hours, fuel center hours, pickup window hours, and special event hours. Supports omnichannel order fulfillment slot availability, customer-facing store locator, and workforce scheduling.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`service_capability` (
    `service_capability_id` BIGINT COMMENT 'Unique identifier for the service capability record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pharmacy, fuel center, and curbside pickup capabilities each have dedicated cost centers in grocery retail for tracking capability-specific labor, licensing, and operating costs — distinct from the st',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Pharmacy-category service capabilities (immunizations, MTM, REMS, specialty pharmacy, drive-through dispensing) must link directly to the licensed pharmacy_location for omnichannel routing (oms_capabi',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Store service capabilities (curbside pickup, home delivery) must reference governing SLA policies for omnichannel fulfillment SLA compliance reporting and breach alerting. sla_target_time_minutes on s',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Grocery service capabilities (pharmacy, fuel center, floral, MFC) are frequently operated under vendor partnership contracts. Linking service_capability to supplier enables vendor contract management,',
    `activation_status` STRING COMMENT 'Current operational status of the service capability at this store location. Active means the service is currently available to customers.. Valid values are `active|inactive|suspended|pending_activation|decommissioned|seasonal`',
    `average_fulfillment_time_minutes` STRING COMMENT 'Average time in minutes required to fulfill a customer order or transaction using this service capability. Used for customer communication and capacity planning.',
    `capability_category` STRING COMMENT 'High-level category grouping for the service capability to support filtering and reporting.. Valid values are `omnichannel|pharmacy|financial_services|food_service|specialty_services|payment_acceptance`',
    `capability_code` STRING COMMENT 'Standardized code identifying the type of service capability (e.g., CURBSIDE_PICKUP, HOME_DELIVERY, PHARMACY_DRIVE_THRU, COINSTAR, WESTERN_UNION, STARBUCKS_KIOSK, SUSHI_BAR, FLORAL_CUSTOM, EBT_SNAP_WIC, LOTTERY, MONEY_ORDER, BOTTLE_RETURN).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `capability_description` STRING COMMENT 'Detailed description of the service capability, including what it offers and any special conditions or limitations.',
    `capability_name` STRING COMMENT 'Human-readable name of the service capability for customer-facing display and internal reference.',
    `capacity_limit` STRING COMMENT 'Maximum concurrent capacity for this service capability (e.g., maximum number of pickup orders that can be processed simultaneously, number of drive-thru lanes, kiosk stations). Null if no specific limit applies.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity limit (e.g., orders per hour, concurrent customers, transaction slots).. Valid values are `orders|customers|transactions|lanes|stations|units`',
    `compliance_certification_required_flag` BOOLEAN COMMENT 'Indicates whether staff must complete specific compliance training or certification to operate this service capability (e.g., HIPAA training for pharmacy, food safety certification for food service).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service capability record was first created in the system.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this service capability should be displayed to customers in store locator tools, mobile apps, and marketing materials.',
    `daily_capacity_limit` STRING COMMENT 'Maximum number of service transactions or orders that can be fulfilled in a single day. Used for omnichannel order routing and capacity planning.',
    `display_priority` STRING COMMENT 'Numeric priority for ordering service capabilities in customer-facing displays. Lower numbers indicate higher priority.',
    `effective_end_date` DATE COMMENT 'Date when this service capability was or will be discontinued at the store location. Null indicates the service is ongoing with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this service capability became or will become available at the store location.',
    `equipment_description` STRING COMMENT 'Description of the specialized equipment or infrastructure required to support this service capability, including make, model, or configuration details.',
    `equipment_required_flag` BOOLEAN COMMENT 'Indicates whether specialized equipment or infrastructure is required to deliver this service capability (e.g., refrigerated pickup lockers, drive-thru window, kiosk hardware).',
    `installation_date` DATE COMMENT 'Date when the equipment or infrastructure for this service capability was installed at the store location.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance or inspection was performed on the equipment or infrastructure supporting this service capability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service capability record was most recently modified.',
    `license_expiration_date` DATE COMMENT 'Date when the regulatory license or permit expires and must be renewed to continue offering this service capability.',
    `license_number` STRING COMMENT 'Regulatory license or permit number authorizing the store to offer this service capability. Confidential business information.',
    `license_required_flag` BOOLEAN COMMENT 'Indicates whether a regulatory license or permit is required to offer this service capability (e.g., pharmacy license, lottery license, money transmitter license).',
    `next_maintenance_due_date` DATE COMMENT 'Date when the next scheduled maintenance or inspection is due for the equipment or infrastructure supporting this service capability.',
    `notes` STRING COMMENT 'Free-form notes or comments about this service capability, including special instructions, known issues, or temporary conditions.',
    `omnichannel_routing_enabled_flag` BOOLEAN COMMENT 'Indicates whether this service capability is integrated with the Order Management System (OMS) for automated omnichannel order routing and fulfillment assignment.',
    `oms_capability_code` STRING COMMENT 'Code used by the Order Management System to identify and route orders to this service capability. Must match OMS configuration.',
    `operating_hours_description` STRING COMMENT 'Textual description of the operating hours for this service capability if different from store hours (e.g., Pharmacy: Mon-Fri 9am-9pm, Sat 9am-6pm, Sun 10am-6pm).',
    `operating_hours_same_as_store_flag` BOOLEAN COMMENT 'Indicates whether this service capability operates during the same hours as the store itself, or has different operating hours.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue from this service capability that is shared with a vendor partner. Confidential business information used for financial reporting and vendor management.',
    `seasonal_end_month` STRING COMMENT 'Month number (1-12) when seasonal service capability typically ends each year. Null if not seasonal.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this service capability is offered seasonally rather than year-round (e.g., holiday gift wrapping, seasonal outdoor plant sales).',
    `seasonal_start_month` STRING COMMENT 'Month number (1-12) when seasonal service capability typically begins each year. Null if not seasonal.',
    `staffing_requirement_fte` DECIMAL(18,2) COMMENT 'Number of full-time equivalent employees required to operate this service capability during standard operating hours. Used for labor planning and scheduling.',
    CONSTRAINT pk_service_capability PRIMARY KEY(`service_capability_id`)
) COMMENT 'Catalog of service capabilities available at a store location, such as Curbside Pickup, Home Delivery, Click-and-Collect, Pharmacy Drive-Through, Coinstar, Western Union, Starbucks Kiosk, Sushi Bar, Floral Custom Orders, EBT/SNAP/WIC acceptance, lottery sales, money orders, and bottle return. Each record defines the capability type, activation status, capacity limits (e.g., max concurrent pickup orders), staffing requirements, equipment dependencies, and effective date range. Enables omnichannel order routing, customer-facing store locator feature display, labor planning, and site selection analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`mfc_profile` (
    `mfc_profile_id` BIGINT COMMENT 'Unique identifier for the micro-fulfillment center profile record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Micro-fulfillment centers are capital-intensive operations with dedicated cost centers for robotics labor, maintenance, and fulfillment costs — separate from the host stores cost center. Grocery reta',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: MFC profiles process ecommerce/omnichannel orders through dedicated payment gateways distinct from the stores POS gateway. Grocery retailers route MFC fulfillment transactions through separate ecomme',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: MFC operational management requires linking each in-store micro-fulfillment center profile to its corresponding fulfillment node for order routing, capacity planning, and WMS integration. A retail-gro',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: MFCs in large grocery chains are tracked as distinct profit centers separate from the host store to measure e-commerce fulfillment P&L. Grocery retailers report MFC contribution margin separately for ',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Each MFC operates under specific SLA commitments (e.g., 2-hour pickup windows). Linking mfc_profile to sla_policy enables MFC-level SLA configuration, breach monitoring, and auto-compensation rules. R',
    `store_location_id` BIGINT COMMENT 'Reference to the retail store location with which this MFC is co-located or adjacent. Links the MFC to its parent store for operational and reporting purposes.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Robotics vendor contracts are managed per fulfillment center; linking enables tracking of vendor performance, costs, and compliance for each stores MFC.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: MFC replenishment is sourced from a specific supplier site (vendor warehouse or distribution point). Grocery retailers operationally track which supplier site feeds each MFC for cold-chain compliance,',
    `activation_date` DATE COMMENT 'Date when the MFC became operational and began fulfilling customer orders. Used for capacity planning and performance tracking.',
    `ambient_zone_enabled` BOOLEAN COMMENT 'Indicates whether the MFC has an ambient temperature zone for storing shelf-stable products (dry goods, canned items, non-perishables).',
    `average_inventory_accuracy_percent` DECIMAL(18,2) COMMENT 'Rolling average percentage of inventory records that match physical counts during cycle counts. Key metric for operational excellence.',
    `average_order_accuracy_percent` DECIMAL(18,2) COMMENT 'Rolling average percentage of orders fulfilled without errors (wrong items, missing items, damaged items). Critical customer satisfaction metric.',
    `average_order_fulfillment_time_minutes` DECIMAL(18,2) COMMENT 'Mean time in minutes from order receipt to order ready for pickup or dispatch. Critical SLA metric for omnichannel fulfillment.',
    `average_pick_time_seconds` DECIMAL(18,2) COMMENT 'Mean time in seconds to pick a single item from inventory. Key performance indicator for MFC efficiency and throughput modeling.',
    `chilled_zone_enabled` BOOLEAN COMMENT 'Indicates whether the MFC has a refrigerated zone for storing chilled products (dairy, fresh produce, deli items) typically maintained at 32-40°F.',
    `cold_chain_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether the MFC has automated temperature monitoring systems for chilled and frozen zones to ensure cold chain integrity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this MFC profile record was first created in the system. Used for audit trail and data lineage.',
    `daily_order_capacity` STRING COMMENT 'Maximum number of customer orders the MFC can fulfill in a 24-hour period under normal operating conditions. Used for order routing and capacity planning.',
    `deactivation_date` DATE COMMENT 'Date when the MFC ceased operations, if applicable. Null for active MFCs. Used for historical analysis and capacity planning.',
    `food_safety_inspection_score` DECIMAL(18,2) COMMENT 'Numerical score from the most recent food safety inspection, typically on a 0-100 scale. Higher scores indicate better compliance.',
    `frozen_zone_enabled` BOOLEAN COMMENT 'Indicates whether the MFC has a frozen storage zone for frozen foods, ice cream, and other products requiring temperatures at or below 0°F.',
    `fulfillment_service_types` STRING COMMENT 'Comma-separated list of fulfillment services supported by this MFC (e.g., curbside pickup, home delivery, ship-from-store, same-day delivery). [ENUM-REF-CANDIDATE: curbside_pickup|home_delivery|ship_from_store|same_day_delivery|next_day_delivery|scheduled_delivery|locker_pickup — promote to reference product]',
    `haccp_certified` BOOLEAN COMMENT 'Indicates whether the MFC has achieved HACCP certification for food safety management, required for facilities handling perishable foods.',
    `last_food_safety_inspection_date` DATE COMMENT 'Date of the most recent food safety inspection by regulatory authorities (FDA, USDA, or state health department). Used for compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this MFC profile record was most recently updated. Used for change tracking and audit purposes.',
    `mfc_code` STRING COMMENT 'Externally-known unique business identifier for the MFC, used in operational systems and reporting. Format: MFC followed by 6 digits.. Valid values are `^MFC[0-9]{6}$`',
    `mfc_name` STRING COMMENT 'Human-readable name or designation of the MFC, typically including geographic or store reference for easy identification by operations teams.',
    `mfc_type` STRING COMMENT 'Classification of the MFC based on its operational model: automated (fully robotic picking and packing), semi-automated (hybrid human and robotic), or manual (human-only fulfillment).. Valid values are `automated|semi-automated|manual`',
    `number_of_packing_stations` STRING COMMENT 'Count of workstations where picked orders are packed into bags or boxes for customer delivery or pickup. Used for labor planning.',
    `number_of_picking_stations` STRING COMMENT 'Count of workstations where associates or robots pick items into customer orders. Key metric for throughput capacity planning.',
    `number_of_robots` STRING COMMENT 'Total count of robotic units (picking robots, transport robots, sorting robots) deployed in the MFC. Zero for manual facilities.',
    `oms_integration_enabled` BOOLEAN COMMENT 'Indicates whether the MFC is integrated with the enterprise Order Management System for real-time order routing and fulfillment orchestration.',
    `operating_hours_end` STRING COMMENT 'Daily end time for MFC operations in 24-hour HH:MM format. Used for order routing and labor scheduling.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily start time for MFC operations in 24-hour HH:MM format. Used for order routing and labor scheduling.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current lifecycle status of the MFC indicating whether it is actively fulfilling orders, temporarily offline, being built, or permanently closed.. Valid values are `active|inactive|under_construction|decommissioned|maintenance`',
    `peak_hourly_order_capacity` STRING COMMENT 'Maximum number of orders the MFC can process in a single hour during peak demand periods. Critical for real-time order routing decisions.',
    `picking_square_footage` DECIMAL(18,2) COMMENT 'Floor area dedicated to order picking operations in square feet. Used for productivity analysis and space utilization metrics.',
    `rfid_enabled` BOOLEAN COMMENT 'Indicates whether the MFC uses RFID technology for inventory tracking and order accuracy verification.',
    `robotics_vendor` STRING COMMENT 'Name of the robotics or automation technology provider for automated or semi-automated MFCs (e.g., AutoStore, Dematic, Ocado). Null for manual MFCs.',
    `sku_count` STRING COMMENT 'Total number of unique SKUs stocked in the MFC at any given time. Indicates assortment breadth and inventory complexity.',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the MFC facility in square feet, including all operational zones, staging areas, and support spaces.',
    `total_tote_capacity` STRING COMMENT 'Maximum number of totes (storage containers) that the MFC can hold at any given time. Key metric for inventory capacity planning.',
    `twenty_four_hour_operation` BOOLEAN COMMENT 'Indicates whether the MFC operates continuously 24 hours per day, 7 days per week. True for round-the-clock facilities.',
    `wms_instance_code` STRING COMMENT 'Unique identifier for the specific WMS instance or tenant serving this MFC. Used for technical integration and troubleshooting.',
    `wms_system_name` STRING COMMENT 'Name of the WMS platform integrated with this MFC (e.g., Manhattan Associates, Blue Yonder, SAP EWM). Used for system integration and support.',
    CONSTRAINT pk_mfc_profile PRIMARY KEY(`mfc_profile_id`)
) COMMENT 'Master profile for a Micro-Fulfillment Center (MFC) co-located with or adjacent to a store. Captures MFC ID, associated store location, MFC type (automated/manual), total tote capacity, daily order throughput capacity, temperature zone configuration (ambient, chilled, frozen), WMS system integration reference, activation date, and operational status. Supports omnichannel fulfillment routing and capacity planning.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique identifier for the health inspection record. Primary key for the health inspection entity.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the health inspection was conducted.',
    `closure_end_date` DATE COMMENT 'Date when the store or department was permitted to reopen after corrective actions were verified and approved by the inspecting agency.',
    `closure_ordered` BOOLEAN COMMENT 'Boolean flag indicating whether the inspecting agency ordered immediate closure of the store or specific departments due to critical food safety violations posing imminent health hazard. True indicates closure ordered, False indicates no closure.',
    `closure_start_date` DATE COMMENT 'Date when the store or department closure became effective due to health violations.',
    `corrective_action_due_date` DATE COMMENT 'Date by which all corrective actions must be completed to address violations identified during the inspection.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective actions required to address violations, including specific steps, responsible parties, and timelines for remediation.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to address violations identified during the inspection. True indicates corrective actions needed, False indicates no actions required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the health inspection record was first created in the system.',
    `critical_violation_count` STRING COMMENT 'Number of critical violations identified during the inspection. Critical violations are food safety issues that pose immediate risk to public health (e.g., improper food temperatures, cross-contamination, inadequate handwashing).',
    `cross_contamination_compliance` STRING COMMENT 'Compliance status for preventing cross-contamination between raw and ready-to-eat foods, proper separation of food preparation areas, and equipment sanitation.. Valid values are `compliant|non-compliant|not-checked`',
    `departments_inspected` STRING COMMENT 'Comma-separated list of store departments included in the inspection scope (e.g., Deli, Bakery, Meat, Seafood, Produce, Pharmacy, Prepared Foods, Grocery).',
    `facility_maintenance_compliance` STRING COMMENT 'Compliance status for physical facility maintenance including floors, walls, ceilings, lighting, ventilation, and equipment condition.. Valid values are `compliant|non-compliant|not-checked`',
    `food_temperature_compliance` STRING COMMENT 'Compliance status for proper food storage and holding temperatures. Critical for preventing bacterial growth and foodborne illness.. Valid values are `compliant|non-compliant|not-checked`',
    `haccp_compliance_status` STRING COMMENT 'Status of compliance with HACCP food safety management system principles. HACCP is a systematic preventive approach to food safety addressing biological, chemical, and physical hazards. Compliant indicates full adherence, non-compliant indicates violations, not-applicable indicates HACCP not required for this location, partial indicates some HACCP elements in place.. Valid values are `compliant|non-compliant|not-applicable|partial`',
    `handwashing_compliance` STRING COMMENT 'Compliance status for proper handwashing facilities, employee hand hygiene practices, and personal cleanliness standards.. Valid values are `compliant|non-compliant|not-checked`',
    `inspecting_agency` STRING COMMENT 'Name of the regulatory agency or health department that conducted the inspection (e.g., County Health Department, FDA, USDA).',
    `inspection_date` DATE COMMENT 'Date when the health inspection was conducted at the store location.',
    `inspection_duration_minutes` STRING COMMENT 'Total duration of the inspection in minutes, from start to completion.',
    `inspection_number` STRING COMMENT 'Externally-known unique inspection number assigned by the inspecting agency or internal tracking system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `inspection_report_url` STRING COMMENT 'URL link to the full inspection report document stored in the document management system or public health department website.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the health inspection. Scheduled indicates future inspection, in-progress indicates active inspection, completed indicates inspection finished, passed indicates no critical violations, failed indicates critical violations found, pending-review indicates awaiting final determination, cancelled indicates inspection did not occur. [ENUM-REF-CANDIDATE: scheduled|in-progress|completed|passed|failed|pending-review|cancelled — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Type of health inspection conducted. Routine inspections are scheduled periodic reviews, follow-up inspections verify corrective actions, complaint-driven inspections respond to customer or employee reports, pre-opening inspections occur before new store launch, special inspections address specific concerns, and reinspections verify compliance after violations.. Valid values are `routine|follow-up|complaint-driven|pre-opening|special|reinspection`',
    `inspector_code` STRING COMMENT 'Unique identifier or badge number of the health inspector assigned by the inspecting agency.',
    `inspector_name` STRING COMMENT 'Full name of the health inspector who conducted the inspection.',
    `letter_grade` STRING COMMENT 'Letter grade assigned to the inspection based on overall score, if applicable in the jurisdiction (A=excellent, B=good, C=satisfactory, D=marginal, F=failing).. Valid values are `A|B|C|D|F`',
    `non_critical_violation_count` STRING COMMENT 'Number of non-critical violations identified during the inspection. Non-critical violations are food safety issues that do not pose immediate risk but require correction (e.g., minor equipment maintenance, documentation gaps).',
    `notes` STRING COMMENT 'Additional notes, observations, or comments from the inspector or store management regarding the inspection, violations, or corrective actions.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the inspection representing overall food safety compliance. Scoring scale varies by jurisdiction (e.g., 0-100 scale where higher is better, or deduction-based scoring).',
    `pest_control_compliance` STRING COMMENT 'Compliance status for pest prevention and control measures, including evidence of rodents, insects, or other pests.. Valid values are `compliant|non-compliant|not-checked`',
    `posted_at_store` BOOLEAN COMMENT 'Boolean flag indicating whether the inspection results or grade card has been posted at the store location as required by local regulations. True indicates posted, False indicates not posted.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the inspection results are subject to public disclosure or posting requirements per local health department regulations. True indicates public disclosure required, False indicates confidential.',
    `reinspection_date` DATE COMMENT 'Scheduled date for follow-up reinspection to verify that corrective actions have been completed and violations have been resolved.',
    `reinspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up reinspection is required to verify corrective actions have been completed. True indicates reinspection needed, False indicates no reinspection required.',
    `score_scale` STRING COMMENT 'Description of the scoring scale used for the overall score (e.g., 0-100 scale, A-F letter grade, pass/fail, deduction-based).',
    `total_violation_count` STRING COMMENT 'Total number of violations (critical and non-critical combined) identified during the inspection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the health inspection record was last modified in the system.',
    CONSTRAINT pk_health_inspection PRIMARY KEY(`health_inspection_id`)
) COMMENT 'Record of food safety and health department inspections conducted at a store location. Captures inspection ID, inspection date, inspecting agency (local health department, FDA, USDA), inspection type (routine, follow-up, complaint-driven), overall score, critical violation count, non-critical violation count, HACCP compliance status, corrective action plan, and re-inspection date. Supports FDA/USDA regulatory compliance and HACCP program management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`lease` (
    `lease_id` BIGINT COMMENT 'Primary key for lease',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Occupancy costs (base rent, CAM charges, property tax) are charged to a cost center for P&L reporting. Grocery finance teams track occupancy expense by cost center for store-level profitability analys',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ASC 842/IFRS 16 lease accounting requires each lease mapped to specific GL accounts (right-of-use asset, lease liability, rent expense). Grocery retailers with hundreds of leased locations must post l',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Leases are executed by a specific legal entity (the lessee). Multi-banner grocery operators (Kroger, Albertsons) have different legal entities signing leases per banner/region. SOX disclosure flag on ',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location covered by this lease agreement.',
    `base_rent_amount_usd` DECIMAL(18,2) COMMENT 'Monthly or annual base rent amount in US dollars before additional charges.',
    `base_rent_frequency` STRING COMMENT 'Frequency at which base rent payments are due.. Valid values are `monthly|quarterly|annually`',
    `cam_charges_usd` DECIMAL(18,2) COMMENT 'Common Area Maintenance charges in US dollars covering shared facility costs such as landscaping, parking lot maintenance, and common utilities.',
    `co_tenancy_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease includes a co-tenancy clause that provides rent relief or termination rights if anchor tenants vacate the property.',
    `commencement_date` DATE COMMENT 'Date when the lease agreement becomes effective and rent obligations begin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the digitally stored lease agreement document for reference and audit purposes.',
    `early_termination_allowed_flag` BOOLEAN COMMENT 'Indicates whether the lease agreement includes an early termination clause allowing tenant to exit before expiration date.',
    `early_termination_penalty_usd` DECIMAL(18,2) COMMENT 'Financial penalty amount in US dollars that tenant must pay if exercising early termination clause.',
    `exclusivity_category` STRING COMMENT 'Business category or industry segment protected under the exclusivity provision (e.g., grocery, pharmacy, fuel).',
    `exclusivity_provision_flag` BOOLEAN COMMENT 'Indicates whether the lease includes an exclusivity clause preventing landlord from leasing to competing businesses in the same property.',
    `execution_date` DATE COMMENT 'Date when the lease agreement was signed by both landlord and tenant.',
    `expiration_date` DATE COMMENT 'Date when the lease agreement term ends unless renewed or extended.',
    `guarantor_name` STRING COMMENT 'Legal name of the entity or individual providing financial guarantee for the lease obligations.',
    `insurance_amount_usd` DECIMAL(18,2) COMMENT 'Annual insurance premium amount in US dollars that tenant is responsible for under the lease terms.',
    `landlord_contact_name` STRING COMMENT 'Primary contact person name at the landlord organization for lease administration.',
    `landlord_email` STRING COMMENT 'Primary email address for landlord contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `landlord_name` STRING COMMENT 'Legal name of the landlord or property owner entity that holds title to the leased premises.',
    `landlord_phone` STRING COMMENT 'Primary phone number for landlord contact. Organizational contact data classified as confidential.',
    `lease_number` STRING COMMENT 'Externally-known lease agreement number or reference code used by landlord and tenant for identification.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement.. Valid values are `active|pending|expired|terminated|renewed|holdover`',
    `lease_type` STRING COMMENT 'Classification of the lease agreement type for accounting and operational purposes.. Valid values are `operating|capital|ground|sublease|license`',
    `leased_square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the leased premises as specified in the lease agreement.',
    `notes` STRING COMMENT 'Free-form text field for additional lease terms, special conditions, or administrative notes.',
    `property_address_line1` STRING COMMENT 'First line of the leased property street address. Organizational location data classified as confidential.',
    `property_address_line2` STRING COMMENT 'Second line of the leased property street address (suite, unit, building). Organizational location data classified as confidential.',
    `property_city` STRING COMMENT 'City where the leased property is located. Organizational location data classified as confidential.',
    `property_country_code` STRING COMMENT 'Three-letter ISO country code where the leased property is located.. Valid values are `^[A-Z]{3}$`',
    `property_postal_code` STRING COMMENT 'Postal or ZIP code of the leased property. Organizational location data classified as confidential.',
    `property_state_code` STRING COMMENT 'Two-letter state or province code where the leased property is located. Organizational location data classified as confidential.. Valid values are `^[A-Z]{2}$`',
    `property_tax_amount_usd` DECIMAL(18,2) COMMENT 'Annual property tax amount in US dollars that tenant is responsible for under the lease terms.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to lease expiration that tenant must provide written notice to exercise renewal option.',
    `renewal_option_count` STRING COMMENT 'Number of renewal option periods available to the tenant after the initial lease term expires.',
    `renewal_option_term_months` STRING COMMENT 'Duration in months of each renewal option period if exercised by the tenant.',
    `rent_escalation_rate_percent` DECIMAL(18,2) COMMENT 'Annual percentage rate at which base rent increases if escalation type is percentage-based.',
    `rent_escalation_type` STRING COMMENT 'Type of rent escalation clause defining how base rent increases over the lease term.. Valid values are `fixed|cpi|percentage|none`',
    `security_deposit_usd` DECIMAL(18,2) COMMENT 'Security deposit amount in US dollars held by landlord to cover potential damages or unpaid rent.',
    `sox_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this lease agreement requires disclosure in financial statements under Sarbanes-Oxley Act compliance requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was last modified in the system.',
    CONSTRAINT pk_lease PRIMARY KEY(`lease_id`)
) COMMENT 'Real estate lease record for store locations that are leased rather than owned. Captures lease ID, store location, landlord entity name, lease commencement date, lease expiration date, renewal option terms, base rent amount, CAM (Common Area Maintenance) charges, rent escalation schedule, co-tenancy clauses, exclusivity provisions, and lease status. Supports real estate portfolio management, SOX financial disclosure, and capital vs. operating lease classification.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`banner` (
    `banner_id` BIGINT COMMENT 'Primary key for banner',
    `division_id` BIGINT COMMENT 'Foreign key linking to store.division. Business justification: In grocery retail, banners (brand identities such as King Soopers, Ralphs, Fred Meyer) are operated and governed by organizational divisions. This is a genuine 1:N relationship: one division operates ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each grocery banner (Kroger, Fred Meyer, Ralphs, Safeway) operates under a distinct legal entity for tax, regulatory, and consolidated financial reporting. Banner-level P&L is reported by legal entity',
    `parent_banner_id` BIGINT COMMENT 'Identifier of the parent banner in a hierarchical banner structure; null if top‑level.',
    `program_config_id` BIGINT COMMENT 'Foreign key linking to loyalty.program_config. Business justification: In retail-grocery, loyalty programs are branded and operated at the banner level (e.g., Kroger Plus, Safeway Club Card). Banner-to-program_config assignment drives which loyalty rules, earn rates, and',
    `average_sales_per_store` DECIMAL(18,2) COMMENT 'Average annual sales (in local currency) generated per store under the banner.',
    `banner_code` STRING COMMENT 'Business code used to uniquely identify the banner in operational systems.',
    `banner_description` STRING COMMENT 'Free‑form textual description of the banners market positioning and characteristics.',
    `banner_name` STRING COMMENT 'Human‑readable name of the banner as displayed to customers and internal users.',
    `banner_status` STRING COMMENT 'Current lifecycle status of the banner.',
    `banner_type` STRING COMMENT 'Classification of the banner based on its market positioning and ownership model.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the banner is headquartered or primarily active.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the banner record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for financial reporting of the banner.',
    `effective_from` DATE COMMENT 'Date when the banner became operational or was first introduced.',
    `effective_until` DATE COMMENT 'Date when the banner is scheduled to be retired or become inactive; null if open‑ended.',
    `franchise_fee_percent` DECIMAL(18,2) COMMENT 'Standard percentage of gross sales paid as franchise fee for stores under this banner.',
    `is_franchise` BOOLEAN COMMENT 'True if the banner operates primarily through franchise agreements.',
    `logo_url` STRING COMMENT 'Web address of the banners logo image for digital assets.',
    `loyalty_program_eligible` BOOLEAN COMMENT 'True if stores under the banner participate in the corporate loyalty program.',
    `market_segment` STRING COMMENT 'Primary market segment targeted by the banner.',
    `online_presence` BOOLEAN COMMENT 'Indicates whether the banner has an e‑commerce or digital storefront offering.',
    `region` STRING COMMENT 'Primary geographic region (e.g., Midwest, Southeast) where the banner operates.',
    `store_count` STRING COMMENT 'Number of individual store locations that belong to this banner.',
    `target_customer_group` STRING COMMENT 'Primary customer demographic group the banner is designed to attract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the banner record.',
    CONSTRAINT pk_banner PRIMARY KEY(`banner_id`)
) COMMENT 'Master reference table for banner. Referenced by banner_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`store`.`division` (
    `division_id` BIGINT COMMENT 'Primary key for division',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Grocery retail divisions (e.g., Krogers Mid-Atlantic Division) map to legal entities for consolidated financial reporting, tax filings, and intercompany eliminations. Division-level financial stateme',
    `parent_division_id` BIGINT COMMENT 'Self-referencing FK on division (parent_division_id)',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code for the divisions primary country.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the division record was first created.',
    `division_code` STRING COMMENT 'Business identifier code assigned to the division.',
    `division_description` STRING COMMENT 'Free‑form description providing additional context about the division.',
    `division_name` STRING COMMENT 'Human‑readable name of the division.',
    `division_status` STRING COMMENT 'Current lifecycle status of the division.',
    `division_type` STRING COMMENT 'Classification of the division by business model or scope.',
    `effective_from` DATE COMMENT 'Date when the division became operational.',
    `effective_until` DATE COMMENT 'Date when the division ceased operation (null if still active).',
    `headcount` STRING COMMENT 'Total number of employees working in the division.',
    `is_franchise` BOOLEAN COMMENT 'Flag indicating whether the division operates as a franchise (true) or company‑owned (false).',
    `region` STRING COMMENT 'Higher‑level geographic region to which the division belongs.',
    `store_count` STRING COMMENT 'Number of stores assigned to the division.',
    `total_sqft` DECIMAL(18,2) COMMENT 'Combined square footage of all stores in the division.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the division record.',
    CONSTRAINT pk_division PRIMARY KEY(`division_id`)
) COMMENT 'Master reference table for division. Referenced by division_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_district_id` FOREIGN KEY (`district_id`) REFERENCES `grocery_ecm`.`store`.`district`(`district_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`store`.`region` ADD CONSTRAINT `fk_store_region_division_id` FOREIGN KEY (`division_id`) REFERENCES `grocery_ecm`.`store`.`division`(`division_id`);
ALTER TABLE `grocery_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ADD CONSTRAINT `fk_store_health_inspection_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`store`.`lease` ADD CONSTRAINT `fk_store_lease_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`store`.`banner` ADD CONSTRAINT `fk_store_banner_division_id` FOREIGN KEY (`division_id`) REFERENCES `grocery_ecm`.`store`.`division`(`division_id`);
ALTER TABLE `grocery_ecm`.`store`.`banner` ADD CONSTRAINT `fk_store_banner_parent_banner_id` FOREIGN KEY (`parent_banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`store`.`division` ADD CONSTRAINT `fk_store_division_parent_division_id` FOREIGN KEY (`parent_division_id`) REFERENCES `grocery_ecm`.`store`.`division`(`division_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`store` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`store` SET TAGS ('dbx_domain' = 'store');
ALTER TABLE `grocery_ecm`.`store`.`store_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`store_location` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location ID');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Config Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `accepts_snap_ebt` SET TAGS ('dbx_business_glossary_term' = 'Accepts SNAP EBT Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `accepts_wic` SET TAGS ('dbx_business_glossary_term' = 'Accepts WIC Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `backroom_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Backroom Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Store Closure Date');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Store Email Address');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `gross_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_bakery` SET TAGS ('dbx_business_glossary_term' = 'Has Bakery Department Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_deli` SET TAGS ('dbx_business_glossary_term' = 'Has Deli Department Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_floral` SET TAGS ('dbx_business_glossary_term' = 'Has Floral Department Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_fuel_center` SET TAGS ('dbx_business_glossary_term' = 'Has Fuel Center Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_meat_department` SET TAGS ('dbx_business_glossary_term' = 'Has Meat Department Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_organic_section` SET TAGS ('dbx_business_glossary_term' = 'Has Organic Section Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_pharmacy` SET TAGS ('dbx_business_glossary_term' = 'Has Pharmacy Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `has_seafood` SET TAGS ('dbx_business_glossary_term' = 'Has Seafood Department Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `last_remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Store Opening Date');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|franchised|licensed');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `parking_spaces_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `selling_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Selling Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `store_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `supports_curbside_pickup` SET TAGS ('dbx_business_glossary_term' = 'Supports Curbside Pickup Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `supports_home_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Home Delivery Flag');
ALTER TABLE `grocery_ecm`.`store`.`store_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`store`.`format` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`store`.`format` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format ID');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `annual_revenue_target_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Annual Revenue Target');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `annual_revenue_target_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `annual_revenue_target_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Revenue Target');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `annual_revenue_target_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `bakery_included` SET TAGS ('dbx_business_glossary_term' = 'Bakery Department Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `capital_investment_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Capital Investment Amount');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `capital_investment_typical` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `checkout_lane_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Checkout Lane Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `checkout_lane_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Checkout Lane Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `deli_included` SET TAGS ('dbx_business_glossary_term' = 'Deli Department Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `department_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Department Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `department_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Department Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `endcap_count_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Endcap Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_category` SET TAGS ('dbx_business_glossary_term' = 'Store Format Category');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_category` SET TAGS ('dbx_value_regex' = 'superstore|neighborhood_market|express|warehouse_club|fuel_only|pharmacy_standalone');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Store Format Code');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_description` SET TAGS ('dbx_business_glossary_term' = 'Store Format Description');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Store Format Name');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Store Format Status');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pilot|discontinued');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `fresh_produce_included` SET TAGS ('dbx_business_glossary_term' = 'Fresh Produce Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `fuel_center_included` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `gondola_count_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Gondola Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `headcount_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Headcount');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `home_delivery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Home Delivery Enabled Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `meat_seafood_included` SET TAGS ('dbx_business_glossary_term' = 'Meat and Seafood Department Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `mfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'MFC (Micro-Fulfillment Center) Enabled Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `online_pickup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Pickup Enabled Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `operating_hours_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Operating Hours');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `parking_spaces_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parking Spaces');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `parking_spaces_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Parking Spaces');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `pharmacy_included` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Included Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `planogram_template_family` SET TAGS ('dbx_business_glossary_term' = 'Planogram Template Family');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `self_checkout_enabled` SET TAGS ('dbx_business_glossary_term' = 'Self-Checkout Enabled Flag');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `selling_area_percentage` SET TAGS ('dbx_business_glossary_term' = 'Selling Area Percentage');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `sku_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum SKU (Stock Keeping Unit) Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `sku_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum SKU (Stock Keeping Unit) Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `sku_count_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical SKU (Stock Keeping Unit) Count');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `square_footage_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `square_footage_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `square_footage_typical` SET TAGS ('dbx_business_glossary_term' = 'Typical Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`format` ALTER COLUMN `staffing_model_template` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Template');
ALTER TABLE `grocery_ecm`.`store`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`region` SET TAGS ('dbx_subdomain' = 'organizational_hierarchy');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Center (DC) Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `annual_ebitda_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Target (USD)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `annual_ebitda_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target (USD)');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `comp_sales_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales (Comp Sales) Reporting Flag');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `district_count` SET TAGS ('dbx_business_glossary_term' = 'District Count');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `geographic_boundary_definition` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Definition');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Region Notes');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `primary_state_code` SET TAGS ('dbx_business_glossary_term' = 'Primary State Code');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `primary_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `promotional_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Calendar Code');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `promotional_calendar_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_status` SET TAGS ('dbx_business_glossary_term' = 'Region Status');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|consolidating');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Region Type');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `region_type` SET TAGS ('dbx_value_regex' = 'geographic|operational|strategic|test');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Regional Office Address Line 1');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Regional Office Address Line 2');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_city` SET TAGS ('dbx_business_glossary_term' = 'Regional Office City');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_phone` SET TAGS ('dbx_business_glossary_term' = 'Regional Office Phone Number');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Office Postal Code');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_state_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Office State Code');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `regional_office_state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`region` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `grocery_ecm`.`store`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`district` SET TAGS ('dbx_subdomain' = 'organizational_hierarchy');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Center (DC) Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier (ID)');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'District Office Address Line 1');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'District Office Address Line 2');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `annual_sales_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Target');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `annual_sales_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'District Office City');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_name` SET TAGS ('dbx_business_glossary_term' = 'District Name');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_status` SET TAGS ('dbx_business_glossary_term' = 'District Status');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `district_status` SET TAGS ('dbx_value_regex' = 'active|inactive|consolidating|restructuring');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'District Office Email Address');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'District Established Date');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `geographic_coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Description');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `labor_budget_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Hours');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `labor_budget_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'District Notes');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier Classification');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|developing');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'District Office Phone Number');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `shrink_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shrink (Inventory Loss) Target Percentage');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `shrink_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `state_province_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `state_province_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `grocery_ecm`.`store`.`district` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`department` SET TAGS ('dbx_subdomain' = 'organizational_hierarchy');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Vendor ID');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `backroom_capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Backroom Capacity Cubic Feet');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `backroom_cooler_flag` SET TAGS ('dbx_business_glossary_term' = 'Backroom Cooler Flag');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `backroom_freezer_flag` SET TAGS ('dbx_business_glossary_term' = 'Backroom Freezer Flag');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `backroom_storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Backroom Storage Zone');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `cooler_door_count` SET TAGS ('dbx_business_glossary_term' = 'Cooler Door Count');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_number` SET TAGS ('dbx_business_glossary_term' = 'Department Number');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Department Status');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|remodel');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_value_regex' = 'perishable|center_store|service|pharmacy|fuel');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `endcap_count` SET TAGS ('dbx_business_glossary_term' = 'Endcap Count');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `fifo_lane_count` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Lane Count');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `gondola_count` SET TAGS ('dbx_business_glossary_term' = 'Gondola Count');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Classification');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `haccp_classification` SET TAGS ('dbx_value_regex' = 'critical|non_critical|not_applicable');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `labor_standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Labor Standard Hours Per Week');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `planogram_family` SET TAGS ('dbx_business_glossary_term' = 'Planogram Family');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `pos_department_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Department Code');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `private_label_focus_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Focus Flag');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'cao|manual|dsd|cross_dock');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `shrink_budget_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Shrink Budget Target Percent');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Department Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`store`.`department` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `operating_hours_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours ID');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `bakery_close_time` SET TAGS ('dbx_business_glossary_term' = 'Bakery Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `bakery_open_time` SET TAGS ('dbx_business_glossary_term' = 'Bakery Open Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `customer_service_close_time` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `customer_service_open_time` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Open Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `deli_close_time` SET TAGS ('dbx_business_glossary_term' = 'Deli Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `deli_open_time` SET TAGS ('dbx_business_glossary_term' = 'Deli Open Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `delivery_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cutoff Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `fuel_center_close_time` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `fuel_center_open_time` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Open Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `is_24_hour_store` SET TAGS ('dbx_business_glossary_term' = 'Is 24 Hour Store');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Notes');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `online_ordering_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering Enabled');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `operating_hours_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Status');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `operating_hours_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_close_time` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_lunch_break_end` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Lunch Break End');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_lunch_break_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_lunch_break_start` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Lunch Break Start');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_lunch_break_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pharmacy_open_time` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Open Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pickup_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `pickup_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `published_to_website` SET TAGS ('dbx_business_glossary_term' = 'Published to Website');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|holiday|special_event|temporary|seasonal|emergency');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `senior_hours_end_time` SET TAGS ('dbx_business_glossary_term' = 'Senior Hours End Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `senior_hours_start_time` SET TAGS ('dbx_business_glossary_term' = 'Senior Hours Start Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `special_event_name` SET TAGS ('dbx_business_glossary_term' = 'Special Event Name');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `store_close_time` SET TAGS ('dbx_business_glossary_term' = 'Store Close Time');
ALTER TABLE `grocery_ecm`.`store`.`operating_hours` ALTER COLUMN `store_open_time` SET TAGS ('dbx_business_glossary_term' = 'Store Open Time');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `service_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Service Capability ID');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|decommissioned|seasonal');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `average_fulfillment_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Fulfillment Time in Minutes');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_category` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Category');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_category` SET TAGS ('dbx_value_regex' = 'omnichannel|pharmacy|financial_services|food_service|specialty_services|payment_acceptance');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_code` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Code');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_description` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Description');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capability_name` SET TAGS ('dbx_business_glossary_term' = 'Service Capability Name');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Limit');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'orders|customers|transactions|lanes|stations|units');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `compliance_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer-Facing Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `daily_capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Limit');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Description');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `equipment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `omnichannel_routing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Routing Enabled Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `oms_capability_code` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Capability Code');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `operating_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Description');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `operating_hours_same_as_store_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Same as Store Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `seasonal_end_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Month');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `seasonal_start_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Month');
ALTER TABLE `grocery_ecm`.`store`.`service_capability` ALTER COLUMN `staffing_requirement_fte` SET TAGS ('dbx_business_glossary_term' = 'Staffing Requirement Full-Time Equivalent (FTE)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Micro-Fulfillment Center (MFC) Profile ID');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Robotics Vendor Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `ambient_zone_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ambient Zone Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `average_inventory_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Inventory Accuracy Percent');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `average_order_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Order Accuracy Percent');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `average_order_fulfillment_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Order Fulfillment Time (Minutes)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `average_pick_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Pick Time (Seconds)');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `chilled_zone_enabled` SET TAGS ('dbx_business_glossary_term' = 'Chilled Zone Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `cold_chain_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Monitoring Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `daily_order_capacity` SET TAGS ('dbx_business_glossary_term' = 'Daily Order Capacity');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `food_safety_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection Score');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `frozen_zone_enabled` SET TAGS ('dbx_business_glossary_term' = 'Frozen Zone Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `fulfillment_service_types` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Service Types');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `haccp_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `last_food_safety_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Food Safety Inspection Date');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_code` SET TAGS ('dbx_business_glossary_term' = 'Micro-Fulfillment Center (MFC) Code');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_code` SET TAGS ('dbx_value_regex' = '^MFC[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_name` SET TAGS ('dbx_business_glossary_term' = 'Micro-Fulfillment Center (MFC) Name');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_type` SET TAGS ('dbx_business_glossary_term' = 'Micro-Fulfillment Center (MFC) Type');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `mfc_type` SET TAGS ('dbx_value_regex' = 'automated|semi-automated|manual');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `number_of_packing_stations` SET TAGS ('dbx_business_glossary_term' = 'Number of Packing Stations');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `number_of_picking_stations` SET TAGS ('dbx_business_glossary_term' = 'Number of Picking Stations');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `number_of_robots` SET TAGS ('dbx_business_glossary_term' = 'Number of Robots');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `oms_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Integration Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|maintenance');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `peak_hourly_order_capacity` SET TAGS ('dbx_business_glossary_term' = 'Peak Hourly Order Capacity');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `picking_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Picking Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `robotics_vendor` SET TAGS ('dbx_business_glossary_term' = 'Robotics Vendor');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `sku_count` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Count');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `total_tote_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Tote Capacity');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `twenty_four_hour_operation` SET TAGS ('dbx_business_glossary_term' = 'Twenty-Four Hour Operation');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `wms_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance ID');
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ALTER COLUMN `wms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Name');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `closure_end_date` SET TAGS ('dbx_business_glossary_term' = 'Closure End Date');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `closure_ordered` SET TAGS ('dbx_business_glossary_term' = 'Closure Ordered Flag');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `closure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Start Date');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `critical_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Count');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `cross_contamination_compliance` SET TAGS ('dbx_business_glossary_term' = 'Cross-Contamination Prevention Compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `cross_contamination_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-checked');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `departments_inspected` SET TAGS ('dbx_business_glossary_term' = 'Departments Inspected');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `facility_maintenance_compliance` SET TAGS ('dbx_business_glossary_term' = 'Facility Maintenance Compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `facility_maintenance_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-checked');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `food_temperature_compliance` SET TAGS ('dbx_business_glossary_term' = 'Food Temperature Compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `food_temperature_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-checked');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `haccp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Compliance Status');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `haccp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-applicable|partial');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `handwashing_compliance` SET TAGS ('dbx_business_glossary_term' = 'Handwashing and Personal Hygiene Compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `handwashing_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-checked');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspecting_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Agency');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration in Minutes');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow-up|complaint-driven|pre-opening|special|reinspection');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `letter_grade` SET TAGS ('dbx_business_glossary_term' = 'Letter Grade');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `letter_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `non_critical_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Violation Count');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Score');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `pest_control_compliance` SET TAGS ('dbx_business_glossary_term' = 'Pest Control Compliance');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `pest_control_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|not-checked');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `posted_at_store` SET TAGS ('dbx_business_glossary_term' = 'Posted at Store Flag');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `score_scale` SET TAGS ('dbx_business_glossary_term' = 'Score Scale');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `total_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Total Violation Count');
ALTER TABLE `grocery_ecm`.`store`.`health_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`lease` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `base_rent_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `base_rent_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `base_rent_amount_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `base_rent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Payment Frequency');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `base_rent_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `cam_charges_usd` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Charges (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `cam_charges_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `cam_charges_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `co_tenancy_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Tenancy Clause Flag');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Lease Document URL');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `early_termination_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Allowed Flag');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `early_termination_penalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `early_termination_penalty_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `early_termination_penalty_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `exclusivity_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Provision Flag');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Execution Date');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_business_glossary_term' = 'Lease Guarantor Name');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `insurance_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `insurance_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `insurance_amount_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Landlord Contact Name');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_email` SET TAGS ('dbx_business_glossary_term' = 'Landlord Contact Email Address');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_name` SET TAGS ('dbx_business_glossary_term' = 'Landlord Entity Name');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_phone` SET TAGS ('dbx_business_glossary_term' = 'Landlord Contact Phone Number');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `landlord_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|renewed|holdover');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'operating|capital|ground|sublease|license');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `leased_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Leased Square Footage');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lease Notes');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 1');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 2');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_city` SET TAGS ('dbx_business_glossary_term' = 'Property City');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_country_code` SET TAGS ('dbx_business_glossary_term' = 'Property Country Code');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Property Postal Code');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_state_code` SET TAGS ('dbx_business_glossary_term' = 'Property State Code');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_tax_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Amount (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_tax_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `property_tax_amount_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `renewal_option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Term (Months)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `rent_escalation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate Percentage');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed|cpi|percentage|none');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `security_deposit_usd` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit (USD)');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `security_deposit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `security_deposit_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `sox_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Disclosure Required Flag');
ALTER TABLE `grocery_ecm`.`store`.`lease` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`store`.`banner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`banner` SET TAGS ('dbx_subdomain' = 'organizational_hierarchy');
ALTER TABLE `grocery_ecm`.`store`.`banner` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Identifier');
ALTER TABLE `grocery_ecm`.`store`.`banner` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`banner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`banner` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Config Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`store`.`division` SET TAGS ('dbx_subdomain' = 'organizational_hierarchy');
ALTER TABLE `grocery_ecm`.`store`.`division` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Identifier');
ALTER TABLE `grocery_ecm`.`store`.`division` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`store`.`division` ALTER COLUMN `parent_division_id` SET TAGS ('dbx_self_ref_fk' = 'true');
