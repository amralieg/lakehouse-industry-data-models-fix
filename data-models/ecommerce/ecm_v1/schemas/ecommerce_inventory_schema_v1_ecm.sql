-- Schema for Domain: inventory | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`inventory` COMMENT 'SSOT for stock positions across all warehouse nodes and virtual locations. Manages SKU-level inventory records, stock allocation, replenishment planning, safety stock, OOS tracking, FIFO/LIFO lot tracking, cycle counting, MOQ rules, DSR metrics, and real-time inventory visibility. Integrates with WMS for inventory control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique surrogate identifier for the stock position record representing a SKU at a specific warehouse node or virtual location. Primary key of this entity.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Needed to associate a primary product image with each stock position for warehouse UI and pick‑face displays, a standard e‑commerce operational requirement.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: Required for inventory dashboards to link each stock position to its product detail page, enabling real‑time UI and reporting of SKU information.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Enables PO‑level stock traceability for recall, cost allocation and supplier performance dashboards.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller who owns this inventory. Null for first-party (1P) inventory owned by the platform operator.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU whose inventory position is being tracked. Links to the product catalog master record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Provides supplier‑wise inventory health reporting and compliance checks, a core e‑commerce operational need.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the physical or virtual warehouse node (fulfillment center, dark store, 3PL facility, virtual location) where this stock position is held.',
    `atp_qty` STRING COMMENT 'Net units available for new order commitments, calculated as on_hand_qty minus reserved_qty minus quarantined_qty. The ATP quantity is the real-time sellable inventory figure exposed to the storefront and OMS for order promising.',
    `bin_location_code` STRING COMMENT 'WMS bin, slot, or storage location code within the warehouse node where this SKU is primarily slotted (e.g., A-01-03-B). Used for pick path optimization, slotting analysis, and physical inventory audits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock position record was first created in the system, typically when the SKU was first received at this warehouse node or when the node was onboarded. Audit trail field for data lineage and compliance.',
    `cycle_count_variance_qty` STRING COMMENT 'Difference between the system-recorded on-hand quantity and the physically counted quantity at the last cycle count (counted minus system). Positive = overage, negative = shrinkage. Used for inventory accuracy KPI reporting and shrinkage investigation.',
    `damaged_qty` STRING COMMENT 'Units at the node that have been identified as damaged and are unsellable in their current condition. May be eligible for liquidation, refurbishment, or disposal. Tracked for shrinkage reporting and insurance claims.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Estimated number of days the current ATP quantity will last at the current 30-day DSR before reaching zero stock. Calculated as atp_qty divided by dsr_30d. Key operational metric for replenishment urgency triage and OOS risk scoring.',
    `dsr_30d` DECIMAL(18,2) COMMENT 'Average units sold per day for this SKU at this node over the trailing 30-day window. Medium-term velocity metric used for safety stock calculation, reorder point setting, and monthly replenishment planning.',
    `dsr_7d` DECIMAL(18,2) COMMENT 'Average units sold per day for this SKU at this node over the trailing 7-day window. Short-term velocity metric used for immediate replenishment decisions and flash sale impact assessment. Recalculated nightly from order fulfillment data.',
    `dsr_90d` DECIMAL(18,2) COMMENT 'Average units sold per day for this SKU at this node over the trailing 90-day window. Long-term velocity baseline used for seasonal trend analysis, annual replenishment planning, and velocity tier classification.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the current lot/batch at this node. Applicable for perishable, pharmaceutical, or regulated goods. Drives FEFO pick sequencing and OOS-before-expiry alerts. Null for non-perishable SKUs.',
    `in_transit_qty` STRING COMMENT 'Units of the SKU currently in transit to this warehouse node from a supplier, another node, or a returns processing center. Included in future ATP projections but not in current on-hand. Tracked via Transportation Management System (TMS) shipment records.',
    `inventory_ownership_type` STRING COMMENT 'Classifies who owns the inventory: first_party (platform-owned), third_party_fba (Fulfillment By Amazon-style seller inventory held at platform warehouse), consignment, dropship (never physically held), or vendor_managed inventory (VMI). Drives cost accounting and liability treatment.. Valid values are `first_party|third_party_fba|consignment|dropship|vendor_managed`',
    `inventory_status` STRING COMMENT 'Current lifecycle status of this stock position record. Active = normal operations; quarantined = held pending quality inspection; suspended = temporarily blocked from sale; archived = historical record no longer in active use.. Valid values are `active|inactive|quarantined|suspended|archived`',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this SKU is classified as a hazardous material requiring special storage, handling, or shipping restrictions at this node. Drives WMS storage zone assignment, carrier eligibility filtering in TMS, and regulatory compliance checks.',
    `is_oos` BOOLEAN COMMENT 'Indicates whether the SKU is currently out of stock (OOS) at this node, meaning ATP quantity is zero or below safety stock threshold. Drives storefront availability suppression, OOS alerts, and replenishment escalation. Key KPI for inventory health reporting.',
    `is_serialized` BOOLEAN COMMENT 'Indicates whether individual units of this SKU are tracked by unique serial number at this node. When true, each unit has a distinct serial number record in the WMS. Relevant for high-value electronics, regulated goods, and warranty management.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count performed for this SKU at this warehouse node. Cycle counting is the primary mechanism for validating perpetual inventory accuracy. Frequency is driven by velocity tier (A-items counted more frequently).',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent inventory movement transaction (receipt, pick, transfer, adjustment) for this SKU at this node. Used to identify dormant stock, trigger dead-stock reviews, and validate real-time inventory visibility.',
    `last_received_date` DATE COMMENT 'Date of the most recent inbound goods receipt (GR) posted for this SKU at this warehouse node. Used to assess inventory freshness, identify slow-moving stock, and validate replenishment cycle adherence.',
    `location_type` STRING COMMENT 'Classifies the nature of the storage location: physical_warehouse (owned/leased FC), virtual_location (logical inventory bucket), dropship_node (supplier ships direct), store_backroom (BOPIS-enabled store), or 3pl_facility (Third-Party Logistics partner site).. Valid values are `physical_warehouse|virtual_location|dropship_node|store_backroom|3pl_facility`',
    `lot_number` STRING COMMENT 'Supplier or internal lot/batch identifier for the current stock at this node. Enables traceability for product recalls, quality investigations, and FEFO rotation. Null when lot_tracking_method is none.',
    `lot_tracking_method` STRING COMMENT 'Inventory costing and lot rotation method applied to this SKU at this node: FIFO (First In First Out), LIFO (Last In First Out), FEFO (First Expired First Out for perishables), or none (no lot tracking). Governs pick sequencing in WMS and cost-of-goods-sold (COGS) calculation in ERP.. Valid values are `fifo|lifo|fefo|none`',
    `max_stock_qty` STRING COMMENT 'Upper bound on inventory units to hold at this node for this SKU, constrained by bin capacity, working capital policy, or perishability. Replenishment orders are sized to not exceed this level. Used in min-max replenishment planning.',
    `moq` STRING COMMENT 'Minimum number of units that must be ordered per replenishment purchase order for this SKU at this node, as stipulated by the supplier contract. Constrains replenishment order sizing in the ERP procurement module.',
    `on_hand_qty` STRING COMMENT 'Total physical units of the SKU currently present at the warehouse node, regardless of reservation or allocation status. Includes allocated, quarantined, and damaged units. Source of truth from WMS cycle count or perpetual inventory.',
    `oos_since_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU first became out of stock at this node in the current OOS episode. Used to calculate OOS duration for SLA compliance, lost sales estimation, and seller performance monitoring. Null when is_oos is false.',
    `peak_dsr` DECIMAL(18,2) COMMENT 'Highest single-day sales rate observed for this SKU at this node within the trailing 90-day window. Used to size safety stock for peak demand scenarios (e.g., flash sales, holiday events) and to stress-test replenishment plans.',
    `quarantined_qty` STRING COMMENT 'Units physically present at the node but held in quarantine pending quality inspection, regulatory hold, or recall investigation. Not available for sale or fulfillment. Tracked separately for compliance and quality management reporting.',
    `reorder_point_qty` STRING COMMENT 'Inventory level at which a replenishment purchase order (PO) should be triggered for this SKU at this node. Calculated as safety_stock_qty plus demand during replenishment lead time. Drives automated replenishment in the ERP/WMS.',
    `replenishment_lead_time_days` STRING COMMENT 'Expected number of calendar days from purchase order (PO) placement to receipt of goods at this warehouse node for this SKU. Used in reorder point and safety stock calculations. Sourced from supplier SLA agreements.',
    `reserved_qty` STRING COMMENT 'Units of the SKU that have been soft-allocated to open orders or reservations but not yet physically picked. Reduces available-to-promise (ATP) quantity. Managed by the Order Management System (OMS) allocation engine.',
    `safety_stock_qty` STRING COMMENT 'Minimum buffer stock level maintained at the node to protect against demand variability and supply lead time uncertainty. When ATP quantity falls below safety stock, a replenishment alert is triggered. Calculated from DSR metrics and lead time data.',
    `seasonal_velocity_index` DECIMAL(18,2) COMMENT 'Multiplicative seasonal adjustment factor applied to the baseline DSR to account for predictable seasonal demand patterns (e.g., 1.5 = 50% above baseline in peak season, 0.7 = 30% below in off-season). Used in demand forecasting and safety stock uplift calculations.',
    `stock_condition` STRING COMMENT 'Physical or logical state of the stock at this node: on_hand (available in bin), allocated (reserved for an order), quarantined (held for QC), damaged (unsellable), in_transit (moving between nodes). Drives WMS pick eligibility and ATP calculations.. Valid values are `on_hand|allocated|quarantined|damaged|in_transit`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure in which inventory quantities for this SKU are tracked at this node (e.g., EA = each, CASE, PALLET, KG, LB, L, M). Must align with the UOM defined in the product catalog and supplier purchase orders. [ENUM-REF-CANDIDATE: EA|CASE|PALLET|KG|LB|L|M — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this stock position record, including quantity adjustments, status changes, velocity recalculations, or cycle count postings. Essential for change data capture (CDC) in the Databricks Silver Layer pipeline.',
    `velocity_recalculated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent recalculation of DSR metrics and velocity tier for this stock position record. Indicates data freshness for downstream consumers (replenishment engine, slotting optimizer, search ranking). Recalculated nightly or on-demand.',
    `velocity_tier` STRING COMMENT 'ABC/D velocity tier assigned to this SKU at this node based on Best Seller Rank (BSR) and sales volume: A = fast-moving (top ~20% by volume), B = medium-moving, C = slow-moving, D = dead stock / near-zero velocity. Drives slotting decisions, replenishment frequency, and pick path optimization in WMS.. Valid values are `A|B|C|D`',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Core master record and SSOT representing the current stock position and velocity profile for a SKU at a specific warehouse node or virtual location. Tracks on-hand quantity, reserved quantity, available-to-promise (ATP) quantity, in-transit quantity, and physical/logical inventory states (on-hand, allocated, quarantined, damaged). Includes comprehensive velocity metrics: rolling daily sales rate (DSR) at 7/30/90-day windows, velocity tier classification (A/B/C/D based on BSR and sales volume), average units sold per day, peak DSR, seasonal velocity index, and last velocity recalculation timestamp. Velocity data drives slotting decisions, replenishment frequency, and safety stock calculations. No separate velocity entity exists — stock_position is the SSOT for both inventory quantities and SKU velocity at the node level. Integrates with WMS for real-time inventory visibility across all fulfillment nodes.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique surrogate identifier for a physical or virtual storage location within a warehouse node. Primary key for this master record.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the parent warehouse node that contains this storage location. Used to scope location records to a specific fulfillment center or distribution node.',
    `accessibility_type` STRING COMMENT 'Equipment or method required to access this storage location. Determines which picking and putaway resources the WMS can assign to tasks involving this location. Automated locations are served by Automated Storage and Retrieval Systems (AS/RS).. Valid values are `manual|forklift|reach_truck|conveyor|automated`',
    `aisle_code` STRING COMMENT 'Identifier for the aisle within the warehouse zone where this location is physically situated. Used by WMS for pick-path optimization and travel-time minimization in fulfillment operations.. Valid values are `^[A-Z0-9]{1,10}$`',
    `barcode` STRING COMMENT 'Barcode value printed on the physical label affixed to this storage location. Scanned by warehouse operatives using handheld devices or fixed scanners during pick, putaway, and cycle count operations to confirm location identity.. Valid values are `^[A-Z0-9-]{4,40}$`',
    `bin_code` STRING COMMENT 'Identifier for the individual bin or slot within the shelf. The most granular physical unit of the warehouse location hierarchy. Directly maps to a scannable barcode label affixed to the physical bin in the warehouse.. Valid values are `^[A-Z0-9]{1,10}$`',
    `capacity_uom` STRING COMMENT 'Unit of measure in which the capacity of this storage location is expressed. Aligns with the WMS capacity management configuration for the warehouse node (e.g., pallets for bulk storage, units for pick-face bins, kg for weight-constrained locations).. Valid values are `units|pallets|cases|kg|cubic_meters`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse location master record was first created in the system. Provides audit trail for record provenance and supports data lineage tracking in the Databricks Silver Layer.',
    `cycle_count_frequency_days` STRING COMMENT 'Target number of days between cycle counts for this location. Drives the WMS cycle count scheduling engine. High-velocity or high-value locations typically have shorter intervals (e.g., 7 days) while low-velocity locations may be counted quarterly (e.g., 90 days).',
    `dedicated_sku` STRING COMMENT 'Stock Keeping Unit (SKU) code of the product permanently assigned to this location under a fixed slotting strategy. Null for floating or multi-SKU locations. Used by WMS to enforce single-SKU integrity and prevent mixed-SKU putaway errors.',
    `effective_from` DATE COMMENT 'Date from which this storage location record became operationally active and available for inventory allocation in the WMS. Supports bi-temporal data management and warehouse expansion tracking.',
    `effective_until` DATE COMMENT 'Date on which this storage location record ceases to be operationally active. Null for currently active locations. Used to manage decommissioned or seasonally inactive locations without hard-deleting master records.',
    `hazmat_class` STRING COMMENT 'Hazardous materials classification code assigned to this location, indicating the category of dangerous goods that may be stored here (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Null for non-hazmat locations. Governs WMS slotting restrictions and regulatory compliance for storage. [ENUM-REF-CANDIDATE: class_1_explosives|class_2_gases|class_3_flammable|class_4_flammable_solids|class_5_oxidizers|class_6_toxic|class_7_radioactive|class_8_corrosives|class_9_misc|none — promote to reference product]',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height dimension of the storage location in centimetres. Used for vertical clearance validation during slotting and for determining forklift or reach-truck accessibility requirements.',
    `is_bulk_storage` BOOLEAN COMMENT 'Indicates whether this location is designated as a bulk or reserve storage position. Bulk locations hold overstock inventory that replenishes pick face locations. Used in WMS replenishment trigger logic.',
    `is_hazmat_approved` BOOLEAN COMMENT 'Indicates whether this storage location has been certified and approved for storing hazardous materials. Drives WMS slotting rules to prevent non-approved locations from receiving hazmat inventory.',
    `is_pick_face` BOOLEAN COMMENT 'Indicates whether this location is designated as an active pick face — a forward-pick position from which pickers directly fulfil customer orders. Pick face locations are replenished from bulk storage and are optimized for pick speed and ergonomics.',
    `is_quarantine` BOOLEAN COMMENT 'Indicates whether this location is designated as a quarantine hold area. Inventory placed in quarantine locations is blocked from pick and shipment pending quality inspection, regulatory hold, or Return Merchandise Authorization (RMA) processing.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether this is a virtual (system-only) storage location with no physical counterpart in the warehouse. Virtual locations are used for in-transit inventory, damaged goods holding, or system adjustment buckets in the WMS.',
    `last_cycle_count_date` DATE COMMENT 'Date on which the most recent cycle count was performed at this storage location. Used to schedule future cycle counts, assess inventory accuracy compliance, and prioritize locations overdue for counting per the warehouse cycle count program.',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length dimension of the storage location in centimetres. Used in WMS slotting optimization to match product dimensions to available location space and to calculate volumetric utilization.',
    `level_number` STRING COMMENT 'Numeric vertical level of the storage location within the rack structure (e.g., 1 = ground level, 2 = second level). Used for ergonomic slotting rules, forklift accessibility constraints, and pick-path optimization in the WMS.',
    `location_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this storage location within the warehouse. Used by WMS for pick-pack-ship operations, barcode scanning, and slotting optimization. Typically formatted as ZONE-AISLE-RACK-SHELF-BIN (e.g., A-01-03-02-05).. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable descriptive name for the storage location, used in WMS user interfaces, slotting reports, and operational dashboards (e.g., Aisle 3 Rack B Shelf 2 Bin 5).',
    `location_status` STRING COMMENT 'Current operational lifecycle state of the storage location. Controls whether the WMS can allocate inventory to or pick from this location. blocked indicates a temporary hold (e.g., quality inspection); under_maintenance indicates physical inaccessibility.. Valid values are `active|inactive|blocked|reserved|under_maintenance`',
    `location_type` STRING COMMENT 'Functional classification of the storage location within the warehouse. Determines how the WMS uses this location in fulfillment workflows: pick_face (active picking slot), bulk_storage (reserve/overflow stock), receiving_dock (inbound goods receipt), returns_area (Return Merchandise Authorization (RMA) processing), virtual (system-only allocation node), staging (pre-shipment consolidation area).. Valid values are `pick_face|bulk_storage|receiving_dock|returns_area|virtual|staging`',
    `lot_tracking_required` BOOLEAN COMMENT 'Indicates whether inventory stored at this location must be tracked at the lot or batch level. Required for locations holding perishables, pharmaceuticals, or regulated goods where First In First Out (FIFO) / First Expired First Out (FEFO) lot traceability is mandated.',
    `max_capacity` DECIMAL(18,2) COMMENT 'Maximum storage capacity of this location expressed in the unit defined by capacity_uom. Used by WMS to enforce inventory allocation limits and prevent overstocking. Critical for slotting optimization and replenishment planning.',
    `max_fill_level` DECIMAL(18,2) COMMENT 'Maximum inventory quantity (in capacity_uom) that should be stocked at this location. Used by the WMS to cap replenishment quantities and prevent overfilling. Typically set equal to or less than max_capacity to allow for operational buffer.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable weight in kilograms that this storage location can safely bear. Enforced by WMS during inventory allocation to prevent structural overloading. Particularly relevant for high-density racking and mezzanine-level locations.',
    `min_fill_level` DECIMAL(18,2) COMMENT 'Minimum inventory quantity (in capacity_uom) that should be maintained at this location before a replenishment task is triggered. Used by the WMS replenishment engine to prevent Out of Stock (OOS) conditions at pick face locations.',
    `mixed_sku_allowed` BOOLEAN COMMENT 'Indicates whether multiple distinct Stock Keeping Units (SKUs) may be co-located in this storage position simultaneously. When false, the WMS enforces single-SKU integrity. Mixed-SKU locations are common in bulk storage but typically prohibited at pick faces to prevent picking errors.',
    `pick_sequence` STRING COMMENT 'Numeric sequence number used by the WMS to order this location within a pick path or wave. Lower numbers are visited first. Optimized to minimize picker travel distance and maximize throughput in fulfillment operations.',
    `putaway_strategy` STRING COMMENT 'Strategy used by the WMS to direct incoming inventory to this location during receiving and putaway operations. Fixed: always assigned to specific Stock Keeping Units (SKUs); floating: any compatible SKU; directed: WMS algorithm assigns; nearest_empty: proximity-based assignment.. Valid values are `fixed|floating|directed|nearest_empty`',
    `rack_code` STRING COMMENT 'Identifier for the rack or bay within the aisle where this location is physically situated. Part of the hierarchical location address used by WMS for precise inventory positioning.. Valid values are `^[A-Z0-9]{1,10}$`',
    `replenishment_strategy` STRING COMMENT 'Inventory rotation and replenishment strategy applied to this location. Governs the order in which stock is consumed and replenished: First In First Out (FIFO), Last In First Out (LIFO), First Expired First Out (FEFO) for perishables, manual (operator-directed), or none (no automated replenishment).. Valid values are `fifo|lifo|fefo|manual|none`',
    `rfid_tag` STRING COMMENT 'RFID tag identifier associated with this storage location for automated inventory tracking and real-time location visibility. Null if the location is not RFID-enabled. Supports real-time inventory visibility in RFID-equipped warehouse nodes.',
    `shelf_code` STRING COMMENT 'Identifier for the shelf level within the rack where this location is physically situated. Shelf codes are used for vertical positioning in WMS pick-path logic and ergonomic slotting (e.g., golden zone placement for high-velocity Stock Keeping Units (SKUs)).. Valid values are `^[A-Z0-9]{1,10}$`',
    `slotting_velocity_class` STRING COMMENT 'ABC/D velocity classification assigned to this location based on the throughput of Stock Keeping Units (SKUs) slotted here. Class A: highest-velocity (golden zone, ergonomic height); Class B: medium-velocity; Class C: low-velocity; Class D: very slow-moving or seasonal. Drives slotting optimization decisions.. Valid values are `A|B|C|D`',
    `temperature_zone` STRING COMMENT 'Temperature classification of the storage location, defining the environmental condition maintained at this position. Drives product-to-location compatibility rules in WMS slotting: ambient (room temperature), chilled (2–8°C), frozen (below -18°C), controlled (specific regulated range for pharmaceuticals or electronics).. Valid values are `ambient|chilled|frozen|controlled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse location master record was most recently modified. Used for change data capture (CDC) processing, incremental ETL loads, and audit compliance in the Silver Layer lakehouse.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width dimension of the storage location in centimetres. Used alongside length_cm and height_cm for volumetric capacity calculations and product-to-location fit validation in WMS slotting.',
    `zone_code` STRING COMMENT 'Identifier for the warehouse zone in which this location resides. Zones group locations by operational function, temperature requirement, or product category (e.g., DRY, COLD, HAZMAT, RETURNS). Used for slotting optimization and pick-path routing.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Master record for physical and virtual storage locations within a warehouse node, including bin, shelf, aisle, zone, and rack identifiers. Defines location type (pick face, bulk storage, receiving dock, returns area, virtual), capacity constraints, temperature zone, and hazmat classification. Used by WMS for slotting optimization and inventory allocation to specific storage positions.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`lot` (
    `lot_id` BIGINT COMMENT 'Unique identifier for the inventory lot or batch record. Primary key for the lot entity.',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: Regulatory compliance mandates attaching digital certificates (assets) to lots; linking enables automated audit reports and traceability.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Links each lot to its originating PO for audit, recall handling and accurate landed‑cost calculation.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory reporting requires each inventory lot to be linked to its primary regulation (e.g., FDA, CE) for compliance status tracking.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Enables Lot Ownership Tracking for seller‑specific batch traceability and recall management.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lot tracking must be tied to a specific SKU to enforce expiration, traceability, and compliance reporting.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who provided this lot. Links to supplier master data for procurement and quality tracking.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center where this lot is stored. Supports multi-node inventory visibility.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of units reserved for pending orders but not yet shipped. Reduces available quantity without physically moving inventory.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Current quantity of units available for allocation and order fulfillment. Updated in real-time as inventory is allocated or consumed.',
    `batch_reference` STRING COMMENT 'Supplier or manufacturer batch reference code used for cross-referencing with supplier records and quality documentation.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Landed cost per unit for this lot including purchase price, freight, duties, and handling. Used for inventory valuation and Cost of Goods Sold (COGS) calculation.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured or produced. Required for customs, trade compliance, and tariff classification.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for cost per unit. Supports multi-currency inventory valuation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count for this lot. Supports inventory accuracy and shrinkage tracking.',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'Difference between system quantity and physical count during the most recent cycle count. Positive values indicate overage, negative indicate shortage.',
    `expiry_date` DATE COMMENT 'Date when the lot expires and is no longer suitable for sale or use. Used for perishable goods, pharmaceuticals, and regulated products. Null for non-perishable items.',
    `fifo_sequence` STRING COMMENT 'Numeric sequence position for First In First Out (FIFO) allocation logic. Lower numbers are allocated first to minimize expiry risk.',
    `goods_receipt_number` STRING COMMENT 'Warehouse Management System (WMS) goods receipt document number. Links lot to receiving transaction for audit trail and discrepancy resolution.. Valid values are `^GR[0-9]{8,12}$`',
    `hold_reason` STRING COMMENT 'Explanation for why the lot is on hold or in quarantine status. Supports quality management and inventory disposition decisions.',
    `hold_release_date` DATE COMMENT 'Date when the lot was released from hold or quarantine status and made available for allocation. Null if lot is still on hold.',
    `inspection_date` DATE COMMENT 'Date when quality inspection was completed. Used for compliance documentation and quality audit trail.',
    `inspection_status` STRING COMMENT 'Result of quality inspection performed at goods receipt. Determines whether lot can be released to available inventory or must remain in quarantine.. Valid values are `pending|passed|failed|waived`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the lot record is currently active in the system. Inactive lots are retained for historical reporting but excluded from operational inventory views.',
    `lifo_sequence` STRING COMMENT 'Numeric sequence position for Last In First Out (LIFO) allocation logic. Higher numbers are allocated first for specific inventory strategies.',
    `lot_number` STRING COMMENT 'Externally-known unique identifier for the production lot or batch. Used for traceability and recall management. Typically assigned by manufacturer or supplier.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lot_status` STRING COMMENT 'Current lifecycle status of the lot. Determines whether inventory is available for allocation, under quality hold, expired, or subject to recall.. Valid values are `available|quarantine|hold|expired|recalled|depleted`',
    `lot_type` STRING COMMENT 'Classification of the lot based on handling requirements. Determines storage conditions, expiry tracking, and regulatory compliance needs.. Valid values are `standard|perishable|regulated|hazmat|serialized`',
    `manufacture_date` DATE COMMENT 'Date when the product lot was manufactured or produced. Critical for shelf-life calculation and First In First Out (FIFO) sequencing.',
    `notes` STRING COMMENT 'Free-text notes for special handling instructions, quality observations, or other relevant information about the lot.',
    `quality_grade` STRING COMMENT 'Quality classification assigned during goods receipt inspection. Determines pricing tier, allocation priority, and disposition rules.. Valid values are `A|B|C|reject`',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity of units placed on quality hold pending inspection or testing. Not available for allocation until released.',
    `recall_date` DATE COMMENT 'Date when the recall was initiated for this lot. Used for compliance reporting and customer notification timelines.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this lot is subject to a product recall. When true, inventory is blocked from allocation and recall procedures are initiated.',
    `recall_reason` STRING COMMENT 'Description of the reason for the product recall. Supports root cause analysis, customer communication, and regulatory reporting.',
    `received_date` DATE COMMENT 'Date when the lot was received into the warehouse. Marks the start of inventory availability and FIFO sequencing position.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Original quantity of units received into inventory for this lot. Baseline for calculating remaining stock and depletion rate.',
    `storage_location` STRING COMMENT 'Physical storage location code within the warehouse (aisle, rack, bin). Supports pick-pack-ship efficiency and cycle counting.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `storage_zone` STRING COMMENT 'Warehouse zone classification based on environmental or security requirements. Determines handling procedures and storage costs.. Valid values are `ambient|refrigerated|frozen|hazmat|high_value`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantity tracking. Aligns with product catalog and warehouse management system conventions. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lbs|liter|gallon — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was last modified. Supports change tracking and data quality monitoring.',
    CONSTRAINT pk_lot PRIMARY KEY(`lot_id`)
) COMMENT 'Master record for a specific production lot or batch of inventory received into the warehouse. Tracks lot number, manufacture date, expiry date, country of origin, supplier batch reference, and FIFO/LIFO sequencing position. Supports lot-level traceability for perishable goods, regulated products, and recall management. Links to goods receipt and stock position for lot-level quantity tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement audit trail.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or 3PL provider involved in the movement, applicable for inbound receipts and inter-warehouse transfers. Null for internal movements.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the inventory movement, used for internal cost allocation and profitability analysis. Particularly relevant for issue and consumption transactions.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse location, bin, or virtual location to which inventory is being moved. Null for issue transactions leaving the warehouse network or write-off transactions.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Identifier of the inbound or outbound shipment associated with this movement. Links inventory movements to transportation and logistics events for end-to-end supply chain visibility.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Add lot_id FK to lot for proper normalization; lot_number string is redundant.',
    `primary_stock_warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse location, bin, or virtual location from which inventory is being moved. Null for receipt transactions originating outside the warehouse network.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Inter‑warehouse stock movements are executed via transport routes; linking enables route efficiency reporting.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Required for Stock Movement Audit Report per seller to track inventory changes attributable to each seller.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for inventory transaction reporting; linking movement records to product SKU details (price, dimensions, compliance) is essential for audit and fulfillment.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the movement occurred. Supports multi-site inventory management and regional stock visibility.',
    `adjustment_reason_notes` STRING COMMENT 'Free-text explanation for manual adjustments, write-offs, or variance corrections. Required for audit trail completeness and regulatory compliance. Captures business context not conveyed by reason code alone.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was first created in the database. Used for audit trail and data lineage tracking. Distinct from movement_timestamp which represents the business event time.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the movement value. Supports multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `erp_document_number` STRING COMMENT 'Material document or goods movement document number generated by the ERP system (e.g., SAP material document). Used for cross-system reconciliation and audit trail.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive inventory. Used for FEFO (First Expired First Out) picking logic and automated expiry write-off processing. Null for non-perishable items.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the inventory movement value was posted. Typically inventory asset account for receipts, cost of goods sold for issues, or inventory variance account for adjustments. Null for non-financial movements.. Valid values are `^[0-9]{4,10}$`',
    `gl_posting_date` DATE COMMENT 'Accounting period date when the inventory movement value was posted to the general ledger. May differ from movement_timestamp due to period close timing. Null for non-financial movements.',
    `is_financial_impact` BOOLEAN COMMENT 'Flag indicating whether this movement has financial impact requiring general ledger posting (True) or is a non-financial movement such as location transfer within the same warehouse (False). Critical for financial reconciliation and month-end close.',
    `is_system_initiated` BOOLEAN COMMENT 'Flag indicating whether the movement was automatically triggered by system logic (True) or manually initiated by a user (False). Used to distinguish automated replenishment, allocation, and reservation movements from manual transactions.',
    `movement_number` STRING COMMENT 'Business-facing unique identifier for the stock movement transaction. Human-readable reference number used in operational systems and audit reports.. Valid values are `^[A-Z]{2,4}-[0-9]{8,12}$`',
    `movement_status` STRING COMMENT 'Current lifecycle state of the stock movement transaction. Pending = awaiting execution; In Transit = movement initiated but not yet received; Completed = movement finalized and inventory updated; Cancelled = movement voided before completion; Failed = movement attempted but rejected by system validation.. Valid values are `pending|in_transit|completed|cancelled|failed`',
    `movement_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inventory movement occurred or was recorded in the system. This is the business event timestamp used for inventory valuation and audit trail sequencing.',
    `movement_type` STRING COMMENT 'Classification of the inventory movement transaction. Receipt = inbound from supplier or production; Issue = outbound to fulfillment or consumption; Transfer = inter-location movement; Adjustment = manual correction; Return = customer or supplier return; Write-off = inventory removal due to damage, expiry, or shrinkage.. Valid values are `receipt|issue|transfer|adjustment|return|write_off`',
    `quality_status` STRING COMMENT 'Quality control status of the inventory at the time of movement. Approved = passed quality inspection and available for use; Quarantine = held for inspection or investigation; Rejected = failed quality standards; Inspection Pending = awaiting quality review. Critical for regulated industries and quality-sensitive products.. Valid values are `approved|quarantine|rejected|inspection_pending`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory units moved in this transaction. Positive for receipts and returns; negative for issues and write-offs. Supports fractional quantities for items sold by weight or volume.',
    `reason_code` STRING COMMENT 'Standardized code explaining the business reason for the inventory movement. Critical for root cause analysis of inventory variances, write-offs, and adjustments. Shrinkage = theft or loss; Damage = physical damage; Count Variance = cycle count discrepancy; System Error = ERP correction; Expiry = expired product removal; Recount = audit adjustment; Returns = RMA processing; Production Scrap = manufacturing waste. [ENUM-REF-CANDIDATE: shrinkage|damage|count_variance|system_error|expiry|recount|customer_return|supplier_return|production_scrap — 9 candidates stripped; promote to reference product]',
    `reference_document_number` STRING COMMENT 'Unique identifier of the source document (PO number, SO number, transfer order, cycle count ID, RMA number, work order) that authorized this movement. Enables drill-through to originating transaction.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `reference_document_type` STRING COMMENT 'Type of source document that triggered or authorized this stock movement. Links the movement to upstream business processes for full audit trail and traceability. [ENUM-REF-CANDIDATE: purchase_order|sales_order|transfer_order|cycle_count|rma|work_order|manual_adjustment — 7 candidates stripped; promote to reference product]',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items requiring unit-level tracking (electronics, high-value goods, regulated products). Null for non-serialized items.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `total_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory movement (quantity × unit cost). Used for general ledger posting, inventory asset reconciliation, and SOX-compliant financial reporting. Positive for receipts; negative for issues and write-offs.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Per-unit inventory cost at the time of movement, used for inventory valuation and financial reconciliation. Reflects weighted average cost, FIFO cost, or standard cost depending on accounting policy.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the movement quantity. Each = individual item; Case = manufacturer case pack; Pallet = full pallet quantity; Weight and volume units for bulk items. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was last modified. Used for audit trail, change tracking, and data synchronization. Null if record has never been updated after initial creation.',
    `wms_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source Warehouse Management System. Enables reconciliation between WMS and ERP inventory records and supports end-to-end audit trail.. Valid values are `^[A-Z0-9-]{10,30}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record and sole audit trail capturing every inventory movement and adjustment event including receipts, issues, transfers, manual corrections, cycle count variances, returns, write-offs, and system-initiated adjustments. Records movement type, source and destination location, quantity moved, unit of measure, movement reason code (shrinkage, damage, count variance, system error, expiry write-off, recount adjustment), reference document (PO, RMA, transfer order, cycle count, investigation), operator ID, authorizing user for adjustments, adjusted quantity (positive or negative), adjusted value for financial reconciliation, and financial impact. Serves as the SSOT for all inventory change audit trails including both automated movements and manual corrections requiring authorization. Feeds replenishment triggers, DSR calculations, inventory write-off reconciliation, and SOX-compliant financial reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` (
    `stock_allocation_id` BIGINT COMMENT 'Unique identifier for the stock allocation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocation charge‑back report requires each stock allocation to be charged to a cost center for internal expense tracking.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer for whom this inventory is allocated. Enables customer-specific allocation rules and analytics.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Required for the Fulfillment Order creation process that reserves inventory for each order line, enabling real‑time allocation tracking.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment that will fulfill this allocation. Links allocation to outbound logistics.',
    `line_id` BIGINT COMMENT 'Reference to the specific order line item that this allocation fulfills. Enables line-level allocation tracking.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Add lot_id FK to lot for proper normalization; lot_number string is redundant.',
    `pick_wave_id` BIGINT COMMENT 'Identifier of the pick wave or batch to which this allocation has been assigned. Supports wave-based fulfillment optimization.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Allocation engine needs SKU attributes (weight, hazardous flag) to calculate pick plans and reserve inventory accurately.',
    `transfer_order_id` BIGINT COMMENT 'Reference to an inter-warehouse transfer order if this allocation is for inventory movement between facilities.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center from which inventory is allocated.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory reserved for this allocation. Reduces Available-to-Promise (ATP) and prevents overselling.',
    `allocation_notes` STRING COMMENT 'Free-text notes or special instructions related to this allocation. Captures operational context and exceptions.',
    `allocation_reason_code` STRING COMMENT 'Coded reason for the allocation or any special handling requirements. Examples: STANDARD, EXPEDITED, REPLACEMENT, SAMPLE.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `allocation_source` STRING COMMENT 'The system or process that originated this allocation. Distinguishes automated allocations from manual interventions.. Valid values are `order_management|manual|replenishment|pre-order|backorder`',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the allocation. Tracks progression from reservation through fulfillment or cancellation. [ENUM-REF-CANDIDATE: pending|confirmed|picked|packed|shipped|cancelled|expired|released — 8 candidates stripped; promote to reference product]',
    `allocation_timestamp` TIMESTAMP COMMENT 'The date and time when the inventory was allocated to this demand. Represents the business event time of reservation.',
    `allocation_type` STRING COMMENT 'Classification of the allocation commitment. Hard allocation is firm and reduces ATP; soft allocation is tentative and may be released; pre-allocation reserves inventory before order confirmation; reservation holds inventory for future demand.. Valid values are `hard|soft|pre-allocation|reservation`',
    `cancellation_reason` STRING COMMENT 'Explanation for why the allocation was cancelled. Examples: customer cancellation, inventory unavailable, order modification, fraud.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was cancelled. Null if allocation was not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was first created in the system. Audit trail for record creation.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation expires if not fulfilled. After expiry, the allocation may be automatically released back to ATP.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether this allocation is on hold and cannot proceed to fulfillment. True if held, False otherwise.',
    `hold_reason` STRING COMMENT 'Explanation for why the allocation is on hold. Examples: payment pending, fraud review, inventory quality check, customer request.',
    `inventory_condition` STRING COMMENT 'Physical condition of the allocated inventory. Supports allocation rules that prioritize new stock over returned or refurbished items.. Valid values are `new|refurbished|used|damaged|returned`',
    `packed_timestamp` TIMESTAMP COMMENT 'The date and time when the picked inventory was packed for shipment. Tracks fulfillment milestone.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The quantity that has been physically picked from the warehouse location. Tracks fulfillment progress.',
    `picked_timestamp` TIMESTAMP COMMENT 'The date and time when the allocated inventory was picked. Marks transition from allocated to in-fulfillment state.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for this allocation. Higher priority allocations are fulfilled first. Supports SLA-based fulfillment sequencing.',
    `released_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory released from this allocation back to ATP. May differ from allocated quantity if partial fulfillment occurred.',
    `released_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was released back to ATP. Null if allocation is still active.',
    `shipped_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was shipped to the customer. Marks completion of the allocation lifecycle.',
    `unit_of_measure` STRING COMMENT 'The unit in which the allocated quantity is expressed (e.g., each, case, pallet, kg). Aligns with inventory tracking standards. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was last modified. Audit trail for record changes.',
    `warehouse_location_code` STRING COMMENT 'Specific bin, aisle, or zone within the warehouse where the allocated inventory resides. Supports pick-path optimization.. Valid values are `^[A-Z0-9]{2,15}$`',
    CONSTRAINT pk_stock_allocation PRIMARY KEY(`stock_allocation_id`)
) COMMENT 'Transactional record linking a specific quantity of inventory to a fulfillment demand (order line, reservation, or pre-allocation). Tracks allocated SKU, warehouse location, lot, allocated quantity, allocation type (hard/soft), allocation status, expiry timestamp, and the originating order or transfer reference. Ensures ATP accuracy and prevents overselling by managing the reserved inventory pool.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders are expense items; they must be booked against a cost center for budgeting and P&L reporting.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Supports replenishment planning per seller to maintain stock levels for each sellers catalog.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Replenishment rules rely on SKU master data (lead time, safety stock) to generate purchase orders; FK provides that linkage.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor from whom the inventory is being procured for replenishment.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center node where inventory is being replenished.',
    `actual_receipt_date` DATE COMMENT 'The actual date when the replenishment inventory was received at the warehouse. Null until receipt is confirmed.',
    `approval_status` STRING COMMENT 'The approval workflow status for this replenishment order. High-value orders may require manager or procurement approval before submission.. Valid values are `pending|approved|rejected|not_required`',
    `approved_by` STRING COMMENT 'The name or identifier of the user who approved this replenishment order for submission to the supplier.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment order was approved for submission.',
    `cancellation_reason` STRING COMMENT 'The reason why this replenishment order was cancelled, if applicable. Null for non-cancelled orders.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment order was cancelled. Null for non-cancelled orders.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_stock_level` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity at the warehouse node at the time this replenishment order was created.',
    `dsr` DECIMAL(18,2) COMMENT 'The average daily sales rate for this SKU at the time the replenishment order was created, used in demand forecasting and order quantity calculation.',
    `expected_receipt_date` DATE COMMENT 'The anticipated date when the replenishment inventory will arrive at the warehouse, calculated from order date plus lead time.',
    `forecast_demand` DECIMAL(18,2) COMMENT 'The projected demand for this SKU over the lead time period, used by the inventory planning engine to calculate optimal order quantity.',
    `lead_time_days` STRING COMMENT 'The expected number of days from order submission to receipt at the warehouse, based on supplier lead time and transportation time.',
    `lot_tracking_required` BOOLEAN COMMENT 'Indicates whether this SKU requires lot or batch tracking for FIFO/LIFO inventory management, expiration date tracking, or recall management.',
    `modified_by` STRING COMMENT 'The name or identifier of the user or system process that last modified this replenishment order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment order record was last modified.',
    `moq` DECIMAL(18,2) COMMENT 'The Minimum Order Quantity constraint imposed by the supplier for this SKU. The order quantity must meet or exceed this threshold.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or context related to this replenishment order.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU requested in this replenishment order, calculated by the inventory planning engine or entered manually by the planner.',
    `priority_level` STRING COMMENT 'The urgency classification of this replenishment order, used to prioritize processing and expedite shipments when necessary.. Valid values are `low|normal|high|urgent|critical`',
    `purchase_order_number` STRING COMMENT 'The Purchase Order number generated in the ERP system when this replenishment order is approved and submitted to the supplier.. Valid values are `^PO-[0-9]{8,12}$`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity received at the warehouse. May differ from order quantity due to partial shipments or supplier shortages.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level threshold that triggered this replenishment order. When on-hand inventory falls below this point, replenishment is initiated.',
    `replenishment_method` STRING COMMENT 'The inventory replenishment strategy applied for this SKU: fixed order quantity, fixed period review, min-max, Economic Order Quantity (EOQ), or Just-In-Time (JIT).. Valid values are `fixed_order_quantity|fixed_period|min_max|economic_order_quantity|just_in_time`',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique identifier for the replenishment order, used for tracking and reference in procurement and warehouse operations.. Valid values are `^RO-[0-9]{8,12}$`',
    `replenishment_status` STRING COMMENT 'Current lifecycle status of the replenishment order in the procurement and receiving workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|submitted|in_transit|partially_received|received|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `replenishment_type` STRING COMMENT 'Classification of the replenishment order based on trigger mechanism: automatic (system-generated based on reorder point), manual (planner-initiated), emergency (urgent stockout prevention), seasonal (planned for seasonal demand), promotional (campaign-driven), or transfer (inter-warehouse movement).. Valid values are `automatic|manual|emergency|seasonal|promotional|transfer`',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'The buffer inventory level maintained to protect against demand variability and supply uncertainty. Used in replenishment calculations.',
    `source_system` STRING COMMENT 'The originating system that created this replenishment order: WMS (Warehouse Management System), ERP (Enterprise Resource Planning), IPS (Inventory Planning System), or MANUAL (user-initiated).. Valid values are `WMS|ERP|IPS|MANUAL`',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment order was submitted to the supplier or converted to a Purchase Order in the ERP system.',
    `total_order_cost` DECIMAL(18,2) COMMENT 'The total cost of this replenishment order, calculated as order quantity multiplied by unit cost, before taxes and fees.',
    `trigger_event` STRING COMMENT 'The business event or condition that initiated the creation of this replenishment order. [ENUM-REF-CANDIDATE: reorder_point_breach|safety_stock_breach|forecast_demand|manual_request|promotional_campaign|stockout_alert|scheduled_replenishment — 7 candidates stripped; promote to reference product]',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit for the SKU as per the supplier contract or purchase agreement. Used for total order cost calculation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the order quantity (EA=Each, CS=Case, PL=Pallet, BX=Box, KG=Kilogram, LB=Pound, LT=Liter, GL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between ordered quantity and received quantity. Positive indicates over-shipment, negative indicates shortage.',
    `created_by` STRING COMMENT 'The name or identifier of the user or system process that created this replenishment order record.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Transactional record representing a replenishment request or purchase order trigger generated by the inventory planning engine to restock a SKU at a warehouse node. Captures reorder point breach, suggested order quantity, MOQ constraints, lead time, supplier reference, replenishment type (automatic/manual), approval status, and expected receipt date. Integrates with procurement and ERP for PO creation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` (
    `inventory_goods_receipt_id` BIGINT COMMENT 'Unique identifier for the inventory goods receipt transaction. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Goods receipt audit and inbound logistics cost analysis need a direct carrier FK.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this inbound shipment.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Enables goods receipt reconciliation per seller for payment accuracy and inventory integrity.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped this inventory.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the destination warehouse node where goods were received.',
    `accepted_unit_count` STRING COMMENT 'Total number of units that passed quality inspection and were accepted into inventory.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the warehouse dock or receiving area.',
    `asn_reference_number` STRING COMMENT 'Reference number from the suppliers Advanced Shipping Notice that pre-notified this inbound shipment.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number provided by the carrier as proof of shipment and receipt.',
    `container_count` STRING COMMENT 'Number of shipping containers, pallets, or packages included in this receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the receipt cost amounts.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether any discrepancies were found between expected and actual received quantities or conditions.',
    `discrepancy_notes` STRING COMMENT 'Detailed notes describing any discrepancies, damages, shortages, or overages identified during receiving.',
    `dock_door_number` STRING COMMENT 'Specific dock door or bay number where the shipment was received at the warehouse.',
    `expected_arrival_date` DATE COMMENT 'Planned or estimated date when the shipment is expected to arrive at the destination warehouse.',
    `expected_unit_count` STRING COMMENT 'Total number of units that were expected to be received based on the purchase order or ASN.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation and freight charges associated with this inbound shipment.',
    `inspection_completion_timestamp` TIMESTAMP COMMENT 'Date and time when quality inspection was completed for this receipt.',
    `inspector_name` STRING COMMENT 'Name of the warehouse personnel or quality inspector who performed the receiving inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this goods receipt record was last updated or modified.',
    `lot_number` STRING COMMENT 'Manufacturer or supplier lot number for traceability and FIFO/LIFO inventory management.',
    `origin_location` STRING COMMENT 'Geographic location or facility from which the shipment originated (supplier warehouse, manufacturing plant, or distribution center).',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all received goods were moved from the receiving area to their designated storage locations.',
    `quality_inspection_status` STRING COMMENT 'Status of the quality inspection process for this goods receipt. Determines whether goods can be released to inventory.. Valid values are `pending|passed|failed|partial|not_required`',
    `receipt_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the receiving process was completed and all items were accounted for.',
    `receipt_number` STRING COMMENT 'Externally-known unique business identifier for this goods receipt transaction. Used for tracking and reference across systems.. Valid values are `^GR[0-9]{10}$`',
    `receipt_start_timestamp` TIMESTAMP COMMENT 'Date and time when warehouse personnel began the physical receiving process (unloading and inspection).',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt process. Tracks progression from shipment notification through final putaway completion. [ENUM-REF-CANDIDATE: in_transit|arrived|at_dock|receiving|putaway|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `receiving_notes` STRING COMMENT 'General notes or comments recorded by receiving personnel during the goods receipt process.',
    `recorded_temperature` DECIMAL(18,2) COMMENT 'Temperature recorded upon receipt for temperature-sensitive shipments, measured in degrees Celsius.',
    `rejected_unit_count` STRING COMMENT 'Total number of units that failed quality inspection and were rejected or quarantined.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the container seal was intact upon arrival, confirming no tampering occurred during transit.',
    `seal_number` STRING COMMENT 'Security seal number applied to the shipping container, verified upon receipt to ensure shipment integrity.',
    `shipment_type` STRING COMMENT 'Classification of the inbound shipment format. Determines handling and receiving procedures.. Valid values are `full_container|parcel|pallet|bulk`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this shipment required temperature-controlled handling (refrigerated or frozen goods).',
    `total_receipt_cost` DECIMAL(18,2) COMMENT 'Total landed cost of all goods received in this transaction, including unit costs and any applicable freight or handling charges.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs included in this goods receipt.',
    `total_unit_count` STRING COMMENT 'Total number of individual units (eaches) received across all SKUs in this shipment.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for end-to-end shipment visibility.',
    CONSTRAINT pk_inventory_goods_receipt PRIMARY KEY(`inventory_goods_receipt_id`)
) COMMENT 'Transactional record and SSOT for the complete inbound inventory lifecycle from supplier shipment notification through physical receipt and putaway at a warehouse node. Tracks the full inbound shipment journey including ASN (Advanced Shipping Notice) reference, carrier, tracking number, origin location, destination warehouse node, shipment status (in-transit, arrived, at-dock, receiving, putaway, closed), expected and actual arrival dates, PO reference, supplier, total SKU count, total unit count, received SKU detail, lot number, received quantity, accepted quantity, rejected quantity, unit cost, receipt date, dock door, quality inspection status, and discrepancy flags. Supports both full-container and parcel-level inbound tracking. Triggers stock position updates and lot creation in the WMS upon confirmation. Bridges procurement and inventory receiving workflows for complete inbound visibility from shipment to shelf.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count task. Primary key for the cycle count record.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) being counted. Links to product master data.',
    `warehouse_location_id` BIGINT COMMENT 'Specific storage location or bin within the warehouse being counted. Links to location master data.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse where the cycle count is performed. Links to the warehouse master data.',
    `zone_id` BIGINT COMMENT 'Warehouse zone or area being counted. Used for zone-based cycle counting programs.',
    `abc_classification` STRING COMMENT 'ABC classification of the SKU (Stock Keeping Unit) being counted: A (high-value, frequent count), B (medium-value, moderate count), C (low-value, infrequent count). Drives cycle count frequency.. Valid values are `A|B|C`',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count task was completed. Used to calculate count duration and productivity metrics.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count task actually began. Used to track SLA (Service Level Agreement) compliance and operational efficiency.',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment has been posted to the WMS (Warehouse Management System) and ERP (Enterprise Resource Planning) systems. True if posted, false if pending.',
    `adjustment_posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory adjustment was posted to the system of record. Used for financial reconciliation and audit trail.',
    `approval_status` STRING COMMENT 'Approval status of the cycle count results: pending (awaiting review), approved (variance accepted), or rejected (count disputed).. Valid values are `pending|approved|rejected`',
    `approved_by_user_code` BIGINT COMMENT 'Identifier of the supervisor or manager who approved the cycle count results. Links to employee master data.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count results were approved. Used for audit trail and compliance reporting.',
    `assigned_counter_name` STRING COMMENT 'Name of the warehouse employee assigned to perform the cycle count. Used for reporting and accountability.',
    `assigned_counter_user_code` BIGINT COMMENT 'Identifier of the warehouse employee assigned to perform the cycle count. Links to employee master data.',
    `count_duration_minutes` STRING COMMENT 'Total time in minutes taken to complete the cycle count task. Calculated from actual start and end timestamps. Used for productivity analysis.',
    `count_method` STRING COMMENT 'Method used to perform the physical count: manual (visual count), rfid (radio frequency identification), barcode_scan (handheld scanner), or automated (system-driven).. Valid values are `manual|rfid|barcode_scan|automated`',
    `count_number` STRING COMMENT 'Business identifier for the cycle count task. Human-readable reference number used in WMS and reporting.. Valid values are `^CC-[0-9]{8}-[0-9]{4}$`',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count task: scheduled (planned), assigned (allocated to counter), in_progress (counting underway), completed (count finished), reconciled (variance resolved), or cancelled.. Valid values are `scheduled|assigned|in_progress|completed|reconciled|cancelled`',
    `count_type` STRING COMMENT 'Type of cycle count being performed: full (complete inventory), partial (sample), abc (frequency-based), blind (no expected quantity shown), or spot (random verification).. Valid values are `full|partial|abc|blind|spot`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Actual physical quantity counted by the warehouse employee. This is the observed inventory level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was first created in the system. Used for audit trail and data lineage.',
    `expected_quantity` DECIMAL(18,2) COMMENT 'System-recorded quantity expected to be found during the count. Sourced from WMS (Warehouse Management System) inventory records.',
    `inventory_value_variance` DECIMAL(18,2) COMMENT 'Financial impact of the variance calculated as variance quantity multiplied by unit cost. Used for financial reporting and shrinkage analysis.',
    `lot_number` STRING COMMENT 'Lot or batch number of the inventory being counted. Used for FIFO (First In First Out) / LIFO (Last In First Out) tracking and traceability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was last modified. Used for audit trail and change tracking.',
    `priority_level` STRING COMMENT 'Priority level assigned to the cycle count task: critical (immediate attention), high (urgent), medium (standard), or low (routine). Used for task scheduling and resource allocation.. Valid values are `critical|high|medium|low`',
    `recount_number` STRING COMMENT 'Sequential number indicating which recount attempt this is (1 for first recount, 2 for second, etc.). Zero if no recount performed.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount is required due to variance exceeding tolerance threshold. True if recount needed, false otherwise.',
    `scheduled_date` DATE COMMENT 'Date when the cycle count task is scheduled to be performed. Used for planning and resource allocation.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when the cycle count task is scheduled to begin. Used for shift planning and resource scheduling.',
    `serial_number` STRING COMMENT 'Serial number of the specific item being counted. Used for serialized inventory tracking and warranty management.',
    `unit_of_measure` STRING COMMENT 'Unit in which the count is recorded: EA (each), CS (case), PL (pallet), BX (box), KG (kilogram), LB (pound). Aligns with SKU (Stock Keeping Unit) base unit.. Valid values are `EA|CS|PL|BX|KG|LB`',
    `variance_notes` STRING COMMENT 'Free-text notes explaining the variance, corrective actions taken, or additional context. Used for root cause analysis and continuous improvement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of expected quantity. Used to assess inventory accuracy and trigger investigation thresholds.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between expected and counted quantities (counted minus expected). Positive indicates overage, negative indicates shortage.',
    `variance_reason_code` STRING COMMENT 'Categorized reason for inventory variance: damaged (product damage), theft (shrinkage), miscount (counting error), system_error (WMS issue), receiving_error (inbound error), picking_error (outbound error), or other. [ENUM-REF-CANDIDATE: damaged|theft|miscount|system_error|receiving_error|picking_error|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Transactional record for a scheduled or ad-hoc physical inventory count task at a specific warehouse location or zone. Tracks count date, assigned counter, location or zone scope, count method (full/partial/ABC), expected quantity, counted quantity, variance quantity, variance percentage, count status (scheduled, in-progress, completed, reconciled), and approval status. Supports WMS cycle counting programs and inventory accuracy KPIs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the inventory adjustment transaction. Primary key.',
    `cycle_count_id` BIGINT COMMENT 'Reference to the originating cycle count event that triggered this adjustment, if applicable. Supports traceability from physical count to financial reconciliation.',
    `investigation_id` BIGINT COMMENT 'Reference to the inventory discrepancy investigation or loss prevention case that resulted in this adjustment. Links to root cause analysis workflows.',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment transaction being reversed, if this record is a reversal. Maintains audit trail for corrections.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center where the inventory adjustment occurred.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'The net quantity change applied to inventory. Positive values indicate additions to stock; negative values indicate reductions. Measured in the SKUs unit of measure (UOM).',
    `adjusted_value` DECIMAL(18,2) COMMENT 'The total financial value of the adjustment, calculated as adjusted_quantity × unit_cost. Represents the General Ledger (GL) impact for inventory write-offs or additions.',
    `adjustment_number` STRING COMMENT 'Human-readable business identifier for the adjustment transaction, typically formatted as ADJ-YYYYMMDD-NNNN for external reference and audit trail.. Valid values are `^ADJ-[0-9]{8,12}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle state of the adjustment transaction. Controls whether the adjustment has been applied to inventory balances and financial ledgers.. Valid values are `draft|pending_approval|approved|posted|rejected|reversed`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The date and time when the physical or system adjustment event occurred. Distinct from record creation timestamp; represents the real-world business event time.',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment reason. Determines financial treatment and operational follow-up actions. [ENUM-REF-CANDIDATE: shrinkage|damage|count_variance|system_error|expiry_write_off|return_to_stock|transfer_correction|theft|obsolescence — 9 candidates stripped; promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the adjustment was formally approved by an authorized user. Marks the transition to posted status.',
    `authorized_by_user_code` BIGINT COMMENT 'Identifier of the user who approved and authorized the adjustment. Required for segregation of duties and audit compliance.',
    `cost_center_code` STRING COMMENT 'The cost center responsible for the inventory adjustment. Used for internal financial reporting and variance accountability.. Valid values are `^CC-[A-Z0-9]{4,8}$`',
    `created_by_user_code` BIGINT COMMENT 'Identifier of the user who initiated or recorded the adjustment transaction in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjusted value. Supports multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `external_reference_number` STRING COMMENT 'Optional reference to an external document or transaction ID, such as a Return Merchandise Authorization (RMA) number, supplier claim, or insurance case number.',
    `gl_account_code` STRING COMMENT 'The GL account number to which the inventory adjustment value was posted. Typically an inventory shrinkage or write-off account.. Valid values are `^[0-9]{4,10}$`',
    `gl_posting_date` DATE COMMENT 'The accounting period date when the adjustment was posted to the General Ledger. May differ from adjustment_timestamp due to period-end cutoffs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was last updated. Supports change tracking and audit compliance.',
    `location_code` STRING COMMENT 'Specific bin, aisle, or zone code within the warehouse where the adjustment was recorded. Supports granular inventory tracking per Warehouse Management System (WMS) location hierarchy.. Valid values are `^[A-Z0-9]{2,10}(-[A-Z0-9]{2,6}){0,3}$`',
    `lot_number` STRING COMMENT 'Batch or lot identifier for inventory tracking under First In First Out (FIFO) or Last In First Out (LIFO) methodologies. Critical for expiry management and recall traceability.. Valid values are `^LOT-[A-Z0-9]{6,20}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, investigation findings, or operational details related to the adjustment. Supports audit and compliance documentation.',
    `posted_to_gl_flag` BOOLEAN COMMENT 'Indicates whether the adjustment has been posted to the financial General Ledger. True when the financial impact has been recorded in the ERP system.',
    `quantity_after_adjustment` DECIMAL(18,2) COMMENT 'The resulting on-hand inventory quantity after the adjustment is applied. Calculated as quantity_before_adjustment + adjusted_quantity.',
    `quantity_before_adjustment` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity recorded in the system immediately prior to the adjustment. Provides audit trail for variance analysis.',
    `reason_code` STRING COMMENT 'Detailed reason code providing granular classification for the adjustment. Used for root cause analysis and loss prevention reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{2,4}$`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previously posted adjustment. True when correcting an erroneous prior adjustment.',
    `sku` STRING COMMENT 'The unique product identifier for which inventory is being adjusted. Links to the product catalog for item-level traceability.. Valid values are `^[A-Z0-9]{8,20}$`',
    `source_system` STRING COMMENT 'The originating system or interface that created the adjustment record. Supports data lineage and integration troubleshooting.. Valid values are `WMS|ERP|manual_entry|cycle_count_app|mobile_scanner`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The per-unit cost of the SKU at the time of adjustment, used to calculate the financial impact. Sourced from the Enterprise Resource Planning (ERP) systems inventory valuation layer.',
    `unit_of_measure` STRING COMMENT 'The unit in which the adjusted quantity is expressed. Must align with the SKUs base UOM in the Product Information Management (PIM) system. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Transactional record documenting a manual or system-initiated correction to stock quantity or value at a specific location and lot. Captures adjustment reason (shrinkage, damage, count variance, system error, expiry write-off), adjusted quantity (positive or negative), adjusted value, authorizing user, and reference to the originating cycle count or investigation. Provides the financial reconciliation trail for inventory write-offs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`transfer_order` (
    `transfer_order_id` BIGINT COMMENT 'Unique identifier for the transfer order. Primary key for the transfer order entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier handling the transfer shipment. Links to carrier master data for tracking and performance analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inter‑warehouse transfer expenses are allocated to a cost center for internal charge‑back and profitability reporting.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center to which inventory is being transferred.',
    `primary_transfer_warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center from which inventory is being transferred.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Transfer orders use defined logistics routes; FK supports route planning, cost allocation, and SLA tracking.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Needed for Transfer Order Ownership Report, attributing inter‑warehouse transfers to the responsible seller.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Transfer orders move inventory of a particular SKU between warehouses; FK enables validation of SKU attributes and regulatory flags.',
    `approved_by_user_code` BIGINT COMMENT 'Identifier of the user who approved the transfer order. Nullable until approval is granted. Used for authorization audit trail.',
    `approved_date` DATE COMMENT 'Date when the transfer order was approved by inventory management or warehouse operations. Nullable for orders not yet approved.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the transfer order was cancelled. Nullable for non-cancelled orders. Used for process improvement analysis.',
    `cancelled_by_user_code` BIGINT COMMENT 'Identifier of the user who cancelled the transfer order. Nullable for non-cancelled orders. Used for exception tracking and audit.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order was closed after successful receipt and reconciliation. Nullable until order is closed. Used for cycle time analysis.',
    `created_by_user_code` BIGINT COMMENT 'Identifier of the user or system that created the transfer order. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order record was first created in the system. Used for audit trail and order age analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for freight cost. Enables multi-currency transfer cost tracking.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Specific bin, aisle, or zone location within the destination warehouse where inventory will be stored. Used for putaway planning.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `expected_delivery_date` DATE COMMENT 'Estimated date when the transfer shipment will arrive at the destination warehouse. Used for receiving planning and inventory availability forecasting.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost for the transfer shipment in the companys base currency. Used for transfer cost allocation and network optimization analysis.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity currently in transit between warehouses. Used for real-time inventory visibility and available-to-promise calculations.',
    `is_cross_dock` BOOLEAN COMMENT 'Flag indicating whether this transfer bypasses storage and goes directly to outbound shipping. Used for fast-moving inventory optimization.',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether the transferred inventory contains hazardous materials requiring special handling and compliance documentation.',
    `lot_number` STRING COMMENT 'Lot or batch identifier for inventory tracking. Used for FIFO/LIFO inventory management and traceability.. Valid values are `^LOT-[A-Z0-9]{6,15}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order record was last modified. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text notes or special instructions for the transfer order. Captures handling requirements, quality concerns, or operational exceptions.',
    `picked_date` DATE COMMENT 'Date when inventory was picked from source warehouse location. Nullable until picking is completed.',
    `priority_level` STRING COMMENT 'Priority classification for processing the transfer order. Determines sequencing in warehouse pick queues and carrier selection.. Valid values are `low|normal|high|urgent|critical`',
    `reason_code` STRING COMMENT 'Detailed reason code for the transfer. Provides granular classification for transfer analytics and root cause analysis. [ENUM-REF-CANDIDATE: stock_out|demand_spike|seasonal_prep|excess_inventory|product_recall|damage|expiry|network_optimization — 8 candidates stripped; promote to reference product]',
    `received_date` DATE COMMENT 'Date when inventory was received and checked in at the destination warehouse. Nullable until receipt is completed.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received at destination warehouse. May differ from transfer quantity due to damage, loss, or discrepancies.',
    `requested_date` DATE COMMENT 'Date by which the transfer is requested to be completed. Used for replenishment planning and fulfillment network optimization.',
    `shipment_method` STRING COMMENT 'Transportation mode used for the transfer. Determines transit time and cost for network optimization.. Valid values are `ground|air|ocean|rail|intermodal|courier`',
    `shipped_date` DATE COMMENT 'Date when the transfer shipment departed the source warehouse. Used for in-transit inventory tracking and SLA monitoring.',
    `source_location_code` STRING COMMENT 'Specific bin, aisle, or zone location within the source warehouse from which inventory is picked. Enables precise inventory tracking.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `temperature_controlled` BOOLEAN COMMENT 'Flag indicating whether the transfer requires temperature-controlled transportation. Used for cold chain compliance and carrier selection.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for the transfer shipment. Used for real-time shipment visibility and exception management.. Valid values are `^[A-Z0-9]{10,30}$`',
    `transfer_order_number` STRING COMMENT 'Externally-visible business identifier for the transfer order. Human-readable reference number used in warehouse operations and tracking systems.. Valid values are `^TO-[0-9]{8,12}$`',
    `transfer_quantity` DECIMAL(18,2) COMMENT 'Quantity of units being transferred from source to destination warehouse. Measured in the SKUs base unit of measure.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the transfer order. Tracks the order through warehouse operations from creation to completion. [ENUM-REF-CANDIDATE: created|approved|picked|packed|shipped|in_transit|received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer order purpose. Indicates the business reason for the inter-warehouse movement.. Valid values are `replenishment|rebalancing|returns_processing|consolidation|emergency|seasonal`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the transfer quantity. Defines how the transferred inventory is counted and tracked.. Valid values are `each|case|pallet|box|unit`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between transfer quantity and received quantity. Positive indicates overage, negative indicates shortage. Used for inventory reconciliation.',
    CONSTRAINT pk_transfer_order PRIMARY KEY(`transfer_order_id`)
) COMMENT 'Transactional record managing the inter-warehouse or inter-location movement of inventory. Captures source warehouse, destination warehouse, SKU, lot, transfer quantity, transfer type (replenishment, rebalancing, returns processing), requested date, confirmed ship date, in-transit quantity, and transfer status (created, picked, shipped, received, closed). Supports multi-node inventory rebalancing and fulfillment network optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`oos_event` (
    `oos_event_id` BIGINT COMMENT 'Unique identifier for the out-of-stock event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Out‑of‑stock events generate cost impact; linking to a cost center enables OOS cost attribution in financial analysis.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Out‑of‑stock events may stem from compliance‑driven supply constraints; linking supports the Compliance‑Driven OOS analysis report.',
    `replenishment_order_id` BIGINT COMMENT 'Identifier of the purchase order or replenishment order created to resolve this OOS event.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Out‑of‑stock analysis requires SKU master data to calculate lost revenue, safety‑stock impact, and demand forecasts.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier responsible for replenishing this SKU, relevant for root cause analysis when supplier stockout is the cause.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center where the OOS event occurred.',
    `actual_replenishment_days` STRING COMMENT 'The actual number of days it took to replenish inventory and resolve the OOS event, measured from OOS start to end.',
    `affected_order_count` STRING COMMENT 'Number of customer orders that were impacted, cancelled, or could not be fulfilled due to this OOS event.',
    `assigned_to` STRING COMMENT 'Name or identifier of the team member or role responsible for managing and resolving this OOS event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this OOS event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated lost revenue amount.. Valid values are `^[A-Z]{3}$`',
    `customer_impact_score` DECIMAL(18,2) COMMENT 'Calculated score representing the severity of customer experience impact from this OOS event, based on affected orders, customer tier, and product importance.',
    `demand_spike_factor` DECIMAL(18,2) COMMENT 'Multiplier representing how much actual demand exceeded forecasted demand during the OOS event (e.g., 2.5 means demand was 250% of forecast).',
    `detected_by` STRING COMMENT 'The source or method by which the OOS event was detected (automated system, manual audit, customer complaint, warehouse staff, demand planner).. Valid values are `automated_system|manual_audit|customer_complaint|warehouse_staff|demand_planner`',
    `dsr_at_oos` DECIMAL(18,2) COMMENT 'The average daily sales rate for this SKU at this location calculated at the time the OOS event occurred, used for replenishment velocity planning.',
    `estimated_lost_revenue` DECIMAL(18,2) COMMENT 'Calculated estimate of revenue lost due to the OOS event based on historical sales velocity and average selling price.',
    `forecast_accuracy_pct` DECIMAL(18,2) COMMENT 'The demand forecast accuracy percentage for this SKU in the period leading up to the OOS event, used to assess forecast miss as root cause.',
    `inventory_level_at_oos` STRING COMMENT 'The inventory quantity recorded at the moment the OOS event was triggered (typically zero or below safety stock threshold).',
    `lead_time_days` STRING COMMENT 'The standard supplier lead time in days for replenishing this SKU, used to assess whether replenishment delay contributed to the OOS event.',
    `location_type` STRING COMMENT 'Classification of the location where the OOS event occurred (physical warehouse, virtual location, fulfillment center, etc.).. Valid values are `physical_warehouse|virtual_location|fulfillment_center|distribution_center|cross_dock|store`',
    `lost_unit_sales` STRING COMMENT 'Estimated number of product units that could not be sold during the OOS period based on demand forecasts and historical sales rate.',
    `oos_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the OOS event measured in hours from start to end (or to current time if ongoing).',
    `oos_end_timestamp` TIMESTAMP COMMENT 'The exact date and time when inventory was replenished and the OOS condition ended. Null if still out of stock.',
    `oos_start_timestamp` TIMESTAMP COMMENT 'The exact date and time when the SKU inventory reached zero and the OOS condition began.',
    `oos_status` STRING COMMENT 'Current lifecycle status of the OOS event (active if still out of stock, resolved if inventory replenished, pending replenishment if order placed, cancelled if event invalidated).. Valid values are `active|resolved|pending_replenishment|cancelled`',
    `priority_level` STRING COMMENT 'Business priority assigned to resolving this OOS event based on SKU importance, revenue impact, and customer demand.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'The product category or classification of the SKU experiencing the OOS event, used for category-level OOS rate analysis.',
    `promotional_event_flag` BOOLEAN COMMENT 'Indicates whether a promotional campaign or marketing event was active during the OOS event, potentially causing demand spike.',
    `reorder_point` STRING COMMENT 'The inventory level threshold that should have triggered replenishment action to prevent this OOS event.',
    `resolution_action_taken` STRING COMMENT 'The primary corrective action taken to resolve the OOS event (emergency replenishment, supplier expedite, inventory transfer, customer notification, substitute offered, backorder created).. Valid values are `emergency_replenishment|supplier_expedite|inventory_transfer|customer_notification|substitute_offered|backorder_created`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken, decisions made, and outcomes of the resolution process for this OOS event.',
    `root_cause_category` STRING COMMENT 'Primary classification of the root cause that led to the OOS event (demand spike, replenishment delay, supplier stockout, forecast miss, system error, quality hold).. Valid values are `demand_spike|replenishment_delay|supplier_stockout|forecast_miss|system_error|quality_hold`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances and factors that caused the OOS event.',
    `safety_stock_level` STRING COMMENT 'The configured safety stock threshold for this SKU at this location at the time of the OOS event.',
    `seasonality_flag` BOOLEAN COMMENT 'Indicates whether this SKU is subject to seasonal demand patterns that may have contributed to the OOS event.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the OOS event duration exceeded the defined service level agreement threshold for inventory availability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this OOS event record was last modified or updated.',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Transactional record capturing an out-of-stock (OOS) event for a SKU at a warehouse node or virtual location. Records OOS start timestamp, OOS end timestamp, OOS duration, root cause classification (demand spike, replenishment delay, supplier stockout, forecast miss), estimated lost revenue, affected order count, and resolution action taken. Feeds OOS rate KPIs and replenishment policy reviews.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` (
    `replenishment_rule_id` BIGINT COMMENT 'Unique identifier for the replenishment rule configuration record. Primary key.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) to which this replenishment rule applies.',
    `supplier_id` BIGINT COMMENT 'Identifier of the primary supplier for this SKU replenishment. Links to the supplier master for procurement execution.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse node or fulfillment center where this replenishment rule is active.',
    `abc_classification` STRING COMMENT 'The ABC inventory classification category for this SKU. A items are high-value/high-velocity, C items are low-value/low-velocity.. Valid values are `A|B|C|D`',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automated replenishment order generation is enabled for this rule. When true, orders are created automatically when triggers are met.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment rule record was first created in the system.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility for this SKU. Used in safety stock optimization to account for demand uncertainty.',
    `dsr_baseline` DECIMAL(18,2) COMMENT 'The baseline average daily sales rate for this SKU at this warehouse. Used as the demand input for replenishment and safety stock calculations.',
    `effective_end_date` DATE COMMENT 'The date on which this replenishment rule expires or is no longer applicable. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'The date from which this replenishment rule becomes active and applicable for order generation.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical forecast accuracy for this SKU-warehouse combination. Used to adjust safety stock and replenishment parameters.',
    `holding_cost_per_unit_per_day` DECIMAL(18,2) COMMENT 'The daily cost of holding one unit of this SKU in inventory. Includes warehousing, capital, insurance, and obsolescence costs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this replenishment rule record was last updated or modified.',
    `last_recalculation_date` DATE COMMENT 'The date when the replenishment parameters (ROP, ROQ, safety stock) were last recalculated or optimized based on updated demand and supply data.',
    `lead_time_days` STRING COMMENT 'The expected number of days between placing a replenishment order and receiving the inventory at the warehouse. Used for reorder point calculations.',
    `lot_sizing_rule` STRING COMMENT 'The rule used to determine the size of replenishment lots. Complements the replenishment method with specific quantity logic.. Valid values are `fixed_order_quantity|economic_order_quantity|lot_for_lot|period_order_quantity`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The upper inventory threshold for this SKU-warehouse combination. Used in min-max replenishment strategies to cap inventory levels.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The smallest order quantity allowed by supplier or business rules. Replenishment orders must meet or exceed this threshold.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review and potential recalculation of replenishment parameters.',
    `notes` STRING COMMENT 'Free-text notes or comments about this replenishment rule. Used for documenting special conditions, exceptions, or planning context.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The quantity increment in which orders must be placed. Replenishment quantities are rounded to the nearest multiple of this value.',
    `priority_rank` STRING COMMENT 'The priority ranking of this SKU for replenishment planning. Higher priority items receive preferential treatment in allocation and ordering.',
    `procurement_category` STRING COMMENT 'The procurement category or commodity group to which this SKU belongs. Used for sourcing strategy and supplier management.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level threshold that triggers a replenishment order. When on-hand inventory falls to or below this quantity, a new order is initiated.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'The standard quantity to order when the reorder point is reached. Represents the replenishment order size.',
    `replenishment_method` STRING COMMENT 'The replenishment strategy applied for this SKU-warehouse combination. Defines the logic used to trigger replenishment orders.. Valid values are `min_max|fixed_period|demand_driven|economic_order_quantity|just_in_time|continuous_review`',
    `replenishment_rule_status` STRING COMMENT 'Current lifecycle status of the replenishment rule. Determines whether the rule is actively used for order generation.. Valid values are `active|inactive|suspended|under_review|archived`',
    `review_cycle_days` STRING COMMENT 'The frequency in days at which inventory levels are reviewed for replenishment decisions. Applies to periodic review replenishment methods.',
    `rule_name` STRING COMMENT 'Human-readable name or label for this replenishment rule configuration.',
    `safety_stock_calculation_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Determines how demand and supply variability are factored into the buffer.. Valid values are `statistical|fixed|seasonal|service_level|demand_variability`',
    `safety_stock_days` STRING COMMENT 'The number of days of demand coverage provided by the safety stock quantity. Used for planning and service level calculations.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The buffer inventory quantity maintained to protect against demand variability and supply uncertainty. Part of the unified replenishment and safety stock policy.',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied to baseline demand to account for seasonal demand patterns. Used in seasonal safety stock calculations.',
    `service_level_target_percentage` DECIMAL(18,2) COMMENT 'The target in-stock service level percentage for this SKU-warehouse combination. Drives safety stock sizing to meet availability goals.',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated business cost incurred per unit when this SKU is out of stock. Used in economic optimization of safety stock levels.',
    `supplier_lead_time_variability` DECIMAL(18,2) COMMENT 'Statistical measure of supplier delivery time variability. Used in safety stock calculations to account for supply uncertainty.',
    CONSTRAINT pk_replenishment_rule PRIMARY KEY(`replenishment_rule_id`)
) COMMENT 'Master configuration record and SSOT defining the complete replenishment policy and safety stock parameters for a SKU-warehouse node combination. Stores reorder point (ROP), reorder quantity (ROQ), safety stock quantity, safety stock days of cover, maximum stock level, MOQ, lead time days, DSR baseline, replenishment method (min-max, fixed-period, demand-driven), review cycle, safety stock calculation method (statistical, fixed, seasonal), demand variability coefficient, supplier lead time variability, service level target percentage, last recalculation date, and safety stock optimization parameters. Serves as the unified SSOT for both replenishment triggers and safety stock buffering logic — no separate safety stock configuration exists. Drives automated replenishment order generation, dynamic safety stock optimization based on demand/supply variability, and integrates with ERP procurement planning.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` (
    `safety_stock_rule_id` BIGINT COMMENT 'Unique identifier for the safety stock rule record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safety‑stock calculations allocate holding cost to a cost center, needed for cost‑of‑goods‑sold and inventory valuation reports.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center node where this safety stock rule applies.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and volume: A (high value, tight control), B (moderate), C (low value, loose control).. Valid values are `A|B|C`',
    `average_daily_demand` DECIMAL(18,2) COMMENT 'The mean daily sales rate or demand for this SKU at this warehouse node, used as baseline for safety stock calculation.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'The mean supplier or replenishment lead time in days for this SKU at this location.',
    `calculation_frequency` STRING COMMENT 'How often the safety stock quantity is automatically recalculated to reflect changing demand patterns and supply conditions.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `calculation_method` STRING COMMENT 'The methodology used to calculate safety stock quantity: statistical (based on demand variability), fixed (constant buffer), seasonal (adjusted for seasonality), dynamic (real-time optimization), min-max (reorder point logic), or service level (target fill rate).. Valid values are `statistical|fixed|seasonal|dynamic|min_max|service_level`',
    `created_by_user_code` STRING COMMENT 'Identifier of the user or system process that created this safety stock rule record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock rule record was first created in the system.',
    `demand_forecast_horizon_days` STRING COMMENT 'The number of days into the future for which demand forecasts are considered in safety stock calculation.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility (standard deviation or coefficient of variation) used in safety stock calculation to account for demand uncertainty.',
    `effective_end_date` DATE COMMENT 'The date on which this safety stock rule expires or is superseded by a new rule. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'The date from which this safety stock rule becomes active and is applied in inventory calculations.',
    `holding_cost_per_unit_per_day` DECIMAL(18,2) COMMENT 'The daily cost of carrying one unit of inventory, including warehousing, insurance, obsolescence, and capital cost.',
    `is_promotional_product` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is frequently subject to promotional campaigns that create demand spikes.',
    `is_seasonal_product` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU exhibits seasonal demand patterns requiring adjusted safety stock strategies.',
    `last_calculation_date` DATE COMMENT 'The most recent date on which the safety stock quantity was recalculated based on updated demand and lead time data.',
    `last_modified_by_user_code` STRING COMMENT 'Identifier of the user or system process that most recently updated this safety stock rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock rule record was most recently updated.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'The standard deviation or variance in supplier lead time measured in days, capturing supply uncertainty for safety stock calculation.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The upper inventory threshold for this SKU at this location, used in min-max inventory control systems.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from the supplier, which may influence safety stock levels and reorder point calculations.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review and potential recalculation of this safety stock rule.',
    `notes` STRING COMMENT 'Additional free-text comments or annotations about this safety stock rule for operational reference and knowledge transfer.',
    `override_reason` STRING COMMENT 'Free-text explanation when safety stock levels are manually overridden from system-calculated values, documenting business justification.',
    `priority_classification` STRING COMMENT 'Business priority level assigned to this SKU for safety stock management, influencing service level targets and buffer sizing.. Valid values are `critical|high|medium|low`',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered, calculated as lead time demand plus safety stock.',
    `review_period_days` STRING COMMENT 'The frequency in days at which inventory levels are reviewed and replenishment decisions are made for this SKU.',
    `rule_name` STRING COMMENT 'Human-readable name or label for this safety stock rule configuration.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the safety stock rule indicating whether it is actively applied in inventory planning.. Valid values are `active|inactive|suspended|under_review|expired`',
    `safety_stock_days_of_cover` DECIMAL(18,2) COMMENT 'The number of days of average demand that the safety stock quantity represents, providing a time-based buffer metric.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The calculated safety stock quantity in units that should be maintained as buffer inventory to protect against stockouts.',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to safety stock during seasonal demand periods to adjust buffer levels for predictable demand fluctuations.',
    `service_level_target_percentage` DECIMAL(18,2) COMMENT 'The target in-stock probability or fill rate percentage (e.g., 95.00, 99.00) that this safety stock rule is designed to achieve.',
    `sku` STRING COMMENT 'The unique product identifier for which this safety stock rule applies. Links to the product catalog.. Valid values are `^[A-Z0-9]{8,20}$`',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated business cost incurred per unit when a stockout occurs, including lost sales, expedited shipping, and customer dissatisfaction.',
    `supplier_reliability_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) measuring supplier on-time delivery performance and quality, influencing safety stock buffer requirements.',
    `unit_of_measure` STRING COMMENT 'The unit in which safety stock quantity is expressed (each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution z-score corresponding to the service level target, used in statistical safety stock formulas.',
    CONSTRAINT pk_safety_stock_rule PRIMARY KEY(`safety_stock_rule_id`)
) COMMENT 'Master record defining safety stock parameters for a SKU at a warehouse node, calculated to buffer against demand variability and supply uncertainty. Captures safety stock quantity, safety stock days of cover, calculation method (statistical, fixed, seasonal), demand variability coefficient, supplier lead time variability, service level target percentage, and last recalculation date. Supports dynamic safety stock optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`snapshot` (
    `snapshot_id` BIGINT COMMENT 'Unique identifier for the inventory snapshot record. Primary key.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Add lot_id FK to lot for proper normalization; lot_number string is redundant.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Periodic inventory snapshots must reference SKU details for valuation, reporting, and trend analysis.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or virtual inventory location where this stock position is held. Supports multi-node inventory visibility.',
    `available_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU available for new orders, calculated as on-hand quantity minus reserved quantity. Represents sellable inventory.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this snapshot record was first created in the data warehouse, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the unit cost and total inventory value are denominated.. Valid values are `^[A-Z]{3}$`',
    `cycle_count_date` DATE COMMENT 'The date of the most recent cycle count performed for this SKU at this warehouse node, used to track inventory accuracy and audit compliance.',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU identified as damaged or defective at the time of the snapshot. Typically marked for return to supplier or disposal.',
    `days_of_cover` DECIMAL(18,2) COMMENT 'The number of days the current on-hand inventory can support expected demand, calculated as on-hand quantity divided by daily sales rate (DSR). Used for inventory health monitoring.',
    `dsr` DECIMAL(18,2) COMMENT 'The average daily sales rate for this SKU at this warehouse node, used to calculate days of cover and forecast future inventory needs.',
    `expiration_date` DATE COMMENT 'The expiration or best-before date for perishable or time-sensitive SKUs in this inventory position, used for inventory rotation and waste prevention.',
    `fifo_cost_layer_reference` BIGINT COMMENT 'Identifier linking this snapshot to a specific FIFO cost layer for inventory valuation and cost of goods sold reconciliation under FIFO accounting method.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU currently in transit to this warehouse node from suppliers or other distribution centers, expected to arrive and increase on-hand stock.',
    `inventory_status` STRING COMMENT 'The overall status classification of this inventory position, indicating whether the stock is available for sale, held for specific purposes, or flagged for special handling. [ENUM-REF-CANDIDATE: available|reserved|quarantine|damaged|in_transit|expired|obsolete — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this snapshot record was last modified or refreshed in the data warehouse, supporting change tracking and data quality monitoring.',
    `location_type` STRING COMMENT 'Classification of the warehouse node type where this inventory is held, distinguishing between physical warehouses, virtual inventory pools, cross-dock facilities, retail stores, or vendor-managed inventory locations.. Valid values are `physical_warehouse|virtual_warehouse|cross_dock|store|vendor_managed`',
    `moq` DECIMAL(18,2) COMMENT 'The minimum order quantity required by the supplier for replenishment orders of this SKU, used in replenishment planning calculations.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'The physical quantity of the SKU available in the warehouse at the time of the snapshot. Represents actual stock on shelves or in bins.',
    `oos_flag` BOOLEAN COMMENT 'Boolean indicator that is true when the available quantity for this SKU at this warehouse node is zero or below safety stock, signaling a stockout condition.',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU held in quarantine due to quality control holds, damage inspection, or regulatory compliance checks. Not available for sale until released.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered for this SKU at this warehouse node to maintain optimal stock levels.',
    `replenishment_status` STRING COMMENT 'The replenishment health status for this SKU at this warehouse node, indicating whether stock levels are adequate, require replenishment, or are overstocked.. Valid values are `adequate|low|critical|overstocked|pending_order`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that is allocated to pending orders or fulfillment processes but not yet shipped. Reduces available-to-promise inventory.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity of the SKU that should be maintained at this warehouse node to prevent stockouts and ensure service level agreements are met.',
    `snapshot_date` DATE COMMENT 'The business date for which this inventory snapshot represents the stock position, used for daily trend analysis and period-over-period comparisons.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The exact date and time when this inventory snapshot was captured, typically end-of-day or end-of-period for reconciliation and financial reporting purposes.',
    `snapshot_type` STRING COMMENT 'Classification of the snapshot based on the reporting period it represents, such as daily, weekly, monthly, quarterly, yearly, or ad-hoc snapshots for special reconciliation needs.. Valid values are `end_of_day|end_of_week|end_of_month|end_of_quarter|end_of_year|ad_hoc`',
    `source_system` STRING COMMENT 'The source system from which this inventory snapshot data was extracted, such as Warehouse Management System, Enterprise Resource Planning system, or Order Management System.. Valid values are `WMS|ERP|OMS|manual_count|third_party`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total monetary value of the on-hand inventory for this SKU at this warehouse node, calculated as on-hand quantity multiplied by unit cost. Used for financial reporting and SOX compliance.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The per-unit cost of the SKU at the time of the snapshot, used for inventory valuation and cost of goods sold calculations. Supports FIFO, LIFO, or weighted average costing methods.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between the system-recorded on-hand quantity and the physically counted quantity from the most recent cycle count, indicating inventory accuracy.',
    CONSTRAINT pk_snapshot PRIMARY KEY(`snapshot_id`)
) COMMENT 'Periodic point-in-time snapshot of stock positions across all warehouse nodes and SKUs, captured at end-of-day or end-of-period for reconciliation, financial reporting, and trend analysis. Records snapshot timestamp, SKU, warehouse node, on-hand quantity, reserved quantity, in-transit quantity, unit cost, total inventory value, and days-of-cover. Supports SOX inventory valuation and FIFO cost layer reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` (
    `warehouse_node_id` BIGINT COMMENT 'Unique surrogate identifier for a warehouse node record in the fulfillment network. Primary key for the warehouse_node master data product.',
    `address_line1` STRING COMMENT 'Primary street address line of the warehouse node facility. Used for carrier pickup scheduling, regulatory filings, and geographic routing in the TMS.',
    `address_line2` STRING COMMENT 'Secondary address line for the warehouse node (suite, dock number, building identifier). Supplements address_line1 for precise carrier and logistics routing.',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the warehouse node in square feet. Principal capacity measurement used for space utilization reporting, lease management, and network capacity planning.',
    `carrier_codes` STRING COMMENT 'Comma-separated list of carrier codes (e.g., UPS,FEDEX,USPS,DHL) representing the shipping carriers that service this warehouse node. Used by the TMS for carrier selection and rate shopping during order fulfillment.',
    `city` STRING COMMENT 'City in which the warehouse node is physically located. Used for geographic clustering, last-mile delivery zone assignment, and regulatory jurisdiction determination.',
    `commissioned_date` DATE COMMENT 'Date on which the warehouse node was officially commissioned and became operational in the fulfillment network. Used for asset lifecycle tracking, depreciation calculations, and network history reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country in which the warehouse node is located. Drives cross-border trade compliance, customs documentation, and WTO regulatory requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse node master record was first created in the system. Used for data lineage, audit trail, and record lifecycle management per ISO 27001 information security standards.',
    `decommissioned_date` DATE COMMENT 'Date on which the warehouse node was decommissioned and removed from the active fulfillment network. Null for active nodes. Used for network topology history and asset lifecycle reporting.',
    `dock_doors_inbound` STRING COMMENT 'Number of inbound receiving dock doors at the warehouse node. Determines inbound throughput capacity for purchase order receiving, supplier deliveries, and FTL/LTL carrier appointments.',
    `dock_doors_outbound` STRING COMMENT 'Number of outbound shipping dock doors at the warehouse node. Determines outbound throughput capacity for order fulfillment, carrier pickups, and cross-dock operations.',
    `fulfillment_model` STRING COMMENT 'Primary fulfillment model supported by this node. Determines order routing eligibility and SLA commitments. FBA-style nodes handle seller-stocked inventory; BOPIS nodes support Buy Online Pick Up In Store; DTC nodes serve direct-to-consumer shipments. [ENUM-REF-CANDIDATE: fba_style|bopis|dtc|b2b|omnichannel|cross_dock — promote to reference product]. Valid values are `fba_style|bopis|dtc|b2b|omnichannel|cross_dock`',
    `gl_cost_center_code` STRING COMMENT 'SAP S/4HANA General Ledger cost center code associated with this warehouse node for financial reporting, operational cost allocation, and SOX-compliant expense tracking.',
    `gln` STRING COMMENT 'GS1 Global Location Number (GLN) — a 13-digit internationally standardized identifier for this warehouse node. Used in EDI transactions, supply chain partner communications, and global trade compliance.. Valid values are `^d{13}$`',
    `is_24hr_operation` BOOLEAN COMMENT 'Indicates whether the warehouse node operates on a 24-hour, continuous basis. When true, overrides operating_hours_start and operating_hours_end for SLA and routing calculations.',
    `is_3pl` BOOLEAN COMMENT 'Indicates whether this warehouse node is operated by a third-party logistics (3PL) provider rather than owned/operated by the business. Drives cost allocation, SLA contract management, and operational reporting.',
    `is_cold_storage` BOOLEAN COMMENT 'Indicates whether the warehouse node has temperature-controlled cold storage capability. Used to route perishable or temperature-sensitive SKUs to eligible nodes during inventory allocation.',
    `is_hazmat_certified` BOOLEAN COMMENT 'Indicates whether the warehouse node holds the required certifications to store and handle hazardous materials (hazmat). Drives SKU-level inventory routing and CPSC compliance checks.',
    `is_returns_enabled` BOOLEAN COMMENT 'Indicates whether this warehouse node is authorized to receive and process customer returns and RMA (Return Merchandise Authorization) shipments. Controls return routing logic in the OMS.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether this is a virtual warehouse node (e.g., a drop-ship node or virtual inventory pool) with no physical facility. Virtual nodes participate in inventory allocation and order routing but have no physical location attributes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse node in decimal degrees (WGS 84). Used by the TMS for route optimization, delivery radius calculations, and geospatial analytics.',
    `lease_expiry_date` DATE COMMENT 'Date on which the facility lease for this warehouse node expires. Used for network planning, lease renewal management, and long-term capacity forecasting. Applicable to leased facilities only.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse node in decimal degrees (WGS 84). Used by the TMS for route optimization, delivery radius calculations, and geospatial analytics.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum total weight capacity of the warehouse node in kilograms. Used for structural load compliance, inventory planning, and safety management per facility engineering specifications.',
    `network_tier` STRING COMMENT 'Hierarchical tier classification of the warehouse node within the fulfillment network topology. Hub nodes serve as primary distribution points; spoke nodes serve last-mile delivery zones. Drives inventory positioning and replenishment flow.. Valid values are `tier_1|tier_2|tier_3|spoke|hub`',
    `node_code` STRING COMMENT 'Externally-known, human-readable alphanumeric code uniquely identifying the warehouse node across all operational systems (WMS, TMS, OMS). Used as the business key in EDI, carrier integrations, and fulfillment routing logic.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `node_name` STRING COMMENT 'Full descriptive name of the warehouse node as used in operational communications, reporting dashboards, and carrier documentation (e.g., Dallas Fulfillment Center - North).',
    `node_status` STRING COMMENT 'Current operational lifecycle status of the warehouse node. Controls whether the node is eligible to receive inventory allocations, fulfill orders, or participate in replenishment planning.. Valid values are `active|inactive|suspended|decommissioned|planned`',
    `node_type` STRING COMMENT 'Classification of the warehouse node by its operational role in the fulfillment network. Drives routing logic, SLA assignment, and capacity planning. [ENUM-REF-CANDIDATE: fulfillment_center|distribution_center|dark_store|3pl_facility|drop_ship_node|returns_center — promote to reference product]. Valid values are `fulfillment_center|distribution_center|dark_store|3pl_facility|drop_ship_node|returns_center`',
    `operating_days` STRING COMMENT 'Comma-separated list of operating days of the week for the warehouse node (e.g., MON,TUE,WED,THU,FRI). Used for SLA cutoff scheduling, carrier appointment booking, and fulfillment routing logic.',
    `operating_hours_end` STRING COMMENT 'Standard daily operating end time for the warehouse node in HH:MM (24-hour) format. Used to determine carrier pickup cutoff windows, SLA calculation, and order routing eligibility.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_start` STRING COMMENT 'Standard daily operating start time for the warehouse node in HH:MM (24-hour) format. Used to determine carrier pickup cutoff windows, SLA calculation, and order routing eligibility.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `pallet_positions` STRING COMMENT 'Total number of standard pallet positions available in the warehouse node. Used for inventory capacity planning, MOQ compliance, and replenishment scheduling in the WMS.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the warehouse node facility. Used for carrier zone mapping, last-mile delivery cost calculation, and geographic analytics.',
    `region_code` STRING COMMENT 'Internal geographic region code grouping warehouse nodes for network planning, carrier contract management, and regional fulfillment analytics (e.g., US-WEST, EU-CENTRAL).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `state_province` STRING COMMENT 'State or province code where the warehouse node is located. Used for tax nexus determination, labor law compliance, and regional fulfillment routing. Follows ISO 3166-2 subdivision codes.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum maintained temperature in degrees Celsius for the warehouse nodes temperature-controlled storage areas. Applicable only when is_cold_storage is true. Used for SKU eligibility routing and compliance audits.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum maintained temperature in degrees Celsius for the warehouse nodes temperature-controlled storage areas. Applicable only when is_cold_storage is true. Used for SKU eligibility routing and compliance audits.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the warehouse node location (e.g., America/Chicago). Used to correctly interpret operating hours, SLA cutoff times, and carrier pickup windows across distributed fulfillment networks.',
    `tms_location_code` STRING COMMENT 'Location code assigned by the Transportation Management System (TMS) for this warehouse node. Used for carrier pickup scheduling, route optimization, and shipment origin identification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse node master record. Used for change detection, data synchronization with WMS/TMS, and audit trail compliance.',
    `wms_facility_reference` STRING COMMENT 'Native facility identifier assigned by the Warehouse Management System (WMS) for this warehouse node. Used for system integration, EDI message routing, and reconciliation between the WMS and the lakehouse SSOT.',
    CONSTRAINT pk_warehouse_node PRIMARY KEY(`warehouse_node_id`)
) COMMENT 'Master record for a physical or virtual warehouse node in the fulfillment network, including distribution centers, fulfillment centers, dark stores, 3PL facilities, and virtual drop-ship nodes. Captures node code, node type, address, geographic coordinates, capacity (sqft and pallet positions), operating hours, supported fulfillment types (FBA-style, BOPIS, DTC), and active status. SSOT for warehouse network topology.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` (
    `sku_velocity_id` BIGINT COMMENT 'Unique surrogate primary key for the SKU velocity record. Identifies a single master record tracking daily sales rate and velocity classification for a SKU at a warehouse node.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller who owns this SKU inventory at this node, where applicable. Relevant for Fulfillment By Amazon-style (FBA-style) models where seller inventory is co-mingled or segregated within the warehouse node.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which velocity metrics are tracked. Links to the product catalog master record.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the warehouse node or fulfillment center at which this SKU velocity record applies. Enables node-level slotting and replenishment decisions.',
    `active_promotion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU is currently under an active promotional campaign that may be influencing its DSR. When true, velocity metrics may be temporarily elevated and should be interpreted with caution for baseline replenishment planning.',
    `bsr_category` STRING COMMENT 'Product category within which the BSR rank is computed (e.g., Electronics, Apparel). BSR is category-relative; this field provides the denominator context for rank interpretation.',
    `bsr_rank` STRING COMMENT 'Best Seller Rank (BSR) of this SKU within its product category at the time of the last velocity recalculation. Lower rank indicates higher sales velocity. Used as a co-input with DSR for velocity tier classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU velocity record was first created in the data platform. Audit trail field supporting data lineage, compliance, and Silver Layer ingestion tracking.',
    `data_window_start_date` DATE COMMENT 'Start date of the data window used in the most recent velocity recalculation. Defines the earliest transaction date included in DSR computations. Important for understanding the representativeness of velocity metrics for newly launched or recently reactivated SKUs.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Estimated number of days the current on-hand inventory will last at the current 30-day DSR before reaching zero. Key Out-of-Stock (OOS) risk indicator used in replenishment prioritization.',
    `dsr_30d` DECIMAL(18,2) COMMENT 'Rolling 30-day average Daily Sales Rate (DSR) expressed as units sold per day. Medium-term velocity indicator used for standard replenishment planning and safety stock calculations.',
    `dsr_7d` DECIMAL(18,2) COMMENT 'Rolling 7-day average Daily Sales Rate (DSR) expressed as units sold per day. Short-term velocity indicator used for immediate replenishment triggers and safety stock adjustments.',
    `dsr_90d` DECIMAL(18,2) COMMENT 'Rolling 90-day average Daily Sales Rate (DSR) expressed as units sold per day. Long-term velocity baseline used for seasonal trend analysis, safety stock floor calculations, and velocity tier classification.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp from which this SKU velocity record is considered valid and active for operational use. Supports Slowly Changing Dimension (SCD) Type 2 history tracking and point-in-time velocity analysis.',
    `effective_to` TIMESTAMP COMMENT 'Timestamp at which this SKU velocity record was superseded by a newer version. Null indicates the current active record. Supports Slowly Changing Dimension (SCD) Type 2 history tracking and point-in-time velocity analysis.',
    `fulfillment_model` STRING COMMENT 'Fulfillment model under which this SKU is stocked and shipped at this node. FBA = Fulfillment By Amazon-style (platform-fulfilled); FBM = Fulfilled by Merchant; 3PL = Third-Party Logistics; DTC = Direct to Consumer; BOPIS = Buy Online Pick Up In Store. Velocity benchmarks and slotting rules differ by fulfillment model.. Valid values are `FBA|FBM|3PL|DTC|BOPIS`',
    `is_seasonal_sku` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU exhibits significant seasonal demand patterns. When true, the seasonal velocity index is weighted more heavily in safety stock and replenishment calculations.',
    `net_dsr_30d` DECIMAL(18,2) COMMENT 'Net 30-day Daily Sales Rate (DSR) adjusted for returns: gross units sold minus units returned, divided by 30 days. Provides a more accurate velocity signal for replenishment planning than gross DSR when return rates are material.',
    `oos_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU at this node is at imminent risk of an Out-of-Stock (OOS) event, defined as days_of_supply falling below the replenishment lead time. Triggers priority replenishment workflows.',
    `peak_dsr` DECIMAL(18,2) COMMENT 'Maximum observed Daily Sales Rate (DSR) for this SKU at this node within the trailing 365-day window. Used to size safety stock buffers for peak demand events such as promotions or seasonal spikes.',
    `peak_dsr_date` DATE COMMENT 'Calendar date on which the peak DSR was recorded. Provides temporal context for peak demand analysis and seasonal pattern identification.',
    `prior_velocity_tier` STRING COMMENT 'Velocity tier assigned to this SKU-node combination in the previous recalculation cycle. Retained alongside the current tier to support tier-change analysis, slotting review workflows, and audit trails.. Valid values are `A|B|C|D`',
    `promotion_velocity_uplift` DECIMAL(18,2) COMMENT 'Multiplier representing the observed or forecasted increase in DSR during active promotional periods for this SKU. A value of 1.5 indicates a 50% uplift over baseline DSR during promotions. Used to pre-position inventory ahead of planned promotions.',
    `recalculation_frequency_hours` STRING COMMENT 'Configured frequency in hours at which the velocity metrics for this SKU-node record are recalculated. Tier-A SKUs may recalculate every 4 hours; Tier-D SKUs may recalculate daily. Drives scheduling of the velocity computation job.',
    `reorder_point_qty` STRING COMMENT 'Inventory level at which a replenishment order should be triggered for this SKU at this node. Computed from DSR, replenishment lead time, and safety stock. When on-hand quantity falls to or below this level, a replenishment signal is generated.',
    `replenishment_frequency_days` DECIMAL(18,2) COMMENT 'Recommended replenishment cycle in days derived from the SKU velocity tier and DSR. Tier-A SKUs may have a 0.5-day (twice daily) replenishment cycle; Tier-D SKUs may be replenished every 30 days. Feeds the Warehouse Management System replenishment scheduler.',
    `return_rate_30d` DECIMAL(18,2) COMMENT 'Ratio of units returned to units sold for this SKU at this node over the trailing 30-day window. Expressed as a decimal (e.g., 0.05 = 5% return rate). High return rates may inflate gross DSR; net velocity should account for returns in replenishment planning.',
    `safety_stock_qty` STRING COMMENT 'Recommended safety stock quantity for this SKU at this node, calculated from DSR, lead time variability, and seasonal velocity index. Represents the buffer inventory held to prevent Out-of-Stock (OOS) events during demand spikes or supply delays.',
    `season_code` STRING COMMENT 'Primary selling season associated with this SKU. Used to contextualize the seasonal velocity index and align replenishment planning with seasonal demand cycles. YEAR_ROUND indicates no dominant season.. Valid values are `SPRING|SUMMER|FALL|WINTER|HOLIDAY|YEAR_ROUND`',
    `seasonal_velocity_index` DECIMAL(18,2) COMMENT 'Dimensionless multiplier representing the ratio of current period DSR to the annual average DSR for this SKU at this node. Values above 1.0 indicate above-average seasonal demand; below 1.0 indicate below-average. Used to adjust safety stock and replenishment quantities for seasonal fluctuations.',
    `slotting_zone` STRING COMMENT 'Warehouse slotting zone recommended or assigned to this SKU based on its velocity tier. prime = highest-pick-frequency zone closest to packing; forward = forward pick area; reserve = reserve storage; bulk = bulk pallet storage; overflow = overflow/offsite storage. Drives pick path optimization and labor efficiency.. Valid values are `prime|forward|reserve|bulk|overflow`',
    `tier_change_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the velocity tier changed during the most recent recalculation cycle. When true, triggers a slotting review workflow to evaluate whether physical relocation of the SKU within the warehouse is warranted.',
    `tier_changed_timestamp` TIMESTAMP COMMENT 'Timestamp when the velocity tier last changed for this SKU-node combination. Used to measure tier stability, assess slotting decision lag, and support historical velocity analysis.',
    `units_sold_30d` STRING COMMENT 'Total units of this SKU sold from this warehouse node in the trailing 30-day window. Raw sales volume input used to compute the 30-day DSR and velocity tier assignment.',
    `units_sold_7d` STRING COMMENT 'Total units of this SKU sold from this warehouse node in the trailing 7-day window. Raw sales volume input used to compute the 7-day DSR.',
    `units_sold_90d` STRING COMMENT 'Total units of this SKU sold from this warehouse node in the trailing 90-day window. Raw sales volume input used to compute the 90-day DSR and long-term velocity baseline.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this SKU velocity record in the data platform. Audit trail field supporting data lineage, change detection, and Silver Layer merge operations.',
    `velocity_recalculated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent velocity recalculation job that updated DSR values, velocity tier, and seasonal index for this SKU-node combination. Used to assess data freshness and trigger stale-data alerts.',
    `velocity_status` STRING COMMENT 'Lifecycle status of this SKU velocity record. active = currently used for slotting and replenishment decisions; inactive = SKU no longer stocked at this node; suspended = temporarily excluded from velocity-driven decisions (e.g., during a product recall); pending_review = awaiting manual validation after anomaly detection.. Valid values are `active|inactive|suspended|pending_review`',
    `velocity_tier` STRING COMMENT 'ABC/D velocity tier assigned to the SKU at this warehouse node based on Best Seller Rank (BSR) and sales volume. A = fastest moving (top ~20%), B = moderate, C = slow, D = dead/near-zero movement. Drives slotting zone assignment and replenishment frequency.. Valid values are `A|B|C|D`',
    `velocity_trend` STRING COMMENT 'Directional trend of SKU velocity based on comparison of 7-day DSR to 90-day DSR. accelerating = 7d DSR significantly above 90d DSR; stable = within normal variance band; decelerating = 7d DSR significantly below 90d DSR; volatile = high variance with no clear direction. Used for proactive inventory positioning.. Valid values are `accelerating|stable|decelerating|volatile`',
    CONSTRAINT pk_sku_velocity PRIMARY KEY(`sku_velocity_id`)
) COMMENT 'Master record tracking the daily sales rate (DSR) and velocity classification for a SKU at a warehouse node. Stores rolling DSR (7-day, 30-day, 90-day), velocity tier (A/B/C/D based on BSR and sales volume), average units sold per day, peak DSR, seasonal velocity index, and last recalculation timestamp. Drives slotting decisions, replenishment frequency, and safety stock calculations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` (
    `quarantine_record_id` BIGINT COMMENT 'Unique identifier for the quarantine record. Primary key.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Add lot_id FK to lot for proper normalization; lot_number string is redundant.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Quarantine events are triggered by specific compliance obligations; linking enables the Quarantine‑Obligation impact report.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Supports Quarantine Compliance Report per seller, monitoring quality issues affecting individual sellers.',
    `service_support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Regulatory compliance: quarantine actions are often initiated by a support case investigation; linking provides traceability for quality and safety audits.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU placed in quarantine.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier associated with the quarantined inventory, relevant for supplier disputes or returns.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key reference to the specific warehouse location (bin, aisle, zone) where the quarantined inventory is stored.',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key reference to the warehouse where the quarantined inventory is located.',
    `affected_order_count` STRING COMMENT 'The number of customer orders that are impacted or blocked due to this quarantine.',
    `corrective_action_description` STRING COMMENT 'Free-text description of the corrective actions planned or implemented to address the root cause and prevent recurrence.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to prevent recurrence of this quarantine issue.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this quarantine record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `customer_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this quarantine has direct impact on customer orders or commitments.',
    `disposition_date` DATE COMMENT 'The date when the disposition decision was executed and the inventory was moved, destroyed, or returned.',
    `disposition_decision` STRING COMMENT 'The final decision on how to handle the quarantined inventory (e.g., return to stock, destroy, return to supplier, donate, rework, scrap).. Valid values are `return_to_stock|destroy|return_to_supplier|donate|rework|scrap`',
    `disposition_notes` STRING COMMENT 'Free-text notes documenting the rationale, process, and details of the disposition decision and execution.',
    `disposition_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory units that were dispositioned. May differ from quarantined quantity if partial disposition occurred.',
    `expected_resolution_date` DATE COMMENT 'The anticipated date by which the quarantine hold is expected to be resolved based on inspection or review timelines.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The estimated or actual financial impact (cost, loss, or liability) associated with this quarantine event, in the base currency.',
    `hold_authority_contact` STRING COMMENT 'Contact information (email or phone) for the authority that initiated the quarantine hold.',
    `hold_authority_name` STRING COMMENT 'The name of the specific person, team, or organization that initiated the quarantine hold.',
    `hold_authority_type` STRING COMMENT 'The type of authority or entity that initiated the quarantine hold (e.g., Quality Assurance team, regulatory body, supplier, warehouse manager).. Valid values are `qa_team|regulatory_body|supplier|warehouse_manager|customer_service`',
    `inspection_date` DATE COMMENT 'The date when the inspection of the quarantined inventory was completed.',
    `inspection_notes` STRING COMMENT 'Free-text notes documenting findings, observations, and details from the inspection process.',
    `inspection_outcome` STRING COMMENT 'The result of the inspection performed on the quarantined inventory (e.g., pass, fail, conditional pass, pending).. Valid values are `pass|fail|conditional_pass|pending|not_applicable`',
    `inspection_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal inspection is required before the quarantine can be resolved.',
    `inspection_type` STRING COMMENT 'The type of inspection required or performed on the quarantined inventory (e.g., visual, functional, laboratory, regulatory, third-party).. Valid values are `visual|functional|laboratory|regulatory|third_party`',
    `inspector_name` STRING COMMENT 'The name of the person or team who performed the inspection of the quarantined inventory.',
    `priority_level` STRING COMMENT 'The priority level assigned to resolving this quarantine, based on business impact, regulatory urgency, or customer commitments.. Valid values are `critical|high|medium|low`',
    `quarantine_end_date` DATE COMMENT 'The date when the quarantine hold was lifted or the inventory was dispositioned. Null if quarantine is still active.',
    `quarantine_end_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the quarantine hold was lifted or the inventory was dispositioned. Null if quarantine is still active.',
    `quarantine_reason_code` STRING COMMENT 'Standardized code indicating the reason inventory was placed in quarantine status. [ENUM-REF-CANDIDATE: quality_hold|damage|regulatory_inspection|recall|supplier_dispute|expiry_risk|contamination — 7 candidates stripped; promote to reference product]',
    `quarantine_reason_description` STRING COMMENT 'Detailed free-text description of the specific reason for quarantine, providing additional context beyond the reason code.',
    `quarantine_start_date` DATE COMMENT 'The date when the inventory was placed into quarantine status.',
    `quarantine_start_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the inventory was placed into quarantine status, supporting audit trail and Service Level Agreement (SLA) tracking.',
    `quarantine_status` STRING COMMENT 'Current lifecycle status of the quarantine record indicating whether the hold is active, under review, or resolved.. Valid values are `active|under_inspection|resolved|released|disposed`',
    `quarantined_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory units placed in quarantine status.',
    `recall_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this quarantine is related to a product recall issued by the Consumer Product Safety Commission (CPSC) or other regulatory body.',
    `recall_number` STRING COMMENT 'The official recall number or identifier issued by the Consumer Product Safety Commission (CPSC) or other regulatory authority, if applicable.',
    `regulatory_reference_number` STRING COMMENT 'Reference number or case identifier from the regulatory body overseeing the quarantine or inspection.',
    `root_cause_category` STRING COMMENT 'The high-level category of the root cause that led to the quarantine event. [ENUM-REF-CANDIDATE: supplier_defect|warehouse_damage|transportation_damage|expiry|contamination|mislabeling|regulatory_change — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed free-text description of the root cause analysis findings for this quarantine event.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quarantined quantity (e.g., each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this quarantine record was last updated in the system.',
    CONSTRAINT pk_quarantine_record PRIMARY KEY(`quarantine_record_id`)
) COMMENT 'Transactional record tracking inventory placed in quarantine status due to quality holds, damage, regulatory inspection, recall, or supplier dispute. Captures quarantine reason, quarantine start date, quarantine end date, affected SKU, lot, quantity, warehouse location, hold authority (QA team, regulatory body, supplier), inspection outcome, and disposition decision (return to stock, destroy, return to supplier, donate). Supports CPSC recall compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the inventory hold record. Primary key.',
    `agent_id` BIGINT COMMENT 'Identifier of the employee or quality assurance personnel who conducted the inspection.',
    `legal_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.legal_hold. Business justification: Inventory holds can be placed due to legal holds; linking enables the Legal‑Hold Management dashboard.',
    `seller_profile_id` BIGINT COMMENT 'Identifier of the marketplace seller who owns the held inventory, relevant for marketplace fulfillment models (FBA-style).',
    `service_support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Required for audit: when a support case triggers a hold on inventory, linking enables case‑to‑hold traceability for SLA and compliance reporting.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU affected by this hold. Links to the product catalog.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the held inventory, relevant for supplier dispute holds or return to supplier dispositions.',
    `warehouse_location_id` BIGINT COMMENT 'Specific bin, shelf, or zone location within the warehouse where the held inventory resides.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse node where the held inventory is located.',
    `atp_impact_quantity` DECIMAL(18,2) COMMENT 'Quantity of ATP inventory reduced due to this hold, impacting order fulfillment capacity and inventory availability reporting.',
    `authority` STRING COMMENT 'Name or identifier of the authority that placed the hold (e.g., QA Team, CPSC, Legal Department, Supplier Name, Regulatory Body).',
    `authority_contact` STRING COMMENT 'Contact information (email or phone) for the authority responsible for the hold, used for resolution coordination.',
    `cpsc_compliance_flag` BOOLEAN COMMENT 'Indicates whether this hold is compliant with CPSC recall and quarantine requirements for consumer product safety.',
    `created_by_user_code` BIGINT COMMENT 'Identifier of the user or system process that created this hold record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disposition_date` DATE COMMENT 'Date when the disposition decision was executed and the inventory was moved to its final state.',
    `disposition_decision` STRING COMMENT 'Final decision on what to do with the held inventory: return to stock (release to available), destroy (dispose of), return to supplier (RMA), donate (charitable contribution), rework (repair or repackage), or scrap (write off).. Valid values are `return_to_stock|destroy|return_to_supplier|donate|rework|scrap`',
    `end_date` DATE COMMENT 'Date when the hold was released or resolved, allowing inventory to return to available status. Null if hold is still active.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the hold was released or resolved. Null if hold is still active.',
    `expiry_date` DATE COMMENT 'Scheduled expiration date for the hold, after which the hold should be reviewed or automatically released if no action is taken.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the hold in terms of inventory value at cost, used for financial reporting and variance analysis.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold: active (inventory is restricted), pending review (under evaluation), released (hold lifted and inventory returned to available), expired (hold period ended), or cancelled (hold removed before completion).. Valid values are `active|pending_review|released|expired|cancelled`',
    `hold_type` STRING COMMENT 'Classification of the hold based on the originating business reason: legal holds, regulatory holds, quality quarantines, financial holds, promotional reserves, damage holds, recall quarantines, or supplier dispute holds. [ENUM-REF-CANDIDATE: legal|regulatory|quality|financial|promotional|damage|recall|supplier_dispute — 8 candidates stripped; promote to reference product]',
    `inspection_date` DATE COMMENT 'Date when the inspection or quality review was completed. Null if inspection has not occurred.',
    `inspection_outcome` STRING COMMENT 'Result of the inspection or quality review conducted on the held inventory: pass (cleared for release), fail (remains quarantined), conditional pass (partial release), pending (inspection in progress), or not applicable.. Valid values are `pass|fail|conditional_pass|pending|not_applicable`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a formal inspection or quality check is required before the hold can be released.',
    `lot_number` STRING COMMENT 'Manufacturing or receiving lot number for FIFO/LIFO tracking and traceability of the held inventory.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the hold, including communication history, escalation details, or special handling instructions.',
    `priority_level` STRING COMMENT 'Priority classification for resolving the hold, indicating urgency for review and disposition (critical for recalls, high for legal holds, medium for quality issues, low for administrative holds).. Valid values are `critical|high|medium|low`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory units placed under this hold, preventing allocation or shipment.',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for placing the hold (e.g., QA_FAIL, RECALL_CPSC, LEGAL_INJUNCTION, DAMAGE_TRANSIT).',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of why the hold was placed, including root cause and context.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this hold is associated with a product recall issued by CPSC or other regulatory body.',
    `recall_number` STRING COMMENT 'Official recall identification number issued by CPSC or regulatory authority, if this hold is part of a recall action.',
    `release_conditions` STRING COMMENT 'Detailed description of the conditions that must be met before the hold can be released (e.g., pass re-inspection, receive supplier credit, legal clearance obtained).',
    `resolution_timeline_days` STRING COMMENT 'Target number of days within which the hold should be resolved, based on hold type and priority level.',
    `root_cause_classification` STRING COMMENT 'Standardized classification of the root cause that led to the hold (e.g., supplier defect, transit damage, regulatory non-compliance, system error).',
    `start_date` DATE COMMENT 'Date when the hold was initiated and inventory was restricted from allocation.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the hold was placed, capturing the exact moment inventory became restricted.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the held quantity (e.g., EA for each, CS for case, PLT for pallet).',
    `updated_by_user_code` BIGINT COMMENT 'Identifier of the user or system process that last updated this hold record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last modified, tracking the most recent change to hold status or attributes.',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Transactional record representing any active hold or quarantine placed on inventory that prevents allocation or shipment. Serves as the SSOT for all inventory restriction types including legal holds, regulatory holds, quality quarantines, financial holds, promotional reserves, damage holds, recall quarantines, and supplier dispute holds. Captures hold type, hold reason, affected SKU, lot, quantity, warehouse location, hold start date, hold end date, hold expiry date, hold authority (QA team, regulatory body, supplier, legal department), release conditions, inspection outcome, and disposition decision (return to stock, destroy, return to supplier, donate). Tracks full quarantine lifecycle including quarantine start/end dates, root cause classification, resolution timeline, and CPSC recall compliance. Supports hold-level reporting for inventory availability impact analysis and regulatory audit trails.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT 'Unique identifier for the stock valuation record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this inventory holding, used for internal cost allocation and management reporting.',
    `financial_period_close_id` BIGINT COMMENT 'Reference to the financial accounting period in which this cost layer valuation is recorded for period-end reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns this inventory for financial consolidation and SOX compliance reporting.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that originated this inventory receipt and cost layer.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Allows COGS allocation per seller for financial reporting and margin analysis.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU being valued in this inventory cost layer.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier from whom this inventory lot was procured, relevant for cost traceability.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the warehouse node where the inventory is held and valued.',
    `adjustment_notes` STRING COMMENT 'Free-text notes providing additional context for cost layer adjustments or valuation changes.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for any cost layer adjustment, such as cycle count variance, damage, obsolescence, or revaluation.',
    `audit_trail_reference` STRING COMMENT 'Unique identifier linking this valuation record to the audit trail for compliance and traceability purposes.',
    `cogs_allocated` DECIMAL(18,2) COMMENT 'Total cost of goods sold amount allocated from this cost layer to revenue transactions, feeding COGS calculation for financial reporting.',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Quantity from this cost layer that has been consumed through sales, transfers, or adjustments, reducing the available layer quantity.',
    `cost_layer_sequence` STRING COMMENT 'Sequential order of this cost layer within the SKU-warehouse-lot combination, used for FIFO/LIFO consumption ordering.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between actual unit cost and standard cost, used for cost variance reporting and analysis.',
    `costing_method` STRING COMMENT 'Inventory valuation method applied to this cost layer: First In First Out (FIFO), Last In First Out (LIFO), weighted average, standard cost, or moving average.. Valid values are `FIFO|LIFO|weighted_average|standard_cost|moving_average`',
    `created_by_user_code` BIGINT COMMENT 'Reference to the user who created this stock valuation record, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amounts (unit cost and layer value).. Valid values are `^[A-Z]{3}$`',
    `duty_cost` DECIMAL(18,2) COMMENT 'Allocated customs duty and tariff cost component included in the unit cost for this inventory layer.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Allocated freight cost component included in the unit cost for this inventory layer.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this inventory valuation is posted for financial statement preparation.',
    `handling_cost` DECIMAL(18,2) COMMENT 'Allocated handling and processing cost component included in the unit cost for this inventory layer.',
    `inventory_status` STRING COMMENT 'Current status of the inventory in this cost layer, affecting its availability for sale and valuation treatment.. Valid values are `available|reserved|quarantined|damaged|in_transit|obsolete`',
    `landed_cost_included` BOOLEAN COMMENT 'Indicates whether the unit cost includes landed cost components such as freight, duties, and handling charges.',
    `layer_quantity` DECIMAL(18,2) COMMENT 'Total quantity of inventory units in this cost layer available for valuation.',
    `layer_value` DECIMAL(18,2) COMMENT 'Total monetary value of this cost layer, calculated as unit cost multiplied by layer quantity.',
    `lot_number` STRING COMMENT 'Inventory lot or batch identifier for traceability and FIFO/LIFO cost layer sequencing.',
    `receipt_date` DATE COMMENT 'Date when the inventory lot was received into the warehouse, establishing the cost layer entry point for FIFO/LIFO.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity remaining in this cost layer available for future consumption, calculated as layer quantity minus consumed quantity.',
    `revaluation_date` DATE COMMENT 'Date on which the cost layer revaluation was performed, if applicable.',
    `revaluation_flag` BOOLEAN COMMENT 'Indicates whether this cost layer has undergone a revaluation adjustment due to market price changes or accounting policy updates.',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether this cost layer valuation record meets SOX internal control requirements for financial reporting accuracy and auditability.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Predetermined standard cost per unit for this SKU, used for variance analysis when standard costing method is applied.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory in this cost layer, expressed in the valuation currency.',
    `updated_by_user_code` BIGINT COMMENT 'Reference to the user who last modified this stock valuation record, supporting accountability and audit requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock valuation record was last modified, supporting audit trail and data lineage.',
    `valuation_date` DATE COMMENT 'Business date on which this inventory cost layer valuation is effective, used for financial period alignment.',
    `valuation_status` STRING COMMENT 'Lifecycle status of this cost layer valuation record, indicating whether it is active, fully consumed, or adjusted.. Valid values are `active|consumed|adjusted|written_off|transferred`',
    `valuation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this cost layer valuation was calculated or recorded in the system.',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Transactional record capturing the cost valuation of inventory for a SKU-lot-warehouse combination under the applicable costing method (FIFO, LIFO, weighted average, standard cost). Stores cost layer sequence, unit cost, total layer quantity, total layer value, valuation date, costing method, and currency. Feeds finance domain for inventory asset valuation, COGS calculation, and SOX financial reporting compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'Unique identifier for the inbound shipment record. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier performance & SLA reporting requires linking each inbound shipment to its carrier record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving logistics expenses are charged to a cost center for freight and handling cost accounting.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the destination warehouse node where this inbound shipment will be received and processed. Links to warehouse node master data.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Inbound shipments must satisfy import/export regulations; linking provides the Regulatory Compliance audit of shipments.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Attributes inbound shipments to the seller for logistics performance metrics and SLA tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor sending this inbound shipment. Links to the supplier master data.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the inbound shipment physically arrived at the destination warehouse receiving dock. Captured by WMS gate check-in.',
    `appointment_number` STRING COMMENT 'Unique identifier for the scheduled receiving appointment in the warehouse dock scheduling system. Links to yard management system.. Valid values are `^APT[0-9]{8,12}$`',
    `asn_reference_number` STRING COMMENT 'External reference number from the Advanced Shipping Notice document provided by the supplier or origin facility. Used for cross-system reconciliation and tracking.. Valid values are `^ASN[0-9]{10,15}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound shipment record was administratively closed in the system. All discrepancies resolved and inventory posted to general ledger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inbound shipment record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated value amount. Standard currency representation for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_notes` STRING COMMENT 'Free-text description of discrepancies found during receiving process. Provides detailed context for exception resolution and supplier communication.',
    `discrepancy_type` STRING COMMENT 'Classification of the primary discrepancy detected during receiving. Used for root cause analysis and supplier performance tracking.. Valid values are `quantity_shortage|quantity_overage|damaged_goods|wrong_sku|missing_documentation|quality_issue`',
    `dock_door_number` STRING COMMENT 'Physical dock door or bay number where this inbound shipment was received. Used for warehouse operations tracking and labor assignment.. Valid values are `^[A-Z0-9]{1,10}$`',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the inventory in this inbound shipment. Used for insurance coverage and customs declaration purposes.',
    `expected_arrival_date` DATE COMMENT 'Planned date when the inbound shipment is expected to arrive at the destination warehouse node. Used for dock scheduling and labor planning.',
    `has_discrepancy_flag` BOOLEAN COMMENT 'Boolean indicator whether any discrepancies were detected during receiving process. Triggers exception handling workflow when true.',
    `hazmat_class` STRING COMMENT 'UN hazard classification code for dangerous goods in this shipment. Determines storage location and handling procedures.. Valid values are `^[1-9](.[1-6])?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator whether this inbound shipment contains hazardous materials requiring special handling and regulatory compliance.',
    `inspection_status` STRING COMMENT 'Current status of quality inspection process for this inbound shipment. Determines whether inventory can be released to available stock.. Valid values are `not_required|pending|in_progress|passed|failed|conditional_pass`',
    `origin_location_code` STRING COMMENT 'Code identifying the origin facility, warehouse, or distribution center from which the shipment was dispatched. May be a supplier facility or internal transfer origin.. Valid values are `^[A-Z0-9]{3,10}$`',
    `po_reference_number` STRING COMMENT 'Reference to the originating purchase order that triggered this inbound shipment. Links procurement to receiving workflows.. Valid values are `^PO[0-9]{8,12}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this inbound shipment. Determines receiving sequence and resource allocation in the warehouse.. Valid values are `critical|high|normal|low`',
    `receiving_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when all items in the inbound shipment have been physically received, inspected, and put away into inventory locations. Marks completion of receiving workflow.',
    `receiving_start_timestamp` TIMESTAMP COMMENT 'Timestamp when warehouse personnel began the physical receiving process for this inbound shipment. Marks transition from arrived to receiving status.',
    `requires_inspection_flag` BOOLEAN COMMENT 'Boolean indicator whether this inbound shipment requires quality inspection before inventory availability. Applies to regulated products or high-value items.',
    `seal_intact_flag` BOOLEAN COMMENT 'Boolean indicator whether the security seal was intact upon arrival. False value triggers security investigation and enhanced inspection.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer. Verified at receiving to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `shipment_method` STRING COMMENT 'Transportation mode used for this inbound shipment. Determines handling requirements and expected transit times.. Valid values are `FTL|LTL|parcel|air_freight|ocean_freight|intermodal`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the inbound shipment. Tracks progression from scheduling through final closure in the warehouse management system. [ENUM-REF-CANDIDATE: scheduled|in_transit|arrived|receiving|received|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the inbound shipment based on its business purpose. Determines receiving workflow and inventory accounting treatment.. Valid values are `purchase_order|transfer|return|consignment|sample`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator whether this inbound shipment requires temperature-controlled handling. Applies to cold chain and perishable goods.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Excursions trigger quality hold and investigation.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance verification.',
    `total_carton_count` STRING COMMENT 'Total number of cartons or cases in this inbound shipment. Used for receiving verification and discrepancy detection.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets or handling units in this inbound shipment. Used for dock space planning and material handling resource allocation.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs included in this inbound shipment. Used for receiving planning and quality control sampling.',
    `total_unit_count` STRING COMMENT 'Total number of individual units across all SKUs in this inbound shipment. Represents the sum of all line-level quantities.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the inbound shipment in cubic meters. Used for warehouse space planning and transportation optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the inbound shipment in kilograms. Used for freight cost validation and warehouse capacity planning.',
    `tracking_number` STRING COMMENT 'Unique tracking number assigned by the carrier for real-time shipment visibility and proof of delivery. Used for integration with carrier tracking APIs.. Valid values are `^[A-Z0-9]{10,35}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inbound shipment record was last modified. Tracks data currency and supports change data capture processes.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Transactional record tracking an inbound shipment of inventory from a supplier or transfer origin en route to a warehouse node. Captures ASN (Advanced Shipping Notice) reference, carrier, tracking number, origin location, destination warehouse node, expected arrival date, actual arrival date, total SKU count, total unit count, shipment status (in-transit, arrived, receiving, closed), and discrepancy flags. Bridges procurement and inventory receiving workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key for investigation',
    `related_investigation_id` BIGINT COMMENT 'Self-referencing FK on investigation (related_investigation_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation record was first inserted.',
    `investigation_description` STRING COMMENT 'Detailed narrative explaining the investigation scope and rationale.',
    `effective_from` DATE COMMENT 'Start date from which the investigation definition is valid.',
    `effective_until` DATE COMMENT 'End date after which the investigation definition is no longer valid (nullable for open‑ended).',
    `investigation_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the investigation type.',
    `investigation_name` STRING COMMENT 'Descriptive name of the investigation used in reports and UI.',
    `investigation_type` STRING COMMENT 'Classification of the investigation purpose or trigger.',
    `is_mandatory` BOOLEAN COMMENT 'True if the investigation must be performed for the associated process.',
    `owner_department` STRING COMMENT 'Organizational unit responsible for maintaining the investigation record.',
    `priority_level` STRING COMMENT 'Indicates the urgency assigned to the investigation type.',
    `related_process` STRING COMMENT 'Name of the operational process that can initiate this investigation.',
    `investigation_status` STRING COMMENT 'Indicates whether the investigation type is currently in use.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the investigation record.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Master reference table for investigation. Referenced by investigation_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `parent_zone_id` BIGINT COMMENT 'Identifier of the parent zone for hierarchical zone structures.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse to which this zone belongs.',
    `access_restriction_level` STRING COMMENT 'Security level required to access the zone.',
    `aisle_number` STRING COMMENT 'Alphanumeric identifier of the aisle containing the zone.',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the zone measured in square feet.',
    `climate_zone` STRING COMMENT 'Specific climate classification of the zone for inventory handling.',
    `zone_code` STRING COMMENT 'External code used to reference the zone in WMS and operational processes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created in the system.',
    `zone_description` STRING COMMENT 'Free‑form description providing additional context about the zone.',
    `effective_from` DATE COMMENT 'Date when the zone became active for inventory operations.',
    `effective_until` DATE COMMENT 'Date when the zone is scheduled to be retired or become inactive (nullable).',
    `floor_number` STRING COMMENT 'Floor level within the warehouse where the zone is located.',
    `humidity_controlled_flag` BOOLEAN COMMENT 'Indicates whether humidity levels are actively controlled in the zone.',
    `humidity_level_percent` DECIMAL(18,2) COMMENT 'Target relative humidity percentage for the zone when humidity control is enabled.',
    `inventory_count` STRING COMMENT 'Number of distinct SKUs currently stored in the zone.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this zone is the default location for new inventory allocations.',
    `is_temperature_monitored` BOOLEAN COMMENT 'Indicates if the zone has real‑time temperature monitoring sensors.',
    `last_inventory_count_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical inventory count performed in the zone.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum total weight the zone can safely hold, expressed in kilograms.',
    `zone_name` STRING COMMENT 'Human‑readable name of the warehouse zone.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational instructions for the zone.',
    `rack_number` STRING COMMENT 'Identifier of the rack or shelving unit within the zone.',
    `safety_stock_flag` BOOLEAN COMMENT 'Marks the zone as designated for safety‑stock inventory.',
    `zone_status` STRING COMMENT 'Current operational status of the zone.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the zone maintains controlled temperature conditions.',
    `zone_type` STRING COMMENT 'Category of activities performed in the zone (e.g., storage, picking).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zone record.',
    `zone_category` STRING COMMENT 'Operational category of the zone based on flow direction and purpose.',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master reference table for zone. Referenced by zone_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ADD CONSTRAINT `fk_inventory_lot_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_primary_stock_warehouse_location_id` FOREIGN KEY (`primary_stock_warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `ecommerce_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `ecommerce_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `ecommerce_ecm`.`inventory`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `ecommerce_ecm`.`inventory`.`investigation`(`investigation_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `ecommerce_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_primary_transfer_warehouse_node_id` FOREIGN KEY (`primary_transfer_warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `ecommerce_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ADD CONSTRAINT `fk_inventory_replenishment_rule_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ADD CONSTRAINT `fk_inventory_snapshot_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ADD CONSTRAINT `fk_inventory_snapshot_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ADD CONSTRAINT `fk_inventory_sku_velocity_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `ecommerce_ecm`.`inventory`.`lot`(`lot_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ADD CONSTRAINT `fk_inventory_quarantine_record_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ADD CONSTRAINT `fk_inventory_hold_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ADD CONSTRAINT `fk_inventory_inbound_shipment_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`investigation` ADD CONSTRAINT `fk_inventory_investigation_related_investigation_id` FOREIGN KEY (`related_investigation_id`) REFERENCES `ecommerce_ecm`.`inventory`.`investigation`(`investigation_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `ecommerce_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Image Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `atp_qty` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `bin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `cycle_count_variance_qty` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `damaged_qty` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply (DOS)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `dsr_30d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) — 30-Day Rolling Average');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `dsr_7d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) — 7-Day Rolling Average');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `dsr_90d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) — 90-Day Rolling Average');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Expiry Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `in_transit_qty` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Ownership Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_ownership_type` SET TAGS ('dbx_value_regex' = 'first_party|third_party_fba|consignment|dropship|vendor_managed');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|quarantined|suspended|archived');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `is_oos` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Serialized Inventory Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Movement Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'physical_warehouse|virtual_location|dropship_node|store_backroom|3pl_facility');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_tracking_method` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_tracking_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|fefo|none');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `max_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_since_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Since Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `peak_dsr` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Sales Rate (DSR)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `quarantined_qty` SET TAGS ('dbx_business_glossary_term' = 'Quarantined Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time (Days)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `reserved_qty` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `seasonal_velocity_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Velocity Index');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_condition` SET TAGS ('dbx_business_glossary_term' = 'Stock Condition / Physical State');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_condition` SET TAGS ('dbx_value_regex' = 'on_hand|allocated|quarantined|damaged|in_transit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `velocity_recalculated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Velocity Last Recalculation Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `velocity_tier` SET TAGS ('dbx_business_glossary_term' = 'Velocity Tier Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `velocity_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `accessibility_type` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `accessibility_type` SET TAGS ('dbx_value_regex' = 'manual|forklift|reach_truck|conveyor|automated');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `aisle_code` SET TAGS ('dbx_business_glossary_term' = 'Aisle Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `aisle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Location Barcode');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,40}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `bin_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_value_regex' = 'units|pallets|cases|kg|cubic_meters');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `dedicated_sku` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Class');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Height (cm)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `is_bulk_storage` SET TAGS ('dbx_business_glossary_term' = 'Is Bulk Storage Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `is_hazmat_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Materials (Hazmat) Approved Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `is_pick_face` SET TAGS ('dbx_business_glossary_term' = 'Is Pick Face Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `is_quarantine` SET TAGS ('dbx_business_glossary_term' = 'Is Quarantine Location Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Location Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Length (cm)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `level_number` SET TAGS ('dbx_business_glossary_term' = 'Level Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|reserved|under_maintenance');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'pick_face|bulk_storage|receiving_dock|returns_area|virtual|staging');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `lot_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `max_fill_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fill Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Capacity (kg)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `min_fill_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fill Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `mixed_sku_allowed` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `pick_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Putaway Strategy');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'fixed|floating|directed|nearest_empty');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rack_code` SET TAGS ('dbx_business_glossary_term' = 'Rack Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rack_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Strategy');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `replenishment_strategy` SET TAGS ('dbx_value_regex' = 'fifo|lifo|fefo|manual|none');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `shelf_code` SET TAGS ('dbx_business_glossary_term' = 'Shelf Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `shelf_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `slotting_velocity_class` SET TAGS ('dbx_business_glossary_term' = 'Slotting Velocity Class');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `slotting_velocity_class` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Width (cm)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Reference');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `fifo_sequence` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Sequence');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lifo_sequence` SET TAGS ('dbx_business_glossary_term' = 'Last In First Out (LIFO) Sequence');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'available|quarantine|hold|expired|recalled|depleted');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'standard|perishable|regulated|hazmat|serialized');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|reject');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `storage_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|hazmat|high_value');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `primary_stock_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `adjustment_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `is_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Is Financial Impact');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `is_system_initiated` SET TAGS ('dbx_business_glossary_term' = 'Is System Initiated');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|completed|cancelled|failed');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|adjustment|return|write_off');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'approved|quarantine|rejected|inspection_pending');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Movement Value');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `wms_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Transaction ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `wms_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,30}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `stock_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Allocation ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `pick_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Wave ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'order_management|manual|replenishment|pre-order|backorder');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'hard|soft|pre-allocation|reservation');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|used|damaged|returned');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packed Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipped Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `current_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `dsr` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `forecast_demand` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `lot_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modification Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'fixed_order_quantity|fixed_period|min_max|economic_order_quantity|just_in_time');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^RO-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_value_regex' = 'automatic|manual|emergency|seasonal|promotional|transfer');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|ERP|IPS|MANUAL');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Order Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `total_order_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `inventory_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Goods Receipt ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `accepted_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Unit Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Reference Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `expected_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Unit Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `inspection_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Putaway Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|partial|not_required');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receipt_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receipt_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `recorded_temperature` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (Celsius)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `rejected_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Unit Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Container Seal Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'full_container|parcel|pallet|bulk');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `total_receipt_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Receipt Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `total_receipt_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inventory_goods_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `adjustment_posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `assigned_counter_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Counter Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `assigned_counter_user_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Counter ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Count Duration Minutes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|rfid|barcode_scan|automated');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'scheduled|assigned|in_progress|completed|reconciled|cancelled');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|partial|abc|blind|spot');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `inventory_value_variance` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Variance');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `inventory_value_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Count Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PL|BX|KG|LB');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Value');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|reversed');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `authorized_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Authorized By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `authorized_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `authorized_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,8}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}(-[A-Z0-9]{2,6}){0,3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `quantity_after_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Quantity After Adjustment');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `quantity_before_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Quantity Before Adjustment');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{2,4}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|ERP|manual_entry|cycle_count_app|mobile_scanner');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `primary_transfer_warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancelled_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancelled_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancelled_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Dock Transfer');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{6,15}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `picked_date` SET TAGS ('dbx_business_glossary_term' = 'Picked Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|rail|intermodal|courier');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipped_date` SET TAGS ('dbx_business_glossary_term' = 'Shipped Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_location_code` SET TAGS ('dbx_business_glossary_term' = 'Source Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_value_regex' = '^TO-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'replenishment|rebalancing|returns_processing|consolidation|emergency|seasonal');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|box|unit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Event ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `actual_replenishment_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Replenishment Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `affected_order_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Order Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `customer_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Score');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `demand_spike_factor` SET TAGS ('dbx_business_glossary_term' = 'Demand Spike Factor');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `detected_by` SET TAGS ('dbx_business_glossary_term' = 'Detected By');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `detected_by` SET TAGS ('dbx_value_regex' = 'automated_system|manual_audit|customer_complaint|warehouse_staff|demand_planner');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `dsr_at_oos` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) at Out-of-Stock (OOS)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Revenue');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `forecast_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `inventory_level_at_oos` SET TAGS ('dbx_business_glossary_term' = 'Inventory Level at Out-of-Stock (OOS)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'physical_warehouse|virtual_location|fulfillment_center|distribution_center|cross_dock|store');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `lost_unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Lost Unit Sales');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Duration Hours');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) End Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_status` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_status` SET TAGS ('dbx_value_regex' = 'active|resolved|pending_replenishment|cancelled');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `promotional_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_value_regex' = 'emergency_replenishment|supplier_expedite|inventory_transfer|customer_notification|substitute_offered|backorder_created');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'demand_spike|replenishment_delay|supplier_stockout|forecast_miss|system_error|quality_hold');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `seasonality_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`oos_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `replenishment_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Rule ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenishment Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `dsr_baseline` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) Baseline');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `holding_cost_per_unit_per_day` SET TAGS ('dbx_business_glossary_term' = 'Holding Cost Per Unit Per Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `holding_cost_per_unit_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `last_recalculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recalculation Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_value_regex' = 'fixed_order_quantity|economic_order_quantity|lot_for_lot|period_order_quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Rule Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity (ROQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'min_max|fixed_period|demand_driven|economic_order_quantity|just_in_time|continuous_review');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `replenishment_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Rule Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `replenishment_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|archived');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Rule Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|fixed|seasonal|service_level|demand_variability');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days of Cover');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `service_level_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`replenishment_rule` ALTER COLUMN `supplier_lead_time_variability` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time Variability');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `safety_stock_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Rule ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `average_daily_demand` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `calculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Calculation Frequency');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `calculation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|fixed|seasonal|dynamic|min_max|service_level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `demand_forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Horizon Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `holding_cost_per_unit_per_day` SET TAGS ('dbx_business_glossary_term' = 'Holding Cost Per Unit Per Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `holding_cost_per_unit_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `is_promotional_product` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Product Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `is_seasonal_product` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Product Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `last_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calculation Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `priority_classification` SET TAGS ('dbx_business_glossary_term' = 'Priority Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `priority_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `review_period_days` SET TAGS ('dbx_business_glossary_term' = 'Review Period Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Rule Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|expired');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `safety_stock_days_of_cover` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days of Cover');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `service_level_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `supplier_reliability_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reliability Score');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Snapshot ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `days_of_cover` SET TAGS ('dbx_business_glossary_term' = 'Days of Cover');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `dsr` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `fifo_cost_layer_reference` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Cost Layer ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'physical_warehouse|virtual_warehouse|cross_dock|store|vendor_managed');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `replenishment_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `replenishment_status` SET TAGS ('dbx_value_regex' = 'adequate|low|critical|overstocked|pending_order');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'end_of_day|end_of_week|end_of_month|end_of_quarter|end_of_year|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Source System');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|ERP|OMS|manual_count|third_party');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`snapshot` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Address Line 1');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Address Line 2');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Capacity Square Feet');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `carrier_codes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Supported Carrier Codes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node City');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `commissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Commissioned Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Country Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Decommissioned Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `dock_doors_inbound` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Inbound Dock Doors');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `dock_doors_outbound` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Outbound Dock Doors');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `fulfillment_model` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Model');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `fulfillment_model` SET TAGS ('dbx_value_regex' = 'fba_style|bopis|dtc|b2b|omnichannel|cross_dock');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^d{13}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_24hr_operation` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node 24-Hour Operation Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_3pl` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Node Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_cold_storage` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Cold Storage Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Hazmat Certified Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_returns_enabled` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Returns Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Virtual Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Latitude');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Lease Expiry Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Longitude');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `max_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Maximum Weight Capacity Kilograms');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Network Tier');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|spoke|hub');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|decommissioned|planned');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'fulfillment_center|distribution_center|dark_store|3pl_facility|drop_ship_node|returns_center');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `operating_days` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Operating Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Operating Hours End');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Operating Hours Start');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Pallet Positions');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Postal Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Region Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node State or Province');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Maximum Temperature Celsius');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Minimum Temperature Celsius');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Timezone');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `tms_location_code` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `wms_facility_reference` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Facility ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `sku_velocity_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Velocity ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `active_promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Promotion Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `bsr_category` SET TAGS ('dbx_business_glossary_term' = 'Best Seller Rank (BSR) Category');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `bsr_rank` SET TAGS ('dbx_business_glossary_term' = 'Best Seller Rank (BSR)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `data_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Velocity Data Window Start Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply (DOS)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `dsr_30d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) - 30-Day Rolling');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `dsr_7d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) - 7-Day Rolling');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `dsr_90d` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Rate (DSR) - 90-Day Rolling');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `fulfillment_model` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Model');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `fulfillment_model` SET TAGS ('dbx_value_regex' = 'FBA|FBM|3PL|DTC|BOPIS');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `is_seasonal_sku` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Stock Keeping Unit (SKU) Indicator');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `net_dsr_30d` SET TAGS ('dbx_business_glossary_term' = 'Net Daily Sales Rate (DSR) - 30-Day (After Returns)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `oos_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Risk Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `peak_dsr` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Sales Rate (DSR)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `peak_dsr_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Sales Rate (DSR) Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `prior_velocity_tier` SET TAGS ('dbx_business_glossary_term' = 'Prior Velocity Tier Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `prior_velocity_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `promotion_velocity_uplift` SET TAGS ('dbx_business_glossary_term' = 'Promotion Velocity Uplift Multiplier');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `recalculation_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Velocity Recalculation Frequency (Hours)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `replenishment_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency (Days)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `return_rate_30d` SET TAGS ('dbx_business_glossary_term' = 'Return Rate - 30-Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = 'SPRING|SUMMER|FALL|WINTER|HOLIDAY|YEAR_ROUND');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `seasonal_velocity_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Velocity Index');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `slotting_zone` SET TAGS ('dbx_business_glossary_term' = 'Slotting Zone Assignment');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `slotting_zone` SET TAGS ('dbx_value_regex' = 'prime|forward|reserve|bulk|overflow');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `tier_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Velocity Tier Change Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `tier_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Velocity Tier Changed Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `units_sold_30d` SET TAGS ('dbx_business_glossary_term' = 'Units Sold - 30-Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `units_sold_7d` SET TAGS ('dbx_business_glossary_term' = 'Units Sold - 7-Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `units_sold_90d` SET TAGS ('dbx_business_glossary_term' = 'Units Sold - 90-Day');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_recalculated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Velocity Recalculated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_status` SET TAGS ('dbx_business_glossary_term' = 'Velocity Record Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_review');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_tier` SET TAGS ('dbx_business_glossary_term' = 'Velocity Tier Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_trend` SET TAGS ('dbx_business_glossary_term' = 'Velocity Trend');
ALTER TABLE `ecommerce_ecm`.`inventory`.`sku_velocity` ALTER COLUMN `velocity_trend` SET TAGS ('dbx_value_regex' = 'accelerating|stable|decelerating|volatile');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_record_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Record ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `affected_order_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Order Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'return_to_stock|destroy|return_to_supplier|donate|rework|scrap');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `disposition_quantity` SET TAGS ('dbx_business_glossary_term' = 'Disposition Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `hold_authority_contact` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority Contact');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `hold_authority_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `hold_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `hold_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `hold_authority_type` SET TAGS ('dbx_value_regex' = 'qa_team|regulatory_body|supplier|warehouse_manager|customer_service');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|not_applicable');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'visual|functional|laboratory|regulatory|third_party');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine End Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quarantine End Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason Description');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Start Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'active|under_inspection|resolved|released|disposed');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `quarantined_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantined Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`quarantine_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `atp_impact_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Impact Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `authority` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `authority_contact` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority Contact');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `authority_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `authority_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `cpsc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'return_to_stock|destroy|return_to_supplier|donate|rework|scrap');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Hold End Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold End Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|pending_review|released|expired|cancelled');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|not_applicable');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `resolution_timeline_days` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timeline Days');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `stock_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `adjustment_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cogs_allocated` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Allocated');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cost_layer_sequence` SET TAGS ('dbx_business_glossary_term' = 'Cost Layer Sequence');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `costing_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `costing_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|weighted_average|standard_cost|moving_average');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `duty_cost` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `handling_cost` SET TAGS ('dbx_business_glossary_term' = 'Handling Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantined|damaged|in_transit|obsolete');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `landed_cost_included` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost Included Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `layer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Layer Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `layer_value` SET TAGS ('dbx_business_glossary_term' = 'Layer Value');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `revaluation_flag` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliant Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `updated_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'active|consumed|adjusted|written_off|transferred');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_value_regex' = '^APT[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Reference Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `asn_reference_number` SET TAGS ('dbx_value_regex' = '^ASN[0-9]{10,15}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Closed Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity_shortage|quantity_overage|damaged_goods|wrong_sku|missing_documentation|quality_issue');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `has_discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Has Discrepancy Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional_pass');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `po_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Reference Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `po_reference_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `receiving_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `receiving_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `requires_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Inspection Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Container Seal Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'FTL|LTL|parcel|air_freight|ocean_freight|intermodal');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'purchase_order|transfer|return|consignment|sample');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius (°C)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius (°C)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (m³)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (kg)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`inbound_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`investigation` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `ecommerce_ecm`.`inventory`.`investigation` ALTER COLUMN `related_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`zone` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
