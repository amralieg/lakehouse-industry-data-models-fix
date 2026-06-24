-- Schema for Domain: inventory | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`inventory` COMMENT 'Inventory management for raw materials, components, WIP (Work in Progress), finished goods, and service parts across plants, warehouses, and dealer networks. Manages stock levels, inventory movements, cycle counting, MRP (Material Requirements Planning) execution, and SKU master data. Tracks inventory accuracy, turnover rates, obsolescence, and safety stock levels. Includes warehouse management (SAP WM), lot traceability, and serialized inventory for high-value components (ECU, batteries).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`sku_master` (
    `sku_master_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Every inventory SKU in automotive corresponds to an engineering part master. BOM explosion, cost targeting, change management, and make/buy decisions all require tracing SKUs to their engineering part',
    `abc_classification` STRING COMMENT 'ABC classification',
    `base_unit_of_measure` STRING COMMENT 'Base unit of measure',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `gross_weight` DECIMAL(18,2) COMMENT 'Gross weight',
    `is_batch_managed` BOOLEAN COMMENT 'Whether batch managed',
    `is_serialized` BOOLEAN COMMENT 'Whether item is serialized',
    `material_group` STRING COMMENT 'Material group',
    `material_type` STRING COMMENT 'Material type',
    `net_weight` DECIMAL(18,2) COMMENT 'Net weight',
    `shelf_life_days` STRING COMMENT 'Shelf life in days',
    `sku_description` STRING COMMENT 'SKU description',
    `sku_number` STRING COMMENT 'SKU number',
    `sku_status` STRING COMMENT 'SKU status',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `weight_unit` STRING COMMENT 'Weight unit',
    CONSTRAINT pk_sku_master PRIMARY KEY(`sku_master_id`)
) COMMENT 'SSOT for all Stock Keeping Unit (SKU) definitions across the enterprise. Owns the material master record for raw materials, production components, WIP sub-assemblies, finished vehicles, and service parts. Aligned with SAP MM material master (MARA/MARC). Captures SKU identity, classification, unit of measure, weight/dimensions, hazardous material flags, shelf-life, and MRP planning parameters. Referenced by all inventory movement and stock transactions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique surrogate key for the storage location.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant to which the location belongs.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center containing the location.',
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
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `storage_location_description` STRING COMMENT 'Free‑form description or notes about the location.',
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
    `storage_location_status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|maintenance|closed`',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the location is climate‑controlled.',
    `temperature_range_celsius` STRING COMMENT 'Allowed temperature range for the location (e.g., "0-5").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `used_capacity_percentage` DECIMAL(18,2) COMMENT 'Current utilization of the location expressed as a percentage of total capacity.',
    `zone` STRING COMMENT 'Logical zone within the warehouse (e.g., receiving, bulk, cold).',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record for all physical and logical storage locations within plants, warehouses, distribution centers, and dealer parts depots. Captures location hierarchy (plant → warehouse → storage type → storage bin), location type (bulk, rack, floor, cold-chain), capacity constraints, and WM (Warehouse Management) configuration. Aligned with SAP WM storage location and bin master. Enables precise bin-level inventory tracking and AGV routing.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` (
    `stock_balance_id` BIGINT COMMENT 'System-generated unique identifier for each stock balance record.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Consignment stock management requires identifying which customer or supplier party owns consignment_stock_qty held at a location. Automotive consignment reconciliation reports and financial liability ',
    `movement_type_id` BIGINT COMMENT 'Foreign key linking to inventory.movement_type. Business justification: stock_balance has goods_movement_type (STRING) — a denormalized reference to the last movement type that affected this balance record. The movement_type reference table is the authoritative classifica',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: stock_balance records inventory per SKU; linking to sku_master provides authoritative SKU attributes and removes redundant material_number.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: stock_balance also references a storage location; adding storage_location_id FK normalizes location data.',
    `batch_number` STRING COMMENT 'Identifier of the production batch when batch management is active.',
    `blocked_stock_qty` BIGINT COMMENT 'Quantity that is blocked due to quality or administrative reasons.',
    `consignment_stock_qty` BIGINT COMMENT 'Quantity owned by a supplier but stored at the plant.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the valuation price.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `expiration_date` DATE COMMENT 'Date after which the material is considered expired or unusable.',
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
    `unit_of_measure` STRING COMMENT 'Unit in which the stock quantity is measured (e.g., EA, KG, L).',
    `unrestricted_stock_qty` BIGINT COMMENT 'Quantity that is free for use or sale.',
    `valuation_area_code` STRING COMMENT 'Accounting valuation area for inventory valuation purposes.',
    `valuation_price` DECIMAL(18,2) COMMENT 'Monetary value per unit for the material based on the valuation type.',
    `valuation_type` STRING COMMENT 'Method used for inventory valuation.. Valid values are `standard|moving_average|fifo|lifo`',
    CONSTRAINT pk_stock_balance PRIMARY KEY(`stock_balance_id`)
) COMMENT 'Current on-hand stock balance snapshot for each SKU at each storage location, plant, and valuation area. Captures unrestricted stock, quality inspection stock, blocked stock, consignment stock, in-transit stock, and safety stock levels. Aligned with SAP MM stock overview (MMBE / MARD). Supports MRP execution, inventory turnover analysis, and obsolescence monitoring. Updated by every goods movement transaction.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` (
    `goods_movement_id` BIGINT COMMENT 'Unique identifier for each goods movement transaction.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Foreign key linking to aftersales.aftersales_repair_order. Business justification: Parts issued to a repair order generate goods issue movements in inventory. This FK enables direct traceability of parts consumption per repair order, supporting warranty cost accounting, parts usage ',
    `movement_type_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_movement_type. Business justification: Add FK to standardize movement type lookup, remove redundant free‑text column, and give inventory_movement_type an inbound reference.',
    `part_master_id` BIGINT COMMENT 'Identifier of the material or component being moved.',
    `party_id` BIGINT COMMENT 'Identifier of the customer for goods issue movements.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order linked to the movement.',
    `reversal_of_movement_goods_movement_id` BIGINT COMMENT 'Identifier of the original goods movement that this record reverses.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Every goods movement event involves a specific material/SKU. While goods_movement.part_master_id references inventory.part_master (cross-domain for engineering BOM context), the inventory domains s',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Normalize source storage location reference; replace string with FK to storage_location',
    `stock_transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_transfer_order. Business justification: Goods movements are frequently triggered by stock transfer orders in SAP WM. The reference_document_number (STRING) on goods_movement is a generic field covering multiple document types. Adding stock_',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: goods_movement has warehouse_number (STRING) — a denormalized reference to the warehouse where the movement occurred. The warehouse master table is the authoritative source for warehouse definitions. ',
    `amount_local` DECIMAL(18,2) COMMENT 'Value of the movement in the plants local currency.',
    `amount_usd` DECIMAL(18,2) COMMENT 'Value of the movement converted to US dollars for consolidated reporting.',
    `base_uom` STRING COMMENT 'Unit of measure associated with the quantity field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods movement record was initially created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
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
    `quality_inspection_status` STRING COMMENT 'Outcome of any quality inspection linked to the movement.. Valid values are `passed|failed|not_required`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material moved, expressed in the base unit of measure.',
    `reference_document_type` STRING COMMENT 'Type of the reference document (Purchase Order, Production Order, Work Order, Delivery, Service Order).. Valid values are `PO|PR|WO|DO|SA`',
    `reversal_indicator` BOOLEAN COMMENT 'True if this record represents a reversal of a previous movement.',
    `source_plant` STRING COMMENT 'Plant where the material originated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `valuation_type` STRING COMMENT 'Inventory valuation method used for this movement.. Valid values are `Standard|MovingAverage|FIFO|LIFO`',
    CONSTRAINT pk_goods_movement PRIMARY KEY(`goods_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts (GR), goods issues (GI), stock transfers, returns, and scrapping. Aligned with SAP MM material document (MSEG/MKPF). Captures movement type, quantity, source and destination storage locations, reference document (purchase order, production order, delivery), posting date, and batch/serial number. Provides full audit trail for lot traceability and IATF 16949 compliance.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` (
    `stock_transfer_order_id` BIGINT COMMENT 'Unique identifier for the stock transfer order.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant receiving the stock.',
    `movement_type_id` BIGINT COMMENT 'Foreign key linking to inventory.movement_type. Business justification: Every stock transfer order is governed by a SAP movement type (e.g., 311 for storage-location-to-storage-location transfer, 313 for plant-to-plant). The movement_type reference table defines the rules',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: A stock transfer order governs the physical movement of a specific material/SKU between locations. material_number and material_description are denormalized SKU attributes that duplicate data owned by',
    `source_plant_id` BIGINT COMMENT 'Identifier of the plant where stock is sourced.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: A stock transfer order moves stock FROM a source storage location. This FK establishes the origin of the transfer within the warehouse management system. No existing in-domain FK covers this relations',
    `agv_code` BIGINT COMMENT 'Identifier of the AGV assigned to execute the transfer.',
    `batch_number` STRING COMMENT 'Batch identifier for the material batch being moved.',
    `confirmation_status` STRING COMMENT 'Result of the confirmation step before execution.. Valid values are `pending|confirmed|rejected`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Internal cost associated with moving the stock.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center responsible for the transfer expense.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` (
    `mrp_requirement_id` BIGINT COMMENT 'System-generated unique identifier for the MRP requirement record.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: MRP requirements are generated by exploding BOM headers against demand. Planners must trace each MRP requirement back to the driving BOM header for exception resolution, engineering change impact anal',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: MRP requirements are generated by exploding a specific BOM version. Linking mrp_requirement to the source bom enables planners to audit which BOM revision drove a requirement, critical for engineering',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: MRP requirements are generated for specific purchased parts. The inbound_part record defines supply parameters (lead time, lot size, safety stock, supplier) used by MRP to calculate requirement dates ',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Automotive MRP is fundamentally driven by vehicle model production schedules. Planners run MRP by model to determine parts requirements and replenishment. Without this FK, mrp_requirement cannot be tr',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: MRP requirements are generated per engineering part. Planners must trace each requirement to the part master to validate lead times, make/buy decisions, and revision levels. Automotive MRP planning an',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: Powertrain-specific components (engines, transmissions, battery packs) have MRP requirements driven by powertrain variant production schedules. Powertrain assembly plants run MRP by variant. This FK e',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: MRP planned orders are converted into production orders — linking mrp_requirement to production_order enables demand-to-supply conversion traceability, a core MRP/ERP process. Production planners and ',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_schedule. Business justification: MRP requirements are fulfilled by production schedules — the MRP run generates demand signals that production scheduling converts into planned output. Demand-to-schedule traceability is a core S&OP an',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall campaigns generate urgent MRP demand for replacement parts. Linking mrp_requirement to recall_campaign allows planners to prioritize recall-driven requirements, track recall parts procurement s',
    `service_campaign_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_campaign. Business justification: Active service campaigns generate deterministic parts demand that feeds MRP planning. Linking mrp_requirement to service_campaign allows planners to trace campaign-driven replenishment requirements, p',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: MRP requirements are always generated for a specific material/SKU. The material_number (STRING) on mrp_requirement is a denormalized reference to the SKU master. Adding sku_master_id FK normalizes thi',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Link MRP requirement to storage_location for proper location tracking',
    `batch_flag` BOOLEAN COMMENT 'Indicates whether the material is managed in batches.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
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
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers a new procurement proposal.',
    `requirement_date` DATE COMMENT 'Date by which the material is needed to meet production schedules.',
    `requirement_number` STRING COMMENT 'Business identifier assigned to the requirement by the MRP run.. Valid values are `^[A-Z0-9]{1,20}$`',
    `requirement_type` STRING COMMENT 'Indicates whether the requirement is independent (external demand) or dependent (internal component need).. Valid values are `independent|dependent`',
    `safety_stock` DECIMAL(18,2) COMMENT 'Buffer stock maintained to protect against demand variability and supply delays.',
    `source_of_supply` STRING COMMENT 'Indicates whether the material will be sourced internally or from external suppliers.. Valid values are `internal|external`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the required quantity.. Valid values are `EA|KG|L|M`',
    CONSTRAINT pk_mrp_requirement PRIMARY KEY(`mrp_requirement_id`)
) COMMENT 'MRP (Material Requirements Planning) planned requirement record generated by SAP MRP run (MD04/MD05). Captures dependent and independent demand requirements for each SKU, planned order proposals, reorder points, lot sizes, lead times, and exception messages. Drives procurement requisitions and production orders. Supports safety stock calculation, demand smoothing, and supply gap analysis across the manufacturing network.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'System-generated unique identifier for the physical inventory cycle count event.',
    `plant_id` BIGINT COMMENT 'Manufacturing plant where the inventory is stored.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IATF 16949 and NHTSA regulations mandate specific cycle count frequencies and methods. The existing compliance_iatf16949_flag and compliance_nhtsa_flag are denormalized signals; a FK to regulatory_req',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: A cycle count event is performed for a specific SKU at a specific storage location. While cycle_count.sku_id references inventory.sku (cross-domain), the inventory domains sku_master is the SSOT for in',
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
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the count took place.',
    `inventory_category` STRING COMMENT 'High‑level classification of the inventory item.. Valid values are `raw_material|component|wip|finished_goods|service_part`',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the count record is locked from further edits.',
    `is_obsolete` BOOLEAN COMMENT 'Indicates whether the SKU is marked as obsolete.',
    `last_count_date` DATE COMMENT 'Date of the most recent prior count for this SKU/location.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of the counted material.',
    `method` STRING COMMENT 'Technique used to perform the count.. Valid values are `manual|automated|RFID`',
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
    `storage_bin` STRING COMMENT 'Alphanumeric code of the specific bin or shelf within the location.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity fields (e.g., EA for each, KG for kilograms).. Valid values are `EA|KG|L|M`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the count record.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance calculated as (variance_quantity / book_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between counted and book quantities (counted - book).',
    `variance_reason` STRING COMMENT 'Narrative explanation for any observed variance.',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Physical inventory cycle count event record for a specific SKU at a specific storage location. Aligned with SAP MM physical inventory document (MI01/MI07). Captures count date, counted quantity, book quantity, variance quantity, variance percentage, count status (planned, counted, posted, approved), counter identity, and recount flag. Supports inventory accuracy KPIs, ABC classification-driven count frequency, and IATF 16949 inventory control requirements.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` (
    `finished_vehicle_stock_id` BIGINT COMMENT 'System-generated unique identifier for each finished vehicle stock record.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Vehicle allocation reporting and customer-specific hold management require knowing which customer (retail or fleet) a finished vehicle is allocated to. OEM allocation dashboards and priority delivery ',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Each finished vehicle in stock was built to a specific BOM header revision. Linking enables recall traceability (which BOM version is affected), warranty claim validation, and regulatory compliance re',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Dealer allocation, order matching, and production mix reporting require knowing the exact build configuration of each stocked vehicle. finished_vehicle_stock carries denormalized body_style, color, po',
    `emissions_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_emissions_certification. Business justification: Finished vehicles must carry valid emissions certification before delivery or registration. The existing emission_standard column is a denormalized string; a FK to compliance_emissions_certification n',
    `fleet_contract_id` BIGINT COMMENT 'Foreign key linking to sales.fleet_contract. Business justification: Fleet allocation reporting: finished vehicles committed under fleet contracts must be tracked against the contract for volume fulfillment and delivery scheduling. Automotive fleet operations require k',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: Vehicle approval: link each finished VIN to its homologation record required for market entry.',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: EV/ICE/hybrid production mix management and dealer allocation require powertrain-variant-level stock reporting. finished_vehicle_stock.powertrain_type is a denormalized plain attribute; a powertrain_v',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer to which the vehicle is allocated.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Finished vehicle stock traceability to production line is required for recall investigations, IATF 16949 quality audits, and line-level defect rate reporting. finished_vehicle_stock.production_line is',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Finished vehicles in yard/dealer stock are placed on hold when a recall is issued. The existing recall_flag and hold_code columns confirm recall awareness; a FK to recall_campaign identifies the speci',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Finished vehicles are physically stored at specific storage locations (PDI bays, finished goods yards, dealer staging areas). current_location_code (STRING) and location_type (STRING) are denormalized',
    `trim_level_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_trim_level. Business justification: Dealer allocation and production mix management require trim-level stock reporting (e.g., Base vs. Premium inventory levels). finished_vehicle_stock carries a denormalized trim_level plain attribute. ',
    `vehicle_allocation_id` BIGINT COMMENT 'Foreign key linking to dealer.vehicle_allocation. Business justification: OEM vehicle pipeline management: a finished vehicle stock unit is governed by exactly one dealer vehicle_allocation record that controls acceptance deadlines, PDI requirements, dealer invoice price, a',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Supports dealership allocation and program performance reports linking finished vehicles back to their engineering program.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Needed for Finished Vehicle Stock report linking each inventory vehicle to its VIN registry for warranty, recall, and regulatory compliance.',
    `aging_days` STRING COMMENT 'Number of days the vehicle has been in its current status.',
    `allocation_date` DATE COMMENT 'Date the vehicle was assigned to a dealer.',
    `batch_number` STRING COMMENT 'Internal production batch number associated with the vehicle.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_date` DATE COMMENT 'Actual date the vehicle left the plant or compound for the dealer/customer.',
    `expected_delivery_date` DATE COMMENT 'Planned delivery date based on logistics schedule.',
    `hold_code` STRING COMMENT 'Code indicating why a vehicle is on hold (e.g., quality, finance).',
    `hold_reason` STRING COMMENT 'Free‑text explanation for the hold code.',
    `lot_number` STRING COMMENT 'Batch identifier used for traceability of the vehicle batch.',
    `model_code` STRING COMMENT 'Manufacturers code representing the vehicle model (e.g., CX5, F150).',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` (
    `service_parts_stock_id` BIGINT COMMENT 'Unique identifier for the service parts stock record.',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Dealer parts inventory management: OEMs track service parts stock held at dealer service departments for parts fill rate reporting, replenishment programs, and warranty parts availability audits. A de',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Aftersales parts management requires knowing which vehicle model a service part applies to — for warranty provisioning, dealer parts ordering, and parts catalog management. Without this FK, service_pa',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Service parts inventory must be traceable to engineering part masters for supersession management, warranty compliance, and revision control. Automotive aftermarket operations require this link to val',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall remedy execution requires provisioning replacement parts at dealer/PDC level. Service parts stock must be linked to the driving recall campaign to support recall parts availability reporting, r',
    `service_center_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_center. Business justification: Service parts stock is physically held at or allocated to a specific service center. This FK enables real-time parts availability checks during appointment booking, service center stock reporting, and',
    `service_part_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_part. Business justification: service_parts_stock tracks physical inventory quantities; service_part is the aftersales catalog master with dealer net price, warranty eligibility, and lifecycle status. Linking them enables stock va',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Service parts stock tracks spare parts and accessories inventory. Each service parts stock record is for a specific part/SKU. The sku_master is the SSOT for all SKU definitions including service parts',
    `storage_location_id` BIGINT COMMENT 'Unique identifier of the warehouse or dealer location where the stock is held.',
    `warehouse_id` BIGINT COMMENT 'FK to inventory.warehouse',
    `aisle` STRING COMMENT 'Aisle identifier within the warehouse layout.',
    `batch_number` STRING COMMENT 'Identifier for the manufacturing batch of the part.',
    `bin_number` STRING COMMENT 'Alphanumeric identifier of the storage bin or pallet location.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of a single unit of the part in the local currency.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for cost values.. Valid values are `USD|EUR|JPY|CAD|GBP`',
    `cycle_count_status` STRING COMMENT 'Current status of the scheduled cycle count for the location.. Valid values are `due|overdue|completed`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
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
    `supersession_part_number` STRING COMMENT 'Part number that supersedes this part in the product lifecycle.',
    `valuation_method` STRING COMMENT 'Inventory valuation method applied to the part stock.. Valid values are `standard|fifo|lifo|average`',
    `warranty_expiration_date` DATE COMMENT 'Date when the parts warranty coverage ends.',
    `warranty_status` STRING COMMENT 'Current warranty coverage status of the part.. Valid values are `in_warranty|out_of_warranty`',
    CONSTRAINT pk_service_parts_stock PRIMARY KEY(`service_parts_stock_id`)
) COMMENT 'After-sales service parts inventory record tracking spare parts and accessories across the central parts distribution center (PDC), regional warehouses, and dealer parts rooms. Captures part number, supersession chain, current stock level by location, min/max replenishment levels, fill rate, backorder quantity, and obsolescence classification. Supports dealer parts ordering, warranty repair fulfillment, and TSB (Technical Service Bulletin) parts pre-positioning.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`movement_type` (
    `movement_type_id` BIGINT COMMENT 'Surrogate primary key for each inventory movement type record. [canonical_skip_reason: REFERENCE_LOOKUP - classification table for movement types]',
    `account_determination_relevant` BOOLEAN COMMENT 'Flag indicating whether the movement type triggers automatic account determination for financial posting.',
    `allowed_destination_location_type` STRING COMMENT 'Type of location permitted as the destination for this movement.',
    `allowed_source_location_type` STRING COMMENT 'Type of location permitted as the source for this movement (e.g., plant, warehouse, vendor).',
    `batch_management_required` BOOLEAN COMMENT 'Indicates if batch management must be maintained for movements of this type.',
    `movement_type_code` STRING COMMENT 'Alphanumeric code that uniquely identifies the movement type (e.g., 101 for goods receipt, 261 for goods issue).',
    `cost_center_required` BOOLEAN COMMENT 'Indicates if a cost center must be supplied when posting this movement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the movement type record was initially created in the source system.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `default_quantity_sign` STRING COMMENT 'Default sign (+1 or -1) applied to quantity for this movement type.',
    `movement_type_description` STRING COMMENT 'Human‑readable description of the movement type and its business purpose.',
    `direction` STRING COMMENT 'Indicates whether the movement adds stock (inbound), removes stock (outbound), or moves stock between locations (transfer).. Valid values are `inbound|outbound|transfer`',
    `effective_from` DATE COMMENT 'Date from which the movement type becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the movement type is no longer valid (null if open‑ended).',
    `hazardous_material_allowed` BOOLEAN COMMENT 'Indicates whether hazardous materials may be moved using this movement type.',
    `inventory_accounting_relevant` BOOLEAN COMMENT 'Flag indicating whether the movement type affects inventory valuation and accounting.',
    `inventory_impact` STRING COMMENT 'Indicates whether the movement increases, decreases, or does not change stock levels.. Valid values are `increase|decrease|neutral`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the movement type is currently active and usable in transactions.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether postings of this movement type can be generated automatically by system processes.',
    `is_deprecated` BOOLEAN COMMENT 'True if the movement type is deprecated and should not be used for new transactions.',
    `is_jis` BOOLEAN COMMENT 'True if the movement type supports Just‑In‑Sequence production scheduling.',
    `is_jit` BOOLEAN COMMENT 'True if the movement type is used in Just‑In‑Time procurement processes.',
    `is_lot_tracked` BOOLEAN COMMENT 'True if lot (batch) tracking is mandatory for this movement type.',
    `is_serial_tracked` BOOLEAN COMMENT 'True if serial number tracking is mandatory for this movement type.',
    `movement_category` STRING COMMENT 'High‑level category grouping of movement types.. Valid values are `goods_receipt|goods_issue|transfer|physical_inventory|adjustment`',
    `movement_reason_code` STRING COMMENT 'Optional code that provides additional reason for the movement (e.g., scrap, rework).',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the movement type.',
    `price_control` STRING COMMENT 'Method used for inventory valuation for this movement type.. Valid values are `standard|moving_average|none`',
    `profit_center_required` BOOLEAN COMMENT 'Indicates if a profit center must be supplied for this movement type.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether a quality inspection record is mandatory for this movement.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether movements of this type must be approved before posting.',
    `reversal_allowed` BOOLEAN COMMENT 'Flag indicating whether this movement type can be reversed by another movement.',
    `reversal_movement_type_code` STRING COMMENT 'Code of the movement type that reverses this movement (e.g., 102 reverses 101).',
    `serial_number_required` BOOLEAN COMMENT 'Indicates if serial numbers must be captured for this movement type.',
    `special_stock_indicator` STRING COMMENT 'Identifies special stock categories (e.g., blocked stock, quality inspection stock) associated with the movement.. Valid values are `none|blocked|quality|consignment|project`',
    `system_defined` BOOLEAN COMMENT 'True if the movement type is delivered by SAP and cannot be deleted.',
    `tax_relevant` BOOLEAN COMMENT 'Flag indicating whether tax calculation is applicable for this movement.',
    `transaction_event` STRING COMMENT 'Business event that typically generates this movement type (e.g., purchase order receipt, production order issue).. Valid values are `purchase|production|sales|transfer|physical_inventory|adjustment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the movement type record.',
    `valuation_class` STRING COMMENT 'Key used in valuation to determine price control and account assignment.',
    CONSTRAINT pk_movement_type PRIMARY KEY(`movement_type_id`)
) COMMENT 'Reference classification table defining all valid inventory movement types used in goods movement transactions. Captures movement type code, description, movement direction (inbound/outbound/transfer), account determination relevance, reversal movement type, and applicable business scenarios (e.g., 101=GR for PO, 261=GI for production order, 311=transfer posting). Aligned with SAP MM movement type configuration. Provides standardized classification for all goods movement transactions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`inventory`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Primary key for warehouse',
    `parent_warehouse_id` BIGINT COMMENT 'Self-referencing FK on warehouse (parent_warehouse_id)',
    `address_line1` STRING COMMENT 'First line of the warehouse street address.',
    `address_line2` STRING COMMENT 'Second line of the warehouse street address (optional).',
    `capacity_cubic_m` DECIMAL(18,2) COMMENT 'Total usable volume capacity in cubic meters.',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable floor space in square feet.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `close_date` DATE COMMENT 'Date when the warehouse ceased operations (null if still active).',
    `warehouse_code` STRING COMMENT 'External code used to reference the warehouse in ERP and logistics systems.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the warehouse resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `warehouse_description` STRING COMMENT 'Free‑form description providing additional details about the warehouse.',
    `effective_from` DATE COMMENT 'Date from which the warehouse information is considered effective.',
    `effective_until` DATE COMMENT 'Date until which the warehouse information remains effective (null for open‑ended).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the warehouse (decimal degrees).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the warehouse (decimal degrees).',
    `manager_email` STRING COMMENT 'Contact email address for the warehouse manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for warehouse operations.',
    `manager_phone` STRING COMMENT 'Contact phone number for the warehouse manager.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse.',
    `open_date` DATE COMMENT 'Date when the warehouse began operations.',
    `operating_hours` STRING COMMENT 'Standard daily operating hours (e.g., 08:00-17:00).',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the warehouse address.',
    `region` STRING COMMENT 'Higher‑level geographic region grouping (e.g., North America, EMEA).',
    `security_level` STRING COMMENT 'Security classification of the warehouse based on access controls and monitoring.',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the warehouse provides temperature‑controlled storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    `warehouse_status` STRING COMMENT 'Current lifecycle status of the warehouse.',
    `warehouse_type` STRING COMMENT 'Category of warehouse based on its primary function.',
    `zone` STRING COMMENT 'Internal zone or area identifier within the warehouse complex.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master reference table for warehouse. Referenced by warehouse_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_movement_type_id` FOREIGN KEY (`movement_type_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`movement_type`(`movement_type_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ADD CONSTRAINT `fk_inventory_stock_balance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_movement_type_id` FOREIGN KEY (`movement_type_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`movement_type`(`movement_type_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_reversal_of_movement_goods_movement_id` FOREIGN KEY (`reversal_of_movement_goods_movement_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_movement_type_id` FOREIGN KEY (`movement_type_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`movement_type`(`movement_type_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ADD CONSTRAINT `fk_inventory_mrp_requirement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ADD CONSTRAINT `fk_inventory_finished_vehicle_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`sku_master`(`sku_master_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ADD CONSTRAINT `fk_inventory_service_parts_stock_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_parent_warehouse_id` FOREIGN KEY (`parent_warehouse_id`) REFERENCES `vibe_automotive_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`sku_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`sku_master` SET TAGS ('dbx_subdomain' = 'stock_registry');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`sku_master` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`sku_master` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'stock_registry');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID (SLID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (WID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `agv_routing_priority` SET TAGS ('dbx_business_glossary_term' = 'AGV Routing Priority (AGV_PRIO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier (AISLE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier (BIN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Quantity (SCQ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO3)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|DEU|FRA|GBR');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Description (SLD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `external_system_source` SET TAGS ('dbx_business_glossary_term' = 'External System Source (ESS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `external_system_source` SET TAGS ('dbx_value_regex' = 'SAP_WM|Oracle_WMS|Custom');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Rating (FSR)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `hazardous_material_allowed` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Allowed Flag (HMAF)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `inventory_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Inventory Accuracy Percentage (IAP)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `is_default_location` SET TAGS ('dbx_business_glossary_term' = 'Default Location Flag (DLF)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `last_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Count Date (LICD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (SLC)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name (SLN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type (SLT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|rack|floor|cold_chain|automated|quarantine');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `rack` SET TAGS ('dbx_business_glossary_term' = 'Rack Identifier (RACK)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status (SLS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|closed');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TCF)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Celsius (TRC)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `used_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Used Capacity Percentage (UCP)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`storage_location` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone (WZ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Party Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `movement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `blocked_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `consignment_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `in_transit_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Is Serialized');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|consignment|in_transit|safety');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `physical_location_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Hierarchy');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `quality_inspection_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_business_glossary_term' = 'Stock Category');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `stock_category` SET TAGS ('dbx_value_regex' = 'raw_material|component|finished_good|service_part|spare_part');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `unrestricted_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Repair Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `reversal_of_movement_goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Movement ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `amount_local` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'USD Amount');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `destination_plant` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant (PLT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location (SL)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Movement Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `is_lot_tracked` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracked Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `is_serial_tracked` SET TAGS ('dbx_business_glossary_term' = 'Serial Tracked Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason (Reason)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason` SET TAGS ('dbx_value_regex' = 'Production|Sales|Repair|Scrap|Transfer');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (Qty)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type (RefDocType)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_value_regex' = 'PO|PR|WO|DO|SA');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `source_plant` SET TAGS ('dbx_business_glossary_term' = 'Source Plant (PLT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'Standard|MovingAverage|FIFO|LIFO');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order ID (STO_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Identifier (DST_PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `movement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `source_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Identifier (SRC_PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `agv_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Guided Vehicle Identifier (AGV_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Confirmation Status (CONFIRM_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount (COST_AMT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER_CD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (COST_CURR)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `execution_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp (EXEC_END_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp (EXEC_START_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions (HANDLING_INSTR)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (IS_HAZARDOUS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `is_jis` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Sequence Flag (IS_JIS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `is_jit` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Time Flag (IS_JIT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code (MOVE_REASON_CD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_value_regex' = 'stock_replenishment|production|maintenance|scrap|return|adjustment');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transfer Priority (PRIORITY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number (PROJ_NO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity (TRANSFER_QTY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Material Flag (IS_SERIALIZED)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `special_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Flag (IS_SPECIAL_HANDLING)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Status (TO_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_status` SET TAGS ('dbx_value_regex' = 'draft|planned|released|in_progress|completed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag (TEMP_CTRL_REQ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Creation Timestamp (TO_CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number (TO_NUM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type (TO_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'plant_to_plant|plant_to_warehouse|warehouse_to_warehouse|replenishment|return|adjustment');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`stock_transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX|PACK');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Requirement ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `batch_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Flag (BATCH_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source (DEMAND_SRC)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|sales_order|production|stock_transfer');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `exception_message` SET TAGS ('dbx_business_glossary_term' = 'Exception Message (EXC_MSG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days (LT_DAYS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity (LOT_SZ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Lifecycle Status (REQ_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `mrp_requirement_status` SET TAGS ('dbx_value_regex' = 'planned|released|cancelled|exception');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (PLAN_HORIZON)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario (PLAN_SCEN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'MPS|MRP|DRP');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code (PRIO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity (QTY_REQ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (ROP_QTY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Requirement Date (REQ_DATE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_business_glossary_term' = 'MRP Requirement Number (REQ_NO)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type (REQ_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'independent|dependent');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SS_QTY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply (SUPPLY_SRC)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`mrp_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Identifier');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (LOC_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification (ABC)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APP_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (APPROVER_ID)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `book_quantity` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity (BQ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `compliance_iatf16949_flag` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag (IATF_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `compliance_nhtsa_flag` SET TAGS ('dbx_business_glossary_term' = 'NHTSA Compliance Flag (NHTSA_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date (CD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_document_number` SET TAGS ('dbx_business_glossary_term' = 'Count Document Number (CDN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Count Frequency (DAYS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status (CS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|counted|posted|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type (CT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|partial|cycle');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity (CQ)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Inventory Category (INV_CAT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `inventory_category` SET TAGS ('dbx_value_regex' = 'raw_material|component|wip|finished_goods|service_part');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag (LOCK_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag (OBSOLETE_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `last_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Count Date (LAST_CD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Method (CC_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'manual|automated|RFID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `next_scheduled_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Count Date (NEXT_CD)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_doc_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Type (PID_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_doc_type` SET TAGS ('dbx_value_regex' = 'MI01|MI07');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Identifier (POSTED_BY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp (POSTED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag (RC_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Sequence Number (RC_NUM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (RMKS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (ROP_QTY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SS_QTY)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Flag (SN_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `storage_bin` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin Code (BIN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage (VPCT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance (QV)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`cycle_count` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason (VR)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` SET TAGS ('dbx_subdomain' = 'stock_registry');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `finished_vehicle_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Vehicle Stock ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Party Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `emissions_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Emissions Certification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `fleet_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Trim Level Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vehicle_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Allocation Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'in_production|pdi_pending|pdi_complete|allocated|in_transit|delivered');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`finished_vehicle_stock` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` SET TAGS ('dbx_subdomain' = 'stock_registry');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `service_parts_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Service Parts Stock ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `service_part_id` SET TAGS ('dbx_business_glossary_term' = 'Service Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CAD|GBP');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_value_regex' = 'due|overdue|completed');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `last_cost_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `last_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Count Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_reason` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Reason');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|pending');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_committed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Committed');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `shelf` SET TAGS ('dbx_business_glossary_term' = 'Shelf');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `supersession_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supersession Part Number');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'standard|fifo|lifo|average');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`service_parts_stock` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'in_warranty|out_of_warranty');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` SET TAGS ('dbx_subdomain' = 'movement_transactions');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Movement Type ID');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `account_determination_relevant` SET TAGS ('dbx_business_glossary_term' = 'Account Determination Relevant');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `allowed_destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Allowed Destination Location Type');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `allowed_source_location_type` SET TAGS ('dbx_business_glossary_term' = 'Allowed Source Location Type');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `batch_management_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code (MT)');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `cost_center_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `default_quantity_sign` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity Sign');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Description');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Movement Direction');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|transfer');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `hazardous_material_allowed` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Allowed');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `inventory_accounting_relevant` SET TAGS ('dbx_business_glossary_term' = 'Inventory Accounting Relevant');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `inventory_impact` SET TAGS ('dbx_business_glossary_term' = 'Inventory Impact');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `inventory_impact` SET TAGS ('dbx_value_regex' = 'increase|decrease|neutral');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Posting Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_jis` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Sequence Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_jit` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Time Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_lot_tracked` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `is_serial_tracked` SET TAGS ('dbx_business_glossary_term' = 'Serial Tracking Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_category` SET TAGS ('dbx_business_glossary_term' = 'Movement Category');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_category` SET TAGS ('dbx_value_regex' = 'goods_receipt|goods_issue|transfer|physical_inventory|adjustment');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Notes');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `price_control` SET TAGS ('dbx_business_glossary_term' = 'Price Control');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `price_control` SET TAGS ('dbx_value_regex' = 'standard|moving_average|none');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `profit_center_required` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `reversal_allowed` SET TAGS ('dbx_business_glossary_term' = 'Reversal Allowed');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `reversal_movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Movement Type Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `serial_number_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Required');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'none|blocked|quality|consignment|project');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `system_defined` SET TAGS ('dbx_business_glossary_term' = 'System Defined Flag');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevant');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `transaction_event` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `transaction_event` SET TAGS ('dbx_value_regex' = 'purchase|production|sales|transfer|physical_inventory|adjustment');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`movement_type` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'stock_registry');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Warehouse Id');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `capacity_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cubic M');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Capacity Sqft');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_automotive_v1`.`inventory`.`warehouse` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Zone');
