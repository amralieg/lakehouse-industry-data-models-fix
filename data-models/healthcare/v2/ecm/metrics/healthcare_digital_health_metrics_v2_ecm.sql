-- Metric views for domain: digital_health | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_digital_health_portal_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital Health Portal Engagement Event business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`digital_health_portal_engagement_event`"
  dimensions:
    - name: "Appointment Action Flag"
      expr: appointment_action_flag
    - name: "Bill Pay Action Flag"
      expr: bill_pay_action_flag
    - name: "Browser Type"
      expr: browser_type
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Document Type"
      expr: document_type
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Error Code"
      expr: error_code
    - name: "Error Description"
      expr: error_description
    - name: "Event Category"
      expr: event_category
    - name: "Event Date"
      expr: event_date
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Feature Name"
      expr: feature_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Digital Health Portal Engagement Event"
      expr: COUNT(DISTINCT digital_health_portal_engagement_event_id)
    - name: "Total Session Duration Seconds"
      expr: SUM(session_duration_seconds)
    - name: "Average Session Duration Seconds"
      expr: AVG(session_duration_seconds)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_digital_health_prom_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital Health Prom Response business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`digital_health_prom_response`"
  dimensions:
    - name: "Administered Timestamp"
      expr: administered_timestamp
    - name: "Administration Method"
      expr: administration_method
    - name: "Administration Mode"
      expr: administration_mode
    - name: "Alert Triggered Flag"
      expr: alert_triggered_flag
    - name: "Alert Type"
      expr: alert_type
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Collection Date"
      expr: collection_date
    - name: "Collection Method"
      expr: collection_method
    - name: "Collection Setting"
      expr: collection_setting
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Follow Up Completed Flag"
      expr: follow_up_completed_flag
    - name: "Follow Up Required Flag"
      expr: follow_up_required_flag
    - name: "Gad7 Total Score"
      expr: gad7_total_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Digital Health Prom Response"
      expr: COUNT(DISTINCT digital_health_prom_response_id)
    - name: "Total Completion Rate Pct"
      expr: SUM(completion_rate_pct)
    - name: "Average Completion Rate Pct"
      expr: AVG(completion_rate_pct)
    - name: "Total Domain Fatigue Score"
      expr: SUM(domain_fatigue_score)
    - name: "Average Domain Fatigue Score"
      expr: AVG(domain_fatigue_score)
    - name: "Total Domain Mental Health Score"
      expr: SUM(domain_mental_health_score)
    - name: "Average Domain Mental Health Score"
      expr: AVG(domain_mental_health_score)
    - name: "Total Domain Pain Score"
      expr: SUM(domain_pain_score)
    - name: "Average Domain Pain Score"
      expr: AVG(domain_pain_score)
    - name: "Total Domain Physical Function Score"
      expr: SUM(domain_physical_function_score)
    - name: "Average Domain Physical Function Score"
      expr: AVG(domain_physical_function_score)
    - name: "Total Domain Social Participation Score"
      expr: SUM(domain_social_participation_score)
    - name: "Average Domain Social Participation Score"
      expr: AVG(domain_social_participation_score)
    - name: "Total Raw Score"
      expr: SUM(raw_score)
    - name: "Average Raw Score"
      expr: AVG(raw_score)
    - name: "Total Response Numeric Score"
      expr: SUM(response_numeric_score)
    - name: "Average Response Numeric Score"
      expr: AVG(response_numeric_score)
    - name: "Total Response Value"
      expr: SUM(response_value)
    - name: "Average Response Value"
      expr: AVG(response_value)
    - name: "Total Score Change From Baseline"
      expr: SUM(score_change_from_baseline)
    - name: "Average Score Change From Baseline"
      expr: AVG(score_change_from_baseline)
    - name: "Total T Score"
      expr: SUM(t_score)
    - name: "Average T Score"
      expr: AVG(t_score)
    - name: "Total Total Score"
      expr: SUM(total_score)
    - name: "Average Total Score"
      expr: AVG(total_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_digital_health_rpm_alert_threshold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital Health Rpm Alert Threshold business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`digital_health_rpm_alert_threshold`"
  dimensions:
    - name: "Alert Notification Method"
      expr: alert_notification_method
    - name: "Alert Recipient Role"
      expr: alert_recipient_role
    - name: "Alert Severity"
      expr: alert_severity
    - name: "Alert Severity Lower Critical"
      expr: alert_severity_lower_critical
    - name: "Alert Severity Upper Critical"
      expr: alert_severity_upper_critical
    - name: "Consecutive Readings Required"
      expr: consecutive_readings_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Escalation Rule"
      expr: escalation_rule
    - name: "Is Active"
      expr: is_active
    - name: "Is Active Flag"
      expr: is_active_flag
    - name: "Loinc Code"
      expr: loinc_code
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Reading Type"
      expr: reading_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Digital Health Rpm Alert Threshold"
      expr: COUNT(DISTINCT digital_health_rpm_alert_threshold_id)
    - name: "Total Clinical Rationale"
      expr: SUM(clinical_rationale)
    - name: "Average Clinical Rationale"
      expr: AVG(clinical_rationale)
    - name: "Total High Critical Value"
      expr: SUM(high_critical_value)
    - name: "Average High Critical Value"
      expr: AVG(high_critical_value)
    - name: "Total High Warning Value"
      expr: SUM(high_warning_value)
    - name: "Average High Warning Value"
      expr: AVG(high_warning_value)
    - name: "Total Low Critical Value"
      expr: SUM(low_critical_value)
    - name: "Average Low Critical Value"
      expr: AVG(low_critical_value)
    - name: "Total Low Warning Value"
      expr: SUM(low_warning_value)
    - name: "Average Low Warning Value"
      expr: AVG(low_warning_value)
    - name: "Total Lower Critical Value"
      expr: SUM(lower_critical_value)
    - name: "Average Lower Critical Value"
      expr: AVG(lower_critical_value)
    - name: "Total Lower Warning Value"
      expr: SUM(lower_warning_value)
    - name: "Average Lower Warning Value"
      expr: AVG(lower_warning_value)
    - name: "Total Upper Critical Value"
      expr: SUM(upper_critical_value)
    - name: "Average Upper Critical Value"
      expr: AVG(upper_critical_value)
    - name: "Total Upper Warning Value"
      expr: SUM(upper_warning_value)
    - name: "Average Upper Warning Value"
      expr: AVG(upper_warning_value)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_digital_health_rpm_device_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital Health Rpm Device Reading business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`digital_health_rpm_device_reading`"
  dimensions:
    - name: "Alert Acknowledged By"
      expr: alert_acknowledged_by
    - name: "Alert Acknowledged Flag"
      expr: alert_acknowledged_flag
    - name: "Alert Acknowledged Timestamp"
      expr: alert_acknowledged_timestamp
    - name: "Alert Severity"
      expr: alert_severity
    - name: "Alert Triggered Flag"
      expr: alert_triggered_flag
    - name: "Context Code"
      expr: context_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source"
      expr: data_source
    - name: "Device Identifier"
      expr: device_identifier
    - name: "Device Manufacturer"
      expr: device_manufacturer
    - name: "Device Model"
      expr: device_model
    - name: "Device Serial Number"
      expr: device_serial_number
    - name: "Device Type"
      expr: device_type
    - name: "Diastolic Bp"
      expr: diastolic_bp
    - name: "Ehr Sync Timestamp"
      expr: ehr_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Digital Health Rpm Device Reading"
      expr: COUNT(DISTINCT digital_health_rpm_device_reading_id)
    - name: "Total Diastolic Mmhg"
      expr: SUM(diastolic_mmhg)
    - name: "Average Diastolic Mmhg"
      expr: AVG(diastolic_mmhg)
    - name: "Total Glucose Mg Dl"
      expr: SUM(glucose_mg_dl)
    - name: "Average Glucose Mg Dl"
      expr: AVG(glucose_mg_dl)
    - name: "Total Heart Rate Bpm"
      expr: SUM(heart_rate_bpm)
    - name: "Average Heart Rate Bpm"
      expr: AVG(heart_rate_bpm)
    - name: "Total Measurement Value"
      expr: SUM(measurement_value)
    - name: "Average Measurement Value"
      expr: AVG(measurement_value)
    - name: "Total Reading Value"
      expr: SUM(reading_value)
    - name: "Average Reading Value"
      expr: AVG(reading_value)
    - name: "Total Respiratory Rate Bpm"
      expr: SUM(respiratory_rate_bpm)
    - name: "Average Respiratory Rate Bpm"
      expr: AVG(respiratory_rate_bpm)
    - name: "Total Spo2 Percent"
      expr: SUM(spo2_percent)
    - name: "Average Spo2 Percent"
      expr: AVG(spo2_percent)
    - name: "Total Systolic Mmhg"
      expr: SUM(systolic_mmhg)
    - name: "Average Systolic Mmhg"
      expr: AVG(systolic_mmhg)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_digital_health_rpm_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital Health Rpm Program Enrollment business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`digital_health_rpm_program_enrollment`"
  dimensions:
    - name: "Billing Code"
      expr: billing_code
    - name: "Billing Eligible Flag"
      expr: billing_eligible_flag
    - name: "Billing Month"
      expr: billing_month
    - name: "Billing Threshold Met Flag"
      expr: billing_threshold_met_flag
    - name: "Condition Managed"
      expr: condition_managed
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Document Reference"
      expr: consent_document_reference
    - name: "Consent Obtained Flag"
      expr: consent_obtained_flag
    - name: "Cpt Code Primary"
      expr: cpt_code_primary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Identifier"
      expr: device_identifier
    - name: "Device Issued Date"
      expr: device_issued_date
    - name: "Device Issued Flag"
      expr: device_issued_flag
    - name: "Device Type List"
      expr: device_type_list
    - name: "Disenrollment Date"
      expr: disenrollment_date
    - name: "Disenrollment Reason"
      expr: disenrollment_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Digital Health Rpm Program Enrollment"
      expr: COUNT(DISTINCT digital_health_rpm_program_enrollment_id)
    - name: "Total Adherence Rate"
      expr: SUM(adherence_rate)
    - name: "Average Adherence Rate"
      expr: AVG(adherence_rate)
    - name: "Total Monitoring Duration Days"
      expr: SUM(monitoring_duration_days)
    - name: "Average Monitoring Duration Days"
      expr: AVG(monitoring_duration_days)
    - name: "Total Monthly Reimbursement Amount"
      expr: SUM(monthly_reimbursement_amount)
    - name: "Average Monthly Reimbursement Amount"
      expr: AVG(monthly_reimbursement_amount)
    - name: "Total Patient Compliance Rate"
      expr: SUM(patient_compliance_rate)
    - name: "Average Patient Compliance Rate"
      expr: AVG(patient_compliance_rate)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_portal_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portal Session business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`portal_session`"
  dimensions:
    - name: "Access Channel"
      expr: access_channel
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Browser Name"
      expr: browser_name
    - name: "Consent Acknowledged Flag"
      expr: consent_acknowledged_flag
    - name: "Device Identifier"
      expr: device_identifier
    - name: "Device Type"
      expr: device_type
    - name: "Failed Login Attempts"
      expr: failed_login_attempts
    - name: "Geo Country"
      expr: geo_country
    - name: "Geo Region"
      expr: geo_region
    - name: "Ip Address"
      expr: ip_address
    - name: "Last Activity Timestamp"
      expr: last_activity_timestamp
    - name: "Locale Preference"
      expr: locale_preference
    - name: "Login Timestamp"
      expr: login_timestamp
    - name: "Logout Timestamp"
      expr: logout_timestamp
    - name: "Mfa Completed"
      expr: mfa_completed
    - name: "Operating System"
      expr: operating_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Portal Session"
      expr: COUNT(DISTINCT portal_session_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_rpm_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rpm Enrollment business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rpm Enrollment"
      expr: COUNT(DISTINCT rpm_enrollment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_secure_message_thread`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Secure Message Thread business metrics"
  source: "`vibe_healthcare_v1`.`digital_health`.`secure_message_thread`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Closed Reason"
      expr: closed_reason
    - name: "Consent On File"
      expr: consent_on_file
    - name: "Escalation Status"
      expr: escalation_status
    - name: "First Response At"
      expr: first_response_at
    - name: "Has Attachment"
      expr: has_attachment
    - name: "Is Archived"
      expr: is_archived
    - name: "Is Clinical"
      expr: is_clinical
    - name: "Language Code"
      expr: language_code
    - name: "Last Message At"
      expr: last_message_at
    - name: "Message Count"
      expr: message_count
    - name: "Opened At"
      expr: opened_at
    - name: "Priority"
      expr: priority
    - name: "Requires Response"
      expr: requires_response
    - name: "Resolved At"
      expr: resolved_at
    - name: "Response Due At"
      expr: response_due_at
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Secure Message Thread"
      expr: COUNT(DISTINCT secure_message_thread_id)
$$;