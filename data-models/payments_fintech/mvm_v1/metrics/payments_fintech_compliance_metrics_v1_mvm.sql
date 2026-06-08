-- Metric views for domain: compliance | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compliance case performance indicators."
  source: "`payments_fintech_ecm`.`compliance`.`compliance_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of compliance case (e.g., AML, KYC)."
    - name: "case_category"
      expr: case_category
      comment: "Business category of the case."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (Open, Closed, etc.)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the case."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the case."
    - name: "jurisdiction_profile_id"
      expr: jurisdiction_profile_id
      comment: "Identifier of the jurisdiction profile."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier associated with the case."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created."
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_timestamp)
      comment: "Month the case was opened."
    - name: "closed_month"
      expr: DATE_TRUNC('month', closed_timestamp)
      comment: "Month the case was closed, if applicable."
    - name: "is_false_positive"
      expr: is_false_positive
      comment: "Flag indicating if the case was later deemed a false positive."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the case."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of compliance cases recorded."
    - name: "open_cases"
      expr: SUM(CASE WHEN case_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of cases that are currently open."
    - name: "closed_cases"
      expr: SUM(CASE WHEN case_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of cases that have been closed."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all cases."
    - name: "high_risk_cases"
      expr: SUM(CASE WHEN risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Number of cases with risk score >= 80 (high risk)."
    - name: "escalated_cases"
      expr: SUM(CASE WHEN is_escalated THEN 1 ELSE 0 END)
      comment: "Count of cases flagged as escalated."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_aml_screening_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics summarizing AML screening outcomes."
  source: "`payments_fintech_ecm`.`compliance`.`aml_screening_result`"
  dimensions:
    - name: "screening_engine"
      expr: screening_engine
      comment: "Engine used for the AML screening."
    - name: "match_type"
      expr: match_type
      comment: "Type of match identified by the screening."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the screening result."
    - name: "screening_rule_version"
      expr: screening_rule_version
      comment: "Version of the screening rule applied."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the screening result."
    - name: "source_module"
      expr: source_module
      comment: "Source module within the system."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month of the screening event."
    - name: "is_sar_required"
      expr: is_sar_required
      comment: "Flag indicating SAR filing requirement."
    - name: "is_str_required"
      expr: is_str_required
      comment: "Flag indicating STR filing requirement."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total AML screening results processed."
    - name: "sar_required_screenings"
      expr: SUM(CASE WHEN is_sar_required THEN 1 ELSE 0 END)
      comment: "Number of screenings that triggered a SAR filing requirement."
    - name: "str_required_screenings"
      expr: SUM(CASE WHEN is_str_required THEN 1 ELSE 0 END)
      comment: "Number of screenings that triggered a STR filing requirement."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across screenings."
    - name: "high_risk_screenings"
      expr: SUM(CASE WHEN risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of screenings with risk score >= 80 (high risk)."
    - name: "sar_filed_screenings"
      expr: SUM(CASE WHEN sar_filing_status = 'Filed' THEN 1 ELSE 0 END)
      comment: "Number of screenings where SAR was actually filed."
    - name: "str_filed_screenings"
      expr: SUM(CASE WHEN str_filing_status = 'Filed' THEN 1 ELSE 0 END)
      comment: "Number of screenings where STR was actually filed."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_sanctions_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for sanctions screening."
  source: "`payments_fintech_ecm`.`compliance`.`sanctions_check`"
  dimensions:
    - name: "list_name"
      expr: list_name
      comment: "Name of the watchlist used."
    - name: "screening_method"
      expr: screening_method
      comment: "Methodology used for the screening."
    - name: "screening_source"
      expr: screening_source
      comment: "Source of the screening data."
    - name: "block_action_taken"
      expr: block_action_taken
      comment: "Action taken when a hit was identified."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the check is considered critical."
    - name: "check_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the sanctions check was performed."
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total sanctions checks performed."
    - name: "hit_checks"
      expr: SUM(CASE WHEN hit_indicator THEN 1 ELSE 0 END)
      comment: "Number of checks that resulted in a hit."
    - name: "false_positive_checks"
      expr: SUM(CASE WHEN false_positive_flag THEN 1 ELSE 0 END)
      comment: "Number of checks later marked as false positives."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all checks."
    - name: "high_risk_checks"
      expr: SUM(CASE WHEN risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of checks with risk score >= 80."
    - name: "critical_checks"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Number of checks flagged as critical."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing volume and value metrics."
  source: "`payments_fintech_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "regulator_name"
      expr: regulator_name
      comment: "Name of the regulator receiving the filing."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (Filed, Pending, Rejected, etc.)."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of filing (e.g., SAR, STR, AML)."
    - name: "filing_category"
      expr: filing_category
      comment: "Business category of the filing."
    - name: "filing_priority"
      expr: filing_priority
      comment: "Priority level assigned to the filing."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier associated with the filing."
    - name: "filing_deadline_month"
      expr: DATE_TRUNC('month', filing_deadline_date)
      comment: "Month of the filing deadline."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted."
    - name: "total_filing_amount"
      expr: SUM(CAST(filing_amount AS DOUBLE))
      comment: "Aggregate monetary amount reported across filings."
    - name: "avg_filing_amount"
      expr: AVG(CAST(filing_amount AS DOUBLE))
      comment: "Average filing amount per submission."
    - name: "filed_filings"
      expr: SUM(CASE WHEN filing_status = 'Filed' THEN 1 ELSE 0 END)
      comment: "Count of filings with status 'Filed'."
    - name: "pending_filings"
      expr: SUM(CASE WHEN filing_status = 'Pending' THEN 1 ELSE 0 END)
      comment: "Count of filings still pending."
    - name: "high_value_filings"
      expr: SUM(CASE WHEN filing_amount >= 100000 THEN 1 ELSE 0 END)
      comment: "Number of filings where the reported amount exceeds $100,000."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_control_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control assessment effectiveness and exception tracking."
  source: "`payments_fintech_ecm`.`compliance`.`control_assessment`"
  dimensions:
    - name: "control_assessment_status"
      expr: control_assessment_status
      comment: "Overall status of the control assessment."
    - name: "control_category"
      expr: control_category
      comment: "Category of the control being assessed."
    - name: "control_owner"
      expr: control_owner
      comment: "Owner responsible for the control."
    - name: "overall_status"
      expr: overall_status
      comment: "Aggregated status of the assessment outcome."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applicable to the assessment."
    - name: "assessment_cycle"
      expr: assessment_cycle
      comment: "Cycle identifier for the assessment (e.g., Q1-2024)."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month the assessment was conducted."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total control assessments performed."
    - name: "avg_effectiveness_score"
      expr: AVG(CAST(control_effectiveness_score AS DOUBLE))
      comment: "Average effectiveness score across assessments."
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_flag THEN 1 ELSE 0 END)
      comment: "Number of assessments that raised an exception."
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required THEN 1 ELSE 0 END)
      comment: "Count of assessments requiring remediation."
$$;