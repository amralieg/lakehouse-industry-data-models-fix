-- Metric views for domain: treatment | Business: Water Utilities | Version: 1 | Generated on: 2026-05-05 23:18:54

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_backwash_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for backwash operations, supporting operational efficiency and reliability decisions"
  source: "`water_utilities_ecm`.`treatment`.`backwash_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the treatment facility where the backwash occurred"
    - name: "wtp_facility_id"
      expr: wtp_facility_id
      comment: "Identifier of the water treatment plant (WTP) associated with the event"
    - name: "backwash_date"
      expr: DATE_TRUNC('day', backwash_start_timestamp)
      comment: "Date of the backwash event (derived from start timestamp)"
    - name: "abnormal_event_flag"
      expr: abnormal_event_flag
      comment: "Indicates whether the backwash event was abnormal"
    - name: "backwash_water_source"
      expr: backwash_water_source
      comment: "Source of water used for the backwash"
    - name: "backwash_waste_disposal_method"
      expr: backwash_waste_disposal_method
      comment: "Method used to dispose of backwash waste"
  measures:
    - name: "total_backwash_events"
      expr: COUNT(1)
      comment: "Total number of backwash events recorded"
    - name: "total_backwash_volume_gal"
      expr: SUM(CAST(backwash_water_volume_gal AS DOUBLE))
      comment: "Cumulative volume of water used in backwash operations (gallons)"
    - name: "avg_backwash_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of backwash cycles (minutes)"
    - name: "avg_backwash_flow_rate_gpm"
      expr: AVG(CAST(backwash_flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate during backwash (gallons per minute)"
    - name: "abnormal_event_count"
      expr: SUM(CASE WHEN abnormal_event_flag THEN 1 ELSE 0 END)
      comment: "Count of backwash events flagged as abnormal"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production and compliance metrics for finished water, guiding capacity planning and regulatory oversight"
  source: "`water_utilities_ecm`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier"
    - name: "production_date"
      expr: DATE_TRUNC('day', production_date)
      comment: "Date of production record"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift identifier (e.g., day, night)"
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Method used to disinfect the water"
    - name: "regulatory_exceedance"
      expr: regulatory_exceedance
      comment: "Flag indicating regulatory exceedance for the event"
  measures:
    - name: "production_event_count"
      expr: COUNT(1)
      comment: "Number of finished water production records"
    - name: "total_production_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total volume of finished water produced (million gallons) for the period"
    - name: "avg_production_rate_gpm"
      expr: AVG(CAST(avg_production_rate_gpm AS DOUBLE))
      comment: "Average production rate (gallons per minute)"
    - name: "peak_production_rate_gpm"
      expr: MAX(peak_production_rate_gpm)
      comment: "Maximum production rate observed (gallons per minute)"
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (dimensionless)"
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN regulatory_exceedance THEN 1 ELSE 0 END)
      comment: "Count of production events that exceeded regulatory limits"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing performance and cost metrics, supporting operational budgeting and compliance monitoring"
  source: "`water_utilities_ecm`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where dosing occurred"
    - name: "chemical_type"
      expr: chemical_type
      comment: "Type/category of chemical used"
    - name: "dosing_method"
      expr: dosing_method
      comment: "Method employed for chemical dosing"
    - name: "dose_event_status"
      expr: dose_event_status
      comment: "Current status of the dose event"
    - name: "dose_trigger_type"
      expr: dose_trigger_type
      comment: "Trigger that initiated the dosing event"
    - name: "operator_employee_id"
      expr: operator_employee_id
      comment: "Employee identifier of the operator who performed the dose"
  measures:
    - name: "dose_event_count"
      expr: COUNT(1)
      comment: "Number of chemical dose events recorded"
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total mass of chemical applied across events (kilograms)"
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average dose rate applied (mg/L)"
    - name: "total_event_dose_cost_usd"
      expr: SUM(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Total cost of chemical dosing events (USD)"
    - name: "regulatory_event_flag_count"
      expr: SUM(CASE WHEN regulatory_event_flag THEN 1 ELSE 0 END)
      comment: "Count of dose events flagged for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_membrane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor membrane health, efficiency, and cleaning activities for strategic asset management"
  source: "`water_utilities_ecm`.`treatment`.`membrane_performance`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the membrane unit is installed"
    - name: "membrane_technology_type"
      expr: membrane_technology_type
      comment: "Technology type of the membrane (e.g., RO, NF)"
    - name: "observation_date"
      expr: DATE_TRUNC('day', observation_timestamp)
      comment: "Date of the performance observation"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the membrane unit"
  measures:
    - name: "membrane_performance_event_count"
      expr: COUNT(1)
      comment: "Number of membrane performance records"
    - name: "avg_normalized_permeate_flux"
      expr: AVG(CAST(normalized_permeate_flux AS DOUBLE))
      comment: "Average normalized permeate flux (units as defined in source)"
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average water recovery rate percentage"
    - name: "avg_fouling_index"
      expr: AVG(CAST(fouling_index AS DOUBLE))
      comment: "Average fouling index indicating membrane condition"
    - name: "cleaning_event_count"
      expr: SUM(CASE WHEN cleaning_chemical_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of membrane cleaning events recorded"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intake water quality and volume metrics, essential for source protection and treatment planning"
  source: "`water_utilities_ecm`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility receiving the source water"
    - name: "intake_date"
      expr: DATE_TRUNC('day', intake_timestamp)
      comment: "Date of the intake event"
    - name: "source_type"
      expr: source_type
      comment: "Classification of the water source (e.g., river, reservoir)"
    - name: "source_water_alert_active"
      expr: source_water_alert_active
      comment: "Flag indicating if a water quality alert was active at intake"
    - name: "water_source_id"
      expr: water_source_id
      comment: "Identifier of the specific water source"
  measures:
    - name: "intake_event_count"
      expr: COUNT(1)
      comment: "Number of source water intake events"
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total volume of raw water withdrawn (million gallons)"
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average turbidity of intake water (NTU)"
    - name: "avg_conductivity_us_per_cm"
      expr: AVG(CAST(conductivity_us_per_cm AS DOUBLE))
      comment: "Average electrical conductivity of intake water (µS/cm)"
    - name: "alert_active_count"
      expr: SUM(CASE WHEN source_water_alert_active THEN 1 ELSE 0 END)
      comment: "Count of intake events where a water quality alert was active"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk metrics for treatment violations, informing regulatory strategy and corrective action prioritization"
  source: "`water_utilities_ecm`.`treatment`.`treatment_violation`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the violation occurred"
    - name: "violation_type"
      expr: violation_type
      comment: "Category or type of the violation"
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., open, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation"
    - name: "detection_date"
      expr: DATE_TRUNC('day', detection_timestamp)
      comment: "Date the violation was detected"
  measures:
    - name: "violation_count"
      expr: COUNT(1)
      comment: "Total number of treatment violations recorded"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Aggregate monetary penalties associated with violations (USD)"
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude of regulatory exceedances"
    - name: "repeat_violation_count"
      expr: SUM(CASE WHEN is_repeat_violation THEN 1 ELSE 0 END)
      comment: "Count of violations that are repeats of prior issues"
$$;