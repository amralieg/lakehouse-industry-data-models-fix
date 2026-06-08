-- Schema for Domain: inventory | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`inventory` COMMENT 'SSOT for stock positions across all warehouse nodes and virtual locations. Manages SKU-level inventory records, stock allocation, replenishment planning, safety stock, OOS tracking, FIFO/LIFO lot tracking, cycle counting, MOQ rules, DSR metrics, and real-time inventory visibility. Integrates with WMS for inventory control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique surrogate identifier for the stock position record representing a SKU at a specific warehouse node or virtual location. Primary key of this entity.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Enables PO‑level stock traceability for recall, cost allocation and supplier performance dashboards.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller who owns this inventory. Null for first-party (1P) inventory owned by the platform operator.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU whose inventory position is being tracked. Links to the product catalog master record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Provides supplier‑wise inventory health reporting and compliance checks, a core e‑commerce operational need.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: A stock position is physically stored at a specific bin/shelf location within a warehouse node. The existing bin_location_code (STRING) on stock_position is a denormalized reference to warehouse_locat',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the physical or virtual warehouse node (fulfillment center, dark store, 3PL facility, virtual location) where this stock position is held.',
    `atp_qty` STRING COMMENT 'Net units available for new order commitments, calculated as on_hand_qty minus reserved_qty minus quarantined_qty. The ATP quantity is the real-time sellable inventory figure exposed to the storefront and OMS for order promising.',
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
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Warehouse slotting operations assign fixed locations to specific SKUs (fixed-slot putaway strategy). The existing plain-text dedicated_sku column is a denormalized SKU reference; replacing it with a',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the parent warehouse node that contains this storage location. Used to scope location records to a specific fulfillment center or distribution node.',
    `accessibility_type` STRING COMMENT 'Equipment or method required to access this storage location. Determines which picking and putaway resources the WMS can assign to tasks involving this location. Automated locations are served by Automated Storage and Retrieval Systems (AS/RS).. Valid values are `manual|forklift|reach_truck|conveyor|automated`',
    `aisle_code` STRING COMMENT 'Identifier for the aisle within the warehouse zone where this location is physically situated. Used by WMS for pick-path optimization and travel-time minimization in fulfillment operations.. Valid values are `^[A-Z0-9]{1,10}$`',
    `barcode` STRING COMMENT 'Barcode value printed on the physical label affixed to this storage location. Scanned by warehouse operatives using handheld devices or fixed scanners during pick, putaway, and cycle count operations to confirm location identity.. Valid values are `^[A-Z0-9-]{4,40}$`',
    `bin_code` STRING COMMENT 'Identifier for the individual bin or slot within the shelf. The most granular physical unit of the warehouse location hierarchy. Directly maps to a scannable barcode label affixed to the physical bin in the warehouse.. Valid values are `^[A-Z0-9]{1,10}$`',
    `capacity_uom` STRING COMMENT 'Unit of measure in which the capacity of this storage location is expressed. Aligns with the WMS capacity management configuration for the warehouse node (e.g., pallets for bulk storage, units for pick-face bins, kg for weight-constrained locations).. Valid values are `units|pallets|cases|kg|cubic_meters`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse location master record was first created in the system. Provides audit trail for record provenance and supports data lineage tracking in the Databricks Silver Layer.',
    `cycle_count_frequency_days` STRING COMMENT 'Target number of days between cycle counts for this location. Drives the WMS cycle count scheduling engine. High-velocity or high-value locations typically have shorter intervals (e.g., 7 days) while low-velocity locations may be counted quarterly (e.g., 90 days).',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement audit trail.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to inventory.adjustment. Business justification: When an inventory adjustment is processed, a corresponding stock movement record is created as the audit trail of the quantity change. Linking stock_movement to adjustment enables direct traceability ',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or 3PL provider involved in the movement, applicable for inbound receipts and inter-warehouse transfers. Null for internal movements.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Carrier performance reporting and freight cost allocation: stock movements (inbound receipts, outbound transfers) use specific carrier service levels. Existing FK covers carrier but not service. Opera',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the inventory movement, used for internal cost allocation and profitability analysis. Particularly relevant for issue and consumption transactions.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse location, bin, or virtual location to which inventory is being moved. Null for issue transactions leaving the warehouse network or write-off transactions.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Financially-impactful stock movements (receipts, issues, write-offs) post to GL accounts for inventory valuation under FIFO/WAC costing. is_financial_impact and gl_posting_date confirm this process. g',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Inbound stock movements (type: goods receipt) are directly triggered by a procurement GR. Linking enables end-to-end traceability: PO → GR → stock movement → stock position. Required for three-way mat',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each financially-impactful stock movement generates a journal entry for inventory accounting (goods receipt, goods issue, transfer posting). erp_document_number references this JE. Direct FK enables r',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Inventory audit and COGS reporting require tracing stock depletion movements (picks, shipments) to specific order lines. Regulatory inventory accounting and shrinkage analysis depend on this link. ref',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Inbound goods receipt reconciliation: stock movements for inbound receipts must be traceable to the logistics shipment that delivered the goods. Warehouse operations and finance teams use this link to',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order_line. Business justification: In e-commerce WMS operations, pick and pack stock movements are line-level events tied to a specific fulfillment_order_line. Line-level pick confirmation, short-pick exception handling, and inventory ',
    `payment_refund_id` BIGINT COMMENT 'Foreign key linking to payment.payment_refund. Business justification: Returns reconciliation process: when a customer return is received at the warehouse, a stock movement (inbound return) is recorded alongside a payment refund. This FK enables direct tracing of physica',
    `primary_stock_warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse location, bin, or virtual location from which inventory is being moved. Null for receipt transactions originating outside the warehouse network.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to service.rma. Business justification: Return-type stock movements are directly caused by RMA processing. Linking stock_movement.rma_id → rma.rma_id enables reverse logistics reporting, financial reconciliation of returned goods, and audit',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Required for Stock Movement Audit Report per seller to track inventory changes attributable to each seller.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for inventory transaction reporting; linking movement records to product SKU details (price, dimensions, compliance) is essential for audit and fulfillment.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Every stock movement event affects a specific stock position (the SKU+warehouse_node combination that is the SSOT for current inventory). Linking stock_movement directly to stock_position enables dire',
    `transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.transfer_order. Business justification: A transfer order (inter-warehouse or inter-location movement) generates stock movement records — an outbound movement from the source and an inbound movement at the destination. Linking stock_movement',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where the movement occurred. Supports multi-site inventory management and regional stock visibility.',
    `adjustment_reason_notes` STRING COMMENT 'Free-text explanation for manual adjustments, write-offs, or variance corrections. Required for audit trail completeness and regulatory compliance. Captures business context not conveyed by reason code alone.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was first created in the database. Used for audit trail and data lineage tracking. Distinct from movement_timestamp which represents the business event time.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the movement value. Supports multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `erp_document_number` STRING COMMENT 'Material document or goods movement document number generated by the ERP system (e.g., SAP material document). Used for cross-system reconciliation and audit trail.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date for perishable or time-sensitive inventory. Used for FEFO (First Expired First Out) picking logic and automated expiry write-off processing. Null for non-perishable items.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional stock reservation: e-commerce operations reserve inventory specifically for flash sales and promotional campaigns. Linking stock_allocation to campaign enables tracking of inventory consum',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocation charge‑back report requires each stock allocation to be charged to a cost center for internal expense tracking.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Required for the Fulfillment Order creation process that reserves inventory for each order line, enabling real‑time allocation tracking.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Reference to the shipment that will fulfill this allocation. Links allocation to outbound logistics.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Pick/pack/ship operations require knowing which order line each stock allocation serves. Warehouse management systems link allocations to order lines for wave planning, SLA tracking, and fulfillment s',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order_line. Business justification: Stock allocations in e-commerce OMS/WMS are line-level — each order line gets its own allocation record for partial fulfillment, substitution tracking, and pick confirmation. stock_allocation already ',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Marketplace inventory allocation is seller-specific. Seller reconciliation reports, fulfillment SLA tracking, and dispute resolution require knowing which sellers inventory is allocated. Direct FK en',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Allocation engine needs SKU attributes (weight, hazardous flag) to calculate pick plans and reserve inventory accurately.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: A stock allocation reserves a specific quantity from a specific stock position (SKU at a warehouse node). Linking stock_allocation directly to stock_position enables position-level allocation tracking',
    `transfer_order_id` BIGINT COMMENT 'Reference to an inter-warehouse transfer order if this allocation is for inventory movement between facilities.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: A stock allocation is picked from a specific physical warehouse location (bin/shelf). The existing warehouse_location_code (STRING) on stock_allocation is a denormalized reference to warehouse_locatio',
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
    CONSTRAINT pk_stock_allocation PRIMARY KEY(`stock_allocation_id`)
) COMMENT 'Transactional record linking a specific quantity of inventory to a fulfillment demand (order line, reservation, or pre-allocation). Tracks allocated SKU, warehouse location, lot, allocated quantity, allocation type (hard/soft), allocation status, expiry timestamp, and the originating order or transfer reference. Ensures ATP accuracy and prevents overselling by managing the reserved inventory pool.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the inventory adjustment transaction. Primary key.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Inventory adjustments (shrinkage, damage, cycle-count variances) post to specific GL accounts for inventory valuation and financial reporting. Finance teams require this link for P&L impact analysis a',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Inventory adjustments are frequently triggered by GR discrepancies (over/under delivery, quality rejections). Linking enables audit trail from GR discrepancy → inventory adjustment, supports three-way',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every posted inventory adjustment generates a journal entry for inventory write-down or variance accounting. posted_to_gl_flag and gl_posting_date confirm financial posting occurs; linking to the actu',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment transaction being reversed, if this record is a reversal. Maintains audit trail for corrections.',
    `payment_refund_id` BIGINT COMMENT 'Foreign key linking to payment.payment_refund. Business justification: Returns reconciliation and financial audit: when a customer return triggers both an inventory adjustment (restocking/write-off) and a payment refund, this FK links the two events. E-commerce finance t',
    `rma_line_id` BIGINT COMMENT 'Foreign key linking to service.rma_line. Business justification: Inventory adjustments for scrap, write-off, or restocking are triggered by specific RMA line dispositions. adjustment has external_reference_number (denormalized reference) but no FK to rma_line. Retu',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Inventory adjustments (cycle count variances, damage write-offs) in a marketplace directly affect seller-owned stock. Seller financial settlement, GMV reconciliation, and dispute resolution processes ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inventory adjustments (cycle count variances, damage write-offs, shrinkage) are performed at SKU level. Audit trails, shrinkage reports, and COGS reconciliation all require direct SKU attribution on e',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: An inventory adjustment corrects the quantity or value of a specific stock position (SKU at a warehouse node). Linking adjustment directly to stock_position establishes the authoritative in-domain rel',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: An inventory adjustment is performed at a specific warehouse location (bin/shelf level). The existing location_code (STRING) on adjustment is a denormalized reference to warehouse_location.location_co',
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
    `gl_posting_date` DATE COMMENT 'The accounting period date when the adjustment was posted to the General Ledger. May differ from adjustment_timestamp due to period-end cutoffs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was last updated. Supports change tracking and audit compliance.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for inventory tracking under First In First Out (FIFO) or Last In First Out (LIFO) methodologies. Critical for expiry management and recall traceability.. Valid values are `^LOT-[A-Z0-9]{6,20}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, investigation findings, or operational details related to the adjustment. Supports audit and compliance documentation.',
    `posted_to_gl_flag` BOOLEAN COMMENT 'Indicates whether the adjustment has been posted to the financial General Ledger. True when the financial impact has been recorded in the ERP system.',
    `quantity_after_adjustment` DECIMAL(18,2) COMMENT 'The resulting on-hand inventory quantity after the adjustment is applied. Calculated as quantity_before_adjustment + adjusted_quantity.',
    `quantity_before_adjustment` DECIMAL(18,2) COMMENT 'The on-hand inventory quantity recorded in the system immediately prior to the adjustment. Provides audit trail for variance analysis.',
    `reason_code` STRING COMMENT 'Detailed reason code providing granular classification for the adjustment. Used for root cause analysis and loss prevention reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{2,4}$`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previously posted adjustment. True when correcting an erroneous prior adjustment.',
    `source_system` STRING COMMENT 'The originating system or interface that created the adjustment record. Supports data lineage and integration troubleshooting.. Valid values are `WMS|ERP|manual_entry|cycle_count_app|mobile_scanner`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The per-unit cost of the SKU at the time of adjustment, used to calculate the financial impact. Sourced from the Enterprise Resource Planning (ERP) systems inventory valuation layer.',
    `unit_of_measure` STRING COMMENT 'The unit in which the adjusted quantity is expressed. Must align with the SKUs base UOM in the Product Information Management (PIM) system. [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Transactional record documenting a manual or system-initiated correction to stock quantity or value at a specific location and lot. Captures adjustment reason (shrinkage, damage, count variance, system error, expiry write-off), adjusted quantity (positive or negative), adjusted value, authorizing user, and reference to the originating cycle count or investigation. Provides the financial reconciliation trail for inventory write-offs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`transfer_order` (
    `transfer_order_id` BIGINT COMMENT 'Unique identifier for the transfer order. Primary key for the transfer order entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier handling the transfer shipment. Links to carrier master data for tracking and performance analysis.',
    `carrier_rate_card_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_rate_card. Business justification: Freight cost audit and financial reconciliation: transfer orders carry a freight_cost field that must be auditable against the rate card applied. Finance and procurement teams require this link to val',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Freight cost reconciliation and SLA tracking: inter-warehouse transfer orders use specific carrier service levels (LTL, FTL, express). Existing FK covers carrier but not service tier. Operations teams',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inter‑warehouse transfer expenses are allocated to a cost center for internal charge‑back and profitability reporting.',
    `warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center to which inventory is being transferred.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Inter-warehouse transfer orders incur freight costs and inventory revaluation postings to specific GL accounts. Finance teams track transfer costs by GL account for cost allocation reporting. No exist',
    `primary_transfer_warehouse_node_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center from which inventory is being transferred.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to service.rma. Business justification: RMAs frequently trigger transfer orders to move returned goods from receiving warehouses to returns processing or refurbishment centers. transfer_order has reason_code (plain) but no FK to rma. Revers',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Needed for Transfer Order Ownership Report, attributing inter‑warehouse transfers to the responsible seller.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Transfer orders move inventory of a particular SKU between warehouses; FK enables validation of SKU attributes and regulatory flags.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: A transfer order moves inventory FROM a specific source warehouse location (bin/shelf). The existing source_location_code (STRING) on transfer_order is a denormalized reference to warehouse_location.l',
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

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` (
    `safety_stock_rule_id` BIGINT COMMENT 'Unique identifier for the safety stock rule record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional inventory planning: e-commerce operations teams create or override safety stock rules ahead of specific campaigns (e.g., Prime Day, Black Friday). Linking safety_stock_rule to campaign ena',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safety‑stock calculations allocate holding cost to a cost center, needed for cost‑of‑goods‑sold and inventory valuation reports.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Seller scorecards track inventory_health_score driven by safety stock compliance. Marketplace operations set seller-specific safety stock rules based on seller tier, SLA commitments, and demand patter',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Safety stock rules are defined per SKU for replenishment planning and reorder-point reporting. A domain expert expects a direct sku_id FK on safety_stock_rule to drive SKU-level replenishment decision',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_sla. Business justification: In e-commerce replenishment planning, safety stock targets are calibrated per SLA tier — same-day SLA demands higher safety stock than standard. Planners explicitly align safety_stock_rule parameters ',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: A safety stock rule defines replenishment parameters for a specific SKU at a specific warehouse node — precisely the entity modeled by stock_position. Linking safety_stock_rule to stock_position estab',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Safety stock rules are supplier-specific: lead time variability and reliability differ per supplier. supplier_reliability_score is a denormalized metric from procurement.supplier. Linking enables auto',
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
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated business cost incurred per unit when a stockout occurs, including lost sales, expedited shipping, and customer dissatisfaction.',
    `unit_of_measure` STRING COMMENT 'The unit in which safety stock quantity is expressed (each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|kg|lb|liter|gallon — 7 candidates stripped; promote to reference product]',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution z-score corresponding to the service level target, used in statistical safety stock formulas.',
    CONSTRAINT pk_safety_stock_rule PRIMARY KEY(`safety_stock_rule_id`)
) COMMENT 'Master record defining safety stock parameters for a SKU at a warehouse node, calculated to buffer against demand variability and supply uncertainty. Captures safety stock quantity, safety stock days of cover, calculation method (statistical, fixed, seasonal), demand variability coefficient, supplier lead time variability, service level target percentage, and last recalculation date. Supports dynamic safety stock optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` (
    `warehouse_node_id` BIGINT COMMENT 'Unique surrogate identifier for a warehouse node record in the fulfillment network. Primary key for the warehouse_node master data product.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Carrier contract management: e-commerce fulfillment centers operate under specific carrier contracts governing outbound rates and SLAs. Network operations teams must know which carrier contract applie',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each warehouse node is a cost center for operational expense tracking (labor, utilities, depreciation). Finance reports warehouse P&L by cost center. gl_cost_center_code is a denormalized reference; p',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Warehouses are owned or operated by specific legal entities — critical for multi-entity e-commerce operators, 3PL arrangements, and cross-border fulfillment. Required for tax jurisdiction assignment, ',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `ecommerce_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_primary_stock_warehouse_location_id` FOREIGN KEY (`primary_stock_warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `ecommerce_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `ecommerce_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ADD CONSTRAINT `fk_inventory_stock_allocation_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `ecommerce_ecm`.`inventory`.`adjustment`(`adjustment_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_primary_transfer_warehouse_node_id` FOREIGN KEY (`primary_transfer_warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `ecommerce_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ADD CONSTRAINT `fk_inventory_safety_stock_rule_warehouse_node_id` FOREIGN KEY (`warehouse_node_id`) REFERENCES `ecommerce_ecm`.`inventory`.`warehouse_node`(`warehouse_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_position` ALTER COLUMN `atp_qty` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Sku Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `payment_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `primary_stock_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `adjustment_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_movement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`stock_allocation` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `payment_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Line Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `quantity_after_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Quantity After Adjustment');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `quantity_before_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Quantity Before Adjustment');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{2,4}$');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WMS|ERP|manual_entry|cycle_count_app|mobile_scanner');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `primary_transfer_warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`transfer_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `safety_stock_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Rule ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Sla Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`safety_stock_rule` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node ID');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`inventory`.`warehouse_node` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
