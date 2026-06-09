-- Metric views for domain: instrument | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key asset inventory and financial metrics for instruments."
  source: "`genomics_biotech_ecm`.`instrument`.`asset`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument (e.g., sequencer, PCR)."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, decommissioned, maintenance)."
    - name: "acquisition_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year of acquisition."
    - name: "warranty_expiry_year"
      expr: DATE_TRUNC('year', warranty_expiry_date)
      comment: "Year warranty expires."
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of instrument assets."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all assets."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset."
    - name: "total_uptime_hours"
      expr: SUM(CAST(total_uptime_hours AS DOUBLE))
      comment: "Cumulative uptime hours across all assets."
    - name: "avg_uptime_hours"
      expr: AVG(CAST(total_uptime_hours AS DOUBLE))
      comment: "Average uptime hours per asset."
    - name: "avg_runtime_hours"
      expr: AVG(CAST(run_time_hours AS DOUBLE))
      comment: "Average runtime hours per asset."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational performance metrics for sequencing runs."
  source: "`genomics_biotech_ecm`.`instrument`.`instrument_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the run."
    - name: "run_type"
      expr: run_type
      comment: "Type of sequencing run (e.g., WGS, RNA-Seq)."
    - name: "run_month"
      expr: DATE_TRUNC('month', scheduled_start_timestamp)
      comment: "Month of the scheduled start."
  measures:
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of instrument runs."
    - name: "total_reads_generated"
      expr: SUM(CAST(total_reads_generated AS DOUBLE))
      comment: "Total reads generated across runs."
    - name: "total_yield_gb"
      expr: SUM(CAST(total_yield_gb AS DOUBLE))
      comment: "Total data yield in GB."
    - name: "avg_error_rate"
      expr: AVG(CAST(error_rate AS DOUBLE))
      comment: "Average sequencing error rate."
    - name: "avg_cluster_density"
      expr: AVG(CAST(cluster_density AS DOUBLE))
      comment: "Average cluster density."
    - name: "avg_percent_q30_bases"
      expr: AVG(CAST(percent_q30_bases AS DOUBLE))
      comment: "Average % of bases with Q30 quality."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration quality and activity metrics."
  source: "`genomics_biotech_ecm`.`instrument`.`calibration_record`"
  dimensions:
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of calibration (completed, pending)."
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed."
    - name: "is_active"
      expr: is_active
      comment: "Whether the calibration record is active."
    - name: "calibration_year"
      expr: DATE_TRUNC('year', calibration_date)
      comment: "Year of calibration."
  measures:
    - name: "calibration_count"
      expr: COUNT(1)
      comment: "Number of calibration records."
    - name: "avg_deviation_from_standard"
      expr: AVG(CAST(deviation_from_standard AS DOUBLE))
      comment: "Average deviation from standard."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value."
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of passed calibrations."
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_result = 'Fail' THEN 1 ELSE 0 END)
      comment: "Count of failed calibrations."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_performance_telemetry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry health and performance indicators."
  source: "`genomics_biotech_ecm`.`instrument`.`performance_telemetry`"
  dimensions:
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the telemetry metric."
    - name: "metric_type"
      expr: metric_type
      comment: "Type/category of metric."
    - name: "asset_id"
      expr: asset_id
      comment: "Instrument asset identifier."
    - name: "telemetry_date"
      expr: DATE_TRUNC('day', telemetry_timestamp)
      comment: "Date of telemetry record."
  measures:
    - name: "telemetry_record_count"
      expr: COUNT(1)
      comment: "Number of telemetry records."
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average value of the metric."
    - name: "avg_anomaly_score"
      expr: AVG(CAST(anomaly_detection_score AS DOUBLE))
      comment: "Average anomaly detection score."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_field_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and cost metrics for field service activities."
  source: "`genomics_biotech_ecm`.`instrument`.`field_service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of field service request."
    - name: "priority"
      expr: priority
      comment: "Priority level of the request."
    - name: "status"
      expr: field_service_request_status
      comment: "Current status of the request."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of request."
  measures:
    - name: "request_count"
      expr: COUNT(1)
      comment: "Total number of field service requests."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost in USD."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration in hours."
    - name: "billable_request_count"
      expr: SUM(CASE WHEN billable_flag THEN 1 ELSE 0 END)
      comment: "Count of billable requests."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance in km."
    - name: "sla_compliance_count"
      expr: SUM(CASE WHEN sla_compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of SLA compliant requests."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and SLA metrics for instrument service contracts."
  source: "`genomics_biotech_ecm`.`instrument`.`service_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the service contract."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., subscription, perpetual)."
    - name: "service_provider"
      expr: service_provider
      comment: "Provider of the service contract."
    - name: "start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year contract started."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of service contracts."
    - name: "total_annual_value_usd"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual contract value in USD."
    - name: "avg_uptime_guarantee_percent"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee percentage."
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active contracts."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product portfolio and reliability metrics for instrument models."
  source: "`genomics_biotech_ecm`.`instrument`.`model`"
  dimensions:
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Instrument type."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation."
    - name: "launch_year"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year of product launch."
  measures:
    - name: "model_count"
      expr: COUNT(1)
      comment: "Number of instrument models."
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price in USD."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average mean time between failures (hours)."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average mean time to repair (hours)."
$$;