-- Metric views for domain: hse | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_ghg_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key greenhouse gas emission metrics per facility and reporting period."
  source: "`oil_gas_ecm`.`hse`.`ghg_emission`"
  dimensions:
    - name: "asset_facility_id"
      expr: asset_facility_id
      comment: "Facility identifier."
    - name: "reporting_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Reporting year."
    - name: "ghg_gas_type"
      expr: ghg_gas_type
      comment: "Type of greenhouse gas."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total CO2e emissions in tonnes."
    - name: "total_ghg_quantity_tonnes"
      expr: SUM(CAST(ghg_quantity_tonnes AS DOUBLE))
      comment: "Total GHG quantity emitted in tonnes."
    - name: "average_global_warming_potential"
      expr: AVG(CAST(global_warming_potential AS DOUBLE))
      comment: "Average global warming potential across emissions."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident occurrence and severity metrics."
  source: "`oil_gas_ecm`.`hse`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of incident."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of incidents."
    - name: "fatal_incidents"
      expr: SUM(CASE WHEN fatality_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents with fatalities."
    - name: "lost_time_incidents"
      expr: SUM(CASE WHEN lost_time_incident_flag THEN 1 ELSE 0 END)
      comment: "Count of lost-time incidents."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_spill_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spill event volume and cost metrics."
  source: "`oil_gas_ecm`.`hse`.`spill_event`"
  dimensions:
    - name: "spill_status"
      expr: spill_status
      comment: "Current status of spill."
    - name: "spill_year"
      expr: YEAR(spill_occurrence_timestamp)
      comment: "Year of spill occurrence."
    - name: "onshore_offshore_indicator"
      expr: onshore_offshore_indicator
      comment: "Indicates if spill is onshore or offshore."
  measures:
    - name: "total_spills"
      expr: COUNT(1)
      comment: "Total number of spill events."
    - name: "total_confirmed_volume_barrels"
      expr: SUM(CAST(confirmed_volume_barrels AS DOUBLE))
      comment: "Total confirmed spill volume in barrels."
    - name: "average_estimated_cleanup_cost_usd"
      expr: AVG(CAST(estimated_cleanup_cost_usd AS DOUBLE))
      comment: "Average estimated cleanup cost in USD."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_chemical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical inventory quantities and compliance flags."
  source: "`oil_gas_ecm`.`hse`.`chemical_inventory`"
  dimensions:
    - name: "storage_location"
      expr: storage_location
      comment: "Location where chemical is stored."
    - name: "hazardous_substance_id"
      expr: hazardous_substance_id
      comment: "Identifier of hazardous substance."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory record."
  measures:
    - name: "total_average_daily_quantity"
      expr: SUM(CAST(average_daily_quantity AS DOUBLE))
      comment: "Sum of average daily quantities across inventory."
    - name: "total_maximum_daily_quantity"
      expr: SUM(CAST(maximum_daily_quantity AS DOUBLE))
      comment: "Sum of maximum daily quantities across inventory."
    - name: "threshold_exceeded_count"
      expr: SUM(CASE WHEN reporting_threshold_exceeded THEN 1 ELSE 0 END)
      comment: "Count of inventory items where reporting threshold was exceeded."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`hse_hazardous_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous substance inventory and risk metrics."
  source: "`oil_gas_ecm`.`hse`.`hazardous_substance`"
  dimensions:
    - name: "chemical_family"
      expr: chemical_family
      comment: "Family classification of chemical."
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state (solid, liquid, gas)."
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage."
  measures:
    - name: "total_average_daily_quantity_lbs"
      expr: SUM(CAST(average_daily_quantity_lbs AS DOUBLE))
      comment: "Total average daily quantity in lbs."
    - name: "total_maximum_daily_quantity_lbs"
      expr: SUM(CAST(maximum_daily_quantity_lbs AS DOUBLE))
      comment: "Total maximum daily quantity in lbs."
    - name: "sara_section_313_flagged_count"
      expr: SUM(CASE WHEN sara_title_iii_section_313_flag THEN 1 ELSE 0 END)
      comment: "Count of substances flagged under SARA Title III Section 313."
$$;