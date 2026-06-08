-- Metric views for domain: demand | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for demand response events, focusing on curtailment and incentive outcomes."
  source: "`energy_utilities_ecm`.`demand`.`dr_event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', actual_start_timestamp)
      comment: "Date of the DR event start"
    - name: "dr_program_id"
      expr: dr_program_id
      comment: "Demand response program identifier"
    - name: "aggregator_id"
      expr: aggregator_id
      comment: "Aggregator responsible for the event"
    - name: "event_type"
      expr: event_type
      comment: "Type of DR event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the DR event"
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of DR events"
    - name: "total_curtailed_mw"
      expr: SUM(CAST(actual_curtailment_mw AS DOUBLE))
      comment: "Total curtailed megawatts across events"
    - name: "avg_curtailed_mw"
      expr: AVG(CAST(actual_curtailment_mw AS DOUBLE))
      comment: "Average curtailed megawatts per event"
    - name: "total_incentive_payment"
      expr: SUM(CAST(total_incentive_payment AS DOUBLE))
      comment: "Total incentive payments awarded for events"
    - name: "avg_incentive_payment"
      expr: AVG(CAST(total_incentive_payment AS DOUBLE))
      comment: "Average incentive payment per event"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_event_participant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participant-level performance and curtailment metrics for demand response events."
  source: "`energy_utilities_ecm`.`demand`.`dr_event_participant`"
  dimensions:
    - name: "event_id"
      expr: dr_event_id
      comment: "Associated DR event identifier"
    - name: "account_id"
      expr: account_id
      comment: "Customer account participating"
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant (e.g., residential, commercial)"
    - name: "response_classification"
      expr: response_classification
      comment: "Classification of participant response"
    - name: "opt_out_timestamp"
      expr: opt_out_timestamp
      comment: "Timestamp when participant opted out (null if not opted out)"
  measures:
    - name: "participant_count"
      expr: COUNT(1)
      comment: "Number of participant records"
    - name: "total_measured_curtailment_kw"
      expr: SUM(CAST(measured_curtailment_kw AS DOUBLE))
      comment: "Total measured curtailment in kilowatts"
    - name: "avg_measured_curtailment_kw"
      expr: AVG(CAST(measured_curtailment_kw AS DOUBLE))
      comment: "Average measured curtailment per participant"
    - name: "total_incentive_payment"
      expr: SUM(CAST(incentive_payment_amount AS DOUBLE))
      comment: "Total incentive payments to participants"
    - name: "avg_incentive_payment"
      expr: AVG(CAST(incentive_payment_amount AS DOUBLE))
      comment: "Average incentive payment per participant"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_incentive_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement metrics for demand response incentive payments."
  source: "`energy_utilities_ecm`.`demand`.`dr_incentive_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "dr_program_id"
      expr: dr_program_id
      comment: "Demand response program identifier"
    - name: "aggregator_id"
      expr: aggregator_id
      comment: "Aggregator receiving the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, check)"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of incentive payment records"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross payment amount before deductions"
    - name: "total_penalty_deduction_amount"
      expr: SUM(CAST(penalty_deduction_amount AS DOUBLE))
      comment: "Total penalties deducted from payments"
    - name: "total_performance_bonus_amount"
      expr: SUM(CAST(performance_bonus_amount AS DOUBLE))
      comment: "Total performance bonuses added to payments"
    - name: "net_payment_amount"
      expr: SUM(gross_payment_amount - penalty_deduction_amount - performance_bonus_amount)
      comment: "Net payment after penalties and bonuses"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`demand_dr_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment and capacity commitment metrics for demand response participants."
  source: "`energy_utilities_ecm`.`demand`.`demand_dr_enrollment`"
  dimensions:
    - name: "dr_program_id"
      expr: dr_program_id
      comment: "Demand response program identifier"
    - name: "aggregator_id"
      expr: aggregator_id
      comment: "Aggregator managing the enrollment"
    - name: "telemetry_enabled_flag"
      expr: telemetry_enabled_flag
      comment: "Indicates if telemetry is enabled for the enrollment"
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of demand response enrollments"
$$;