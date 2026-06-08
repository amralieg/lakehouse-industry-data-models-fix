-- Metric views for domain: production | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_manufacturing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for manufacturing orders"
  source: "`chemical_mfg_ecm`.`production`.`manufacturing_order`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the order is executed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the manufacturing order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, rush)"
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Planned start date of the order"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of manufacturing orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Sum of actual quantity produced across orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for manufacturing orders"
    - name: "average_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics summarizing batch production performance"
  source: "`chemical_mfg_ecm`.`production`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch"
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Date the batch was manufactured"
  measures:
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of batch records"
    - name: "total_batch_size_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total quantity sized for batches"
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Sum of actual yield quantity across batches"
    - name: "average_batch_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage per batch"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_equipment_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment effectiveness and downtime impact metrics"
  source: "`chemical_mfg_ecm`.`production`.`equipment_effectiveness`"
  dimensions:
    - name: "equipment_id"
      expr: equipment_id
      comment: "Identifier of the equipment"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center associated with the equipment"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., planned, unplanned)"
    - name: "downtime_day"
      expr: DATE_TRUNC('day', downtime_start_timestamp)
      comment: "Day of the downtime event"
  measures:
    - name: "equipment_downtime_event_count"
      expr: COUNT(1)
      comment: "Number of downtime events recorded for equipment"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Cumulative downtime minutes for equipment"
    - name: "availability_impact_event_count"
      expr: SUM(CASE WHEN oee_availability_impact_flag THEN 1 ELSE 0 END)
      comment: "Count of downtime events that impacted OEE availability"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield performance metrics per plant and production line"
  source: "`chemical_mfg_ecm`.`production`.`yield_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the yield was recorded"
    - name: "production_line_code"
      expr: production_line_code
      comment: "Production line identifier"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the yield record"
    - name: "record_date"
      expr: DATE_TRUNC('day', record_created_timestamp)
      comment: "Date the yield record was created"
  measures:
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records captured"
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity across records"
    - name: "total_planned_yield_quantity"
      expr: SUM(CAST(planned_yield_quantity AS DOUBLE))
      comment: "Total planned yield quantity"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved"
    - name: "total_yield_variance_quantity"
      expr: SUM(CAST(yield_variance_quantity AS DOUBLE))
      comment: "Cumulative yield variance quantity"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level production efficiency and cost metrics"
  source: "`chemical_mfg_ecm`.`production`.`campaign`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier for the campaign"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., standard, CIP)"
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Planned start date of the campaign"
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaigns executed"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced in campaigns"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for campaigns"
    - name: "average_oee_actual_percentage"
      expr: AVG(CAST(oee_actual_percentage AS DOUBLE))
      comment: "Average OEE actual percentage across campaigns"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_process_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process order planning and execution metrics"
  source: "`chemical_mfg_ecm`.`production`.`process_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the process order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the process order"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the process order is executed"
  measures:
    - name: "process_order_count"
      expr: COUNT(1)
      comment: "Number of process orders"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity for process orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (actual) quantity for process orders"
$$;