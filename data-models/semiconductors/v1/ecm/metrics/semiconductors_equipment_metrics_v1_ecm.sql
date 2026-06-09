-- Metric views for domain: equipment | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key OEE performance metrics per tool and shift"
  source: "`semiconductors_ecm`.`equipment`.`oee_record`"
  dimensions:
    - name: "tool_id"
      expr: primary_fab_tool_id
      comment: "Identifier of the primary fab tool"
    - name: "shift_date"
      expr: DATE_TRUNC('day', shift_date)
      comment: "Date of the shift"
    - name: "shift_name"
      expr: shift_name
      comment: "Name of the shift (e.g., A, B, C)"
    - name: "state_current"
      expr: state_current
      comment: "Current state of the OEE record"
  measures:
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across records"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available hours recorded"
    - name: "total_productive_hours"
      expr: SUM(CAST(productive_hours AS DOUBLE))
      comment: "Total productive hours recorded"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours recorded"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of maintenance activities"
  source: "`semiconductors_ecm`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "tool_id"
      expr: primary_fab_tool_id
      comment: "Primary fab tool associated with the maintenance event"
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category of maintenance (e.g., corrective, preventive)"
    - name: "event_status"
      expr: maintenance_event_status
      comment: "Current status of the maintenance event"
    - name: "event_type"
      expr: event_type
      comment: "Type of maintenance event"
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_total AS DOUBLE))
      comment: "Total labor cost for maintenance events"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_total AS DOUBLE))
      comment: "Total parts cost for maintenance events"
    - name: "total_event_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Overall cost (labor + parts) per maintenance event"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of maintenance events"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact of tool downtime on OEE"
  source: "`semiconductors_ecm`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "tool_id"
      expr: primary_fab_tool_id
      comment: "Primary fab tool experiencing downtime"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Classification of downtime (e.g., planned, unplanned)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event"
    - name: "shift"
      expr: shift
      comment: "Shift during which downtime occurred"
  measures:
    - name: "total_oee_impact_percentage"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact from tool downtime events"
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Number of tool downtime events"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration performance and compliance metrics"
  source: "`semiconductors_ecm`.`equipment`.`calibration_record`"
  dimensions:
    - name: "tool_id"
      expr: calibration_fab_tool_id
      comment: "Fab tool that was calibrated"
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method used for calibration"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Result of calibration (PASS/FAIL)"
    - name: "calibration_date"
      expr: DATE_TRUNC('day', calibration_timestamp)
      comment: "Date of calibration"
  measures:
    - name: "calibration_count"
      expr: COUNT(1)
      comment: "Total number of calibration records"
    - name: "pass_calibration_count"
      expr: SUM(CASE WHEN pass_fail_result = 'PASS' THEN 1 ELSE 0 END)
      comment: "Number of successful calibrations"
    - name: "total_measured_value"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Sum of measured values across calibrations"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value per calibration"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_capex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure tracking per tool"
  source: "`semiconductors_ecm`.`equipment`.`tool_capex`"
  dimensions:
    - name: "tool_id"
      expr: primary_fab_tool_id
      comment: "Primary fab tool receiving capex"
    - name: "capex_year"
      expr: DATE_TRUNC('year', capex_date)
      comment: "Fiscal year of the capex transaction"
    - name: "capex_number"
      expr: capex_number
      comment: "Capex transaction identifier"
  measures:
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation cost for tool capex events"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price for tool capex events"
    - name: "total_capex_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Aggregate capex amount (including all components)"
    - name: "capex_event_count"
      expr: COUNT(1)
      comment: "Number of capex events recorded"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty financial exposure per tool"
  source: "`semiconductors_ecm`.`equipment`.`tool_warranty`"
  dimensions:
    - name: "tool_id"
      expr: primary_fab_tool_id
      comment: "Primary fab tool under warranty"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (e.g., extended, standard)"
    - name: "warranty_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the warranty became effective"
  measures:
    - name: "total_warranty_cost"
      expr: SUM(CAST(warranty_cost AS DOUBLE))
      comment: "Total cost covered by warranties"
    - name: "warranty_count"
      expr: COUNT(1)
      comment: "Number of warranty records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_spc_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical process control violation metrics"
  source: "`semiconductors_ecm`.`equipment`.`spc_control`"
  dimensions:
    - name: "tool_id"
      expr: fab_tool_id
      comment: "Fab tool associated with the SPC control"
    - name: "violation_type"
      expr: violation_type
      comment: "Type/category of SPC violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the violation"
    - name: "detection_date"
      expr: DATE_TRUNC('day', detection_timestamp)
      comment: "Date when the violation was detected"
  measures:
    - name: "violation_count"
      expr: COUNT(1)
      comment: "Number of SPC control violations"
    - name: "avg_ucl"
      expr: AVG(CAST(ucl AS DOUBLE))
      comment: "Average Upper Control Limit across violations"
    - name: "avg_lcl"
      expr: AVG(CAST(lcl AS DOUBLE))
      comment: "Average Lower Control Limit across violations"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value triggering violations"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_recipe_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and resource utilization of recipe executions"
  source: "`semiconductors_ecm`.`equipment`.`recipe_execution`"
  dimensions:
    - name: "tool_id"
      expr: fab_tool_id
      comment: "Fab tool used for the recipe execution"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Identifier of the recipe executed"
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the execution (e.g., completed, failed)"
  measures:
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability across recipe executions"
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance across recipe executions"
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality across recipe executions"
    - name: "total_execution_time_seconds"
      expr: SUM(CAST(time_actual_sec AS DOUBLE))
      comment: "Total actual execution time in seconds"
    - name: "total_power_watts"
      expr: SUM(CAST(power_actual_w AS DOUBLE))
      comment: "Cumulative power consumption during executions"
    - name: "total_pressure_pa"
      expr: SUM(CAST(pressure_actual_pa AS DOUBLE))
      comment: "Cumulative pressure applied during executions"
    - name: "total_temperature_c"
      expr: SUM(CAST(temperature_actual_c AS DOUBLE))
      comment: "Cumulative temperature during executions"
    - name: "execution_count"
      expr: COUNT(1)
      comment: "Number of recipe execution records"
$$;