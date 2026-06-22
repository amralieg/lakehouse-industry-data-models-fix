-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for food safety audit performance, compliance scoring, and corrective action tracking across restaurant units. Enables leadership to monitor audit pass rates, compliance health, and outstanding corrective actions."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit (e.g., routine, surprise, regulatory) for segmenting audit outcomes by audit category."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail result of the audit, used to filter and group audits by outcome."
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current lifecycle status of the audit (e.g., open, closed, in-review) for pipeline and backlog analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the audit, enabling tracking of remediation progress."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority that mandated or will review the audit, for compliance reporting segmentation."
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Boolean flag indicating whether allergen control requirements were met during the audit."
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Boolean flag indicating whether temperature monitoring requirements were met during the audit."
    - name: "sanitation_schedule_compliant"
      expr: sanitation_schedule_compliant
      comment: "Boolean flag indicating whether the sanitation schedule was compliant during the audit."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Month in which the audit was conducted, for trend analysis over time."
    - name: "audit_year"
      expr: YEAR(audit_timestamp)
      comment: "Year in which the audit was conducted, for annual compliance reporting."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted. Baseline volume metric for audit program activity."
    - name: "passed_audits"
      expr: COUNT(CASE WHEN pass_fail = 'Pass' THEN 1 END)
      comment: "Number of audits that received a passing result. Used to compute pass rate and track compliance health."
    - name: "failed_audits"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of audits that received a failing result. Triggers investigation and corrective action workflows."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits. A declining trend signals systemic food safety risk requiring executive intervention."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score. Used in QBRs to benchmark restaurant unit performance against food safety standards."
    - name: "min_compliance_score"
      expr: MIN(CAST(compliance_score AS DOUBLE))
      comment: "Lowest compliance score recorded, identifying the worst-performing audit for targeted remediation."
    - name: "audits_with_open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of audits with unresolved corrective actions. High values indicate systemic non-compliance risk and drive resource allocation decisions."
    - name: "allergen_non_compliant_audits"
      expr: COUNT(CASE WHEN allergen_control_compliant = FALSE THEN 1 END)
      comment: "Number of audits where allergen control was non-compliant. Directly linked to guest safety risk and regulatory liability."
    - name: "temperature_non_compliant_audits"
      expr: COUNT(CASE WHEN temperature_monitoring_compliant = FALSE THEN 1 END)
      comment: "Number of audits where temperature monitoring was non-compliant. Indicates food safety hazard exposure requiring immediate operational response."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit findings severity, resolution velocity, and corrective action compliance. Enables risk prioritization and operational accountability tracking."
  source: "`vibe_restaurants_v1`.`foodsafety`.`audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, major, minor) for risk-tiered reporting."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., temperature, sanitation, labeling) for root-cause trend analysis."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (e.g., open, resolved, overdue) for backlog and resolution tracking."
    - name: "corrective_action"
      expr: corrective_action
      comment: "Corrective action prescribed for the finding, used to group findings by remediation type."
    - name: "regulatory_reference"
      expr: regulatory_reference
      comment: "Regulatory code or standard referenced by the finding, for compliance reporting to governing bodies."
    - name: "has_attachment"
      expr: has_attachment
      comment: "Whether supporting evidence is attached to the finding, indicating documentation completeness."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_timestamp)
      comment: "Month the finding was recorded, for trend analysis of finding volumes over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume metric for food safety risk exposure."
    - name: "critical_findings"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Number of critical-severity findings. Critical findings directly trigger executive escalation and regulatory notification workflows."
    - name: "open_findings"
      expr: COUNT(CASE WHEN audit_finding_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of findings not yet resolved. High open counts indicate unmitigated food safety risk across the estate."
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN audit_finding_status NOT IN ('Resolved', 'Closed') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of findings past their due date without resolution. Overdue findings represent regulatory and operational risk requiring immediate management action."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across all findings. A rising average signals deteriorating food safety standards and drives investment in corrective programs."
    - name: "total_severity_score"
      expr: SUM(CAST(severity_score AS DOUBLE))
      comment: "Aggregate severity score across all findings. Used to rank restaurant units by cumulative food safety risk exposure."
    - name: "findings_with_attachment"
      expr: COUNT(CASE WHEN has_attachment = TRUE THEN 1 END)
      comment: "Number of findings with supporting documentation attached. Measures evidence quality and audit rigor."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for external health inspection outcomes, scores, violation exposure, and regulatory compliance. Directly informs executive risk posture and regulatory relationship management."
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (e.g., routine, complaint-driven, follow-up) for segmenting outcomes by inspection trigger."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail result of the health inspection, the primary regulatory compliance indicator."
    - name: "overall_grade"
      expr: overall_grade
      comment: "Letter or numeric grade assigned by the inspecting agency, used for public-facing compliance reporting."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., completed, pending, appealed)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned by the inspecting agency, for prioritizing follow-up and remediation resources."
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the health agency conducting the inspection, for regulatory relationship tracking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action was mandated by the inspection outcome."
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Boolean flag indicating whether a closure order was issued, the most severe regulatory outcome."
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Boolean flag indicating whether a follow-up inspection was required, signaling unresolved compliance issues."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of the inspection for trend analysis of regulatory outcomes over time."
    - name: "permit_status"
      expr: permit_status
      comment: "Current operating permit status of the restaurant unit at time of inspection."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections. Baseline volume metric for regulatory activity."
    - name: "passed_inspections"
      expr: COUNT(CASE WHEN pass_fail = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing result. Core regulatory compliance KPI tracked at executive level."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of inspections with a failing result. Failures trigger mandatory corrective action and potential regulatory escalation."
    - name: "closure_orders_issued"
      expr: COUNT(CASE WHEN closure_order_flag = TRUE THEN 1 END)
      comment: "Number of closure orders issued across all inspections. The most severe regulatory outcome, directly impacting revenue and brand reputation."
    - name: "avg_inspection_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average health inspection score. Declining trend signals systemic food safety degradation requiring executive intervention."
    - name: "min_inspection_score"
      expr: MIN(CAST(score AS DOUBLE))
      comment: "Lowest inspection score recorded, identifying the highest-risk restaurant unit for targeted remediation."
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total fees paid for health inspections. Tracks regulatory cost burden and informs compliance investment decisions."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections that mandated corrective action. High values indicate systemic non-compliance requiring operational investment."
    - name: "inspections_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring a follow-up visit. Indicates unresolved issues and additional regulatory scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for health inspection violations including penalty exposure, severity distribution, and corrective action compliance. Enables risk quantification and regulatory liability management."
  source: "`vibe_restaurants_v1`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation (e.g., temperature, sanitation, labeling) for root-cause categorization and targeted remediation."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation for risk-tiered prioritization and executive reporting."
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current status of the violation record (e.g., open, resolved, appealed) for backlog management."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action was mandated for this violation."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action for this violation, tracking remediation progress."
    - name: "area_of_concern"
      expr: area_of_concern
      comment: "Physical area or operational domain where the violation was identified (e.g., kitchen, storage, front-of-house)."
    - name: "reinspection_outcome"
      expr: reinspection_outcome
      comment: "Outcome of the reinspection following the violation, indicating whether remediation was successful."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Month the violation was recorded, for trend analysis of violation frequency over time."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of inspection violations. Baseline metric for regulatory non-compliance exposure."
    - name: "open_violations"
      expr: COUNT(CASE WHEN inspection_violation_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of violations not yet resolved. Unresolved violations represent active regulatory risk and potential penalty exposure."
    - name: "overdue_violations"
      expr: COUNT(CASE WHEN inspection_violation_status NOT IN ('Resolved', 'Closed') AND compliance_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of violations past their compliance deadline. Overdue violations escalate regulatory risk and penalty severity."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all violations. Direct financial impact metric tracked at CFO and COO level."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Rising averages indicate escalating regulatory severity and drive compliance investment decisions."
    - name: "violations_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of violations mandating corrective action. Drives resource allocation for compliance remediation programs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for foodborne illness reports including severity, investigation status, health authority notifications, and employee exclusion decisions. Critical for guest safety risk management and regulatory compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the illness report (e.g., mild, moderate, severe) for risk-tiered escalation."
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report (e.g., open, under investigation, closed) for case management tracking."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the illness report, indicating whether root cause has been established."
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen associated with the illness, for epidemiological trend analysis and supplier risk management."
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the illness, for systemic corrective action and process improvement."
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Boolean flag indicating whether the health department was notified, a mandatory regulatory requirement for certain illness types."
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Boolean flag indicating whether the affected employee was excluded from food handling duties."
    - name: "report_method"
      expr: report_method
      comment: "Method by which the illness was reported (e.g., guest complaint, employee self-report, health authority) for intake channel analysis."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month the illness was reported, for trend analysis of foodborne illness incidence over time."
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of illness reports filed. Baseline metric for foodborne illness incidence and guest safety risk."
    - name: "open_illness_reports"
      expr: COUNT(CASE WHEN illness_report_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of illness reports not yet closed. Open cases represent active guest safety and regulatory risk."
    - name: "health_dept_notified_reports"
      expr: COUNT(CASE WHEN health_department_notified = TRUE THEN 1 END)
      comment: "Number of illness reports where the health department was notified. Tracks regulatory notification compliance and outbreak escalation frequency."
    - name: "employee_exclusion_cases"
      expr: COUNT(CASE WHEN exclusion_decision = TRUE THEN 1 END)
      comment: "Number of cases where an employee was excluded from food handling. Measures effectiveness of illness containment protocols."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of illness reports. Rising scores indicate worsening guest safety outcomes and drive executive escalation."
    - name: "total_severity_score"
      expr: SUM(CAST(severity_score AS DOUBLE))
      comment: "Aggregate severity score across all illness reports. Used to rank restaurant units by cumulative guest safety risk."
    - name: "reports_with_open_action_plans"
      expr: COUNT(CASE WHEN illness_report_status NOT IN ('Closed', 'Resolved') AND action_plan_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of illness reports with overdue action plans. Indicates failure to execute remediation commitments, escalating regulatory and reputational risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for temperature monitoring compliance, deviation frequency, and calibration status. Temperature control is a critical HACCP control point — deviations directly indicate food safety hazard exposure."
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the temperature reading (e.g., compliant, non-compliant, deviation) for regulatory reporting."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Boolean flag indicating whether the temperature reading was outside the critical limit range."
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (e.g., receiving, storage, cooking, cooling) for process-step analysis."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to capture the temperature reading (e.g., probe, sensor, manual) for data quality segmentation."
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Current status of the temperature log record for completeness and audit trail tracking."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating whether the temperature reading has a data quality concern, for filtering reliable readings."
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Boolean flag indicating whether the monitoring equipment requires maintenance, impacting data reliability."
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend direction of temperature readings (e.g., rising, stable, falling) for predictive food safety risk analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the temperature reading for trend analysis of compliance and deviation rates over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of temperature measurement (e.g., Celsius, Fahrenheit) for consistent reporting."
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings logged. Baseline metric for monitoring program activity and coverage."
    - name: "deviation_readings"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Number of temperature readings that exceeded critical limits. Each deviation represents a potential food safety hazard requiring immediate corrective action."
    - name: "compliant_readings"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of temperature readings within compliant range. Used to compute compliance rate and benchmark monitoring program effectiveness."
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature value across all readings. Enables trend analysis to detect gradual drift toward critical limits before deviations occur."
    - name: "max_temperature_value"
      expr: MAX(CAST(temperature_value AS DOUBLE))
      comment: "Maximum temperature recorded. Identifies worst-case temperature exceedances for risk assessment and equipment review."
    - name: "min_temperature_value"
      expr: MIN(CAST(temperature_value AS DOUBLE))
      comment: "Minimum temperature recorded. Identifies cold-chain failures and under-temperature events for food safety risk assessment."
    - name: "readings_requiring_maintenance"
      expr: COUNT(CASE WHEN maintenance_required = TRUE THEN 1 END)
      comment: "Number of readings from equipment flagged as requiring maintenance. Unreliable equipment undermines HACCP monitoring integrity."
    - name: "data_quality_flagged_readings"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Number of readings with data quality concerns. High counts indicate monitoring system reliability issues that compromise food safety assurance."
    - name: "distinct_ccp_monitored"
      expr: COUNT(DISTINCT critical_control_point_id)
      comment: "Number of distinct critical control points with temperature readings. Measures HACCP monitoring coverage across the operation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HACCP plan lifecycle management, compliance status, and audit readiness. HACCP plans are the foundational food safety governance documents — their currency and compliance status directly determine regulatory risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`haccp_plan`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the HACCP plan (e.g., compliant, non-compliant, under review)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the HACCP plan (e.g., approved, pending, rejected) for governance tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the HACCP plan (e.g., active, expired, draft) for currency and validity management."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status of the HACCP plan, indicating whether it has been recently audited and validated."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the HACCP plan for prioritizing review and resource allocation."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HACCP plan (e.g., full, simplified, product-specific) for segmenting governance coverage."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the HACCP plan is designed to comply with (e.g., FDA, USDA, local health code)."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Boolean flag indicating whether the HACCP plan includes allergen control provisions."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Boolean flag indicating whether staff training is required under this HACCP plan."
    - name: "document_status"
      expr: document_status
      comment: "Document management status of the HACCP plan (e.g., current, superseded, archived)."
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total number of HACCP plans in the system. Baseline metric for food safety governance coverage."
    - name: "active_compliant_plans"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' AND compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of HACCP plans that are both active and compliant. The primary governance health KPI — low values indicate systemic food safety program risk."
    - name: "expired_plans"
      expr: COUNT(CASE WHEN effective_until < CURRENT_DATE() AND lifecycle_status = 'Active' THEN 1 END)
      comment: "Number of HACCP plans that have passed their effective end date but remain active. Expired plans represent regulatory non-compliance and must be escalated immediately."
    - name: "plans_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of HACCP plans past their scheduled review date. Overdue reviews indicate governance process failures and regulatory risk."
    - name: "plans_overdue_for_audit"
      expr: COUNT(CASE WHEN audit_next_due < CURRENT_DATE() THEN 1 END)
      comment: "Number of HACCP plans past their next audit due date. Drives audit scheduling and resource allocation decisions."
    - name: "plans_pending_approval"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected') THEN 1 END)
      comment: "Number of HACCP plans awaiting approval. Pending approvals block operational readiness and must be tracked for governance SLA compliance."
    - name: "plans_requiring_training"
      expr: COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END)
      comment: "Number of HACCP plans that require associated staff training. Drives training program planning and workforce compliance investment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HACCP critical control point (CCP) performance, deviation frequency, and monitoring compliance. CCPs are the operational backbone of food safety — their status directly determines hazard control effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current operational status of the CCP (e.g., active, inactive, under review) for coverage analysis."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled by the CCP (e.g., biological, chemical, physical) for risk categorization."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating whether the control point is classified as critical under the HACCP plan."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency at which the CCP is monitored (e.g., continuous, hourly, daily) for compliance gap analysis."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to monitor the CCP (e.g., temperature probe, visual inspection) for process standardization analysis."
    - name: "process_step"
      expr: process_step
      comment: "Food production process step associated with the CCP (e.g., receiving, cooking, cooling) for operational risk mapping."
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "Frequency of CCP verification activities for governance compliance tracking."
    - name: "haccp_plan_version"
      expr: haccp_plan_version
      comment: "Version of the HACCP plan under which this CCP operates, for change management and audit trail purposes."
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total number of critical control points defined. Baseline metric for HACCP program scope and coverage."
    - name: "active_critical_ccps"
      expr: COUNT(CASE WHEN is_critical = TRUE AND critical_control_point_status = 'Active' THEN 1 END)
      comment: "Number of active critical control points. Ensures all critical hazard controls are operational — gaps represent immediate food safety risk."
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across all CCPs. Rising averages indicate systemic drift from critical limits, requiring process correction before violations occur."
    - name: "max_deviation_value"
      expr: MAX(CAST(average_deviation_value AS DOUBLE))
      comment: "Maximum average deviation recorded across CCPs. Identifies the highest-risk control point for targeted intervention."
    - name: "avg_critical_limit_range"
      expr: AVG(CAST(critical_limit_max AS DOUBLE) - CAST(critical_limit_min AS DOUBLE))
      comment: "Average range between critical limit maximum and minimum across CCPs. Narrow ranges indicate tighter process control requirements and higher monitoring precision needs."
    - name: "distinct_haccp_plans_covered"
      expr: COUNT(DISTINCT haccp_plan_id)
      comment: "Number of distinct HACCP plans with at least one CCP defined. Measures HACCP program completeness across the plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_sanitation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for sanitation schedule compliance, task completion, and chemical usage governance. Sanitation program effectiveness is a direct determinant of food safety audit outcomes and regulatory compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the sanitation schedule (e.g., compliant, non-compliant, overdue) for regulatory reporting."
    - name: "sanitation_schedule_status"
      expr: sanitation_schedule_status
      comment: "Current operational status of the sanitation schedule (e.g., active, suspended, completed)."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of the sanitation task (e.g., daily, weekly, monthly) for scheduling and compliance gap analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sanitation task for resource allocation and escalation decisions."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag indicating whether the sanitation task is mandatory under regulatory or HACCP requirements."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Boolean flag indicating whether the sanitation task is part of allergen control protocols."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Boolean flag indicating whether this sanitation task requires audit verification."
    - name: "area"
      expr: area
      comment: "Physical area covered by the sanitation schedule (e.g., kitchen, storage, dining) for location-based compliance analysis."
    - name: "cleaning_method"
      expr: cleaning_method
      comment: "Cleaning method specified in the sanitation schedule for process standardization and compliance verification."
  measures:
    - name: "total_sanitation_tasks"
      expr: COUNT(1)
      comment: "Total number of sanitation schedule tasks. Baseline metric for sanitation program scope."
    - name: "overdue_sanitation_tasks"
      expr: COUNT(CASE WHEN next_due_timestamp < CURRENT_TIMESTAMP() AND sanitation_schedule_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of sanitation tasks past their due date. Overdue mandatory tasks represent direct food safety and regulatory compliance risk."
    - name: "mandatory_overdue_tasks"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND next_due_timestamp < CURRENT_TIMESTAMP() AND sanitation_schedule_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of mandatory sanitation tasks that are overdue. Mandatory overdue tasks are the highest-priority compliance risk and require immediate management escalation."
    - name: "avg_chemical_concentration"
      expr: AVG(CAST(chemical_concentration AS DOUBLE))
      comment: "Average chemical concentration used in sanitation tasks. Deviations from approved concentrations indicate protocol non-compliance and potential food safety or safety hazards."
    - name: "avg_temperature_requirement"
      expr: AVG(CAST(temperature_requirement_celsius AS DOUBLE))
      comment: "Average temperature requirement across sanitation tasks. Used to benchmark sanitation protocol standards and verify equipment capability."
    - name: "allergen_control_tasks"
      expr: COUNT(CASE WHEN allergen_control_flag = TRUE THEN 1 END)
      comment: "Number of sanitation tasks specifically designated for allergen control. Tracks allergen management program scope and completeness."
$$;