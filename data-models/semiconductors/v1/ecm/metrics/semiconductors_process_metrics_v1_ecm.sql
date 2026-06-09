-- Metric views for domain: process | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_capability_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capability quality metrics for process engineering leadership"
  source: "`semiconductors_ecm`.`process`.`capability`"
  dimensions:
    - name: "process_area"
      expr: process_area
      comment: "High‑level process area (e.g., Front‑End, Back‑End)"
    - name: "process_layer"
      expr: process_layer
      comment: "Specific process layer within the area"
    - name: "product_family"
      expr: product_family
      comment: "Product family associated with the capability"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the capability"
    - name: "capability_status"
      expr: capability_status
      comment: "Operational status of the capability"
    - name: "control_chart_type"
      expr: control_chart_type
      comment: "Type of control chart used for monitoring"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the capability parameters"
    - name: "analysis_date"
      expr: DATE_TRUNC('day', analysis_timestamp)
      comment: "Date of the capability analysis"
  measures:
    - name: "total_capabilities"
      expr: COUNT(1)
      comment: "Total number of capability records captured"
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Process Capability (Cp) index across capabilities"
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Process Capability (Cpk) index across capabilities"
    - name: "avg_pp_index"
      expr: AVG(CAST(pp_index AS DOUBLE))
      comment: "Average Process Performance (Pp) index"
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Process Performance (Ppk) index"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN corrective_action_required THEN 1 ELSE 0 END), 2)
      comment: "Percentage of capabilities requiring corrective action"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_defect_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and yield impact metrics from defect inspections"
  source: "`semiconductors_ecm`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "fab_tool_id"
      expr: fab_tool_id
      comment: "Identifier of the fab tool used for inspection"
    - name: "wafer_id"
      expr: wafer_id
      comment: "Wafer identifier inspected"
    - name: "inspection_date"
      expr: DATE_TRUNC('day', inspection_timestamp)
      comment: "Date of the inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., Completed, Pending)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer where inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspection records"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across inspections"
    - name: "avg_inspected_area"
      expr: AVG(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Average inspected area in cm²"
    - name: "excursion_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN excursion_detected THEN 1 ELSE 0 END), 2)
      comment: "Percentage of inspections where an excursion was detected"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_lot_process_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and quality metrics for lot‑level process runs"
  source: "`semiconductors_ecm`.`process`.`lot_process_run`"
  dimensions:
    - name: "fab_tool_id"
      expr: fab_tool_id
      comment: "Fab tool used for the lot run"
    - name: "process_step_id"
      expr: process_step_id
      comment: "Process step identifier"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Recipe applied during the run"
    - name: "shift_schedule_id"
      expr: shift_schedule_id
      comment: "Shift schedule identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the lot"
    - name: "run_start_date"
      expr: DATE_TRUNC('day', actual_start_timestamp)
      comment: "Start date of the lot run"
    - name: "process_qualification_status"
      expr: process_qualification_status
      comment: "Qualification status of the process for the lot"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Disposition outcome of the lot"
  measures:
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of lot process runs recorded"
    - name: "total_measurement_value"
      expr: SUM(CAST(measurement_result_value AS DOUBLE))
      comment: "Sum of measurement result values for the lot runs"
    - name: "avg_gas_flow"
      expr: AVG(CAST(process_gas_flow_sccm AS DOUBLE))
      comment: "Average process gas flow (sccm) across runs"
    - name: "avg_power_watts"
      expr: AVG(CAST(process_power_watts AS DOUBLE))
      comment: "Average process power (watts) across runs"
    - name: "avg_pressure_torr"
      expr: AVG(CAST(process_pressure_torr AS DOUBLE))
      comment: "Average process pressure (torr) across runs"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across lot runs"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_yield_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic yield loss and risk metrics for executive oversight"
  source: "`semiconductors_ecm`.`process`.`yield_loss_event`"
  dimensions:
    - name: "fab_tool_id"
      expr: fab_tool_id
      comment: "Fab tool where the yield loss event occurred"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Recipe in use during the event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the yield loss event"
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of yield loss events recorded"
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value associated with yield loss events"
    - name: "high_severity_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END), 2)
      comment: "Percentage of events classified as high severity"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_metrology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology quality and capability metrics for process control"
  source: "`semiconductors_ecm`.`process`.`process_metrology_measurement`"
  dimensions:
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer measured"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the metrology data"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the metrology measurement"
  measures:
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Number of metrology measurements captured"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp value across measurements"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value across measurements"
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean value of the measured parameter"
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation of the measured parameter"
$$;