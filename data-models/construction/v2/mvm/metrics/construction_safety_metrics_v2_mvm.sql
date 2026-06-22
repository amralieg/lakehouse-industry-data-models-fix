-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident KPIs tracking frequency, severity, and financial impact of workplace incidents across construction projects. Used by HSE leadership and executives to monitor safety performance, drive intervention, and benchmark against industry targets."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g., near-miss, first-aid, LTI, environmental) for segmenting safety performance by event category."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident (e.g., minor, moderate, serious, critical) enabling risk-tiered analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (e.g., open, under investigation, closed) for pipeline and backlog monitoring."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause grouping (e.g., human error, equipment failure, environmental) to identify systemic safety gaps."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (e.g., direct employee, subcontractor, visitor) for workforce safety segmentation."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating whether the incident resulted in a Lost Time Injury, the primary lagging safety indicator."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating OSHA recordability, required for regulatory compliance reporting."
    - name: "is_environmental_event"
      expr: is_environmental_event
      comment: "Flag indicating whether the incident involved an environmental impact, supporting ESG and regulatory reporting."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', CAST(occurred_at AS DATE))
      comment: "Month the incident occurred, enabling trend analysis and month-over-month safety performance tracking."
    - name: "incident_year"
      expr: YEAR(CAST(occurred_at AS DATE))
      comment: "Year the incident occurred for annual safety performance benchmarking."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred (e.g., day, night, swing) to identify shift-specific risk patterns."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level safety performance comparison."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded incidents. The primary volume KPI for safety performance dashboards and trend analysis."
    - name: "total_lti_incidents"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of Lost Time Injury incidents. The most critical lagging safety indicator used by executives and regulators to assess workforce safety."
    - name: "total_osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Mandatory for regulatory compliance reporting and benchmarking against industry TRIR targets."
    - name: "total_environmental_incidents"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of incidents with environmental impact. Supports ESG reporting and environmental regulatory compliance."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total financial value of property damage from incidents. Directly informs insurance, risk management, and capital protection decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Used to assess severity trends and prioritise risk mitigation investments."
    - name: "lti_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lti = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Lost Time Injury rate as a percentage of all incidents. A key executive safety KPI used to benchmark against industry standards and HSE plan targets."
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Percentage of incidents that are OSHA-recordable. Tracks regulatory exposure and Total Recordable Incident Rate (TRIR) performance."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'closed') THEN 1 END)
      comment: "Count of incidents not yet closed. Measures investigation backlog and responsiveness of the safety management process."
    - name: "incidents_with_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_status IS NOT NULL AND regulatory_notification_status != '' THEN 1 END)
      comment: "Count of incidents requiring or having received regulatory notification. Tracks regulatory compliance obligations and exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazard register KPIs tracking the volume, risk profile, and closure performance of identified workplace hazards. Used by HSE managers and project directors to proactively manage risk and ensure hazard controls are in place before incidents occur."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of the hazard (e.g., electrical, chemical, mechanical, ergonomic) for risk-type segmentation."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Specific type of hazard within its category, enabling granular risk analysis."
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (e.g., open, mitigated, closed) for tracking control effectiveness."
    - name: "hazard_register_status"
      expr: hazard_register_status
      comment: "Administrative status of the hazard register entry for governance and audit tracking."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Risk level before controls are applied (e.g., low, medium, high, critical). Used to prioritise hazard treatment."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Risk level after controls are applied. Measures the effectiveness of the hierarchy of controls."
    - name: "hierarchy_of_controls"
      expr: hierarchy_of_controls
      comment: "Control type applied (e.g., elimination, substitution, engineering, administrative, PPE) for control strategy analysis."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Flag indicating whether a permit to work is required for this hazard, supporting PTW compliance monitoring."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether regulatory notification is required for this hazard, supporting compliance tracking."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag indicating whether the hazard has an environmental dimension, supporting ESG and environmental compliance reporting."
    - name: "identification_source"
      expr: identification_source
      comment: "Source through which the hazard was identified (e.g., inspection, incident, audit) to evaluate proactive vs reactive identification."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the hazard was identified, enabling trend analysis of hazard discovery rates."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level hazard risk profiling."
    - name: "site_id"
      expr: site_id
      comment: "Foreign key to the site for site-level hazard density and risk analysis."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of registered hazards. The baseline volume KPI for hazard management performance."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('Closed', 'closed', 'Mitigated', 'mitigated') THEN 1 END)
      comment: "Count of hazards not yet closed or mitigated. A leading safety indicator — high open hazard counts signal elevated risk exposure."
    - name: "high_risk_hazards"
      expr: COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of hazards with high or critical initial risk rating. Prioritised for executive attention and immediate control action."
    - name: "residual_high_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of hazards where residual risk remains high or critical after controls. Indicates inadequate control effectiveness requiring escalation."
    - name: "risk_reduction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') AND residual_risk_level NOT IN ('High', 'Critical', 'high', 'critical') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END), 0), 2)
      comment: "Percentage of initially high/critical hazards successfully reduced to lower residual risk. Measures the effectiveness of the hazard control programme."
    - name: "overdue_hazards"
      expr: COUNT(CASE WHEN target_closure_date < CURRENT_DATE() AND hazard_status NOT IN ('Closed', 'closed') THEN 1 END)
      comment: "Count of hazards past their target closure date that remain open. A critical operational KPI for HSE accountability and corrective action prioritisation."
    - name: "ptw_required_hazards"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Count of hazards requiring a permit to work. Used to plan and validate PTW compliance coverage across the project."
    - name: "tbm_topic_hazards"
      expr: COUNT(CASE WHEN tbm_topic_flag = TRUE THEN 1 END)
      comment: "Count of hazards flagged as toolbox meeting topics. Measures the integration of hazard awareness into daily safety communications."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit to Work (PTW) KPIs tracking issuance, compliance, and lifecycle performance of work authorisation controls. Used by site managers and HSE teams to ensure high-risk work is properly authorised, controlled, and closed out."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., hot work, confined space, electrical isolation, working at height) for risk-category analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., draft, issued, active, suspended, closed) for pipeline and compliance monitoring."
    - name: "permit_to_work_status"
      expr: permit_to_work_status
      comment: "Operational status of the PTW for workflow and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work, enabling prioritisation and oversight intensity decisions."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of authority required to approve the permit (e.g., supervisor, HSE manager, site director) for governance analysis."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Flag indicating whether energy isolation is required, a critical safety control for high-risk work."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Flag indicating whether atmospheric gas testing is required before work commences."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flag indicating whether a toolbox meeting was conducted before work started under this permit."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag indicating whether the permitted work has potential environmental impact."
    - name: "concurrent_permit_flag"
      expr: concurrent_permit_flag
      comment: "Flag indicating concurrent permits are active, a risk factor requiring additional coordination controls."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', CAST(issued_timestamp AS DATE))
      comment: "Month the permit was issued, enabling trend analysis of work authorisation volumes."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level PTW compliance analysis."
    - name: "site_id"
      expr: site_id
      comment: "Foreign key to the site for site-level PTW activity and compliance monitoring."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits to work issued. Baseline volume KPI for work authorisation activity."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status IN ('Active', 'active', 'Issued', 'issued') THEN 1 END)
      comment: "Count of currently active permits. Measures live work authorisation load and concurrent risk exposure on site."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN permit_status IN ('Suspended', 'suspended') THEN 1 END)
      comment: "Count of suspended permits. Elevated suspension rates signal safety control failures or site condition deterioration."
    - name: "tbm_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where a toolbox meeting was conducted before work. A leading safety indicator measuring pre-work safety briefing compliance."
    - name: "isolation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isolation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits requiring energy isolation. Informs the scale of lockout/tagout programme management."
    - name: "permits_with_extensions"
      expr: COUNT(CASE WHEN extension_count IS NOT NULL AND extension_count != '0' AND extension_count != '' THEN 1 END)
      comment: "Count of permits that have been extended beyond their original validity. Frequent extensions may indicate poor work planning or scope creep risk."
    - name: "concurrent_permit_count"
      expr: COUNT(CASE WHEN concurrent_permit_flag = TRUE THEN 1 END)
      comment: "Count of permits with concurrent work authorisations active. High concurrency increases coordination risk and requires heightened HSE oversight."
    - name: "high_risk_permit_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of permits classified as high or critical risk. Used by site directors to allocate HSE supervision resources to highest-risk work activities."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment KPIs measuring the volume, quality, and risk reduction effectiveness of formal risk assessments across construction activities. Used by HSE managers and project directors to validate that risk controls are adequate before work commences."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., JSEA, JHA, formal RA, environmental RA) for methodology and coverage analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g., draft, approved, under review, expired) for governance tracking."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Operational status of the risk assessment record for workflow management."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Risk level before controls (e.g., low, medium, high, critical) for pre-control risk profiling."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Risk level after controls for post-control risk profiling and control effectiveness measurement."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard being assessed, enabling risk analysis by hazard category."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag indicating whether the assessment covers an environmental aspect, supporting ESG and environmental compliance."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective actions were identified, measuring the rate of assessments generating action items."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted for trend analysis of risk assessment activity."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level risk assessment coverage analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted. Baseline KPI for proactive risk management activity volume."
    - name: "approved_risk_assessments"
      expr: COUNT(CASE WHEN assessment_status IN ('Approved', 'approved') THEN 1 END)
      comment: "Count of formally approved risk assessments. Measures governance compliance — work should only proceed under approved assessments."
    - name: "high_initial_risk_assessments"
      expr: COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of assessments with high or critical initial risk. Identifies the volume of high-risk activities requiring robust control measures."
    - name: "residual_high_risk_assessments"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of assessments where residual risk remains high or critical. Signals inadequate controls requiring escalation or work stoppage."
    - name: "risk_control_effectiveness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') AND residual_risk_level NOT IN ('High', 'Critical', 'high', 'critical') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('High', 'Critical', 'high', 'critical') THEN 1 END), 0), 2)
      comment: "Percentage of high/critical risk assessments where controls successfully reduced residual risk. The primary KPI for measuring the effectiveness of the risk control programme."
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of risk assessments that identified corrective actions. Measures the rate of assessments generating improvement actions."
    - name: "overdue_review_assessments"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND assessment_status NOT IN ('Closed', 'closed', 'Expired', 'expired') THEN 1 END)
      comment: "Count of risk assessments past their next review date. Overdue reviews indicate stale risk controls that may no longer be adequate for current site conditions."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status IN ('Approved', 'approved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments that have been formally approved. Measures governance compliance and readiness for work commencement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident investigation KPIs measuring the timeliness, completeness, and corrective action closure of safety investigations. Used by HSE leadership to ensure root causes are identified and systemic improvements are implemented to prevent recurrence."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g., 5-Why, bow-tie, fault tree) for methodology effectiveness analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (e.g., in progress, completed, closed) for backlog and timeliness monitoring."
    - name: "incident_investigation_status"
      expr: incident_investigation_status
      comment: "Administrative status of the investigation record for governance tracking."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the investigated incident for systemic pattern analysis across incident types."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Formal classification of the incident (e.g., near-miss, first-aid, LTI, fatality) for severity-tiered investigation analysis."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating whether the investigated incident was a Lost Time Injury, the primary lagging safety indicator."
    - name: "is_recordable"
      expr: is_recordable
      comment: "Flag indicating whether the incident is recordable for regulatory reporting purposes."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag indicating whether the incident requires regulatory reporting, tracking compliance obligations."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation (e.g., open, in progress, closed) for action closure tracking."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party for workforce safety segmentation in investigation analysis."
    - name: "investigation_start_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month the investigation was initiated for trend analysis of investigation activity."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level investigation performance analysis."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations conducted. Baseline KPI for investigation programme activity."
    - name: "completed_investigations"
      expr: COUNT(CASE WHEN investigation_status IN ('Completed', 'completed', 'Closed', 'closed') THEN 1 END)
      comment: "Count of investigations that have been completed and closed. Measures investigation throughput and closure performance."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Completed', 'completed', 'Closed', 'closed') THEN 1 END)
      comment: "Count of investigations still open. High open counts indicate investigation backlog and delayed corrective action implementation."
    - name: "lti_investigations"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of investigations for Lost Time Injury incidents. LTI investigations are the highest priority for root cause analysis and recurrence prevention."
    - name: "regulatory_reportable_investigations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations with regulatory reporting obligations. Tracks compliance exposure and notification requirements."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND corrective_action_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 END)
      comment: "Count of investigations with overdue corrective actions. Overdue actions directly increase the risk of incident recurrence and are a critical HSE governance KPI."
    - name: "corrective_action_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations where corrective actions have been closed. The primary KPI for measuring the effectiveness of the corrective action programme."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_close_date, investigation_start_date))
      comment: "Average number of days from investigation start to close. Measures investigation timeliness — prolonged investigations delay corrective action and increase recurrence risk."
    - name: "swms_compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN swms_in_place_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigated incidents where a SWMS was in place at the time. Low rates indicate SWMS coverage gaps contributing to incidents."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Toolbox meeting (TBM) KPIs measuring the frequency, attendance, and quality of pre-work safety briefings. Used by HSE managers and site supervisors to ensure workers are informed of hazards and controls before commencing work — a critical leading safety indicator."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (e.g., daily pre-start, weekly safety, emergency drill) for coverage and frequency analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Status of the toolbox meeting (e.g., planned, completed, cancelled) for completion rate tracking."
    - name: "toolbox_meeting_status"
      expr: toolbox_meeting_status
      comment: "Operational status of the TBM record for workflow management."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "HSE topic category covered in the meeting (e.g., hazard awareness, PPE, emergency procedures) for topic coverage analysis."
    - name: "incident_review_included"
      expr: incident_review_included
      comment: "Flag indicating whether an incident review was included in the meeting, measuring the integration of lessons learned into daily safety communications."
    - name: "emergency_procedures_reviewed"
      expr: emergency_procedures_reviewed
      comment: "Flag indicating whether emergency procedures were reviewed, a critical safety preparedness indicator."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Flag indicating whether a corrective action was raised during the meeting, measuring the proactive identification of safety issues."
    - name: "ppe_requirements_communicated"
      expr: ppe_requirements_communicated
      comment: "Flag indicating whether PPE requirements were communicated, a fundamental safety compliance indicator."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month the toolbox meeting was held for trend analysis of TBM frequency and attendance."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level TBM compliance analysis."
    - name: "site_id"
      expr: site_id
      comment: "Foreign key to the site for site-level TBM frequency and quality monitoring."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total number of toolbox meetings conducted. The primary leading safety indicator for pre-work safety communication activity."
    - name: "completed_meetings"
      expr: COUNT(CASE WHEN meeting_status IN ('Completed', 'completed') THEN 1 END)
      comment: "Count of toolbox meetings successfully completed. Measures TBM programme delivery against planned frequency."
    - name: "avg_attendance_rate_pct"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate percentage across all toolbox meetings. Low attendance rates indicate workers are not receiving critical safety briefings before work commences."
    - name: "total_meeting_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total time invested in toolbox meetings. Measures the overall safety communication effort and supports HSE programme cost analysis."
    - name: "avg_meeting_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of toolbox meetings in minutes. Very short meetings may indicate inadequate safety briefing quality."
    - name: "incident_review_inclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included an incident review. Measures the integration of lessons learned into daily safety communications — a key leading indicator."
    - name: "emergency_procedure_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings where emergency procedures were reviewed. Measures emergency preparedness communication compliance."
    - name: "ppe_communication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppe_requirements_communicated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings where PPE requirements were communicated. A fundamental safety compliance KPI for personal protective equipment programme effectiveness."
    - name: "corrective_action_raised_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that generated a corrective action. Measures the proactive hazard identification effectiveness of the TBM programme."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_swms`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safe Work Method Statement (SWMS) KPIs tracking the coverage, approval status, and risk reduction effectiveness of documented safe work procedures. Used by HSE managers and project directors to ensure high-risk construction activities are performed under approved, current SWMS."
  source: "`vibe_construction_v1`.`safety`.`swms`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity covered by the SWMS (e.g., excavation, working at height, hot work) for activity-risk coverage analysis."
    - name: "swms_status"
      expr: swms_status
      comment: "Current status of the SWMS (e.g., draft, approved, expired, superseded) for governance and compliance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the SWMS document for governance compliance monitoring."
    - name: "initial_risk_rating"
      expr: initial_risk_rating
      comment: "Risk rating before controls are applied, for pre-control risk profiling of covered activities."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Risk rating after controls are applied, measuring the effectiveness of SWMS control measures."
    - name: "ptw_required"
      expr: ptw_required
      comment: "Flag indicating whether a permit to work is required alongside this SWMS, for integrated PTW-SWMS compliance analysis."
    - name: "tbm_required"
      expr: tbm_required
      comment: "Flag indicating whether a toolbox meeting is required before commencing work under this SWMS."
    - name: "worker_acknowledgement_required"
      expr: worker_acknowledgement_required
      comment: "Flag indicating whether workers must formally acknowledge the SWMS before work, measuring sign-off compliance requirements."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the SWMS was issued for trend analysis of SWMS production and coverage."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level SWMS coverage analysis."
    - name: "site_id"
      expr: site_id
      comment: "Foreign key to the site for site-level SWMS compliance monitoring."
  measures:
    - name: "total_swms"
      expr: COUNT(1)
      comment: "Total number of SWMS documents. Baseline KPI for safe work procedure coverage across construction activities."
    - name: "approved_swms"
      expr: COUNT(CASE WHEN approval_status IN ('Approved', 'approved') THEN 1 END)
      comment: "Count of formally approved SWMS. Work should only proceed under approved SWMS — this KPI measures governance compliance."
    - name: "swms_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status IN ('Approved', 'approved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SWMS that are formally approved. Low approval rates indicate governance gaps and potential unauthorised high-risk work."
    - name: "expired_swms"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND swms_status NOT IN ('Superseded', 'superseded', 'Cancelled', 'cancelled') THEN 1 END)
      comment: "Count of SWMS past their expiry date. Expired SWMS in use represent a critical compliance and safety risk requiring immediate review."
    - name: "high_risk_swms"
      expr: COUNT(CASE WHEN initial_risk_rating IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of SWMS covering high or critical risk activities. Used to prioritise HSE oversight and ensure the most dangerous activities have robust documented controls."
    - name: "residual_high_risk_swms"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical', 'high', 'critical') THEN 1 END)
      comment: "Count of SWMS where residual risk remains high or critical after controls. Indicates inadequate control measures requiring revision or escalation."
    - name: "swms_risk_reduction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_rating IN ('High', 'Critical', 'high', 'critical') AND residual_risk_rating NOT IN ('High', 'Critical', 'high', 'critical') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_rating IN ('High', 'Critical', 'high', 'critical') THEN 1 END), 0), 2)
      comment: "Percentage of high/critical risk SWMS where controls successfully reduced residual risk. Measures the effectiveness of documented safe work procedures in controlling risk."
    - name: "ptw_linked_swms"
      expr: COUNT(CASE WHEN ptw_required = TRUE THEN 1 END)
      comment: "Count of SWMS requiring an associated permit to work. Used to validate that PTW coverage aligns with SWMS requirements for high-risk activities."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE Plan KPIs tracking the governance, target-setting, and compliance posture of project-level Health, Safety and Environment plans. Used by HSE directors and project executives to ensure every project operates under a current, approved HSE plan with defined safety targets."
  source: "`vibe_construction_v1`.`safety`.`hse_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HSE plan (e.g., project HSE plan, environmental management plan, emergency response plan) for plan category analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the HSE plan (e.g., draft, approved, active, expired) for governance compliance monitoring."
    - name: "hse_plan_status"
      expr: hse_plan_status
      comment: "Operational status of the HSE plan record for workflow management."
    - name: "project_phase"
      expr: project_phase
      comment: "Construction project phase covered by the plan (e.g., design, construction, commissioning) for phase-specific safety governance."
    - name: "induction_required"
      expr: induction_required
      comment: "Flag indicating whether site induction is required under this plan, measuring induction programme coverage."
    - name: "ptw_required"
      expr: ptw_required
      comment: "Flag indicating whether a permit to work programme is required under this plan."
    - name: "swms_required"
      expr: swms_required
      comment: "Flag indicating whether SWMS are required under this plan, measuring SWMS programme mandate coverage."
    - name: "leed_applicable"
      expr: leed_applicable
      comment: "Flag indicating whether LEED sustainability requirements apply, supporting green building compliance tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plan applies for jurisdictional regulatory compliance analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the HSE plan became effective for temporal coverage analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project for project-level HSE plan governance analysis."
  measures:
    - name: "total_hse_plans"
      expr: COUNT(1)
      comment: "Total number of HSE plans. Baseline KPI for HSE governance coverage across projects."
    - name: "approved_hse_plans"
      expr: COUNT(CASE WHEN plan_status IN ('Approved', 'approved', 'Active', 'active') THEN 1 END)
      comment: "Count of approved and active HSE plans. Projects without an approved HSE plan represent a critical governance and regulatory compliance gap."
    - name: "expired_hse_plans"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND plan_status NOT IN ('Superseded', 'superseded', 'Cancelled', 'cancelled') THEN 1 END)
      comment: "Count of HSE plans past their expiry date. Expired plans in use represent a regulatory compliance risk and must be renewed immediately."
    - name: "avg_lti_target"
      expr: AVG(CAST(lti_target AS DOUBLE))
      comment: "Average LTI (Lost Time Injury) target set across HSE plans. Benchmarks the ambition of safety targets across the project portfolio."
    - name: "avg_trir_target"
      expr: AVG(CAST(trir_target AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) target set across HSE plans. The primary industry benchmark for safety performance target-setting."
    - name: "plans_overdue_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND plan_status NOT IN ('Expired', 'expired', 'Superseded', 'superseded') THEN 1 END)
      comment: "Count of HSE plans past their scheduled review date. Overdue reviews indicate stale safety governance that may not reflect current site conditions or regulatory requirements."
    - name: "ptw_programme_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ptw_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HSE plans mandating a permit to work programme. Measures the breadth of PTW governance across the project portfolio."
    - name: "swms_programme_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN swms_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HSE plans mandating SWMS. Measures the breadth of safe work method statement governance across the project portfolio."
$$;