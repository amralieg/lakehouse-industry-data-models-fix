-- Schema for Domain: inventory | Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`inventory` COMMENT 'Inventory management for raw materials, components, WIP (Work in Progress), finished goods, and service parts across plants, warehouses, and dealer networks. Manages stock levels, inventory movements, cycle counting, MRP (Material Requirements Planning) execution, and SKU master data. Tracks inventory accuracy, turnover rates, obsolescence, and safety stock levels. Includes warehouse management (SAP WM), lot traceability, and serialized inventory for high-value components (ECU, batteries).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`sku_master` (
    `sku_master_id` BIGINT COMMENT 'Unique surrogate key for each SKU master record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory valuation account assignment. Every SKU in automotive manufacturing requires a GL account for financial posting of inventory transactions (receipts, issues, revaluations). Standard SAP/ERP p',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.material_specification. Business justification: Each automotive SKU must conform to an approved engineering material specification for REACH/RoHS compliance and supplier qualification. Direct FK enables automated compliance verification during rece',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Required for traceability report linking engineering part definitions to inventory SKUs for production planning and cost tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory mapping: each part must satisfy specific regulatory requirements for reporting and certification.',
    `country_of_origin` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country where the SKU was manufactured.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the SKU master record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for price fields.. Valid values are `^[A-Z]{3}$`',
    `customs_tariff_code` STRING COMMENT 'HS or tariff code used for import/export compliance.',
    `ean13` STRING COMMENT '13‑digit European Article Number for the SKU.. Valid values are `^d{13}$`',
    `effective_from` DATE COMMENT 'Date from which the SKU definition is valid.',
    `effective_until` DATE COMMENT 'Date until which the SKU definition remains valid; null if indefinite.',
    `expiration_date` DATE COMMENT 'Date after which the SKU is considered expired.',
    `hazardous_class` STRING COMMENT 'Regulatory hazard class (e.g., Class 1, Class 2) for the SKU.',
    `hazardous_flag` BOOLEAN COMMENT 'Indicates whether the SKU is classified as hazardous under regulatory standards.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the SKU in centimeters.',
    `last_price` DECIMAL(18,2) COMMENT 'Most recent purchase price recorded for the SKU.',
    `lead_time_days` STRING COMMENT 'Planned number of days from order to receipt of the SKU.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the SKU in centimeters.',
    `lot_controlled_flag` BOOLEAN COMMENT 'True if inventory of the SKU is managed by lot numbers.',
    `material_group` STRING COMMENT 'Grouping used for reporting and analysis of similar SKUs.',
    `material_type` STRING COMMENT 'Technical classification of the SKU (e.g., RAW, HALB, FERT).',
    `max_order_qty` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered in a single transaction.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered for the SKU.',
    `mrp_controller` STRING COMMENT 'Responsible planner or group for the SKUs MRP.',
    `mrp_type` STRING COMMENT 'Material Requirements Planning type that controls how the SKU is planned.. Valid values are `PD|VB|FO|... `',
    `procurement_type` STRING COMMENT 'Indicates whether the SKU is externally procured (E), internally produced (I), or mixed (M).. Valid values are `E|I|M`',
    `product_category` STRING COMMENT 'High‑level classification of the SKU (e.g., Engine, Body, Electrical).',
    `product_subcategory` STRING COMMENT 'Secondary classification within the product category.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum inventory level to protect against demand variability.',
    `serial_controlled_flag` BOOLEAN COMMENT 'True if each unit of the SKU is tracked by a unique serial number.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the SKU can be stored before it expires.',
    `sku_code` STRING COMMENT 'Business identifier used across the enterprise to reference the SKU.',
    `sku_master_description` STRING COMMENT 'Detailed textual description of the SKU, including functional characteristics.',
    `sku_master_status` STRING COMMENT 'Current lifecycle status of the SKU.. Valid values are `active|inactive|discontinued|pending`',
    `sku_name` STRING COMMENT 'Human‑readable name or title of the SKU.',
    `standard_price` DECIMAL(18,2) COMMENT 'Default price used for cost calculations and standard costing.',
    `tax_indicator` BOOLEAN COMMENT 'True if the SKU is subject to tax.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for inventory transactions of the SKU.. Valid values are `EA|KG|L|M|CM|MM`',
    `upc` STRING COMMENT '12‑digit Universal Product Code for the SKU.. Valid values are `^d{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the SKU master record.',
    `valuation_class` STRING COMMENT 'Key used for accounting valuation of the SKU.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume occupied by one unit of the SKU.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single unit of the SKU in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the SKU in centimeters.',
    CONSTRAINT pk_sku_master PRIMARY KEY(`sku_master_id`)
) COMMENT 'SSOT for all Stock Keeping Unit (SKU) definitions across the enterprise. Owns the material master record for raw materials, production components, WIP sub-assemblies, finished vehicles, and service parts. Aligned with SAP MM material master (MARA/MARC). Captures SKU identity, classification, unit of measure, weight/dimensions, hazardous material flags, shelf-life, and MRP planning parameters. Referenced by all inventory movement and stock transactions.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique surrogate key for the storage location.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warehouse cost allocation. Storage locations (warehouses, yards) in automotive plants are assigned to cost centers for overhead allocation, labor cost tracking, and operational expense reporting. Esse',
    `plant_id` BIGINT COMMENT 'Identifier of the plant to which the location belongs.',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building).',
    `agv_routing_priority` STRING COMMENT 'Priority used by automated guided vehicles when selecting this location.',
    `aisle` STRING COMMENT 'Aisle designation within the zone.',
    `bin` STRING COMMENT 'Specific bin or shelf code for inventory placement.',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum amount of material the location can hold.',
    `capacity_uom` STRING COMMENT 'Unit of measure for capacity (e.g., kg, m3, units).',
    `city` STRING COMMENT 'City where the location is situated.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the location.. Valid values are `USA|CAN|MEX|DEU|FRA|GBR`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the location became active for inventory.',
    `effective_until` DATE COMMENT 'Date when the location is scheduled to be retired (null if indefinite).',
    `external_system_source` STRING COMMENT 'Source system that provides the master data for this location.. Valid values are `SAP_WM|Oracle_WMS|Custom`',
    `fire_safety_rating` STRING COMMENT 'Fire‑safety classification of the location.. Valid values are `A|B|C|D`',
    `hazardous_material_allowed` BOOLEAN COMMENT 'True if hazardous parts may be stored in this location.',
    `inventory_accuracy_percent` DECIMAL(18,2) COMMENT 'Measured accuracy of inventory records for this location.',
    `is_default_location` BOOLEAN COMMENT 'Indicates if this is the default location for new stock of its type.',
    `last_inventory_count_date` DATE COMMENT 'Date of the most recent physical inventory count.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location.',
    `location_code` STRING COMMENT 'External code used in ERP/WMS to identify the location.',
    `location_name` STRING COMMENT 'Human‑readable name of the storage location.',
    `location_type` STRING COMMENT 'Category describing the physical storage configuration.. Valid values are `bulk|rack|floor|cold_chain|automated|quarantine`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location.',
    `rack` STRING COMMENT 'Rack identifier where the bin is located.',
    `state` STRING COMMENT 'State or province of the location.',
    `storage_location_description` STRING COMMENT 'Free‑form description or notes about the location.',
    `storage_location_status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|maintenance|closed`',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the location is climate‑controlled.',
    `temperature_range_celsius` STRING COMMENT 'Allowed temperature range for the location (e.g., "0-5").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `used_capacity_percentage` DECIMAL(18,2) COMMENT 'Current utilization of the location expressed as a percentage of total capacity.',
    `zone` STRING COMMENT 'Logical zone within the warehouse (e.g., receiving, bulk, cold).',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record for all physical and logical storage locations within plants, warehouses, distribution centers, and dealer parts depots. Captures location hierarchy (plant → warehouse → storage type → storage bin), location type (bulk, rack, floor, cold-chain), capacity constraints, and WM (Warehouse Management) configuration. Aligned with SAP WM storage location and bin master. Enables precise bin-level inventory tracking and AGV routing.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`stock_balance` (
    `stock_balance_id` BIGINT COMMENT 'System-generated unique identifier for each stock balance record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity inventory ownership. Stock balances must be assigned to company code for consolidated financial reporting, intercompany stock transfers, and legal entity-level inventory valuation. Requir',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Stock balance valuation amounts must be posted to a GL account for financial statements.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: stock_balance records inventory per SKU; linking to sku_master provides authoritative SKU attributes and removes redundant material_number.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: stock_balance also references a storage location; adding storage_location_id FK normalizes location data.',
    `batch_number` STRING COMMENT 'Identifier of the production batch when batch management is active.',
    `blocked_stock_qty` BIGINT COMMENT 'Quantity that is blocked due to quality or administrative reasons.',
    `consignment_stock_qty` BIGINT COMMENT 'Quantity owned by a supplier but stored at the plant.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the valuation price.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `expiration_date` DATE COMMENT 'Date after which the material is considered expired or unusable.',
    `goods_movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the transaction (e.g., receipt, issue, transfer).. Valid values are `101|102|201|202|301|311`',
    `in_transit_stock_qty` BIGINT COMMENT 'Quantity that is currently being transferred between locations.',
    `is_serialized` BOOLEAN COMMENT 'Indicates whether the material is managed at the serial number level.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent goods movement affecting this stock record.',
    `lifecycle_status` STRING COMMENT 'Current status of the stock quantity (e.g., unrestricted, blocked).. Valid values are `unrestricted|quality_inspection|blocked|consignment|in_transit|safety`',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the material.',
    `manufacturing_date` DATE COMMENT 'Date the material was produced or assembled.',
    `physical_location_hierarchy` STRING COMMENT 'Concatenated path representing plant, warehouse, aisle, and bin (e.g., PL01/WH02/AIS03/BIN04).',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or site where the stock is held.',
    `purchase_order_number` STRING COMMENT 'Most recent purchase order that affected the stock balance.',
    `quality_inspection_stock_qty` BIGINT COMMENT 'Quantity currently under quality inspection.',
    `quality_status` STRING COMMENT 'Result of the latest quality inspection for the stock batch.. Valid values are `passed|failed|pending`',
    `quantity_on_hand` BIGINT COMMENT 'Total physical quantity of the material available at the location.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the stock balance record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stock balance record.',
    `safety_stock_qty` BIGINT COMMENT 'Reserved quantity to protect against demand variability.',
    `serial_number` STRING COMMENT 'Serial number of the individual unit when serialization is enabled.',
    `stock_category` STRING COMMENT 'Broad classification of the stock for reporting (e.g., raw material, finished good).. Valid values are `raw_material|component|finished_good|service_part|spare_part`',
    `supplier_code` STRING COMMENT 'Code of the primary supplier for the material.',
    `unit_of_measure` STRING COMMENT 'Unit in which the stock quantity is measured (e.g., EA, KG, L).',
    `unrestricted_stock_qty` BIGINT COMMENT 'Quantity that is free for use or sale.',
    `valuation_area_code` STRING COMMENT 'Accounting valuation area for inventory valuation purposes.',
    `valuation_price` DECIMAL(18,2) COMMENT 'Monetary value per unit for the material based on the valuation type.',
    `valuation_type` STRING COMMENT 'Method used for inventory valuation.. Valid values are `standard|moving_average|fifo|lifo`',
    CONSTRAINT pk_stock_balance PRIMARY KEY(`stock_balance_id`)
) COMMENT 'Current on-hand stock balance snapshot for each SKU at each storage location, plant, and valuation area. Captures unrestricted stock, quality inspection stock, blocked stock, consignment stock, in-transit stock, and safety stock levels. Aligned with SAP MM stock overview (MMBE / MARD). Supports MRP execution, inventory turnover analysis, and obsolescence monitoring. Updated by every goods movement transaction.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`goods_movement` (
    `goods_movement_id` BIGINT COMMENT 'Unique identifier for each goods movement transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods movement postings require a cost‑center for internal cost allocation; finance cost_center is the authoritative source for reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Period assignment for goods movements. Every inventory transaction must be assigned to fiscal period for period-end closing, cutoff control, and financial reporting. Essential for month-end/year-end i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Direct posting account for goods movement. Each movement type (goods receipt, issue, scrap, transfer) posts to specific GL accounts for inventory accounting. Required for real-time financial integrati',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: Goods movements for supplier parts need inbound_part reference for supplier-specific cost, lead time, and PPAP status. Enables supplier part number traceability and purchase price variance analysis at',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Goods receipt movements originate from inbound shipments. Links enable supplier quality traceability, customs documentation reconciliation, receiving variance analysis, and ASN-to-GR matching for supp',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods receipts trigger quality inspection (QI stock in SAP 101 movement type). GR documents reference inspection lot numbers for quality-gated movements. Enables traceability from material receipt to ',
    `part_master_id` BIGINT COMMENT 'Identifier of the material or component being moved.',
    `party_id` BIGINT COMMENT 'Identifier of the customer for goods issue movements.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order linked to the movement.',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall-driven goods movements require campaign traceability for NHTSA/Transport Canada reporting, segregation compliance, and audit trails. Enables tracking which movements were executed to quarantine',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: Goods movements can be the physical inventory transaction that fulfills a replenishment order (e.g., a goods receipt posting that satisfies the replenishment demand). Adding replenishment_order_id FK ',
    `reversal_of_movement_goods_movement_id` BIGINT COMMENT 'Identifier of the original goods movement that this record reverses.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Every goods movement event (GR, GI, transfer) is for a specific SKU. goods_movement currently carries material_number (STRING) as a denormalized SKU reference. Adding sku_master_id FK normalizes this ',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Normalize source storage location reference; replace string with FK to storage_location',
    `stock_transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_transfer_order. Business justification: Goods movements are the physical execution records generated when a stock transfer order is carried out. goods_movement has reference_document_number and reference_document_type (STRING) as denormaliz',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Goods movements (material issues to production) are posted against specific work centers for activity-based cost allocation and work-center-level consumption reporting. This is a standard SAP MM-PP in',
    `amount_local` DECIMAL(18,2) COMMENT 'Value of the movement in the plants local currency.',
    `amount_usd` DECIMAL(18,2) COMMENT 'Value of the movement converted to US dollars for consolidated reporting.',
    `base_uom` STRING COMMENT 'Unit of measure associated with the quantity field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods movement record was initially created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `delivery_note_number` STRING COMMENT 'Delivery document number for goods issue movements.',
    `destination_plant` STRING COMMENT 'Plant receiving the material.',
    `destination_storage_location` STRING COMMENT 'Storage location in the destination plant where the material is placed.',
    `goods_movement_status` STRING COMMENT 'Current status of the goods movement record.. Valid values are `posted|reversed|pending`',
    `is_automated` BOOLEAN COMMENT 'True if the movement was performed automatically by a system (e.g., AGV).',
    `is_lot_tracked` BOOLEAN COMMENT 'True if the material is tracked by lot.',
    `is_serial_tracked` BOOLEAN COMMENT 'True if the material is tracked by serial number.',
    `line_sequence` STRING COMMENT 'Ordering number of this line within the goods movement document.',
    `location_zone` STRING COMMENT 'Specific zone or area within the warehouse for the storage location.',
    `lot_number` STRING COMMENT 'Lot number used for traceability of batch‑controlled items.',
    `movement_reason` STRING COMMENT 'Business reason prompting the inventory movement.. Valid values are `Production|Sales|Repair|Scrap|Transfer`',
    `posting_date` DATE COMMENT 'Calendar date on which the goods movement was posted.',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the movement was posted.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material moved, expressed in the base unit of measure.',
    `reference_document_number` STRING COMMENT 'Number of the source document that triggered the movement, such as purchase order or production order.',
    `reference_document_type` STRING COMMENT 'Type of the reference document (Purchase Order, Production Order, Work Order, Delivery, Service Order).. Valid values are `PO|PR|WO|DO|SA`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this record represents a reversal of a previous movement.',
    `source_plant` STRING COMMENT 'Plant where the material originated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `valuation_type` STRING COMMENT 'Inventory valuation method used for this movement.. Valid values are `Standard|MovingAverage|FIFO|LIFO`',
    `warehouse_number` STRING COMMENT 'Identifier of the warehouse where the movement occurs.',
    CONSTRAINT pk_goods_movement PRIMARY KEY(`goods_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts (GR), goods issues (GI), stock transfers, returns, and scrapping. Aligned with SAP MM material document (MSEG/MKPF). Captures movement type, quantity, source and destination storage locations, reference document (purchase order, production order, delivery), posting date, and batch/serial number. Provides full audit trail for lot traceability and IATF 16949 compliance.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` (
    `stock_transfer_order_id` BIGINT COMMENT 'Unique identifier for the stock transfer order.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant receiving the stock.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: Stock transfer orders are frequently created to physically execute replenishment orders — the replenishment_order is the demand signal and the stock_transfer_order is the warehouse execution instructi',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: A stock transfer order governs the physical movement of a specific SKU between storage locations. stock_transfer_order currently carries material_number (STRING) and material_description (STRING) as d',
    `source_plant_id` BIGINT COMMENT 'Identifier of the plant where stock is sourced.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: A stock transfer order moves stock FROM a source storage location TO a destination storage location. While stock_transfer_order already has source_plant_id (cross-domain to manufacturing.plant), it la',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Transfer order creation is driven by a vehicle order; linking them supports the Transfer Order Planning report used in production logistics.',
    `agv_code` BIGINT COMMENT 'Identifier of the AGV assigned to execute the transfer.',
    `batch_number` STRING COMMENT 'Batch identifier for the material batch being moved.',
    `confirmation_status` STRING COMMENT 'Result of the confirmation step before execution.. Valid values are `pending|confirmed|rejected`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Internal cost associated with moving the stock.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center responsible for the transfer expense.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.',
    `execution_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock transfer was completed.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Timestamp when physical movement of stock began.',
    `handling_instructions` STRING COMMENT 'Free‑text instructions for special handling during transfer.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the material is classified as hazardous.',
    `is_jis` BOOLEAN COMMENT 'Indicates if the transfer follows Just‑In‑Sequence sequencing.',
    `is_jit` BOOLEAN COMMENT 'Indicates if the transfer supports Just‑In‑Time replenishment.',
    `lot_number` STRING COMMENT 'Lot or batch identifier for traceability.',
    `movement_reason_code` STRING COMMENT 'Reason code explaining why the stock is being transferred.. Valid values are `stock_replenishment|production|maintenance|scrap|return|adjustment`',
    `priority` STRING COMMENT 'Business priority assigned to the transfer order.. Valid values are `low|medium|high|critical`',
    `project_number` STRING COMMENT 'Project identifier if the transfer is linked to a specific project.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material to be moved.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `serial_number_flag` BOOLEAN COMMENT 'Indicates whether the material is tracked by serial number.',
    `special_handling_flag` BOOLEAN COMMENT 'True if any non‑standard handling procedures apply.',
    `stock_transfer_order_status` STRING COMMENT 'Current processing status of the transfer order.. Valid values are `draft|planned|released|in_progress|completed|cancelled`',
    `temperature_control_required` BOOLEAN COMMENT 'Indicates whether temperature‑controlled handling is required.',
    `transfer_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer order was created in the system.',
    `transfer_order_number` STRING COMMENT 'External reference number assigned to the transfer order.',
    `transfer_type` STRING COMMENT 'Category of stock movement represented by the order.. Valid values are `plant_to_plant|plant_to_warehouse|warehouse_to_warehouse|replenishment|return|adjustment`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the transfer quantity.. Valid values are `EA|KG|L|M|BOX|PACK`',
    CONSTRAINT pk_stock_transfer_order PRIMARY KEY(`stock_transfer_order_id`)
) COMMENT 'Warehouse Management transfer order governing the physical movement of stock between storage bins, storage types, or plants. Aligned with SAP WM transfer order (LT0A). Captures source and destination bin, transfer quantity, movement reason, AGV assignment, picker assignment, confirmation status, and execution timestamps. Supports JIT/JIS sequencing for line-side replenishment and inter-plant stock balancing.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`mrp_requirement` (
    `mrp_requirement_id` BIGINT COMMENT 'System-generated unique identifier for the MRP requirement record.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: MRP requirements in automotive are generated by BOM explosion. Linking mrp_requirement to the specific BOM version used enables change impact analysis — when a BOM revision occurs, planners identify w',
    `model_year_program_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_model_year_program. Business justification: MRP requirements in automotive manufacturing are planned against specific model year programs. Production planners run parts requirements by model year program to align supply with production ramp-up/',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: MRP requirements for powertrain-specific components (EV battery packs, engine assemblies) are driven by planned production of specific powertrain variants. Supply planners must trace which powertrain ',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: MRP requirements are pegged to production orders in order-based automotive manufacturing (make-to-order). This SAP PP standard link enables order-level material availability checks, shortage analysis,',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_schedule. Business justification: MRP requirements in automotive are pegged to production schedules — the schedule drives demand that generates requirements. This standard SAP PP-MRP link enables requirement-to-schedule traceability, ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Planning under regulation: MRP calculations consider mandatory regulatory constraints for material planning.',
    `safety_stock_policy_id` BIGINT COMMENT 'Foreign key linking to inventory.safety_stock_policy. Business justification: MRP requirements incorporate safety stock and reorder point values that are governed by safety_stock_policy. mrp_requirement carries safety_stock (DECIMAL) and reorder_point (DECIMAL) as denormalized ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: MRP requirements are generated per material/SKU during the MRP planning run (MD04/MD05). mrp_requirement carries material_number (STRING) as a denormalized SKU reference. Adding sku_master_id FK links',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Link MRP requirement to storage_location for proper location tracking',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Automotive MRP requirements are program-specific; production plans are organized by vehicle program. Direct link enables program-level demand planning reports, launch readiness dashboards, and capacit',
    `batch_flag` BOOLEAN COMMENT 'Indicates whether the material is managed in batches.',
    `demand_source` STRING COMMENT 'Origin of the demand that generated the requirement.. Valid values are `forecast|sales_order|production|stock_transfer`',
    `exception_message` STRING COMMENT 'System-generated message describing any planning exception for the requirement.',
    `lead_time_days` STRING COMMENT 'Planned procurement or production lead time expressed in days.',
    `lot_size` DECIMAL(18,2) COMMENT 'Minimum production or procurement lot size applicable to the material.',
    `mrp_requirement_status` STRING COMMENT 'Current processing state of the requirement.. Valid values are `planned|released|cancelled|exception`',
    `planning_horizon_days` STRING COMMENT 'Number of days covered by the planning run that produced this requirement.',
    `planning_scenario` STRING COMMENT 'Planning run scenario used to generate the requirement (e.g., MPS, MRP, DRP).. Valid values are `MPS|MRP|DRP`',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant where the requirement applies.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_code` STRING COMMENT 'Business priority assigned to the requirement for planning urgency.. Valid values are `high|medium|low`',
    `quantity_required` DECIMAL(18,2) COMMENT 'Total quantity of the material required for the planning horizon.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the requirement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requirement record.',
    `requirement_date` DATE COMMENT 'Date by which the material is needed to meet production schedules.',
    `requirement_number` STRING COMMENT 'Business identifier assigned to the requirement by the MRP run.. Valid values are `^[A-Z0-9]{1,20}$`',
    `requirement_type` STRING COMMENT 'Indicates whether the requirement is independent (external demand) or dependent (internal component need).. Valid values are `independent|dependent`',
    `source_of_supply` STRING COMMENT 'Indicates whether the material will be sourced internally or from external suppliers.. Valid values are `internal|external`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the required quantity.. Valid values are `EA|KG|L|M`',
    CONSTRAINT pk_mrp_requirement PRIMARY KEY(`mrp_requirement_id`)
) COMMENT 'MRP (Material Requirements Planning) planned requirement record generated by SAP MRP run (MD04/MD05). Captures dependent and independent demand requirements for each SKU, planned order proposals, reorder points, lot sizes, lead times, and exception messages. Drives procurement requisitions and production orders. Supports safety stock calculation, demand smoothing, and supply gap analysis across the manufacturing network.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'System-generated unique identifier for the physical inventory cycle count event.',
    `plant_id` BIGINT COMMENT 'Manufacturing plant where the inventory is stored.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Cycle counts in automotive plants are scoped to specific production lines for lineside inventory accuracy audits required by IATF 16949. Linking cycle_count to production_line enables line-level inven',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: A cycle count is a physical inventory count event for a specific SKU at a specific storage location. cycle_count already has storage_location_id but is missing sku_master_id — a critical gap since a c',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (warehouse, plant, or depot) where the count took place.',
    `abc_classification` STRING COMMENT 'ABC inventory classification driving count frequency.. Valid values are `A|B|C`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the count was approved.',
    `approved_by` BIGINT COMMENT 'Employee who approved the count after review.',
    `book_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded in the system (book) prior to the count.',
    `compliance_iatf16949_flag` BOOLEAN COMMENT 'True if the count complies with IATF 16949 inventory control requirements.',
    `compliance_nhtsa_flag` BOOLEAN COMMENT 'True if the count satisfies NHTSA traceability obligations.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the inventory location.',
    `count_date` DATE COMMENT 'Date on which the physical count was performed.',
    `count_document_number` STRING COMMENT 'External document number assigned by SAP MM for the inventory count (e.g., MI01/MI07).',
    `count_frequency_days` STRING COMMENT 'Number of days between scheduled counts for this SKU/location.',
    `count_status` STRING COMMENT 'Current lifecycle status of the count event.. Valid values are `planned|counted|posted|approved|rejected`',
    `count_type` STRING COMMENT 'Specifies whether the count is a full inventory, partial, or scheduled cycle count.. Valid values are `full|partial|cycle`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Quantity physically counted during the inventory event.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the count record was first created.',
    `cycle_count_method` STRING COMMENT 'Technique used to perform the count.. Valid values are `manual|automated|RFID`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the count took place.',
    `inventory_category` STRING COMMENT 'High‑level classification of the inventory item.. Valid values are `raw_material|component|wip|finished_goods|service_part`',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the count record is locked from further edits.',
    `is_obsolete` BOOLEAN COMMENT 'Indicates whether the SKU is marked as obsolete.',
    `last_count_date` DATE COMMENT 'Date of the most recent prior count for this SKU/location.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of the counted material.',
    `model_year` STRING COMMENT 'Model year of the vehicle or component associated with the SKU.',
    `next_scheduled_count_date` DATE COMMENT 'Planned date for the next cycle count based on ABC classification.',
    `physical_inventory_doc_type` STRING COMMENT 'SAP document type for the inventory count.. Valid values are `MI01|MI07`',
    `posted_by` BIGINT COMMENT 'Employee who posted the count results.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the count was posted to inventory.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether a recount was required after the initial count.',
    `recount_number` STRING COMMENT 'Sequential number of the recount attempt, if applicable.',
    `remarks` STRING COMMENT 'Free‑text field for additional comments or observations.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Quantity at which a replenishment order should be triggered.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Predefined safety stock level for the SKU at the location.',
    `serial_number_flag` BOOLEAN COMMENT 'Indicates whether the counted items are serialized (true) or not (false).',
    `source_system` STRING COMMENT 'Originating system of record, e.g., SAP WM.',
    `storage_bin` STRING COMMENT 'Alphanumeric code of the specific bin or shelf within the location.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity fields (e.g., EA for each, KG for kilograms).. Valid values are `EA|KG|L|M`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the count record.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance calculated as (variance_quantity / book_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between counted and book quantities (counted - book).',
    `variance_reason` STRING COMMENT 'Narrative explanation for any observed variance.',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Physical inventory cycle count event record for a specific SKU at a specific storage location. Aligned with SAP MM physical inventory document (MI01/MI07). Captures count date, counted quantity, book quantity, variance quantity, variance percentage, count status (planned, counted, posted, approved), counter identity, and recount flag. Supports inventory accuracy KPIs, ABC classification-driven count frequency, and IATF 16949 inventory control requirements.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` (
    `finished_vehicle_stock_id` BIGINT COMMENT 'System-generated unique identifier for each finished vehicle stock record.',
    `individual_id` BIGINT COMMENT 'Foreign key linking to customer.individual. Business justification: Retail customers reserve vehicles during production or at completion before ownership transfer. Supports sold-order tracking, delivery coordination, and sales pipeline management. Distinct from vehicl',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Finished vehicle traceability requires knowing the exact BOM version used to build each vehicle. This is mandatory for NHTSA recall investigations, warranty root cause analysis, and IATF 16949 build r',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity assignment for finished vehicles. Vehicles must be assigned to company code for financial reporting, intercompany transfers between plants/markets, and consolidated balance sheet reportin',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Finished vehicle stock allocation, dealer order matching, and MSRP pricing require knowing the exact vehicle configuration (trim, powertrain, color, options). model_code, trim_level, body_style, power',
    `organization_account_id` BIGINT COMMENT 'Foreign key linking to customer.organization_account. Business justification: Fleet customers pre-allocate finished vehicles before delivery. Tracks which fleet account has reserved specific VINs for their order fulfillment, supporting fleet sales pipeline and logistics coordin',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: Vehicle approval: link each finished VIN to its homologation record required for market entry.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Finished vehicles undergo pre-delivery inspection (PDI) and final quality gates before release to dealers. Linking FVS to inspection lots enables traceability of which quality checks were performed on',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Vehicle sales invoicing requires linking each finished vehicle (VIN) to its sales invoice for reconciliation of inventory and revenue.',
    `model_year_program_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_model_year_program. Business justification: Finished vehicle stock aging analysis, dealer allocation quotas, and production closeout reporting are managed by model year program. Inventory managers track stock levels per model year program to pr',
    `powertrain_spec_id` BIGINT COMMENT 'Foreign key linking to engineering.powertrain_spec. Business justification: Each finished vehicle stock record carries a specific powertrain configuration. Linking to powertrain_spec enables emissions compliance reporting, EPA/WLTP range verification, and dealer configuration',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer to which the vehicle is allocated.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Finished vehicle stock must trace to the production order for cost settlement, warranty traceability, and NHTSA recall investigations. production_line is a denormalized plain attr. Domain experts expe',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Vehicle profitability analysis attributes each finished vehicle to a profit center for margin reporting.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Finished vehicles are physically stored at specific storage locations (EOL staging areas, PDI bays, finished goods yards, dealer lots). finished_vehicle_stock carries current_location_code (STRING) as',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Allocation report requires linking each finished vehicle to the specific sales order it fulfills, enabling real‑time order fulfillment tracking.',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Delivery & Warranty Management report needs to tie each stocked VIN to its owning customer record.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Supports dealership allocation and program performance reports linking finished vehicles back to their engineering program.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Needed for Finished Vehicle Stock report linking each inventory vehicle to its VIN registry for warranty, recall, and regulatory compliance.',
    `aging_days` STRING COMMENT 'Number of days the vehicle has been in its current status.',
    `allocation_date` DATE COMMENT 'Date the vehicle was assigned to a dealer.',
    `batch_number` STRING COMMENT 'Internal production batch number associated with the vehicle.',
    `color` STRING COMMENT 'Paint color of the vehicle as defined by the manufacturer.',
    `delivery_date` DATE COMMENT 'Actual date the vehicle left the plant or compound for the dealer/customer.',
    `emission_standard` STRING COMMENT 'Regulatory emission classification (e.g., Euro 6, EPA Tier 3).',
    `expected_delivery_date` DATE COMMENT 'Planned delivery date based on logistics schedule.',
    `location_type` STRING COMMENT 'Category of the current location.. Valid values are `compound|yard|warehouse|dealer|in_transit`',
    `lot_number` STRING COMMENT 'Batch identifier used for traceability of the vehicle batch.',
    `msrp` DECIMAL(18,2) COMMENT 'Standard retail price set by the manufacturer for the vehicle configuration.',
    `plant_code` STRING COMMENT 'Identifier of the plant where the vehicle was assembled.',
    `production_date` DATE COMMENT 'Calendar date when the vehicle completed assembly (EOL).',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the vehicle is subject to a safety recall (true) or not (false).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the stock record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stock record.',
    `stock_status` STRING COMMENT 'Current lifecycle status of the vehicle within inventory.. Valid values are `in_production|pdi_pending|pdi_complete|allocated|in_transit|delivered`',
    `vin` STRING COMMENT 'Globally unique 17‑character identifier assigned to each vehicle.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `warranty_end_date` DATE COMMENT 'Date when the vehicle warranty period expires.',
    `warranty_start_date` DATE COMMENT 'Date when the vehicle warranty period begins.',
    CONSTRAINT pk_finished_vehicle_stock PRIMARY KEY(`finished_vehicle_stock_id`)
) COMMENT 'Finished vehicle inventory record tracking completed vehicles from end-of-line (EOL) through PDI (Pre-Delivery Inspection), compound storage, and dealer allocation. Captures VIN, model/trim/color configuration, plant of manufacture, current compound or yard location, stock status (in-production, PDI-pending, PDI-complete, allocated, in-transit, delivered), hold codes, and aging days. Bridges manufacturing and logistics domains for vehicle order fulfillment.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`service_parts_stock` (
    `service_parts_stock_id` BIGINT COMMENT 'Unique identifier for the service parts stock record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service parts inventory cost is allocated to a cost center for service department expense tracking.',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Service parts at OEM distribution centers are allocated to specific dealers for replenishment orders, backorder fulfillment, and emergency parts requests. Tracks which dealer has allocation rights or ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Service parts inventory valuation account. Aftermarket parts inventory requires GL account assignment for balance sheet valuation, separate from production materials. Supports parts business P&L and i',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: Aftermarket service parts often source from production suppliers. Linking to inbound_part enables supplier lead time planning, cost tracking, and procurement continuity between production and service ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Service parts stock management requires engineering part specification for obsolescence management, warranty claims, and supersession tracking. part_revision and supersession_part_number on service_pa',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Service parts reserved for specific customer vehicles undergoing warranty or service work. Supports dealer service operations parts allocation, ensuring critical parts availability for customer appoin',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Service parts are SKUs defined in sku_master (material_type = service part). service_parts_stock tracks after-sales spare parts inventory but currently has no FK to sku_master, creating a data silo fo',
    `storage_location_id` BIGINT COMMENT 'Unique identifier of the warehouse or dealer location where the stock is held.',
    `aisle` STRING COMMENT 'Aisle identifier within the warehouse layout.',
    `batch_number` STRING COMMENT 'Identifier for the manufacturing batch of the part.',
    `bin_number` STRING COMMENT 'Alphanumeric identifier of the storage bin or pallet location.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of a single unit of the part in the local currency.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for cost values.. Valid values are `USD|EUR|JPY|CAD|GBP`',
    `cycle_count_status` STRING COMMENT 'Current status of the scheduled cycle count for the location.. Valid values are `due|overdue|completed`',
    `expiration_date` DATE COMMENT 'Date after which the part should not be used (e.g., perishable components).',
    `inventory_status` STRING COMMENT 'Overall lifecycle status of the stock record.. Valid values are `active|inactive|blocked`',
    `last_cost_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent cost update for the part.',
    `last_count_date` DATE COMMENT 'Date of the most recent physical inventory count.',
    `last_issue_date` DATE COMMENT 'Date when the most recent stock issue (dispatch) was recorded.',
    `last_receipt_date` DATE COMMENT 'Date when the most recent stock receipt was recorded.',
    `lead_time_days` STRING COMMENT 'Average number of days from order placement to receipt for this part.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of the part.',
    `max_stock_level` STRING COMMENT 'Upper bound for stock to avoid over‑stocking.',
    `min_stock_level` STRING COMMENT 'Safety stock threshold below which replenishment is triggered.',
    `obsolescence_date` DATE COMMENT 'Effective date when the part becomes obsolete.',
    `obsolescence_reason` STRING COMMENT 'Reason for obsolescence (e.g., discontinued, replaced by new model).',
    `obsolescence_status` STRING COMMENT 'Indicates whether the part is active, pending obsolescence, or obsolete.. Valid values are `active|obsolete|pending`',
    `quantity_available` STRING COMMENT 'Units available for allocation to orders (excluding reserved stock).',
    `quantity_committed` STRING COMMENT 'Units already committed to pending service orders.',
    `quantity_on_hand` STRING COMMENT 'Total number of units physically present in the location.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the stock record was initially created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stock record.',
    `reorder_point` STRING COMMENT 'Inventory level that triggers a replenishment order.',
    `safety_stock` STRING COMMENT 'Buffer quantity kept to protect against demand variability.',
    `serial_number_flag` BOOLEAN COMMENT 'Indicates whether the part is tracked by individual serial numbers.',
    `shelf` STRING COMMENT 'Shelf identifier within the aisle for the part.',
    `valuation_method` STRING COMMENT 'Inventory valuation method applied to the part stock.. Valid values are `standard|fifo|lifo|average`',
    `warranty_expiration_date` DATE COMMENT 'Date when the parts warranty coverage ends.',
    `warranty_status` STRING COMMENT 'Current warranty coverage status of the part.. Valid values are `in_warranty|out_of_warranty`',
    CONSTRAINT pk_service_parts_stock PRIMARY KEY(`service_parts_stock_id`)
) COMMENT 'After-sales service parts inventory record tracking spare parts and accessories across the central parts distribution center (PDC), regional warehouses, and dealer parts rooms. Captures part number, supersession chain, current stock level by location, min/max replenishment levels, fill rate, backorder quantity, and obsolescence classification. Supports dealer parts ordering, warranty repair fulfillment, and TSB (Technical Service Bulletin) parts pre-positioning.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the inventory hold record.',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering change orders (ECOs) are the primary trigger for inventory holds on affected parts pending disposition. Linking hold to the triggering change enables ECO impact tracking — quality teams qu',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: Holds placed due to pending homologation approval or certification issues require linkage to specific certification records. Supports EU type-approval delays, EPA certification blocks, and market-spec',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Quality holds frequently originate from defective inbound shipments. Link enables shipment-level quarantine, supplier corrective action requests, and root cause analysis tied to specific ASN/delivery ',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Quality or recall holds on finished vehicles or parts require immediate dealer notification when the hold affects dealer allocations or inventory in transit. Tracks primary dealer responsible for coor',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Inventory holds in automotive are frequently placed at the engineering part level (affecting all SKUs of that part) due to design defects or ECO dispositions. Direct link enables quality engineers to ',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Inventory holds triggered by production quality failures reference the producing production order for root cause analysis, cost assignment, and IATF 16949 non-conformance reporting. Traceability from ',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_recall_campaign. Business justification: Recall management: holds placed due to a recall must reference the specific recall campaign.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: inventory_hold blocks stock for a SKU; linking to sku_master eliminates duplicate SKU identifier.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the warehouse or plant location where the hold applies.',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Holds placed on specific customer-owned vehicles for warranty disputes, lemon law cases, or owner-specific quality issues. Complements recall_campaign_id for non-campaign holds. Supports customer-spec',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was actually released.',
    `batch_number` STRING COMMENT 'Batch or lot identifier for the inventory affected.',
    `comments` STRING COMMENT 'Free-text comments describing the hold context.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was created in the system.',
    `disposition_decision` STRING COMMENT 'Action to be taken after hold is released.. Valid values are `use_as_is|rework|scrap|return_to_supplier`',
    `expected_release_timestamp` TIMESTAMP COMMENT 'Planned date and time for hold release.',
    `hold_number` STRING COMMENT 'System-generated hold reference number.',
    `hold_source` STRING COMMENT 'Indicates whether the hold was generated automatically by the system or entered manually.. Valid values are `system|manual`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `active|released|cancelled|expired`',
    `hold_type` STRING COMMENT 'Category of hold indicating reason source.. Valid values are `quality|engineering|regulatory|supplier|recall`',
    `initiating_department` STRING COMMENT 'Department that initiated the hold.. Valid values are `quality|engineering|procurement|production|logistics`',
    `is_critical_hold` BOOLEAN COMMENT 'Indicates if the hold is critical to production safety.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability.',
    `quantity_held` DECIMAL(18,2) COMMENT 'Total quantity of items placed on hold.',
    `reason_code` STRING COMMENT 'Code representing specific reason for the hold as defined by quality or engineering.',
    `serial_number_end` STRING COMMENT 'Ending serial number in the range held.',
    `serial_number_start` STRING COMMENT 'Starting serial number in the range held (if serialized).',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the hold became effective.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the held quantity.. Valid values are `EA|KG|L|SET`',
    `updated_by` STRING COMMENT 'User identifier who last modified the hold record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hold record.',
    `created_by` STRING COMMENT 'User identifier who created the hold record.',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Inventory hold and block record restricting the use or movement of specific stock due to quality holds, engineering change notices (ECN), regulatory non-conformance, supplier PPAP failures, or recall investigations. Captures hold type, affected SKU/batch/serial range, quantity blocked, hold reason code, initiating department, hold start date, expected release date, and disposition decision (use-as-is, rework, scrap, return-to-supplier). Supports APQP/PPAP compliance and quality containment actions.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order.',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: Customer cases trigger emergency parts replenishment (warranty claims, service escalations requiring expedited parts to dealers). Links customer service needs to supply chain response, supporting case',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders are budgeted and expensed against a cost center for internal cost control.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the consuming location (line‑side, assembly station, dealer parts room).',
    `mrp_requirement_id` BIGINT COMMENT 'Foreign key linking to inventory.mrp_requirement. Business justification: Replenishment orders are frequently generated as a direct response to MRP planned requirements (demand signals from the MRP run). Adding mrp_requirement_id FK to replenishment_order creates a traceabl',
    `primary_replenishment_storage_location_id` BIGINT COMMENT 'Identifier of the supplying storage location (warehouse, supermarket, PDC).',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Replenishment orders for lineside materials are triggered by specific production lines running low on components in JIT/JIS environments. Linking to production_line enables line-specific replenishment',
    `safety_stock_policy_id` BIGINT COMMENT 'Foreign key linking to inventory.safety_stock_policy. Business justification: Replenishment orders are triggered when stock falls below safety stock thresholds defined in safety_stock_policy. replenishment_order has trigger_source (STRING) which is a denormalized reference to w',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: replenishment_order requests stock for a SKU; linking to sku_master centralizes SKU attributes.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the replenishment was physically received at the destination.',
    `batch_number` STRING COMMENT 'Batch identifier for the replenished material.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of a single unit of the SKU at the time of order.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the replenishment order record was first created in the system.',
    `event_timestamp` TIMESTAMP COMMENT 'The moment the replenishment request was generated (e.g., pull signal from the shop floor).',
    `fulfillment_status` STRING COMMENT 'Current fulfillment state of the order.. Valid values are `pending|in_progress|completed|failed`',
    `is_critical` BOOLEAN COMMENT 'Indicates if the SKU is a critical component requiring priority handling.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the replenishment order record.',
    `lead_time_days` STRING COMMENT 'Planned number of days from order release to delivery.',
    `lot_number` STRING COMMENT 'Lot identifier for batch‑controlled items, if applicable.',
    `max_stock_level` STRING COMMENT 'Maximum allowable inventory level for the SKU at the source location.',
    `min_stock_level` STRING COMMENT 'Minimum desired inventory level for the SKU at the source location.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the replenishment.',
    `order_number` STRING COMMENT 'External reference number assigned to the replenishment order.',
    `order_status` STRING COMMENT 'Current processing state of the replenishment order.. Valid values are `draft|open|released|fulfilled|cancelled`',
    `order_type` STRING COMMENT 'Methodology used to trigger the replenishment (e.g., kanban, min‑max, JIT pull, JIS sequence).. Valid values are `kanban|min_max|jit_pull|jis_sequence`',
    `priority_level` STRING COMMENT 'Business priority assigned to the order to influence fulfillment sequencing.. Valid values are `low|medium|high|critical`',
    `promised_delivery_date` DATE COMMENT 'Date promised by the supplying location for delivery.',
    `replenishment_method` STRING COMMENT 'Whether the order was generated automatically by the system or entered manually.. Valid values are `automatic|manual`',
    `requested_delivery_date` DATE COMMENT 'Date by which the consuming location expects the replenishment.',
    `requested_quantity` STRING COMMENT 'Quantity of the SKU requested for replenishment.',
    `safety_stock_quantity` STRING COMMENT 'Quantity of the SKU kept as safety stock at the source location.',
    `serial_number` STRING COMMENT 'Serial number for individually tracked high‑value components (e.g., ECUs, batteries).',
    `trigger_source` STRING COMMENT 'Origin of the trigger that generated the replenishment request.. Valid values are `production_schedule|reorder_point|manual|system`',
    `uom` STRING COMMENT 'Unit of measure for the requested quantity (e.g., each, kilogram, liter, box).. Valid values are `EA|KG|L|M|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the replenishment order record.',
    `created_by` STRING COMMENT 'User identifier who initially created the replenishment order record.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Internal replenishment order triggering stock movement from a supplying storage location (warehouse, supermarket, PDC) to a consuming location (line-side, assembly station, dealer parts room). Captures replenishment type (kanban, min-max, JIT pull, JIS sequence), trigger source, requested SKU and quantity, source and destination locations, priority, requested delivery time, and fulfillment status. Supports lean manufacturing pull systems and dealer parts replenishment cycles.';

CREATE OR REPLACE TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` (
    `safety_stock_policy_id` BIGINT COMMENT 'System-generated unique identifier for the safety stock policy record.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: safety_stock_policy defines policies per SKU; linking to sku_master eliminates redundant sku_code.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Safety stock policies are defined per SKU per location (the policy description explicitly states minimum stock buffer for each SKU at each [location]). safety_stock_policy already has sku_master_id ',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Safety stock policies in automotive are program-specific — launch programs require higher safety stock buffers than steady-state production. Linking safety_stock_policy to vehicle_program enables prog',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety stock policy record was first created.',
    `demand_variability_factor` DECIMAL(18,2) COMMENT 'Coefficient representing demand volatility used in safety stock calculation (percentage).',
    `effective_from` DATE COMMENT 'Date on which the policy becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the policy expires or is superseded; null if open‑ended.',
    `last_recalculation_timestamp` TIMESTAMP COMMENT 'Date and time when the safety stock values were last computed.',
    `lead_time_days` STRING COMMENT 'Average number of days from order placement to receipt for the SKU.',
    `lifecycle_status` STRING COMMENT 'Stage of the policy within its approval and implementation lifecycle.. Valid values are `draft|approved|implemented|retired`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper bound of inventory allowed for the SKU to avoid overstock.',
    `notes` STRING COMMENT 'Free‑form comments or rationale associated with the policy.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant or production site where the policy is enforced.',
    `policy_number` STRING COMMENT 'Business-visible identifier or code assigned to the safety stock policy.',
    `policy_type` STRING COMMENT 'Category of inventory control the policy addresses.. Valid values are `safety_stock|reorder_point|max_stock`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order for the SKU.',
    `review_cycle_days` STRING COMMENT 'Frequency, in days, at which the safety stock parameters are reviewed and potentially recalculated.',
    `safety_stock_method` STRING COMMENT 'Method used to determine safety stock (statistical, fixed amount, or dynamic algorithm).. Valid values are `statistical|fixed|dynamic`',
    `safety_stock_policy_status` STRING COMMENT 'Current operational state of the safety stock policy.. Valid values are `active|inactive|pending`',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Calculated buffer quantity to be kept on hand for the SKU at the specified location.',
    `safety_stock_source` STRING COMMENT 'Origin of the safety stock values – generated by the system, entered manually, or supplied by an external tool.. Valid values are `system|manual|external`',
    `service_level_target` DECIMAL(18,2) COMMENT 'Desired fill‑rate or service level expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the policy record.',
    CONSTRAINT pk_safety_stock_policy PRIMARY KEY(`safety_stock_policy_id`)
) COMMENT 'Safety stock and reorder point policy record defining the minimum stock buffer for each SKU at each plant/location to protect against demand variability and supply disruptions. Captures safety stock quantity, reorder point, maximum stock level, replenishment lead time, demand variability factor, service level target, review cycle, and last recalculation date. Drives MRP safety stock parameters and supports supply chain resilience planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `automotive_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_reversal_of_movement_goods_movement_id` FOREIGN KEY (`reversal_of_movement_goods_movement_id`) REFERENCES `automotive_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `automotive_ecm`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `automotive_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `automotive_ecm`.`inventory`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_mrp_requirement_id` FOREIGN KEY (`mrp_requirement_id`) REFERENCES `automotive_ecm`.`inventory`.`mrp_requirement`(`mrp_requirement_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_primary_replenishment_storage_location_id` FOREIGN KEY (`primary_replenishment_storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_safety_stock_policy_id` FOREIGN KEY (`safety_stock_policy_id`) REFERENCES `automotive_ecm`.`inventory`.`safety_stock_policy`(`safety_stock_policy_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `automotive_ecm`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `automotive_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `automotive_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Master Identifier');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `ean13` SET TAGS ('dbx_business_glossary_term' = 'EAN‑13 Barcode');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `ean13` SET TAGS ('dbx_value_regex' = '^d{13}$');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `hazardous_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Class');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `hazardous_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimeters)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `last_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `lot_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Controlled Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP Controller');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Type');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|FO|...');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|I|M');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `serial_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Controlled Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU Code (Stock Keeping Unit)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_master_description` SET TAGS ('dbx_business_glossary_term' = 'SKU Description');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_master_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Status');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_master_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `sku_name` SET TAGS ('dbx_business_glossary_term' = 'SKU Name');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Indicator');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|CM|MM');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'UPC Barcode');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `automotive_ecm`.`inventory`.`sku_master` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID (SLID)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PID)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `agv_routing_priority` SET TAGS ('dbx_business_glossary_term' = 'AGV Routing Priority (AGV_PRIO)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier (AISLE)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier (BIN)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Quantity (SCQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO3)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|DEU|FRA|GBR');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `external_system_source` SET TAGS ('dbx_business_glossary_term' = 'External System Source (ESS)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `external_system_source` SET TAGS ('dbx_value_regex' = 'SAP_WM|Oracle_WMS|Custom');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Rating (FSR)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `hazardous_material_allowed` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Allowed Flag (HMAF)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `inventory_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Inventory Accuracy Percentage (IAP)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `is_default_location` SET TAGS ('dbx_business_glossary_term' = 'Default Location Flag (DLF)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `last_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Count Date (LICD)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (SLC)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name (SLN)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type (SLT)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|rack|floor|cold_chain|automated|quarantine');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `rack` SET TAGS ('dbx_business_glossary_term' = 'Rack Identifier (RACK)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Description (SLD)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status (SLS)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|closed');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TCF)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Celsius (TRC)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `used_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Used Capacity Percentage (UCP)');
ALTER TABLE `automotive_ecm`.`inventory`.`storage_location` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone (WZ)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance ID');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `blocked_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `consignment_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `goods_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Type');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `goods_movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202|301|311');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `in_transit_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Is Serialized');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Lifecycle Status');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|consignment|in_transit|safety');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `physical_location_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Hierarchy');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `quality_inspection_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_business_glossary_term' = 'Stock Category');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_value_regex' = 'raw_material|component|finished_good|service_part|spare_part');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `unrestricted_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `valuation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area Code');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement ID');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reversal_of_movement_goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Movement ID');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_local` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'USD Amount');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `destination_plant` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant (PLT)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location (SL)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Movement Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_lot_tracked` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracked Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_serial_tracked` SET TAGS ('dbx_business_glossary_term' = 'Serial Tracked Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason (Reason)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason` SET TAGS ('dbx_value_regex' = 'Production|Sales|Repair|Scrap|Transfer');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (Qty)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number (RefDocNo)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type (RefDocType)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_value_regex' = 'PO|PR|WO|DO|SA');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `source_plant` SET TAGS ('dbx_business_glossary_term' = 'Source Plant (PLT)');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'Standard|MovingAverage|FIFO|LIFO');
ALTER TABLE `automotive_ecm`.`inventory`.`goods_movement` ALTER COLUMN `warehouse_number` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Number');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order ID (STO_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Identifier (DST_PLANT_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `source_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Identifier (SRC_PLANT_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `agv_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Guided Vehicle Identifier (AGV_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Confirmation Status (CONFIRM_STATUS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount (COST_AMT)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER_CD)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (COST_CURR)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `execution_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp (EXEC_END_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp (EXEC_START_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions (HANDLING_INSTR)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (IS_HAZARDOUS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `is_jis` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Sequence Flag (IS_JIS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `is_jit` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Time Flag (IS_JIT)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code (MOVE_REASON_CD)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_value_regex' = 'stock_replenishment|production|maintenance|scrap|return|adjustment');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transfer Priority (PRIORITY)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number (PROJ_NO)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity (TRANSFER_QTY)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Material Flag (IS_SERIALIZED)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `special_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Flag (IS_SPECIAL_HANDLING)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Status (TO_STATUS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_status` SET TAGS ('dbx_value_regex' = 'draft|planned|released|in_progress|completed|cancelled');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag (TEMP_CTRL_REQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Creation Timestamp (TO_CREATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number (TO_NUM)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type (TO_TYPE)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'plant_to_plant|plant_to_warehouse|warehouse_to_warehouse|replenishment|return|adjustment');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX|PACK');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Requirement ID');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `model_year_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `batch_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Flag (BATCH_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source (DEMAND_SRC)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|sales_order|production|stock_transfer');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `exception_message` SET TAGS ('dbx_business_glossary_term' = 'Exception Message (EXC_MSG)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days (LT_DAYS)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity (LOT_SZ)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Lifecycle Status (REQ_STATUS)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_status` SET TAGS ('dbx_value_regex' = 'planned|released|cancelled|exception');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (PLAN_HORIZON)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario (PLAN_SCEN)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'MPS|MRP|DRP');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code (PRIO)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity (QTY_REQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Requirement Date (REQ_DATE)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_business_glossary_term' = 'MRP Requirement Number (REQ_NO)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type (REQ_TYPE)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'independent|dependent');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply (SUPPLY_SRC)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`mrp_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Identifier');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (LOC_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification (ABC)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APP_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (APPROVER_ID)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `book_quantity` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity (BQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `compliance_iatf16949_flag` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag (IATF_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `compliance_nhtsa_flag` SET TAGS ('dbx_business_glossary_term' = 'NHTSA Compliance Flag (NHTSA_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date (CD)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_document_number` SET TAGS ('dbx_business_glossary_term' = 'Count Document Number (CDN)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Count Frequency (DAYS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status (CS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|counted|posted|approved|rejected');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type (CT)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|partial|cycle');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity (CQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_method` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Method (CC_METHOD)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_method` SET TAGS ('dbx_value_regex' = 'manual|automated|RFID');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Inventory Category (INV_CAT)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `inventory_category` SET TAGS ('dbx_value_regex' = 'raw_material|component|wip|finished_goods|service_part');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag (LOCK_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag (OBSOLETE_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `last_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Count Date (LAST_CD)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `next_scheduled_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Count Date (NEXT_CD)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_doc_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Type (PID_TYPE)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_doc_type` SET TAGS ('dbx_value_regex' = 'MI01|MI07');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Identifier (POSTED_BY)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp (POSTED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag (RC_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Sequence Number (RC_NUM)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (RMKS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (ROP_QTY)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SS_QTY)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Flag (SN_FLAG)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_bin` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin Code (BIN)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage (VPCT)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance (QV)');
ALTER TABLE `automotive_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason (VR)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `finished_vehicle_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Vehicle Stock ID');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Individual Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `organization_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Allocation Organization Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `model_year_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `powertrain_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Spec Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Dealer ID');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Exterior Color');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'compound|yard|warehouse|dealer|in_transit');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'in_production|pdi_pending|pdi_complete|allocated|in_transit|delivered');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `automotive_ecm`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `service_parts_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Service Parts Stock ID');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved For Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CAD|GBP');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_value_regex' = 'due|overdue|completed');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `last_cost_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `last_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Count Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_reason` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Reason');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Status');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|pending');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_committed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Committed');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `shelf` SET TAGS ('dbx_business_glossary_term' = 'Shelf');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'standard|fifo|lifo|average');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `automotive_ecm`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'in_warranty|out_of_warranty');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Hold ID');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Notified Dealership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Hold Comments');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `expected_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number (HOLD_NO)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_source` SET TAGS ('dbx_business_glossary_term' = 'Hold Source');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_source` SET TAGS ('dbx_value_regex' = 'system|manual');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|expired');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'quality|engineering|regulatory|supplier|recall');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `initiating_department` SET TAGS ('dbx_business_glossary_term' = 'Initiating Department');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `initiating_department` SET TAGS ('dbx_value_regex' = 'quality|engineering|procurement|production|logistics');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `is_critical_hold` SET TAGS ('dbx_business_glossary_term' = 'Critical Hold Flag');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `quantity_held` SET TAGS ('dbx_business_glossary_term' = 'Quantity Held');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `serial_number_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number End');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `serial_number_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Start');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|SET');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`hold` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'movement_operations');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID (ROID)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Identifier (DSLI)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `mrp_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `primary_replenishment_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Identifier (SSLI)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp (ADT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (CPU)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Request Timestamp (RRT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status (FS)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Indicator (CPI)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User (RLMU)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days (LTD)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level (XSL)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level (MSL)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number (RON)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status (ROS)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|released|fulfilled|cancelled');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type (ROT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'kanban|min_max|jit_pull|jis_sequence');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Level (RPL)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date (PDD)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method (RM)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (RDD)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity (RQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SSQ)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Source (RTS)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'production_schedule|reorder_point|manual|system');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp (RUT)');
ALTER TABLE `automotive_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User (RCBU)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_subdomain' = 'material_definition');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy Identifier');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `demand_variability_factor` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Factor');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `last_recalculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Recalculation Timestamp');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Lifecycle Status');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|approved|implemented|retired');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'safety_stock|reorder_point|max_stock');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'statistical|fixed|dynamic');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Operational Status');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_source` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Source');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `safety_stock_source` SET TAGS ('dbx_value_regex' = 'system|manual|external');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `service_level_target` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target (Percent)');
ALTER TABLE `automotive_ecm`.`inventory`.`safety_stock_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
