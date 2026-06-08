-- Metric views for domain: foodsafety | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food safety audit outcomes, compliance scores, and pass/fail rates across restaurant units and facilities. Enables leadership to monitor audit quality, identify systemic compliance gaps, and prioritize corrective interventions."
  source: "`restaurants_ecm`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit conducted (e.g., routine, surprise, regulatory), enabling segmentation of compliance performance by audit category."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail outcome of the audit, used to track failure rates across units and time periods."
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current lifecycle status of the audit (e.g., open, closed, pending review), supporting pipeline and backlog analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the audit, enabling tracking of remediation progress."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority that mandated or will review the audit, supporting compliance reporting by governing body."
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Boolean flag indicating whether allergen control requirements were met during the audit."
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Boolean flag indicating whether temperature monitoring requirements were met during the audit."
    - name: "sanitation_schedule_compliant"
      expr: sanitation_schedule_compliant
      comment: "Boolean flag indicating whether the sanitation schedule was followed during the audit period."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Calendar month of the audit, enabling trend analysis of compliance scores and failure rates over time."
    - name: "haccp_plan_version"
      expr: haccp_plan_version
      comment: "Version of the HACCP plan in effect at the time of the audit, supporting version-level compliance comparison."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted. Baseline volume metric for audit program coverage and cadence."
    - name: "total_failed_audits"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of audits that resulted in a fail outcome. Directly signals compliance risk exposure across the restaurant portfolio."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits. A key executive KPI for tracking overall food safety program health."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score, which may incorporate additional criteria beyond compliance. Used for holistic audit performance benchmarking."
    - name: "min_compliance_score"
      expr: MIN(CAST(compliance_score AS DOUBLE))
      comment: "Lowest compliance score recorded in the period. Identifies worst-performing units or audit events requiring urgent intervention."
    - name: "audits_with_open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of audits with unresolved corrective actions. Tracks remediation backlog and operational risk exposure."
    - name: "allergen_non_compliance_count"
      expr: COUNT(CASE WHEN allergen_control_compliant = False THEN 1 END)
      comment: "Number of audits where allergen control was non-compliant. Critical food safety risk metric with direct liability implications."
    - name: "temperature_non_compliance_count"
      expr: COUNT(CASE WHEN temperature_monitoring_compliant = False THEN 1 END)
      comment: "Number of audits where temperature monitoring was non-compliant. Directly linked to food safety hazard risk and regulatory exposure."
    - name: "distinct_restaurant_units_audited"
      expr: COUNT(DISTINCT primary_food_restaurant_unit_id)
      comment: "Number of distinct restaurant units that received a food safety audit. Measures audit program coverage across the estate."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides granular insight into individual audit findings, their severity, resolution status, and financial impact. Enables risk prioritization and corrective action governance across the restaurant network."
  source: "`restaurants_ecm`.`foodsafety`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., temperature control, sanitation, labeling), enabling root-cause trend analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, major, minor), used to prioritize remediation and escalation."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current resolution status of the finding (e.g., open, in-progress, closed), supporting backlog and SLA tracking."
    - name: "regulatory_reference"
      expr: regulatory_reference
      comment: "Regulatory code or standard referenced by the finding, enabling compliance reporting by regulatory framework."
    - name: "has_attachment"
      expr: has_attachment
      comment: "Indicates whether supporting evidence was attached to the finding, relevant for audit quality and defensibility."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_timestamp)
      comment: "Calendar month the finding was recorded, enabling trend analysis of finding volumes and severity over time."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the corrective action is due, supporting SLA and deadline management reporting."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded. Baseline measure for audit finding volume and program intensity."
    - name: "critical_findings_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Number of findings classified as critical severity. A primary executive risk indicator requiring immediate escalation and action."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of findings not yet resolved. Tracks remediation backlog and operational risk exposure."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average numeric severity score across all findings. Enables trend analysis of finding severity intensity over time and across units."
    - name: "total_severity_score"
      expr: SUM(CAST(severity_score AS DOUBLE))
      comment: "Cumulative severity score across all findings in the period. A composite risk exposure index used for portfolio-level risk ranking."
    - name: "findings_with_overdue_resolution"
      expr: COUNT(CASE WHEN resolution_date IS NULL AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of findings past their due date without a recorded resolution. Directly measures SLA breach risk and regulatory exposure."
    - name: "distinct_facilities_with_findings"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with at least one audit finding. Measures breadth of compliance issues across the real estate portfolio."
    - name: "distinct_restaurant_units_with_findings"
      expr: COUNT(DISTINCT primary_audit_restaurant_unit_id)
      comment: "Number of distinct restaurant units with audit findings. Supports geographic and operational unit-level risk segmentation."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the effectiveness, cost, and timeliness of corrective actions taken in response to food safety findings and violations. Enables leadership to assess remediation program performance and financial investment in compliance."
  source: "`restaurants_ecm`.`foodsafety`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action taken (e.g., retraining, equipment repair, process change), enabling analysis of remediation strategy effectiveness."
    - name: "foodsafety_corrective_action_status"
      expr: foodsafety_corrective_action_status
      comment: "Current status of the corrective action (e.g., open, in-progress, verified, closed), supporting pipeline and SLA tracking."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure classification of the corrective action, distinguishing formally closed actions from those still pending verification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the underlying issue that triggered the corrective action, enabling cost and effort analysis by risk tier."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the corrective action, supporting triage and resource allocation decisions."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category identified for the corrective action, enabling systemic issue analysis and prevention investment."
    - name: "ccp_deviation"
      expr: ccp_deviation
      comment: "Boolean flag indicating whether the corrective action was triggered by a Critical Control Point deviation, a high-risk HACCP event."
    - name: "temperature_exceedance"
      expr: temperature_exceedance
      comment: "Boolean flag indicating whether a temperature exceedance triggered the corrective action, a key food safety hazard indicator."
    - name: "is_effective"
      expr: is_effective
      comment: "Boolean flag indicating whether the corrective action was verified as effective, supporting quality-of-remediation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the action cost is denominated, required for multi-currency financial aggregation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the corrective action became effective, enabling trend analysis of remediation activity over time."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions recorded. Baseline measure for remediation program volume and activity."
    - name: "total_action_cost"
      expr: SUM(CAST(action_cost AS DOUBLE))
      comment: "Total financial cost of all corrective actions. A direct measure of the monetary investment required to remediate food safety non-compliance."
    - name: "avg_action_cost"
      expr: AVG(CAST(action_cost AS DOUBLE))
      comment: "Average cost per corrective action. Enables benchmarking of remediation efficiency and identification of high-cost action types."
    - name: "ccp_deviation_actions_count"
      expr: COUNT(CASE WHEN ccp_deviation = True THEN 1 END)
      comment: "Number of corrective actions triggered by Critical Control Point deviations. A critical HACCP compliance KPI with direct regulatory implications."
    - name: "temperature_exceedance_actions_count"
      expr: COUNT(CASE WHEN temperature_exceedance = True THEN 1 END)
      comment: "Number of corrective actions triggered by temperature exceedances. Tracks the most common and high-risk food safety hazard category."
    - name: "effective_actions_count"
      expr: COUNT(CASE WHEN is_effective = True THEN 1 END)
      comment: "Number of corrective actions verified as effective. Measures the quality and success rate of the remediation program."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN actual_completion_date IS NULL AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of corrective actions past their target completion date without recorded completion. Measures SLA breach risk and regulatory exposure."
    - name: "total_ccp_deviation_action_cost"
      expr: SUM(CASE WHEN ccp_deviation = True THEN CAST(action_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of corrective actions specifically triggered by CCP deviations. Quantifies the financial burden of HACCP non-conformance."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks health inspection outcomes, regulatory grades, fees, and closure orders across restaurant units. Provides executives with a real-time view of regulatory compliance standing and financial exposure from inspections."
  source: "`restaurants_ecm`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (e.g., routine, complaint-driven, follow-up), enabling analysis of compliance performance by inspection trigger."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail outcome of the health inspection, the primary regulatory compliance indicator."
    - name: "overall_grade"
      expr: overall_grade
      comment: "Letter or numeric grade assigned by the health authority, used for public-facing compliance reporting and brand risk assessment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned by the inspecting agency, enabling prioritization of follow-up and remediation resources."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., open, closed, appealed), supporting pipeline management."
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the health authority conducting the inspection, enabling compliance analysis by regulatory jurisdiction."
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Boolean flag indicating whether a closure order was issued, the most severe regulatory outcome with direct revenue impact."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether corrective action was mandated by the inspection outcome."
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Boolean flag indicating whether a follow-up inspection was required, signaling unresolved compliance issues."
    - name: "permit_status"
      expr: permit_status
      comment: "Current operating permit status following the inspection, directly linked to the unit's legal right to operate."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Calendar month of the inspection, enabling trend analysis of inspection outcomes and regulatory risk over time."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections recorded. Baseline measure for regulatory inspection volume and coverage."
    - name: "failed_inspections_count"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of health inspections resulting in a fail. Primary regulatory compliance risk KPI for executive and board reporting."
    - name: "closure_orders_issued"
      expr: COUNT(CASE WHEN closure_order_flag = True THEN 1 END)
      comment: "Number of closure orders issued across all inspections. The most severe regulatory outcome, with direct revenue and brand impact."
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total fees paid for health inspections. Quantifies the direct financial cost of regulatory compliance activity."
    - name: "avg_inspection_fee"
      expr: AVG(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Average inspection fee per inspection event. Supports budgeting and cost benchmarking for regulatory compliance."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = True THEN 1 END)
      comment: "Number of inspections that mandated corrective action. Measures the volume of compliance deficiencies requiring remediation investment."
    - name: "follow_up_inspections_required_count"
      expr: COUNT(CASE WHEN follow_up_inspection_required = True THEN 1 END)
      comment: "Number of inspections that triggered a mandatory follow-up. Indicates persistent non-compliance and elevated regulatory scrutiny."
    - name: "distinct_units_inspected"
      expr: COUNT(DISTINCT primary_health_restaurant_unit_id)
      comment: "Number of distinct restaurant units that received a health inspection. Measures regulatory inspection coverage across the estate."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides detailed analysis of health inspection violations, their severity, financial penalties, and resolution status. Enables risk-based prioritization of compliance remediation and regulatory penalty management."
  source: "`restaurants_ecm`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g., temperature, sanitation, labeling), enabling root-cause trend analysis across the restaurant network."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the violation, used to prioritize remediation resources and escalation decisions."
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current resolution status of the violation (e.g., open, resolved, appealed), supporting backlog and SLA management."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action associated with the violation, tracking remediation progress."
    - name: "area_of_concern"
      expr: area_of_concern
      comment: "Physical or operational area where the violation was identified (e.g., kitchen, storage, front-of-house), enabling location-based risk analysis."
    - name: "regulatory_citation"
      expr: regulatory_citation
      comment: "Specific regulatory code or standard cited in the violation, supporting compliance reporting by regulatory framework."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty amount, required for multi-currency financial aggregation."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Calendar month the violation was recorded, enabling trend analysis of violation volumes and penalty exposure over time."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of inspection violations recorded. Baseline measure for regulatory non-compliance volume."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed across all violations. A direct measure of regulatory financial exposure and compliance program effectiveness."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Enables benchmarking of penalty severity and identification of high-cost violation types."
    - name: "open_violations_count"
      expr: COUNT(CASE WHEN inspection_violation_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of violations not yet resolved. Tracks active regulatory risk exposure and remediation backlog."
    - name: "violations_with_penalty"
      expr: COUNT(CASE WHEN penalty_amount > 0 THEN 1 END)
      comment: "Number of violations that resulted in a financial penalty. Measures the proportion of violations with direct monetary consequences."
    - name: "distinct_facilities_with_violations"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with recorded violations. Measures the breadth of regulatory non-compliance across the real estate portfolio."
    - name: "distinct_units_with_violations"
      expr: COUNT(DISTINCT primary_inspection_restaurant_unit_id)
      comment: "Number of distinct restaurant units with violations. Supports unit-level risk ranking and targeted compliance intervention."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors temperature readings across critical control points and equipment assets, tracking deviations, compliance status, and calibration health. Temperature control is the single most important food safety operational KPI in foodservice."
  source: "`restaurants_ecm`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (e.g., ambient, product, equipment), enabling analysis of compliance by monitoring context."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance classification of the temperature reading (e.g., compliant, non-compliant, critical deviation), the primary temperature safety KPI dimension."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Boolean flag indicating whether the reading exceeded critical limits, directly signaling a food safety hazard event."
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend direction of temperature readings (e.g., rising, stable, falling), enabling predictive maintenance and early hazard detection."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of temperature measurement (e.g., Celsius, Fahrenheit), required for correct aggregation and display."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to capture the temperature reading (e.g., manual probe, automated sensor), enabling data quality and reliability analysis."
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Boolean flag indicating whether the monitoring equipment requires maintenance, supporting preventive maintenance scheduling."
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Status of the temperature log record, supporting data completeness and audit trail analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Calendar month of the temperature reading, enabling trend analysis of deviation rates and compliance over time."
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings recorded. Baseline measure for monitoring program coverage and frequency."
    - name: "deviation_readings_count"
      expr: COUNT(CASE WHEN deviation_flag = True THEN 1 END)
      comment: "Number of temperature readings that exceeded critical limits. The primary food safety temperature hazard KPI, directly linked to pathogen risk."
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature value across all readings. Enables baseline temperature profiling and detection of systemic drift from safe ranges."
    - name: "max_temperature_value"
      expr: MAX(CAST(temperature_value AS DOUBLE))
      comment: "Maximum temperature recorded in the period. Identifies worst-case temperature exceedances for risk assessment and incident investigation."
    - name: "min_temperature_value"
      expr: MIN(CAST(temperature_value AS DOUBLE))
      comment: "Minimum temperature recorded in the period. Identifies cold-chain failures and freezing risks for product safety."
    - name: "avg_critical_limit_high"
      expr: AVG(CAST(critical_limit_high AS DOUBLE))
      comment: "Average upper critical limit configured across monitored control points. Supports calibration and limit-setting governance reviews."
    - name: "equipment_requiring_maintenance_count"
      expr: COUNT(CASE WHEN maintenance_required = True THEN 1 END)
      comment: "Number of temperature log records flagged for equipment maintenance. Drives preventive maintenance prioritization to avoid monitoring gaps."
    - name: "distinct_ccps_monitored"
      expr: COUNT(DISTINCT critical_control_point_id)
      comment: "Number of distinct Critical Control Points with temperature readings. Measures HACCP monitoring coverage across the operation."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides governance metrics over HACCP Critical Control Points, including deviation rates, limit configurations, and monitoring coverage. Enables food safety leadership to assess HACCP program integrity and identify systemic control failures."
  source: "`restaurants_ecm`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current operational status of the CCP (e.g., active, suspended, retired), supporting program coverage analysis."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of food safety hazard controlled by the CCP (e.g., biological, chemical, physical), enabling risk-based analysis by hazard category."
    - name: "process_step"
      expr: process_step
      comment: "Production or service process step where the CCP is applied (e.g., cooking, cooling, receiving), enabling process-level compliance analysis."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency at which the CCP is monitored (e.g., hourly, per batch), supporting monitoring adequacy assessments."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating whether the control point is classified as critical under the HACCP plan."
    - name: "haccp_plan_version"
      expr: haccp_plan_version
      comment: "Version of the HACCP plan under which the CCP is defined, enabling version-level compliance comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the CCP monitoring parameter (e.g., °C, pH, minutes), required for correct limit interpretation."
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "Frequency of CCP verification activities, supporting HACCP plan adequacy and regulatory compliance assessments."
  measures:
    - name: "total_critical_control_points"
      expr: COUNT(1)
      comment: "Total number of Critical Control Points defined across all HACCP plans. Baseline measure for HACCP program scope and coverage."
    - name: "active_ccps_count"
      expr: COUNT(CASE WHEN critical_control_point_status = 'Active' THEN 1 END)
      comment: "Number of currently active Critical Control Points. Measures the operational scope of the HACCP monitoring program."
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across all CCPs. A composite indicator of how far CCP readings typically stray from critical limits, signaling systemic control weakness."
    - name: "total_deviation_value"
      expr: SUM(CAST(average_deviation_value AS DOUBLE))
      comment: "Sum of average deviation values across all CCPs. Provides a portfolio-level risk index for HACCP control performance."
    - name: "avg_critical_limit_max"
      expr: AVG(CAST(critical_limit_max AS DOUBLE))
      comment: "Average upper critical limit across all CCPs. Supports governance reviews of limit-setting consistency and regulatory alignment."
    - name: "avg_critical_limit_min"
      expr: AVG(CAST(critical_limit_min AS DOUBLE))
      comment: "Average lower critical limit across all CCPs. Supports governance reviews of limit-setting consistency and regulatory alignment."
    - name: "distinct_facilities_with_ccps"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with defined Critical Control Points. Measures HACCP program deployment coverage across the real estate portfolio."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks foodborne illness reports linked to restaurant units, including investigation status, health department notifications, and root causes. A critical brand protection and regulatory compliance KPI domain with direct liability implications."
  source: "`restaurants_ecm`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report (e.g., open, under investigation, closed), supporting case management and regulatory reporting."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the illness report, enabling tracking of open investigations and time-to-resolution."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the illness (e.g., mild, moderate, severe), used to prioritize response and escalation."
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Pathogen suspected as the cause of illness (e.g., Salmonella, E. coli, Norovirus), enabling epidemiological trend analysis."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause identified for the illness (e.g., temperature abuse, cross-contamination), enabling systemic prevention investment."
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Boolean flag indicating whether the health department was notified, a mandatory regulatory compliance indicator."
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Boolean flag indicating whether the affected employee was excluded from work, a critical food safety protocol compliance indicator."
    - name: "report_method"
      expr: report_method
      comment: "Method by which the illness was reported (e.g., guest complaint, employee self-report, health department), enabling source analysis."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Calendar month of illness onset, enabling trend analysis of illness incidence over time and seasonal pattern detection."
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of foodborne illness reports recorded. The primary food safety brand risk and liability KPI for executive reporting."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of illness reports with open investigations. Tracks active liability exposure and regulatory scrutiny."
    - name: "health_dept_notified_count"
      expr: COUNT(CASE WHEN health_department_notified = True THEN 1 END)
      comment: "Number of illness reports where the health department was notified. Measures regulatory notification compliance, a mandatory legal obligation."
    - name: "health_dept_not_notified_count"
      expr: COUNT(CASE WHEN health_department_notified = False THEN 1 END)
      comment: "Number of illness reports where the health department was NOT notified. Identifies potential regulatory notification compliance failures with legal risk."
    - name: "employee_exclusion_count"
      expr: COUNT(CASE WHEN exclusion_decision = True THEN 1 END)
      comment: "Number of illness reports resulting in employee exclusion from work. Measures adherence to food safety exclusion protocols."
    - name: "distinct_units_with_illness_reports"
      expr: COUNT(DISTINCT primary_illness_restaurant_unit_id)
      comment: "Number of distinct restaurant units with illness reports. Identifies high-risk units requiring targeted food safety intervention."
    - name: "reports_with_action_plan_completed"
      expr: COUNT(CASE WHEN action_plan_completed_date IS NOT NULL THEN 1 END)
      comment: "Number of illness reports where the action plan was completed. Measures the effectiveness and closure rate of the illness response program."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_food_safety_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food safety certifications across employees and facilities, including expiration status, renewal compliance, and certification coverage. Ensures the organization maintains required regulatory certifications and avoids lapses that could trigger regulatory action."
  source: "`restaurants_ecm`.`foodsafety`.`food_safety_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of food safety certification (e.g., ServSafe, HACCP, allergen awareness), enabling coverage analysis by certification category."
    - name: "certification_category"
      expr: certification_category
      comment: "Broader category grouping of certifications, supporting portfolio-level compliance reporting."
    - name: "food_safety_certification_status"
      expr: food_safety_certification_status
      comment: "Current status of the certification (e.g., active, expired, revoked, pending renewal), the primary certification compliance indicator."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification, enabling analysis of certification source and regulatory recognition."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the certification is currently in compliance, supporting rapid compliance status reporting."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Boolean flag indicating whether the certification requires renewal, supporting proactive renewal management."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Boolean flag indicating whether an expiration notice was sent, supporting notification process compliance."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Calendar month of certification expiration, enabling forward-looking renewal pipeline management."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Calendar month the certification was issued, enabling trend analysis of certification activity and onboarding compliance."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of food safety certifications on record. Baseline measure for certification program coverage."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN food_safety_certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications. Measures the organization's current certified workforce and facility coverage."
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN food_safety_certification_status = 'Expired' OR expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired certifications. A critical compliance risk KPI — expired certifications may trigger regulatory violations and operational shutdowns."
    - name: "certifications_expiring_within_30_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of certifications expiring within the next 30 days. Enables proactive renewal management to prevent compliance lapses."
    - name: "non_compliant_certifications_count"
      expr: COUNT(CASE WHEN compliance_flag = False THEN 1 END)
      comment: "Number of certifications flagged as non-compliant. Directly measures certification compliance gaps requiring immediate remediation."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required = True THEN 1 END)
      comment: "Number of certifications requiring renewal. Supports renewal workload planning and resource allocation."
    - name: "distinct_employees_certified"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees holding at least one food safety certification. Measures certified workforce coverage across the organization."
    - name: "distinct_facilities_with_certifications"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with at least one active certification on record. Measures facility-level certification coverage."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_sanitation_task_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures sanitation task execution, compliance rates, chemical usage, and environmental conditions across restaurant units and facilities. Sanitation program adherence is a foundational food safety operational KPI directly linked to inspection outcomes."
  source: "`restaurants_ecm`.`foodsafety`.`sanitation_task_log`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of sanitation task performed (e.g., surface cleaning, equipment sanitization, floor scrubbing), enabling analysis by sanitation activity category."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the sanitation task (e.g., completed, missed, in-progress), supporting compliance and adherence tracking."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the sanitation task verification, the primary sanitation compliance indicator."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating whether the sanitation task is classified as critical under the HACCP or sanitation plan."
    - name: "chemical_name"
      expr: chemical_name
      comment: "Name of the sanitizing chemical used, enabling analysis of chemical usage patterns and compliance with approved chemical protocols."
    - name: "location_area"
      expr: location_area
      comment: "Physical area of the restaurant where the sanitation task was performed (e.g., kitchen, prep area, restrooms), enabling location-based compliance analysis."
    - name: "compliance_regulation"
      expr: compliance_regulation
      comment: "Regulatory standard the sanitation task is designed to satisfy, supporting compliance reporting by regulatory framework."
    - name: "task_month"
      expr: DATE_TRUNC('MONTH', task_timestamp)
      comment: "Calendar month the sanitation task was performed, enabling trend analysis of sanitation compliance over time."
  measures:
    - name: "total_sanitation_tasks"
      expr: COUNT(1)
      comment: "Total number of sanitation tasks logged. Baseline measure for sanitation program activity and coverage."
    - name: "failed_sanitation_tasks_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of sanitation tasks that failed verification. Directly measures sanitation program non-compliance and food safety risk."
    - name: "critical_tasks_completed_count"
      expr: COUNT(CASE WHEN is_critical = True AND task_status = 'Completed' THEN 1 END)
      comment: "Number of critical sanitation tasks successfully completed. Measures adherence to the most important sanitation protocol requirements."
    - name: "avg_chemical_concentration"
      expr: AVG(CAST(chemical_concentration AS DOUBLE))
      comment: "Average chemical concentration used across sanitation tasks. Enables monitoring of sanitizer efficacy — too low risks pathogen survival, too high risks food contamination."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during sanitation tasks. Ensures sanitation processes are performed at effective temperatures per food safety standards."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity level recorded during sanitation tasks. High humidity can accelerate microbial growth; monitoring supports environmental control compliance."
    - name: "distinct_units_with_sanitation_tasks"
      expr: COUNT(DISTINCT primary_sanitation_restaurant_unit_id)
      comment: "Number of distinct restaurant units with sanitation task records. Measures sanitation program deployment coverage across the estate."
    - name: "missed_sanitation_tasks_count"
      expr: COUNT(CASE WHEN task_status = 'Missed' OR (scheduled_timestamp < CURRENT_TIMESTAMP() AND completion_timestamp IS NULL) THEN 1 END)
      comment: "Number of sanitation tasks that were missed or not completed on schedule. A leading indicator of sanitation compliance risk and potential inspection failures."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks HACCP plan governance, approval status, review cycles, and compliance standing across facilities. HACCP plan integrity is the regulatory foundation of food safety programs in foodservice and a primary audit target."
  source: "`restaurants_ecm`.`foodsafety`.`haccp_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HACCP plan (e.g., product-specific, process-based, facility-wide), enabling analysis of plan coverage by scope."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the HACCP plan (e.g., approved, pending, rejected), the primary governance compliance indicator."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the HACCP plan against regulatory requirements, used for regulatory reporting and audit preparation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the HACCP plan (e.g., draft, active, archived, superseded), supporting version governance and plan currency analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the HACCP plan, enabling risk-based prioritization of review and audit resources."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the HACCP plan is designed to satisfy (e.g., FDA, USDA, local health code), supporting compliance reporting by jurisdiction."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Boolean flag indicating whether the HACCP plan includes allergen control provisions, a critical food safety and labeling compliance requirement."
    - name: "temperature_monitoring_required_flag"
      expr: temperature_monitoring_required_flag
      comment: "Boolean flag indicating whether temperature monitoring is required under the plan, supporting monitoring program coverage analysis."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Boolean flag indicating whether staff training is required under the plan, supporting workforce compliance program management."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the HACCP plan became effective, enabling trend analysis of plan activation and version rollout over time."
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total number of HACCP plans on record. Baseline measure for HACCP program scope and governance coverage."
    - name: "approved_plans_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of HACCP plans with approved status. Measures the proportion of the food safety program operating under formally approved plans."
    - name: "plans_pending_approval_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected') THEN 1 END)
      comment: "Number of HACCP plans awaiting approval. Tracks governance backlog and identifies plans operating without formal sign-off."
    - name: "plans_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND lifecycle_status = 'Active' THEN 1 END)
      comment: "Number of active HACCP plans past their scheduled review date. A critical governance KPI — overdue reviews are a common regulatory audit finding."
    - name: "plans_with_allergen_control"
      expr: COUNT(CASE WHEN allergen_control_flag = True THEN 1 END)
      comment: "Number of HACCP plans that include allergen control provisions. Measures allergen management coverage across the food safety program."
    - name: "distinct_facilities_with_haccp_plans"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with at least one HACCP plan. Measures HACCP program deployment coverage across the real estate portfolio."
    - name: "plans_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_until BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of HACCP plans expiring within the next 90 days. Enables proactive plan renewal management to prevent compliance lapses."
$$;