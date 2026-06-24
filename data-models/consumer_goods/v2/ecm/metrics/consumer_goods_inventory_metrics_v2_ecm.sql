-- Metric views for domain: inventory | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand, available, allocated, and reserved quantities by SKU and location for inventory optimization and fulfillment planning."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_position`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU identifier for inventory analysis"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location identifier"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Specific storage location within warehouse"
    - name: "lot_batch_id"
      expr: lot_batch_id
      comment: "Lot or batch identifier for traceability"
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position"
    - name: "last_movement_month"
      expr: DATE_TRUNC('MONTH', last_movement_date)
      comment: "Month of last inventory movement for aging analysis"
    - name: "last_count_month"
      expr: DATE_TRUNC('MONTH', last_count_date)
      comment: "Month of last physical count for audit tracking"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total physical inventory on hand across all locations"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for allocation and fulfillment"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to orders or production"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for specific orders or purposes"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations"
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity held in quarantine pending quality release"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity identified as damaged or unsellable"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total monetary value of inventory positions"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for fulfillment (key service level indicator)"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(allocated_quantity AS DOUBLE)) + SUM(CAST(reserved_quantity AS DOUBLE))) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory committed to orders or production (efficiency metric)"
    - name: "quarantine_rate"
      expr: ROUND(100.0 * SUM(CAST(quarantine_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory held in quarantine (quality risk indicator)"
    - name: "damage_rate"
      expr: ROUND(100.0 * SUM(CAST(damaged_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory damaged (operational quality metric)"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in inventory positions"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouse locations holding inventory"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement transaction metrics tracking transfers, receipts, issues, and adjustments for supply chain velocity and accuracy analysis."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU identifier for movement analysis"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where movement occurred"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement (receipt, issue, transfer, adjustment)"
    - name: "movement_reason"
      expr: movement_reason
      comment: "Business reason for the movement"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of source document triggering the movement"
    - name: "from_inventory_storage_location_id"
      expr: from_inventory_storage_location_id
      comment: "Source storage location for transfers"
    - name: "to_inventory_storage_location_id"
      expr: to_inventory_storage_location_id
      comment: "Destination storage location for transfers"
    - name: "movement_date"
      expr: movement_date
      comment: "Date of inventory movement"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of movement for trend analysis"
    - name: "movement_year"
      expr: YEAR(movement_date)
      comment: "Year of movement for annual reporting"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost value of inventory movements"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory movement transactions"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "avg_movement_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per movement transaction"
    - name: "distinct_sku_moved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs involved in movements"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with movement activity"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics for inventory control, audit compliance, and operational excellence measurement."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU being counted"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location of cycle count"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Specific storage location counted"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (ABC, random, full)"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (pending, completed, approved)"
    - name: "adjustment_posted"
      expr: adjustment_posted
      comment: "Whether variance adjustment has been posted"
    - name: "count_date"
      expr: count_date
      comment: "Date of physical count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of count for trend analysis"
    - name: "count_year"
      expr: YEAR(count_date)
      comment: "Year of count for annual reporting"
  measures:
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted"
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system quantity expected"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (counted minus system)"
    - name: "total_absolute_variance_quantity"
      expr: SUM(ABS(CAST(variance_quantity AS DOUBLE)))
      comment: "Total absolute variance for accuracy measurement"
    - name: "cycle_count_accuracy_rate"
      expr: ROUND(100.0 * (1 - SUM(ABS(CAST(variance_quantity AS DOUBLE))) / NULLIF(SUM(CAST(system_quantity AS DOUBLE)), 0)), 2)
      comment: "Percentage accuracy of cycle counts (key operational KPI)"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all counts"
    - name: "cycle_count_transaction_count"
      expr: COUNT(1)
      comment: "Total number of cycle count transactions"
    - name: "distinct_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs cycle counted"
    - name: "distinct_location_counted"
      expr: COUNT(DISTINCT inventory_storage_location_id)
      comment: "Number of unique storage locations counted"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-stock event metrics tracking stockout frequency, duration, and lost sales impact for service level and revenue protection analysis."
  source: "`vibe_consumer_goods_v1`.`inventory`.`oos_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU experiencing stockout"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location of stockout"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Specific storage location of stockout"
    - name: "oos_category"
      expr: oos_category
      comment: "Category of out-of-stock event (demand spike, supply delay, etc.)"
    - name: "oos_reason"
      expr: oos_reason
      comment: "Root cause reason for stockout"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for stockout (planning, procurement, logistics)"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve stockout"
    - name: "oos_start_month"
      expr: DATE_TRUNC('MONTH', oos_start_timestamp)
      comment: "Month when stockout began"
  measures:
    - name: "total_oos_events"
      expr: COUNT(1)
      comment: "Total number of out-of-stock events"
    - name: "total_oos_duration_hours"
      expr: SUM(CAST(oos_duration_hours AS DOUBLE))
      comment: "Total hours of stockout across all events"
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of stockout events in hours"
    - name: "total_lost_sales_quantity"
      expr: SUM(CAST(lost_sales_quantity AS DOUBLE))
      comment: "Total quantity of lost sales due to stockouts"
    - name: "total_lost_sales_value"
      expr: SUM(CAST(lost_sales_value AS DOUBLE))
      comment: "Total revenue lost due to stockouts (critical business impact metric)"
    - name: "total_demand_during_oos"
      expr: SUM(CAST(demand_during_oos AS DOUBLE))
      comment: "Total demand that occurred during stockout periods"
    - name: "oos_fill_rate"
      expr: ROUND(100.0 * (1 - SUM(CAST(lost_sales_quantity AS DOUBLE)) / NULLIF(SUM(CAST(demand_during_oos AS DOUBLE)), 0)), 2)
      comment: "Percentage of demand fulfilled during stockout periods (inverse service level)"
    - name: "avg_lost_sales_per_event"
      expr: AVG(CAST(lost_sales_value AS DOUBLE))
      comment: "Average revenue lost per stockout event"
    - name: "distinct_sku_oos_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs experiencing stockouts"
    - name: "distinct_warehouse_oos_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with stockout events"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation metrics by costing method for financial reporting, working capital management, and inventory investment optimization."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU being valued"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location of valued inventory"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Costing method used (FIFO, LIFO, weighted average, standard)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (book, market, replacement)"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "General ledger account for inventory value"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of valuation snapshot"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation for trend analysis"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of valuation for annual reporting"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of inventory (key balance sheet metric)"
    - name: "total_inventory_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of valued inventory"
    - name: "weighted_avg_unit_cost"
      expr: SUM(CAST(total_value AS DOUBLE)) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0)
      comment: "Weighted average unit cost across all inventory"
    - name: "total_fifo_cost"
      expr: SUM(CAST(fifo_cost AS DOUBLE))
      comment: "Total inventory value using FIFO method"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total inventory value using standard cost"
    - name: "total_moving_average_cost"
      expr: SUM(CAST(moving_average_cost AS DOUBLE))
      comment: "Total inventory value using moving average method"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per SKU"
    - name: "distinct_sku_valued_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in valuation"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with valued inventory"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall event metrics tracking recall scope, recovery effectiveness, and regulatory compliance for risk management and quality assurance."
  source: "`vibe_consumer_goods_v1`.`inventory`.`recall_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU being recalled"
    - name: "lot_batch_id"
      expr: lot_batch_id
      comment: "Lot or batch subject to recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)"
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity classification of recall (Class I, II, III)"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of recall (initiated, in progress, completed)"
    - name: "recall_reason"
      expr: recall_reason
      comment: "Root cause reason for recall"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body overseeing recall (FDA, CPSC, etc.)"
    - name: "recall_date"
      expr: recall_date
      comment: "Date recall was initiated"
    - name: "recall_month"
      expr: DATE_TRUNC('MONTH', recall_date)
      comment: "Month of recall initiation"
    - name: "recall_year"
      expr: YEAR(recall_date)
      comment: "Year of recall for annual reporting"
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by recalls"
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity successfully recovered from market"
    - name: "total_quantity_destroyed"
      expr: SUM(CAST(quantity_destroyed AS DOUBLE))
      comment: "Total quantity destroyed as part of recall"
    - name: "recall_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_recovered AS DOUBLE)) / NULLIF(SUM(CAST(affected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of affected product successfully recovered (key effectiveness metric)"
    - name: "recall_destruction_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_destroyed AS DOUBLE)) / NULLIF(SUM(CAST(affected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of affected product destroyed"
    - name: "avg_affected_quantity_per_recall"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average quantity affected per recall event"
    - name: "distinct_sku_recalled_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs subject to recall"
    - name: "distinct_lot_recalled_count"
      expr: COUNT(DISTINCT lot_batch_id)
      comment: "Number of unique lots or batches recalled"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy metrics for inventory planning optimization, service level management, and working capital efficiency."
  source: "`vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU with safety stock policy"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location for policy"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed, dynamic, statistical)"
    - name: "effective_from"
      expr: effective_from
      comment: "Policy effective start date"
    - name: "effective_until"
      expr: effective_until
      comment: "Policy effective end date"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month policy became effective"
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all policies"
    - name: "total_minimum_stock_level"
      expr: SUM(CAST(minimum_stock_level AS DOUBLE))
      comment: "Total minimum stock level targets"
    - name: "total_maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level targets"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantities"
    - name: "avg_service_level_target"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across policies"
    - name: "avg_demand_variability_factor"
      expr: AVG(CAST(demand_variability_factor AS DOUBLE))
      comment: "Average demand variability factor for safety stock calculation"
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity per SKU-location"
    - name: "distinct_sku_with_policy_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with safety stock policies"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with safety stock policies"
    - name: "total_policy_count"
      expr: COUNT(1)
      comment: "Total number of active safety stock policies"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment transaction metrics tracking write-offs, corrections, and shrinkage for inventory accuracy and loss prevention analysis."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU being adjusted"
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse location of adjustment"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Specific storage location adjusted"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (increase, decrease, write-off)"
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Business reason for adjustment (damage, theft, cycle count, etc.)"
    - name: "reference_document"
      expr: reference_document
      comment: "Reference document triggering adjustment"
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date of adjustment"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of adjustment for trend analysis"
    - name: "adjustment_year"
      expr: YEAR(adjustment_date)
      comment: "Year of adjustment for annual reporting"
  measures:
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(adjustment_quantity AS DOUBLE))
      comment: "Total net quantity adjusted (positive and negative)"
    - name: "total_absolute_adjustment_quantity"
      expr: SUM(ABS(CAST(adjustment_quantity AS DOUBLE)))
      comment: "Total absolute quantity adjusted for accuracy measurement"
    - name: "total_value_impact"
      expr: SUM(CAST(total_value_impact AS DOUBLE))
      comment: "Total financial impact of adjustments (key P&L metric)"
    - name: "total_absolute_value_impact"
      expr: SUM(ABS(CAST(total_value_impact AS DOUBLE)))
      comment: "Total absolute financial impact for loss measurement"
    - name: "adjustment_transaction_count"
      expr: COUNT(1)
      comment: "Total number of adjustment transactions"
    - name: "avg_adjustment_quantity"
      expr: AVG(CAST(adjustment_quantity AS DOUBLE))
      comment: "Average quantity per adjustment transaction"
    - name: "avg_value_impact"
      expr: AVG(CAST(total_value_impact AS DOUBLE))
      comment: "Average financial impact per adjustment"
    - name: "distinct_sku_adjusted_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with adjustments"
    - name: "distinct_warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with adjustments"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics for quality management, expiry tracking, and regulatory compliance in consumer goods supply chain."
  source: "`vibe_consumer_goods_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Product SKU for lot/batch"
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility that produced the lot"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier providing the lot (for purchased goods)"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of lot (active, expired, recalled)"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status (approved, pending, rejected)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where lot was manufactured"
    - name: "is_quarantined"
      expr: is_quarantined
      comment: "Whether lot is currently quarantined"
    - name: "is_recalled"
      expr: is_recalled
      comment: "Whether lot is subject to recall"
    - name: "manufacture_date"
      expr: manufacture_date
      comment: "Date lot was manufactured"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date lot expires"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture for production analysis"
  measures:
    - name: "total_lot_count"
      expr: COUNT(1)
      comment: "Total number of lots or batches"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with lot/batch records"
    - name: "distinct_manufacturing_facility_count"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of unique manufacturing facilities producing lots"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing lots"
    - name: "quarantined_lot_count"
      expr: SUM(CASE WHEN is_quarantined = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots currently quarantined"
    - name: "recalled_lot_count"
      expr: SUM(CASE WHEN is_recalled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots subject to recall"
    - name: "quarantine_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_quarantined = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots in quarantine (quality risk indicator)"
    - name: "recall_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recalled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots recalled (quality and compliance metric)"
$$;