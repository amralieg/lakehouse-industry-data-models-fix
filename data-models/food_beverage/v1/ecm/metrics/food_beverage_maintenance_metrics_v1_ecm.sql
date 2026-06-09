-- Metric views for domain: maintenance | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order performance and cost metrics"
  source: "`food_beverage_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of work order"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type/category of work order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to work order"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date work order was created"
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Number of work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours recorded"
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`maintenance_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset valuation and reliability metrics"
  source: "`food_beverage_ecm`.`maintenance`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type/category of asset"
    - name: "asset_status"
      expr: asset_status
      comment: "Operational status of asset"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where asset is located"
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with asset"
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year asset was installed"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of assets"
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Total book value of assets"
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of assets"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (hours)"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (hours)"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`maintenance_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure impact and downtime metrics"
  source: "`food_beverage_ecm`.`maintenance`.`failure_record`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset associated with failure"
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of failure"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of failure"
    - name: "shift"
      expr: shift
      comment: "Shift during which failure occurred"
    - name: "failure_date"
      expr: DATE_TRUNC('day', failure_timestamp)
      comment: "Date of failure occurrence"
  measures:
    - name: "failure_count"
      expr: COUNT(1)
      comment: "Number of failure records"
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total downtime hours from failures"
    - name: "total_production_loss_quantity"
      expr: SUM(CAST(production_loss_quantity AS DOUBLE))
      comment: "Total production loss quantity due to failures"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule cost and performance metrics"
  source: "`food_beverage_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where preventive maintenance scheduled"
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category of maintenance"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance activity"
    - name: "schedule_status"
      expr: pm_schedule_status
      comment: "Current status of PM schedule"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of scheduled maintenance"
  measures:
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of preventive maintenance schedules"
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of PM schedules"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of PM schedules"
    - name: "avg_counter_reading"
      expr: AVG(CAST(counter_reading AS DOUBLE))
      comment: "Average counter reading at schedule"
    - name: "avg_next_due_counter"
      expr: AVG(CAST(next_due_counter AS DOUBLE))
      comment: "Average next due counter value"
$$;