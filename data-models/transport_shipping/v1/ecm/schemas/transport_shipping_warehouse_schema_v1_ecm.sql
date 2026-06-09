-- Schema for Domain: warehouse | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`warehouse` COMMENT 'Governs all warehouse and distribution center operations including inbound receiving, putaway, slotting optimization, inventory control, order picking, packing, and outbound dispatch. Owns SKU master, FIFO/LIFO inventory positions, ASN processing, WIP tracking, labor productivity metrics, and returns management. Powered by Manhattan WMS and supports e-commerce fulfillment and contract logistics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the warehouse or distribution center facility. Primary key for the facility master record.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Facilities require operating licenses, safety certifications (ISO9001, ISO28000, CTPAT, AEO), customs bonds, and FTZ designations. Regulatory compliance requirement for warehouse operations, customs c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warehouse facilities are cost centers in logistics operations. Facility operating expenses (labor, utilities, maintenance, depreciation) must be allocated to cost centers for P&L reporting, budget var',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Facilities have operational managers responsible for safety, compliance, performance, and daily operations. Enables org charts, accountability tracking, performance reviews, and labor cost allocation.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Many warehouses are operated by 3PL providers under management contracts. Critical for contract billing, performance SLA tracking, operational escalations, and distinguishing client-owned vs. 3PL-oper',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution centers in 3PL operations function as profit centers, tracking warehousing service revenue against facility-specific costs. Required for facility-level P&L statements, EBITDA reporting by',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Warehouses operate as customs-registered trade parties (importer of record, FTZ operator, bonded warehouse operator). Links facility to customs registration for CBP bond tracking, C-TPAT certification',
    `address_line1` STRING COMMENT 'Primary street address line for the facility location. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `annual_ghg_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total annual greenhouse gas emissions from facility operations measured in tonnes of CO2 equivalent. Used for sustainability reporting and carbon footprint tracking.',
    `city` STRING COMMENT 'City or municipality where the facility is located. Organizational contact data classified as confidential.',
    `closed_date` DATE COMMENT 'Date when the facility ceased operations, if applicable. Null for active facilities.',
    `contact_email` STRING COMMENT 'Primary contact email address for the facility. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the facility. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the facility is located (e.g., USA, GBR, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system. Used for audit trail and data lineage.',
    `customs_bonded_warehouse` BOOLEAN COMMENT 'Indicates whether the facility is a customs bonded warehouse authorized to store imported goods before duties and taxes are paid.',
    `dock_door_count` STRING COMMENT 'Total number of loading and unloading dock doors available at the facility for inbound and outbound freight operations.',
    `facility_code` STRING COMMENT 'Externally-known unique business identifier for the facility, used across operational systems and customer communications. Typically a short alphanumeric code.. Valid values are `^[A-Z0-9]{3,10}$`',
    `facility_name` STRING COMMENT 'Human-readable name of the warehouse or distribution center facility.',
    `facility_type` STRING COMMENT 'Classification of the facility. DC = Distribution Center, CFS = Container Freight Station, ICD = Inland Container Depot, FTZ = Free Trade Zone, cross-dock = Cross-Docking Facility, fulfillment = E-Commerce Fulfillment Center.. Valid values are `DC|CFS|ICD|FTZ|cross-dock|fulfillment`',
    `ftz_designation` STRING COMMENT 'Official FTZ designation number if the facility operates within a free trade zone, allowing duty deferral and other trade benefits.',
    `has_cold_storage` BOOLEAN COMMENT 'Indicates whether the facility has refrigerated or frozen storage capabilities for temperature-sensitive goods.',
    `has_hazmat_storage` BOOLEAN COMMENT 'Indicates whether the facility is certified and equipped to store hazardous materials per IMDG Code and local regulations.',
    `is_aeo_certified` BOOLEAN COMMENT 'Indicates whether the facility holds AEO certification for trusted trader status and simplified customs procedures in the EU and partner countries.',
    `is_ctpat_certified` BOOLEAN COMMENT 'Indicates whether the facility holds C-TPAT certification for enhanced supply chain security and expedited customs processing.',
    `is_iso28000_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 28000 certification for supply chain security management.',
    `is_iso9001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 9001 certification for quality management systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last updated. Used for audit trail and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees for GPS tracking and route optimization.',
    `lease_expiration_date` DATE COMMENT 'Date when the current facility lease expires, if applicable. Used for real estate planning and contract renewal tracking.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees for GPS tracking and route optimization.',
    `max_daily_inbound_volume_units` STRING COMMENT 'Maximum number of units (pallets, cartons, or SKUs) the facility can receive and process in a single day. Used for capacity planning and load balancing.',
    `max_daily_outbound_volume_units` STRING COMMENT 'Maximum number of units (pallets, cartons, or SKUs) the facility can pick, pack, and ship in a single day. Used for capacity planning and order fulfillment forecasting.',
    `opened_date` DATE COMMENT 'Date when the facility first became operational. Used for lifecycle tracking and depreciation calculations.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays in format HH:MM-HH:MM (e.g., 08:00-18:00). Used for scheduling inbound and outbound operations.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends in format HH:MM-HH:MM. May be different from weekday hours or closed.',
    `operational_status` STRING COMMENT 'Current operational lifecycle status of the facility.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|maintenance`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address. Organizational contact data classified as confidential.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of facility energy consumption sourced from renewable energy (solar, wind, etc.). Used for sustainability KPIs and environmental reporting.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the facility is located. Organizational contact data classified as confidential.',
    `storage_capacity_cbm` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the facility in cubic meters. CBM is a standard logistics measurement for warehouse capacity.',
    `temperature_zone_count` STRING COMMENT 'Number of distinct temperature-controlled zones within the facility (e.g., ambient, refrigerated, frozen) for specialized inventory storage.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility location (e.g., America/New_York, Europe/London) used for scheduling and operational hours.',
    `total_floor_area_sqm` DECIMAL(18,2) COMMENT 'Total usable floor area of the facility measured in square meters, used for capacity planning and utilization analysis.',
    `wms_instance_code` STRING COMMENT 'Identifier of the Manhattan WMS instance managing this facility. Used for system integration and operational tracking.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for each warehouse and distribution center operated by Transport Shipping. Captures physical facility attributes including location, type (DC, CFS, ICD, FTZ, cross-dock), total floor area in CBM, dock door count, temperature zones, WMS instance identifier, operating hours, capacity thresholds, and certifications (C-TPAT, AEO, ISO 9001). SSOT for warehouse identity referenced across all warehouse domain products.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the warehouse management system. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the parent warehouse or distribution center facility where this storage location resides.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Specific storage locations (hazmat zones, confined spaces, high-rack areas) require documented location-specific hazard assessments. Safety officers conduct risk assessments for each location type, fe',
    `zone_id` BIGINT COMMENT 'Reference to the logical zone within the warehouse to which this storage location is assigned.',
    `active_from_date` DATE COMMENT 'Date when this storage location became active and available for warehouse operations.',
    `active_to_date` DATE COMMENT 'Date when this storage location was deactivated or retired from warehouse operations. Null if currently active.',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse where the storage location is physically situated. Used for route optimization and labor management.. Valid values are `^[A-Z0-9]{1,10}$`',
    `automation_type` STRING COMMENT 'Level and type of automation technology deployed at this storage location. Impacts labor planning and throughput capacity.. Valid values are `manual|semi_automated|fully_automated|robotic|automated_storage_retrieval_system|conveyor_integrated`',
    `bin` STRING COMMENT 'Specific bin or slot position within the level. Represents the most granular storage position.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether this storage location is within a bonded warehouse zone where goods are stored without payment of customs duties until released for domestic consumption.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the Manhattan Warehouse Management System (WMS).',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this storage location is used for cross-docking operations where inbound shipments are directly transferred to outbound without long-term storage.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for physical inventory cycle counting at this storage location. Supports inventory accuracy and compliance with ISO 9001 quality management.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `fire_suppression_zone` STRING COMMENT 'Fire suppression system zone identifier covering this storage location. Critical for safety compliance and insurance requirements.. Valid values are `^[A-Z0-9]{1,10}$`',
    `free_trade_zone_flag` BOOLEAN COMMENT 'Indicates whether this storage location is within a Free Trade Zone (FTZ) where goods can be stored, processed, or re-exported without customs intervention.',
    `hazmat_class_permitted` STRING COMMENT 'Comma-separated list of International Maritime Organization (IMO) hazard classes permitted in this storage location (e.g., 1.1, 2.2, 3, 4.1, 5.1, 6.1, 8, 9). Empty if not hazmat suitable.',
    `hazmat_suitable` BOOLEAN COMMENT 'Indicates whether the storage location is certified and equipped for storing hazardous materials per International Maritime Dangerous Goods (IMDG) Code and International Civil Aviation Organization (ICAO) Technical Instructions.',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height dimension of the storage location in centimeters.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent physical cycle count was performed at this storage location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated in the Manhattan Warehouse Management System (WMS).',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length dimension of the storage location in centimeters.',
    `location_barcode` STRING COMMENT 'Scannable barcode identifier for the storage location used by handheld Radio Frequency Identification (RFID) devices and mobile scanning equipment during warehouse operations.. Valid values are `^[0-9]{8,20}$`',
    `location_code` STRING COMMENT 'Human-readable unique code identifying the storage location within the warehouse. Used for directed putaway and picking operations in Manhattan Warehouse Management System (WMS).. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_status` STRING COMMENT 'Current operational status of the storage location indicating availability for putaway and picking operations.. Valid values are `active|inactive|blocked|maintenance|damaged|reserved`',
    `location_type` STRING COMMENT 'Physical storage infrastructure type defining the structural characteristics and handling requirements of the location. [ENUM-REF-CANDIDATE: pallet_rack|floor_stack|shelf|bin|drive_in|push_back|flow_rack|cantilever|mezzanine|automated_storage_retrieval — 10 candidates stripped; promote to reference product]',
    `occupancy_status` STRING COMMENT 'Current inventory occupancy state of the storage location based on capacity utilization.. Valid values are `empty|partially_occupied|fully_occupied|over_allocated`',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this location is designated as a pick-face position for order fulfillment operations. Pick-face locations are optimized for high-velocity Stock Keeping Units (SKUs).',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated for quarantine inventory pending quality inspection, customs clearance, or Return Merchandise Authorization (RMA) processing.',
    `rack` STRING COMMENT 'Rack or bay identifier within the aisle where the storage location is positioned.. Valid values are `^[A-Z0-9]{1,10}$`',
    `replenishment_flag` BOOLEAN COMMENT 'Indicates whether this location requires periodic replenishment from bulk storage. Used in First In First Out (FIFO) and Last In First Out (LIFO) inventory management strategies.',
    `returns_processing_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated for processing customer returns and Return Merchandise Authorization (RMA) inventory.',
    `security_level` STRING COMMENT 'Security classification of the storage location. High-value and bonded locations require additional access controls per Customs-Trade Partnership Against Terrorism (C-TPAT) and Authorized Economic Operator (AEO) programs.. Valid values are `standard|restricted|high_value|controlled_access|bonded`',
    `storage_location_level` STRING COMMENT 'Vertical level or shelf position within the rack structure. Used for slotting optimization based on Stock Keeping Unit (SKU) velocity and weight.. Valid values are `^[A-Z0-9]{1,5}$`',
    `temperature_class` STRING COMMENT 'Temperature control classification of the storage location. Critical for cold-chain logistics and pharmaceutical shipments.. Valid values are `ambient|chilled|frozen|controlled|deep_freeze`',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Celsius for the storage location. Used for cold-chain compliance and quality assurance.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Celsius for the storage location. Used for cold-chain compliance and quality assurance.',
    `value_added_services_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated for value-added services such as kitting, labeling, repackaging, or customization operations.',
    `volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location in cubic meters. Used for dimensional weight (DIM Weight) calculations and space optimization.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms. Used for slotting optimization and safety compliance.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width dimension of the storage location in centimeters.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Granular storage location and zone master within a facility representing every bin, slot, rack, bay, aisle, floor position, and logical zone managed by Manhattan WMS. Tracks location code, zone assignment, zone type (receiving, bulk, pick-face, staging, dispatch, cold-chain, hazmat, quarantine, returns, VAS), aisle, rack, level, bin, location type, weight/volume capacity, temperature class, hazmat suitability, automation type, and current occupancy status. After merge with zone, also carries zone-level attributes (floor area, height, temperature range). Enables slotting optimization, directed putaway, and compliance segregation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the stock keeping unit. Primary key for the SKU master data product.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: SKUs require certificates of origin, phytosanitary certificates, quality certificates, and product compliance certificates for international trade. Customs/regulatory requirement for cross-border ship',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: In 3PL transport/shipping, SKUs are customer-specific (each customer has their own product catalog). Links SKU to owning customer account, enabling customer-specific SKU management, catalog isolation,',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Hazmat SKUs require documented hazard assessments per IMDG/ADR/49CFR regulations. Warehouse managers verify hazard register entries exist before accepting dangerous goods for storage. Critical for reg',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: SKUs require binding HS tariff classifications for customs compliance. Links product master to approved classification for duty calculation, trade agreement eligibility, import/export license determin',
    `abc_classification` STRING COMMENT 'The ABC inventory classification (A=high-value/high-velocity, B=medium, C=low) used for prioritization and slotting optimization.. Valid values are `A|B|C`',
    `active_from_date` DATE COMMENT 'The date from which this SKU became active and available for warehouse operations.',
    `active_to_date` DATE COMMENT 'The date on which this SKU was discontinued or became inactive. Null if currently active.',
    `barcode` STRING COMMENT 'The primary barcode identifier (UPC, EAN, or other format) used for scanning and automated identification in warehouse operations.',
    `barcode_type` STRING COMMENT 'The barcode symbology or format type used for this SKU (UPC, EAN, CODE128, etc.).. Valid values are `UPC|EAN|CODE128|CODE39|QR|other`',
    `country_of_origin` STRING COMMENT 'The three-letter ISO country code representing the country where the product was manufactured or produced, required for customs and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SKU record was first created in the warehouse management system.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'The dimensional weight of the SKU in kilograms, calculated using industry-standard DIM weight factors for freight rating and space optimization.',
    `expiry_date_required` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU requires expiry date tracking for inventory management and FEFO rotation.',
    `fragile` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is fragile and requires special handling to prevent damage.',
    `hazmat_class` STRING COMMENT 'The hazardous materials classification code per IMDG or ICAO standards if the SKU contains dangerous goods. Null if non-hazardous.',
    `height_cm` DECIMAL(18,2) COMMENT 'The height dimension of the SKU in centimeters, used for slotting optimization and space planning.',
    `hs_code` STRING COMMENT 'The Harmonized System tariff classification code used for customs declarations, duty calculation, and international trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `inventory_method` STRING COMMENT 'The inventory valuation and rotation method applied to this SKU: FIFO (First In First Out), LIFO (Last In First Out), FEFO (First Expired First Out), or standard.. Valid values are `FIFO|LIFO|FEFO|standard`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this SKU record was last updated or modified in the warehouse management system.',
    `length_cm` DECIMAL(18,2) COMMENT 'The length dimension of the SKU in centimeters, used for slotting optimization and space planning.',
    `lot_tracking_required` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU requires lot or batch number tracking for traceability and quality control.',
    `manufacturer_name` STRING COMMENT 'The name of the manufacturer or producer of this SKU, used for quality tracking and compliance.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers own part number or SKU identifier for this item, used for cross-referencing and procurement.',
    `max_stack_height` STRING COMMENT 'The maximum number of units that can be safely stacked vertically. Null if not stackable or no limit.',
    `pick_type` STRING COMMENT 'The standard picking method or unit used for order fulfillment of this SKU (each-pick, case-pick, pallet-pick, or bulk).. Valid values are `each|case|pallet|bulk`',
    `product_category` STRING COMMENT 'High-level classification category for this SKU used for inventory segmentation, slotting optimization, and reporting.',
    `product_subcategory` STRING COMMENT 'Detailed subcategory classification within the product category for granular inventory management and analytics.',
    `reorder_point` STRING COMMENT 'The inventory quantity threshold that triggers replenishment or reorder action for this SKU.',
    `rfid_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is tagged with RFID technology for automated tracking and inventory visibility.',
    `rfid_tag_code` STRING COMMENT 'The RFID tag identifier or Electronic Product Code (EPC) associated with this SKU for automated identification.',
    `safety_stock_quantity` STRING COMMENT 'The minimum buffer inventory quantity maintained to prevent stockouts and ensure service level for this SKU.',
    `serial_tracking_required` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU requires individual serial number tracking at the unit level for high-value or regulated items.',
    `shelf_life_days` STRING COMMENT 'The number of days from receipt or manufacture date that the SKU remains usable or saleable before expiration. Null for non-perishable items.',
    `sku_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying this SKU across all warehouse operations and systems. Used for scanning, picking, and inventory transactions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sku_description` STRING COMMENT 'Detailed human-readable description of the product or item represented by this SKU, including key characteristics and specifications.',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU indicating whether it is available for warehouse operations, discontinued, or pending activation.. Valid values are `active|inactive|discontinued|pending|obsolete`',
    `stackable` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU can be safely stacked vertically in storage and transport.',
    `storage_class` STRING COMMENT 'The warehouse storage class or zone assignment for this SKU based on handling requirements, velocity, and physical characteristics (e.g., fast-pick, bulk, secure, hazmat).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'The maximum allowable storage temperature in Celsius for temperature-controlled SKUs. Null for ambient items.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'The minimum allowable storage temperature in Celsius for temperature-controlled SKUs. Null for ambient items.',
    `temperature_requirement` STRING COMMENT 'The temperature control requirement for storing and handling this SKU, determining warehouse zone assignment.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the hazardous substance if applicable, used for compliance with international dangerous goods regulations.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The standard unit of measure used for inventory counting, picking, and tracking of this SKU.. Valid values are `each|case|pallet|box|carton|unit`',
    `velocity_code` STRING COMMENT 'The movement velocity classification indicating how frequently this SKU is picked or shipped (fast, medium, slow movers).. Valid values are `fast|medium|slow`',
    `vendor_code` STRING COMMENT 'The code or identifier of the primary vendor or supplier for this SKU, used for procurement and replenishment.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the SKU in cubic meters, calculated or measured for warehouse space utilization and freight planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'The actual gross weight of the SKU in kilograms, used for handling, labor planning, and freight calculations.',
    `width_cm` DECIMAL(18,2) COMMENT 'The width dimension of the SKU in centimeters, used for slotting optimization and space planning.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock Keeping Unit master — the authoritative product catalog for all items stored and handled within warehouse operations. Captures SKU code, description, product category, unit of measure, dimensions (length, width, height), weight, DIM weight factor, hazmat class (IMDG/ICAO), temperature requirement, country of origin, HS Code reference, FIFO/LIFO indicator, shelf life days, barcode/RFID identifiers, and storage class. SSOT for item identity within the warehouse domain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Unique identifier for the inventory position record. Primary key for this entity.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Inventory positions in 3PL warehouses are owned by customer accounts (shippers/sellers). Replaces denormalized owner_code string with proper FK. Essential for customer-specific inventory reporting, bi',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the inventory is held.',
    `ftz_inventory_id` BIGINT COMMENT 'Foreign key linking to customs.ftz_inventory. Business justification: Inventory stored in Foreign Trade Zones must be tracked in FTZ inventory records for CBP compliance. Links warehouse position to FTZ admission for duty deferral tracking, zone lot management, and week',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Storage charges are calculated per SKU/pallet position (daily or monthly) and invoiced to customers. Inventory_position is the unit of storage billing; direct invoice link needed for billing reconcili',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Inventory positions MUST reference the authoritative SKU master. Currently inventory_position has sku STRING field (denormalized sku_code) but lacks proper FK to sku.sku_id. Adding sku_id enables JOIN',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: Inventory positions MUST reference the authoritative storage location master. Currently inventory_position has storage_location_code STRING field (denormalized) but lacks proper FK to storage_location',
    `asn_number` STRING COMMENT 'Reference number of the Advanced Shipping Notice that announced the arrival of this inventory. Links received inventory to inbound shipment documentation.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity available for allocation to new orders. Calculated as on-hand minus reserved, quarantine, hold, damaged, and expired quantities.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard or actual cost per unit of the inventory item. Used for inventory valuation, cost of goods sold calculations, and financial reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the product was manufactured or produced. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory position record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per unit value. Standard codes include USD, EUR, GBP, CNY, JPY.. Valid values are `^[A-Z]{3}$`',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'Quantity identified as physically damaged or defective. Typically segregated for disposal, return to vendor, or salvage processing.',
    `expiry_date` DATE COMMENT 'Date when the inventory item expires or becomes unusable. Critical for perishable goods, pharmaceuticals, and time-sensitive products. Drives FEFO (First Expired First Out) allocation logic.',
    `fifo_sequence_number` STRING COMMENT 'Sequential number assigned based on receipt date to enforce FIFO picking logic. Lower numbers are picked first to ensure oldest inventory is consumed before newer stock.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the inventory item is classified as hazardous material requiring special handling, storage, and transportation compliance.',
    `hold_quantity` DECIMAL(18,2) COMMENT 'Quantity placed on administrative hold due to customer disputes, regulatory issues, or business decisions. Not available for allocation.',
    `hs_code` STRING COMMENT 'International tariff classification code used for customs clearance and duty calculation. Six to ten digit code standardized by the World Customs Organization.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity currently being moved within the facility between storage locations. Temporarily unavailable during putaway or replenishment operations.',
    `inventory_status` STRING COMMENT 'Current status of the inventory position indicating availability for order fulfillment. Available = ready for allocation; Reserved = committed to orders; Quarantine = pending quality inspection; Hold = administrative block; Damaged = physically impaired; Expired = past expiration date.. Valid values are `available|reserved|quarantine|hold|damaged|expired`',
    `last_cycle_count_date` DATE COMMENT 'Date when the inventory position was last physically counted during cycle count operations. Used to schedule next count and track inventory accuracy.',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction affecting this position (receipt, pick, adjustment, transfer). Used for slow-moving inventory analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this inventory position record. Used for real-time inventory synchronization and change tracking.',
    `lifo_sequence_number` STRING COMMENT 'Sequential number assigned based on receipt date to enforce LIFO picking logic. Higher numbers are picked first to ensure newest inventory is consumed before older stock.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability and quality control. Used for FIFO/LIFO inventory management and product recalls.',
    `manufacture_date` DATE COMMENT 'Date when the product was manufactured or produced. Used for traceability, quality control, and shelf-life calculations.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Total physical quantity of the SKU present at the storage location, regardless of availability status. Includes available, reserved, quarantine, hold, and damaged quantities.',
    `pick_face_indicator` BOOLEAN COMMENT 'Flag indicating whether this inventory position is in an active pick face location (forward pick area) versus reserve storage. Pick face locations are optimized for high-velocity picking.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order under which this inventory was procured. Used for receiving verification and supplier reconciliation.',
    `putaway_zone` STRING COMMENT 'Warehouse zone designation where the inventory was placed during putaway operations. Used for slotting optimization and pick path planning.',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity held for quality inspection or pending release approval. Not available for order fulfillment until cleared.',
    `receipt_date` DATE COMMENT 'Date when the inventory was received into the facility. Used for FIFO/LIFO sequencing and aging analysis.',
    `replenishment_trigger_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity threshold that triggers automatic replenishment from reserve storage to pick face. Used to maintain optimal pick face inventory levels.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity committed to existing orders or work orders but not yet picked. Reduces available quantity for new allocations.',
    `serial_number` STRING COMMENT 'Unique serial number for individual item-level tracking. Used for high-value or serialized inventory items.',
    `sku` STRING COMMENT 'Unique product identifier used for inventory tracking and order fulfillment. The SKU code that identifies the specific product variant.',
    `supplier_code` STRING COMMENT 'Identifier of the vendor or supplier who provided this inventory. Used for supplier performance tracking and quality traceability.',
    `temperature_controlled_indicator` BOOLEAN COMMENT 'Flag indicating whether the inventory requires temperature-controlled storage (refrigerated or frozen). Drives storage zone assignment and handling requirements.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Maximum acceptable storage temperature for temperature-controlled inventory. Used to monitor cold chain compliance.',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Minimum acceptable storage temperature for temperature-controlled inventory. Used to monitor cold chain compliance.',
    `temperature_uom` STRING COMMENT 'Unit of measure for temperature range values. Standard units are celsius or fahrenheit.. Valid values are `celsius|fahrenheit`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials. Required for dangerous goods shipping compliance under IMDG, IATA, and DOT regulations.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit in which inventory quantities are tracked and reported. Standard units include each (individual items), case (inner pack), pallet (shipping unit), carton, box, or generic unit.. Valid values are `each|case|pallet|carton|box|unit`',
    `volume_per_unit` DECIMAL(18,2) COMMENT 'Physical volume or cubic measurement of a single unit of the SKU. Used for warehouse space planning, slotting optimization, and freight rating.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume per unit value. Standard units include CBM (cubic meter), CFT (cubic foot), liter, gallon.. Valid values are `cbm|cft|liter|gallon`',
    `weight_per_unit` DECIMAL(18,2) COMMENT 'Physical weight of a single unit of the SKU. Used for dimensional weight calculations, freight rating, and capacity planning.',
    `weight_uom` STRING COMMENT 'Unit of measure for the weight per unit value. Standard units include kg (kilogram), lb (pound), g (gram), oz (ounce), ton (short ton), mt (metric ton).. Valid values are `kg|lb|g|oz|ton|mt`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Real-time and point-in-time inventory position record for each SKU at each storage location within a facility. Tracks on-hand quantity, available quantity, reserved quantity, quarantine quantity, damaged quantity, lot number, serial number, expiry date, receipt date, FIFO/LIFO sequence number, inventory status (available, hold, damaged, expired), and last cycle count date. Core operational record powering WMS inventory control and order fulfillment allocation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` (
    `warehouse_asn_id` BIGINT COMMENT 'Unique identifier for the advanced shipping notice record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Inbound shipments arrive under specific contract terms governing receiving SLAs, handling requirements, and cost allocation. Receiving teams validate contract compliance; billing systems allocate inbo',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: ASNs track inbound carrier costs via contracted buy rates. Business need: Inbound freight cost allocation, carrier performance vs. contracted rates, landed cost calculation, freight audit and payment ',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the shipment from origin to destination.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: ASNs specify exact carrier service level (express/standard/economy) for inbound dock scheduling, labor planning, and receiving prioritization. Service level determines handling requirements and expect',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: In 3PL logistics, ASNs represent inbound inventory on behalf of customer accounts (inventory owners). Links ASN to the customer whose goods are being received, enabling customer-specific receiving wor',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: International inbound shipments require customs import declarations before warehouse receipt. ASN triggers customs filing; linking enables compliance verification, duty reconciliation, and clearance s',
    `facility_id` BIGINT COMMENT 'Identifier of the receiving warehouse or distribution center where the ASN shipment will arrive.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Inbound freight planning assigns ASNs to specific transport lanes for carrier booking, transit time calculation, and cost allocation. Lane assignment drives dock scheduling and receiving resource plan',
    `origin_facility_id` BIGINT COMMENT 'Identifier of the facility, warehouse, or distribution center from which the shipment originates.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: ASNs originating from cross-dock hubs or consolidation gateways in multi-leg inbound flows. Tracks origin point for transit time calculation, carrier performance measurement, and inbound network visib',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor sending the inbound shipment. Primary party responsible for the ASN.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: ASNs track the inbound truck/trailer delivering goods. Essential for receiving dock scheduling, cross-docking decisions, yard management, and linking inbound freight movements to warehouse receipts. C',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: ASNs generate transport documents (packing lists, delivery notes, advance shipping notices) as standard shipping documentation. Essential for carrier coordination, customs clearance, and proof-of-ship',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shipment physically arrived at the receiving facility. Used for performance tracking and SLA compliance.',
    `appointment_number` STRING COMMENT 'Dock appointment or slot reservation number for this ASN. Links to yard management system scheduling.',
    `asn_number` STRING COMMENT 'Externally-known unique business identifier for the ASN, typically shared with suppliers and carriers. Used for cross-system tracking and communication.. Valid values are `^ASN[0-9]{10,15}$`',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN. Tracks progression from initial notification through final receipt or cancellation.. Valid values are `pending|in_transit|partially_received|fully_received|cancelled|exception`',
    `bill_of_lading_number` STRING COMMENT 'Master or house bill of lading number associated with this ASN. Links to freight documentation.',
    `carrier_reference_number` STRING COMMENT 'Tracking or reference number assigned by the carrier for this shipment. Used for cross-referencing with carrier systems.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN was marked as fully received or closed. Indicates completion of the receiving process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN record was first created in the system. Represents when the advance notice was received.',
    `customs_entry_number` STRING COMMENT 'Customs declaration or entry number for international shipments. Required for cross-border compliance tracking.',
    `dock_door_assignment` STRING COMMENT 'Specific receiving dock door assigned for unloading this ASN shipment. Supports yard management and labor dispatch.',
    `edi_transmission_reference` STRING COMMENT 'Unique identifier for the EDI 856 (ASN) transmission that created this record. Used for EDI audit trail and troubleshooting.',
    `expected_arrival_date` DATE COMMENT 'Planned date when the shipment is expected to arrive at the destination facility. Used for receiving dock scheduling.',
    `expected_arrival_time` TIMESTAMP COMMENT 'Precise timestamp when the shipment is expected to arrive at the destination facility. Enables detailed dock appointment scheduling.',
    `incoterm` STRING COMMENT 'International commercial term defining the division of costs and risks between buyer and seller. Impacts customs and duty responsibility. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether the shipment contains hazardous materials requiring special handling and compliance documentation.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Flag indicating whether the shipment requires temperature-controlled handling (refrigerated or frozen).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN record was last updated. Tracks changes to status, quantities, or other attributes throughout the receiving lifecycle.',
    `pro_number` STRING COMMENT 'Progressive number assigned by LTL carriers for tracking and freight billing. Common in less-than-truckload shipments.',
    `purchase_order_number` STRING COMMENT 'Primary purchase order number associated with this ASN. Links the inbound shipment to procurement records.',
    `received_carton_count` STRING COMMENT 'Actual number of cartons received and verified at the destination facility. Used for variance analysis against expected count.',
    `received_pallet_count` STRING COMMENT 'Actual number of pallets received and verified at the destination facility. Used for variance analysis against expected count.',
    `receiving_notes` STRING COMMENT 'Free-text notes captured by receiving personnel during the unloading and inspection process. Documents exceptions or observations.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer. Used for tamper detection and customs compliance.',
    `ship_date` DATE COMMENT 'Date when the shipment departed from the origin facility or supplier location.',
    `shipment_priority` STRING COMMENT 'Priority level assigned to this inbound shipment. Determines receiving dock scheduling sequence and resource allocation.. Valid values are `standard|expedited|urgent|critical`',
    `source_system` STRING COMMENT 'Name of the originating system that generated the ASN (e.g., supplier ERP, TMS, 3PL system). Used for data lineage and integration troubleshooting.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as fragile items, top-load only, or security protocols.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance.',
    `total_carton_count` STRING COMMENT 'Total number of cartons or boxes included in this ASN shipment. Used for receiving verification and labor planning.',
    `total_line_count` STRING COMMENT 'Total number of distinct SKU line items included in this ASN. Used for receiving complexity assessment.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets included in this ASN shipment. Used for dock space allocation and material handling equipment planning.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for warehouse space planning and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms. Used for capacity planning and freight cost validation.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this inbound shipment.. Valid values are `air|ocean|road|rail|intermodal|parcel`',
    `variance_reason_code` STRING COMMENT 'Standardized code indicating the reason for any discrepancy between expected and received quantities or condition.. Valid values are `overage|shortage|damage|mislabel|quality_issue|none`',
    CONSTRAINT pk_warehouse_asn PRIMARY KEY(`warehouse_asn_id`)
) COMMENT 'Advanced Shipping Notice — inbound shipment notification received from suppliers, carriers, or origin facilities prior to physical arrival at the warehouse. Captures ASN number, origin party, expected arrival date/time, carrier reference, transport mode, total carton count, total pallet count, total weight, total CBM, associated purchase order references, and ASN status (pending, partially received, fully received, cancelled). Drives receiving dock scheduling and labor planning in Manhattan WMS.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` (
    `asn_line_id` BIGINT COMMENT 'Primary key for asn_line',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the warehouse user or employee who performed the receiving transaction. Used for labor tracking and accountability.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master. Identifies the specific product item expected on this ASN line.',
    `storage_location_id` BIGINT COMMENT 'Foreign key reference to the destination warehouse or distribution center. Identifies where this ASN line will be received and stored.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier or vendor providing this shipment. Used for supplier performance tracking and quality management.',
    `warehouse_asn_id` BIGINT COMMENT 'Foreign key reference to the parent ASN header document. Links this line to the overall inbound shipment notification.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured or produced. Required for customs compliance and trade documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN line record was first created in the warehouse management system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Enables multi-currency inventory valuation and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_notes` STRING COMMENT 'Free-text notes describing the nature of any receiving discrepancy. Provides additional context for exception resolution and claims processing.',
    `discrepancy_reason_code` STRING COMMENT 'Code indicating the type of discrepancy between expected and received quantities. Used for root cause analysis and supplier performance tracking.. Valid values are `overage|shortage|damage|wrong_item|quality_issue|none`',
    `expected_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU expected to be received as declared in the ASN. Used for receiving reconciliation against actual received quantity.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive inventory. Used for FIFO/FEFO (First Expired First Out) inventory rotation and shelf-life management.',
    `hazmat_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item contains hazardous materials requiring special handling. True if hazardous, False otherwise.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the product. Required for customs clearance, duty calculation, and international trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN line record was last updated. Audit trail for change tracking and data governance.',
    `line_number` STRING COMMENT 'Sequential line number within the ASN document. Determines the ordering and position of this line item in the shipment notice.',
    `line_status` STRING COMMENT 'Current processing status of the ASN line. Tracks the lifecycle from pending receipt through completion or exception handling.. Valid values are `pending|in_progress|received|discrepancy|cancelled`',
    `lot_number` STRING COMMENT 'Manufacturer or supplier lot number for traceability and quality control. Critical for First In First Out (FIFO) inventory management and product recalls.',
    `manufacture_date` DATE COMMENT 'Date the product was manufactured. Used for quality control, warranty tracking, and regulatory compliance.',
    `purchase_order_line_number` STRING COMMENT 'Specific line number on the purchase order that corresponds to this ASN line. Enables line-level reconciliation between PO, ASN, and receipt.',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order that authorized this inbound shipment. Links ASN to procurement documents for three-way matching (PO, ASN, invoice).',
    `putaway_location` STRING COMMENT 'Designated storage location (bin, slot, or zone) where the received inventory will be placed. Assigned during receiving or putaway process.',
    `putaway_timestamp` TIMESTAMP COMMENT 'Date and time when the received inventory was placed into its designated storage location. Marks completion of the inbound process.',
    `quality_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether this line item requires quality inspection before putaway. True if inspection is mandatory, False otherwise.',
    `quality_inspection_status` STRING COMMENT 'Current status of quality inspection for this line item. Tracks the inspection lifecycle from pending through final disposition.. Valid values are `not_required|pending|in_progress|passed|failed|conditional`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of the SKU physically received at the warehouse. Used to identify discrepancies against expected quantity.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was physically received at the warehouse. Represents the actual business event time for receiving completion.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items. Enables unit-level tracking for high-value or regulated products.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for temperature-sensitive products. Used for cold chain compliance monitoring.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for temperature-sensitive products. Used for cold chain compliance monitoring.',
    `temperature_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether this line item requires temperature-controlled storage. True if cold chain management is required, False otherwise.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying hazardous materials for transportation and storage compliance. Required for dangerous goods handling.. Valid values are `^UN[0-9]{4}$`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for the SKU on this ASN line. Used for inventory valuation, cost of goods sold (COGS) calculation, and financial reporting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the expected and received quantities. Standard warehouse UOM codes such as Each (EA), Case (CS), Pallet (PL), Carton (CTN), Box (BOX), or Package (PKG).. Valid values are `EA|CS|PL|CTN|BOX|PKG`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the line item in cubic meters. Used for warehouse space planning, slotting optimization, and freight cost calculations.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the line item in kilograms. Used for capacity planning, freight cost allocation, and dimensional weight calculations.',
    CONSTRAINT pk_asn_line PRIMARY KEY(`asn_line_id`)
) COMMENT 'Line-level detail of an Advanced Shipping Notice representing each SKU expected on an inbound delivery. Captures ASN line number, SKU reference, expected quantity, unit of measure, lot number, expiry date, country of origin, HS Code, and line status. Enables granular receiving reconciliation and discrepancy tracking against actual received quantities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for the inbound receipt record.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier that delivered the goods to the warehouse.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Physical receipt of imported goods must reconcile with customs clearance documentation. Links receipt to import declaration for duty payment verification, customs hold resolution, and regulatory audit',
    `dock_appointment_id` BIGINT COMMENT 'Foreign key linking to warehouse.dock_appointment. Business justification: Inbound receipts are executed against scheduled dock appointments. Currently inbound_receipt has appointment_number STRING field but lacks proper FK to dock_appointment.dock_appointment_id. Adding doc',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Inbound receipts record the driver who delivered goods. Required for proof-of-delivery verification, driver detention time tracking, security audit trails, and linking warehouse receiving events to dr',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where goods are being received.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who processed the inbound receipt. Used for accountability and labor tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received. Links receipt to procurement transaction.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Receipt operations reference delivery notes, CMRs, proof-of-delivery documents for verification against expected shipments. Critical for discrepancy resolution, carrier claims, and goods-received audi',
    `warehouse_asn_id` BIGINT COMMENT 'Reference to the Advanced Shipping Notice that preceded this receipt. Used for variance analysis between expected and actual goods received.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier arrived at the warehouse gate or dock. Used for on-time delivery performance measurement.',
    `bonded_goods_flag` BOOLEAN COMMENT 'Indicates whether goods are under customs bond and require special handling in bonded warehouse area. Critical for customs compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inbound receipt record was first created in the system. Used for audit trail and data lineage.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether goods are designated for immediate cross-docking to outbound shipment without storage. Enables flow-through distribution.',
    `customs_entry_number` STRING COMMENT 'Customs declaration or entry number for imported goods. Required for customs clearance and duty payment tracking.. Valid values are `^[A-Z0-9]{11,15}$`',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether any variance was detected between expected and actual quantities, quality, or documentation. Triggers exception workflow when true.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of any discrepancies, damages, or exceptions noted during the receipt process. Provides context for exception resolution.',
    `discrepancy_type` STRING COMMENT 'Classification of the type of variance or exception identified during receipt. Used for root cause analysis and supplier performance tracking.. Valid values are `overage|shortage|damage|quality|documentation|none`',
    `dock_door_number` STRING COMMENT 'Specific dock door or bay assigned for unloading this inbound receipt. Used for resource allocation and tracking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `expected_cartons_count` STRING COMMENT 'Number of cartons expected based on the ASN or purchase order. Used to calculate receipt variance.',
    `expected_pallets_count` STRING COMMENT 'Number of pallets expected based on the ASN or purchase order. Used to calculate receipt variance.',
    `goods_receipt_number` STRING COMMENT 'ERP system goods receipt document number generated upon receipt completion. Links warehouse receipt to financial inventory posting.. Valid values are `^GR[0-9]{10}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the receipt contains dangerous goods requiring special handling, storage, and documentation per IMDG or IATA regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inbound receipt record was last updated. Used for change tracking and audit purposes.',
    `putaway_priority` STRING COMMENT 'Priority level assigned for moving received goods from dock to storage location. Determines task sequencing in warehouse operations.. Valid values are `urgent|high|normal|low`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether goods require quality inspection before putaway. Determined by product type, supplier rating, or regulatory requirements.',
    `quality_inspection_status` STRING COMMENT 'Current status of quality inspection process for this receipt. Determines whether goods can be released to inventory.. Valid values are `not-required|pending|in-progress|passed|failed`',
    `receipt_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the entire receipt process was finalized, including quality checks and system confirmation. Marks the official completion of the receipt transaction.',
    `receipt_number` STRING COMMENT 'Externally-known unique business identifier for the inbound receipt transaction. Used for tracking and reference across systems and with external parties.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the inbound receipt process. Tracks progression from scheduled arrival through completion or exception handling.. Valid values are `scheduled|in-progress|completed|exception|cancelled`',
    `receipt_type` STRING COMMENT 'Classification of the receipt transaction based on the source and purpose of the inbound goods.. Valid values are `purchase-order|transfer|return|cross-dock|sample`',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the carrier was expected to arrive at the warehouse dock. Used for dock scheduling and resource planning.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was found intact upon arrival. False value triggers security investigation.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer. Verified at receipt to ensure cargo integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether temperature-sensitive goods were received within required temperature range. Critical for cold chain compliance.',
    `temperature_recorded_c` DECIMAL(18,2) COMMENT 'Actual temperature recorded at time of receipt for temperature-controlled shipments. Used for cold chain validation.',
    `total_cartons_received` STRING COMMENT 'Total number of cartons or cases physically received in this inbound receipt. Used for variance analysis against ASN.',
    `total_pallets_received` STRING COMMENT 'Total number of pallets or handling units physically received. Used for space planning and material handling resource allocation.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of all goods received, measured in cubic meters. Used for warehouse space utilization and slotting optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all goods received, measured in kilograms. Used for freight reconciliation and capacity planning.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or container used for transportation. Used for equipment tracking and reconciliation.. Valid values are `^[A-Z0-9]{4,15}$`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials. Required for dangerous goods handling and compliance.. Valid values are `^UN[0-9]{4}$`',
    `unloading_end_timestamp` TIMESTAMP COMMENT 'Date and time when physical unloading of goods was completed. Used to calculate unloading duration and dock turnaround time.',
    `unloading_start_timestamp` TIMESTAMP COMMENT 'Date and time when physical unloading of goods from the vehicle began. Used for labor productivity and dock utilization analysis.',
    `vehicle_registration_number` STRING COMMENT 'License plate or registration number of the delivery vehicle. Used for security tracking and gate management.. Valid values are `^[A-Z0-9]{4,15}$`',
    CONSTRAINT pk_inbound_receipt PRIMARY KEY(`inbound_receipt_id`)
) COMMENT 'Physical receiving event record capturing the actual arrival and unloading of goods at a warehouse dock. Records receipt number, dock door assigned, carrier/driver details, vehicle registration, arrival timestamp, unloading start/end timestamps, total cartons received, total pallets received, total weight received, total CBM received, receipt status (in-progress, completed, exception), and discrepancy flag. Links to ASN for variance analysis and GR (Goods Receipt) reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` (
    `inbound_receipt_line_id` BIGINT COMMENT 'Unique identifier for the inbound receipt line record. Primary key for this entity.',
    `asn_line_id` BIGINT COMMENT 'Reference to the corresponding ASN line that this receipt line was expected against. Used for variance analysis between expected and received quantities.',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the parent inbound receipt header that this line belongs to. Links line-level detail to the receipt event.',
    `pallet_id` BIGINT COMMENT 'Identifier of the pallet on which the received goods are stored. Used for pallet-level tracking and storage optimization.',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse employee who performed quality inspection on this receipt line. Used for accountability and performance tracking.',
    `storage_location_id` BIGINT COMMENT 'Reference to the warehouse location where the received goods were stored. Final storage location after putaway completion.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized the receipt of these goods. Links receipt to procurement transaction.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU master record for the item received on this line. Identifies the specific product variant received.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who shipped the goods. Used for supplier performance tracking and claim processing.',
    `condition_code` STRING COMMENT 'Condition classification of the received inventory. Determines storage location, availability for picking, and valuation. NEW=new goods, USED=returned/used items, REFURBISHED=reconditioned goods, DAMAGED=damaged goods, EXPIRED=past expiry date, QUARANTINE=held for inspection.. Valid values are `NEW|USED|REFURBISHED|DAMAGED|EXPIRED|QUARANTINE`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the goods were manufactured or produced. Required for customs compliance and trade reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost amounts on this receipt line. Used for multi-currency inventory valuation.. Valid values are `^[A-Z]{3}$`',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU received in damaged condition. Segregated for disposition decision and potential supplier claim.',
    `expected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU that was expected to be received based on the ASN or purchase order. Used as baseline for variance calculation.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the received goods. Used for shelf-life management, FEFO picking strategies, and compliance with food/pharma regulations.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the received goods. Used for customs declarations, duty calculation, and trade compliance.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when quality inspection was completed for this receipt line. Used for cycle time analysis and compliance reporting.',
    `line_number` STRING COMMENT 'Sequential line number within the parent receipt. Used for ordering and referencing specific lines in the receipt document.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number assigned to the received goods. Critical for traceability, recalls, and FIFO/LIFO inventory management.',
    `lpn_number` STRING COMMENT 'License Plate Number assigned to the physical container or pallet holding the received goods. Used for tracking and putaway task assignment.',
    `manufacture_date` DATE COMMENT 'Date the goods were manufactured or produced. Used for quality control, warranty tracking, and regulatory compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by warehouse staff regarding this receipt line. Captures exceptions, observations, or special handling instructions.',
    `purchase_order_line_number` STRING COMMENT 'Line number on the purchase order corresponding to this receipt line. Used for three-way matching with PO and invoice.',
    `putaway_completed_timestamp` TIMESTAMP COMMENT 'Date and time when putaway was completed and goods were stored in their final warehouse location. Marks inventory availability for picking.',
    `putaway_status` STRING COMMENT 'Status of the putaway process for this receipt line. NOT_STARTED=received but not yet assigned to putaway task, IN_PROGRESS=putaway task active, COMPLETED=goods stored in final location, EXCEPTION=putaway blocked or failed.. Valid values are `NOT_STARTED|IN_PROGRESS|COMPLETED|EXCEPTION`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this receipt line requires quality inspection before being made available for picking. True if inspection is mandatory, False otherwise.',
    `quality_inspection_status` STRING COMMENT 'Current status of quality inspection for this receipt line. NOT_REQUIRED=no inspection needed, PENDING=awaiting inspection, IN_PROGRESS=inspection underway, PASSED=inspection approved, FAILED=inspection rejected.. Valid values are `NOT_REQUIRED|PENDING|IN_PROGRESS|PASSED|FAILED`',
    `receipt_status` STRING COMMENT 'Current processing status of the receipt line. PENDING=awaiting physical receipt, RECEIVED=physically received but not yet putaway, PUTAWAY=completed and stored, DISCREPANCY=variance requiring resolution, CLOSED=receipt line processing complete.. Valid values are `PENDING|RECEIVED|PUTAWAY|DISCREPANCY|CLOSED`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU physically received and accepted during the receipt event. Drives inventory position updates.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line was physically received and recorded in the WMS. Primary business event timestamp for receipt processing.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU rejected during receiving inspection due to quality issues, incorrect item, or other non-conformance. Not accepted into inventory.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized items received. Enables unit-level tracking for high-value or regulated goods.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost for this receipt line (received quantity multiplied by unit cost). Used for financial accrual and inventory valuation.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the received goods as per the purchase order. Used for inventory valuation and financial reconciliation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantities on this receipt line. Standard warehouse UOM codes: EA=Each, CS=Case, PL=Pallet, CTN=Carton, BX=Box, KG=Kilogram, LB=Pound, LT=Liter, GL=Gallon. [ENUM-REF-CANDIDATE: EA|CS|PL|CTN|BX|KG|LB|LT|GL — 9 candidates stripped; promote to reference product]',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between expected and received quantities (received minus expected). Positive indicates over-receipt, negative indicates short-receipt.',
    `volume` DECIMAL(18,2) COMMENT 'Total volume or cubic measurement of the goods received on this line. Used for warehouse space planning and slotting optimization.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume field. CBM=Cubic Meter, CFT=Cubic Foot, LT=Liter, GL=Gallon.. Valid values are `CBM|CFT|LT|GL`',
    `weight` DECIMAL(18,2) COMMENT 'Total weight of the goods received on this line. Used for freight reconciliation, capacity planning, and handling equipment selection.',
    `weight_uom` STRING COMMENT 'Unit of measure for the weight field. KG=Kilogram, LB=Pound, MT=Metric Ton, TON=US Ton.. Valid values are `KG|LB|MT|TON`',
    CONSTRAINT pk_inbound_receipt_line PRIMARY KEY(`inbound_receipt_line_id`)
) COMMENT 'Line-level record of each SKU actually received during an inbound receipt event. Captures receipt line number, SKU, received quantity, damaged quantity, rejected quantity, lot number, serial number, expiry date, condition code, putaway status, and variance quantity versus ASN line. Drives inventory position updates and discrepancy reporting for supplier claims.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` (
    `putaway_task_id` BIGINT COMMENT 'Unique identifier for the putaway task. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account that owns the inventory being put away. Relevant for contract logistics and 3PL operations with multi-client warehouses.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the storage location (bin, slot, pallet position) where the goods must be placed. Determined by slotting optimization rules.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operative (picker, forklift operator, material handler) assigned to execute this putaway task.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the putaway task is executed.',
    `handling_unit_id` BIGINT COMMENT 'Identifier of the physical handling unit (pallet, container, tote) being moved. May be an SSCC (Serial Shipping Container Code) or internal license plate number.. Valid values are `^[A-Z0-9]{10,30}$`',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the inbound receipt transaction that created this putaway task.',
    `primary_putaway_storage_location_id` BIGINT COMMENT 'Identifier of the staging or receiving location where the goods are currently located and must be picked up from.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU being moved in this putaway task.',
    `warehouse_asn_id` BIGINT COMMENT 'Reference to the Advanced Shipping Notice that triggered the inbound receipt and subsequent putaway task.',
    `wave_id` BIGINT COMMENT 'Identifier of the putaway wave or batch that groups multiple tasks for optimized execution. Used for labor planning and performance tracking.',
    `zone_id` BIGINT COMMENT 'Identifier of the warehouse zone (area, section) where the destination location resides. Used for zone-based labor assignment and wave planning.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the task was assigned to a warehouse operative. Used to measure task allocation latency.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the task was cancelled, if applicable. Cancellation may occur due to inventory discrepancies, damage, or process exceptions.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the operative completed the task by confirming placement at the destination location. Used for labor productivity measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the putaway task was created by the WMS, typically immediately following receipt confirmation.',
    `duration_seconds` STRING COMMENT 'Total elapsed time from task start to completion, in seconds. Key metric for labor productivity analysis and engineered labor standards validation.',
    `equipment_type_required` STRING COMMENT 'Type of material handling equipment required to execute this putaway task, based on weight, height, and location characteristics.. Valid values are `manual|pallet_jack|forklift|reach_truck|order_picker|automated_guided_vehicle`',
    `exception_code` STRING COMMENT 'Code identifying any exception or deviation during task execution (e.g., DAMAGE, SHORT, LOCATION_BLOCKED, EQUIPMENT_FAILURE). Empty if no exception occurred.. Valid values are `^[A-Z0-9_]{0,20}$`',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the operative or supervisor describing any exception, issue, or special handling during task execution.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the goods. Used for FEFO (First Expired First Out) putaway and picking strategies.',
    `fifo_date` DATE COMMENT 'Date used for FIFO inventory rotation logic. Typically the receipt date or production date. Ensures oldest inventory is picked first.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the SKU being moved is classified as hazardous material requiring special handling, storage segregation, and compliance documentation.',
    `inventory_status` STRING COMMENT 'Quality and availability status of the inventory being put away: available (sellable), quarantine (pending inspection), hold (blocked), damaged (non-sellable), expired (past use-by date).. Valid values are `available|quarantine|hold|damaged|expired`',
    `last_modified_by` STRING COMMENT 'User ID or system process that last modified the task record. Used for audit trail and accountability.. Valid values are `^[A-Za-z0-9_]{1,50}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the task record was last updated. Used for audit trail and data synchronization.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number for traceability and FIFO/LIFO inventory management. Critical for perishable goods and regulatory compliance.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `owner_type` STRING COMMENT 'Classification of inventory ownership: own_stock (company-owned), customer_stock (3PL client inventory), consignment (supplier-owned), vendor_managed (VMI program).. Valid values are `own_stock|customer_stock|consignment|vendor_managed`',
    `priority` STRING COMMENT 'Numeric priority ranking for task execution sequencing. Lower numbers indicate higher priority. Used by WMS to optimize labor allocation and meet SLA commitments.',
    `quality_check_required` BOOLEAN COMMENT 'Indicates whether a quality inspection or verification step is required before or after putaway, based on SKU classification or customer requirements.',
    `quality_check_status` STRING COMMENT 'Status of the quality inspection: not_required (no check needed), pending (awaiting inspection), passed (approved for storage), failed (rejected, requires disposition).. Valid values are `not_required|pending|passed|failed`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU to be moved in this putaway task, expressed in the SKUs base unit of measure.',
    `replenishment_trigger_flag` BOOLEAN COMMENT 'Indicates whether completion of this putaway task will trigger an automatic replenishment task to move goods from reserve to forward pick locations.',
    `standard_time_seconds` STRING COMMENT 'Engineered labor standard time for this task type and distance, in seconds. Used to calculate labor productivity percentage (actual vs. standard).',
    `started_timestamp` TIMESTAMP COMMENT 'Date and time when the operative began executing the task (scanned source location or handling unit). Marks transition to in_progress status.',
    `system_directed_flag` BOOLEAN COMMENT 'Indicates whether the destination location was system-directed by slotting optimization algorithms (true) or manually specified by a user (false).',
    `task_number` STRING COMMENT 'Externally visible business identifier for the putaway task, generated by Manhattan WMS. Used for tracking and operator reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `task_status` STRING COMMENT 'Current lifecycle status of the putaway task: open (created, awaiting assignment), assigned (allocated to operative), in_progress (operative has started), completed (goods placed in destination), cancelled (task voided), suspended (temporarily paused).. Valid values are `open|assigned|in_progress|completed|cancelled|suspended`',
    `task_type` STRING COMMENT 'Classification of the putaway task based on the destination and handling strategy: standard (normal putaway to reserve), cross-dock (direct to outbound), replenishment (to forward pick location), bulk (large quantity), directed (system-optimized), reserve (long-term storage), forward_pick (active pick face). [ENUM-REF-CANDIDATE: standard|cross_dock|replenishment|bulk|directed|reserve|forward_pick — 7 candidates stripped; promote to reference product]',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for storage: ambient (room temperature), chilled (2-8°C), frozen (<-18°C), controlled (specific range). Ensures cold chain integrity.. Valid values are `ambient|chilled|frozen|controlled`',
    `travel_distance_meters` DECIMAL(18,2) COMMENT 'Calculated or actual travel distance from source to destination location, in meters. Used for slotting optimization and labor standards.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field (e.g., EA for each, CS for case, PLT for pallet, KG for kilogram).. Valid values are `^[A-Z]{2,5}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the handling unit or goods being moved, in cubic meters. Used for space utilization and slotting optimization.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the handling unit or goods being moved, in kilograms. Used for equipment selection and safety compliance.',
    CONSTRAINT pk_putaway_task PRIMARY KEY(`putaway_task_id`)
) COMMENT 'Directed putaway task generated by Manhattan WMS for each received unit or pallet, instructing warehouse operatives to move goods from the receiving staging area to a designated storage location. Captures task number, task type (standard, cross-dock, replenishment), assigned operative, source location, destination location, SKU, quantity, priority, creation timestamp, assignment timestamp, completion timestamp, and task status (open, assigned, in-progress, completed, cancelled). Feeds labor productivity measurement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` (
    `pick_wave_id` BIGINT COMMENT 'Unique identifier for the pick wave. Primary key for the pick wave entity.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where this pick wave is executed.',
    `employee_id` BIGINT COMMENT 'Identifier of the Warehouse Management System (WMS) user or automated process that created this wave record.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to warehouse.zone. Business justification: pick_wave has assigned_zone_code (STRING) indicating the zone assigned for picking. Adding zone_id FK enables proper relational JOIN to zone master. assigned_zone_code removed as retrievable via JOIN.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when all picking and packing activities for this wave were completed. Used to calculate wave cycle time and On-Time In-Full (OTIF) performance.',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Actual date and time when the wave was released to pickers. Used to measure schedule adherence and identify release delays.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for wave cancellation if wave status is cancelled. Used for root cause analysis and process improvement.',
    `carrier_service_type` STRING COMMENT 'Primary carrier service level for orders in this wave (e.g., express, standard, economy). Used for wave grouping and Service Level Agreement (SLA) management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was first created in the Warehouse Management System (WMS). Used for audit trail and wave age analysis.',
    `customer_segment_code` STRING COMMENT 'Customer segment classification for orders in this wave (e.g., retail, wholesale, e-commerce, Third-Party Logistics (3PL) client). Used for prioritization and Service Level Agreement (SLA) differentiation.',
    `destination_country_code` STRING COMMENT 'Primary destination country for orders in this wave, using ISO 3166-1 alpha-3 country codes. Used for wave grouping by geography and customs requirements.. Valid values are `^[A-Z]{3}$`',
    `exception_count` STRING COMMENT 'Total number of exceptions or issues encountered during wave execution (damaged goods, missing Stock Keeping Units (SKUs), system errors, etc.).',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this wave contains hazardous materials requiring special handling per International Maritime Dangerous Goods (IMDG) Code or International Civil Aviation Organization (ICAO) Technical Instructions.',
    `is_high_value` BOOLEAN COMMENT 'Indicates whether this wave contains high-value goods requiring enhanced security measures, additional insurance, or special handling procedures.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether this wave contains temperature-sensitive goods requiring cold chain management (refrigerated or frozen storage).',
    `labor_hours_actual` DECIMAL(18,2) COMMENT 'Actual total labor hours consumed to complete picking and packing for this wave. Used for productivity analysis and labor cost calculation.',
    `labor_hours_planned` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete picking and packing for this wave. Used for workforce planning and scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was last modified. Used for audit trail and change tracking.',
    `packing_end_timestamp` TIMESTAMP COMMENT 'Date and time when the last packing task for this wave was completed. Marks readiness for outbound dispatch.',
    `packing_start_timestamp` TIMESTAMP COMMENT 'Date and time when the first packing task for this wave was started. Marks the beginning of the packing phase.',
    `packing_station_count` STRING COMMENT 'Number of packing stations allocated to process orders from this wave. Used for packing capacity planning.',
    `pick_accuracy_percentage` DECIMAL(18,2) COMMENT 'Percentage of pick tasks completed without errors (correct Stock Keeping Unit (SKU), correct quantity, correct location). Key Performance Indicator (KPI) for picking quality.',
    `picker_count` STRING COMMENT 'Number of warehouse pickers assigned to execute this wave. Used for labor planning and productivity measurement.',
    `picking_end_timestamp` TIMESTAMP COMMENT 'Date and time when the last pick task in this wave was completed. Marks the end of picking phase before packing begins.',
    `picking_start_timestamp` TIMESTAMP COMMENT 'Date and time when the first pick task in this wave was started by a picker. Marks the beginning of active picking operations.',
    `planned_completion_timestamp` TIMESTAMP COMMENT 'Target date and time for completing all picking and packing activities for this wave. Used for capacity planning and Service Level Agreement (SLA) management.',
    `planned_release_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the wave is planned to be released to the warehouse floor for picking execution.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for wave execution. Lower numbers indicate higher priority. Used for sequencing waves when warehouse capacity is constrained.',
    `short_pick_count` STRING COMMENT 'Number of order lines that could not be fully picked due to insufficient inventory. Indicates inventory accuracy issues or stock-outs.',
    `sla_cutoff_timestamp` TIMESTAMP COMMENT 'Latest date and time by which this wave must be completed to meet Service Level Agreement (SLA) commitments for included orders. Used for On-Time Delivery (OTD) tracking.',
    `total_carton_count` STRING COMMENT 'Total number of cartons or parcels packed for this wave. Represents the number of shippable units generated.',
    `total_line_count` STRING COMMENT 'Total number of order lines (Stock Keeping Unit (SKU) line items) across all orders in this wave. Indicates picking complexity.',
    `total_order_count` STRING COMMENT 'Total number of distinct outbound orders included in this pick wave. Used for wave sizing and throughput analysis.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets used for consolidating and shipping orders from this wave. Relevant for Full Truckload (FTL) and Less Than Truckload (LTL) shipments.',
    `total_unit_count` STRING COMMENT 'Total number of individual units (eaches) to be picked across all orders in this wave. Represents total picking volume.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of all packed items in this wave, measured in cubic meters. Used for load planning and Dimensional Weight (DIM Weight) calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all packed items in this wave, measured in kilograms. Used for freight planning and carrier selection.',
    `wave_allocation_method` STRING COMMENT 'Inventory allocation strategy used for this wave. First In First Out (FIFO): oldest stock first. Last In First Out (LIFO): newest stock first. First Expired First Out (FEFO): shortest shelf-life first. Nearest Location: minimize travel distance. Optimal Path: system-optimized routing.. Valid values are `fifo|lifo|fefo|nearest_location|optimal_path`',
    `wave_notes` STRING COMMENT 'Free-text operational notes or special instructions for this wave. Used for communicating exceptions, special handling requirements, or coordination messages.',
    `wave_number` STRING COMMENT 'Business-facing unique wave identifier assigned by the Warehouse Management System (WMS). Used for operational tracking and communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `wave_status` STRING COMMENT 'Current lifecycle status of the pick wave. Tracks progression from planning through completion or cancellation. [ENUM-REF-CANDIDATE: planned|released|in_progress|picking_complete|packing_in_progress|completed|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `wave_template_code` STRING COMMENT 'Code identifying the wave template or configuration profile used to generate this wave. Templates define picking rules, zone assignments, and resource allocation strategies.',
    `wave_type` STRING COMMENT 'Classification of the picking strategy used for this wave. Single-order: one order per picker. Multi-order: multiple orders picked simultaneously. Zone: picking confined to specific warehouse zones. Cluster: multiple orders picked into separate containers. Batch: orders grouped by similar characteristics. Wave: large-scale coordinated release.. Valid values are `single_order|multi_order|zone|cluster|batch|wave`',
    CONSTRAINT pk_pick_wave PRIMARY KEY(`pick_wave_id`)
) COMMENT 'Order picking and packing wave — a batch of outbound orders grouped and released together for coordinated pick-and-pack execution in the warehouse. Captures wave number, wave type (single-order, multi-order, zone, cluster, batch), release timestamp, planned/actual completion timestamps, total order count, total line count, total unit count, assigned zone, wave status, picker count, and associated packing station assignments. After merge with pack_order, also tracks carton/pallet consolidation, packed weight/CBM, packaging materials, and pack completion. Core orchestration entity for outbound fulfillment throughput.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Primary key for pick_task',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Warehouse pick tasks are executed to fulfill specific shipments/consignments. Pick-to-ship operations require linking pick tasks to the outbound consignment for shipment preparation, load planning, an',
    `container_unit_id` BIGINT COMMENT 'Identifier of the tote, cart, or container into which the picked items are placed. Enables tracking of picked inventory through packing and dispatch.',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse operative (picker) assigned to execute this pick task. Used for labor productivity tracking.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where this pick task is executed.',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line that this pick task fulfills. Links the pick task to customer order demand.',
    `outbound_shipment_order_id` BIGINT COMMENT 'Reference to the outbound shipment that this pick task supports. Links warehouse execution to transportation planning.',
    `pick_wave_id` BIGINT COMMENT 'Reference to the pick wave batch that this task belongs to. Pick waves group multiple tasks for efficient warehouse execution.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) that must be picked for this task.',
    `storage_location_id` BIGINT COMMENT 'Reference to the storage location (bin, shelf, pallet position) from which the SKU must be retrieved.',
    `aisle_code` STRING COMMENT 'The aisle identifier within the warehouse where the source location is situated. Supports travel distance calculation and slotting analysis.. Valid values are `^[A-Z0-9]{1,10}$`',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when the pick task was assigned to the operative. Marks the start of the task lifecycle for labor tracking.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating why the pick task was cancelled. Enables root cause analysis of task cancellations and process improvement.. Valid values are `order_cancelled|inventory_unavailable|duplicate_task|system_error|customer_request|other`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when this pick task was cancelled, if applicable. Supports analysis of task cancellation patterns and reasons.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when the operative completed the pick task and confirmed the picked quantity. Used to calculate task duration and productivity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pick task record was first created in the warehouse management system. Audit trail for task generation.',
    `customer_order_number` STRING COMMENT 'The customer-facing order number associated with this pick task. Provides traceability from warehouse execution back to customer order.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the operative or supervisor to document exceptions, issues, or special handling during task execution.',
    `expiry_date` DATE COMMENT 'The expiration or best-before date of the picked SKU, captured to ensure FIFO rotation and prevent shipment of expired goods.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the SKU being picked is classified as hazardous material requiring special handling, labeling, and compliance documentation. True if hazardous.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pick task record was last updated. Tracks changes to task status, quantities, or assignments.',
    `lot_number` STRING COMMENT 'The lot or batch number of the picked SKU, captured for traceability and FIFO/LIFO inventory rotation compliance.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `pick_method` STRING COMMENT 'Technology or process method used to execute the pick task. Determines equipment requirements and productivity benchmarks.. Valid values are `rf_scan|voice_pick|paper_list|goods_to_person|pick_to_light|automated`',
    `pick_sequence_number` STRING COMMENT 'The sequence order of this task within the assigned pick wave or batch. Optimizes travel path and minimizes operative movement.',
    `pick_type` STRING COMMENT 'Picking strategy applied to this task. Discrete picks one order at a time; batch picks multiple orders simultaneously; zone assigns pickers to specific warehouse areas.. Valid values are `discrete|batch|zone|wave|cluster`',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of the SKU that the operative successfully picked and confirmed. Used to calculate fill rate and order completeness.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether the picked inventory is subject to a quality hold pending inspection or release. True if on quality hold.',
    `replenishment_triggered_flag` BOOLEAN COMMENT 'Indicates whether this pick task triggered an automatic replenishment task to refill the source location from reserve storage. True if replenishment was triggered.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that the operative is instructed to pick, as determined by the order line requirement.',
    `serial_number` STRING COMMENT 'The unique serial number of the picked item, captured for serialized inventory tracking and warranty management.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `short_pick_quantity` DECIMAL(18,2) COMMENT 'The quantity shortfall when the operative cannot fulfill the full requested quantity due to inventory discrepancy, damage, or location error.',
    `short_pick_reason_code` STRING COMMENT 'Standardized code indicating why the operative could not fulfill the full requested quantity. Drives root cause analysis and inventory accuracy improvement.. Valid values are `inventory_discrepancy|damaged_goods|location_empty|wrong_sku|system_error|other`',
    `start_timestamp` TIMESTAMP COMMENT 'The date and time when the operative began executing the pick task, typically captured via RF scan or voice confirmation.',
    `task_duration_seconds` STRING COMMENT 'The elapsed time in seconds from task start to completion. Key metric for labor productivity analysis and engineered labor standards.',
    `task_number` STRING COMMENT 'Human-readable unique identifier for the pick task, typically displayed on RF scanners and pick lists.. Valid values are `^[A-Z0-9]{8,20}$`',
    `task_priority` STRING COMMENT 'Priority level assigned to the pick task, determining execution sequence. Urgent tasks support expedited shipments and SLA commitments.. Valid values are `urgent|high|normal|low`',
    `task_status` STRING COMMENT 'Current lifecycle status of the pick task. Tracks progression from assignment through completion or exception handling. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|short_picked|cancelled|exception — 7 candidates stripped; promote to reference product]',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification of the source location and SKU. Ensures cold chain integrity for perishable goods.. Valid values are `ambient|chilled|frozen|controlled`',
    `travel_distance_meters` DECIMAL(18,2) COMMENT 'The distance in meters traveled by the operative to reach the source location and complete the pick. Used for slotting optimization and productivity benchmarking.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the pick quantity is expressed. Aligns with SKU packaging hierarchy.. Valid values are `each|case|pallet|carton|box|piece`',
    `verification_method` STRING COMMENT 'The method used to verify the accuracy of the pick before task completion. Ensures order accuracy and reduces mis-picks.. Valid values are `barcode_scan|weight_check|visual_inspection|supervisor_approval|none`',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether this pick task requires additional verification (e.g., weight check, barcode scan, supervisor approval) before completion. True if verification is required.',
    `volume_picked_cbm` DECIMAL(18,2) COMMENT 'The total volume in cubic meters of the picked quantity. Used for space utilization analysis and container load optimization.',
    `weight_picked_kg` DECIMAL(18,2) COMMENT 'The total weight in kilograms of the picked quantity. Used for load planning, freight calculation, and weight verification.',
    `zone_code` STRING COMMENT 'The warehouse zone or area code where the source location resides. Used for zone-based picking strategies and labor allocation.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Individual picking task assigned to a warehouse operative within a pick wave, directing them to retrieve a specific SKU quantity from a storage location. Captures task number, wave reference, order line reference, operative assigned, source location, SKU, requested quantity, picked quantity, short-pick quantity, pick method (RF scan, voice, paper, goods-to-person), start timestamp, completion timestamp, and task status. Drives labor productivity tracking and order fill-rate measurement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` (
    `pack_order_id` BIGINT COMMENT 'Unique identifier for the pack order. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier selected for outbound transportation of this pack order. Determined by carrier selection logic in the Transportation Management System (TMS).',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Packing instructions vary by carrier service level: priority services require specific packaging materials, labeling formats, and dimensional weight calculations. Links pack station operations to carr',
    `consignee_id` BIGINT COMMENT 'Identifier of the consignee (final recipient) of the shipment. May differ from the customer account for third-party logistics (3PL) or drop-ship scenarios.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account for whom this pack order is being prepared. Used for customer-specific packing rules and billing.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the packing operation is performed.',
    `material_id` BIGINT COMMENT 'Foreign key linking to warehouse.material. Business justification: pack_order has packaging_material_code (STRING) identifying the packaging material used. Adding material_id FK normalizes this to the material master reference table, providing a second inbound link t',
    `outbound_shipment_order_id` BIGINT COMMENT 'Reference to the parent outbound order that this pack order fulfills. Links to the customer order being prepared for shipment.',
    `packing_station_id` BIGINT COMMENT 'Identifier of the physical packing station or workbench where items are consolidated and packaged.. Valid values are `^[A-Z0-9]{2,10}$`',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Packed cartons become trackable parcels at carrier handoff. Manifest generation, tracking number assignment, and carrier billing reconciliation require linking warehouse pack records to fulfillment pa',
    `pick_wave_id` BIGINT COMMENT 'Identifier of the pick batch or pick list that supplied the items to this packing station. Used for traceability and exception handling.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Packing completion triggers route plan execution and carrier handoff. Route plan provides multi-leg routing instructions, carrier assignments, and dispatch timing for packed shipments requiring comple',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operative or packer assigned to execute this pack order.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Pack orders track the assigned truck/trailer for loading. Critical for load planning, trailer cube utilization optimization, dispatch coordination, and linking packing operations to specific outbound ',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Packing operations generate shipping labels, packing lists, hazmat declarations, and carrier manifests. Direct documentation output required for carrier acceptance, customs clearance, and customer del',
    `wave_id` BIGINT COMMENT 'Identifier of the picking wave that generated the items for this pack order. Links packing operations back to wave planning and pick execution.',
    `carton_count` STRING COMMENT 'Total number of cartons or boxes packed for this order. Used for shipment planning and carrier manifesting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack order record was first created in the Warehouse Management System (WMS). Audit trail for record lifecycle.',
    `dimensional_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight based on volumetric measurement, used by carriers to determine billable weight when volume exceeds actual weight.',
    `dispatch_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the packed order was dispatched from the warehouse. Used for On-Time Delivery (OTD) and On-Time In-Full (OTIF) performance tracking.',
    `dispatch_scheduled_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for outbound dispatch of the packed order. Used for dock scheduling and carrier pickup coordination.',
    `exception_notes` STRING COMMENT 'Free-text notes describing the packing exception or issue, captured by the operative or supervisor for resolution tracking.',
    `hazmat_class` STRING COMMENT 'UN hazard class for dangerous goods if applicable (e.g., 3 for flammable liquids, 9 for miscellaneous). Required for IMDG and ICAO compliance.. Valid values are `^(1|2|3|4|5|6|7|8|9)(.[0-9])?$`',
    `label_generated_flag` BOOLEAN COMMENT 'Indicates whether shipping labels have been generated for this pack order. Label generation is triggered upon pack completion.',
    `label_generation_timestamp` TIMESTAMP COMMENT 'Timestamp when shipping labels were generated for the packed cartons or pallets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack order record was last updated. Used for change tracking and data synchronization.',
    `pack_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when packing was completed and the order was ready for outbound dispatch. Triggers label generation and carrier manifesting.',
    `pack_duration_minutes` STRING COMMENT 'Total time in minutes taken to complete the packing operation, calculated as the difference between start and completion timestamps. Key performance indicator (KPI) for labor efficiency.',
    `pack_method_code` STRING COMMENT 'Packing methodology applied based on order characteristics: single-item for individual SKUs, multi-item for consolidated cartons, bulk for large quantities, pallet for palletized loads, mixed for heterogeneous packaging.. Valid values are `single_item|multi_item|bulk|pallet|mixed`',
    `pack_order_number` STRING COMMENT 'Human-readable business identifier for the pack order, typically displayed on packing station screens and printed on labels.. Valid values are `^PO-[0-9]{8,12}$`',
    `pack_priority_code` STRING COMMENT 'Priority level assigned to the pack order, determining sequence in the packing queue. Urgent orders are typically express shipments or SLA-critical.. Valid values are `urgent|high|standard|low`',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the operative began packing this order. Used for labor productivity analysis and cycle time measurement.',
    `pack_status` STRING COMMENT 'Current lifecycle status of the pack order in the packing workflow.. Valid values are `assigned|in_progress|packed|verified|on_hold|cancelled`',
    `packaging_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of packaging materials consumed for this pack order, used for cost center accounting and profitability analysis.',
    `packing_exception_code` STRING COMMENT 'Code indicating any exception or issue encountered during packing (e.g., short pick from upstream, damaged item discovered, packaging material shortage, equipment malfunction).. Valid values are `short_pick|damaged_item|missing_material|equipment_failure|none`',
    `packing_instructions` STRING COMMENT 'Free-text field capturing specific packing instructions from the customer or order management system, such as gift wrapping, custom labeling, or assembly requirements.',
    `packing_zone_code` STRING COMMENT 'Code identifying the packing zone or area within the warehouse where the station is located, used for labor allocation and workflow optimization.. Valid values are `^[A-Z0-9]{2,6}$`',
    `pallet_count` STRING COMMENT 'Total number of pallets used for this pack order. Relevant for Full Truckload (FTL) and Less Than Truckload (LTL) shipments.',
    `special_handling_code` STRING COMMENT 'Code indicating special handling requirements for the packed order. Fragile requires cushioning, hazmat requires IMDG/IATA compliance, cold_chain requires temperature control, high_value requires security protocols.. Valid values are `fragile|hazmat|cold_chain|high_value|oversized|none`',
    `target_temperature_range_c` STRING COMMENT 'Required temperature range in Celsius for cold chain shipments (e.g., 2 to 8 for vaccines, -18 to -22 for frozen goods).. Valid values are `^-?[0-9]{1,3}s?tos?-?[0-9]{1,3}$`',
    `temperature_control_required_flag` BOOLEAN COMMENT 'Indicates whether the packed order requires temperature-controlled handling (cold chain for pharmaceuticals, perishables, or temperature-sensitive goods).',
    `total_item_quantity` STRING COMMENT 'Total quantity of individual Stock Keeping Units (SKUs) packed in this order, summed across all cartons and pallets.',
    `total_packed_volume_cbm` DECIMAL(18,2) COMMENT 'Total volumetric measurement of all packed units in cubic meters (CBM). Critical for dimensional weight (DIM weight) calculation and load optimization.',
    `total_packed_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all packed cartons and pallets in kilograms, including packaging materials. Used for freight rating and carrier selection.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs included in this pack order. Used for complexity analysis and packing time estimation.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for dangerous goods (e.g., UN1203 for gasoline). Mandatory for hazmat shipments.. Valid values are `^UN[0-9]{4}$`',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether the packed order requires quality verification or audit before dispatch, typically for high-value or regulated shipments.',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when quality verification was completed. Null if verification was not required or not yet performed.',
    CONSTRAINT pk_pack_order PRIMARY KEY(`pack_order_id`)
) COMMENT 'Packing station work order capturing the consolidation and packaging of picked items into outbound cartons or pallets for a customer order. Records pack order number, associated outbound order, packing station ID, operative assigned, carton count, pallet count, total packed weight, total packed CBM, packaging material used, special handling instructions (fragile, hazmat, cold chain), pack start timestamp, pack completion timestamp, and pack status. Triggers label generation and outbound dispatch scheduling.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` (
    `outbound_shipment_order_id` BIGINT COMMENT 'Unique identifier for the outbound shipment order. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Outbound orders fulfill contract commitments with specific service levels, pricing, and performance obligations. Order management validates contract terms, billing applies contracted rates, performanc',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier assigned to transport this outbound shipment from the warehouse to the destination.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Outbound orders require specific service level selection for SLA compliance, rate calculation, cutoff time enforcement, and packing/labeling instructions. Links order to contracted service terms and t',
    `certificate_of_origin_id` BIGINT COMMENT 'Foreign key linking to customs.certificate_of_origin. Business justification: Export orders claiming preferential tariff treatment under trade agreements require certificates of origin. Links shipment to COO document for USMCA/FTA compliance, preferential duty eligibility, and ',
    `consignment_id` BIGINT COMMENT 'Identifier of the downstream shipment record created when this order was dispatched and entered the transportation network.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account that placed or is associated with this outbound shipment order.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Export shipments require customs export declarations for regulatory compliance. Links outbound order to export filing for AES/EEI compliance, denied party screening verification, and export license va',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Outbound orders are routed through specific consolidation hubs or gateways for line-haul optimization and cross-border clearance. Essential for network planning, load building, and multi-leg shipment ',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Outbound orders track the assigned driver for dispatch. Required for driver manifesting, HOS compliance verification before departure, delivery accountability, and POD reconciliation. Standard practic',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center fulfilling this outbound shipment order.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Outbound order fulfillment requires lane selection for carrier assignment, service level determination, and delivery promise calculation. Lane drives freight cost allocation and transit time commitmen',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Complex outbound shipments (multi-leg, cross-border, multi-modal) require detailed route plans with carrier sequences, transit times, and cost breakdowns. Route plan drives dispatch execution and cust',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: Outbound orders originate from spot quotes in logistics operations. Business need: Quote-to-order conversion tracking, revenue recognition, pricing variance analysis between quoted and actual costs, s',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Outbound orders track the assigned truck/trailer for dispatch. Critical for loading planning, trailer utilization optimization, dispatch scheduling, on-time departure tracking, and linking warehouse f',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Outbound orders generate bills of lading, commercial invoices, packing lists, and export documentation. Core shipping process requirement for carrier handoff, customs, and customer delivery confirmati',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse picking wave to which this order was assigned for batch fulfillment optimization.',
    `allocated_timestamp` TIMESTAMP COMMENT 'Date and time when inventory was successfully allocated to this outbound shipment order in the warehouse management system.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for order cancellation, if the order was cancelled.. Valid values are `CUSTOMER_REQUEST|INVENTORY_SHORTAGE|ADDRESS_INVALID|PAYMENT_FAILURE|DUPLICATE_ORDER|OTHER`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound shipment order was cancelled, if applicable.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used as the basis for freight charge calculation.',
    `cod_amount` DECIMAL(18,2) COMMENT 'Cash on delivery amount to be collected from the consignee upon delivery, if applicable.',
    `cod_currency_code` STRING COMMENT 'Three-letter ISO currency code for the COD amount.. Valid values are `^[A-Z]{3}$`',
    `consignee_name` STRING COMMENT 'Full name of the consignee (recipient) to whom the shipment will be delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this outbound shipment order record was first created in the warehouse management system.',
    `customer_reference_number` STRING COMMENT 'External reference number or purchase order number provided by the customer for tracking and reconciliation purposes.',
    `destination_address_line1` STRING COMMENT 'Primary street address line for the shipment destination.',
    `destination_address_line2` STRING COMMENT 'Secondary address line for the shipment destination (suite, apartment, building, etc.).',
    `destination_city` STRING COMMENT 'City name for the shipment destination address.',
    `destination_contact_email` STRING COMMENT 'Email address for the consignee or destination contact for delivery notifications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `destination_contact_phone` STRING COMMENT 'Primary phone number for the consignee or destination contact for delivery coordination.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the shipment destination.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code for the shipment destination address.',
    `destination_state_province` STRING COMMENT 'State, province, or region code for the shipment destination address.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight (DIM weight) of the shipment in kilograms, used by carriers for freight rating when volume exceeds actual weight.',
    `dispatched_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound shipment order was handed over to the carrier and departed the warehouse facility.',
    `gift_message` STRING COMMENT 'Optional gift message provided by the customer to be included with the shipment, common in B2C e-commerce orders.',
    `incoterm` STRING COMMENT 'Incoterm code defining the division of costs, risks, and responsibilities between buyer and seller for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_hazmat` BOOLEAN COMMENT 'Boolean indicator of whether this shipment contains hazardous materials requiring special handling and documentation per IMDG or IATA dangerous goods regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this outbound shipment order record was last updated or modified.',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for the outbound shipment order. Used for customer communication and tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_received_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound shipment order was received by the warehouse management system from the upstream order management or ERP system.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound shipment order in the warehouse fulfillment workflow. Tracks progression from receipt through dispatch or cancellation. [ENUM-REF-CANDIDATE: RECEIVED|ALLOCATED|PICKING|PICKED|PACKING|PACKED|DISPATCHED|CANCELLED — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order by business purpose: B2C e-commerce fulfillment, B2B freight shipment, inter-facility transfer, RMA (Return Merchandise Authorization) return, replenishment order, or cross-dock operation.. Valid values are `B2C_ECOMMERCE|B2B_FREIGHT|INTER_FACILITY_TRANSFER|RMA_RETURN|REPLENISHMENT|CROSS_DOCK`',
    `otd_flag` BOOLEAN COMMENT 'Boolean indicator of whether the order was dispatched on or before the requested ship date, meeting the on-time delivery commitment.',
    `packed_timestamp` TIMESTAMP COMMENT 'Date and time when the order was fully packed and prepared for dispatch.',
    `picked_timestamp` TIMESTAMP COMMENT 'Date and time when all order lines were successfully picked from warehouse inventory locations.',
    `priority_level` STRING COMMENT 'Processing priority assigned to this outbound shipment order for warehouse resource allocation and sequencing.. Valid values are `URGENT|HIGH|NORMAL|LOW`',
    `requested_delivery_date` DATE COMMENT 'Date by which the customer has requested the order to be delivered to the destination.',
    `requested_ship_date` DATE COMMENT 'Date by which the customer has requested the order to be shipped from the warehouse.',
    `sla_service_level` STRING COMMENT 'Contracted service level commitment for this shipment defining the expected delivery timeframe (same-day, next-day, two-day, standard, economy, or express).. Valid values are `SAME_DAY|NEXT_DAY|TWO_DAY|STANDARD|ECONOMY|EXPRESS`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for this shipment (fragile, hazardous materials, temperature control, signature required, etc.).',
    `total_line_count` STRING COMMENT 'Total number of distinct order lines (SKUs) included in this outbound shipment order.',
    `total_unit_count` STRING COMMENT 'Total number of individual units (pieces, eaches) across all lines in this outbound shipment order.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the outbound shipment order in cubic meters (CBM), used for capacity planning and freight rating.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the outbound shipment order in kilograms, including packaging.',
    CONSTRAINT pk_outbound_shipment_order PRIMARY KEY(`outbound_shipment_order_id`)
) COMMENT 'Outbound dispatch order representing a customer or transfer order released to the warehouse for fulfillment and outbound dispatch. Captures order number, order type (B2C e-commerce, B2B freight, inter-facility transfer, RMA return), customer reference, destination address, requested ship date, SLA service level, carrier assigned, total line count, total unit count, total weight, total CBM, order status (received, allocated, picked, packed, dispatched, cancelled), and OTD flag. Central orchestration record linking warehouse execution to the shipment and fulfillment domains.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` (
    `outbound_order_line_id` BIGINT COMMENT 'Unique identifier for the outbound order line. Primary key for this entity.',
    `carton_id` BIGINT COMMENT 'Unique identifier for the shipping carton or container holding this line item. Links line to physical package for tracking and proof of delivery.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `outbound_shipment_order_id` BIGINT COMMENT 'Foreign key reference to the parent outbound order header. Links this line to its parent shipment order.',
    `pick_wave_id` BIGINT COMMENT 'Identifier for the pick wave or batch that included this order line. Used for wave planning analysis and labor productivity tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse associate who picked this line item. Supports labor management and productivity analysis.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master. Identifies the specific product or item being fulfilled on this order line.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory allocated or reserved for this order line. Represents inventory commitment prior to physical picking.',
    `allocated_timestamp` TIMESTAMP COMMENT 'Date and time when inventory was allocated to this order line. Marks the start of the fulfillment process.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the SKU was manufactured or produced. Required for customs clearance and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was first created in the warehouse management system. Audit trail for record lifecycle.',
    `customer_item_reference` STRING COMMENT 'Customers own SKU or item reference number. Used for cross-referencing in e-commerce fulfillment and contract logistics scenarios.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive inventory. Used for FEFO (First Expired First Out) picking strategies.',
    `hazmat_class` STRING COMMENT 'UN hazard class for dangerous goods (e.g., 3 for flammable liquids, 8 for corrosives). Required for compliance with IMDG and IATA dangerous goods transport regulations.. Valid values are `^[1-9](.[1-9])?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the SKU on this line is classified as hazardous material requiring special handling, labeling, and documentation per IMDG or IATA dangerous goods regulations.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the SKU. Required for customs declarations, duty calculation, and trade compliance in cross-border shipments.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was last updated. Audit trail for tracking changes to fulfillment status and quantities.',
    `line_number` STRING COMMENT 'Sequential line number within the parent outbound order. Determines the ordering and sequence of line items for picking and packing operations.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line. Tracks progression through warehouse operations from allocation to shipment. [ENUM-REF-CANDIDATE: pending|allocated|picking|picked|packing|packed|shipped|cancelled|short_shipped — 9 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this order line, calculated as shipped quantity multiplied by unit price. Used for financial reporting and invoicing.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability. Critical for FIFO/LIFO inventory management, product recalls, and quality control.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU originally ordered by the customer or requested for fulfillment. Represents the target fulfillment quantity.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this line was fulfilled on-time and in-full per customer SLA. Key performance indicator for warehouse and fulfillment operations.',
    `pack_station` STRING COMMENT 'Packing station identifier where the item was packed. Used for labor productivity tracking and quality control.. Valid values are `^[A-Z0-9-]{2,15}$`',
    `packed_quantity` DECIMAL(18,2) COMMENT 'The quantity packed into shipping containers or cartons. Represents items prepared for outbound dispatch.',
    `packed_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was packed into a shipping container. Used for throughput analysis and labor productivity metrics.',
    `pick_location` STRING COMMENT 'Warehouse location code where the item was picked from. Supports slotting optimization and pick path analysis.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The quantity physically picked from warehouse storage locations. Represents actual inventory retrieved by warehouse staff.',
    `picked_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was physically picked from warehouse storage. Used for cycle time analysis and SLA tracking.',
    `return_reason_code` STRING COMMENT 'Reason code if this line item was returned or rejected. Supports RMA (Return Merchandise Authorization) processing and quality analysis.. Valid values are `DAMAGED|WRONG_ITEM|DEFECTIVE|CUSTOMER_CHANGE|NONE`',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items. Enables item-level tracking for high-value goods, electronics, and regulated products.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'The quantity actually shipped to the customer or consignee. Represents final fulfilled quantity that left the warehouse.',
    `shipped_timestamp` TIMESTAMP COMMENT 'Date and time when the line item left the warehouse facility. Marks completion of warehouse fulfillment and start of carrier transit.',
    `short_ship_quantity` DECIMAL(18,2) COMMENT 'The quantity not fulfilled due to inventory shortage, damage, or other constraints. Calculated as ordered quantity minus shipped quantity.',
    `special_handling_code` STRING COMMENT 'Code indicating special handling requirements for this line item. Drives warehouse labor instructions and quality control procedures.. Valid values are `FRAGILE|REFRIGERATED|FROZEN|HIGH_VALUE|OVERSIZED|NONE`',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance (e.g., UN1203 for gasoline). Required for dangerous goods documentation and labeling.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantities on this line. Standard values: EA (Each), CS (Case), PL (Pallet), BX (Box), KG (Kilogram), LB (Pound), M (Meter), FT (Foot). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|M|FT — 8 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the SKU for this order line. Used for order valuation, invoicing, and revenue recognition. Currency is defined at order header level.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the line item in cubic meters. Used for warehouse space planning, container load optimization, and freight rating.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the line item in kilograms. Used for load planning, freight calculation, and dimensional weight pricing.',
    CONSTRAINT pk_outbound_order_line PRIMARY KEY(`outbound_order_line_id`)
) COMMENT 'Line-level detail of an outbound shipment order specifying each SKU, quantity, and fulfillment status. Captures line number, SKU reference, ordered quantity, allocated quantity, picked quantity, packed quantity, shipped quantity, short-ship quantity, lot number, serial number, unit price reference, line status, and OTIF flag. Enables granular order fill-rate analysis and inventory depletion tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` (
    `inventory_movement_id` BIGINT COMMENT 'Unique identifier for the inventory movement transaction. Primary key for atomic inventory transaction records.',
    `container_unit_id` BIGINT COMMENT 'Identifier of the physical container, tote, or license plate containing the inventory being moved. Supports containerized inventory tracking.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the inventory owner or customer account. Supports multi-client 3PL operations where multiple customers share warehouse space.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operative or system user who executed the movement. Required for labor productivity tracking and audit compliance.',
    `equipment_id` BIGINT COMMENT 'Identifier of the material handling equipment used for the movement (forklift, pallet jack, conveyor, automated storage/retrieval system). Supports equipment utilization analysis.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the movement occurred. Supports multi-site inventory visibility and network optimization.',
    `ftz_admission_id` BIGINT COMMENT 'Foreign key linking to customs.ftz_admission. Business justification: Inventory movements into Foreign Trade Zones require FTZ admission records for CBP compliance. Links movement transaction to zone entry for duty suspension tracking, privileged foreign status, and CBP',
    `pallet_id` BIGINT COMMENT 'Identifier of the pallet or handling unit on which the inventory is stored. Enables pallet-level tracking and cross-docking operations.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `reversed_movement_inventory_movement_id` BIGINT COMMENT 'Reference to the original inventory movement transaction that this record reverses. Null if this is not a reversal transaction.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Every inventory movement transaction MUST reference the authoritative SKU master. Currently inventory_movement has sku STRING field but lacks proper FK to sku.sku_id. Adding sku_id enables JOIN to sku',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: Inventory movement source location MUST reference the authoritative storage location master. Currently inventory_movement has from_location_code STRING but lacks proper FK. Adding from_location_id ena',
    `pick_task_id` BIGINT COMMENT 'Identifier of the warehouse task or work assignment that generated this movement. Links to labor management and task optimization systems.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `wave_id` BIGINT COMMENT 'Identifier of the picking wave or batch that includes this movement. Used for wave performance analysis and order fulfillment optimization.',
    `bonded_status` STRING COMMENT 'Customs bonded warehouse status of the inventory. Indicates whether goods are held in a Free Trade Zone (FTZ) or bonded warehouse pending customs clearance.. Valid values are `non_bonded|bonded|in_bond|duty_paid`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Unit cost of the inventory at the time of movement. Used for inventory valuation, COGS calculation, and financial reconciliation. Currency is USD unless otherwise specified in warehouse configuration.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the goods were manufactured or produced. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory movement record was first created in the system. Audit trail for record creation.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive inventory. Used for FEFO (First Expired First Out) picking strategies.',
    `from_location_code` STRING COMMENT 'Source warehouse location code from which inventory is being moved. Null for receipt transactions. Supports multi-level location hierarchy (zone-aisle-bay-level-position).. Valid values are `^[A-Z0-9-]{4,20}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the inventory item is classified as hazardous material requiring special handling, storage segregation, and regulatory compliance.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the inventory item. Required for customs compliance and duty calculation in bonded warehouse operations.. Valid values are `^[0-9]{6,10}$`',
    `inventory_status` STRING COMMENT 'Quality and availability status of the inventory being moved. Determines whether stock is available for allocation or requires inspection/disposition. [ENUM-REF-CANDIDATE: available|reserved|quarantine|damaged|expired|hold|bonded — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory movement record was last updated. Audit trail for record modifications.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number for traceability. Required for FIFO/LIFO inventory position tracking and product recall management.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `movement_number` STRING COMMENT 'Externally-visible business identifier for the inventory movement transaction. Used for audit trail and cross-system reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `movement_status` STRING COMMENT 'Current lifecycle status of the inventory movement transaction. Tracks progression from initiation through completion or cancellation.. Valid values are `pending|in_progress|completed|cancelled|reversed|error`',
    `movement_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inventory movement occurred. Principal business event timestamp for FIFO/LIFO position calculation and audit trail.',
    `movement_type` STRING COMMENT 'Classification of the inventory movement transaction. Defines the nature of the stock movement within or between warehouse locations. [ENUM-REF-CANDIDATE: receipt|putaway|pick|replenishment|transfer|adjustment|cycle_count|damage_writeoff|return|consolidation|deconsolidation — 11 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments about the inventory movement. Captures exception details, special handling instructions, or operator observations.',
    `project_code` STRING COMMENT 'Identifier of the project or contract logistics engagement associated with this inventory. Used for project-based inventory segregation and billing.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `quantity_moved` DECIMAL(18,2) COMMENT 'Quantity of inventory units moved in this transaction. Positive for additions, negative for reductions. Supports fractional quantities for catch-weight items.',
    `reason_code` STRING COMMENT 'Standardized code explaining the business reason for the movement. Required for adjustments, write-offs, and exception transactions.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `reference_document_number` STRING COMMENT 'Business identifier of the source document that triggered this movement (ASN number, PO number, sales order number, etc.). Enables cross-system reconciliation.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that triggered or authorized this inventory movement. Provides audit trail linkage to originating business transaction. [ENUM-REF-CANDIDATE: asn|purchase_order|sales_order|transfer_order|work_order|cycle_count|adjustment_request — 7 candidates stripped; promote to reference product]',
    `reference_line_number` STRING COMMENT 'Line item number within the reference document. Links movement to specific order line or ASN line for detailed reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this movement is a reversal or correction of a previous transaction. Used for audit trail and inventory reconciliation.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items. Enables unit-level tracking for high-value or regulated goods.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the item being moved. Links to product master for item attributes and inventory control parameters.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this inventory movement record. Supports multi-system data integration and lineage tracking.. Valid values are `manhattan_wms|sap_ewm|oracle_wms|blue_yonder|manual_entry`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the inventory requires temperature-controlled storage (cold chain). Triggers special handling and monitoring requirements.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable storage temperature in Celsius for temperature-sensitive inventory. Used for cold chain compliance monitoring.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable storage temperature in Celsius for temperature-sensitive inventory. Used for cold chain compliance monitoring.',
    `to_location_code` STRING COMMENT 'Destination warehouse location code to which inventory is being moved. Null for shipment/dispatch transactions. Supports multi-level location hierarchy (zone-aisle-bay-level-position).. Valid values are `^[A-Z0-9-]{4,20}$`',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the inventory movement (quantity_moved × cost_per_unit). Used for inventory valuation and financial reporting. Currency is USD unless otherwise specified in warehouse configuration.',
    `un_number` STRING COMMENT 'UN number for hazardous materials classification. Required for dangerous goods handling, storage, and transportation compliance.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity moved. Aligns with SKU base unit or alternate handling units. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the inventory moved, measured in cubic meters. Used for warehouse space utilization and slotting optimization.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the inventory moved, measured in kilograms. Used for capacity planning, freight calculation, and dimensional weight analysis.',
    CONSTRAINT pk_inventory_movement PRIMARY KEY(`inventory_movement_id`)
) COMMENT 'Atomic inventory transaction record capturing every movement, adjustment, or transfer of stock within or between warehouse locations. Records movement type (receipt, putaway, pick, replenishment, transfer, adjustment, cycle count, damage write-off, return), SKU, from-location, to-location, quantity moved, movement timestamp, operative ID, reference document number, and reason code. Provides full inventory audit trail required for FIFO/LIFO position recalculation, stock reconciliation, and regulatory compliance (SOX, customs bonded warehouse reporting).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count event. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the approver. Used for audit trail and accountability.',
    `counter_team_id` BIGINT COMMENT 'Identifier for the team or crew assigned to perform the physical count. Used for labor productivity tracking.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where the cycle count is performed.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to warehouse.zone. Business justification: cycle_count has zone_code (STRING) indicating which zone is being counted. Adding a proper zone_id FK enables JOIN to zone master for zone details. zone_code removed as it can be retrieved via the FK ',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Inventory accuracy percentage for this count event. Calculated as (locations with zero variance / total locations counted) * 100. Key performance indicator for warehouse operations.',
    `adjustment_posted` BOOLEAN COMMENT 'Indicates whether inventory adjustments resulting from count variances have been posted to the WMS and financial systems.',
    `adjustment_posted_timestamp` TIMESTAMP COMMENT 'Date and time when inventory adjustments were posted to the system. Used for financial reconciliation and audit trail.',
    `aisle_range_end` STRING COMMENT 'Ending aisle identifier for the count scope. Used to define physical location boundaries.',
    `aisle_range_start` STRING COMMENT 'Starting aisle identifier for the count scope. Used to define physical location boundaries.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count results were approved by the authorized approver.',
    `approver_name` STRING COMMENT 'Name of the warehouse manager or supervisor who approved the cycle count results and variances.',
    `count_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the physical count activity was completed. Marks the end of the count execution window.',
    `count_method` STRING COMMENT 'Method used to perform the physical count. Manual = paper-based or visual; RFID = radio frequency identification; Barcode Scan = handheld scanner; Automated = robotic or sensor-based.. Valid values are `manual|rfid|barcode_scan|automated`',
    `count_program_code` STRING COMMENT 'Business identifier for the cycle count program or event. Externally-known code used for tracking and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `count_program_name` STRING COMMENT 'Human-readable name of the cycle count program or event.',
    `count_reason` STRING COMMENT 'Business reason or trigger for the cycle count. Examples: scheduled rotation, exception investigation, audit requirement, pre-physical inventory, post-receiving verification.',
    `count_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the physical count activity began. Marks the beginning of the count execution window.',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event. Scheduled = planned but not started; In-Progress = counting underway; Completed = count finished awaiting approval; Approved = variances reviewed and accepted; Cancelled = count aborted; On-Hold = temporarily suspended.. Valid values are `scheduled|in_progress|completed|approved|cancelled|on_hold`',
    `count_type` STRING COMMENT 'Classification of the count event. Full = complete facility inventory; Cycle = scheduled rotating count; Spot = ad-hoc targeted count; ABC-Velocity = frequency-based on SKU velocity; Blind = count without system quantity reference; Location-Directed = system-assigned location count.. Valid values are `full|cycle|spot|abc_velocity|blind|location_directed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was first created in the system. Audit trail field.',
    `fifo_lifo_method` STRING COMMENT 'Inventory valuation method applied during count variance adjustment. FIFO = First In First Out; LIFO = Last In First Out; FEFO = First Expired First Out; Not Applicable = no specific method.. Valid values are `fifo|lifo|fefo|not_applicable`',
    `hazmat_count_flag` BOOLEAN COMMENT 'Indicates whether this cycle count includes hazardous materials requiring special handling and compliance procedures.',
    `labor_hours_actual` DECIMAL(18,2) COMMENT 'Actual labor hours spent performing the cycle count. Used for labor productivity analysis and cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was last updated. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments about the cycle count event. May include variance explanations, operational issues, or special circumstances.',
    `priority_level` STRING COMMENT 'Priority classification for the cycle count event. Critical = immediate count required; High = urgent; Medium = standard; Low = routine.. Valid values are `critical|high|medium|low`',
    `recount_count` STRING COMMENT 'Number of times this cycle count has been recounted. Used to track count quality and identify problematic locations or SKUs.',
    `recount_required` BOOLEAN COMMENT 'Indicates whether a recount is required due to significant variances or count discrepancies exceeding tolerance thresholds.',
    `regulatory_audit_flag` BOOLEAN COMMENT 'Indicates whether this cycle count is part of a regulatory audit or compliance requirement (e.g., customs bonded warehouse audit, ISO certification audit).',
    `scheduled_date` DATE COMMENT 'Planned date for the cycle count event to be executed. Used for count program planning and resource allocation.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this cycle count includes temperature-controlled or cold storage inventory.',
    `total_locations_counted` STRING COMMENT 'Total number of storage locations physically counted during this cycle count event.',
    `total_skus_counted` STRING COMMENT 'Total number of unique SKUs physically counted during this cycle count event.',
    `total_units_counted` STRING COMMENT 'Total quantity of inventory units physically counted across all SKUs and locations.',
    `variance_quantity` STRING COMMENT 'Net difference between physical count quantity and system quantity (physical minus system). Positive indicates overage; negative indicates shortage.',
    `variance_tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance threshold percentage for this count event. Variances exceeding this threshold trigger recount or approval workflows.',
    `variance_value_usd` DECIMAL(18,2) COMMENT 'Financial value of the inventory variance in USD. Calculated as variance quantity multiplied by unit cost. Used for financial reconciliation and inventory accuracy KPI.',
    `wms_batch_reference` STRING COMMENT 'Batch identifier from the source WMS system. Used for traceability and integration with Manhattan WMS.. Valid values are `^[A-Z0-9_-]{5,30}$`',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Cycle count program record representing a scheduled or ad-hoc physical inventory count event for a defined set of storage locations or SKUs within a facility. Captures count program name, count type (full, cycle, spot, ABC-velocity), facility, zone scope, scheduled date, count start timestamp, count end timestamp, total locations counted, total SKUs counted, variance quantity, variance value, count status (scheduled, in-progress, completed, approved), and approver. Supports inventory accuracy KPI and regulatory stock reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` (
    `cycle_count_line_id` BIGINT COMMENT 'Unique identifier for the cycle count line record. Primary key.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the supervisor or manager who approved or rejected the cycle count variance. Nullable if not yet approved.',
    `cycle_count_id` BIGINT COMMENT 'Reference to the parent cycle count header that this line belongs to. Links to the cycle count batch or session.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where the cycle count was performed.',
    `inventory_movement_id` BIGINT COMMENT 'The unique transaction identifier of the inventory adjustment posting in the WMS. Nullable if adjustment not yet posted.',
    `primary_cycle_counter_employee_id` BIGINT COMMENT 'The employee identifier of the warehouse associate who performed the initial count. Links to workforce management system.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Cycle count lines MUST reference the authoritative SKU master for accurate inventory reconciliation. Currently cycle_count_line has sku_code STRING field but lacks proper FK to sku.sku_id. Adding sku_',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: Cycle count lines MUST reference the authoritative storage location master. Currently cycle_count_line has storage_location_code STRING field but lacks proper FK to storage_location.storage_location_i',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment has been posted to the WMS and financial systems. True if posted, False if pending.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The date and time when the inventory adjustment was posted to the system. Nullable if adjustment not yet posted.',
    `approval_status` STRING COMMENT 'Approval status of the cycle count line. Indicates whether the count variance has been reviewed and approved for inventory adjustment posting.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the cycle count line was approved or rejected. Nullable if not yet approved.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The unit cost of the SKU at the time of the cycle count. Used to calculate the financial impact of the variance. Sourced from inventory valuation system.',
    `count_status` STRING COMMENT 'Current status of this cycle count line in the workflow. Tracks progression from initial count through approval and adjustment.. Valid values are `pending|counted|recounted|approved|rejected|adjusted`',
    `count_timestamp` TIMESTAMP COMMENT 'The date and time when the initial physical count was performed. Business event timestamp for the count activity.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse associate during the cycle count.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count line record was first created in the system. Audit trail timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost and variance value amounts. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'The expiration or best-before date of the lot counted. Used for FEFO (First Expired First Out) inventory management. Nullable for non-perishable items.',
    `inventory_condition_code` STRING COMMENT 'The condition or quality status of the inventory counted. Determines whether inventory is available for sale or fulfillment.. Valid values are `good|damaged|expired|quarantine|hold|rework`',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether this variance requires formal investigation due to high value, high percentage, or recurring pattern. True if investigation is required, False otherwise.',
    `investigation_status` STRING COMMENT 'Current status of the variance investigation workflow. Tracks progression from initiation through resolution.. Valid values are `not_required|pending|in_progress|completed|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count line record was last updated. Audit trail timestamp for tracking changes.',
    `line_number` STRING COMMENT 'Sequential line number within the cycle count header. Used for ordering and referencing specific count lines.',
    `lot_number` STRING COMMENT 'The lot or batch number of the inventory counted. Used for traceability and FIFO/LIFO inventory management. Nullable for non-lot-tracked items.',
    `recount_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded during the recount verification. Nullable if no recount was performed.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether this line requires a recount due to variance exceeding threshold or other business rules. True if recount is required, False otherwise.',
    `recount_timestamp` TIMESTAMP COMMENT 'The date and time when the recount verification was performed. Nullable if no recount was performed.',
    `recount_variance_quantity` DECIMAL(18,2) COMMENT 'The variance between recount quantity and system quantity. Nullable if no recount was performed.',
    `serial_number` STRING COMMENT 'The serial number of the specific unit counted. Used for serialized inventory tracking. Nullable for non-serialized items.',
    `system_quantity` DECIMAL(18,2) COMMENT 'The book stock quantity recorded in the WMS system before the physical count. Also known as expected quantity or on-hand quantity.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantities recorded. Common values: EA (Each), CS (Case), PL (Pallet), BX (Box), KG (Kilogram), LB (Pound), LT (Liter), GL (Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `variance_notes` STRING COMMENT 'Free-text notes explaining the variance, investigation findings, or corrective actions taken. Used for audit trail and continuous improvement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of system quantity. Calculated as (variance_quantity / system_quantity) * 100. Used for threshold-based recount triggers.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity. Calculated as counted_quantity minus system_quantity. Positive indicates overage, negative indicates shortage.',
    `variance_reason_code` STRING COMMENT 'The root cause category assigned to explain the inventory variance. Used for discrepancy investigation and process improvement. [ENUM-REF-CANDIDATE: damage|theft|miscount|system_error|receiving_error|picking_error|putaway_error|shrinkage|obsolescence|unknown|other — promote to reference product]',
    `variance_value_amount` DECIMAL(18,2) COMMENT 'The financial value of the variance, calculated as variance_quantity multiplied by cost_per_unit. Used for financial reporting and variance analysis.',
    CONSTRAINT pk_cycle_count_line PRIMARY KEY(`cycle_count_line_id`)
) COMMENT 'Line-level result of a cycle count for each storage location and SKU combination counted. Records location, SKU, lot number, system quantity (book stock), counted quantity, variance quantity, variance percentage, recount flag, recount quantity, adjuster ID, adjustment timestamp, and approval status. Drives inventory adjustment postings and discrepancy investigation workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order. Primary key for the replenishment order entity.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the active pick-face location to which inventory will be moved to maintain picking availability.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse worker or operator assigned to execute the replenishment task.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse facility where the replenishment is being executed.',
    `primary_replenishment_storage_location_id` BIGINT COMMENT 'Identifier of the reserve or bulk storage location from which inventory will be moved.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Replenishment orders MUST reference the authoritative SKU master. Currently replenishment_order has sku_code STRING field but lacks proper FK to sku.sku_id. Adding sku_id enables JOIN to sku master fo',
    `wave_id` BIGINT COMMENT 'Identifier of the picking wave that triggered this replenishment order, if applicable. Used for wave-triggered replenishment strategies.',
    `zone_id` BIGINT COMMENT 'Identifier of the warehouse zone where the replenishment activity is taking place, used for zone-based labor assignment and performance tracking.',
    `actual_duration_minutes` STRING COMMENT 'The actual time in minutes taken to complete the replenishment task, calculated from started to completed timestamp.',
    `actual_quantity_moved` DECIMAL(18,2) COMMENT 'The actual quantity of inventory units successfully moved upon completion. May differ from planned replenishment quantity due to inventory availability or operational constraints.',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order was assigned to a warehouse worker or automated system.',
    `batch_reference` STRING COMMENT 'Identifier for a batch of replenishment orders grouped together for efficient execution by a single worker or equipment unit.. Valid values are `^BATCH-[0-9]{8,12}$`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the replenishment order was cancelled, if applicable.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order was successfully completed and inventory moved to the destination location.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order was created by the warehouse management system.',
    `equipment_type` STRING COMMENT 'The type of material handling equipment required or used to execute the replenishment task.. Valid values are `forklift|pallet_jack|reach_truck|order_picker|manual|automated_system`',
    `estimated_duration_minutes` STRING COMMENT 'The estimated time in minutes to complete the replenishment task based on labor standards and distance calculations.',
    `expiration_date` DATE COMMENT 'The expiration or best-before date of the inventory being replenished, critical for First Expired First Out (FEFO) replenishment strategies.',
    `failure_reason` STRING COMMENT 'Free-text explanation for why the replenishment order failed to complete successfully, if applicable. May include reasons such as insufficient source inventory, location blocked, equipment failure.',
    `fifo_sequence` STRING COMMENT 'Numeric sequence indicating the FIFO priority of the inventory being replenished, ensuring oldest inventory is moved to pick-face first.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the replenishment involves hazardous materials requiring certified workers and special safety protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order record was last updated in the system.',
    `lot_number` STRING COMMENT 'The inventory lot or batch number being replenished, used for lot-controlled inventory tracking and First In First Out (FIFO) compliance.. Valid values are `^LOT-[A-Z0-9]{6,20}$`',
    `order_number` STRING COMMENT 'Business-facing unique replenishment order number used for tracking and reference in warehouse operations.. Valid values are `^REP-[0-9]{10}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order indicating its progress through the warehouse workflow.. Valid values are `pending|assigned|in_progress|completed|cancelled|failed`',
    `pick_face_max_quantity` DECIMAL(18,2) COMMENT 'The maximum inventory capacity for the destination pick-face location used to calculate optimal replenishment quantity.',
    `pick_face_min_quantity` DECIMAL(18,2) COMMENT 'The minimum inventory level threshold for the destination pick-face location that triggered the replenishment order.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for the replenishment order where lower numbers indicate higher urgency. Used for task sequencing and labor assignment.',
    `replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory units to be moved from source to destination location.',
    `started_timestamp` TIMESTAMP COMMENT 'The date and time when physical execution of the replenishment task began.',
    `system_generated_flag` BOOLEAN COMMENT 'Indicates whether the replenishment order was automatically generated by the warehouse management system based on business rules or manually created by an operator.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the replenishment involves temperature-controlled inventory requiring special handling and equipment.',
    `travel_distance_meters` DECIMAL(18,2) COMMENT 'The calculated travel distance in meters between source and destination locations used for labor planning and productivity measurement.',
    `trigger_type` STRING COMMENT 'The business rule or event that initiated the replenishment order. Min-max indicates inventory fell below minimum threshold, demand-driven indicates anticipated pick demand, wave-triggered indicates wave planning requirement, manual indicates operator-initiated, scheduled indicates time-based replenishment.. Valid values are `min_max|demand_driven|wave_triggered|manual|scheduled`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the replenishment quantity.. Valid values are `each|case|pallet|carton|box`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between planned replenishment quantity and actual quantity moved. Positive values indicate over-replenishment, negative values indicate under-replenishment.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Replenishment task order directing the movement of stock from reserve/bulk storage to active pick-face locations to maintain minimum pick-face inventory levels. Captures replenishment order number, trigger type (min-max, demand-driven, wave-triggered), source location, destination pick-face location, SKU, replenishment quantity, priority, creation timestamp, assignment timestamp, completion timestamp, and status. Ensures pick-face availability and prevents stockout-driven pick failures.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` (
    `returns_receipt_id` BIGINT COMMENT 'Unique identifier for the returns receipt record. Primary key.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Returns processing incurs billable accessorial charges (restocking fees, inspection, disposal). Business need: Returns cost recovery, reverse logistics billing, customer charge-back for non-compliant ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Returns processing governed by contract terms defining handling procedures, restocking fees, credit policies, and reverse logistics SLAs. Returns teams apply contract-specific policies; billing calcul',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Returns are delivered by carriers; tracking which carrier handled the return is essential for carrier performance evaluation, damage claims attribution, reverse logistics billing, and return transit t',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Return service level (ground/expedited) affects processing priority, customer refund timing, and reverse logistics costs. Links returns to carrier service contract terms for billing reconciliation and',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account that initiated the return or is associated with the original order.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: International returns require customs re-import declarations for duty assessment and regulatory compliance. Links return receipt to import declaration for duty drawback claims, temporary import bond c',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Returns receipts record the driver who delivered returns. Required for POD verification on returns, returns processing accountability, and driver performance tracking in reverse logistics operations.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse facility where the return was received.',
    `outbound_shipment_order_id` BIGINT COMMENT 'Foreign key linking to warehouse.outbound_shipment_order. Business justification: Returns receipts MUST reference the original outbound shipment order for traceability. Currently returns_receipt has originating_order_number STRING field but lacks proper FK to outbound_shipment_orde',
    `employee_id` BIGINT COMMENT 'Employee or operator identifier who physically received and processed the inbound return at the dock.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to fulfillment.rma. Business justification: Returns processing requires linking physical warehouse receipt to RMA authorization for disposition decisions (restock/destroy), refund triggering, and merchant settlement. RMA number is denormalized;',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Returns receipts track the vehicle that delivered returned goods. Needed for reverse logistics tracking, carrier performance measurement on returns, and linking warehouse returns processing to inbound',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Returns processing requires return authorization documents, return shipping labels, credit memos, and proof-of-return documentation. Standard reverse logistics documentation for customer refunds, carr',
    `carrier_reference_number` STRING COMMENT 'Tracking or reference number from the carrier who delivered the return shipment to the warehouse.',
    `claim_initiated_flag` BOOLEAN COMMENT 'Indicates whether a cargo claim or insurance claim was initiated for this return due to damage or loss.',
    `claim_reference_number` STRING COMMENT 'Reference number of the associated cargo claim or insurance claim if one was initiated for this return.',
    `condition_assessment` STRING COMMENT 'Overall condition assessment of the returned goods after inspection. Determines eligibility for resale or other disposition.. Valid values are `resalable|damaged|quarantine|destroy|refurbish_required`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this returns receipt record was first created in the warehouse management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `damaged_quantity` STRING COMMENT 'Number of units from this return that were assessed as damaged and not suitable for resale.',
    `disposition_action` STRING COMMENT 'Final disposition action assigned to the returned goods based on condition assessment and business rules. [ENUM-REF-CANDIDATE: restock|refurbish|quarantine|dispose|return_to_vendor|donate|salvage — 7 candidates stripped; promote to reference product]',
    `disposition_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the final disposition action was completed and the return was closed in the system.',
    `inspection_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inspection and condition assessment of the return was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this returns receipt record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments recorded by warehouse operatives during receiving, inspection, or disposition processing.',
    `originating_order_number` STRING COMMENT 'Reference to the original outbound order or shipment number that this return is associated with.',
    `pod_document_reference` STRING COMMENT 'Reference to the Proof of Delivery document or electronic proof of delivery for the return shipment.',
    `quarantined_quantity` STRING COMMENT 'Number of units from this return that were placed in quarantine pending further investigation or quality review.',
    `receipt_number` STRING COMMENT 'Business-facing unique receipt number assigned to the return when received at the warehouse. Format: RR followed by 10 digits.. Valid values are `^RR[0-9]{10}$`',
    `received_date` DATE COMMENT 'Date when the return shipment was physically received at the warehouse dock.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the return shipment was received and scanned into the warehouse management system.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether this return is eligible for customer refund based on return policy and condition assessment.',
    `restocked_quantity` STRING COMMENT 'Number of units from this return that were restocked into available inventory for resale.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the return as provided by the customer or carrier.',
    `return_reason_description` STRING COMMENT 'Detailed text description of the return reason provided by the customer, carrier, or warehouse operative.',
    `return_status` STRING COMMENT 'Current status of the return in the processing workflow from receipt through final disposition. [ENUM-REF-CANDIDATE: received|inspection_pending|inspection_complete|disposition_assigned|restocked|disposed|quarantined — 7 candidates stripped; promote to reference product]',
    `return_type` STRING COMMENT 'Classification of the return reason. Indicates why the goods were returned to the warehouse.. Valid values are `customer_return|failed_delivery|damaged_in_transit|warranty_return|wrong_item_shipped|quality_defect`',
    `total_declared_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the returned goods as declared on the return documentation or original order.',
    `total_packages_received` STRING COMMENT 'Total number of packages, cartons, or containers received in this return shipment.',
    `total_units_received` STRING COMMENT 'Total count of individual units or items received in this return shipment across all SKUs.',
    CONSTRAINT pk_returns_receipt PRIMARY KEY(`returns_receipt_id`)
) COMMENT 'Returns processing record capturing the receipt and disposition of inbound returned goods from customers or delivery failures (RMA — Return Merchandise Authorization). Records return receipt number, return type (customer return, failed delivery, damaged in transit, warranty return), originating order reference, carrier reference, received date, total units received, condition assessment (resalable, damaged, quarantine, destroy), disposition action (restock, refurbish, quarantine, dispose), processing operative, and completion timestamp. Supports e-commerce reverse logistics and claims processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` (
    `returns_receipt_line_id` BIGINT COMMENT 'Unique identifier for the returns receipt line. Primary key.',
    `order_line_id` BIGINT COMMENT 'Foreign key reference to the original order line that this return corresponds to.',
    `outbound_shipment_order_id` BIGINT COMMENT 'Foreign key reference to the original outbound shipment from which this item is being returned.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the warehouse user who performed the quality inspection.',
    `storage_location_id` BIGINT COMMENT 'Foreign key reference to the storage location where resalable units will be restocked.',
    `returns_receipt_id` BIGINT COMMENT 'Foreign key reference to the parent returns receipt header record.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU master record identifying the returned product.',
    `condition_code` STRING COMMENT 'Code indicating the physical condition of the returned SKU upon receipt.. Valid values are `NEW|USED|DAMAGED|DEFECTIVE|EXPIRED|OPENED`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this return receipt line record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be credited to the customer for this return line.',
    `credit_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this return line is eligible for customer credit or refund.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units that are damaged and cannot be resold without repair or refurbishment.',
    `destroyed_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units that are beyond repair and must be destroyed or disposed of.',
    `disposition_code` STRING COMMENT 'Code indicating the disposition decision for the returned SKU (restock, repair, scrap, donate, return to vendor).. Valid values are `RESTOCK|REPAIR|SCRAP|DONATE|RETURN_VENDOR`',
    `expiry_date` DATE COMMENT 'Expiration date of the returned SKU, relevant for perishable or time-sensitive goods.',
    `hazmat_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the returned SKU is classified as hazardous material requiring special handling.',
    `inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the quality inspection was completed for this return line.',
    `inspection_notes` STRING COMMENT 'Free-text notes recorded by the quality inspector regarding the condition and disposition of the returned SKU.',
    `inspection_status` STRING COMMENT 'Status of the quality inspection process for the returned line.. Valid values are `PENDING|IN_PROGRESS|PASSED|FAILED|WAIVED`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this return receipt line record was last updated.',
    `line_number` STRING COMMENT 'Sequential line number within the returns receipt, used for ordering and reference.',
    `line_status` STRING COMMENT 'Current processing status of the return receipt line in the returns workflow.. Valid values are `RECEIVED|INSPECTED|RESTOCKED|DISPOSED|PENDING`',
    `lot_number` STRING COMMENT 'Lot or batch number of the returned SKU, used for traceability and quality control.',
    `manufacture_date` DATE COMMENT 'Date the returned SKU was manufactured, used for shelf life calculation and quality tracking.',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units placed in quarantine pending quality inspection or disposition decision.',
    `resalable_quantity` DECIMAL(18,2) COMMENT 'Quantity of returned units that are in resalable condition and can be restocked for sale.',
    `restocked_timestamp` TIMESTAMP COMMENT 'Date and time when resalable units were restocked into inventory.',
    `return_reason_code` STRING COMMENT 'Code indicating the reason for the return (e.g., damaged in transit, wrong item shipped, customer remorse, quality defect). [ENUM-REF-CANDIDATE: DAMAGED_TRANSIT|WRONG_ITEM|CUSTOMER_REMORSE|QUALITY_DEFECT|EXPIRED|OVERSTOCKED|RECALL|WARRANTY_CLAIM — promote to reference product]',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the SKU returned by the customer or consignee.',
    `rma_number` STRING COMMENT 'Return Merchandise Authorization number issued to the customer authorizing the return.',
    `serial_number` STRING COMMENT 'Serial number of the returned unit for serialized inventory tracking.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification for dangerous goods.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity (EA=Each, CS=Case, PL=Pallet, BX=Box, KG=Kilogram, LB=Pound).. Valid values are `EA|CS|PL|BX|KG|LB`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the returned quantity in cubic meters (CBM).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the returned quantity in kilograms.',
    CONSTRAINT pk_returns_receipt_line PRIMARY KEY(`returns_receipt_line_id`)
) COMMENT 'Line-level detail of a returns receipt capturing each SKU returned, quantity, condition, and disposition outcome. Records line number, SKU, returned quantity, resalable quantity, damaged quantity, destroyed quantity, lot number, serial number, condition code, disposition code, restock location, and credit eligibility flag. Feeds inventory position updates and customer credit note generation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` (
    `labor_activity_id` BIGINT COMMENT 'Unique identifier for the warehouse labor activity record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warehouse labor costs must be allocated to cost centers for accurate financial accounting. Labor activity records drive cost allocation for picking, packing, receiving, and VAS operations. Essential f',
    `equipment_id` BIGINT COMMENT 'Unique identifier or asset tag of the specific equipment unit used during the activity.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse facility where the activity was performed.',
    `fulfillment_order_id` BIGINT COMMENT 'Identifier of the customer order or shipment associated with this activity (applicable for picking, packing, and loading activities).',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Dedicated labor hours for customer-specific operations (special projects, peak season support) are invoiced in 3PL contracts with labor pass-through clauses. Labor_activity tracks billable hours that ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Labor activities for loading/unloading are tied to specific route plan legs for labor costing, productivity tracking, and dock scheduling. Route plan context enables accurate labor allocation to freig',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Labor activities are performed by employees in specific positions; enables position-based productivity benchmarking, labor standards by role, workforce planning, and training needs analysis. Essential',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operative who performed the activity. Links to workforce management system.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the work shift during which the activity was performed.',
    `sku_id` BIGINT COMMENT 'Identifier of the Stock Keeping Unit (SKU) handled during the activity.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the storage location (bin, rack, aisle) where the activity took place.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Labor activities (loading/unloading) are documented in delivery notes, dock receipts, and proof-of-service documents for carrier billing and dispute resolution. Operational audit trail for labor cost ',
    `warehouse_asn_id` BIGINT COMMENT 'Identifier of the Advanced Shipping Notice (ASN) associated with this activity (applicable for receiving and putaway activities).',
    `zone_id` BIGINT COMMENT 'Identifier of the warehouse zone where the activity took place (e.g., receiving dock, picking zone, packing area).',
    `activity_status` STRING COMMENT 'Current status of the labor activity in its lifecycle.. Valid values are `in_progress|completed|paused|cancelled|exception`',
    `activity_type` STRING COMMENT 'Type of warehouse work activity performed. [ENUM-REF-CANDIDATE: receiving|putaway|picking|packing|replenishment|cycle_count|loading|unloading|housekeeping|quality_inspection|returns_processing|kitting|labeling|consolidation|deconsolidation|cross_docking — promote to reference product]. Valid values are `receiving|putaway|picking|packing|replenishment|cycle_count`',
    `actual_time_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes the operative spent on the activity, excluding breaks and idle time.',
    `batch_number` STRING COMMENT 'Batch or wave number grouping multiple activities together for coordinated execution (e.g., wave picking).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this labor activity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amount.. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes for the activity, calculated as the difference between end and start timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the operative completed or paused the activity. Captured from RF scanner or voice device logout.',
    `equipment_type` STRING COMMENT 'Type of equipment or device used by the operative during the activity (e.g., forklift, pallet jack, RF scanner, voice device).. Valid values are `forklift|pallet_jack|rf_scanner|voice_device|none`',
    `exception_code` STRING COMMENT 'Code indicating any exception or deviation that occurred during the activity (e.g., damaged goods, short pick, system error).',
    `exception_notes` STRING COMMENT 'Free-text notes describing the exception or any special circumstances related to the activity.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Incentive pay amount earned for this activity based on productivity performance.',
    `incentive_eligible` BOOLEAN COMMENT 'Indicates whether this activity is eligible for productivity-based incentive pay.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Allocated labor cost for this activity in the facilitys operating currency, calculated based on operative hourly rate and activity duration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this labor activity record was last updated in the system.',
    `priority_level` STRING COMMENT 'Priority level assigned to the activity based on Service Level Agreement (SLA) requirements or shipment urgency.. Valid values are `urgent|high|normal|low`',
    `productivity_percentage` DECIMAL(18,2) COMMENT 'Productivity percentage calculated as (standard_time_minutes / actual_time_minutes) * 100. Values above 100% indicate performance exceeding standard.',
    `quality_check_passed` BOOLEAN COMMENT 'Indicates whether the quality inspection was passed (true) or failed (false). Null if no quality check was performed.',
    `quality_check_required` BOOLEAN COMMENT 'Indicates whether a quality inspection was required for this activity.',
    `standard_time_minutes` DECIMAL(18,2) COMMENT 'Engineered labor standard time in minutes expected to complete the activity, based on industrial engineering studies and labor standards.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the operative began the activity. Captured from Radio Frequency (RF) scanner or voice device login.',
    `training_mode` BOOLEAN COMMENT 'Indicates whether the operative was in training mode during this activity. Training activities may be excluded from productivity calculations.',
    `travel_distance_meters` DECIMAL(18,2) COMMENT 'Estimated or tracked travel distance in meters covered by the operative during the activity.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the units processed (e.g., each, case, pallet, line, order).. Valid values are `each|case|pallet|line|order`',
    `units_processed` STRING COMMENT 'Number of units (Stock Keeping Units, cartons, pallets, or line items) processed during the activity.',
    `work_order_number` STRING COMMENT 'Work order or task number assigned by the Warehouse Management System (WMS) for this activity.',
    CONSTRAINT pk_labor_activity PRIMARY KEY(`labor_activity_id`)
) COMMENT 'Warehouse labor productivity record capturing each discrete work activity performed by an operative during a shift, as tracked by Manhattan WMS labor management module. Records activity type (receiving, putaway, picking, packing, replenishment, cycle count, loading, housekeeping), operative ID, facility, zone, start timestamp, end timestamp, duration minutes, units processed, standard time (engineered labor standard), actual time, productivity percentage, and equipment used (forklift, RF scanner, voice device). Drives FTE utilization, labor cost allocation, and OTIF performance attribution.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` (
    `dock_appointment_id` BIGINT COMMENT 'Unique identifier for the dock door appointment record. Primary key for the dock appointment entity.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Dock appointments trigger billable accessorial charges (detention, storage, special handling). Business need: Billable event capture, detention fee calculation, appointment cost tracking, carrier char',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Dock appointments scheduled under carrier contracts defining capacity commitments, appointment windows, detention/demurrage terms, and loading/unloading SLAs. Dock scheduling validates carrier contrac',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier company responsible for the shipment associated with this dock appointment.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Dock appointments are scheduled for specific carrier service types with different handling requirements, equipment needs, and cutoff times. Critical for dock door allocation and labor resource plannin',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Dock appointments record driver identity for security gate access, compliance verification, driver check-in/check-out timestamps, and detention billing. Essential for warehouse security protocols and ',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center facility where the dock appointment is scheduled.',
    `facility_inspection_id` BIGINT COMMENT 'Foreign key linking to safety.facility_inspection. Business justification: Dock door safety inspections (structural integrity, lighting, seal condition, traffic control) are scheduled alongside operational appointments. Safety officers conduct pre-shift dock inspections reco',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Customs holds (exam, VACIS, agriculture inspection) delay dock operations and require appointment rescheduling. Links appointment to hold record for detention tracking, demurrage calculation, customer',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Dock appointment fees (early arrival penalties, detention charges, no-show fees) are invoiced to customers or carriers. Dock_appointment captures billable events for dock utilization; invoice link req',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Dock appointment scheduling requires lane context for carrier coordination, capacity planning, and dock door assignment. Lane determines expected vehicle type, handling requirements, and appointment d',
    `outbound_shipment_order_id` BIGINT COMMENT 'Foreign key linking to warehouse.outbound_shipment_order. Business justification: Dock appointments for outbound shipments MUST reference the outbound shipment order. Currently dock_appointment has outbound_order_number STRING field but lacks proper FK to outbound_shipment_order.ou',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Dock appointments are scheduled based on route plan ETAs/ETDs for resource allocation and carrier coordination. Route plan provides planned arrival/departure times driving dock door assignment and lab',
    `employee_id` BIGINT COMMENT 'Reference to the user who cancelled the appointment. Used for audit trail and accountability.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Dock appointments must track which truck/trailer arrives for loading/unloading. Critical for yard management, dock door assignment optimization, driver check-in workflows, and detention time tracking.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Dock appointments reference carrier transport documents (BOL, delivery notes, shipping manifests) for scheduled inbound/outbound shipments. Essential for dock scheduling, carrier check-in, and load ve',
    `warehouse_asn_id` BIGINT COMMENT 'Foreign key linking to warehouse.asn. Business justification: Dock appointments for inbound shipments MUST reference the ASN (Advanced Shipping Notice). Currently dock_appointment has asn_number STRING field but lacks proper FK to asn.asn_id. Adding asn_id enabl',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier or driver checked in at the facility gate or reception. Used for measuring on-time performance and dwell time calculation.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the carrier or driver departed the facility after completing loading or unloading operations. Used for dock throughput and turnaround time analysis.',
    `appointment_duration_minutes` STRING COMMENT 'Estimated or planned duration of the loading or unloading operation in minutes. Used for dock scheduling optimization and labor allocation.',
    `appointment_number` STRING COMMENT 'Business-facing unique appointment reference number used for communication with carriers and drivers. Externally visible identifier for scheduling and tracking purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the dock appointment. Scheduled indicates initial booking, confirmed indicates carrier acknowledgment, checked-in indicates driver arrival, in-progress indicates active loading/unloading, completed indicates finished operation, no-show indicates missed appointment, cancelled indicates appointment termination. [ENUM-REF-CANDIDATE: scheduled|confirmed|checked-in|in-progress|completed|no-show|cancelled — 7 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'Classification of the dock appointment indicating the direction and nature of the operation. Inbound for receiving shipments, outbound for dispatch, cross-dock for direct transfer, live-unload for immediate unloading with driver waiting, drop-trailer for trailer left at facility.. Valid values are `inbound|outbound|cross-dock|live-unload|drop-trailer`',
    `asn_number` STRING COMMENT 'Reference to the Advanced Shipping Notice document associated with this inbound appointment. Links the dock appointment to expected inventory receipts.',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading number for the shipment. Legal document serving as receipt of goods and contract of carriage.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the appointment was cancelled. Used for operational analysis and continuous improvement.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment was cancelled. Used for measuring cancellation lead time and impact on dock utilization.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the driver completed check-in procedures at the facility gate or reception desk. Marks the beginning of the appointment lifecycle.',
    `container_number` STRING COMMENT 'ISO container number for ocean freight shipments. Used for intermodal tracking and customs clearance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dock appointment record was first created in the system. Used for audit trail and data governance.',
    `dock_door_number` STRING COMMENT 'Physical dock door identifier assigned to this appointment. Used for yard management and directing drivers to the correct loading/unloading bay.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `expected_carton_count` STRING COMMENT 'Number of cartons expected to be loaded or unloaded during this appointment. Used for labor planning and throughput estimation.',
    `expected_pallet_count` STRING COMMENT 'Number of pallets expected to be loaded or unloaded during this appointment. Used for labor planning and dock capacity management.',
    `expected_volume_cbm` DECIMAL(18,2) COMMENT 'Total expected volume of the shipment in cubic meters. Used for space planning and trailer utilization analysis.',
    `expected_weight_kg` DECIMAL(18,2) COMMENT 'Total expected weight of the shipment in kilograms. Used for equipment selection and dock floor load capacity verification.',
    `hazmat_class` STRING COMMENT 'UN hazard classification for dangerous goods in the shipment. Used for compliance with International Maritime Dangerous Goods (IMDG) Code and Department of Transportation (DOT) regulations.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and segregation. Determines dock door assignment to hazmat-certified areas.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dock appointment record was last updated. Used for change tracking and data quality monitoring.',
    `loading_complete_timestamp` TIMESTAMP COMMENT 'Date and time when loading or unloading operations were completed. Used for turnaround time calculation and dock throughput metrics.',
    `loading_start_timestamp` TIMESTAMP COMMENT 'Date and time when loading or unloading operations actually began at the dock door. Used for measuring dock productivity and dwell time.',
    `no_show_reason` STRING COMMENT 'Explanation for why a scheduled appointment was missed by the carrier or driver. Used for carrier performance tracking and root cause analysis.',
    `outbound_order_number` STRING COMMENT 'Reference to the outbound shipment order or wave being loaded during this appointment. Links dock appointment to order fulfillment operations.',
    `pro_number` STRING COMMENT 'Progressive or freight bill number assigned by the carrier for tracking and billing purposes. Common in Less Than Truckload (LTL) shipments.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the inbound shipment. Used for receiving verification and three-way match reconciliation.',
    `scheduled_arrival_end` TIMESTAMP COMMENT 'End of the scheduled arrival time window for the carrier or driver. Represents the latest acceptable arrival time for the appointment without being considered late.',
    `scheduled_arrival_start` TIMESTAMP COMMENT 'Beginning of the scheduled arrival time window for the carrier or driver. Represents the earliest acceptable arrival time for the appointment.',
    `seal_number` STRING COMMENT 'Security seal number applied to the trailer or container. Verified at check-in to ensure cargo integrity and customs compliance.',
    `shipment_priority` STRING COMMENT 'Priority level assigned to the shipment associated with this appointment. Influences dock door allocation and processing sequence.. Valid values are `standard|expedited|urgent|critical`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements or operational notes for the appointment. Examples include fragile cargo, top-load only, or specific unloading sequence.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled handling. Determines dock door assignment to refrigerated bays.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance verification.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance verification.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance. Required for hazmat shipment documentation and emergency response.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dock_appointment PRIMARY KEY(`dock_appointment_id`)
) COMMENT 'Dock door appointment scheduling record managing the allocation of inbound and outbound dock doors to carriers, drivers, and shipments at a warehouse facility. Captures appointment number, appointment type (inbound/outbound), facility, dock door number, scheduled arrival window (start/end), carrier name, vehicle type, vehicle registration, driver name, associated ASN or outbound order reference, appointment status (scheduled, confirmed, arrived, in-progress, completed, no-show, cancelled), and actual arrival timestamp. Enables yard management and dock throughput optimization.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` (
    `wip_record_id` BIGINT COMMENT 'Unique identifier for the work-in-progress record. Primary key.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Value-added services (kitting, labeling, repackaging) are billable accessorial charges. Business need: VAS revenue capture, customer billing for warehouse services, labor cost recovery, service-level ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Value-added services (kitting, assembly, labeling, customization) generate direct labor and material costs that must be allocated to cost centers. Required for VAS cost tracking, customer billing vali',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or contract logistics client for whom this VAS activity is being performed. Critical for billing and SLA tracking.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where the WIP activity is being performed.',
    `outbound_shipment_order_id` BIGINT COMMENT 'Foreign key linking to warehouse.outbound_shipment_order. Business justification: WIP (Work-in-Progress) records for value-added services MUST reference the outbound shipment order being fulfilled. Currently wip_record has order_number STRING field but lacks proper FK to outbound_s',
    `permit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_permit. Business justification: Value-added services work (kitting, assembly, labeling, repackaging) often requires hot work permits, confined space entry permits, or chemical handling permits. VAS supervisors must verify permit iss',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse operative or worker assigned to perform the VAS activity. Used for labor tracking and productivity measurement.',
    `quaternary_wip_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this WIP record, used for audit trail and accountability.',
    `sku_id` BIGINT COMMENT 'Reference to the primary SKU being processed in this WIP record. For kitting operations, this may reference the output kit SKU.',
    `tertiary_wip_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this WIP record in the system, typically a warehouse supervisor or system administrator.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Value-added services (kitting, assembly, labeling) generate work completion certificates, packing documentation, and service delivery proof. Required for customer billing, quality verification, and sh',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours consumed to complete this WIP activity, calculated from start to completion timestamps. Used for productivity analysis and VAS billing.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this WIP activity is billable to the customer under the contract logistics agreement. True if billable, False if internal or non-billable.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the WIP activity was completed or finalized. Null if the activity is still in progress or queued.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this WIP record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the VAS charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `defect_code` STRING COMMENT 'Standardized code identifying the type of defect or quality issue found during inspection (e.g., damaged packaging, incorrect labeling, contamination).',
    `failure_reason_code` STRING COMMENT 'Code identifying the reason why the WIP activity failed or was rejected, used for root cause analysis and process improvement.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the goods being processed are classified as hazardous materials requiring special handling and compliance procedures. True if hazmat, False otherwise.',
    `input_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or units received as input to the WIP process. For kitting, this represents the sum of component quantities; for repackaging, the original quantity before processing.',
    `kit_reference_code` STRING COMMENT 'Reference code for the kit configuration when WIP type is kitting. Defines the bill of materials for the kit assembly.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this WIP record was last updated. Used for audit trail and change tracking.',
    `lot_number` STRING COMMENT 'Lot or batch number of the goods being processed, enabling traceability for quality control and recall management.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the operative or supervisor regarding the WIP activity, including observations, issues, or deviations from standard procedures.',
    `order_number` STRING COMMENT 'Reference to the customer order or fulfillment request that triggered this WIP activity. Used for order-level traceability.',
    `output_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or units produced as output from the WIP process. For kitting, this represents the number of completed kits; for repackaging, the new quantity after processing.',
    `priority_level` STRING COMMENT 'Priority classification for the WIP activity, determining the sequence in which queued work is processed: urgent (immediate processing required), high (expedited), normal (standard), or low (can be deferred).. Valid values are `urgent|high|normal|low`',
    `quality_inspection_result` STRING COMMENT 'Outcome of quality inspection when WIP type is quality_inspection: passed (meets quality standards), failed (does not meet standards), conditional (requires additional review), or not_applicable (no inspection performed).. Valid values are `passed|failed|conditional|not_applicable`',
    `rejection_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected or failed during the WIP process due to quality issues, damage, or non-conformance. These units are typically moved to quarantine or damaged inventory status.',
    `scheduled_completion_date` DATE COMMENT 'Target date for the WIP activity to be completed, used for SLA tracking and customer commitment management.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the WIP activity to begin, used for capacity planning and resource allocation.',
    `serial_number` STRING COMMENT 'Serial number of the individual unit being processed, used for high-value or serialized inventory tracking.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements during the VAS activity, such as temperature control, fragile handling, or customer-specific procedures.',
    `standard_labor_hours` DECIMAL(18,2) COMMENT 'Engineered standard labor hours expected for this type of WIP activity based on time-and-motion studies. Used for variance analysis and performance measurement.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the WIP activity was initiated by the operative. Used for labor productivity measurement and cycle time analysis.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the goods being processed require temperature-controlled handling during the VAS activity. True if temperature-sensitive, False otherwise.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantities recorded in this WIP record (e.g., EA for each, CS for case, PL for pallet).',
    `vas_charge_amount` DECIMAL(18,2) COMMENT 'Billable charge amount for this VAS activity, calculated based on contract rates, labor hours, or per-unit pricing. Used for contract logistics invoicing.',
    `wip_record_number` STRING COMMENT 'Business-facing unique identifier for the WIP record, typically human-readable and used in operational communications and documentation.',
    `wip_status` STRING COMMENT 'Current lifecycle status of the WIP record: queued (awaiting processing), in_progress (actively being worked), completed (successfully finished), failed (processing failed), or cancelled (work order cancelled).. Valid values are `queued|in_progress|completed|failed|cancelled`',
    `wip_type` STRING COMMENT 'Classification of the value-added service being performed: kitting (assembling multiple SKUs into a kit), labelling (applying customer-specific labels), repackaging (changing packaging configuration), quality inspection (QC checks), customs hold (goods under customs examination), or deconsolidation (breaking down bulk shipments).. Valid values are `kitting|labelling|repackaging|quality_inspection|customs_hold|deconsolidation`',
    `work_order_number` STRING COMMENT 'Reference to the parent work order or task assignment that authorized this WIP activity. Links to broader warehouse task management.',
    `work_station_code` STRING COMMENT 'Identifier of the physical work station, packing table, or processing area within the warehouse where the VAS activity is being performed.',
    CONSTRAINT pk_wip_record PRIMARY KEY(`wip_record_id`)
) COMMENT 'Work-in-Progress tracking record for goods undergoing value-added services (VAS) within the warehouse such as kitting, labelling, repackaging, quality inspection, or customs examination. Captures WIP record number, WIP type (kitting, labelling, repackaging, QC inspection, customs hold, deconsolidation), SKU or kit reference, input quantity, output quantity, facility, work station, operative assigned, start timestamp, completion timestamp, WIP status (queued, in-progress, completed, failed), and rejection quantity. Supports contract logistics and e-commerce fulfillment VAS billing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` (
    `hazmat_storage_compliance_id` BIGINT COMMENT 'Unique identifier for the hazmat storage compliance record.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Hazmat storage requires safety certificates, material safety data sheets, compliance certificates, and handling permits. Regulatory mandate for dangerous goods storage, inspection audits, and emergenc',
    `emergency_response_plan_id` BIGINT COMMENT 'Identifier of the emergency response plan applicable to this hazmat storage location.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector or auditor who conducted the last compliance inspection.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse facility where the hazmat SKU is stored.',
    `sku_id` BIGINT COMMENT 'Reference to the hazardous material SKU being stored.',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location within the facility where the hazmat is stored.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the hazmat storage (compliant, over-limit, segregation-breach, zone-violation, expired-permit, non-compliant).. Valid values are `compliant|over_limit|segregation_breach|zone_violation|expired_permit|non_compliant`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required to achieve compliance.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions must be completed to maintain regulatory compliance.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required to bring the storage into compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was first created in the system.',
    `current_stored_quantity` DECIMAL(18,2) COMMENT 'Current quantity of this hazmat SKU stored in the facility at the time of compliance assessment.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed in the storage zone (sprinkler, foam, CO2, dry-chemical, none).. Valid values are `sprinkler|foam|co2|dry_chemical|none`',
    `hazmat_class` STRING COMMENT 'IMDG/ICAO hazmat classification class (1=Explosives, 2=Gases, 3=Flammable Liquids, 4=Flammable Solids, 5=Oxidizing Substances, 6=Toxic Substances, 7=Radioactive, 8=Corrosives, 9=Miscellaneous). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — 9 candidates stripped; promote to reference product]',
    `incident_count` STRING COMMENT 'Number of safety incidents or compliance violations recorded for this hazmat storage location.',
    `inspection_type` STRING COMMENT 'Type of inspection conducted (routine, spot-check, incident-driven, regulatory-audit, annual-review).. Valid values are `routine|spot_check|incident_driven|regulatory_audit|annual_review`',
    `inspector_name` STRING COMMENT 'Full name of the inspector or auditor who conducted the last compliance inspection.',
    `labeling_compliant_flag` BOOLEAN COMMENT 'Indicates whether the hazmat labeling on packages and storage locations is compliant with regulatory requirements.',
    `last_incident_date` DATE COMMENT 'Date of the most recent safety incident or compliance violation at this storage location.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent hazmat storage compliance inspection was conducted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was last updated in the system.',
    `last_training_date` DATE COMMENT 'Date when warehouse personnel last completed hazmat handling and storage training for this material class.',
    `maximum_storage_quantity` DECIMAL(18,2) COMMENT 'Maximum permitted quantity of this hazmat SKU that can be stored in the designated zone, as per regulatory limits.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or inspection of this hazmat storage.',
    `next_training_due_date` DATE COMMENT 'Date when the next mandatory hazmat training is due for personnel handling this material.',
    `non_compliance_reason` STRING COMMENT 'Detailed explanation of the reason for non-compliance if the status is not compliant.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the hazmat storage compliance status, inspection findings, or special handling requirements.',
    `packing_group` STRING COMMENT 'Packing group indicating the degree of danger (I=High, II=Medium, III=Low) as per IMDG/ICAO standards.. Valid values are `I|II|III`',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit or license for hazmat storage.',
    `permit_number` STRING COMMENT 'Regulatory permit or license number authorizing the storage of this hazmat material at the facility.',
    `personal_protective_equipment_required` STRING COMMENT 'Description of the personal protective equipment required when handling this hazmat material.',
    `placarding_required_flag` BOOLEAN COMMENT 'Indicates whether hazmat placarding is required for this storage location per DOT/IMDG regulations.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the storage quantities (kg, lbs, liters, gallons, units).. Valid values are `kg|lbs|liters|gallons|units`',
    `regulatory_authority` STRING COMMENT 'Regulatory authority governing this hazmat storage compliance (IMO, IATA, DOT, ICAO, WCO, local-authority).. Valid values are `IMO|IATA|DOT|ICAO|WCO|local_authority`',
    `safety_data_sheet_reference` STRING COMMENT 'Reference number or location of the Safety Data Sheet for this hazmat material.',
    `segregation_group` STRING COMMENT 'Segregation group code indicating which other hazmat classes this material must be separated from during storage.',
    `segregation_requirement` STRING COMMENT 'Specific segregation requirement level for this hazmat material as per IMDG Code (away from, separated from, separated by deck, separated longitudinally, or none).. Valid values are `away_from|separated_from|separated_by_deck|separated_longitudinally|none`',
    `spill_containment_available_flag` BOOLEAN COMMENT 'Indicates whether spill containment equipment and procedures are available for this storage location.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum permitted storage temperature in Celsius for this hazmat material.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum required storage temperature in Celsius for this hazmat material.',
    `storage_zone_code` STRING COMMENT 'Code identifying the designated hazmat storage zone within the warehouse facility.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the storage zone has temperature control capabilities required for this hazmat material.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for the hazardous material as per international dangerous goods regulations.. Valid values are `^UN[0-9]{4}$`',
    `ventilation_system_type` STRING COMMENT 'Type of ventilation system in the storage zone (natural, mechanical, explosion-proof, none).. Valid values are `natural|mechanical|explosion_proof|none`',
    CONSTRAINT pk_hazmat_storage_compliance PRIMARY KEY(`hazmat_storage_compliance_id`)
) COMMENT 'Hazardous materials storage compliance record tracking the regulatory compliance status of hazmat SKUs stored within warehouse facilities. Captures SKU reference, IMDG/ICAO hazmat class, UN number, packing group, storage zone assigned, segregation requirements, maximum storage quantity, current stored quantity, compliance status (compliant, over-limit, segregation-breach), last inspection date, inspector ID, regulatory authority (IMDG, ICAO, DOT), and next review date. Supports IMO, IATA, and DOT regulatory reporting obligations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Primary key for service_agreement',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement under which this SLA is defined. Nullable for non-contractual SLAs.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Warehouse service agreements have budgeted revenue and cost targets tracked in finance budgets. Required for budget vs actual performance tracking, variance analysis, and financial planning for custom',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this SLA is configured. Nullable for facility-wide or service-type-level SLAs.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center facility where this SLA applies.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Warehouse SLA performance (order accuracy, on-time dispatch) triggers contractual penalties or bonuses that adjust invoice amounts. Service_agreement defines billing terms; invoice link needed to appl',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: SLA penalty clauses in warehouse service agreements require automated posting to specific GL accounts when breaches occur. Links penalty_amount to the correct revenue reduction or liability account. E',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee responsible for managing and monitoring this SLA configuration.',
    `quaternary_service_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this SLA configuration record.',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.document_template. Business justification: Warehouse SLAs reference standard document templates for performance reporting, invoicing formats, compliance documentation, and exception reporting. Contractual requirement for consistent customer co',
    `tertiary_service_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this SLA configuration record.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the SLA configuration indicating whether it has been reviewed and approved by authorized stakeholders.. Valid values are `pending|approved|rejected|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA configuration was approved by the authorized stakeholder.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this SLA automatically renews upon expiration or requires manual renewal.',
    `baseline_performance_value` DECIMAL(18,2) COMMENT 'Historical baseline performance value measured prior to SLA implementation, used for comparison and improvement tracking.',
    `breach_threshold_unit` STRING COMMENT 'Unit of measure for the breach threshold value, such as hours, minutes, days, percentage, units, orders, or lines. [ENUM-REF-CANDIDATE: hours|minutes|days|percentage|units|orders|lines — 7 candidates stripped; promote to reference product]',
    `breach_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value at which the SLA is considered breached, triggering alerts or penalties.',
    `continuous_improvement_target` DECIMAL(18,2) COMMENT 'Aspirational performance target beyond the contractual SLA commitment, used for internal continuous improvement initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA configuration record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this SLA configuration expires or is no longer in effect. Nullable for open-ended SLAs.',
    `effective_start_date` DATE COMMENT 'Date when this SLA configuration becomes active and performance measurement begins.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process to be followed when the SLA is breached, including notification hierarchy and remediation steps.',
    `exclusion_criteria` STRING COMMENT 'Description of conditions or scenarios under which SLA measurement is suspended or excluded, such as force majeure events, system outages, or customer-caused delays.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA configuration record was last updated or modified.',
    `measurement_frequency` STRING COMMENT 'Frequency at which the SLA metric is measured and evaluated, such as real-time, hourly, daily, weekly, monthly, quarterly, or per transaction. [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|per_transaction — 7 candidates stripped; promote to reference product]',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target value, such as hours, minutes, days, percentage, units, orders, or lines. [ENUM-REF-CANDIDATE: hours|minutes|days|percentage|units|orders|lines — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this SLA configuration.',
    `notification_email_list` STRING COMMENT 'Comma-separated list of email addresses to be notified when SLA breach events occur.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount charged per breach occurrence or per measurement period when the SLA is not met. Nullable if no penalty applies.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether a financial or operational penalty applies when this SLA is breached.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `priority_level` STRING COMMENT 'Business priority classification of this SLA indicating the importance and urgency of compliance monitoring.. Valid values are `critical|high|medium|low`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notification should be sent to stakeholders.',
    `reporting_dashboard_url` STRING COMMENT 'URL link to the performance dashboard or reporting interface where SLA compliance metrics are visualized.',
    `service_type` STRING COMMENT 'Category of warehouse operation covered by this SLA, such as receiving turnaround, order dispatch, inventory accuracy, returns processing, putaway completion, or picking accuracy.. Valid values are `receiving_turnaround|order_dispatch|inventory_accuracy|returns_processing|putaway_completion|picking_accuracy`',
    `sla_code` STRING COMMENT 'Business identifier code for the SLA configuration, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `sla_name` STRING COMMENT 'Descriptive name of the service level agreement defining the operational performance commitment.',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA configuration indicating whether it is active, inactive, suspended, in draft, or expired.. Valid values are `active|inactive|suspended|draft|expired`',
    `target_metric_name` STRING COMMENT 'Name of the performance metric being measured for this SLA, such as turnaround time, accuracy percentage, or on-time delivery rate.',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value that defines the performance commitment for the SLA metric.',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'Warehouse service level agreement configuration record defining the operational performance commitments for a specific customer, contract, or service type within a facility. Captures SLA name, customer or contract reference, facility, service type (receiving turnaround, order dispatch, inventory accuracy, returns processing), target metric value, measurement unit, measurement frequency, breach threshold, penalty clause flag, effective start date, and expiry date. Drives SLA breach alerting and contract logistics performance reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`zone` (
    `zone_id` BIGINT COMMENT 'Unique identifier for the warehouse zone. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the parent warehouse facility where this zone is located. Links to the facility master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Zones have supervisors/managers responsible for zone-specific operations, labor productivity, and safety. Critical for zone-level performance metrics, labor cost allocation, shift planning, and operat',
    `active_from_date` DATE COMMENT 'Date when the zone became operational and available for warehouse activities. Supports historical tracking and lifecycle management.',
    `active_to_date` DATE COMMENT 'Date when the zone was decommissioned or taken out of service. Null for currently active zones.',
    `aisle_count` STRING COMMENT 'Number of aisles within the zone. Used for labor planning and travel distance optimization.',
    `automation_type` STRING COMMENT 'Classification of the automation technology deployed in the zone. Determines labor requirements, throughput capacity, and operational workflows.. Valid values are `manual|conveyor|asrs|goods_to_person|robotic|hybrid`',
    `bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated as a customs bonded area where duties and taxes are deferred until goods are released.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created in the system. Supports audit trail and data lineage.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated for cross-docking operations where goods bypass storage and move directly from receiving to dispatch.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for cycle counting inventory within the zone. Supports inventory accuracy and compliance requirements.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `dock_door_assignment` STRING COMMENT 'Comma-separated list of dock door numbers assigned to this zone for inbound receiving or outbound dispatch operations.',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed in the zone. Critical for safety compliance and insurance requirements.. Valid values are `sprinkler|foam|gas|dry_chemical|none`',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the zone measured in square meters. Used for capacity planning and space utilization analysis.',
    `ftz_designation` BOOLEAN COMMENT 'Indicates whether the zone is designated as a Free Trade Zone with special customs and tax treatment.',
    `hazmat_class_permitted` STRING COMMENT 'Comma-separated list of UN hazmat classes permitted in this zone (e.g., 3,4.1,9). Empty if zone is not hazmat-certified.',
    `hazmat_suitable_flag` BOOLEAN COMMENT 'Indicates whether the zone is certified and equipped for storing hazardous materials per IMDG and ICAO regulations.',
    `height_m` DECIMAL(18,2) COMMENT 'Maximum vertical clearance height of the zone in meters. Critical for slotting tall items and equipment operation.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was completed for this zone. Used to track compliance with counting schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was last updated. Supports change tracking and audit compliance.',
    `location_count` STRING COMMENT 'Total number of discrete storage locations within the zone. Key metric for capacity planning and utilization tracking.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the zone on weekdays, typically in HH:MM-HH:MM format. Used for labor scheduling and SLA planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for the zone on weekends, typically in HH:MM-HH:MM format. Used for labor scheduling and SLA planning.',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated as a pick-face area for high-velocity order fulfillment operations.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated for quarantine or quality hold inventory pending inspection or release.',
    `replenishment_source_flag` BOOLEAN COMMENT 'Indicates whether the zone serves as a bulk storage source for replenishing pick-face locations.',
    `returns_processing_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated for processing returned merchandise and reverse logistics operations.',
    `security_level` STRING COMMENT 'Security classification of the zone determining access controls, surveillance requirements, and handling protocols.. Valid values are `standard|high|restricted|bonded`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements, operational notes, or safety instructions specific to this zone.',
    `storage_capacity_cbm` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the zone measured in cubic meters. Used for inventory planning and space optimization.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the zone has active temperature control systems for cold-chain or climate-sensitive inventory.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum operating temperature of the zone in degrees Celsius. Defines the upper bound for temperature-controlled storage.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum operating temperature of the zone in degrees Celsius. Defines the lower bound for temperature-controlled storage.',
    `vas_flag` BOOLEAN COMMENT 'Indicates whether the zone is designated for value-added services such as kitting, labeling, packaging, or customization.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the zone in kilograms. Ensures compliance with structural load limits and safety regulations.',
    `zone_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the zone within the facility. Used for operational reference and WMS integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `zone_name` STRING COMMENT 'Descriptive name of the zone for human-readable identification and reporting purposes.',
    `zone_status` STRING COMMENT 'Current operational status of the zone indicating availability for warehouse operations.. Valid values are `active|inactive|maintenance|restricted|decommissioned`',
    `zone_type` STRING COMMENT 'Functional classification of the zone defining its operational purpose. Determines workflow routing, labor assignment, and compliance requirements. [ENUM-REF-CANDIDATE: receiving|bulk_storage|pick_face|staging|dispatch|cold_chain|hazmat|quarantine|returns|vas|cross_dock — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Warehouse zone master defining the logical and physical zones within a facility used to organize storage, picking, and operational workflows. Captures zone code, zone name, zone type (receiving, bulk storage, pick-face, staging, dispatch, cold-chain, hazmat, quarantine, returns, VAS), facility reference, temperature range (min/max Celsius), floor area (sqm), height (m), automation type (manual, conveyor, AS/RS, goods-to-person), and active status. Provides the spatial hierarchy above storage locations for slotting, labor assignment, and compliance segregation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` (
    `facility_carrier_service_id` BIGINT COMMENT 'Unique identifier for this facility-carrier service agreement. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner in this service agreement',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the warehouse facility in this service agreement',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility-carrier service record was created in the system.',
    `dock_door_assignments` STRING COMMENT 'Comma-separated list of dock door numbers assigned to this carrier at this facility (e.g., D1,D2,D5). Facility-specific operational assignment.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this facility-carrier service record was last updated.',
    `operational_status` STRING COMMENT 'Current operational status of this carrier service at this facility. ACTIVE = currently servicing, SUSPENDED = temporarily paused, INACTIVE = service ended.',
    `pickup_schedule` STRING COMMENT 'Scheduled pickup times for this carrier at this facility (e.g., MON-FRI 14:00, SAT 10:00). Facility-specific schedule that may differ from carriers general availability.',
    `priority_level` STRING COMMENT 'Priority classification of this carrier at this facility. PRIMARY = preferred carrier, SECONDARY = alternate option, BACKUP = contingency carrier. Used for routing decisions.',
    `rate_agreement_reference` STRING COMMENT 'Reference identifier to the facility-specific rate agreement or pricing schedule for this carrier. Links to contract management system.',
    `service_end_date` DATE COMMENT 'Date when carrier service ended or is scheduled to end at this facility. Null for active ongoing service agreements.',
    `service_start_date` DATE COMMENT 'Date when carrier service began at this specific facility location. Tracks the operational start of the facility-carrier relationship.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Committed monthly shipment volume (in units or weight) for this carrier at this facility. Part of facility-level service agreement terms.',
    CONSTRAINT pk_facility_carrier_service PRIMARY KEY(`facility_carrier_service_id`)
) COMMENT 'This association product represents the operational service contract between a warehouse facility and a carrier partner. It captures facility-specific pickup schedules, dock assignments, volume commitments, and rate agreements that exist only in the context of this facility-carrier relationship. Each record links one facility to one carrier with attributes that govern the operational service terms at that specific facility location.. Existence Justification: In Transport Shipping logistics operations, facilities contract with multiple carriers simultaneously for redundancy, service coverage, and mode diversity (LTL, parcel, air freight). Each carrier serves multiple facilities across the network. The facility-carrier relationship is an operational service agreement that carries facility-specific terms including pickup schedules, dock assignments, volume commitments, and rate agreements that differ by facility location.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Unique identifier for this supply agreement record. Primary key.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU being sourced under this supply agreement',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier providing the SKU under this supply agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement: Active (in use), Inactive (discontinued), Suspended (temporarily halted), Under Review (being evaluated).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this supply agreement became or becomes effective for procurement operations.',
    `expiration_date` DATE COMMENT 'The date on which this supply agreement expires or is scheduled for renewal, if applicable.',
    `last_purchase_date` DATE COMMENT 'The date of the most recent purchase order placed for this SKU from this supplier, used for supplier performance tracking.',
    `lead_time_days` STRING COMMENT 'The number of days from purchase order placement to expected delivery for this SKU from this supplier.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity required by the supplier for this SKU, expressed in the SKUs unit of measure.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Boolean indicator of whether this supplier is the preferred or primary source for this SKU in the multi-sourcing strategy.',
    `quality_rating` DECIMAL(18,2) COMMENT 'The quality performance rating for this supplier-SKU combination, typically on a scale of 0.00 to 5.00, based on defect rates and compliance.',
    `supplier_part_number` STRING COMMENT 'The unique part number or SKU code used by the supplier to identify this item in their catalog. May differ from internal SKU code.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The negotiated unit cost or price per unit of measure for this SKU from this supplier, in the suppliers preferred currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was last modified.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association product represents the commercial sourcing relationship between a SKU and a supplier. It captures the supplier-specific terms, pricing, lead times, and performance metrics for each SKU-supplier combination. Each record links one SKU to one supplier with attributes that exist only in the context of this sourcing relationship, enabling multi-sourcing strategies and supplier performance management.. Existence Justification: In logistics operations, SKUs are routinely sourced from multiple suppliers as part of a multi-sourcing risk mitigation strategy, and each supplier provides hundreds or thousands of different SKUs. Each SKU-supplier combination has unique commercial terms including supplier-specific part numbers, negotiated unit costs, lead times, minimum order quantities, and quality performance ratings. This is an operational relationship actively managed by procurement teams.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` (
    `facility_partner_agreement_id` BIGINT COMMENT 'Unique identifier for this facility-partner agreement record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the warehouse facility in this partnership agreement',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the network partner in this partnership agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this facility-partner service agreement, tracking whether the partnership is operationally active.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this facility-partner agreement record was created in the data platform.',
    `effective_date` DATE COMMENT 'Date when this facility-partner service agreement becomes active and the partner is authorized to provide services to the facility.',
    `expiry_date` DATE COMMENT 'Date when this facility-partner service agreement expires or is scheduled for renewal. Null indicates an evergreen or indefinite agreement.',
    `partnership_type` STRING COMMENT 'Classification of the service relationship type between the facility and network partner. Defines the primary service category provided by the partner to this facility.',
    `performance_tier` STRING COMMENT 'Service level tier assigned to this facility-partner relationship, reflecting priority handling, response time commitments, and service quality expectations specific to this partnership.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person at the network partner for operational coordination with this facility.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the network partner organization for this specific facility relationship.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the network partner for urgent operational matters related to this facility.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the network partner for services provided to this facility, representing the commercial terms specific to this facility-partner agreement.',
    `service_scope` STRING COMMENT 'Detailed description of the specific services the network partner provides to this facility, including operational boundaries, service level expectations, and any facility-specific arrangements.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this facility-partner agreement record was last modified.',
    CONSTRAINT pk_facility_partner_agreement PRIMARY KEY(`facility_partner_agreement_id`)
) COMMENT 'This association product represents the contractual service agreement between a Transport Shipping facility and a network partner. It captures the specific partnership terms, service scope, performance expectations, and commercial arrangements that exist only in the context of this facility-partner relationship. Each record links one facility to one network partner with attributes defining the partnership parameters.. Existence Justification: In Transport Shipping logistics operations, facilities routinely engage multiple specialized network partners simultaneously (customs brokers for clearance, freight forwarders for consolidation, drayage operators for container movement, ground handlers for cargo processing). Each network partner serves multiple facilities across the network. The business actively manages these partnerships as distinct service agreements with facility-specific terms, performance tiers, service scopes, and commercial arrangements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` (
    `facility_agreement_id` BIGINT COMMENT 'Unique identifier for this facility-agreement association record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the commercial agreement governing services at this facility',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the warehouse facility providing services under this agreement',
    `allocated_capacity_percentage` DECIMAL(18,2) COMMENT 'Percentage of the facilitys total storage capacity allocated to this agreement. Used in multi-tenant warehousing to manage capacity commitments across multiple customers. Sum of all allocations at a facility should not exceed 100%.',
    `billing_rate_override` DECIMAL(18,2) COMMENT 'Facility-specific billing rate that overrides the master agreement rate for this facility. Used when different facilities have different cost structures or service levels. Nullable if master agreement rate applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility-agreement association record was created in the system.',
    `facility_agreement_status` STRING COMMENT 'Current operational status of services at this facility under this agreement. Allows facility-level service suspension or termination independent of the master agreement status.',
    `service_end_date` DATE COMMENT 'Date when services under this agreement terminated at this specific facility. Nullable for ongoing service. May differ from master agreement expiry_date when facilities are removed from a multi-facility contract.',
    `service_start_date` DATE COMMENT 'Date when services under this agreement commenced at this specific facility. May differ from the master agreement effective_date when facilities are added to an existing contract.',
    `sla_tier` STRING COMMENT 'Service level tier applicable to this facility-agreement pairing. Defines operational priorities, response times, and service quality commitments. May vary by facility even within the same master agreement based on facility capabilities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility-agreement association record was last modified.',
    CONSTRAINT pk_facility_agreement PRIMARY KEY(`facility_agreement_id`)
) COMMENT 'This association product represents the Contract between facility and agreement. It captures the facility-specific service terms, capacity allocation, billing arrangements, and SLA commitments that exist when a warehouse facility operates under a commercial agreement. In 3PL operations, this enables multi-tenant warehousing where a single facility serves multiple customer contracts simultaneously, and network contracts where a single master agreement spans multiple facilities. Each record links one facility to one agreement with attributes that define the operational and commercial parameters unique to that facility-agreement pairing.. Existence Justification: In 3PL logistics operations, facilities routinely operate under multiple customer agreements simultaneously (multi-tenant warehousing), and master agreements frequently span multiple facilities (network contracts). The business actively manages facility-agreement pairings as operational entities, tracking facility-specific capacity allocations, billing rate overrides, service periods, and SLA tiers that vary by customer within the same facility and by facility within the same agreement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`material` (
    `material_id` BIGINT COMMENT 'Primary key for material',
    `parent_material_id` BIGINT COMMENT 'Self-referencing FK on material (parent_material_id)',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master reference table for material. Referenced by material_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` (
    `counter_team_id` BIGINT COMMENT 'Primary key for counter_team',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse supervisor or manager who oversees this counter team and approves count results.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: counter_team.warehouse_id (BIGINT) semantically refers to the facility (primary entity in warehouse domain). Adding proper facility_id FK normalizes this relationship. warehouse_id is removed as it be',
    `team_lead_employee_id` BIGINT COMMENT 'Identifier of the employee designated as the team lead responsible for supervising the counter teams operations.',
    `parent_counter_team_id` BIGINT COMMENT 'Self-referencing FK on counter_team (parent_counter_team_id)',
    `accuracy_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable inventory count accuracy percentage for the team. Counts below this threshold trigger recount procedures.',
    `certification_expiry_date` DATE COMMENT 'Date when the teams current counting certification expires and recertification is required.',
    `counter_team_code` STRING COMMENT 'Unique alphanumeric business code used to reference the counter team in WMS transactions and reporting.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which this counter teams labor and operational costs are charged.',
    `count_frequency` STRING COMMENT 'Standard frequency at which this counter team is scheduled to perform inventory counts.',
    `count_method` STRING COMMENT 'Primary counting methodology employed by the team, determining the process and technology used during inventory counts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this counter team record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this counter team became operational and available for inventory counting assignments.',
    `effective_to_date` DATE COMMENT 'Date on which this counter team was or will be disbanded or deactivated. Null indicates currently active with no planned end date.',
    `equipment_type` STRING COMMENT 'Primary type of counting equipment or technology assigned to this counter team for inventory verification.',
    `headcount` STRING COMMENT 'Current number of members assigned to the counter team, used for labor planning and workload distribution.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether the counter team has completed required training and certification for conducting official inventory counts.',
    `is_hazmat_qualified` BOOLEAN COMMENT 'Indicates whether the counter team is qualified to count hazardous materials inventory requiring special handling and safety protocols.',
    `is_high_value_authorized` BOOLEAN COMMENT 'Indicates whether the counter team is authorized to count high-value inventory items that require additional security oversight.',
    `last_count_date` DATE COMMENT 'Date of the most recent inventory count completed by this team, used for scheduling and compliance tracking.',
    `max_capacity` STRING COMMENT 'Maximum number of members that can be assigned to this counter team based on operational constraints and supervision ratios.',
    `counter_team_name` STRING COMMENT 'Human-readable name assigned to the counter team for identification in warehouse operations (e.g., Night Cycle Count Team A, Annual Inventory Team 3).',
    `next_scheduled_count_date` DATE COMMENT 'Date of the next planned inventory count assignment for this team.',
    `notes` STRING COMMENT 'Free-text operational notes about the counter team including special instructions, constraints, or historical context.',
    `operating_schedule` STRING COMMENT 'Description of the teams regular operating schedule including days of week and hours (e.g., Mon-Fri 06:00-14:00).',
    `priority_level` STRING COMMENT 'Priority classification of the counter team determining scheduling precedence and resource allocation during peak periods.',
    `shift_code` STRING COMMENT 'Code representing the work shift during which this counter team is scheduled to perform counting activities (e.g., DAY, NIGHT, SWING).',
    `counter_team_status` STRING COMMENT 'Current lifecycle status of the counter team indicating whether it is operational and available for assignment.',
    `target_locations_per_shift` STRING COMMENT 'Expected number of storage locations the counter team should count per shift, used as a productivity benchmark.',
    `counter_team_type` STRING COMMENT 'Classification of the counter team based on the type of inventory counting activity they perform.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this counter team record was last modified.',
    `variance_tolerance_percent` DECIMAL(18,2) COMMENT 'Maximum allowable percentage variance between system inventory and physical count before an exception is raised.',
    `wms_reference_code` STRING COMMENT 'External reference identifier for this counter team as stored in the Manhattan WMS system for integration and reconciliation purposes.',
    `zone_assignment` STRING COMMENT 'Warehouse zone or area designation where this counter team is primarily assigned to conduct counting activities (e.g., bulk storage, pick modules, mezzanine).',
    CONSTRAINT pk_counter_team PRIMARY KEY(`counter_team_id`)
) COMMENT 'Master reference table for counter_team. Referenced by counter_team_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`pallet` (
    `pallet_id` BIGINT COMMENT 'Primary key for pallet',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: pallet.warehouse_id (BIGINT) semantically refers to the facility where the pallet is located. Adding proper facility_id FK normalizes this. warehouse_id removed as redundant.',
    `material_id` BIGINT COMMENT 'Foreign key linking to warehouse.material. Business justification: pallet has material (STRING) describing pallet material type (wood, plastic, etc.). Adding material_id FK normalizes this to the material master reference table. This also connects the otherwise-siloe',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: pallet has current_location_code (STRING) indicating its current storage position. Adding storage_location_id FK properly normalizes this to the storage_location master. current_location_code removed ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to warehouse.zone. Business justification: pallet has current_zone (STRING) indicating its zone. Adding zone_id FK normalizes this to the zone master. current_zone removed as retrievable via JOIN to zone.zone_code/zone_name.',
    `parent_pallet_id` BIGINT COMMENT 'Self-referencing FK on pallet (parent_pallet_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or lease cost of the pallet in the base operating currency, used for asset depreciation and cost allocation.',
    `barcode` STRING COMMENT 'Externally visible barcode or license plate number (LPN) printed on the pallet label, used for scanning during warehouse operations.',
    `color` STRING COMMENT 'Physical color of the pallet, often used to visually identify pool provider ownership or product segregation requirements.',
    `commissioned_date` DATE COMMENT 'Date the pallet was first put into active service within the warehouse operation.',
    `condition_grade` STRING COMMENT 'Quality grade indicating the physical condition of the pallet (A=new/excellent, B=good, C=fair, D=poor, F=failed/condemned).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pallet master record was first created in the warehouse management system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost and any financial values associated with this pallet.',
    `decommissioned_date` DATE COMMENT 'Date the pallet was permanently removed from active service due to damage, age, or end-of-life.',
    `entry_method` STRING COMMENT 'The material handling method used to move or place the pallet (forklift, conveyor, automated guided vehicle, manual, crane).',
    `height_mm` DECIMAL(18,2) COMMENT 'Height of the pallet deck structure (without load) in millimeters, relevant for stacking calculations and rack compatibility.',
    `is_food_grade` BOOLEAN COMMENT 'Indicates whether the pallet meets food-grade hygiene and safety standards for use in food and pharmaceutical supply chains.',
    `is_heat_treated` BOOLEAN COMMENT 'Indicates whether the wooden pallet has been heat-treated per ISPM-15 phytosanitary requirements for international shipment.',
    `is_rackable` BOOLEAN COMMENT 'Indicates whether the pallet is structurally suitable for placement on warehouse pallet racking systems.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether the pallet is designed for return and reuse in a closed-loop supply chain, as opposed to single-use disposal.',
    `is_rfid_enabled` BOOLEAN COMMENT 'Indicates whether the pallet is equipped with an RFID tag for automated tracking within the warehouse.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this pallet type is approved for vertical stacking in warehouse racking or during transport.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or quality check performed on the pallet.',
    `last_repair_date` DATE COMMENT 'Date of the most recent repair or refurbishment performed on the pallet.',
    `length_mm` DECIMAL(18,2) COMMENT 'External length dimension of the pallet in millimeters, used for slotting optimization and load planning.',
    `manufacture_date` DATE COMMENT 'Date the pallet was manufactured, used to track age, expected lifespan, and replacement scheduling.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the pallet, relevant for warranty claims and quality tracking.',
    `max_load_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum safe static load capacity of the pallet in kilograms as rated by the manufacturer or standard.',
    `max_stack_layers` STRING COMMENT 'Maximum number of pallet layers that can be safely stacked vertically in storage or transport.',
    `max_stack_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight that can be stacked on top of a loaded pallet in racking or floor-stacking scenarios.',
    `max_trip_limit` STRING COMMENT 'Maximum number of trips or usage cycles allowed before the pallet must be retired or refurbished.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection of the pallet based on usage cycles or time intervals.',
    `notes` STRING COMMENT 'Free-text operational notes or comments about the pallet, such as special handling instructions or damage observations.',
    `ownership_type` STRING COMMENT 'Indicates whether the pallet is company-owned, leased from a pooling provider (e.g., CHEP, PECO), pooled, customer-owned, or single-use one-way.',
    `pool_provider` STRING COMMENT 'Name of the pallet pooling service provider (e.g., CHEP, PECO, LPR, IPP) if the pallet is leased or pooled.',
    `repair_count` STRING COMMENT 'Total number of repairs performed on the pallet over its lifetime, used to assess remaining useful life.',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag affixed to the pallet, used for automated scanning and real-time location tracking.',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code, an 18-digit globally unique identifier assigned to the pallet for supply chain tracking and EDI messaging.',
    `pallet_status` STRING COMMENT 'Current operational status of the pallet within the warehouse management lifecycle.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the pallet in kilograms, used to calculate net cargo weight during receiving and shipping.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum operating temperature in Celsius that the pallet material can safely withstand, relevant for heated storage environments.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum operating temperature in Celsius that the pallet material can safely withstand, relevant for cold chain logistics.',
    `trip_count` STRING COMMENT 'Total number of shipping trips or usage cycles the pallet has completed since manufacture or last refurbishment.',
    `pallet_type` STRING COMMENT 'Classification of the pallet by physical form factor and standard (e.g., euro, standard 48x40, half pallet, quarter pallet, custom, oversized).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the pallet master record was last modified in the warehouse management system.',
    `width_mm` DECIMAL(18,2) COMMENT 'External width dimension of the pallet in millimeters, used for slotting optimization and load planning.',
    CONSTRAINT pk_pallet PRIMARY KEY(`pallet_id`)
) COMMENT 'Master reference table for pallet. Referenced by pallet_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Primary key for equipment',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operator or worker currently assigned to operate this equipment.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: equipment.warehouse_id (BIGINT) semantically refers to the facility where equipment is deployed. Adding proper facility_id FK normalizes this. warehouse_id removed as redundant.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the equipment was procured.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to warehouse.zone. Business justification: equipment has zone_code (STRING) indicating which zone the equipment operates in. Adding zone_id FK normalizes this to zone master. zone_code removed as retrievable via JOIN.',
    `parent_equipment_id` BIGINT COMMENT 'Self-referencing FK on equipment (parent_equipment_id)',
    `acquisition_date` DATE COMMENT 'Date on which the equipment was acquired or purchased by the organization.',
    `asset_tag` STRING COMMENT 'Externally visible unique asset tag affixed to the equipment for physical identification and inventory tracking.',
    `barcode` STRING COMMENT 'Barcode value used for scanning and quick identification of the equipment in warehouse management systems.',
    `equipment_category` STRING COMMENT 'Broad operational category grouping equipment by its primary warehouse function.',
    `commissioning_date` DATE COMMENT 'Date on which the equipment was first placed into active service after installation and testing.',
    `condition_rating` STRING COMMENT 'Assessed physical condition of the equipment based on the most recent inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment record was first created in the system.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current depreciated book value of the equipment for financial reporting purposes.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation of the equipment over its useful life.',
    `dimensions_lxwxh_cm` STRING COMMENT 'Physical dimensions of the equipment expressed as length x width x height in centimeters.',
    `expected_retirement_date` DATE COMMENT 'Planned date for decommissioning and retiring the equipment from active service based on lifecycle planning.',
    `inspection_certification_number` STRING COMMENT 'Certificate or reference number issued upon passing the most recent regulatory safety inspection.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering the equipment against damage or loss.',
    `is_iot_enabled` BOOLEAN COMMENT 'Indicates whether the equipment is fitted with IoT sensors for real-time telemetry and monitoring.',
    `is_safety_certified` BOOLEAN COMMENT 'Indicates whether the equipment currently holds a valid safety certification.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection performed on the equipment.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the equipment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this equipment record.',
    `lease_contract_number` STRING COMMENT 'Reference number of the lease or rental contract if the equipment is not owned outright.',
    `load_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum rated load capacity of the equipment measured in kilograms.',
    `maintenance_interval_days` STRING COMMENT 'Standard number of days between scheduled preventive maintenance services.',
    `manufacture_year` STRING COMMENT 'Calendar year in which the equipment was manufactured.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced the unit.',
    `max_lift_height_m` DECIMAL(18,2) COMMENT 'Maximum vertical lift height of the equipment in meters, applicable to forklifts and reach trucks.',
    `model_number` STRING COMMENT 'Manufacturer model number identifying the specific product line and variant.',
    `equipment_name` STRING COMMENT 'Human-readable name or designation of the equipment (e.g., Forklift A-12, Conveyor Belt C3).',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance service for the equipment.',
    `notes` STRING COMMENT 'Free-text notes or remarks about the equipment including special handling instructions or known issues.',
    `operating_speed_mps` DECIMAL(18,2) COMMENT 'Rated maximum operating speed of the equipment in meters per second.',
    `ownership_type` STRING COMMENT 'Indicates whether the equipment is owned, leased, rented, or on loan from a third party.',
    `power_source` STRING COMMENT 'Type of energy or power source that drives the equipment.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the equipment in the base currency.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying the equipment unit.',
    `equipment_status` STRING COMMENT 'Current operational lifecycle status of the equipment within the warehouse.',
    `telematics_device_code` STRING COMMENT 'Identifier of the telematics or IoT device installed on the equipment for remote monitoring.',
    `total_operating_hours` DECIMAL(18,2) COMMENT 'Cumulative number of hours the equipment has been in active operation since commissioning.',
    `equipment_type` STRING COMMENT 'Classification of the equipment by its functional category within warehouse operations. [ENUM-REF-CANDIDATE: forklift|conveyor|pallet_jack|reach_truck|sorter|agv|crane|dock_leveler|stretch_wrapper|label_applicator — promote to reference product]',
    `useful_life_months` STRING COMMENT 'Estimated useful economic life of the equipment expressed in months for depreciation and replacement planning.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage expires.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Unladen weight of the equipment in kilograms.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master reference table for equipment. Referenced by equipment_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`carton` (
    `carton_id` BIGINT COMMENT 'Primary key for carton',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: carton.warehouse_id (BIGINT) semantically refers to the facility where carton stock is held. Adding proper facility_id FK normalizes this. warehouse_id removed as redundant.',
    `supplier_id` BIGINT COMMENT 'Identifier of the packaging supplier who manufactures or provides this carton type.',
    `parent_carton_id` BIGINT COMMENT 'Self-referencing FK on carton (parent_carton_id)',
    `barcode` STRING COMMENT 'Unique barcode identifier printed on or associated with the carton type, used for scanning during picking, packing, and dispatch operations.',
    `color_code` STRING COMMENT 'Color designation of the carton exterior used for visual sorting, zone identification, or brand-specific packaging in e-commerce fulfillment.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost amount (e.g., USD, EUR, GBP).',
    `carton_description` STRING COMMENT 'Free-text description providing additional details about the cartons intended use, special handling instructions, or compatibility notes.',
    `dimensional_weight_factor` DECIMAL(18,2) COMMENT 'Carrier-specific divisor used to calculate dimensional (volumetric) weight for freight rating purposes (e.g., 5000 for air, 6000 for ground).',
    `edge_crush_test_value` DECIMAL(18,2) COMMENT 'Edge Crush Test rating in kN/m indicating the cartons resistance to crushing forces, critical for stacking strength assessment.',
    `effective_from_date` DATE COMMENT 'Date from which this carton type became available for use in warehouse operations.',
    `effective_to_date` DATE COMMENT 'Date after which this carton type is no longer available for use. Null indicates currently active with no planned discontinuation.',
    `flute_type` STRING COMMENT 'Flute profile designation for corrugated cartons indicating thickness and cushioning properties (e.g., A-flute for heavy items, E-flute for retail packaging).',
    `height_cm` DECIMAL(18,2) COMMENT 'Internal height dimension of the carton measured in centimeters, used for volumetric calculations and stacking rules.',
    `is_fragile_rated` BOOLEAN COMMENT 'Indicates whether the carton includes additional cushioning or reinforcement suitable for fragile goods handling.',
    `is_hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carton is certified for transporting hazardous materials per UN packaging group requirements.',
    `is_recyclable` BOOLEAN COMMENT 'Indicates whether the carton material is recyclable at end of life, supporting sustainability reporting and environmental compliance.',
    `is_reusable` BOOLEAN COMMENT 'Indicates whether the carton is designed for multiple use cycles in a returnable packaging program.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the carton is designed for temperature-sensitive goods requiring cold chain or insulated packaging.',
    `lead_time_days` STRING COMMENT 'Number of calendar days from order placement to delivery for replenishing stock of this carton type from the supplier.',
    `length_cm` DECIMAL(18,2) COMMENT 'Internal length dimension of the carton measured in centimeters, used for volumetric calculations and slotting optimization.',
    `material_grade` STRING COMMENT 'Grade or composition of the carton material indicating structural strength and protection level for contents.',
    `max_reuse_cycles` STRING COMMENT 'Maximum number of times a reusable carton can be cycled before mandatory retirement, based on manufacturer specifications.',
    `max_stackable_layers` STRING COMMENT 'Maximum number of layers this carton type can be stacked when loaded, used for pallet building and storage optimization.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum allowable weight of contents in kilograms that the carton can safely hold without structural failure.',
    `minimum_stock_quantity` STRING COMMENT 'Reorder point threshold — when on-hand quantity of this carton type falls below this level, a replenishment order is triggered.',
    `carton_name` STRING COMMENT 'Human-readable name or label assigned to the carton type for easy identification in warehouse operations (e.g., Small Flat Box, Large Heavy-Duty Crate).',
    `carton_status` STRING COMMENT 'Current lifecycle status of the carton master record indicating whether it is available for use in warehouse operations.',
    `storage_location_code` STRING COMMENT 'Bin or slot location code within the warehouse where empty cartons of this type are stored for picking and packing operations.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the carton in kilograms, used to calculate gross shipment weight when combined with contents.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius that the carton can maintain for temperature-controlled shipments. Applicable only for insulated carton types.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius that the carton can maintain for temperature-controlled shipments. Applicable only for insulated carton types.',
    `carton_type` STRING COMMENT 'Classification of the carton based on its construction material and intended use within the warehouse.',
    `un_packaging_group` STRING COMMENT 'UN Packaging Group classification (I=Great Danger, II=Medium Danger, III=Minor Danger) for hazmat-certified cartons.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Procurement cost per individual carton unit in the base operating currency, used for packaging cost allocation to shipments.',
    `volume_cm3` DECIMAL(18,2) COMMENT 'Total internal cubic volume of the carton in cubic centimeters, representing usable packing space for order fulfillment.',
    `width_cm` DECIMAL(18,2) COMMENT 'Internal width dimension of the carton measured in centimeters, used for volumetric calculations and cartonization algorithms.',
    CONSTRAINT pk_carton PRIMARY KEY(`carton_id`)
) COMMENT 'Master reference table for carton. Referenced by carton_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` (
    `packing_station_id` BIGINT COMMENT 'Primary key for packing_station',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: packing_station.warehouse_id (BIGINT) semantically refers to the facility where the packing station is installed. Adding proper facility_id FK normalizes this. warehouse_id removed as redundant.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to warehouse.zone. Business justification: packing_station has zone_code (STRING) indicating which zone the station is in. Adding zone_id FK normalizes this to zone master. zone_code removed as retrievable via JOIN.',
    `parent_packing_station_id` BIGINT COMMENT 'Self-referencing FK on packing_station (parent_packing_station_id)',
    `aisle_location` STRING COMMENT 'Physical aisle or bay location reference within the warehouse floor plan for the packing station.',
    `asset_tag_number` STRING COMMENT 'Internal fixed asset tag number assigned for capital asset tracking and depreciation purposes.',
    `assigned_shift_pattern` STRING COMMENT 'The shift pattern during which this packing station is typically operational and staffed.',
    `commissioning_date` DATE COMMENT 'Date when the packing station was formally commissioned and approved for production use after installation and testing.',
    `conveyor_connected` BOOLEAN COMMENT 'Indicates whether the packing station is connected to the outbound conveyor system for automated parcel dispatch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packing station record was first created in the master data system.',
    `decommission_date` DATE COMMENT 'Date when the packing station was decommissioned and removed from active service, if applicable.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp from which this packing station record configuration becomes effective in the system.',
    `effective_until` TIMESTAMP COMMENT 'Timestamp until which this packing station record configuration remains effective; null for currently active records.',
    `equipment_manufacturer` STRING COMMENT 'Name of the manufacturer or vendor who supplied the packing station equipment.',
    `equipment_model` STRING COMMENT 'Model number or designation of the packing station equipment as specified by the manufacturer.',
    `ergonomic_height_adjustable` BOOLEAN COMMENT 'Indicates whether the packing station has height-adjustable work surfaces to support ergonomic working conditions.',
    `floor_level` STRING COMMENT 'Floor or mezzanine level where the packing station is located within a multi-level distribution center.',
    `has_barcode_scanner` BOOLEAN COMMENT 'Indicates whether the packing station is equipped with a barcode scanner for item verification and tracking.',
    `has_dimensioner` BOOLEAN COMMENT 'Indicates whether the packing station is equipped with automated dimensioning equipment to capture parcel dimensions.',
    `has_label_printer` BOOLEAN COMMENT 'Indicates whether the packing station has an integrated label printer for shipping labels and documentation.',
    `has_scale` BOOLEAN COMMENT 'Indicates whether the packing station is equipped with an integrated weighing scale for parcel weight capture.',
    `installation_date` DATE COMMENT 'Date when the packing station was physically installed and made available in the warehouse.',
    `ip_address` STRING COMMENT 'IP address of the packing station terminal on the warehouse network for WMS connectivity.',
    `is_cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the packing station supports cold chain packing with temperature-controlled materials and insulated packaging.',
    `is_ecommerce_dedicated` BOOLEAN COMMENT 'Indicates whether the packing station is dedicated exclusively to e-commerce fulfillment orders.',
    `is_hazmat_certified` BOOLEAN COMMENT 'Indicates whether the packing station is certified to handle hazardous materials (HAZMAT) shipments per IATA/DOT regulations.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the packing station equipment.',
    `max_operators` STRING COMMENT 'Maximum number of operators that can work simultaneously at this packing station.',
    `max_parcel_height_cm` DECIMAL(18,2) COMMENT 'Maximum height dimension in centimeters of a parcel that can be processed at this station.',
    `max_parcel_length_cm` DECIMAL(18,2) COMMENT 'Maximum length dimension in centimeters of a parcel that can be processed at this station.',
    `max_parcel_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms of a single parcel that the packing station can handle safely.',
    `max_parcel_width_cm` DECIMAL(18,2) COMMENT 'Maximum width dimension in centimeters of a parcel that can be processed at this station.',
    `max_throughput_per_hour` STRING COMMENT 'Maximum rated capacity of parcels or packages the station can process per hour under optimal conditions.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned preventive maintenance of the packing station.',
    `notes` STRING COMMENT 'Free-text operational notes or special instructions associated with the packing station for warehouse staff.',
    `packing_material_type` STRING COMMENT 'Primary type of packing material used at this station for cushioning and protection of goods.',
    `power_supply_voltage` STRING COMMENT 'Electrical voltage specification required by the packing station equipment.',
    `priority_level` STRING COMMENT 'Priority classification of the packing station determining which order priority levels are routed to it.',
    `station_code` STRING COMMENT 'Externally-known unique alphanumeric code used to identify the packing station across warehouse operations and Manhattan WMS.',
    `station_name` STRING COMMENT 'Human-readable descriptive name of the packing station used for operational displays and reporting.',
    `station_type` STRING COMMENT 'Classification of the packing station by operational mode and capability, determining the types of orders it can process.',
    `packing_station_status` STRING COMMENT 'Current operational lifecycle status of the packing station indicating its availability for order fulfillment.',
    `supported_carrier_services` STRING COMMENT 'Comma-separated list of carrier service codes that this packing station is configured to process (e.g., express, standard, freight).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this packing station record was last modified in the master data system.',
    `wms_device_code` STRING COMMENT 'Unique device identifier registered in Manhattan WMS for this packing station terminal.',
    `workstation_surface_area_sqm` DECIMAL(18,2) COMMENT 'Total usable work surface area in square meters available at the packing station for packing operations.',
    CONSTRAINT pk_packing_station PRIMARY KEY(`packing_station_id`)
) COMMENT 'Master reference table for packing_station. Referenced by packing_station_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` (
    `handling_unit_id` BIGINT COMMENT 'Primary key for handling_unit',
    `customer_account_id` BIGINT COMMENT 'Identifier of the party (client or business unit) that owns the inventory within this handling unit, critical for multi-client contract logistics and 3PL operations.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: handling_unit.warehouse_id (BIGINT) semantically refers to the facility where the handling unit is located. Adding proper facility_id FK normalizes this. warehouse_id removed as redundant.',
    `parent_handling_unit_id` BIGINT COMMENT 'Identifier of the parent handling unit when this unit is nested within a larger unit (e.g., cartons on a pallet), enabling hierarchical tracking of nested packaging structures.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: handling_unit has storage_location_code (STRING) indicating its current position. Adding storage_location_id FK normalizes this to storage_location master. storage_location_code removed as retrievable',
    `asn_number` STRING COMMENT 'Reference number of the Advance Shipment Notification associated with this handling units inbound receipt, linking to supplier shipment documentation.',
    `barcode` STRING COMMENT 'The scannable barcode label affixed to the handling unit for warehouse management system identification and tracking during receiving, putaway, picking, and shipping operations.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country of origin of the goods within this handling unit, required for customs declarations and trade compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this handling unit record was first created in the warehouse management system, establishing the units operational lifecycle start.',
    `customs_status` STRING COMMENT 'Current customs clearance status of the handling unit contents, determining whether goods can be released for domestic distribution or must remain in bonded storage.',
    `disposition_code` STRING COMMENT 'Inventory disposition classification indicating the intended action or salability status of the handling unit contents, driving returns management and write-off workflows.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the contents within this handling unit, critical for FEFO (First Expired First Out) inventory rotation and shelf-life management.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the handling unit including contents and packaging material, measured in kilograms. Used for load planning, transport capacity calculations, and SOLAS VGM compliance.',
    `handling_instructions` STRING COMMENT 'Special handling instructions for this unit such as fragile, this-side-up, keep dry, or forklift-only requirements, communicated to warehouse operatives during movement tasks.',
    `hazmat_class` STRING COMMENT 'UN hazardous material classification code (e.g., Class 1-9) for the contents of this handling unit, determining storage segregation rules and transport documentation requirements. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `height_cm` DECIMAL(18,2) COMMENT 'External height dimension of the handling unit in centimeters, used for stacking calculations, rack storage assignment, and vehicle loading constraints.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the handling unit contains hazardous materials requiring special handling, storage segregation, and regulatory documentation per IMDG/ADR/IATA DGR.',
    `is_mixed_sku` BOOLEAN COMMENT 'Indicates whether this handling unit contains multiple different SKUs (mixed) versus a single SKU (homogeneous), affecting picking strategy and inventory allocation logic.',
    `is_returnable` BOOLEAN COMMENT 'Indicates whether this handling unit (e.g., pallet, tote) is a returnable/reusable asset that must be tracked for reverse logistics and asset pool management.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether this handling unit can be safely stacked upon by other units during storage or transport, affecting warehouse slotting and load planning decisions.',
    `item_count` STRING COMMENT 'Total number of individual items or SKUs contained within this handling unit, used for inventory reconciliation and pick verification.',
    `last_cycle_count_date` DATE COMMENT 'Date when this handling unit was last included in a cycle count or physical inventory audit, supporting inventory accuracy KPIs and audit scheduling.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical movement of this handling unit within the warehouse (putaway, replenishment, pick, or relocation), used for dwell time analysis.',
    `length_cm` DECIMAL(18,2) COMMENT 'External length dimension of the handling unit in centimeters, used for slotting optimization, truck/container load planning, and storage capacity calculations.',
    `load_unit_number` STRING COMMENT 'Reference number of the outbound load or shipment this handling unit is assigned to for dispatch, linking warehouse operations to transportation execution.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the goods contained in this handling unit, enabling FIFO/FEFO inventory management and product recall traceability.',
    `max_stack_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms that can be placed on top of this handling unit when stacked, ensuring safe storage and preventing product damage.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for temperature-sensitive contents, used for cold chain compliance monitoring and alert thresholds.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for temperature-sensitive contents, used for cold chain compliance monitoring.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this handling unit record, supporting audit trail and data freshness monitoring.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the contents only (excluding packaging) in kilograms. Critical for customs declarations, freight billing, and inventory weight tracking.',
    `packaging_material` STRING COMMENT 'The primary material composition of the handling unit, relevant for weight calculations, sustainability reporting, customs declarations, and ISPM-15 phytosanitary compliance for wood packaging.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the inbound receipt of this handling unit, enabling three-way matching between PO, ASN, and physical receipt.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether this handling unit is currently under quality hold, preventing it from being allocated to outbound orders until inspection or disposition is completed.',
    `receipt_date` DATE COMMENT 'Date when this handling unit was received into the warehouse through inbound receiving, establishing the FIFO aging baseline for inventory rotation.',
    `seal_number` STRING COMMENT 'Security seal number applied to the handling unit for tamper-evidence during transit, required for customs bonded movements and high-value shipments.',
    `sscc` STRING COMMENT 'The 18-digit GS1 Serial Shipping Container Code that uniquely identifies this handling unit across the global supply chain for tracking and traceability.',
    `handling_unit_status` STRING COMMENT 'Current lifecycle status of the handling unit indicating its availability and condition within warehouse operations.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the empty handling unit (packaging only, without contents) in kilograms. Used to calculate net weight of goods and for verified gross mass calculations.',
    `temperature_requirement` STRING COMMENT 'Required temperature storage condition for the handling unit contents, determining cold chain assignment and warehouse zone placement.',
    `unit_type` STRING COMMENT 'Classification of the physical packaging type of the handling unit, determining storage requirements, handling equipment needs, and slotting optimization rules.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the handling unit in cubic meters, used for freight rate calculations, container utilization planning, and warehouse space allocation.',
    `width_cm` DECIMAL(18,2) COMMENT 'External width dimension of the handling unit in centimeters, used for slotting optimization and load planning.',
    CONSTRAINT pk_handling_unit PRIMARY KEY(`handling_unit_id`)
) COMMENT 'Master reference table for handling_unit. Referenced by handling_unit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ADD CONSTRAINT `fk_warehouse_storage_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ADD CONSTRAINT `fk_warehouse_storage_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ADD CONSTRAINT `fk_warehouse_inventory_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ADD CONSTRAINT `fk_warehouse_warehouse_asn_origin_facility_id` FOREIGN KEY (`origin_facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ADD CONSTRAINT `fk_warehouse_asn_line_warehouse_asn_id` FOREIGN KEY (`warehouse_asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`warehouse_asn`(`warehouse_asn_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_dock_appointment_id` FOREIGN KEY (`dock_appointment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`dock_appointment`(`dock_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ADD CONSTRAINT `fk_warehouse_inbound_receipt_warehouse_asn_id` FOREIGN KEY (`warehouse_asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`warehouse_asn`(`warehouse_asn_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_asn_line_id` FOREIGN KEY (`asn_line_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`asn_line`(`asn_line_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_pallet_id` FOREIGN KEY (`pallet_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pallet`(`pallet_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ADD CONSTRAINT `fk_warehouse_inbound_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_handling_unit_id` FOREIGN KEY (`handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_primary_putaway_storage_location_id` FOREIGN KEY (`primary_putaway_storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_warehouse_asn_id` FOREIGN KEY (`warehouse_asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`warehouse_asn`(`warehouse_asn_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ADD CONSTRAINT `fk_warehouse_putaway_task_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ADD CONSTRAINT `fk_warehouse_pick_wave_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_wave`(`pick_wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ADD CONSTRAINT `fk_warehouse_pick_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`material`(`material_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_packing_station_id` FOREIGN KEY (`packing_station_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`packing_station`(`packing_station_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ADD CONSTRAINT `fk_warehouse_pack_order_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_wave`(`pick_wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ADD CONSTRAINT `fk_warehouse_outbound_shipment_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_carton_id` FOREIGN KEY (`carton_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`carton`(`carton_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_pick_wave_id` FOREIGN KEY (`pick_wave_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_wave`(`pick_wave_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ADD CONSTRAINT `fk_warehouse_outbound_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`equipment`(`equipment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_pallet_id` FOREIGN KEY (`pallet_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pallet`(`pallet_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_reversed_movement_inventory_movement_id` FOREIGN KEY (`reversed_movement_inventory_movement_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inventory_movement`(`inventory_movement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ADD CONSTRAINT `fk_warehouse_inventory_movement_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pick_task`(`pick_task_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ADD CONSTRAINT `fk_warehouse_cycle_count_counter_team_id` FOREIGN KEY (`counter_team_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`counter_team`(`counter_team_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ADD CONSTRAINT `fk_warehouse_cycle_count_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ADD CONSTRAINT `fk_warehouse_cycle_count_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_inventory_movement_id` FOREIGN KEY (`inventory_movement_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`inventory_movement`(`inventory_movement_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ADD CONSTRAINT `fk_warehouse_cycle_count_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_primary_replenishment_storage_location_id` FOREIGN KEY (`primary_replenishment_storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ADD CONSTRAINT `fk_warehouse_replenishment_order_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ADD CONSTRAINT `fk_warehouse_returns_receipt_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_returns_receipt_id` FOREIGN KEY (`returns_receipt_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`returns_receipt`(`returns_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ADD CONSTRAINT `fk_warehouse_returns_receipt_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`equipment`(`equipment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_warehouse_asn_id` FOREIGN KEY (`warehouse_asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`warehouse_asn`(`warehouse_asn_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ADD CONSTRAINT `fk_warehouse_labor_activity_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ADD CONSTRAINT `fk_warehouse_dock_appointment_warehouse_asn_id` FOREIGN KEY (`warehouse_asn_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`warehouse_asn`(`warehouse_asn_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_outbound_shipment_order_id` FOREIGN KEY (`outbound_shipment_order_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`(`outbound_shipment_order_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ADD CONSTRAINT `fk_warehouse_wip_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ADD CONSTRAINT `fk_warehouse_hazmat_storage_compliance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ADD CONSTRAINT `fk_warehouse_service_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ADD CONSTRAINT `fk_warehouse_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ADD CONSTRAINT `fk_warehouse_facility_carrier_service_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ADD CONSTRAINT `fk_warehouse_supply_agreement_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`sku`(`sku_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ADD CONSTRAINT `fk_warehouse_facility_partner_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ADD CONSTRAINT `fk_warehouse_facility_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`material` ADD CONSTRAINT `fk_warehouse_material_parent_material_id` FOREIGN KEY (`parent_material_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`material`(`material_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ADD CONSTRAINT `fk_warehouse_counter_team_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ADD CONSTRAINT `fk_warehouse_counter_team_parent_counter_team_id` FOREIGN KEY (`parent_counter_team_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`counter_team`(`counter_team_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ADD CONSTRAINT `fk_warehouse_pallet_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ADD CONSTRAINT `fk_warehouse_pallet_material_id` FOREIGN KEY (`material_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`material`(`material_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ADD CONSTRAINT `fk_warehouse_pallet_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ADD CONSTRAINT `fk_warehouse_pallet_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ADD CONSTRAINT `fk_warehouse_pallet_parent_pallet_id` FOREIGN KEY (`parent_pallet_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`pallet`(`pallet_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ADD CONSTRAINT `fk_warehouse_equipment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ADD CONSTRAINT `fk_warehouse_equipment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ADD CONSTRAINT `fk_warehouse_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`equipment`(`equipment_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ADD CONSTRAINT `fk_warehouse_carton_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ADD CONSTRAINT `fk_warehouse_carton_parent_carton_id` FOREIGN KEY (`parent_carton_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`carton`(`carton_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ADD CONSTRAINT `fk_warehouse_packing_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ADD CONSTRAINT `fk_warehouse_packing_station_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`zone`(`zone_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ADD CONSTRAINT `fk_warehouse_packing_station_parent_packing_station_id` FOREIGN KEY (`parent_packing_station_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`packing_station`(`packing_station_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`facility`(`facility_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_parent_handling_unit_id` FOREIGN KEY (`parent_handling_unit_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`handling_unit`(`handling_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ADD CONSTRAINT `fk_warehouse_handling_unit_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `transport_shipping_ecm`.`warehouse`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`warehouse` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`warehouse` SET TAGS ('dbx_domain' = 'warehouse');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `annual_ghg_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Annual Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Tonnes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Closed Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `customs_bonded_warehouse` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Warehouse');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'DC|CFS|ICD|FTZ|cross-dock|fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `ftz_designation` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Designation');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `has_cold_storage` SET TAGS ('dbx_business_glossary_term' = 'Has Cold Storage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `has_hazmat_storage` SET TAGS ('dbx_business_glossary_term' = 'Has Hazardous Materials (HAZMAT) Storage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `is_aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `is_ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Is Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `is_iso28000_certified` SET TAGS ('dbx_business_glossary_term' = 'Is ISO 28000 Certified');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `is_iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'Is ISO 9001 Certified');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `max_daily_inbound_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Inbound Volume in Units');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `max_daily_outbound_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Outbound Volume in Units');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Opened Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `storage_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `temperature_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `total_floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Total Floor Area in Square Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility` ALTER COLUMN `wms_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `automation_type` SET TAGS ('dbx_business_glossary_term' = 'Automation Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `automation_type` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|robotic|automated_storage_retrieval_system|conveyor_integrated');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `fire_suppression_zone` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Zone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `fire_suppression_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `free_trade_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `hazmat_class_permitted` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class Permitted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `hazmat_suitable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Suitable Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_barcode` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Barcode');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|damaged|reserved');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'empty|partially_occupied|fully_occupied|over_allocated');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `rack` SET TAGS ('dbx_business_glossary_term' = 'Rack Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `rack` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `returns_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Processing Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|restricted|high_value|controlled_access|bonded');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Level Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `temperature_class` SET TAGS ('dbx_business_glossary_term' = 'Temperature Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `temperature_class` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled|deep_freeze');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `value_added_services_flag` SET TAGS ('dbx_business_glossary_term' = 'Value Added Services (VAS) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`storage_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `barcode_type` SET TAGS ('dbx_value_regex' = 'UPC|EAN|CODE128|CODE39|QR|other');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `expiry_date_required` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `fragile` SET TAGS ('dbx_business_glossary_term' = 'Fragile Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `inventory_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Method Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `inventory_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|FEFO|standard');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `lot_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `max_stack_height` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Height');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `pick_type` SET TAGS ('dbx_business_glossary_term' = 'Pick Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `pick_type` SET TAGS ('dbx_value_regex' = 'each|case|pallet|bulk');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `serial_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Tracking Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'SKU Description');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|obsolete');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|box|carton|unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `velocity_code` SET TAGS ('dbx_business_glossary_term' = 'Velocity Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `velocity_code` SET TAGS ('dbx_value_regex' = 'fast|medium|slow');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`sku` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `ftz_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ftz Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `fifo_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `hold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantine|hold|damaged|expired');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `lifo_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Last In First Out (LIFO) Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `pick_face_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `putaway_zone` SET TAGS ('dbx_business_glossary_term' = 'Putaway Zone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `replenishment_trigger_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `temperature_controlled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'celsius|fahrenheit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|carton|box|unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `volume_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Per Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cbm|cft|liter|gallon');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `weight_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Per Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_position` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|g|oz|ton|mt');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `origin_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^ASN[0-9]{10,15}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|partially_received|fully_received|cancelled|exception');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `carrier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Reference Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `dock_door_assignment` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assignment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `edi_transmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `expected_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Time');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Temperature Controlled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `received_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Received Carton Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `received_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Received Pallet Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `shipment_priority` SET TAGS ('dbx_business_glossary_term' = 'Shipment Priority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `shipment_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters - CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal|parcel');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`warehouse_asn` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|mislabel|quality_issue|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `asn_line_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Line Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Header ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_item|quality_issue|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'ASN Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'ASN Line Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|received|discrepancy|cancelled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `putaway_location` SET TAGS ('dbx_business_glossary_term' = 'Putaway Location');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `putaway_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Putaway Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PL|CTN|BOX|PKG');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`asn_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `dock_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Dock Appointment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Clerk ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `bonded_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{11,15}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|quality|documentation|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `expected_cartons_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Cartons Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `expected_pallets_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallets Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `putaway_priority` SET TAGS ('dbx_business_glossary_term' = 'Putaway Priority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `putaway_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|in-progress|passed|failed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|exception|cancelled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'purchase-order|transfer|return|cross-dock|sample');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `temperature_recorded_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Recorded (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `total_cartons_received` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons Received');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `total_pallets_received` SET TAGS ('dbx_business_glossary_term' = 'Total Pallets Received');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters - CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `unloading_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unloading End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `unloading_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unloading Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `vehicle_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt` ALTER COLUMN `vehicle_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `asn_line_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `pallet_id` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspector ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'NEW|USED|REFURBISHED|DAMAGED|EXPIRED|QUARANTINE');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `lpn_number` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (LPN)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `purchase_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `putaway_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Putaway Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `putaway_status` SET TAGS ('dbx_business_glossary_term' = 'Putaway Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `putaway_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|IN_PROGRESS|COMPLETED|EXCEPTION');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'NOT_REQUIRED|PENDING|IN_PROGRESS|PASSED|FAILED');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'PENDING|RECEIVED|PUTAWAY|DISCREPANCY|CLOSED');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Line Cost');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Volume');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'CBM|CFT|LT|GL');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Receipt Line Weight');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inbound_receipt_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|MT|TON');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `putaway_task_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Operative ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `handling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `handling_unit_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `primary_putaway_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Required');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'manual|pallet_jack|forklift|reach_truck|order_picker|automated_guided_vehicle');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{0,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `fifo_date` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|quarantine|hold|damaged|expired');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_]{1,50}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'own_stock|customer_stock|consignment|vendor_managed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `quality_check_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `replenishment_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `standard_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Standard Time (Seconds)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Started Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `system_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'System Directed Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'open|assigned|in_progress|completed|cancelled|suspended');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `travel_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance (Meters)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`putaway_task` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `carrier_service_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Materials (HAZMAT)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `is_high_value` SET TAGS ('dbx_business_glossary_term' = 'Is High Value');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Temperature Controlled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `labor_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Actual');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `labor_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Planned');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `packing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packing End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `packing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packing Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `packing_station_count` SET TAGS ('dbx_business_glossary_term' = 'Packing Station Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `pick_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pick Accuracy Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `picker_count` SET TAGS ('dbx_business_glossary_term' = 'Picker Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `picking_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `picking_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `planned_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `planned_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `short_pick_count` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `sla_cutoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Cutoff Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Wave Allocation Method');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_allocation_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|fefo|nearest_location|optimal_path');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_notes` SET TAGS ('dbx_business_glossary_term' = 'Wave Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_business_glossary_term' = 'Wave Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_template_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Template Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Wave Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_value_regex' = 'single_order|multi_order|zone|cluster|batch|wave');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operative ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `aisle_code` SET TAGS ('dbx_business_glossary_term' = 'Aisle Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `aisle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'order_cancelled|inventory_unavailable|duplicate_task|system_error|customer_request|other');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Cancelled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'rf_scan|voice_pick|paper_list|goods_to_person|pick_to_light|automated');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_type` SET TAGS ('dbx_business_glossary_term' = 'Pick Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `pick_type` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `replenishment_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Triggered Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `short_pick_quantity` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `short_pick_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `short_pick_reason_code` SET TAGS ('dbx_value_regex' = 'inventory_discrepancy|damaged_goods|location_empty|wrong_sku|system_error|other');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration in Seconds');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Priority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `travel_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance in Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|carton|box|piece');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'barcode_scan|weight_check|visual_inspection|supervisor_approval|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `volume_picked_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Picked in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `weight_picked_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Picked in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pick_task` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_order_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Order ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_station_id` SET TAGS ('dbx_business_glossary_term' = 'Packing Station ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_station_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Batch ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operative ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `dimensional_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `dispatch_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Actual Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `dispatch_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Scheduled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^(1|2|3|4|5|6|7|8|9)(.[0-9])?$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `label_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `label_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Generation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_method_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Method Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_method_code` SET TAGS ('dbx_value_regex' = 'single_item|multi_item|bulk|pallet|mixed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_order_number` SET TAGS ('dbx_business_glossary_term' = 'Pack Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_priority_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Priority Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|standard|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pack_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|packed|verified|on_hold|cancelled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packaging_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Packing Exception Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_exception_code` SET TAGS ('dbx_value_regex' = 'short_pick|damaged_item|missing_material|equipment_failure|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Packing Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Packing Zone Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `packing_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = 'fragile|hazmat|cold_chain|high_value|oversized|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `target_temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `target_temperature_range_c` SET TAGS ('dbx_value_regex' = '^-?[0-9]{1,3}s?tos?-?[0-9]{1,3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `temperature_control_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `total_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Item Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `total_packed_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Packed Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `total_packed_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Packed Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pack_order` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Order ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Origin Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'CUSTOMER_REQUEST|INVENTORY_SHORTAGE|ADDRESS_INVALID|PAYMENT_FAILURE|DUPLICATE_ORDER|OTHER');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cod_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cod_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `cod_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `consignee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Destination Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Destination Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight in Kilograms (DIM Weight)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `dispatched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatched Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'B2C_ECOMMERCE|B2B_FREIGHT|INTER_FACILITY_TRANSFER|RMA_RETURN|REPLENISHMENT|CROSS_DOCK');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `otd_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'URGENT|HIGH|NORMAL|LOW');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `sla_service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Service Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `sla_service_level` SET TAGS ('dbx_value_regex' = 'SAME_DAY|NEXT_DAY|TWO_DAY|STANDARD|ECONOMY|EXPRESS');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_shipment_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `carton_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Picker Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `customer_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Item Reference');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-9])?$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `pack_station` SET TAGS ('dbx_business_glossary_term' = 'Pack Station');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `pack_station` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,15}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `pick_location` SET TAGS ('dbx_business_glossary_term' = 'Pick Location');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `pick_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'DAMAGED|WRONG_ITEM|DEFECTIVE|CUSTOMER_CHANGE|NONE');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipped Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `short_ship_quantity` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = 'FRAGILE|REFRIGERATED|FROZEN|HIGH_VALUE|OVERSIZED|NONE');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`outbound_order_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `inventory_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Movement ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `equipment_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `ftz_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Ftz Admission Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `pallet_id` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `pallet_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reversed_movement_inventory_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Movement ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Task ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `bonded_status` SET TAGS ('dbx_business_glossary_term' = 'Bonded Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `bonded_status` SET TAGS ('dbx_value_regex' = 'non_bonded|bonded|in_bond|duty_paid');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `from_location_code` SET TAGS ('dbx_business_glossary_term' = 'From Location Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `from_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|reversed|error');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `quantity_moved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Moved');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reference_line_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'manhattan_wms|sap_ewm|oracle_wms|blue_yonder|manual_entry');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `to_location_code` SET TAGS ('dbx_business_glossary_term' = 'To Location Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `to_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`inventory_movement` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `counter_team_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Team ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `counter_team_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `adjustment_posted` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `adjustment_posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `aisle_range_end` SET TAGS ('dbx_business_glossary_term' = 'Aisle Range End');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `aisle_range_start` SET TAGS ('dbx_business_glossary_term' = 'Aisle Range Start');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|rfid|barcode_scan|automated');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_program_code` SET TAGS ('dbx_business_glossary_term' = 'Count Program Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_program_name` SET TAGS ('dbx_business_glossary_term' = 'Count Program Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_reason` SET TAGS ('dbx_business_glossary_term' = 'Count Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|approved|cancelled|on_hold');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|cycle|spot|abc_velocity|blind|location_directed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `fifo_lifo_method` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) / Last In First Out (LIFO) Method');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `fifo_lifo_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|fefo|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `hazmat_count_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Count Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `labor_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Actual');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `recount_count` SET TAGS ('dbx_business_glossary_term' = 'Recount Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `recount_required` SET TAGS ('dbx_business_glossary_term' = 'Recount Required');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `regulatory_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `total_locations_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Locations Counted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `total_skus_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Units (SKUs) Counted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `total_units_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Units Counted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `variance_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `variance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Variance Value United States Dollar (USD)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `variance_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `wms_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Batch ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count` ALTER COLUMN `wms_batch_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{5,30}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `cycle_count_line_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Header ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `inventory_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `primary_cycle_counter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `primary_cycle_counter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `primary_cycle_counter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'pending|counted|recounted|approved|rejected|adjusted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `inventory_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `inventory_condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|quarantine|hold|rework');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|closed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `recount_quantity` SET TAGS ('dbx_business_glossary_term' = 'Recount Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `recount_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recount Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `recount_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Recount Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Value Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`cycle_count_line` ALTER COLUMN `variance_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Pick-Face Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Worker ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `primary_replenishment_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `actual_quantity_moved` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Moved');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Batch ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `batch_reference` SET TAGS ('dbx_value_regex' = '^BATCH-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'forklift|pallet_jack|reach_truck|order_picker|manual|automated_system');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `fifo_sequence` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Sequence');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|failed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `pick_face_max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick-Face Maximum Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `pick_face_min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick-Face Minimum Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Started Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `system_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'System Generated Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `travel_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'min_max|demand_driven|wave_triggered|manual|scheduled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|carton|box');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`replenishment_order` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `returns_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Operative ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `carrier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Reference Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `claim_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Initiated Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_value_regex' = 'resalable|damaged|quarantine|destroy|refurbish_required');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `disposition_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `inspection_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `originating_order_number` SET TAGS ('dbx_business_glossary_term' = 'Originating Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `pod_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Document Reference');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `quarantined_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantined Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^RR[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Return Received Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `restocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Restocked Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Processing Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'customer_return|failed_delivery|damaged_in_transit|warranty_return|wrong_item_shipped|quality_defect');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `total_declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `total_packages_received` SET TAGS ('dbx_business_glossary_term' = 'Total Packages Received');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt` ALTER COLUMN `total_units_received` SET TAGS ('dbx_business_glossary_term' = 'Total Units Received');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `returns_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Original Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspected By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Restock Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `returns_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt Header ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'NEW|USED|DAMAGED|DEFECTIVE|EXPIRED|OPENED');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `destroyed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Destroyed Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'RESTOCK|REPAIR|SCRAP|DONATE|RETURN_VENDOR');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspected Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'PENDING|IN_PROGRESS|PASSED|FAILED|WAIVED');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'RECEIVED|INSPECTED|RESTOCKED|DISPOSED|PENDING');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `resalable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Resalable Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `restocked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restocked Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PL|BX|KG|LB');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`returns_receipt_line` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `labor_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Activity ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operative ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|paused|cancelled|exception');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'receiving|putaway|picking|packing|replenishment|cycle_count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `actual_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Time Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Activity Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'forklift|pallet_jack|rf_scanner|voice_device|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `incentive_eligible` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `productivity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Productivity Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `quality_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Passed Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `quality_check_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `standard_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Time Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `training_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Mode Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `travel_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|line|order');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `units_processed` SET TAGS ('dbx_business_glossary_term' = 'Units Processed');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`labor_activity` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `dock_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Dock Appointment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `warehouse_asn_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|cross-dock|live-unload|drop-trailer');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `expected_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Carton Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `expected_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallet Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `expected_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Expected Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `expected_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Expected Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `loading_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Complete Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `loading_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `no_show_reason` SET TAGS ('dbx_business_glossary_term' = 'No-Show Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `outbound_order_number` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `scheduled_arrival_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival End Time');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `scheduled_arrival_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Start Time');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `shipment_priority` SET TAGS ('dbx_business_glossary_term' = 'Shipment Priority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `shipment_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum in Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`dock_appointment` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Work-in-Progress (WIP) Record ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `outbound_shipment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operative User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `quaternary_wip_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `quaternary_wip_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `quaternary_wip_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `tertiary_wip_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `tertiary_wip_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `tertiary_wip_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `kit_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Kit Reference Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `rejection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejection Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `standard_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Labor Hours');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `vas_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Service (VAS) Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_record_number` SET TAGS ('dbx_business_glossary_term' = 'Work-in-Progress (WIP) Record Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work-in-Progress (WIP) Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'queued|in_progress|completed|failed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_type` SET TAGS ('dbx_business_glossary_term' = 'Work-in-Progress (WIP) Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `wip_type` SET TAGS ('dbx_value_regex' = 'kitting|labelling|repackaging|quality_inspection|customs_hold|deconsolidation');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`wip_record` ALTER COLUMN `work_station_code` SET TAGS ('dbx_business_glossary_term' = 'Work Station Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `hazmat_storage_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Storage Compliance ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|over_limit|segregation_breach|zone_violation|expired_permit|non_compliant');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `current_stored_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Stored Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|co2|dry_chemical|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Class');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|spot_check|incident_driven|regulatory_audit|annual_review');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `labeling_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Labeling Compliant Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `maximum_storage_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `personal_protective_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `placarding_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Placarding Required Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lbs|liters|gallons|units');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'IMO|IATA|DOT|ICAO|WCO|local_authority');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `safety_data_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `segregation_group` SET TAGS ('dbx_business_glossary_term' = 'Segregation Group');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Segregation Requirement');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_value_regex' = 'away_from|separated_from|separated_by_deck|separated_longitudinally|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `spill_containment_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Spill Containment Available Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `storage_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `ventilation_system_type` SET TAGS ('dbx_business_glossary_term' = 'Ventilation System Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`hazmat_storage_compliance` ALTER COLUMN `ventilation_system_type` SET TAGS ('dbx_value_regex' = 'natural|mechanical|explosion_proof|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Ledger Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `quaternary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `quaternary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `quaternary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `tertiary_service_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `tertiary_service_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `tertiary_service_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `baseline_performance_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance Value');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `breach_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `breach_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `continuous_improvement_target` SET TAGS ('dbx_business_glossary_term' = 'Continuous Improvement Target');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `notification_email_list` SET TAGS ('dbx_business_glossary_term' = 'Notification Email List');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `notification_email_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `reporting_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Reporting Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'receiving_turnaround|order_dispatch|inventory_accuracy|returns_processing|putaway_completion|picking_accuracy');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|expired');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `target_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`service_agreement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `aisle_count` SET TAGS ('dbx_business_glossary_term' = 'Aisle Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `automation_type` SET TAGS ('dbx_business_glossary_term' = 'Automation Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `automation_type` SET TAGS ('dbx_value_regex' = 'manual|conveyor|asrs|goods_to_person|robotic|hybrid');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Dock Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `dock_door_assignment` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assignment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|dry_chemical|none');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Square Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `ftz_designation` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Designation');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `hazmat_class_permitted` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class Permitted');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `hazmat_suitable_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Suitable Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `height_m` SET TAGS ('dbx_business_glossary_term' = 'Zone Height Meters');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `location_count` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Count');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `replenishment_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Source Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `returns_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Processing Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|high|restricted|bonded');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `storage_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `vas_flag` SET TAGS ('dbx_business_glossary_term' = 'Value Added Services (VAS) Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity Kilograms');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|restricted|decommissioned');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` SET TAGS ('dbx_association_edges' = 'warehouse.facility,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `facility_carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Service ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Service - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Service - Facility Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `dock_door_assignments` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assignments');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `pickup_schedule` SET TAGS ('dbx_business_glossary_term' = 'Pickup Schedule');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `rate_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Reference');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_carrier_service` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'warehouse.sku,procurement.supplier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Sku Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`supply_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` SET TAGS ('dbx_association_edges' = 'warehouse.facility,network.network_partner');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `facility_partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Partner Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Partner Agreement - Facility Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Partner Agreement - Network Partner Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_partner_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` SET TAGS ('dbx_association_edges' = 'warehouse.facility,contract.agreement');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `facility_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Agreement - Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Agreement - Facility Id');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `allocated_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Percentage');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Override');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `facility_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Tier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`facility_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`material` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`material` ALTER COLUMN `parent_material_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ALTER COLUMN `counter_team_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Team Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`counter_team` ALTER COLUMN `parent_counter_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `pallet_id` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`pallet` ALTER COLUMN `parent_pallet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ALTER COLUMN `parent_carton_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`carton` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` SET TAGS ('dbx_subdomain' = 'facility_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `packing_station_id` SET TAGS ('dbx_business_glossary_term' = 'Packing Station Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `parent_packing_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`packing_station` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ALTER COLUMN `handling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Identifier');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`warehouse`.`handling_unit` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
