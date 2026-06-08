-- Metric views for domain: safety | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_occurrence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety occurrences — the primary event record for aviation safety events including incidents, accidents, runway incursions, and dangerous goods events. Drives regulatory compliance tracking, risk trending, and operational safety steering."
  source: "`airlines_ecm`.`safety`.`occurrence`"
  dimensions:
    - name: "occurrence_date"
      expr: occurrence_date
      comment: "Calendar date the safety occurrence took place, used for trend analysis and period-over-period comparisons."
    - name: "occurrence_year_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month-level bucketing of occurrence date for monthly safety trend dashboards."
    - name: "occurrence_category_code"
      expr: category_code
      comment: "ICAO/IATA occurrence category code (e.g. LOC-I, CFIT, RE) used to classify the type of safety event for regulatory reporting."
    - name: "occurrence_classification"
      expr: classification
      comment: "Regulatory classification of the occurrence (e.g. Accident, Serious Incident, Incident) — drives mandatory notification obligations."
    - name: "occurrence_subtype"
      expr: subtype
      comment: "Detailed sub-classification of the occurrence type for granular safety analysis."
    - name: "flight_phase"
      expr: flight_phase
      comment: "Phase of flight during which the occurrence happened (e.g. Takeoff, Cruise, Landing) — critical for identifying high-risk operational phases."
    - name: "departure_airport_code"
      expr: departure_airport_code
      comment: "IATA code of the departure airport, enabling station-level safety performance analysis."
    - name: "arrival_airport_code"
      expr: arrival_airport_code
      comment: "IATA code of the arrival airport, enabling destination-level safety performance analysis."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity classification of injuries resulting from the occurrence (e.g. None, Minor, Serious, Fatal) — key for safety outcome reporting."
    - name: "aircraft_damage_level"
      expr: aircraft_damage_level
      comment: "Level of damage sustained by the aircraft (e.g. None, Minor, Substantial, Destroyed) — informs fleet risk and insurance exposure."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Boolean flag indicating whether the occurrence mandates regulatory notification — used to track compliance obligations."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Current status of the regulatory notification process for this occurrence — tracks compliance execution."
    - name: "reporting_source"
      expr: reporting_source
      comment: "Source through which the occurrence was reported (e.g. Crew, ATC, Ground Staff) — informs safety culture and reporting completeness."
    - name: "wildlife_ingestion_flag"
      expr: wildlife_ingestion_flag
      comment: "Boolean flag indicating whether the occurrence involved wildlife ingestion — used for wildlife hazard management programs."
    - name: "dangerous_goods_class"
      expr: dangerous_goods_class
      comment: "ICAO dangerous goods class involved in the occurrence, if applicable — drives DG compliance and cargo safety analysis."
    - name: "runway_incursion_severity"
      expr: runway_incursion_severity
      comment: "ICAO severity category of runway incursion (A–D) if the occurrence was a runway incursion — key for aerodrome safety programs."
  measures:
    - name: "total_occurrences"
      expr: COUNT(1)
      comment: "Total number of safety occurrences recorded. The primary volume KPI for safety event load and trend monitoring."
    - name: "regulatory_notifiable_occurrences"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of occurrences that legally require regulatory notification. Tracks mandatory reporting obligations and compliance exposure."
    - name: "regulatory_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_status = 'Notified' THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory regulatory notifications that have been completed. A critical compliance KPI — failure to notify regulators carries significant legal and operational risk."
    - name: "occurrences_with_injuries"
      expr: COUNT(CASE WHEN injury_severity NOT IN ('None', 'Nil') AND injury_severity IS NOT NULL THEN 1 END)
      comment: "Count of occurrences resulting in any level of injury. Tracks human harm outcomes and drives safety investment prioritisation."
    - name: "occurrences_with_aircraft_damage"
      expr: COUNT(CASE WHEN aircraft_damage_level NOT IN ('None', 'Nil') AND aircraft_damage_level IS NOT NULL THEN 1 END)
      comment: "Count of occurrences resulting in aircraft damage. Directly linked to fleet availability, maintenance cost, and insurance claims."
    - name: "wildlife_strike_occurrences"
      expr: COUNT(CASE WHEN wildlife_ingestion_flag = TRUE THEN 1 END)
      comment: "Count of occurrences involving wildlife ingestion or strike. Informs wildlife hazard management programs and aerodrome risk mitigation."
    - name: "runway_incursion_occurrences"
      expr: COUNT(CASE WHEN runway_incursion_severity IS NOT NULL AND runway_incursion_severity != '' THEN 1 END)
      comment: "Count of runway incursion occurrences. A top-tier ICAO safety priority metric tracked at executive and regulatory level."
    - name: "dangerous_goods_occurrences"
      expr: COUNT(CASE WHEN dangerous_goods_class IS NOT NULL AND dangerous_goods_class != '' THEN 1 END)
      comment: "Count of occurrences involving dangerous goods. Tracks DG compliance risk and informs cargo safety program effectiveness."
    - name: "distinct_aircraft_involved"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft involved in safety occurrences. Identifies fleet-level concentration of safety risk."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_hazard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the safety hazard register — the proactive risk management backbone of the Safety Management System (SMS). Tracks hazard identification, risk rating, mitigation progress, and regulatory reportability to steer proactive safety investment."
  source: "`airlines_ecm`.`safety`.`hazard`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "High-level category of the hazard (e.g. Airspace, Ground Operations, Maintenance) — used to allocate safety resources by risk domain."
    - name: "hazard_subcategory"
      expr: subcategory
      comment: "Detailed sub-classification of the hazard for granular risk register analysis."
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current lifecycle status of the hazard (e.g. Open, Mitigated, Closed) — tracks risk register health and closure velocity."
    - name: "initial_risk_index"
      expr: initial_risk_index
      comment: "Risk index assigned at the time of hazard identification before any mitigations — baseline risk exposure indicator."
    - name: "current_risk_index"
      expr: current_risk_index
      comment: "Current risk index after mitigations have been applied — measures effectiveness of risk reduction actions."
    - name: "initial_severity_rating"
      expr: initial_severity_rating
      comment: "Severity rating at initial hazard identification — used to prioritise response urgency."
    - name: "current_severity_rating"
      expr: current_severity_rating
      comment: "Current severity rating after mitigations — tracks whether severity has been reduced."
    - name: "initial_likelihood_rating"
      expr: initial_likelihood_rating
      comment: "Likelihood rating at initial identification — part of the risk matrix assessment."
    - name: "current_likelihood_rating"
      expr: current_likelihood_rating
      comment: "Current likelihood rating after mitigations — tracks probability reduction from safety controls."
    - name: "identification_source"
      expr: identification_source
      comment: "Source through which the hazard was identified (e.g. Audit, Occurrence Report, Proactive Survey) — informs SMS effectiveness and reporting culture."
    - name: "affected_operations_area"
      expr: affected_operations_area
      comment: "Operational area affected by the hazard (e.g. Flight Operations, Ground Handling, Maintenance) — drives departmental accountability."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating whether the hazard must be reported to the regulatory authority — tracks compliance obligations."
    - name: "notam_issued_flag"
      expr: notam_issued_flag
      comment: "Boolean flag indicating whether a NOTAM was issued in response to this hazard — tracks operational safety communication."
    - name: "sop_revision_required_flag"
      expr: sop_revision_required_flag
      comment: "Boolean flag indicating whether a Standard Operating Procedure revision is required to mitigate this hazard."
    - name: "identified_date"
      expr: identified_date
      comment: "Date the hazard was first identified — used for aging analysis and mitigation timeliness tracking."
    - name: "identified_year_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month-level bucketing of hazard identification date for trend analysis."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of hazards in the safety risk register. The primary volume KPI for SMS proactive risk identification activity."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status = 'Open' THEN 1 END)
      comment: "Count of hazards currently in Open status. Tracks the active risk backlog requiring management attention and mitigation resources."
    - name: "hazard_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazard_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all hazards that have been closed. A key SMS effectiveness KPI — low closure rates indicate risk backlog accumulation."
    - name: "regulatory_reportable_hazards"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of hazards flagged as requiring regulatory reporting. Tracks compliance exposure and notification obligations."
    - name: "hazards_requiring_sop_revision"
      expr: COUNT(CASE WHEN sop_revision_required_flag = TRUE THEN 1 END)
      comment: "Count of hazards that require a Standard Operating Procedure revision. Drives the SOP update workload and procedural safety improvement pipeline."
    - name: "hazards_with_notam_issued"
      expr: COUNT(CASE WHEN notam_issued_flag = TRUE THEN 1 END)
      comment: "Count of hazards for which a NOTAM was issued. Tracks the operational communication response to identified hazards."
    - name: "overdue_mitigation_hazards"
      expr: COUNT(CASE WHEN hazard_status != 'Closed' AND mitigation_target_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of open hazards whose mitigation target date has passed. A critical risk governance KPI — overdue mitigations represent uncontrolled risk exposure."
    - name: "distinct_routes_with_hazards"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes associated with registered hazards. Identifies route-level risk concentration for network safety management."
    - name: "distinct_aircraft_with_hazards"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft associated with registered hazards. Identifies fleet-level risk concentration for maintenance and airworthiness programs."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety audits — the formal assurance mechanism of the SMS and regulatory compliance program. Tracks audit execution, findings volume, corrective action plan obligations, and follow-up requirements to steer quality assurance governance."
  source: "`airlines_ecm`.`safety`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g. Internal, External, IOSA, Regulatory) — used to segment assurance activity by program."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g. Planned, In Progress, Completed, Closed) — tracks audit pipeline health."
    - name: "audited_department"
      expr: audited_department
      comment: "Department subject to the audit — enables departmental compliance performance benchmarking."
    - name: "audited_function"
      expr: audited_function
      comment: "Functional area audited (e.g. Flight Operations, Ground Handling, Maintenance) — drives functional accountability for compliance."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope description of the audit — provides context for findings volume and severity interpretation."
    - name: "regulatory_authority_name"
      expr: regulatory_authority_name
      comment: "Name of the regulatory authority that conducted or mandated the audit — used to track regulatory engagement and compliance posture."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Boolean flag indicating whether a corrective action plan is required as an outcome of the audit."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Boolean flag indicating whether a follow-up audit has been mandated — tracks recurring compliance risk."
    - name: "sms_accountable_executive_notified"
      expr: sms_accountable_executive_notified
      comment: "Boolean flag indicating whether the SMS Accountable Executive was notified of audit outcomes — tracks governance escalation compliance."
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual start date of the audit — used for scheduling adherence and audit cycle analysis."
    - name: "audit_year_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month-level bucketing of audit start date for audit activity trend analysis."
    - name: "report_issued_date"
      expr: report_issued_date
      comment: "Date the audit report was formally issued — used to measure audit cycle time from start to report."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safety audits conducted. The primary volume KPI for assurance program activity."
    - name: "completed_audits"
      expr: COUNT(CASE WHEN audit_status = 'Completed' THEN 1 END)
      comment: "Count of audits that have reached Completed status. Tracks assurance program execution rate."
    - name: "audit_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_status IN ('Completed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that have been completed or closed. A governance KPI measuring assurance program delivery effectiveness."
    - name: "audits_requiring_cap"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Count of audits that require a Corrective Action Plan. Tracks the volume of compliance remediation obligations generated by the audit program."
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Count of audits mandating a follow-up audit. Elevated follow-up rates signal systemic compliance weaknesses requiring executive attention."
    - name: "overdue_cap_audits"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE AND corrective_action_plan_due_date < CURRENT_DATE() AND audit_status NOT IN ('Closed') THEN 1 END)
      comment: "Count of audits where the Corrective Action Plan due date has passed and the audit is not yet closed. A critical compliance risk KPI."
    - name: "avg_audit_cycle_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average number of days from audit start to completion. Measures audit execution efficiency and resource utilisation."
    - name: "executive_notified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_accountable_executive_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits for which the SMS Accountable Executive was notified. Tracks governance escalation compliance — a regulatory expectation under ICAO SMS standards."
    - name: "distinct_departments_audited"
      expr: COUNT(DISTINCT audited_department)
      comment: "Number of distinct departments that have been audited. Measures breadth of assurance coverage across the organisation."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over audit findings — the granular compliance deficiency record. Tracks finding severity distribution, closure velocity, recurrence rates, and escalation patterns to drive targeted compliance improvement and regulatory risk reduction."
  source: "`airlines_ecm`.`safety`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g. Observation, Non-Conformance, Major Finding) — used to segment findings by severity class."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g. Documentation, Procedure, Training) — identifies systemic compliance weakness areas."
    - name: "finding_status"
      expr: finding_status
      comment: "Current lifecycle status of the finding (e.g. Open, In Progress, Closed, Verified) — tracks remediation pipeline."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding (e.g. Low, Medium, High, Critical) — prioritises remediation effort and executive escalation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for remediating the finding — enables departmental compliance performance tracking."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Boolean flag indicating whether this finding is a recurrence of a previously identified issue — a key indicator of systemic compliance failure."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the finding has been escalated — tracks governance response to high-risk compliance gaps."
    - name: "finding_date"
      expr: finding_date
      comment: "Date the finding was identified — used for trend analysis and aging calculations."
    - name: "finding_year_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month-level bucketing of finding date for monthly compliance trend dashboards."
    - name: "station_code"
      expr: station_code
      comment: "Station (airport) code where the finding was identified — enables station-level compliance benchmarking."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded. The primary volume KPI for compliance deficiency load."
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Count of findings currently in Open status. Tracks the active compliance remediation backlog."
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status IN ('Closed', 'Verified') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit findings that have been closed or verified. A key compliance governance KPI — low closure rates signal remediation capacity constraints."
    - name: "recurrent_findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of findings that are recurrences of previously identified issues. Elevated recurrence rates indicate systemic compliance failures and ineffective corrective actions."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrences. A critical quality KPI — high recurrence rates signal that root causes are not being addressed effectively."
    - name: "escalated_findings"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of findings that have been escalated. Tracks the volume of high-risk compliance gaps requiring senior management intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that required escalation. Informs leadership of the proportion of compliance issues exceeding normal remediation thresholds."
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed', 'Verified') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of open findings past their due date. A critical compliance risk KPI — overdue findings represent unresolved regulatory exposure."
    - name: "avg_finding_closure_days"
      expr: AVG(DATEDIFF(closure_date, finding_date))
      comment: "Average number of days from finding identification to closure. Measures remediation velocity and compliance responsiveness."
    - name: "distinct_departments_with_findings"
      expr: COUNT(DISTINCT responsible_department)
      comment: "Number of distinct departments with open or historical findings. Measures breadth of compliance risk exposure across the organisation."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety investigations — the formal root cause analysis process triggered by occurrences, hazards, and incidents. Tracks investigation throughput, regulatory notification compliance, completion timeliness, and cost to steer SMS effectiveness and regulatory standing."
  source: "`airlines_ecm`.`safety`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g. Internal, Regulatory, Joint) — used to segment investigation activity by authority and scope."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current lifecycle status of the investigation (e.g. Open, In Progress, Completed, Closed) — tracks investigation pipeline health."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the investigation (e.g. High, Medium, Low) — drives resource allocation and management attention."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory authority notification for this investigation — tracks mandatory reporting compliance."
    - name: "acars_data_reviewed"
      expr: acars_data_reviewed
      comment: "Boolean flag indicating whether ACARS data was reviewed during the investigation — measures investigation thoroughness."
    - name: "cvr_fdr_data_reviewed"
      expr: cvr_fdr_data_reviewed
      comment: "Boolean flag indicating whether CVR/FDR (black box) data was reviewed — a key indicator of investigation depth for serious occurrences."
    - name: "external_expert_consulted"
      expr: external_expert_consulted
      comment: "Boolean flag indicating whether an external expert was consulted — tracks investigation resource utilisation and complexity."
    - name: "risk_assessment_updated"
      expr: risk_assessment_updated
      comment: "Boolean flag indicating whether the risk assessment was updated as a result of the investigation — measures SMS feedback loop effectiveness."
    - name: "start_date"
      expr: start_date
      comment: "Date the investigation was initiated — used for aging analysis and timeliness tracking."
    - name: "investigation_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucketing of investigation start date for trend analysis."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of safety investigations initiated. The primary volume KPI for SMS investigation program activity."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status IN ('Open', 'In Progress') THEN 1 END)
      comment: "Count of investigations currently active. Tracks the investigation workload and resource demand on the safety team."
    - name: "investigation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_status IN ('Completed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been completed or closed. Measures SMS investigation throughput and closure effectiveness."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Completed', 'Closed') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of investigations past their target completion date. Overdue investigations represent unresolved safety risk and potential regulatory non-compliance."
    - name: "regulatory_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_status = 'Notified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations for which the regulatory authority has been notified. A mandatory compliance KPI under ICAO Annex 13 and national aviation regulations."
    - name: "total_investigation_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all investigations. Tracks the financial burden of safety investigation activity and informs safety budget planning."
    - name: "avg_investigation_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per investigation. Benchmarks investigation cost efficiency and identifies outlier high-cost investigations."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(actual_completion_date, start_date))
      comment: "Average number of days from investigation start to actual completion. Measures investigation cycle time efficiency — a key SMS performance indicator."
    - name: "investigations_with_risk_assessment_updated"
      expr: COUNT(CASE WHEN risk_assessment_updated = TRUE THEN 1 END)
      comment: "Count of investigations that resulted in an updated risk assessment. Measures the SMS feedback loop — investigations should drive risk register updates."
    - name: "risk_assessment_update_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_assessment_updated = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN investigation_status IN ('Completed', 'Closed') THEN 1 END), 0), 2)
      comment: "Percentage of completed investigations that resulted in a risk assessment update. A key SMS quality KPI — low rates indicate the investigation program is not feeding back into proactive risk management."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over corrective actions — the remediation and risk control implementation record spanning audit findings, occurrences, and investigations. Tracks action closure rates, cost, timeliness, and verification effectiveness to steer compliance remediation governance."
  source: "`airlines_ecm`.`safety`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Corrective, Preventive, Immediate) — used to segment remediation activity by response category."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current lifecycle status of the corrective action (e.g. Open, In Progress, Completed, Closed) — tracks remediation pipeline."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the corrective action — provides granular closure state beyond the main status field."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the corrective action (e.g. Critical, High, Medium, Low) — drives remediation sequencing and resource allocation."
    - name: "source_type"
      expr: source_type
      comment: "Source that generated the corrective action (e.g. Audit, Occurrence, Investigation, Hazard) — enables source-based remediation analysis."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for implementing the corrective action — enables departmental accountability tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the effectiveness verification for the corrective action — tracks whether remediation has been independently confirmed."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Rating of the corrective action's effectiveness after implementation — measures whether actions are actually resolving the underlying issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which corrective action costs are denominated — required for multi-currency cost aggregation context."
    - name: "target_completion_date"
      expr: target_completion_date
      comment: "Target date for completing the corrective action — used for overdue analysis and scheduling compliance."
    - name: "action_year_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month-level bucketing of target completion date for remediation pipeline planning."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions recorded. The primary volume KPI for compliance remediation workload."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status IN ('Open', 'In Progress') THEN 1 END)
      comment: "Count of corrective actions currently active. Tracks the remediation backlog and resource demand."
    - name: "corrective_action_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status IN ('Completed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been completed or closed. A primary compliance governance KPI — low rates signal remediation capacity or accountability gaps."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Completed', 'Closed') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of corrective actions past their target completion date. Overdue actions represent unresolved compliance risk and potential regulatory exposure."
    - name: "overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status NOT IN ('Completed', 'Closed') AND target_completion_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_status NOT IN ('Completed', 'Closed') THEN 1 END), 0), 2)
      comment: "Percentage of open corrective actions that are overdue. A critical compliance risk KPI for executive dashboards and regulatory audits."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all corrective actions. Tracks the financial investment in compliance remediation and safety improvement."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all corrective actions. Used for safety budget planning and cost-benefit analysis of remediation programs."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency and identifies high-cost action categories."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(cost_estimate AS DOUBLE)))
      comment: "Total variance between actual and estimated corrective action costs. Positive values indicate cost overruns in the safety remediation program — informs budget accuracy and planning."
    - name: "verified_actions"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of corrective actions that have been independently verified as effective. Tracks the quality assurance step in the remediation lifecycle."
    - name: "verification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_status IN ('Completed', 'Closed') THEN 1 END), 0), 2)
      comment: "Percentage of completed corrective actions that have been verified. Measures the rigour of the effectiveness verification process — a key SMS quality indicator."
    - name: "avg_implementation_days"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average number of days from corrective action creation to actual completion. Measures remediation velocity and implementation efficiency."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety recommendations — formal directives issued to address systemic safety risks identified through investigations, audits, and risk assessments. Tracks implementation rates, cost, timeliness, and regulatory compliance to steer safety improvement program effectiveness."
  source: "`airlines_ecm`.`safety`.`recommendation`"
  dimensions:
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of safety recommendation (e.g. Immediate, Urgent, Routine) — used to prioritise implementation and track response by urgency class."
    - name: "recommendation_status"
      expr: recommendation_status
      comment: "Current lifecycle status of the recommendation (e.g. Open, Accepted, Implemented, Closed, Rejected) — tracks implementation pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recommendation — drives implementation sequencing and resource allocation."
    - name: "safety_risk_category"
      expr: safety_risk_category
      comment: "Safety risk category addressed by the recommendation — enables risk-domain analysis of the recommendation portfolio."
    - name: "addressee_department"
      expr: addressee_department
      comment: "Internal department to which the recommendation is addressed — tracks departmental accountability for safety improvements."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the recommendation (e.g. Internal SMS, ATSB, NTSB, EASA) — distinguishes internal from regulatory recommendations."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the recommendation has a regulatory compliance dimension — tracks mandatory vs. voluntary safety improvements."
    - name: "sms_integration_flag"
      expr: sms_integration_flag
      comment: "Boolean flag indicating whether the recommendation has been integrated into the SMS — measures SMS feedback loop completeness."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the recommendation was formally issued — used for aging analysis and implementation timeliness tracking."
    - name: "recommendation_year_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month-level bucketing of recommendation issue date for trend analysis."
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of safety recommendations issued. The primary volume KPI for the safety improvement program."
    - name: "open_recommendations"
      expr: COUNT(CASE WHEN recommendation_status IN ('Open', 'Accepted', 'In Progress') THEN 1 END)
      comment: "Count of recommendations currently active and pending implementation. Tracks the safety improvement backlog."
    - name: "recommendation_implementation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recommendation_status IN ('Implemented', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety recommendations that have been implemented or closed. A primary SMS effectiveness KPI — low rates indicate safety improvement actions are not being executed."
    - name: "rejected_recommendations"
      expr: COUNT(CASE WHEN recommendation_status = 'Rejected' THEN 1 END)
      comment: "Count of recommendations that have been rejected. Elevated rejection rates may signal resource constraints or governance issues in the safety improvement program."
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recommendation_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety recommendations that were rejected. A governance quality KPI — high rejection rates require executive scrutiny and justification review."
    - name: "overdue_recommendations"
      expr: COUNT(CASE WHEN recommendation_status NOT IN ('Implemented', 'Closed', 'Rejected') AND target_implementation_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of open recommendations past their target implementation date. Overdue recommendations represent unaddressed safety risks and potential regulatory non-compliance."
    - name: "regulatory_compliance_recommendations"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of recommendations with a regulatory compliance dimension. Tracks the mandatory safety improvement obligation portfolio."
    - name: "total_estimated_implementation_cost"
      expr: SUM(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Total estimated cost to implement all safety recommendations. Informs safety investment planning and budget allocation decisions."
    - name: "avg_estimated_implementation_cost"
      expr: AVG(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Average estimated implementation cost per recommendation. Benchmarks safety improvement investment and identifies high-cost recommendation categories."
    - name: "avg_implementation_days"
      expr: AVG(DATEDIFF(actual_implementation_date, issue_date))
      comment: "Average number of days from recommendation issue to actual implementation. Measures safety improvement responsiveness — a key SMS performance indicator."
    - name: "sms_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_integration_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN recommendation_status IN ('Implemented', 'Closed') THEN 1 END), 0), 2)
      comment: "Percentage of implemented recommendations that have been integrated into the SMS. Measures the completeness of the safety improvement feedback loop into the broader SMS framework."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety risk assessments — the formal risk evaluation process within the SMS. Tracks assessment volume, risk distribution, review timeliness, and regulatory notification compliance to steer proactive risk governance and safety investment prioritisation."
  source: "`airlines_ecm`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g. Initial, Review, Post-Incident) — used to segment assessment activity by trigger and purpose."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current lifecycle status of the risk assessment (e.g. Draft, Active, Under Review, Closed) — tracks assessment currency and governance."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk being assessed (e.g. Flight Operations, Ground Operations, Maintenance) — enables risk portfolio analysis by domain."
    - name: "risk_index"
      expr: risk_index
      comment: "Composite risk index value from the risk matrix — the primary risk severity indicator for portfolio-level risk monitoring."
    - name: "risk_matrix_quadrant"
      expr: risk_matrix_quadrant
      comment: "Quadrant of the risk matrix (e.g. High/High, Low/Low) — provides a visual risk classification for executive risk dashboards."
    - name: "risk_tolerance_level"
      expr: risk_tolerance_level
      comment: "Risk tolerance classification (e.g. Acceptable, Tolerable, Intolerable) — the primary risk acceptability indicator for governance decisions."
    - name: "likelihood_score"
      expr: likelihood_score
      comment: "Likelihood score from the risk matrix — used to segment assessments by probability of occurrence."
    - name: "severity_score"
      expr: severity_score
      comment: "Severity score from the risk matrix — used to segment assessments by consequence magnitude."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the risk assessment (e.g. ICAO SMS, Bow-Tie, FMEA) — tracks methodological consistency across the risk portfolio."
    - name: "regulatory_authority_notified_flag"
      expr: regulatory_authority_notified_flag
      comment: "Boolean flag indicating whether the regulatory authority was notified of this risk assessment — tracks regulatory transparency obligations."
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date the risk assessment was conducted — used for currency analysis and review cycle tracking."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month-level bucketing of assessment date for risk assessment activity trend analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted. The primary volume KPI for SMS proactive risk management activity."
    - name: "active_risk_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Active' THEN 1 END)
      comment: "Count of currently active risk assessments. Tracks the live risk register size and SMS operational scope."
    - name: "intolerable_risk_assessments"
      expr: COUNT(CASE WHEN risk_tolerance_level = 'Intolerable' THEN 1 END)
      comment: "Count of risk assessments classified as Intolerable risk. The most critical safety governance KPI — intolerable risks require immediate executive action and mandatory mitigation."
    - name: "intolerable_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_tolerance_level = 'Intolerable' THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active risk assessments classified as Intolerable. A top-tier SMS KPI for board and executive safety committees — any non-zero value demands immediate action."
    - name: "overdue_review_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Active' AND next_review_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of active risk assessments past their next review due date. Overdue reviews mean the risk register is stale — a governance and regulatory compliance risk."
    - name: "review_currency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status = 'Active' AND next_review_due_date >= CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active risk assessments that are current (not overdue for review). Measures the currency and governance health of the risk register."
    - name: "regulatory_notified_assessments"
      expr: COUNT(CASE WHEN regulatory_authority_notified_flag = TRUE THEN 1 END)
      comment: "Count of risk assessments for which the regulatory authority was notified. Tracks proactive regulatory transparency and compliance with notification obligations."
    - name: "distinct_routes_assessed"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes covered by risk assessments. Measures the breadth of route-level risk management coverage across the network."
    - name: "avg_assessment_cycle_days"
      expr: AVG(DATEDIFF(review_date, assessment_date))
      comment: "Average number of days between initial assessment and review. Measures risk assessment review cycle efficiency and governance cadence."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety alerts — formal safety communications issued to fleet, operations, and maintenance teams in response to identified risks, regulatory directives, and airworthiness concerns. Tracks alert volume, compliance deadlines, acknowledgement rates, and regulatory reportability."
  source: "`airlines_ecm`.`safety`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of safety alert (e.g. Airworthiness Directive, Safety Bulletin, NOTAM, Operational Alert) — used to segment alert activity by communication category."
    - name: "alert_status"
      expr: alert_status
      comment: "Current lifecycle status of the alert (e.g. Active, Acknowledged, Closed, Superseded) — tracks alert lifecycle and compliance execution."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the alert (e.g. Critical, High, Medium, Low) — drives prioritisation of compliance response."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the alert — used to triage alert response and resource allocation."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the alert (e.g. EASA, FAA, Manufacturer, Internal) — distinguishes regulatory mandates from internal safety communications."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the required action — enables departmental compliance accountability tracking."
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Boolean flag indicating whether formal acknowledgement is required from recipients — tracks mandatory compliance confirmation obligations."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating whether the alert has regulatory reporting implications — tracks compliance notification obligations."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the alert was formally issued — used for trend analysis and compliance deadline tracking."
    - name: "alert_year_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month-level bucketing of alert issue date for safety communication trend analysis."
    - name: "compliance_deadline"
      expr: compliance_deadline
      comment: "Date by which the required action must be completed — the primary compliance tracking dimension for alert management."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of safety alerts issued. The primary volume KPI for safety communication activity and compliance obligation load."
    - name: "active_alerts"
      expr: COUNT(CASE WHEN alert_status = 'Active' THEN 1 END)
      comment: "Count of currently active safety alerts. Tracks the live compliance action backlog requiring operational response."
    - name: "critical_alerts"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of alerts classified as Critical severity. The highest-priority safety communication KPI — critical alerts demand immediate executive awareness and operational response."
    - name: "overdue_compliance_alerts"
      expr: COUNT(CASE WHEN alert_status NOT IN ('Closed', 'Superseded') AND compliance_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Count of active alerts past their compliance deadline. Overdue compliance represents direct regulatory non-compliance and airworthiness risk."
    - name: "compliance_on_time_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_status IN ('Closed') AND (closed_timestamp IS NULL OR CAST(closed_timestamp AS DATE) <= compliance_deadline) THEN 1 END) / NULLIF(COUNT(CASE WHEN alert_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed alerts that were closed on or before the compliance deadline. Measures the organisation's ability to execute safety compliance actions within mandated timeframes."
    - name: "regulatory_reportable_alerts"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of alerts with regulatory reporting obligations. Tracks the mandatory notification workload generated by the alert program."
    - name: "acknowledgement_required_alerts"
      expr: COUNT(CASE WHEN acknowledgement_required_flag = TRUE THEN 1 END)
      comment: "Count of alerts requiring formal acknowledgement from recipients. Tracks the formal compliance confirmation obligation volume."
    - name: "superseded_alerts"
      expr: COUNT(CASE WHEN alert_status = 'Superseded' THEN 1 END)
      comment: "Count of alerts that have been superseded by newer alerts. Tracks alert version management and ensures recipients are acting on current directives."
    - name: "distinct_aircraft_types_alerted"
      expr: COUNT(DISTINCT aircraft_type_id)
      comment: "Number of distinct aircraft types covered by safety alerts. Measures the breadth of fleet-level safety communication coverage."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over safety reports — the formal safety reporting record encompassing voluntary and mandatory reports from crew, ground staff, and other stakeholders. Tracks reporting culture health, investigation trigger rates, regulatory notification compliance, and distribution effectiveness."
  source: "`airlines_ecm`.`safety`.`report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of safety report (e.g. Voluntary, Mandatory, Confidential, ASR) — used to segment reporting activity by program and obligation type."
    - name: "report_status"
      expr: report_status
      comment: "Current lifecycle status of the report (e.g. Submitted, Under Review, Closed) — tracks report processing pipeline."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the report — used to prioritise investigation and response actions."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the report — drives triage and response prioritisation."
    - name: "reporter_role"
      expr: reporter_role
      comment: "Role of the person who submitted the report (e.g. Captain, Cabin Crew, Ground Staff, ATC) — informs safety culture analysis and reporting source diversity."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority associated with the report — distinguishes internal from regulatory-driven reports."
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Boolean flag indicating whether the report triggered an investigation — measures the proportion of reports escalating to formal investigation."
    - name: "regulatory_notification_flag"
      expr: regulatory_notification_flag
      comment: "Boolean flag indicating whether regulatory notification was required for this report — tracks mandatory reporting obligations."
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Boolean flag indicating whether formal acknowledgement is required — tracks reporter feedback obligations."
    - name: "de_identification_flag"
      expr: de_identification_flag
      comment: "Boolean flag indicating whether the report was de-identified — tracks confidential reporting program utilisation, a key safety culture indicator."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of report distribution to relevant stakeholders — tracks safety communication effectiveness."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month-level bucketing of report submission timestamp for safety reporting trend analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of safety reports submitted. The primary safety culture KPI — higher voluntary reporting volumes indicate a healthy, open safety culture."
    - name: "reports_requiring_investigation"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END)
      comment: "Count of reports that triggered a formal investigation. Tracks the escalation rate from reporting to formal investigation."
    - name: "investigation_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety reports that triggered a formal investigation. Measures the severity profile of the reporting stream and investigation resource demand."
    - name: "regulatory_notification_required_reports"
      expr: COUNT(CASE WHEN regulatory_notification_flag = TRUE THEN 1 END)
      comment: "Count of reports requiring regulatory notification. Tracks mandatory reporting obligations generated by the safety reporting program."
    - name: "confidential_reports"
      expr: COUNT(CASE WHEN de_identification_flag = TRUE THEN 1 END)
      comment: "Count of de-identified (confidential) safety reports. Tracks utilisation of the confidential reporting channel — a key safety culture health indicator."
    - name: "confidential_reporting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN de_identification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted through the confidential (de-identified) channel. Higher rates indicate stronger just culture and reporter trust in the safety system."
    - name: "open_reports"
      expr: COUNT(CASE WHEN report_status NOT IN ('Closed') THEN 1 END)
      comment: "Count of reports not yet closed. Tracks the active report processing backlog and safety team workload."
    - name: "report_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety reports that have been closed. Measures report processing efficiency and the organisation's ability to close the loop on safety concerns."
    - name: "distinct_aircraft_reported"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft referenced in safety reports. Identifies aircraft with elevated safety reporting activity for targeted fleet risk management."
    - name: "distinct_routes_reported"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes referenced in safety reports. Identifies route-level safety concern concentration for network risk management."
$$;