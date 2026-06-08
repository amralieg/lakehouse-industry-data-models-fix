-- Metric views for domain: supply | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key supply planning KPIs that drive capacity and demand alignment decisions"
  source: "`manufacturing_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the plan is executed"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan (e.g., Approved, Draft)"
    - name: "plan_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of plan creation for time‑based analysis"
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total quantity of supply that has been planned across all plans"
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity associated with the plan"
    - name: "average_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization % across plans"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance % between planned supply and forecasted demand"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health metrics used for stock‑level and service‑level decisions"
  source: "`manufacturing_ecm`.`supply`.`inventory_position`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inventory is located"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU identifier for the inventory item"
    - name: "inventory_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the inventory snapshot"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total inventory on hand across all locations"
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total quantity available to promise to customers"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply based on current inventory"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock held across locations"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting performance indicators for planning accuracy"
  source: "`manufacturing_ecm`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Name of the forecasting model used"
    - name: "demand_class"
      expr: demand_class
      comment: "Classification of demand (e.g., New, Existing)"
    - name: "forecast_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the forecast was generated"
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity across all forecasts"
    - name: "average_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage"
    - name: "average_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Mean Absolute Percentage Error across forecasts"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs that highlight utilization and bottlenecks"
  source: "`manufacturing_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which capacity is planned"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic operating plan (SOP) cycle metrics used for executive review"
  source: "`manufacturing_ecm`.`supply`.`sop_cycle`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the SOP cycle"
    - name: "cycle_name"
      expr: cycle_name
      comment: "Descriptive name of the SOP cycle"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cycle"
    - name: "cycle_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the SOP cycle was created"
  measures:
    - name: "average_capacity_utilization_target_percentage"
      expr: AVG(CAST(capacity_utilization_target_percentage AS DOUBLE))
      comment: "Target capacity utilization % set for the SOP cycle"
    - name: "total_demand_supply_gap_quantity"
      expr: SUM(CAST(demand_supply_gap_quantity AS DOUBLE))
      comment: "Total quantity gap between demand and supply in the cycle"
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Planned revenue amount for the SOP cycle"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk register KPIs that inform risk mitigation and financial exposure"
  source: "`manufacturing_ecm`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g., Supply, Quality)"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (Open, Closed)"
    - name: "risk_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the risk was recorded"
  measures:
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of recorded risks"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all risks"
    - name: "high_severity_risk_count"
      expr: SUM(CASE WHEN risk_severity = 'High' THEN 1 ELSE 0 END)
      comment: "Count of risks classified as high severity"
$$;