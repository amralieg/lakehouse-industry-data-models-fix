-- Metric views for domain: technology | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_broadcast_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capacity and location metrics for broadcast facilities."
  source: "`media_broadcasting_ecm`.`technology`.`broadcast_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of broadcast facility (e.g., TV, radio, satellite)."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located."
    - name: "city"
      expr: city
      comment: "City where the facility is located."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the facility record was created."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of broadcast facilities."
    - name: "avg_power_capacity_kva"
      expr: AVG(CAST(power_capacity_kva AS DOUBLE))
      comment: "Average power capacity (kVA) across facilities."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total floor area (sqm) of all facilities."
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height in meters."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning efficiency and financial exposure."
  source: "`media_broadcasting_ecm`.`technology`.`capacity_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the capacity plan."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capacity plan."
    - name: "planning_start_month"
      expr: DATE_TRUNC('month', planning_start_date)
      comment: "Month when planning started."
    - name: "planning_end_month"
      expr: DATE_TRUNC('month', planning_end_date)
      comment: "Month when planning ended."
  measures:
    - name: "avg_current_utilization_pct"
      expr: AVG(CAST(current_utilization_percentage AS DOUBLE))
      comment: "Average current utilization percentage across capacity plans."
    - name: "max_current_utilization_pct"
      expr: MAX(current_utilization_percentage)
      comment: "Maximum current utilization percentage observed."
    - name: "total_estimated_capex_usd"
      expr: SUM(CAST(estimated_capex_amount AS DOUBLE))
      comment: "Total estimated capital expenditure (USD) for capacity plans."
    - name: "plans_exceeding_threshold"
      expr: SUM(CASE WHEN capacity_threshold_percentage > 80 THEN 1 ELSE 0 END)
      comment: "Count of capacity plans where the threshold percentage exceeds 80%."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_network_circuit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network circuit performance and cost metrics."
  source: "`media_broadcasting_ecm`.`technology`.`network_circuit`"
  dimensions:
    - name: "circuit_type"
      expr: circuit_type
      comment: "Type of network circuit (e.g., fiber, microwave)."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the circuit."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the circuit."
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the circuit record was created."
  measures:
    - name: "avg_bandwidth_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth (Mbps) of network circuits."
    - name: "total_monthly_cost_usd"
      expr: SUM(CAST(monthly_recurring_cost AS DOUBLE))
      comment: "Total monthly recurring cost (USD) across circuits."
    - name: "max_utilization_percent"
      expr: MAX(average_utilization_percent)
      comment: "Maximum average utilization percent observed among circuits."
    - name: "circuits_exceeding_90_util"
      expr: SUM(CASE WHEN average_utilization_percent > 90 THEN 1 ELSE 0 END)
      comment: "Number of circuits with average utilization > 90%."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage impact and duration metrics for service reliability."
  source: "`media_broadcasting_ecm`.`technology`.`outage_record`"
  dimensions:
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity level of the outage impact."
    - name: "outage_type"
      expr: outage_type
      comment: "Category/type of outage."
    - name: "month_start"
      expr: DATE_TRUNC('month', outage_start_timestamp)
      comment: "Month when the outage started."
  measures:
    - name: "total_outage_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total outage duration in minutes across all records."
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact (USD) from outages."
    - name: "avg_viewer_impact"
      expr: AVG(CAST(affected_viewer_count_estimate AS DOUBLE))
      comment: "Average estimated number of viewers affected per outage."
    - name: "outage_count"
      expr: COUNT(1)
      comment: "Number of outage records."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_sla_performance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance and performance metrics."
  source: "`media_broadcasting_ecm`.`technology`.`sla_performance_record`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of SLA breach."
    - name: "month_measure_start"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of the measurement period start."
  measures:
    - name: "avg_measured_availability_pct"
      expr: AVG(CAST(measured_availability_percentage AS DOUBLE))
      comment: "Average measured availability percentage across SLA records."
    - name: "total_breach_count"
      expr: SUM(CASE WHEN breach_flag THEN 1 ELSE 0 END)
      comment: "Total number of SLA breaches recorded."
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(actual_mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair (minutes) for SLA incidents."
    - name: "total_service_credit_usd"
      expr: SUM(CAST(service_credit_amount AS DOUBLE))
      comment: "Total service credit amount (USD) awarded due to SLA breaches."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`technology_tech_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status overview of technology projects."
  source: "`media_broadcasting_ecm`.`technology`.`tech_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the technology project."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the project."
    - name: "project_type"
      expr: project_type
      comment: "Category/type of the technology project."
  measures:
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budget allocated to technology projects (USD)."
    - name: "total_spend_to_date_usd"
      expr: SUM(CAST(spend_to_date_usd AS DOUBLE))
      comment: "Total spend to date across all technology projects (USD)."
    - name: "avg_budget_variance_usd"
      expr: AVG(CAST(budget_variance_usd AS DOUBLE))
      comment: "Average budget variance (USD) across projects."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of technology projects."
$$;