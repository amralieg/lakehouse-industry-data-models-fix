-- Metric views for domain: demand | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for demand response events"
  source: "`energy_utilities_ecm`.`demand`.`dr_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of DR event (e.g., emergency, economic)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "market_product_type"
      expr: market_product_type
      comment: "Market product associated with the event"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the event"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier for the event"
    - name: "event_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of event creation"
  measures:
    - name: "total_dr_events"
      expr: COUNT(1)
      comment: "Total number of demand response events recorded"
    - name: "total_actual_curtailment_mw"
      expr: SUM(CAST(actual_curtailment_mw AS DOUBLE))
      comment: "Sum of actual curtailment (MW) across all events"
    - name: "total_target_curtailment_mw"
      expr: SUM(CAST(target_curtailment_mw AS DOUBLE))
      comment: "Sum of target curtailment (MW) planned for events"
    - name: "total_incentive_payment_usd"
      expr: SUM(CAST(total_incentive_payment AS DOUBLE))
      comment: "Total incentive payments (USD) awarded for events"
    - name: "average_performance_ratio"
      expr: AVG(CAST(performance_ratio AS DOUBLE))
      comment: "Average performance ratio across events"
    - name: "average_settlement_price_usd_per_mwh"
      expr: AVG(CAST(settlement_price AS DOUBLE))
      comment: "Average settlement price (USD/MWh) for events"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that track demand response enrollment health and capacity"
  source: "`energy_utilities_ecm`.`demand`.`dr_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment"
    - name: "enrollment_source_system"
      expr: enrollment_source_system
      comment: "Source system that created the enrollment"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment was obtained"
    - name: "telemetry_enabled_flag"
      expr: telemetry_enabled_flag
      comment: "Flag indicating if telemetry is enabled for the enrollment"
    - name: "capacity_market_participation_flag"
      expr: capacity_market_participation_flag
      comment: "Indicates participation in capacity markets"
    - name: "enrollment_effective_date"
      expr: DATE_TRUNC('day', enrollment_effective_date)
      comment: "Effective date of the enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of demand response enrollments"
    - name: "total_enrolled_capacity_kw"
      expr: SUM(CAST(enrolled_load_capacity_kw AS DOUBLE))
      comment: "Sum of enrolled load capacity (kW) across all enrollments"
    - name: "total_incentive_payments_usd"
      expr: SUM(CAST(total_incentive_payments_usd AS DOUBLE))
      comment: "Total incentive payments (USD) promised to enrollments"
    - name: "average_participation_rate_percent"
      expr: AVG(CAST(participation_rate_percent AS DOUBLE))
      comment: "Average participation rate percent across enrollments"
    - name: "average_enrollment_capacity_kw"
      expr: AVG(CAST(enrolled_load_capacity_kw AS DOUBLE))
      comment: "Average enrolled capacity per enrollment (kW)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_incentive_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial outcomes of demand response incentive payments"
  source: "`energy_utilities_ecm`.`demand`.`dr_incentive_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., paid, pending)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., incentive, penalty)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the payment"
    - name: "payment_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the payment record was created"
  measures:
    - name: "total_incentive_payments"
      expr: COUNT(1)
      comment: "Total number of incentive payment records"
    - name: "total_gross_payment_usd"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Sum of gross incentive payments (USD)"
    - name: "total_net_payment_usd"
      expr: SUM(CAST(customer_net_payment_amount AS DOUBLE))
      comment: "Sum of net payments to customers (USD)"
    - name: "total_penalty_deduction_usd"
      expr: SUM(CAST(penalty_deduction_amount AS DOUBLE))
      comment: "Total penalty deductions (USD) applied"
    - name: "total_performance_bonus_usd"
      expr: SUM(CAST(performance_bonus_amount AS DOUBLE))
      comment: "Total performance bonuses (USD) awarded"
    - name: "average_aggregator_share_percentage"
      expr: AVG(CAST(aggregator_share_percentage AS DOUBLE))
      comment: "Average aggregator share percentage across payments"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_curtailment_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for curtailment measurement data"
  source: "`energy_utilities_ecm`.`demand`.`curtailment_measurement`"
  dimensions:
    - name: "measurement_status_code"
      expr: measurement_status_code
      comment: "Status code of the measurement"
    - name: "data_quality_code"
      expr: data_quality_code
      comment: "Data quality classification"
    - name: "reported_to_iso_flag"
      expr: reported_to_iso_flag
      comment: "Flag indicating if measurement was reported to ISO"
    - name: "reported_to_puc_flag"
      expr: reported_to_puc_flag
      comment: "Flag indicating if measurement was reported to PUC"
    - name: "interval_start_date"
      expr: DATE_TRUNC('day', interval_start_timestamp)
      comment: "Date of interval start"
  measures:
    - name: "total_curtailment_measurements"
      expr: COUNT(1)
      comment: "Total number of curtailment measurement records"
    - name: "total_curtailment_kw"
      expr: SUM(CAST(curtailment_kw AS DOUBLE))
      comment: "Sum of curtailment power (kW) measured"
    - name: "total_curtailment_kwh"
      expr: SUM(CAST(curtailment_kwh AS DOUBLE))
      comment: "Sum of curtailment energy (kWh) measured"
    - name: "total_incentive_amount_usd"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount (USD) associated with measurements"
    - name: "average_performance_ratio"
      expr: AVG(CAST(performance_ratio AS DOUBLE))
      comment: "Average performance ratio across measurements"
    - name: "total_settlement_quantity_kw"
      expr: SUM(CAST(settlement_quantity_kw AS DOUBLE))
      comment: "Sum of settlement quantity (kW) for measurements"
    - name: "reported_to_iso_count"
      expr: SUM(CASE WHEN reported_to_iso_flag THEN 1 ELSE 0 END)
      comment: "Count of measurements reported to ISO"
$$;