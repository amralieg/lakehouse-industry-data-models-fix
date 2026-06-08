-- Metric views for domain: metering | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_ami_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AMI event KPIs for revenue risk and reverse flow monitoring"
  source: "`energy_utilities_ecm`.`metering`.`ami_event`"
  dimensions:
    - name: "event_type_code"
      expr: event_type_code
      comment: "AMI event type code"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the AMI event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the AMI event"
  measures:
    - name: "ami_event_count"
      expr: COUNT(1)
      comment: "Number of AMI events recorded"
    - name: "total_estimated_unbilled_consumption_kwh"
      expr: SUM(CAST(estimated_unbilled_consumption_kwh AS DOUBLE))
      comment: "Total estimated unbilled consumption (kWh) from AMI events"
    - name: "total_revenue_recovery_amount"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovery amount associated with AMI events"
    - name: "total_reverse_flow_kwh"
      expr: SUM(CAST(reverse_flow_kwh AS DOUBLE))
      comment: "Total reverse flow energy (kWh) captured in AMI events"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_meter_read`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated consumption and usage metrics from meter reads"
  source: "`energy_utilities_ecm`.`metering`.`meter_read`"
  dimensions:
    - name: "read_date"
      expr: DATE_TRUNC('day', read_date)
      comment: "Date of the meter read"
  measures:
    - name: "meter_read_count"
      expr: COUNT(1)
      comment: "Number of meter reads recorded"
    - name: "total_consumption_kwh"
      expr: SUM(CAST(consumption_kwh AS DOUBLE))
      comment: "Total consumption (kWh) reported by meter reads"
    - name: "avg_daily_usage"
      expr: AVG(CAST(average_daily_usage AS DOUBLE))
      comment: "Average daily usage (kWh) per meter read"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_interval_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interval reading volume and quality metrics"
  source: "`energy_utilities_ecm`.`metering`.`interval_reading`"
  dimensions:
    - name: "channel_number"
      expr: channel_number
      comment: "Channel number for the interval reading"
    - name: "interval_date"
      expr: DATE_TRUNC('day', interval_end_timestamp)
      comment: "Date of the interval reading"
  measures:
    - name: "interval_reading_count"
      expr: COUNT(1)
      comment: "Number of interval readings captured"
    - name: "total_reading_value"
      expr: SUM(CAST(reading_value AS DOUBLE))
      comment: "Sum of interval reading values (kWh)"
    - name: "avg_reading_value"
      expr: AVG(CAST(reading_value AS DOUBLE))
      comment: "Average interval reading value (kWh)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_net_energy_metering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core capacity and balance metrics for net energy metering programs"
  source: "`energy_utilities_ecm`.`metering`.`net_energy_metering`"
  dimensions:
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of net energy metering application"
    - name: "obligation_id"
      expr: obligation_id
      comment: "Obligation identifier linked to the metering record"
  measures:
    - name: "net_energy_metering_count"
      expr: COUNT(1)
      comment: "Number of net energy metering records"
    - name: "total_banking_balance_kwh"
      expr: SUM(CAST(banking_balance_kwh AS DOUBLE))
      comment: "Total banking balance (kWh) across net energy meters"
    - name: "total_nameplate_capacity_kw"
      expr: SUM(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Total nameplate capacity (kW) of net energy meters"
    - name: "total_export_capacity_limit_kw"
      expr: SUM(CAST(export_capacity_limit_kw AS DOUBLE))
      comment: "Total export capacity limit (kW) for net energy meters"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_tou_rate_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic TOU program impact metrics for demand management"
  source: "`energy_utilities_ecm`.`metering`.`tou_rate_program`"
  dimensions:
    - name: "program_name"
      expr: program_name
      comment: "Name of the TOU rate program"
    - name: "program_type"
      expr: program_type
      comment: "Type/category of the TOU program"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the TOU program became effective"
  measures:
    - name: "tou_rate_program_count"
      expr: COUNT(1)
      comment: "Number of TOU rate program records"
    - name: "total_estimated_annual_savings_kwh"
      expr: SUM(CAST(estimated_annual_savings_kwh AS DOUBLE))
      comment: "Total estimated annual energy savings (kWh) from TOU programs"
    - name: "total_estimated_annual_cost_savings_usd"
      expr: SUM(CAST(estimated_annual_cost_savings_usd AS DOUBLE))
      comment: "Total estimated annual cost savings (USD) from TOU programs"
$$;