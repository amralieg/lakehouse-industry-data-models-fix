-- Metric views for domain: compliance | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_ccr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Confidence Report (CCR) metrics tracking drinking water quality reporting compliance, contaminant exceedances, and public notification reach across service territories and facilities."
  source: "`water_utilities_ecm`.`compliance`.`ccr`"
  dimensions:
    - name: "report_year"
      expr: report_year
      comment: "Calendar year of the CCR report, used to track year-over-year compliance trends."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the CCR (e.g., Compliant, Non-Compliant, Pending), used to segment reports by regulatory standing."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the CCR to customers (e.g., mailed, electronic, website), used to analyze distribution channel effectiveness."
    - name: "publication_month"
      expr: DATE_TRUNC('month', publication_date)
      comment: "Month the CCR was published, used for temporal trend analysis of reporting timeliness."
    - name: "mcl_exceedance_flag"
      expr: mcl_exceedance_flag
      comment: "Indicates whether the CCR includes a Maximum Contaminant Level exceedance, used to filter high-risk reports."
    - name: "violation_included_flag"
      expr: violation_included_flag
      comment: "Indicates whether the CCR documents a regulatory violation, used to segment compliant vs. non-compliant reports."
    - name: "special_notice_required_flag"
      expr: special_notice_required_flag
      comment: "Indicates whether a special public notice was required for this CCR, used to track elevated-risk reporting obligations."
    - name: "language_accessibility_flag"
      expr: language_accessibility_flag
      comment: "Indicates whether the CCR was made available in multiple languages, used to assess equity and accessibility compliance."
  measures:
    - name: "total_ccr_reports"
      expr: COUNT(1)
      comment: "Total number of CCR reports issued. Baseline volume metric for tracking annual reporting obligations."
    - name: "mcl_exceedance_report_count"
      expr: COUNT(CASE WHEN mcl_exceedance_flag = TRUE THEN ccr_id END)
      comment: "Number of CCR reports that include an MCL exceedance. Directly signals drinking water quality failures requiring executive attention and regulatory response."
    - name: "violation_report_count"
      expr: COUNT(CASE WHEN violation_included_flag = TRUE THEN ccr_id END)
      comment: "Number of CCR reports documenting a regulatory violation. Key risk indicator for regulatory penalty exposure."
    - name: "mcl_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mcl_exceedance_flag = TRUE THEN ccr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCR reports with an MCL exceedance. Compound rate metric used by leadership to benchmark water quality compliance performance."
    - name: "avg_lead_90th_percentile_ppb"
      expr: AVG(CAST(lead_90th_percentile_ppb AS DOUBLE))
      comment: "Average 90th-percentile lead concentration (ppb) across all CCR reports. Critical public health KPI monitored against the EPA Lead and Copper Rule action level of 15 ppb."
    - name: "max_lead_90th_percentile_ppb"
      expr: MAX(CAST(lead_90th_percentile_ppb AS DOUBLE))
      comment: "Maximum 90th-percentile lead concentration (ppb) recorded across CCR reports. Identifies worst-case lead exposure scenarios requiring immediate intervention."
    - name: "avg_copper_90th_percentile_ppm"
      expr: AVG(CAST(copper_90th_percentile_ppm AS DOUBLE))
      comment: "Average 90th-percentile copper concentration (ppm) across CCR reports. Monitored against the EPA action level of 1.3 ppm under the Lead and Copper Rule."
    - name: "special_notice_required_count"
      expr: COUNT(CASE WHEN special_notice_required_flag = TRUE THEN ccr_id END)
      comment: "Number of CCR reports requiring a special public notice. Elevated-risk indicator used to track public health communication obligations."
    - name: "language_accessible_report_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN language_accessibility_flag = TRUE THEN ccr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCR reports made available in multiple languages. Equity and accessibility compliance metric tracked by regulators and community stakeholders."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_dmr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report (DMR) metrics tracking NPDES permit compliance, submission timeliness, noncompliance rates, and exceedance patterns for wastewater discharge reporting."
  source: "`water_utilities_ecm`.`compliance`.`dmr`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the DMR submission (e.g., Submitted, Accepted, Rejected, Pending), used to track submission pipeline health."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which DMRs are required (e.g., Monthly, Quarterly), used to segment compliance obligations by reporting cadence."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the DMR (e.g., eDMR, paper), used to track electronic reporting adoption."
    - name: "noncompliance_flag"
      expr: noncompliance_flag
      comment: "Indicates whether the DMR documents a noncompliance event, used to filter and segment non-compliant reporting periods."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Indicates whether the DMR was submitted after the regulatory due date, used to track submission timeliness compliance."
    - name: "resubmission_flag"
      expr: resubmission_flag
      comment: "Indicates whether this DMR is a resubmission of a previously rejected report, used to measure data quality and rework rates."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Start month of the DMR reporting period, used for temporal trend analysis of discharge compliance."
    - name: "monitoring_location_code"
      expr: monitoring_location_code
      comment: "Code identifying the monitoring location (outfall or sampling point), used to segment compliance by discharge point."
    - name: "no_discharge_flag"
      expr: no_discharge_flag
      comment: "Indicates whether no discharge occurred during the reporting period, used to distinguish active discharge periods from dry periods."
  measures:
    - name: "total_dmr_submissions"
      expr: COUNT(1)
      comment: "Total number of DMR submissions. Baseline volume metric for tracking NPDES reporting obligations."
    - name: "noncompliance_dmr_count"
      expr: COUNT(CASE WHEN noncompliance_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs documenting a noncompliance event. Primary regulatory risk indicator for NPDES permit holders."
    - name: "noncompliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN noncompliance_flag = TRUE THEN dmr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMR submissions with noncompliance. Compound rate KPI used by executives to benchmark NPDES permit compliance performance."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs submitted after the regulatory due date. Timeliness KPI that directly drives regulatory penalty risk."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_submission_flag = TRUE THEN dmr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMR submissions that were late. Operational efficiency and regulatory risk metric tracked on compliance dashboards."
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_flag = TRUE THEN dmr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMRs that required resubmission. Data quality KPI indicating rework burden and potential regulatory scrutiny."
    - name: "rejected_dmr_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN dmr_id END)
      comment: "Number of DMRs rejected by the regulatory agency. Quality and compliance risk indicator requiring immediate corrective action."
    - name: "distinct_facilities_reporting"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities submitting DMRs. Coverage metric ensuring all permitted facilities are meeting reporting obligations."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_dmr_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DMR result-level metrics tracking permit limit exceedances, measurement values versus permit limits, and analytical compliance quality for individual discharge parameters."
  source: "`water_utilities_ecm`.`compliance`.`dmr_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the individual DMR result (e.g., In Compliance, Exceedance), used to segment results by regulatory standing."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the monitored parameter (e.g., BOD, TSS, pH), used to analyze compliance by pollutant type."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory code for the monitored parameter, used for standardized cross-facility parameter comparison."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Indicates whether the measured value exceeded the permit limit, used to filter and count exceedance events."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the violation associated with this result (e.g., TRC, SNC), used to prioritize enforcement response."
    - name: "permit_limit_type"
      expr: permit_limit_type
      comment: "Type of permit limit applied (e.g., Daily Maximum, Monthly Average), used to segment exceedances by limit stringency."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parameter result (e.g., mg/L, CFU/100mL), used to ensure dimensional consistency in analysis."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Start month of the result reporting period, used for temporal trend analysis of parameter compliance."
    - name: "enforcement_action_required"
      expr: enforcement_action_required
      comment: "Indicates whether this result triggered an enforcement action requirement, used to track escalation rates."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the result (e.g., Qualified, Rejected), used to assess analytical data reliability."
  measures:
    - name: "total_dmr_results"
      expr: COUNT(1)
      comment: "Total number of DMR parameter results. Baseline volume metric for monitoring program coverage."
    - name: "exceedance_result_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN dmr_result_id END)
      comment: "Number of DMR results where the measured value exceeded the permit limit. Primary NPDES compliance KPI driving enforcement and corrective action decisions."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN dmr_result_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMR results with a permit limit exceedance. Compound compliance rate KPI used in regulatory performance benchmarking."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceeded permit limits. Severity indicator used to prioritize corrective actions and assess environmental risk."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage recorded. Identifies worst-case permit violations requiring immediate regulatory notification and remediation."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value across DMR results. Operational baseline used to track parameter trends relative to permit limits."
    - name: "avg_permit_limit_value"
      expr: AVG(CAST(permit_limit_value AS DOUBLE))
      comment: "Average permit limit value across DMR results. Reference metric used alongside average measurement value to assess headroom to permit limits."
    - name: "enforcement_action_triggered_count"
      expr: COUNT(CASE WHEN enforcement_action_required = TRUE THEN dmr_result_id END)
      comment: "Number of DMR results that triggered an enforcement action requirement. Escalation rate KPI directly linked to regulatory penalty exposure."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter_code)
      comment: "Number of distinct parameters monitored across DMR results. Coverage metric ensuring all permit-required parameters are being sampled."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enforcement action metrics tracking regulatory penalties, civil penalty amounts, resolution rates, and supplemental environmental project (SEP) obligations across facilities and regulatory agencies."
  source: "`water_utilities_ecm`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of enforcement action (e.g., Notice of Violation, Consent Order, Administrative Order), used to segment enforcement severity."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the enforcement action (e.g., Open, Resolved, Appealed), used to track resolution pipeline."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the resolved enforcement action (e.g., Penalty Paid, Dismissed, Consent Agreement), used to evaluate regulatory negotiation results."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether the utility filed an appeal against the enforcement action, used to track legal challenge rates."
    - name: "supplemental_environmental_project_flag"
      expr: supplemental_environmental_project_flag
      comment: "Indicates whether a Supplemental Environmental Project (SEP) was included in the enforcement resolution, used to track SEP program utilization."
    - name: "compliance_schedule_required_flag"
      expr: compliance_schedule_required_flag
      comment: "Indicates whether a compliance schedule was required as part of the enforcement action, used to track structured remediation obligations."
    - name: "issue_year"
      expr: DATE_TRUNC('year', issue_date)
      comment: "Year the enforcement action was issued, used for year-over-year trend analysis of regulatory enforcement activity."
    - name: "public_notice_required_flag"
      expr: public_notice_required_flag
      comment: "Indicates whether a public notice was required for this enforcement action, used to track public transparency obligations."
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(1)
      comment: "Total number of enforcement actions received. Baseline regulatory risk volume metric tracked by executives and legal counsel."
    - name: "open_enforcement_action_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN enforcement_action_id END)
      comment: "Number of currently open enforcement actions. Active liability exposure metric requiring ongoing management attention."
    - name: "total_civil_penalty_amount"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Total civil penalty amount assessed across all enforcement actions. Direct financial liability KPI reported to the board and CFO."
    - name: "total_penalty_paid_amount"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total penalty amount actually paid to regulatory agencies. Cash outflow KPI used to track enforcement cost realization."
    - name: "penalty_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(penalty_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(civil_penalty_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed civil penalties that have been paid. Settlement and resolution efficiency metric used by finance and legal teams."
    - name: "avg_civil_penalty_amount"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty amount per enforcement action. Severity benchmark used to assess regulatory agency enforcement posture over time."
    - name: "total_sep_estimated_cost"
      expr: SUM(CAST(sep_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of Supplemental Environmental Projects (SEPs) across enforcement actions. Community investment and penalty mitigation metric."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN enforcement_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enforcement actions for which an appeal was filed. Legal strategy metric indicating the utility's willingness to contest regulatory findings."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Resolved' THEN enforcement_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enforcement actions that have been resolved. Operational closure rate KPI used to manage regulatory liability backlog."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action metrics tracking remediation progress, cost performance, schedule adherence, and effectiveness verification for compliance violations and enforcement-driven remediation activities."
  source: "`water_utilities_ecm`.`compliance`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g., Open, In Progress, Closed, Overdue), used to track remediation pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the corrective action (e.g., Critical, High, Medium, Low), used to focus resources on highest-risk remediations."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the corrective action (e.g., Inspection Finding, Violation, Overflow), used to analyze root cause patterns."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the corrective action, used to allocate accountability and workload across the organization."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the effectiveness verification for the corrective action (e.g., Verified, Pending, Failed), used to confirm remediation closure quality."
    - name: "preventive_action_implemented"
      expr: preventive_action_implemented
      comment: "Indicates whether a preventive action was implemented alongside the corrective action, used to track systemic improvement rates."
    - name: "planned_completion_year"
      expr: DATE_TRUNC('year', planned_completion_date)
      comment: "Year the corrective action is planned to be completed, used for capacity planning and schedule risk analysis."
    - name: "regulatory_agency_notified"
      expr: regulatory_agency_notified
      comment: "Indicates whether the regulatory agency was notified of the corrective action, used to track notification compliance obligations."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions. Baseline remediation workload metric used to assess compliance program capacity."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN corrective_action_id END)
      comment: "Number of currently open corrective actions. Active remediation backlog metric used by operations and compliance leadership."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Direct compliance remediation expenditure KPI reported to finance and executive leadership."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Budget planning KPI used to forecast compliance remediation spend."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated corrective action costs. Budget performance KPI indicating cost overrun or underrun on compliance remediation."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Unit cost benchmark used to evaluate remediation efficiency and inform future budget estimates."
    - name: "preventive_action_implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventive_action_implemented = TRUE THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that also implemented a preventive measure. Systemic improvement rate KPI indicating the maturity of the compliance management program."
    - name: "verified_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions with verified closure. Quality of remediation KPI ensuring actions are not just closed on paper but confirmed effective."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection metrics tracking inspection outcomes, deficiency rates, enforcement escalation rates, and follow-up compliance for facility and process unit inspections conducted by regulatory agencies."
  source: "`water_utilities_ecm`.`compliance`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., Routine, Complaint-Driven, Follow-Up), used to segment inspection outcomes by inspection purpose."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Report Pending), used to track inspection pipeline."
    - name: "inspection_report_status"
      expr: inspection_report_status
      comment: "Status of the inspection report (e.g., Draft, Final, Accepted), used to track regulatory documentation completion."
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Indicates whether the inspection identified a significant deficiency, used to flag high-risk inspection outcomes."
    - name: "violation_identified_flag"
      expr: violation_identified_flag
      comment: "Indicates whether the inspection identified a regulatory violation, used to track inspection-to-violation conversion rates."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Indicates whether the inspection resulted in an enforcement action, used to track escalation rates from inspections."
    - name: "follow_up_inspection_required_flag"
      expr: follow_up_inspection_required_flag
      comment: "Indicates whether a follow-up inspection was required, used to track unresolved deficiency rates."
    - name: "inspection_year"
      expr: DATE_TRUNC('year', inspection_date)
      comment: "Year of the inspection, used for year-over-year trend analysis of regulatory inspection activity and outcomes."
    - name: "significant_deficiency_classification"
      expr: significant_deficiency_classification
      comment: "Classification of the significant deficiency identified (e.g., Significant Non-Compliance, Minor), used to prioritize remediation response."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections. Baseline metric for tracking regulatory oversight activity and inspection program coverage."
    - name: "violation_identified_count"
      expr: COUNT(CASE WHEN violation_identified_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections that identified a regulatory violation. Primary inspection outcome KPI driving compliance program prioritization."
    - name: "violation_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_identified_flag = TRUE THEN regulatory_inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a violation finding. Compound compliance performance rate used by executives to benchmark regulatory standing."
    - name: "significant_deficiency_count"
      expr: COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections with significant deficiency findings. High-severity risk indicator requiring prioritized corrective action and board-level awareness."
    - name: "enforcement_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enforcement_action_flag = TRUE THEN regulatory_inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that escalated to an enforcement action. Regulatory risk escalation KPI used to assess the severity of compliance gaps."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_inspection_required_flag = TRUE THEN regulatory_inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a follow-up inspection. Unresolved deficiency rate indicating the effectiveness of initial corrective responses."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections requiring corrective action. Remediation workload driver metric used to plan compliance program resources."
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities inspected. Coverage metric ensuring all regulated facilities receive required regulatory oversight."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_inspection_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection finding metrics tracking finding severity, resolution rates, recurrence patterns, and cost of remediation for individual deficiencies identified during regulatory inspections."
  source: "`water_utilities_ecm`.`compliance`.`inspection_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of inspection finding (e.g., Deficiency, Violation, Observation), used to segment findings by regulatory significance."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., Operations, Maintenance, Documentation), used to identify systemic compliance gaps by functional area."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding (e.g., Critical, High, Medium, Low), used to prioritize remediation resources."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding (e.g., Open, Resolved, Overdue), used to track remediation pipeline."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether this finding is a recurrence of a previously identified deficiency, used to detect systemic compliance failures."
    - name: "enforcement_action_required"
      expr: enforcement_action_required
      comment: "Indicates whether the finding requires an enforcement action, used to track escalation rates from inspection findings."
    - name: "identified_year"
      expr: DATE_TRUNC('year', identified_date)
      comment: "Year the finding was identified, used for trend analysis of inspection finding volumes and severity over time."
    - name: "affected_system"
      expr: affected_system
      comment: "System or process area affected by the finding (e.g., Distribution, Treatment, Monitoring), used to identify high-risk operational areas."
  measures:
    - name: "total_inspection_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings. Baseline metric for tracking regulatory deficiency volume across the compliance program."
    - name: "critical_high_risk_finding_count"
      expr: COUNT(CASE WHEN risk_level IN ('Critical', 'High') THEN inspection_finding_id END)
      comment: "Number of critical or high-risk inspection findings. Priority risk indicator used by executives to assess the severity of the compliance deficiency portfolio."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN inspection_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection findings that are recurrences of previously identified deficiencies. Systemic failure indicator used to evaluate the effectiveness of the compliance management program."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN inspection_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection findings that have been resolved. Remediation effectiveness KPI used to manage the open deficiency backlog."
    - name: "enforcement_escalation_count"
      expr: COUNT(CASE WHEN enforcement_action_required = TRUE THEN inspection_finding_id END)
      comment: "Number of inspection findings that escalated to an enforcement action requirement. Regulatory risk escalation metric directly linked to penalty exposure."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to remediate inspection findings. Compliance cost KPI used to quantify the financial impact of regulatory deficiencies."
    - name: "avg_estimated_remediation_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated remediation cost per inspection finding. Unit cost benchmark used for compliance budget planning and risk prioritization."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage cost overrun on inspection finding remediation. Budget performance KPI indicating whether compliance remediation is being executed within planned cost."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_mor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monthly Operating Report (MOR) metrics tracking drinking water treatment compliance, turbidity performance, CT value achievement, disinfection residuals, and fluoride compliance for water treatment plants."
  source: "`water_utilities_ecm`.`compliance`.`mor`"
  dimensions:
    - name: "turbidity_compliance_status"
      expr: turbidity_compliance_status
      comment: "Turbidity compliance status for the reporting month (e.g., Compliant, Non-Compliant), used to track Surface Water Treatment Rule compliance."
    - name: "ct_compliance_status"
      expr: ct_compliance_status
      comment: "CT (Concentration × Time) compliance status for the reporting month, used to track disinfection efficacy compliance."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the MOR (e.g., Certified, Pending, Rejected), used to track operator certification compliance."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (e.g., Chlorine, Chloramine, UV), used to segment treatment performance by disinfection technology."
    - name: "source_water_type"
      expr: source_water_type
      comment: "Type of source water treated (e.g., Surface Water, Groundwater), used to segment treatment compliance by source water vulnerability."
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_month)
      comment: "Month of the MOR reporting period, used for temporal trend analysis of treatment plant performance."
    - name: "agency_response_received"
      expr: agency_response_received
      comment: "Indicates whether the regulatory agency responded to the MOR submission, used to track regulatory acknowledgment rates."
  measures:
    - name: "total_mor_reports"
      expr: COUNT(1)
      comment: "Total number of Monthly Operating Reports submitted. Baseline reporting compliance volume metric."
    - name: "turbidity_noncompliant_month_count"
      expr: COUNT(CASE WHEN turbidity_compliance_status != 'Compliant' THEN mor_id END)
      comment: "Number of reporting months with turbidity noncompliance. Critical public health KPI indicating failure to meet Surface Water Treatment Rule filtration requirements."
    - name: "ct_noncompliant_month_count"
      expr: COUNT(CASE WHEN ct_compliance_status != 'Compliant' THEN mor_id END)
      comment: "Number of reporting months with CT value noncompliance. Critical disinfection efficacy KPI indicating potential pathogen risk in finished water."
    - name: "avg_finished_water_turbidity_ntu"
      expr: AVG(CAST(finished_water_turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity (NTU) across MOR reporting periods. Treatment performance KPI benchmarked against the 0.3 NTU regulatory standard."
    - name: "max_finished_water_turbidity_ntu"
      expr: MAX(CAST(finished_water_turbidity_max_ntu AS DOUBLE))
      comment: "Maximum finished water turbidity (NTU) recorded. Worst-case treatment performance indicator used to identify peak risk events."
    - name: "avg_ct_value_achieved"
      expr: AVG(CAST(ct_value_achieved AS DOUBLE))
      comment: "Average CT value achieved across MOR reporting periods. Disinfection efficacy KPI compared against the required CT value to assess pathogen inactivation performance."
    - name: "avg_ct_value_required"
      expr: AVG(CAST(ct_value_required AS DOUBLE))
      comment: "Average CT value required by permit across MOR reporting periods. Regulatory benchmark used alongside achieved CT to calculate disinfection compliance headroom."
    - name: "avg_disinfectant_residual_mg_l"
      expr: AVG(CAST(disinfectant_residual_avg_mg_l AS DOUBLE))
      comment: "Average disinfectant residual (mg/L) in finished water. Distribution system protection KPI ensuring adequate residual to prevent microbial regrowth."
    - name: "avg_fluoride_mg_l"
      expr: AVG(CAST(fluoride_avg_mg_l AS DOUBLE))
      comment: "Average fluoride concentration (mg/L) in finished water. Public health KPI monitored against the EPA optimal fluoride level of 0.7 mg/L and MCL of 4.0 mg/L."
    - name: "avg_total_water_produced_mgd"
      expr: AVG(CAST(total_water_produced_mgd AS DOUBLE))
      comment: "Average total water produced (million gallons per day) across MOR reporting periods. Operational throughput KPI used for capacity planning and demand forecasting."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission metrics tracking submission timeliness, amendment rates, noncompliance reporting, and agency response patterns across all regulatory reporting obligations."
  source: "`water_utilities_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., DMR, MOR, CCR, Annual Report), used to segment submission performance by report type."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Accepted, Rejected, Pending), used to track submission pipeline health."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., Electronic Portal, Mail, Hand Delivery), used to track electronic reporting adoption."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Indicates whether the submission was made after the regulatory due date, used to track timeliness compliance."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Indicates whether this submission is an amendment to a prior submission, used to track data quality and rework rates."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Indicates whether the agency required a resubmission, used to track regulatory rejection rates."
    - name: "agency_response_type"
      expr: agency_response_type
      comment: "Type of agency response received (e.g., Accepted, Deficiency Letter, Request for Information), used to analyze regulatory feedback patterns."
    - name: "submission_year"
      expr: DATE_TRUNC('year', submission_date)
      comment: "Year of the submission, used for year-over-year trend analysis of regulatory reporting performance."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline reporting obligation volume metric."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions made after the regulatory due date. Timeliness compliance KPI directly linked to regulatory penalty risk."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = TRUE THEN regulatory_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory submissions that were late. Compound timeliness KPI used by compliance leadership to benchmark reporting program performance."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amendment = TRUE THEN regulatory_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that are amendments to prior filings. Data quality KPI indicating the frequency of errors requiring correction after initial submission."
    - name: "resubmission_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = TRUE THEN regulatory_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions for which the agency required a resubmission. Regulatory rejection rate KPI indicating submission quality issues."
    - name: "accepted_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Accepted' THEN regulatory_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions accepted by the regulatory agency on first submission. First-pass acceptance rate KPI measuring overall submission quality."
    - name: "distinct_facilities_submitting"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities making regulatory submissions. Coverage metric ensuring all regulated facilities are meeting reporting obligations."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation metrics tracking fulfillment rates, cost performance, schedule adherence, and critical path obligations across regulatory requirements and permit conditions."
  source: "`water_utilities_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., Monitoring, Reporting, Operational, Capital Improvement), used to segment obligations by regulatory category."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., Open, Completed, Overdue, Waived), used to track fulfillment pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation (e.g., Critical, High, Medium, Low), used to focus management attention on highest-risk obligations."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the obligation, used to allocate accountability and workload."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the obligation is on the critical path of a compliance schedule, used to prioritize schedule-sensitive obligations."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Indicates whether the obligation requires escalation due to risk or delay, used to track management intervention needs."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the obligation (e.g., Environmental, Legal, Financial, Operational), used to segment obligations by risk type."
    - name: "due_year"
      expr: DATE_TRUNC('year', due_date)
      comment: "Year the obligation is due, used for capacity planning and forward-looking compliance schedule management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations. Baseline metric for tracking the scope of the regulatory obligation portfolio."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN obligation_status = 'Overdue' THEN obligation_id END)
      comment: "Number of obligations that are past their due date. Active regulatory risk indicator requiring immediate management attention and potential agency notification."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status = 'Completed' THEN obligation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations that have been fulfilled. Primary compliance program effectiveness KPI used in executive and board reporting."
    - name: "critical_path_overdue_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND obligation_status = 'Overdue' THEN obligation_id END)
      comment: "Number of critical path obligations that are overdue. Highest-priority risk indicator for compliance schedule management, directly linked to enforcement action risk."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill compliance obligations. Direct compliance program expenditure KPI reported to finance leadership."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of compliance obligations. Forward-looking budget planning KPI for compliance program financial management."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated obligation fulfillment costs. Budget performance KPI indicating compliance program cost control effectiveness."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN obligation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations requiring management escalation. Risk management KPI indicating the proportion of obligations that cannot be resolved at the operational level."
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per compliance obligation. Workforce productivity KPI used to benchmark compliance program staffing requirements."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_industrial_user`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Industrial user (pretreatment program) metrics tracking compliance status, inspection coverage, violation rates, and discharge volumes for industrial users discharging to the municipal sewer system."
  source: "`water_utilities_ecm`.`compliance`.`industrial_user`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the industrial user (e.g., Compliant, Significant Non-Compliant, Non-Compliant), used to segment the industrial user portfolio by regulatory standing."
    - name: "classification"
      expr: classification
      comment: "Classification of the industrial user (e.g., Significant Industrial User, Categorical Industrial User), used to segment by regulatory tier."
    - name: "categorical_standard_applicable"
      expr: categorical_standard_applicable
      comment: "Indicates whether a federal categorical pretreatment standard applies to this industrial user, used to segment users by regulatory stringency."
    - name: "enforcement_action_pending"
      expr: enforcement_action_pending
      comment: "Indicates whether an enforcement action is currently pending against the industrial user, used to track active regulatory escalations."
    - name: "pretreatment_system_installed"
      expr: pretreatment_system_installed
      comment: "Indicates whether the industrial user has installed a pretreatment system, used to track technology compliance rates."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the industrial user is currently active, used to filter the active regulated universe."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry code of the industrial user, used to analyze compliance patterns by industry sector."
  measures:
    - name: "total_industrial_users"
      expr: COUNT(1)
      comment: "Total number of industrial users in the pretreatment program. Baseline metric for tracking the regulated industrial discharger universe."
    - name: "significant_noncompliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Significant Non-Compliant' THEN industrial_user_id END)
      comment: "Number of industrial users in Significant Non-Compliance (SNC). Primary pretreatment program KPI reported to the EPA and state primacy agency in the annual pretreatment report."
    - name: "significant_noncompliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Significant Non-Compliant' THEN industrial_user_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of industrial users in Significant Non-Compliance. Compound pretreatment program performance rate used by regulators to evaluate program effectiveness."
    - name: "enforcement_action_pending_count"
      expr: COUNT(CASE WHEN enforcement_action_pending = TRUE THEN industrial_user_id END)
      comment: "Number of industrial users with a pending enforcement action. Active regulatory escalation metric used to manage the enforcement pipeline."
    - name: "pretreatment_installation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pretreatment_system_installed = TRUE THEN industrial_user_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of industrial users with a pretreatment system installed. Technology compliance rate KPI used to assess the effectiveness of the pretreatment program in reducing pollutant loads."
    - name: "total_estimated_discharge_volume_gpd"
      expr: SUM(CAST(estimated_discharge_volume_gpd AS DOUBLE))
      comment: "Total estimated discharge volume (gallons per day) from all industrial users. Pollutant loading capacity KPI used to assess the aggregate impact of industrial discharges on the WWTP."
    - name: "avg_estimated_discharge_volume_gpd"
      expr: AVG(CAST(estimated_discharge_volume_gpd AS DOUBLE))
      comment: "Average estimated discharge volume (gallons per day) per industrial user. Unit discharge benchmark used to identify high-volume dischargers for enhanced monitoring."
    - name: "inspection_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_inspection_date IS NOT NULL THEN industrial_user_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of industrial users that have received at least one inspection. Program coverage KPI ensuring all regulated dischargers are subject to oversight."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_public_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public notification metrics tracking regulatory deadline compliance, notification distribution costs, tier classification, and public meeting obligations for drinking water violations requiring public notice."
  source: "`water_utilities_ecm`.`compliance`.`compliance_public_notification`"
  dimensions:
    - name: "notification_tier"
      expr: notification_tier
      comment: "Tier of the public notification (Tier 1, Tier 2, Tier 3), indicating urgency and required notification timeline under the Public Notification Rule."
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the public notification (e.g., Issued, Pending, Overdue), used to track notification obligation fulfillment."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to deliver the public notification (e.g., Direct Mail, Newspaper, Website), used to analyze distribution channel effectiveness."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation triggering the public notification (e.g., MCL Violation, Treatment Technique Violation), used to segment notifications by violation category."
    - name: "deadline_met_flag"
      expr: deadline_met_flag
      comment: "Indicates whether the notification was issued within the regulatory deadline, used to track Public Notification Rule timeliness compliance."
    - name: "repeat_notification_required_flag"
      expr: repeat_notification_required_flag
      comment: "Indicates whether repeat notifications are required (for ongoing violations), used to track extended notification obligations."
    - name: "public_meeting_held_flag"
      expr: public_meeting_held_flag
      comment: "Indicates whether a public meeting was held as part of the notification process, used to track community engagement compliance."
    - name: "violation_year"
      expr: DATE_TRUNC('year', violation_date)
      comment: "Year the underlying violation occurred, used for trend analysis of public notification obligations over time."
  measures:
    - name: "total_public_notifications"
      expr: COUNT(1)
      comment: "Total number of public notifications issued. Baseline metric for tracking the volume of drinking water violation notifications to the public."
    - name: "tier1_notification_count"
      expr: COUNT(CASE WHEN notification_tier = 'Tier 1' THEN compliance_public_notification_id END)
      comment: "Number of Tier 1 public notifications (most urgent, required within 24 hours). Critical public health risk indicator requiring immediate executive awareness."
    - name: "deadline_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deadline_met_flag = TRUE THEN compliance_public_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of public notifications issued within the regulatory deadline. Public Notification Rule compliance rate KPI directly linked to regulatory penalty risk."
    - name: "deadline_missed_count"
      expr: COUNT(CASE WHEN deadline_met_flag = FALSE THEN compliance_public_notification_id END)
      comment: "Number of public notifications issued after the regulatory deadline. Timeliness violation count used to assess Public Notification Rule compliance failures."
    - name: "total_distribution_cost"
      expr: SUM(CAST(distribution_cost_amount AS DOUBLE))
      comment: "Total cost incurred to distribute public notifications. Compliance program cost KPI used to budget for public notification obligations."
    - name: "avg_distribution_cost_per_notification"
      expr: AVG(CAST(distribution_cost_amount AS DOUBLE))
      comment: "Average distribution cost per public notification. Unit cost benchmark used to evaluate notification delivery efficiency and channel cost-effectiveness."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured contaminant value triggering public notifications. Severity indicator used to assess the magnitude of violations requiring public notice."
    - name: "repeat_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_notification_required_flag = TRUE THEN compliance_public_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of public notifications requiring repeat issuance due to ongoing violations. Chronic violation indicator used to identify persistent compliance failures."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`compliance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance schedule metrics tracking milestone completion rates, schedule adherence, cost performance, and extension request patterns for regulatory compliance schedules tied to enforcement actions and permit conditions."
  source: "`water_utilities_ecm`.`compliance`.`schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of compliance schedule (e.g., Consent Order, Permit Compliance Schedule, Voluntary), used to segment schedules by regulatory instrument."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the compliance schedule (e.g., Active, Completed, Overdue, Extended), used to track schedule portfolio health."
    - name: "on_schedule_flag"
      expr: on_schedule_flag
      comment: "Indicates whether the compliance schedule is currently on track, used to identify at-risk schedules requiring management intervention."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Indicates whether a schedule extension was requested, used to track the frequency of deadline extension requests."
    - name: "extension_approved_flag"
      expr: extension_approved_flag
      comment: "Indicates whether the requested schedule extension was approved by the regulatory agency, used to track extension approval rates."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Indicates whether public notification is required for this compliance schedule, used to track public transparency obligations."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the compliance schedule, used to allocate accountability across the organization."
    - name: "final_deadline_year"
      expr: DATE_TRUNC('year', final_compliance_deadline)
      comment: "Year of the final compliance deadline, used for forward-looking schedule risk analysis and capacity planning."
  measures:
    - name: "total_compliance_schedules"
      expr: COUNT(1)
      comment: "Total number of compliance schedules. Baseline metric for tracking the regulatory schedule portfolio."
    - name: "off_schedule_count"
      expr: COUNT(CASE WHEN on_schedule_flag = FALSE THEN schedule_id END)
      comment: "Number of compliance schedules that are currently off track. Active regulatory risk indicator requiring immediate management intervention to avoid enforcement escalation."
    - name: "on_schedule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_schedule_flag = TRUE THEN schedule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance schedules currently on track. Primary schedule adherence KPI used in executive and board compliance reporting."
    - name: "avg_overall_completion_pct"
      expr: AVG(CAST(overall_completion_percentage AS DOUBLE))
      comment: "Average overall completion percentage across all compliance schedules. Portfolio progress KPI used to assess the aggregate advancement of regulatory remediation programs."
    - name: "extension_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_requested_flag = TRUE THEN schedule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance schedules for which an extension was requested. Schedule risk indicator used to assess the frequency of deadline pressure across the compliance portfolio."
    - name: "extension_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_approved_flag = TRUE THEN schedule_id END) / NULLIF(COUNT(CASE WHEN extension_requested_flag = TRUE THEN schedule_id END), 0), 2)
      comment: "Percentage of extension requests that were approved by the regulatory agency. Regulatory relationship metric indicating the agency's willingness to grant schedule relief."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost incurred across all compliance schedules. Compliance capital and operational expenditure KPI reported to finance and executive leadership."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of compliance schedules. Forward-looking budget planning KPI for compliance program financial management."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_total_cost AS DOUBLE)) - SUM(CAST(estimated_total_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_total_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated compliance schedule costs. Budget performance KPI indicating cost control effectiveness on regulatory remediation programs."
$$;