-- Metric views for domain: equipment | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:33:23

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration Record business metrics"
  source: "`semiconductors_ecm`.`equipment`.`calibration_record`"
  dimensions:
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Calibration Method"
      expr: calibration_method
    - name: "Calibration Record Status"
      expr: calibration_record_status
    - name: "Calibration Report Url"
      expr: calibration_report_url
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
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Next Due Date"
      expr: next_due_date
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_equipment_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Process Recipe business metrics"
  source: "`semiconductors_ecm`.`equipment`.`equipment_process_recipe`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Audit Status"
      expr: audit_status
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Deprecated"
      expr: is_deprecated
    - name: "Last Audit Timestamp"
      expr: last_audit_timestamp
    - name: "Last Used Timestamp"
      expr: last_used_timestamp
    - name: "Parameter Count"
      expr: parameter_count
    - name: "Parameter Set Description"
      expr: parameter_set_description
    - name: "Process Node Target"
      expr: process_node_target
    - name: "Process Step Count"
      expr: process_step_count
    - name: "Recipe Category"
      expr: recipe_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Process Recipe"
      expr: COUNT(DISTINCT equipment_process_recipe_id)
    - name: "Total Exposure Dose Mj Cm2"
      expr: SUM(exposure_dose_mj_cm2)
    - name: "Average Exposure Dose Mj Cm2"
      expr: AVG(exposure_dose_mj_cm2)
    - name: "Total Focus Offset Nm"
      expr: SUM(focus_offset_nm)
    - name: "Average Focus Offset Nm"
      expr: AVG(focus_offset_nm)
    - name: "Total Gas Flow Rate Sccm"
      expr: SUM(gas_flow_rate_sccm)
    - name: "Average Gas Flow Rate Sccm"
      expr: AVG(gas_flow_rate_sccm)
    - name: "Total Oee Actual Percent"
      expr: SUM(oee_actual_percent)
    - name: "Average Oee Actual Percent"
      expr: AVG(oee_actual_percent)
    - name: "Total Oee Target Percent"
      expr: SUM(oee_target_percent)
    - name: "Average Oee Target Percent"
      expr: AVG(oee_target_percent)
    - name: "Total Pressure Setpoint Pa"
      expr: SUM(pressure_setpoint_pa)
    - name: "Average Pressure Setpoint Pa"
      expr: AVG(pressure_setpoint_pa)
    - name: "Total Rf Power Watts"
      expr: SUM(rf_power_watts)
    - name: "Average Rf Power Watts"
      expr: AVG(rf_power_watts)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
    - name: "Total Yield Actual Percent"
      expr: SUM(yield_actual_percent)
    - name: "Average Yield Actual Percent"
      expr: AVG(yield_actual_percent)
    - name: "Total Yield Target Percent"
      expr: SUM(yield_target_percent)
    - name: "Average Yield Target Percent"
      expr: AVG(yield_target_percent)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab Tool business metrics"
  source: "`semiconductors_ecm`.`equipment`.`fab_tool`"
  dimensions:
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Cleanroom Class"
      expr: cleanroom_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Depreciation End Date"
      expr: depreciation_end_date
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Fab Tool Description"
      expr: fab_tool_description
    - name: "Fab Tool Name"
      expr: fab_tool_name
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Maintenance Interval Days"
      expr: maintenance_interval_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fab Tool"
      expr: COUNT(DISTINCT fab_tool_id)
    - name: "Total Capacity Wafer Per Hour"
      expr: SUM(capacity_wafer_per_hour)
    - name: "Average Capacity Wafer Per Hour"
      expr: AVG(capacity_wafer_per_hour)
    - name: "Total Capital Expenditure Amount"
      expr: SUM(capital_expenditure_amount)
    - name: "Average Capital Expenditure Amount"
      expr: AVG(capital_expenditure_amount)
    - name: "Total Energy Consumption Kwh Per Year"
      expr: SUM(energy_consumption_kwh_per_year)
    - name: "Average Energy Consumption Kwh Per Year"
      expr: AVG(energy_consumption_kwh_per_year)
    - name: "Total Mtbf Hours"
      expr: SUM(mtbf_hours)
    - name: "Average Mtbf Hours"
      expr: AVG(mtbf_hours)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Oee Percent"
      expr: SUM(oee_percent)
    - name: "Average Oee Percent"
      expr: AVG(oee_percent)
    - name: "Total Power Rating Kw"
      expr: SUM(power_rating_kw)
    - name: "Average Power Rating Kw"
      expr: AVG(power_rating_kw)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Event business metrics"
  source: "`semiconductors_ecm`.`equipment`.`maintenance_event`"
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
    - name: "Eco Reference"
      expr: eco_reference
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Event Number"
      expr: event_number
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
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Plan business metrics"
  source: "`semiconductors_ecm`.`equipment`.`maintenance_plan`"
  dimensions:
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Equipment Category"
      expr: equipment_category
    - name: "Frequency Unit"
      expr: frequency_unit
    - name: "Frequency Value"
      expr: frequency_value
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Performed Date"
      expr: last_performed_date
    - name: "Maintenance Plan Status"
      expr: maintenance_plan_status
    - name: "Maintenance Task Description"
      expr: maintenance_task_description
    - name: "Next Due Date"
      expr: next_due_date
    - name: "Notes"
      expr: notes
    - name: "Plan Code"
      expr: plan_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Plan"
      expr: COUNT(DISTINCT maintenance_plan_id)
    - name: "Total Cost Estimate Usd"
      expr: SUM(cost_estimate_usd)
    - name: "Average Cost Estimate Usd"
      expr: AVG(cost_estimate_usd)
    - name: "Total Maintenance Window Hours"
      expr: SUM(maintenance_window_hours)
    - name: "Average Maintenance Window Hours"
      expr: AVG(maintenance_window_hours)
    - name: "Total Mean Time Between Failures Hours"
      expr: SUM(mean_time_between_failures_hours)
    - name: "Average Mean Time Between Failures Hours"
      expr: AVG(mean_time_between_failures_hours)
    - name: "Total Mean Time To Repair Hours"
      expr: SUM(mean_time_to_repair_hours)
    - name: "Average Mean Time To Repair Hours"
      expr: AVG(mean_time_to_repair_hours)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_metrology_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology Run business metrics"
  source: "`semiconductors_ecm`.`equipment`.`metrology_run`"
  dimensions:
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Lot Type"
      expr: lot_type
    - name: "Measurement Mode"
      expr: measurement_mode
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Metrology Run Status"
      expr: metrology_run_status
    - name: "Pass Fail"
      expr: pass_fail
    - name: "Run Duration Seconds"
      expr: run_duration_seconds
    - name: "Run Number"
      expr: run_number
    - name: "Run Timestamp"
      expr: run_timestamp
    - name: "Shift"
      expr: shift
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Metrology Run"
      expr: COUNT(DISTINCT metrology_run_id)
    - name: "Total Humidity Percent"
      expr: SUM(humidity_percent)
    - name: "Average Humidity Percent"
      expr: AVG(humidity_percent)
    - name: "Total Mean Value"
      expr: SUM(mean_value)
    - name: "Average Mean Value"
      expr: AVG(mean_value)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Oee Percent"
      expr: SUM(oee_percent)
    - name: "Average Oee Percent"
      expr: AVG(oee_percent)
    - name: "Total Sigma Value"
      expr: SUM(sigma_value)
    - name: "Average Sigma Value"
      expr: AVG(sigma_value)
    - name: "Total Spec Limit High"
      expr: SUM(spec_limit_high)
    - name: "Average Spec Limit High"
      expr: AVG(spec_limit_high)
    - name: "Total Spec Limit Low"
      expr: SUM(spec_limit_low)
    - name: "Average Spec Limit Low"
      expr: AVG(spec_limit_low)
    - name: "Total Std Dev"
      expr: SUM(std_dev)
    - name: "Average Std Dev"
      expr: AVG(std_dev)
    - name: "Total Temperature C"
      expr: SUM(temperature_c)
    - name: "Average Temperature C"
      expr: AVG(temperature_c)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pm Schedule business metrics"
  source: "`semiconductors_ecm`.`equipment`.`pm_schedule`"
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
    - name: "Pm Schedule Description"
      expr: pm_schedule_description
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_recipe_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe Execution business metrics"
  source: "`semiconductors_ecm`.`equipment`.`recipe_execution`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Compliance Status"
      expr: compliance_status
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Execution Status"
      expr: execution_status
    - name: "Is Calibrated"
      expr: is_calibrated
    - name: "Is Critical"
      expr: is_critical
    - name: "Notes"
      expr: notes
    - name: "Process Step"
      expr: process_step
    - name: "Recipe Version"
      expr: recipe_version
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Result Code"
      expr: result_code
    - name: "Run Number"
      expr: run_number
    - name: "Start Timestamp"
      expr: start_timestamp
    - name: "End Timestamp Month"
      expr: DATE_TRUNC('MONTH', end_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recipe Execution"
      expr: COUNT(DISTINCT recipe_execution_id)
    - name: "Total Duration Seconds"
      expr: SUM(duration_seconds)
    - name: "Average Duration Seconds"
      expr: AVG(duration_seconds)
    - name: "Total Gas Flow Actual Sccm"
      expr: SUM(gas_flow_actual_sccm)
    - name: "Average Gas Flow Actual Sccm"
      expr: AVG(gas_flow_actual_sccm)
    - name: "Total Gas Flow Setpoint Sccm"
      expr: SUM(gas_flow_setpoint_sccm)
    - name: "Average Gas Flow Setpoint Sccm"
      expr: AVG(gas_flow_setpoint_sccm)
    - name: "Total Oee Availability Percent"
      expr: SUM(oee_availability_percent)
    - name: "Average Oee Availability Percent"
      expr: AVG(oee_availability_percent)
    - name: "Total Oee Performance Percent"
      expr: SUM(oee_performance_percent)
    - name: "Average Oee Performance Percent"
      expr: AVG(oee_performance_percent)
    - name: "Total Oee Quality Percent"
      expr: SUM(oee_quality_percent)
    - name: "Average Oee Quality Percent"
      expr: AVG(oee_quality_percent)
    - name: "Total Power Actual W"
      expr: SUM(power_actual_w)
    - name: "Average Power Actual W"
      expr: AVG(power_actual_w)
    - name: "Total Power Setpoint W"
      expr: SUM(power_setpoint_w)
    - name: "Average Power Setpoint W"
      expr: AVG(power_setpoint_w)
    - name: "Total Pressure Actual Pa"
      expr: SUM(pressure_actual_pa)
    - name: "Average Pressure Actual Pa"
      expr: AVG(pressure_actual_pa)
    - name: "Total Pressure Setpoint Pa"
      expr: SUM(pressure_setpoint_pa)
    - name: "Average Pressure Setpoint Pa"
      expr: AVG(pressure_setpoint_pa)
    - name: "Total Temperature Actual C"
      expr: SUM(temperature_actual_c)
    - name: "Average Temperature Actual C"
      expr: AVG(temperature_actual_c)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare Part business metrics"
  source: "`semiconductors_ecm`.`equipment`.`spare_part`"
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
    - name: "Inspection Status"
      expr: inspection_status
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
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_chamber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Chamber business metrics"
  source: "`semiconductors_ecm`.`equipment`.`tool_chamber`"
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
    - name: "Location"
      expr: location
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Downtime business metrics"
  source: "`semiconductors_ecm`.`equipment`.`tool_downtime`"
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
    - name: "Downtime Reason Code"
      expr: downtime_reason_code
    - name: "Downtime Reason Description"
      expr: downtime_reason_description
    - name: "Downtime Start Timestamp"
      expr: downtime_start_timestamp
    - name: "Downtime Type"
      expr: downtime_type
    - name: "Impact Wip Lot Count"
      expr: impact_wip_lot_count
    - name: "Responsible Party"
      expr: responsible_party
    - name: "Root Cause Category"
      expr: root_cause_category
    - name: "Scheduled Flag"
      expr: scheduled_flag
    - name: "Severity Level"
      expr: severity_level
    - name: "Shift"
      expr: shift
    - name: "Source System"
      expr: source_system
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Qualification business metrics"
  source: "`semiconductors_ecm`.`equipment`.`tool_qualification`"
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
    - name: "Process Node"
      expr: process_node
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