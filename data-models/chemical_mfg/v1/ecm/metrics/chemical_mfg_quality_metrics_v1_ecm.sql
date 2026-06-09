-- Metric views for domain: quality | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit performance and efficiency metrics"
  source: "`chemical_mfg_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where audit was conducted"
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the audit"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits"
    - name: "avg_audit_duration_days"
      expr: AVG(datediff(actual_end_timestamp, actual_start_timestamp))
      comment: "Average audit duration in days"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality deviation financial and operational impact metrics"
  source: "`chemical_mfg_ecm`.`quality`.`quality_deviation`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Severity level of the quality deviation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deviation"
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Identifier of the chemical product associated with the deviation"
  measures:
    - name: "total_deviation_count"
      expr: COUNT(1)
      comment: "Total number of quality deviations"
    - name: "total_cost_of_quality"
      expr: SUM(CAST(cost_of_quality AS DOUBLE))
      comment: "Sum of cost of quality for deviations"
    - name: "avg_impact_quantity"
      expr: AVG(CAST(impact_quantity AS DOUBLE))
      comment: "Average impact quantity across deviations"
    - name: "hold_deviation_count"
      expr: SUM(CASE WHEN is_hold THEN 1 ELSE 0 END)
      comment: "Count of deviations that resulted in a hold"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot pass/fail and measurement quality metrics"
  source: "`chemical_mfg_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inspection was performed"
    - name: "inspection_reason"
      expr: inspection_reason
      comment: "Reason for the inspection"
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot"
    - name: "batch_number"
      expr: batch_number
      comment: "Batch number associated with the inspection"
    - name: "lot_number"
      expr: lot_number
      comment: "Lot number inspected"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "pass_inspections"
      expr: SUM(CASE WHEN pass_fail_flag THEN 1 ELSE 0 END)
      comment: "Count of inspections that passed"
    - name: "fail_inspections"
      expr: SUM(CASE WHEN pass_fail_flag = false THEN 1 ELSE 0 END)
      comment: "Count of inspections that failed"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across inspections"
    - name: "oos_count"
      expr: SUM(CASE WHEN oos_flag THEN 1 ELSE 0 END)
      comment: "Count of out‑of‑specification inspections"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_qc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical process control and QC result performance metrics"
  source: "`chemical_mfg_ecm`.`quality`.`qc_result`"
  dimensions:
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Chemical product identifier"
    - name: "lab_instrument_id"
      expr: lab_instrument_id
      comment: "Lab instrument used for the measurement"
    - name: "inspection_lot_id"
      expr: inspection_lot_id
      comment: "Inspection lot identifier"
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Name of the measured characteristic"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., concentration, weight)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result"
  measures:
    - name: "total_qc_results"
      expr: COUNT(1)
      comment: "Total number of QC result records"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average QC result value"
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average deviation amount from target"
    - name: "spc_violations"
      expr: SUM(CASE WHEN spc_flag THEN 1 ELSE 0 END)
      comment: "Count of SPC violations detected"
    - name: "control_samples"
      expr: SUM(CASE WHEN is_control_sample THEN 1 ELSE 0 END)
      comment: "Count of control samples processed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA effectiveness and cost efficiency metrics"
  source: "`chemical_mfg_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., Open, Closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA"
    - name: "department"
      expr: department
      comment: "Department responsible for the CAPA"
    - name: "location"
      expr: location
      comment: "Physical location associated with the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying issue"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the CAPA"
  measures:
    - name: "total_capa"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Sum of actual costs incurred for CAPA actions"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Sum of estimated costs for CAPA actions"
    - name: "on_time_capa"
      expr: SUM(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= target_completion_date THEN 1 ELSE 0 END)
      comment: "Count of CAPA actions completed on or before target date"
$$;