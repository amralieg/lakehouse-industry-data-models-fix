-- Metric views for domain: formulation | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`formulation_process_simulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and efficiency metrics for formulation process simulations."
  source: "`chemical_mfg_ecm`.`formulation`.`formulation_process_simulation`"
  dimensions:
    - name: "simulation_id"
      expr: formulation_process_simulation_id
      comment: "Unique identifier of the simulation run."
    - name: "simulation_type"
      expr: simulation_type
      comment: "Type of simulation (e.g., pilot, scale-up)."
    - name: "simulation_category"
      expr: simulation_category
      comment: "Category grouping for simulations."
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS classification of the simulated formulation."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates if simulation meets regulatory compliance."
    - name: "is_sensitivity_analysis"
      expr: is_sensitivity_analysis
      comment: "Flag for sensitivity analysis runs."
    - name: "simulation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of simulation creation."
  measures:
    - name: "total_simulations"
      expr: COUNT(1)
      comment: "Count of simulation records."
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across simulations."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across simulations."
    - name: "avg_yield_gap_percent"
      expr: AVG(actual_yield_percent - target_yield_percent)
      comment: "Average difference between actual and target yields."
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_minutes AS DOUBLE))
      comment: "Average runtime in minutes per simulation."
    - name: "avg_cpu_usage_percent"
      expr: AVG(CAST(cpu_usage_percent AS DOUBLE))
      comment: "Average CPU usage percentage during simulations."
    - name: "avg_memory_usage_gb"
      expr: AVG(CAST(memory_usage_gb AS DOUBLE))
      comment: "Average memory usage in GB per simulation."
    - name: "avg_energy_balance_mwh"
      expr: AVG(CAST(energy_balance_mwh AS DOUBLE))
      comment: "Average energy balance in MWh per simulation."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of simulation inputs."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`formulation_formula_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality deviation metrics for formulas to monitor process stability and compliance."
  source: "`chemical_mfg_ecm`.`formulation`.`formula_deviation`"
  dimensions:
    - name: "formula_id"
      expr: formula_id
      comment: "Identifier of the associated formula."
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of the deviation (e.g., process, material)."
    - name: "deviation_type"
      expr: deviation_type
      comment: "Specific type of deviation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the deviation."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification for the deviation."
    - name: "deviation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the deviation was recorded."
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of deviation records."
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average quantitative deviation amount."
    - name: "avg_magnitude_percent"
      expr: AVG(CAST(magnitude_percent AS DOUBLE))
      comment: "Average magnitude of deviation expressed as percent."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`formulation_formula`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level metrics for formulas to assess ingredient content and batch sizing."
  source: "`chemical_mfg_ecm`.`formulation`.`formula`"
  dimensions:
    - name: "formula_id"
      expr: formula_id
      comment: "Primary key of the formula."
    - name: "formula_status"
      expr: formula_status
      comment: "Current status of the formula (e.g., Active, Retired)."
    - name: "formulation_category"
      expr: formulation_category
      comment: "Category grouping of the formula."
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS classification for safety compliance."
    - name: "ip_ownership_flag"
      expr: ip_ownership_flag
      comment: "Indicates if the formula is IP owned."
    - name: "formula_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the formula record was created."
  measures:
    - name: "total_formulas"
      expr: COUNT(1)
      comment: "Total number of formulas in the catalog."
    - name: "avg_active_ingredient_content_percent"
      expr: AVG(CAST(active_ingredient_content_percent AS DOUBLE))
      comment: "Average active ingredient content percentage across formulas."
    - name: "avg_standard_batch_size_kg"
      expr: AVG(CAST(standard_batch_size_kg AS DOUBLE))
      comment: "Average standard batch size in kilograms."
$$;