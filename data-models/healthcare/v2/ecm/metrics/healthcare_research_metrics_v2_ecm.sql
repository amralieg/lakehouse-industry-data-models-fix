-- Metric views for domain: research | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for clinical research studies covering enrollment performance, study status mix, and regulatory profile. Used by research leadership to steer the trial portfolio."
  source: "`vibe_healthcare_v1`.`research`.`research_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Lifecycle status of the study (e.g., active, completed, suspended) for portfolio pipeline analysis."
    - name: "study_type"
      expr: study_type
      comment: "Type of study (interventional, observational) used to segment the research portfolio."
    - name: "study_phase"
      expr: phase
      comment: "Clinical trial phase used to assess portfolio maturity and risk mix."
    - name: "sponsor_type"
      expr: sponsor_type
      comment: "Sponsor classification (industry, federal, investigator-initiated) for funding mix analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source category to evaluate revenue and grant dependency."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding design used to assess study rigor distribution."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Calendar year the study started, for trend analysis of new study activations."
  measures:
    - name: "Study Count"
      expr: COUNT(1)
      comment: "Total number of research studies for portfolio sizing."
    - name: "Distinct Studies"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies, used to validate counts across grouped reporting."
    - name: "Total Target Enrollment"
      expr: SUM(CAST(target_enrollment AS DOUBLE))
      comment: "Sum of planned enrollment targets across studies for capacity planning."
    - name: "Total Actual Enrollment"
      expr: SUM(CAST(actual_enrollment AS DOUBLE))
      comment: "Sum of actual enrollment achieved, the core throughput metric for the portfolio."
    - name: "Enrollment Attainment Pct"
      expr: ROUND(100.0 * SUM(CAST(actual_enrollment AS DOUBLE)) / NULLIF(SUM(CAST(target_enrollment AS DOUBLE)),0),2)
      comment: "Actual vs target enrollment percentage — a primary indicator of trial recruitment performance leadership tracks closely."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject-level enrollment and safety KPIs measuring recruitment funnel, withdrawals, and adverse-event burden across studies."
  source: "`vibe_healthcare_v1`.`research`.`subject_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (screening, enrolled, withdrawn, completed) for funnel analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "How the subject was recruited, used to evaluate recruitment channel effectiveness."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for recruitment trend analysis."
  measures:
    - name: "Subject Count"
      expr: COUNT(1)
      comment: "Total subject enrollment records, the base recruitment volume."
    - name: "Distinct Subjects"
      expr: COUNT(DISTINCT subject_enrollment_id)
      comment: "Distinct enrolled subjects for accurate de-duplicated counts."
    - name: "Eligibility Confirmed Count"
      expr: SUM(CASE WHEN eligibility_confirmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of subjects with confirmed eligibility, used to measure screening conversion."
    - name: "Withdrawal Count"
      expr: SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of withdrawn subjects — a retention/attrition risk signal for trial integrity."
    - name: "Withdrawal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of subjects withdrawn — key retention KPI that triggers intervention when high."
    - name: "Serious Adverse Event Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN serious_adverse_event_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of subjects with a serious adverse event — a critical safety steering metric."
    - name: "Protocol Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of subjects with protocol deviations — a compliance quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety surveillance KPIs for research adverse events, tracking seriousness, expedited reporting compliance, and outcome resolution."
  source: "`vibe_healthcare_v1`.`research`.`adverse_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse event for safety categorization."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the adverse event (open, resolved) for follow-up tracking."
    - name: "severity_grade"
      expr: severity_grade
      comment: "Severity grade of the event for risk stratification."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Causality relationship to investigational product for safety signal analysis."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the event for resolution monitoring."
    - name: "report_year"
      expr: YEAR(report_date)
      comment: "Year the event was reported for safety trend analysis."
  measures:
    - name: "Event Count"
      expr: COUNT(1)
      comment: "Total adverse events reported, the base safety volume."
    - name: "Serious Event Count"
      expr: SUM(CASE WHEN seriousness_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of serious adverse events — primary patient-safety steering metric."
    - name: "Serious Event Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN seriousness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of events classified as serious — drives DSMB and safety committee attention."
    - name: "Expedited Reporting Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expedited_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of events requiring expedited regulatory reporting — compliance workload indicator."
    - name: "IRB Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN irb_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of events that are IRB-reportable — regulatory compliance monitoring metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site performance KPIs comparing enrollment productivity, data quality, and protocol compliance across participating study sites."
  source: "`vibe_healthcare_v1`.`research`.`study_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site for activation/closure tracking."
    - name: "site_risk_rating"
      expr: site_risk_rating
      comment: "Risk rating used to prioritize monitoring effort across sites."
    - name: "regulatory_binder_status"
      expr: regulatory_binder_status
      comment: "Regulatory documentation completeness status for compliance oversight."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of site activation for site rollout trend analysis."
  measures:
    - name: "Site Count"
      expr: COUNT(1)
      comment: "Total study sites for portfolio breadth assessment."
    - name: "Total Actual Enrollment"
      expr: SUM(CAST(actual_enrollment_count AS DOUBLE))
      comment: "Sum of actual enrollment across sites — the core site productivity output."
    - name: "Avg Enrollment Rate Per Month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average monthly enrollment rate across sites — recruitment velocity KPI for site selection decisions."
    - name: "Avg Site Performance Score"
      expr: AVG(CAST(site_performance_score AS DOUBLE))
      comment: "Average composite performance score — used to rank and remediate underperforming sites."
    - name: "Total Open Data Queries"
      expr: SUM(CAST(open_data_query_count AS DOUBLE))
      comment: "Sum of open data queries — a data-quality and timeliness indicator across sites."
    - name: "Total Serious Adverse Events"
      expr: SUM(CAST(serious_adverse_event_count AS DOUBLE))
      comment: "Sum of serious adverse events by site — site-level safety signal."
    - name: "Total Protocol Deviations"
      expr: SUM(CAST(protocol_deviation_count AS DOUBLE))
      comment: "Sum of protocol deviations by site — site compliance quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for clinical trial budgets covering total budget, per-patient economics, overhead recovery, and approval status mix."
  source: "`vibe_healthcare_v1`.`research`.`study_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval/lifecycle status of the budget for negotiation pipeline tracking."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (sponsor, institutional) for financial segmentation."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure used to assess cash-flow timing."
    - name: "approval_year"
      expr: YEAR(budget_approval_date)
      comment: "Year of budget approval for financial trend analysis."
  measures:
    - name: "Budget Count"
      expr: COUNT(1)
      comment: "Number of study budgets under management."
    - name: "Total Budget Amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Aggregate negotiated budget value — core research revenue/funding metric."
    - name: "Avg Per Patient Budget"
      expr: AVG(CAST(per_patient_budget_amount AS DOUBLE))
      comment: "Average per-patient budget — key trial economics metric for site/sponsor negotiation."
    - name: "Total Overhead Amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total indirect/overhead recovery — institutional revenue indicator."
    - name: "Avg Overhead Rate Pct"
      expr: AVG(CAST(overhead_rate_percentage AS DOUBLE))
      comment: "Average overhead rate negotiated — informs indirect cost recovery strategy."
    - name: "Total Research Only Cost"
      expr: SUM(CAST(research_only_cost_amount AS DOUBLE))
      comment: "Total research-only (non-standard-of-care) cost — drives coverage analysis and billing compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant funding portfolio KPIs covering award value, direct vs indirect cost mix, and human/animal subject involvement for research finance leadership."
  source: "`vibe_healthcare_v1`.`research`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Lifecycle status of the grant for funding pipeline tracking."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant for portfolio segmentation."
    - name: "sponsor_name"
      expr: sponsor_name
      comment: "Funding sponsor for concentration/dependency analysis."
    - name: "award_year"
      expr: YEAR(award_notice_date)
      comment: "Year of award notice for funding trend analysis."
  measures:
    - name: "Grant Count"
      expr: COUNT(1)
      comment: "Number of grants in the research funding portfolio."
    - name: "Total Award Amount"
      expr: SUM(CAST(award_amount_total AS DOUBLE))
      comment: "Total grant award value — primary external funding metric for research finance."
    - name: "Total Direct Cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Aggregate direct cost funding for budget planning."
    - name: "Total Indirect Cost"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Aggregate indirect cost recovery — institutional sustainability indicator."
    - name: "Avg Indirect Cost Rate Pct"
      expr: AVG(CAST(indirect_cost_rate_pct AS DOUBLE))
      comment: "Average negotiated indirect cost rate — informs F&A recovery strategy."
    - name: "Total Cost Share"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total committed cost share — institutional financial obligation metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant spend KPIs tracking expenditure burn, allowability/allocability compliance, and cost-share execution against awards."
  source: "`vibe_healthcare_v1`.`research`.`grant_expenditure`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Category of expenditure for spend composition analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expenditure for financial control."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure for budget-period tracking."
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Calendar year of the transaction for spend trend analysis."
  measures:
    - name: "Expenditure Count"
      expr: COUNT(1)
      comment: "Number of grant expenditure transactions."
    - name: "Total Expenditure Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total grant spend — core burn-rate metric for award management."
    - name: "Total Cost Share Spent"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share expended — tracks institutional commitment fulfillment."
    - name: "Allowable Spend Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allowable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of expenditures flagged allowable — audit risk and compliance indicator."
    - name: "Audit Flagged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of expenditures flagged for audit — financial compliance risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol compliance KPIs measuring deviation volume, severity, and regulatory reportability to steer GCP quality and site remediation."
  source: "`vibe_healthcare_v1`.`research`.`protocol_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of deviation for root-cause grouping."
    - name: "deviation_severity"
      expr: deviation_severity
      comment: "Severity of the deviation for risk prioritization."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Resolution status of the deviation for follow-up tracking."
    - name: "deviation_year"
      expr: YEAR(deviation_date)
      comment: "Year of the deviation for compliance trend analysis."
  measures:
    - name: "Deviation Count"
      expr: COUNT(1)
      comment: "Total protocol deviations, base compliance quality volume."
    - name: "FDA Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fda_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deviations reportable to FDA — regulatory exposure metric."
    - name: "IRB Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN irb_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deviations reportable to IRB — oversight compliance metric."
    - name: "Audit Finding Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of deviations tied to audit findings — quality program effectiveness indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical monitoring KPIs covering source-data verification, finding burden, and CAPA generation across site monitoring visits."
  source: "`vibe_healthcare_v1`.`research`.`monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit for monitoring strategy analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the monitoring visit for completion tracking."
    - name: "monitor_type"
      expr: monitor_type
      comment: "Monitor type (CRO, sponsor) for resource attribution."
    - name: "visit_year"
      expr: YEAR(visit_date)
      comment: "Year of the monitoring visit for monitoring activity trend analysis."
  measures:
    - name: "Visit Count"
      expr: COUNT(1)
      comment: "Total monitoring visits conducted, base oversight activity."
    - name: "Avg SDV Percentage"
      expr: AVG(CAST(sdv_percentage AS DOUBLE))
      comment: "Average source-data-verification coverage — data integrity assurance KPI."
    - name: "Total Major Findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Sum of major findings across visits — high-severity quality signal."
    - name: "Total Minor Findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Sum of minor findings across visits — overall quality burden indicator."
    - name: "CAPA Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of visits requiring a corrective action plan — remediation workload and quality risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol visit execution KPIs measuring visit compliance, missed assessments, and within-window adherence for trial conduct quality."
  source: "`vibe_healthcare_v1`.`research`.`study_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the study visit for execution tracking."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of study visit for protocol schedule analysis."
    - name: "visit_window_status"
      expr: visit_window_status
      comment: "Whether the visit occurred within the protocol window — adherence indicator."
    - name: "actual_visit_year"
      expr: YEAR(actual_date)
      comment: "Year the visit actually occurred for activity trend analysis."
  measures:
    - name: "Visit Count"
      expr: COUNT(1)
      comment: "Total scheduled study visits, base trial activity volume."
    - name: "Avg Compliance Percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average protocol compliance percentage per visit — core conduct quality KPI."
    - name: "Total Assessments Completed"
      expr: SUM(CAST(assessments_completed_count AS DOUBLE))
      comment: "Sum of assessments completed — protocol execution throughput."
    - name: "Total Assessments Missed"
      expr: SUM(CAST(assessments_missed_count AS DOUBLE))
      comment: "Sum of missed assessments — data-completeness risk signal."
    - name: "Protocol Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of visits with a protocol deviation — visit-level compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_ip_dispensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational product dispensation KPIs tracking quantity dispensed/returned, accountability compliance, and missed dosing for IP management oversight."
  source: "`vibe_healthcare_v1`.`research`.`ip_dispensation`"
  dimensions:
    - name: "accountability_status"
      expr: accountability_status
      comment: "IP accountability reconciliation status for compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Dispensation compliance status for adherence monitoring."
    - name: "dispensed_by_role"
      expr: dispensed_by_role
      comment: "Role of the person dispensing IP for process attribution."
    - name: "dispensation_year"
      expr: YEAR(dispensation_date)
      comment: "Year of dispensation for IP activity trend analysis."
  measures:
    - name: "Dispensation Count"
      expr: COUNT(1)
      comment: "Total IP dispensation events, base IP activity volume."
    - name: "Total Quantity Dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total investigational product quantity dispensed — supply utilization metric."
    - name: "Total Quantity Returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total IP quantity returned — accountability reconciliation input."
    - name: "Total Missed Doses"
      expr: SUM(CAST(missed_doses AS DOUBLE))
      comment: "Sum of missed doses — subject adherence and trial integrity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_irb_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRB/regulatory submission KPIs tracking submission volume, determination outcomes, and action-required burden for regulatory affairs oversight."
  source: "`vibe_healthcare_v1`.`research`.`irb_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of IRB submission for regulatory workload analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission for pipeline tracking."
    - name: "review_type"
      expr: review_type
      comment: "IRB review type (expedited, full board) for resource planning."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the study for review prioritization."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of submission for regulatory activity trend analysis."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total IRB submissions, base regulatory workload volume."
    - name: "Distinct Studies Submitted"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies with submissions — portfolio regulatory coverage."
    - name: "Action Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of submissions requiring follow-up action — regulatory burden indicator."
    - name: "Vulnerable Population Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vulnerable_population_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of submissions involving vulnerable populations — added oversight risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_informed_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Informed consent KPIs measuring consent completion, interpreter usage, and copy-provision compliance for human subjects protection oversight."
  source: "`vibe_healthcare_v1`.`research`.`informed_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Status of the consent for completion tracking."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent for protocol categorization."
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent (paper, electronic) for process analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of consent for equity and interpreter-need analysis."
    - name: "consent_year"
      expr: YEAR(consent_date)
      comment: "Year consent was obtained for trend analysis."
  measures:
    - name: "Consent Count"
      expr: COUNT(1)
      comment: "Total informed consents recorded, base subject protection volume."
    - name: "Interpreter Used Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_used_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of consents using an interpreter — language access compliance indicator."
    - name: "Consent Copy Provided Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_copy_provided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Percent of subjects given a consent copy — regulatory compliance KPI."
    - name: "Withdrawal Count"
      expr: SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of consent withdrawals — retention and ethics signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_billing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance metrics for research‑related billing activities"
  source: "`vibe_healthcare_v1`.`research`.`billing_event`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing event (e.g., Submitted, Approved)"
  measures:
    - name: "billing_event_count"
      expr: COUNT(1)
      comment: "Total number of billing events captured"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Aggregate charge amount across all billing events"
    - name: "average_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per billing event"
    - name: "compliant_billing_events"
      expr: SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of billing events flagged as compliance‑checked"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_deidentified_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data governance metrics for de‑identified research datasets"
  source: "`vibe_healthcare_v1`.`research`.`deidentified_dataset`"
  dimensions:
    - name: "dataset_type"
      expr: dataset_type
      comment: "Logical classification of the dataset (e.g., Clinical, Genomic)"
  measures:
    - name: "dataset_count"
      expr: COUNT(1)
      comment: "Total number of de‑identified datasets created"
    - name: "total_dataset_size_mb"
      expr: SUM(CAST(dataset_size_mb AS DOUBLE))
      comment: "Cumulative size of all datasets in megabytes"
    - name: "average_dataset_size_mb"
      expr: AVG(CAST(dataset_size_mb AS DOUBLE))
      comment: "Average size per dataset"
    - name: "cfr_part_11_compliant_datasets"
      expr: SUM(CASE WHEN cfr_part_11_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of datasets that are CFR Part 11 compliant"
$$;