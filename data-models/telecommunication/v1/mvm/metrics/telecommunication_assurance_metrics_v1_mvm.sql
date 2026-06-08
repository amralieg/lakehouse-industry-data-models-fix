-- Metric views for domain: assurance | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:30:47

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alarm Event business metrics"
  source: "`telecommunication_ecm`.`assurance`.`alarm_event`"
  dimensions:
    - name: "Acknowledged By User"
      expr: acknowledged_by_user
    - name: "Actual Resolution Minutes"
      expr: actual_resolution_minutes
    - name: "Affected Service Type"
      expr: affected_service_type
    - name: "Alarm Acknowledged Timestamp"
      expr: alarm_acknowledged_timestamp
    - name: "Alarm Cleared Timestamp"
      expr: alarm_cleared_timestamp
    - name: "Alarm Identifier"
      expr: alarm_identifier
    - name: "Alarm Raised Timestamp"
      expr: alarm_raised_timestamp
    - name: "Alarm Severity"
      expr: alarm_severity
    - name: "Alarm State"
      expr: alarm_state
    - name: "Alarm Type"
      expr: alarm_type
    - name: "Cleared By System"
      expr: cleared_by_system
    - name: "Correlation Identifier"
      expr: correlation_identifier
    - name: "Customer Impact Count"
      expr: customer_impact_count
    - name: "First Occurrence Timestamp"
      expr: first_occurrence_timestamp
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Alarm Event"
      expr: COUNT(DISTINCT alarm_event_id)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud Alert business metrics"
  source: "`telecommunication_ecm`.`assurance`.`fraud_alert`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Action Taken"
      expr: action_taken
    - name: "Affected Imsi"
      expr: affected_imsi
    - name: "Affected Msisdn"
      expr: affected_msisdn
    - name: "Alert Generated Timestamp"
      expr: alert_generated_timestamp
    - name: "Alert Number"
      expr: alert_number
    - name: "Alert Priority"
      expr: alert_priority
    - name: "Alert Severity"
      expr: alert_severity
    - name: "Alert Status"
      expr: alert_status
    - name: "Alert Trigger Type"
      expr: alert_trigger_type
    - name: "Analyst Notes"
      expr: analyst_notes
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detection Timestamp"
      expr: detection_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fraud Alert"
      expr: COUNT(DISTINCT fraud_alert_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total Estimated Revenue Impact"
      expr: SUM(estimated_revenue_impact)
    - name: "Average Estimated Revenue Impact"
      expr: AVG(estimated_revenue_impact)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud Case business metrics"
  source: "`telecommunication_ecm`.`assurance`.`fraud_case`"
  dimensions:
    - name: "Affected Msisdn"
      expr: affected_msisdn
    - name: "Alert Severity"
      expr: alert_severity
    - name: "Alert Timestamp"
      expr: alert_timestamp
    - name: "Case Closed Timestamp"
      expr: case_closed_timestamp
    - name: "Case Number"
      expr: case_number
    - name: "Case Opened Timestamp"
      expr: case_opened_timestamp
    - name: "Case Priority"
      expr: case_priority
    - name: "Case Status"
      expr: case_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detection Rule Reference"
      expr: detection_rule_reference
    - name: "Detection Source"
      expr: detection_source
    - name: "Evidence References"
      expr: evidence_references
    - name: "False Positive Flag"
      expr: false_positive_flag
    - name: "Fraud Subtype"
      expr: fraud_subtype
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fraud Case"
      expr: COUNT(DISTINCT fraud_case_id)
    - name: "Total Confirmed Fraud Loss Amount"
      expr: SUM(confirmed_fraud_loss_amount)
    - name: "Average Confirmed Fraud Loss Amount"
      expr: AVG(confirmed_fraud_loss_amount)
    - name: "Total Estimated Fraud Loss Amount"
      expr: SUM(estimated_fraud_loss_amount)
    - name: "Average Estimated Fraud Loss Amount"
      expr: AVG(estimated_fraud_loss_amount)
    - name: "Total Fraud Confidence Score"
      expr: SUM(fraud_confidence_score)
    - name: "Average Fraud Confidence Score"
      expr: AVG(fraud_confidence_score)
    - name: "Total Recovery Amount"
      expr: SUM(recovery_amount)
    - name: "Average Recovery Amount"
      expr: AVG(recovery_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_fraud_pattern`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud Pattern business metrics"
  source: "`telecommunication_ecm`.`assurance`.`fraud_pattern`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detection Method"
      expr: detection_method
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fraud Type"
      expr: fraud_type
    - name: "Is Active"
      expr: is_active
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Mitigation Action"
      expr: mitigation_action
    - name: "Notes"
      expr: notes
    - name: "Pattern Category"
      expr: pattern_category
    - name: "Pattern Description"
      expr: pattern_description
    - name: "Pattern Name"
      expr: pattern_name
    - name: "Pattern Status"
      expr: pattern_status
    - name: "Pattern Tags"
      expr: pattern_tags
    - name: "Pattern Version"
      expr: pattern_version
    - name: "Regulatory Compliance Flag"
      expr: regulatory_compliance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fraud Pattern"
      expr: COUNT(DISTINCT fraud_pattern_id)
    - name: "Total Alert Threshold"
      expr: SUM(alert_threshold)
    - name: "Average Alert Threshold"
      expr: AVG(alert_threshold)
    - name: "Total Detection Threshold"
      expr: SUM(detection_threshold)
    - name: "Average Detection Threshold"
      expr: AVG(detection_threshold)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_kpi_threshold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kpi Threshold business metrics"
  source: "`telecommunication_ecm`.`assurance`.`kpi_threshold`"
  dimensions:
    - name: "Applicable Service Type"
      expr: applicable_service_type
    - name: "Auto Ticket Creation Flag"
      expr: auto_ticket_creation_flag
    - name: "Correlated Alarm Types"
      expr: correlated_alarm_types
    - name: "Correlation Window Minutes"
      expr: correlation_window_minutes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detection Logic Description"
      expr: detection_logic_description
    - name: "Detection Method"
      expr: detection_method
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fraud Type"
      expr: fraud_type
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Tuned Timestamp"
      expr: last_tuned_timestamp
    - name: "Measurement Window Minutes"
      expr: measurement_window_minutes
    - name: "Network Domain"
      expr: network_domain
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kpi Threshold"
      expr: COUNT(DISTINCT kpi_threshold_id)
    - name: "Total False Positive Rate Percent"
      expr: SUM(false_positive_rate_percent)
    - name: "Average False Positive Rate Percent"
      expr: AVG(false_positive_rate_percent)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_noc_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Noc Incident business metrics"
  source: "`telecommunication_ecm`.`assurance`.`noc_incident`"
  dimensions:
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Declared Timestamp"
      expr: declared_timestamp
    - name: "Detected Timestamp"
      expr: detected_timestamp
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Impacted Customer Count"
      expr: impacted_customer_count
    - name: "Impacted Geography"
      expr: impacted_geography
    - name: "Impacted Network Elements"
      expr: impacted_network_elements
    - name: "Impacted Services List"
      expr: impacted_services_list
    - name: "Incident Category"
      expr: incident_category
    - name: "Incident Number"
      expr: incident_number
    - name: "Incident Priority"
      expr: incident_priority
    - name: "Incident Source"
      expr: incident_source
    - name: "Incident Status"
      expr: incident_status
    - name: "Incident Type"
      expr: incident_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Noc Incident"
      expr: COUNT(DISTINCT noc_incident_id)
    - name: "Total Estimated Revenue Impact"
      expr: SUM(estimated_revenue_impact)
    - name: "Average Estimated Revenue Impact"
      expr: AVG(estimated_revenue_impact)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage Record business metrics"
  source: "`telecommunication_ecm`.`assurance`.`outage_record`"
  dimensions:
    - name: "Affected Cell Site Ids"
      expr: affected_cell_site_ids
    - name: "Affected Geography"
      expr: affected_geography
    - name: "Affected Region"
      expr: affected_region
    - name: "Affected Service Type"
      expr: affected_service_type
    - name: "Compliance Officer Sign Off Timestamp"
      expr: compliance_officer_sign_off_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Detection Method"
      expr: detection_method
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notification Due Timestamp"
      expr: notification_due_timestamp
    - name: "Notification Submission Timestamp"
      expr: notification_submission_timestamp
    - name: "Outage Cause Category"
      expr: outage_cause_category
    - name: "Outage Cause Description"
      expr: outage_cause_description
    - name: "Outage End Timestamp"
      expr: outage_end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outage Record"
      expr: COUNT(DISTINCT outage_record_id)
    - name: "Total Estimated Revenue Impact"
      expr: SUM(estimated_revenue_impact)
    - name: "Average Estimated Revenue Impact"
      expr: AVG(estimated_revenue_impact)
    - name: "Total Impacted Business Customer Count"
      expr: SUM(impacted_business_customer_count)
    - name: "Average Impacted Business Customer Count"
      expr: AVG(impacted_business_customer_count)
    - name: "Total Impacted Subscriber Count"
      expr: SUM(impacted_subscriber_count)
    - name: "Average Impacted Subscriber Count"
      expr: AVG(impacted_subscriber_count)
    - name: "Total Mttr Target Minutes"
      expr: SUM(mttr_target_minutes)
    - name: "Average Mttr Target Minutes"
      expr: AVG(mttr_target_minutes)
    - name: "Total Outage Duration Minutes"
      expr: SUM(outage_duration_minutes)
    - name: "Average Outage Duration Minutes"
      expr: AVG(outage_duration_minutes)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_performance_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Measurement business metrics"
  source: "`telecommunication_ecm`.`assurance`.`performance_measurement`"
  dimensions:
    - name: "Aggregation Method"
      expr: aggregation_method
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Measurement End Timestamp"
      expr: measurement_end_timestamp
    - name: "Measurement Interval Type"
      expr: measurement_interval_type
    - name: "Measurement Object Reference"
      expr: measurement_object_reference
    - name: "Measurement Object Type"
      expr: measurement_object_type
    - name: "Measurement Reliability Flag"
      expr: measurement_reliability_flag
    - name: "Measurement Source System"
      expr: measurement_source_system
    - name: "Measurement Source System Code"
      expr: measurement_source_system_code
    - name: "Measurement Start Timestamp"
      expr: measurement_start_timestamp
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Network Domain"
      expr: network_domain
    - name: "Notes"
      expr: notes
    - name: "Technology Type"
      expr: technology_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Measurement"
      expr: COUNT(DISTINCT performance_measurement_id)
    - name: "Total Availability Percentage"
      expr: SUM(availability_percentage)
    - name: "Average Availability Percentage"
      expr: AVG(availability_percentage)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Deviation Percentage"
      expr: SUM(deviation_percentage)
    - name: "Average Deviation Percentage"
      expr: AVG(deviation_percentage)
    - name: "Total Measurement Value"
      expr: SUM(measurement_value)
    - name: "Average Measurement Value"
      expr: AVG(measurement_value)
    - name: "Total Sample Count"
      expr: SUM(sample_count)
    - name: "Average Sample Count"
      expr: AVG(sample_count)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_problem_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Problem Record business metrics"
  source: "`telecommunication_ecm`.`assurance`.`problem_record`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Affected Customer Count"
      expr: affected_customer_count
    - name: "Affected Network Domain"
      expr: affected_network_domain
    - name: "Affected Service Type"
      expr: affected_service_type
    - name: "Affected Technology Type"
      expr: affected_technology_type
    - name: "Assigned Problem Manager"
      expr: assigned_problem_manager
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Identified Timestamp"
      expr: identified_timestamp
    - name: "Impact"
      expr: impact
    - name: "Kedb Article Reference"
      expr: kedb_article_reference
    - name: "Known Error Flag"
      expr: known_error_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Permanent Fix Description"
      expr: permanent_fix_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Problem Record"
      expr: COUNT(DISTINCT problem_record_id)
    - name: "Total Estimated Revenue Impact"
      expr: SUM(estimated_revenue_impact)
    - name: "Average Estimated Revenue Impact"
      expr: AVG(estimated_revenue_impact)
    - name: "Total Investigation Duration Hours"
      expr: SUM(investigation_duration_hours)
    - name: "Average Investigation Duration Hours"
      expr: AVG(investigation_duration_hours)
    - name: "Total Resolution Duration Hours"
      expr: SUM(resolution_duration_hours)
    - name: "Average Resolution Duration Hours"
      expr: AVG(resolution_duration_hours)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_sla_breach_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Breach Event business metrics"
  source: "`telecommunication_ecm`.`assurance`.`sla_breach_event`"
  dimensions:
    - name: "Affected Customer Count"
      expr: affected_customer_count
    - name: "Affected Service Type"
      expr: affected_service_type
    - name: "Breach End Timestamp"
      expr: breach_end_timestamp
    - name: "Breach Event Number"
      expr: breach_event_number
    - name: "Breach Severity"
      expr: breach_severity
    - name: "Breach Start Timestamp"
      expr: breach_start_timestamp
    - name: "Breach Status"
      expr: breach_status
    - name: "Breach Type"
      expr: breach_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Impact Level"
      expr: customer_impact_level
    - name: "Customer Notification Channel"
      expr: customer_notification_channel
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Detection Method"
      expr: detection_method
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Dispute Raised Flag"
      expr: dispute_raised_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Breach Event"
      expr: COUNT(DISTINCT sla_breach_event_id)
    - name: "Total Actual Measured Value"
      expr: SUM(actual_measured_value)
    - name: "Average Actual Measured Value"
      expr: AVG(actual_measured_value)
    - name: "Total Breach Deviation Percentage"
      expr: SUM(breach_deviation_percentage)
    - name: "Average Breach Deviation Percentage"
      expr: AVG(breach_deviation_percentage)
    - name: "Total Breach Duration Minutes"
      expr: SUM(breach_duration_minutes)
    - name: "Average Breach Duration Minutes"
      expr: AVG(breach_duration_minutes)
    - name: "Total Contracted Threshold Value"
      expr: SUM(contracted_threshold_value)
    - name: "Average Contracted Threshold Value"
      expr: AVG(contracted_threshold_value)
    - name: "Total Detection Delay Minutes"
      expr: SUM(detection_delay_minutes)
    - name: "Average Detection Delay Minutes"
      expr: AVG(detection_delay_minutes)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_sla_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Contract business metrics"
  source: "`telecommunication_ecm`.`assurance`.`sla_contract`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Breach Notification Required"
      expr: breach_notification_required
    - name: "Breach Threshold Count"
      expr: breach_threshold_count
    - name: "Contract Status"
      expr: contract_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Procedure"
      expr: escalation_procedure
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Source System"
      expr: measurement_source_system
    - name: "Measurement Window"
      expr: measurement_window
    - name: "Notes"
      expr: notes
    - name: "Owner Department"
      expr: owner_department
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Contract"
      expr: COUNT(DISTINCT sla_contract_id)
    - name: "Total Availability Target Percent"
      expr: SUM(availability_target_percent)
    - name: "Average Availability Target Percent"
      expr: AVG(availability_target_percent)
    - name: "Total Jitter Target Ms"
      expr: SUM(jitter_target_ms)
    - name: "Average Jitter Target Ms"
      expr: AVG(jitter_target_ms)
    - name: "Total Latency Target Ms"
      expr: SUM(latency_target_ms)
    - name: "Average Latency Target Ms"
      expr: AVG(latency_target_ms)
    - name: "Total Mttr Target Hours"
      expr: SUM(mttr_target_hours)
    - name: "Average Mttr Target Hours"
      expr: AVG(mttr_target_hours)
    - name: "Total Packet Loss Target Percent"
      expr: SUM(packet_loss_target_percent)
    - name: "Average Packet Loss Target Percent"
      expr: AVG(packet_loss_target_percent)
    - name: "Total Penalty Cap Amount"
      expr: SUM(penalty_cap_amount)
    - name: "Average Penalty Cap Amount"
      expr: AVG(penalty_cap_amount)
    - name: "Total Throughput Target Mbps"
      expr: SUM(throughput_target_mbps)
    - name: "Average Throughput Target Mbps"
      expr: AVG(throughput_target_mbps)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_trouble_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trouble Ticket business metrics"
  source: "`telecommunication_ecm`.`assurance`.`trouble_ticket`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Affected Customer Count"
      expr: affected_customer_count
    - name: "Affected Service Name"
      expr: affected_service_name
    - name: "Affected Subscriber Count"
      expr: affected_subscriber_count
    - name: "Assignee Name"
      expr: assignee_name
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Correlated Alarm Ids"
      expr: correlated_alarm_ids
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Reported Flag"
      expr: customer_reported_flag
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Tier"
      expr: escalation_tier
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Impact Scope"
      expr: impact_scope
    - name: "Opened Timestamp"
      expr: opened_timestamp
    - name: "Priority"
      expr: priority
    - name: "Resolution Code"
      expr: resolution_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trouble Ticket"
      expr: COUNT(DISTINCT trouble_ticket_id)
    - name: "Total Mttr Minutes"
      expr: SUM(mttr_minutes)
    - name: "Average Mttr Minutes"
      expr: AVG(mttr_minutes)
    - name: "Total Outage Duration Minutes"
      expr: SUM(outage_duration_minutes)
    - name: "Average Outage Duration Minutes"
      expr: AVG(outage_duration_minutes)
$$;