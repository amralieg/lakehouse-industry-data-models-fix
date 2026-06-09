-- Metric views for domain: hse | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident KPIs tracking frequency, severity, and regulatory exposure across mining operations. Used by HSE leadership to monitor safety performance, drive LTIFR/TRIFR targets, and manage regulatory notification obligations."
  source: "`mining_ecm`.`hse`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g. injury, near-miss, environmental spill) for segmenting safety performance by event category."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity tier of the incident (e.g. High, Medium, Low) enabling prioritisation of response and trend analysis by risk level."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (e.g. Open, Under Investigation, Closed) for workload and closure rate tracking."
    - name: "shift"
      expr: shift
      comment: "Shift during which the incident occurred (Day/Night/Afternoon) to identify shift-pattern safety risks."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Calendar month of incident occurrence for time-series trend analysis of safety performance."
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Calendar year of incident occurrence for annual safety performance benchmarking."
    - name: "investigation_report_status"
      expr: investigation_report_status
      comment: "Status of the investigation report (e.g. Draft, Final, Overdue) to track investigation completion discipline."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification (e.g. Notified, Pending, Not Required) for compliance monitoring."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded incidents. Baseline KPI for absolute safety event volume used in LTIFR/TRIFR rate calculations and board safety dashboards."
    - name: "ltifr_contributing_incidents"
      expr: COUNT(CASE WHEN ltifr_contribution_flag = TRUE THEN incident_id END)
      comment: "Count of incidents that contribute to the Lost Time Injury Frequency Rate (LTIFR). Core input to the industry-standard LTIFR safety KPI reported to boards and regulators."
    - name: "trifr_contributing_incidents"
      expr: COUNT(CASE WHEN trifr_contribution_flag = TRUE THEN incident_id END)
      comment: "Count of incidents contributing to the Total Recordable Injury Frequency Rate (TRIFR). Tracks all recordable injuries including medical treatment cases, restricted work, and lost time."
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity_classification IN ('High', 'Critical', 'Fatality') THEN incident_id END)
      comment: "Count of high-severity incidents requiring executive escalation, regulatory notification, and board-level visibility. Directly linked to workforce safety outcomes and licence-to-operate risk."
    - name: "incidents_requiring_investigation"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN incident_id END)
      comment: "Count of incidents flagged as requiring formal investigation. Tracks investigation workload and ensures no serious incidents are left uninvestigated."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN incident_id END)
      comment: "Count of incidents currently open and unresolved. Elevated open counts signal systemic closure failures and unresolved safety risks."
    - name: "regulatory_notification_required_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN incident_id END)
      comment: "Count of incidents requiring regulatory notification. Failure to notify regulators on time is a compliance breach with licence and financial consequences."
    - name: "environmental_incidents"
      expr: COUNT(CASE WHEN incident_type = 'Environmental' THEN incident_id END)
      comment: "Count of environmental incidents (spills, exceedances, land disturbance). Tracks environmental liability exposure and permit compliance risk."
    - name: "total_environmental_volume_released"
      expr: SUM(CAST(environmental_volume_released AS DOUBLE))
      comment: "Total volume of material released to the environment across all environmental incidents. Quantifies environmental impact severity for regulatory reporting and remediation planning."
    - name: "remediation_required_incidents"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN incident_id END)
      comment: "Count of incidents requiring environmental or physical remediation. Drives remediation cost provisioning and project planning."
    - name: "investigation_overdue_incidents"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE AND investigation_report_status NOT IN ('Final', 'Closed') AND investigation_completion_date < CURRENT_DATE() THEN incident_id END)
      comment: "Count of incidents where investigation is overdue (past completion date but not finalised). Overdue investigations indicate governance failures and regulatory risk."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action management KPIs tracking closure rates, overdue actions, cost, and effectiveness across HSE events. Used by HSE managers to ensure timely resolution of safety and environmental findings and demonstrate continuous improvement."
  source: "`mining_ecm`.`hse`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. Open, In Progress, Closed, Overdue) for workload and closure tracking."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Engineering Control, Administrative, PPE) aligned to hierarchy of controls."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action (e.g. Critical, High, Medium, Low) for resource allocation decisions."
    - name: "source_trigger_type"
      expr: source_trigger_type
      comment: "The event type that triggered the corrective action (e.g. Incident, Audit, Observation) for root cause pattern analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for completing the corrective action, enabling departmental performance benchmarking."
    - name: "hierarchy_of_controls"
      expr: hierarchy_of_controls
      comment: "Control hierarchy level applied (Elimination, Substitution, Engineering, Administrative, PPE) to assess quality of risk controls implemented."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Post-closure effectiveness rating of the corrective action to assess whether controls are working as intended."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the corrective action is due, for scheduling and overdue trend analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions raised. Baseline volume metric for HSE action management workload."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN corrective_action_id END)
      comment: "Count of corrective actions currently open. High open counts indicate systemic closure failures and unresolved safety risks."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN action_status != 'Closed' AND due_date < CURRENT_DATE() THEN corrective_action_id END)
      comment: "Count of corrective actions past their due date and not yet closed. Overdue actions are a leading indicator of deteriorating HSE governance and regulatory non-compliance risk."
    - name: "corrective_action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Closed' THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been closed. Key governance KPI — low closure rates signal systemic failure to address identified hazards and findings."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions flagged as recurring issues. High recurrence rates indicate root causes are not being effectively addressed, a critical safety governance failure."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all corrective actions. Quantifies the financial impact of HSE remediation and informs budget provisioning."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting and cost-benefit analysis of control improvements."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Aggregate variance between actual and estimated corrective action costs. Positive variance indicates cost overruns in HSE remediation programs."
    - name: "high_priority_open_actions"
      expr: COUNT(CASE WHEN priority IN ('Critical', 'High') AND action_status != 'Closed' THEN corrective_action_id END)
      comment: "Count of high-priority corrective actions still open. Directly tracks the most critical unresolved safety and compliance risks requiring executive attention."
    - name: "sop_update_required_actions"
      expr: COUNT(CASE WHEN sop_updated = FALSE AND action_status = 'Closed' THEN corrective_action_id END)
      comment: "Count of closed corrective actions where the SOP was not updated. Indicates gaps in procedural learning and systemic risk of recurrence."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs tracking permit exceedances, measurement compliance, and regulatory reporting obligations. Used by environmental managers and regulators to assess environmental performance against permit limits and drive corrective action."
  source: "`mining_ecm`.`hse`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (e.g. Water Quality, Air Quality, Noise, Dust) for segmenting environmental performance by media."
    - name: "parameter_measured"
      expr: parameter_measured
      comment: "Specific environmental parameter being measured (e.g. pH, TSS, PM10) for parameter-level compliance analysis."
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of the monitoring record (e.g. Validated, Pending, Exceedance) for data quality and compliance tracking."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status (e.g. Validated, Rejected, Pending) to assess data quality and regulatory defensibility."
    - name: "monitoring_point_code"
      expr: monitoring_point_code
      comment: "Unique code identifying the monitoring location for spatial analysis of environmental performance."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency (e.g. Daily, Weekly, Monthly) for compliance scheduling and gap analysis."
    - name: "sampling_month"
      expr: DATE_TRUNC('MONTH', sampling_datetime)
      comment: "Month of sample collection for time-series trend analysis of environmental parameters."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the monitored parameter, ensuring correct interpretation of measurement values."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring records. Baseline measure for monitoring program coverage and data completeness."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN environmental_monitoring_id END)
      comment: "Count of monitoring results that exceeded permit limits. Core environmental compliance KPI — exceedances trigger regulatory notification and corrective action obligations."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN environmental_monitoring_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring results exceeding permit limits. Tracks overall environmental compliance performance and permit breach risk."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measurements exceed permit limits. Quantifies the magnitude of exceedances, distinguishing minor breaches from significant environmental events."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage recorded. Identifies worst-case environmental breaches requiring immediate escalation and regulatory notification."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN environmental_monitoring_id END)
      comment: "Count of monitoring results requiring corrective action. Tracks the volume of environmental issues requiring active remediation."
    - name: "regulatory_report_flagged_count"
      expr: COUNT(CASE WHEN regulatory_report_flag = TRUE THEN environmental_monitoring_id END)
      comment: "Count of monitoring results flagged for regulatory reporting. Ensures all reportable environmental events are captured and submitted to regulators on time."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across monitoring records for a given parameter and location. Used to assess baseline environmental conditions and trend against permit limits."
    - name: "validated_records_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'Validated' THEN environmental_monitoring_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring records that have been formally validated. Low validation rates indicate data quality risks that could undermine regulatory defensibility."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental permit portfolio KPIs tracking compliance status, enforcement actions, and renewal obligations. Used by environmental and legal teams to manage licence-to-operate risk and ensure permit conditions are met."
  source: "`mining_ecm`.`hse`.`environmental_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (e.g. Water Licence, Air Emissions, Waste Discharge) for portfolio segmentation."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g. Active, Expired, Suspended, Under Renewal) for licence-to-operate risk monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against permit conditions (e.g. Compliant, Non-Compliant, Conditional) for regulatory risk assessment."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the permit, enabling jurisdiction-level compliance analysis."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process (e.g. Not Started, In Progress, Submitted, Approved) for renewal pipeline management."
    - name: "regulated_activity"
      expr: regulated_activity
      comment: "The regulated activity covered by the permit (e.g. Mining, Processing, Tailings Storage) for activity-level compliance tracking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency under the permit (e.g. Monthly, Quarterly, Annual) for compliance scheduling."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of environmental permits in the portfolio. Baseline measure for licence-to-operate coverage and regulatory footprint."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN environmental_permit_id END)
      comment: "Count of currently active environmental permits. Tracks the operational permit portfolio underpinning the licence to operate."
    - name: "non_compliant_permits"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN environmental_permit_id END)
      comment: "Count of permits in non-compliant status. Each non-compliant permit represents a regulatory breach risk with potential for enforcement action, fines, or suspension."
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN environmental_permit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits in compliant status. Core licence-to-operate KPI reported to boards and regulators — declining compliance rate signals systemic environmental governance failure."
    - name: "permits_with_enforcement_action"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN environmental_permit_id END)
      comment: "Count of permits subject to active enforcement action. Enforcement actions represent the most severe regulatory risk, potentially halting operations."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN environmental_permit_id END)
      comment: "Count of permits expiring within the next 90 days. Proactive renewal management KPI — expired permits without renewal constitute an immediate licence-to-operate breach."
    - name: "permits_requiring_financial_assurance"
      expr: COUNT(CASE WHEN financial_assurance_required_flag = TRUE THEN environmental_permit_id END)
      comment: "Count of permits requiring financial assurance (bonds, guarantees). Tracks financial liability exposure associated with environmental obligations."
    - name: "overdue_reporting_permits"
      expr: COUNT(CASE WHEN next_reporting_due_date < CURRENT_DATE() AND permit_status = 'Active' THEN environmental_permit_id END)
      comment: "Count of active permits where the next regulatory report is overdue. Overdue reports are a direct compliance breach with regulatory notification consequences."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment portfolio KPIs tracking residual risk levels, control adequacy, and assessment currency. Used by HSE and operations leadership to ensure all significant hazards are assessed, controlled, and reviewed on schedule."
  source: "`mining_ecm`.`hse`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g. JSEA, HAZOP, Bow-Tie, Quantitative) for portfolio segmentation by methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g. Active, Expired, Under Review, Superseded) for currency monitoring."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls are applied (e.g. Low, Medium, High, Extreme). Core risk portfolio KPI for executive risk reporting."
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls (e.g. Low, Medium, High, Extreme). Used to assess the effectiveness of controls by comparing to residual risk."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard being assessed (e.g. Ground Stability, Explosives, Electrical, Chemical) for hazard-type risk portfolio analysis."
    - name: "control_hierarchy_level"
      expr: control_hierarchy_level
      comment: "Highest level of control applied (Elimination through PPE) to assess the quality of risk controls across the portfolio."
    - name: "risk_acceptance_status"
      expr: risk_acceptance_status
      comment: "Whether the residual risk has been formally accepted (Accepted, Not Accepted, Conditional) for governance and accountability tracking."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the risk assessment was conducted for temporal analysis of risk assessment program activity."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments in the portfolio. Baseline measure for risk management program coverage."
    - name: "high_extreme_residual_risk_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Extreme') THEN risk_assessment_id END)
      comment: "Count of risk assessments with High or Extreme residual risk after controls. These represent the most critical uncontrolled hazards requiring executive attention and priority resource allocation."
    - name: "expired_risk_assessments"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND assessment_status = 'Active' THEN risk_assessment_id END)
      comment: "Count of risk assessments past their expiry date. Expired assessments mean work is proceeding without current risk controls — a critical safety governance failure."
    - name: "risk_assessment_currency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiry_date >= CURRENT_DATE() AND assessment_status = 'Active' THEN risk_assessment_id END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Active' THEN risk_assessment_id END), 0), 2)
      comment: "Percentage of active risk assessments that are current (not expired). Low currency rates indicate the risk register is out of date, undermining the safety management system."
    - name: "control_effectiveness_gap_count"
      expr: COUNT(CASE WHEN inherent_risk_level IN ('High', 'Extreme') AND residual_risk_level IN ('High', 'Extreme') THEN risk_assessment_id END)
      comment: "Count of assessments where controls have not reduced a High/Extreme inherent risk to an acceptable residual level. Identifies hazards where current controls are inadequate and additional investment is required."
    - name: "overdue_review_assessments"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND assessment_status = 'Active' THEN risk_assessment_id END)
      comment: "Count of active risk assessments overdue for scheduled review. Overdue reviews indicate the risk register is not being maintained, creating regulatory and safety liability."
    - name: "unaccepted_residual_risk_count"
      expr: COUNT(CASE WHEN risk_acceptance_status = 'Not Accepted' THEN risk_assessment_id END)
      comment: "Count of risk assessments where residual risk has not been formally accepted. Unaccepted risks require escalation and additional control investment before work can proceed safely."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE audit and certification KPIs tracking audit outcomes, non-conformance rates, and corrective action obligations. Used by HSE and compliance teams to manage audit program effectiveness and certification currency."
  source: "`mining_ecm`.`hse`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g. Internal, External, Regulatory, Certification) for segmenting audit program performance."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g. Planned, In Progress, Completed, Overdue) for audit program management."
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Outcome of certification audits (e.g. Certified, Conditional, Failed) for certification portfolio management."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (e.g. Safety Management System, Environmental, Quality) for coverage analysis."
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organisation conducting the audit (internal team or external body) for auditor performance benchmarking."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month the audit commenced for time-series analysis of audit program activity."
    - name: "standard_reference"
      expr: standard_reference
      comment: "Standard or framework being audited against (e.g. ISO 45001, ISO 14001, ICMM) for standards compliance tracking."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline measure for audit program activity and coverage."
    - name: "audits_with_corrective_action_required"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN audit_id END)
      comment: "Count of audits that identified findings requiring corrective action. Tracks the volume of compliance gaps identified through the audit program."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN audit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in corrective action requirements. High rates indicate systemic compliance gaps; declining rates indicate improving HSE management system maturity."
    - name: "ppe_non_compliance_audits"
      expr: COUNT(CASE WHEN ppe_compliance_verified = FALSE THEN audit_id END)
      comment: "Count of audits where PPE compliance was not verified or failed. PPE non-compliance is a leading indicator of injury risk and a common regulatory finding."
    - name: "environmental_permit_non_verified_audits"
      expr: COUNT(CASE WHEN environmental_permit_verified = FALSE THEN audit_id END)
      comment: "Count of audits where environmental permit compliance was not verified. Unverified permit compliance represents direct regulatory breach risk."
    - name: "overdue_corrective_action_audits"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE() THEN audit_id END)
      comment: "Count of audits with corrective actions past their due date. Overdue audit corrective actions indicate governance failures and repeat finding risk."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN audit_id END)
      comment: "Count of certifications expiring within 90 days. Proactive certification renewal KPI — lapsed certifications (e.g. ISO 45001) can affect customer contracts and regulatory standing."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE training compliance KPIs tracking competency currency, certification status, and training cost. Used by HSE and HR leadership to ensure workforce competency obligations are met and regulatory training requirements are fulfilled."
  source: "`mining_ecm`.`hse`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g. Induction, Refresher, Competency Assessment, Emergency Response) for training program segmentation."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (e.g. Completed, In Progress, Overdue, Not Started) for compliance tracking."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance outcome (e.g. Attended, Absent, Partial) for participation rate analysis."
    - name: "competency_level"
      expr: competency_level
      comment: "Competency level achieved (e.g. Novice, Competent, Proficient, Expert) for workforce capability assessment."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e.g. Classroom, Online, On-the-Job, Simulation) for program effectiveness analysis."
    - name: "training_title"
      expr: training_title
      comment: "Title of the training course for course-level compliance and completion analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month training was completed for time-series analysis of training program delivery."
    - name: "regulatory_requirement"
      expr: regulatory_requirement
      comment: "Regulatory requirement the training fulfils (e.g. Mining Act, Explosives Regulation) for regulatory compliance tracking."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records. Baseline measure for training program volume and workforce coverage."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN training_record_id END)
      comment: "Count of completed training records. Tracks training program delivery against plan."
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_status = 'Completed' THEN training_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records with completed status. Core workforce competency KPI — low completion rates indicate regulatory compliance risk and workforce safety exposure."
    - name: "overdue_refresher_training_count"
      expr: COUNT(CASE WHEN refresher_due_date < CURRENT_DATE() AND training_status != 'Completed' THEN training_record_id END)
      comment: "Count of training records where refresher training is overdue. Overdue refreshers indicate lapsed competencies, creating safety and regulatory compliance risk."
    - name: "expired_certificates_count"
      expr: COUNT(CASE WHEN certificate_issued = TRUE AND certificate_expiry_date < CURRENT_DATE() THEN training_record_id END)
      comment: "Count of training certificates that have expired. Expired certificates mean personnel may be operating without current authorisation, a direct regulatory and safety risk."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training records. Tracks workforce competency levels and identifies training programs with poor knowledge retention."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_result = 'Pass' THEN training_record_id END) / NULLIF(COUNT(CASE WHEN assessment_required = TRUE THEN training_record_id END), 0), 2)
      comment: "Percentage of assessed training records where the participant passed. Low pass rates indicate training program effectiveness issues or workforce competency gaps."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training delivered. Tracks HSE training investment and enables cost-per-competency analysis for budget optimisation."
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of training delivered across the workforce. Measures training program scale and workforce time investment in competency development."
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training record. Enables benchmarking of training delivery efficiency across methods and providers."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_safety_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety observation (leading indicator) KPIs tracking observation volumes, hazard identification rates, and follow-up closure. Used by HSE leadership to monitor proactive safety culture and leading indicator performance against lagging injury metrics."
  source: "`mining_ecm`.`hse`.`safety_observation`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of safety observation (e.g. Safe Act, Unsafe Act, Unsafe Condition, Near Miss) for leading indicator categorisation."
    - name: "observation_status"
      expr: observation_status
      comment: "Current status of the observation (e.g. Open, Closed, In Progress) for follow-up management."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating assigned to the observation for risk-weighted leading indicator analysis."
    - name: "leading_indicator_category"
      expr: leading_indicator_category
      comment: "Leading indicator category (e.g. Housekeeping, Isolation, Working at Height) for hazard type trend analysis."
    - name: "observer_role"
      expr: observer_role
      comment: "Role of the person making the observation (e.g. Supervisor, Worker, Manager) for safety culture participation analysis."
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', observation_timestamp)
      comment: "Month the observation was recorded for time-series leading indicator trend analysis."
    - name: "work_activity"
      expr: work_activity
      comment: "Work activity during which the observation was made for activity-level safety risk analysis."
  measures:
    - name: "total_safety_observations"
      expr: COUNT(1)
      comment: "Total number of safety observations recorded. Primary leading indicator KPI — high observation volumes indicate an active safety culture and proactive hazard identification."
    - name: "unsafe_act_or_condition_observations"
      expr: COUNT(CASE WHEN observation_type IN ('Unsafe Act', 'Unsafe Condition') THEN safety_observation_id END)
      comment: "Count of observations identifying unsafe acts or conditions. Tracks the volume of active hazards identified before they cause incidents — a critical leading safety indicator."
    - name: "stop_work_authority_exercised_count"
      expr: COUNT(CASE WHEN stop_work_authority_exercised_flag = TRUE THEN safety_observation_id END)
      comment: "Count of observations where Stop Work Authority was exercised. Tracks workforce empowerment to halt unsafe work — a key safety culture indicator and critical risk control."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN safety_observation_id END)
      comment: "Count of observations requiring follow-up action. Tracks the volume of identified hazards requiring active remediation."
    - name: "observation_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN observation_status = 'Closed' THEN safety_observation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety observations that have been closed. Low closure rates indicate identified hazards are not being actioned, undermining the value of the observation program."
    - name: "ppe_non_compliance_observations"
      expr: COUNT(CASE WHEN ppe_compliance_flag = FALSE THEN safety_observation_id END)
      comment: "Count of observations where PPE non-compliance was identified. Tracks PPE compliance as a leading indicator of injury risk."
    - name: "fatigue_indicator_observations"
      expr: COUNT(CASE WHEN fatigue_indicator_flag = TRUE THEN safety_observation_id END)
      comment: "Count of observations flagging fatigue indicators. Fatigue is a major causal factor in mining incidents — tracking fatigue observations enables proactive workforce management intervention."
    - name: "overdue_follow_up_observations"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND observation_status != 'Closed' AND due_date < CURRENT_DATE() THEN safety_observation_id END)
      comment: "Count of observations with overdue follow-up actions. Overdue follow-ups indicate identified hazards remain unaddressed, increasing incident risk."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission compliance KPIs tracking on-time submission rates, response outcomes, and corrective action obligations. Used by compliance and legal teams to manage regulatory reporting obligations and avoid enforcement action."
  source: "`mining_ecm`.`hse`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g. Annual Environmental Report, Incident Notification, Licence Application) for obligation-type compliance analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g. Draft, Submitted, Accepted, Rejected, Overdue) for pipeline management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority receiving the submission for jurisdiction-level compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory submission (e.g. State, Federal, International) for multi-jurisdictional compliance management."
    - name: "response_outcome"
      expr: response_outcome
      comment: "Outcome of the regulatory body's response (e.g. Accepted, Rejected, Requires Amendment) for submission quality analysis."
    - name: "frequency"
      expr: frequency
      comment: "Required submission frequency (e.g. Monthly, Quarterly, Annual) for compliance scheduling."
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year of the reporting period for annual compliance performance benchmarking."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline measure for regulatory reporting program volume."
    - name: "on_time_submission_count"
      expr: COUNT(CASE WHEN submission_date <= due_date AND submission_status = 'Submitted' THEN regulatory_submission_id END)
      comment: "Count of submissions made on or before the due date. Core regulatory compliance KPI — late submissions constitute a direct regulatory breach."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= due_date AND submission_status = 'Submitted' THEN regulatory_submission_id END) / NULLIF(COUNT(CASE WHEN submission_status = 'Submitted' THEN regulatory_submission_id END), 0), 2)
      comment: "Percentage of submissions made on time. Declining on-time rates signal systemic regulatory compliance failures with enforcement and reputational consequences."
    - name: "overdue_submissions"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND submission_status NOT IN ('Submitted', 'Accepted') THEN regulatory_submission_id END)
      comment: "Count of submissions past their due date and not yet submitted. Each overdue submission is an active regulatory breach requiring immediate escalation."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN response_outcome = 'Rejected' THEN regulatory_submission_id END)
      comment: "Count of submissions rejected by the regulatory authority. Rejections require resubmission and may trigger enforcement scrutiny — tracking rejection rates identifies quality improvement opportunities."
    - name: "corrective_action_required_submissions"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN regulatory_submission_id END)
      comment: "Count of submissions where the regulator has required corrective action. Tracks the volume of regulatory-directed remediation obligations."
    - name: "acknowledgement_received_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_received = TRUE THEN regulatory_submission_id END) / NULLIF(COUNT(CASE WHEN submission_status = 'Submitted' THEN regulatory_submission_id END), 0), 2)
      comment: "Percentage of submitted reports for which regulatory acknowledgement has been received. Unacknowledged submissions may indicate delivery failures or regulatory processing issues."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`hse_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident investigation KPIs tracking investigation timeliness, cost impact, and root cause identification. Used by HSE leadership to ensure serious incidents are investigated thoroughly and learnings are captured to prevent recurrence."
  source: "`mining_ecm`.`hse`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g. Incident, Near Miss, Environmental, Audit Finding) for investigation program segmentation."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (e.g. Open, In Progress, Closed, Overdue) for workload and closure tracking."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the investigated event for risk-weighted investigation performance analysis."
    - name: "investigation_method"
      expr: investigation_method
      comment: "Investigation methodology used (e.g. 5-Why, Bow-Tie, ICAM) for methodology effectiveness analysis."
    - name: "investigation_year"
      expr: YEAR(initiated_date)
      comment: "Year the investigation was initiated for annual investigation program performance benchmarking."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the investigated event had an environmental impact, for environmental investigation portfolio tracking."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations initiated. Baseline measure for investigation program volume."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'Open' THEN investigation_id END)
      comment: "Count of investigations currently open. Elevated open counts indicate investigation backlog and unresolved safety learnings."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN investigation_id END)
      comment: "Count of investigations past their target completion date. Overdue investigations delay corrective action implementation and regulatory notification, increasing liability."
    - name: "investigation_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_status = 'Closed' THEN investigation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been closed. Low closure rates indicate systemic investigation governance failures and delayed learning implementation."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of investigated events. Quantifies the financial consequence of incidents and informs investment in preventive controls."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total operational downtime hours attributed to investigated events. Directly quantifies production impact of safety and environmental incidents."
    - name: "regulatory_notification_required_investigations"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN investigation_id END)
      comment: "Count of investigations requiring regulatory notification. Tracks the volume of serious events with mandatory reporting obligations."
    - name: "corrective_actions_required_investigations"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN investigation_id END)
      comment: "Count of investigations that identified corrective actions. Tracks the volume of investigations generating actionable safety improvements."
$$;