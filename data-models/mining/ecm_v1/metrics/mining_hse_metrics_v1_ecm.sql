-- Metric views for domain: hse | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core HSE incident metrics tracking frequency, severity, and regulatory impact of safety and environmental events"
  source: "`mining_ecm`.`hse`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of incident (safety, environmental, near-miss, etc.)"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the incident (critical, major, minor, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (open, under investigation, closed, etc.)"
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Year when the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month when the incident occurred"
    - name: "location_description"
      expr: location_description
      comment: "Physical location where the incident occurred"
    - name: "activity_being_performed"
      expr: activity_being_performed
      comment: "Work activity being performed at time of incident"
    - name: "shift"
      expr: shift
      comment: "Shift during which the incident occurred"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of injury sustained (if applicable)"
    - name: "injury_body_part"
      expr: injury_body_part
      comment: "Body part affected by injury (if applicable)"
    - name: "ltifr_contribution_flag"
      expr: ltifr_contribution_flag
      comment: "Whether incident contributes to Lost Time Injury Frequency Rate"
    - name: "trifr_contribution_flag"
      expr: trifr_contribution_flag
      comment: "Whether incident contributes to Total Recordable Injury Frequency Rate"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Whether formal investigation is required"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether environmental remediation is required"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HSE incidents reported"
    - name: "ltifr_incidents"
      expr: SUM(CASE WHEN ltifr_contribution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents contributing to Lost Time Injury Frequency Rate"
    - name: "trifr_incidents"
      expr: SUM(CASE WHEN trifr_contribution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents contributing to Total Recordable Injury Frequency Rate"
    - name: "total_days_lost"
      expr: SUM(CAST(days_lost AS BIGINT))
      comment: "Total days lost due to injuries across all incidents"
    - name: "total_environmental_volume_released"
      expr: SUM(CAST(environmental_volume_released AS DOUBLE))
      comment: "Total volume of environmental releases (spills, emissions, etc.)"
    - name: "regulatory_notification_incidents"
      expr: SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring regulatory notification"
    - name: "investigation_required_incidents"
      expr: SUM(CASE WHEN investigation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring formal investigation"
    - name: "remediation_required_incidents"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring environmental remediation"
    - name: "avg_days_lost_per_incident"
      expr: AVG(CAST(days_lost AS DOUBLE))
      comment: "Average days lost per incident (severity indicator)"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness and closure metrics tracking HSE improvement initiatives"
  source: "`mining_ecm`.`hse`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of corrective action (open, in progress, closed, overdue)"
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (immediate, preventive, systemic)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "source_trigger_type"
      expr: source_trigger_type
      comment: "What triggered the corrective action (incident, audit, inspection, etc.)"
    - name: "hierarchy_of_controls"
      expr: hierarchy_of_controls
      comment: "Level in hierarchy of controls (elimination, substitution, engineering, admin, PPE)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for completing the action"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Rating of action effectiveness after review"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the corrective action is due"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the corrective action is due"
    - name: "training_required"
      expr: training_required
      comment: "Whether training is required as part of the corrective action"
    - name: "sop_updated"
      expr: sop_updated
      comment: "Whether standard operating procedures were updated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions raised"
    - name: "open_corrective_actions"
      expr: SUM(CASE WHEN action_status IN ('Open', 'In Progress') THEN 1 ELSE 0 END)
      comment: "Count of corrective actions currently open or in progress"
    - name: "closed_corrective_actions"
      expr: SUM(CASE WHEN action_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of corrective actions successfully closed"
    - name: "overdue_corrective_actions"
      expr: SUM(CASE WHEN action_status = 'Overdue' THEN 1 ELSE 0 END)
      comment: "Count of corrective actions past their due date"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions"
    - name: "recurring_issues"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrective actions addressing recurring issues"
    - name: "actions_requiring_training"
      expr: SUM(CASE WHEN training_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrective actions requiring training"
    - name: "sop_updates_completed"
      expr: SUM(CASE WHEN sop_updated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrective actions that resulted in SOP updates"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring compliance and exceedance metrics tracking permit limits and regulatory thresholds"
  source: "`mining_ecm`.`hse`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (air, water, soil, noise, etc.)"
    - name: "parameter_measured"
      expr: parameter_measured
      comment: "Specific environmental parameter being measured"
    - name: "monitoring_point_name"
      expr: monitoring_point_name
      comment: "Name of the monitoring location"
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of the monitoring record (draft, validated, reported)"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the measurement"
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded permit limits"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required due to exceedance"
    - name: "regulatory_report_flag"
      expr: regulatory_report_flag
      comment: "Whether this measurement must be reported to regulators"
    - name: "sampling_year"
      expr: YEAR(sampling_datetime)
      comment: "Year when the sample was collected"
    - name: "sampling_month"
      expr: DATE_TRUNC('MONTH', sampling_datetime)
      comment: "Month when the sample was collected"
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required frequency of monitoring (daily, weekly, monthly, etc.)"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of sampling"
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring records"
    - name: "exceedances"
      expr: SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements exceeding permit limits"
    - name: "corrective_actions_triggered"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of monitoring results requiring corrective action"
    - name: "regulatory_reportable_records"
      expr: SUM(CASE WHEN regulatory_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of records requiring regulatory reporting"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across all monitoring records"
    - name: "avg_permit_limit"
      expr: AVG(CAST(permit_limit AS DOUBLE))
      comment: "Average permit limit across all monitoring records"
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which exceedances exceeded limits"
    - name: "validated_records"
      expr: SUM(CASE WHEN validation_status = 'Validated' THEN 1 ELSE 0 END)
      comment: "Count of monitoring records that have been validated"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE audit and inspection performance metrics tracking compliance findings and certification outcomes"
  source: "`mining_ecm`.`hse`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, certification, regulatory, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in progress, completed, closed)"
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Outcome of certification audit (certified, conditional, not certified)"
    - name: "standard_reference"
      expr: standard_reference
      comment: "Standard or framework being audited against (ISO 14001, ISO 45001, etc.)"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organization conducting the audit"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification body issuing the certificate"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting or requiring the audit"
    - name: "area_inspected"
      expr: area_inspected
      comment: "Physical area or process inspected"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the audit was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the audit was scheduled"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective actions are required from audit findings"
    - name: "environmental_permit_verified"
      expr: environmental_permit_verified
      comment: "Whether environmental permits were verified during audit"
    - name: "ppe_compliance_verified"
      expr: ppe_compliance_verified
      comment: "Whether PPE compliance was verified during audit"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of HSE audits conducted"
    - name: "completed_audits"
      expr: SUM(CASE WHEN audit_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of audits completed"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits that identified need for corrective action"
    - name: "total_major_nonconformances"
      expr: SUM(CAST(major_nonconformance_count AS BIGINT))
      comment: "Total count of major nonconformances identified across all audits"
    - name: "total_minor_nonconformances"
      expr: SUM(CAST(minor_nonconformance_count AS BIGINT))
      comment: "Total count of minor nonconformances identified across all audits"
    - name: "total_observations"
      expr: SUM(CAST(observation_count AS BIGINT))
      comment: "Total count of observations (opportunities for improvement) identified"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total count of all findings (nonconformances + observations)"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit"
    - name: "certifications_achieved"
      expr: SUM(CASE WHEN certification_outcome = 'Certified' THEN 1 ELSE 0 END)
      comment: "Count of successful certifications achieved"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE risk assessment metrics tracking inherent and residual risk levels and control effectiveness"
  source: "`mining_ecm`.`hse`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (job safety analysis, HAZOP, bow-tie, etc.)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, approved, expired, superseded)"
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard being assessed"
    - name: "work_area"
      expr: work_area
      comment: "Work area where the assessed activity takes place"
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Risk level before controls (extreme, high, medium, low)"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Risk level after controls are applied"
    - name: "risk_acceptance_status"
      expr: risk_acceptance_status
      comment: "Whether the residual risk has been accepted by management"
    - name: "control_hierarchy_level"
      expr: control_hierarchy_level
      comment: "Highest level of control in hierarchy (elimination, substitution, engineering, admin, PPE)"
    - name: "control_adequacy_rating"
      expr: control_adequacy_rating
      comment: "Rating of control measure adequacy"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the risk assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the risk assessment was conducted"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted"
    - name: "approved_risk_assessments"
      expr: SUM(CASE WHEN assessment_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of risk assessments that have been approved"
    - name: "extreme_inherent_risks"
      expr: SUM(CASE WHEN inherent_risk_level = 'Extreme' THEN 1 ELSE 0 END)
      comment: "Count of assessments with extreme inherent risk"
    - name: "high_inherent_risks"
      expr: SUM(CASE WHEN inherent_risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of assessments with high inherent risk"
    - name: "extreme_residual_risks"
      expr: SUM(CASE WHEN residual_risk_level = 'Extreme' THEN 1 ELSE 0 END)
      comment: "Count of assessments with extreme residual risk after controls"
    - name: "high_residual_risks"
      expr: SUM(CASE WHEN residual_risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of assessments with high residual risk after controls"
    - name: "accepted_risks"
      expr: SUM(CASE WHEN risk_acceptance_status = 'Accepted' THEN 1 ELSE 0 END)
      comment: "Count of residual risks formally accepted by management"
    - name: "avg_affected_personnel"
      expr: AVG(CAST(affected_personnel_count AS DOUBLE))
      comment: "Average number of personnel affected per risk assessment"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE training completion and competency metrics tracking workforce capability and compliance"
  source: "`mining_ecm`.`hse`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (induction, refresher, competency, regulatory, etc.)"
    - name: "training_status"
      expr: training_status
      comment: "Status of the training record (scheduled, completed, failed, expired)"
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status (attended, absent, partial)"
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of training assessment (pass, fail, not assessed)"
    - name: "competency_level"
      expr: competency_level
      comment: "Competency level achieved (basic, intermediate, advanced, expert)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (classroom, online, on-the-job, simulator)"
    - name: "training_code"
      expr: training_code
      comment: "Unique code identifying the training course"
    - name: "training_title"
      expr: training_title
      comment: "Title of the training course"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the training was completed"
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Whether a certificate was issued upon completion"
    - name: "assessment_required"
      expr: assessment_required
      comment: "Whether assessment was required for this training"
    - name: "regulatory_requirement"
      expr: regulatory_requirement
      comment: "Regulatory requirement driving the training need"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records"
    - name: "completed_training"
      expr: SUM(CASE WHEN training_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of training courses completed"
    - name: "passed_assessments"
      expr: SUM(CASE WHEN assessment_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of training assessments passed"
    - name: "failed_assessments"
      expr: SUM(CASE WHEN assessment_result = 'Fail' THEN 1 ELSE 0 END)
      comment: "Count of training assessments failed"
    - name: "certificates_issued"
      expr: SUM(CASE WHEN certificate_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of training certificates issued"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training delivered"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training record"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_safety_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proactive safety observation and leading indicator metrics tracking hazard identification and intervention effectiveness"
  source: "`mining_ecm`.`hse`.`safety_observation`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of safety observation (positive, at-risk behavior, unsafe condition, near-miss)"
    - name: "observation_status"
      expr: observation_status
      comment: "Current status of the observation (open, closed, under review)"
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard observed"
    - name: "leading_indicator_category"
      expr: leading_indicator_category
      comment: "Leading indicator category for proactive safety metrics"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the observed hazard or behavior"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the observed hazard or behavior"
    - name: "work_activity"
      expr: work_activity
      comment: "Work activity being performed when observation was made"
    - name: "work_area"
      expr: work_area
      comment: "Work area where observation was made"
    - name: "observer_role"
      expr: observer_role
      comment: "Role of the person making the observation"
    - name: "observation_year"
      expr: YEAR(observation_timestamp)
      comment: "Year the observation was made"
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_timestamp)
      comment: "Month the observation was made"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required"
    - name: "stop_work_authority_exercised_flag"
      expr: stop_work_authority_exercised_flag
      comment: "Whether stop work authority was exercised"
    - name: "ppe_compliance_flag"
      expr: ppe_compliance_flag
      comment: "Whether PPE compliance was observed"
    - name: "fatigue_indicator_flag"
      expr: fatigue_indicator_flag
      comment: "Whether fatigue was identified as a contributing factor"
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of safety observations recorded"
    - name: "positive_observations"
      expr: SUM(CASE WHEN observation_type = 'Positive' THEN 1 ELSE 0 END)
      comment: "Count of positive safety observations (safe behaviors)"
    - name: "at_risk_observations"
      expr: SUM(CASE WHEN observation_type = 'At-Risk Behavior' THEN 1 ELSE 0 END)
      comment: "Count of at-risk behavior observations"
    - name: "unsafe_condition_observations"
      expr: SUM(CASE WHEN observation_type = 'Unsafe Condition' THEN 1 ELSE 0 END)
      comment: "Count of unsafe condition observations"
    - name: "near_miss_observations"
      expr: SUM(CASE WHEN observation_type = 'Near-Miss' THEN 1 ELSE 0 END)
      comment: "Count of near-miss observations"
    - name: "observations_requiring_followup"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observations requiring follow-up action"
    - name: "stop_work_exercises"
      expr: SUM(CASE WHEN stop_work_authority_exercised_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of times stop work authority was exercised"
    - name: "ppe_non_compliance_observations"
      expr: SUM(CASE WHEN ppe_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of observations where PPE non-compliance was identified"
    - name: "fatigue_related_observations"
      expr: SUM(CASE WHEN fatigue_indicator_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observations where fatigue was a factor"
    - name: "closed_observations"
      expr: SUM(CASE WHEN observation_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of safety observations that have been closed"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental permit compliance and financial assurance metrics tracking regulatory obligations"
  source: "`mining_ecm`.`hse`.`environmental_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (air, water, waste, mining, etc.)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (active, expired, suspended, pending renewal)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the permit (compliant, non-compliant, under review)"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Government authority that issued the permit"
    - name: "regulated_activity"
      expr: regulated_activity
      comment: "Activity regulated by the permit"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required frequency of compliance reporting"
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required frequency of environmental monitoring"
    - name: "financial_assurance_required_flag"
      expr: financial_assurance_required_flag
      comment: "Whether financial assurance (bond) is required"
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Whether enforcement action has been taken"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the permit was issued"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the permit expires"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of environmental permits held"
    - name: "active_permits"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active environmental permits"
    - name: "compliant_permits"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of permits in compliance"
    - name: "non_compliant_permits"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of permits with non-compliance issues"
    - name: "permits_with_enforcement_action"
      expr: SUM(CASE WHEN enforcement_action_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of permits subject to enforcement action"
    - name: "total_financial_assurance"
      expr: SUM(CAST(financial_assurance_amount AS DOUBLE))
      comment: "Total financial assurance (bonds) held across all permits"
    - name: "permits_requiring_assurance"
      expr: SUM(CASE WHEN financial_assurance_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of permits requiring financial assurance"
    - name: "avg_financial_assurance"
      expr: AVG(CAST(financial_assurance_amount AS DOUBLE))
      comment: "Average financial assurance amount per permit"
    - name: "total_non_compliances"
      expr: SUM(CAST(non_compliance_count AS BIGINT))
      comment: "Total count of non-compliance events across all permits"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_management_of_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Management of change effectiveness and risk control metrics tracking process safety and operational changes"
  source: "`mining_ecm`.`hse`.`management_of_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (permanent, temporary, emergency)"
    - name: "change_category"
      expr: change_category
      comment: "Category of change (process, equipment, personnel, procedure, etc.)"
    - name: "moc_status"
      expr: moc_status
      comment: "Current status of the management of change (draft, under review, approved, implemented, closed)"
    - name: "approval_workflow_stage"
      expr: approval_workflow_stage
      comment: "Current stage in the approval workflow"
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Risk level before change controls (extreme, high, medium, low)"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Risk level after change controls are applied"
    - name: "affected_area"
      expr: affected_area
      comment: "Area affected by the change"
    - name: "affected_process"
      expr: affected_process
      comment: "Process affected by the change"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required for the change"
    - name: "pssr_required_flag"
      expr: pssr_required_flag
      comment: "Whether pre-startup safety review is required"
    - name: "sop_updated_flag"
      expr: sop_updated_flag
      comment: "Whether standard operating procedures have been updated"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the MOC was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the MOC was submitted"
  measures:
    - name: "total_mocs"
      expr: COUNT(1)
      comment: "Total number of management of change records"
    - name: "approved_mocs"
      expr: SUM(CASE WHEN moc_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of MOCs that have been approved"
    - name: "implemented_mocs"
      expr: SUM(CASE WHEN moc_status = 'Implemented' THEN 1 ELSE 0 END)
      comment: "Count of MOCs that have been implemented"
    - name: "closed_mocs"
      expr: SUM(CASE WHEN moc_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of MOCs that have been closed"
    - name: "high_risk_mocs"
      expr: SUM(CASE WHEN inherent_risk_level IN ('High', 'Extreme') THEN 1 ELSE 0 END)
      comment: "Count of MOCs with high or extreme inherent risk"
    - name: "mocs_requiring_training"
      expr: SUM(CASE WHEN training_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MOCs requiring training"
    - name: "mocs_requiring_pssr"
      expr: SUM(CASE WHEN pssr_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MOCs requiring pre-startup safety review"
    - name: "sop_updates_completed"
      expr: SUM(CASE WHEN sop_updated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MOCs where SOPs have been updated"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MOCs"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for MOCs"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per MOC"
$$;