-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive safety KPIs derived from the incident fact table. Tracks incident frequency, severity, lost-time rates, and property damage costs to steer HSE performance and regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g. near-miss, first-aid, LTI, fatality) for trend analysis by type."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident (e.g. low, medium, high, critical) used to prioritise response and reporting."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident record (open, under investigation, closed)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause grouping (e.g. human error, equipment failure, environmental) to drive systemic corrective action."
    - name: "site_area"
      expr: site_area
      comment: "Physical area of the site where the incident occurred, enabling hotspot analysis."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred (day, night, swing) to identify shift-related risk patterns."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Category of the injured party (direct employee, subcontractor, visitor) for workforce safety segmentation."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating whether the incident resulted in a Lost Time Injury, the primary lagging safety indicator."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating OSHA recordability, required for regulatory reporting and benchmarking."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred, used for trend analysis and monthly safety reporting."
    - name: "incident_year"
      expr: YEAR(occurred_at)
      comment: "Year the incident occurred for annual safety performance benchmarking."
    - name: "treatment_type"
      expr: treatment_type
      comment: "Medical treatment category (first aid, medical treatment, hospitalisation) to assess injury severity distribution."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded incidents. Baseline KPI for incident frequency tracking and TRIR calculation inputs."
    - name: "total_lti_incidents"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of Lost Time Injuries. Primary lagging safety indicator used in LTIFR calculations and board reporting."
    - name: "total_osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Required for regulatory compliance reporting and TRIR benchmarking."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total monetary value of property damage from incidents. Directly informs insurance, risk provisioning, and capital protection decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Helps prioritise high-cost incident categories for targeted prevention investment."
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total lost workdays due to incidents. Directly measures workforce productivity loss and drives return-to-work programme investment."
    - name: "lti_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lti = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that resulted in a Lost Time Injury. Key safety performance ratio for executive dashboards and client reporting."
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable. Regulatory compliance KPI used in TRIR benchmarking against industry peers."
    - name: "environmental_incident_count"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of incidents with environmental impact. Drives environmental liability assessment and regulatory notification obligations."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'closed') THEN 1 END)
      comment: "Number of incidents not yet closed. Operational KPI for HSE managers to track investigation backlog and closure velocity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the quality, timeliness, and outcomes of incident investigations. Enables leadership to assess investigation closure rates, regulatory reportability, and systemic root cause patterns."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in-progress, closed) for workload and backlog management."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g. RCA, 5-Why, bow-tie) to assess investigation rigour."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the underlying incident (injury, near-miss, environmental) for trend analysis."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Formal classification of the incident severity for regulatory and insurance reporting."
    - name: "is_lti"
      expr: is_lti
      comment: "Whether the investigated incident was a Lost Time Injury, the primary lagging safety indicator."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag indicating whether the incident must be reported to a regulatory authority."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation, used to track closure and prevent recurrence."
    - name: "investigation_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month the investigation was initiated for trend and capacity planning."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations. Baseline for investigation programme capacity and throughput."
    - name: "closed_investigations"
      expr: COUNT(CASE WHEN investigation_status IN ('Closed', 'closed', 'CLOSED') THEN 1 END)
      comment: "Number of investigations formally closed. Measures investigation closure velocity and backlog reduction."
    - name: "investigation_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_status IN ('Closed', 'closed', 'CLOSED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been closed. Executive KPI for HSE programme effectiveness and regulatory compliance."
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations flagged as requiring regulatory reporting. Drives compliance obligation tracking and notification deadlines."
    - name: "lti_investigation_count"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Number of investigations for Lost Time Injuries. Directly linked to LTIFR and workforce safety performance."
    - name: "avg_lost_time_days"
      expr: AVG(CAST(lost_time_days AS DOUBLE))
      comment: "Average number of lost workdays per LTI investigation. Informs return-to-work programme effectiveness and productivity impact."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 END)
      comment: "Number of investigations with open corrective actions. Operational KPI to prevent recurrence and demonstrate due diligence."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors permit-to-work issuance, compliance, and risk controls. Enables HSE leadership to track high-risk work authorisation, isolation compliance, and permit closure rates."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (hot work, confined space, electrical isolation, working at height) for risk-category analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current lifecycle status of the permit (draft, issued, active, suspended, closed) for operational tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work (low, medium, high, critical) for prioritisation and oversight."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of authority required to approve the permit, reflecting the risk hierarchy."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Whether energy isolation is required for the permitted work, a critical safety control indicator."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Whether atmospheric gas testing is required, indicating confined space or flammable atmosphere risk."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the permitted work has a potential environmental impact, triggering additional controls."
    - name: "permit_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued for trend analysis and workload planning."
  measures:
    - name: "total_permits_issued"
      expr: COUNT(1)
      comment: "Total permits issued. Baseline KPI for high-risk work volume and PTW programme activity."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status IN ('Active', 'active', 'Issued', 'issued') THEN 1 END)
      comment: "Number of currently active permits. Operational KPI for simultaneous work management and site risk exposure."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN permit_status IN ('Suspended', 'suspended') THEN 1 END)
      comment: "Number of suspended permits. Indicates active safety interventions and stop-work situations requiring management attention."
    - name: "high_risk_permit_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'high', 'Critical', 'critical') THEN 1 END)
      comment: "Count of high or critical risk permits. Drives senior oversight allocation and simultaneous operations risk management."
    - name: "isolation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isolation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits requiring energy isolation. Indicates proportion of high-consequence work requiring LOTO controls."
    - name: "tbm_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where a toolbox meeting was conducted before work commenced. Key leading safety indicator for pre-task briefing compliance."
    - name: "concurrent_permit_count"
      expr: COUNT(CASE WHEN concurrent_permit_flag = TRUE THEN 1 END)
      comment: "Number of permits flagged as concurrent with other active permits. Drives simultaneous operations risk assessment and coordination."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures HSE inspection outcomes, deficiency rates, and PPE compliance across the project. Enables safety leadership to track inspection programme effectiveness and site compliance trends."
  source: "`vibe_construction_v1`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection (routine, unannounced, regulatory, drill) for programme coverage analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (scheduled, in-progress, completed, overdue)."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail/conditional result of the inspection for compliance rate tracking."
    - name: "highest_deficiency_severity"
      expr: highest_deficiency_severity
      comment: "Severity of the most critical deficiency found, used to prioritise corrective action urgency."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued as a result of the inspection, indicating critical safety failures."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Whether the inspection was planned or reactive, for programme adherence analysis."
    - name: "site_area"
      expr: site_area
      comment: "Area of the site inspected, enabling hotspot identification and targeted intervention."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis and inspection frequency compliance."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total HSE inspections conducted. Baseline for inspection programme activity and frequency compliance."
    - name: "stop_work_order_count"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a stop-work order. Critical safety KPI indicating severe non-compliance requiring immediate executive attention."
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across inspections. Leading safety indicator directly linked to injury prevention and regulatory compliance."
    - name: "avg_drill_muster_accuracy"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage across emergency drills. Measures emergency preparedness effectiveness and evacuation plan reliability."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that identified deficiencies requiring corrective action. Measures site compliance health and inspection rigour."
    - name: "immediate_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN immediate_action_taken = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where immediate corrective action was taken on-the-spot. Indicates responsiveness to critical safety findings."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of inspections triggering mandatory regulatory notification. Drives compliance obligation management and authority reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks risk assessment coverage, residual risk profiles, and control effectiveness across the project. Enables HSE and project leadership to manage risk exposure and demonstrate due diligence."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (JSEA, HAZOP, environmental, pre-task) for coverage analysis by methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, approved, under review, superseded) for governance tracking."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Category of hazard assessed (mechanical, chemical, electrical, ergonomic) for risk profile analysis."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls are applied, used to measure control effectiveness."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls are applied. Key indicator of risk management effectiveness."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether additional corrective action is required beyond existing controls."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Whether the assessment covers an environmental aspect, for environmental risk portfolio management."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted for trend and programme coverage analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total risk assessments conducted. Baseline for risk management programme coverage and activity."
    - name: "high_residual_risk_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'high', 'Critical', 'critical', 'Extreme', 'extreme') THEN 1 END)
      comment: "Number of assessments with high or critical residual risk after controls. Drives escalation to senior management and additional control investment."
    - name: "risk_reduction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_level IN ('Low', 'low', 'Medium', 'medium') AND initial_risk_level IN ('High', 'high', 'Critical', 'critical', 'Extreme', 'extreme') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('High', 'high', 'Critical', 'critical', 'Extreme', 'extreme') THEN 1 END), 0), 2)
      comment: "Percentage of initially high/critical risks reduced to low/medium after controls. Measures control hierarchy effectiveness and risk management ROI."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of risk assessments requiring additional corrective action. Operational KPI for outstanding risk treatment obligations."
    - name: "environmental_risk_count"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of risk assessments covering environmental aspects. Drives environmental compliance programme resourcing and permit condition management."
    - name: "approved_assessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status IN ('Approved', 'approved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments that have been formally approved. Governance KPI ensuring all work is covered by authorised risk controls before commencement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures safety audit programme performance, compliance scores, and finding closure rates. Enables HSE leadership to assess audit programme effectiveness and systemic compliance gaps."
  source: "`vibe_construction_v1`.`safety`.`safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of safety audit (internal, external, regulatory, third-party) for programme coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, overdue) for programme tracking."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit scope (HSE management system, site safety, environmental, fire) for thematic analysis."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating assigned to the audit (satisfactory, requires improvement, unsatisfactory)."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued as a result of the audit, indicating critical non-compliance."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether the audit findings require regulatory notification, driving compliance obligation management."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit was conducted for trend analysis and audit programme frequency compliance."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total safety audits conducted. Baseline for audit programme activity and frequency compliance."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits. Primary KPI for overall HSE management system effectiveness and regulatory standing."
    - name: "stop_work_audit_count"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Number of audits resulting in stop-work orders. Critical indicator of severe systemic non-compliance requiring board-level attention."
    - name: "total_major_nc_count"
      expr: SUM(CAST(major_nc_count AS DOUBLE))
      comment: "Total major non-conformances identified across all audits. Drives corrective action programme prioritisation and management system improvement investment."
    - name: "total_minor_nc_count"
      expr: SUM(CAST(minor_nc_count AS DOUBLE))
      comment: "Total minor non-conformances identified. Tracks systemic improvement opportunities and audit programme thoroughness."
    - name: "avg_open_findings"
      expr: AVG(CAST(open_findings_count AS DOUBLE))
      comment: "Average number of open findings per audit. Measures corrective action closure velocity and outstanding compliance obligations."
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring regulatory notification. Tracks regulatory exposure and compliance obligation density."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks toolbox meeting (TBM) programme delivery, attendance rates, and topic coverage. Enables HSE leadership to measure pre-task safety briefing compliance as a leading safety indicator."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (pre-task, weekly, emergency, toolbox talk) for programme coverage analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Current status of the meeting record (planned, completed, cancelled) for programme adherence tracking."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "HSE topic category covered in the meeting (hazard awareness, PPE, emergency procedures) for content coverage analysis."
    - name: "trade_group"
      expr: trade_group
      comment: "Trade or work group the meeting was conducted for, enabling trade-specific safety engagement analysis."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Whether a corrective action was raised during the meeting, indicating proactive hazard identification."
    - name: "interpreter_required"
      expr: interpreter_required
      comment: "Whether an interpreter was required, indicating multilingual workforce safety communication needs."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month the toolbox meeting was held for trend analysis and programme frequency compliance."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total toolbox meetings conducted. Baseline leading safety indicator for pre-task briefing programme activity."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate across toolbox meetings. Leading safety indicator measuring workforce engagement in safety briefings."
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_minutes AS DOUBLE) / 60.0)
      comment: "Total hours invested in toolbox meetings. Measures safety communication programme investment and workforce safety engagement."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of toolbox meetings in minutes. Indicates briefing thoroughness and quality of safety communication."
    - name: "ppe_communication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppe_requirements_communicated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings where PPE requirements were communicated. Leading indicator for PPE compliance and injury prevention."
    - name: "emergency_procedure_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of meetings where emergency procedures were reviewed. Measures emergency preparedness communication coverage."
    - name: "corrective_action_raise_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that generated a corrective action. Measures proactive hazard identification effectiveness as a leading safety indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks safety training delivery, certification rates, compliance status, and training investment. Enables HSE and HR leadership to manage workforce competency and regulatory training obligations."
  source: "`vibe_construction_v1`.`safety`.`training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of safety training (induction, refresher, certification, emergency response) for programme coverage analysis."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (scheduled, completed, failed, expired) for compliance tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (classroom, online, on-the-job, simulation) for programme effectiveness analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the training record (compliant, non-compliant, expiring) for obligation management."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory for regulatory or contractual compliance."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Whether a certification was issued upon completion, for competency credential tracking."
    - name: "refresher_required"
      expr: refresher_required
      comment: "Whether a refresher training is required, for forward planning of training programme capacity."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month training was delivered for trend analysis and programme scheduling."
  measures:
    - name: "total_training_sessions"
      expr: COUNT(1)
      comment: "Total training sessions recorded. Baseline for safety training programme activity and workforce coverage."
    - name: "certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training sessions resulting in certification. Measures workforce competency attainment and training programme effectiveness."
    - name: "mandatory_training_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE AND compliance_status IN ('Compliant', 'compliant') THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory training records in compliant status. Critical regulatory KPI for workforce legal compliance and contract obligations."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total monetary investment in safety training. Informs training budget allocation and cost-per-competency analysis."
    - name: "avg_training_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per training session. Benchmarks training programme efficiency and informs make-vs-buy decisions for training delivery."
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of safety training delivered. Measures workforce safety education investment and programme scale."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training sessions. Measures training effectiveness and workforce competency attainment quality."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_result IN ('Pass', 'pass', 'Passed', 'passed', 'Competent', 'competent') THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed training sessions where the participant passed. Measures training programme quality and workforce readiness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental monitoring results, exceedance events, and regulatory compliance. Enables HSE and sustainability leadership to manage environmental permit conditions and regulatory obligations."
  source: "`vibe_construction_v1`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (noise, dust, water quality, air quality) for compliance category analysis."
    - name: "parameter_category"
      expr: parameter_category
      comment: "High-level category of the monitoring parameter (air, water, soil, noise) for portfolio-level environmental risk management."
    - name: "environmental_monitoring_status"
      expr: environmental_monitoring_status
      comment: "Current status of the monitoring record for data completeness and programme tracking."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded the regulatory threshold, the primary environmental compliance indicator."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required in response to the monitoring result."
    - name: "reported_to_regulator"
      expr: reported_to_regulator
      comment: "Whether the exceedance was reported to the regulatory authority, for compliance obligation tracking."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of monitoring (daily, weekly, monthly) for programme adherence analysis."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis and seasonal pattern identification."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total environmental monitoring records. Baseline for monitoring programme coverage and frequency compliance."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of measurements exceeding regulatory thresholds. Primary environmental compliance KPI driving regulatory notification and corrective action."
    - name: "exceedance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring readings that exceeded regulatory limits. Executive KPI for environmental compliance performance and permit condition adherence."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks environmental parameter trends relative to regulatory thresholds."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CASE WHEN exceedance_flag = TRUE THEN exceedance_magnitude END)
      comment: "Average magnitude of exceedances above the threshold. Measures severity of environmental non-compliance events to prioritise remediation investment."
    - name: "unreported_exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = FALSE THEN 1 END)
      comment: "Number of exceedances not yet reported to the regulator. Critical compliance risk KPI indicating potential regulatory breach and penalty exposure."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of monitoring records requiring corrective action. Drives environmental remediation programme prioritisation and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_swms`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Safe Work Method Statement (SWMS) coverage, approval status, and residual risk profiles. Enables HSE leadership to ensure all high-risk work is covered by approved risk controls before commencement."
  source: "`vibe_construction_v1`.`safety`.`swms`"
  dimensions:
    - name: "swms_status"
      expr: swms_status
      comment: "Current lifecycle status of the SWMS (draft, under review, approved, expired, superseded)."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of work activity covered by the SWMS (excavation, concrete pour, electrical, working at height) for risk coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the SWMS, ensuring only approved documents are used for high-risk work."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls are applied. Measures control effectiveness and remaining risk exposure."
    - name: "ptw_required"
      expr: ptw_required
      comment: "Whether a permit to work is required in conjunction with this SWMS, indicating high-consequence work."
    - name: "worker_acknowledgement_required"
      expr: worker_acknowledgement_required
      comment: "Whether workers must formally acknowledge the SWMS before commencing work."
    - name: "swms_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the SWMS was issued for trend analysis and programme coverage tracking."
  measures:
    - name: "total_swms"
      expr: COUNT(1)
      comment: "Total SWMS records. Baseline for high-risk work coverage and safety documentation programme activity."
    - name: "approved_swms_count"
      expr: COUNT(CASE WHEN approval_status IN ('Approved', 'approved') THEN 1 END)
      comment: "Number of approved SWMS documents. Governance KPI ensuring all high-risk work is covered by authorised risk controls."
    - name: "swms_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status IN ('Approved', 'approved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SWMS documents that are formally approved. Critical safety governance KPI ensuring no unapproved high-risk work commences."
    - name: "high_residual_risk_swms_count"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'high', 'Extreme', 'extreme', 'Critical', 'critical') THEN 1 END)
      comment: "Number of SWMS with high or extreme residual risk after controls. Drives senior management review and additional control investment."
    - name: "ptw_linked_swms_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ptw_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SWMS requiring a linked permit to work. Indicates proportion of highest-consequence work requiring dual-control authorisation."
    - name: "expired_swms_count"
      expr: COUNT(CASE WHEN swms_status IN ('Expired', 'expired') THEN 1 END)
      comment: "Number of expired SWMS documents. Operational risk KPI indicating outdated risk controls that must be renewed before work can continue."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks hazard identification, risk ratings, and control effectiveness across the project. Enables HSE leadership to manage the hazard portfolio, prioritise controls, and demonstrate proactive risk management."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard record (open, under control, closed, escalated) for portfolio management."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard (physical, chemical, biological, ergonomic, psychosocial) for risk category analysis."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Broader hazard category for portfolio-level risk management and reporting."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls, used to measure control effectiveness and risk reduction."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls. Primary indicator of remaining risk exposure in the project hazard portfolio."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Whether the hazard has an environmental aspect, for integrated HSE risk management."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Whether a permit to work is required to manage this hazard, indicating high-consequence risk."
    - name: "hazard_register_status"
      expr: hazard_register_status
      comment: "Overall register status for governance and audit trail purposes."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total hazards identified and registered. Baseline for hazard identification programme activity and site risk profile."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('Closed', 'closed') THEN 1 END)
      comment: "Number of hazards not yet closed. Operational KPI for outstanding risk treatment obligations and site exposure."
    - name: "high_residual_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'high', 'Extreme', 'extreme', 'Critical', 'critical') THEN 1 END)
      comment: "Number of hazards with high or extreme residual risk. Drives senior management attention and additional control investment."
    - name: "risk_reduction_effectiveness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('High', 'high', 'Extreme', 'extreme') AND residual_risk_level IN ('Low', 'low', 'Medium', 'medium') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('High', 'high', 'Extreme', 'extreme') THEN 1 END), 0), 2)
      comment: "Percentage of initially high/extreme hazards reduced to low/medium residual risk. Measures control hierarchy effectiveness and risk management programme ROI."
    - name: "ptw_required_hazard_count"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Number of hazards requiring a permit to work. Drives PTW programme capacity planning and high-risk work authorisation management."
    - name: "environmental_hazard_count"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of hazards with environmental aspects. Drives environmental compliance programme resourcing and permit condition management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_subcontractor_involvement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor involvement in safety incidents, liability attribution, and corrective action compliance. Enables HSE and contract management leadership to manage subcontractor safety performance and liability exposure."
  source: "`vibe_construction_v1`.`safety`.`incident_subcontractor_involvement`"
  dimensions:
    - name: "involvement_type"
      expr: involvement_type
      comment: "Type of subcontractor involvement in the incident (direct cause, contributing factor, bystander) for liability analysis."
    - name: "involvement_role"
      expr: involvement_role
      comment: "Role of the subcontractor in the incident (performing party, supervising party, equipment operator) for accountability tracking."
    - name: "involvement_status"
      expr: involvement_status
      comment: "Current status of the involvement record (under investigation, acknowledged, closed) for case management."
    - name: "incident_subcontractor_involvement_status"
      expr: incident_subcontractor_involvement_status
      comment: "Overall lifecycle status of the subcontractor involvement record for governance tracking."
    - name: "is_at_fault"
      expr: is_at_fault
      comment: "Whether the subcontractor has been determined to be at fault, driving liability and back-charge decisions."
    - name: "is_primary_responsible"
      expr: is_primary_responsible
      comment: "Whether the subcontractor is the primary responsible party, for insurance and contractual liability management."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required from the subcontractor, for performance management and contract compliance."
    - name: "acknowledged_flag"
      expr: acknowledged_flag
      comment: "Whether the subcontractor has formally acknowledged their involvement, for legal and contractual record-keeping."
  measures:
    - name: "total_subcontractor_involvements"
      expr: COUNT(1)
      comment: "Total subcontractor involvement records across incidents. Baseline for subcontractor safety performance portfolio management."
    - name: "at_fault_count"
      expr: COUNT(CASE WHEN is_at_fault = TRUE THEN 1 END)
      comment: "Number of incidents where the subcontractor was determined to be at fault. Drives back-charge, performance scorecard, and contract termination decisions."
    - name: "at_fault_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_at_fault = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subcontractor involvements where fault was attributed. Key subcontractor safety performance KPI for prequalification and contract renewal decisions."
    - name: "avg_fault_percentage"
      expr: AVG(CAST(fault_percentage AS DOUBLE))
      comment: "Average fault percentage attributed to subcontractors across incidents. Informs proportional liability allocation and insurance claim management."
    - name: "avg_liability_percentage"
      expr: AVG(CAST(liability_percentage AS DOUBLE))
      comment: "Average liability percentage attributed to subcontractors. Drives financial exposure quantification and back-charge calculation."
    - name: "unacknowledged_involvement_count"
      expr: COUNT(CASE WHEN acknowledged_flag = FALSE OR acknowledged_flag IS NULL THEN 1 END)
      comment: "Number of subcontractor involvements not yet formally acknowledged. Operational KPI for legal risk management and dispute prevention."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND involvement_status NOT IN ('Closed', 'closed') THEN 1 END)
      comment: "Number of subcontractor involvements with open corrective actions. Drives subcontractor performance management and contract compliance enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_chemical_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks hazardous chemical inventory, compliance status, and exposure risk on site. Enables HSE leadership to manage chemical hazard exposure, regulatory compliance, and SDS currency."
  source: "`vibe_construction_v1`.`safety`.`chemical_register`"
  dimensions:
    - name: "chemical_register_status"
      expr: chemical_register_status
      comment: "Current status of the chemical register entry (active, superseded, disposed) for inventory management."
    - name: "hazard_category"
      expr: hazard_category
      comment: "GHS hazard category of the chemical (flammable, toxic, corrosive, oxidising) for risk profile analysis."
    - name: "chemical_family"
      expr: chemical_family
      comment: "Chemical family grouping for portfolio-level hazard management and substitution analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the chemical (low, medium, high, extreme) for prioritisation."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the chemical is classified as hazardous under applicable regulations."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the chemical register entry, for permit condition and legal obligation management."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the chemical storage, for safety compliance tracking."
  measures:
    - name: "total_chemicals_registered"
      expr: COUNT(1)
      comment: "Total chemicals registered on site. Baseline for chemical inventory management and regulatory reporting obligations."
    - name: "hazardous_chemical_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous chemicals on site. Drives regulatory notification, emergency response planning, and exposure risk management."
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of chemicals on site (in registered units). Informs threshold limit compliance and major hazard facility classification."
    - name: "non_compliant_chemical_count"
      expr: COUNT(CASE WHEN regulatory_compliance_status NOT IN ('Compliant', 'compliant') THEN 1 END)
      comment: "Number of chemicals with non-compliant regulatory status. Critical compliance KPI driving immediate remediation to avoid regulatory penalties."
    - name: "avg_exposure_limit_tlv"
      expr: AVG(CAST(exposure_limit_tlv AS DOUBLE))
      comment: "Average threshold limit value across registered chemicals. Informs occupational hygiene programme design and exposure monitoring priorities."
    - name: "sds_overdue_count"
      expr: COUNT(CASE WHEN is_quantities_verified = FALSE THEN 1 END)
      comment: "Number of chemicals where quantities have not been verified. Operational KPI for inventory accuracy and emergency response preparedness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_ppe_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks PPE issuance, compliance, cost, and inspection status across the workforce. Enables HSE leadership to manage PPE programme effectiveness, cost, and regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`ppe_register`"
  dimensions:
    - name: "ppe_category"
      expr: ppe_category
      comment: "Category of PPE (head protection, eye protection, respiratory, fall protection) for coverage analysis."
    - name: "item_type"
      expr: item_type
      comment: "Specific type of PPE item for inventory and compliance tracking."
    - name: "ppe_register_status"
      expr: ppe_register_status
      comment: "Current status of the PPE record (issued, returned, expired, condemned) for lifecycle management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PPE item (compliant, non-compliant, expired) for regulatory obligation management."
    - name: "issuance_status"
      expr: issuance_status
      comment: "Whether the PPE has been issued to a worker, for inventory and distribution tracking."
    - name: "fit_test_required"
      expr: fit_test_required
      comment: "Whether a fit test is required for this PPE item (e.g. respirators), indicating high-consequence protection requirements."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Hazard type the PPE is designed to protect against, for risk-based PPE programme management."
  measures:
    - name: "total_ppe_items"
      expr: COUNT(1)
      comment: "Total PPE items registered. Baseline for PPE inventory management and workforce protection coverage."
    - name: "total_ppe_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total cost of PPE issued. Informs PPE budget management and cost-per-worker protection analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per PPE item. Benchmarks PPE procurement efficiency and informs category-level budget planning."
    - name: "non_compliant_ppe_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'compliant') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPE items in non-compliant status. Critical safety KPI indicating workers potentially unprotected against identified hazards."
    - name: "worker_acknowledgement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN worker_acknowledgement = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPE items formally acknowledged by the receiving worker. Governance KPI for PPE issuance accountability and legal defensibility."
    - name: "training_completed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPE items where the worker has completed required PPE training. Leading safety indicator for correct PPE usage and injury prevention."
$$;