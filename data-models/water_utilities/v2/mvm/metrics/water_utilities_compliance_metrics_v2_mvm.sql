-- Metric views for domain: compliance | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for water utility compliance permits. Tracks permit portfolio health, financial exposure from annual fees, permitted flow capacity, and renewal/expiration risk across jurisdictions and regulatory programs."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., Active, Expired, Pending Renewal) — primary grouping for portfolio health analysis."
    - name: "permit_type"
      expr: permit_type
      comment: "Classification of the permit type (e.g., NPDES, Water Supply) — used to segment fee and flow analysis by regulatory program."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the permit — critical for regulatory risk dashboards."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Governing jurisdiction of the permit — enables geographic and regulatory segmentation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the permit was issued (e.g., SDWA, CWA, EU WFD) — supports multi-framework compliance reporting."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Specific regulatory program associated with the permit — used for program-level compliance tracking."
    - name: "major_minor_classification"
      expr: major_minor_classification
      comment: "Major or minor permit classification — drives prioritization of compliance oversight resources."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the permit — used to segment portfolio by regulatory authority."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of permit effective date — supports trend analysis of permit issuances over time."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of permit expiration — used to forecast upcoming renewal workload and risk."
    - name: "special_conditions_flag"
      expr: special_conditions_flag
      comment: "Indicates whether the permit carries special conditions — used to identify higher-complexity permits requiring additional oversight."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Indicates whether public notification is required — used to track regulatory transparency obligations."
  measures:
    - name: "total_active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN compliance_permit_id END)
      comment: "Count of currently active permits. Executives use this to gauge the size and scope of the active regulatory permit portfolio."
    - name: "total_permits"
      expr: COUNT(compliance_permit_id)
      comment: "Total number of permits across all statuses. Baseline measure for portfolio sizing and trend analysis."
    - name: "total_annual_fee_amount"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual regulatory fee obligations across all permits. Directly informs budgeting and cost-of-compliance financial planning."
    - name: "avg_annual_fee_amount"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per permit. Used to benchmark fee burden and identify outlier permits with disproportionate cost."
    - name: "total_permitted_flow_mgd"
      expr: SUM(CAST(permitted_flow_mgd AS DOUBLE))
      comment: "Total permitted flow capacity in million gallons per day across all permits. Strategic KPI for capacity planning and regulatory headroom assessment."
    - name: "avg_permitted_flow_mgd"
      expr: AVG(CAST(permitted_flow_mgd AS DOUBLE))
      comment: "Average permitted flow per permit in MGD. Used to understand typical permit scale and identify capacity outliers."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN compliance_permit_id END)
      comment: "Number of permits expiring within the next 90 days. Critical operational KPI for renewal risk management — triggers proactive renewal actions."
    - name: "permits_with_special_conditions"
      expr: COUNT(CASE WHEN special_conditions_flag = TRUE THEN compliance_permit_id END)
      comment: "Count of permits carrying special regulatory conditions. Indicates complexity and elevated compliance monitoring burden."
    - name: "noncompliant_permit_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'In Compliance') THEN compliance_permit_id END)
      comment: "Number of permits not in compliance status. A leading risk indicator used by compliance officers and executives to prioritize remediation."
    - name: "permit_renewal_overdue_count"
      expr: COUNT(CASE WHEN renewal_due_date < CURRENT_DATE AND permit_status = 'Active' THEN compliance_permit_id END)
      comment: "Count of active permits where the renewal due date has passed without renewal. Signals regulatory exposure and potential enforcement risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-value KPIs tracking water utility regulatory violations — their frequency, financial penalties, health risk profile, and resolution performance. Core domain for regulatory risk management and executive compliance reporting."
  source: "`vibe_water_utilities_v1`.`compliance`.`violation`"
  dimensions:
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., Open, Resolved, Pending) — primary dimension for active risk monitoring."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of regulatory violation (e.g., MCL Exceedance, Monitoring, Reporting) — used to categorize and prioritize remediation efforts."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation — drives escalation and resource allocation decisions."
    - name: "health_based_flag"
      expr: health_based_flag
      comment: "Indicates whether the violation poses a direct health risk — highest-priority filter for public health protection reporting."
    - name: "is_public_notification_required"
      expr: is_public_notification_required
      comment: "Indicates whether public notification is required for this violation — tracks regulatory transparency obligations."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Indicates whether an enforcement action has been triggered — used to measure escalation rate."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the violation occurred — enables geographic risk segmentation."
    - name: "violation_date_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month of violation occurrence — supports trend analysis of violation frequency over time."
    - name: "rule_name"
      expr: rule_name
      comment: "Name of the regulatory rule violated — used to identify systemic compliance gaps by regulation."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Water quality parameter associated with the violation (e.g., Lead, Nitrate, Turbidity) — critical for contaminant-specific risk analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome of the violation — used to track closure rates and outstanding liabilities."
  measures:
    - name: "total_violations"
      expr: COUNT(violation_id)
      comment: "Total number of violations recorded. Baseline KPI for regulatory compliance performance — tracked on every executive compliance dashboard."
    - name: "open_violations"
      expr: COUNT(CASE WHEN violation_status NOT IN ('Resolved', 'Closed', 'Return to Compliance') THEN violation_id END)
      comment: "Count of unresolved violations. Directly measures current regulatory exposure and drives remediation prioritization."
    - name: "health_based_violation_count"
      expr: COUNT(CASE WHEN health_based_flag = TRUE THEN violation_id END)
      comment: "Number of violations classified as health-based. Highest-priority public health KPI — any increase triggers immediate executive and regulatory response."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed across all violations. Core financial risk KPI for compliance cost management and budget forecasting."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Total penalties in USD — used for standardized financial reporting across multi-jurisdiction portfolios."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Benchmarks penalty severity and informs risk-adjusted compliance investment decisions."
    - name: "violations_with_enforcement_action"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN violation_id END)
      comment: "Number of violations that escalated to formal enforcement action. Measures regulatory escalation rate — a leading indicator of systemic compliance failure."
    - name: "violations_requiring_public_notification"
      expr: COUNT(CASE WHEN is_public_notification_required = TRUE THEN violation_id END)
      comment: "Count of violations requiring public notification. Tracks public transparency obligations and reputational risk exposure."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, violation_date) AS DOUBLE))
      comment: "Average number of days from violation detection to resolution. Operational efficiency KPI — longer resolution times signal systemic remediation bottlenecks."
    - name: "measured_value_avg"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured contaminant or parameter value at time of violation. Used to assess typical exceedance magnitude relative to regulatory limits."
    - name: "regulatory_limit_avg"
      expr: AVG(CAST(regulatory_limit AS DOUBLE))
      comment: "Average regulatory limit value across violations. Paired with measured_value_avg to compute exceedance ratios in BI tools."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory enforcement actions against the water utility — tracking financial penalties, resolution performance, appeal activity, and supplemental environmental project commitments. Used by legal, compliance, and executive teams to manage regulatory liability."
  source: "`vibe_water_utilities_v1`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of enforcement action (e.g., Notice of Violation, Consent Order, Administrative Order) — primary dimension for enforcement severity analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the enforcement action (e.g., Open, Resolved, Appealed) — used to track active regulatory liabilities."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the enforcement action — used to segment liability by regulatory authority."
    - name: "issuing_agency_region"
      expr: issuing_agency_region
      comment: "Regional office of the issuing agency — supports geographic risk analysis."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal was filed — used to track contested enforcement actions and legal resource requirements."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is mandated — drives operational remediation planning."
    - name: "supplemental_environmental_project_flag"
      expr: supplemental_environmental_project_flag
      comment: "Indicates whether a Supplemental Environmental Project (SEP) is part of the resolution — used to track SEP commitments and costs."
    - name: "action_date_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month of enforcement action issuance — supports trend analysis of enforcement activity over time."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the enforcement action resolution — used to evaluate settlement and compliance performance."
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(enforcement_action_id)
      comment: "Total number of enforcement actions received. Baseline KPI for regulatory enforcement exposure — tracked on executive compliance scorecards."
    - name: "open_enforcement_actions"
      expr: COUNT(CASE WHEN action_status NOT IN ('Resolved', 'Closed', 'Dismissed') THEN enforcement_action_id END)
      comment: "Count of unresolved enforcement actions. Measures current regulatory liability exposure requiring active management."
    - name: "total_civil_penalty_amount"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Total civil penalties assessed across all enforcement actions. Primary financial liability KPI for compliance cost management."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts across enforcement actions. Used alongside civil_penalty for comprehensive financial exposure reporting."
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total penalties already paid. Tracks cash outflow from enforcement actions and outstanding unpaid liability."
    - name: "outstanding_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE) - CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total unpaid penalty balance (penalty assessed minus paid). Direct measure of outstanding financial regulatory liability."
    - name: "total_sep_estimated_cost"
      expr: SUM(CAST(sep_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of Supplemental Environmental Projects committed as part of enforcement resolutions. Tracks environmental investment obligations."
    - name: "enforcement_actions_with_appeal"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN enforcement_action_id END)
      comment: "Number of enforcement actions where an appeal was filed. Measures legal contestation rate and associated legal resource demand."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, action_date) AS DOUBLE))
      comment: "Average days from enforcement action issuance to resolution. Operational KPI for enforcement response efficiency — longer cycles increase regulatory risk."
    - name: "avg_civil_penalty_per_action"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty per enforcement action. Benchmarks penalty severity and informs risk-adjusted compliance investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory inspections of water utility facilities — tracking inspection outcomes, deficiency rates, enforcement escalation, and follow-up compliance. Used by operations, compliance, and executive teams to manage inspection readiness and regulatory standing."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., Routine, Complaint-Driven, Follow-Up) — primary dimension for inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Pending Report) — used to track inspection pipeline."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Agency conducting the inspection — used to segment inspection outcomes by regulatory authority."
    - name: "inspection_report_status"
      expr: inspection_report_status
      comment: "Status of the inspection report (e.g., Draft, Final, Submitted) — tracks reporting compliance obligations."
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Indicates whether a significant deficiency was identified — highest-priority inspection outcome flag for executive reporting."
    - name: "violation_identified_flag"
      expr: violation_identified_flag
      comment: "Indicates whether a violation was identified during the inspection — key leading indicator for enforcement risk."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Indicates whether the inspection resulted in an enforcement action — measures escalation rate from inspections."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether corrective action was required following the inspection — drives remediation workload planning."
    - name: "follow_up_inspection_required_flag"
      expr: follow_up_inspection_required_flag
      comment: "Indicates whether a follow-up inspection was required — measures first-pass compliance rate."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — supports trend analysis of inspection frequency and outcomes over time."
    - name: "significant_deficiency_classification"
      expr: significant_deficiency_classification
      comment: "Classification of significant deficiency type — used to identify systemic infrastructure or operational weaknesses."
  measures:
    - name: "total_inspections"
      expr: COUNT(regulatory_inspection_id)
      comment: "Total number of regulatory inspections conducted. Baseline KPI for inspection program activity and regulatory engagement."
    - name: "inspections_with_violations"
      expr: COUNT(CASE WHEN violation_identified_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections that identified at least one violation. Core compliance performance KPI — directly measures inspection pass/fail rate."
    - name: "inspections_with_significant_deficiency"
      expr: COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections resulting in a significant deficiency finding. Highest-severity inspection outcome — triggers mandatory executive escalation."
    - name: "inspections_resulting_in_enforcement"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections that escalated to formal enforcement action. Measures the rate at which inspections convert to regulatory liability."
    - name: "inspections_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_inspection_required_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections requiring a follow-up visit. Inverse of first-pass compliance rate — high values indicate systemic operational deficiencies."
    - name: "avg_days_to_corrective_action_due"
      expr: AVG(CAST(DATEDIFF(corrective_action_due_date, inspection_date) AS DOUBLE))
      comment: "Average days between inspection date and corrective action due date. Measures regulatory response window and urgency of remediation requirements."
    - name: "violation_identification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_identified_flag = TRUE THEN regulatory_inspection_id END) / NULLIF(COUNT(regulatory_inspection_id), 0), 2)
      comment: "Percentage of inspections that identified a violation. Strategic KPI for inspection readiness — benchmarked against industry standards and tracked on executive scorecards."
    - name: "significant_deficiency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN regulatory_inspection_id END) / NULLIF(COUNT(regulatory_inspection_id), 0), 2)
      comment: "Percentage of inspections resulting in a significant deficiency. Tracks systemic infrastructure and operational risk — a declining rate signals improving compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory reporting submissions — tracking on-time submission performance, late filing rates, amendment frequency, and noncompliance reporting. Used by compliance managers and executives to manage reporting obligations and avoid late-submission penalties."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., DMR, Annual Report, Incident Report) — primary dimension for submission program analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Pending, Rejected) — used to track submission pipeline and outstanding obligations."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., Electronic, Paper, Portal) — used to track digital adoption and submission channel efficiency."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Indicates whether the submission was filed after the due date — primary dimension for on-time compliance performance analysis."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Indicates whether the submission is an amendment to a prior filing — used to track data quality and correction rates."
    - name: "agency_response_type"
      expr: agency_response_type
      comment: "Type of agency response received (e.g., Accepted, Rejected, Acknowledged) — measures submission acceptance quality."
    - name: "public_notice_required"
      expr: public_notice_required
      comment: "Indicates whether public notice is required for this submission — tracks transparency obligations."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission — supports trend analysis of submission volume and timeliness over time."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Indicates whether a resubmission was required — measures first-submission quality and rework rate."
  measures:
    - name: "total_submissions"
      expr: COUNT(regulatory_submission_id)
      comment: "Total number of regulatory submissions filed. Baseline KPI for reporting program volume and workload management."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions filed after the regulatory due date. Direct measure of reporting compliance failure — late submissions trigger penalties and regulatory scrutiny."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN regulatory_submission_id END) / NULLIF(COUNT(regulatory_submission_id), 0), 2)
      comment: "Percentage of submissions filed on time. Primary KPI for regulatory reporting compliance — tracked on executive compliance scorecards and regulatory performance reviews."
    - name: "amendment_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN regulatory_submission_id END)
      comment: "Number of amendment submissions. Measures data quality and accuracy of original filings — high amendment rates signal upstream data or process issues."
    - name: "resubmission_required_count"
      expr: COUNT(CASE WHEN resubmission_required = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions requiring resubmission. Tracks first-pass acceptance rate and submission quality — drives process improvement initiatives."
    - name: "avg_days_late"
      expr: AVG(CAST(DATEDIFF(submission_date, due_date) AS DOUBLE))
      comment: "Average number of days between due date and actual submission date (positive = late). Measures severity of late filing patterns and informs deadline management improvements."
    - name: "submissions_with_noncompliance"
      expr: COUNT(CASE WHEN noncompliance_explanation IS NOT NULL THEN regulatory_submission_id END)
      comment: "Number of submissions that included a noncompliance explanation. Tracks self-reported noncompliance frequency — a key input for regulatory risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance obligations — tracking completion rates, cost performance, effort efficiency, and overdue obligations. Used by compliance managers and operations teams to manage regulatory commitments and avoid enforcement escalation."
  source: "`vibe_water_utilities_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., Monitoring, Reporting, Corrective Action) — primary dimension for obligation portfolio analysis."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., Open, Completed, Overdue) — used to track active compliance commitments."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the obligation — drives resource allocation and escalation decisions."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category associated with the obligation — used to segment obligations by regulatory and operational risk level."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the obligation — enables accountability tracking and workload distribution analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the obligation is on the critical compliance path — highest-priority obligations for executive monitoring."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Indicates whether escalation has been flagged for this obligation — used to identify obligations requiring senior intervention."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of obligation due date — supports workload forecasting and deadline management."
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Recurrence pattern of the obligation (e.g., Monthly, Quarterly, Annual) — used to forecast recurring compliance workload."
  measures:
    - name: "total_obligations"
      expr: COUNT(obligation_id)
      comment: "Total number of compliance obligations. Baseline KPI for compliance program scope and workload management."
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND obligation_status NOT IN ('Completed', 'Closed') THEN obligation_id END)
      comment: "Number of obligations past their due date without completion. Critical risk KPI — overdue obligations directly expose the utility to enforcement action."
    - name: "obligation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status IN ('Completed', 'Closed') THEN obligation_id END) / NULLIF(COUNT(obligation_id), 0), 2)
      comment: "Percentage of obligations completed or closed. Primary KPI for compliance program effectiveness — tracked on executive compliance dashboards."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill compliance obligations. Core financial KPI for compliance program cost management and budget variance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of compliance obligations. Used for budget forecasting and cost-of-compliance planning."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across obligations. Measures budget accuracy and cost overrun exposure in the compliance program."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours expended on compliance obligations. Measures true labor cost of compliance and informs workforce planning."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total effort variance (actual minus estimated hours) across obligations. Identifies systematic underestimation of compliance workload — drives capacity planning improvements."
    - name: "critical_path_overdue_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND due_date < CURRENT_DATE AND obligation_status NOT IN ('Completed', 'Closed') THEN obligation_id END)
      comment: "Number of critical-path obligations that are overdue. Highest-priority compliance risk KPI — any non-zero value requires immediate executive escalation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_permit_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for permit conditions — tracking compliance status, numeric limit adherence, monitoring requirements, and condition complexity. Used by compliance engineers and managers to ensure permit conditions are met and to identify conditions at risk of violation."
  source: "`vibe_water_utilities_v1`.`compliance`.`permit_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of permit condition (e.g., Effluent Limit, Monitoring, Reporting) — primary dimension for condition portfolio analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the permit condition (e.g., Active, Expired, Waived) — used to track active compliance requirements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the permit condition — primary risk indicator for condition-level compliance monitoring."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of numeric limit (e.g., Daily Maximum, Monthly Average) — used to segment conditions by limit stringency."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for the condition — used to plan sampling and analytical workload."
    - name: "seasonal_variation_flag"
      expr: seasonal_variation_flag
      comment: "Indicates whether the condition has seasonal variation — used to identify conditions requiring seasonal compliance management."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Indicates whether public notification is required for this condition — tracks transparency obligations."
    - name: "enforcement_priority"
      expr: enforcement_priority
      comment: "Enforcement priority level assigned to the condition — used to focus compliance monitoring resources."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of condition effective date — supports trend analysis of new condition requirements over time."
  measures:
    - name: "total_permit_conditions"
      expr: COUNT(permit_condition_id)
      comment: "Total number of active permit conditions. Baseline KPI for compliance obligation scope and monitoring workload."
    - name: "noncompliant_conditions"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'In Compliance', 'Met') THEN permit_condition_id END)
      comment: "Number of permit conditions not in compliance. Direct measure of permit-level regulatory exposure — each noncompliant condition is a potential violation."
    - name: "condition_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status IN ('Compliant', 'In Compliance', 'Met') THEN permit_condition_id END) / NULLIF(COUNT(permit_condition_id), 0), 2)
      comment: "Percentage of permit conditions currently in compliance. Strategic KPI for permit-level compliance performance — tracked on regulatory standing dashboards."
    - name: "avg_numeric_limit"
      expr: AVG(CAST(numeric_limit AS DOUBLE))
      comment: "Average numeric limit value across permit conditions. Used to benchmark limit stringency and assess overall regulatory burden."
    - name: "avg_violation_threshold"
      expr: AVG(CAST(violation_threshold AS DOUBLE))
      comment: "Average violation threshold across permit conditions. Paired with numeric_limit to assess headroom between operational performance and violation triggers."
    - name: "conditions_with_seasonal_variation"
      expr: COUNT(CASE WHEN seasonal_variation_flag = TRUE THEN permit_condition_id END)
      comment: "Number of permit conditions with seasonal variation requirements. Measures complexity of seasonal compliance management obligations."
    - name: "conditions_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN permit_condition_id END)
      comment: "Number of permit conditions expiring within 90 days. Proactive risk KPI — expiring conditions require renewal or renegotiation to avoid compliance gaps."
$$;