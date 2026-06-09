-- Metric views for domain: safety | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the safety incident register. Tracks incident frequency, severity, lost-time injury rates, and property damage exposure to steer HSE performance and regulatory compliance."
  source: "`construction_ecm`.`safety`.`incident`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables incident rate benchmarking across projects."
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g., near-miss, first-aid, LTI, fatality) for severity trending."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident — critical for risk prioritisation and executive reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause grouping to identify systemic safety failures."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (open, under investigation, closed)."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating a Lost Time Injury — key regulatory and performance metric."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating OSHA recordability — drives regulatory reporting obligations."
    - name: "is_environmental_event"
      expr: is_environmental_event
      comment: "Flag for environmental incidents — supports environmental compliance tracking."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (employee, subcontractor, visitor) for workforce safety segmentation."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred — identifies shift-based risk patterns."
    - name: "site_area"
      expr: site_area
      comment: "Physical area of the site where the incident occurred — supports spatial risk analysis."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', CAST(occurred_at AS DATE))
      comment: "Month of incident occurrence — enables trend analysis over time."
    - name: "incident_date_year"
      expr: YEAR(CAST(occurred_at AS DATE))
      comment: "Year of incident occurrence — supports annual performance benchmarking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded incidents. Baseline KPI for incident frequency tracking and TRIR calculation inputs."
    - name: "total_lti_incidents"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of Lost Time Injuries. Core safety KPI used in LTIFR calculations and executive HSE dashboards."
    - name: "total_osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Drives regulatory reporting and TRIR benchmarking."
    - name: "total_environmental_incidents"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of environmental incidents. Tracks environmental liability exposure and regulatory notification obligations."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total financial value of property damage from incidents. Directly informs insurance, cost recovery, and risk management decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Benchmarks incident severity in financial terms for risk prioritisation."
    - name: "lti_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lti = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that resulted in a Lost Time Injury. Key executive safety performance indicator."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable. Tracks regulatory compliance exposure across projects."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of incidents not yet closed. Indicates backlog of unresolved safety events requiring management attention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over incident investigations. Tracks investigation closure rates, corrective action status, LTI classification, and regulatory reportability to ensure systemic safety issues are resolved."
  source: "`construction_ecm`.`safety`.`incident_investigation`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables investigation performance comparison across projects."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in-progress, closed) — tracks closure performance."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g., RCA, 5-Why, Bow-Tie)."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the incident under investigation — supports systemic pattern analysis."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Formal classification of the incident (e.g., near-miss, recordable, LTI, fatality)."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation — tracks remediation progress."
    - name: "is_lti"
      expr: is_lti
      comment: "Lost Time Injury flag — segments investigations by severity for executive reporting."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for investigations with regulatory reporting obligations — critical compliance dimension."
    - name: "root_cause_description"
      expr: root_cause_description
      comment: "Root cause narrative — supports qualitative analysis of systemic safety failures."
    - name: "investigation_start_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month investigation was initiated — enables trend analysis of investigation volumes."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations. Baseline measure for investigation workload and throughput."
    - name: "closed_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END)
      comment: "Count of fully closed investigations. Tracks resolution throughput and backlog clearance."
    - name: "investigation_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been closed. Key operational KPI for HSE management effectiveness."
    - name: "regulatory_reportable_investigations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations with regulatory reporting obligations. Tracks compliance exposure and notification workload."
    - name: "lti_investigations"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of investigations involving Lost Time Injuries. Core input to LTIFR and executive safety scorecards."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Count of investigations with open corrective actions. Indicates unresolved systemic risks requiring management intervention."
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status IN ('Closed', 'Completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations where corrective actions are completed. Measures effectiveness of the safety improvement cycle."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_close_date, investigation_start_date))
      comment: "Average number of days from investigation start to close. Benchmarks investigation efficiency and identifies bottlenecks."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over HSE field inspections. Tracks inspection pass rates, PPE compliance, deficiency rates, and stop-work orders to drive proactive safety management on site."
  source: "`construction_ecm`.`safety`.`hse_inspection`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables inspection performance benchmarking across projects."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection (e.g., routine, pre-start, regulatory) — segments inspection outcomes by purpose."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, in-progress, completed, overdue)."
    - name: "overall_result"
      expr: overall_result
      comment: "Pass/fail/conditional result of the inspection — primary outcome dimension."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Whether the inspection was planned or reactive — distinguishes proactive vs. reactive safety activity."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Flag indicating a stop-work order was issued — highest-severity inspection outcome."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective actions were raised — tracks remediation demand from inspections."
    - name: "site_area"
      expr: site_area
      comment: "Site area inspected — enables spatial risk analysis and targeted intervention."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — supports trend analysis of inspection frequency and outcomes."
    - name: "drill_type"
      expr: drill_type
      comment: "Type of emergency drill conducted during inspection — tracks emergency preparedness activity."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of HSE inspections conducted. Baseline measure for inspection programme activity."
    - name: "inspections_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of inspections resulting in a stop-work order. Critical safety KPI indicating severe non-compliance events."
    - name: "stop_work_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in stop-work orders. Tracks severity of non-compliance across the inspection programme."
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across inspections. Directly measures worker safety behaviour and training effectiveness."
    - name: "avg_drill_muster_accuracy_pct"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage across emergency drills. Measures emergency preparedness effectiveness."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections that raised corrective actions. Tracks volume of safety deficiencies requiring remediation."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that required corrective action. Key indicator of site safety compliance health."
    - name: "scheduled_inspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that were planned vs. reactive. Measures proactive safety management maturity."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the HSE audit register. Tracks compliance scores, finding rates, stop-work orders, and audit closure performance to support regulatory compliance and governance reporting."
  source: "`construction_ecm`.`safety`.`audit`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables compliance benchmarking across projects."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, third-party) — segments compliance performance by audit regime."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit scope (e.g., HSE, environmental, quality) — supports domain-specific compliance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (planned, in-progress, closed) — tracks audit programme execution."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating assigned to the audit — primary outcome dimension for governance reporting."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Flag indicating a stop-work order was issued as a result of the audit — highest-severity outcome."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag for audits requiring regulatory notification — tracks compliance obligations."
    - name: "immediate_action_required"
      expr: immediate_action_required
      comment: "Flag indicating immediate corrective action was required — segments critical audit findings."
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard assessed during the audit — enables compliance tracking by standard."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit — supports trend analysis of audit programme activity and compliance scores."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline measure for audit programme activity and coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits. Primary KPI for HSE governance performance — tracked at executive and board level."
    - name: "audits_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of audits resulting in stop-work orders. Tracks the most severe compliance failures requiring immediate intervention."
    - name: "audits_requiring_immediate_action"
      expr: COUNT(CASE WHEN immediate_action_required = TRUE THEN 1 END)
      comment: "Count of audits with immediate action requirements. Measures critical non-compliance exposure across the audit programme."
    - name: "regulatory_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring regulatory notification. Tracks regulatory compliance exposure and notification workload."
    - name: "audit_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that have been closed. Measures audit programme completion and governance effectiveness."
    - name: "open_audits"
      expr: COUNT(CASE WHEN audit_status NOT IN ('Closed') THEN 1 END)
      comment: "Count of audits not yet closed. Indicates outstanding compliance obligations and governance backlog."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the Permit to Work register. Tracks permit issuance, active permits, environmental impact flags, isolation requirements, and gas testing compliance to manage high-risk work authorisation."
  source: "`construction_ecm`.`safety`.`permit_to_work`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables PTW compliance benchmarking across projects."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., hot work, confined space, electrical isolation) — segments risk by work category."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (issued, active, suspended, closed) — tracks permit lifecycle."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work — enables risk-stratified permit analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of authority required to approve the permit — tracks governance compliance."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Flag indicating energy isolation is required — critical safety control for high-risk work."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Flag indicating gas testing is required before work commences — tracks confined space and hot work safety controls."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag for permits with environmental impact — supports environmental compliance tracking."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flag indicating a toolbox meeting was conducted before work — measures pre-work safety briefing compliance."
    - name: "permit_issue_month"
      expr: DATE_TRUNC('MONTH', CAST(issued_timestamp AS DATE))
      comment: "Month permit was issued — supports trend analysis of high-risk work authorisation volumes."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits to work issued. Baseline measure for high-risk work authorisation activity."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Count of currently active permits. Tracks concurrent high-risk work exposure on site."
    - name: "permits_with_isolation"
      expr: COUNT(CASE WHEN isolation_required = TRUE THEN 1 END)
      comment: "Count of permits requiring energy isolation. Measures volume of highest-risk work requiring lockout/tagout controls."
    - name: "permits_with_gas_test"
      expr: COUNT(CASE WHEN gas_test_required = TRUE THEN 1 END)
      comment: "Count of permits requiring gas testing. Tracks confined space and atmospheric hazard work volumes."
    - name: "tbm_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where a toolbox meeting was conducted. Measures pre-work safety briefing compliance — key leading indicator."
    - name: "environmental_impact_permit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits with environmental impact. Tracks environmental risk exposure from permitted work activities."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN permit_status = 'Suspended' THEN 1 END)
      comment: "Count of suspended permits. Indicates active safety interventions halting high-risk work — requires management attention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the risk assessment register. Tracks risk reduction effectiveness, residual risk profiles, corrective action rates, and assessment currency to support proactive risk management."
  source: "`construction_ecm`.`safety`.`risk_assessment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables risk profile comparison across projects."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., JSEA, SWMS, environmental) — segments risk by assessment methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (draft, approved, expired, under review)."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Initial risk level before controls — measures inherent hazard severity."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls — primary outcome measure of risk treatment effectiveness."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard assessed — enables risk analysis by hazard category."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective actions are required — tracks remediation demand from risk assessments."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag for assessments covering environmental aspects — supports environmental risk tracking."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — supports trend analysis of risk assessment activity."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments on record. Baseline measure for risk management programme coverage."
    - name: "high_residual_risk_assessments"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Extreme', 'Critical') THEN 1 END)
      comment: "Count of assessments with high or extreme residual risk after controls. Identifies inadequately controlled hazards requiring escalation."
    - name: "residual_high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_level IN ('High', 'Extreme', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments with unacceptably high residual risk. Key executive KPI for risk management effectiveness."
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of risk assessments requiring corrective action. Tracks volume of identified control gaps needing remediation."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments requiring corrective action. Measures the rate of control inadequacy across the risk register."
    - name: "environmental_risk_assessments"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of risk assessments covering environmental aspects. Tracks environmental risk management programme coverage."
    - name: "expired_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Expired' THEN 1 END)
      comment: "Count of risk assessments that have expired without renewal. Indicates gaps in risk management currency — a compliance and safety liability."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over environmental monitoring records. Tracks exceedance rates, threshold breaches, regulatory notifications, and corrective action rates to manage environmental compliance obligations."
  source: "`construction_ecm`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables environmental compliance benchmarking across projects."
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (e.g., noise, dust, water quality) — primary analytical dimension."
    - name: "parameter_category"
      expr: parameter_category
      comment: "Category of environmental parameter — enables grouped compliance analysis."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Flag indicating the measurement exceeded the regulatory threshold — primary compliance outcome dimension."
    - name: "reported_to_regulator"
      expr: reported_to_regulator
      comment: "Flag indicating the exceedance was reported to the regulator — tracks notification compliance."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective action was required following the measurement — tracks remediation demand."
    - name: "monitoring_record_status"
      expr: monitoring_record_status
      comment: "Status of the monitoring record (active, closed, under review)."
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold applied (regulatory limit, project limit, trigger level) — contextualises exceedance severity."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', CAST(measurement_timestamp AS DATE))
      comment: "Month of measurement — supports trend analysis of environmental compliance over time."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of monitoring instrument used — supports data quality and calibration tracking."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring measurements. Baseline measure for monitoring programme activity and coverage."
    - name: "total_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Count of measurements exceeding regulatory or project thresholds. Primary environmental compliance KPI."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements that exceeded thresholds. Key executive KPI for environmental compliance performance."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks central tendency of environmental parameters against thresholds."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude by which measurements exceeded thresholds. Quantifies severity of environmental non-compliance events."
    - name: "unreported_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = FALSE THEN 1 END)
      comment: "Count of threshold exceedances not yet reported to the regulator. Critical compliance risk indicator — unreported exceedances create legal liability."
    - name: "regulatory_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of exceedances that were reported to the regulator. Measures regulatory notification compliance — a direct legal obligation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the safety training register. Tracks training completion rates, certification currency, assessment pass rates, and training costs to manage workforce competency and compliance."
  source: "`construction_ecm`.`safety`.`training`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables training compliance benchmarking across projects."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (induction, refresher, certification, toolbox) — segments compliance by training category."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance outcome (attended, absent, partial) — primary completion dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record (compliant, overdue, expired) — tracks regulatory training obligations."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating mandatory training — enables compliance tracking for legally required training."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Flag indicating a certification was issued — tracks workforce qualification outcomes."
    - name: "refresher_required"
      expr: refresher_required
      comment: "Flag indicating a refresher is required — tracks upcoming training obligations."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (classroom, online, on-the-job) — supports training programme effectiveness analysis."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month of training — supports trend analysis of training activity and compliance."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records. Baseline measure for training programme activity and workforce coverage."
    - name: "mandatory_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE AND attendance_status = 'Attended' THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory training records with confirmed attendance. Critical compliance KPI — mandatory training gaps create regulatory and safety liability."
    - name: "certification_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records resulting in certification issuance. Measures workforce qualification outcomes from the training programme."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training records. Measures training effectiveness and workforce competency levels."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total expenditure on safety training. Tracks training investment for budget management and cost-per-competency analysis."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training duration in hours. Benchmarks training intensity and supports programme design decisions."
    - name: "overdue_training_records"
      expr: COUNT(CASE WHEN compliance_status = 'Overdue' THEN 1 END)
      comment: "Count of training records that are overdue. Tracks compliance gaps requiring urgent management intervention."
    - name: "workers_requiring_refresher"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct workers with at least one training record — proxy for trained workforce coverage. Use with refresher_required filter for refresher demand analysis."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over toolbox meeting (TBM) records. Tracks attendance rates, meeting frequency, corrective action rates, and emergency procedure review compliance as leading safety indicators."
  source: "`construction_ecm`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables TBM programme benchmarking across projects."
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (pre-start, weekly, incident review) — segments meeting activity by purpose."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Status of the meeting record (completed, cancelled, rescheduled)."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "HSE topic category covered in the meeting — tracks safety communication themes."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Flag indicating a corrective action was raised during the meeting — tracks safety issues identified in TBMs."
    - name: "emergency_procedures_reviewed"
      expr: emergency_procedures_reviewed
      comment: "Flag indicating emergency procedures were reviewed — tracks emergency preparedness communication."
    - name: "incident_review_included"
      expr: incident_review_included
      comment: "Flag indicating an incident review was included — measures lessons-learned communication effectiveness."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month of meeting — supports trend analysis of TBM frequency and attendance."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total number of toolbox meetings conducted. Baseline measure for safety communication programme activity."
    - name: "avg_attendance_rate_pct"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate across toolbox meetings. Key leading safety indicator — low attendance signals workforce engagement and safety culture issues."
    - name: "meetings_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END)
      comment: "Count of toolbox meetings that raised corrective actions. Tracks safety issues identified through pre-work safety briefings."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that raised corrective actions. Measures the rate of safety issues identified through proactive safety communication."
    - name: "emergency_procedure_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included emergency procedure review. Tracks emergency preparedness communication compliance."
    - name: "incident_review_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included an incident review. Measures lessons-learned communication effectiveness — a key safety culture indicator."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the hazard register. Tracks open hazard counts, residual risk profiles, closure rates, and PTW requirements to manage proactive hazard identification and control effectiveness."
  source: "`construction_ecm`.`safety`.`hazard_register`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project identifier — enables hazard profile comparison across projects."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard (e.g., electrical, working at height, chemical) — primary analytical dimension for risk prioritisation."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard — enables granular risk analysis within categories."
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (open, controlled, closed) — tracks hazard lifecycle management."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Initial risk level before controls — measures inherent hazard severity."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls — primary outcome measure of hazard control effectiveness."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Flag indicating a PTW is required to manage this hazard — tracks high-risk work authorisation demand."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag for hazards with environmental aspects — supports environmental risk tracking."
    - name: "tbm_topic_flag"
      expr: tbm_topic_flag
      comment: "Flag indicating the hazard is a toolbox meeting topic — tracks safety communication coverage of known hazards."
    - name: "hazard_identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month hazard was identified — supports trend analysis of hazard identification rates."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of hazards on the register. Baseline measure for hazard identification programme coverage."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('Closed', 'Controlled') THEN 1 END)
      comment: "Count of hazards not yet closed or fully controlled. Tracks outstanding risk exposure requiring management attention."
    - name: "high_residual_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Extreme', 'Critical') THEN 1 END)
      comment: "Count of hazards with high or extreme residual risk after controls. Identifies inadequately controlled hazards — critical for executive risk reporting."
    - name: "hazard_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazard_status IN ('Closed', 'Controlled') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazards that have been closed or fully controlled. Measures hazard management effectiveness and risk reduction performance."
    - name: "ptw_required_hazard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazards requiring a Permit to Work. Quantifies the proportion of high-risk work requiring formal authorisation controls."
    - name: "environmental_hazard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazards with environmental aspects. Tracks environmental risk exposure within the hazard register."
$$;