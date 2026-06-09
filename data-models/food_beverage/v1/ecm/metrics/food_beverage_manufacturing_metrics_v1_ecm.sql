-- Metric views for domain: manufacturing | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_batch_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key yield and production volume metrics at the batch level"
  source: "`food_beverage_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the batch"
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Date the batch was manufactured"
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch"
  measures:
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total quantity actually yielded across batches"
    - name: "total_batch_size_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total planned batch size quantity"
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of batch records"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(actual_yield_quantity AS DOUBLE) / NULLIF(CAST(batch_size_quantity AS DOUBLE), 0) * 100)
      comment: "Average yield percentage per batch"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_production_order_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Efficiency and yield metrics for production orders"
  source: "`food_beverage_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant executing the production order"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being produced"
    - name: "production_shift_id"
      expr: production_shift_id
      comment: "Shift identifier for the order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order"
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the order"
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity planned for production orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity actually confirmed/produced"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of production orders"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across orders"
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average variance between planned and actual yield"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_oee_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) impact metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`oee_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the OEE event occurred"
    - name: "equipment_master_id"
      expr: equipment_master_id
      comment: "Equipment identifier"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where the event was logged"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the event"
    - name: "event_type"
      expr: event_type
      comment: "Type of OEE event"
  measures:
    - name: "total_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total loss units recorded in OEE events"
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total duration of OEE events in minutes"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of OEE events"
    - name: "avg_loss_per_minute"
      expr: AVG(production_loss_units / NULLIF(duration_minutes, 0))
      comment: "Average loss units per minute of downtime"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_equipment_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and capacity metrics for manufacturing equipment"
  source: "`food_beverage_ecm`.`manufacturing`.`equipment_master`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where equipment is located"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific type of equipment"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Number of equipment records"
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity of equipment"
    - name: "avg_energy_consumption_rating_kwh"
      expr: AVG(CAST(energy_consumption_rating_kwh AS DOUBLE))
      comment: "Average energy consumption rating (kWh) per equipment"
    - name: "avg_oee_baseline_target_percent"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target percentage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_production_schedule_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and demand alignment metrics for production schedules"
  source: "`food_beverage_ecm`.`manufacturing`.`production_schedule`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being scheduled"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center assigned to the schedule"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule"
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity planned in schedules"
    - name: "total_forecast_demand_quantity"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity"
    - name: "capacity_utilization_percent_avg"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across schedules"
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of production schedule records"
$$;