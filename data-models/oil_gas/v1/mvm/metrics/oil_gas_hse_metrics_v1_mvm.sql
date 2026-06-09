-- Metric views for domain: hse | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key safety incident metrics for executive oversight"
  source: "`oil_gas_ecm`.`hse`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of the incident (e.g., fire, spill)"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of incident records"
    - name: "fatal_incident_count"
      expr: SUM(CASE WHEN fatality_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents that resulted in a fatality"
    - name: "lost_time_incident_count"
      expr: SUM(CASE WHEN lost_time_incident_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents that caused lost time"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_process_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process safety event performance and impact metrics"
  source: "`oil_gas_ecm`.`hse`.`process_safety_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of safety event (e.g., release, ignition)"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the event for time‑based analysis"
  measures:
    - name: "process_safety_event_count"
      expr: COUNT(1)
      comment: "Total number of process safety events"
    - name: "total_production_loss_boe"
      expr: SUM(CAST(production_loss_boe AS DOUBLE))
      comment: "Aggregate production loss in barrels of oil equivalent"
    - name: "total_property_damage_usd"
      expr: SUM(CAST(property_damage_usd AS DOUBLE))
      comment: "Total property damage cost in USD"
    - name: "average_release_quantity"
      expr: AVG(CAST(release_quantity AS DOUBLE))
      comment: "Average quantity released per event"
    - name: "average_release_rate"
      expr: AVG(CAST(release_rate AS DOUBLE))
      comment: "Average release rate across events"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_ghg_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GHG emission reporting metrics for sustainability governance"
  source: "`oil_gas_ecm`.`hse`.`ghg_emission`"
  dimensions:
    - name: "ghg_gas_type"
      expr: ghg_gas_type
      comment: "Greenhouse gas type (e.g., CO2, CH4)"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period month"
  measures:
    - name: "ghg_emission_event_count"
      expr: COUNT(1)
      comment: "Number of GHG emission records"
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total CO2e emissions in metric tonnes"
    - name: "total_ghg_quantity_tonnes"
      expr: SUM(CAST(ghg_quantity_tonnes AS DOUBLE))
      comment: "Total GHG quantity emitted in tonnes"
    - name: "average_emission_factor_value"
      expr: AVG(CAST(emission_factor_value AS DOUBLE))
      comment: "Average emission factor used for calculations"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_spill_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spill event impact and cost metrics for risk management"
  source: "`oil_gas_ecm`.`hse`.`spill_event`"
  dimensions:
    - name: "spill_reference_number"
      expr: spill_reference_number
      comment: "Unique identifier for the spill event"
  measures:
    - name: "spill_event_count"
      expr: COUNT(1)
      comment: "Total number of spill events"
    - name: "total_confirmed_volume_barrels"
      expr: SUM(CAST(confirmed_volume_barrels AS DOUBLE))
      comment: "Sum of confirmed spill volumes in barrels"
    - name: "total_recovered_volume_barrels"
      expr: SUM(CAST(volume_recovered_barrels AS DOUBLE))
      comment: "Sum of recovered spill volumes in barrels"
    - name: "average_estimated_cleanup_cost_usd"
      expr: AVG(CAST(estimated_cleanup_cost_usd AS DOUBLE))
      comment: "Average estimated cleanup cost in USD"
    - name: "total_estimated_cleanup_cost_usd"
      expr: SUM(CAST(estimated_cleanup_cost_usd AS DOUBLE))
      comment: "Total estimated cleanup cost in USD"
$$;