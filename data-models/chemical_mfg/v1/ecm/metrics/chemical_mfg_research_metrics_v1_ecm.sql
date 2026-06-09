-- Metric views for domain: research | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_lab_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for lab experiments focusing on yield, quality, and operational conditions"
  source: "`chemical_mfg_ecm`.`research`.`lab_experiment`"
  dimensions:
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment performed"
    - name: "lab_experiment_status"
      expr: lab_experiment_status
      comment: "Current status of the lab experiment"
    - name: "instrument_method"
      expr: instrument_method
      comment: "Analytical instrument method used"
    - name: "experiment_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the experiment was created"
    - name: "experiment_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the experiment was created"
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of lab experiments recorded"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across experiments"
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_c AS DOUBLE))
      comment: "Average actual temperature (C) observed in experiments"
    - name: "avg_actual_pressure_bar"
      expr: AVG(CAST(actual_pressure_bar AS DOUBLE))
      comment: "Average actual pressure (bar) observed in experiments"
    - name: "deviation_count"
      expr: SUM(CASE WHEN deviation_flag THEN 1 ELSE 0 END)
      comment: "Count of experiments flagged with a deviation"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for experiments"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_trial_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor production efficiency, energy use, and waste in trial batches"
  source: "`chemical_mfg_ecm`.`research`.`trial_batch`"
  dimensions:
    - name: "trial_batch_status"
      expr: trial_batch_status
      comment: "Operational status of the trial batch"
    - name: "project_id"
      expr: project_id
      comment: "Associated research project identifier"
    - name: "batch_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the batch record was created"
    - name: "batch_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the batch record was created"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of trial batches"
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percent across batches"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption (MWh) per batch"
    - name: "avg_emission_estimate_kg"
      expr: AVG(CAST(emission_estimate_kg AS DOUBLE))
      comment: "Average estimated emissions (kg) per batch"
    - name: "total_waste_generated_kg"
      expr: SUM(CAST(waste_generated_kg AS DOUBLE))
      comment: "Total waste generated (kg) across all batches"
    - name: "avg_yield_difference_percent"
      expr: AVG(CAST(yield_difference_percent AS DOUBLE))
      comment: "Average difference between target and actual yield percent"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_synthesis_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for synthesis efficiency, cost, and environmental impact"
  source: "`chemical_mfg_ecm`.`research`.`synthesis_procedure`"
  dimensions:
    - name: "procedure_name"
      expr: procedure_name
      comment: "Descriptive name of the synthesis procedure"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the procedure"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the procedure is critical"
    - name: "procedure_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the procedure record was created"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of synthesis procedures executed"
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percent for procedures"
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate (USD) per procedure"
    - name: "total_emissions_co2_kg"
      expr: SUM(CAST(emissions_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions (kg) from synthesis procedures"
    - name: "avg_scale_kg"
      expr: AVG(CAST(scale_kg AS DOUBLE))
      comment: "Average scale (kg) of material processed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_rd_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance metrics for stability studies"
  source: "`chemical_mfg_ecm`.`research`.`rd_stability_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study"
    - name: "rd_stability_study_status"
      expr: rd_stability_study_status
      comment: "Current status of the study"
    - name: "regulatory_protocol_reference"
      expr: regulatory_protocol_reference
      comment: "Reference to regulatory protocol used"
    - name: "study_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year the study started"
    - name: "study_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the study started"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of R&D stability studies"
    - name: "avg_shelf_life_estimate_months"
      expr: AVG(CAST(shelf_life_estimate_months AS DOUBLE))
      comment: "Average estimated shelf life (months) from studies"
    - name: "avg_light_exposure_lux"
      expr: AVG(CAST(light_exposure_lux AS DOUBLE))
      comment: "Average light exposure (lux) applied in studies"
    - name: "oos_count"
      expr: SUM(CASE WHEN is_oos_flag THEN 1 ELSE 0 END)
      comment: "Count of out‑of‑specification (OOS) findings"
    - name: "oot_count"
      expr: SUM(CASE WHEN is_oot_flag THEN 1 ELSE 0 END)
      comment: "Count of out‑of‑trend (OOT) findings"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_process_simulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic simulation KPIs to assess process efficiency and conversion"
  source: "`chemical_mfg_ecm`.`research`.`research_process_simulation`"
  dimensions:
    - name: "simulation_type"
      expr: simulation_type
      comment: "Classification of the simulation"
    - name: "simulation_status"
      expr: simulation_status
      comment: "Current status of the simulation run"
    - name: "model_tool"
      expr: model_tool
      comment: "Software tool used for the simulation"
    - name: "simulation_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the simulation was created"
    - name: "simulation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the simulation was created"
  measures:
    - name: "total_simulations"
      expr: COUNT(1)
      comment: "Total number of research process simulations run"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average simulated yield percent"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average simulated energy consumption (MWh)"
    - name: "avg_conversion_rate_percent"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate percent from simulations"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`research_structure_activity_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key activity and potency metrics for chemical structures"
  source: "`chemical_mfg_ecm`.`research`.`structure_activity_record`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity measured (e.g., inhibition, activation)"
    - name: "activity_unit"
      expr: activity_unit
      comment: "Unit of the activity measurement"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the activity"
    - name: "record_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the record was created"
    - name: "record_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the record was created"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total number of structure activity records"
    - name: "avg_activity_value"
      expr: AVG(CAST(activity_value AS DOUBLE))
      comment: "Average activity value across records"
    - name: "avg_concentration_mg_per_ml"
      expr: AVG(CAST(concentration_mg_per_ml AS DOUBLE))
      comment: "Average concentration (mg/mL) measured"
    - name: "distinct_assay_count"
      expr: COUNT(DISTINCT assay_id)
      comment: "Number of distinct assays represented"
$$;