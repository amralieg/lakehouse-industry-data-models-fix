-- Schema for Domain: inventory | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`inventory` COMMENT 'Owns physical inventory positions across the entire distribution network. Manages stock on hand, in-transit inventory, warehouse locations, FEFO/FIFO rotation rules, DIO metrics, OOS/OSA events, VMI replenishment triggers, lot/batch traceability for recall readiness, safety stock levels, and multi-echelon inventory visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `allocated_quantity` DECIMAL(18,2) COMMENT '',
    `available_quantity` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `damaged_quantity` DECIMAL(18,2) COMMENT '',
    `in_transit_quantity` DECIMAL(18,2) COMMENT '',
    `last_count_date` DATE COMMENT '',
    `last_movement_date` DATE COMMENT '',
    `on_hand_quantity` DECIMAL(18,2) COMMENT '',
    `quarantine_quantity` DECIMAL(18,2) COMMENT '',
    `reserved_quantity` DECIMAL(18,2) COMMENT '',
    `stock_status` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `valuation_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Current inventory position by SKU, location, and lot/batch';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT '',
    `best_before_date` DATE COMMENT '',
    `certificate_of_analysis_ref` STRING COMMENT '',
    `country_of_origin` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_quarantined` BOOLEAN COMMENT '',
    `is_recalled` BOOLEAN COMMENT '',
    `lot_number` STRING COMMENT '',
    `lot_status` STRING COMMENT '',
    `manufacture_date` DATE COMMENT '',
    `quality_status` STRING COMMENT '',
    `retest_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Lot and batch tracking for inventory traceability';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` (
    `inventory_storage_location_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `aisle` STRING COMMENT '',
    `bay` STRING COMMENT '',
    `bin` STRING COMMENT '',
    `capacity_cubic_meters` DECIMAL(18,2) COMMENT '',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `hazmat_approved` BOOLEAN COMMENT '',
    `inventory_storage_location_level` STRING COMMENT '',
    `location_code` STRING COMMENT '',
    `location_name` STRING COMMENT '',
    `location_status` STRING COMMENT '',
    `location_type` STRING COMMENT '',
    `temperature_controlled` BOOLEAN COMMENT '',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT '',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `zone` STRING COMMENT '',
    CONSTRAINT pk_inventory_storage_location PRIMARY KEY(`inventory_storage_location_id`)
) COMMENT 'Physical storage locations within warehouses';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `to_inventory_storage_location_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `cost_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `movement_date` DATE COMMENT '',
    `movement_reason` STRING COMMENT '',
    `movement_timestamp` TIMESTAMP COMMENT '',
    `movement_type` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `reference_document_number` STRING COMMENT '',
    `reference_document_type` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'All inventory movements and transactions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` (
    `inventory_replenishment_order_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `confirmed_delivery_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `order_date` DATE COMMENT '',
    `order_number` STRING COMMENT '',
    `order_quantity` DECIMAL(18,2) COMMENT '',
    `order_status` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `replenishment_type` STRING COMMENT '',
    `requested_delivery_date` DATE COMMENT '',
    `total_cost` DECIMAL(18,2) COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_inventory_replenishment_order PRIMARY KEY(`inventory_replenishment_order_id`)
) COMMENT 'Orders to replenish inventory levels';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` (
    `inventory_cycle_count_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `inventory_counted_by_employee_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `adjustment_posted` BOOLEAN COMMENT '',
    `count_date` DATE COMMENT '',
    `count_status` STRING COMMENT '',
    `count_timestamp` TIMESTAMP COMMENT '',
    `count_type` STRING COMMENT '',
    `counted_quantity` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `system_quantity` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `variance_percentage` DECIMAL(18,2) COMMENT '',
    `variance_quantity` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_inventory_cycle_count PRIMARY KEY(`inventory_cycle_count_id`)
) COMMENT 'Cycle count activities for inventory accuracy';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` (
    `safety_stock_policy_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `demand_variability_factor` DECIMAL(18,2) COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `maximum_stock_level` DECIMAL(18,2) COMMENT '',
    `minimum_stock_level` DECIMAL(18,2) COMMENT '',
    `policy_type` STRING COMMENT '',
    `reorder_point` DECIMAL(18,2) COMMENT '',
    `review_period_days` STRING COMMENT '',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT '',
    `service_level_target_pct` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_safety_stock_policy PRIMARY KEY(`safety_stock_policy_id`)
) COMMENT 'Safety stock policies by SKU and location';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` (
    `intransit_shipment_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `logistics_shipment_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `to_warehouse_id` BIGINT COMMENT '',
    `actual_arrival_date` DATE COMMENT '',
    `carrier_name` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `expected_arrival_date` DATE COMMENT '',
    `freight_cost` DECIMAL(18,2) COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `ship_date` DATE COMMENT '',
    `shipment_number` STRING COMMENT '',
    `shipment_status` STRING COMMENT '',
    `tracking_number` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_intransit_shipment PRIMARY KEY(`intransit_shipment_id`)
) COMMENT 'Inventory in transit between locations';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` (
    `oos_event_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `demand_during_oos` DECIMAL(18,2) COMMENT '',
    `lost_sales_quantity` DECIMAL(18,2) COMMENT '',
    `lost_sales_value` DECIMAL(18,2) COMMENT '',
    `oos_category` STRING COMMENT '',
    `oos_duration_hours` DECIMAL(18,2) COMMENT '',
    `oos_end_timestamp` TIMESTAMP COMMENT '',
    `oos_reason` STRING COMMENT '',
    `oos_start_timestamp` TIMESTAMP COMMENT '',
    `resolution_action` STRING COMMENT '',
    `responsible_party` STRING COMMENT '',
    CONSTRAINT pk_oos_event PRIMARY KEY(`oos_event_id`)
) COMMENT 'Out-of-stock events and tracking';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` (
    `stock_hold_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `stock_initiated_by_employee_id` BIGINT COMMENT '',
    `stock_release_approved_by_employee_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `hold_end_date` DATE COMMENT '',
    `hold_reason` STRING COMMENT '',
    `hold_start_date` DATE COMMENT '',
    `hold_status` STRING COMMENT '',
    `hold_type` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quality_inspection_ref` STRING COMMENT '',
    `quantity_on_hold` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_stock_hold PRIMARY KEY(`stock_hold_id`)
) COMMENT 'Inventory holds for quality or regulatory reasons';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` (
    `recall_event_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `product_recall_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `affected_quantity` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_notification_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `quantity_destroyed` DECIMAL(18,2) COMMENT '',
    `quantity_recovered` DECIMAL(18,2) COMMENT '',
    `recall_completion_date` DATE COMMENT '',
    `recall_date` DATE COMMENT '',
    `recall_number` STRING COMMENT '',
    `recall_reason` STRING COMMENT '',
    `recall_severity` STRING COMMENT '',
    `recall_status` STRING COMMENT '',
    `recall_type` STRING COMMENT '',
    `regulatory_authority` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Product recall events and affected inventory';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` (
    `inventory_vmi_agreement_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `agreement_name` STRING COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT '',
    `consignment_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `max_inventory_level` DECIMAL(18,2) COMMENT '',
    `min_inventory_level` DECIMAL(18,2) COMMENT '',
    `payment_terms` STRING COMMENT '',
    `replenishment_frequency` STRING COMMENT '',
    `target_service_level_pct` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_inventory_vmi_agreement PRIMARY KEY(`inventory_vmi_agreement_id`)
) COMMENT 'Vendor-managed inventory agreements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT '',
    `gl_account_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `fifo_cost` DECIMAL(18,2) COMMENT '',
    `moving_average_cost` DECIMAL(18,2) COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `standard_cost` DECIMAL(18,2) COMMENT '',
    `total_value` DECIMAL(18,2) COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `valuation_date` DATE COMMENT '',
    `valuation_method` STRING COMMENT '',
    `valuation_type` STRING COMMENT '',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Inventory valuation records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` (
    `stock_adjustment_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `stock_initiated_by_employee_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `adjustment_date` DATE COMMENT '',
    `adjustment_quantity` DECIMAL(18,2) COMMENT '',
    `adjustment_reason` STRING COMMENT '',
    `adjustment_timestamp` TIMESTAMP COMMENT '',
    `adjustment_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quantity_after` DECIMAL(18,2) COMMENT '',
    `quantity_before` DECIMAL(18,2) COMMENT '',
    `reference_document` STRING COMMENT '',
    `total_value_impact` DECIMAL(18,2) COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_stock_adjustment PRIMARY KEY(`stock_adjustment_id`)
) COMMENT 'Inventory adjustments and corrections';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `inventory_storage_location_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `order_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `warehouse_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `expiry_date` DATE COMMENT '',
    `priority` STRING COMMENT '',
    `required_date` DATE COMMENT '',
    `reservation_date` DATE COMMENT '',
    `reservation_number` STRING COMMENT '',
    `reservation_status` STRING COMMENT '',
    `reservation_timestamp` TIMESTAMP COMMENT '',
    `reservation_type` STRING COMMENT '',
    `reserved_quantity` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_reservation PRIMARY KEY(`reservation_id`)
) COMMENT 'Inventory reservations for orders and allocations';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` (
    `warehouse_id` BIGINT COMMENT '',
    `distribution_facility_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT '',
    `address_line_2` STRING COMMENT '',
    `city` STRING COMMENT '',
    `warehouse_code` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `hazmat_certified` BOOLEAN COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT '',
    `longitude` DECIMAL(18,2) COMMENT '',
    `warehouse_name` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `temperature_controlled` BOOLEAN COMMENT '',
    `total_capacity_cubic_meters` DECIMAL(18,2) COMMENT '',
    `total_capacity_pallets` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `warehouse_status` STRING COMMENT '',
    `warehouse_type` STRING COMMENT '',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Warehouse master data';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ADD CONSTRAINT `fk_inventory_inventory_storage_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_to_inventory_storage_location_id` FOREIGN KEY (`to_inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ADD CONSTRAINT `fk_inventory_inventory_replenishment_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` ADD CONSTRAINT `fk_inventory_safety_stock_policy_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` ADD CONSTRAINT `fk_inventory_intransit_shipment_to_warehouse_id` FOREIGN KEY (`to_warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ADD CONSTRAINT `fk_inventory_stock_hold_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ADD CONSTRAINT `fk_inventory_recall_event_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` ADD CONSTRAINT `fk_inventory_inventory_vmi_agreement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_inventory_storage_location_id` FOREIGN KEY (`inventory_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location`(`inventory_storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_consumer_goods_v1`.`inventory`.`warehouse`(`warehouse_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` SET TAGS ('dbx_ssot_reference' = 'distribution.distribution_storage_location');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_ssot_superseded_by' = 'distribution.distribution_storage_location');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_storage_location` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_ssot_owner' = 'inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_replenishment_scope' = 'location_restock');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_ssot_role' = 'inventory_replenishment_view');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` SET TAGS ('dbx_ssot' = 'inventory.inventory_replenishment_order');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_ssot_reference' = 'distribution.distribution_cycle_count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_ssot_superseded_by' = 'distribution.distribution_cycle_count');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_counted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_counted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`intransit_shipment` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`oos_event` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `stock_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `stock_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `stock_release_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_hold` ALTER COLUMN `stock_release_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_ssot_owner' = 'inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_vmi_scope' = 'inventory_parameters');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_ssot_role' = 'inventory_vmi_view');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement` SET TAGS ('dbx_ssot' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`stock_adjustment` ALTER COLUMN `stock_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'replenishment_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`inventory`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
