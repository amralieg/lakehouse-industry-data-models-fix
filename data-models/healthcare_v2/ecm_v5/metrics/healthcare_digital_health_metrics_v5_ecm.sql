-- Metric views for domain: digital_health | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_rpm_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core RPM enrollment metrics tracking program participation, patient engagement, and enrollment lifecycle for remote patient monitoring programs."
  source: "`healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, terminated, pending) for filtering program participation"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which patient was enrolled (referral, self-enroll, care management)"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for RPM data collection and sharing"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for program termination to identify retention barriers"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for trend analysis"
    - name: "data_retention_policy"
      expr: data_retention_policy
      comment: "HIPAA data retention policy applied to enrollment records"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total RPM enrollment records for program sizing and capacity planning"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Currently active RPM enrollments indicating real-time program load"
    - name: "terminated_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'terminated' THEN 1 END)
      comment: "Terminated enrollments for attrition analysis"
    - name: "avg_portal_engagement_score"
      expr: AVG(CAST(portal_engagement_score AS DOUBLE))
      comment: "Average patient portal engagement score indicating digital health adoption"
    - name: "avg_alert_threshold_value"
      expr: AVG(CAST(alert_threshold_value AS DOUBLE))
      comment: "Average alert threshold configured per enrollment for clinical sensitivity analysis"
    - name: "consented_enrollments"
      expr: COUNT(CASE WHEN consent_status = 'granted' THEN 1 END)
      comment: "Enrollments with active patient consent for compliance reporting"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients enrolled in RPM programs across the enterprise"
    - name: "avg_prom_measure_value"
      expr: AVG(CAST(prom_measure_value AS DOUBLE))
      comment: "Average patient-reported outcome measure value for clinical effectiveness tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_rpm_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM device reading metrics tracking measurement volume, alert rates, and data quality for remote patient monitoring clinical operations."
  source: "`healthcare_ecm_v1`.`digital_health`.`rpm_reading`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of physiological measurement (blood pressure, glucose, weight, SpO2)"
    - name: "reading_status"
      expr: reading_status
      comment: "Status of the reading (valid, pending review, rejected)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the reading value"
    - name: "signal_quality"
      expr: signal_quality
      comment: "Signal quality indicator for data reliability assessment"
    - name: "source_system"
      expr: source_system
      comment: "Source device system for vendor performance comparison"
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of reading for temporal trend analysis"
    - name: "alert_flag"
      expr: CAST(alert_flag AS STRING)
      comment: "Whether reading triggered a clinical alert"
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total device readings received for volume and capacity monitoring"
    - name: "alert_triggered_readings"
      expr: COUNT(CASE WHEN alert_flag = true THEN 1 END)
      comment: "Readings that triggered clinical alerts requiring provider intervention"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across readings for population health trending"
    - name: "distinct_patients_with_readings"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients submitting readings indicating program adherence"
    - name: "distinct_devices_active"
      expr: COUNT(DISTINCT device_id)
      comment: "Unique devices transmitting data for fleet management"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average configured threshold for clinical sensitivity benchmarking"
    - name: "readings_with_consent"
      expr: COUNT(CASE WHEN patient_consent = true THEN 1 END)
      comment: "Readings with verified patient consent for compliance audit"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_rpm_device_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed RPM device reading metrics with clinical review tracking, alert severity analysis, and data quality indicators for operational monitoring."
  source: "`healthcare_ecm_v1`.`digital_health`.`rpm_device_reading`"
  dimensions:
    - name: "reading_type"
      expr: reading_type
      comment: "Clinical reading type classification for measure-specific analysis"
    - name: "reading_status"
      expr: reading_status
      comment: "Processing status of the device reading"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of triggered alerts (critical, high, medium, low)"
    - name: "transmission_method"
      expr: transmission_method
      comment: "How reading was transmitted (Bluetooth, cellular, WiFi, manual)"
    - name: "quality_indicator"
      expr: quality_indicator
      comment: "Data quality flag for reading reliability assessment"
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Whether reading is outside normal clinical range"
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of reading for trend analysis"
    - name: "is_manually_entered"
      expr: CAST(is_manually_entered AS STRING)
      comment: "Whether reading was manually entered vs device-transmitted"
  measures:
    - name: "total_device_readings"
      expr: COUNT(1)
      comment: "Total device readings for volume tracking and billing (CPT 99457/99458)"
    - name: "alert_triggered_count"
      expr: COUNT(CASE WHEN is_alert_triggered = true THEN 1 END)
      comment: "Readings triggering alerts for clinical workload planning"
    - name: "clinician_reviewed_count"
      expr: COUNT(CASE WHEN clinician_reviewed_flag = true THEN 1 END)
      comment: "Readings reviewed by clinician for care quality and billing compliance"
    - name: "avg_numeric_value"
      expr: AVG(CAST(value_numeric AS DOUBLE))
      comment: "Average primary reading value for population health trending"
    - name: "avg_device_battery_pct"
      expr: AVG(CAST(device_battery_pct AS DOUBLE))
      comment: "Average device battery level for proactive device management"
    - name: "manually_entered_readings"
      expr: COUNT(CASE WHEN is_manually_entered = true THEN 1 END)
      comment: "Manually entered readings indicating potential device connectivity issues"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with device readings for adherence tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_health_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical health alert metrics tracking alert volume, severity distribution, resolution performance, and response times for RPM clinical operations."
  source: "`healthcare_ecm_v1`.`digital_health`.`health_alert`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Alert severity level for clinical prioritization (critical, high, medium, low)"
    - name: "alert_category"
      expr: alert_category
      comment: "Category of health alert (vital sign, medication, activity, symptom)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the alert (open, acknowledged, resolved, escalated)"
    - name: "notification_method"
      expr: notification_method
      comment: "How the alert was delivered (SMS, call, in-app, EHR inbox)"
    - name: "metric_name"
      expr: metric_name
      comment: "Clinical metric that triggered the alert (BP, glucose, weight, SpO2)"
    - name: "alert_month"
      expr: DATE_TRUNC('month', alert_timestamp)
      comment: "Month of alert for trend analysis"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total health alerts generated for clinical workload assessment"
    - name: "critical_alerts"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Critical severity alerts requiring immediate clinical intervention"
    - name: "resolved_alerts"
      expr: COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END)
      comment: "Alerts that have been clinically resolved for closure rate calculation"
    - name: "open_alerts"
      expr: COUNT(CASE WHEN resolution_status = 'open' THEN 1 END)
      comment: "Currently open alerts indicating pending clinical workload"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value at time of alert for threshold calibration"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value that triggered alerts for sensitivity tuning"
    - name: "distinct_patients_alerted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with alerts for high-risk patient identification"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_prom_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-Reported Outcome Measure (PROM) response metrics tracking survey completion, clinical scores, and alert generation for value-based care quality measurement."
  source: "`healthcare_ecm_v1`.`digital_health`.`prom_response`"
  dimensions:
    - name: "prom_response_status"
      expr: prom_response_status
      comment: "Response completion status (completed, partial, abandoned)"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which PROM was completed (portal, tablet, phone, paper)"
    - name: "interpretation"
      expr: interpretation
      comment: "Clinical interpretation of the PROM score (normal, mild, moderate, severe)"
    - name: "data_source"
      expr: data_source
      comment: "Source system for the PROM response"
    - name: "language_code"
      expr: language_code
      comment: "Language in which PROM was administered for health equity analysis"
    - name: "response_month"
      expr: DATE_TRUNC('month', response_timestamp)
      comment: "Month of response for longitudinal outcome tracking"
    - name: "alert_triggered"
      expr: CAST(alert_triggered AS STRING)
      comment: "Whether PROM score triggered a clinical alert"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total PROM responses collected for program participation tracking"
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average PROM total score for population-level outcome measurement"
    - name: "alert_triggered_responses"
      expr: COUNT(CASE WHEN alert_triggered = true THEN 1 END)
      comment: "Responses triggering clinical alerts for intervention workload planning"
    - name: "consented_responses"
      expr: COUNT(CASE WHEN consent_given = true THEN 1 END)
      comment: "Responses with verified consent for research and quality reporting eligibility"
    - name: "distinct_patients_responding"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients completing PROMs for engagement and adherence tracking"
    - name: "distinct_questionnaires_used"
      expr: COUNT(DISTINCT prom_questionnaire_id)
      comment: "Number of distinct PROM instruments in use for program breadth assessment"
    - name: "test_responses"
      expr: COUNT(CASE WHEN is_test_response = true THEN 1 END)
      comment: "Test responses to exclude from clinical reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_portal_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal engagement event metrics tracking digital health adoption, portal utilization patterns, and patient activation for consumer experience optimization."
  source: "`healthcare_ecm_v1`.`digital_health`.`portal_engagement_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of portal event (login, message_sent, appointment_scheduled, lab_viewed, bill_paid)"
    - name: "event_outcome"
      expr: event_outcome
      comment: "Outcome of the portal event (success, failure, abandoned)"
    - name: "device_type"
      expr: device_type
      comment: "Device used for portal access (mobile, desktop, tablet) for UX optimization"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of event for adoption trend analysis"
  measures:
    - name: "total_portal_events"
      expr: COUNT(1)
      comment: "Total portal engagement events for digital adoption measurement"
    - name: "successful_events"
      expr: COUNT(CASE WHEN event_outcome = 'success' THEN 1 END)
      comment: "Successfully completed portal events for usability assessment"
    - name: "failed_events"
      expr: COUNT(CASE WHEN event_outcome = 'failure' THEN 1 END)
      comment: "Failed portal events indicating technical or UX issues requiring remediation"
    - name: "distinct_active_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients engaging with portal for digital adoption rate calculation"
    - name: "distinct_sessions"
      expr: COUNT(DISTINCT portal_session_code)
      comment: "Unique portal sessions for session-level engagement analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_rpm_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM program-level metrics tracking program portfolio, billing rates, and operational configuration for strategic program management and financial planning."
  source: "`healthcare_ecm_v1`.`digital_health`.`rpm_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of RPM program (chronic disease, post-surgical, maternal, cardiac)"
    - name: "rpm_program_status"
      expr: rpm_program_status
      comment: "Current program status (active, pilot, suspended, retired)"
    - name: "device_type"
      expr: device_type
      comment: "Primary device type used in the program"
    - name: "sensor_type"
      expr: sensor_type
      comment: "Sensor technology used for clinical measurements"
    - name: "is_pilot_program"
      expr: CAST(is_pilot_program AS STRING)
      comment: "Whether program is in pilot phase for portfolio maturity assessment"
    - name: "data_capture_frequency"
      expr: data_capture_frequency
      comment: "Required data capture frequency for compliance monitoring"
    - name: "portal_access_enabled"
      expr: CAST(portal_access_enabled AS STRING)
      comment: "Whether patient portal access is enabled for the program"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total RPM programs in portfolio for strategic planning"
    - name: "active_programs"
      expr: COUNT(CASE WHEN rpm_program_status = 'active' THEN 1 END)
      comment: "Currently active RPM programs for operational capacity assessment"
    - name: "pilot_programs"
      expr: COUNT(CASE WHEN is_pilot_program = true THEN 1 END)
      comment: "Programs in pilot phase for innovation pipeline tracking"
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across programs for revenue forecasting"
    - name: "total_billing_rate_capacity"
      expr: SUM(CAST(billing_rate AS DOUBLE))
      comment: "Total billing rate capacity across all programs for revenue potential"
    - name: "avg_alert_threshold_value"
      expr: AVG(CAST(alert_threshold_value AS DOUBLE))
      comment: "Average alert threshold across programs for clinical sensitivity benchmarking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_device`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM device fleet metrics tracking device inventory, connectivity health, calibration status, and lifecycle management for biomedical engineering operations."
  source: "`healthcare_ecm_v1`.`digital_health`.`device`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of monitoring device (blood pressure cuff, glucometer, pulse oximeter, scale)"
    - name: "device_category"
      expr: device_category
      comment: "Device category for fleet segmentation"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current deployment status (deployed, available, maintenance, decommissioned)"
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Connectivity method (Bluetooth, cellular, WiFi) for infrastructure planning"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Patient enrollment status of the device"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Device manufacturer for vendor performance comparison"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the device"
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total devices in fleet for inventory and capital planning"
    - name: "deployed_devices"
      expr: COUNT(CASE WHEN deployment_status = 'deployed' THEN 1 END)
      comment: "Currently deployed devices for utilization rate calculation"
    - name: "calibrated_devices"
      expr: COUNT(CASE WHEN is_calibrated = true THEN 1 END)
      comment: "Devices with current calibration for quality assurance"
    - name: "secure_devices"
      expr: COUNT(CASE WHEN is_secure = true THEN 1 END)
      comment: "Devices meeting security requirements for HIPAA compliance"
    - name: "firmware_updates_available"
      expr: COUNT(CASE WHEN firmware_update_available = true THEN 1 END)
      comment: "Devices with pending firmware updates for patch management"
    - name: "avg_last_reading_value"
      expr: AVG(CAST(last_reading_value AS DOUBLE))
      comment: "Average last reading value across fleet for data flow health monitoring"
    - name: "avg_alert_threshold_value"
      expr: AVG(CAST(alert_threshold_value AS DOUBLE))
      comment: "Average alert threshold configured on devices"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_patient_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient digital health engagement metrics tracking engagement scores, channel effectiveness, and activation patterns for consumer experience strategy."
  source: "`healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement activity for behavioral segmentation"
    - name: "engagement_channel"
      expr: engagement_channel
      comment: "Channel of engagement (app, portal, SMS, email, phone) for omnichannel strategy"
    - name: "content_category"
      expr: content_category
      comment: "Category of content engaged with for content strategy optimization"
    - name: "device_type"
      expr: device_type
      comment: "Device used for engagement for platform optimization"
    - name: "referral_source"
      expr: referral_source
      comment: "How patient was referred to digital engagement for acquisition analysis"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether engagement is currently active"
    - name: "is_first_engagement"
      expr: CAST(is_first_engagement AS STRING)
      comment: "Whether this is patient's first digital engagement for activation tracking"
    - name: "engagement_month"
      expr: DATE_TRUNC('month', engagement_datetime)
      comment: "Month of engagement for trend analysis"
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total digital health engagement events for volume trending"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score for patient activation level assessment"
    - name: "first_time_engagements"
      expr: COUNT(CASE WHEN is_first_engagement = true THEN 1 END)
      comment: "First-time digital engagements for new patient activation tracking"
    - name: "active_engagements"
      expr: COUNT(CASE WHEN is_active = true THEN 1 END)
      comment: "Currently active engagements for real-time program health"
    - name: "distinct_engaged_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with digital engagement for adoption rate calculation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`digital_health_rpm_alert_threshold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM alert threshold configuration metrics tracking threshold distribution, severity patterns, and evaluation outcomes for clinical decision support optimization."
  source: "`healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Configured severity level for alert prioritization analysis"
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold (absolute, relative, trend-based)"
    - name: "rpm_alert_threshold_status"
      expr: rpm_alert_threshold_status
      comment: "Current status of the threshold configuration (active, suspended, expired)"
    - name: "notification_channel"
      expr: notification_channel
      comment: "Configured notification delivery channel"
    - name: "metric_name"
      expr: metric_name
      comment: "Clinical metric being monitored (systolic BP, diastolic BP, glucose, weight)"
    - name: "escalation_policy"
      expr: escalation_policy
      comment: "Escalation policy for unacknowledged alerts"
  measures:
    - name: "total_thresholds"
      expr: COUNT(1)
      comment: "Total configured alert thresholds for clinical decision support coverage"
    - name: "active_thresholds"
      expr: COUNT(CASE WHEN rpm_alert_threshold_status = 'active' THEN 1 END)
      comment: "Currently active thresholds for operational monitoring load"
    - name: "avg_upper_threshold"
      expr: AVG(CAST(upper_threshold AS DOUBLE))
      comment: "Average upper threshold for clinical sensitivity benchmarking"
    - name: "avg_lower_threshold"
      expr: AVG(CAST(lower_threshold AS DOUBLE))
      comment: "Average lower threshold for clinical sensitivity benchmarking"
    - name: "distinct_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with configured thresholds for monitoring coverage assessment"
$$;