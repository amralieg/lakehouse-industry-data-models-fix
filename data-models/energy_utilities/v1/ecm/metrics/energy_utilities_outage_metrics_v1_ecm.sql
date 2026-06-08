-- Metric views for domain: outage | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core outage event KPIs for operational and strategic monitoring"
  source: "`energy_utilities_ecm`.`outage`.`event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of event occurrence"
    - name: "event_type"
      expr: event_type
      comment: "Type of outage event (e.g., planned, unplanned)"
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code of the outage"
    - name: "is_major_event_day"
      expr: is_major_event_day
      comment: "Flag indicating if the event occurred on a major event day"
    - name: "is_storm_event"
      expr: is_storm_event
      comment: "Flag indicating if the event is storm related"
  measures:
    - name: "total_interruption_minutes"
      expr: SUM(CAST(saidi_contribution_minutes AS DOUBLE))
      comment: "Total interruption minutes (SAIDI contribution) across events"
    - name: "total_customers_affected"
      expr: SUM(CAST(saifi_contribution AS DOUBLE))
      comment: "Total customers affected (SAIFI contribution) across events"
    - name: "avg_interruption_minutes_per_event"
      expr: AVG(CAST(saidi_contribution_minutes AS DOUBLE))
      comment: "Average interruption minutes per event"
    - name: "avg_customers_affected_per_event"
      expr: AVG(CAST(saifi_contribution AS DOUBLE))
      comment: "Average customers affected per event"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of outage events"
    - name: "major_event_count"
      expr: SUM(CASE WHEN is_major_event_day THEN 1 ELSE 0 END)
      comment: "Count of major events"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`outage_reliability_index_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability index period metrics required for regulatory reporting and performance tracking"
  source: "`energy_utilities_ecm`.`outage`.`reliability_index_period`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reliability reporting period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reliability reporting period"
    - name: "period_type"
      expr: period_type
      comment: "Type of period (e.g., monthly, quarterly, annual)"
    - name: "reporting_entity_name"
      expr: reporting_entity_name
      comment: "Name of the reporting utility or entity"
    - name: "reporting_entity_code"
      expr: reporting_entity_code
      comment: "Code identifying the reporting entity"
  measures:
    - name: "saifi_index"
      expr: SUM(CAST((saifi_index) AS DOUBLE))
      comment: "System Average Interruption Frequency Index for the period"
    - name: "said_minutes"
      expr: SUM(CAST((saidi_minutes) AS DOUBLE))
      comment: "System Average Interruption Duration Index (minutes) for the period"
    - name: "caidi_minutes"
      expr: SUM(CAST((caidi_minutes) AS DOUBLE))
      comment: "Customer Average Interruption Duration Index (minutes) for the period"
    - name: "total_customer_minutes_interrupted"
      expr: SUM(CAST((total_customer_minutes_interrupted) AS DOUBLE))
      comment: "Total customer minutes interrupted in the period"
    - name: "puc_saifi_performance_target"
      expr: SUM(CAST((puc_saifi_performance_target) AS DOUBLE))
      comment: "PUC SAIFI performance target for the period"
    - name: "puc_saidi_performance_target"
      expr: SUM(CAST((puc_saidi_performance_target) AS DOUBLE))
      comment: "PUC SAIDI performance target for the period"
$$;