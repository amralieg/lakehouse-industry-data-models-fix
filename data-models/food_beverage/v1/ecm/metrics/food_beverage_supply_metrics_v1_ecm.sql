-- Metric views for domain: supply | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core supply planning KPIs for production and inventory balancing"
  source: "`food_beverage_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plan_date"
      expr: plan_date
      comment: "Timestamp of the plan record"
    - name: "center_id"
      expr: center_id
      comment: "Distribution center identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (e.g., forecast, actual)"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier classification"
    - name: "supply_constraint_flag"
      expr: supply_constraint_flag
      comment: "Flag indicating if supply constraints are applied"
  measures:
    - name: "plan_record_count"
      expr: COUNT(1)
      comment: "Number of supply plan records"
    - name: "total_demand_qty"
      expr: SUM(CAST(demand_qty AS DOUBLE))
      comment: "Total forecasted demand quantity across all SKUs"
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity"
    - name: "total_planned_receipts_qty"
      expr: SUM(CAST(planned_receipts_qty AS DOUBLE))
      comment: "Total planned receipts (incoming supply) quantity"
    - name: "total_planned_shipments_qty"
      expr: SUM(CAST(planned_shipments_qty AS DOUBLE))
      comment: "Total planned shipments quantity"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning KPIs to assess forecast quality and volume"
  source: "`food_beverage_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "plan_period_start_date"
      expr: plan_period_start_date
      comment: "Start date of the planning period"
    - name: "plan_period_end_date"
      expr: plan_period_end_date
      comment: "End date of the planning period"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "plan_type"
      expr: plan_type
      comment: "Demand plan type"
    - name: "forecast_algorithm"
      expr: forecast_algorithm
      comment: "Algorithm used for forecasting"
    - name: "is_new_product"
      expr: is_new_product
      comment: "Flag for new product forecasts"
    - name: "is_frozen"
      expr: is_frozen
      comment: "Flag indicating if the forecast is frozen"
  measures:
    - name: "demand_plan_record_count"
      expr: COUNT(1)
      comment: "Number of demand plan records"
    - name: "total_baseline_forecast_qty"
      expr: SUM(CAST(baseline_forecast_qty AS DOUBLE))
      comment: "Sum of baseline forecast quantities"
    - name: "total_consensus_forecast_qty"
      expr: SUM(CAST(consensus_forecast_qty AS DOUBLE))
      comment: "Sum of consensus forecast quantities"
    - name: "total_statistical_forecast_qty"
      expr: SUM(CAST(statistical_forecast_qty AS DOUBLE))
      comment: "Sum of statistical forecast quantities"
    - name: "avg_forecast_confidence_pct"
      expr: AVG(CAST(forecast_confidence_pct AS DOUBLE))
      comment: "Average forecast confidence percentage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_capacity_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity constraint KPIs for production planning and bottleneck identification"
  source: "`food_beverage_ecm`.`supply`.`capacity_constraint`"
  dimensions:
    - name: "center_id"
      expr: center_id
      comment: "Distribution center identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier"
    - name: "capacity_bucket"
      expr: capacity_bucket
      comment: "Capacity bucket classification"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of capacity constraint"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the capacity bucket"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the capacity bucket"
  measures:
    - name: "capacity_constraint_record_count"
      expr: COUNT(1)
      comment: "Number of capacity constraint records"
    - name: "total_available_capacity"
      expr: SUM(CAST(available_capacity AS DOUBLE))
      comment: "Total available capacity across all constraints"
    - name: "total_effective_capacity"
      expr: SUM(CAST(effective_capacity AS DOUBLE))
      comment: "Total effective capacity after adjustments"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average utilization percentage of constrained resources"
    - name: "avg_oee_target_pct"
      expr: AVG(CAST(oee_target_pct AS DOUBLE))
      comment: "Average OEE target percentage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_otif_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time-In-Full performance metrics for logistics and fulfillment"
  source: "`food_beverage_ecm`.`supply`.`otif_performance`"
  dimensions:
    - name: "center_id"
      expr: center_id
      comment: "Distribution center identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier"
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the OTIF measurement"
  measures:
    - name: "otif_performance_record_count"
      expr: COUNT(1)
      comment: "Number of OTIF performance records"
    - name: "avg_otif_score"
      expr: AVG(CAST(otif_score AS DOUBLE))
      comment: "Average OTIF score across shipments"
    - name: "avg_case_fill_rate"
      expr: AVG(CAST(case_fill_rate AS DOUBLE))
      comment: "Average case fill rate"
    - name: "avg_line_fill_rate"
      expr: AVG(CAST(line_fill_rate AS DOUBLE))
      comment: "Average line fill rate"
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total quantity shipped"
    - name: "total_delivered_qty"
      expr: SUM(CAST(delivered_qty AS DOUBLE))
      comment: "Total quantity delivered"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_allocation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation planning KPIs to monitor supply distribution effectiveness"
  source: "`food_beverage_ecm`.`supply`.`plan`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "allocation_plan_record_count"
      expr: COUNT(1)
      comment: "Number of allocation plan records"
$$;