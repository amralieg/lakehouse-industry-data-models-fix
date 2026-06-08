-- Metric views for domain: supply | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ATP (Available-to-Promise) metrics for inventory availability planning"
  source: "`consumer_goods_ecm`.`supply`.`atp_record`"
  dimensions:
    - name: "atp_date"
      expr: atp_date
      comment: "Date of the ATP calculation"
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Supply network node where ATP is calculated"
    - name: "atp_status"
      expr: atp_status
      comment: "Status of the ATP record (e.g., confirmed, pending)"
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "Method used to calculate ATP"
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity across all records"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity that has been allocated to orders"
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity currently on backorder"
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total quantity in transit (not yet on hand)"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of ATP records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning KPIs that drive production and procurement decisions"
  source: "`consumer_goods_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the planning period"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being planned"
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Supply node for the plan"
    - name: "version_type"
      expr: version_type
      comment: "Version classification (e.g., consensus, final)"
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Sum of consensus demand quantities across the planning horizon"
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Sum of statistical baseline forecast quantities"
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Sum of promotional overlay quantities"
    - name: "plan_record_count"
      expr: COUNT(1)
      comment: "Number of demand plan records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_inventory_projection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory projection metrics used for stock positioning and service level planning"
  source: "`consumer_goods_ecm`.`supply`.`inventory_projection`"
  dimensions:
    - name: "projection_date"
      expr: projection_date
      comment: "Date of the inventory projection"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Supply node for the projection"
    - name: "projection_type"
      expr: projection_type
      comment: "Type of projection (e.g., baseline, scenario)"
  measures:
    - name: "total_projected_on_hand_quantity"
      expr: SUM(CAST(projected_on_hand_quantity AS DOUBLE))
      comment: "Projected on‑hand inventory at projection date"
    - name: "total_projected_demand_quantity"
      expr: SUM(CAST(projected_demand_quantity AS DOUBLE))
      comment: "Projected demand quantity for the period"
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Projected available inventory balance after demand"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply across projected records"
    - name: "projection_record_count"
      expr: COUNT(1)
      comment: "Number of inventory projection records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics that inform logistics and cost management"
  source: "`consumer_goods_ecm`.`supply`.`supply_replenishment_order`"
  dimensions:
    - name: "planned_receipt_date"
      expr: planned_receipt_date
      comment: "Planned receipt date for the order"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being replenished"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., regular, emergency)"
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested in replenishment orders"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped to downstream locations"
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total monetary cost of replenishment orders"
    - name: "order_type_count"
      expr: COUNT(DISTINCT order_type)
      comment: "Number of distinct order types used"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock KPIs that drive service level and inventory cost decisions"
  source: "`consumer_goods_ecm`.`supply`.`safety_stock`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the safety stock setting"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Supply node for the safety stock"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU"
  measures:
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Sum of safety stock units calculated by the system"
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Sum of safety stock units approved for use"
    - name: "average_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average variability in lead time across SKUs"
    - name: "safety_stock_record_count"
      expr: COUNT(1)
      comment: "Number of safety stock records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast accuracy metrics to monitor model performance and drive improvement initiatives"
  source: "`consumer_goods_ecm`.`supply`.`forecast_accuracy`"
  dimensions:
    - name: "forecast_version"
      expr: forecast_version
      comment: "Version identifier of the forecast"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being forecasted"
    - name: "supply_network_node_id"
      expr: supply_network_node_id
      comment: "Supply node for the forecast"
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the planning period for the forecast"
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Type of forecasting model used"
  measures:
    - name: "average_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Mean Absolute Percentage Error across forecasts"
    - name: "average_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Weighted MAPE across forecasts"
    - name: "average_accuracy_target_percent"
      expr: AVG(CAST(accuracy_target_percent AS DOUBLE))
      comment: "Average target accuracy percentage set for forecasts"
    - name: "forecast_accuracy_record_count"
      expr: COUNT(1)
      comment: "Number of forecast accuracy records"
$$;