-- Metric views for domain: automation | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for industrial alarm events — tracks alarm frequency, duration, nuisance ratio, and acknowledgement latency to drive alarm rationalisation and operator response improvement."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_event`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm (e.g. process, safety, equipment) for grouping alarm performance by type."
    - name: "alarm_priority"
      expr: alarm_priority
      comment: "Priority level of the alarm (e.g. critical, high, medium, low) — key driver of operator response SLA."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity classification of the alarm event, used to stratify risk exposure."
    - name: "alarm_state"
      expr: alarm_state
      comment: "Current state of the alarm (active, acknowledged, cleared) for real-time operational monitoring."
    - name: "is_nuisance"
      expr: is_nuisance
      comment: "Flag indicating whether the alarm is classified as a nuisance alarm — drives rationalisation backlog."
    - name: "alarm_source_system"
      expr: alarm_source_system
      comment: "Source system that generated the alarm, enabling cross-system alarm benchmarking."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Calendar day of the alarm event for daily trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Calendar month of the alarm event for monthly KPI reporting."
  measures:
    - name: "total_alarm_events"
      expr: COUNT(1)
      comment: "Total number of alarm events fired — primary volume KPI for alarm load assessment."
    - name: "nuisance_alarm_count"
      expr: COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END)
      comment: "Count of alarms classified as nuisance — high nuisance counts indicate poor alarm rationalisation and operator fatigue risk."
    - name: "nuisance_alarm_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarm events that are nuisance alarms — EEMUA 191 target is below 5%; high rates drive operator desensitisation."
    - name: "avg_alarm_duration_seconds"
      expr: AVG(CAST(alarm_duration_seconds AS DOUBLE))
      comment: "Average duration of alarm events in seconds — prolonged alarms indicate unresolved process deviations or operator response gaps."
    - name: "total_alarm_duration_seconds"
      expr: SUM(CAST(alarm_duration_seconds AS DOUBLE))
      comment: "Total cumulative alarm duration in seconds — reflects overall process instability burden on operations."
    - name: "unacknowledged_alarm_count"
      expr: COUNT(CASE WHEN acknowledged_by IS NULL THEN 1 END)
      comment: "Count of alarm events with no acknowledgement recorded — unacknowledged alarms represent safety and compliance exposure."
    - name: "distinct_devices_alarming"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices that generated alarm events — high counts indicate systemic equipment health issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPIs for the alarm definition library — tracks rationalisation progress, lifecycle health, and setpoint configuration quality to support ISA-18.2 / EEMUA 191 compliance."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_definition`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm definition (process, safety, equipment) for rationalisation segmentation."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm (e.g. high, low, deviation) for configuration quality analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the alarm definition (active, deprecated, under review) — drives governance backlog."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the alarm definition — used to assess priority distribution compliance."
    - name: "process_area"
      expr: process_area
      comment: "Plant process area associated with the alarm definition for area-level rationalisation tracking."
    - name: "shelving_allowed"
      expr: shelving_allowed
      comment: "Whether the alarm can be shelved by operators — relevant for safety compliance audits."
    - name: "auto_reset"
      expr: auto_reset
      comment: "Whether the alarm auto-resets — auto-reset alarms require special rationalisation scrutiny."
    - name: "last_reviewed_month"
      expr: DATE_TRUNC('month', last_reviewed_date)
      comment: "Month of last alarm definition review — used to identify stale definitions overdue for rationalisation."
  measures:
    - name: "total_alarm_definitions"
      expr: COUNT(1)
      comment: "Total number of alarm definitions in the library — baseline for rationalisation scope assessment."
    - name: "active_alarm_definitions"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Count of alarm definitions in active lifecycle status — represents current operational alarm footprint."
    - name: "shelving_allowed_count"
      expr: COUNT(CASE WHEN shelving_allowed = TRUE THEN 1 END)
      comment: "Number of alarm definitions where shelving is permitted — high counts may indicate safety governance gaps."
    - name: "auto_reset_alarm_count"
      expr: COUNT(CASE WHEN auto_reset = TRUE THEN 1 END)
      comment: "Count of alarms configured to auto-reset — auto-reset alarms can mask recurring process issues."
    - name: "avg_setpoint_value"
      expr: AVG(CAST(setpoint_value AS DOUBLE))
      comment: "Average setpoint value across alarm definitions — used for configuration benchmarking and outlier detection."
    - name: "avg_deadband"
      expr: AVG(CAST(deadband AS DOUBLE))
      comment: "Average deadband configured across alarm definitions — inadequate deadband causes chattering alarms."
    - name: "acknowledgment_required_count"
      expr: COUNT(CASE WHEN acknowledgment_required = TRUE THEN 1 END)
      comment: "Count of alarm definitions requiring operator acknowledgement — critical for safety compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_batch_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing batch performance KPIs — tracks yield, OEE, energy consumption, quality pass rates, and cycle time to drive continuous improvement in batch manufacturing operations."
  source: "`vibe_manufacturing_v1`.`automation`.`batch_execution`"
  dimensions:
    - name: "batch_execution_status"
      expr: batch_execution_status
      comment: "Execution status of the batch (completed, aborted, in-progress) for performance segmentation."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (production, trial, cleaning) for comparative performance analysis."
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Final disposition of the batch (released, rejected, rework) — key quality outcome dimension."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the batch execution — drives quality yield and rejection rate KPIs."
    - name: "quality_check_passed"
      expr: quality_check_passed
      comment: "Boolean indicating whether the batch passed quality checks — primary quality gate outcome."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area where the batch was executed — enables area-level performance benchmarking."
    - name: "batch_start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the batch started — for monthly production performance trending."
    - name: "maintenance_flag"
      expr: maintenance_flag
      comment: "Flag indicating a maintenance event occurred during the batch — correlates maintenance with yield loss."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch executions — baseline production volume KPI."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches passing quality checks — primary quality yield KPI; below target triggers process investigation."
    - name: "avg_batch_yield_pct"
      expr: AVG(CAST(batch_yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage — core manufacturing efficiency KPI; declining yield drives raw material cost increases."
    - name: "total_actual_yield"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity across all batches — primary production output volume measure."
    - name: "total_target_yield"
      expr: SUM(CAST(target_yield_quantity AS DOUBLE))
      comment: "Total target yield quantity — used as denominator for yield attainment rate calculations."
    - name: "yield_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_yield_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_yield_quantity AS DOUBLE)), 0), 2)
      comment: "Actual yield as a percentage of target yield — measures production plan attainment; below 95% triggers capacity or process review."
    - name: "avg_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batches — world-class target is 85%; primary equipment productivity KPI."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across batch executions in kWh — drives energy cost and sustainability reporting."
    - name: "avg_batch_cycle_time_seconds"
      expr: AVG(CAST(batch_cycle_time_seconds AS DOUBLE))
      comment: "Average batch cycle time in seconds — increasing cycle times indicate process degradation or equipment issues."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(batch_scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all batches — directly impacts material cost and sustainability targets."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(batch_co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions from batch executions in kg — critical for ESG reporting and emissions reduction targets."
    - name: "total_water_usage_liters"
      expr: SUM(CAST(batch_water_usage_liters AS DOUBLE))
      comment: "Total water consumption across batches in liters — key sustainability and operational cost KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_device_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health and fleet management KPIs for the automation device registry — tracks device lifecycle status, maintenance currency, and fleet composition to support reliability and cybersecurity governance."
  source: "`vibe_manufacturing_v1`.`automation`.`device_registry`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of automation device (PLC, sensor, actuator, HMI) for fleet segmentation."
    - name: "device_registry_status"
      expr: device_registry_status
      comment: "Operational status of the device (active, decommissioned, maintenance) for fleet health monitoring."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the device (commissioned, end-of-life, obsolete) — drives replacement planning."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the device — used to identify overdue maintenance backlog."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the device (Modbus, PROFINET, OPC-UA) — relevant for cybersecurity and interoperability planning."
    - name: "commissioning_month"
      expr: DATE_TRUNC('month', commissioning_date)
      comment: "Month the device was commissioned — used for fleet age distribution analysis."
    - name: "last_maintenance_month"
      expr: DATE_TRUNC('month', last_maintenance_date)
      comment: "Month of last maintenance activity — identifies devices with stale maintenance records."
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total number of registered automation devices — baseline fleet size KPI for capacity and licensing planning."
    - name: "active_device_count"
      expr: COUNT(CASE WHEN device_registry_status = 'active' THEN 1 END)
      comment: "Count of devices in active operational status — measures productive fleet utilisation."
    - name: "decommissioned_device_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'decommissioned' THEN 1 END)
      comment: "Count of decommissioned devices — high counts indicate fleet refresh backlog or stranded asset risk."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of registered devices in kW — used for energy capacity planning and load balancing."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power capacity of the automation device fleet in kW — drives electrical infrastructure planning."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct device suppliers in the fleet — high supplier count increases supply chain and support complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_firmware_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity and reliability KPIs for firmware update management — tracks update success rates, critical patch coverage, rollback frequency, and update cycle time to manage OT cybersecurity posture."
  source: "`vibe_manufacturing_v1`.`automation`.`firmware_update`"
  dimensions:
    - name: "update_status"
      expr: update_status
      comment: "Status of the firmware update (completed, failed, rolled-back, pending) — primary outcome dimension."
    - name: "is_critical_update"
      expr: is_critical_update
      comment: "Flag indicating whether the update addresses a critical security or reliability issue — drives prioritisation."
    - name: "device_type"
      expr: device_type
      comment: "Type of device receiving the firmware update — enables device-class update compliance tracking."
    - name: "update_method"
      expr: update_method
      comment: "Method used to deploy the firmware update (remote, manual, automated) — informs deployment strategy effectiveness."
    - name: "post_update_validation_status"
      expr: post_update_validation_status
      comment: "Validation outcome after firmware update — failed validations indicate update quality issues."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the firmware update record — used to filter active vs. historical update analysis."
    - name: "update_month"
      expr: DATE_TRUNC('month', scheduled_timestamp)
      comment: "Month the firmware update was scheduled — for monthly patch cadence and compliance reporting."
  measures:
    - name: "total_firmware_updates"
      expr: COUNT(1)
      comment: "Total number of firmware update records — baseline patch activity volume KPI."
    - name: "successful_update_count"
      expr: COUNT(CASE WHEN update_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed firmware updates — numerator for update success rate."
    - name: "update_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN update_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates that completed successfully — below 95% triggers OT change management review."
    - name: "rollback_count"
      expr: COUNT(CASE WHEN update_status = 'rolled-back' THEN 1 END)
      comment: "Count of firmware updates that required rollback — high rollback rates indicate poor pre-deployment testing."
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN update_status = 'rolled-back' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates that were rolled back — key OT change quality KPI."
    - name: "critical_update_count"
      expr: COUNT(CASE WHEN is_critical_update = TRUE THEN 1 END)
      comment: "Count of critical firmware updates — used to track security patch backlog and compliance exposure."
    - name: "avg_update_duration_seconds"
      expr: AVG(CAST(update_duration_seconds AS DOUBLE))
      comment: "Average time to complete a firmware update in seconds — long durations increase production downtime risk."
    - name: "total_update_size_mb"
      expr: SUM(CAST(update_size_mb AS DOUBLE))
      comment: "Total firmware update payload size in MB — informs network bandwidth planning for OT update campaigns."
    - name: "distinct_devices_updated"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices that received firmware updates — measures patch coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_control_mode_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational discipline KPIs for control mode events — tracks manual override frequency, safety-critical mode changes, and mode transition patterns to enforce automation discipline and reduce human-error risk."
  source: "`vibe_manufacturing_v1`.`automation`.`control_mode_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of control mode event (mode change, override, reset) for operational pattern analysis."
    - name: "new_mode"
      expr: new_mode
      comment: "The control mode transitioned to (auto, manual, cascade) — identifies manual mode prevalence."
    - name: "previous_mode"
      expr: previous_mode
      comment: "The control mode before the transition — used to analyse mode change patterns."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating whether the mode change was a manual operator override — high rates indicate automation reliability issues."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating whether the mode event involved a safety-critical control loop — drives safety compliance reporting."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity of the control mode event — used to prioritise investigation of high-severity transitions."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the control mode change — enables root cause categorisation of manual interventions."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the control mode event — for monthly operational discipline trending."
  measures:
    - name: "total_control_mode_events"
      expr: COUNT(1)
      comment: "Total number of control mode events — baseline operational intervention volume KPI."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END)
      comment: "Count of manual override events — high counts indicate automation reliability problems or operator distrust of automation."
    - name: "manual_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of control mode events that are manual overrides — target below 10%; high rates drive automation improvement investment."
    - name: "safety_critical_event_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Count of safety-critical control mode events — any increase triggers immediate safety review."
    - name: "avg_event_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of control mode events in seconds — prolonged manual modes indicate operator workload or process instability."
    - name: "total_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total cumulative duration of control mode events in seconds — measures total time spent in non-standard control modes."
    - name: "distinct_devices_with_mode_events"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices experiencing control mode events — high counts indicate systemic automation issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_setpoint_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process governance KPIs for setpoint changes — tracks change frequency, approval compliance, out-of-limits changes, and process parameter deviation to enforce process discipline and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`automation`.`setpoint_change`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Status of the setpoint change (approved, pending, rejected) — drives approval compliance monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the setpoint change — unapproved changes represent process governance violations."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean indicating whether the setpoint change was formally approved — key compliance gate."
    - name: "within_normal_limits"
      expr: within_normal_limits
      comment: "Flag indicating whether the new setpoint is within normal operating limits — out-of-limits changes require escalation."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the setpoint change — enables root cause categorisation of process adjustments."
    - name: "initiated_by_type"
      expr: initiated_by_type
      comment: "Whether the change was initiated by an operator, system, or recipe — informs automation vs. manual intervention analysis."
    - name: "change_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the setpoint change occurred — for monthly process discipline trending."
  measures:
    - name: "total_setpoint_changes"
      expr: COUNT(1)
      comment: "Total number of setpoint changes — baseline process intervention volume KPI."
    - name: "unapproved_change_count"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Count of setpoint changes made without formal approval — regulatory compliance violation indicator."
    - name: "approval_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes that were formally approved — target 100% for regulated processes; below target triggers audit."
    - name: "out_of_limits_change_count"
      expr: COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END)
      comment: "Count of setpoint changes that moved the process outside normal operating limits — high counts indicate process instability."
    - name: "out_of_limits_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes that resulted in out-of-limits conditions — key process risk KPI."
    - name: "avg_setpoint_delta"
      expr: AVG(ABS(new_setpoint_value - previous_setpoint_value))
      comment: "Average absolute magnitude of setpoint changes — large average deltas indicate aggressive process adjustments that may destabilise quality."
    - name: "distinct_parameters_changed"
      expr: COUNT(DISTINCT process_parameter_id)
      comment: "Number of distinct process parameters that received setpoint changes — breadth of process adjustment activity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_proof_test_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety instrumented system (SIS) proof test KPIs — tracks test pass rates, overdue tests, and safety integrity level compliance to meet IEC 61511 functional safety requirements."
  source: "`vibe_manufacturing_v1`.`automation`.`proof_test_record`"
  dimensions:
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the proof test (pass, fail, conditional pass) — primary safety compliance outcome dimension."
    - name: "test_type"
      expr: test_type
      comment: "Type of proof test (full, partial, bypass) — different test types have different SIL credit implications."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "Safety Integrity Level (SIL 1/2/3) of the safety function under test — drives test frequency and rigor requirements."
    - name: "proof_test_record_status"
      expr: proof_test_record_status
      comment: "Status of the proof test record (approved, pending review, rejected) — incomplete records represent compliance gaps."
    - name: "test_is_critical"
      expr: test_is_critical
      comment: "Flag indicating whether the test covers a critical safety function — critical test failures require immediate escalation."
    - name: "test_environment"
      expr: test_environment
      comment: "Environment in which the test was conducted (live plant, isolated, simulated) — affects test validity."
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the proof test was conducted — for monthly SIS compliance reporting."
  measures:
    - name: "total_proof_tests"
      expr: COUNT(1)
      comment: "Total number of proof test records — baseline SIS testing activity volume."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_result = 'pass' THEN 1 END)
      comment: "Count of proof tests with a passing result — numerator for SIS test pass rate."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proof tests that passed — below target indicates deteriorating SIS reliability and IEC 61511 compliance risk."
    - name: "test_failure_count"
      expr: COUNT(CASE WHEN test_result = 'fail' THEN 1 END)
      comment: "Count of failed proof tests — each failure requires documented corrective action and may trigger SIL re-assessment."
    - name: "overdue_tests_count"
      expr: COUNT(CASE WHEN next_test_due_date < CURRENT_DATE THEN 1 END)
      comment: "Count of safety functions with overdue proof tests — overdue tests represent direct IEC 61511 compliance violations."
    - name: "avg_test_duration_seconds"
      expr: AVG(CAST(test_duration_seconds AS DOUBLE))
      comment: "Average proof test duration in seconds — long test durations increase production downtime and scheduling complexity."
    - name: "distinct_safety_functions_tested"
      expr: COUNT(DISTINCT safety_function_id)
      comment: "Number of distinct safety functions covered by proof tests — measures SIS test coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OT change management KPIs — tracks change request volume, approval cycle times, emergency change rates, and post-change validation outcomes to govern automation system modifications safely."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_change_request`"
  dimensions:
    - name: "automation_change_request_status"
      expr: automation_change_request_status
      comment: "Current status of the change request (open, approved, implemented, closed) — primary change pipeline dimension."
    - name: "change_type"
      expr: change_type
      comment: "Type of automation change (configuration, software, hardware, parameter) — drives risk and approval routing."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority of the change request (critical, high, medium, low) — used to assess change backlog urgency."
    - name: "is_emergency_change"
      expr: is_emergency_change
      comment: "Flag indicating whether the change was classified as an emergency — high emergency rates indicate poor change planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change request — unapproved implementations represent governance violations."
    - name: "post_change_validation_status"
      expr: post_change_validation_status
      comment: "Outcome of post-implementation validation — failed validations indicate change quality issues."
    - name: "change_origin"
      expr: change_origin
      comment: "Origin of the change request (corrective, preventive, improvement, regulatory) — informs change driver analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the change request was raised — for monthly change volume trending."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of automation change requests — baseline OT change activity volume KPI."
    - name: "emergency_change_count"
      expr: COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END)
      comment: "Count of emergency change requests — high emergency change rates indicate reactive rather than planned change management."
    - name: "emergency_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests classified as emergency — target below 10%; high rates drive change planning maturity improvement."
    - name: "post_change_validation_failure_count"
      expr: COUNT(CASE WHEN post_change_validation_status = 'failed' THEN 1 END)
      comment: "Count of changes where post-implementation validation failed — indicates change quality and testing adequacy issues."
    - name: "validation_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_change_validation_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of implemented changes that failed post-change validation — key OT change quality KPI."
    - name: "distinct_control_systems_changed"
      expr: COUNT(DISTINCT control_system_id)
      comment: "Number of distinct control systems affected by change requests — measures change impact breadth across the automation estate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_fat_sat_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory Acceptance Test and Site Acceptance Test KPIs — tracks test pass rates, retest frequency, and corrective action requirements to govern automation system commissioning quality."
  source: "`vibe_manufacturing_v1`.`automation`.`fat_sat_record`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of acceptance test (FAT, SAT, IQ, OQ, PQ) — enables FAT vs SAT performance comparison."
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the acceptance test (pass, fail, conditional) — primary commissioning quality outcome."
    - name: "fat_sat_record_status"
      expr: fat_sat_record_status
      comment: "Status of the FAT/SAT record (approved, pending, rejected) — incomplete records block commissioning sign-off."
    - name: "retest_required"
      expr: retest_required
      comment: "Flag indicating whether a retest is required — high retest rates indicate poor pre-test preparation."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required following the test — drives commissioning punch list."
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the acceptance test was conducted — for commissioning project progress tracking."
  measures:
    - name: "total_fat_sat_records"
      expr: COUNT(1)
      comment: "Total number of FAT/SAT test records — baseline commissioning test activity volume."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_result = 'pass' THEN 1 END)
      comment: "Count of acceptance tests with a passing result — numerator for commissioning test pass rate."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FAT/SAT tests that passed first time — below 90% indicates commissioning quality issues that delay project handover."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Count of tests requiring a retest — high retest counts increase commissioning cost and schedule risk."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests requiring retest — key commissioning efficiency KPI."
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of tests requiring corrective action — drives commissioning punch list size and project completion risk."
    - name: "distinct_projects_tested"
      expr: COUNT(DISTINCT automation_project_id)
      comment: "Number of distinct automation projects with FAT/SAT records — measures commissioning activity breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_device_connectivity_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OT network reliability KPIs for device connectivity events — tracks connectivity loss frequency, auto-recovery rates, and communication protocol reliability to manage OT network uptime."
  source: "`vibe_manufacturing_v1`.`automation`.`device_connectivity_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of connectivity event (disconnect, reconnect, timeout, error) — primary event classification."
    - name: "device_connectivity_event_status"
      expr: device_connectivity_event_status
      comment: "Status of the connectivity event (open, resolved, escalated) — drives open incident backlog monitoring."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol involved in the connectivity event — identifies protocol-specific reliability issues."
    - name: "auto_recovery_attempted"
      expr: auto_recovery_attempted
      comment: "Flag indicating whether automatic recovery was attempted — measures automation resilience capability."
    - name: "device_model"
      expr: device_model
      comment: "Model of the device experiencing connectivity issues — identifies hardware models with reliability problems."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the connectivity event — for monthly OT network reliability trending."
  measures:
    - name: "total_connectivity_events"
      expr: COUNT(1)
      comment: "Total number of device connectivity events — baseline OT network reliability KPI."
    - name: "auto_recovery_success_count"
      expr: COUNT(CASE WHEN auto_recovery_attempted = TRUE AND recovery_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of connectivity events where auto-recovery succeeded — measures OT network self-healing capability."
    - name: "auto_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_recovery_attempted = TRUE AND recovery_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN auto_recovery_attempted = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of auto-recovery attempts that succeeded — low rates indicate OT network resilience gaps."
    - name: "distinct_devices_with_connectivity_issues"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices experiencing connectivity events — high counts indicate systemic OT network issues."
    - name: "unresolved_connectivity_events"
      expr: COUNT(CASE WHEN recovery_timestamp IS NULL THEN 1 END)
      comment: "Count of connectivity events with no recorded recovery — represents active OT network reliability risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_scada_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCADA operator activity and cybersecurity KPIs — tracks session duration, control action volume, and setpoint change activity to monitor operator engagement and detect anomalous access patterns."
  source: "`vibe_manufacturing_v1`.`automation`.`scada_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of SCADA session (operator, engineer, remote, audit) — enables role-based activity analysis."
    - name: "session_status"
      expr: session_status
      comment: "Status of the SCADA session (active, terminated, expired) — used to identify abnormal session terminations."
    - name: "login_method"
      expr: login_method
      comment: "Authentication method used (password, MFA, certificate) — drives cybersecurity compliance monitoring."
    - name: "user_role"
      expr: user_role
      comment: "Role of the SCADA user — enables privilege-level activity analysis and least-privilege compliance."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area accessed during the SCADA session — for area-level access pattern analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', login_timestamp)
      comment: "Month of the SCADA session — for monthly operator activity and access trending."
  measures:
    - name: "total_scada_sessions"
      expr: COUNT(1)
      comment: "Total number of SCADA sessions — baseline operator activity volume KPI."
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average SCADA session duration in seconds — unusually short or long sessions may indicate anomalous access."
    - name: "total_session_duration_seconds"
      expr: SUM(CAST(session_duration_seconds AS DOUBLE))
      comment: "Total cumulative SCADA session time in seconds — measures overall operator engagement with the control system."
    - name: "distinct_operators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct operators with SCADA sessions — measures active user base for licensing and access governance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation capital project KPIs — tracks budget performance, schedule adherence, and project delivery quality to govern automation investment outcomes."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_project`"
  dimensions:
    - name: "automation_project_status"
      expr: automation_project_status
      comment: "Current status of the automation project (planning, in-progress, completed, cancelled) — primary project pipeline dimension."
    - name: "automation_project_type"
      expr: automation_project_type
      comment: "Type of automation project (greenfield, upgrade, cybersecurity, integration) — enables portfolio segmentation."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the project is on the critical path — critical projects require executive oversight."
    - name: "is_cybersecurity_hardening"
      expr: is_cybersecurity_hardening
      comment: "Flag indicating whether the project is a cybersecurity hardening initiative — tracks OT security investment."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the automation project — non-compliant projects represent regulatory risk."
    - name: "priority"
      expr: priority
      comment: "Priority level of the automation project — used to assess portfolio prioritisation alignment."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the project was planned to start — for portfolio timeline analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of automation projects — baseline portfolio size KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted investment across automation projects — primary capital allocation KPI for automation portfolio."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across automation projects — compared against budget to assess cost performance."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of budget — over 100% indicates cost overrun; under 70% may indicate under-delivery."
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual project duration in days — compared against estimated duration to assess schedule performance."
    - name: "avg_estimated_duration_days"
      expr: AVG(CAST(estimated_duration_days AS DOUBLE))
      comment: "Average estimated project duration in days — baseline for schedule variance calculation."
    - name: "schedule_overrun_count"
      expr: COUNT(CASE WHEN actual_duration_days > estimated_duration_days THEN 1 END)
      comment: "Count of projects that exceeded their estimated duration — high counts indicate planning accuracy issues."
    - name: "cybersecurity_project_count"
      expr: COUNT(CASE WHEN is_cybersecurity_hardening = TRUE THEN 1 END)
      comment: "Count of cybersecurity hardening projects — tracks OT security investment portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_control_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and risk metrics for control system assets"
  source: "`vibe_manufacturing_v1`.`automation`.`control_system`"
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