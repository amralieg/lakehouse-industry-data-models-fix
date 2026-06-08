-- Metric views for domain: production | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_daily_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key daily production performance metrics"
  source: "`oil_gas_ecm`.`production`.`daily_production`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of production"
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Reservoir identifier"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Production facility identifier"
    - name: "artificial_lift_type"
      expr: artificial_lift_type
      comment: "Type of artificial lift used"
    - name: "production_status"
      expr: production_status
      comment: "Operational status of the production record"
  measures:
    - name: "total_net_gas_volume_mcf"
      expr: SUM(CAST(net_gas_volume_mcf AS DOUBLE))
      comment: "Total net gas produced (Mcf) per grouping"
    - name: "total_net_oil_volume_bbl"
      expr: SUM(CAST(net_oil_volume_bbl AS DOUBLE))
      comment: "Total net oil produced (bbl) per grouping"
    - name: "total_boe_volume"
      expr: SUM(CAST(boe_volume AS DOUBLE))
      comment: "Total barrel of oil equivalent produced"
    - name: "average_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas‑oil ratio"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of daily production records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_monthly_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated monthly production KPIs"
  source: "`oil_gas_ecm`.`production`.`monthly_production`"
  dimensions:
    - name: "production_month"
      expr: production_month
      comment: "Month of production"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Production facility identifier"
    - name: "artificial_lift_type"
      expr: artificial_lift_type
      comment: "Artificial lift type used"
    - name: "production_status"
      expr: production_status
      comment: "Production status for the month"
  measures:
    - name: "total_gas_volume_mcf"
      expr: SUM(CAST(gas_volume_mcf AS DOUBLE))
      comment: "Total gas produced (Mcf) for the month"
    - name: "total_oil_volume_bbl"
      expr: SUM(CAST(oil_volume_bbl AS DOUBLE))
      comment: "Total oil produced (bbl) for the month"
    - name: "total_water_volume_bbl"
      expr: SUM(CAST(water_volume_bbl AS DOUBLE))
      comment: "Total water produced (bbl) for the month"
    - name: "total_boe"
      expr: SUM(CAST(boe_total AS DOUBLE))
      comment: "Total barrel‑of‑oil‑equivalent for the month"
    - name: "average_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas‑oil ratio for the month"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of monthly production records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_artificial_lift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost metrics for artificial lift equipment"
  source: "`oil_gas_ecm`.`production`.`artificial_lift`"
  dimensions:
    - name: "installation_date"
      expr: installation_date
      comment: "Date the lift was installed"
    - name: "lift_type"
      expr: lift_type
      comment: "Type of artificial lift"
    - name: "lift_status"
      expr: lift_status
      comment: "Current status of the lift"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment identifier"
  measures:
    - name: "average_actual_rate_bopd"
      expr: AVG(CAST(actual_rate_bopd AS DOUBLE))
      comment: "Average actual production rate (bopd) of artificial lifts"
    - name: "average_design_rate_bopd"
      expr: AVG(CAST(design_rate_bopd AS DOUBLE))
      comment: "Average design production rate (bopd) of artificial lifts"
    - name: "total_operating_cost_usd"
      expr: SUM(CAST(operating_cost_per_day_usd AS DOUBLE))
      comment: "Total operating cost (USD) for artificial lifts"
    - name: "lift_count"
      expr: COUNT(1)
      comment: "Number of artificial lift records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime impact metrics for production assets"
  source: "`oil_gas_ecm`.`production`.`downtime_event`"
  dimensions:
    - name: "start_timestamp"
      expr: start_timestamp
      comment: "Timestamp when downtime started"
    - name: "downtime_category"
      expr: downtime_category
      comment: "High‑level category of downtime"
    - name: "downtime_subcategory"
      expr: downtime_subcategory
      comment: "Detailed sub‑category of downtime"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Facility affected by downtime"
    - name: "field_id"
      expr: field_id
      comment: "Field where downtime occurred"
  measures:
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total downtime duration (hours)"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of downtime (USD)"
    - name: "average_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average downtime duration (hours)"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of downtime events"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_flare_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental and operational metrics for flare events"
  source: "`oil_gas_ecm`.`production`.`flare_record`"
  dimensions:
    - name: "flare_date"
      expr: flare_date
      comment: "Date of flare event"
    - name: "flare_type"
      expr: flare_type
      comment: "Type of flare (e.g., routine, upset)"
    - name: "flare_status"
      expr: flare_status
      comment: "Operational status of the flare event"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Facility where flare occurred"
    - name: "field_id"
      expr: field_id
      comment: "Field associated with the flare"
  measures:
    - name: "total_flare_volume_mcf"
      expr: SUM(CAST(flare_volume_mcf AS DOUBLE))
      comment: "Total flare gas volume (Mcf)"
    - name: "total_ghg_emissions_tonnes"
      expr: SUM(CAST(ghg_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total CO2e emissions from flaring (tonnes)"
    - name: "flare_event_count"
      expr: COUNT(1)
      comment: "Number of flare events"
$$;