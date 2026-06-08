-- Metric views for domain: monitoring | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for monitoring visits — tracks visit execution quality, SDV coverage, findings burden, and report timeliness across studies and sites. Used by Clinical Operations leadership to assess site oversight effectiveness and CRA performance."
  source: "`clinical_trials_ecm`.`monitoring`.`monitoring_visit`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables slicing all visit KPIs by individual clinical study."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level benchmarking of monitoring quality."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit (e.g., Site Initiation, Interim, Close-Out) — drives frequency and intensity analysis."
    - name: "visit_mode"
      expr: visit_mode
      comment: "Delivery mode of the visit (On-site vs. Remote) — supports hybrid monitoring strategy evaluation."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (Planned, Completed, Cancelled) — used to filter active vs. historical visits."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk tier assigned to the visit — enables risk-stratified monitoring analysis."
    - name: "report_status"
      expr: report_status
      comment: "Status of the visit report (Draft, Submitted, Approved) — tracks reporting compliance."
    - name: "actual_start_date_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual visit start — supports trend analysis of visit activity over time."
    - name: "scheduled_start_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled visit start — used to compare planned vs. actual visit cadence."
  measures:
    - name: "total_completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN monitoring_visit_id END)
      comment: "Total number of completed monitoring visits — baseline KPI for site oversight activity volume."
    - name: "avg_sdv_percentage"
      expr: AVG(CAST(sdv_percentage AS DOUBLE))
      comment: "Average Source Data Verification (SDV) coverage percentage across visits — measures data integrity oversight intensity. Low values may indicate under-monitoring risk."
    - name: "avg_visit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of monitoring visits in days — informs resource planning and CRA workload estimation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score assigned at visit level — tracks whether high-risk sites are receiving appropriately intensive monitoring."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total critical findings identified across all monitoring visits — a leading indicator of site compliance risk and potential regulatory exposure."
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total major findings across visits — used alongside critical findings to assess overall site quality burden."
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total minor findings across visits — provides a complete picture of the findings severity distribution."
    - name: "total_queries_opened"
      expr: SUM(CAST(queries_opened AS BIGINT))
      comment: "Total data queries opened during monitoring visits — reflects data quality issues identified at source."
    - name: "total_queries_closed"
      expr: SUM(CAST(queries_closed AS BIGINT))
      comment: "Total data queries closed during monitoring visits — measures resolution throughput and site responsiveness."
    - name: "visits_with_overdue_report"
      expr: COUNT(CASE WHEN report_status NOT IN ('Submitted','Approved') AND report_due_date < CURRENT_DATE() THEN monitoring_visit_id END)
      comment: "Number of visits where the monitoring report is overdue — a GCP compliance KPI; high values signal reporting discipline issues."
    - name: "visits_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN monitoring_visit_id END)
      comment: "Number of visits that triggered a CAPA requirement — indicates the volume of serious quality events requiring corrective action."
    - name: "remote_visit_count"
      expr: COUNT(CASE WHEN visit_mode = 'Remote' THEN monitoring_visit_id END)
      comment: "Count of remote monitoring visits — supports evaluation of the remote vs. on-site monitoring strategy mix."
    - name: "on_site_visit_count"
      expr: COUNT(CASE WHEN visit_mode = 'On-site' THEN monitoring_visit_id END)
      comment: "Count of on-site monitoring visits — used with remote_visit_count to compute the hybrid monitoring ratio in BI."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_central_monitoring_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for centralized statistical monitoring alerts — tracks KRI breach rates, alert severity distribution, escalation patterns, and sponsor notification timeliness. Used by Risk-Based Monitoring (RBM) teams and Clinical Operations leadership to govern data-driven site oversight."
  source: "`clinical_trials_ecm`.`monitoring`.`central_monitoring_alert`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level alert burden analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level KRI breach profiling."
    - name: "alert_category"
      expr: alert_category
      comment: "Category of the central monitoring alert (e.g., Data Quality, Safety, Enrollment) — supports thematic risk analysis."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert (e.g., Critical, Major, Minor) — drives prioritization of monitoring response."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (Open, Under Review, Closed) — tracks resolution pipeline."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of alert trigger (e.g., KRI Threshold Breach, Statistical Outlier) — informs RBM strategy refinement."
    - name: "kri_code"
      expr: kri_code
      comment: "Key Risk Indicator code — enables KRI-level performance benchmarking across sites and studies."
    - name: "kri_name"
      expr: kri_name
      comment: "Human-readable KRI name — used in dashboards and steering reports."
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold breached (Amber/Red/Absolute) — contextualizes alert severity."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('MONTH', alert_generated_timestamp)
      comment: "Month the alert was generated — supports trend analysis of KRI breach frequency over time."
    - name: "is_repeat_alert"
      expr: is_repeat_alert
      comment: "Flag indicating whether this is a recurring alert for the same KRI/site — identifies persistent risk patterns."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether escalation was required — used to segment high-severity alert cohorts."
  measures:
    - name: "total_open_alerts"
      expr: COUNT(CASE WHEN alert_status = 'Open' THEN central_monitoring_alert_id END)
      comment: "Total number of open central monitoring alerts — primary RBM workload KPI; high values indicate unresolved site risk."
    - name: "total_critical_alerts"
      expr: COUNT(CASE WHEN alert_severity = 'Critical' THEN central_monitoring_alert_id END)
      comment: "Total critical-severity alerts — a leading indicator of patient safety and data integrity risk requiring immediate action."
    - name: "repeat_alert_count"
      expr: COUNT(CASE WHEN is_repeat_alert = TRUE THEN central_monitoring_alert_id END)
      comment: "Number of repeat alerts for the same KRI/site — signals persistent non-compliance or ineffective corrective actions."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN central_monitoring_alert_id END)
      comment: "Number of alerts requiring escalation — measures the volume of high-severity issues needing senior management attention."
    - name: "capa_triggered_alert_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN central_monitoring_alert_id END)
      comment: "Number of alerts that triggered a CAPA — links centralized monitoring findings to formal quality management actions."
    - name: "sponsor_notified_alert_count"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN central_monitoring_alert_id END)
      comment: "Number of alerts for which the sponsor was notified — measures regulatory and contractual notification compliance."
    - name: "avg_observed_value"
      expr: AVG(CAST(observed_value AS DOUBLE))
      comment: "Average observed KRI value at time of alert — provides a quantitative baseline for KRI performance benchmarking."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value configured for triggered alerts — used alongside avg_observed_value to assess breach magnitude in BI."
    - name: "distinct_sites_with_alerts"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites with at least one central monitoring alert — measures breadth of risk exposure across the site network."
    - name: "distinct_kris_breached"
      expr: COUNT(DISTINCT kri_code)
      comment: "Number of distinct KRIs breached — indicates the diversity of risk signals and whether issues are systemic or isolated."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_risk_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for site and study risk indicators — tracks KRI computed values, threshold breach rates, trend directions, and risk score contributions. Used by Risk Management and Clinical Operations to govern risk-based monitoring intensity decisions."
  source: "`clinical_trials_ecm`.`monitoring`.`risk_indicator`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level risk profile analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level KRI performance benchmarking."
    - name: "indicator_name"
      expr: indicator_name
      comment: "Name of the risk indicator — used as the primary grouping dimension for KRI performance dashboards."
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of risk indicator (e.g., Data Quality, Safety, Enrollment) — supports thematic risk categorization."
    - name: "risk_indicator_category"
      expr: risk_indicator_category
      comment: "Category of the risk indicator — enables portfolio-level risk theme analysis."
    - name: "alert_status"
      expr: alert_status
      comment: "Current alert status of the indicator (Green/Amber/Red) — the primary traffic-light KRI status dimension."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Operational status of the indicator (Active/Inactive/Suspended) — filters to active monitoring KRIs."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of the KRI trend (Improving/Stable/Worsening) — a leading indicator for proactive risk intervention."
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of threshold breach logic (Above/Below) — contextualizes whether high or low values represent risk."
    - name: "is_centralized_monitoring"
      expr: is_centralized_monitoring
      comment: "Flag indicating whether this KRI is part of the centralized monitoring program — segments central vs. on-site risk indicators."
    - name: "computation_date_month"
      expr: DATE_TRUNC('MONTH', computation_date)
      comment: "Month of KRI computation — supports longitudinal trend analysis of risk indicator values."
  measures:
    - name: "red_alert_indicator_count"
      expr: COUNT(CASE WHEN alert_status = 'Red' THEN risk_indicator_id END)
      comment: "Number of risk indicators currently in Red (critical breach) status — the primary risk escalation KPI for site oversight."
    - name: "amber_alert_indicator_count"
      expr: COUNT(CASE WHEN alert_status = 'Amber' THEN risk_indicator_id END)
      comment: "Number of risk indicators in Amber (warning) status — identifies sites approaching critical thresholds before they breach."
    - name: "avg_computed_value"
      expr: AVG(CAST(computed_value AS DOUBLE))
      comment: "Average computed KRI value across indicators — provides a portfolio-level view of risk metric performance."
    - name: "avg_risk_score_contribution"
      expr: AVG(CAST(risk_score_contribution AS DOUBLE))
      comment: "Average risk score contribution per indicator — identifies which KRI categories drive the highest composite site risk scores."
    - name: "total_risk_score_contribution"
      expr: SUM(CAST(risk_score_contribution AS DOUBLE))
      comment: "Total risk score contribution across all indicators — used to compute composite site risk scores in BI."
    - name: "worsening_trend_count"
      expr: COUNT(CASE WHEN trend_direction = 'Worsening' THEN risk_indicator_id END)
      comment: "Number of indicators with a worsening trend — a leading indicator for proactive monitoring intensity escalation."
    - name: "capa_required_indicator_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN risk_indicator_id END)
      comment: "Number of risk indicators that have triggered a CAPA requirement — links KRI breaches to formal quality management actions."
    - name: "distinct_sites_with_red_kri"
      expr: COUNT(DISTINCT CASE WHEN alert_status = 'Red' THEN study_site_id END)
      comment: "Number of distinct sites with at least one Red KRI — measures breadth of critical risk exposure across the site network."
    - name: "avg_amber_threshold"
      expr: AVG(CAST(amber_threshold AS DOUBLE))
      comment: "Average Amber threshold value across active risk indicators — used to benchmark threshold calibration across studies."
    - name: "avg_red_threshold"
      expr: AVG(CAST(red_threshold AS DOUBLE))
      comment: "Average Red threshold value across active risk indicators — used alongside avg_amber_threshold for threshold calibration analysis."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_site_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for site risk assessments — tracks overall risk scores, KRI breach counts, enrollment and data quality performance, and recommended monitoring intensity. Used by Clinical Operations and Quality leadership to govern risk-stratified site oversight and resource allocation."
  source: "`clinical_trials_ecm`.`monitoring`.`site_risk_assessment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level site risk portfolio analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — the primary entity for risk assessment KPIs."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Current risk tier of the site (High/Medium/Low) — the primary stratification dimension for monitoring intensity decisions."
    - name: "previous_risk_tier"
      expr: previous_risk_tier
      comment: "Prior risk tier — used with current risk_tier to identify sites that have escalated or de-escalated in risk."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (Initial, Periodic, Triggered) — contextualizes the assessment cadence."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (Draft, Approved, Superseded) — filters to current approved assessments."
    - name: "recommended_monitoring_intensity"
      expr: recommended_monitoring_intensity
      comment: "Recommended monitoring intensity level (Enhanced/Standard/Reduced) — the primary output dimension for resource allocation decisions."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating whether a CAPA was required at assessment — segments high-risk assessment cohorts."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — supports trend analysis of site risk profile evolution over time."
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average composite site risk score — the headline KPI for site risk portfolio health; drives monitoring intensity and resource allocation decisions."
    - name: "high_risk_site_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'High' THEN study_site_id END)
      comment: "Number of distinct sites classified as High risk — directly drives enhanced monitoring resource requirements."
    - name: "avg_kri_breaches_count"
      expr: AVG(CAST(kri_breaches_count AS DOUBLE))
      comment: "Average number of KRI breaches per site assessment — measures the typical KRI burden across the site network."
    - name: "avg_critical_kri_breaches_count"
      expr: AVG(CAST(critical_kri_breaches_count AS DOUBLE))
      comment: "Average number of critical KRI breaches per site — identifies sites with the most severe risk signal concentration."
    - name: "avg_enrollment_rate_percent"
      expr: AVG(CAST(enrollment_rate_percent AS DOUBLE))
      comment: "Average enrollment rate percentage across assessed sites — links site risk profile to enrollment performance for portfolio planning."
    - name: "avg_query_rate_percent"
      expr: AVG(CAST(query_rate_percent AS DOUBLE))
      comment: "Average data query rate percentage — measures data quality burden across the site network; high values indicate data entry issues."
    - name: "avg_sdv_completion_percent"
      expr: AVG(CAST(sdv_completion_percent AS DOUBLE))
      comment: "Average SDV completion percentage across sites — measures source data verification coverage relative to plan."
    - name: "avg_ae_reporting_timeliness_percent"
      expr: AVG(CAST(ae_reporting_timeliness_percent AS DOUBLE))
      comment: "Average AE reporting timeliness percentage — a patient safety KPI; low values indicate regulatory reporting compliance risk."
    - name: "avg_subject_dropout_rate_percent"
      expr: AVG(CAST(subject_dropout_rate_percent AS DOUBLE))
      comment: "Average subject dropout rate percentage — a study integrity KPI; high dropout rates threaten statistical power and data completeness."
    - name: "avg_screen_failure_rate_percent"
      expr: AVG(CAST(screen_failure_rate_percent AS DOUBLE))
      comment: "Average screen failure rate percentage — measures site eligibility assessment quality; high rates increase recruitment costs."
    - name: "risk_escalated_site_count"
      expr: COUNT(CASE WHEN risk_tier = 'High' AND previous_risk_tier IN ('Medium','Low') THEN site_risk_assessment_id END)
      comment: "Number of sites that escalated to High risk from a lower tier — identifies deteriorating sites requiring immediate monitoring intervention."
    - name: "capa_required_assessment_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN site_risk_assessment_id END)
      comment: "Number of site risk assessments that triggered a CAPA — measures the volume of assessments identifying serious quality gaps."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_sdv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Source Data Verification (SDV) records — tracks SDV coverage, discrepancy rates, resolution timeliness, and critical data point verification. Used by Data Management and Clinical Operations to govern data integrity and GCP compliance."
  source: "`clinical_trials_ecm`.`monitoring`.`sdv_record`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level SDV performance analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level SDV coverage and discrepancy benchmarking."
    - name: "sdv_type"
      expr: sdv_type
      comment: "Type of SDV performed (Full, Targeted, Risk-Based) — supports SDV strategy effectiveness analysis."
    - name: "sdv_method"
      expr: sdv_method
      comment: "Method used for SDV (On-site, Remote, Hybrid) — enables remote vs. on-site SDV quality comparison."
    - name: "sdv_outcome"
      expr: sdv_outcome
      comment: "Outcome of the SDV activity (Verified, Discrepancy Found, Not Verifiable) — the primary quality outcome dimension."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of discrepancy resolution (Open, Resolved, Waived) — tracks the discrepancy resolution pipeline."
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Category of discrepancy identified (Transcription Error, Missing Data, etc.) — supports root cause analysis."
    - name: "is_critical_data_point"
      expr: is_critical_data_point
      comment: "Flag indicating whether the verified field is a critical data point — enables critical vs. non-critical SDV performance segmentation."
    - name: "is_sdv_waived"
      expr: is_sdv_waived
      comment: "Flag indicating whether SDV was waived for this record — tracks risk-based SDV waiver utilization."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document reviewed (Medical Record, Lab Report, etc.) — supports document-type-level discrepancy analysis."
    - name: "sdv_performed_month"
      expr: DATE_TRUNC('MONTH', sdv_performed_timestamp)
      comment: "Month SDV was performed — supports trend analysis of SDV throughput and discrepancy rates over time."
  measures:
    - name: "total_sdv_records"
      expr: COUNT(sdv_record_id)
      comment: "Total number of SDV records — baseline measure of SDV activity volume across the program."
    - name: "discrepancy_found_count"
      expr: COUNT(CASE WHEN sdv_outcome = 'Discrepancy Found' THEN sdv_record_id END)
      comment: "Number of SDV records where a discrepancy was found — the primary data quality KPI; high values indicate systemic data entry issues."
    - name: "critical_data_discrepancy_count"
      expr: COUNT(CASE WHEN is_critical_data_point = TRUE AND sdv_outcome = 'Discrepancy Found' THEN sdv_record_id END)
      comment: "Number of discrepancies found on critical data points — a patient safety and regulatory risk KPI; any critical discrepancy requires immediate action."
    - name: "open_discrepancy_count"
      expr: COUNT(CASE WHEN resolution_status = 'Open' THEN sdv_record_id END)
      comment: "Number of unresolved SDV discrepancies — measures the outstanding data quality remediation backlog."
    - name: "avg_sdv_coverage_percentage"
      expr: AVG(CAST(sdv_coverage_percentage AS DOUBLE))
      comment: "Average SDV coverage percentage per record — measures how much of the target data scope has been verified; compared against plan thresholds."
    - name: "avg_rbm_risk_score"
      expr: AVG(CAST(rbm_risk_score AS DOUBLE))
      comment: "Average Risk-Based Monitoring risk score at the SDV record level — identifies high-risk data fields and subjects driving SDV prioritization."
    - name: "regulatory_impact_record_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN sdv_record_id END)
      comment: "Number of SDV records with regulatory impact — identifies data issues that may affect regulatory submission integrity."
    - name: "sdv_waiver_count"
      expr: COUNT(CASE WHEN is_sdv_waived = TRUE THEN sdv_record_id END)
      comment: "Number of SDV records where verification was waived — monitors risk-based SDV waiver utilization to ensure it remains within acceptable limits."
    - name: "distinct_subjects_with_discrepancy"
      expr: COUNT(DISTINCT CASE WHEN sdv_outcome = 'Discrepancy Found' THEN trial_subject_id END)
      comment: "Number of distinct subjects with at least one SDV discrepancy — measures the breadth of data quality issues across the subject population."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_action_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for monitoring action items — tracks open action item backlog, overdue rates, escalation frequency, and closure timeliness. Used by Clinical Operations and Quality leadership to govern site corrective action follow-through and GCP compliance."
  source: "`clinical_trials_ecm`.`monitoring`.`monitoring_action_item`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level action item burden analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level action item performance benchmarking."
    - name: "monitoring_action_item_status"
      expr: monitoring_action_item_status
      comment: "Current status of the action item (Open, Closed, Overdue, Escalated) — the primary pipeline status dimension."
    - name: "monitoring_action_item_category"
      expr: monitoring_action_item_category
      comment: "Category of the action item (Data Quality, Safety, Regulatory, etc.) — supports thematic analysis of site compliance gaps."
    - name: "action_type"
      expr: action_type
      comment: "Type of action required (Corrective, Preventive, Informational) — distinguishes reactive from proactive quality actions."
    - name: "priority"
      expr: priority
      comment: "Priority level of the action item (Critical, High, Medium, Low) — drives triage and resource allocation."
    - name: "responsible_party_role"
      expr: responsible_party_role
      comment: "Role responsible for resolving the action item (CRA, PI, Site Coordinator) — enables accountability tracking."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flag indicating whether the action item has been escalated — segments escalated vs. routine action items."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this is a recurring action item — identifies persistent site compliance failures."
    - name: "raised_date_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month the action item was raised — supports trend analysis of action item generation rates over time."
  measures:
    - name: "total_open_action_items"
      expr: COUNT(CASE WHEN monitoring_action_item_status = 'Open' THEN monitoring_action_item_id END)
      comment: "Total open monitoring action items — the primary site compliance backlog KPI; high values indicate unresolved quality issues."
    - name: "overdue_action_item_count"
      expr: COUNT(CASE WHEN monitoring_action_item_status = 'Open' AND due_date < CURRENT_DATE() THEN monitoring_action_item_id END)
      comment: "Number of action items past their due date without closure — a GCP compliance risk KPI; overdue items may indicate site non-responsiveness."
    - name: "escalated_action_item_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN monitoring_action_item_id END)
      comment: "Number of escalated action items — measures the volume of issues requiring senior management or sponsor intervention."
    - name: "recurring_action_item_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN monitoring_action_item_id END)
      comment: "Number of recurring action items — identifies sites with persistent compliance failures where prior corrective actions were ineffective."
    - name: "subject_safety_impact_count"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN monitoring_action_item_id END)
      comment: "Number of action items with subject safety impact — the highest-priority patient safety KPI in the monitoring action item domain."
    - name: "data_integrity_impact_count"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN monitoring_action_item_id END)
      comment: "Number of action items with data integrity impact — measures the volume of issues that may affect regulatory submission data quality."
    - name: "capa_triggered_count"
      expr: COUNT(CASE WHEN capa_id IS NOT NULL THEN monitoring_action_item_id END)
      comment: "Number of action items linked to a CAPA — measures the proportion of action items serious enough to require formal corrective action plans."
    - name: "distinct_sites_with_open_items"
      expr: COUNT(DISTINCT CASE WHEN monitoring_action_item_status = 'Open' THEN study_site_id END)
      comment: "Number of distinct sites with open action items — measures the breadth of outstanding compliance issues across the site network."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for monitoring visit findings — tracks finding severity distribution, resolution rates, repeat finding patterns, and regulatory impact. Used by Quality Assurance and Clinical Operations to govern site compliance and GCP adherence."
  source: "`clinical_trials_ecm`.`monitoring`.`visit_finding`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level finding burden analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level finding profile benchmarking."
    - name: "severity"
      expr: severity
      comment: "Severity of the finding (Critical, Major, Minor) — the primary quality risk stratification dimension."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (ICF, IP Accountability, Data Quality, etc.) — supports thematic compliance gap analysis."
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Sub-category of the finding — enables granular root cause analysis of compliance patterns."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding (Open, Resolved, Closed) — tracks the finding remediation pipeline."
    - name: "repeat_finding"
      expr: repeat_finding
      comment: "Flag indicating whether this is a repeat finding — identifies persistent site compliance failures."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit during which the finding was identified — contextualizes findings by visit phase."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified — supports trend analysis of finding rates over time."
  measures:
    - name: "total_critical_findings"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN visit_finding_id END)
      comment: "Total critical findings across all monitoring visits — the primary GCP compliance risk KPI; any critical finding requires immediate escalation."
    - name: "total_major_findings"
      expr: COUNT(CASE WHEN severity = 'Major' THEN visit_finding_id END)
      comment: "Total major findings — used with critical findings to assess overall site compliance burden."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN resolution_status = 'Open' THEN visit_finding_id END)
      comment: "Number of unresolved findings — measures the outstanding compliance remediation backlog across the site network."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN repeat_finding = TRUE THEN visit_finding_id END)
      comment: "Number of repeat findings — identifies sites where prior corrective actions failed to prevent recurrence; a key quality governance KPI."
    - name: "subject_safety_impact_finding_count"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN visit_finding_id END)
      comment: "Number of findings with subject safety impact — the highest-priority patient safety KPI; drives immediate escalation and CAPA requirements."
    - name: "regulatory_impact_finding_count"
      expr: COUNT(CASE WHEN regulatory_impact = TRUE THEN visit_finding_id END)
      comment: "Number of findings with regulatory impact — identifies issues that may affect regulatory submissions or inspection readiness."
    - name: "data_integrity_impact_finding_count"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN visit_finding_id END)
      comment: "Number of findings with data integrity impact — measures the volume of issues threatening the reliability of clinical trial data."
    - name: "distinct_sites_with_critical_findings"
      expr: COUNT(DISTINCT CASE WHEN severity = 'Critical' THEN study_site_id END)
      comment: "Number of distinct sites with at least one critical finding — measures the breadth of critical compliance risk across the site network."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for monitoring visit reports — tracks report submission timeliness, SDV coverage, query resolution rates, and site overall ratings. Used by Clinical Operations management to govern CRA performance and site oversight quality."
  source: "`clinical_trials_ecm`.`monitoring`.`visit_report`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level visit report quality analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level report quality benchmarking."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit covered by the report — contextualizes report metrics by visit phase."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the visit report (Draft, Submitted, Approved) — tracks the report lifecycle pipeline."
    - name: "site_overall_rating"
      expr: site_overall_rating
      comment: "Overall site rating assigned in the report (Satisfactory, Needs Improvement, Unsatisfactory) — the primary site quality outcome dimension."
    - name: "monitoring_approach"
      expr: monitoring_approach
      comment: "Monitoring approach used (On-site, Remote, Hybrid) — enables approach-level quality comparison."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating whether a CAPA was required based on report findings — segments high-severity report cohorts."
    - name: "visit_date_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the visit — supports trend analysis of report quality and timeliness over time."
  measures:
    - name: "avg_sdv_coverage_percent"
      expr: AVG(CAST(sdv_coverage_percent AS DOUBLE))
      comment: "Average SDV coverage percentage reported across visit reports — measures source data verification intensity relative to plan."
    - name: "overdue_report_count"
      expr: COUNT(CASE WHEN report_status NOT IN ('Submitted','Approved') AND report_authored_date IS NULL THEN visit_report_id END)
      comment: "Number of visit reports not yet authored — a GCP compliance KPI; timely report submission is a regulatory requirement."
    - name: "unsatisfactory_site_rating_count"
      expr: COUNT(CASE WHEN site_overall_rating = 'Unsatisfactory' THEN visit_report_id END)
      comment: "Number of visit reports with an Unsatisfactory site rating — identifies sites requiring immediate quality intervention."
    - name: "capa_required_report_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN visit_report_id END)
      comment: "Number of visit reports that triggered a CAPA — measures the volume of visits identifying serious quality gaps requiring formal corrective action."
    - name: "total_queries_raised"
      expr: SUM(CAST(queries_raised_count AS BIGINT))
      comment: "Total data queries raised across all visit reports — measures the aggregate data quality issue volume identified during monitoring."
    - name: "total_queries_resolved"
      expr: SUM(CAST(queries_resolved_count AS BIGINT))
      comment: "Total data queries resolved across all visit reports — used with total_queries_raised to compute query resolution rate in BI."
    - name: "total_protocol_deviations_identified"
      expr: SUM(CAST(protocol_deviations_identified AS BIGINT))
      comment: "Total protocol deviations identified across visit reports — a key GCP compliance KPI linking monitoring activity to protocol adherence."
    - name: "avg_subjects_enrolled_at_visit"
      expr: AVG(CAST(subjects_enrolled_count AS DOUBLE))
      comment: "Average number of subjects enrolled at the time of visit — contextualizes monitoring intensity relative to site enrollment progress."
    - name: "distinct_sites_rated_unsatisfactory"
      expr: COUNT(DISTINCT CASE WHEN site_overall_rating = 'Unsatisfactory' THEN study_site_id END)
      comment: "Number of distinct sites that received an Unsatisfactory rating — measures the breadth of serious site quality issues across the network."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for monitoring visit scheduling — tracks schedule adherence, overdue visits, RBM-triggered scheduling, and SDV target coverage. Used by Clinical Operations to govern visit planning efficiency and risk-based monitoring responsiveness."
  source: "`clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — enables study-level schedule adherence analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level scheduling performance benchmarking."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of scheduled visit — contextualizes scheduling KPIs by visit phase."
    - name: "visit_mode"
      expr: visit_mode
      comment: "Planned delivery mode (On-site/Remote) — supports hybrid monitoring strategy planning analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule entry (Planned, Confirmed, Cancelled, Completed) — the primary scheduling pipeline dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the scheduled visit — enables risk-stratified scheduling analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flag indicating whether the scheduled visit is overdue — the primary schedule adherence risk flag."
    - name: "is_rbm_triggered"
      expr: is_rbm_triggered
      comment: "Flag indicating whether the visit was triggered by a Risk-Based Monitoring signal — measures RBM system responsiveness."
    - name: "scheduling_basis"
      expr: scheduling_basis
      comment: "Basis for scheduling the visit (Risk-Based, Protocol-Mandated, Frequency-Based) — supports monitoring strategy effectiveness analysis."
    - name: "planned_visit_date_month"
      expr: DATE_TRUNC('MONTH', planned_visit_date)
      comment: "Month of planned visit — supports forward-looking capacity planning and schedule adherence trend analysis."
  measures:
    - name: "overdue_visit_count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN monitoring_visit_schedule_id END)
      comment: "Number of overdue scheduled visits — the primary schedule adherence KPI; high values indicate monitoring gaps and potential GCP compliance risk."
    - name: "rbm_triggered_visit_count"
      expr: COUNT(CASE WHEN is_rbm_triggered = TRUE THEN monitoring_visit_schedule_id END)
      comment: "Number of visits triggered by RBM signals — measures the operational responsiveness of the risk-based monitoring system."
    - name: "cancelled_visit_count"
      expr: COUNT(CASE WHEN schedule_status = 'Cancelled' THEN monitoring_visit_schedule_id END)
      comment: "Number of cancelled scheduled visits — high cancellation rates may indicate site access issues or resource constraints."
    - name: "avg_sdv_target_percentage"
      expr: AVG(CAST(sdv_target_percentage AS DOUBLE))
      comment: "Average SDV target percentage across scheduled visits — measures the planned data verification intensity relative to risk tier."
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned visit duration in days — informs CRA capacity planning and travel budget forecasting."
    - name: "distinct_sites_with_overdue_visits"
      expr: COUNT(DISTINCT CASE WHEN is_overdue = TRUE THEN study_site_id END)
      comment: "Number of distinct sites with at least one overdue scheduled visit — measures the breadth of monitoring schedule adherence failures."
    - name: "sponsor_approved_schedule_count"
      expr: COUNT(CASE WHEN sponsor_approved = TRUE THEN monitoring_visit_schedule_id END)
      comment: "Number of visit schedules with sponsor approval — measures sponsor engagement in monitoring oversight planning."
$$;