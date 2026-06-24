-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration Record business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Calibration Method"
      expr: calibration_method
    - name: "Calibration Record Status"
      expr: calibration_record_status
    - name: "Calibration Report Url"
      expr: calibration_report_url
    - name: "Calibration Result"
      expr: calibration_result
    - name: "Calibration Result Code"
      expr: calibration_result_code
    - name: "Calibration Source System"
      expr: calibration_source_system
    - name: "Calibration Standard"
      expr: calibration_standard
    - name: "Calibration Timestamp"
      expr: calibration_timestamp
    - name: "Calibration Type"
      expr: calibration_type
    - name: "Comments"
      expr: comments
    - name: "Compliance Reference"
      expr: compliance_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Location"
      expr: location
    - name: "Lot Number"
      expr: lot_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Calibration Record"
      expr: COUNT(DISTINCT calibration_record_id)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Measurement Uncertainty"
      expr: SUM(measurement_uncertainty)
    - name: "Average Measurement Uncertainty"
      expr: AVG(measurement_uncertainty)
    - name: "Total Nominal Value"
      expr: SUM(nominal_value)
    - name: "Average Nominal Value"
      expr: AVG(nominal_value)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Event business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "Baseline Change Flag"
      expr: baseline_change_flag
    - name: "Comments"
      expr: comments
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Downtime Duration Minutes"
      expr: downtime_duration_minutes
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Eco Reference"
      expr: eco_reference
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Event Number"
      expr: event_number
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Maintenance Category"
      expr: maintenance_category
    - name: "Maintenance Event Status"
      expr: maintenance_event_status
    - name: "Performance Improvement Target"
      expr: performance_improvement_target
    - name: "Post Config Version"
      expr: post_config_version
    - name: "Pre Config Version"
      expr: pre_config_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Event"
      expr: COUNT(DISTINCT maintenance_event_id)
    - name: "Total Labor Cost Total"
      expr: SUM(labor_cost_total)
    - name: "Average Labor Cost Total"
      expr: AVG(labor_cost_total)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Oee Impact Percentage"
      expr: SUM(oee_impact_percentage)
    - name: "Average Oee Impact Percentage"
      expr: AVG(oee_impact_percentage)
    - name: "Total Parts Cost Total"
      expr: SUM(parts_cost_total)
    - name: "Average Parts Cost Total"
      expr: AVG(parts_cost_total)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Oee Record business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`oee_record`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Category"
      expr: downtime_category
    - name: "Downtime Reason Code"
      expr: downtime_reason_code
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Oee Calculation Method"
      expr: oee_calculation_method
    - name: "Record Date"
      expr: record_date
    - name: "Record Status"
      expr: record_status
    - name: "Responsible Party"
      expr: responsible_party
    - name: "Shift Date"
      expr: shift_date
    - name: "Shift Name"
      expr: shift_name
    - name: "State Current"
      expr: state_current
    - name: "State Last Change Timestamp"
      expr: state_last_change_timestamp
    - name: "State Transition Count"
      expr: state_transition_count
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Oee Record"
      expr: COUNT(DISTINCT oee_record_id)
    - name: "Total Availability Percent"
      expr: SUM(availability_percent)
    - name: "Average Availability Percent"
      expr: AVG(availability_percent)
    - name: "Total Availability Rate"
      expr: SUM(availability_rate)
    - name: "Average Availability Rate"
      expr: AVG(availability_rate)
    - name: "Total Available Hours"
      expr: SUM(available_hours)
    - name: "Average Available Hours"
      expr: AVG(available_hours)
    - name: "Total Engineering Hours"
      expr: SUM(engineering_hours)
    - name: "Average Engineering Hours"
      expr: AVG(engineering_hours)
    - name: "Total Idle Hours"
      expr: SUM(idle_hours)
    - name: "Average Idle Hours"
      expr: AVG(idle_hours)
    - name: "Total Oee Percent"
      expr: SUM(oee_percent)
    - name: "Average Oee Percent"
      expr: AVG(oee_percent)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Performance Percent"
      expr: SUM(performance_percent)
    - name: "Average Performance Percent"
      expr: AVG(performance_percent)
    - name: "Total Performance Rate"
      expr: SUM(performance_rate)
    - name: "Average Performance Rate"
      expr: AVG(performance_rate)
    - name: "Total Productive Hours"
      expr: SUM(productive_hours)
    - name: "Average Productive Hours"
      expr: AVG(productive_hours)
    - name: "Total Quality Percent"
      expr: SUM(quality_percent)
    - name: "Average Quality Percent"
      expr: AVG(quality_percent)
    - name: "Total Quality Rate"
      expr: SUM(quality_rate)
    - name: "Average Quality Rate"
      expr: AVG(quality_rate)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pm Schedule business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`pm_schedule`"
  dimensions:
    - name: "Compliance Requirement"
      expr: compliance_requirement
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimated Downtime Minutes"
      expr: estimated_downtime_minutes
    - name: "Interval Unit"
      expr: interval_unit
    - name: "Interval Value"
      expr: interval_value
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Performed Date"
      expr: last_performed_date
    - name: "Maintenance Window End"
      expr: maintenance_window_end
    - name: "Maintenance Window Start"
      expr: maintenance_window_start
    - name: "Next Scheduled Date"
      expr: next_scheduled_date
    - name: "Pm Procedure Reference"
      expr: pm_procedure_reference
    - name: "Pm Schedule Status"
      expr: pm_schedule_status
    - name: "Pm Type"
      expr: pm_type
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pm Schedule"
      expr: COUNT(DISTINCT pm_schedule_id)
    - name: "Total Oee Impact Estimate"
      expr: SUM(oee_impact_estimate)
    - name: "Average Oee Impact Estimate"
      expr: AVG(oee_impact_estimate)
    - name: "Total Work Order Template Code"
      expr: SUM(work_order_template_code)
    - name: "Average Work Order Template Code"
      expr: AVG(work_order_template_code)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare Part business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`spare_part`"
  dimensions:
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Calibration Required Flag"
      expr: calibration_required_flag
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Stock Qty"
      expr: current_stock_qty
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Equipment Compatible"
      expr: equipment_compatible
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Received Date"
      expr: last_received_date
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lifecycle End Date"
      expr: lifecycle_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spare Part"
      expr: COUNT(DISTINCT spare_part_id)
    - name: "Total Part Volume Cm3"
      expr: SUM(part_volume_cm3)
    - name: "Average Part Volume Cm3"
      expr: AVG(part_volume_cm3)
    - name: "Total Part Weight Kg"
      expr: SUM(part_weight_kg)
    - name: "Average Part Weight Kg"
      expr: AVG(part_weight_kg)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Unit Cost Usd"
      expr: SUM(unit_cost_usd)
    - name: "Average Unit Cost Usd"
      expr: AVG(unit_cost_usd)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_chamber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Chamber business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_chamber`"
  dimensions:
    - name: "Audit Last Date"
      expr: audit_last_date
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Chamber Code"
      expr: chamber_code
    - name: "Chamber Name"
      expr: chamber_name
    - name: "Chamber Status Reason"
      expr: chamber_status_reason
    - name: "Chamber Type"
      expr: chamber_type
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Calibration Result"
      expr: last_calibration_result
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Chamber"
      expr: COUNT(DISTINCT tool_chamber_id)
    - name: "Total Chamber Lifetime Hours"
      expr: SUM(chamber_lifetime_hours)
    - name: "Average Chamber Lifetime Hours"
      expr: AVG(chamber_lifetime_hours)
    - name: "Total Gas Flow Rate Sccm"
      expr: SUM(gas_flow_rate_sccm)
    - name: "Average Gas Flow Rate Sccm"
      expr: AVG(gas_flow_rate_sccm)
    - name: "Total Mtbf Hours"
      expr: SUM(mtbf_hours)
    - name: "Average Mtbf Hours"
      expr: AVG(mtbf_hours)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Pressure Setpoint Pa"
      expr: SUM(pressure_setpoint_pa)
    - name: "Average Pressure Setpoint Pa"
      expr: AVG(pressure_setpoint_pa)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
    - name: "Total Throughput Pph"
      expr: SUM(throughput_pph)
    - name: "Average Throughput Pph"
      expr: AVG(throughput_pph)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Downtime business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Duration Minutes"
      expr: downtime_duration_minutes
    - name: "Downtime End Timestamp"
      expr: downtime_end_timestamp
    - name: "Downtime Reason"
      expr: downtime_reason
    - name: "Downtime Reason Code"
      expr: downtime_reason_code
    - name: "Downtime Reason Description"
      expr: downtime_reason_description
    - name: "Downtime Start Timestamp"
      expr: downtime_start_timestamp
    - name: "Downtime Type"
      expr: downtime_type
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Responsible Party"
      expr: responsible_party
    - name: "Root Cause Category"
      expr: root_cause_category
    - name: "Scheduled Flag"
      expr: scheduled_flag
    - name: "Severity Level"
      expr: severity_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Downtime"
      expr: COUNT(DISTINCT tool_downtime_id)
    - name: "Total Oee Impact Percentage"
      expr: SUM(oee_impact_percentage)
    - name: "Average Oee Impact Percentage"
      expr: AVG(oee_impact_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Change Control Number"
      expr: change_control_number
    - name: "Compliance Approval Status"
      expr: compliance_approval_status
    - name: "Compliance Document Reference"
      expr: compliance_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Equipment Serial Number"
      expr: equipment_serial_number
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Maintenance Status"
      expr: maintenance_status
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Notes"
      expr: notes
    - name: "Qualification End Date"
      expr: qualification_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Qualification"
      expr: COUNT(DISTINCT tool_qualification_id)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Oee Impact"
      expr: SUM(oee_impact)
    - name: "Average Oee Impact"
      expr: AVG(oee_impact)
    - name: "Total Result Metric Value"
      expr: SUM(result_metric_value)
    - name: "Average Result Metric Value"
      expr: AVG(result_metric_value)
    - name: "Total Tolerance"
      expr: SUM(tolerance)
    - name: "Average Tolerance"
      expr: AVG(tolerance)
$$;