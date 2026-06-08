-- Metric views for domain: compliance | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for compliance inspections across facilities — tracks inspection outcomes, violation rates, penalty exposure, and corrective action burden to steer regulatory risk management."
  source: "`waste_management_ecm`.`compliance`.`compliance_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., routine, follow-up, complaint-driven) — used to segment inspection outcomes by program type."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g., pass, fail, conditional) — primary dimension for compliance performance analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current lifecycle status of the inspection (e.g., scheduled, completed, overdue) — used to track open vs. closed inspections."
    - name: "inspecting_authority"
      expr: inspecting_authority
      comment: "Regulatory authority conducting the inspection — enables analysis by agency or jurisdiction."
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (e.g., full facility, targeted area) — used to assess depth of regulatory scrutiny."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action was mandated — key filter for post-inspection remediation tracking."
    - name: "notice_of_violation_issued"
      expr: notice_of_violation_issued
      comment: "Boolean flag indicating a formal notice of violation was issued — critical dimension for regulatory enforcement tracking."
    - name: "iso_14001_audit"
      expr: iso_14001_audit
      comment: "Indicates whether the inspection was an ISO 14001 environmental management audit — used for ISO certification compliance tracking."
    - name: "iso_45001_audit"
      expr: iso_45001_audit
      comment: "Indicates whether the inspection was an ISO 45001 occupational health and safety audit — used for ISO certification compliance tracking."
    - name: "actual_inspection_date_month"
      expr: DATE_TRUNC('MONTH', actual_inspection_date)
      comment: "Month of the actual inspection date — enables trend analysis of inspection activity over time."
    - name: "actual_inspection_date_year"
      expr: DATE_TRUNC('YEAR', actual_inspection_date)
      comment: "Year of the actual inspection date — enables year-over-year comparison of inspection outcomes."
    - name: "frequency_requirement"
      expr: frequency_requirement
      comment: "Regulatory frequency requirement for the inspection (e.g., annual, quarterly) — used to assess compliance with inspection scheduling obligations."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of compliance inspections conducted — baseline volume metric for inspection program activity."
    - name: "inspections_with_violation_notice"
      expr: COUNT(CASE WHEN notice_of_violation_issued = TRUE THEN 1 END)
      comment: "Number of inspections that resulted in a formal notice of violation — key indicator of regulatory enforcement exposure."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections that mandated corrective action — measures remediation burden arising from inspection findings."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all inspections — direct measure of financial regulatory exposure."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per inspection — used to benchmark severity of regulatory enforcement actions."
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that received at least one inspection — measures breadth of regulatory oversight coverage."
    - name: "overdue_follow_up_inspections"
      expr: COUNT(CASE WHEN follow_up_due_date < CURRENT_DATE AND inspection_status != 'Completed' THEN 1 END)
      comment: "Number of inspections with a past-due follow-up date that are not yet completed — critical operational risk indicator for regulatory non-compliance."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_violation_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for regulatory violation notices — tracks penalty exposure, resolution rates, appeal activity, and settlement outcomes to manage enforcement risk and financial liability."
  source: "`waste_management_ecm`.`compliance`.`violation_notice`"
  dimensions:
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation notice (e.g., open, resolved, appealed) — primary dimension for enforcement pipeline management."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity classification of the violation (e.g., minor, major, critical) — used to prioritize remediation and assess regulatory risk."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the violation (e.g., air, water, hazardous waste) — enables analysis by environmental media or regulatory program."
    - name: "notice_type"
      expr: notice_type
      comment: "Type of violation notice issued (e.g., NOV, compliance order, consent agreement) — used to segment enforcement actions by instrument type."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the violation notice — enables analysis by jurisdiction and enforcement authority."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the violation was cited (e.g., RCRA, Clean Air Act) — used for program-level compliance performance tracking."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Boolean flag indicating whether an appeal was filed — used to track contested enforcement actions."
    - name: "settlement_agreement_flag"
      expr: settlement_agreement_flag
      comment: "Boolean flag indicating whether a settlement agreement was reached — used to track negotiated resolutions vs. contested enforcement."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Boolean flag indicating whether the violation is subject to public disclosure — used to assess reputational and transparency risk."
    - name: "violation_date_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month of the violation date — enables trend analysis of violation frequency over time."
    - name: "violation_date_year"
      expr: DATE_TRUNC('YEAR', violation_date)
      comment: "Year of the violation date — enables year-over-year comparison of enforcement activity."
  measures:
    - name: "total_violation_notices"
      expr: COUNT(1)
      comment: "Total number of violation notices issued — baseline measure of regulatory enforcement activity against the organization."
    - name: "total_penalty_assessed"
      expr: SUM(CAST(penalty_assessed_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all violation notices — primary measure of financial regulatory liability."
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total monetary penalties actually paid — used to track cash outflow from regulatory enforcement and outstanding payment obligations."
    - name: "avg_penalty_assessed"
      expr: AVG(CAST(penalty_assessed_amount AS DOUBLE))
      comment: "Average penalty assessed per violation notice — benchmarks enforcement severity and informs risk provisioning."
    - name: "open_violation_notices"
      expr: COUNT(CASE WHEN violation_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of violation notices that remain open or unresolved — key indicator of outstanding regulatory enforcement exposure."
    - name: "violations_with_appeal"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of violation notices for which an appeal was filed — measures contested enforcement activity and legal resource demand."
    - name: "violations_with_settlement"
      expr: COUNT(CASE WHEN settlement_agreement_flag = TRUE THEN 1 END)
      comment: "Number of violation notices resolved via settlement agreement — tracks negotiated resolution rate as an alternative to litigation."
    - name: "penalty_outstanding_amount"
      expr: SUM(CAST(penalty_assessed_amount AS DOUBLE) - CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total outstanding penalty balance (assessed minus paid) — measures unresolved financial liability from regulatory enforcement."
    - name: "distinct_facilities_with_violations"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that received at least one violation notice — measures breadth of enforcement exposure across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_inspection_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for inspection findings — tracks finding severity, repeat violations, penalty exposure, and closure rates to drive corrective action prioritization and regulatory risk reduction."
  source: "`waste_management_ecm`.`compliance`.`inspection_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of inspection finding (e.g., violation, observation, recommendation) — used to segment findings by regulatory significance."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding (e.g., critical, major, minor) — primary dimension for prioritizing corrective action."
    - name: "inspection_finding_status"
      expr: inspection_finding_status
      comment: "Current lifecycle status of the finding (e.g., open, in-progress, closed) — used to track remediation pipeline."
    - name: "regulation_category"
      expr: regulation_category
      comment: "Regulatory category associated with the finding (e.g., air, water, hazardous waste) — enables program-level compliance gap analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action is required for this finding — used to filter actionable findings."
    - name: "repeat_finding"
      expr: repeat_finding
      comment: "Boolean flag indicating whether this is a repeat finding from a prior inspection — critical indicator of systemic compliance failure."
    - name: "root_cause_analysis_completed"
      expr: root_cause_analysis_completed
      comment: "Boolean flag indicating whether root cause analysis has been completed — used to track investigation thoroughness."
    - name: "facility_area"
      expr: facility_area
      comment: "Area of the facility where the finding was identified — enables spatial analysis of compliance gaps within a facility."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification of the finding — used to identify systemic drivers of non-compliance for targeted remediation."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the finding remediation is due — used to forecast corrective action workload and identify upcoming deadlines."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings — baseline measure of compliance gap volume across all inspections."
    - name: "critical_findings"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of findings classified as critical severity — highest-priority measure for executive risk reporting."
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding = TRUE THEN 1 END)
      comment: "Number of findings that are repeats from prior inspections — key indicator of systemic non-compliance and ineffective corrective actions."
    - name: "open_findings"
      expr: COUNT(CASE WHEN inspection_finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of findings that remain open and unresolved — measures outstanding remediation backlog and regulatory exposure."
    - name: "total_potential_penalty_exposure"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all open and closed findings — quantifies maximum financial risk from inspection findings."
    - name: "avg_potential_penalty_per_finding"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty per finding — used to benchmark severity and prioritize high-value remediation efforts."
    - name: "findings_past_due"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND inspection_finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of findings whose remediation due date has passed and are still open — critical operational risk indicator for regulatory non-compliance."
    - name: "findings_requiring_rca"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND root_cause_analysis_completed = FALSE THEN 1 END)
      comment: "Number of findings requiring corrective action where root cause analysis has not yet been completed — measures investigation backlog."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_ehs_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic EHS KPIs tracking environmental, health, and safety incidents — measures OSHA recordability, property damage, regulatory reporting obligations, and corrective action completion to steer safety culture and regulatory compliance."
  source: "`waste_management_ecm`.`compliance`.`ehs_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of EHS incident (e.g., spill, injury, near-miss, fire) — primary dimension for incident classification and trend analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (e.g., open, under investigation, closed) — used to track incident resolution pipeline."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Boolean flag indicating whether the incident is OSHA recordable — critical dimension for regulatory reporting and safety performance benchmarking."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Boolean flag indicating whether regulatory reporting is required for this incident — used to track mandatory notification obligations."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Boolean flag indicating whether corrective action is required — used to filter incidents driving remediation workload."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Classification of the root cause of the incident — used to identify systemic safety and environmental risk drivers."
    - name: "environmental_media_affected"
      expr: environmental_media_affected
      comment: "Environmental media impacted by the incident (e.g., air, water, soil) — used to assess environmental impact scope."
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained (e.g., laceration, fracture, chemical exposure) — used for safety trend analysis and PPE program evaluation."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident date — enables trend analysis of incident frequency over time."
    - name: "incident_date_year"
      expr: DATE_TRUNC('YEAR', incident_date)
      comment: "Year of the incident date — enables year-over-year safety performance comparison."
    - name: "ppe_in_use_flag"
      expr: ppe_in_use_flag
      comment: "Boolean flag indicating whether PPE was in use at the time of the incident — used to evaluate PPE program effectiveness."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of EHS incidents recorded — baseline measure of safety and environmental event frequency."
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Number of OSHA recordable incidents — primary regulatory safety performance metric reported to OSHA and used in industry benchmarking."
    - name: "incidents_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents that require mandatory regulatory reporting — measures regulatory notification obligation volume."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage costs from EHS incidents — quantifies direct financial impact of safety and environmental events."
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity of material released across all incidents — measures cumulative environmental release volume for regulatory and sustainability reporting."
    - name: "incidents_with_overdue_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE AND corrective_action_due_date < CURRENT_DATE AND corrective_action_completed_date IS NULL THEN 1 END)
      comment: "Number of incidents with overdue corrective actions — critical operational risk indicator for unresolved safety and environmental hazards."
    - name: "incidents_without_ppe"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE AND ppe_in_use_flag = FALSE THEN 1 END)
      comment: "Number of OSHA recordable incidents where PPE was not in use — measures PPE compliance gap and informs safety training prioritization."
    - name: "distinct_facilities_with_incidents"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that experienced at least one EHS incident — measures breadth of safety risk exposure across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs tracking regulatory limit exceedances, measurement values, and corrective action triggers — enables proactive environmental compliance management and permit condition adherence."
  source: "`waste_management_ecm`.`compliance`.`environmental_monitoring`"
  dimensions:
    - name: "parameter_measured"
      expr: parameter_measured
      comment: "Environmental parameter being monitored (e.g., pH, BOD, mercury concentration) — primary dimension for pollutant-level compliance analysis."
    - name: "monitoring_program_type"
      expr: monitoring_program_type
      comment: "Type of monitoring program (e.g., groundwater, air emissions, stormwater) — used to segment monitoring results by environmental media."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency at which monitoring is conducted (e.g., daily, monthly, quarterly) — used to assess monitoring program intensity."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Boolean flag indicating whether the measured value exceeded the regulatory limit — primary filter for compliance exceedance analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action is required based on monitoring results — used to track remediation triggers."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Boolean flag indicating whether regulatory reporting is required for this monitoring result — used to track mandatory disclosure obligations."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the monitored parameter — used to ensure consistent comparison of measured values against regulatory limits."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period associated with the monitoring event — used to align monitoring results with regulatory submission cycles."
    - name: "sample_collection_month"
      expr: DATE_TRUNC('MONTH', sample_collection_timestamp)
      comment: "Month of sample collection — enables trend analysis of environmental monitoring results over time."
    - name: "sample_collection_year"
      expr: DATE_TRUNC('YEAR', sample_collection_timestamp)
      comment: "Year of sample collection — enables year-over-year comparison of environmental compliance performance."
    - name: "data_qualifier"
      expr: data_qualifier
      comment: "Data quality qualifier for the monitoring result (e.g., estimated, below detection limit) — used to assess data reliability in compliance reporting."
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring events recorded — baseline measure of monitoring program activity."
    - name: "exceedance_events"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of monitoring events where measured values exceeded regulatory limits — primary indicator of environmental permit non-compliance."
    - name: "events_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of monitoring events that triggered a corrective action requirement — measures remediation burden from environmental monitoring."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all monitoring events — used to track central tendency of environmental parameters relative to regulatory limits."
    - name: "avg_regulatory_limit"
      expr: AVG(CAST(regulatory_limit AS DOUBLE))
      comment: "Average regulatory limit across all monitoring events — provides context for interpreting measured values and exceedance rates."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average analytical detection limit across monitoring events — used to assess laboratory sensitivity and data quality for compliance reporting."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter_measured)
      comment: "Number of distinct environmental parameters being monitored — measures breadth of environmental monitoring program coverage."
    - name: "distinct_facilities_monitored"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with active environmental monitoring — measures scope of environmental compliance monitoring program."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic permit portfolio KPIs — tracks permit status, expiration risk, financial assurance obligations, and renewal pipeline to ensure uninterrupted operational authorization and regulatory compliance."
  source: "`waste_management_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., active, expired, pending renewal) — primary dimension for permit portfolio health monitoring."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., air, water, hazardous waste, solid waste) — used to segment permit portfolio by regulatory program."
    - name: "permit_tier"
      expr: permit_tier
      comment: "Regulatory tier classification of the permit (e.g., Title V, minor source) — used to assess regulatory complexity and compliance burden."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the permit — enables analysis of permit portfolio by regulatory jurisdiction."
    - name: "issuing_agency_jurisdiction"
      expr: issuing_agency_jurisdiction
      comment: "Jurisdiction of the issuing agency (e.g., federal, state, local) — used to segment permits by regulatory level."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status of the permit (e.g., not started, in progress, submitted) — used to track renewal pipeline and avoid lapses."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the permit was issued (e.g., RCRA, Clean Air Act, NPDES) — used for program-level permit portfolio analysis."
    - name: "financial_assurance_required"
      expr: financial_assurance_required
      comment: "Boolean flag indicating whether financial assurance is required for this permit — used to track financial obligation coverage."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the permit expires — used to forecast permit renewal workload and identify near-term expiration risk."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of regulatory reporting required under the permit — used to assess compliance reporting burden."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio — baseline measure of regulatory authorization scope."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active permits — measures operational authorization coverage across the facility portfolio."
    - name: "expired_permits"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE AND permit_status != 'Renewed' THEN 1 END)
      comment: "Number of permits that have passed their expiration date without renewal — critical risk indicator for unauthorized operations."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of permits expiring within the next 90 days — forward-looking risk metric for renewal prioritization and resource planning."
    - name: "total_financial_assurance_amount"
      expr: SUM(CAST(financial_assurance_amount AS DOUBLE))
      comment: "Total financial assurance amount required across all permits — measures aggregate financial obligation for regulatory closure and remediation coverage."
    - name: "permits_with_financial_assurance"
      expr: COUNT(CASE WHEN financial_assurance_required = TRUE THEN 1 END)
      comment: "Number of permits requiring financial assurance — used to track financial obligation coverage and assurance instrument management."
    - name: "permits_with_permitted_capacity"
      expr: SUM(CAST(permitted_capacity AS DOUBLE))
      comment: "Total permitted operational capacity across all active permits — measures aggregate authorized throughput for capacity planning and regulatory compliance."
    - name: "distinct_facilities_with_permits"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities holding at least one permit — measures breadth of regulatory authorization across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_regulatory_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action program KPIs — tracks remediation cost, completion rates, overdue actions, and verification status to ensure timely resolution of regulatory findings and minimize enforcement escalation risk."
  source: "`waste_management_ecm`.`compliance`.`regulatory_corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g., open, in-progress, completed, verified) — primary dimension for remediation pipeline management."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g., engineering control, administrative, training) — used to segment remediation efforts by approach."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the corrective action (e.g., high, medium, low) — used to focus resources on highest-risk remediation items."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the corrective action (e.g., inspection finding, violation notice, incident) — used to trace remediation back to root regulatory drivers."
    - name: "environmental_impact_category"
      expr: environmental_impact_category
      comment: "Category of environmental impact addressed by the corrective action — used to segment remediation by environmental media or risk type."
    - name: "safety_impact_category"
      expr: safety_impact_category
      comment: "Category of safety impact addressed by the corrective action — used to segment remediation by safety risk type."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of corrective action verification (e.g., pending, verified, rejected) — used to track regulatory closure confirmation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the corrective action — used to allocate accountability and track departmental remediation performance."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessment of the risk that the issue will recur after corrective action — used to prioritize systemic vs. one-time remediation efforts."
    - name: "target_completion_date_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the corrective action is targeted for completion — used to forecast remediation workload and identify upcoming deadlines."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of regulatory corrective actions — baseline measure of remediation program volume."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status NOT IN ('Completed', 'Closed', 'Verified') THEN 1 END)
      comment: "Number of corrective actions that remain open — measures outstanding remediation backlog and regulatory exposure."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND action_status NOT IN ('Completed', 'Closed', 'Verified') THEN 1 END)
      comment: "Number of corrective actions past their target completion date that are not yet closed — critical risk indicator for regulatory escalation."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions — measures direct financial expenditure on regulatory remediation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all corrective actions — used for remediation budget planning and financial provisioning."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action — benchmarks remediation cost efficiency and informs future cost estimation."
    - name: "actions_pending_verification"
      expr: COUNT(CASE WHEN action_status = 'Completed' AND verification_status NOT IN ('Verified', 'Closed') THEN 1 END)
      comment: "Number of completed corrective actions awaiting regulatory verification — measures closure pipeline and potential regulatory re-opening risk."
    - name: "high_priority_open_actions"
      expr: COUNT(CASE WHEN priority_level = 'High' AND action_status NOT IN ('Completed', 'Closed', 'Verified') THEN 1 END)
      comment: "Number of high-priority corrective actions that remain open — executive-level risk indicator for critical unresolved regulatory obligations."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs — tracks on-time filing rates, late submission exposure, agency response status, and amendment activity to ensure regulatory reporting obligations are met and enforcement risk is minimized."
  source: "`waste_management_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission (e.g., submitted, accepted, rejected, pending) — primary dimension for submission pipeline management."
    - name: "report_type"
      expr: report_type
      comment: "Type of regulatory report submitted (e.g., annual compliance report, discharge monitoring report) — used to segment submissions by reporting obligation."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the submission was filed (e.g., RCRA, Clean Air Act, NPDES) — used for program-level reporting compliance analysis."
    - name: "filing_agency"
      expr: filing_agency
      comment: "Regulatory agency to which the submission was filed — enables analysis by jurisdiction and agency."
    - name: "agency_jurisdiction"
      expr: agency_jurisdiction
      comment: "Jurisdiction of the filing agency (e.g., federal, state, local) — used to segment submissions by regulatory level."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Boolean flag indicating whether the submission was filed after the due date — primary dimension for on-time compliance analysis."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Boolean flag indicating whether this submission is an amendment to a prior filing — used to track data quality and correction activity."
    - name: "agency_response_status"
      expr: agency_response_status
      comment: "Status of the agency response to the submission (e.g., accepted, deficiency notice, under review) — used to track regulatory acceptance rates."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., electronic, paper, portal) — used to track e-reporting adoption and submission channel efficiency."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the submission was due — enables trend analysis of reporting obligation volume and on-time performance over time."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year associated with the submission — used to align reporting metrics with annual regulatory cycles."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed — baseline measure of regulatory reporting activity."
    - name: "late_submissions"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of submissions filed after the regulatory due date — primary indicator of reporting compliance failure and enforcement risk."
    - name: "on_time_submissions"
      expr: COUNT(CASE WHEN late_submission_flag = FALSE THEN 1 END)
      comment: "Number of submissions filed on or before the regulatory due date — measures reporting compliance rate."
    - name: "amendment_submissions"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of submissions that are amendments to prior filings — measures data quality issues and correction burden in regulatory reporting."
    - name: "submissions_with_deficiency"
      expr: COUNT(CASE WHEN agency_response_status IN ('Deficiency Notice', 'Rejected', 'Incomplete') THEN 1 END)
      comment: "Number of submissions that received a deficiency notice or rejection from the regulatory agency — measures submission quality and rework burden."
    - name: "distinct_facilities_reporting"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that filed at least one regulatory submission — measures breadth of active regulatory reporting obligations."
    - name: "submissions_past_due_unsubmitted"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND submission_status NOT IN ('Submitted', 'Accepted', 'Filed') THEN 1 END)
      comment: "Number of submissions whose due date has passed but have not yet been filed — critical risk indicator for imminent regulatory enforcement."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_training_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compliance training KPIs — tracks certification currency, expiration risk, training hours, pass rates, and cost to ensure regulatory training obligations are met and workforce competency is maintained."
  source: "`waste_management_ecm`.`compliance`.`training_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the training certification (e.g., active, expired, pending renewal) — primary dimension for workforce compliance currency analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., HAZWOPER, CDL, DOT hazmat) — used to segment training compliance by regulatory requirement type."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the training assessment — used to measure training effectiveness and identify competency gaps."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Boolean flag indicating whether the certification is required for regulatory compliance — used to prioritize mandatory training tracking."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating whether the certification requires periodic renewal — used to forecast renewal workload."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification — used to segment certifications by accreditation source."
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Method of training delivery (e.g., classroom, online, on-the-job) — used to analyze training program effectiveness by delivery channel."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the certification expires — used to forecast renewal workload and identify near-term expiration risk."
    - name: "completion_date_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year the training was completed — enables year-over-year comparison of training program activity."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of training certifications on record — baseline measure of workforce training program scope."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active and valid certifications — measures current workforce compliance training currency."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE AND certification_status != 'Renewed' THEN 1 END)
      comment: "Number of certifications that have expired — critical indicator of workforce regulatory compliance gaps."
    - name: "certifications_expiring_within_60_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 60) THEN 1 END)
      comment: "Number of certifications expiring within the next 60 days — forward-looking metric for proactive renewal planning and compliance risk management."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all certifications — measures workforce investment in compliance training."
    - name: "avg_training_hours_per_certification"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per certification — used to benchmark training program depth and identify under-resourced compliance training areas."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training certifications — measures financial investment in workforce compliance training program."
    - name: "failed_certifications"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of certifications where the trainee failed the assessment — measures training effectiveness and identifies competency gaps requiring remediation."
    - name: "mandatory_compliance_certifications"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Number of certifications that are mandatory for regulatory compliance — measures the scope of legally required training obligations."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_regulated_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulated facility portfolio KPIs — tracks compliance risk levels, ISO certification status, operational status, and permit expiration across the facility estate to steer enterprise-wide regulatory risk management."
  source: "`waste_management_ecm`.`compliance`.`regulated_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the regulated facility (e.g., active, closed, post-closure) — primary dimension for facility portfolio segmentation."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of regulated facility (e.g., landfill, transfer station, TSDF, recycling center) — used to segment compliance risk by facility category."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Compliance risk level assigned to the facility (e.g., high, medium, low) — primary dimension for risk-based regulatory oversight prioritization."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory status of the facility (e.g., in compliance, significant non-complier, under enforcement) — used to track regulatory standing across the portfolio."
    - name: "rcra_generator_status"
      expr: rcra_generator_status
      comment: "RCRA hazardous waste generator status (e.g., LQG, SQG, VSQG) — used to segment facilities by hazardous waste regulatory tier."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Boolean flag indicating ISO 14001 environmental management system certification — used to track environmental management maturity across the portfolio."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Boolean flag indicating ISO 45001 occupational health and safety management system certification — used to track safety management maturity."
    - name: "post_closure_monitoring_required"
      expr: post_closure_monitoring_required
      comment: "Boolean flag indicating whether post-closure monitoring is required — used to identify long-term environmental liability obligations."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the facility is located — used for geographic segmentation of compliance risk and regulatory jurisdiction analysis."
    - name: "title_v_designation"
      expr: title_v_designation
      comment: "Title V air permit designation of the facility — used to identify major source air emission facilities subject to enhanced regulatory requirements."
  measures:
    - name: "total_regulated_facilities"
      expr: COUNT(1)
      comment: "Total number of regulated facilities in the portfolio — baseline measure of regulatory footprint."
    - name: "high_risk_facilities"
      expr: COUNT(CASE WHEN compliance_risk_level = 'High' THEN 1 END)
      comment: "Number of facilities classified as high compliance risk — executive-level indicator of concentrated regulatory exposure requiring priority attention."
    - name: "facilities_with_permit_expiring_soon"
      expr: COUNT(CASE WHEN permit_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of regulated facilities whose operating permit expires within 90 days — forward-looking risk metric for permit renewal prioritization."
    - name: "total_design_capacity"
      expr: SUM(CAST(design_capacity AS DOUBLE))
      comment: "Total design capacity across all regulated facilities — measures aggregate authorized operational throughput for capacity planning."
    - name: "iso_14001_certified_facilities"
      expr: COUNT(CASE WHEN iso_14001_certified = TRUE THEN 1 END)
      comment: "Number of facilities with ISO 14001 environmental management system certification — measures environmental management maturity across the portfolio."
    - name: "iso_45001_certified_facilities"
      expr: COUNT(CASE WHEN iso_45001_certified = TRUE THEN 1 END)
      comment: "Number of facilities with ISO 45001 occupational health and safety certification — measures safety management maturity across the portfolio."
    - name: "facilities_requiring_post_closure_monitoring"
      expr: COUNT(CASE WHEN post_closure_monitoring_required = TRUE THEN 1 END)
      comment: "Number of facilities requiring post-closure environmental monitoring — measures long-term environmental liability obligations in the facility portfolio."
    - name: "non_compliant_facilities"
      expr: COUNT(CASE WHEN regulatory_status IN ('Significant Non-Complier', 'Under Enforcement', 'Non-Compliant') THEN 1 END)
      comment: "Number of facilities currently in a non-compliant regulatory status — critical enterprise risk indicator for regulatory enforcement exposure."
$$;