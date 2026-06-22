-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPIs for food safety audits across restaurant units, tracking pass rates, compliance scores, and corrective action velocity."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit (e.g., internal, third-party, regulatory) for segmenting audit performance."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass/fail outcome of the audit, used to filter and group compliance results."
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current lifecycle status of the audit (e.g., open, closed, pending review)."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the audit, indicating remediation progress."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory or governing body that mandated or will receive the audit results."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Month the audit was conducted, for trend analysis over time."
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Whether allergen control procedures were found compliant during the audit."
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Whether temperature monitoring was found compliant during the audit."
    - name: "sanitation_schedule_compliant"
      expr: sanitation_schedule_compliant
      comment: "Whether the sanitation schedule was found compliant during the audit."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted; baseline volume metric for audit program coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits; primary KPI for overall food safety program health."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score; used alongside compliance score to assess holistic audit performance."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that passed; critical executive KPI for food safety compliance posture."
    - name: "audits_with_open_corrective_actions"
      expr: SUM(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 ELSE 0 END)
      comment: "Count of audits with unresolved corrective actions; drives urgency in remediation tracking."
    - name: "allergen_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_control_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where allergen controls were compliant; critical for guest safety and regulatory risk."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_monitoring_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where temperature monitoring was compliant; key HACCP indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory health inspections across restaurant units, tracking scores, violation rates, closure orders, and follow-up compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (e.g., routine, follow-up, complaint-driven)."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail outcome of the health inspection."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., open, closed, appealed)."
    - name: "overall_grade"
      expr: overall_grade
      comment: "Letter or numeric grade assigned by the health authority."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned by the inspector (e.g., high, medium, low)."
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the health agency conducting the inspection."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for trend analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required as a result of the inspection."
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Whether a closure order was issued during this inspection."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections; baseline for regulatory engagement volume."
    - name: "avg_inspection_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average health inspection score across all inspections; primary regulatory compliance KPI."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of health inspections passed; executive-level regulatory compliance indicator."
    - name: "closure_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_order_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a closure order; highest-severity regulatory risk metric."
    - name: "inspections_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections that triggered corrective action requirements; drives remediation workload planning."
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total regulatory inspection fees paid; informs compliance cost budgeting."
    - name: "follow_up_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_inspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a follow-up visit; indicates systemic compliance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed KPIs for health inspection violations, tracking severity distribution, penalty exposure, and resolution rates."
  source: "`vibe_restaurants_v1`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g., temperature, sanitation, labeling)."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation (e.g., critical, major, minor)."
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current resolution status of the violation."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken in response to the violation."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Month the violation was recorded, for trend analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was mandated for this violation."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of inspection violations recorded; baseline for regulatory risk exposure."
    - name: "critical_violations_count"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical-severity violations; highest-priority metric for food safety risk management."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed from violations; direct cost of non-compliance."
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation; benchmarks cost of individual compliance failures."
    - name: "open_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_violation_status NOT IN ('Closed', 'Resolved') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations still open/unresolved; key indicator of remediation velocity."
    - name: "violations_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations mandating corrective action; drives compliance workload and risk prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for temperature monitoring compliance, tracking deviation rates, critical limit breaches, and data quality across equipment and locations."
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (e.g., refrigerator, hot-hold, receiving) for segmenting compliance by process."
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Status of the temperature log record (e.g., normal, deviation, corrected)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of temperature measurement (Celsius or Fahrenheit)."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether this reading represents a temperature deviation from acceptable limits."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Whether the reading passed data quality checks; used to filter unreliable sensor data."
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Whether the equipment requires maintenance based on this reading."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the temperature reading for trend analysis."
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Directional trend of temperature readings (e.g., rising, stable, falling)."
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total temperature readings recorded; baseline for monitoring program coverage."
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature reading across all logs; used to detect systemic drift from safe ranges."
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings with a temperature deviation; primary HACCP compliance KPI."
    - name: "critical_high_breach_count"
      expr: SUM(CASE WHEN temperature_value > critical_limit_high THEN 1 ELSE 0 END)
      comment: "Count of readings exceeding the critical high limit; direct food safety risk indicator requiring immediate action."
    - name: "critical_low_breach_count"
      expr: SUM(CASE WHEN temperature_value < critical_limit_low THEN 1 ELSE 0 END)
      comment: "Count of readings below the critical low limit; indicates cold-chain failures."
    - name: "data_quality_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_quality_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings passing data quality checks; ensures monitoring data reliability."
    - name: "equipment_maintenance_alerts"
      expr: SUM(CASE WHEN maintenance_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readings triggering equipment maintenance alerts; drives preventive maintenance scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for allergen incident management, tracking incident volume, severity, resolution speed, and regulatory notification compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "allergen_name"
      expr: allergen_name
      comment: "Name of the allergen involved in the incident (e.g., peanut, gluten, shellfish)."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of allergen incident (e.g., cross-contact, mislabeling, undisclosed ingredient)."
    - name: "allergen_incident_status"
      expr: allergen_incident_status
      comment: "Current status of the incident investigation and resolution."
    - name: "severity_level_bucket"
      expr: CASE WHEN severity_score >= 8 THEN 'High' WHEN severity_score >= 4 THEN 'Medium' ELSE 'Low' END
      comment: "Bucketed severity level derived from numeric severity score for executive reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the incident was handled in compliance with regulatory requirements."
    - name: "fda_medwatch_filed"
      expr: fda_medwatch_filed
      comment: "Whether an FDA MedWatch report was filed for this incident."
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Whether this is a repeat allergen incident, indicating systemic control failure."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month the incident occurred for trend analysis."
    - name: "investigation_complete"
      expr: investigation_complete
      comment: "Whether the investigation has been completed."
  measures:
    - name: "total_allergen_incidents"
      expr: COUNT(1)
      comment: "Total allergen incidents recorded; baseline for allergen risk exposure across the enterprise."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of allergen incidents; executive KPI for allergen risk level."
    - name: "repeat_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_incident = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeat occurrences; indicates systemic allergen control failures."
    - name: "fda_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fda_medwatch_filed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in FDA MedWatch filings; regulatory compliance and severity indicator."
    - name: "open_investigation_count"
      expr: SUM(CASE WHEN investigation_complete = FALSE THEN 1 ELSE 0 END)
      comment: "Count of incidents with incomplete investigations; drives investigation workload and risk exposure."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents handled in full regulatory compliance; key risk management KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food safety corrective actions, tracking resolution rates, cost of remediation, CCP deviations, and action effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g., retraining, equipment repair, process change)."
    - name: "foodsafety_corrective_action_status"
      expr: foodsafety_corrective_action_status
      comment: "Current status of the corrective action (e.g., open, in-progress, closed)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the issue that triggered the corrective action."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the corrective action for scheduling and resource allocation."
    - name: "closure_status"
      expr: closure_status
      comment: "Whether the corrective action has been formally closed."
    - name: "ccp_deviation"
      expr: ccp_deviation
      comment: "Whether the corrective action was triggered by a Critical Control Point deviation."
    - name: "temperature_exceedance"
      expr: temperature_exceedance
      comment: "Whether the corrective action was triggered by a temperature exceedance event."
    - name: "is_effective"
      expr: is_effective
      comment: "Whether the corrective action was verified as effective after implementation."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the corrective action event occurred for trend analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions initiated; baseline for food safety remediation program volume."
    - name: "total_action_cost"
      expr: SUM(CAST(action_cost AS DOUBLE))
      comment: "Total cost of all corrective actions; direct financial impact of food safety non-compliance."
    - name: "avg_action_cost"
      expr: AVG(CAST(action_cost AS DOUBLE))
      comment: "Average cost per corrective action; benchmarks remediation efficiency."
    - name: "open_corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN foodsafety_corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions still open; key indicator of remediation velocity and backlog risk."
    - name: "ccp_deviation_action_count"
      expr: SUM(CASE WHEN ccp_deviation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrective actions triggered by CCP deviations; highest-priority HACCP compliance metric."
    - name: "effectiveness_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_effective = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions verified as effective; measures quality of remediation outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HACCP plan governance, tracking plan coverage, compliance status, review currency, and training completion."
  source: "`vibe_restaurants_v1`.`foodsafety`.`haccp_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HACCP plan (e.g., food production, receiving, storage)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the HACCP plan."
    - name: "approval_status"
      expr: approval_status
      comment: "Whether the HACCP plan has been formally approved."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the plan (e.g., draft, active, retired)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the process covered by this HACCP plan."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the plan is designed to comply with (e.g., FDA FSMA, USDA HACCP)."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Whether the plan includes allergen control procedures."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether staff training is required as part of this HACCP plan."
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total HACCP plans in the system; baseline for food safety program coverage."
    - name: "compliant_plan_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans in compliant status; primary governance KPI for food safety leadership."
    - name: "approved_plan_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans formally approved; indicates governance rigor."
    - name: "plans_overdue_review"
      expr: SUM(CASE WHEN next_review_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of HACCP plans past their scheduled review date; drives compliance risk escalation."
    - name: "plans_with_allergen_controls"
      expr: SUM(CASE WHEN allergen_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HACCP plans that include allergen control procedures; measures allergen risk coverage."
    - name: "plans_requiring_training"
      expr: SUM(CASE WHEN training_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HACCP plans requiring staff training; drives training program planning and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Critical Control Points (CCPs) within HACCP plans, tracking monitoring compliance, deviation frequency, and verification currency."
  source: "`vibe_restaurants_v1`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled by this CCP (e.g., biological, chemical, physical)."
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current operational status of the CCP."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "How frequently this CCP is monitored (e.g., continuous, hourly, daily)."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether this control point is classified as critical (CCP vs. prerequisite program)."
    - name: "process_step"
      expr: process_step
      comment: "The process step in the food production flow where this CCP applies."
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "Frequency at which CCP monitoring is independently verified."
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total Critical Control Points defined across all HACCP plans; baseline for CCP program scope."
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across all CCPs; indicates systemic drift from critical limits."
    - name: "avg_critical_limit_range"
      expr: AVG(CAST(critical_limit_max AS DOUBLE) - CAST(critical_limit_min AS DOUBLE))
      comment: "Average range between critical high and low limits; measures tolerance band width across CCPs."
    - name: "ccps_overdue_verification"
      expr: SUM(CASE WHEN last_verification_timestamp < DATE_SUB(CURRENT_TIMESTAMP(), 30) THEN 1 ELSE 0 END)
      comment: "Count of CCPs not verified in the last 30 days; drives verification compliance escalation."
    - name: "active_ccp_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_control_point_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCPs in active monitoring status; ensures full HACCP plan coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food recall events, tracking recall volume, severity distribution, scope, and resolution status."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_recall`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "FDA/USDA recall class (Class I, II, III) indicating severity of health risk."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., voluntary, mandatory, market withdrawal)."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g., active, closed, monitoring)."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency overseeing the recall (e.g., FDA, USDA, local health authority)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the recall event."
    - name: "is_voluntary"
      expr: is_voluntary
      comment: "Whether the recall was initiated voluntarily by the company."
    - name: "recall_month"
      expr: DATE_TRUNC('MONTH', recall_initiation_timestamp)
      comment: "Month the recall was initiated for trend analysis."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total food recall events; baseline for supply chain food safety risk exposure."
    - name: "class_one_recall_count"
      expr: SUM(CASE WHEN recall_class = 'Class I' THEN 1 ELSE 0 END)
      comment: "Count of Class I recalls (highest health risk); most critical executive food safety metric."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across all recalls; tracks overall recall risk level over time."
    - name: "voluntary_recall_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_voluntary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls that were voluntary; higher rates indicate proactive food safety culture."
    - name: "open_recall_count"
      expr: SUM(CASE WHEN recall_status NOT IN ('Closed', 'Completed') THEN 1 ELSE 0 END)
      comment: "Count of currently active/open recalls; drives supply chain and operations response urgency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_recall_unit_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for restaurant unit responses to food recalls, tracking affected quantities, compliance rates, and disposition completeness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`recall_unit_response`"
  dimensions:
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity of the recall that triggered this unit response."
    - name: "recall_unit_response_status"
      expr: recall_unit_response_status
      comment: "Current status of the unit's recall response (e.g., pending, completed, verified)."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to dispose of recalled product (e.g., destroyed, returned, quarantined)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the unit's recall response met compliance requirements."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the recall response has been independently verified."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the recall response was recorded for trend analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the unit's response met all regulatory compliance requirements."
  measures:
    - name: "total_unit_responses"
      expr: COUNT(1)
      comment: "Total recall response records across all units; baseline for recall response program coverage."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by recalls across all units; measures supply chain recall scope."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unit recall responses meeting compliance requirements; key regulatory risk KPI."
    - name: "verified_response_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'Verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recall responses independently verified; ensures recall closure integrity."
    - name: "open_response_count"
      expr: SUM(CASE WHEN recall_unit_response_status NOT IN ('Completed', 'Closed') THEN 1 ELSE 0 END)
      comment: "Count of recall responses not yet completed; drives urgency in recall remediation tracking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for foodborne illness reports, tracking incident volume, severity, investigation completion, and health department notification compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen associated with the illness (e.g., Salmonella, E. coli, Norovirus)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the illness report."
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report (e.g., open, under investigation, closed)."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the illness report."
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Whether the health department was notified of this illness report."
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Whether the affected employee was excluded from work."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month the illness was reported for trend analysis."
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total illness reports filed; baseline for foodborne illness risk exposure."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of illness reports; tracks overall illness risk level."
    - name: "health_dept_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN health_department_notified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports where health department was notified; regulatory compliance KPI."
    - name: "employee_exclusion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusion_decision = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports resulting in employee exclusion from work; measures protective action compliance."
    - name: "open_investigation_count"
      expr: SUM(CASE WHEN investigation_status NOT IN ('Closed', 'Completed') THEN 1 ELSE 0 END)
      comment: "Count of illness reports with open investigations; drives investigation resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food safety training program completion, pass rates, and compliance across employees and restaurant units."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of food safety training (e.g., HACCP, allergen awareness, sanitation)."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (e.g., completed, in-progress, expired)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the employee passed or failed the training assessment."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the training was delivered (e.g., in-person, e-learning, on-the-job)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the training record meets compliance requirements."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month training was completed for trend analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total food safety training completions; baseline for training program coverage."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions; measures training effectiveness."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions with a passing assessment score; key training quality KPI."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records meeting compliance requirements; regulatory training compliance KPI."
    - name: "expired_certifications_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() AND training_status != 'Renewed' THEN 1 ELSE 0 END)
      comment: "Count of training certifications that have expired; drives renewal urgency and compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_receiving_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for incoming goods receiving inspections, tracking pass rates, temperature compliance, and rejection rates at the point of receipt."
  source: "`vibe_restaurants_v1`.`foodsafety`.`receiving_inspection`"
  dimensions:
    - name: "receiving_inspection_status"
      expr: receiving_inspection_status
      comment: "Current status of the receiving inspection record."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the received goods met compliance requirements."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required based on inspection findings."
    - name: "temperature_pass_flag"
      expr: temperature_pass_flag
      comment: "Whether the received goods passed temperature requirements at receipt."
    - name: "visual_quality_pass"
      expr: visual_quality_pass
      comment: "Whether the received goods passed visual quality inspection."
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier whose goods were inspected; for supplier quality benchmarking."
    - name: "receiving_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of receiving inspection for trend analysis."
  measures:
    - name: "total_receiving_inspections"
      expr: COUNT(1)
      comment: "Total receiving inspections conducted; baseline for inbound quality control program coverage."
    - name: "temperature_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries passing temperature requirements; critical cold-chain compliance KPI."
    - name: "visual_quality_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN visual_quality_pass = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries passing visual quality inspection; measures supplier product quality."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received across all inspections; measures inbound supply volume."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature of received goods in Celsius; monitors cold-chain integrity at receipt."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason IS NOT NULL AND rejection_reason != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries rejected at receiving; key supplier quality and food safety KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_sanitation_task_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for sanitation task execution, tracking completion rates, compliance, chemical usage, and task duration across restaurant units."
  source: "`vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of sanitation task (e.g., surface cleaning, equipment sanitization, floor cleaning)."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the sanitation task (e.g., completed, missed, in-progress)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the sanitation task passed quality verification."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether this is a critical sanitation task with direct food safety implications."
    - name: "location_area"
      expr: location_area
      comment: "Area of the restaurant where the sanitation task was performed."
    - name: "task_month"
      expr: DATE_TRUNC('MONTH', task_timestamp)
      comment: "Month the sanitation task was performed for trend analysis."
  measures:
    - name: "total_sanitation_tasks"
      expr: COUNT(1)
      comment: "Total sanitation tasks logged; baseline for sanitation program execution volume."
    - name: "task_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN task_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanitation tasks completed as scheduled; primary sanitation compliance KPI."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanitation tasks passing quality verification; measures sanitation execution quality."
    - name: "avg_task_duration_seconds"
      expr: AVG(CAST(task_duration_seconds AS DOUBLE))
      comment: "Average time to complete a sanitation task in seconds; benchmarks sanitation labor efficiency."
    - name: "critical_task_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical = TRUE AND task_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Completion rate for critical sanitation tasks only; highest-priority food safety execution KPI."
    - name: "avg_chemical_concentration"
      expr: AVG(CAST(chemical_concentration AS DOUBLE))
      comment: "Average chemical concentration used in sanitation tasks; monitors proper sanitizer usage compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for environmental monitoring program, tracking pathogen detection rates, pass rates, and threshold compliance across monitoring zones."
  source: "`vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring test (e.g., ATP, pathogen swab, air quality)."
    - name: "monitoring_zone"
      expr: monitoring_zone
      comment: "Zone of the facility where monitoring was conducted (e.g., food contact, non-food contact)."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., surface swab, air sample, water sample)."
    - name: "test_organism"
      expr: test_organism
      comment: "Target organism or pathogen being tested for in the environmental sample."
    - name: "is_pass"
      expr: is_pass
      comment: "Whether the environmental monitoring result passed acceptable limits."
    - name: "pathogen_detected"
      expr: pathogen_detected
      comment: "Whether a pathogen was detected in the environmental sample."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required based on the monitoring result."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_date)
      comment: "Month of environmental monitoring for trend analysis."
  measures:
    - name: "total_monitoring_samples"
      expr: COUNT(1)
      comment: "Total environmental monitoring samples collected; baseline for environmental monitoring program coverage."
    - name: "pathogen_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pathogen_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with pathogen detected; most critical environmental food safety KPI."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_pass = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental monitoring samples passing acceptable limits; overall program compliance KPI."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all environmental monitoring samples; tracks environmental contamination levels."
    - name: "samples_exceeding_threshold"
      expr: SUM(CASE WHEN measured_value > threshold_value THEN 1 ELSE 0 END)
      comment: "Count of samples exceeding defined threshold values; drives immediate corrective action prioritization."
    - name: "corrective_action_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring results triggering corrective action; measures environmental risk response rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_pest_control_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for pest control program effectiveness, tracking service compliance, pest identification rates, and severity across restaurant units."
  source: "`vibe_restaurants_v1`.`foodsafety`.`pest_control_log`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of pest control service (e.g., preventive, reactive, inspection)."
    - name: "service_status"
      expr: service_status
      comment: "Current status of the pest control service record."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of pest activity identified during the service."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the pest control service met compliance requirements."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Whether allergen control was addressed during the pest control service."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_timestamp)
      comment: "Month the pest control service was performed for trend analysis."
  measures:
    - name: "total_pest_control_services"
      expr: COUNT(1)
      comment: "Total pest control service visits logged; baseline for pest management program coverage."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of pest activity findings; tracks overall pest risk level across locations."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pest control services meeting compliance requirements; regulatory compliance KPI."
    - name: "services_with_pest_findings"
      expr: SUM(CASE WHEN pests_identified IS NOT NULL AND pests_identified != '' THEN 1 ELSE 0 END)
      comment: "Count of services where pests were identified; measures active infestation prevalence."
    - name: "pest_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pests_identified IS NOT NULL AND pests_identified != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pest control visits with active pest findings; key indicator of facility hygiene risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food safety certifications held by employees, tracking compliance rates, expiration risk, and renewal currency."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of food safety certification (e.g., ServSafe, HACCP, Food Handler)."
    - name: "certification_category"
      expr: certification_category
      comment: "Category of certification (e.g., manager, handler, allergen specialist)."
    - name: "food_safety_certification_status"
      expr: food_safety_certification_status
      comment: "Current status of the certification (e.g., active, expired, suspended)."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification (e.g., National Restaurant Association, local health authority)."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the certification meets current compliance requirements."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires renewal."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires for cohort analysis of renewal needs."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total food safety certifications on record; baseline for certification program coverage."
    - name: "active_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN food_safety_certification_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications currently active; primary workforce food safety compliance KPI."
    - name: "expired_certification_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of certifications that have expired; drives urgent renewal action to maintain compliance."
    - name: "expiring_within_30_days_count"
      expr: SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 ELSE 0 END)
      comment: "Count of certifications expiring within 30 days; enables proactive renewal management."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications meeting compliance requirements; regulatory workforce compliance KPI."
$$;