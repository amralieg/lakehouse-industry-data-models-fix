-- Schema for Domain: inventory | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`inventory` COMMENT 'Owns physical inventory positions across the entire distribution network. Manages stock on hand, in-transit inventory, warehouse locations, FEFO/FIFO rotation rules, DIO metrics, OOS/OSA events, VMI replenishment triggers, lot/batch traceability for recall readiness, safety stock levels, and multi-echelon inventory visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique identifier for the stock position record. Primary key for the stock position entity.',
    `inventory_storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (warehouse, distribution center, store, or specific bin) where the inventory is held.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Label changeover management requires knowing which approved label version is currently in stock at each location. Consumer goods companies must track label version on-hand to manage artwork transition',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Batch‑level inventory reconciliation report requires linking each stock position to its lot_batch for traceability of production dates and quality attributes.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution facility that owns this inventory position.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Inventory Balance Report requires linking each stock_position to its brand for marketing planning and stock‑availability forecasts.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Consumer goods manufacturers maintain stock positions for raw materials and packaging components alongside finished goods. A material_id FK enables raw material inventory visibility, reorder point man',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: REQUIRED: Links each stock record to its purchase‑order line for cost allocation and replenishment analysis.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: REQUIRED: Traceability of on‑hand stock to the goods receipt that created it for audit and regulatory compliance.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Inventory stock position reports need registration status of each SKU to ensure market compliance and audit readiness.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: VMI programs in consumer goods require stock positions to be linked to specific retail stores for replenishment triggering, OSA monitoring, and store-level inventory reporting. stock_position has vmi_',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which inventory is held. Links to the product master data.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: REPLENISHMENT PLANNING: stock positions need to reference SKU planning parameters for safety stock and lot sizing decisions.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Stock positions in Consumer Goods are valued using standard costs; unit_cost and total_value on stock_position derive from the active standard cost record. This link enables inventory valuation report',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor who owns consignment stock. Populated only when special_stock_indicator is consignment.',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'Quantity available for new customer orders after accounting for existing commitments and reservations. Calculated as unrestricted quantity minus reserved quantity.',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock that is blocked from use due to quality issues, regulatory holds, or other restrictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock position record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory valuation. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CAD|AUD|INR|BRL|MXN — 10 candidates stripped; promote to reference product]',
    `days_inventory_outstanding` STRING COMMENT 'Number of days the current inventory level would last based on average daily demand. Key metric for working capital efficiency and cash flow management.',
    `expiration_date` DATE COMMENT 'Date after which the product should not be sold or used. Essential for FEFO inventory rotation and regulatory compliance.',
    `goods_receipt_date` DATE COMMENT 'Date when the inventory was physically received at this storage location. Used for FIFO rotation and aging analysis.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock currently in transit between locations (plant-to-warehouse, warehouse-to-store, etc.) and not yet received at destination.',
    `last_goods_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (receipt, issue, transfer) for this stock position. Used to identify slow-moving or obsolete inventory.',
    `last_physical_inventory_date` DATE COMMENT 'Date when the last physical count or cycle count was performed for this stock position. Used for inventory accuracy monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock position record was last modified. Used for data freshness monitoring and change tracking.',
    `manufacturing_date` DATE COMMENT 'Date when the batch or lot was manufactured. Critical for shelf-life management and FEFO rotation.',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at this location to prevent overstocking and optimize working capital.',
    `obsolete_flag` BOOLEAN COMMENT 'Indicates whether the inventory is obsolete (discontinued product, expired, or no longer saleable) and should be written off or disposed.',
    `oos_risk_flag` BOOLEAN COMMENT 'Indicates whether the current stock level is below safety stock and at risk of stockout. Used for proactive replenishment alerts.',
    `quality_inspection_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock currently undergoing quality control inspection and not yet released for use.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical inventory quantity available at the storage location. This is the authoritative single source of truth for inventory balance.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the stock is under quarantine pending quality inspection, regulatory review, or investigation.',
    `recall_hold_flag` BOOLEAN COMMENT 'Indicates whether the stock is on hold due to a product recall or safety alert. Prevents further distribution or sale.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic replenishment. When stock falls to this level, a purchase requisition or transfer order is generated.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock reserved for specific sales orders, production orders, or other commitments and not available for general allocation.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained as buffer stock to prevent stockouts due to demand variability or supply disruptions.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining until expiration. Used for FEFO prioritization and markdown planning.',
    `slow_moving_flag` BOOLEAN COMMENT 'Indicates whether the inventory has had no or minimal movement over a defined period (typically 90+ days), signaling potential obsolescence risk.',
    `special_stock_indicator` STRING COMMENT 'Indicates whether the stock is held under special conditions or ownership arrangements. Standard stock is company-owned and unrestricted; consignment is supplier-owned; project stock is allocated to specific projects; sales order stock is reserved for specific customer orders; subcontracting stock is at vendor location; pipeline stock is in-transit; returnable packaging is reusable containers. [ENUM-REF-CANDIDATE: standard|consignment|project|sales_order|subcontracting|pipeline|returnable_packaging — 7 candidates stripped; promote to reference product]',
    `stock_rotation_rule` STRING COMMENT 'Inventory rotation policy applied at this location. FIFO=First In First Out; FEFO=First Expired First Out (for perishables); LIFO=Last In First Out; Manual=operator-controlled picking.. Valid values are `fifo|fefo|lifo|manual`',
    `stock_status` STRING COMMENT 'Current lifecycle status of the stock position. Active=available for operations; Inactive=temporarily unavailable; Pending Disposal=marked for write-off; Transferred=moved to another location; Consumed=used in production or sold.. Valid values are `active|inactive|pending_disposal|transferred|consumed`',
    `stock_type` STRING COMMENT 'Classification of inventory by availability status. Unrestricted stock is available for sale or use; quality inspection stock is pending QC approval; blocked stock cannot be used; returns stock is customer returns awaiting disposition; restricted use stock has limited applications; consignment stock is owned by supplier; VMI-managed stock is vendor-managed inventory. [ENUM-REF-CANDIDATE: unrestricted|quality_inspection|blocked|returns|restricted_use|consignment|vmi_managed — 7 candidates stripped; promote to reference product]',
    `total_value` DECIMAL(18,2) COMMENT 'Total financial value of the stock position, calculated as quantity on hand multiplied by unit cost. Used for balance sheet reporting and working capital analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory at this location, used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon, M=Meter, FT=Foot. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL|M|FT — 9 candidates stripped; promote to reference product]',
    `unrestricted_quantity` DECIMAL(18,2) COMMENT 'Quantity of stock that is freely available for sale, production, or distribution without any restrictions.',
    `valuation_type` STRING COMMENT 'Method used to value the inventory for financial reporting. Standard uses predetermined costs; moving average recalculates after each receipt; FIFO assumes first-in-first-out; LIFO assumes last-in-first-out; weighted average uses average cost across all receipts.. Valid values are `standard|moving_average|fifo|lifo|weighted_average`',
    `vmi_replenishment_flag` BOOLEAN COMMENT 'Indicates whether this stock position is managed under a VMI agreement where the vendor is responsible for replenishment decisions.',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Core master record of physical inventory on-hand quantities for each SKU at each storage location. Captures unrestricted, quality-hold, blocked, consignment, VMI-managed, and in-transit stock quantities by stock type and special stock indicator. Serves as the authoritative real-time inventory balance (single source of truth for quantity on hand). Supports OOS/OSA monitoring, days-inventory-outstanding calculation, available-to-promise derivation, and multi-echelon inventory visibility across the distribution network.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique identifier for the lot or batch record. Primary key for the lot_batch product.',
    `dossier_id` BIGINT COMMENT 'Foreign key linking to regulatory.dossier. Business justification: Batch traceability links each lot/batch to its regulatory dossier for post‑market surveillance and recall investigations.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: Consumer goods batch release and regulatory compliance require tracing each manufactured lot to the exact formulation version used. Critical for recall root-cause analysis, GMP compliance, and INCI/RE',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: A lot/batch has a primary storage location within the distribution network (storage_location_code is currently a denormalized STRING). Replacing storage_location_code with a typed FK to inventory_stor',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Label changeover management in consumer goods requires tracking which approved label version was applied to each manufactured lot. Regulatory traceability audits and artwork compliance reviews depend ',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility where this lot or batch was produced.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level lot traceability is required for quality compliance and consumer‑facing brand claims; linking lot_batch to brand supports this.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Raw material lots received from suppliers are tracked as lot_batch records in consumer goods manufacturing. A material_id FK enables raw material traceability, shelf-life management, and supplier qual',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.product_bom. Business justification: Batch traceability requires knowing which BOM version was used to produce each lot. In consumer goods GMP audits, quality investigations, and regulatory submissions, the exact BOM version active at ba',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: GMP batch release requires confirming the batch was manufactured under a valid regulatory registration for the target market. Regulatory auditors and quality teams routinely verify this link during ba',
    `sku_id` BIGINT COMMENT 'Reference to the SKU that this lot or batch represents. Links to the product master.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Lot/batch traceability to originating supplier is a core consumer goods regulatory requirement (FDA 21 CFR, EU cosmetics regulation). lot_batch.vendor_name is a denormalized plain-text supplier refere',
    `batch_number` STRING COMMENT 'The externally-known unique batch or lot number assigned during manufacturing. Used for traceability and recall management.',
    `batch_status` STRING COMMENT 'The current lifecycle status of the lot or batch. Indicates whether the batch is active and available, depleted, expired, recalled, destroyed, or transferred to another location.. Valid values are `active|depleted|expired|recalled|destroyed|transferred`',
    `best_before_date` DATE COMMENT 'The date until which the product retains optimal quality. Distinct from expiry_date; product may still be safe but quality may degrade after this date.',
    `certificate_of_analysis_number` STRING COMMENT 'The unique identifier for the Certificate of Analysis document that records the quality test results for this lot or batch.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting regulatory compliance status, exceptions, or special handling requirements for this lot or batch.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the country where this lot or batch was manufactured. Required for customs, trade compliance, and labeling.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this lot or batch record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lot or batch record was first created in the system. Used for audit trail and data lineage.',
    `expiry_date` DATE COMMENT 'The date after which the product should not be used or sold. Used to enforce First Expired First Out (FEFO) inventory rotation and prevent sale of expired goods.',
    `gmp_status` STRING COMMENT 'Indicates whether this lot or batch was produced in compliance with Good Manufacturing Practice standards. Critical for regulatory compliance and quality assurance.. Valid values are `certified|compliant|non_compliant|pending_review|exempt`',
    `hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot or batch is on hold and cannot be used or shipped. True if on hold, False otherwise.',
    `hold_reason` STRING COMMENT 'The business reason why this lot or batch is on hold, if applicable. Examples: pending quality review, regulatory investigation, customer complaint.',
    `inspection_date` DATE COMMENT 'The date on which quality control inspection was performed on this lot or batch.',
    `lot_number` STRING COMMENT 'Alternative or supplementary lot identifier used in some manufacturing contexts. May be the same as batch_number or represent a sub-batch.',
    `manufacturing_date` DATE COMMENT 'The date on which this lot or batch was manufactured or produced. Critical for shelf-life calculation and First Expired First Out (FEFO) rotation.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this lot or batch record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lot or batch record was last modified in the system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this lot or batch. May include special handling instructions, quality observations, or other relevant information.',
    `production_order_number` STRING COMMENT 'The production order or work order number under which this lot or batch was manufactured. Links to Manufacturing Execution System (MES) records.',
    `quality_grade` STRING COMMENT 'The quality grade or classification assigned to this lot or batch based on quality control inspection results. May affect pricing, distribution channel, or disposal decisions. [ENUM-REF-CANDIDATE: A|B|C|premium|standard|substandard|rejected — 7 candidates stripped; promote to reference product]',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The total quantity of product manufactured in this lot or batch, measured in the base unit of measure.',
    `quarantine_status` STRING COMMENT 'Current quarantine or release status of the lot or batch. Quarantined lots cannot be used or shipped until quality inspection is complete and status is changed to released.. Valid values are `released|quarantined|rejected|pending_inspection|conditionally_released`',
    `receipt_date` DATE COMMENT 'The date on which this lot or batch was received into inventory, applicable for purchased or transferred goods.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot or batch meets all applicable regulatory compliance requirements. True if compliant, False otherwise.',
    `remaining_shelf_life_days` STRING COMMENT 'The number of days remaining until expiry_date as of the current date. Used for inventory rotation and markdown decisions.',
    `retest_date` DATE COMMENT 'The date by which the lot or batch must be retested to confirm continued quality and compliance. Common in pharmaceutical and chemical manufacturing.',
    `shelf_life_days` STRING COMMENT 'The number of days from manufacturing_date to expiry_date, representing the total shelf life of this lot or batch. Used for First Expired First Out (FEFO) calculations.',
    `storage_condition_requirement` STRING COMMENT 'The required storage conditions for this lot or batch to maintain product quality and safety. Examples: ambient, refrigerated, frozen, controlled room temperature.. Valid values are `ambient|refrigerated|frozen|controlled_room_temperature|hazmat`',
    `supplier_lot_number` STRING COMMENT 'The lot or batch number assigned by the supplier for received raw materials or finished goods. Used for traceability back to the supplier in case of quality issues or recalls.',
    `traceability_code` STRING COMMENT 'A unique code used for end-to-end supply chain traceability of this lot or batch. May be a GS1 Global Trade Item Number (GTIN) with batch extension or similar standard.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantity_produced is measured. Examples: EA (each), CS (case), KG (kilogram), L (liter). [ENUM-REF-CANDIDATE: EA|CS|KG|LB|L|GAL|M|FT — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Master record for each manufactured or received lot/batch of a SKU, capturing batch number, manufacturing date, expiry date, best-before date, country of origin, GMP status, and quarantine flags. Supports FEFO/FIFO rotation enforcement, lot-level traceability for recall readiness, and regulatory compliance (FDA 21 CFR Part 11, EU REACH, EU Food Information Regulation). Linked to production batch records in manufacturing execution systems and quality inspection lots.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` (
    `inventory_storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the distribution network. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Specific storage locations (hazmat zones, cold-chain areas, controlled substance cages) are governed by distinct compliance obligations (temperature monitoring requirements, hazmat storage regulations',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory reporting requires mapping each storage location to its jurisdiction for local compliance (labeling, safety, reporting).',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the parent facility (distribution center, warehouse, retail store, or third-party logistics provider) where this storage location resides.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: WAREHOUSE MANAGEMENT: each storage location is physically part of a supply network node; required for location‑level inventory reporting.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: A storage location (aisle, bay, bin, zone) physically resides within a warehouse. This is a fundamental parent-child relationship in warehouse management: warehouse → storage_location hierarchy. Witho',
    `abc_classification` STRING COMMENT 'ABC analysis classification for the location based on inventory velocity and value. A for high-velocity/high-value, B for medium, C for low-velocity/low-value items. Used for slotting optimization.. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and location addressing.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or section identifier within an aisle, representing a vertical or horizontal subdivision of storage space.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin` STRING COMMENT 'Bin or slot identifier representing the smallest addressable storage unit within a level, used for item-level location precision.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the location was blocked or made unavailable for inventory placement.',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, used for operational troubleshooting and compliance documentation.',
    `capacity_pallet_positions` STRING COMMENT 'Number of standard pallet positions that can be stored in this location, used for pallet-based inventory planning.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location in cubic meters, used for space utilization optimization.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms, used for load planning and safety compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the system for audit trail and data lineage.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this location is designated for cross-docking operations where goods move directly from receiving to shipping without long-term storage.',
    `effective_end_date` DATE COMMENT 'Date when the storage location was decommissioned or removed from active use. Null for currently active locations.',
    `effective_start_date` DATE COMMENT 'Date when the storage location became operational and available for inventory placement.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified and equipped for storing hazardous materials per regulatory requirements.',
    `inventory_storage_location_level` STRING COMMENT 'Vertical level or shelf position within a bay, used for precise location addressing in multi-tier racking systems.. Valid values are `^[A-Z0-9]{1,3}$`',
    `last_inventory_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count performed at this location, used for inventory accuracy tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was most recently updated for change tracking and audit compliance.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent inventory movement (putaway, pick, transfer) at this location, used for activity analysis and slotting optimization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the storage location for geospatial analytics, route optimization, and facility mapping.',
    `location_code` STRING COMMENT 'Business identifier for the storage location used across warehouse management and inventory systems. Unique alphanumeric code assigned to each physical or logical storage position.. Valid values are `^[A-Z0-9]{4,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the storage location for operational reference and reporting.',
    `location_status` STRING COMMENT 'Current operational status of the storage location. Active for normal operations, blocked for temporary holds, maintenance for repairs, quarantine for quality issues, inactive for unused space, decommissioned for permanently retired locations.. Valid values are `active|inactive|blocked|maintenance|quarantine|decommissioned`',
    `location_type` STRING COMMENT 'Classification of the storage location based on its operational purpose within the warehouse. Bulk storage for palletized goods, pick locations for order fulfillment, reserve for overflow, quarantine for quality hold, returns for reverse logistics, and staging for in-transit goods.. Valid values are `bulk|pick|reserve|quarantine|returns|staging`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the storage location for geospatial analytics, route optimization, and facility mapping.',
    `mixed_sku_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple SKUs simultaneously or requires single-SKU dedication for inventory accuracy.',
    `picking_priority` STRING COMMENT 'Numeric priority ranking for order picking optimization. Lower numbers indicate higher priority for fast-moving SKUs and efficient pick path planning.',
    `replenishment_trigger_threshold` DECIMAL(18,2) COMMENT 'Percentage threshold that triggers automatic replenishment from reserve to pick locations. Used in Vendor Managed Inventory (VMI) and automated replenishment processes.',
    `rotation_rule` STRING COMMENT 'Inventory rotation policy applied to this location. FEFO (First Expired First Out) for perishables, FIFO (First In First Out) for standard goods, LIFO (Last In First Out) for specific scenarios, or MANUAL for operator-controlled picking.. Valid values are `FEFO|FIFO|LIFO|MANUAL`',
    `security_level` STRING COMMENT 'Security classification of the storage location based on access controls and monitoring requirements. High-value for premium products, controlled substance for regulated materials, restricted for limited access areas.. Valid values are `standard|restricted|high_value|controlled_substance`',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location. Ambient for room temperature, refrigerated for 2-8°C, frozen for below 0°C, and controlled for specific temperature ranges required by product specifications.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `zone_code` STRING COMMENT 'WMS zone identifier used for warehouse layout management, picking optimization, and labor allocation. Zones group locations by operational characteristics or product categories.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_inventory_storage_location PRIMARY KEY(`inventory_storage_location_id`)
) COMMENT 'Master record for physical and logical storage locations within the distribution network including distribution centers, warehouses, retail back-rooms, 3PL facilities, and in-transit staging areas. Captures location code, location type (bulk, pick, reserve, quarantine, returns), temperature zone, capacity (weight, volume, pallet positions), WMS zone mapping, and geo-coordinates. Serves as the single source of truth for the location hierarchy used across warehouse management and inventory systems.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement record.',
    `bom_line_id` BIGINT COMMENT 'Foreign key linking to product.bom_line. Business justification: Manufacturing consumption tracking links inventory movements to specific BOM lines, enabling component usage analysis per product in the Component Consumption Report.',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: Logistics teams track stock movements tied to specific campaign flights to measure promotional material delivery and OTIF performance.',
    `carrier_id` BIGINT COMMENT 'Transportation carrier responsible for moving inventory between locations for inter-node transfers.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting for each inventory movement requires linking to the responsible cost center for internal reporting and allocation.',
    `inventory_storage_location_id` BIGINT COMMENT 'Warehouse, plant, or storage location to which inventory is being moved. Null for goods issues to external destinations.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Stock movements (retailer shipments, display builds, returns) executed as part of promotion event fulfillment must be linked to the promotion event for trade spend reconciliation, deduction management',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: GR-triggered stock movements (movement type 101) must be traceable to the originating goods receipt for three-way match validation, inventory audit trails, and GR reversal reconciliation. Existing pur',
    `inventory_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_replenishment_order. Business justification: A replenishment order generates one or more stock movements (goods receipts, transfer postings). Linking stock_movement to inventory_replenishment_order enables end-to-end replenishment traceability: ',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the logistics shipment for inter-plant or inter-warehouse transfers to track in-transit inventory.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Every stock movement in consumer goods is traceable to a specific lot/batch for FEFO/FIFO rotation, recall readiness, and shelf-life management. The existing batch_number STRING column is a denormaliz',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Raw material goods receipts, production issues, and scrap movements in consumer goods manufacturing are stock movements against materials, not finished SKUs. A direct material_id FK supports raw mater',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Needed to tie inventory movements to the originating sales order for order fulfillment audit and cost of goods sold reconciliation.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Stock movements from GR posting must reference the specific PO line for line-level three-way match, partial delivery tracking, and invoice reconciliation. Existing purchase_order_id FK is header-level',
    `primary_stock_inventory_storage_location_id` BIGINT COMMENT 'Warehouse, plant, or storage location from which inventory is being moved. Null for goods receipts from external sources.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Stock movements for goods issue to production (component consumption) and goods receipt from production are directly caused by production orders. Consumer goods ERP systems (SAP) require this link for',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis of inventory flows assigns each movement to a profit center, needed for segment reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: PO receipt tracking for OTIF reporting and financial reconciliation links stock movements to the originating purchase order.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Cross-border stock movements (import/export) in consumer goods require a valid regulatory registration in the destination jurisdiction. Customs clearance, trade compliance reporting, and import docume',
    `reversed_movement_stock_movement_id` BIGINT COMMENT 'Reference to the original stock movement record that this transaction reverses or cancels.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU involved in this stock movement event.',
    `supplier_id` BIGINT COMMENT 'Supplier or vendor from whom goods were received for goods receipt movements.',
    `trade_account_id` BIGINT COMMENT 'Customer to whom goods were issued for sales order fulfillment or Direct to Consumer (DTC) shipments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock movement record was first created in the system for audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the movement value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the source document (purchase order, production order, delivery note) that triggered this movement.',
    `expiration_date` DATE COMMENT 'Shelf life expiration date for perishable or time-sensitive products. Critical for First Expired First Out (FEFO) rotation and Out of Stock (OOS) prevention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock movement record was last updated or modified for change tracking.',
    `manufacturing_date` DATE COMMENT 'Date when the product was manufactured or produced. Used for shelf life calculation and traceability.',
    `material_document_number` STRING COMMENT 'SAP material document number generated for this goods movement. Unique identifier in the source ERP system.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year of the material document for SAP document key uniqueness.',
    `movement_category` STRING COMMENT 'High-level classification of the movement event for reporting and analytics purposes.. Valid values are `goods_receipt|goods_issue|stock_transfer|return|adjustment|write_off`',
    `movement_notes` STRING COMMENT 'Free-text notes or comments providing additional context about the stock movement event.',
    `movement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical inventory movement occurred or was recorded in the system.',
    `movement_type_code` STRING COMMENT 'SAP movement type code identifying the nature of the inventory transaction (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Production, 311=Stock Transfer, 551=Scrapping, 601=Goods Receipt from Delivery).. Valid values are `^[A-Z0-9]{2,4}$`',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where the movement occurred.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date when the stock movement was posted to the inventory ledger for financial and inventory accounting purposes.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this stock movement requires quality inspection before the inventory can be released for use.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory moved in this transaction. Positive for receipts/increases, negative for issues/decreases.',
    `reason_code` STRING COMMENT 'Code explaining the business reason for the movement (e.g., quality issue, damage, expiration, customer return, production scrap).. Valid values are `^[A-Z0-9]{2,6}$`',
    `reference_document_line` STRING COMMENT 'Line item number within the reference document that corresponds to this stock movement.',
    `reference_document_number` STRING COMMENT 'Document number of the source transaction (PO number, production order number, delivery note number) that triggered this movement.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that initiated this stock movement for audit trail and reconciliation. [ENUM-REF-CANDIDATE: purchase_order|production_order|sales_order|delivery_note|transfer_order|return_order|adjustment_document — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this movement is a reversal or cancellation of a previous stock movement transaction.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `special_stock_indicator` STRING COMMENT 'SAP special stock type indicator (e.g., E=Sales Order Stock, K=Consignment Stock, O=Project Stock, W=Vendor Managed Inventory).. Valid values are `^[A-Z]{1}$`',
    `stock_type` STRING COMMENT 'Classification of inventory status determining availability for use (unrestricted=available for sale/use, quality_inspection=pending QC, blocked=not available).. Valid values are `unrestricted|quality_inspection|blocked|restricted|in_transit`',
    `storage_location` STRING COMMENT 'Specific storage location or bin within the plant or warehouse where inventory is stored.. Valid values are `^[A-Z0-9]{4}$`',
    `total_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory movement (quantity × unit cost) for financial reporting and inventory accounting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory at the time of movement for inventory valuation and Cost of Goods Sold (COGS) calculation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the movement quantity (e.g., EA=Each, CS=Case, KG=Kilogram, LT=Liter).. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Sub-classification for split valuation of the same material (e.g., domestic vs imported, new vs refurbished).. Valid values are `^[A-Z0-9]{1,4}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts, goods issues, stock transfers, returns, write-offs, and inter-plant transfers. Captures movement type code, quantity, unit of measure, source and destination locations, posting date, reference document (purchase order, production order, delivery note), carrier/shipment reference for inter-node transfers, and posting user. Provides the full audit trail for inventory reconciliation and in-transit tracking.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` (
    `inventory_replenishment_order_id` BIGINT COMMENT 'Unique identifier for the inventory replenishment order record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaigns trigger dedicated replenishment orders; linking enables the Campaign‑Driven Replenishment Report used in trade spend planning.',
    `carrier_id` BIGINT COMMENT 'Reference to the logistics carrier assigned to transport this replenishment shipment from source to destination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders are charged to cost centers for budgeting and cost tracking of inventory replenishment.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or retail location that will receive the replenished inventory.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Replenishment orders are frequently triggered by upcoming promotion events (promotional inventory build). Linking enables promotion-driven supply chain planning, post-event analysis of inventory avail',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Replenishment orders in consumer goods are executed on specific logistics lanes that determine transit time, carrier assignment, and freight cost — all critical inputs to replenishment planning and OT',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: When a replenishment order is received, it is associated with a specific lot/batch for FEFO rotation and shelf-life compliance. The existing lot_number STRING column is a denormalized reference; repla',
    `primary_inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or manufacturing facility from which inventory will be shipped to fulfill this replenishment order.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: In make-to-stock consumer goods operations, inventory replenishment orders fulfilled by internal manufacturing are directly linked to the production order that will produce the stock. Supply planners ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center allocation of replenishment orders supports segment‑level expense reporting.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: REQUIRED: Internal replenishment orders are driven by purchase requisitions; linking supports demand‑driven planning.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU being replenished. Links to the product master for item details.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: A replenishment order is triggered by a specific stock position falling below safety stock or reorder point thresholds (safety_stock_trigger_flag, oos_prevention_flag on inventory_replenishment_order)',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Replenishment orders are fulfilled by a specific supplier. Consumer goods supply planners track supplier-level fill rates and lead time adherence per replenishment order. No existing FK links replenis',
    `actual_delivery_date` DATE COMMENT 'Actual date the shipment was received at the destination location. Used to measure delivery performance and OTIF compliance.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location. Used to calculate On Time In Full (OTIF) performance.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU approved for fulfillment after review and Available to Promise (ATP) validation. May differ from requested quantity due to supply constraints.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the replenishment order was cancelled, if applicable. Examples include demand change, supply constraint, or duplicate order.',
    `expiration_date` DATE COMMENT 'Date after which the product should not be sold or used. Used to enforce First Expired First Out (FEFO) rotation rules in inventory management.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost incurred for transporting this replenishment order from source to destination location.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was last updated in the system.',
    `lead_time_days` STRING COMMENT 'Expected number of days between order placement and delivery at the destination location, based on historical lane performance.',
    `oos_prevention_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was created to prevent an anticipated Out of Stock (OOS) event based on demand forecasting.',
    `order_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was approved for fulfillment by the supply chain planner or automated approval workflow.',
    `order_cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was cancelled, if applicable. Null for active orders.',
    `order_creation_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was first created in the system, either automatically by planning algorithms or manually by a planner.',
    `order_notes` STRING COMMENT 'Free-text field for planners to capture special instructions, handling requirements, or contextual information about the replenishment order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order indicating its position in the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|in_transit|received|cancelled — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to the replenishment order to guide fulfillment sequencing and resource allocation. Critical orders address Out of Stock (OOS) situations.. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received and confirmed at the destination location. May differ from shipped quantity due to damage or discrepancies.',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique identifier for the replenishment order, used for tracking and communication across systems and stakeholders.. Valid values are `^[A-Z0-9]{8,20}$`',
    `replenishment_type` STRING COMMENT 'Classification of the replenishment order generation method: Vendor Managed Inventory (VMI) auto-replenishment, Distribution Requirements Planning (DRP) planned order, manual trigger by planner, safety stock replenishment, emergency order, or seasonal build.. Valid values are `vmi_auto|drp_planned|manual_trigger|safety_stock|emergency|seasonal`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the replenishment inventory is needed at the destination location to prevent Out of Stock (OOS) conditions.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment, as calculated by the demand planning system or entered by the planner.',
    `rotation_rule` STRING COMMENT 'Inventory rotation policy applied to this replenishment: First Expired First Out (FEFO) for perishables, First In First Out (FIFO) for standard goods, Last In First Out (LIFO) for specific scenarios.. Valid values are `fefo|fifo|lifo`',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below the safety stock threshold at the destination location.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for shipment departure from the source location, calculated based on lead time and requested delivery date.',
    `shipment_tracking_number` STRING COMMENT 'Carrier-provided tracking number for the shipment associated with this replenishment order. Used for in-transit visibility.. Valid values are `^[A-Z0-9]{10,30}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped from the source location. Updated when the shipment is dispatched.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the replenishment quantity is expressed: Each (EA), Case (CS), Pallet (PL), Pound (LB), Kilogram (KG), Liter (L), Gallon (GAL). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inventory_replenishment_order PRIMARY KEY(`inventory_replenishment_order_id`)
) COMMENT 'Transactional record of inventory replenishment requests and orders generated through VMI auto-replenishment, distribution requirements planning (DRP), or manual triggers. Captures replenishment type, requested quantity, approved quantity, source location, destination location, requested delivery date, priority, and fulfillment status. Closes the loop between demand sensing signals and physical stock movement execution.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` (
    `inventory_cycle_count_id` BIGINT COMMENT 'Unique identifier for the inventory cycle count event. Primary key for the cycle count record.',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse storage location where the cycle count was performed. Links to the physical bin, aisle, or zone within the facility.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Cycle counts in consumer goods are conducted at the lot/batch level to verify lot-specific quantities, especially for perishable and regulated products. The existing lot_number STRING column is a deno',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the cycle count was performed. Supports multi-site inventory management.',
    `original_count_inventory_cycle_count_id` BIGINT COMMENT 'If this is a recount, references the inventory_cycle_count_id of the original count that triggered the recount requirement. Null for initial counts.',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: S&OP inventory accuracy reporting: consumer goods companies schedule cycle counts aligned with planning periods (monthly/quarterly) to feed inventory accuracy metrics into S&OP. This link enables peri',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) that was counted during this cycle count event.',
    `stock_adjustment_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_adjustment. Business justification: A cycle count variance triggers a stock adjustment to correct the inventory balance. The existing adjustment_document_number STRING column is a denormalized reference to the resulting adjustment; repl',
    `abc_classification` STRING COMMENT 'The ABC inventory classification of the SKU at the time of count. A = high-value items counted frequently, B = medium-value, C = low-value counted less frequently. Drives cycle count frequency.. Valid values are `A|B|C`',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the variance has been posted as an inventory adjustment in the ERP (Enterprise Resource Planning) system. True = adjustment posted, False = pending posting.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count was approved by the authorized supervisor. Part of the audit trail for inventory adjustments.',
    `count_date` DATE COMMENT 'The calendar date on which the physical cycle count was performed.',
    `count_method` STRING COMMENT 'The methodology used for the cycle count. Full physical = complete inventory audit, ABC cycle = frequency-based counting by value classification, perpetual = continuous counting, spot check = random verification, blind count = counter does not see system quantity.. Valid values are `full_physical|abc_cycle|perpetual|spot_check|blind_count`',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event. Planned = scheduled but not started, in_progress = counting underway, confirmed = count verified, posted = variance adjusted in system, cancelled = count voided, recount_required = variance exceeds threshold.. Valid values are `planned|in_progress|confirmed|posted|cancelled|recount_required`',
    `count_timestamp` TIMESTAMP COMMENT 'Precise date and time when the cycle count was executed. Used for audit trail and WMS (Warehouse Management System) reconciliation.',
    `count_zone` STRING COMMENT 'The warehouse zone or area designation where the count took place (e.g., receiving, picking, reserve, quarantine). Used for zone-based cycle count scheduling.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse associate during the cycle count event. Measured in the SKUs unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was first created in the system. Part of the audit trail.',
    `expiration_date` DATE COMMENT 'The expiration or best-before date of the lot/batch counted. Critical for FEFO (First Expired First Out) rotation rules and consumer safety in CPG (Consumer Packaged Goods).',
    `inventory_value_at_count` DECIMAL(18,2) COMMENT 'The total monetary value of the counted inventory based on the counted quantity and the unit cost at the time of count. Used for financial reconciliation and shrinkage cost calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was last updated. Tracks changes through the count lifecycle (planned → in_progress → confirmed → posted).',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the counted inventory is in quarantine status pending quality inspection or regulatory clearance. True = quarantined, False = available.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether this cycle count is a recount of a previous count that exceeded variance thresholds. True = recount, False = initial count.',
    `system_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded in the WMS (Warehouse Management System) or ERP (Enterprise Resource Planning) system at the time of the count. Used to calculate variance.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the counted inventory is stored in a temperature-controlled environment. True = cold chain storage, False = ambient. Relevant for perishable consumer goods.',
    `unit_of_measure` STRING COMMENT 'The unit in which the inventory was counted. EA = each, CS = case, PL = pallet, KG = kilogram, LB = pound, L = liter, GAL = gallon. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_notes` STRING COMMENT 'Free-text explanation or additional context provided by the counter or approver regarding the variance. Used for investigation and documentation.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the system quantity. Calculated as (variance_quantity / system_quantity) * 100. Used to trigger investigation thresholds.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity (counted minus system). Positive values indicate overage, negative values indicate shortage.',
    `variance_reason_code` STRING COMMENT 'Categorization of the root cause for the inventory variance. Used for shrinkage analysis, process improvement, and loss prevention. [ENUM-REF-CANDIDATE: shrinkage|damage|misplacement|system_error|receiving_error|picking_error|expiration|theft|administrative_error|vendor_shortage — promote to reference product]. Valid values are `shrinkage|damage|misplacement|system_error|receiving_error|picking_error`',
    `variance_value` DECIMAL(18,2) COMMENT 'The monetary value of the variance (variance_quantity * unit_cost). Represents the financial impact of the inventory discrepancy. Used for shrinkage reporting and P&L (Profit and Loss) impact analysis.',
    CONSTRAINT pk_inventory_cycle_count PRIMARY KEY(`inventory_cycle_count_id`)
) COMMENT 'Transactional record of physical inventory cycle count events conducted at storage locations. Captures count date, count method (full physical, ABC cycle, perpetual), counted quantity, system quantity, variance quantity, variance percentage, count status (planned, in-progress, confirmed, posted), and approver. Supports inventory accuracy KPIs, shrinkage investigation triggers, and WMS reconciliation. Distinct from stock_movement as it represents a formal audit event, not a stock transaction.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`oos_event` (
    `oos_event_id` BIGINT COMMENT 'Unique identifier for the out-of-stock event record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign-driven OOS analysis is a named KPI in consumer goods: when a campaign spikes demand causing stockouts, brand and supply chain teams must link the OOS event to the causative campaign to calcul',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: OOS events during active promotions directly impact promotional ROI, lift measurement, and post-event analysis. Consumer goods TPM teams track OOS incidents per promotion event as a standard KPI for p',
    `inventory_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_replenishment_order. Business justification: An OOS event directly triggers a replenishment order (oos_prevention_flag on inventory_replenishment_order). Linking oos_event to the resulting inventory_replenishment_order enables measurement of OOS',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or retail location where the OOS event occurred.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Brand managers in consumer goods track OOS rates as a brand health KPI. oos_event.brand_name is a denormalized text field; replacing it with marketing_brand_id normalizes the model and enables direct ',
    `previous_oos_event_id` BIGINT COMMENT 'Reference to the previous OOS event ID for the same SKU-location if this is a recurrence, enabling trend analysis.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: OOS events in consumer goods occur at specific retail stores and must be linked for store-level OSA reporting, sales rep notification, and account-level OOS tracking. oos_event has inventory_storage_l',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: OOS root cause analysis: OOS events are directly caused by safety stock parameter failures. Linking oos_event to the specific safety_stock record breached enables root cause analysis and safety stock ',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU that experienced the out-of-stock condition.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: An OOS/OSA event is directly triggered by a specific stock position (SKU at a storage location) falling below threshold. Linking oos_event directly to stock_position provides a navigational shortcut t',
    `actual_demand_units` DECIMAL(18,2) COMMENT 'Actual observed demand in units during the OOS event period, used to identify demand spikes or forecast misses.',
    `channel_type` STRING COMMENT 'Distribution channel type where the OOS event occurred: retail, wholesale, e-commerce, DSD (Direct Store Delivery), or DTC (Direct to Consumer).. Valid values are `retail|wholesale|ecommerce|dsd|dtc`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective action plan implemented to prevent recurrence of similar OOS events in the future.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS event record was first created in the system.',
    `customer_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the OOS event resulted in direct customer impact such as lost sales, customer complaints, or service level breaches.',
    `demand_forecast_units` DECIMAL(18,2) COMMENT 'Forecasted demand in units for the period during which the OOS event occurred, used to compare actual vs. planned demand.',
    `detection_source` STRING COMMENT 'System or channel that detected and reported the out-of-stock event, such as POS system, WMS, demand sensing platform, manual report, retail execution app, or EDI feed.. Valid values are `pos_system|wms|demand_sensing|manual_report|retail_execution_app|edi_feed`',
    `estimated_lost_sales_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of sales lost due to the out-of-stock condition, calculated based on historical demand patterns and average selling price.',
    `estimated_lost_units` DECIMAL(18,2) COMMENT 'Estimated quantity of units that could not be sold due to the out-of-stock condition.',
    `event_status` STRING COMMENT 'Current lifecycle status of the OOS event record: open (active OOS), resolved (inventory restored), under investigation (root cause analysis in progress), or closed (fully resolved and documented).. Valid values are `open|resolved|under_investigation|closed`',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'Forecast accuracy percentage for the SKU-location during the period of the OOS event, calculated as (1 - |actual - forecast| / actual) * 100.',
    `impact_severity` STRING COMMENT 'Severity classification of the OOS event impact based on lost sales value, SKU importance, and customer impact. Categories: critical, high, medium, low.. Valid values are `critical|high|medium|low`',
    `inventory_on_hand_at_oos` DECIMAL(18,2) COMMENT 'System-recorded inventory quantity on hand at the time the OOS event was detected, used to identify phantom inventory situations.',
    `last_replenishment_date` DATE COMMENT 'Date of the most recent replenishment delivery prior to the OOS event, used to analyze replenishment frequency adequacy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS event record was most recently updated, reflecting changes to status, resolution actions, or root cause analysis.',
    `next_scheduled_replenishment_date` DATE COMMENT 'Date of the next scheduled replenishment delivery at the time of the OOS event, used to assess replenishment planning gaps.',
    `oos_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the out-of-stock event measured in hours, calculated as the difference between end and start timestamps.',
    `oos_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the out-of-stock condition was resolved and inventory became available again.',
    `oos_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the out-of-stock condition was first detected. Sourced from POS data feeds or demand sensing signals.',
    `oos_type` STRING COMMENT 'Classification of the OOS event type: warehouse stockout (no inventory in facility), shelf stockout (inventory in back room but not on shelf), phantom inventory (system shows stock but physical count is zero), or system mismatch.. Valid values are `warehouse_stockout|shelf_stockout|phantom_inventory|system_mismatch`',
    `osa_actual_percent` DECIMAL(18,2) COMMENT 'Actual on-shelf availability percentage achieved during the period including the OOS event, calculated from POS and inventory data.',
    `osa_target_percent` DECIMAL(18,2) COMMENT 'Target on-shelf availability percentage for the SKU-location at the time of the OOS event, used to measure performance against goals.',
    `product_category` STRING COMMENT 'Product category classification of the SKU that experienced the OOS event, used for category-level OOS analysis and reporting.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this OOS event is a recurrence of a previous OOS event for the same SKU-location combination within a defined time window.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Configured reorder point threshold for the SKU at this location, used to evaluate whether replenishment triggers were properly set.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the out-of-stock event, such as emergency replenishment, transfer from alternate location, expedited shipment, customer backorder, substitution offered, or no action taken.. Valid values are `emergency_replenishment|transfer_from_alternate_location|expedited_shipment|customer_backorder|no_action_taken|substitution_offered`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the resolution action was initiated or completed to address the out-of-stock condition.',
    `root_cause_category` STRING COMMENT 'Primary root cause classification for the OOS event. Categories include demand spike, replenishment failure, forecast miss, upstream stockout, logistics delay, or system error.. Valid values are `demand_spike|replenishment_failure|forecast_miss|upstream_stockout|logistics_delay|system_error`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause behind the out-of-stock event, providing context beyond the category classification.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the OOS event caused a breach of service level agreement commitments to customers or retail partners.',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Transactional record capturing Out-of-Stock (OOS) and On-Shelf Availability (OSA) events at the SKU-location level. Captures OOS start timestamp, OOS end timestamp, OOS duration (hours), root cause category (demand spike, replenishment failure, forecast miss, upstream stockout, logistics delay), estimated lost sales value, and resolution action. Sourced from POS data feeds and demand sensing signals. Critical for OSA improvement programs, retail execution accountability, and service level reporting.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'Unique identifier for the product recall or withdrawal event. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: When a recall is initiated, the batch manufacturing record is the primary GMP document reviewed by regulatory authorities (FDA 21 CFR Part 7). Consumer goods recall management requires direct linkage ',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Every consumer goods recall requires a CAPA to address root cause and prevent recurrence. Linking recall_event to capa_id enables recall CAPA management, regulatory submission tracking, and effectiven',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: Consumer goods recalls are frequently triggered by formulation defects (contamination, incorrect ingredient concentration, regulatory non-compliance). Linking recall_event to the causative formulation',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Recall scope is jurisdiction-specific in consumer goods — a voluntary recall in the EU may differ from a mandatory recall in the US. Regulatory reporting, authority notifications, and effectiveness ch',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Recalls are scoped to specific manufacturing facilities (e.g., all product from Facility X during date range). FDA/CPSC recall reporting requires identifying the originating manufacturing facility. Co',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Regulatory recall notifications are issued per brand; linking recall_event to brand enables brand‑level recall management and compliance reporting.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Recalls in consumer goods are initiated from a nonconformance event (e.g., contamination, labelling defect). Linking recall_event to the triggering nonconformance_id provides mandatory regulatory trac',
    `product_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.product_complaint. Business justification: Consumer goods recalls are frequently triggered by product complaints (consumer safety reports). Linking recall_event to the initiating product_complaint_id provides the consumer-facing trigger tracea',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Internal recall events must be tied to the external regulatory product recall record to align actions and reporting.',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to regulatory.restricted_substance. Business justification: Recalls in consumer goods are frequently triggered by restricted substance violations (e.g., prohibited preservatives, heavy metals exceeding limits). Linking the recall event to the specific restrict',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: When a recall is initiated, a formal regulatory submission (recall notification, adverse event report) is filed with authorities. Consumer goods companies must link the operational recall event to the',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Consumer goods recall events are frequently caused by supplier quality failures. Regulatory reporting (FDA, EU) and supplier accountability tracking require identifying the responsible supplier on eac',
    `affected_gtin_list` STRING COMMENT 'Comma-separated list of GTIN/UPC/EAN codes for recalled products. Enables point-of-sale blocking and supply chain traceability across trading partners using GS1 standards.',
    `affected_product_description` STRING COMMENT 'Comprehensive description of the product(s) subject to recall, including brand names, product names, sizes, formulations, and any distinguishing characteristics. Used for consumer identification.',
    `affected_sku_list` STRING COMMENT 'Comma-separated or structured list of SKU codes for all products included in the recall scope. Links to product master for detailed SKU attributes and enables inventory queries.',
    `closure_date` DATE COMMENT 'Date when the regulatory authority officially closed the recall after reviewing effectiveness checks and final reports. Nullable until regulatory closure is granted.',
    `completion_date` DATE COMMENT 'Date when all recall activities were completed, including product recovery, customer notification, and corrective actions. Nullable until recall is finished.',
    `consumer_contact_method` STRING COMMENT 'Primary method(s) used to notify consumers about the recall. Press Release: public media announcement. Direct Mail: letters to registered consumers. Email: electronic notification. Phone: direct phone contact. Social Media: notification via social platforms. Retail Signage: point-of-sale notices. Multiple Methods: combination approach. [ENUM-REF-CANDIDATE: Press Release|Direct Mail|Email|Phone|Social Media|Retail Signage|Multiple Methods — 7 candidates stripped; promote to reference product]',
    `corrective_action` STRING COMMENT 'Description of corrective and preventive actions (CAPA) implemented to address the root cause and prevent recurrence. Includes process changes, equipment modifications, supplier changes, and quality system improvements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `depth_of_recall` STRING COMMENT 'Level in the distribution chain to which the recall extends. Consumer Level: recall reaches end consumers. Retail Level: recall stops at retail stores. Wholesale Level: recall stops at wholesalers/distributors. Distribution Center: recall stops at company distribution centers before reaching trade.. Valid values are `Consumer Level|Retail Level|Wholesale Level|Distribution Center`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the recall including product cost, logistics, customer credits, disposal, regulatory fines, and brand impact. Expressed in reporting currency. Used for financial reserves and management reporting.',
    `expiration_date_range_end` DATE COMMENT 'Latest expiration or best-by date printed on recalled products. Defines the full date range for consumer identification.',
    `expiration_date_range_start` DATE COMMENT 'Earliest expiration or best-by date printed on recalled products. Helps consumers and retailers identify affected units on shelf.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact amount. Enables multi-currency recall cost tracking and consolidation.. Valid values are `^[A-Z]{3}$`',
    `health_hazard_evaluation` STRING COMMENT 'FDA or internal assessment of the health risk posed by the recalled product. Describes potential adverse health consequences and likelihood of occurrence. Used to determine recall classification.',
    `initiation_date` DATE COMMENT 'Date when the recall was officially initiated by the company. This is the business event date when the decision to recall was made and communicated internally.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was last updated. Tracks data currency and supports change audit requirements.',
    `manufacturing_date_range_end` DATE COMMENT 'Latest manufacturing date of products included in the recall scope. Defines the cutoff for affected production runs.',
    `manufacturing_date_range_start` DATE COMMENT 'Earliest manufacturing date of products included in the recall scope. Used to identify affected inventory based on production timeline.',
    `notification_date` DATE COMMENT 'Date when the regulatory authority (FDA, CPSC, EPA, or other governing body) was formally notified of the recall event. Required for compliance reporting.',
    `public_announcement_date` DATE COMMENT 'Date when the recall was publicly announced through press release, FDA website posting, or other public communication channels.',
    `quantity_distributed` DECIMAL(18,2) COMMENT 'Total quantity of affected product that was distributed into the market prior to recall initiation. Expressed in base unit of measure (units, cases, kilograms). Represents the maximum potential recall scope.',
    `quantity_recalled` DECIMAL(18,2) COMMENT 'Total quantity of product subject to the recall action. May differ from quantity distributed if recall scope is narrowed to specific lots, channels, or geographies.',
    `quantity_recovered` DECIMAL(18,2) COMMENT 'Actual quantity of recalled product recovered from the market through returns, destructions, and corrections. Updated throughout recall lifecycle. Used to calculate recall effectiveness percentage.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this recall record. Ensures consistent interpretation of distributed, recalled, and recovered quantities.. Valid values are `Units|Cases|Pallets|Kilograms|Liters|Pounds`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the specific defect, contamination, safety issue, or regulatory violation that triggered the recall. Includes root cause findings and quality investigation summary.',
    `recall_classification` STRING COMMENT 'FDA or regulatory classification of the recall severity. Class I: dangerous or defective products that could cause serious health problems or death. Class II: products that might cause temporary health problem or pose slight threat of serious nature. Class III: products unlikely to cause adverse health reaction but violate FDA labeling or manufacturing regulations. Voluntary Withdrawal: firm removes product from market not required by FDA. Market Withdrawal: minor violation not subject to legal action. Stock Recovery: correction of product still in distribution chain.. Valid values are `Class I|Class II|Class III|Voluntary Withdrawal|Market Withdrawal|Stock Recovery`',
    `recall_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of recalled product successfully recovered from the market. Formula: (quantity_recovered / quantity_recalled) * 100. FDA expects effectiveness checks at 2, 4, and 8 weeks. High effectiveness (>95%) supports recall closure.',
    `recall_number` STRING COMMENT 'External recall identification number assigned by the company or regulatory authority for tracking and communication purposes.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `recall_scope_channel` STRING COMMENT 'Distribution channel(s) affected by the recall. Retail: products sold through retail stores. Wholesale: products in wholesale/distributor inventory. DTC: direct-to-consumer shipments. Food Service: products sold to restaurants/institutions. Healthcare: products distributed to healthcare facilities. All Channels: recall spans all distribution paths.. Valid values are `Retail|Wholesale|DTC|Food Service|Healthcare|All Channels`',
    `recall_scope_customer_segment` STRING COMMENT 'Specific customer segments, account types, or customer groups affected by the recall. Used for targeted notification and recovery when recall does not affect all customers.',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event. Initiated: recall has been declared and communication started. In Progress: active recovery and customer notification underway. Ongoing: recall activities continuing. Completed: all recall activities finished, awaiting final regulatory closure. Terminated: recall ended by firm decision. Closed: regulatory authority has reviewed and closed the recall.. Valid values are `Initiated|In Progress|Ongoing|Completed|Terminated|Closed`',
    `recall_strategy` STRING COMMENT 'Documented strategy for executing the recall including communication plan, recovery method, depth of recall (consumer level, retail level, wholesale level), and timeline. Required by FDA 21 CFR 7.42.',
    `recall_type` STRING COMMENT 'Primary reason category for the recall event. Safety: product poses health or safety risk. Quality: product fails quality specifications. Regulatory: non-compliance with regulations. Labeling: incorrect or missing label information. Contamination: presence of foreign material or microbial contamination. Allergen: undeclared allergen present.. Valid values are `Safety|Quality|Regulatory|Labeling|Contamination|Allergen`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority overseeing this recall. FDA: U.S. Food and Drug Administration. CPSC: Consumer Product Safety Commission. EPA: Environmental Protection Agency. EU REACH: European chemicals regulation. Health Canada: Canadian health authority. ANVISA: Brazilian health authority. TGA: Australian Therapeutic Goods Administration. MHRA: UK Medicines and Healthcare products Regulatory Agency. [ENUM-REF-CANDIDATE: FDA|CPSC|EPA|EU REACH|Health Canada|ANVISA|TGA|MHRA|Other — 9 candidates stripped; promote to reference product]',
    `regulatory_case_number` STRING COMMENT 'Official case or reference number assigned by the regulatory authority for tracking this recall in their system. Used for all regulatory correspondence and reporting.',
    `root_cause_analysis_summary` STRING COMMENT 'Summary of the root cause investigation findings including failure mode, contributing factors, and systemic issues identified. Supports CAPA and regulatory reporting.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Master record for product recall and withdrawal events triggered by safety, quality, or regulatory findings. Captures recall classification (Class I/II/III FDA, voluntary withdrawal), affected SKUs, affected lot/batch ranges, recall scope (geographic, channel, customer), recall initiation date, regulatory notification date (FDA/CPSC), quantity recalled, quantity recovered, recall status, and financial impact estimate. Supports lot_batch traceability queries and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` (
    `stock_adjustment_id` BIGINT COMMENT 'Primary key for stock_adjustment',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `compliance_assessment_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_assessment. Business justification: GMP-mandated stock adjustments (destruction of non-compliant batches, quarantine write-offs) are directly triggered by compliance assessment findings. Quality and regulatory teams require this FK to t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Adjustment postings must be charged to the correct cost center for variance analysis and budgeting.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Stock adjustments for unsold promotional inventory, display teardown write-offs, and promotional returns must be linked to the originating promotion event for accurate post-event P&L, trade spend sett',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each inventory adjustment posts to a GL account; linking ensures accurate journal entry generation.',
    `inventory_storage_location_id` BIGINT COMMENT 'FK to inventory.inventory_storage_location',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Stock adjustments in consumer goods are performed at the lot/batch level to maintain accurate lot-level inventory balances. The existing batch_number STRING column is a denormalized reference; replaci',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Raw material stock adjustments (quality rejections, scrap write-offs, physical count variances for ingredients/packaging) are routine in consumer goods manufacturing. A material_id FK enables raw mate',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Quality-driven stock adjustments (scrap write-offs, quantity corrections due to defects) must reference the nonconformance that triggered them. Consumer goods audit and financial reporting require tra',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Financial adjustments are allocated to profit centers to reflect impact on segment P&L.',
    `reversed_adjustment_stock_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment transaction that this record reverses, establishing the correction chain for audit purposes.',
    `sku_id` BIGINT COMMENT 'Identifier of the product or Stock Keeping Unit (SKU) being adjusted.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: In consumer goods inventory management, a stock adjustment generates or is reconciled against a stock movement document (material document). Formalizing this link with a typed FK replaces the loose re',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the inventory adjustment occurred.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Net quantity change applied to inventory (positive for additions, negative for reductions), measured in the base unit of measure.',
    `adjusted_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory adjustment calculated as adjusted quantity multiplied by unit cost, impacting Cost of Goods Sold (COGS) and inventory valuation.',
    `adjustment_date` DATE COMMENT 'Business date when the inventory adjustment was physically identified or when the correction event occurred, distinct from system posting date.',
    `adjustment_number` STRING COMMENT 'Business-facing unique adjustment document number used for tracking and reference in operational systems and audit trails.. Valid values are `^ADJ-[0-9]{10}$`',
    `adjustment_reason_code` STRING COMMENT 'Standardized code representing the specific reason for the inventory adjustment (e.g., SHRINK, DAMAGE, SAMPLE, PROMO, RECALL, OBSOLETE, RECOUNT).. Valid values are `^[A-Z0-9]{2,10}$`',
    `adjustment_reason_description` STRING COMMENT 'Detailed textual explanation of why the inventory adjustment was necessary, providing business context beyond the reason code.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment transaction indicating its approval and posting state in the inventory ledger.. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adjustment transaction was created or recorded in the system.',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment transaction indicating the nature of the inventory correction (physical count variance, shrinkage, damage, expiry, system reconciliation, theft).. Valid values are `physical_count|shrinkage|damage|expiry|system_reconciliation|theft`',
    `approval_date` DATE COMMENT 'Date when the adjustment was formally approved by authorized personnel, required for audit trail and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the adjustment record was first created in the database, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the adjusted value and unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Product expiration or best-before date for the adjusted inventory batch, critical for First Expired First Out (FEFO) rotation and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the adjustment record was last updated, tracking the most recent change for audit and version control.',
    `movement_type` STRING COMMENT 'SAP movement type code classifying the inventory transaction for goods movement and financial posting (e.g., 701 for goods issue, 702 for goods receipt).. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information about the adjustment that may be relevant for audit or operational review.',
    `physical_count_quantity` DECIMAL(18,2) COMMENT 'Actual physical quantity counted during inventory verification, used to calculate the adjustment variance for cycle counts and physical inventories.',
    `plant_code` STRING COMMENT 'SAP plant code representing the manufacturing or distribution facility where the inventory adjustment occurred.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Financial accounting date when the adjustment was posted to the inventory ledger and general ledger, used for period closing and financial reporting.',
    `reference_document_number` STRING COMMENT 'External reference document number supporting the adjustment (e.g., physical inventory document, cycle count sheet, damage report, quality inspection report).. Valid values are `^[A-Z0-9-]{6,20}$`',
    `reference_document_type` STRING COMMENT 'Type of supporting document referenced for the adjustment, providing audit trail and justification context. [ENUM-REF-CANDIDATE: physical_inventory|cycle_count|damage_report|quality_inspection|sampling_request|promotional_giveaway|recall_notice — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this adjustment is a reversal of a previous adjustment transaction, used for error correction and audit trails.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring individual unit tracking and traceability.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `special_stock_indicator` STRING COMMENT 'Code indicating special stock categories such as consignment, vendor-managed inventory (VMI), or customer-owned stock requiring separate tracking.. Valid values are `^[A-Z]{1,2}$`',
    `stock_type` STRING COMMENT 'Classification of inventory stock status indicating availability for use (unrestricted, quality inspection, blocked, restricted, returns).. Valid values are `unrestricted|quality_inspection|blocked|restricted|returns`',
    `system_quantity_after` DECIMAL(18,2) COMMENT 'Resulting inventory quantity in the system after the adjustment has been posted, representing the corrected stock balance.',
    `system_quantity_before` DECIMAL(18,2) COMMENT 'Inventory quantity recorded in the system before the adjustment was applied, used for variance analysis and audit trails.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or moving average cost per unit of the inventory item at the time of adjustment, used for inventory valuation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the adjusted quantity (e.g., EA for each, CS for case, KG for kilogram, LT for liter).. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_stock_adjustment PRIMARY KEY(`stock_adjustment_id`)
) COMMENT 'Transactional record of manual and system-generated inventory adjustments that correct stock balances outside of normal goods movement flows. Captures adjustment reason (shrinkage, damage, system reconciliation, theft, sampling, promotional giveaway), adjusted quantity, adjusted value, adjustment date, approver, and supporting reference document. Distinct from stock_movement (which covers standard GR/GI flows) — adjustments represent exception corrections to the inventory ledger.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Primary key for warehouse',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each Consumer Goods warehouse operates under a specific legal entity for statutory reporting, tax compliance, and intercompany billing. Linking warehouse to company_code enables legal-entity-level inv',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Warehouses operate under jurisdiction-specific regulatory requirements (hazmat storage, food safety, controlled substance handling). Facility-level regulatory compliance reporting, inspection scheduli',
    `parent_warehouse_id` BIGINT COMMENT 'Self-referencing FK on warehouse (parent_warehouse_id)',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Distribution warehouses in consumer goods require facility-level regulatory registrations (FDA food facility registration, DEA for controlled substances, EU GDP certification). Compliance teams track ',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable storage capacity measured in square feet.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `climate_zone` STRING COMMENT 'Designated climate zone for the warehouse.',
    `closing_date` DATE COMMENT 'Date the warehouse ceased operations (null if still active).',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance certifications held by the warehouse.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the warehouse location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `dock_count` STRING COMMENT 'Total number of loading docks available.',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this warehouse is the primary distribution hub for the company.',
    `last_inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the warehouse.',
    `loading_bays` STRING COMMENT 'Number of dedicated loading bays for inbound/outbound shipments.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the warehouse.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `opening_date` DATE COMMENT 'Date the warehouse began operations.',
    `operational_hours` STRING COMMENT 'Standard operating hours of the warehouse.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the warehouse address.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA) where the warehouse resides.',
    `safety_stock_level` STRING COMMENT 'Target safety stock quantity maintained at the warehouse.',
    `security_level` STRING COMMENT 'Security classification of the warehouse.',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `temperature_control` BOOLEAN COMMENT 'Indicates whether the warehouse has temperature‑controlled storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    `warehouse_code` STRING COMMENT 'External business code used to reference the warehouse in operational systems.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse.',
    `warehouse_status` STRING COMMENT 'Current lifecycle status of the warehouse.',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse based on its primary function.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master reference table for warehouse. Referenced by warehouse_id.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` (
    `recall_lot_scope_id` BIGINT COMMENT 'Primary key for the recall_lot_scope association',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to the specific lot or batch record included in this recall scope',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to the recall event that covers this lot/batch record',
    `affected_lot_batch_range` STRING COMMENT 'Specification of the lot numbers, batch codes, or serial number ranges included in the recall. Critical for traceability and targeted recovery. May be expressed as ranges, lists, or patterns. [Moved from recall_event: This STRING field is a denormalized placeholder that stores lot/batch ranges as unstructured text. It cannot support proper lot-level traceability, per-lot quantity tracking, or regulatory reporting. Its functional purpose is entirely replaced by the recall_lot_scope association table, which provides a proper FK-based enumeration of affected lots with per-lot recovery attributes. This field should be deprecated and removed from recall_event once recall_lot_scope is populated.]',
    `lot_recall_status` STRING COMMENT 'The current recovery status of this specific lot/batch within the recall action. Tracks per-lot progress independently of the overall recall event status. Pending: recovery not yet initiated for this lot; In Progress: recovery activities underway; Recovered: full recovery achieved; Destroyed: product destroyed in lieu of return; Not Located: product cannot be traced.',
    `quantity_recalled_per_lot` DECIMAL(18,2) COMMENT 'The quantity of product from this specific lot/batch that is subject to the recall action. May differ from the lots total quantity_produced if only a portion was distributed or affected. Required for per-lot FDA effectiveness reporting.',
    `quantity_recovered_per_lot` DECIMAL(18,2) COMMENT 'The actual quantity of product from this specific lot/batch that has been recovered from the market through returns, destruction, or retrieval. Used to calculate per-lot recovery effectiveness rate for regulatory reporting.',
    `recovery_date` DATE COMMENT 'The date on which recovery activities for this specific lot/batch were completed. Null if recovery is not yet complete. Used to calculate time-to-recovery per lot and to support FDA effectiveness check submissions.',
    CONSTRAINT pk_recall_lot_scope PRIMARY KEY(`recall_lot_scope_id`)
) COMMENT 'This association product represents the regulatory compliance artifact that enumerates exactly which lot/batch records are covered by each recall event, with per-lot recovery tracking. It captures the scope and recovery status of each recall at the lot level, replacing the denormalized affected_lot_batch_range STRING field on recall_event. Each record links one recall_event to one lot_batch and carries attributes — quantity recalled per lot, quantity recovered per lot, lot-level recall status, and recovery date — that exist only in the context of this specific recall-lot pairing. Required for FDA effectiveness checks and regulatory reporting obligations.. Existence Justification: In consumer goods regulatory operations, a single recall event explicitly covers multiple specific lot/batch numbers (e.g., Recall #2024-001 covers Lot A123, Lot B456, Lot C789), AND a single lot/batch can theoretically be implicated in multiple recall events over its lifecycle (e.g., a contamination recall and a labeling recall affecting overlapping lots). More critically, the business must track per-lot recovery status, quantities recalled per lot, and recovery dates — data that belongs neither to the recall event header nor to the lot master record alone. Regulatory bodies (FDA, CPSC) require manufacturers to report exactly which lot numbers are covered and the recovery status per lot, making this an operationally managed compliance artifact.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_replenishment_order_id` FOREIGN KEY (`inventory_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order`(`inventory_replenishment_order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_primary_stock_inventory_storage_location_id` FOREIGN KEY (`primary_stock_inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_reversed_movement_stock_movement_id` FOREIGN KEY (`reversed_movement_stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_primary_inventory_storage_location_id` FOREIGN KEY (`primary_inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_original_count_inventory_cycle_count_id` FOREIGN KEY (`original_count_inventory_cycle_count_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_stock_adjustment_id` FOREIGN KEY (`stock_adjustment_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_adjustment`(`stock_adjustment_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_inventory_replenishment_order_id` FOREIGN KEY (`inventory_replenishment_order_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order`(`inventory_replenishment_order_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_previous_oos_event_id` FOREIGN KEY (`previous_oos_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`oos_event`(`oos_event_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_reversed_adjustment_stock_adjustment_id` FOREIGN KEY (`reversed_adjustment_stock_adjustment_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_adjustment`(`stock_adjustment_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_stock_movement_id` FOREIGN KEY (`stock_movement_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`stock_movement`(`stock_movement_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ADD CONSTRAINT `fk_inventory_warehouse_parent_warehouse_id` FOREIGN KEY (`parent_warehouse_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ADD CONSTRAINT `fk_inventory_recall_lot_scope_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ADD CONSTRAINT `fk_inventory_recall_lot_scope_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `consumer_goods_ecm`.`inventory`.`recall_event`(`recall_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Vendor Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `days_inventory_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Inventory Outstanding (DIO)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_goods_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `obsolete_flag` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Risk Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `quality_inspection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `recall_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `slow_moving_flag` SET TAGS ('dbx_business_glossary_term' = 'Slow Moving Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Stock Rotation Rule');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_rotation_rule` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|manual');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_disposal|transferred|consumed');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `unrestricted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo|weighted_average');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_position` ALTER COLUMN `vmi_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Replenishment Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'active|depleted|expired|recalled|destroyed|transferred');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `gmp_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `gmp_status` SET TAGS ('dbx_value_regex' = 'certified|compliant|non_compliant|pending_review|exempt');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'released|quarantined|rejected|pending_inspection|conditionally_released');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `storage_condition_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirement');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `storage_condition_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temperature|hazmat');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Pallet Positions');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume in Cubic Meters (m³)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight in Kilograms (kg)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Location Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Level Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Count Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude Coordinate');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Operational Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|decommissioned');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|quarantine|returns|staging');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude Coordinate');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `picking_priority` SET TAGS ('dbx_business_glossary_term' = 'Picking Priority Rank');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `replenishment_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Threshold Percentage');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'FEFO|FIFO|LIFO|MANUAL');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level Classification');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|restricted|high_value|controlled_substance');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Zone Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'replenishment_operations');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `inventory_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `primary_stock_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reversed_movement_stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Movement ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_business_glossary_term' = 'Movement Category');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_value_regex' = 'goods_receipt|goods_issue|stock_transfer|return|adjustment|write_off');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_line` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Line Item');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|in_transit');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Movement Value');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_subdomain' = 'replenishment_operations');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `inventory_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Replenishment Order Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `primary_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `oos_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Prevention Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_value_regex' = 'vmi_auto|drp_planned|manual_trigger|safety_stock|emergency|seasonal');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Rule');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `rotation_rule` SET TAGS ('dbx_value_regex' = 'fefo|fifo|lifo');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_subdomain' = 'replenishment_operations');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `original_count_inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Original Count ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Adjustment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'full_physical|abc_cycle|perpetual|spot_check|blind_count');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|confirmed|posted|cancelled|recount_required');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_zone` SET TAGS ('dbx_business_glossary_term' = 'Count Zone');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_value_at_count` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value at Count');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_value_at_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'shrinkage|damage|misplacement|system_error|receiving_error|picking_error');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'replenishment_operations');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Event ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `inventory_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `previous_oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Out-of-Stock (OOS) Event ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `actual_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Demand Units');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dsd|dtc');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `demand_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Units');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'pos_system|wms|demand_sensing|manual_report|retail_execution_app|edi_feed');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Sales Value');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Units');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|resolved|under_investigation|closed');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percent');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `inventory_on_hand_at_oos` SET TAGS ('dbx_business_glossary_term' = 'Inventory On Hand at Out-of-Stock (OOS)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `next_scheduled_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Replenishment Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Duration in Hours');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_type` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_type` SET TAGS ('dbx_value_regex' = 'warehouse_stockout|shelf_stockout|phantom_inventory|system_mismatch');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `osa_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Shelf Availability (OSA) Actual Percent');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `osa_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Shelf Availability (OSA) Target Percent');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'emergency_replenishment|transfer_from_alternate_location|expedited_shipment|customer_backorder|no_action_taken|substitution_offered');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'demand_spike|replenishment_failure|forecast_miss|upstream_stockout|logistics_delay|system_error');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`oos_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` SET TAGS ('dbx_subdomain' = 'recall_compliance');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `affected_gtin_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Global Trade Item Number (GTIN) List');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `affected_product_description` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Description');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `affected_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) List');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Closure Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `consumer_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Consumer Contact Method');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `depth_of_recall` SET TAGS ('dbx_business_glossary_term' = 'Depth of Recall');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `depth_of_recall` SET TAGS ('dbx_value_regex' = 'Consumer Level|Retail Level|Wholesale Level|Distribution Center');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `expiration_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date Range End');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `expiration_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date Range Start');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `manufacturing_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range End');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `manufacturing_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date Range Start');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `public_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `quantity_distributed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Distributed');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `quantity_recalled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `quantity_recovered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recovered');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'Units|Cases|Pallets|Kilograms|Liters|Pounds');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Description');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Voluntary Withdrawal|Market Withdrawal|Stock Recovery');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Percentage');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_channel` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope Channel');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_channel` SET TAGS ('dbx_value_regex' = 'Retail|Wholesale|DTC|Food Service|Healthcare|All Channels');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_scope_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope Customer Segment');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|In Progress|Ongoing|Completed|Terminated|Closed');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_strategy` SET TAGS ('dbx_business_glossary_term' = 'Recall Strategy');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Safety|Quality|Regulatory|Labeling|Contamination|Allergen');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_event` ALTER COLUMN `root_cause_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Summary');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` SET TAGS ('dbx_subdomain' = 'replenishment_operations');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Adjustment Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `reversed_adjustment_stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Adjustment ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Value');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'physical_count|shrinkage|damage|expiry|system_reconciliation|theft');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `physical_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Quantity');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|returns');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `system_quantity_after` SET TAGS ('dbx_business_glossary_term' = 'System Quantity After Adjustment');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `system_quantity_before` SET TAGS ('dbx_business_glossary_term' = 'System Quantity Before Adjustment');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` SET TAGS ('dbx_subdomain' = 'recall_compliance');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` SET TAGS ('dbx_association_edges' = 'inventory.recall_event,inventory.lot_batch');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `recall_lot_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Lot Scope - Recall Lot Scope Id');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Lot Scope - Lot Batch Id');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Lot Scope - Recall Event Id');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `affected_lot_batch_range` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot/Batch Range');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `lot_recall_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Recall Status');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `quantity_recalled_per_lot` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled Per Lot');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `quantity_recovered_per_lot` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recovered Per Lot');
ALTER TABLE `consumer_goods_ecm`.`inventory`.`recall_lot_scope` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Recovery Date');
