-- Schema for Domain: inventory | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`inventory` COMMENT 'Manages BOH stock levels, SKU tracking, PAR levels (Periodic Automatic Replenishment), waste tracking (Waste%), yield management, receiving, transfers, physical counts, and replenishment orders via MarketMan. Supports COGS% optimization and food cost control across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`stock_item` (
    `stock_item_id` BIGINT COMMENT 'Unique identifier for the stock item. Primary key for the stock_item product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allows allocation of inventory holding costs to specific cost centers for budgeting and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for financial reporting of inventory valuation and COGS per item, enabling accurate GL posting of stock costs.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each stock item (ingredient) is governed by a specific HACCP plan defining its safe handling, temperature limits, and critical controls. stock_item already stores haccp_max_temp_f/haccp_min_temp_f. Li',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: REQUIRED: Ingredient Inventory Valuation Report needs each stock item linked to its ingredient master for nutrition, allergen, and compliance tracking.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: stock_item.unit_of_measure is a STRING column that denotes the storage/base unit of measure for the SKU. The uom table is the authoritative UOM reference master in this domain. Adding uom_id FK normal',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates whether the item contains or may contain eggs. Required for menu labeling and allergen disclosure.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain fish. Required for menu labeling and allergen disclosure.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates whether the item contains or may contain milk or dairy derivatives. Required for menu labeling and allergen disclosure.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain peanuts. Required for menu labeling and allergen disclosure.',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates whether the item contains or may contain crustacean shellfish. Required for menu labeling and allergen disclosure.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates whether the item contains or may contain soybeans. Required for menu labeling and allergen disclosure.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates whether the item contains or may contain tree nuts. Required for menu labeling and allergen disclosure.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates whether the item contains or may contain wheat. Required for menu labeling and allergen disclosure.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one case. Used for ordering and receiving conversions.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the standard cost (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
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
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order matching and invoice reconciliation.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of usable product after preparation and trimming. Critical for recipe costing and waste tracking.',
    CONSTRAINT pk_stock_item PRIMARY KEY(`stock_item_id`)
) COMMENT 'Master record for every SKU tracked in restaurant inventory — food, beverage, packaging, and non-food supplies. Captures SKU code, item name, unit of measure (UOM), item category (protein, produce, dry goods, beverage, paper goods, cleaning), storage class (ambient, refrigerated, frozen), reorder point, reorder quantity, standard cost, vendor item code, shelf life days, HACCP temperature range, allergen flags, daypart applicability, seasonal adjustment flags, and active status. Also owns PAR-level configuration per unit-location: PAR quantity, minimum quantity (reorder point), maximum quantity (shelf capacity), day-of-week overrides, seasonal adjustment flags, and effective date range. This is the SSOT for all stockable items and their replenishment parameters managed through MarketMan.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`stock_location` (
    `stock_location_id` BIGINT COMMENT 'Unique identifier for the stock location. Primary key.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Brand standard compliance audits for storage: each storage location must comply with a governing brand standard defining temperature zone requirements, HACCP storage protocols, and access controls. Br',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stores overhead allocation of each storage location to cost centers for accurate expense tracking.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Facility‑level inventory mapping needed for inventory valuation and rent‑cost allocation reports per physical restaurant property.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for HACCP temperature monitoring accountability; each storage location has an assigned manager employee who signs compliance reports.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier for the refrigeration or climate control equipment serving this location, used for maintenance tracking and temperature monitoring integration.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this stock location is physically situated.',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` (
    `on_hand_balance_id` BIGINT COMMENT 'Unique identifier for the on-hand balance record. Primary key for the inventory position snapshot.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links on‑hand quantities to cost centers to reflect inventory value in financial statements per cost center.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: On‑hand snapshots need facility context for real‑estate cost allocation, insurance valuation, and property‑level inventory audits.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: On-hand balance snapshots are taken at period end for inventory valuation on the balance sheet. Linking to financial_period enables period-over-period inventory value comparison and supports COGS calc',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: FRANCHISEE‑LEVEL INVENTORY DASHBOARD aggregates on‑hand balances per franchisee for performance and royalty calculations.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this inventory is held. Links to the restaurant operations master.',
    `stock_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this balance is recorded. Links to the inventory item master.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location within the restaurant (walk-in cooler, dry storage, freezer, prep area). Links to storage location master.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: on_hand_balance.unit_of_measure is a STRING column denoting the UOM for the on-hand quantity snapshot. The uom table is the authoritative UOM reference master. Adding uom_id FK normalizes this referen',
    `abc_classification` STRING COMMENT 'The ABC inventory classification based on value and usage velocity. A items are high-value/high-velocity requiring tight control, C items are low-value/low-velocity.. Valid values are `A|B|C`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which unit_cost and extended_value are denominated.. Valid values are `USD|CAD|EUR|GBP|MXN|AUD`',
    `cycle_count_frequency` STRING COMMENT 'The frequency at which this SKU should be physically counted as part of the cycle count program. Typically aligned with ABC classification.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `days_until_expiration` STRING COMMENT 'The number of days remaining until the expiration date. Used to prioritize usage and identify items at risk of waste.',
    `expiration_date` DATE COMMENT 'The date by which this inventory must be used or discarded. Critical for food safety, waste management, and FIFO (First In First Out) rotation.',
    `extended_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand inventory, calculated as quantity_on_hand multiplied by unit_cost. Used for financial reporting and COGS% analysis.',
    `inventory_status` STRING COMMENT 'The current lifecycle status of this inventory position. Determines whether the inventory is available for use, held for quality review, or flagged for disposal.. Valid values are `available|reserved|quarantined|expired|damaged|in_transit`',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether this SKU is a perishable item requiring temperature control and expiration tracking. True for fresh produce, dairy, meat; false for dry goods.',
    `last_adjustment_date` DATE COMMENT 'The date when the last inventory adjustment (waste, transfer, or correction) was recorded for this SKU at this location.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'The date and time of the last inventory transaction (receipt, transfer, issue, or adjustment) that affected this balance. Used to identify stagnant inventory.',
    `last_physical_count_date` DATE COMMENT 'The date when the last physical inventory count was performed for this SKU at this location. Used to track audit compliance and inventory accuracy.',
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
    `source_system` STRING COMMENT 'The operational system that provided this inventory balance record (MarketMan Inventory Management, SAP Materials Management, manual physical count, or POS integration).. Valid values are `MarketMan|SAP_MM|manual_count|POS_integration`',
    `temperature_zone` STRING COMMENT 'The required storage temperature zone for this SKU (ambient/dry, refrigerated, or frozen). Critical for food safety compliance and storage location assignment.. Valid values are `ambient|refrigerated|frozen`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this SKU at this location. Used to calculate extended inventory value and COGS (Cost of Goods Sold).',
    `valuation_method` STRING COMMENT 'The accounting method used to value this inventory (FIFO - First In First Out, LIFO - Last In First Out, weighted average, or standard cost). Determines COGS calculation.. Valid values are `FIFO|LIFO|weighted_average|standard_cost`',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The difference between quantity_on_hand and par_level. Positive values indicate overstocking, negative values indicate understocking and trigger replenishment.',
    CONSTRAINT pk_on_hand_balance PRIMARY KEY(`on_hand_balance_id`)
) COMMENT 'Current stock-on-hand snapshot for each SKU at each storage location within a restaurant unit. Captures quantity on hand, quantity reserved (committed to prep), quantity available, last physical count date, last adjustment date, last received date, unit cost, extended value, and variance from PAR level. Updated by receiving, transfers, waste events, and physical counts. The authoritative real-time inventory position record used for replenishment decisions and food cost reporting.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`receiving_order` (
    `receiving_order_id` BIGINT COMMENT 'Unique identifier for the receiving order record. Primary key for inbound inventory transactions at restaurant unit level.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: 3-way match (PO + goods receipt + AP invoice) is a standard AP control in restaurant foodservice. Linking receiving_order to ap_invoice enables automated invoice matching, dispute resolution, and supp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving transactions are posted to a cost center for food cost allocation and budget variance reporting. Restaurant operators track receiving costs by cost center to manage food cost percent targets',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Receiving dock assignment per facility supports labor‑cost tracking and health‑inspection compliance at each restaurant location.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Received goods must be posted to the correct fiscal period for COGS accrual and inventory valuation. Period-end close in restaurant finance requires all receiving transactions to be period-stamped. No',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee receiving reports track supplier deliveries per franchisee to reconcile costs against royalty fees.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Goods receipt to inventory posting reconciliation is a core foodservice receiving control. The receiving_order (inventory posting) must reference the supply-side goods_receipt (physical inspection rec',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Receiving is a critical HACCP control point. Each receiving order must be processed per the applicable HACCP plan governing temperature checks, seal integrity, and quality inspection. receiving_order ',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Delivery performance tracking requires linking the inventory receiving event to the logistics shipment record. Foodservice operators compare scheduled vs actual arrival (inbound_shipment) against what',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: Three-way match (PO → receipt → invoice) is a fundamental AP control in foodservice procurement. Linking receiving_order to supply_purchase_order enables PO fulfillment reporting and quantity variance',
    `employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `receiving_manager_employee_id` BIGINT COMMENT 'Employee identifier of the restaurant manager or BOH staff member who inspected and accepted the delivery. Links to Workday HCM employee master.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit receiving the goods. Links to restaurant operations master data.',
    `receiving_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit receiving the goods. Links to restaurant operations master data.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: A receiving_order is the physical fulfillment event for a replenishment_order. Linking receiving_order.replenishment_order_id → replenishment_order.replenishment_order_id closes the procurement loop: ',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Receiving orders occur during specific shifts; shift-level receiving reports (delivery accuracy, temperature compliance by shift) are standard foodservice operational controls. receiving_shift is a pl',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: receiving_order.receiving_location is a free-text STRING denoting where goods were received within the restaurant unit. Replacing it with a FK to stock_location.stock_location_id normalizes this refer',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was first created in MarketMan or source system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the received value (e.g., USD, CAD, EUR). Supports multi-currency operations for international franchise units.. Valid values are `^[A-Z]{3}$`',
    `days_variance` STRING COMMENT 'Calculated difference in days between expected and actual delivery date. Positive values indicate late delivery; negative values indicate early delivery. Used for supplier scorecard.',
    `delivery_date` DATE COMMENT 'Calendar date when the goods were delivered to the restaurant unit. Used for inventory aging and FIFO tracking.',
    `delivery_note_number` STRING COMMENT 'Packing slip or delivery note number provided by the supplier. Cross-reference document for reconciliation and dispute resolution.',
    `delivery_time` TIMESTAMP COMMENT 'Precise timestamp when the delivery was received at the restaurant Back of House (BOH). Critical for temperature control compliance and HACCP documentation.',
    `delivery_timeliness` STRING COMMENT 'Classification of delivery punctuality relative to expected delivery date. On Time: within agreed window; Early: before window; Late: after window. Key supplier performance indicator.. Valid values are `on_time|early|late`',
    `driver_name` STRING COMMENT 'Name of the driver who delivered the goods. Captured for traceability and food safety audit trail per HACCP requirements.',
    `expected_delivery_date` DATE COMMENT 'Scheduled delivery date from the original purchase order. Used to calculate delivery timeliness and supplier on-time performance metrics.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the receiving order record was last updated. Tracks changes to status, variance resolution, or quality inspection updates.',
    `posted_to_inventory_flag` BOOLEAN COMMENT 'Boolean indicator that received goods have been posted to restaurant unit inventory in MarketMan and SAP S/4HANA. True when goods receipt is complete and stock levels updated.',
    `posted_to_inventory_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving transaction was posted to inventory system. Used for inventory valuation date and FIFO/LIFO costing.',
    `quality_inspection_result` STRING COMMENT 'Overall quality assessment result for the received goods. Approved: meets standards; Rejected: fails quality criteria; Conditional: accepted with notes; Not Inspected: visual check only. Aligns with Good Manufacturing Practice (GMP) standards.. Valid values are `approved|rejected|conditional|not_inspected`',
    `quality_notes` STRING COMMENT 'Free-text notes captured by receiving manager regarding product quality, packaging condition, or other observations. Used for supplier feedback and continuous improvement.',
    `receiving_number` STRING COMMENT 'Business-facing unique receiving document number generated by MarketMan or restaurant POS system. Format: RCV-YYYYMMDD-NNNN.. Valid values are `^RCV-[0-9]{8}-[0-9]{4}$`',
    `receiving_status` STRING COMMENT 'Current lifecycle status of the receiving transaction. Pending: awaiting inspection; Partial: some items received; Complete: fully received and accepted; Rejected: delivery refused; Disputed: discrepancy under review.. Valid values are `pending|partial|complete|rejected|disputed`',
    `rejection_reason` STRING COMMENT 'Detailed explanation if receiving status is rejected. Captures specific food safety, quality, or compliance failure that led to refusal of delivery. Required for FDA and HACCP audit trail.',
    `seal_integrity_check` STRING COMMENT 'Verification that tamper-evident seals on delivery containers were intact upon arrival. Intact: seal unbroken; Broken: potential contamination risk; Not Applicable: no seal required. Part of food safety protocol.. Valid values are `intact|broken|not_applicable`',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this receiving record. MarketMan: primary inventory system; SAP MM: ERP goods receipt; Manual Entry: paper-based receiving logged retrospectively.. Valid values are `marketman|sap_mm|manual_entry`',
    `supplier_name` STRING COMMENT 'Legal or trade name of the supplier or distributor. Denormalized for reporting convenience; authoritative source is supplier master.',
    `temperature_check_result` STRING COMMENT 'Result of temperature verification for refrigerated and frozen goods upon delivery. Pass: within safe range; Fail: out of range, reject or quarantine; Not Applicable: ambient goods. Critical for HACCP and FDA compliance.. Valid values are `pass|fail|not_applicable`',
    `temperature_recorded` DECIMAL(18,2) COMMENT 'Actual temperature reading in Fahrenheit recorded during delivery inspection for refrigerated or frozen items. Null for ambient goods. Used for food safety audit trail.',
    `total_items_ordered` STRING COMMENT 'Total count of distinct Stock Keeping Units (SKUs) listed on the originating purchase order. Used for completeness verification.',
    `total_items_received` STRING COMMENT 'Total count of distinct SKUs actually received and accepted in this transaction. Variance from total_items_ordered triggers partial or disputed status.',
    `total_received_value` DECIMAL(18,2) COMMENT 'Total monetary value of all goods received in this transaction, in local currency. Used for Cost of Goods Sold (COGS) calculation and variance analysis against PO.',
    `variance_flag` BOOLEAN COMMENT 'Boolean indicator that quantity or value variance exists between PO and received goods. True triggers exception workflow for manager review and supplier follow-up.',
    `variance_reason` STRING COMMENT 'Categorized reason for any discrepancy between ordered and received goods. Used for supplier performance tracking and root cause analysis.. Valid values are `short_shipment|damaged_goods|wrong_item|quality_issue|overage|none`',
    CONSTRAINT pk_receiving_order PRIMARY KEY(`receiving_order_id`)
) COMMENT 'Records the receipt of goods delivered to a restaurant unit from a supplier or distribution center, capturing both delivery-level header information and line-level SKU detail in a single consolidated entity. Header attributes: purchase order reference, delivery date/time, supplier reference, driver name, invoice number, total received value, receiving status (pending/partial/complete/rejected), temperature check result, seal integrity check, and receiving manager reference. Line attributes (one per SKU received): stock item reference, ordered vs received vs rejected quantities, unit of measure, unit cost, extended cost, lot number, expiration date, temperature at receipt (°F/°C), condition code (acceptable/damaged/short-dated/rejected), and variance reason code. Links to MarketMan purchase order and SAP S/4HANA goods receipt. Drives on-hand balance updates, COGS% tracking, and supplier performance measurement.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`physical_count` (
    `physical_count_id` BIGINT COMMENT 'Unique identifier for the physical inventory count event. Primary key.',
    `financial_period_id` BIGINT COMMENT 'Reference to the fiscal period (month/quarter) for which this count is being performed, used for period-end food cost reconciliation and P&L (Profit and Loss) reporting.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee audit of physical inventory counts is required for compliance and variance analysis.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the General Ledger journal entry created to record the inventory variance from this physical count.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initiated or started the physical count event.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the physical count was performed.',
    `recount_of_count_id` BIGINT COMMENT 'Reference to the original physical count ID if this count is a recount or correction of a previous count event.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: A physical count event can be scoped to a specific storage location within a restaurant unit (e.g., counting only the walk-in cooler or dry storage). Adding stock_location_id FK to physical_count link',
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
    `recount_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a recount is required due to excessive variance or data quality issues. True if recount needed, False otherwise.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the physical count was scheduled to begin.',
    `source_system` STRING COMMENT 'The system or application from which the physical count data originated: MarketMan (primary inventory system), SAP (ERP integration), Manual (paper-based), or Mobile-App (handheld device).. Valid values are `MarketMan|SAP|Manual|Mobile-App`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was submitted for approval after completion.',
    `system_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory according to the system (MarketMan) at the time of count, used as the baseline for variance calculation.',
    `total_sku_counted` STRING COMMENT 'The total number of unique SKUs (Stock Keeping Units) that were physically counted during this count event.',
    `total_sku_with_variance` STRING COMMENT 'The number of SKUs that showed a variance (difference) between system inventory and physical count.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The total dollar value variance between system inventory and physical count results, calculated as (physical count value - system inventory value). Positive indicates overage, negative indicates shortage.',
    `total_variance_percentage` DECIMAL(18,2) COMMENT 'The total variance expressed as a percentage of system inventory value, calculated as (variance amount / system inventory value) * 100. Key metric for COGS% (Cost of Goods Sold Percentage) analysis and food cost control.',
    `variance_reason_code` STRING COMMENT 'Primary reason code for inventory variance: theft (shrinkage), spoilage (expired/damaged), waste (prep waste), receiving-error (incorrect receipt), transfer-error (incorrect transfer), system-error (data entry mistake), or unknown. [ENUM-REF-CANDIDATE: theft|spoilage|waste|receiving-error|transfer-error|system-error|unknown — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_physical_count PRIMARY KEY(`physical_count_id`)
) COMMENT 'Records scheduled or ad-hoc physical inventory count events at a restaurant unit, capturing both count-level header metadata and line-level SKU counts in a single consolidated entity. Header attributes: count date, count type (full/spot-check/cycle-count/pre-close/post-close), count status, count period, initiated-by/approved-by employees, total variance value and percentage. Line attributes (one per SKU-location counted): stock item reference, storage location, system quantity (book inventory), counted quantity, variance quantity and value ($), unit of measure, unit cost, count method (manual/scan), counted-by employee reference, and recount flag. Variance lines trigger investigation workflows and feed period-end food cost reconciliation and COGS% reporting.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`waste_log` (
    `waste_log_id` BIGINT COMMENT 'Unique identifier for the waste log entry. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Marketing ROI analysis needs to attribute waste spikes to specific campaigns; this FK supports that report.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to foodsafety.foodsafety_corrective_action. Business justification: When a food safety corrective action mandates disposal of non-compliant stock (temperature exceedance, contamination), the resulting waste event must be traceable to that corrective action for HACCP c',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: waste_log.haccp_violation flag indicates a CCP breach caused the waste event. Linking to the specific critical_control_point enables HACCP deviation tracking, regulatory reporting, and CCP performance',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: HACCP equipment-linked waste tracking: waste events caused by equipment failure (refrigeration breakdown, fryer malfunction) must reference the responsible equipment asset for food safety audits, insu',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Waste tracking per facility enables waste‑cost attribution to each property for sustainability and expense reporting.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Waste is reported by fiscal period for P&L variance analysis and food cost percent calculation. Restaurant operators and franchisors track waste cost against period budgets. No existing FK from waste_',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee waste reporting feeds sustainability metrics and waste‑related royalty adjustments.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Health inspectors can mandate immediate disposal of food items during an inspection. Linking waste_log to health_inspection provides regulatory traceability — health departments and operators need to ',
    `illness_report_id` BIGINT COMMENT 'Foreign key linking to foodsafety.illness_report. Business justification: When a foodborne illness is reported, suspected food items must be immediately disposed of and the disposal recorded. Linking waste_log to illness_report provides regulatory traceability for health de',
    `maintenance_work_order_id` BIGINT COMMENT 'Foreign key linking to realestate.maintenance_work_order. Business justification: Refrigeration or equipment failures cause waste events directly attributable to a maintenance work order. Linking waste_log to maintenance_work_order supports warranty/insurance claims, HACCP violatio',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Void-to-waste reconciliation: when an order item is voided, comped, or returned, the physical food becomes waste. Linking waste_log to the triggering order_item enables loss prevention reporting, food',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the waste event in the system.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the waste event occurred.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to supply.recall_event. Business justification: FDA/USDA recall compliance requires linking disposal and waste records to the triggering recall event. Foodservice operators must demonstrate that recalled product was properly disposed of; waste_log ',
    `recipe_id` BIGINT COMMENT 'Identifier of the recipe or Bill of Materials (BOM) associated with the wasted prepared item, if applicable.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the waste event occurred, used for labor and operational analysis.',
    `stock_item_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) that was wasted.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Waste is recorded per storage location; replacing the denormalized storage_location field with a FK enables location‑level waste analytics.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posts waste expense to a designated GL account for waste cost reporting and profitability analysis.',
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
    `responsible_station` STRING COMMENT 'The operational area where the waste occurred: BOH (Back of House - kitchen/prep areas) or FOH (Front of House - service/dining areas).. Valid values are `BOH|FOH`',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Unique identifier for the stock transfer transaction. Primary key for the stock transfer record.',
    `catering_order_id` BIGINT COMMENT 'Foreign key linking to order.catering_order. Business justification: Catering-driven inter-unit stock transfers: high-volume catering events at one unit may require stock transferred from a nearby unit. Linking stock_transfer to the catering_order enables event-driven ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Captures internal transfer cost allocation to cost centers for inter‑unit inventory movement accounting.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center receiving the transferred inventory. For intra-unit transfers, this is the same as origin unit.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the destination unit where items will be received. Critical for BOH (Back of House) inventory accuracy.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Inter‑facility stock transfers require facility context to allocate transfer costs and maintain accurate on‑hand balances per property.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Inter-unit stock transfers affect inventory valuation at both origin and destination units and must be posted to the correct fiscal period. stock_transfer has fiscal_period as a plain text attr — a pr',
    `origin_restaurant_unit_id` BIGINT COMMENT 'Reference to the restaurant unit or distribution center from which inventory is being transferred. For intra-unit transfers, this is the same as destination unit.',
    `origin_stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in cooler, dry storage, freezer) within the origin unit from which items are being transferred. Critical for BOH (Back of House) inventory accuracy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically kitchen manager or shift supervisor) who initiated the stock transfer request. Used for accountability and audit trail.',
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
    `total_item_count` STRING COMMENT 'Total number of distinct SKU (Stock Keeping Unit) line items included in this transfer. Used for transfer complexity assessment and receiving workload planning.',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order. Primary key for the replenishment order entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Replenishment orders generate AP invoices upon fulfillment. Linking the replenishment order to its AP invoice enables PO-to-invoice reconciliation, accrual accounting, and supplier payment tracking — ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: LTO and promotional campaign planning directly drives replenishment orders in foodservice — supply chain teams generate campaign-specific purchase orders to stock featured items. Links procurement spe',
    `catering_order_id` BIGINT COMMENT 'Foreign key linking to order.catering_order. Business justification: Pre-event inventory planning: large catering orders require advance stock purchasing. Linking replenishment_order to the catering_order that drove it enables demand-driven procurement tracking, ensure',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Associates purchase orders with cost centers to allocate procurement spend in financial reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Replenishment orders are received at a specific physical facility (receiving dock). Facility-level procurement reporting, HACCP receiving compliance, and delivery scheduling all require knowing which ',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Replenishment orders are accrued to fiscal periods for AP liability recognition and inventory cost reporting. Period-end close requires all open POs to be assigned to the correct financial period. No ',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchise agreements mandate approved supplier purchasing. Linking replenishment_order to franchisee enables franchisor audits of franchisee purchasing compliance, cost allocation by franchisee, and a',
    `primary_replenishment_employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: Specific promotions (BOGO, LTO price points) with defined start/end dates drive precise replenishment timing and quantities in QSR operations. Promotion-level procurement traceability is required for ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: Replenishment-to-PO traceability is a standard foodservice inventory management report showing which internal reorder requests generated which supplier POs. This link closes the demand-to-supply loop.',
    `quaternary_replenishment_employee_id` BIGINT COMMENT 'Reference to the user (manager or approver) who approved the replenishment order. Null if approval not required or still pending.',
    `receiving_user_employee_id` BIGINT COMMENT 'Reference to the user (typically BOH manager or receiving clerk) who received and verified the replenishment order delivery at the restaurant unit.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit placing the replenishment order. Links to the restaurant operations master data.',
    `tertiary_replenishment_cancelled_by_user_employee_id` BIGINT COMMENT 'Reference to the user who cancelled the replenishment order. Used for audit trail and accountability.',
    `tertiary_replenishment_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the replenishment order. For auto-PAR orders, may reference system user account.',
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
    `payment_terms` STRING COMMENT 'Payment terms agreed with supplier for this replenishment order. Examples: Net 30, Net 60, COD, 2/10 Net 30. Inherited from supplier master agreement or negotiated per order.',
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

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the inventory adjustment record. Primary key.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `adjustment_employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who reviewed and approved the inventory adjustment.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to foodsafety.corrective_action. Business justification: Inventory adjustments may result from corrective actions issued after audits; the FK records the originating action.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Adjustment entries need facility reference for GL posting and COGS allocation to the correct restaurant building.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Inventory adjustments must be posted to the correct fiscal period for accurate COGS and shrinkage reporting. Period-end close procedures require all adjustments to be period-stamped. No existing FK fr',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Adjustments affect COGS and royalty calculations; franchisee‑level tracking is required for financial reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ensures inventory adjustments affect the correct GL account for accurate COGS and inventory valuation.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Receipt discrepancy correction is a named adjustment type in foodservice. When a quantity or quality error is discovered post-receipt, the corrective inventory_adjustment must reference the originatin',
    `inspection_violation_id` BIGINT COMMENT 'Foreign key linking to foodsafety.inspection_violation. Business justification: Health inspection violations (expired product, temperature abuse, improper storage) directly trigger inventory adjustments to remove non-compliant stock. Linking enables regulatory compliance traceabi',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Inventory adjustments generate GL journal entries (debit shrinkage/COGS, credit inventory). Audit trails require traceability from the operational adjustment record to the financial journal entry. phy',
    `primary_inventory_adjusted_by_employee_id` BIGINT COMMENT 'Reference to the employee who initiated and recorded the inventory adjustment transaction.',
    `physical_count_id` BIGINT COMMENT 'Reference to the physical inventory count record that triggered this adjustment, if the adjustment resulted from a count reconciliation.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to supply.recall_event. Business justification: Recall-driven inventory write-downs must be traceable to the recall event for FDA compliance and financial impact reporting. Foodservice operators are required to quantify recalled inventory value; li',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the inventory adjustment occurred.',
    `reversal_adjustment_inventory_adjustment_id` BIGINT COMMENT 'Reference to the adjustment record that reversed this adjustment, if applicable.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level inventory shrinkage and adjustment reporting is a standard foodservice operational control. Managers review which shifts generate the most adjustments to identify training gaps or theft pa',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock keeping unit (SKU) being adjusted.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location (walk-in, dry storage, freezer) where the adjusted inventory is held.',
    `waste_log_id` BIGINT COMMENT 'Foreign key linking to inventory.waste_log. Business justification: When a waste event is recorded in waste_log, it typically triggers a corresponding inventory_adjustment to reduce on-hand balances. Adding waste_log_id FK to inventory_adjustment links the adjustment ',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory adjusted, expressed in the stock items unit of measure. Positive values indicate increases to on-hand inventory; negative values indicate decreases.',
    `adjustment_date` DATE COMMENT 'The business date on which the inventory adjustment was recorded and applied to on-hand balances.',
    `adjustment_number` STRING COMMENT 'Externally-visible unique business identifier for the inventory adjustment transaction. Format: ADJ-YYYYMMDD-NNNNNN.. Valid values are `^ADJ-[0-9]{8}-[0-9]{6}$`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inventory adjustment transaction was recorded in the system.',
    `adjustment_type` STRING COMMENT 'Classification of the inventory adjustment indicating the nature of the non-standard inventory movement (positive adjustment, negative adjustment, write-off, theft, breakage, spoilage, system correction, transfer correction, count reconciliation, damaged goods, expired product, vendor credit). [ENUM-REF-CANDIDATE: positive adjustment|negative adjustment|write-off|theft|breakage|spoilage|system correction|transfer correction|count reconciliation|damaged goods|expired product|vendor credit — 12 candidates stripped; promote to reference product]',
    `adjustment_value` DECIMAL(18,2) COMMENT 'The total monetary value of the inventory adjustment, calculated as adjusted quantity multiplied by unit cost. Positive values increase inventory asset value; negative values decrease it.',
    `approval_status` STRING COMMENT 'Current approval status of the inventory adjustment (pending, approved, rejected, auto-approved).. Valid values are `pending|approved|rejected|auto-approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the manager approved the inventory adjustment.',
    `batch_number` STRING COMMENT 'The batch or lot number of the stock item being adjusted, used for traceability and food safety compliance under Hazard Analysis Critical Control Points (HACCP).',
    `cost_center_code` STRING COMMENT 'The cost center code associated with the restaurant unit or department responsible for the inventory adjustment, used for Profit and Loss (P&L) allocation.',
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
    `waste_category` STRING COMMENT 'Classification of waste type for adjustments related to inventory loss, used for waste percentage (Waste%) tracking and analysis (operational waste, spoilage, theft, damage, other).. Valid values are `operational waste|spoilage|theft|damage|other`',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Records manual adjustments to on-hand inventory balances outside of standard receiving, waste, or count workflows. Captures adjustment date, adjustment type (positive adjustment, negative adjustment, write-off, theft, breakage, system correction), stock item reference, storage location, adjusted quantity, adjustment value ($), reason code, supporting document reference, adjusted-by employee, and manager approval. Provides a complete audit trail for all non-standard inventory movements and supports shrinkage analysis.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`food_cost_period` (
    `food_cost_period_id` BIGINT COMMENT 'Unique identifier for the food cost period record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Franchise agreements define contractual COGS% benchmarks and royalty obligations. Linking food_cost_period to the governing agreement enables franchisor compliance reporting — verifying actual food co',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Food‑cost period calculations consider campaign impact on COGS; linking provides the necessary data for cost‑impact reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links periodic food‑cost calculations to cost centers for departmental profitability reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Facility-level food cost reporting is a standard foodservice management report used for remodel ROI analysis, occupancy cost as % of food sales, and lease vs. owned performance benchmarking. No existi',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Food cost periods must align with canonical fiscal periods for P&L reporting and COGS recognition. Restaurant finance teams reconcile food cost percent against the financial period close. No existing ',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Food‑cost period statements are aggregated per franchisee for royalty and performance scorecards.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Food cost period close generates a GL journal entry to post COGS, inventory adjustments, and waste to the general ledger. Linking food_cost_period to journal_entry enables audit traceability from oper',
    `labor_budget_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_budget. Business justification: Prime cost reporting (food cost % + labor cost %) is the foundational P&L metric in foodservice operations. Linking food_cost_period directly to the corresponding labor_budget for the same unit and pe',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking to inventory.physical_count. Business justification: food_cost_period.physical_count_date is a DATE field that denotes when the physical count anchoring this periods food cost calculation occurred. Replacing it with a FK to physical_count.physical_coun',
    `employee_id` BIGINT COMMENT 'Identifier of the user who closed and finalized this food cost period. Typically a restaurant manager or accounting staff member.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each restaurant unit is a profit center; food cost reporting is the primary P&L metric tracked at profit center level. food_cost_period has cost_center_id but not profit_center_id — profit center is t',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit for which this food cost period is calculated. Links to the specific restaurant location.',
    `sales_report_id` BIGINT COMMENT 'Foreign key linking to franchise.sales_report. Business justification: Food cost percentage is calculated using sales revenue from the franchisees submitted sales report. Linking food_cost_period to the specific sales_report used as the revenue denominator enables audit',
    `tertiary_food_employee_id` BIGINT COMMENT 'Identifier of the user who closed and finalized this food cost period. Typically a restaurant manager or accounting staff member.',
    `unit_performance_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit_performance. Business justification: Period-end food cost reconciliation: food_cost_period records (actual_food_cost, cogs_percent_actual, waste_percent) are directly reconciled against the unit_performance record for the same fiscal per',
    `actual_food_cost` DECIMAL(18,2) COMMENT 'The actual Cost of Goods Sold (COGS) for the period, calculated as: Opening Inventory + Purchases + Transfers In - Transfers Out - Closing Inventory. The real food cost incurred.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual adjustments applied to the food cost calculation for the period, such as corrections for inventory errors, vendor credits, or accounting reclassifications. Positive or negative value.',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustment applied to the food cost calculation. Provides audit trail and justification for period adjustments.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period was reviewed and approved by management. Indicates final sign-off on the period results.',
    `beverage_sales_revenue` DECIMAL(18,2) COMMENT 'The total beverage sales revenue for the period. Tracked separately from food sales for category-specific cost analysis.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period was officially closed and calculations were finalized. Marks the completion of the period-close process.',
    `closing_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of food inventory on hand at the end of the period, determined by physical count or perpetual inventory system. Represents the ending stock value for COGS calculation.',
    `cogs_percent_actual` DECIMAL(18,2) COMMENT 'The actual food cost as a percentage of food sales revenue for the period. Key performance metric for restaurant profitability and cost control. Calculated as (Actual Food Cost / Food Sales Revenue) * 100.',
    `cogs_percent_theoretical` DECIMAL(18,2) COMMENT 'The theoretical food cost as a percentage of food sales revenue for the period. Represents the ideal COGS% if all operational standards were met. Calculated as (Theoretical Food Cost / Food Sales Revenue) * 100.',
    `count_method` STRING COMMENT 'The method used to determine closing inventory value: physical (manual count), perpetual (system-tracked), or hybrid (system with periodic physical verification).. Valid values are `physical|perpetual|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period record was first created in the system. Marks the initiation of the period tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record (e.g., USD, EUR, GBP). Supports multi-currency operations for international restaurant chains.. Valid values are `^[A-Z]{3}$`',
    `food_sales_revenue` DECIMAL(18,2) COMMENT 'The total food sales revenue (excluding beverage) for the period. Used as the denominator in COGS% calculations. Sourced from Point of Sale (POS) system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this food cost period record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-text notes or comments about this food cost period, such as unusual events, operational issues, inventory discrepancies, or explanations for variance. Used for management review and audit purposes.',
    `opening_inventory_value` DECIMAL(18,2) COMMENT 'The total dollar value of food inventory on hand at the beginning of the period. Represents the starting stock value for Cost of Goods Sold (COGS) calculation.',
    `period_end_date` DATE COMMENT 'The last date of the accounting period for which food costs are being calculated. Marks the close of the cost accumulation window.',
    `period_number` STRING COMMENT 'The accounting period identifier in format YYYY-PNN (e.g., 2024-P01 for period 1 of 2024). Used for financial reporting alignment.. Valid values are `^[0-9]{4}-P[0-9]{2}$`',
    `period_start_date` DATE COMMENT 'The first date of the accounting period for which food costs are being calculated. Marks the beginning of the cost accumulation window.',
    `period_status` STRING COMMENT 'The current status of the food cost period: open (still accepting transactions), closed (period ended, calculations complete), locked (finalized, no further changes allowed), or under_review (being audited or reviewed).. Valid values are `open|closed|locked|under_review`',
    `period_type` STRING COMMENT 'The frequency type of the accounting period for food cost calculation (weekly, bi-weekly, monthly, or quarterly).. Valid values are `weekly|bi-weekly|monthly|quarterly`',
    `purchases_value` DECIMAL(18,2) COMMENT 'The total dollar value of all food and beverage purchases received during the period. Includes all vendor invoices posted to inventory during the period.',
    `theoretical_food_cost` DECIMAL(18,2) COMMENT 'The calculated ideal food cost based on recipe costing and actual sales mix (PMIX). Represents what food cost should have been if all recipes were followed perfectly with no waste or theft.',
    `total_sales_revenue` DECIMAL(18,2) COMMENT 'The combined food and beverage sales revenue for the period. Represents total top-line revenue for the restaurant unit during the period.',
    `transfers_in_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory transferred into this restaurant unit from other locations during the period. Increases available inventory.',
    `transfers_out_value` DECIMAL(18,2) COMMENT 'The total dollar value of inventory transferred out of this restaurant unit to other locations during the period. Decreases available inventory.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The dollar difference between actual food cost and theoretical food cost (Actual - Theoretical). Positive variance indicates higher-than-expected costs due to waste, theft, portioning errors, or recipe non-compliance.',
    `variance_percent` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of theoretical food cost. Calculated as (Variance Amount / Theoretical Food Cost) * 100. Used to assess the magnitude of cost control issues.',
    `waste_percent` DECIMAL(18,2) COMMENT 'The waste value as a percentage of total food usage (Waste Value / (Actual Food Cost + Waste Value)) * 100. Key metric for food quality control and operational efficiency.',
    `waste_value` DECIMAL(18,2) COMMENT 'The total dollar value of food waste recorded during the period, including spoilage, expiration, preparation errors, and quality control discards. Tracked for Waste% calculation and food cost control.',
    CONSTRAINT pk_food_cost_period PRIMARY KEY(`food_cost_period_id`)
) COMMENT 'Period-level food cost summary record for each restaurant unit, capturing the calculated COGS% for a defined accounting period (weekly, bi-weekly, monthly). Captures period start date, period end date, opening inventory value ($), purchases value ($), transfers-in value ($), transfers-out value ($), waste value ($), closing inventory value ($), theoretical food cost ($), actual food cost ($), COGS% actual, COGS% theoretical, variance ($), and variance percentage. The operational food cost control record — NOT an analytics aggregate but the posted period-close record used by restaurant managers and finance.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`uom` (
    `uom_id` BIGINT COMMENT 'Unique identifier for the unit of measure. Primary key.',
    `base_uom_id` BIGINT COMMENT 'Reference to the base UOM for this measurement type. Used to establish conversion chains. Null if this UOM is itself the base unit.',
    `abbreviation` STRING COMMENT 'Short form or symbol for the UOM (e.g., lb, oz, gal, kg, g, ml). Used in compact displays, labels, and Kitchen Display System (KDS) screens.',
    `allows_fractional_quantities` BOOLEAN COMMENT 'Indicates whether fractional quantities are permitted for this UOM (e.g., 2.5 pounds allowed, but 2.5 cases may not be). Enforces business rules in inventory transactions and recipe scaling.',
    `allows_temperature_tracking` BOOLEAN COMMENT 'Indicates whether items measured in this UOM require Hazard Analysis Critical Control Points (HACCP) temperature monitoring during storage and transfer. Supports food safety compliance per Food and Drug Administration (FDA) regulations.',
    `applicable_item_categories` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) categories or commodity types where this UOM is applicable (e.g., dry goods, produce, dairy, beverages, proteins). Supports context-aware UOM selection in ordering and recipe management.',
    `conversion_factor_to_base` DECIMAL(18,2) COMMENT 'Multiplier to convert this UOM to the base UOM (e.g., 1 pound = 453.592 grams, so conversion_factor_to_base = 453.592). Critical for accurate Cost of Goods Sold (COGS%) calculation and yield management across ordering, storage, and recipe contexts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this UOM record was first created in the system. Supports audit trails and data lineage tracking per Generally Accepted Accounting Principles (GAAP) requirements.',
    `default_shelf_life_days` STRING COMMENT 'Default shelf life in days for items measured in this UOM. Used as a fallback when Stock Keeping Unit (SKU)-specific shelf life is not defined. Supports waste tracking (Waste%) and First In First Out (FIFO) rotation.',
    `display_sequence` STRING COMMENT 'Sort order for displaying UOMs in user interfaces and dropdown lists. Lower numbers appear first. Supports user experience optimization in Point of Sale (POS) and inventory management systems.',
    `effective_end_date` DATE COMMENT 'Date when this UOM was retired or deprecated. Null for currently active UOMs. Supports historical reporting and audit trails for Cost of Goods Sold (COGS%) analysis.',
    `effective_start_date` DATE COMMENT 'Date when this UOM became available for use in inventory transactions. Supports temporal validity and historical analysis of UOM changes.',
    `is_base_uom` BOOLEAN COMMENT 'Indicates whether this UOM is the base unit for its type (e.g., gram for weight, milliliter for volume). Base UOMs have a conversion factor of 1.0 and serve as the reference for all conversions within their type.',
    `is_system_standard` BOOLEAN COMMENT 'Indicates whether this UOM is a system-defined standard (e.g., gram, liter, each) that cannot be modified or deleted by users. Protects core reference data integrity.',
    `iso_code` STRING COMMENT 'ISO 80000 standard code for the unit of measure. Supports international operations and regulatory compliance across multiple jurisdictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this UOM record was last updated. Supports change tracking and data governance for Cost of Goods Sold (COGS%) accuracy and regulatory compliance.',
    `notes` STRING COMMENT 'Free-text field for additional context, usage guidelines, or special handling instructions for this UOM. Supports operational documentation and training materials.',
    `ordering_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used in purchase orders and vendor ordering (e.g., case, pallet). Supports procurement workflows and vendor catalog integration.',
    `plural_name` STRING COMMENT 'Plural form of the UOM name (e.g., Pounds, Ounces, Cases). Supports grammatically correct reporting and user interface text generation.',
    `precision_decimal_places` STRING COMMENT 'Number of decimal places to use when displaying or calculating quantities in this UOM. Ensures consistent rounding and precision across inventory transactions.',
    `recipe_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used in recipe Bill of Materials (BOM) and menu item costing (e.g., ounce, gram, tablespoon). Critical for accurate recipe yield management and menu engineering.',
    `requires_lot_tracking` BOOLEAN COMMENT 'Indicates whether items measured in this UOM require lot number and expiration date tracking for traceability. Supports food safety recalls and Good Manufacturing Practice (GMP) compliance.',
    `storage_uom_flag` BOOLEAN COMMENT 'Indicates whether this UOM is used for Back of House (BOH) inventory storage and stock tracking (e.g., each, bag, box). Supports Periodic Automatic Replenishment (PAR) level management and cycle counts.',
    `symbol` STRING COMMENT 'Standard international symbol for the UOM (e.g., °F, °C, %, #). Used in scientific and regulatory contexts, particularly for Hazard Analysis Critical Control Points (HACCP) temperature monitoring.',
    `un_cefact_code` STRING COMMENT 'Standardized UN/CEFACT Recommendation 20 code for the unit of measure. Supports Electronic Data Interchange (EDI) integration with suppliers and third-party logistics providers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `uom_category` STRING COMMENT 'Measurement system category (metric, imperial, count-based, or custom). Supports multi-region operations with different measurement standards.. Valid values are `metric|imperial|count|custom`',
    `uom_code` STRING COMMENT 'Short alphanumeric code representing the unit of measure (e.g., EA, CS, LB, OZ, GAL, KG, G, ML, L). Used as the business identifier in inventory transactions and recipe management.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `uom_name` STRING COMMENT 'Full descriptive name of the unit of measure (e.g., Each, Case, Pound, Ounce, Gallon, Kilogram, Gram, Milliliter, Liter). Human-readable label for reporting and user interfaces.',
    `uom_status` STRING COMMENT 'Current lifecycle status of the UOM. Active UOMs are available for use in transactions; deprecated UOMs are retained for historical data but not available for new transactions.. Valid values are `active|inactive|deprecated|pending`',
    `uom_type` STRING COMMENT 'Classification of the unit of measure by dimension type. Determines conversion logic and applicability to different inventory contexts (receiving, storage, recipe). [ENUM-REF-CANDIDATE: weight|volume|count|length|area|temperature|time — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_uom PRIMARY KEY(`uom_id`)
) COMMENT 'Reference master for all units of measure used in inventory transactions — ordering UOM, storage UOM, and recipe UOM — plus their conversion factors. Captures UOM code, UOM name, UOM type (weight/volume/count/length), base UOM flag, and applicable item categories. Conversion detail: from-UOM, to-UOM, stock-item-specific overrides (item-specific conversions override global defaults), conversion factor, effective date, and source (vendor spec/lab measurement/standard). Supports accurate translation between ordering (case of 6), storage (each), and recipe (ounce/gram) contexts — critical for inventory valuation and COGS% calculation across all restaurant units.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Unique identifier for the vendor item mapping record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps vendor items to expense GL accounts for automated AP posting and cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor item master management is a named procurement process: a purchasing/category manager employee owns each vendor item record, negotiating pricing and preferred vendor status. Foodservice procurem',
    `uom_id` BIGINT COMMENT 'Foreign key linking to inventory.uom. Business justification: vendor_item.order_uom is a STRING column denoting the unit of measure used when ordering from this vendor. The uom table is the authoritative UOM reference master. Adding order_uom_id FK (prefixed or',
    `stock_item_id` BIGINT COMMENT 'Reference to the stock item (SKU) in the inventory master that this vendor supplies.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: REQUIRED: Procurement audit needs to know which supplier contract governs each vendor‑supplied item for pricing and compliance.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Vendor item master management requires a direct supplier reference independent of contract status. Prospective or contract-free suppliers must be linkable to their catalog items for vendor qualificati',
    `activation_date` DATE COMMENT 'The date when this vendor item mapping became active and available for ordering.',
    `contract_effective_date` DATE COMMENT 'The date when the contract pricing becomes effective for this vendor item.',
    `contract_expiration_date` DATE COMMENT 'The date when the contract pricing expires for this vendor item.',
    `contract_number` STRING COMMENT 'Reference number of the procurement contract governing this vendor item pricing, if applicable.',
    `contract_price_flag` BOOLEAN COMMENT 'Indicates whether the unit cost is based on a negotiated contract (True) or spot pricing (False).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. [ENUM-REF-CANDIDATE: USD|CAD|EUR|GBP|MXN|AUD|JPY|CNY — 8 candidates stripped; promote to reference product]',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where this item is produced or sourced by the vendor. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|BRA|ARG|AUS|NZL|GBR|FRA|DEU|ITA|ESP|JPN|KOR|THA|VNM|IND — 18 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor item mapping record was first created in the system.',
    `deactivation_date` DATE COMMENT 'The date when this vendor item mapping was deactivated or discontinued, if applicable.',
    `deactivation_reason` STRING COMMENT 'Business reason for deactivating this vendor item mapping (e.g., vendor discontinued, better pricing found, quality issues).',
    `gtin` STRING COMMENT 'The vendors GTIN/UPC/EAN barcode for this item, used for receiving and inventory tracking.',
    `last_cost_update_date` DATE COMMENT 'The date when the unit cost for this vendor item was last updated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor item mapping record was most recently updated.',
    `last_order_date` DATE COMMENT 'The most recent date when this item was ordered from this vendor.',
    `last_received_date` DATE COMMENT 'The most recent date when this item was received from this vendor.',
    `lead_time_days` STRING COMMENT 'The number of days between order placement and expected delivery from this vendor for this item.',
    `manufacturer_name` STRING COMMENT 'The name of the actual manufacturer of this item, which may differ from the vendor/distributor.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers unique part or item number for this product.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity (in order UOM) that must be ordered from this vendor for this item.',
    `next_cost_review_date` DATE COMMENT 'The scheduled date for the next cost review or renegotiation with this vendor for this item.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or vendor-specific requirements for this item.',
    `on_time_delivery_percent` DECIMAL(18,2) COMMENT 'Percentage of orders for this vendor item that were delivered within the promised lead time window.',
    `order_increment` DECIMAL(18,2) COMMENT 'The quantity increment (in order UOM) in which this item must be ordered (e.g., must order in multiples of 5).',
    `pack_quantity` DECIMAL(18,2) COMMENT 'The number of individual packs or units contained in one order UOM (e.g., 12 cans per case, 4 bags per box).',
    `pack_size` STRING COMMENT 'The size or weight of each individual pack or unit within the order UOM (e.g., 5 LB, 12 OZ, 1 GAL).',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred supplier for this stock item (True) or an alternate source (False).',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality score for this vendors supply of this item, typically on a scale of 0.00 to 5.00, based on receiving inspections and quality audits.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The current cost per order UOM from this vendor. Used for purchase order generation and COGS calculation.',
    `vendor_brand_name` STRING COMMENT 'The brand name under which the vendor supplies this item, if applicable.',
    `vendor_item_description` STRING COMMENT 'Detailed description of the item from the vendors catalog, including specifications, grade, or quality attributes.',
    `vendor_item_name` STRING COMMENT 'The suppliers product name or description for this item as it appears in their catalog.',
    `vendor_item_status` STRING COMMENT 'Current status of this vendor item mapping in the system lifecycle.. Valid values are `active|inactive|discontinued|pending|suspended`',
    `vendor_priority_rank` STRING COMMENT 'Numeric ranking of this vendor for this item when multiple vendors supply the same SKU (1=first choice, 2=second choice, etc.).',
    `vendor_product_category` STRING COMMENT 'The vendors classification or category for this item in their catalog structure.',
    `vendor_sku` STRING COMMENT 'The suppliers unique item code or SKU for this product. Used in purchase orders and receiving documents.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Maps each stock item to the supplier(s) that provide it, capturing the supplier-specific item details used in ordering and receiving. Captures supplier reference, stock item reference, supplier item code (vendor SKU), supplier item description, order UOM, pack size, pack quantity, current unit cost, contract price flag, lead time days, minimum order quantity, preferred vendor flag, and active status. Enables multi-vendor sourcing for critical items and supports cost comparison and replenishment order generation. Distinct from the procurement domains supplier master — this is the inventory-domain view of what each vendor supplies.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`inventory`.`physical_count_line` (
    `physical_count_line_id` BIGINT COMMENT 'Primary key for the physical_count_line association',
    `physical_count_id` BIGINT COMMENT 'Foreign key linking this count line to its parent physical count event header.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking this count line to the specific SKU being counted.',
    `count_uom` STRING COMMENT 'The unit of measure used by the counting team for this SKU during this count event (e.g., each, case, lb). May differ from the stock items standard UOM and is specific to this count line.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The physical quantity of this SKU observed and recorded by the counting team during the count event. Belongs to the line, not the header or the stock item master.',
    `expiration_date` DATE COMMENT 'The expiration or use-by date of the lot being counted. Captured at count time to support FIFO rotation compliance and waste tracking. Belongs to the count line.',
    `lot_number` STRING COMMENT 'The supplier or internal lot identifier for the batch of this SKU being counted. Required for lot-level traceability and HACCP compliance. Belongs to the count line, not the stock item master.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether this specific SKU line requires a recount due to excessive variance or counting error. This is a per-SKU-per-count flag that belongs to the line, not the count header.',
    `system_quantity` DECIMAL(18,2) COMMENT 'The inventory systems expected on-hand quantity for this SKU at the time of the count event. Captured at count time and belongs to this specific count line, not the stock item master.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted_quantity and system_quantity for this SKU in this count event. Positive indicates overage; negative indicates shortage.',
    `variance_value` DECIMAL(18,2) COMMENT 'The dollar value of the variance for this SKU line, calculated as variance_quantity multiplied by the unit cost at count time. Feeds period-end COGS% and GL journal entry.',
    CONSTRAINT pk_physical_count_line PRIMARY KEY(`physical_count_line_id`)
) COMMENT 'This association product represents the line-level Event between physical_count and stock_item in restaurant inventory operations. It captures the per-SKU count result for each physical inventory count event, including the counted quantity, system (book) quantity, variance, lot and expiration data, and recount disposition. Each record links one physical_count event to one stock_item and carries the operational data required for COGS% analysis, MarketMan reconciliation, variance investigation workflows, and period-end food cost reporting. Without this entity, the model cannot represent per-SKU variance, recount flags, or lot-level count data.. Existence Justification: A physical inventory count in foodservice operations produces one count line per SKU per storage location — a physical_count event covers many stock_items, and each stock_item appears across many physical_count events over time. This line-level detail (counted_quantity, system_quantity, variance_quantity, variance_value, recount_required_flag) is the operational record that drives COGS% reporting, MarketMan reconciliation, and variance investigation workflows. The relationship is universally recognized in foodservice inventory management as a physical_count_line or count_detail — a first-class operational entity that humans create, review, and act upon.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `restaurants_ecm`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `restaurants_ecm`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `restaurants_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_recount_of_count_id` FOREIGN KEY (`recount_of_count_id`) REFERENCES `restaurants_ecm`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_stock_location_id` FOREIGN KEY (`origin_stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `restaurants_ecm`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_reversal_adjustment_inventory_adjustment_id` FOREIGN KEY (`reversal_adjustment_inventory_adjustment_id`) REFERENCES `restaurants_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_waste_log_id` FOREIGN KEY (`waste_log_id`) REFERENCES `restaurants_ecm`.`inventory`.`waste_log`(`waste_log_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `restaurants_ecm`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ADD CONSTRAINT `fk_inventory_uom_base_uom_id` FOREIGN KEY (`base_uom_id`) REFERENCES `restaurants_ecm`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `restaurants_ecm`.`inventory`.`uom`(`uom_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ADD CONSTRAINT `fk_inventory_physical_count_line_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `restaurants_ecm`.`inventory`.`physical_count`(`physical_count_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ADD CONSTRAINT `fk_inventory_physical_count_line_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `restaurants_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Eggs');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Fish');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Milk');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Peanuts');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Shellfish');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Soybeans');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Tree Nuts');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen - Wheat');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `haccp_max_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Maximum Temperature Fahrenheit');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `haccp_min_temp_f` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Minimum Temperature Fahrenheit');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Is Gluten Free');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_gmo_free` SET TAGS ('dbx_business_glossary_term' = 'Is Genetically Modified Organism (GMO) Free');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Is Halal');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Is Kosher');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Is Organic');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Is Vegan');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Is Vegetarian');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `storage_class` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `access_control_required` SET TAGS ('dbx_business_glossary_term' = 'Access Control Required');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `allows_receiving` SET TAGS ('dbx_business_glossary_term' = 'Allows Receiving');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `allows_transfers` SET TAGS ('dbx_business_glossary_term' = 'Allows Transfers');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `allows_waste_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Waste Tracking');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `bin_count` SET TAGS ('dbx_business_glossary_term' = 'Bin Count');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Cubic Feet)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'refrigerated|frozen|ambient|bar|prep_area|service_station');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `par_level_enabled` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level Enabled');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `primary_commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `requires_haccp_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Requires HACCP (Hazard Analysis Critical Control Points) Monitoring');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'open|restricted|locked|high_value');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `stock_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Area Type (Back of House / Front of House)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `storage_area_type` SET TAGS ('dbx_value_regex' = 'boh|foh');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Maximum (Fahrenheit)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `target_temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Minimum (Fahrenheit)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `temperature_monitoring_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Frequency (Hours)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'freezer|cooler|ambient|controlled');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `on_hand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Balance Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|AUD');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `days_until_expiration` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiration');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Inventory Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `extended_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantined|expired|damaged|in_transit');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Is Perishable Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MarketMan|SAP_MM|manual_count|POS_integration');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|standard_cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Periodic Automatic Replenishment (PAR) Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Manager Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `days_variance` SET TAGS ('dbx_business_glossary_term' = 'Delivery Days Variance');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `delivery_timeliness` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timeliness');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `delivery_timeliness` SET TAGS ('dbx_value_regex' = 'on_time|early|late');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Inventory Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `posted_to_inventory_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to Inventory Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional|not_inspected');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_number` SET TAGS ('dbx_value_regex' = '^RCV-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|rejected|disputed');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `seal_integrity_check` SET TAGS ('dbx_business_glossary_term' = 'Seal Integrity Check');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `seal_integrity_check` SET TAGS ('dbx_value_regex' = 'intact|broken|not_applicable');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'marketman|sap_mm|manual_entry');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `temperature_check_result` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Result');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `temperature_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `temperature_recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `total_items_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Items Ordered');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `total_items_received` SET TAGS ('dbx_business_glossary_term' = 'Total Items Received');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `total_received_value` SET TAGS ('dbx_business_glossary_term' = 'Total Received Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `total_received_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ALTER COLUMN `variance_reason` SET TAGS ('dbx_value_regex' = 'short_shipment|damaged_goods|wrong_item|quality_issue|overage|none');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'GL (General Ledger) Journal Entry ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `recount_of_count_id` SET TAGS ('dbx_business_glossary_term' = 'Recount Of Count ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|barcode-scan|rfid|hybrid');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^PC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_business_glossary_term' = 'Count Period (Daypart)');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night|overnight|full-day');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|submitted|approved|posted|cancelled');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|spot-check|cycle-count|pre-close|post-close|opening');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `is_period_end_count` SET TAGS ('dbx_business_glossary_term' = 'Is Period End Count Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `physical_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `posted_to_gl_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted to GL (General Ledger) Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MarketMan|SAP|Manual|Mobile-App');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'System Inventory Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `system_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_sku_counted` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) Counted');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_sku_with_variance` SET TAGS ('dbx_business_glossary_term' = 'Total SKU (Stock Keeping Unit) With Variance');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Percentage (Waste%)');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `total_variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Foodsafety Corrective Action Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `maintenance_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late-night');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'trash|compost|donation|rendering|other');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `haccp_violation` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Violation Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `manager_approved` SET TAGS ('dbx_business_glossary_term' = 'Manager Approved Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `on_hand_quantity_before_waste` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Waste');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `par_level_at_waste` SET TAGS ('dbx_business_glossary_term' = 'PAR (Periodic Automatic Replenishment) Level at Waste');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `responsible_station` SET TAGS ('dbx_business_glossary_term' = 'Responsible Station');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `responsible_station` SET TAGS ('dbx_value_regex' = 'BOH|FOH');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `temperature_at_waste` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Waste (Fahrenheit)');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|overproduction|prep-loss|expiration|quality-reject|theft-unknown');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_prevention_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Waste Prevention Opportunity');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason Description');
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Stock Location ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `origin_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `origin_stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Stock Location ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `tertiary_stock_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `external_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'External Transfer ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P(0[1-9]|1[0-3])$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `haccp_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Monitoring Required Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|emergency');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|passed|failed|conditional-accept');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'internal-delivery|courier|third-party|self-pickup|direct-transfer');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MARKETMAN|SAP-MM|MANUAL|LEGACY');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Required');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi-temp');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `total_quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Transferred');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `total_transfer_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Value (USD)');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approval Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^STR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_value_regex' = 'par-replenishment|excess-stock|expiring-soon|quality-issue|menu-change|seasonal-adjustment');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Received Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_request_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Request Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Ship Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'inter-unit|intra-unit|return-to-dc|return-to-vendor|emergency|rebalance');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ALTER COLUMN `variance_reason` SET TAGS ('dbx_value_regex' = 'damage-in-transit|short-shipment|overage|quality-rejection|counting-error|none');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `primary_replenishment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `primary_replenishment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `primary_replenishment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `quaternary_replenishment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `receiving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tertiary_replenishment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^RO-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'marketman_auto|manager_manual|pos_integration|erp_mrp|mobile_app|third_party_api');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'auto_par|manual|emergency|scheduled|spot');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_fee` SET TAGS ('dbx_business_glossary_term' = 'Shipping Fee');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|supplier_truck|third_party_carrier|will_call');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Order Reference');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `primary_inventory_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Related Physical Count ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `reversal_adjustment_inventory_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Adjustment ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto-approved');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `impacts_cogs` SET TAGS ('dbx_business_glossary_term' = 'Impacts Cost of Goods Sold (COGS) Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Is Reversed Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `is_shrinkage` SET TAGS ('dbx_business_glossary_term' = 'Is Shrinkage Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity After Adjustment');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `on_hand_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity Before Adjustment');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `temperature_at_adjustment_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Adjustment (Fahrenheit)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'operational waste|spoilage|theft|damage|other');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Period ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `labor_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `tertiary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `unit_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Performance Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `actual_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Food Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Approved Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `beverage_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Beverage Sales Revenue');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Closed Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `closing_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Closing Inventory Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage Actual');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `cogs_percent_theoretical` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage Theoretical');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Count Method');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'physical|perpetual|hybrid');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `food_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food Sales Revenue');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `opening_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Opening Inventory Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-P[0-9]{2}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|locked|under_review');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|monthly|quarterly');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `purchases_value` SET TAGS ('dbx_business_glossary_term' = 'Purchases Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `theoretical_food_cost` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Food Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `total_sales_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Revenue');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_in_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers In Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `transfers_out_value` SET TAGS ('dbx_business_glossary_term' = 'Transfers Out Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage (Waste%)');
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ALTER COLUMN `waste_value` SET TAGS ('dbx_business_glossary_term' = 'Waste Value');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `base_uom_id` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM) ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Abbreviation');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `allows_fractional_quantities` SET TAGS ('dbx_business_glossary_term' = 'Allows Fractional Quantities Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `allows_temperature_tracking` SET TAGS ('dbx_business_glossary_term' = 'Allows Temperature Tracking Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `applicable_item_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Item Categories');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `conversion_factor_to_base` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor to Base Unit of Measure (UOM)');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `default_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Default Shelf Life Days');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `is_base_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Base Unit of Measure (UOM) Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `is_system_standard` SET TAGS ('dbx_business_glossary_term' = 'Is System Standard Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `iso_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `ordering_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Ordering Unit of Measure (UOM) Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `plural_name` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Plural Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `precision_decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Precision Decimal Places');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `recipe_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Recipe Unit of Measure (UOM) Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `requires_lot_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Lot Tracking Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `storage_uom_flag` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit of Measure (UOM) Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Symbol');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `un_cefact_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Centre for Trade Facilitation and Electronic Business (UN/CEFACT) Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `un_cefact_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_category` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_category` SET TAGS ('dbx_value_regex' = 'metric|imperial|count|custom');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_name` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_status` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `restaurants_ecm`.`inventory`.`uom` ALTER COLUMN `uom_type` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Type');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Managed By Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Order Uom Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item ID');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `contract_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `next_cost_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Cost Review Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Percentage');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `order_increment` SET TAGS ('dbx_business_glossary_term' = 'Order Increment');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pack Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Brand Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Name');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|suspended');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Vendor Priority Rank');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_product_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Product Category');
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ALTER COLUMN `vendor_sku` SET TAGS ('dbx_business_glossary_term' = 'Vendor Stock Keeping Unit (SKU)');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` SET TAGS ('dbx_association_edges' = 'inventory.physical_count,inventory.stock_item');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `physical_count_line_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Physical Count Line Id');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Physical Count Id');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Line - Stock Item Id');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `count_uom` SET TAGS ('dbx_business_glossary_term' = 'Count Unit of Measure');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System (Book) Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count_line` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
