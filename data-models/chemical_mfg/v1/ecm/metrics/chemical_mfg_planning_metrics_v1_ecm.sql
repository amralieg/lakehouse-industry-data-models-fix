-- Metric views for domain: planning | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key demand forecasting KPIs used for strategic planning and accuracy monitoring"
  source: "`chemical_mfg_ecm`.`planning`.`demand_forecast`"
  dimensions:
    - name: "forecast_period_start"
      expr: forecast_period_start
      comment: "Start date of the forecast period"
    - name: "forecast_period_end"
      expr: forecast_period_end
      comment: "End date of the forecast period"
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name for what‑if analysis"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., Draft, Approved)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of demand forecast records"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Sum of adjusted forecast quantities across all records"
    - name: "total_baseline_quantity"
      expr: SUM(CAST(baseline_quantity AS DOUBLE))
      comment: "Sum of baseline forecast quantities"
    - name: "average_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy AS DOUBLE))
      comment: "Average forecast accuracy percentage"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply planning KPIs that drive procurement and production decisions"
  source: "`chemical_mfg_ecm`.`planning`.`supply_plan`"
  dimensions:
    - name: "planning_horizon_start"
      expr: planning_horizon_start_date
      comment: "Start of the planning horizon"
    - name: "planning_horizon_end"
      expr: planning_horizon_end_date
      comment: "End of the planning horizon"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (e.g., Long‑term, Short‑term)"
    - name: "supply_source"
      expr: supply_source
      comment: "Source of supply (e.g., Internal, External)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of supply plan records"
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total quantity planned to be supplied"
    - name: "total_confirmed_supply_quantity"
      expr: SUM(CAST(confirmed_supply_quantity AS DOUBLE))
      comment: "Total quantity that has been confirmed for supply"
    - name: "total_supply_gap_quantity"
      expr: SUM(CAST(supply_gap_quantity AS DOUBLE))
      comment: "Total quantity shortfall between planned and confirmed supply"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning metrics to monitor resource utilization and bottlenecks"
  source: "`chemical_mfg_ecm`.`planning`.`capacity_plan`"
  dimensions:
    - name: "planning_horizon_start"
      expr: planning_horizon_start
      comment: "Start date of the planning horizon"
    - name: "planning_horizon_end"
      expr: planning_horizon_end
      comment: "End date of the planning horizon"
    - name: "plan_type"
      expr: plan_type
      comment: "Capacity plan type (e.g., Shift, Continuous)"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Identifier of the work center"
    - name: "capacity_plan_status"
      expr: capacity_plan_status
      comment: "Current status of the capacity plan"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of capacity plan records"
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity in hours"
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total required capacity in hours"
    - name: "average_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing Resource Planning run performance and output metrics"
  source: "`chemical_mfg_ecm`.`planning`.`mrp_run`"
  dimensions:
    - name: "planning_date"
      expr: planning_date
      comment: "Date the MRP run was executed"
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (e.g., Simulation, Live)"
    - name: "run_status"
      expr: mrp_run_status
      comment: "Execution status of the MRP run"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the MRP run was performed"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of MRP run executions"
    - name: "total_planned_quantity"
      expr: SUM(CAST(total_planned_quantity AS DOUBLE))
      comment: "Total quantity planned by the MRP run"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_inventory_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory target KPIs to guide stocking levels and safety stock policies"
  source: "`chemical_mfg_ecm`.`planning`.`inventory_target`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where inventory is held"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier"
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Chemical product identifier"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (e.g., Active, Obsolete)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantities"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of inventory target records"
    - name: "total_max_stock_qty"
      expr: SUM(CAST(max_stock_qty AS DOUBLE))
      comment: "Sum of maximum stock quantity targets"
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Sum of reorder point quantities"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Sum of safety stock quantities"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_supply_demand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balancing supply and demand to ensure service levels and inventory efficiency"
  source: "`chemical_mfg_ecm`.`planning`.`supply_demand_balance`"
  dimensions:
    - name: "planning_period_start"
      expr: planning_period_start
      comment: "Start of the planning period"
    - name: "planning_period_end"
      expr: planning_period_end
      comment: "End of the planning period"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for the balance"
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Scenario name (e.g., Base, Optimistic)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of supply‑demand balance records"
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity"
    - name: "total_planned_sales_qty"
      expr: SUM(CAST(planned_sales_qty AS DOUBLE))
      comment: "Total planned sales quantity"
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Total projected available inventory balance"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply across the planning horizon"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`planning_atp_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available‑to‑Promise (ATP) check metrics to monitor fulfillment capability"
  source: "`chemical_mfg_ecm`.`planning`.`atp_check`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where ATP check is performed"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier"
    - name: "atp_check_status"
      expr: atp_check_status
      comment: "Result status of the ATP check"
    - name: "atp_method"
      expr: atp_method
      comment: "Method used for ATP calculation"
    - name: "is_backorder_allowed"
      expr: is_backorder_allowed
      comment: "Flag indicating if backorders are permitted"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of ATP check records"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed as available"
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by demand"
    - name: "total_shortage_quantity"
      expr: SUM(CAST(shortage_quantity AS DOUBLE))
      comment: "Total shortage quantity identified"
$$;