-- Metric views for domain: automation | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`automation_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alarm performance indicators for operational reliability and safety"
  source: "`manufacturing_ecm`.`automation`.`alarm_event`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm (e.g., Safety, Equipment)"
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of alarm events recorded"
    - name: "critical_alarms"
      expr: SUM(CASE WHEN alarm_severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of alarms with Critical severity"
    - name: "avg_process_value"
      expr: AVG(CAST(process_value AS DOUBLE))
      comment: "Average process value at the time of alarm"
    - name: "avg_setpoint_value"
      expr: AVG(CAST(setpoint_value AS DOUBLE))
      comment: "Average setpoint value associated with alarms"
    - name: "acknowledged_alarms"
      expr: SUM(CASE WHEN acknowledged_by IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of alarms that have been acknowledged"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`automation_batch_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production efficiency and quality metrics for batch manufacturing"
  source: "`manufacturing_ecm`.`automation`.`batch_execution`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g., Standard, Custom)"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch executions"
    - name: "avg_batch_yield_pct"
      expr: AVG(CAST(batch_yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage across executions"
    - name: "total_energy_kwh"
      expr: SUM(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption (kWh) for all batches"
    - name: "avg_cycle_time_sec"
      expr: AVG(CAST(batch_cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time per batch in seconds"
    - name: "avg_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batches"
    - name: "quality_passed_batches"
      expr: SUM(CASE WHEN quality_check_passed THEN 1 ELSE 0 END)
      comment: "Number of batches that passed quality checks"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`automation_control_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and risk metrics for control system assets"
  source: "`manufacturing_ecm`.`automation`.`control_system`"
  dimensions:
    - name: "system_type"
      expr: system_type
      comment: "Type/category of the control system"
  measures:
    - name: "total_control_systems"
      expr: COUNT(1)
      comment: "Total number of control systems in the portfolio"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (hours)"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (hours)"
    - name: "critical_systems"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Number of control systems marked as critical"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`automation_device_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inventory and capacity overview for devices"
  source: "`manufacturing_ecm`.`automation`.`device_registry`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Classification of the device (e.g., PLC, Sensor)"
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total count of registered devices"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating (kW) of devices"
$$;