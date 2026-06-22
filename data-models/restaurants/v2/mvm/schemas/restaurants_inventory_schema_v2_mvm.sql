-- Schema for Domain: inventory | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-06-22 16:55:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Unique identifier for the stock item. Primary key for the stock_item product.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each high-risk stock item (raw proteins, dairy, shellfish) is governed by a specific HACCP plan defining its CCPs, temperature limits, and handling procedures. This link enables automatic HACCP plan l',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: REQUIRED: Ingredient Inventory Valuation Report needs each stock item linked to its ingredient master for nutrition, allergen, and compliance tracking.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Station-level par management and KDS routing configuration: each stock item has a primary prep/consumption station (e.g., beef patties → grill station). Operations managers use this to configure stati',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates whether the item contains or may contain eggs. Required for menu labeling and allergen disclosure.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain fish. Required for menu labeling and allergen disclosure.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates whether the item contains or may contain milk or dairy derivatives. Required for menu labeling and allergen disclosure.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain peanuts. Required for menu labeling and allergen disclosure.',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain crustacean shellfish. Required for menu labeling and allergen disclosure.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates whether the item contains or may contain soybeans. Required for menu labeling and allergen disclosure.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain tree nuts. Required for menu labeling and allergen disclosure.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates whether the item contains or may contain wheat. Required for menu labeling and allergen disclosure.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one case. Used for ordering and receiving conversions.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the standard cost (e.g., USD, CAD, EUR).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the stock item record was first created in the inventory management system.',
    `discontinuation_date` DATE COMMENT 'Date when the item was or will be discontinued from inventory. Used for phase-out planning and historical analysis.',
    `gtin` STRING COMMENT 'International product identifier used for supply chain tracking and barcode scanning. May be UPC, EAN, or other GS1 format.. Valid values are `^[0-9]{8,14}$`',
    `haccp_max_temp_f` DECIMAL(18,2) COMMENT 'Maximum safe storage temperature in Fahrenheit to maintain product quality and food safety standards.',
    `haccp_min_temp_f` DECIMAL(18,2) COMMENT 'Minimum safe storage temperature in Fahrenheit required to prevent bacterial growth and ensure food safety compliance.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the stock item is currently available for ordering and use. Inactive items are retained for historical reporting but not available for new transactions.',
    `is_gluten_free` BOOLEAN COMMENT 'Indicates whether the item is certified gluten-free or naturally contains no gluten. Critical for dietary accommodation and menu labeling.',
    `is_gmo_free` BOOLEAN COMMENT 'Indicates whether the item is certified non-GMO. Used for menu transparency and consumer preference alignment.',
    `is_halal` BOOLEAN COMMENT 'Indicates whether the item meets Islamic dietary law requirements. Used for menu segmentation and cultural accommodation.',
    `is_kosher` BOOLEAN COMMENT 'Indicates whether the item meets Jewish dietary law requirements. Used for menu segmentation and cultural accommodation.',
    `is_organic` BOOLEAN COMMENT 'Indicates whether the item is certified organic according to USDA standards. Used for menu marketing and premium pricing.',
    `is_vegan` BOOLEAN COMMENT 'Indicates whether the item contains no animal products or by-products. Used for menu filtering and dietary preference alignment.',
    `is_vegetarian` BOOLEAN COMMENT 'Indicates whether the item contains no meat, poultry, or seafood. Used for menu filtering and dietary preference alignment.',
    `item_category` STRING COMMENT 'Primary classification of the stock item by food service category. Used for inventory organization, COGS analysis, and procurement planning. [ENUM-REF-CANDIDATE: protein|produce|dairy|dry_goods|beverage|paper_goods|cleaning|packaging — 8 candidates stripped; promote to reference product]',
    `item_description` STRING COMMENT 'Detailed description of the stock item including brand, size, packaging, and other distinguishing characteristics.',
    `item_name` STRING COMMENT 'Human-readable name of the stock item as it appears in inventory management and ordering systems.',
    `item_subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the item category (e.g., beef, chicken, lettuce, tomato).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the stock item record was last updated. Used for change tracking and audit trails.',
    `par_level` DECIMAL(18,2) COMMENT 'Target inventory quantity that should be maintained at all times to support operational needs without overstocking. Used for automated reorder triggers.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory threshold quantity that triggers a replenishment order. Set below PAR level to account for lead time.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to order when inventory falls below reorder point. Calculated to restore inventory to PAR level.',
    `shelf_life_days` STRING COMMENT 'Number of days the item remains usable after receipt. Critical for waste management, FIFO rotation, and food safety compliance.',
    `sku_code` STRING COMMENT 'Unique alphanumeric code identifying the stock item across all restaurant units and inventory systems. This is the business identifier used in MarketMan and POS systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Expected unit cost of the item used for COGS calculations and variance analysis. Updated periodically based on procurement contracts.',
    `storage_class` STRING COMMENT 'Required storage temperature zone for the item. Determines BOH storage location and HACCP compliance requirements.. Valid values are `ambient|refrigerated|frozen`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the stock item is tracked, ordered, and received. Critical for accurate inventory counts and cost calculations. [ENUM-REF-CANDIDATE: each|case|pound|kilogram|ounce|liter|gallon|box|bag|dozen — 10 candidates stripped; promote to reference product]',
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order matching and invoice reconciliation.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of usable product after preparation and trimming. Critical for recipe costing and waste tracking.',
    CONSTRAINT pk_stock_item PRIMARY KEY(`stock_item_id`)
) COMMENT 'Master record for every SKU tracked in restaurant inventory — food, beverage, packaging, and non-food supplies. Captures SKU code, item name, unit of measure (UOM), item category (protein, produce, dry goods, beverage, paper goods, cleaning), storage class (ambient, refrigerated, frozen), reorder point, reorder quantity, standard cost, vendor item code, shelf life days, HACCP temperature range, allergen flags, daypart applicability, seasonal adjustment flags, and active status. Also owns PAR-level configuration per unit-location: PAR quantity, minimum quantity (reorder point), maximum quantity (shelf capacity), day-of-week overrides, seasonal adjustment flags, and effective date range. This is the SSOT for all stockable items and their replenishment parameters managed through MarketMan.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the stock location. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for HACCP temperature monitoring accountability; each storage location has an assigned manager employee who signs compliance reports.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this stock location is physically situated.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier for the refrigeration or climate control equipment serving this location, used for maintenance tracking and temperature monitoring integration.',
    `access_control_required` BOOLEAN COMMENT 'Indicates whether electronic or physical access control (keycard, PIN, lock) is required to enter this location.',
    `activation_date` DATE COMMENT 'Date when the stock location was first activated and made available for inventory storage.',
    `allows_receiving` BOOLEAN COMMENT 'Indicates whether this location is designated as a receiving point for incoming inventory deliveries.',
    `allows_transfers` BOOLEAN COMMENT 'Indicates whether inventory can be transferred into or out of this location to other stock locations within the restaurant or across units.',
    `allows_waste_tracking` BOOLEAN COMMENT 'Indicates whether waste events (spoilage, damage, expiration) can be recorded against inventory in this location for Waste% calculation.',
    `bin_count` STRING COMMENT 'Number of individual storage bins or compartments within this location for granular SKU organization.',
    `building_section` STRING COMMENT 'Specific section or wing of the building where the location is situated (e.g., Kitchen, Bar, Prep Area, Receiving Dock).',
    `capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in cubic feet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock location record was first created in the system.',
    `cycle_count_frequency_days` STRING COMMENT 'Number of days between scheduled physical inventory cycle counts for this location to maintain stock accuracy.',
    `deactivation_date` DATE COMMENT 'Date when the stock location was deactivated or decommissioned and is no longer available for inventory storage.',
    `floor_level` STRING COMMENT 'Physical floor level where the storage location is situated (e.g., 1 for ground floor, -1 for basement, 2 for second floor).',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent physical inventory cycle count was completed for this location.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance or inspection was performed on the storage location or its equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock location record was most recently updated.',
    `location_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the storage location within the restaurant unit (e.g., WIC01 for walk-in cooler 1, DRY02 for dry storage room 2).. Valid values are `^[A-Z0-9]{2,10}$`',
    `location_name` STRING COMMENT 'Human-readable name of the stock location (e.g., Walk-In Cooler, Dry Storage Room, Bar Storage, Prep Area Shelf).',
    `location_type` STRING COMMENT 'Classification of the storage location based on its primary function and environmental control (refrigerated, frozen, ambient, bar, prep_area, service_station).. Valid values are `refrigerated|frozen|ambient|bar|prep_area|service_station`',
    `next_scheduled_cycle_count_date` DATE COMMENT 'Date when the next physical inventory cycle count is scheduled for this location.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance or inspection is planned for the storage location or its equipment.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or operational notes about the stock location.',
    `par_level_enabled` BOOLEAN COMMENT 'Indicates whether PAR level inventory management is enabled for this location to trigger automatic replenishment orders.',
    `primary_commodity_category` STRING COMMENT 'Primary category of inventory items typically stored in this location (e.g., Proteins, Dairy, Produce, Dry Goods, Beverages, Alcohol).',
    `requires_haccp_monitoring` BOOLEAN COMMENT 'Indicates whether this location requires HACCP monitoring and documentation for food safety compliance.',
    `security_level` STRING COMMENT 'Security classification for the location indicating access control requirements (open: unrestricted, restricted: authorized staff only, locked: key/code required, high_value: premium items with enhanced security).. Valid values are `open|restricted|locked|high_value`',
    `shelf_count` STRING COMMENT 'Number of shelves or storage levels available in this location for organizing inventory.',
    `stock_location_status` STRING COMMENT 'Current operational status of the stock location (active: in use, inactive: temporarily not in use, maintenance: under repair, decommissioned: permanently retired).. Valid values are `active|inactive|maintenance|decommissioned`',
    `storage_area_type` STRING COMMENT 'Indicates whether the location is in Back of House (BOH) or Front of House (FOH) area of the restaurant.. Valid values are `boh|foh`',
    `target_temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum target temperature in Fahrenheit for this storage location to maintain food safety and quality standards.',
    `target_temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum target temperature in Fahrenheit for this storage location to maintain food safety and quality standards.',
    `temperature_monitoring_frequency_hours` STRING COMMENT 'Required frequency in hours for temperature checks and logging at this location to ensure food safety compliance.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the location (freezer: below 0°F, cooler: 32-40°F, ambient: room temperature, controlled: climate-controlled but not refrigerated).. Valid values are `freezer|cooler|ambient|controlled`',
    CONSTRAINT pk_stock_location PRIMARY KEY(`stock_location_id`)
) COMMENT 'Master record for every physical storage location within a restaurant unit where inventory is held — walk-in cooler, walk-in freezer, dry storage room, BOH prep area, FOH service station, bar storage. Captures location code, location name, location type (refrigerated, frozen, ambient, bar), temperature zone, capacity (cubic feet or shelf count), restaurant unit reference, and active status. Enables granular stock-on-hand tracking by storage zone.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` (
    `on_hand_balance_id` DECIMAL(18,2) COMMENT 'Unique identifier for the on-hand balance record. Primary key for the inventory position snapshot.',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking to inventory.physical_count. Business justification: on_hand_balance tracks the last physical count date as a string date field (last_physical_count_date). Replacing this with a FK to physical_count allows the system to JOIN directly to the full count e',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this inventory is held. Links to the restaurant operations master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this balance is recorded. Links to the inventory item master.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the restaurant (walk-in cooler, dry storage, freezer, prep area). Links to storage location master.',
    `abc_classification` STRING COMMENT 'The ABC inventory classification based on value and usage velocity. A items are high-value/high-velocity requiring tight control, C items are low-value/low-velocity.. Valid values are `A|B|C`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which unit_cost and extended_value are denominated.. Valid values are `USD|CAD|EUR|GBP|MXN|AUD`',
    `cycle_count_frequency` STRING COMMENT 'The frequency at which this SKU should be physically counted as part of the cycle count program. Typically aligned with ABC classification.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `days_until_expiration` DECIMAL(18,2) COMMENT 'The number of days remaining until the expiration date. Used to prioritize usage and identify items at risk of waste.',
    `expiration_date` DATE COMMENT 'The date by which this inventory must be used or discarded. Critical for food safety, waste management, and FIFO (First In First Out) rotation.',
    `extended_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand inventory, calculated as quantity_on_hand multiplied by unit_cost. Used for financial reporting and COGS% analysis.',
    `inventory_status` STRING COMMENT 'The current lifecycle status of this inventory position. Determines whether the inventory is available for use, held for quality review, or flagged for disposal.. Valid values are `available|reserved|quarantined|expired|damaged|in_transit`',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether this SKU is a perishable item requiring temperature control and expiration tracking. True for fresh produce, dairy, meat; false for dry goods.',
    `last_adjustment_date` DATE COMMENT 'The date when the last inventory adjustment (waste, transfer, or correction) was recorded for this SKU at this location.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'The date and time of the last inventory transaction (receipt, transfer, issue, or adjustment) that affected this balance. Used to identify stagnant inventory.',
    `last_received_date` DATE COMMENT 'The date when this SKU was last received into inventory at this location. Used to track inventory freshness and identify slow-moving items.',
    `lot_number` STRING COMMENT 'The supplier or manufacturer lot number for traceability and recall management. Critical for food safety compliance under HACCP (Hazard Analysis Critical Control Points).',
    `par_level` DECIMAL(18,2) COMMENT 'The target inventory level for this SKU at this location, used for automatic replenishment decisions. Represents the optimal stock level to maintain service without excess waste.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The net quantity available for use or sale, calculated as quantity_on_hand minus quantity_reserved. Represents the true available-to-promise inventory.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The total physical quantity of the SKU currently in stock at this location. Represents the gross inventory position before reservations.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'The quantity of the SKU that is committed to prep, production, or pending orders and not available for new allocation. Used in BOH (Back of House) prep planning.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance record was first created in the data platform. Audit trail for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance record was last updated in the data platform. Audit trail for change tracking.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered. When quantity_available falls below this threshold, the system generates a purchase order.',
    `safety_stock` DECIMAL(18,2) COMMENT 'The minimum buffer stock maintained to protect against stockouts due to demand variability or supply delays. Part of the PAR level calculation.',
    `sku_code` STRING COMMENT 'The business identifier code for the SKU. Denormalized from SKU master for reporting convenience.',
    `sku_description` STRING COMMENT 'Human-readable description of the SKU. Denormalized from SKU master for reporting convenience.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The date and time when this on-hand balance snapshot was captured. Represents the point-in-time inventory position for reporting and reconciliation.',
    `temperature_zone` STRING COMMENT 'The required storage temperature zone for this SKU (ambient/dry, refrigerated, or frozen). Critical for food safety compliance and storage location assignment.. Valid values are `ambient|refrigerated|frozen`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this SKU at this location. Used to calculate extended inventory value and COGS (Cost of Goods Sold).',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the quantity is expressed (each, pound, kilogram, ounce, gallon, liter, case, box, pack, dozen). [ENUM-REF-CANDIDATE: EA|LB|KG|OZ|GAL|L|CS|BX|PK|DZ — 10 candidates stripped; promote to reference product]',
    `valuation_method` STRING COMMENT 'The accounting method used to value this inventory (FIFO - First In First Out, LIFO - Last In First Out, weighted average, or standard cost). Determines COGS calculation.. Valid values are `FIFO|LIFO|weighted_average|standard_cost`',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The difference between quantity_on_hand and par_level. Positive values indicate overstocking, negative values indicate understocking and trigger replenishment.',
    CONSTRAINT pk_on_hand_balance PRIMARY KEY(`on_hand_balance_id`)
) COMMENT 'Current stock-on-hand snapshot for each SKU at each storage location within a restaurant unit. Captures quantity on hand, quantity reserved (committed to prep), quantity available, last physical count date, last adjustment date, last received date, unit cost, extended value, and variance from PAR level. Updated by receiving, transfers, waste events, and physical counts. The authoritative real-time inventory position record used for replenishment decisions and food cost reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` (
    `physical_count_id` BIGINT COMMENT 'Unique identifier for the physical inventory count event. Primary key.',
    `parent_count_physical_count_id` BIGINT COMMENT 'Reference to the original physical count ID if this count is a recount or correction of a previous count event.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initiated or started the physical count event.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the physical count was performed.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Physical inventory counts are conducted during a specific shift in restaurant operations. This FK enables labor cost attribution for counting activities, audit traceability by shift, and scheduling an',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: A physical count event can be scoped to a specific storage location within a restaurant unit (e.g., a walk-in cooler count vs. a dry-storage count). Adding stock_location_id as a nullable FK allows lo',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the physical count was completed and submitted.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the physical count was started by the counting team.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was approved by the manager or supervisor.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the physical count was cancelled or voided.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was cancelled or voided, if applicable.',
    `count_date` DATE COMMENT 'The calendar date on which the physical inventory count was conducted.',
    `count_method` STRING COMMENT 'The method used to perform the physical count: manual (paper-based or manual entry), barcode-scan (handheld scanner), rfid (radio-frequency identification), or hybrid (combination of methods).. Valid values are `manual|barcode-scan|rfid|hybrid`',
    `count_number` STRING COMMENT 'Business identifier for the physical count event, formatted as PC-YYYYMMDD-NNNN for external reference and audit trail.. Valid values are `^PC-[0-9]{8}-[0-9]{4}$`',
    `count_period` STRING COMMENT 'The daypart or shift during which the count was performed, aligned with restaurant operating periods.. Valid values are `breakfast|lunch|dinner|late-night|overnight|full-day`',
    `count_status` STRING COMMENT 'Current lifecycle status of the count event: scheduled (planned but not started), in-progress (counting underway), submitted (completed awaiting approval), approved (validated by manager), posted (applied to inventory system), or cancelled (voided).. Valid values are `scheduled|in-progress|submitted|approved|posted|cancelled`',
    `count_type` STRING COMMENT 'Classification of the count event: full (complete inventory), spot-check (random sample), cycle-count (scheduled rotation), pre-close (before period end), post-close (after period end), or opening (new restaurant opening).. Valid values are `full|spot-check|cycle-count|pre-close|post-close|opening`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was first created in the system.',
    `is_period_end_count` BOOLEAN COMMENT 'Boolean flag indicating whether this count is a mandatory period-end count for financial close and COGS% (Cost of Goods Sold Percentage) calculation. True if period-end count, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the count event, including explanations for significant variances, operational issues during count, or special circumstances.',
    `physical_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory based on the physical count results, calculated by multiplying counted quantities by unit costs.',
    `posted_to_gl_timestamp` TIMESTAMP COMMENT 'The date and time when the count variance was posted to the General Ledger (GL) for financial reporting, typically after approval.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the physical count was scheduled to begin.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was submitted for approval after completion.',
    `system_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory according to the system (MarketMan) at the time of count, used as the baseline for variance calculation.',
    `total_sku_counted` DECIMAL(18,2) COMMENT 'The total number of unique SKUs (Stock Keeping Units) that were physically counted during this count event.',
    `total_sku_with_variance` DECIMAL(18,2) COMMENT 'The number of SKUs that showed a variance (difference) between system inventory and physical count.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The total dollar value variance between system inventory and physical count results, calculated as (physical count value - system inventory value). Positive indicates overage, negative indicates shortage.',
    `total_variance_percentage` DECIMAL(18,2) COMMENT 'The total variance expressed as a percentage of system inventory value, calculated as (variance amount / system inventory value) * 100. Key metric for COGS% (Cost of Goods Sold Percentage) analysis and food cost control.',
    `variance_reason_code` STRING COMMENT 'Primary reason code for inventory variance: theft (shrinkage), spoilage (expired/damaged), waste (prep waste), receiving-error (incorrect receipt), transfer-error (incorrect transfer), system-error (data entry mistake), or unknown. [ENUM-REF-CANDIDATE: theft|spoilage|waste|receiving-error|transfer-error|system-error|unknown — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_physical_count PRIMARY KEY(`physical_count_id`)
) COMMENT 'Records scheduled or ad-hoc physical inventory count events at a restaurant unit, capturing both count-level header metadata and line-level SKU counts in a single consolidated entity. Header attributes: count date, count type (full/spot-check/cycle-count/pre-close/post-close), count status, count period, initiated-by/approved-by employees, total variance value and percentage. Line attributes (one per SKU-location counted): stock item reference, storage location, system quantity (book inventory), counted quantity, variance quantity and value ($), unit of measure, unit cost, count method (manual/scan), counted-by employee reference, and recount flag. Variance lines trigger investigation workflows and feed period-end food cost reconciliation and COGS% reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` (
    `waste_log_id` BIGINT COMMENT 'Unique identifier for the waste log entry. Primary key.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Equipment failure-driven waste tracking: spoilage events caused by refrigeration or cooking equipment failures must be linked to the specific asset for HACCP documentation, insurance claims, and maint',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Waste events flagged as HACCP violations (waste_log.haccp_violation = true) must reference the governing HACCP plan to document which plan was breached and trigger the plans corrective action procedu',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Food safety and recall impact: waste events must reference the specific ingredient lot discarded to support lot-level waste analysis, recall disposition reporting, and HACCP corrective action document',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Station-level waste cost reporting and HACCP accountability: waste events are attributed to the kitchen station where they occurred. `responsible_station` is a denormalized plain string; replacing it ',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Restaurant waste tracking requires linking waste events to the specific order line item that generated them (voided after prep, customer rejection). Enables food cost variance reports, COGS reconcilia',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the waste event in the system.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the waste event occurred.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or Bill of Materials (BOM) associated with the wasted prepared item, if applicable.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to order.refund. Business justification: Customer complaints resulting in refunds often generate waste log entries (food disposed after return). Direct FK enables food safety and financial reports correlating refund events with waste costs, ',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the waste event occurred, used for labor and operational analysis.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) that was wasted.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Waste is recorded per storage location; replacing the denormalized storage_location field with a FK enables location‑level waste analytics.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the waste log entry was approved by a manager.',
    `batch_number` STRING COMMENT 'The production or receiving batch identifier for the wasted item, used for traceability and food safety compliance.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action implemented to prevent recurrence of this type of waste.',
    `daypart` STRING COMMENT 'The operational time segment during which the waste event occurred (breakfast, lunch, dinner, late-night).. Valid values are `breakfast|lunch|dinner|late-night`',
    `disposal_method` STRING COMMENT 'The method used to dispose of the wasted item: trash (landfill), compost, donation (food rescue), rendering (animal feed/byproduct), or other.. Valid values are `trash|compost|donation|rendering|other`',
    `expiration_date` DATE COMMENT 'The use-by or best-before date of the wasted item, critical for expiration-related waste tracking.',
    `haccp_violation` BOOLEAN COMMENT 'Indicates whether the waste event was associated with a HACCP critical control point violation.',
    `manager_approved` BOOLEAN COMMENT 'Indicates whether a manager has reviewed and approved this waste log entry.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the waste event for operational context.',
    `on_hand_quantity_before_waste` DECIMAL(18,2) COMMENT 'The inventory quantity on hand immediately before the waste event was recorded.',
    `par_level_at_waste` DECIMAL(18,2) COMMENT 'The PAR level setting for this item at the time of waste, used to analyze whether overstocking contributed to waste.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this waste log record was first created in the database.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The system timestamp when this waste log record was last modified.',
    `temperature_at_waste` DECIMAL(18,2) COMMENT 'The temperature in Fahrenheit of the item or storage area at the time of waste, relevant for food safety and spoilage analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the waste quantity is measured (e.g., kilograms, pounds, each, gallons). [ENUM-REF-CANDIDATE: kg|lb|oz|g|ea|case|box|gal|ltr|ml — 10 candidates stripped; promote to reference product]',
    `waste_category` STRING COMMENT 'The classification of the waste event: spoilage (deterioration), overproduction (excess prepared food), prep-loss (trimming/cooking loss), expiration (past use-by date), quality-reject (failed quality standards), theft-unknown (unexplained loss).. Valid values are `spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown`',
    `waste_cost` DECIMAL(18,2) COMMENT 'The monetary cost of the wasted item in the restaurants operating currency, calculated as quantity times unit cost.',
    `waste_date` DATE COMMENT 'The calendar date on which the waste event occurred.',
    `waste_prevention_opportunity` STRING COMMENT 'Notes on potential process improvements or training opportunities identified from this waste event.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of the item wasted, measured in the unit of measure specified.',
    `waste_reason` STRING COMMENT 'Free-text description providing additional context and specific reason for the waste event.',
    `waste_timestamp` TIMESTAMP COMMENT 'The precise date and time when the waste event was recorded.',
    CONSTRAINT pk_waste_log PRIMARY KEY(`waste_log_id`)
) COMMENT 'Records every food waste event at a restaurant unit — spoilage, overproduction, prep waste, expiration, and quality rejection. Captures waste date, waste time, stock item reference, waste quantity, unit of measure, waste cost ($), waste category (spoilage, overproduction, prep loss, expiration, quality-reject, theft/unknown), waste reason description, responsible station (BOH/FOH), recorded-by employee reference, and manager approval flag. Drives Waste% KPI calculation and supports yield management and COGS% optimization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Unique identifier for the stock transfer transaction. Primary key for the stock transfer record.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center receiving the transferred inventory. For intra-unit transfers, this is the same as origin unit.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the destination unit where items will be received. Critical for BOH (Back of House) inventory accuracy.',
    `origin_restaurant_unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center from which inventory is being transferred. For intra-unit transfers, this is the same as destination unit.',
    `origin_stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the origin unit from which items are being transferred. Critical for BOH (Back of House) inventory accuracy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically kitchen manager or shift supervisor) who initiated the stock transfer request. Used for accountability and audit trail.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: Inter-unit stock transfers are frequently initiated to fulfill replenishment needs when a supplier order cannot be fulfilled in time. Linking stock_transfer to the replenishment_order that triggered i',
    `tertiary_stock_received_by_employee_id` BIGINT COMMENT 'Reference to the employee at the destination unit who physically received and confirmed the transferred inventory. Null until transfer is received.',
    `cancellation_date` DATE COMMENT 'Date when the stock transfer was cancelled. Null if transfer was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the transfer was cancelled. Used for operational analysis and process improvement.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or delivery service used for inter-unit transfers. Null for intra-unit transfers or self-pickup.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock transfer record was first created in the system. Used for audit trail and data lineage tracking.',
    `expected_delivery_date` DATE COMMENT 'Planned or estimated date when the transferred inventory is expected to arrive at the destination. Used for receiving planning and PAR (Periodic Automatic Replenishment) level management.',
    `external_transfer_reference` STRING COMMENT 'Unique identifier from the source operational system (MarketMan, SAP MM). Used for data lineage, reconciliation, and cross-system traceability.',
    `fiscal_period` STRING COMMENT 'Fiscal period (year and period number) to which this transfer is assigned for financial reporting. Format: YYYY-PNN (e.g., 2024-P03 for period 3 of fiscal year 2024).. Valid values are `^[0-9]{4}-P(0[1-9]|1[0-3])$`',
    `gl_posting_date` DATE COMMENT 'Date when the inventory transfer transaction was posted to the general ledger for financial reporting. May differ from physical transfer date due to period-end cutoffs.',
    `haccp_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires continuous temperature monitoring and documentation per HACCP critical control point protocols. True for high-risk perishable items.',
    `inspection_notes` STRING COMMENT 'Free-text notes from quality inspection documenting any issues, observations, or conditions. Used for quality tracking and supplier performance evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock transfer record was most recently updated. Used for change tracking and data synchronization.',
    `priority_level` STRING COMMENT 'Urgency classification for the transfer: routine (standard replenishment), high (needed within 24 hours), urgent (needed same day), emergency (critical stockout situation requiring immediate action).. Valid values are `routine|high|urgent|emergency`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether items in this transfer require formal quality inspection upon receipt per GMP (Good Manufacturing Practice) or food safety protocols. True for high-value or high-risk items.',
    `quality_inspection_status` STRING COMMENT 'Result of quality inspection at receiving: not-required (no inspection needed), pending (awaiting inspection), passed (accepted), failed (rejected), conditional-accept (accepted with notes or partial rejection).. Valid values are `not-required|pending|passed|failed|conditional-accept`',
    `shipping_method` STRING COMMENT 'Method used to transport inventory between locations: internal-delivery (company fleet), courier (contracted delivery service), third-party (3PD logistics provider), self-pickup (destination unit retrieves), direct-transfer (hand-carried for intra-unit).. Valid values are `internal-delivery|courier|third-party|self-pickup|direct-transfer`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this stock transfer record: MARKETMAN (MarketMan Inventory Management), SAP-MM (SAP Materials Management), MANUAL (manually entered), LEGACY (migrated from prior system).. Valid values are `MARKETMAN|SAP-MM|MANUAL|LEGACY`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires temperature-controlled transportation to maintain food safety and quality. True for perishable items requiring refrigeration or freezing per HACCP (Hazard Analysis Critical Control Points) standards.',
    `temperature_zone_required` STRING COMMENT 'Required temperature zone for transport: ambient (room temperature), refrigerated (33-40°F), frozen (0°F or below), multi-temp (mixed temperature requirements). Critical for HACCP compliance and food safety.. Valid values are `ambient|refrigerated|frozen|multi-temp`',
    `total_item_count` DECIMAL(18,2) COMMENT 'Total number of distinct SKU (Stock Keeping Unit) line items included in this transfer. Used for transfer complexity assessment and receiving workload planning.',
    `total_quantity_transferred` DECIMAL(18,2) COMMENT 'Aggregate quantity of all items transferred, summed across all line items. Unit of measure varies by item (cases, pounds, gallons, each). Used for high-level transfer volume tracking.',
    `total_transfer_value_usd` DECIMAL(18,2) COMMENT 'Total dollar value of all items included in this stock transfer, calculated at standard cost. Critical for COGS% (Cost of Goods Sold Percentage) tracking and inventory valuation across units.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by carrier for monitoring in-transit status. Null for internal transfers without formal tracking.',
    `transfer_approval_date` DATE COMMENT 'Date when the stock transfer was approved by authorized manager. Null if not yet approved or if auto-approved (same as request date).',
    `transfer_number` STRING COMMENT 'Business-facing unique transfer document number used for tracking and reference in operational systems and communications. Format: STR-YYYYMMDD-NNNN.. Valid values are `^STR-[0-9]{8}-[0-9]{4}$`',
    `transfer_reason_code` STRING COMMENT 'Business reason for initiating the stock transfer: par-replenishment (restore PAR levels), excess-stock (reduce overstock), expiring-soon (move near-expiry items), quality-issue (return defective goods), menu-change (redistribute due to menu update), seasonal-adjustment (rebalance for seasonal demand).. Valid values are `par-replenishment|excess-stock|expiring-soon|quality-issue|menu-change|seasonal-adjustment`',
    `transfer_reason_notes` STRING COMMENT 'Free-text explanation providing additional context for the transfer. Used for operational communication and audit documentation.',
    `transfer_received_date` DATE COMMENT 'Date when the inventory was physically received and confirmed at the destination location. Null until transfer is fully or partially received.',
    `transfer_request_date` DATE COMMENT 'Date when the stock transfer was initially requested. Used for tracking lead times and transfer cycle analytics.',
    `transfer_ship_date` DATE COMMENT 'Date when the inventory physically left the origin location. Used for in-transit tracking and speed of service metrics.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the stock transfer: requested (initiated but pending approval), approved (authorized for execution), rejected (denied by approver), in-transit (shipped but not yet received), received (fully received and confirmed), cancelled (voided before completion), partially-received (some items received, others pending). [ENUM-REF-CANDIDATE: requested|approved|rejected|in-transit|received|cancelled|partially-received — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer based on origin and destination: inter-unit (between restaurant units), intra-unit (between storage locations within same unit), return-to-dc (from unit back to distribution center), return-to-vendor (from unit back to supplier), emergency (urgent replenishment), rebalance (inventory optimization transfer).. Valid values are `inter-unit|intra-unit|return-to-dc|return-to-vendor|emergency|rebalance`',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified between shipped quantities and received quantities. True if any line item shows variance requiring investigation.',
    `variance_reason` STRING COMMENT 'Root cause classification for any quantity variance: damage-in-transit (items damaged during shipment), short-shipment (fewer items sent than documented), overage (more items received than expected), quality-rejection (items rejected at receiving), counting-error (human error in count), none (no variance).. Valid values are `damage-in-transit|short-shipment|overage|quality-rejection|counting-error|none`',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Records the movement of inventory between restaurant units, between storage locations within a unit, or from a unit back to a distribution center — capturing both transfer header and line-level SKU detail in a single consolidated entity. Header attributes: transfer date, transfer type (inter-unit/intra-unit/return-to-vendor/return-to-DC), origin and destination units/locations, transfer status, requested-by/approved-by employees, and total transfer value. Line attributes (one per SKU transferred): stock item reference, transferred quantity, unit of measure, unit cost, extended cost, lot number, expiration date, and condition code. Maintains inventory accuracy across the restaurant network and supports inter-unit food cost allocation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order. Primary key for the replenishment order entity.',
    `employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: Procurement-to-inventory reconciliation: a replenishment order triggers a supply PO; linking them enables end-to-end order fulfillment tracking, AP matching, and delivery variance reporting. purchase',
    `quaternary_replenishment_employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `receiving_employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `receiving_user_employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit placing the replenishment order. Links to the restaurant operations master data.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Replenishment orders target a specific storage location within the restaurant unit (e.g., replenish the walk-in cooler, not just the unit in general). This FK enables location-level replenishment trac',
    `tertiary_replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'Reference to the user who cancelled the replenishment order. Used for audit trail and accountability.',
    `tertiary_replenishment_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the replenishment order. For auto-PAR orders, may reference system user account.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: A replenishment order is triggered when a specific stock item falls below its PAR level or reorder point. Linking replenishment_order to the stock_item that triggered the order enables PAR-level analy',
    `actual_delivery_date` DATE COMMENT 'Actual date when the replenishment order was received at the restaurant unit. Used for supplier performance tracking and variance analysis.',
    `approval_status` STRING COMMENT 'Approval workflow status for the replenishment order. Orders above threshold or emergency orders may require manager or regional approval before submission.. Valid values are `pending|approved|rejected|not_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was approved. Used for audit trail and approval turnaround time analysis.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the replenishment order was cancelled. Captures business reason such as supplier unavailability, budget constraints, duplicate order, or inventory correction.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was cancelled. Used for order lifecycle tracking and supplier performance analysis.',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier or logistics provider delivering the replenishment order. May be supplier-managed or third-party carrier.',
    `confirmed_delivery_date` DATE COMMENT 'Supplier-confirmed date for delivery of the replenishment order. May differ from requested date based on supplier availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was first created in the system. Used for audit trail and order lifecycle analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the replenishment order. Typically USD for US operations, but supports multi-currency for international units.. Valid values are `^[A-Z]{3}$`',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivery of the replenishment order. May include receiving hours, loading dock location, contact person, or handling requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was last updated. Tracks any changes to order details, status, or metadata.',
    `notes` STRING COMMENT 'General free-text notes or comments about the replenishment order. May include special requests, context, or internal communication.',
    `order_date` DATE COMMENT 'Date when the replenishment order was created or initiated. Business event date for order placement.',
    `order_number` STRING COMMENT 'Business-facing unique order number for tracking and reference. Format: RO-YYYYMMDD-XXXXXX where YYYYMMDD is order date and XXXXXX is sequence.. Valid values are `^RO-[0-9]{8}-[A-Z0-9]{6}$`',
    `order_source` STRING COMMENT 'System or channel that originated the replenishment order. Identifies whether order was auto-generated by MarketMan, manually created by manager, or triggered by integrated system.. Valid values are `marketman_auto|manager_manual|pos_integration|erp_mrp|mobile_app|third_party_api`',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order. Tracks progression from creation through fulfillment or cancellation. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|in_transit|delivered|partially_delivered|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the replenishment order trigger mechanism. Auto-PAR: triggered automatically when stock falls below PAR level; Manual: manager-initiated; Emergency: urgent out-of-stock order; Scheduled: routine periodic order; Spot: one-time special order.. Valid values are `auto_par|manual|emergency|scheduled|spot`',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms agreed with supplier for this replenishment order. Examples: Net 30, Net 60, COD, 2/10 Net 30. Inherited from supplier master agreement or negotiated per order.',
    `priority_level` STRING COMMENT 'Business priority classification for the replenishment order. Urgent priority for emergency out-of-stock situations; high for items approaching stockout; normal for routine PAR replenishment.. Valid values are `low|normal|high|urgent`',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was physically received and logged into inventory at the restaurant unit. Triggers inventory update and AP invoice matching.',
    `requested_delivery_date` DATE COMMENT 'Target date by which the restaurant unit requests delivery of the replenishment order. Used for planning and scheduling.',
    `shipping_fee` DECIMAL(18,2) COMMENT 'Delivery or freight charge for the replenishment order in USD. May be waived based on minimum order value or supplier agreement.',
    `shipping_method` STRING COMMENT 'Delivery method for the replenishment order. Determines delivery speed and cost. Will-call indicates restaurant will pick up from supplier.. Valid values are `standard|expedited|overnight|supplier_truck|third_party_carrier|will_call`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was submitted to the supplier. Marks transition from draft to active order.',
    `supplier_order_reference` STRING COMMENT 'Supplier-provided order confirmation number or reference. Used for cross-referencing with supplier systems and delivery documentation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the replenishment order in USD. Includes sales tax, VAT, or other applicable taxes based on jurisdiction.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Final total amount payable for the replenishment order in USD, including order value, tax, and shipping fees. Used for AP invoice reconciliation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the replenishment order in USD, including all line items before tax and fees. Used for budget tracking and COGS calculation.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by carrier for the replenishment order. Enables real-time delivery status monitoring.',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether the received replenishment order had discrepancies (quantity, quality, or item substitutions) compared to the original order. True if variance detected.',
    `variance_notes` STRING COMMENT 'Detailed notes describing any discrepancies found during receiving. Includes short shipments, damaged goods, wrong items, or quality issues. Used for supplier dispute resolution.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Automated or manually triggered replenishment order generated when stock falls below PAR level or reorder point, capturing both order header and line-level SKU detail in a single consolidated entity. Header attributes: order date, order type (auto-PAR/manual/emergency), restaurant unit reference, supplier reference, requested delivery date, order status, total order value, order source (MarketMan auto-replenishment/manager-initiated), and approval status. Line attributes (one per SKU ordered): stock item reference, ordered quantity, unit of measure, unit cost, extended cost, PAR quantity at time of order, on-hand quantity at time of order, variance-to-PAR quantity, and confirmed delivery quantity. Bridges inventory management and procurement; links to purchase orders in Coupa and SAP MM. Enables food cost forecasting and supplier fill-rate tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the inventory adjustment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who reviewed and approved the inventory adjustment.',
    `stock_transfer_id` BIGINT COMMENT 'Reference to the inventory transfer transaction that this adjustment corrects, if the adjustment is a transfer correction.',
    `adjustment_inventory_related_transfer_stock_transfer_id` BIGINT COMMENT 'Reference to the inventory transfer transaction that this adjustment corrects, if the adjustment is a transfer correction.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Health inspectors frequently mandate disposal of non-compliant inventory items, generating inventory adjustments. Linking the adjustment to the triggering health_inspection provides regulatory traceab',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Lot-level adjustment traceability: expiry write-offs, recall disposals, and shrinkage adjustments must reference the specific ingredient lot for HACCP compliance, recall scope determination, and accur',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: When an order item is voided post-prep or returned, an inventory adjustment is required to correct stock levels. Direct FK enables audit trails linking COGS adjustments to specific order lines, suppor',
    `prep_usage_id` BIGINT COMMENT 'Foreign key linking to inventory.prep_usage. Business justification: Prep usage events consume raw ingredients and generate inventory adjustments to reduce on-hand balances of the consumed stock items. Linking inventory_adjustment to the prep_usage record that triggere',
    `primary_inventory_adjusted_by_employee_id` BIGINT COMMENT 'Reference to the employee who initiated and recorded the inventory adjustment transaction.',
    `physical_count_id` BIGINT COMMENT 'Reference to the physical inventory count record that triggered this adjustment, if the adjustment resulted from a count reconciliation.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: When a loyalty free-item reward is redeemed, an inventory adjustment must be created to decrement stock. This FK traces which loyalty redemption triggered the adjustment, enabling COGS attribution to ',
    `refund_id` BIGINT COMMENT 'Foreign key linking to order.refund. Business justification: Refunds for food items trigger inventory adjustments (disposal or restock). Direct FK enables financial reconciliation reports matching refund dollar amounts to inventory cost adjustments, supporting ',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the inventory adjustment occurred.',
    `reversal_adjustment_inventory_adjustment_id` BIGINT COMMENT 'Reference to the adjustment record that reversed this adjustment, if applicable.',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock keeping unit (SKU) being adjusted.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in, dry storage, freezer) where the adjusted inventory is held.',
    `waste_log_id` BIGINT COMMENT 'Foreign key linking to inventory.waste_log. Business justification: Waste events (spoilage, overproduction, expiration) directly trigger inventory adjustments to reduce on-hand balances. Linking inventory_adjustment to the waste_log record that caused it enables end-t',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory adjusted, expressed in the stock items unit of measure. Positive values indicate increases to on-hand inventory; negative values indicate decreases.',
    `adjustment_date` DATE COMMENT 'The business date on which the inventory adjustment was recorded and applied to on-hand balances.',
    `adjustment_number` STRING COMMENT 'Externally-visible unique business identifier for the inventory adjustment transaction. Format: ADJ-YYYYMMDD-NNNNNN.. Valid values are `^ADJ-[0-9]{8}-[0-9]{6}$`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inventory adjustment transaction was recorded in the system.',
    `adjustment_type` STRING COMMENT 'Classification of the inventory adjustment indicating the nature of the non-standard inventory movement (positive adjustment, negative adjustment, write-off, theft, breakage, spoilage, system correction, transfer correction, count reconciliation, damaged goods, expired product, vendor credit). [ENUM-REF-CANDIDATE: positive adjustment|negative adjustment|write-off|theft|breakage|spoilage|system correction|transfer correction|count reconciliation|damaged goods|expired product|vendor credit — 12 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current approval status of the inventory adjustment (pending, approved, rejected, auto-approved).. Valid values are `pending|approved|rejected|auto-approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the manager approved the inventory adjustment.',
    `approved_by_manager_name` STRING COMMENT 'Full name of the manager who approved the inventory adjustment, captured for audit trail purposes.',
    `batch_number` STRING COMMENT 'The batch or lot number of the stock item being adjusted, used for traceability and food safety compliance under Hazard Analysis Critical Control Points (HACCP).',
    `cost_center_code` DECIMAL(18,2) COMMENT 'The cost center code associated with the restaurant unit or department responsible for the inventory adjustment, used for Profit and Loss (P&L) allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment value (e.g., USD, CAD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the stock item being adjusted, relevant for adjustments due to expired product removal.',
    `impacts_cogs` BOOLEAN COMMENT 'Indicates whether this inventory adjustment impacts the restaurant units Cost of Goods Sold (COGS) percentage calculation.',
    `is_reversed` BOOLEAN COMMENT 'Indicates whether this inventory adjustment has been reversed by a subsequent correcting adjustment.',
    `is_shrinkage` BOOLEAN COMMENT 'Indicates whether this adjustment represents inventory shrinkage (unexplained loss, theft, or discrepancy between physical count and system records).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory adjustment record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing context, details, or special instructions related to the inventory adjustment.',
    `on_hand_quantity_after` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity for this stock item at this location immediately after the adjustment was applied.',
    `on_hand_quantity_before` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity for this stock item at this location immediately before the adjustment was applied.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment. [ENUM-REF-CANDIDATE: THEFT|DAMAGE|SPOIL|EXPIRE|RECOUNT|SYSCORR|XFERERR|VNDCRED|BREAK|SPILL|MISREC|OVERPOUR|PORTIONERR|TEMPFAIL|RECALL — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative providing detailed explanation of why the inventory adjustment was necessary.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether this adjustment type or value threshold requires manager approval before being applied to inventory balances.',
    `supporting_document_reference` STRING COMMENT 'Reference number or identifier for supporting documentation (e.g., incident report number, physical count sheet ID, vendor credit memo number, manager approval form) that justifies the adjustment.',
    `temperature_at_adjustment_f` DECIMAL(18,2) COMMENT 'The recorded storage temperature in Fahrenheit at the time of adjustment, relevant for temperature-related spoilage or HACCP compliance documentation.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the stock item at the time of adjustment, used to calculate the total adjustment value.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the adjusted quantity is expressed (each, case, pound, kilogram, ounce, liter, gallon, box, bag, pallet). [ENUM-REF-CANDIDATE: each|case|pound|kilogram|ounce|liter|gallon|box|bag|pallet — 10 candidates stripped; promote to reference product]',
    `value` DECIMAL(18,2) COMMENT 'The total monetary value of the inventory adjustment, calculated as adjusted quantity multiplied by unit cost. Positive values increase inventory asset value; negative values decrease it.',
    `waste_category` STRING COMMENT 'Classification of waste type for adjustments related to inventory loss, used for waste percentage (Waste%) tracking and analysis (operational waste, spoilage, theft, damage, other).. Valid values are `operational waste|spoilage|theft|damage|other`',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Records manual adjustments to on-hand inventory balances outside of standard receiving, waste, or count workflows. Captures adjustment date, adjustment type (positive adjustment, negative adjustment, write-off, theft, breakage, system correction), stock item reference, storage location, adjusted quantity, adjustment value ($), reason code, supporting document reference, adjusted-by employee, and manager approval. Provides a complete audit trail for all non-standard inventory movements and supports shrinkage analysis. [SSOT] Authoritative owner for concept adjustment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` (
    `prep_usage_id` BIGINT COMMENT 'Unique identifier for the prep usage record. Primary key for the prep usage transaction.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Equipment utilization tracking via prep activity: prep tasks are performed on specific equipment (mixer, slicer, oven). Linking prep_usage to equipment_asset enables equipment utilization reports, mai',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: FIFO/FEFO consumption tracking and lot traceability: prep usage must reference the ingredient lot consumed to enforce rotation compliance, support allergen/recall traceability from finished prep back ',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Station-level food cost and production analysis: prep usage is recorded at the kitchen station performing the prep task (grill, cold line, prep station). Enables theoretical vs. actual usage variance ',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Food cost reporting and COGS attribution require linking prep batches directly to the menu item being produced. While recipe_id exists, direct menu_item_id enables menu-item-level theoretical vs. actu',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Restaurant prep work is performed during a specific shift. Linking prep_usage to shift enables labor-cost-per-prep reporting, HACCP traceability by daypart, and variance analysis by shift. shift_code ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the prep usage transaction. Supports accountability and audit trails.',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or BOM (Bill of Materials) that defines the theoretical ingredient usage. Links to the menu domain recipe master.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the prep activity occurred. Links to the restaurant operations domain.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the raw ingredient or stock item consumed during prep. Links to the inventory stock item master.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Prep activities occur at specific BOH stations which correspond to physical storage/prep locations tracked in stock_location. Adding stock_location_id normalizes the prep station reference — stock_loc',
    `actual_cost` DECIMAL(18,2) COMMENT 'The total dollar cost of the actual quantity used (actual_quantity_used multiplied by unit_cost). Contributes to actual COGS% (Cost of Goods Sold Percentage).',
    `actual_quantity_used` DECIMAL(18,2) COMMENT 'The actual quantity of the ingredient consumed during prep, as recorded by the BOH (Back of House) team. This is the real-world usage that depletes inventory.',
    `batch_number` STRING COMMENT 'The internal batch or production run number assigned to the prep output. Links multiple ingredient pulls to a single production batch.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prep usage record was first created in the system. Supports audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this record. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the ingredient lot consumed. Ensures FIFO (First In First Out) compliance and food safety.',
    `haccp_compliant` BOOLEAN COMMENT 'Indicates whether the prep activity met HACCP (Hazard Analysis Critical Control Points) temperature and handling requirements. True if compliant, False if not.',
    `item_description` STRING COMMENT 'The description of the stock item consumed. Denormalized to preserve historical context even if the item master changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this prep usage record was last updated. Supports change tracking and audit compliance.',
    `lot_number` STRING COMMENT 'The lot or batch number of the ingredient consumed. Critical for traceability and food safety compliance under HACCP (Hazard Analysis Critical Control Points).',
    `notes` STRING COMMENT 'Free-text notes or comments about the prep usage transaction. Captures contextual information for variance investigation or operational insights.',
    `prep_date` DATE COMMENT 'The calendar date on which the prep activity occurred. Used for daily food cost tracking and COGS% (Cost of Goods Sold Percentage) analysis.',
    `prep_task_reference` STRING COMMENT 'Reference code or identifier for the specific prep task or production batch. Used to group related ingredient pulls for a single prep activity.',
    `prep_timestamp` TIMESTAMP COMMENT 'The precise date and time when the prep activity was performed. Enables shift-level and intra-day analysis of BOH (Back of House) production.',
    `prep_type` STRING COMMENT 'The type or purpose of the prep activity. Distinguishes between batch production, made-to-order, PAR (Periodic Automatic Replenishment) level restocking, and other prep scenarios.. Valid values are `batch|made_to_order|par_replenishment|catering|special_event|waste_recovery`',
    `prep_usage_status` STRING COMMENT 'The current lifecycle status of the prep usage record. Supports workflow management and data quality controls.. Valid values are `draft|recorded|verified|posted|voided`',
    `quality_grade` STRING COMMENT 'The quality grade assigned to the prep output. Used to track prep quality and identify training or process improvement needs.. Valid values are `A|B|C|reject`',
    `sku_code` STRING COMMENT 'The SKU (Stock Keeping Unit) code of the ingredient consumed. Denormalized for reporting convenience and historical accuracy.',
    `temperature_at_prep_f` DECIMAL(18,2) COMMENT 'The temperature in Fahrenheit at which the ingredient was stored or handled during prep. Critical for HACCP (Hazard Analysis Critical Control Points) compliance.',
    `theoretical_cost` DECIMAL(18,2) COMMENT 'The total dollar cost of the theoretical quantity (theoretical_quantity multiplied by unit_cost). Used for theoretical COGS% calculation.',
    `theoretical_quantity` DECIMAL(18,2) COMMENT 'The theoretical quantity of the ingredient that should have been used according to the recipe or BOM (Bill of Materials). Used for variance analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for the ingredient at the time of prep. Used to calculate the dollar value of usage and variance.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity used. Examples include lb, kg, oz, gal, L, ea (each), case, or portion.',
    `variance_cost` DECIMAL(18,2) COMMENT 'The dollar value of the variance (actual_cost minus theoretical_cost). Quantifies the financial impact of over- or under-usage.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance quantity expressed as a percentage of the theoretical quantity. Enables standardized comparison across different ingredients and recipes.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual and theoretical quantity used (actual minus theoretical). Positive values indicate over-usage; negative values indicate under-usage.',
    `waste_reason_code` STRING COMMENT 'Code indicating the reason for any waste or over-usage. Used to categorize and analyze sources of food waste and variance. [ENUM-REF-CANDIDATE: none|spillage|over_prep|quality_issue|expiration|contamination|equipment_failure|training_error — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_prep_usage PRIMARY KEY(`prep_usage_id`)
) COMMENT 'Records the consumption of raw ingredients during BOH food preparation activities — the actual ingredient usage pulled from inventory to fulfill prep tasks and production schedules. Captures prep date, shift, station, stock item consumed, quantity used, unit of measure, theoretical usage (from BOM/recipe), actual usage, variance quantity, variance value ($), prep task reference, and recorded-by employee. Bridges inventory depletion with recipe/BOM standards from the menu domain, enabling theoretical vs. actual COGS% comparison.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` (
    `physical_count_line_id` BIGINT COMMENT 'Primary key for the physical_count_line association',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who physically counted this specific SKU line. Supports accountability tracking and variance investigation — different employees may count different sections of the same count event.',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking this count line to its parent physical count event header.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking this count line to the specific SKU that was counted.',
    `count_method` STRING COMMENT 'The method used to count this specific SKU line (manual entry, barcode scan, or weight-based). May differ per SKU within the same count event — e.g., produce counted by weight while packaged goods are scanned.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The physical quantity of this SKU found on the shelf during this count event, as recorded by the counting employee. This value belongs exclusively to the SKU-event intersection — it varies per count and per SKU.',
    `line_status` STRING COMMENT 'Per-SKU lifecycle status of this count line, independent of the overall count header status. A count event may be submitted while individual lines remain in recount or disputed state.',
    `recount_required` BOOLEAN COMMENT 'Boolean flag indicating whether this specific SKU line requires a recount due to variance exceeding acceptable thresholds. This is the line-level flag; the header-level recount_required_flag on physical_count is an aggregate. Moving this attribute here resolves the ambiguity between header and line-level recount disposition.',
    `recount_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a recount is required due to excessive variance or data quality issues. True if recount needed, False otherwise. [Moved from physical_count: The header-level recount_required_flag on physical_count is an aggregate indicator. The per-SKU recount disposition belongs on the count line (recount_required attribute), not on the count header. The header flag can be derived as TRUE if any line has recount_required = TRUE.]',
    `storage_location` STRING COMMENT 'The specific storage location within the restaurant unit where this SKU was counted (e.g., walk-in cooler, dry storage shelf 3, freezer). Belongs to the count line because the same SKU may be stored in multiple locations and counted separately per location within one event.',
    `system_quantity_at_count` DECIMAL(18,2) COMMENT 'The book inventory quantity for this SKU as recorded in the inventory management system (MarketMan) at the time this count line was initiated. Snapshotted at line creation to preserve the point-in-time comparison basis. Cannot reside on stock_item (changes continuously) nor on physical_count header (varies per SKU).',
    `unit_cost_at_count` DECIMAL(18,2) COMMENT 'The standard cost per unit of measure for this SKU at the time of the count event, snapshotted for variance_value calculation. Required because standard costs change over time and the historical variance value must be reproducible.',
    `unit_of_measure` STRING COMMENT 'The unit of measure used for this count line (e.g., each, case, lb, oz). May differ from the stock_item default UOM if the item was counted in a different unit during this event.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted_quantity and system_quantity_at_count for this SKU in this count event (counted minus system). Negative values indicate shrinkage or over-consumption; positive values indicate over-receiving or system errors.',
    `variance_value` DECIMAL(18,2) COMMENT 'The dollar value of the variance for this SKU in this count event, calculated as variance_quantity multiplied by the unit cost at count time. Feeds period-end food cost reconciliation and COGS% reporting at the line level.',
    CONSTRAINT pk_physical_count_line PRIMARY KEY(`physical_count_line_id`)
) COMMENT 'This association product represents the line-level detail record (Count Line Item) between a physical_count event and a stock_item SKU. It captures the operational result of counting one specific SKU during one specific count event — including the quantity physically found, the system book quantity at that moment, the resulting variance, and the per-SKU recount disposition. Each record is actively created by counting staff during the count event and is the atomic unit of variance investigation, food cost reconciliation, and COGS% reporting. This is the source of truth for what was actually on the shelf versus what the system believed was there, at the SKU-event intersection level.. Existence Justification: In restaurant inventory operations, a physical count event covers many SKUs simultaneously, and each SKU participates in many count events over time (daily spot-checks, weekly cycle counts, period-end full counts). The intersection — called a physical_count_line or count_detail — is a real operational record that staff actively create during each count, carrying counted_quantity, system_quantity_at_count, variance_quantity, variance_value, and recount flags that belong exclusively to the specific pairing of a count event and a stock item. This is a textbook M:N with a recognized business concept, rich relationship-specific data, and confirmed reciprocity in both directions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_parent_count_physical_count_id` FOREIGN KEY (`parent_count_physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_stock_location_id` FOREIGN KEY (`origin_stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_inventory_related_transfer_stock_transfer_id` FOREIGN KEY (`adjustment_inventory_related_transfer_stock_transfer_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_prep_usage_id` FOREIGN KEY (`prep_usage_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`prep_usage`(`prep_usage_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_reversal_adjustment_inventory_adjustment_id` FOREIGN KEY (`reversal_adjustment_inventory_adjustment_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_waste_log_id` FOREIGN KEY (`waste_log_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`waste_log`(`waste_log_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ADD CONSTRAINT `fk_inventory_prep_usage_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ADD CONSTRAINT `fk_inventory_physical_count_line_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ADD CONSTRAINT `fk_inventory_physical_count_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `vibe_restaurants_v1`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Eggs');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Fish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Milk');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Peanuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Soybeans');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Tree Nuts');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Wheat');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_max_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Maximum Temperature Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `haccp_min_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Minimum Temperature Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Is Gluten Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_gmo_free` SET TAGS ('dbx_business_glossary_term' = 'Is Genetically Modified Organism (GMO) Free');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Is Halal');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Is Kosher');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Is Vegetarian');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_item` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `access_control_required` SET TAGS ('dbx_business_glossary_term' = 'Access Control Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_receiving` SET TAGS ('dbx_business_glossary_term' = 'Allows Receiving');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_transfers` SET TAGS ('dbx_business_glossary_term' = 'Allows Transfers');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `allows_waste_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Waste Tracking');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `bin_count` SET TAGS ('dbx_business_glossary_term' = 'Bin Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Cubic Feet)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'refrigerated|frozen|ambient|bar|prep_area|service_station');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `par_level_enabled` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level Enabled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `primary_commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `requires_haccp_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Requires HACCP (Hazard Analysis Critical Control Points) Monitoring');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'open|restricted|locked|high_value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Area Type (Back of House / Front of House)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_value_regex' = 'boh|foh');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Maximum (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Minimum (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_monitoring_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Frequency (Hours)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'freezer|cooler|ambient|controlled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `on_hand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Balance Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|AUD');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantined|expired|damaged|in_transit');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|standard_cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`on_hand_balance` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `parent_count_physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Recount Of Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `parent_count_physical_count_id` SET TAGS ('dbx_self_reference' = 'recount_parent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|barcode-scan|rfid|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^PC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_business_glossary_term' = 'Count Period (Daypart)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night|overnight|full-day');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|submitted|approved|posted|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|spot-check|cycle-count|pre-close|post-close|opening');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `is_period_end_count` SET TAGS ('dbx_business_glossary_term' = 'Is Period End Count Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `posted_to_gl_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to GL (General Ledger) Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'System Inventory Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_counted` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) Counted');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_sku_with_variance` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) With Variance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Percentage (Waste%)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'trash|compost|donation|rendering|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `haccp_violation` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Violation Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `manager_approved` SET TAGS ('dbx_business_glossary_term' = 'Manager Approved Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `on_hand_quantity_before_waste` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `par_level_at_waste` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level at Waste');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `temperature_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Waste (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_prevention_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Waste Prevention Opportunity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P(0[1-9]|1[0-3])$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `haccp_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Monitoring Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|emergency');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|passed|failed|conditional-accept');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'internal-delivery|courier|third-party|self-pickup|direct-transfer');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MARKETMAN|SAP-MM|MANUAL|LEGACY');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi-temp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Transferred');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `total_transfer_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Value (USD)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^STR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_value_regex' = 'par-replenishment|excess-stock|expiring-soon|quality-issue|menu-change|seasonal-adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Received Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_request_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Request Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Ship Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'inter-unit|intra-unit|return-to-dc|return-to-vendor|emergency|rebalance');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_value_regex' = 'damage-in-transit|short-shipment|overage|quality-rejection|counting-error|none');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^RO-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'marketman_auto|manager_manual|pos_integration|erp_mrp|mobile_app|third_party_api');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'auto_par|manual|emergency|scheduled|spot');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_fee` SET TAGS ('dbx_business_glossary_term' = 'Shipping Fee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|supplier_truck|third_party_carrier|will_call');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Order Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`replenishment_order` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_inventory_related_transfer_stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transfer ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `prep_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Related Physical Count ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reversal_adjustment_inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto-approved');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `approved_by_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `impacts_cogs` SET TAGS ('dbx_business_glossary_term' = 'Impacts Cost of Goods Sold (COGS) Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `is_shrinkage` SET TAGS ('dbx_business_glossary_term' = 'Is Shrinkage Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity After Adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Adjustment');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `temperature_at_adjustment_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Adjustment (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'operational waste|spoilage|theft|damage|other');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `actual_quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Used');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `haccp_compliant` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Compliant');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_date` SET TAGS ('dbx_business_glossary_term' = 'Prep Date');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Prep Task Reference');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prep Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_type` SET TAGS ('dbx_business_glossary_term' = 'Prep Type');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_type` SET TAGS ('dbx_value_regex' = 'batch|made_to_order|par_replenishment|catering|special_event|waste_recovery');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `prep_usage_status` SET TAGS ('dbx_value_regex' = 'draft|recorded|verified|posted|voided');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|reject');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `temperature_at_prep_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Prep (Fahrenheit)');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `theoretical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Variance Cost');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`prep_usage` ALTER COLUMN `waste_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` SET TAGS ('dbx_association_edges' = 'inventory.physical_count,inventory.stock_item');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `physical_count_line_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Physical Count Line Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counted By Employee');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Physical Count Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Stock Item Id');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Line Count Method');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Count Line Status');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `recount_required` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `system_quantity_at_count` SET TAGS ('dbx_business_glossary_term' = 'System Quantity at Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `unit_cost_at_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost at Count');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_restaurants_v1`.`inventory`.`physical_count_line` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
