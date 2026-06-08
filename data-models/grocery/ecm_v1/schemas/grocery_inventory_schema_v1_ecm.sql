-- Schema for Domain: inventory | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`inventory` COMMENT 'Real-time and historical stock positions across all stores, distribution centers, and MFCs. Manages on-hand quantities, reserved stock, FIFO/LIFO rotation tracking, shrink records (theft, spoilage, damage), OOS monitoring, cycle counts, cold chain temperature compliance, and CAO replenishment signals. Integrates with WMS, SAP MM, and ERP systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique surrogate key for each stock position record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category‑Level Stock Position Reporting requires each stock position to be tied to its product category for aggregated inventory metrics.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Store performance dashboard combines grocery stock positions with fuel center sales; linking each stock position to its fuel center enables per‑store profitability analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Holding cost allocation ties each stock position to a cost center for budgeting and profitability analysis per store.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Stock position is physically located within a store department; linking enables department‑level inventory visibility.',
    `product_item_id` BIGINT COMMENT 'FK to product.item.item_id — Core inventory-to-product join enabling stock queries by product attributes (category, brand, vendor). Fundamental to replenishment, OOS analysis, and shrink reporting.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: PHARMACY STOCK AUDIT: ties each stock position to the pharmacy location for drug inventory compliance and daily stock‑reconciliation reports.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional Allocation: inventory positions are earmarked for a campaign to ensure shelf space and display compliance.',
    `sku_id` BIGINT COMMENT 'Internal surrogate key referencing the product (SKU) whose inventory is tracked.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Link stock_position to its physical storage location for precise inventory location tracking.',
    `store_location_id` BIGINT COMMENT 'FK to store.store_location.store_location_id — Links stock positions to physical store locations for store-level inventory visibility, replenishment triggers, and OOS alerting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PROCUREMENT PLANNING: Stock position reports need primary supplier to calculate lead times and order allocation per SKU.',
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
    `associate_id` BIGINT COMMENT 'Identifier of the manager who approved the adjustment or movement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Internal movements are charged to a cost center to track transfer costs and support internal charge‑back reporting.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Goods movement often occurs between departments; linking provides departmental movement tracking.',
    `storage_location_id` BIGINT COMMENT 'Location (store, DC, MFC) to which inventory is added.',
    `primary_goods_storage_location_id` BIGINT COMMENT 'Location (store, DC, MFC) from which inventory is removed.',
    `product_item_id` BIGINT COMMENT 'Unique identifier of the SKU or product being moved.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Goods movement (inbound/outbound) is audited against the PO that generated the movement for traceability and audit.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: TRACEABILITY: Inbound goods movements must capture the supplying vendor for compliance and supplier performance audits.',
    `adjustment_reason` STRING COMMENT 'Free‑text or coded reason for an inventory adjustment (e.g., shrink, recount, donation).',
    `batch_number` STRING COMMENT 'Manufacturer batch number for items that require batch tracking.',
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
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of perishable or regulated items.',
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
    `food_safety_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_violation. Business justification: When shrink is caused by a food safety violation, the violation must be recorded and linked to the shrink record for traceability and regulatory reporting.',
    `product_item_id` BIGINT COMMENT 'Unique identifier of the product (SKU) that experienced shrink.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Shrink analysis per PO enables supplier chargebacks, loss accounting, and regulatory reporting of inventory loss.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link shrink_record to the stock_position it originates from, consolidating shrink events with the affected position.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the shrink occurred.',
    `compliance_flag_haccp` BOOLEAN COMMENT 'Indicates if the shrink event relates to a HACCP (food safety) issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shrink record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated cost.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `disposal_method` STRING COMMENT 'Method used to dispose of inventory that cannot be salvaged.. Valid values are `landfill|incineration|recycling`',
    `disposition_method` STRING COMMENT 'How the lost inventory was handled after identification.. Valid values are `markdown|donation|disposal|return_to_vendor|recycle`',
    `donation_recipient` STRING COMMENT 'Name of the charitable organization or entity receiving the donated inventory.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Monetary value of the lost inventory based on standard cost.',
    `line_number` STRING COMMENT 'Sequential number of the line within the shrink event.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability, especially for perishable items.',
    `markdown_effective_date` DATE COMMENT 'Date when the markdown price became effective.',
    `markdown_expiry_date` DATE COMMENT 'Date after which the markdown is no longer valid.',
    `markdown_original_price` DECIMAL(18,2) COMMENT 'Standard retail price of the item before markdown was applied.',
    `markdown_percentage` DECIMAL(18,2) COMMENT 'Percentage reduction from original price (e.g., 25.00 for 25%).',
    `markdown_price` DECIMAL(18,2) COMMENT 'Reduced price applied to the item for markdown disposition.',
    `notes` STRING COMMENT 'Free‑form text for additional details or observations.',
    `quantity_lost` DECIMAL(18,2) COMMENT 'Amount of inventory lost, expressed in the unit of measure.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the shrink event was captured in the source system.',
    `responsible_department` STRING COMMENT 'Organizational unit accountable for the shrink event.. Valid values are `store|warehouse|pharmacy|logistics|admin`',
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
    `associate_id` BIGINT COMMENT 'Identifier of the associate who performed the physical count.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the specific location (aisle, shelf, bin) within the store.',
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
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of perishable or regulated items.',
    `notes` STRING COMMENT 'Free‑form comments entered by the associate performing the count.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cycle count record.',
    `reserved_quantity` BIGINT COMMENT 'Quantity of the SKU reserved for open orders at count time.',
    `shrink_flag` BOOLEAN COMMENT 'Indicates whether the variance is classified as shrink (loss).',
    `shrink_reason` STRING COMMENT 'Root cause of shrink when shrink_flag is true.. Valid values are `theft|spoilage|damage|administrative|other`',
    `sku` STRING COMMENT 'Retailer-assigned identifier for the product being counted.. Valid values are `^[A-Z0-9]{8,12}$`',
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
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category Replenishment Signal Aggregation groups signals by category to drive category‑wide ordering decisions.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Demand signal generated by an active campaign, used for automated replenishment planning.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the SKU for which the signal is generated.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the store, distribution center, or micro‑fulfillment center where the signal applies.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: AUTOMATED ORDERING: Replenishment signals must identify the designated supplier to generate correct purchase orders.',
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
    `associate_id` BIGINT COMMENT 'Indicates whether the OOS record was generated automatically by a system process or entered manually by a user.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Out‑of‑stock events trigger compliance obligations to report inventory shortages to health authorities; linking enables obligation tracking and audit.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order that was expected to deliver the SKU but contributed to the OOS.',
    `replenishment_signal_id` BIGINT COMMENT 'Identifier of the Computer‑Assisted Ordering (CAO) signal that triggered the OOS detection.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link oos_event to the stock_position to associate out‑of‑stock events with the exact inventory record.',
    `store_location_id` BIGINT COMMENT 'Internal identifier of the specific location (store number, DC code, or MFC ID).',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier responsible for the product when root cause is supplier OOS.',
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
    `sku` STRING COMMENT 'Unique identifier for the product (SKU) that experienced the out‑of‑stock condition.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if temperature‑controlled items remained within required range during the OOS period; otherwise false.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the OOS event record.',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Out-of-Stock (OOS) event records capturing when a SKU at a specific location transitions to zero available-to-sell quantity. Tracks OOS start timestamp, OOS end timestamp (when restocked), OOS duration in hours, root cause category (supplier OOS, DC OOS, store receiving delay, shrink, demand spike), estimated lost sales value, and whether the OOS was detected via POS scan failure, CAO signal, or manual audit. Critical for store operations performance and vendor fill-rate accountability.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique surrogate key for each lot or batch record.',
    `food_safety_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_violation. Business justification: Lot or batch failures that cause food safety violations are recorded; linking the batch to the violation supports recall management and regulatory documentation.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, store, or micro‑fulfillment center where the lot is stored.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier that provided the lot.',
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
    `product_sku` STRING COMMENT 'SKU of the product to which this lot or batch belongs.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`cold_chain_log` (
    `cold_chain_log_id` BIGINT COMMENT 'Primary key for cold_chain_log',
    `associate_id` BIGINT COMMENT 'Identifier of the employee who logged any manual corrective action.',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Remaining battery level of the sensor at time of reading.',
    `corrective_action_taken` STRING COMMENT 'Description of the action performed to resolve the excursion (e.g., re‑stock, equipment repair).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the log record was first created in the system.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the sensor reading was captured.',
    `excursion_duration_seconds` BIGINT COMMENT 'Total duration of the out‑of‑range event in seconds.',
    `excursion_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition returned to within thresholds.',
    `excursion_flag` BOOLEAN COMMENT 'True when temperature or humidity exceeds configured thresholds.',
    `excursion_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the first out‑of‑range condition was detected.',
    `haccp_compliance_status` STRING COMMENT 'Indicates whether the reading complies with HACCP food‑safety requirements.. Valid values are `compliant|non_compliant|pending`',
    `humidity_deviation_percent` DECIMAL(18,2) COMMENT 'Difference between measured humidity and configured threshold.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Measured relative humidity as a percentage.',
    `location_type` STRING COMMENT 'Category of the physical location hosting the zone.. Valid values are `store|distribution_center|micro_fulfillment_center|warehouse`',
    `max_temp_threshold_c` DECIMAL(18,2) COMMENT 'Configured upper bound for acceptable temperature in Celsius.',
    `max_temp_threshold_f` DECIMAL(18,2) COMMENT 'Configured upper bound for acceptable temperature in Fahrenheit.',
    `min_temp_threshold_c` DECIMAL(18,2) COMMENT 'Configured lower bound for acceptable temperature in Celsius.',
    `min_temp_threshold_f` DECIMAL(18,2) COMMENT 'Configured lower bound for acceptable temperature in Fahrenheit.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the reading.',
    `reading_quality_flag` STRING COMMENT 'Quality assessment of the sensor reading.. Valid values are `good|questionable|bad`',
    `reading_type` STRING COMMENT 'Indicates whether the record captures temperature, humidity, or both.. Valid values are `temperature|humidity`',
    `sensor_code` BIGINT COMMENT 'Unique identifier of the temperature/humidity sensor that generated the reading.',
    `sensor_status` STRING COMMENT 'Operational status of the sensor.. Valid values are `active|inactive|maintenance`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature in degrees Celsius.',
    `temperature_deviation_c` DECIMAL(18,2) COMMENT 'Difference between measured temperature and nearest threshold in Celsius.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Measured temperature in degrees Fahrenheit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the log record.',
    CONSTRAINT pk_cold_chain_log PRIMARY KEY(`cold_chain_log_id`)
) COMMENT 'Temperature and humidity monitoring log for cold chain inventory across refrigerated/frozen storage zones in stores, DCs, and MFCs. Captures sensor readings at defined intervals, zone identifier, temperature reading (°F/°C), humidity reading, min/max thresholds, excursion flag, excursion duration, corrective action taken, and HACCP compliance status. Supports EPA refrigerant management compliance and FDA cold chain requirements for perishable and pharmaceutical inventory.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique surrogate key for each storage location.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center that contains the location.',
    `mfc_profile_id` BIGINT COMMENT 'Identifier of the micro‑fulfillment center (MFC) where the location resides.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: CONTROLLED‑SUBSTANCE COMPLIANCE: maps storage locations used for drug storage to the pharmacy they serve, required for DEA audit and temperature‑monitoring reports.',
    `fulfillment_slot_id` BIGINT COMMENT 'Reference to the planogram slot that defines product placement for this location.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Location‑level campaign assignment: stores map locations to campaigns for end‑cap and aisle displays.',
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
    `temperature_zone` STRING COMMENT 'Temperature classification of the location for compliance with cold‑chain requirements.. Valid values are `ambient|cold|frozen`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the storage location record.',
    `zone_classification` STRING COMMENT 'Operational zone label used for routing and labor planning.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record of all physical storage locations within stores, DCs, and MFCs where inventory is held. Captures location type (sales floor, backroom, cooler, freezer, pharmacy vault, fuel tank, MFC bin), aisle, bay, shelf, bin coordinates, planogram slot reference, maximum capacity (units and weight), temperature zone classification, and active status. This is the SSOT for inventory location topology used by WMS putaway, picking, and replenishment workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`stock_reservation` (
    `stock_reservation_id` BIGINT COMMENT 'System‑generated unique identifier for each inventory reservation record.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Reservation for limited‑quantity offers: reservation records must reference the specific promo offer they protect.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer (or shopper) whose order triggered the reservation.',
    `store_location_id` BIGINT COMMENT 'Identifier of the physical location (store, distribution center, or micro‑fulfillment center) where inventory is reserved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reservation record was first persisted in the lakehouse.',
    `demand_document_number` BIGINT COMMENT 'Reference to the originating demand document (sales order, transfer order, production order, or OMS allocation).',
    `demand_document_type` STRING COMMENT 'Specifies the type of document that generated the reservation.. Valid values are `sales_order|transfer_order|production_order|oms_allocation`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time after which the reservation is automatically released if not fulfilled.',
    `is_auto_reservation` BOOLEAN COMMENT 'Indicates whether the reservation was generated automatically by system rules (true) or manually by an operator (false).',
    `location_type` STRING COMMENT 'Classifies the type of location holding the reserved stock.. Valid values are `store|distribution_center|micro_fulfillment_center`',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special handling instructions.',
    `reservation_number` STRING COMMENT 'Business‑visible identifier (e.g., reservation code) used in operational screens and reports.',
    `reservation_source` STRING COMMENT 'Originating system that created the reservation record.. Valid values are `sap|oms|manual`',
    `reservation_status` STRING COMMENT 'Current lifecycle state of the reservation indicating allocation progress.. Valid values are `open|partially_fulfilled|fulfilled|cancelled`',
    `reservation_timestamp` TIMESTAMP COMMENT 'The exact moment the reservation was created in the source system (e.g., SAP MM or OMS).',
    `reservation_type` STRING COMMENT 'Classifies the demand source that triggered the reservation: customer order, inter‑store transfer, production requirement, or automated replenishment.. Valid values are `order|transfer|production|replenishment`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory units reserved for the demand document.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the reserved quantity (e.g., each, kilogram, liter, case).. Valid values are `EA|KG|L|CASE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the reservation (e.g., status change, quantity adjustment).',
    CONSTRAINT pk_stock_reservation PRIMARY KEY(`stock_reservation_id`)
) COMMENT 'Records of inventory quantities reserved against specific demand documents — customer orders (click-and-collect, delivery), transfer orders, and production requirements. Captures reservation type, reserved quantity, reservation status (open, partially-fulfilled, fulfilled, cancelled), expiry timestamp, and the originating demand document reference. Prevents double-allocation of inventory across omnichannel order fulfillment and DC replenishment workflows. Sourced from SAP MM reservations and OMS allocation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`transfer_order` (
    `transfer_order_id` BIGINT COMMENT 'System-generated unique identifier for the transfer order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transfer orders incur internal costs; associating each order with a cost center enables charge‑back and profitability tracking.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the location (store, DC, MFC) receiving the transferred inventory.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who created the transfer order.',
    `primary_transfer_storage_location_id` BIGINT COMMENT 'Identifier of the location (store, DC, MFC) from which inventory is being transferred.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`stock_adjustment` (
    `stock_adjustment_id` BIGINT COMMENT 'Unique system-generated identifier for each stock adjustment record.',
    `associate_id` BIGINT COMMENT 'Identifier of the manager who approved the stock adjustment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial posting of inventory adjustments requires linking each adjustment to a GL account for accurate expense/revenue reporting.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Adjustment due to promotion: markdowns or corrections linked to the offer that triggered the change.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link stock_adjustment directly to the stock_position it adjusts, enabling audit of adjustments per position.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the adjustment took place.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: ADJUSTMENT AUDIT: Adjustments caused by supplier issues (quality, recall) require linking to the responsible supplier for KPI tracking.',
    `adjustment_number` STRING COMMENT 'Human‑readable identifier assigned to the adjustment (e.g., ADJ‑20230915‑001).',
    `adjustment_reason_code` STRING COMMENT 'Standard code describing why the adjustment was made.. Valid values are `cycle_count|system_correction|damage|donation|recall|other`',
    `adjustment_reason_description` STRING COMMENT 'Free‑text description providing additional context for the adjustment reason.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment physically occurred in the store or warehouse.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was formally approved.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of one unit of the product at the time of adjustment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.',
    `cycle_count_flag` BOOLEAN COMMENT 'True if the adjustment originated from a cycle‑count variance.',
    `effective_date` DATE COMMENT 'Date on which the adjustment becomes effective for reporting purposes.',
    `inventory_status_after` STRING COMMENT 'Stock status after the adjustment is applied.. Valid values are `on_hand|reserved|in_transit|allocated|unknown`',
    `inventory_status_before` STRING COMMENT 'Stock status prior to the adjustment.. Valid values are `on_hand|reserved|in_transit|allocated|unknown`',
    `location_type` STRING COMMENT 'Classification of the location (e.g., store, DC, MFC).. Valid values are `store|distribution_center|micro_fulfillment_center|warehouse`',
    `notes` STRING COMMENT 'Free‑form comments or observations entered by the adjusting personnel.',
    `quantity_adjusted` DECIMAL(18,2) COMMENT 'Signed quantity change; positive for additions, negative for reductions.',
    `shrink_flag` BOOLEAN COMMENT 'True if the adjustment is recorded as shrink (theft, spoilage, damage).',
    `sku` STRING COMMENT 'Unique product identifier to which the adjustment applies.',
    `source_document_reference` STRING COMMENT 'Reference to the original SAP MM document or other source supporting the adjustment.',
    `stock_adjustment_status` STRING COMMENT 'Current processing state of the adjustment.. Valid values are `pending|approved|rejected|cancelled`',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if the adjustment is related to a temperature‑control violation.',
    `total_adjusted_cost` DECIMAL(18,2) COMMENT 'Monetary impact of the adjustment (quantity_adjusted * cost_per_unit).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity adjusted.. Valid values are `each|case|kg|lb|liter`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the adjustment record.',
    CONSTRAINT pk_stock_adjustment PRIMARY KEY(`stock_adjustment_id`)
) COMMENT 'Authorized inventory adjustment records correcting on-hand quantities outside of normal goods movement flows. Captures adjustment reason code (cycle count variance, system correction, damage write-off, donation, recall removal), quantity adjusted (positive or negative), adjusted value at cost, approving manager, adjustment date, and reference to supporting documentation. Provides a controlled audit trail for all non-transactional stock changes. Sourced from SAP MM inventory adjustment postings.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`reorder_policy` (
    `reorder_policy_id` BIGINT COMMENT 'Unique surrogate key for each reorder policy record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reorder policies are budgeted against cost centers to control inventory replenishment spend.',
    `demand_forecast_id` BIGINT COMMENT 'Link to the demand forecast record that supplies expected sales for the SKU‑location.',
    `sku_id` BIGINT COMMENT 'Identifier of the product (SKU) to which this reorder policy applies.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the policy is enforced.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SUPPLIER‑SPECIFIC POLICY: Reorder points and safety stock are often defined per supplier for a SKU, needed for procurement analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy record was first created in the system.',
    `economic_order_quantity` STRING COMMENT 'Calculated optimal order size that minimizes total holding and ordering costs.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes binding and may be used for replenishment calculations.',
    `effective_until` DATE COMMENT 'Date on which the policy ceases to be active; null indicates an open‑ended policy.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the policy parameters were last reviewed or recalibrated.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to receipt at the location.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`recall_hold` (
    `recall_hold_id` BIGINT COMMENT 'Unique system-generated identifier for each recall hold record.',
    `food_safety_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_violation. Business justification: Recall holds are often initiated due to identified food safety violations; linking provides traceability from hold to the specific violation.',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) that is subject to the hold.',
    `storage_location_id` BIGINT COMMENT 'Reference to the store, distribution center, or micro‑fulfillment center where the hold is applied.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor responsible for the affected product.',
    `batch_number` STRING COMMENT 'Batch identifier for the affected product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall hold record was first created in the lakehouse.',
    `disposition_instruction` STRING COMMENT 'Action to be taken with the held product.. Valid values are `return_to_vendor|destroy|donate|rework`',
    `hold_end_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was resolved or released.',
    `hold_number` STRING COMMENT 'Business identifier assigned to the recall hold, used for tracking and communication with regulators and suppliers.',
    `hold_resolution_date` DATE COMMENT 'Calendar date on which the hold was resolved or released.',
    `hold_start_timestamp` TIMESTAMP COMMENT 'Date and time when the hold became effective.',
    `hold_type` STRING COMMENT 'Classification of the recall hold based on regulatory or internal criteria.. Valid values are `FDA_Class_I|FDA_Class_II|FDA_Class_III|Supplier_Voluntary|Internal_Quarantine`',
    `is_shrink` BOOLEAN COMMENT 'True if the hold is due to inventory shrink (theft, spoilage, damage).',
    `is_temperature_compliant` BOOLEAN COMMENT 'Indicates whether the held product meets required cold‑chain temperature specifications.',
    `lot_number` STRING COMMENT 'Lot identifier associated with the affected product batch.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the hold.',
    `quantity_on_hold` DECIMAL(18,2) COMMENT 'Total amount of product units placed on hold.',
    `recall_agency` STRING COMMENT 'Regulatory agency that issued the recall or hold.. Valid values are `FDA|USDA|State|Other`',
    `recall_classification` STRING COMMENT 'Regulatory classification of the recall severity.. Valid values are `Class I|Class II|Class III`',
    `recall_hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `active|released|disposed|closed`',
    `recall_reason` STRING COMMENT 'Root cause for the recall or hold.. Valid values are `contamination|mislabel|foreign_object|allergen|other`',
    `regulatory_notification_reference` STRING COMMENT 'Reference number or identifier of the regulatory notice (e.g., FDA recall notice).',
    `source_system` STRING COMMENT 'Originating system that created the hold record (e.g., SAP, Oracle, WMS).',
    `temperature_reading_c` DECIMAL(18,2) COMMENT 'Recorded temperature at the time of hold for temperature‑sensitive items.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity on hold.. Valid values are `each|kg|lb|case`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recall hold record.',
    CONSTRAINT pk_recall_hold PRIMARY KEY(`recall_hold_id`)
) COMMENT 'Inventory hold and recall management records for SKUs subject to FDA/USDA product recalls, supplier quality holds, or internal quality quarantine actions. Captures hold type (FDA Class I/II/III recall, supplier voluntary recall, internal quarantine), affected lot/batch range, quantity on hold, hold status (active, released, disposed), regulatory notification reference, disposition instructions (return-to-vendor, destroy, donate), and hold resolution date. Critical for FDA food safety compliance and USDA meat/poultry recall protocols.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`perishable_rotation` (
    `perishable_rotation_id` BIGINT COMMENT 'System-generated unique identifier for each perishable rotation record.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate who executed the rotation check.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Perishable Rotation Compliance per Category links rotation events to categories for regulatory and freshness reporting.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU/lot being evaluated for rotation.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the rotation check occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rotation record was first inserted into the lakehouse.',
    `days_to_expiry_at_check` STRING COMMENT 'Number of calendar days remaining until the lot expires at the moment of the check.',
    `event_payload` STRING COMMENT 'JSON‑encoded snapshot of key fields captured at the time of the rotation check for downstream processing.',
    `event_type` STRING COMMENT 'Categorizes the event; fixed value rotation_check for this product.. Valid values are `rotation_check`',
    `expiration_date` DATE COMMENT 'Calendar date on which the lot is required to be sold or removed.',
    `lot_number` STRING COMMENT 'Batch or lot number assigned by the supplier for traceability.',
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
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: REQUIRED: Receiving audit logs need the associate who performed the receipt; this is essential for compliance and traceability reports.',
    `food_safety_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_inspection. Business justification: Each received shipment is inspected for safety; associating the inspection result with the receiving record ensures compliance verification and auditability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Receiving costs (duties, freight) are posted to GL accounts; the link supports AP integration and financial reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Receiving ties each receipt to its PO for invoice matching, compliance reporting, and supplier performance tracking.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where receipt occurred.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplying vendor.',
    `accepted_quantity` STRING COMMENT 'Units approved for inventory after quality and compliance checks.',
    `batch_number` STRING COMMENT 'Batch identifier used for manufacturing or production tracking.',
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
    `lot_number` STRING COMMENT 'Lot identifier for traceability of perishable or regulated items.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`markdown_event` (
    `markdown_event_id` BIGINT COMMENT 'Primary key for markdown_event',
    `associate_id` BIGINT COMMENT 'Identifier of the employee who approved the markdown event.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Markdowns affect revenue accounts; linking to a GL account enables proper expense posting and margin analysis.',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Required for the Markdown Audit Report that ties each inventory markdown event to its pricing markdown record for compliance and margin analysis.',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Markdown Impact Analysis per planogram links markdown events to the specific planogram to assess shelf‑level price changes.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the stock‑keeping unit being marked down.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the markdown occurred.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the markdown event received final approval.',
    `batch_number` STRING COMMENT 'Batch or lot identifier associated with the inventory units being marked down.',
    `cost_at_markdown` DECIMAL(18,2) COMMENT 'Standard cost of the SKU at the time of markdown, used for margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the markdown record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price values (e.g., USD).',
    `disposition_outcome` STRING COMMENT 'Final disposition of the markdown inventory (e.g., sold, donated, disposed, returned).. Valid values are `sold|donated|disposed|returned`',
    `effective_date` DATE COMMENT 'Date on which the markdown price becomes active.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the markdown was applied to inventory.',
    `expiration_date` DATE COMMENT 'Expiration date of the SKU, relevant for perishable items.',
    `expiry_date` DATE COMMENT 'Date after which the markdown is no longer valid (nullable if indefinite).',
    `is_manual_entry` BOOLEAN COMMENT 'True if the markdown was entered manually rather than generated automatically.',
    `markdown_event_status` STRING COMMENT 'Current processing state of the markdown event.. Valid values are `pending|active|completed|cancelled`',
    `markdown_percentage` DECIMAL(18,2) COMMENT 'Percentage reduction from original price to markdown price.',
    `markdown_price` DECIMAL(18,2) COMMENT 'Reduced price applied to the SKU during the markdown event.',
    `markdown_type` STRING COMMENT 'Category describing why the markdown was applied (e.g., clearance, near‑expiry, seasonal, damage, shrink).. Valid values are `clearance|near_expiry|seasonal|damage|shrink`',
    `markdown_version` STRING COMMENT 'Version counter for the markdown record to support audit of changes.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the markdown.',
    `original_price` DECIMAL(18,2) COMMENT 'Standard retail price of the SKU before any markdown.',
    `quantity_marked_down` STRING COMMENT 'Number of units of the SKU that were subject to the markdown.',
    `reason_code` STRING COMMENT 'Internal code indicating the business reason for the markdown (e.g., slow_moving, overstock, promotional).',
    `shrink_type` STRING COMMENT 'Category of inventory loss associated with the markdown (e.g., theft, spoilage, damage).. Valid values are `theft|spoilage|damage`',
    `source_system` STRING COMMENT 'Originating system that generated the markdown record (e.g., SAP, Oracle).',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the markdown item met cold‑chain temperature requirements at the time of markdown.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the markdown record.',
    CONSTRAINT pk_markdown_event PRIMARY KEY(`markdown_event_id`)
) COMMENT 'Inventory markdown events applied to slow-moving, near-expiry, or clearance stock to accelerate sell-through and reduce shrink. Captures markdown type (clearance, near-expiry, seasonal, damage), original retail price, markdown price, markdown percentage, quantity marked down, markdown effective date, markdown expiry date, and disposition outcome (sold, donated, disposed). Supports perishable inventory management, shrink reduction programs, and GMROI optimization.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`stock_snapshot` (
    `stock_snapshot_id` BIGINT COMMENT 'Primary key for stock_snapshot',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: Assortment Performance Dashboard joins inventory snapshot with assortment items to evaluate on‑hand stock vs planogram placement.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Link each stock_snapshot to the stock_position it captures for easy navigation between snapshot and current position.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the physical location (store, distribution center, micro‑fulfillment center) where the inventory is held.',
    `available_quantity` BIGINT COMMENT 'Units available for sale (on‑hand minus reserved).',
    `cold_chain_compliance_flag` BOOLEAN COMMENT 'True if temperature‑controlled items met compliance at snapshot time.',
    `estimated_lost_sales_value` DECIMAL(18,2) COMMENT 'Monetary estimate of sales lost due to the out‑of‑stock event.',
    `expiration_date` DATE COMMENT 'Date when the product expires, if applicable.',
    `fifo_lifo_indicator` STRING COMMENT 'Indicates whether the inventory is managed using FIFO or LIFO rotation.. Valid values are `FIFO|LIFO`',
    `in_transit_quantity` BIGINT COMMENT 'Units that have been shipped to the location but not yet received.',
    `inventory_cost_at_snapshot` DECIMAL(18,2) COMMENT 'Total cost value of the on‑hand inventory at snapshot time.',
    `inventory_retail_value_at_snapshot` DECIMAL(18,2) COMMENT 'Total retail (selling price) value of the on‑hand inventory at snapshot time.',
    `inventory_valuation_method` STRING COMMENT 'Method used to value inventory cost at snapshot (e.g., standard, moving average, FIFO, LIFO).. Valid values are `standard|moving_average|fifo|lifo`',
    `is_perishable` BOOLEAN COMMENT 'True if the SKU is classified as perishable.',
    `last_cycle_count_quantity` BIGINT COMMENT 'Quantity recorded during the last cycle count.',
    `last_cycle_count_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical cycle count for this SKU‑location.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the snapshot.',
    `on_hand_quantity` BIGINT COMMENT 'Total units of the SKU physically present at the location at snapshot time.',
    `on_order_quantity` BIGINT COMMENT 'Units ordered from suppliers but not yet shipped to the location.',
    `oos_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the out‑of‑stock event in hours.',
    `oos_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the out‑of‑stock condition ended, if resolved.',
    `oos_flag` BOOLEAN COMMENT 'Indicates whether the SKU was out of stock at the snapshot time.',
    `oos_root_cause` STRING COMMENT 'Primary reason for the out‑of‑stock condition (enumerated).. Valid values are `stockout|supplier|logistics|demand|system`',
    `oos_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the out‑of‑stock condition began, if applicable.',
    `perishable_category` STRING COMMENT 'Category describing the type of perishable product.. Valid values are `fresh|frozen|dry|canned|produce|dairy`',
    `reserved_quantity` BIGINT COMMENT 'Units of the SKU that are allocated to open orders or reservations and not available for new sales.',
    `shrink_quantity` BIGINT COMMENT 'Units lost due to theft, spoilage, damage, or administrative adjustments.',
    `snapshot_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the snapshot record was initially created in the data lake.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory snapshot was captured (EOD/EOW).',
    `snapshot_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the snapshot record.',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the snapshot data (e.g., SAP MM, Manhattan WMS).',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature of the storage environment at snapshot time.',
    `temperature_timestamp` TIMESTAMP COMMENT 'When the temperature reading was taken.',
    CONSTRAINT pk_stock_snapshot PRIMARY KEY(`stock_snapshot_id`)
) COMMENT 'Point-in-time historical snapshots of stock positions captured at end-of-day (EOD) or end-of-week (EOW) for each SKU-location combination. Captures snapshot timestamp, on-hand quantity, reserved quantity, in-transit quantity, on-order quantity, inventory value at cost (using current valuation method), and inventory value at retail. Enables period-over-period inventory trend analysis, shrink calculation by comparing successive snapshots, book-to-physical reconciliation, and financial inventory valuation reporting for SOX compliance. Distinct from real-time stock_position as it represents frozen historical states used for audit and financial close.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`valuation` (
    `valuation_id` BIGINT COMMENT 'System-generated unique identifier for each inventory valuation record.',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the valuation batch or run that groups multiple valuation lines.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Valuation entries must be posted to GL accounts to reflect inventory asset values and COGS in financial statements.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the stock keeping unit being valued.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, or micro‑fulfillment center where the inventory resides.',
    `prior_layer_valuation_id` BIGINT COMMENT 'Self-referencing FK on valuation (prior_layer_valuation_id)',
    `adjustment_reason` STRING COMMENT 'Reason for any manual or system adjustment to the valuation.. Valid values are `shrink|obsolescence|error|revaluation`',
    `compliance_flag_haccp` BOOLEAN COMMENT 'True if the inventory item complies with HACCP food‑safety standards.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier for financial reporting.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Cost assigned to a single unit of inventory based on the selected valuation method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the valuation record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.',
    `expiration_date` DATE COMMENT 'Date after which the inventory item must not be sold.',
    `financial_period` STRING COMMENT 'Fiscal period identifier (e.g., FY2025Q1) used for GL posting.',
    `is_adjusted` BOOLEAN COMMENT 'Indicates whether the valuation amount has been manually adjusted.',
    `is_physical_inventory` BOOLEAN COMMENT 'True if the record reflects a physical inventory count rather than a system estimate.',
    `lcm_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount applied when market value is lower than cost, per GAAP/IFRS LCM rules.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the valuation batch.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the inventory batch.',
    `lower_of_cost_or_market_flag` BOOLEAN COMMENT 'True if the lower‑of‑cost‑or‑market rule was applied to this record.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes related to the valuation.',
    `obsolescence_reserve_amount` DECIMAL(18,2) COMMENT 'Reserve for inventory that may become obsolete or unsellable.',
    `period_end_date` DATE COMMENT 'Fiscal period end date associated with this valuation snapshot.',
    `perishable_category` STRING COMMENT 'Category describing the type of perishable product.. Valid values are `fresh|frozen|dry|canned|produce|dairy`',
    `perishable_flag` BOOLEAN COMMENT 'True if the SKU is classified as perishable.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Physical count of units available for sale at the valuation moment.',
    `shrink_reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve for anticipated inventory shrink (theft, spoilage, damage).',
    `source_system` STRING COMMENT 'Originating operational system (e.g., SAP MM, Oracle Retail, Manhattan WMS).',
    `sox_compliant_flag` BOOLEAN COMMENT 'Indicates whether the valuation record meets Sarbanes‑Oxley compliance requirements.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'True if temperature readings for the item are within defined cold‑chain limits.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate cost of the on‑hand quantity (quantity_on_hand * cost_per_unit).',
    `total_retail_value` DECIMAL(18,2) COMMENT 'Aggregate retail price of the on‑hand quantity for gross‑margin reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the valuation record.',
    `valuation_date` DATE COMMENT 'Date on which the inventory valuation is performed.',
    `valuation_method` STRING COMMENT 'Method used to calculate inventory cost (e.g., FIFO, LIFO, weighted average, retail inventory method, standard cost).. Valid values are `weighted_average|fifo|lifo|retail|standard_cost`',
    `valuation_status` STRING COMMENT 'Current processing status of the valuation record.. Valid values are `pending|completed|adjusted|reconciled`',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Inventory cost layer and valuation records supporting GAAP/IFRS financial reporting. Captures valuation method (weighted average cost, FIFO, LIFO, retail inventory method), cost per unit, total inventory value at cost, total inventory value at retail, lower-of-cost-or-market (LCM) adjustments, shrink reserve accruals, obsolescence reserve, valuation date, and period-end book-to-physical reconciliation. Supports SOX-compliant inventory valuation for monthly/quarterly close, COGS calculation, gross margin reporting, and external audit evidence. Integrates with SAP MM material valuation and finance domain GL postings.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`pick` (
    `pick_id` BIGINT COMMENT 'Primary key for the pick association',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to the order line receiving the pick',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to the stock position being picked',
    `pick_timestamp` TIMESTAMP COMMENT 'Date‑time when the pick was performed',
    `quantity_picked` DECIMAL(18,2) COMMENT 'Amount of inventory units taken from the stock position for this order line',
    CONSTRAINT pk_pick PRIMARY KEY(`pick_id`)
) COMMENT 'This association captures each pick event linking a stock_position to an order_line. It records the quantity taken from a specific inventory location and the time of the pick, enabling audit of inventory consumption per order line.. Existence Justification: An order_line can be fulfilled from multiple stock_position records (different locations or batches) and each stock_position can serve many order_line records across orders. The picking process records the quantity taken and the timestamp for each stock_position‑order_line pair, creating a distinct record for every pick.';

CREATE OR REPLACE TABLE `grocery_ecm`.`inventory`.`lot_allocation` (
    `lot_allocation_id` BIGINT COMMENT 'Primary key for the LotAllocation association',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to the lot_batch',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to the order_line',
    `allocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation was performed',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'Quantity of the product allocated from the lot to the order line',
    CONSTRAINT pk_lot_allocation PRIMARY KEY(`lot_allocation_id`)
) COMMENT 'Represents the allocation of inventory lot/batch to a specific order line for traceability and recall management. Each record links one lot_batch to one order_line and captures allocation-specific data.. Existence Justification: A lot_batch can be allocated to many order_line records (multiple sales) and a single order_line can be fulfilled from multiple lot_batches when the quantity exceeds a single lot. The allocation is actively managed in the system for traceability, with attributes such as quantity_allocated and allocation_timestamp recorded for each allocation.';

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
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_primary_goods_storage_location_id` FOREIGN KEY (`primary_goods_storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_replenishment_signal_id` FOREIGN KEY (`replenishment_signal_id`) REFERENCES `grocery_ecm`.`inventory`.`replenishment_signal`(`replenishment_signal_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_primary_transfer_storage_location_id` FOREIGN KEY (`primary_transfer_storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ADD CONSTRAINT `fk_inventory_recall_hold_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ADD CONSTRAINT `fk_inventory_stock_snapshot_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_prior_layer_valuation_id` FOREIGN KEY (`prior_layer_valuation_id`) REFERENCES `grocery_ecm`.`inventory`.`valuation`(`valuation_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ADD CONSTRAINT `fk_inventory_pick_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ADD CONSTRAINT `fk_inventory_lot_allocation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `grocery_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ADD CONSTRAINT `fk_inventory_temperature_zone_parent_temperature_zone_id` FOREIGN KEY (`parent_temperature_zone_id`) REFERENCES `grocery_ecm`.`inventory`.`temperature_zone`(`temperature_zone_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Identifier (AMI)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (DLID)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (SLID)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PID)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `shrink_record_id` SET TAGS ('dbx_business_glossary_term' = 'Shrink Record Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Violation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
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
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Effective Date');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Expiry Date');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Price Before Markdown');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markdown Percentage');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `markdown_price` SET TAGS ('dbx_business_glossary_term' = 'Markdown Price');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes / Comments');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `quantity_lost` SET TAGS ('dbx_business_glossary_term' = 'Quantity Lost');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'store|warehouse|pharmacy|logistics|admin');
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
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
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
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_flag` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `shrink_reason` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage|administrative|other');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
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
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock Event ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `replenishment_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Signal ID');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
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
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Violation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
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
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU (Stock Keeping Unit)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `cold_chain_log_id` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Log Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Sensor Battery Level (%)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `excursion_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Excursion Duration (Seconds)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `excursion_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Excursion End Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Excursion Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `excursion_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Excursion Start Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `haccp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Status');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `haccp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `humidity_deviation_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Deviation (%)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center|warehouse');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `max_temp_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Threshold (C)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `max_temp_threshold_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Threshold (F)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `min_temp_threshold_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Threshold (C)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `min_temp_threshold_f` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Threshold (F)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `reading_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Reading Quality Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `reading_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'temperature|humidity');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `sensor_status` SET TAGS ('dbx_business_glossary_term' = 'Sensor Status');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `sensor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `temperature_deviation_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation (C)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (SL_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier (DC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `mfc_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Micro‑Fulfillment Center Identifier (MFC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `fulfillment_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Slot Identifier (PSI)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification (TZC)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|cold|frozen');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Zone Classification (ZONE_CLASS)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `stock_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Reservation ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `demand_document_number` SET TAGS ('dbx_business_glossary_term' = 'Demand Document ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `demand_document_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Document Type');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `demand_document_type` SET TAGS ('dbx_value_regex' = 'sales_order|transfer_order|production_order|oms_allocation');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiry Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `is_auto_reservation` SET TAGS ('dbx_business_glossary_term' = 'Automatic Reservation Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reservation Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_source` SET TAGS ('dbx_business_glossary_term' = 'Reservation Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_source` SET TAGS ('dbx_value_regex' = 'sap|oms|manual');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'open|partially_fulfilled|fulfilled|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'order|transfer|production|replenishment');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|CASE');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ALTER COLUMN `primary_transfer_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
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
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Adjustment ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'cycle_count|system_correction|damage|donation|recall|other');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Event Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `cycle_count_flag` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_status_after` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status After Adjustment');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_status_after` SET TAGS ('dbx_value_regex' = 'on_hand|reserved|in_transit|allocated|unknown');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_status_before` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status Before Adjustment');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `inventory_status_before` SET TAGS ('dbx_value_regex' = 'on_hand|reserved|in_transit|allocated|unknown');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|micro_fulfillment_center|warehouse');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `quantity_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Adjusted');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `shrink_flag` SET TAGS ('dbx_business_glossary_term' = 'Shrink Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `total_adjusted_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Adjusted Cost');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|kg|lb|liter');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `reorder_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reorder Policy Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Identifier (DEMAND_FORECAST_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit Identifier (SKU_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `economic_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Economic Order Quantity (EOQ)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date (EFFECTIVE_FROM)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date (EFFECTIVE_UNTIL)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TS)');
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (LEAD_TIME_DAYS)');
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
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Violation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_value_regex' = 'return_to_vendor|destroy|donate|rework');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold End Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Number');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Resolution Date');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Type');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'FDA_Class_I|FDA_Class_II|FDA_Class_III|Supplier_Voluntary|Internal_Quarantine');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `is_shrink` SET TAGS ('dbx_business_glossary_term' = 'Shrink Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `is_temperature_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `quantity_on_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hold');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_agency` SET TAGS ('dbx_business_glossary_term' = 'Recall Agency');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|State|Other');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Status');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_hold_status` SET TAGS ('dbx_value_regex' = 'active|released|disposed|closed');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `recall_reason` SET TAGS ('dbx_value_regex' = 'contamination|mislabel|foreign_object|allergen|other');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `regulatory_notification_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Reference');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `temperature_reading_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|kg|lb|case');
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `perishable_rotation_id` SET TAGS ('dbx_business_glossary_term' = 'Perishable Rotation ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Employee ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `days_to_expiry_at_check` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry at Check');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rotation_check');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
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
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
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
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
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
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `cost_at_markdown` SET TAGS ('dbx_business_glossary_term' = 'Cost at Markdown');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'sold|donated|disposed|returned');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Effective Date');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Expiry Date');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_event_status` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Status');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_event_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markdown Percentage');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_price` SET TAGS ('dbx_business_glossary_term' = 'Markdown Price');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_type` SET TAGS ('dbx_business_glossary_term' = 'Markdown Type');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_type` SET TAGS ('dbx_value_regex' = 'clearance|near_expiry|seasonal|damage|shrink');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `markdown_version` SET TAGS ('dbx_business_glossary_term' = 'Markdown Version');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Markdown Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `original_price` SET TAGS ('dbx_business_glossary_term' = 'Original Retail Price');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `quantity_marked_down` SET TAGS ('dbx_business_glossary_term' = 'Quantity Marked Down');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Markdown Reason Code');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `shrink_type` SET TAGS ('dbx_business_glossary_term' = 'Shrink Type');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `shrink_type` SET TAGS ('dbx_value_regex' = 'theft|spoilage|damage');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `stock_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Snapshot Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `cold_chain_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold‑Chain Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `estimated_lost_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Sales Value');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `fifo_lifo_indicator` SET TAGS ('dbx_business_glossary_term' = 'FIFO/LIFO Indicator');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `fifo_lifo_indicator` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `inventory_cost_at_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cost at Snapshot');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `inventory_retail_value_at_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Inventory Retail Value at Snapshot');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `last_cycle_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `last_cycle_count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On‑Hand Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `on_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'On‑Order Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Duration (Hours)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock End Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_root_cause` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Root Cause');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_root_cause` SET TAGS ('dbx_value_regex' = 'stockout|supplier|logistics|demand|system');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `oos_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Start Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `perishable_category` SET TAGS ('dbx_business_glossary_term' = 'Perishable Category');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `perishable_category` SET TAGS ('dbx_value_regex' = 'fresh|frozen|dry|canned|produce|dairy');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `shrink_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shrink Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `snapshot_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `snapshot_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ALTER COLUMN `temperature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Temperature Measurement Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation ID');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Batch ID');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `prior_layer_valuation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_value_regex' = 'shrink|obsolescence|error|revaluation');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `compliance_flag_haccp` SET TAGS ('dbx_business_glossary_term' = 'HACCP Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `financial_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Period');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `is_physical_inventory` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `lcm_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Lower‑of‑Cost‑or‑Market Adjustment');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `lower_of_cost_or_market_flag` SET TAGS ('dbx_business_glossary_term' = 'LCM Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `obsolescence_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Reserve Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `perishable_category` SET TAGS ('dbx_business_glossary_term' = 'Perishable Category');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `perishable_category` SET TAGS ('dbx_value_regex' = 'fresh|frozen|dry|canned|produce|dairy');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `shrink_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reserve Amount');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `sox_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Compliant Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Cost');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `total_retail_value` SET TAGS ('dbx_business_glossary_term' = 'Total Retail Value');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'weighted_average|fifo|lifo|retail|standard_cost');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|adjusted|reconciled');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` SET TAGS ('dbx_association_edges' = 'inventory.stock_position,order.order_line');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ALTER COLUMN `pick_id` SET TAGS ('dbx_business_glossary_term' = 'Pick - Pick Id');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pick - Order Line Id');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Pick - Stock Position Id');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ALTER COLUMN `quantity_picked` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` SET TAGS ('dbx_association_edges' = 'inventory.lot_batch,order.order_line');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ALTER COLUMN `lot_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Lotallocation - Lot Allocation Id');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lotallocation - Lot Batch Id');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Lotallocation - Order Line Id');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Time');
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` SET TAGS ('dbx_subdomain' = 'inventory_tracking');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ALTER COLUMN `temperature_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Identifier');
ALTER TABLE `grocery_ecm`.`inventory`.`temperature_zone` ALTER COLUMN `parent_temperature_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
