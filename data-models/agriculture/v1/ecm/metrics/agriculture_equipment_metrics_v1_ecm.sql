-- Metric views for domain: equipment | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset inventory KPIs"
  source: "`agriculture_ecm`.`equipment`.`asset`"
  dimensions:
    - name: "asset_category_id"
      expr: asset_category_id
      comment: "Asset category identifier"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where asset is located"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the asset"
    - name: "gps_rtk_enabled"
      expr: gps_rtk_enabled
      comment: "Whether RTK GPS is enabled"
    - name: "acquisition_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year the asset was acquired"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Count of equipment assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of assets"
    - name: "average_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value of assets"
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Sum of engine hours across all assets"
    - name: "average_engine_power_kw"
      expr: AVG(CAST(engine_power_kw AS DOUBLE))
      comment: "Average engine power in kW"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of assets"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_asset_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for asset usage assignments"
  source: "`agriculture_ecm`.`equipment`.`asset_assignment`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility of assignment"
    - name: "crew_id"
      expr: crew_id
      comment: "Crew responsible for the assignment"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment"
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Purpose of the assignment"
    - name: "start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year assignment started"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Count of asset assignments"
    - name: "total_assigned_area_hectares"
      expr: SUM(CAST(actual_area_hectares AS DOUBLE))
      comment: "Total actual area assigned (hectares)"
    - name: "total_assigned_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual utilization hours"
    - name: "total_assignment_cost"
      expr: SUM(CAST(total_assignment_cost AS DOUBLE))
      comment: "Total cost of assignments"
    - name: "average_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for assignments"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness metrics"
  source: "`agriculture_ecm`.`equipment`.`oee_record`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where OEE was recorded"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of measurement"
    - name: "shift_id"
      expr: shift_id
      comment: "Shift identifier"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation"
  measures:
    - name: "average_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage"
    - name: "average_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average availability rate"
    - name: "average_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate"
    - name: "average_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate"
    - name: "total_output_quantity"
      expr: SUM(CAST(total_output_quantity AS DOUBLE))
      comment: "Total output quantity measured"
    - name: "total_acceptable_output_quantity"
      expr: SUM(CAST(acceptable_output_quantity AS DOUBLE))
      comment: "Total acceptable output quantity"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_fault`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fault and reliability KPIs"
  source: "`agriculture_ecm`.`equipment`.`fault`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier"
    - name: "fault_category"
      expr: fault_category
      comment: "Category of fault"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of fault"
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the fault"
    - name: "detection_year"
      expr: DATE_TRUNC('year', detection_timestamp)
      comment: "Year fault was detected"
  measures:
    - name: "total_faults"
      expr: COUNT(1)
      comment: "Count of recorded faults"
    - name: "total_actual_repair_cost_usd"
      expr: SUM(CAST(actual_repair_cost_usd AS DOUBLE))
      comment: "Total actual repair cost in USD"
    - name: "total_estimated_repair_cost_usd"
      expr: SUM(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total estimated repair cost in USD"
    - name: "warranty_claim_faults"
      expr: SUM(CASE WHEN is_warranty_claim THEN 1 ELSE 0 END)
      comment: "Number of faults that resulted in warranty claims"
    - name: "safety_critical_faults"
      expr: SUM(CASE WHEN is_safety_critical THEN 1 ELSE 0 END)
      comment: "Number of safety‑critical faults"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance work order performance metrics"
  source: "`agriculture_ecm`.`equipment`.`work_order`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being serviced"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center handling the order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the work order"
    - name: "maintenance_plan_id"
      expr: maintenance_plan_id
      comment: "Associated maintenance plan"
    - name: "start_year"
      expr: DATE_TRUNC('year', actual_start_timestamp)
      comment: "Year work order started"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Count of work orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours spent"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost incurred"
    - name: "average_labor_cost"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per work order"
    - name: "average_equipment_downtime_hours"
      expr: AVG(CAST(equipment_downtime_hours AS DOUBLE))
      comment: "Average equipment downtime hours per work order"
$$;