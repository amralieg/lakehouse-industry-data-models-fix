-- Metric views for domain: quality | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_apqp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality performance indicators derived from APQP planning data"
  source: "`automotive_ecm`.`quality`.`apqp_plan`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle program"
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Identifier for the vehicle program"
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase"
    - name: "classification_type"
      expr: classification_type
      comment: "Classification of the APQP plan"
    - name: "actual_release_month"
      expr: DATE_TRUNC('month', actual_release_date)
      comment: "Month of actual release date"
  measures:
    - name: "apqp_plan_count"
      expr: COUNT(1)
      comment: "Total number of APQP plans"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual parts per million (PPM) across APQP plans"
    - name: "avg_quality_goal_ppm"
      expr: AVG(CAST(quality_goal_ppm AS DOUBLE))
      comment: "Average quality goal PPM defined in APQP plans"
    - name: "ppm_yield_rate"
      expr: AVG(CAST(CASE WHEN actual_ppm <= target_ppm THEN 1 ELSE 0 END AS DOUBLE))
      comment: "Proportion of APQP plans meeting or beating the target PPM"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated defect information for root‑cause and quality impact analysis"
  source: "`automotive_ecm`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "High‑level category of the defect"
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect (e.g., design, process)"
  measures:
    - name: "defect_record_count"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average PPM rate for defects"
    - name: "distinct_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Count of unique defect codes reported"
    - name: "repeat_defect_rate"
      expr: AVG(CAST(CASE WHEN is_repeat_defect THEN 1 ELSE 0 END AS DOUBLE))
      comment: "Proportion of defects that are repeats"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_ppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPM tracking at gate level to monitor quality trends"
  source: "`automotive_ecm`.`quality`.`ppm_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Code of the manufacturing plant"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period identifier (e.g., Q1-2024)"
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect associated with the PPM record"
  measures:
    - name: "ppm_record_count"
      expr: COUNT(1)
      comment: "Total number of PPM records captured"
    - name: "avg_ppm_value"
      expr: AVG(CAST(ppm_value AS DOUBLE))
      comment: "Average measured PPM value"
    - name: "avg_ppm_variance"
      expr: AVG(CAST(ppm_variance AS DOUBLE))
      comment: "Average variance between target and actual PPM"
    - name: "quality_gate_pass_rate"
      expr: AVG(CAST(CASE WHEN quality_gate_passed THEN 1 ELSE 0 END AS DOUBLE))
      comment: "Proportion of records where the quality gate was passed"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_gate_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance of quality gates across production"
  source: "`automotive_ecm`.`quality`.`gate_result`"
  dimensions:
    - name: "gate_id"
      expr: gate_id
      comment: "Identifier of the gate"
    - name: "gate_type"
      expr: gate_type
      comment: "Type of gate (e.g., assembly, final)"
    - name: "gate_status"
      expr: gate_status
      comment: "Result status of the gate"
    - name: "gate_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of gate result creation"
  measures:
    - name: "gate_result_count"
      expr: COUNT(1)
      comment: "Total number of gate result events"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned at gate"
    - name: "gate_pass_rate"
      expr: AVG(CAST(CASE WHEN gate_status = 'PASS' THEN 1 ELSE 0 END AS DOUBLE))
      comment: "Proportion of gates with a PASS status"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_wltp_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key emissions and range metrics from WLTP testing for electric and hybrid vehicles"
  source: "`automotive_ecm`.`quality`.`wltp_test_result`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle under test"
    - name: "powertrain_variant_code"
      expr: powertrain_variant_code
      comment: "Identifier for the powertrain variant"
    - name: "test_type"
      expr: test_type
      comment: "Type of WLTP test performed"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted"
  measures:
    - name: "wltp_test_count"
      expr: COUNT(1)
      comment: "Total number of WLTP test results recorded"
    - name: "avg_electric_range_km"
      expr: AVG(CAST(electric_range_km AS DOUBLE))
      comment: "Average electric range (km) achieved in WLTP tests"
    - name: "avg_total_co2_g_per_km"
      expr: AVG(CAST(total_co2_g_per_km AS DOUBLE))
      comment: "Average total CO2 emissions (g/km) across tests"
    - name: "avg_nox_mg_per_km"
      expr: AVG(CAST(nox_mg_per_km AS DOUBLE))
      comment: "Average NOx emissions (mg/km) across tests"
$$;