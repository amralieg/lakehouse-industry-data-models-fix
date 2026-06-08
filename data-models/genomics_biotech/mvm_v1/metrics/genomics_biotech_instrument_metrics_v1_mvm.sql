-- Metric views for domain: instrument | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:33:08

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Gxp Classification"
      expr: gxp_classification
    - name: "Installation Date"
      expr: installation_date
    - name: "Instrument Type"
      expr: instrument_type
    - name: "Iq Completion Date"
      expr: iq_completion_date
    - name: "Is Validated"
      expr: is_validated
    - name: "Last Calibration Date"
      expr: last_calibration_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Preventive Maintenance Date"
      expr: last_preventive_maintenance_date
    - name: "Next Calibration Due Date"
      expr: next_calibration_due_date
    - name: "Next Preventive Maintenance Due Date"
      expr: next_preventive_maintenance_due_date
    - name: "Notes"
      expr: notes
    - name: "Operational Status"
      expr: operational_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset"
      expr: COUNT(DISTINCT asset_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Run Time Hours"
      expr: SUM(run_time_hours)
    - name: "Average Run Time Hours"
      expr: AVG(run_time_hours)
    - name: "Total Throughput Capacity"
      expr: SUM(throughput_capacity)
    - name: "Average Throughput Capacity"
      expr: AVG(throughput_capacity)
    - name: "Total Total Uptime Hours"
      expr: SUM(total_uptime_hours)
    - name: "Average Total Uptime Hours"
      expr: AVG(total_uptime_hours)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration Record business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`calibration_record`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Calibration Certificate Reference"
      expr: calibration_certificate_reference
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Calibration End Timestamp"
      expr: calibration_end_timestamp
    - name: "Calibration Event Number"
      expr: calibration_event_number
    - name: "Calibration Location"
      expr: calibration_location
    - name: "Calibration Notes"
      expr: calibration_notes
    - name: "Calibration Procedure Version"
      expr: calibration_procedure_version
    - name: "Calibration Standard Certificate Number"
      expr: calibration_standard_certificate_number
    - name: "Calibration Standard Expiry Date"
      expr: calibration_standard_expiry_date
    - name: "Calibration Start Timestamp"
      expr: calibration_start_timestamp
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Calibration Type"
      expr: calibration_type
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Required"
      expr: corrective_action_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Calibration Record"
      expr: COUNT(DISTINCT calibration_record_id)
    - name: "Total Deviation From Standard"
      expr: SUM(deviation_from_standard)
    - name: "Average Deviation From Standard"
      expr: AVG(deviation_from_standard)
    - name: "Total Environmental Humidity Percent"
      expr: SUM(environmental_humidity_percent)
    - name: "Average Environmental Humidity Percent"
      expr: AVG(environmental_humidity_percent)
    - name: "Total Environmental Temperature C"
      expr: SUM(environmental_temperature_c)
    - name: "Average Environmental Temperature C"
      expr: AVG(environmental_temperature_c)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Tolerance Lower Limit"
      expr: SUM(tolerance_lower_limit)
    - name: "Average Tolerance Lower Limit"
      expr: AVG(tolerance_lower_limit)
    - name: "Total Tolerance Upper Limit"
      expr: SUM(tolerance_upper_limit)
    - name: "Average Tolerance Upper Limit"
      expr: AVG(tolerance_upper_limit)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Configuration business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`configuration`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Trail Enabled Flag"
      expr: audit_trail_enabled_flag
    - name: "Backup Configuration"
      expr: backup_configuration
    - name: "Calibration Profile"
      expr: calibration_profile
    - name: "Change Description"
      expr: change_description
    - name: "Change Reason"
      expr: change_reason
    - name: "Checksum"
      expr: checksum
    - name: "Configuration Name"
      expr: configuration_name
    - name: "Configuration Status"
      expr: configuration_status
    - name: "Configuration Type"
      expr: configuration_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Output Format"
      expr: data_output_format
    - name: "Data Storage Path"
      expr: data_storage_path
    - name: "Deployed By"
      expr: deployed_by
    - name: "Deployment Method"
      expr: deployment_method
    - name: "Deployment Timestamp"
      expr: deployment_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Configuration"
      expr: COUNT(DISTINCT configuration_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_field_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field Service Request business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`field_service_request`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Billable Flag"
      expr: billable_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Feedback"
      expr: customer_feedback
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Field Service Request Status"
      expr: field_service_request_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Parts Required Flag"
      expr: parts_required_flag
    - name: "Priority"
      expr: priority
    - name: "Problem Description"
      expr: problem_description
    - name: "Request Date"
      expr: request_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Field Service Request"
      expr: COUNT(DISTINCT field_service_request_id)
    - name: "Total Actual Cost Usd"
      expr: SUM(actual_cost_usd)
    - name: "Average Actual Cost Usd"
      expr: AVG(actual_cost_usd)
    - name: "Total Actual Duration Hours"
      expr: SUM(actual_duration_hours)
    - name: "Average Actual Duration Hours"
      expr: AVG(actual_duration_hours)
    - name: "Total Estimated Cost Usd"
      expr: SUM(estimated_cost_usd)
    - name: "Average Estimated Cost Usd"
      expr: AVG(estimated_cost_usd)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
    - name: "Total Invoice Amount Usd"
      expr: SUM(invoice_amount_usd)
    - name: "Average Invoice Amount Usd"
      expr: AVG(invoice_amount_usd)
    - name: "Total Travel Distance Km"
      expr: SUM(travel_distance_km)
    - name: "Average Travel Distance Km"
      expr: AVG(travel_distance_km)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_installation_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installation Qualification business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`installation_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Cfr Part 11 Compliant Flag"
      expr: cfr_part_11_compliant_flag
    - name: "Comments"
      expr: comments
    - name: "Completion Date"
      expr: completion_date
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Acceptance Date"
      expr: customer_acceptance_date
    - name: "Customer Signature Captured Flag"
      expr: customer_signature_captured_flag
    - name: "Deviation Count"
      expr: deviation_count
    - name: "Deviation Summary"
      expr: deviation_summary
    - name: "Environmental Conditions"
      expr: environmental_conditions
    - name: "Execution Date"
      expr: execution_date
    - name: "Gxp Compliant Flag"
      expr: gxp_compliant_flag
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Installation Qualification"
      expr: COUNT(DISTINCT installation_qualification_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_instrument_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument Run business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`instrument_run`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count"
      expr: cycle_count
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Identifier"
      expr: identifier
    - name: "Instrument Software Version"
      expr: instrument_software_version
    - name: "Is Clinical Run"
      expr: is_clinical_run
    - name: "Is Paired End"
      expr: is_paired_end
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Multiplexing Index Strategy"
      expr: multiplexing_index_strategy
    - name: "Number Of Samples"
      expr: number_of_samples
    - name: "Output Data Location"
      expr: output_data_location
    - name: "Output File Format"
      expr: output_file_format
    - name: "Qc Review Timestamp"
      expr: qc_review_timestamp
    - name: "Qc Status"
      expr: qc_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Instrument Run"
      expr: COUNT(DISTINCT instrument_run_id)
    - name: "Total Cluster Density"
      expr: SUM(cluster_density)
    - name: "Average Cluster Density"
      expr: AVG(cluster_density)
    - name: "Total Error Rate"
      expr: SUM(error_rate)
    - name: "Average Error Rate"
      expr: AVG(error_rate)
    - name: "Total Mean Quality Score"
      expr: SUM(mean_quality_score)
    - name: "Average Mean Quality Score"
      expr: AVG(mean_quality_score)
    - name: "Total Percent Aligned To Phix"
      expr: SUM(percent_aligned_to_phix)
    - name: "Average Percent Aligned To Phix"
      expr: AVG(percent_aligned_to_phix)
    - name: "Total Percent Pf Clusters"
      expr: SUM(percent_pf_clusters)
    - name: "Average Percent Pf Clusters"
      expr: AVG(percent_pf_clusters)
    - name: "Total Percent Q30 Bases"
      expr: SUM(percent_q30_bases)
    - name: "Average Percent Q30 Bases"
      expr: AVG(percent_q30_bases)
    - name: "Total Phix Error Rate"
      expr: SUM(phix_error_rate)
    - name: "Average Phix Error Rate"
      expr: AVG(phix_error_rate)
    - name: "Total Qc Performed By"
      expr: SUM(qc_performed_by)
    - name: "Average Qc Performed By"
      expr: AVG(qc_performed_by)
    - name: "Total Total Reads Generated"
      expr: SUM(total_reads_generated)
    - name: "Average Total Reads Generated"
      expr: AVG(total_reads_generated)
    - name: "Total Total Yield Gb"
      expr: SUM(total_yield_gb)
    - name: "Average Total Yield Gb"
      expr: AVG(total_yield_gb)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Event business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`maintenance_event`"
  dimensions:
    - name: "Actual End Datetime"
      expr: actual_end_datetime
    - name: "Actual Start Datetime"
      expr: actual_start_datetime
    - name: "Billable Flag"
      expr: billable_flag
    - name: "Created Datetime"
      expr: created_datetime
    - name: "Customer Signoff Datetime"
      expr: customer_signoff_datetime
    - name: "Customer Signoff Required"
      expr: customer_signoff_required
    - name: "Event Type"
      expr: event_type
    - name: "Follow Up Actions"
      expr: follow_up_actions
    - name: "Follow Up Required"
      expr: follow_up_required
    - name: "Impact Assessment"
      expr: impact_assessment
    - name: "Last Modified Datetime"
      expr: last_modified_datetime
    - name: "Maintenance Event Status"
      expr: maintenance_event_status
    - name: "Notes"
      expr: notes
    - name: "Priority"
      expr: priority
    - name: "Regulatory Reportable Flag"
      expr: regulatory_reportable_flag
    - name: "Resolution Summary"
      expr: resolution_summary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Event"
      expr: COUNT(DISTINCT maintenance_event_id)
    - name: "Total Downtime Duration Minutes"
      expr: SUM(downtime_duration_minutes)
    - name: "Average Downtime Duration Minutes"
      expr: AVG(downtime_duration_minutes)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Sla Actual Response Hours"
      expr: SUM(sla_actual_response_hours)
    - name: "Average Sla Actual Response Hours"
      expr: AVG(sla_actual_response_hours)
    - name: "Total Sla Target Response Hours"
      expr: SUM(sla_target_response_hours)
    - name: "Average Sla Target Response Hours"
      expr: AVG(sla_target_response_hours)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Model business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`model`"
  dimensions:
    - name: "Calibration Frequency Days"
      expr: calibration_frequency_days
    - name: "Ce Mark Certificate"
      expr: ce_mark_certificate
    - name: "Connectivity Requirements"
      expr: connectivity_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Output Format"
      expr: data_output_format
    - name: "End Of Life Date"
      expr: end_of_life_date
    - name: "End Of Support Date"
      expr: end_of_support_date
    - name: "Environmental Requirements"
      expr: environmental_requirements
    - name: "Fda Clearance Number"
      expr: fda_clearance_number
    - name: "Flow Cell Type"
      expr: flow_cell_type
    - name: "Instrument Type"
      expr: instrument_type
    - name: "Launch Date"
      expr: launch_date
    - name: "Model Description"
      expr: model_description
    - name: "Model Number"
      expr: model_number
    - name: "Model Status"
      expr: model_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Model"
      expr: COUNT(DISTINCT model_id)
    - name: "Total List Price Usd"
      expr: SUM(list_price_usd)
    - name: "Average List Price Usd"
      expr: AVG(list_price_usd)
    - name: "Total Max Reads Per Run"
      expr: SUM(max_reads_per_run)
    - name: "Average Max Reads Per Run"
      expr: AVG(max_reads_per_run)
    - name: "Total Max Throughput Gb"
      expr: SUM(max_throughput_gb)
    - name: "Average Max Throughput Gb"
      expr: AVG(max_throughput_gb)
    - name: "Total Mean Time Between Failures Hours"
      expr: SUM(mean_time_between_failures_hours)
    - name: "Average Mean Time Between Failures Hours"
      expr: AVG(mean_time_between_failures_hours)
    - name: "Total Mean Time To Repair Hours"
      expr: SUM(mean_time_to_repair_hours)
    - name: "Average Mean Time To Repair Hours"
      expr: AVG(mean_time_to_repair_hours)
    - name: "Total Run Time Hours"
      expr: SUM(run_time_hours)
    - name: "Average Run Time Hours"
      expr: AVG(run_time_hours)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pm Schedule business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`pm_schedule`"
  dimensions:
    - name: "Applicable Instrument Types"
      expr: applicable_instrument_types
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Generate Work Order Flag"
      expr: auto_generate_work_order_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Level"
      expr: criticality_level
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Estimated Duration Minutes"
      expr: estimated_duration_minutes
    - name: "Frequency Interval Days"
      expr: frequency_interval_days
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Last Completed Date"
      expr: last_completed_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Maintenance Frequency"
      expr: maintenance_frequency
    - name: "Maintenance Task Type"
      expr: maintenance_task_type
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pm Schedule"
      expr: COUNT(DISTINCT pm_schedule_id)
    - name: "Total Estimated Cost Usd"
      expr: SUM(estimated_cost_usd)
    - name: "Average Estimated Cost Usd"
      expr: AVG(estimated_cost_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`instrument_service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Contract business metrics"
  source: "`genomics_biotech_ecm`.`instrument`.`service_contract`"
  dimensions:
    - name: "Acquisition Method"
      expr: acquisition_method
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Claim Eligibility Rules"
      expr: claim_eligibility_rules
    - name: "Contract Currency"
      expr: contract_currency
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Signed Date"
      expr: contract_signed_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Coverage Scope"
      expr: coverage_scope
    - name: "Coverage Territory"
      expr: coverage_territory
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Included Pm Visits"
      expr: included_pm_visits
    - name: "Labor Coverage Included"
      expr: labor_coverage_included
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Contract"
      expr: COUNT(DISTINCT service_contract_id)
    - name: "Total Annual Contract Value"
      expr: SUM(annual_contract_value)
    - name: "Average Annual Contract Value"
      expr: AVG(annual_contract_value)
    - name: "Total Consumables Discount Percent"
      expr: SUM(consumables_discount_percent)
    - name: "Average Consumables Discount Percent"
      expr: AVG(consumables_discount_percent)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Response Time Hours"
      expr: SUM(response_time_hours)
    - name: "Average Response Time Hours"
      expr: AVG(response_time_hours)
    - name: "Total Uptime Guarantee Percent"
      expr: SUM(uptime_guarantee_percent)
    - name: "Average Uptime Guarantee Percent"
      expr: AVG(uptime_guarantee_percent)
$$;