-- Metric views for domain: outage | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_reliability_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key reliability performance indicators (SAIDI, SAIFI, CAIDI, MAIFI) per reporting period for executive oversight"
  source: "`energy_utilities_ecm`.`outage`.`reliability_index_period`"
  dimensions:
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the reporting period start"
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (e.g., monthly, annual)"
    - name: "reporting_entity_name"
      expr: reporting_entity_name
      comment: "Entity reporting the reliability metrics"
  measures:
    - name: "total_saidi_minutes"
      expr: SUM(CAST(saidi_minutes AS DOUBLE))
      comment: "Total SAIDI minutes across the reporting period"
    - name: "average_saifi_index"
      expr: AVG(CAST(saifi_index AS DOUBLE))
      comment: "Average SAIFI index for the period"
    - name: "total_caidi_minutes"
      expr: SUM(CAST(caidi_minutes AS DOUBLE))
      comment: "Total CAIDI minutes across the reporting period"
    - name: "average_maifi_index"
      expr: AVG(CAST(maifi_index AS DOUBLE))
      comment: "Average MAIFI index for the period"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of reliability index records (baseline)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level outage event performance metrics for operational and strategic review"
  source: "`energy_utilities_ecm`.`outage`.`event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the event record was created"
    - name: "event_type"
      expr: event_type
      comment: "Classification of the outage event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "is_major_event_day"
      expr: is_major_event_day
      comment: "Flag indicating a major event day"
    - name: "is_storm_event"
      expr: is_storm_event
      comment: "Flag indicating the event is storm‑related"
  measures:
    - name: "total_energy_not_served_mwh"
      expr: SUM(CAST(energy_not_served_mwh AS DOUBLE))
      comment: "Total megawatt‑hours of energy not served due to outages"
    - name: "total_customer_minutes_interrupted"
      expr: SUM(CAST(customer_minutes_interrupted AS DOUBLE))
      comment: "Aggregate customer interruption minutes"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of outage events (baseline)"
    - name: "average_restoration_time_minutes"
      expr: AVG(UNIX_TIMESTAMP(estimated_restoration_timestamp) - UNIX_TIMESTAMP(detection_timestamp)) / 60.0
      comment: "Average time from detection to estimated restoration in minutes"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_interruption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational interruption metrics to monitor duration and critical‑care impact"
  source: "`energy_utilities_ecm`.`outage`.`interruption`"
  dimensions:
    - name: "interruption_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the interruption started"
    - name: "interruption_type"
      expr: interruption_type
      comment: "Type of interruption (e.g., sustained, momentary)"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag for critical‑care customers"
    - name: "interruption_status"
      expr: interruption_status
      comment: "Current status of the interruption"
  measures:
    - name: "total_interruption_duration_minutes"
      expr: SUM(UNIX_TIMESTAMP(end_timestamp) - UNIX_TIMESTAMP(start_timestamp)) / 60.0
      comment: "Total interruption duration in minutes across all records"
    - name: "interruption_count"
      expr: COUNT(1)
      comment: "Number of interruption records (baseline)"
    - name: "critical_care_interruption_count"
      expr: SUM(CASE WHEN is_critical_care THEN 1 ELSE 0 END)
      comment: "Count of interruptions flagged as critical‑care"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_crew_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew dispatch efficiency metrics to support operational performance management"
  source: "`energy_utilities_ecm`.`outage`.`crew_dispatch`"
  dimensions:
    - name: "dispatch_date"
      expr: DATE_TRUNC('day', dispatched_at)
      comment: "Date the crew was dispatched"
    - name: "crew_type"
      expr: crew_type
      comment: "Type/category of crew dispatched"
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch"
    - name: "service_territory_code"
      expr: service_territory_code
      comment: "Geographic service territory"
  measures:
    - name: "average_response_time_minutes"
      expr: AVG(UNIX_TIMESTAMP(actual_arrival_at) - UNIX_TIMESTAMP(dispatched_at)) / 60.0
      comment: "Average crew response time from dispatch to arrival in minutes"
    - name: "average_restoration_time_minutes"
      expr: AVG(UNIX_TIMESTAMP(actual_restoration_at) - UNIX_TIMESTAMP(actual_arrival_at)) / 60.0
      comment: "Average time from crew arrival to restoration in minutes"
    - name: "dispatch_count"
      expr: COUNT(1)
      comment: "Number of crew dispatches (baseline)"
$$;