-- Metric views for domain: asset | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key downtime performance indicators for assets"
  source: "`manufacturing_ecm`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the downtime occurred"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the asset"
    - name: "equipment_register_id"
      expr: equipment_register_id
      comment: "Identifier of the equipment"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., mechanical, electrical)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime"
    - name: "shift_id"
      expr: shift_id
      comment: "Shift during which downtime was recorded"
    - name: "downtime_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the downtime event"
  measures:
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime minutes across all events"
    - name: "average_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime minutes per event"
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Number of downtime events recorded"
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Sum of estimated financial loss due to downtime"
    - name: "average_oee_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order performance and cost metrics"
  source: "`manufacturing_ecm`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "work_order_type_id"
      expr: work_order_type_id
      comment: "Type of work order"
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality rating of the asset involved"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center funding the work order"
    - name: "work_order_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the work order was created"
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Sum of estimated cost for all work orders"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Sum of actual labor cost incurred"
    - name: "average_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "safety_incident_work_order_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Count of work orders that impacted production (safety/critical)"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_reliability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and availability KPIs for assets"
  source: "`manufacturing_ecm`.`asset`.`reliability_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the asset"
    - name: "equipment_register_id"
      expr: equipment_register_id
      comment: "Equipment register identifier"
    - name: "asset_number"
      expr: asset_number
      comment: "Asset number"
    - name: "asset_class"
      expr: asset_class
      comment: "Class of the asset"
    - name: "record_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the reliability record"
  measures:
    - name: "reliability_record_count"
      expr: COUNT(1)
      comment: "Number of reliability records"
    - name: "average_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average Mean Time Between Failures (hours)"
    - name: "average_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average Mean Time To Repair (hours)"
    - name: "average_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average asset availability percentage"
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total downtime hours recorded"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_capex_asset_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial overview of capital assets"
  source: "`manufacturing_ecm`.`asset`.`capex_asset_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the asset is located"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of capitalized assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost for all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Sum of accumulated depreciation across assets"
    - name: "average_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value of assets"
$$;