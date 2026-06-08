-- Metric views for domain: monitoring | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core monitoring visit metrics tracking visit execution quality, findings severity, SDV coverage, and operational efficiency for clinical trial site oversight."
  source: "`clinical_trials_ecm`.`monitoring`.`monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit (e.g., SIV, IMV, COV, routine)"
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the monitoring visit (e.g., planned, completed, cancelled)"
    - name: "visit_mode"
      expr: visit_mode
      comment: "Mode of visit conduct (e.g., on-site, remote, hybrid)"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk tier assigned to the site at time of visit"
    - name: "report_status"
      expr: report_status
      comment: "Status of the visit report (e.g., draft, submitted, approved)"
    - name: "outcome"
      expr: outcome
      comment: "Overall outcome/result of the monitoring visit"
    - name: "capa_required_flag"
      expr: capa_required
      comment: "Whether a CAPA was triggered by this visit"
    - name: "visit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the visit was actually conducted"
    - name: "visit_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date))
      comment: "Quarter the visit was actually conducted"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of monitoring visits conducted"
    - name: "avg_sdv_percentage"
      expr: AVG(CAST(sdv_percentage AS DOUBLE))
      comment: "Average source data verification percentage across visits — key quality indicator for data integrity assurance"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average site risk score observed during visits — drives risk-based monitoring intensity decisions"
    - name: "avg_visit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of monitoring visits in days — operational efficiency indicator"
    - name: "visits_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of visits that triggered a CAPA — indicates systemic site quality issues"
    - name: "visits_with_pi_meeting"
      expr: COUNT(CASE WHEN pi_meeting_conducted = TRUE THEN 1 END)
      comment: "Number of visits where PI meeting was conducted — compliance with monitoring plan requirements"
    - name: "visits_with_icf_verified"
      expr: COUNT(CASE WHEN icf_compliance_verified = TRUE THEN 1 END)
      comment: "Number of visits where ICF compliance was verified — critical for subject protection oversight"
    - name: "visits_with_ip_verified"
      expr: COUNT(CASE WHEN ip_accountability_verified = TRUE THEN 1 END)
      comment: "Number of visits where IP accountability was verified — regulatory compliance indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_central_monitoring_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Central monitoring alert metrics tracking KRI breaches, alert severity distribution, and resolution timeliness for risk-based monitoring oversight."
  source: "`clinical_trials_ecm`.`monitoring`.`central_monitoring_alert`"
  dimensions:
    - name: "alert_category"
      expr: alert_category
      comment: "Category of the central monitoring alert (e.g., enrollment, safety, data quality)"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert (e.g., critical, major, minor)"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (e.g., open, under review, closed)"
    - name: "alert_type"
      expr: alert_type
      comment: "Type classification of the alert"
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold breached (e.g., red, amber)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the alert after review"
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the alert review process"
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source system or process that triggered the alert"
    - name: "is_repeat_alert_flag"
      expr: is_repeat_alert
      comment: "Whether this is a repeat/recurring alert for the same issue"
    - name: "kri_name"
      expr: kri_name
      comment: "Name of the Key Risk Indicator that triggered the alert"
    - name: "alert_year_month"
      expr: DATE_TRUNC('MONTH', alert_generated_timestamp)
      comment: "Month the alert was generated for trend analysis"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of central monitoring alerts generated"
    - name: "avg_observed_value"
      expr: AVG(CAST(observed_value AS DOUBLE))
      comment: "Average observed KRI value across alerts — indicates magnitude of threshold breaches"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value — baseline for understanding breach severity"
    - name: "alerts_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of alerts that required CAPA initiation — indicates systemic quality issues"
    - name: "alerts_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of alerts requiring escalation — measures severity of monitoring findings"
    - name: "repeat_alerts"
      expr: COUNT(CASE WHEN is_repeat_alert = TRUE THEN 1 END)
      comment: "Number of repeat alerts — indicates unresolved root causes and ineffective corrective actions"
    - name: "sponsor_notified_alerts"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END)
      comment: "Number of alerts where sponsor was notified — transparency and governance indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_visit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit finding metrics tracking the volume, severity, and resolution of findings identified during monitoring visits — critical for site quality oversight and GCP compliance."
  source: "`clinical_trials_ecm`.`monitoring`.`visit_finding`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Severity classification of the finding (e.g., critical, major, minor)"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., consent, safety reporting, data management)"
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Subcategory providing granular classification of the finding"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding (e.g., open, resolved, escalated)"
    - name: "monitoring_approach"
      expr: monitoring_approach
      comment: "Monitoring approach under which the finding was identified (e.g., on-site, remote, centralized)"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit during which the finding was identified"
    - name: "repeat_finding_flag"
      expr: repeat_finding
      comment: "Whether this is a repeat finding — indicates ineffective corrective actions"
    - name: "subject_safety_impact_flag"
      expr: subject_safety_impact
      comment: "Whether the finding has potential impact on subject safety"
    - name: "data_integrity_impact_flag"
      expr: data_integrity_impact
      comment: "Whether the finding has potential impact on data integrity"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact
      comment: "Whether the finding has regulatory compliance implications"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of visit findings identified — overall site quality indicator"
    - name: "critical_findings"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical findings — requires immediate attention and potential study impact"
    - name: "major_findings"
      expr: COUNT(CASE WHEN severity = 'Major' THEN 1 END)
      comment: "Number of major findings — significant GCP or protocol compliance issues"
    - name: "findings_with_safety_impact"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN 1 END)
      comment: "Number of findings impacting subject safety — highest priority for resolution"
    - name: "findings_with_data_integrity_impact"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN 1 END)
      comment: "Number of findings impacting data integrity — affects study data reliability"
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings — indicates ineffective CAPA and persistent site issues"
    - name: "findings_requiring_sdv"
      expr: COUNT(CASE WHEN sdv_required = TRUE THEN 1 END)
      comment: "Number of findings requiring source data verification follow-up"
    - name: "open_findings"
      expr: COUNT(CASE WHEN resolution_status = 'Open' THEN 1 END)
      comment: "Number of currently open/unresolved findings — operational backlog indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_site_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site risk assessment metrics providing risk-based monitoring intelligence including risk scores, KRI breach rates, and quality indicators that drive monitoring intensity decisions."
  source: "`clinical_trials_ecm`.`monitoring`.`site_risk_assessment`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification of the site (e.g., high, medium, low)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., routine, triggered, ad-hoc)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "recommended_monitoring_intensity"
      expr: recommended_monitoring_intensity
      comment: "Recommended monitoring intensity based on risk assessment outcome"
    - name: "capa_required_flag"
      expr: capa_required
      comment: "Whether the assessment triggered a CAPA requirement"
    - name: "previous_risk_tier"
      expr: previous_risk_tier
      comment: "Previous risk tier for tracking tier migration trends"
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of site risk assessments conducted"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across sites — key indicator for portfolio-level risk posture"
    - name: "avg_enrollment_rate_pct"
      expr: AVG(CAST(enrollment_rate_percent AS DOUBLE))
      comment: "Average enrollment rate percentage — operational performance indicator"
    - name: "avg_query_rate_pct"
      expr: AVG(CAST(query_rate_percent AS DOUBLE))
      comment: "Average query rate percentage — data quality indicator"
    - name: "avg_sdv_completion_pct"
      expr: AVG(CAST(sdv_completion_percent AS DOUBLE))
      comment: "Average SDV completion percentage — monitoring execution completeness"
    - name: "avg_ae_reporting_timeliness_pct"
      expr: AVG(CAST(ae_reporting_timeliness_percent AS DOUBLE))
      comment: "Average AE reporting timeliness — critical safety compliance metric"
    - name: "avg_subject_dropout_rate_pct"
      expr: AVG(CAST(subject_dropout_rate_percent AS DOUBLE))
      comment: "Average subject dropout rate — retention and site performance indicator"
    - name: "avg_screen_failure_rate_pct"
      expr: AVG(CAST(screen_failure_rate_percent AS DOUBLE))
      comment: "Average screen failure rate — site recruitment quality indicator"
    - name: "high_risk_sites"
      expr: COUNT(CASE WHEN risk_tier = 'High' THEN 1 END)
      comment: "Number of sites classified as high risk — drives resource allocation decisions"
    - name: "sites_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of site assessments triggering CAPA — systemic quality concern indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_risk_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Risk Indicator (KRI) metrics tracking computed values, threshold breaches, and trend directions for centralized risk-based monitoring of clinical trial sites."
  source: "`clinical_trials_ecm`.`monitoring`.`risk_indicator`"
  dimensions:
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of risk indicator (e.g., enrollment, safety, data quality, compliance)"
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current status of the risk indicator (e.g., active, breached, resolved)"
    - name: "alert_status"
      expr: alert_status
      comment: "Alert status triggered by this indicator"
    - name: "risk_indicator_category"
      expr: risk_indicator_category
      comment: "Category classification of the risk indicator"
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of threshold (e.g., above, below) indicating breach condition"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Current trend direction of the indicator (e.g., improving, worsening, stable)"
    - name: "computation_frequency"
      expr: computation_frequency
      comment: "How frequently the indicator is computed (e.g., weekly, monthly)"
    - name: "is_centralized_monitoring_flag"
      expr: is_centralized_monitoring
      comment: "Whether this indicator is part of centralized monitoring program"
    - name: "escalation_required_flag"
      expr: escalation_required
      comment: "Whether the indicator breach requires escalation"
    - name: "computation_month"
      expr: DATE_TRUNC('MONTH', computation_date)
      comment: "Month of KRI computation for trend analysis"
  measures:
    - name: "total_indicators_computed"
      expr: COUNT(1)
      comment: "Total number of risk indicator computations — monitoring coverage indicator"
    - name: "avg_computed_value"
      expr: AVG(CAST(computed_value AS DOUBLE))
      comment: "Average computed KRI value — portfolio-level risk signal"
    - name: "avg_risk_score_contribution"
      expr: AVG(CAST(risk_score_contribution AS DOUBLE))
      comment: "Average risk score contribution per indicator — identifies highest-impact risk drivers"
    - name: "indicators_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of indicators requiring escalation — severity of risk landscape"
    - name: "indicators_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of indicators triggering CAPA — systemic quality issues"
    - name: "avg_numerator_value"
      expr: AVG(CAST(numerator_value AS DOUBLE))
      comment: "Average numerator value for ratio-based KRIs"
    - name: "avg_denominator_value"
      expr: AVG(CAST(denominator_value AS DOUBLE))
      comment: "Average denominator value for ratio-based KRIs — context for KRI interpretation"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_action_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitoring action item metrics tracking open items, escalation rates, and resolution timeliness — critical for ensuring site corrective actions are completed and GCP compliance is maintained."
  source: "`clinical_trials_ecm`.`monitoring`.`monitoring_action_item`"
  dimensions:
    - name: "monitoring_action_item_status"
      expr: monitoring_action_item_status
      comment: "Current status of the action item (e.g., open, closed, overdue)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the action item (e.g., high, medium, low)"
    - name: "monitoring_action_item_category"
      expr: monitoring_action_item_category
      comment: "Category of the action item (e.g., consent, safety, data management)"
    - name: "action_type"
      expr: action_type
      comment: "Type of action required"
    - name: "source_type"
      expr: source_type
      comment: "Source that generated the action item (e.g., visit finding, central alert)"
    - name: "is_escalated_flag"
      expr: is_escalated
      comment: "Whether the action item has been escalated"
    - name: "subject_safety_impact_flag"
      expr: subject_safety_impact
      comment: "Whether the action item has subject safety implications"
    - name: "data_integrity_impact_flag"
      expr: data_integrity_impact
      comment: "Whether the action item has data integrity implications"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring action item — indicates persistent site issues"
  measures:
    - name: "total_action_items"
      expr: COUNT(1)
      comment: "Total number of monitoring action items — workload and compliance indicator"
    - name: "escalated_action_items"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Number of escalated action items — indicates unresolved issues requiring management attention"
    - name: "safety_impacting_items"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN 1 END)
      comment: "Number of action items with subject safety impact — highest priority for resolution"
    - name: "recurring_action_items"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring action items — indicates ineffective root cause resolution"
    - name: "data_integrity_items"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN 1 END)
      comment: "Number of action items impacting data integrity — affects study data reliability"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_escalation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escalation record metrics tracking escalation volume, severity, resolution timeliness, and regulatory impact — critical for governance oversight and sponsor communication."
  source: "`clinical_trials_ecm`.`monitoring`.`escalation_record`"
  dimensions:
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (e.g., L1-CRA, L2-CTL, L3-Management, L4-Sponsor)"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current status of the escalation (e.g., open, acknowledged, resolved, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority classification of the escalation"
    - name: "escalation_trigger_type"
      expr: escalation_trigger_type
      comment: "Type of trigger that initiated the escalation"
    - name: "gcp_finding_category"
      expr: gcp_finding_category
      comment: "GCP finding category associated with the escalation"
    - name: "subject_safety_impact_flag"
      expr: subject_safety_impact
      comment: "Whether the escalation involves subject safety concerns"
    - name: "data_integrity_impact_flag"
      expr: data_integrity_impact
      comment: "Whether the escalation involves data integrity concerns"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required
      comment: "Whether regulatory authority reporting is required"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the escalation resolution"
    - name: "escalation_year_month"
      expr: DATE_TRUNC('MONTH', escalation_date)
      comment: "Month of escalation for trend analysis"
  measures:
    - name: "total_escalations"
      expr: COUNT(1)
      comment: "Total number of escalation records — governance and oversight intensity indicator"
    - name: "safety_impact_escalations"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN 1 END)
      comment: "Number of escalations with subject safety impact — critical patient protection metric"
    - name: "regulatory_reportable_escalations"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of escalations requiring regulatory reporting — compliance risk indicator"
    - name: "sponsor_notified_escalations"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END)
      comment: "Number of escalations where sponsor was notified — governance transparency metric"
    - name: "irb_notified_escalations"
      expr: COUNT(CASE WHEN irb_iec_notified = TRUE THEN 1 END)
      comment: "Number of escalations requiring IRB/IEC notification — ethical oversight indicator"
    - name: "follow_up_required_escalations"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of escalations requiring follow-up — workload and resolution completeness indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`monitoring_sdv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source Data Verification (SDV) metrics tracking verification coverage, outcomes, discrepancies, and risk-based monitoring scores — essential for data quality assurance in clinical trials."
  source: "`clinical_trials_ecm`.`monitoring`.`sdv_record`"
  dimensions:
    - name: "sdv_outcome"
      expr: sdv_outcome
      comment: "Outcome of the SDV check (e.g., verified, discrepancy found, not verifiable)"
    - name: "sdv_type"
      expr: sdv_type
      comment: "Type of SDV performed (e.g., full, targeted, risk-based)"
    - name: "sdv_method"
      expr: sdv_method
      comment: "Method used for SDV (e.g., on-site, remote)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of any discrepancy found during SDV"
    - name: "is_critical_data_point_flag"
      expr: is_critical_data_point
      comment: "Whether the verified data point is classified as critical"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the SDV finding has regulatory impact"
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document used for verification"
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Category of discrepancy identified during SDV"
  measures:
    - name: "total_sdv_records"
      expr: COUNT(1)
      comment: "Total number of SDV records — monitoring execution volume"
    - name: "avg_sdv_coverage_percentage"
      expr: AVG(CAST(sdv_coverage_percentage AS DOUBLE))
      comment: "Average SDV coverage percentage — indicates monitoring plan adherence"
    - name: "avg_rbm_risk_score"
      expr: AVG(CAST(rbm_risk_score AS DOUBLE))
      comment: "Average risk-based monitoring score — drives targeted verification decisions"
    - name: "critical_data_point_verifications"
      expr: COUNT(CASE WHEN is_critical_data_point = TRUE THEN 1 END)
      comment: "Number of critical data point verifications — ensures key study data is verified"
    - name: "sdv_waived_records"
      expr: COUNT(CASE WHEN is_sdv_waived = TRUE THEN 1 END)
      comment: "Number of SDV records waived — risk acceptance indicator"
    - name: "regulatory_impact_findings"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of SDV findings with regulatory impact — compliance risk indicator"
    - name: "distinct_subjects_verified"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of distinct subjects with SDV performed — coverage breadth indicator"
$$;