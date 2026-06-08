-- Schema for Domain: inventory | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`inventory` COMMENT 'Real-time and historical stock positions across all stores, distribution centers, and MFCs. Manages on-hand quantities, reserved stock, FIFO/LIFO rotation tracking, shrink records (theft, spoilage, damage), OOS monitoring, cycle counts, cold chain temperature compliance, and CAO replenishment signals. Integrates with WMS, SAP MM, and ERP systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique surrogate key for each stock position record.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Assortment compliance reporting requires knowing whether each assortment item is physically in stock. Linking stock_position to assortment_item enables on-shelf availability vs. assortment plan report',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category‑Level Stock Position Reporting requires each stock position to be tied to its product category for aggregated inventory metrics.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Holding cost allocation ties each stock position to a cost center for budgeting and profitability analysis per store.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Stock position is physically located within a store department; linking enables department‑level inventory visibility.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Stock positions represent on-hand inventory value mapped to balance sheet inventory asset GL accounts. Grocery retailers require stock_position→gl_account for inventory valuation reporting, balance sh',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Active markdown inventory tracking: stock_position must reference any active markdown to support sell-through rate monitoring and markdown effectiveness reporting. Retail-grocery category managers tra',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: PHARMACY STOCK AUDIT: ties each stock position to the pharmacy location for drug inventory compliance and daily stock‑reconciliation reports.',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Planogram compliance reporting — comparing actual on-shelf stock positions against planned positions — is a core grocery retail KPI. On-shelf availability dashboards require linking stock positions to',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional Allocation: inventory positions are earmarked for a campaign to ensure shelf space and display compliance.',
    `reorder_policy_id` BIGINT COMMENT 'Foreign key linking to inventory.reorder_policy. Business justification: stock_position is the real-time inventory position at SKU-location level; reorder_policy defines the replenishment parameters for the same SKU-location combination. Adding reorder_policy_id FK links e',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Perishable clearance and markdown automation: stock_position tracks expiration_date and on_hand_quantity; linking to retail_price enables automated clearance pricing workflows and lost-sales dollar va',
    `sku_id` BIGINT COMMENT 'Internal surrogate key referencing the product (SKU) whose inventory is tracked.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Link stock_position to its physical storage location for precise inventory location tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PROCUREMENT PLANNING: Stock position reports need primary supplier to calculate lead times and order allocation per SKU.',
    `tpr_event_id` BIGINT COMMENT 'Foreign key linking to promotion.tpr_event. Business justification: TPR inventory reservation and available-to-promise calculations require stock positions to reference the active TPR event. Retailers reserve inventory for TPR windows to prevent overselling; stock_pos',
    `available_quantity` DECIMAL(18,2) COMMENT 'Units that can be sold to customers (on‑hand minus reserved).',
    `cold_chain_compliance_flag` BOOLEAN COMMENT 'True when temperature‑controlled items meet required temperature range.',
    `estimated_lost_sales_value` DECIMAL(18,2) COMMENT 'Monetary estimate of sales lost due to the OOS condition.',
    `expiration_date` DATE COMMENT 'Date on which the product expires; applicable to perishable goods.',
    `fifo_lifo_indicator` STRING COMMENT 'Specifies whether the SKU is managed using First‑In‑First‑Out or Last‑In‑First‑Out rotation.. Valid values are `fifo|lifo`',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Units currently being moved between locations (e.g., from DC to store) and not yet on‑hand.',
    `is_perishable` BOOLEAN COMMENT 'True if the SKU is a perishable item requiring special handling.',
    `last_cycle_count_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded during the most recent cycle count.',
    `last_cycle_count_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent physical cycle count for this SKU at the location.',
    `location_type` STRING COMMENT 'Classifies the location as a retail store, distribution center (DC), or micro‑fulfillment center (MFC).. Valid values are `store|distribution_center|micro_fulfillment_center`',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of perishable or regulated items.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Current physical units of the SKU available on the shelf or floor at the location.',
    `on_order_quantity` DECIMAL(18,2) COMMENT 'Units ordered from suppliers but not yet received at any location.',
    `oos_detection_method` STRING COMMENT 'Technique by which the OOS condition was identified.. Valid values are `pos_scan|cao_signal|manual_audit`',
    `oos_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the OOS event expressed in hours.',
    `oos_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the SKU was restocked and the OOS condition ended (null if still OOS).',
    `oos_flag` BOOLEAN COMMENT 'Indicates whether the SKU is currently out of stock at the location.',
    `oos_root_cause` STRING COMMENT 'Categorized reason for the OOS event.. Valid values are `supplier|dc|store_receiving|shrink|demand_spike`',
    `oos_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the out‑of‑stock condition began.',
    `perishable_category` STRING COMMENT 'Sub‑category of perishable items, used for handling and pricing rules.. Valid values are `fresh|frozen|dry|canned`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date‑time when this stock position record was first created in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to this stock position record.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Units allocated to open orders, transfers, or replenishment signals and therefore not sellable.',
    `shrink_quantity` DECIMAL(18,2) COMMENT 'Units lost due to theft, spoilage, damage, or administrative error.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Most recent temperature reading for the location or pallet, in degrees Celsius.',
    `temperature_timestamp` TIMESTAMP COMMENT 'Date‑time when the temperature_celsius value was recorded.',
    `upc_code` STRING COMMENT '12‑digit barcode identifier for the product, used for POS scanning and inventory reconciliation.. Valid values are `^d{12}$`',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Real-time and near-real-time on-hand stock position for every SKU at every location (store, DC, MFC). Captures on-hand quantity, reserved quantity, available-to-sell quantity, in-transit quantity, on-order quantity, and comprehensive OOS tracking: OOS status flag, OOS start timestamp, OOS end timestamp (when restocked), OOS duration in hours, root cause category (supplier OOS, DC OOS, store receiving delay, shrink, demand spike), estimated lost sales value, and OOS detection method (POS scan failure, CAO signal, manual audit). This is the authoritative SSOT for current inventory levels and out-of-stock events across the enterprise, fed by SAP MM goods movements and Manhattan WMS inventory control. Supports OOS monitoring and alerting, CAO replenishment signal generation, omnichannel availability checks, and store operations performance measurement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`goods_movement` (
    `goods_movement_id` BIGINT COMMENT 'System-generated unique identifier for each inventory movement event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Internal movements are charged to a cost center to track transfer costs and support internal charge‑back reporting.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: COGS and inventory valuation audit: goods_movement records every stock transaction with cost_at_movement; linking to cost_price enables cost variance analysis between standard cost and actual movement',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Goods movement often occurs between departments; linking provides departmental movement tracking.',
    `storage_location_id` BIGINT COMMENT 'Location (store, DC, MFC) to which inventory is added.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Inventory movements must be period-stamped for COGS calculation, period-end inventory valuation, and financial close. Grocery retailers associate goods movements with fiscal periods to prevent cross-p',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every inventory goods movement (receipt, adjustment, write-off, transfer) generates a GL posting in grocery ERP systems. goods_movement→gl_account is required for inventory valuation, COGS posting, an',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: goods_receipt (supply-side) triggers goods_movement (inventory-side) — this is the fundamental GR/GI posting in retail ERP systems. The goods_movement records the inventory impact of a goods_receipt. ',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: goods_movement has denormalized `lot_number` (STRING) and `batch_number` (STRING) attributes that are natural keys for the lot_batch master record. Adding lot_batch_id FK normalizes these references t',
    `primary_goods_storage_location_id` BIGINT COMMENT 'Location (store, DC, MFC) from which inventory is removed.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Goods movement (inbound/outbound) is audited against the PO that generated the movement for traceability and audit.',
    `receiving_record_id` BIGINT COMMENT 'Foreign key linking to inventory.receiving_record. Business justification: goods_movement records receipt-type movements (movement_type = RECEIPT, is_physical_inventory = true). receiving_record is the formal inbound receiving document. Adding receiving_record_id FK links ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inventory valuation, shrink reporting, and goods movement audit trails in grocery are produced at SKU level. goods_movement has product_item_id but not sku_id. Movements involving variable-weight or c',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Every goods_movement event affects a specific stock position (on_hand_quantity changes with every receipt, issue, transfer, or adjustment). Adding stock_position_id FK links each movement transaction ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: TRACEABILITY: Inbound goods movements must capture the supplying vendor for compliance and supplier performance audits.',
    `transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.transfer_order. Business justification: goods_movement records inventory movement events including inter-location transfers. transfer_order is the authorizing document for such movements. Adding transfer_order_id FK links movement transacti',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Goods movements require vendor_item for accurate cost-at-movement (vendor_cost_amount), unit-of-measure validation, and COGS posting. Inventory valuation and shrink costing depend on the specific vend',
    `wms_task_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wms_task. Business justification: Every WMS task execution (pick, putaway, transfer) generates a goods_movement record in inventory. Linking goods_movement to the originating wms_task enables inventory discrepancy reconciliation, shri',
    `adjustment_reason` STRING COMMENT 'Free‑text or coded reason for an inventory adjustment (e.g., shrink, recount, donation).',
    `cost_at_movement` DECIMAL(18,2) COMMENT 'Standard cost of the inventory at the time of movement, used for financial valuation.',
    `cost_method` STRING COMMENT 'Costing methodology applied to the inventory item at the time of movement.. Valid values are `standard|moving_average|specific_identification`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the movement record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amount.',
    `cycle_count_quantity` DECIMAL(18,2) COMMENT 'Quantity difference identified during a cycle count.',
    `document_reference` STRING COMMENT 'Reference to the source document (e.g., material document number, WMS transaction ID).',
    `expiration_date` DATE COMMENT 'Date on which the product expires; used for perishable inventory control.',
    `goods_movement_status` STRING COMMENT 'Current processing status of the movement record.. Valid values are `posted|pending|reversed|cancelled`',
    `inventory_valuation_method` STRING COMMENT 'Method used to value inventory for this movement (FIFO, LIFO, average cost, or standard cost).. Valid values are `fifo|lifo|average|standard`',
    `is_cycle_count_correction` BOOLEAN COMMENT 'True when the movement reflects a correction from a cycle‑count process.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the movement was entered manually rather than via automated interface.',
    `is_physical_inventory` BOOLEAN COMMENT 'Indicates whether the movement is part of a physical inventory count process.',
    `is_reserved` BOOLEAN COMMENT 'Indicates whether the quantity was reserved for a pending order at the time of movement.',
    `is_shrink` BOOLEAN COMMENT 'True when the movement records inventory loss (theft, spoilage, damage).',
    `movement_reason_code` STRING COMMENT 'Code describing why the movement occurred (e.g., purchase receipt, customer return, internal transfer).',
    `movement_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory movement was posted in the source system.',
    `movement_type` STRING COMMENT 'Category of inventory movement: receipt, issue, transfer, adjustment, correction, or other.. Valid values are `receipt|issue|transfer|adjustment|correction|other`',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric amount of inventory moved, expressed in the unit of measure.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized items (e.g., electronics, high‑value assets).',
    `shrink_reason` STRING COMMENT 'Categorized cause of shrinkage when is_shrink is true.. Valid values are `theft|spoilage|damage|loss|other`',
    `source_system` STRING COMMENT 'Originating operational system that generated the movement record.. Valid values are `sap_mm|manhattan_wms|oracle_retail|blue_yonder`',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the movement complied with cold‑chain temperature requirements.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Recorded temperature at the time of movement for temperature‑sensitive items.',
    `temperature_unit` STRING COMMENT 'Unit of the temperature reading (Celsius, Fahrenheit, Kelvin).. Valid values are `c|f|k`',
    `transaction_document_number` STRING COMMENT 'Human‑readable document number shown on transaction prints and reports.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity (e.g., each, kilogram, pound, case, pallet).. Valid values are `each|kg|lb|case|pallet`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the movement record.',
    CONSTRAINT pk_goods_movement PRIMARY KEY(`goods_movement_id`)
) COMMENT 'Transactional record of every inventory movement event — receipts, issues, transfers, adjustments (including cycle-count corrections, damage write-offs, donation dispositions, and recall removals), returns, and write-offs — across all locations. Each record captures movement type (GR, GI, transfer, adjustment, cycle-count-correction), quantity, unit of measure, originating document reference, posting timestamp, and for adjustments: reason code, approving manager, adjustment value at cost, and supporting documentation reference. Sourced from SAP MM material documents and Manhattan WMS transactions. Provides the full audit trail for stock position changes, supports FIFO/LIFO rotation tracking, and serves as the controlled, auditable record for all inventory quantity changes including authorized corrections. This is the single source of truth for all inventory quantity change events.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`shrink_record` (
    `shrink_record_id` BIGINT COMMENT 'System-generated unique identifier for each shrink record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grocery retailers allocate shrink costs to department/store cost centers for P&L accountability and shrink rate KPIs by cost center. The responsible_department on shrink_record must map to a cost_cent',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Shrink is budgeted, tracked, and reported at the department level in grocery. Department managers own shrink reduction programs and are accountable to shrink targets. responsible_department is a denor',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Shrink must be reported by fiscal period for P&L shrink rate KPIs, budget variance analysis, and regulatory reporting. Grocery retailers track shrink as a percentage of sales by period; shrink_record→',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shrink write-downs (spoilage, theft, damage) must be posted to specific GL shrink-expense or waste accounts for P&L reporting. Grocery retailers require shrink_record→gl_account to drive accurate inve',
    `goods_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_movement. Business justification: shrink events generate inventory adjustment goods_movements (goods_movement.is_shrink = true). Adding goods_movement_id FK on shrink_record links each shrink event to its corresponding inventory adjus',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: shrink_record has a denormalized `lot_number` (STRING) attribute. Shrink events on perishable and regulated inventory must trace back to the lot_batch master for HACCP compliance and recall traceabili',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Perishable markdown-to-shrink traceability: markdowns that fail to clear inventory result in shrink disposal. Linking shrink_record to the triggering markdown event enables markdown effectiveness repo',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Shrink analysis per PO enables supplier chargebacks, loss accounting, and regulatory reporting of inventory loss.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Shrink dollar valuation (retail inventory method): shrink_record.estimated_cost requires the active retail price at time of loss. Retail-grocery loss-prevention and P&L reporting depend on this link. ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Grocery shrink reporting and vendor chargeback processes require shrink records linked at SKU level. shrink_record has product_item_id but not sku_id. Shrink budgets, markdown decisions, and supplier ',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link shrink_record to the stock_position it originates from, consolidating shrink events with the affected position.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the shrink occurred.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Shrink records tied to vendor items enable vendor chargeback claims for damaged-on-arrival or short-shelf-life goods. Trade allowance recovery and vendor performance scorecarding for shrink contributi',
    `compliance_flag_haccp` BOOLEAN COMMENT 'Indicates if the shrink event relates to a HACCP (food safety) issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shrink record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated cost.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `disposal_method` STRING COMMENT 'Method used to dispose of inventory that cannot be salvaged.. Valid values are `landfill|incineration|recycling`',
    `disposition_method` STRING COMMENT 'How the lost inventory was handled after identification.. Valid values are `markdown|donation|disposal|return_to_vendor|recycle`',
    `donation_recipient` STRING COMMENT 'Name of the charitable organization or entity receiving the donated inventory.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Monetary value of the lost inventory based on standard cost.',
    `line_number` STRING COMMENT 'Sequential number of the line within the shrink event.',
    `notes` STRING COMMENT 'Free‑form text for additional details or observations.',
    `quantity_lost` DECIMAL(18,2) COMMENT 'Amount of inventory lost, expressed in the unit of measure.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the shrink event was captured in the source system.',
    `serial_number` STRING COMMENT 'Unique serial identifier for high‑value or regulated items.',
    `shrink_category` STRING COMMENT 'High‑level classification of the shrink event for reporting.. Valid values are `inventory|financial|compliance`',
    `shrink_cause` STRING COMMENT 'Root cause of the inventory loss.. Valid values are `theft|spoilage|damage|admin_error|vendor_short_ship|unknown`',
    `shrink_event_number` BIGINT COMMENT 'Identifier linking this line to the parent shrink event batch.',
    `shrink_record_status` STRING COMMENT 'Current processing state of the shrink record.. Valid values are `open|closed|reversed|pending_review`',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Recorded temperature at the time of the event.',
    `temperature_unit` STRING COMMENT 'Unit of measure for the temperature reading.. Valid values are `C|F`',
    `temperature_violation` BOOLEAN COMMENT 'True if temperature readings indicated a cold‑chain breach leading to spoilage.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity lost (e.g., each, kilogram, liter).. Valid values are `EA|KG|L|BOX|CASE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this shrink record.',
    CONSTRAINT pk_shrink_record PRIMARY KEY(`shrink_record_id`)
) COMMENT 'Operational record of inventory shrink events and loss-mitigation dispositions. Captures shrink cause (theft known/unknown, spoilage, damage, administrative error, vendor short-ship), quantity lost, estimated cost of shrink, shrink category, responsible department, and disposition method and outcome — including markdowns (clearance, near-expiry, seasonal, damage markdowns with original price, markdown price, markdown percentage, effective/expiry dates), donations, and disposal. For markdown dispositions: tracks quantity marked down, sell-through outcome, and recovered value. Supports GMROI analysis, loss prevention programs, HACCP compliance for perishable spoilage, shrink reduction programs, and perishable inventory management. Sourced from store shrink entry workflows in SAP MM and Oracle Retail.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'System-generated unique identifier for each cycle count event.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Cycle counts in grocery are scoped to departments (produce, deli, pharmacy). Department managers own cycle count schedules and variance accountability. Department-level inventory accuracy reporting an',
    `goods_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_movement. Business justification: cycle counts with variance generate inventory adjustment goods_movements (goods_movement.is_cycle_count_correction = true). Adding goods_movement_id FK on cycle_count links count events to their resul',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: cycle_count has a denormalized `lot_number` (STRING) attribute for lot-specific physical counts. Adding lot_batch_id FK links count events to the authoritative lot_batch master, enabling traceability ',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Grocery retailers schedule cycle counts by planogram reset cycle — counts are scoped to all SKUs within a planogram. Planogram-scoped cycle count scheduling and post-reset verification are standard re',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Cycle count variance reconciliation requires linking each count record to the product item master. Grocery inventory accuracy reporting (shrink budget, audit compliance) depends on joining cycle count',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Cycle count records carry sku as plain text — a denormalization of the SKU entity. Grocery inventory accuracy KPIs (variance by SKU, shrink by SKU) require a proper FK. Replacing the plain sku column ',
    `slot_location_id` BIGINT COMMENT 'Foreign key linking to fulfillment.slot_location. Business justification: In WMS-managed fulfillment centers, cycle counts are performed at specific pick slot locations. cycle_count already links to storage_location, but slot_location is the WMS-specific granularity for cyc',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: cycle_count verifies and updates stock positions. Adding stock_position_id FK links each count event to the stock position it verifies, enabling direct reconciliation between counted_quantity and on_h',
    `storage_location_id` BIGINT COMMENT 'Identifier of the specific location (aisle, shelf, bin) within the store.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Store operations teams schedule and execute cycle counts per store location. Store-level inventory accuracy reporting, shrink audits, and cycle count scheduling all require knowing which store a count',
    `approved_by` STRING COMMENT 'Name or employee identifier of the associate who approved the count.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the count was approved.',
    `count_method` STRING COMMENT 'Method used for the count (full inventory, cycle count, spot check, or ad‑hoc).. Valid values are `full|cycle|spot|ad_hoc`',
    `count_number` STRING COMMENT 'Business identifier assigned to the count event, used for tracking and reference.. Valid values are `^CC-d{8}$`',
    `count_reason` STRING COMMENT 'Business reason for initiating the count.. Valid values are `audit|shrink|replenishment|cycle|other`',
    `count_timestamp` TIMESTAMP COMMENT 'Date and time when the physical count was performed.',
    `count_type` STRING COMMENT 'Indicates whether the count was performed manually or by an automated system.. Valid values are `manual|automated`',
    `counted_quantity` BIGINT COMMENT 'Physical quantity recorded by the associate during the count.',
    `cycle_count_status` STRING COMMENT 'Current lifecycle status of the count event.. Valid values are `scheduled|in_progress|completed|approved|rejected`',
    `expiration_date` DATE COMMENT 'Expiration date of the product lot, if applicable.',
    `is_out_of_stock` BOOLEAN COMMENT 'True if the SKU is considered out‑of‑stock after the count.',
    `notes` STRING COMMENT 'Free‑form comments entered by the associate performing the count.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cycle count record.',
    `reserved_quantity` BIGINT COMMENT 'Quantity of the SKU reserved for open orders at count time.',
    `shrink_flag` BOOLEAN COMMENT 'Indicates whether the variance is classified as shrink (loss).',
    `shrink_reason` STRING COMMENT 'Root cause of shrink when shrink_flag is true.. Valid values are `theft|spoilage|damage|administrative|other`',
    `system_quantity` BIGINT COMMENT 'Quantity that the inventory system recorded for the SKU at the time of the count.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if the counted item met cold‑chain temperature requirements.',
    `temperature_reading_c` DECIMAL(18,2) COMMENT 'Recorded temperature at the time of count for temperature‑sensitive items.',
    `tolerance_flag` BOOLEAN COMMENT 'True if the variance exceeds predefined tolerance thresholds.',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the quantity (e.g., each, case, pallet, kilogram).. Valid values are `each|case|pallet|kg|lb`',
    `upc` STRING COMMENT '12‑digit barcode number for the product.. Valid values are `^d{12}$`',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage difference between counted and system quantities.',
    `variance_quantity` BIGINT COMMENT 'Difference between counted_quantity and system_quantity (counted – system).',
    `variance_value` DECIMAL(18,2) COMMENT 'Monetary impact of the quantity variance based on standard cost.',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Scheduled and ad-hoc physical inventory count events at the SKU-location level. Captures count date, count method (full, cycle, spot), counted quantity, system quantity at time of count, variance quantity, variance value, count status (scheduled, in-progress, completed, approved), and the associate who performed the count. Drives inventory accuracy KPIs and triggers adjustment postings when variances exceed tolerance thresholds. Sourced from Manhattan WMS cycle count module and SAP MM physical inventory.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`replenishment_signal` (
    `replenishment_signal_id` BIGINT COMMENT 'System-generated unique identifier for each replenishment signal record.',
    `allocation_plan_id` BIGINT COMMENT 'Foreign key linking to supply.allocation_plan. Business justification: Replenishment signals are generated when stock falls below allocation_plan minimums. Supply planners need to know which allocation_plan drove a replenishment_signal to evaluate plan accuracy and adjus',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category Replenishment Signal Aggregation groups signals by category to drive category‑wide ordering decisions.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Replenishment in grocery is managed at the department level — department managers review signals, approve orders, and are accountable for in-stock rates. Department-level replenishment reporting and s',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Replenishment signals must align with the active assortment plan — signals should only be generated for items currently in the assortment. Merchandising-operations integration requires this link for a',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Planogram-driven replenishment — filling to planogram-specified facing counts and capacity — is a named grocery retail process. Replenishment signals must reference the active planogram to determine t',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Demand signal generated by an active campaign, used for automated replenishment planning.',
    `reorder_policy_id` BIGINT COMMENT 'Foreign key linking to inventory.reorder_policy. Business justification: replenishment_signal records are generated by the CAO system based on reorder_policy parameters (reorder_point, safety_stock_qty, lead_time_days, etc.). Adding reorder_policy_id FK establishes the gov',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.replenishment_order. Business justification: Replenishment signals trigger replenishment_order creation. Signal-to-order response time and fill rate are core supply chain KPIs. Supply planners need to track which replenishment_order was generate',
    `sku_id` BIGINT COMMENT 'Unique identifier of the SKU for which the signal is generated.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: replenishment_signal is triggered by the stock position falling below reorder_point. Adding stock_position_id FK links each signal to the triggering stock position, enabling direct traceability from s',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the store, distribution center, or micro‑fulfillment center where the signal applies.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: AUTOMATED ORDERING: Replenishment signals must identify the designated supplier to generate correct purchase orders.',
    `tpr_event_id` BIGINT COMMENT 'Foreign key linking to promotion.tpr_event. Business justification: TPR-driven replenishment is a distinct operational process: when a TPR is scheduled, the replenishment system generates pre-positioning signals specific to that price reduction event. replenishment_si',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Replenishment signals must validate suggested_order_quantity against vendor_item.minimum_order_quantity and order_multiple_quantity before generating a PO. Without this link, signals cannot be rounded',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the signal record was first persisted in the lakehouse.',
    `demand_forecast_date` DATE COMMENT 'Date for which the demand forecast quantity applies.',
    `demand_forecast_units` STRING COMMENT 'Projected units of demand for the SKU‑location over the forecast horizon that triggered the signal.',
    `forecast_accuracy_pct` DECIMAL(18,2) COMMENT 'Historical accuracy of the demand forecast that generated this signal, expressed as a percentage.',
    `inventory_on_hand` STRING COMMENT 'Quantity of units physically available at the location at signal generation time.',
    `inventory_reserved` STRING COMMENT 'Units already allocated to existing orders or transfers and therefore unavailable for new demand.',
    `inventory_shrink` STRING COMMENT 'Units lost due to theft, spoilage, or damage recorded at the time of signal.',
    `is_critical` BOOLEAN COMMENT 'True if the signal requires immediate attention due to risk of stockout or high‑margin item.',
    `is_oos` BOOLEAN COMMENT 'True if the SKU is currently out of stock at the location.',
    `lead_time_days` STRING COMMENT 'Expected number of days from order placement to receipt of goods for the SKU at this location.',
    `notes` STRING COMMENT 'Free‑form comments entered by planners or system about the signal.',
    `priority_level` STRING COMMENT 'Business priority assigned to the signal for planning and execution urgency.. Valid values are `high|medium|low`',
    `reorder_point` STRING COMMENT 'Inventory level at which the signal is triggered; when on‑hand falls below this value.',
    `reorder_point_timestamp` TIMESTAMP COMMENT 'Date‑time when the reorder point value was last calculated or updated.',
    `replenishment_signal_status` STRING COMMENT 'Current lifecycle state of the signal: pending, converted to purchase order, or cancelled.. Valid values are `pending|converted|cancelled`',
    `safety_stock_level` STRING COMMENT 'Buffer stock quantity maintained to protect against demand variability and supply lead‑time.',
    `signal_generated_timestamp` TIMESTAMP COMMENT 'Date‑time when the replenishment signal was created by the system.',
    `signal_type` STRING COMMENT 'Indicates whether the signal was automatically generated by the demand engine or manually overridden by a planner.. Valid values are `auto|manual_override`',
    `signal_version` STRING COMMENT 'Version number of the signal record to support updates and re‑evaluations.',
    `source_system` STRING COMMENT 'Originating system that produced the signal, e.g., Blue Yonder demand planning or Oracle Retail Replenishment.. Valid values are `blue_yonder|oracle_replenishment`',
    `suggested_order_quantity` STRING COMMENT 'Quantity of units recommended to order to bring inventory back to target levels.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the signal record.',
    CONSTRAINT pk_replenishment_signal PRIMARY KEY(`replenishment_signal_id`)
) COMMENT 'CAO (Computer-Assisted Ordering) replenishment signals generated for each SKU-location combination when on-hand stock falls below reorder point or safety stock threshold. Captures signal type (auto-generated, manual override), suggested order quantity, reorder point at time of signal, safety stock level, lead time days, signal status (pending, converted-to-PO, cancelled), and the demand forecast that triggered the signal. Integrates Blue Yonder Demand Planning output with Oracle Retail Replenishment.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`oos_event` (
    `oos_event_id` BIGINT COMMENT 'System‑generated unique identifier for the OOS event record.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: OOS events drive assortment rationalization decisions — items with chronic OOS are candidates for delisting or supplier review. Category managers require OOS event history per assortment item for rang',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: OOS events are department-specific in grocery — produce OOS differs from pharmacy OOS in root cause, accountability, and resolution. Department managers are measured on OOS rates. Department-level OOS',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional OOS analysis and vendor deduction claims require direct campaign attribution on OOS events. Post-promo reporting tracks which campaigns caused stockouts; stock_positions promo_campaign_id',
    `purchase_order_id` BIGINT COMMENT 'Purchase order that was expected to deliver the SKU but contributed to the OOS.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.replenishment_order. Business justification: OOS events are resolved by replenishment_orders. OOS resolution time (time from oos_start to replenishment_order delivery) is a key retail KPI. Currently oos_event links to replenishment_signal but no',
    `replenishment_signal_id` BIGINT COMMENT 'Identifier of the Computer‑Assisted Ordering (CAO) signal that triggered the OOS detection.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Lost-sales revenue quantification: oos_event.estimated_lost_sales_value requires the active retail price to convert forecasted_demand_qty into dollar impact. Retail-grocery category managers and opera',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: OOS event tracking is a core retail KPI reported at SKU level (lost sales value, fill rate by SKU). The plain sku column is a denormalization. A proper sku_id FK enables OOS duration and lost-sales re',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link oos_event to the stock_position to associate out‑of‑stock events with the exact inventory record.',
    `store_location_id` BIGINT COMMENT 'Internal identifier of the specific location (store number, DC code, or MFC ID).',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier responsible for the product when root cause is supplier OOS.',
    `tpr_event_id` BIGINT COMMENT 'Foreign key linking to promotion.tpr_event. Business justification: TPR-driven stockout analysis is a named operational process: retailers track OOS events caused by TPR demand spikes for root cause reporting, vendor accountability, and future TPR inventory planning. ',
    `actual_sales_qty` DECIMAL(18,2) COMMENT 'Number of units actually sold during the OOS period (typically zero).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the OOS event record was first created in the data lake.',
    `detection_method` STRING COMMENT 'How the OOS was identified: POS scan failure, CAO replenishment signal, or manual audit.. Valid values are `pos_scan|cao_signal|manual_audit`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the out‑of‑stock event expressed in hours (difference between end and start timestamps).',
    `estimated_lost_sales_value` DECIMAL(18,2) COMMENT 'Monetary estimate of sales lost due to the OOS condition, expressed in the stores currency.',
    `forecasted_demand_qty` DECIMAL(18,2) COMMENT 'Projected quantity of the SKU expected to sell during the OOS window based on demand planning.',
    `is_resolved` BOOLEAN COMMENT 'Indicates whether the OOS event has been closed (true) or is still open (false).',
    `location_type` STRING COMMENT 'Type of location where the OOS occurred: store, distribution center (dc), or micro‑fulfillment center (mfc).. Valid values are `store|dc|mfc`',
    `notes` STRING COMMENT 'Optional free‑text comments providing additional context or observations about the OOS event.',
    `oos_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the item was replenished and the OOS condition ended.',
    `oos_severity` STRING COMMENT 'Business impact severity of the OOS event based on expected sales loss and product importance.. Valid values are `low|medium|high`',
    `oos_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the inventory quantity first reached zero and the OOS event began.',
    `quantity_after` STRING COMMENT 'On‑hand quantity of the SKU after the OOS was resolved (post‑replenishment).',
    `quantity_before` STRING COMMENT 'On‑hand quantity of the SKU immediately before it reached zero.',
    `root_cause_category` STRING COMMENT 'Primary reason for the OOS event, classified into standard categories.. Valid values are `supplier_oos|dc_oos|store_delay|shrink|demand_spike|other`',
    `shrink_type` STRING COMMENT 'Category of inventory loss if the OOS root cause is shrinkage.. Valid values are `theft|spoilage|damage|none`',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if temperature‑controlled items remained within required range during the OOS period; otherwise false.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the OOS event record.',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Out-of-Stock (OOS) event records capturing when a SKU at a specific location transitions to zero available-to-sell quantity. Tracks OOS start timestamp, OOS end timestamp (when restocked), OOS duration in hours, root cause category (supplier OOS, DC OOS, store receiving delay, shrink, demand spike), estimated lost sales value, and whether the OOS was detected via POS scan failure, CAO signal, or manual audit. Critical for store operations performance and vendor fill-rate accountability.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique surrogate key for each lot or batch record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: HACCP compliance and perishable management reporting require lot batch traceability by category (e.g., produce, dairy, meat). Category-level lot recall and rotation compliance audits are regulatory re',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Lot-level FIFO/LIFO inventory valuation: each lot_batch must reference its landed cost for accurate COGS calculation during rotation and write-off. Retail-grocery inventory accountants require lot-lev',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Lot batches are received into specific departments (pharmacy, produce, meat). HACCP compliance and department-level expiry rotation management require knowing which department holds each lot. Departme',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Pharmacy drug lots require NDC-level traceability for FDA recall management, expiration tracking, and DEA controlled substance audit trails. A retail-grocery pharmacy expert expects each lot/batch to ',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: FSMA lot traceability regulations require direct lot-to-shipment linkage. Food safety audits and recall investigations need to identify which inbound_shipment introduced a specific lot_batch into inve',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: FDA FSMA lot traceability and recall management require every lot/batch to be linked to a specific product item. Grocery retailers must trace recalled product from lot number back to product master — ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: FSMA lot traceability and vendor recall management require direct lot-to-PO linkage for regulatory audits. Vendor chargebacks for quality failures require identifying the PO under which a defective lo',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lot/batch rotation and recall operations in grocery are executed at SKU level. product_sku is a plain-text denormalization of the SKU entity. Replacing it with a proper sku_id FK enables SKU-level lot',
    `storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, store, or micro‑fulfillment center where the lot is stored.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: FDA/USDA product recall traceability requires knowing which store received each lot/batch. Store-level lot tracking is mandatory for food safety compliance, health inspection documentation, and target',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier that provided the lot.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: FSMA and FDA traceability rules require linking lot/batch records to the originating supplier facility (not just the supplier). Food safety recalls and USDA audits demand site-level traceability. A fo',
    `batch_number` STRING COMMENT 'Manufacturer‑assigned batch code used for traceability across the supply chain.',
    `best_by_date` DATE COMMENT 'Recommended date for optimal quality consumption.',
    `cold_chain_flag` BOOLEAN COMMENT 'Indicates whether the lot must be stored and transported under temperature‑controlled conditions.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code indicating where the product was produced.. Valid values are `^[A-Z]{3}$`',
    `days_to_expiry` STRING COMMENT 'Calculated number of days remaining until the expiration date at the time of check.',
    `entry_temperature_c` DECIMAL(18,2) COMMENT 'Temperature recorded when the lot entered the cold chain.',
    `expiration_date` DATE COMMENT 'Date after which the product must not be sold or consumed.',
    `lot_batch_status` STRING COMMENT 'Current lifecycle state of the lot within inventory management.. Valid values are `active|quarantined|recalled|expired|consumed|pending`',
    `lot_number` STRING COMMENT 'Human‑readable identifier assigned to the lot by the manufacturer or supplier.',
    `lot_type` STRING COMMENT 'Category describing the nature of the lot for handling and compliance purposes.. Valid values are `perishable|non_perishable|regulated|raw_material`',
    `production_date` DATE COMMENT 'Date the product was manufactured or produced.',
    `quantity` DECIMAL(18,2) COMMENT 'Total amount of product units contained in the lot.',
    `quarantine_end_date` DATE COMMENT 'Date the lot exited quarantine status.',
    `quarantine_start_date` DATE COMMENT 'Date the lot entered quarantine status.',
    `recall_date` DATE COMMENT 'Date the lot was officially recalled from the supply chain.',
    `recall_reason` STRING COMMENT 'Narrative description of why the lot was recalled.',
    `received_timestamp` TIMESTAMP COMMENT 'Exact time the lot entered the warehouse or store receiving area.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the lot record.',
    `rotation_check_date` DATE COMMENT 'Date on which the rotation compliance was verified.',
    `rotation_checked_by` STRING COMMENT 'Identifier of the associate who performed the rotation compliance check.',
    `rotation_compliance_flag` BOOLEAN COMMENT 'True if the lot was rotated according to policy during the most recent check.',
    `rotation_method` STRING COMMENT 'Policy used to rotate inventory: First‑In‑First‑Out, First‑Expired‑First‑Out, or Last‑In‑First‑Out.. Valid values are `FIFO|FEFO|LIFO`',
    `rotation_sequence` STRING COMMENT 'Numeric order of the lot within the chosen rotation method at its current location.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., each, kilogram, pound, liter).. Valid values are `each|kg|lb|liter`',
    `usda_fda_certified_flag` BOOLEAN COMMENT 'True if the lot complies with USDA or FDA certification requirements.',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Lot and batch master records for perishable, regulated, and traceable inventory items. Captures lot number, batch number, production date, expiration date, best-by date, FIFO/FEFO sequence number, country of origin, USDA/FDA certification flags, cold chain entry temperature, current lot status (active, quarantined, recalled, expired, consumed), and comprehensive rotation compliance tracking: rotation method (FIFO, FEFO — First Expired First Out), current rotation sequence at each location, days-to-expiry at time of check, rotation compliance flag (whether stock was rotated per policy), rotation check date, and checking associate. Essential for FIFO/LIFO/FEFO rotation enforcement, HACCP compliance, fresh produce quality management, spoilage reduction, perishable rotation audit, and FDA/USDA food safety traceability. Sourced from SAP MM batch management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique surrogate key for each storage location.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center that contains the location.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Storage locations within a store are assigned to departments (produce backroom, pharmacy storage, deli cooler). Department-level space management, planogram assignment, and capacity planning all requi',
    `fixture_id` BIGINT COMMENT 'Foreign key linking to assortment.fixture. Business justification: Planogram reset execution and compliance auditing require knowing which fixture each storage location belongs to. Store operations teams physically map bins/shelves to fixtures (gondolas, coolers) dur',
    `mfc_profile_id` BIGINT COMMENT 'Identifier of the micro‑fulfillment center (MFC) where the location resides.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: CONTROLLED‑SUBSTANCE COMPLIANCE: maps storage locations used for drug storage to the pharmacy they serve, required for DEA audit and temperature‑monitoring reports.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Location‑level campaign assignment: stores map locations to campaigns for end‑cap and aisle displays.',
    `temperature_zone_id` BIGINT COMMENT 'Foreign key linking to inventory.temperature_zone. Business justification: storage_location has a denormalized STRING column `temperature_zone` that stores the zone name/code. temperature_zone is a master reference table in this domain with zone_code, zone_name, zone_type, a',
    `aisle` STRING COMMENT 'Aisle identifier within the store or warehouse where the location resides.',
    `available_units` BIGINT COMMENT 'Units available for new allocation (on‑hand minus reserved).',
    `bay` STRING COMMENT 'Bay or section within an aisle.',
    `bin` STRING COMMENT 'Bin or slot identifier on the shelf.',
    `capacity_units` BIGINT COMMENT 'Maximum number of individual items the location can hold.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volume in cubic meters that the location can accommodate.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms that the location can safely store.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was first created in the system.',
    `current_onhand_units` BIGINT COMMENT 'Real‑time count of items physically present in the location.',
    `effective_from` DATE COMMENT 'Date when the location became operational.',
    `effective_until` DATE COMMENT 'Date when the location is scheduled to be decommissioned or retired (null if indefinite).',
    `floor_level` STRING COMMENT 'Numeric floor level where the location resides (e.g., 0 for ground floor).',
    `is_accessible` BOOLEAN COMMENT 'Indicates whether the location meets accessibility standards for disabled personnel.',
    `is_security_restricted` BOOLEAN COMMENT 'True for locations with heightened security controls (e.g., pharmacy vault, fuel tank).',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the location is equipped with active temperature control.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent cycle count performed for the location.',
    `last_inventory_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the latest inventory reconciliation event.',
    `location_code` STRING COMMENT 'External business code or identifier used by the retailer to reference the location (e.g., SKU‑like code).',
    `location_name` STRING COMMENT 'Human‑readable name of the storage location used in operational screens and reports.',
    `location_type` STRING COMMENT 'Category of the location such as sales floor, backroom, cooler, freezer, pharmacy vault, fuel tank, or MFC bin. [ENUM-REF-CANDIDATE: sales_floor|backroom|cooler|freezer|pharmacy_vault|fuel_tank|mfc_bin — promote to reference product]',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the location.',
    `oos_flag` BOOLEAN COMMENT 'True when the location has zero available units.',
    `reserved_units` BIGINT COMMENT 'Units allocated to pending orders but not yet picked.',
    `shelf` STRING COMMENT 'Shelf identifier on the bay.',
    `shrink_units` BIGINT COMMENT 'Units lost due to theft, spoilage, or damage.',
    `storage_location_status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|maintenance|closed`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for the location.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the storage location record.',
    `zone_classification` STRING COMMENT 'Operational zone label used for routing and labor planning.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record of all physical storage locations within stores, DCs, and MFCs where inventory is held. Captures location type (sales floor, backroom, cooler, freezer, pharmacy vault, fuel tank, MFC bin), aisle, bay, shelf, bin coordinates, planogram slot reference, maximum capacity (units and weight), temperature zone classification, and active status. This is the SSOT for inventory location topology used by WMS putaway, picking, and replenishment workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`transfer_order` (
    `transfer_order_id` BIGINT COMMENT 'System-generated unique identifier for the transfer order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transfer orders incur internal costs; associating each order with a cost center enables charge‑back and profitability tracking.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Inter-department transfers (e.g., produce to deli, backroom to floor) are common in grocery. Department-level transfer tracking is required for department P&L accuracy, shrink attribution, and invento',
    `storage_location_id` BIGINT COMMENT 'Identifier of the location (store, DC, MFC) receiving the transferred inventory.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Transfer orders must be period-stamped for inter-location inventory cost accounting and period-end reconciliation. Grocery retailers associate transfers with fiscal periods to ensure inventory valuati',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inter-location inventory transfers (DC-to-store, store-to-store) require GL postings for inventory movement between cost objects. Grocery retailers post transfer costs and inventory reclassifications ',
    `primary_transfer_storage_location_id` BIGINT COMMENT 'Identifier of the location (store, DC, MFC) from which inventory is being transferred.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: DC-to-store and store-to-store transfer orders in grocery must reference the product being transferred for temperature compliance routing, hazmat handling, and inventory valuation. transfer_order has ',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional inventory transfers (DC-to-store or inter-store moves for campaign events) require campaign attribution for cost allocation, performance measurement, and vendor funding reconciliation. Ret',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.replenishment_order. Business justification: Transfer orders are created to physically execute replenishment_orders (DC-to-store stock movements). Supply planners track which transfer_orders fulfill which replenishment_orders for fill rate, on-t',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Transfer execution in grocery is performed at SKU level — warehouse staff pick and ship by SKU. Transfer order fulfillment reporting, in-transit inventory tracking, and receiving reconciliation all re',
    `transport_route_id` BIGINT COMMENT 'Foreign key linking to supply.transport_route. Business justification: Transfer orders are executed via specific transport routes (DC-to-store lanes). Logistics planners assign transport_routes to transfer_orders for scheduling, carrier assignment, temperature compliance',
    `actual_delivery_date` DATE COMMENT 'Date on which the inventory was actually received.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory approved for transfer after validation.',
    `carrier_mode` STRING COMMENT 'Transportation mode used for the transfer.. Valid values are `truck|van|rail|air|drone`',
    `compliance_document_number` BIGINT COMMENT 'Reference to a compliance document (e.g., FDA, USDA) attached to the transfer.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost associated with moving the inventory.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the transfer cost.. Valid values are `^[A-Z]{3}$`',
    `destination_location_type` STRING COMMENT 'Classification of the destination location.. Valid values are `store|distribution_center|micro_fulfillment_center|warehouse`',
    `expected_delivery_date` DATE COMMENT 'Planned date by which the transfer should be completed.',
    `is_cross_dock` BOOLEAN COMMENT 'True if the transfer is a cross‑dock operation without storage.',
    `is_expedited` BOOLEAN COMMENT 'True if the transfer is processed with expedited handling.',
    `is_fifo_rotation` BOOLEAN COMMENT 'True if the items follow a First‑In‑First‑Out rotation policy.',
    `is_lifo_rotation` BOOLEAN COMMENT 'True if the items follow a Last‑In‑First‑Out rotation policy.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Date and time when the status field was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional comments or special instructions.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the transfer order is high priority.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory received at the destination location.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory initially requested for transfer.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory actually shipped from the source location.',
    `shrink_quantity` DECIMAL(18,2) COMMENT 'Quantity lost due to theft, spoilage, or damage during transfer.',
    `shrink_reason` STRING COMMENT 'Root cause of the shrinkage recorded for the transfer.. Valid values are `theft|spoilage|damage|other`',
    `source_location_type` STRING COMMENT 'Classification of the source location.. Valid values are `store|distribution_center|micro_fulfillment_center|warehouse`',
    `temperature_compliance_status` STRING COMMENT 'Result of temperature compliance checks for the transfer.. Valid values are `compliant|non_compliant|not_applicable`',
    `temperature_control_required` BOOLEAN COMMENT 'True if the transferred items require temperature-controlled handling.',
    `transfer_date` DATE COMMENT 'The business date on which the transfer order was initiated.',
    `transfer_order_number` STRING COMMENT 'Business-visible reference number for the transfer order, used in communications and documentation.',
    `transfer_order_status` STRING COMMENT 'Current lifecycle state of the transfer order.. Valid values are `created|approved|in_transit|received|closed|cancelled`',
    `transfer_order_type` STRING COMMENT 'Indicates whether the transfer is internal (within company) or external (to third‑party).. Valid values are `internal|external`',
    `transfer_reason` STRING COMMENT 'Business driver for the inventory movement.. Valid values are `replenishment|rebalancing|recall|seasonal|promotion|damage`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantities expressed in the transfer order.. Valid values are `each|kg|lb|case|pallet`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the transfer order record.',
    CONSTRAINT pk_transfer_order PRIMARY KEY(`transfer_order_id`)
) COMMENT 'Inter-location inventory transfer orders authorizing movement of stock between stores, from DC to store, from DC to MFC, or between DCs. Captures source location, destination location, requested quantity, approved quantity, shipped quantity, received quantity, transfer reason (replenishment, rebalancing, recall, seasonal), transfer status (created, approved, in-transit, received, closed), and expected delivery date. Sourced from Manhattan WMS transfer order management and SAP MM stock transport orders.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`reorder_policy` (
    `reorder_policy_id` BIGINT COMMENT 'Unique surrogate key for each reorder policy record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reorder policies are budgeted against cost centers to control inventory replenishment spend.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: EOQ and holding-cost optimization: reorder_policy.economic_order_quantity calculation requires unit cost (holding cost = f(unit_cost × carrying_rate)). Retail-grocery supply chain planners expect cost',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Reorder policies in grocery are set at the department level — produce has different lead times and safety stock rules than pharmacy or frozen foods. Department-level policy management and compliance r',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Reorder policies must be scoped to the active assortment plan — policies should only exist for items in the current assortment, and seasonal plan transitions require policy updates. Inventory planning',
    `sku_id` BIGINT COMMENT 'Identifier of the product (SKU) to which this reorder policy applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the policy is enforced.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SUPPLIER‑SPECIFIC POLICY: Reorder points and safety stock are often defined per supplier for a SKU, needed for procurement analytics.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Reorder policies must reference the governing trade agreement to enforce contracted minimum order quantities, payment terms, and lead times. Procurement compliance reporting requires knowing which agr',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Reorder policies are built around vendor_item parameters: lead_time_days, minimum_order_quantity, order_multiple_quantity, case_pack_quantity. A replenishment analyst must link the policy to the speci',
    `vendor_lead_time_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_lead_time. Business justification: Reorder policies are calibrated using vendor_lead_time records. Supply planners update reorder points when vendor lead times change — the reorder_policy.lead_time_days should be sourced from the autho',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Wholesale account contracts specify minimum order quantities, delivery cadence, and dedicated stock levels that directly govern reorder policies. Grocery wholesale operations require account-specific ',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `economic_order_quantity` STRING COMMENT 'Calculated optimal order size that minimizes total holding and ordering costs.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes binding and may be used for replenishment calculations.',
    `effective_until` DATE COMMENT 'Date on which the policy ceases to be active; null indicates an open‑ended policy.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy parameters were last reviewed or recalibrated.',
    `maximum_stock_level` STRING COMMENT 'Upper bound on on‑hand inventory to avoid over‑stocking.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the policy configuration.',
    `order_multiple` STRING COMMENT 'Standard case‑pack or pallet quantity that orders must be rounded to.',
    `policy_number` STRING COMMENT 'Human‑readable business identifier for the policy, often used in operational reports and communications.',
    `policy_type` STRING COMMENT 'Classification of the policy logic governing how reorder signals are generated.. Valid values are `min_max|demand_driven|vendor_managed|custom`',
    `policy_version` STRING COMMENT 'Sequential version number to track changes to the policy over time.',
    `priority_level` STRING COMMENT 'Business priority used when multiple policies compete for the same SKU‑location.. Valid values are `high|medium|low`',
    `reorder_point` STRING COMMENT 'Inventory level (units) at which a replenishment signal is triggered.',
    `reorder_policy_status` STRING COMMENT 'Current lifecycle state of the policy.. Valid values are `active|inactive|pending|expired|draft`',
    `replenishment_method` STRING COMMENT 'Algorithm used to calculate reorder signals: static min‑max, demand‑driven, or vendor‑managed.. Valid values are `min_max|demand_driven|vendor_managed`',
    `review_cycle` STRING COMMENT 'How often the policy parameters are evaluated and potentially updated.. Valid values are `daily|weekly|monthly|quarterly`',
    `safety_stock_qty` STRING COMMENT 'Buffer stock kept to protect against demand variability and supply delays.',
    `source_system` STRING COMMENT 'Originating system that created or last maintained the policy (e.g., Oracle Retail, Blue Yonder).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the policy.',
    CONSTRAINT pk_reorder_policy PRIMARY KEY(`reorder_policy_id`)
) COMMENT 'SKU-location level replenishment policy parameters governing CAO and manual reorder behavior. Captures reorder point (units), safety stock quantity, maximum stock level, economic order quantity (EOQ), order multiple (case pack), lead time days, review cycle (daily, weekly), replenishment method (min-max, demand-driven, vendor-managed), demand forecast reference, and policy effective/expiry dates. Managed in Oracle Retail Replenishment and Blue Yonder Demand Planning. Drives replenishment signal generation and integrates demand forecast inputs for dynamic threshold calculation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`perishable_rotation` (
    `perishable_rotation_id` BIGINT COMMENT 'System-generated unique identifier for each perishable rotation record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Perishable Rotation Compliance per Category links rotation events to categories for regulatory and freshness reporting.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Perishable rotation is department-specific — produce, deli, meat, and seafood departments each have distinct FIFO/FEFO rotation requirements. Department managers own rotation compliance. HACCP audits ',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: perishable_rotation has a denormalized `lot_number` (STRING) attribute. FIFO/LIFO rotation tracking events are inherently tied to specific lot/batch records. Adding lot_batch_id FK links rotation even',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Rotation-triggered markdown traceability: when days_to_expiry_at_check breaches threshold, a markdown event is initiated. Linking perishable_rotation to pricing.markdown enables end-to-end perishable ',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Grocery retailers routinely link near-expiry perishable rotation events to targeted loyalty reward offers (markdown/clearance incentives) to reduce food waste. The perishable markdown loyalty offer ',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU/lot being evaluated for rotation.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: perishable_rotation tracks FIFO/LIFO rotation events for perishable inventory. Each rotation event affects a specific stock position (SKU at a location). Adding stock_position_id FK links rotation eve',
    `storage_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the rotation check occurred.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Perishable rotation compliance is tracked per store for health inspections and food safety audits. Store-level rotation compliance scores feed into health inspection preparation and store manager acco',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rotation record was first inserted into the lakehouse.',
    `days_to_expiry_at_check` STRING COMMENT 'Number of calendar days remaining until the lot expires at the moment of the check.',
    `event_payload` STRING COMMENT 'JSON‑encoded snapshot of key fields captured at the time of the rotation check for downstream processing.',
    `event_type` STRING COMMENT 'Categorizes the event; fixed value rotation_check for this product.. Valid values are `rotation_check`',
    `expiration_date` DATE COMMENT 'Calendar date on which the lot is required to be sold or removed.',
    `notes` STRING COMMENT 'Free‑form comments entered by the associate regarding the rotation check.',
    `rotation_check_timestamp` TIMESTAMP COMMENT 'Date and time when the rotation check was performed.',
    `rotation_compliance_flag` BOOLEAN COMMENT 'Indicates whether the lot was rotated according to the defined policy (true = compliant).',
    `rotation_method` STRING COMMENT 'Method used to rotate inventory: FIFO (First‑In‑First‑Out), FEFO (First‑Expired‑First‑Out), or LIFO (Last‑In‑First‑Out).. Valid values are `FIFO|FEFO|LIFO`',
    `rotation_sequence` STRING COMMENT 'Ordinal position of the lot within the rotation order at the location.',
    `source_system` STRING COMMENT 'Name of the operational system that generated the record (e.g., Manhattan WMS, SAP MM).',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if the temperature reading at the time of check met cold‑chain requirements.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Measured temperature of the product at the time of rotation check.',
    `temperature_unit` STRING COMMENT 'Unit of measure for the temperature reading (Celsius or Fahrenheit).. Valid values are `C|F`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rotation record.',
    CONSTRAINT pk_perishable_rotation PRIMARY KEY(`perishable_rotation_id`)
) COMMENT 'FIFO/LIFO rotation tracking records for perishable and short-shelf-life inventory. Captures rotation method (FIFO, FEFO — First Expired First Out), current rotation sequence for each lot at each location, days-to-expiry at time of record, rotation compliance flag (whether stock was rotated per policy), rotation check date, and associate who performed the rotation check. Supports HACCP compliance, fresh produce quality management, and reduction of spoilage shrink.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`receiving_record` (
    `receiving_record_id` BIGINT COMMENT 'System-generated unique identifier for the inbound receiving record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods receipts are charged to store/department cost centers for inventory cost allocation and budget tracking. Grocery ERP systems (SAP, Oracle) associate receiving records with cost centers for three',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Three-way match (PO/receipt/invoice) cost verification: receiving_record must validate received cost against agreed cost_price to detect invoice discrepancies. Retail-grocery AP and receiving teams de',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Receiving in grocery is department-specific — produce, pharmacy, and deli each have separate receiving processes and department managers who sign off. Department-level receiving reports, shrink attrib',
    `direct_store_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.direct_store_delivery. Business justification: DSD receiving is a distinct receiving type where vendors deliver directly to stores. The receiving_record documents what was accepted from a direct_store_delivery. DSD reconciliation (invoice vs. rece',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Goods receipts drive AP accruals and inventory asset postings that are period-sensitive. Grocery retailers must associate receiving records with fiscal periods for period-end accruals, three-way match',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Receiving costs (duties, freight) are posted to GL accounts; the link supports AP integration and financial reporting.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: goods_receipt (supply-side document) triggers the inventory-side receiving_record posting. Three-way match (PO/GR/invoice) and inventory valuation require linking the supply receipt document to the in',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Receiving teams reconcile receiving_record quantities against the inbound_shipment ASN during dock receiving. This is the core receiving workflow — every receiving_record closes out a specific inbound',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: receiving_record has denormalized `lot_number` (STRING) and `batch_number` (STRING) attributes. Inbound receiving for perishable and regulated items creates or references lot_batch master records. Add',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Grocery receiving operations require each receipt to reference the product item for PO matching, inventory valuation (FIFO/LIFO), and temperature compliance verification. receiving_record has no produ',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional receiving reconciliation and vendor funding accrual require campaign attribution on receiving records. Vendor-funded promotional buys must be matched to campaigns for funding claim support',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Receiving ties each receipt to its PO for invoice matching, compliance reporting, and supplier performance tracking.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: A receiving record documents the acceptance of an inbound shipment at a DC or store. Grocery receiving operations require receiving_record to reference the inbound shipment for discrepancy reporting (',
    `storage_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where receipt occurred.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Receiving operations are store-specific. Store receiving managers sign off on deliveries, store-level receiving reports are generated for AP reconciliation, and food safety audits require store-level ',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplying vendor.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: Receiving records must identify the specific supplier site (facility) that shipped the delivery for OTIF tracking, temperature compliance audits, and routing disputes. A retail-grocery receiving manag',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Receiving records must reference the governing trade agreement to validate payment terms, cost compliance, and trigger trade allowance accruals. Procurement and AP teams require this link for contract',
    `accepted_quantity` STRING COMMENT 'Units approved for inventory after quality and compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `cycle_count_quantity` STRING COMMENT 'Quantity adjustment applied during a cycle count correction.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discounts applied to the receipt (e.g., promotional or volume discounts).',
    `dsd_vendor_identifier` STRING COMMENT 'Identifier used for Direct Store Delivery vendors that may differ from the master vendor ID.',
    `expected_quantity` STRING COMMENT 'Quantity of units expected on the purchase order or transfer.',
    `expiration_date` DATE COMMENT 'Date after which the product must not be sold or consumed.',
    `inventory_valuation_method` STRING COMMENT 'Method used to value inventory for this receipt (FIFO, LIFO, or Average).. Valid values are `FIFO|LIFO|Average`',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the receipt for three‑way matching.',
    `is_cycle_count_correction` BOOLEAN COMMENT 'Indicates whether the receipt was entered to correct a prior cycle count.',
    `is_physical_inventory` BOOLEAN COMMENT 'True if the receipt is part of a physical inventory count process.',
    `is_shrink` BOOLEAN COMMENT 'True if the receipt includes shrink (theft, spoilage, damage).',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payable amount after discounts; used for three‑way matching.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the receiver.',
    `payment_terms` STRING COMMENT 'Contractual payment terms associated with the vendor invoice.',
    `po_number` STRING COMMENT 'Purchase order reference that initiated the inbound shipment.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt (e.g., MIGO document number).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the goods were physically received and logged.',
    `received_quantity` STRING COMMENT 'Total units physically counted at receipt, before any rejections.',
    `receiving_record_status` STRING COMMENT 'Current processing status of the receiving record.. Valid values are `scheduled|partial|complete|discrepant|cancelled`',
    `receiving_type` STRING COMMENT 'Indicates how the goods arrived: distribution center sourced, direct store delivery, or inter‑location transfer.. Valid values are `dc_sourced|dsd|transfer`',
    `refused_quantity` STRING COMMENT 'Quantity the DSD vendor refused to accept back (e.g., for damaged pallets).',
    `refused_reason` STRING COMMENT 'Explanation for the DSD vendors refusal.',
    `rejected_quantity` STRING COMMENT 'Units rejected due to damage, spoilage, or non‑conformance.',
    `rejection_reason` STRING COMMENT 'Free‑text or coded reason why items were rejected.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the delivery to arrive at the receiving location.',
    `serial_number` STRING COMMENT 'Unique serial identifier for serialized items.',
    `shrink_reason` STRING COMMENT 'Reason code or description for shrinkage observed at receipt.',
    `sign_off_name` STRING COMMENT 'Name of the employee who signed off on the receipt.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature of the product at receipt for cold‑chain compliance.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the recorded temperature met the products required range.',
    `temperature_unit` STRING COMMENT 'Unit of measure for the temperature reading (Celsius or Fahrenheit).. Valid values are `C|F`',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the received goods before discounts or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receiving record.',
    CONSTRAINT pk_receiving_record PRIMARY KEY(`receiving_record_id`)
) COMMENT 'Inbound inventory receiving records for all goods arriving at stores and DCs — including DC-sourced replenishment, Direct Store Delivery (DSD) from vendor-managed distributors, and inter-location transfers. Captures receiving type (DC-sourced, DSD, transfer), PO or invoice reference, vendor/carrier, DSD vendor identifier, scheduled and actual delivery dates, expected/received/accepted/rejected quantities with rejection reasons, refused quantities with reason for DSD, temperature at receipt for cold chain items, backdoor receiver sign-off, payment terms reference, and receiving status (scheduled, partial, complete, discrepant). Sourced from Manhattan WMS receiving module and SAP MM goods receipt (MIGO). Supports DSD vendor reconciliation, accounts payable three-way match, store-level inventory updates, and DSD-specific audit workflows. This is the single source of truth for all inbound inventory receipts regardless of delivery channel.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`temperature_zone` (
    `temperature_zone_id` BIGINT COMMENT 'Primary key for temperature_zone',
    `parent_temperature_zone_id` BIGINT COMMENT 'Self-referencing FK on temperature_zone (parent_temperature_zone_id)',
    `compliance_status` STRING COMMENT 'Indicates whether the zone meets regulatory temperature and humidity compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was created in the master reference system.',
    `humidity_max_percent` DECIMAL(18,2) COMMENT 'Upper bound of the relative humidity range for the zone, expressed as a percentage.',
    `humidity_min_percent` DECIMAL(18,2) COMMENT 'Lower bound of the relative humidity range for the zone, expressed as a percentage.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the temperature zone is currently active and usable in operations.',
    `monitoring_required_flag` BOOLEAN COMMENT 'Indicates if continuous temperature monitoring is required for this zone.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the zone, such as special handling instructions.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Upper bound of the temperature range maintained in the zone, expressed in degrees Celsius.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Lower bound of the temperature range maintained in the zone, expressed in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zone record.',
    `zone_code` STRING COMMENT 'Short alphanumeric code used to identify the temperature zone in operational systems.',
    `zone_name` STRING COMMENT 'Human‑readable name of the temperature zone (e.g., Cold Storage, Frozen Bay, Ambient Shelf).',
    `zone_type` STRING COMMENT 'Category of temperature control applied to the zone.',
    CONSTRAINT pk_temperature_zone PRIMARY KEY(`temperature_zone_id`)
) COMMENT 'Master reference table for temperature_zone. Referenced by zone_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_reorder_policy_id` FOREIGN KEY (`reorder_policy_id`) REFERENCES `grocery_ecm`.`inventory`.`reorder_policy`(`reorder_policy_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_storage_location_id` FOREIGN KEY (`primary_goods_storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_receiving_record_id` FOREIGN KEY (`receiving_record_id`) REFERENCES `grocery_ecm`.`inventory`.`receiving_record`(`receiving_record_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `grocery_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `grocery_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `grocery_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_reorder_policy_id` FOREIGN KEY (`reorder_policy_id`) REFERENCES `grocery_ecm`.`inventory`.`reorder_policy`(`reorder_policy_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_replenishment_signal_id` FOREIGN KEY (`replenishment_signal_id`) REFERENCES `grocery_ecm`.`inventory`.`replenishment_signal`(`replenishment_signal_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_temperature_zone_id` FOREIGN KEY (`temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_primary_transfer_storage_location_id` FOREIGN KEY (`primary_transfer_storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ADD CONSTRAINT `fk_inventory_temperature_zone_parent_temperature_zone_id` FOREIGN KEY (`parent_temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_visibility');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `reorder_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `tpr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Event Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available‑to‑Sell Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `cold_chain_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold‑Chain Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Sales Value');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `fifo_lifo_indicator` SET TAGS ('dbx_business_glossary_term' = 'FIFO/LIFO Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `fifo_lifo_indicator` SET TAGS ('dbx_value_regex' = 'fifo|lifo');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_cycle_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_cycle_count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On‑Hand Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `on_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'On‑Order Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Detection Method');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_detection_method` SET TAGS ('dbx_value_regex' = 'pos_scan|cao_signal|manual_audit');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Duration (Hours)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock End Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_root_cause` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Root Cause');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_root_cause` SET TAGS ('dbx_value_regex' = 'supplier|dc|store_receiving|shrink|demand_spike');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Start Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `perishable_category` SET TAGS ('dbx_business_glossary_term' = 'Perishable Category');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `perishable_category` SET TAGS ('dbx_value_regex' = 'fresh|frozen|dry|canned');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `shrink_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shrink Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `temperature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'stock_visibility');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (DLID)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (SLID)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `receiving_record_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Record Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `wms_task_id` SET TAGS ('dbx_business_glossary_term' = 'Wms Task Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_at_movement` SET TAGS ('dbx_business_glossary_term' = 'Cost at Movement (CAM)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method (CM)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average|specific_identification');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cycle_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cycle‑Count Quantity (CCQ)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference (DR)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status (MS)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method (IVM)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|average|standard');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_cycle_count_correction` SET TAGS ('dbx_business_glossary_term' = 'Cycle‑Count Correction Flag (CCF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag (MEF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_physical_inventory` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Flag (PIF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_reserved` SET TAGS ('dbx_business_glossary_term' = 'Reserved Flag (RF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `is_shrink` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag (SF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code (MRC)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp (MT)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (MT)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|adjustment|correction|other');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity (QTY)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason (SR)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|loss|other');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_mm|manhattan_wms|oracle_retail|blue_yonder');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag (TCF)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (TEMP)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit (TU)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'c|f|k');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `transaction_document_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Document Number (TDN)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|kg|lb|case|pallet');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` SET TAGS ('dbx_subdomain' = 'stock_visibility');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_record_id` SET TAGS ('dbx_business_glossary_term' = 'Shrink Record Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `compliance_flag_haccp` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Disposition Method');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'markdown|donation|disposal|return_to_vendor|recycle');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `donation_recipient` SET TAGS ('dbx_business_glossary_term' = 'Donation Recipient');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost of Shrink');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes / Comments');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `quantity_lost` SET TAGS ('dbx_business_glossary_term' = 'Quantity Lost');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_category` SET TAGS ('dbx_business_glossary_term' = 'Shrink Category');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_category` SET TAGS ('dbx_value_regex' = 'inventory|financial|compliance');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_cause` SET TAGS ('dbx_business_glossary_term' = 'Shrink Cause');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_cause` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|admin_error|vendor_short_ship|unknown');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_event_number` SET TAGS ('dbx_business_glossary_term' = 'Shrink Event Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_record_status` SET TAGS ('dbx_business_glossary_term' = 'Shrink Record Status');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_record_status` SET TAGS ('dbx_value_regex' = 'open|closed|reversed|pending_review');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (°C/°F)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `temperature_violation` SET TAGS ('dbx_business_glossary_term' = 'Temperature Violation Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|BOX|CASE');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'stock_visibility');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `slot_location_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'full|cycle|spot|ad_hoc');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-d{8}$');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_reason` SET TAGS ('dbx_business_glossary_term' = 'Count Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_reason` SET TAGS ('dbx_value_regex' = 'audit|shrink|replenishment|cycle|other');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|approved|rejected');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `is_out_of_stock` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_flag` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|administrative|other');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `temperature_reading_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `tolerance_flag` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|kg|lb');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value (USD)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `replenishment_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Signal Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `allocation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `reorder_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `tpr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Event Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `demand_forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Date');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `demand_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Units');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `forecast_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `inventory_on_hand` SET TAGS ('dbx_business_glossary_term' = 'On‑Hand Inventory');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `inventory_reserved` SET TAGS ('dbx_business_glossary_term' = 'Reserved Inventory');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `inventory_shrink` SET TAGS ('dbx_business_glossary_term' = 'Inventory Shrinkage');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Signal Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `is_oos` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Signal Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Signal Priority Level');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `reorder_point_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `replenishment_signal_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Signal Status');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `replenishment_signal_status` SET TAGS ('dbx_value_regex' = 'pending|converted|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `signal_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signal Generated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Signal Type');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_value_regex' = 'auto|manual_override');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `signal_version` SET TAGS ('dbx_business_glossary_term' = 'Signal Version');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'blue_yonder|oracle_replenishment');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `suggested_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Suggested Order Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'stock_visibility');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock Event ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `replenishment_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Signal ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `tpr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Event Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `actual_sales_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Sales Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'pos_scan|cao_signal|manual_audit');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'OOS Duration (Hours)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Sales Value');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `forecasted_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Demand Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `is_resolved` SET TAGS ('dbx_business_glossary_term' = 'OOS Resolved Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|dc|mfc');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'OOS Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OOS End Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_severity` SET TAGS ('dbx_business_glossary_term' = 'OOS Severity');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OOS Start Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `quantity_after` SET TAGS ('dbx_business_glossary_term' = 'Quantity After Restock');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `quantity_before` SET TAGS ('dbx_business_glossary_term' = 'Quantity Before OOS');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'supplier_oos|dc_oos|store_delay|shrink|demand_spike|other');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `shrink_type` SET TAGS ('dbx_business_glossary_term' = 'Shrink Type');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `shrink_type` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|none');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'perishable_control');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `best_by_date` SET TAGS ('dbx_business_glossary_term' = 'Best‑By Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `cold_chain_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Requirement Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO‑3)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `entry_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Entry Temperature (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|recalled|expired|consumed|pending');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'perishable|non_perishable|regulated|raw_material');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine End Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Start Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Received Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_check_date` SET TAGS ('dbx_business_glossary_term' = 'Rotation Check Date');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_checked_by` SET TAGS ('dbx_business_glossary_term' = 'Rotation Checked By (Employee ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotation Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Rotation Method');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_method` SET TAGS ('dbx_value_regex' = 'FIFO|FEFO|LIFO');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rotation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rotation Sequence Number');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|kg|lb|liter');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `usda_fda_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'USDA/FDA Certification Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'perishable_control');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (SL_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier (DC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Fixture Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `mfc_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Micro‑Fulfillment Center Identifier (MFC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier (AISLE)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `available_units` SET TAGS ('dbx_business_glossary_term' = 'Available Units (AVAILABLE_UNITS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier (BAY)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bin Identifier (BIN)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity Units (CAP_UNITS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity Volume (cubic meters) (CAP_VOL_M3)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity Weight (kg) (CAP_WGT_KG)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `current_onhand_units` SET TAGS ('dbx_business_glossary_term' = 'Current On‑Hand Units (ONHAND_UNITS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level (FLOOR_LVL)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Flag (ACCESSIBLE_FLAG)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `is_security_restricted` SET TAGS ('dbx_business_glossary_term' = 'Security Restricted Flag (SEC_RESTRICTED)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date (CYCLE_COUNT_DT)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `last_inventory_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Check Timestamp (INV_CHECK_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (SLC)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name (SLN)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type (SLT)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑Of‑Stock Flag (OOS_FLAG)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `reserved_units` SET TAGS ('dbx_business_glossary_term' = 'Reserved Units (RESERVED_UNITS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `shelf` SET TAGS ('dbx_business_glossary_term' = 'Shelf Identifier (SHELF)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Shrink Units (SHRINK_UNITS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status (SLS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|closed');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C) (TEMP_MAX_C)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C) (TEMP_MIN_C)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Zone Classification (ZONE_CLASS)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `primary_transfer_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_mode` SET TAGS ('dbx_business_glossary_term' = 'Carrier Mode');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_mode` SET TAGS ('dbx_value_regex' = 'truck|van|rail|air|drone');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `compliance_document_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center|warehouse');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Dock Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Transfer Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_fifo_rotation` SET TAGS ('dbx_business_glossary_term' = 'FIFO Rotation Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `is_lifo_rotation` SET TAGS ('dbx_business_glossary_term' = 'LIFO Rotation Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shrink_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shrink Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|other');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_location_type` SET TAGS ('dbx_business_glossary_term' = 'Source Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center|warehouse');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `temperature_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Status');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `temperature_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Date');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number (TO_NUMBER)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Status');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_status` SET TAGS ('dbx_value_regex' = 'created|approved|in_transit|received|closed|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Type');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_type` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_value_regex' = 'replenishment|rebalancing|recall|seasonal|promotion|damage');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|kg|lb|case|pallet');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `reorder_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit Identifier (SKU_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `vendor_lead_time_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `economic_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Economic Order Quantity (EOQ)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date (EFFECTIVE_FROM)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date (EFFECTIVE_UNTIL)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level (MAX_STOCK_LEVEL)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes (NOTES)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple (ORDER_MULTIPLE)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Number (POLICY_NO)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Type (POLICY_TYPE)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'min_max|demand_driven|vendor_managed|custom');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number (VERSION)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority Level (PRIORITY_LEVEL)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (REORDER_POINT)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `reorder_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Status (STATUS)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `reorder_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|draft');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method (REPLENISH_METHOD)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'min_max|demand_driven|vendor_managed');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Frequency (REVIEW_CYCLE)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SAFETY_STOCK_QTY)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` SET TAGS ('dbx_subdomain' = 'perishable_control');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `perishable_rotation_id` SET TAGS ('dbx_business_glossary_term' = 'Perishable Rotation ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `days_to_expiry_at_check` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry at Check');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rotation_check');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rotation Check Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `rotation_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rotation Check Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `rotation_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotation Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Rotation Method');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `rotation_method` SET TAGS ('dbx_value_regex' = 'FIFO|FEFO|LIFO');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `rotation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rotation Sequence Number');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receiving_record_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Record ID');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `direct_store_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `cycle_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `dsd_vendor_identifier` SET TAGS ('dbx_business_glossary_term' = 'DSD Vendor Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|Average');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `is_cycle_count_correction` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Correction Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `is_physical_inventory` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `is_shrink` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receiving_record_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receiving_record_status` SET TAGS ('dbx_value_regex' = 'scheduled|partial|complete|discrepant|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receiving_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Type');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `receiving_type` SET TAGS ('dbx_value_regex' = 'dc_sourced|dsd|transfer');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `refused_quantity` SET TAGS ('dbx_business_glossary_term' = 'Refused Quantity (DSD)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `refused_reason` SET TAGS ('dbx_business_glossary_term' = 'Refused Reason (DSD)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `sign_off_name` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Name');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` SET TAGS ('dbx_subdomain' = 'perishable_control');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ALTER COLUMN `temperature_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ALTER COLUMN `parent_temperature_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
