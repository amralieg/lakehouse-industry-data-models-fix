-- Metric views for domain: distribution | Business: Water Utilities | Version: 1 | Generated on: 2026-05-05 23:18:54

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_nrw_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic NRW performance metrics per DMA and audit period."
  source: "`water_utilities_ecm`.`distribution`.`distribution_nrw_water_balance`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the Distribution Management Area (DMA)."
    - name: "audit_period_month"
      expr: DATE_TRUNC('month', audit_period_start_date)
      comment: "Month of the audit period start date."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Completed, In‑Progress)."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the audit (e.g., Metered, Estimated)."
  measures:
    - name: "total_apparent_losses_mg"
      expr: SUM(CAST(apparent_losses_mg AS DOUBLE))
      comment: "Total apparent water losses (mg) across the selected period and DMA."
    - name: "total_real_losses_mg"
      expr: SUM(CAST(real_losses_mg AS DOUBLE))
      comment: "Total real water losses (mg) across the selected period and DMA."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non‑Revenue Water (NRW) percentage across records."
    - name: "total_unauthorized_consumption_mg"
      expr: SUM(CAST(unauthorized_consumption_mg AS DOUBLE))
      comment: "Total unauthorized water consumption (mg) across the selected period and DMA."
    - name: "count_balances"
      expr: COUNT(1)
      comment: "Number of NRW balance records."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow and pressure KPIs for distribution network."
  source: "`water_utilities_ecm`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the reading was taken."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., Instantaneous, Averaged)."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of the flow reading (day granularity)."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total flow volume recorded (MG) across all readings."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average pressure (psi) observed across readings."
    - name: "count_readings"
      expr: COUNT(1)
      comment: "Number of flow reading records."
    - name: "distinct_measurement_points"
      expr: COUNT(DISTINCT measurement_point_id)
      comment: "Count of unique measurement points reporting flow."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_flushing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flushing event effectiveness and volume metrics."
  source: "`water_utilities_ecm`.`distribution`.`flushing_event`"
  dimensions:
    - name: "flush_reason"
      expr: flush_reason
      comment: "Reason for the flushing event (e.g., Maintenance, Water Quality)."
    - name: "flush_status"
      expr: flush_status
      comment: "Current status of the flushing event."
    - name: "flush_month"
      expr: DATE_TRUNC('month', flush_date)
      comment: "Month of the flushing event."
  measures:
    - name: "total_volume_discharged_gallons"
      expr: SUM(CAST(volume_discharged_gallons AS DOUBLE))
      comment: "Total volume of water discharged during flushing events (gallons)."
    - name: "count_flush_events"
      expr: COUNT(1)
      comment: "Number of flushing events recorded."
    - name: "avg_flush_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of flushing events (minutes)."
    - name: "effective_flush_count"
      expr: SUM(CASE WHEN flush_effectiveness_rating = 'Effective' THEN 1 ELSE 0 END)
      comment: "Count of flushing events rated as Effective."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break impact and repair performance metrics."
  source: "`water_utilities_ecm`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the break occurred."
    - name: "break_type"
      expr: break_type
      comment: "Type of main break (e.g., Pipe rupture, Valve failure)."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break (e.g., Open, Closed)."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Month when the break was reported."
  measures:
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water loss (gallons) attributed to main breaks."
    - name: "count_breaks"
      expr: COUNT(1)
      comment: "Number of main break incidents recorded."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average repair duration for main breaks (hours)."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tank capacity and operational status KPIs."
  source: "`water_utilities_ecm`.`distribution`.`storage_tank`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the tank is located."
    - name: "tank_type"
      expr: tank_type
      comment: "Classification of tank (e.g., Elevated, Ground)."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the tank was installed."
  measures:
    - name: "total_capacity_gallons"
      expr: SUM(CAST(capacity_gallons AS DOUBLE))
      comment: "Aggregate storage capacity across tanks (gallons)."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Aggregate usable capacity across tanks (gallons)."
    - name: "count_tanks"
      expr: COUNT(1)
      comment: "Number of storage tank records."
    - name: "operational_tank_count"
      expr: SUM(CASE WHEN operational_status = 'Operational' THEN 1 ELSE 0 END)
      comment: "Count of tanks currently in operational status."
$$;