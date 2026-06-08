-- Metric views for domain: compliance | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance and financial exposure metrics tracking audit lifecycle, findings, and remediation effectiveness"
  source: "`staffing_hr_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit (internal, external, regulatory)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (open, in progress, closed)"
    - name: "audit_source"
      expr: audit_source
      comment: "Source or trigger of the audit"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned to the audit"
    - name: "overall_disposition"
      expr: overall_disposition
      comment: "Final disposition or outcome of the audit"
    - name: "initiating_agency"
      expr: initiating_agency
      comment: "Government or regulatory agency that initiated the audit"
    - name: "audit_year"
      expr: YEAR(period_start_date)
      comment: "Year the audit period started"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(period_start_date))
      comment: "Quarter the audit period started"
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of corrective action plan (pending, in progress, completed)"
    - name: "legal_counsel_engaged"
      expr: legal_counsel_engaged
      comment: "Whether legal counsel was engaged for this audit"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this audit contains repeat findings from prior audits"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits"
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure across all audits"
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Total actual penalties assessed across all audits"
    - name: "avg_estimated_financial_exposure"
      expr: AVG(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Average estimated financial exposure per audit"
    - name: "avg_actual_penalty_amount"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average actual penalty amount per audit"
    - name: "penalty_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_financial_exposure AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated exposure that materialized as actual penalties"
    - name: "audits_with_critical_findings"
      expr: COUNT(CASE WHEN CAST(critical_findings_count AS INT) > 0 THEN 1 END)
      comment: "Number of audits with at least one critical finding"
    - name: "audits_with_repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of audits containing repeat findings from prior audits"
    - name: "audits_with_legal_counsel"
      expr: COUNT(CASE WHEN legal_counsel_engaged = TRUE THEN 1 END)
      comment: "Number of audits requiring legal counsel engagement"
    - name: "avg_audit_duration_days"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average duration of audit fieldwork in days"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(closure_date, report_issued_date))
      comment: "Average time from report issuance to audit closure in days"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation effectiveness and deficiency tracking metrics"
  source: "`staffing_hr_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the audit finding (critical, high, medium, low)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in remediation, closed)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required for this finding"
    - name: "finding_year"
      expr: YEAR(finding_date)
      comment: "Year the finding was identified"
    - name: "finding_quarter"
      expr: CONCAT('Q', QUARTER(finding_date))
      comment: "Quarter the finding was identified"
    - name: "responsible_owner"
      expr: responsible_owner
      comment: "Owner responsible for remediating the finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "findings_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of findings requiring corrective action"
    - name: "closed_findings"
      expr: COUNT(CASE WHEN finding_status = 'closed' THEN 1 END)
      comment: "Number of findings that have been closed"
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status IN ('open', 'in remediation') THEN 1 END)
      comment: "Number of findings still open or in remediation"
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(closure_date, finding_date))
      comment: "Average time from finding identification to closure in days"
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND finding_status != 'closed' THEN 1 END)
      comment: "Number of findings past their corrective action due date and still open"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_coe_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Co-employment risk assessment metrics tracking worker classification risk and mitigation effectiveness"
  source: "`staffing_hr_ecm`.`compliance`.`coe_risk_assessment`"
  dimensions:
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall co-employment risk rating (low, medium, high, critical)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "worker_classification_type"
      expr: worker_classification_type
      comment: "Worker classification type (W2, 1099, contractor, etc.)"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of worker engagement"
    - name: "legal_counsel_review_required"
      expr: legal_counsel_review_required
      comment: "Whether legal counsel review is required"
    - name: "legal_counsel_review_status"
      expr: legal_counsel_review_status
      comment: "Status of legal counsel review"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was performed"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date))
      comment: "Quarter the assessment was performed"
    - name: "incident_history_flag"
      expr: incident_history_flag
      comment: "Whether there is a history of co-employment incidents"
    - name: "contract_language_required"
      expr: contract_language_required
      comment: "Whether specific contract language is required to mitigate risk"
    - name: "insurance_rider_required"
      expr: insurance_rider_required
      comment: "Whether an insurance rider is required"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of co-employment risk assessments"
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN risk_rating IN ('high', 'critical') THEN 1 END)
      comment: "Number of assessments rated as high or critical risk"
    - name: "high_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_rating IN ('high', 'critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments rated as high or critical risk"
    - name: "assessments_requiring_legal_review"
      expr: COUNT(CASE WHEN legal_counsel_review_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring legal counsel review"
    - name: "assessments_with_incident_history"
      expr: COUNT(CASE WHEN incident_history_flag = TRUE THEN 1 END)
      comment: "Number of assessments with prior co-employment incident history"
    - name: "assessments_requiring_contract_language"
      expr: COUNT(CASE WHEN contract_language_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring specific contract language mitigation"
    - name: "assessments_requiring_insurance_rider"
      expr: COUNT(CASE WHEN insurance_rider_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring insurance rider mitigation"
    - name: "avg_time_to_approval_days"
      expr: AVG(DATEDIFF(approval_date, assessment_date))
      comment: "Average time from assessment to approval in days"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_everify_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "E-Verify case processing and employment authorization verification metrics"
  source: "`staffing_hr_ecm`.`compliance`.`everify_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the E-Verify case"
    - name: "final_case_result"
      expr: final_case_result
      comment: "Final result of the E-Verify case (employment authorized, not authorized)"
    - name: "case_verification_type"
      expr: case_verification_type
      comment: "Type of verification performed"
    - name: "further_action_notice_issued"
      expr: further_action_notice_issued
      comment: "Whether a further action notice (FAN) was issued"
    - name: "tnc_issued"
      expr: tnc_type IS NOT NULL
      comment: "Whether a tentative non-confirmation (TNC) was issued"
    - name: "tnc_type"
      expr: tnc_type
      comment: "Type of tentative non-confirmation issued"
    - name: "worker_contested_tnc"
      expr: worker_contested_tnc
      comment: "Whether the worker contested the TNC"
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Whether the case was submitted late (after 3 business days)"
    - name: "federal_contractor_flag"
      expr: federal_contractor_flag
      comment: "Whether this is for a federal contractor position"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the case was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_timestamp))
      comment: "Quarter the case was submitted"
  measures:
    - name: "total_everify_cases"
      expr: COUNT(1)
      comment: "Total number of E-Verify cases processed"
    - name: "cases_with_tnc"
      expr: COUNT(CASE WHEN tnc_type IS NOT NULL THEN 1 END)
      comment: "Number of cases that received a tentative non-confirmation"
    - name: "tnc_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tnc_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that received a TNC"
    - name: "contested_tnc_cases"
      expr: COUNT(CASE WHEN worker_contested_tnc = TRUE THEN 1 END)
      comment: "Number of cases where worker contested the TNC"
    - name: "late_submission_cases"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of cases submitted late (compliance violation)"
    - name: "late_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases submitted late"
    - name: "employment_authorized_cases"
      expr: COUNT(CASE WHEN final_case_result = 'employment authorized' THEN 1 END)
      comment: "Number of cases with final result of employment authorized"
    - name: "authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_case_result = 'employment authorized' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resulting in employment authorization"
    - name: "avg_case_resolution_days"
      expr: AVG(DATEDIFF(case_closure_date, submission_timestamp))
      comment: "Average time from submission to case closure in days"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_i9_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "I-9 employment eligibility verification compliance and processing metrics"
  source: "`staffing_hr_ecm`.`compliance`.`i9_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current status of I-9 verification"
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Citizenship or immigration status of the worker"
    - name: "everify_status"
      expr: everify_status
      comment: "Status of E-Verify case associated with this I-9"
    - name: "employer_of_record_type"
      expr: employer_of_record_type
      comment: "Type of employer of record (direct, staffing, MSP, etc.)"
    - name: "list_a_document_type"
      expr: list_a_document_type
      comment: "Type of List A document presented (establishes both identity and work authorization)"
    - name: "remote_verification"
      expr: remote_verification
      comment: "Whether verification was performed remotely"
    - name: "preparer_used"
      expr: preparer_used
      comment: "Whether a preparer/translator was used"
    - name: "reverification_required"
      expr: reverification_required
      comment: "Whether reverification is required due to expiring work authorization"
    - name: "tnc_issued"
      expr: tnc_issued
      comment: "Whether a tentative non-confirmation was issued"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "hire_quarter"
      expr: CONCAT('Q', QUARTER(hire_date))
      comment: "Quarter of hire"
  measures:
    - name: "total_i9_verifications"
      expr: COUNT(1)
      comment: "Total number of I-9 verifications processed"
    - name: "remote_verifications"
      expr: COUNT(CASE WHEN remote_verification = TRUE THEN 1 END)
      comment: "Number of I-9 verifications performed remotely"
    - name: "remote_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_verification = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of I-9 verifications performed remotely"
    - name: "verifications_requiring_reverification"
      expr: COUNT(CASE WHEN reverification_required = TRUE THEN 1 END)
      comment: "Number of verifications requiring future reverification"
    - name: "verifications_with_tnc"
      expr: COUNT(CASE WHEN tnc_issued = TRUE THEN 1 END)
      comment: "Number of verifications where a TNC was issued"
    - name: "verifications_with_preparer"
      expr: COUNT(CASE WHEN preparer_used = TRUE THEN 1 END)
      comment: "Number of verifications where a preparer/translator was used"
    - name: "avg_section1_to_section2_days"
      expr: AVG(DATEDIFF(section2_completed_date, section1_completed_date))
      comment: "Average time from Section 1 completion to Section 2 completion in days"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA workplace safety incident tracking and recordkeeping compliance metrics"
  source: "`staffing_hr_ecm`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation and remediation"
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Whether the incident is OSHA recordable (300 log)"
    - name: "is_fatality"
      expr: is_fatality
      comment: "Whether the incident resulted in a fatality"
    - name: "is_hospitalized"
      expr: is_hospitalized
      comment: "Whether the incident resulted in hospitalization"
    - name: "outcome_type"
      expr: outcome_type
      comment: "Outcome type (days away, restricted duty, medical treatment only)"
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Type of injury or illness"
    - name: "event_type"
      expr: event_type
      comment: "Type of event that caused the incident"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter the incident occurred"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of workplace safety incidents"
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Number of OSHA recordable incidents (300 log entries)"
    - name: "fatalities"
      expr: COUNT(CASE WHEN is_fatality = TRUE THEN 1 END)
      comment: "Number of fatal incidents"
    - name: "hospitalizations"
      expr: COUNT(CASE WHEN is_hospitalized = TRUE THEN 1 END)
      comment: "Number of incidents resulting in hospitalization"
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable"
    - name: "avg_days_away_from_work"
      expr: AVG(CAST(days_away_from_work AS INT))
      comment: "Average number of days away from work per incident"
    - name: "avg_days_restricted_duty"
      expr: AVG(CAST(days_restricted_duty AS INT))
      comment: "Average number of days on restricted duty per incident"
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_completed_date, incident_date))
      comment: "Average time from incident to investigation completion in days"
    - name: "avg_corrective_action_duration_days"
      expr: AVG(DATEDIFF(corrective_action_completed_date, incident_date))
      comment: "Average time from incident to corrective action completion in days"
    - name: "avg_return_to_work_days"
      expr: AVG(DATEDIFF(return_to_work_date, incident_date))
      comment: "Average time from incident to return to work in days"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_regulatory_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory violation tracking and financial penalty metrics for compliance risk management"
  source: "`staffing_hr_ecm`.`compliance`.`regulatory_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of regulatory violation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body or agency that issued the violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the violation (critical, high, medium, low)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the violation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the violation"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction where violation occurred"
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country jurisdiction where violation occurred"
    - name: "repeat_violation_flag"
      expr: repeat_violation_flag
      comment: "Whether this is a repeat violation"
    - name: "legal_counsel_involved"
      expr: legal_counsel_involved
      comment: "Whether legal counsel is involved in the violation response"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the violation was discovered"
    - name: "discovery_quarter"
      expr: CONCAT('Q', QUARTER(discovery_date))
      comment: "Quarter the violation was discovered"
    - name: "worker_classification_type"
      expr: worker_classification_type
      comment: "Worker classification type involved in the violation"
    - name: "co_employment_risk_flag"
      expr: co_employment_risk_flag
      comment: "Whether the violation involves co-employment risk"
    - name: "data_privacy_breach_flag"
      expr: data_privacy_breach_flag
      comment: "Whether the violation involves a data privacy breach"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations"
    - name: "total_financial_penalties"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed across all violations"
    - name: "avg_financial_penalty"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average financial penalty per violation"
    - name: "repeat_violations"
      expr: COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END)
      comment: "Number of repeat violations"
    - name: "repeat_violation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are repeat occurrences"
    - name: "violations_requiring_legal_counsel"
      expr: COUNT(CASE WHEN legal_counsel_involved = TRUE THEN 1 END)
      comment: "Number of violations requiring legal counsel involvement"
    - name: "resolved_violations"
      expr: COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END)
      comment: "Number of violations that have been resolved"
    - name: "violation_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that have been resolved"
    - name: "avg_time_to_remediation_days"
      expr: AVG(DATEDIFF(remediation_completed_date, discovery_date))
      comment: "Average time from violation discovery to remediation completion in days"
    - name: "overdue_remediations"
      expr: COUNT(CASE WHEN remediation_due_date < CURRENT_DATE() AND resolution_status != 'resolved' THEN 1 END)
      comment: "Number of violations with overdue remediation plans"
    - name: "violations_with_co_employment_risk"
      expr: COUNT(CASE WHEN co_employment_risk_flag = TRUE THEN 1 END)
      comment: "Number of violations involving co-employment risk"
    - name: "data_privacy_breaches"
      expr: COUNT(CASE WHEN data_privacy_breach_flag = TRUE THEN 1 END)
      comment: "Number of violations involving data privacy breaches"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_worker_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Worker classification determination and misclassification risk metrics for independent contractor compliance"
  source: "`staffing_hr_ecm`.`compliance`.`worker_classification`"
  dimensions:
    - name: "classification_type"
      expr: classification_type
      comment: "Worker classification type (W2 employee, 1099 contractor, etc.)"
    - name: "classification_status"
      expr: classification_status
      comment: "Current status of the classification determination"
    - name: "misclassification_risk_level"
      expr: misclassification_risk_level
      comment: "Risk level of worker misclassification (low, medium, high, critical)"
    - name: "abc_test_result"
      expr: abc_test_result
      comment: "Result of ABC test for independent contractor status"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status (exempt, non-exempt)"
    - name: "determination_basis"
      expr: determination_basis
      comment: "Basis for the classification determination"
    - name: "ic_agreement_on_file"
      expr: ic_agreement_on_file
      comment: "Whether an independent contractor agreement is on file"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether the classification was manually overridden"
    - name: "ss8_filed"
      expr: ss8_filed
      comment: "Whether an IRS SS-8 determination was filed"
    - name: "determination_year"
      expr: YEAR(determination_date)
      comment: "Year the classification was determined"
    - name: "determination_quarter"
      expr: CONCAT('Q', QUARTER(determination_date))
      comment: "Quarter the classification was determined"
    - name: "reclassification_trigger"
      expr: reclassification_trigger
      comment: "Trigger that caused a reclassification review"
  measures:
    - name: "total_classifications"
      expr: COUNT(1)
      comment: "Total number of worker classification determinations"
    - name: "high_risk_classifications"
      expr: COUNT(CASE WHEN misclassification_risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Number of classifications with high or critical misclassification risk"
    - name: "high_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN misclassification_risk_level IN ('high', 'critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of classifications with high or critical misclassification risk"
    - name: "independent_contractor_classifications"
      expr: COUNT(CASE WHEN classification_type LIKE '%1099%' OR classification_type LIKE '%contractor%' THEN 1 END)
      comment: "Number of workers classified as independent contractors"
    - name: "ic_classification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN classification_type LIKE '%1099%' OR classification_type LIKE '%contractor%' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workers classified as independent contractors"
    - name: "classifications_without_ic_agreement"
      expr: COUNT(CASE WHEN (classification_type LIKE '%1099%' OR classification_type LIKE '%contractor%') AND ic_agreement_on_file = FALSE THEN 1 END)
      comment: "Number of IC classifications missing required agreement on file"
    - name: "overridden_classifications"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of classifications that were manually overridden"
    - name: "reclassifications"
      expr: COUNT(CASE WHEN reclassification_date IS NOT NULL THEN 1 END)
      comment: "Number of workers who were reclassified"
    - name: "reclassification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reclassification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of classifications that resulted in reclassification"
    - name: "ss8_filings"
      expr: COUNT(CASE WHEN ss8_filed = TRUE THEN 1 END)
      comment: "Number of classifications where IRS SS-8 determination was filed"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_wage_hour_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wage and hour compliance determination metrics tracking FLSA classification and pay equity"
  source: "`staffing_hr_ecm`.`compliance`.`wage_hour_determination`"
  dimensions:
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt, non-exempt)"
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the wage hour determination"
    - name: "exemption_basis"
      expr: exemption_basis
      comment: "Basis for FLSA exemption if applicable"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate (hourly, salary, etc.)"
    - name: "prevailing_wage_flag"
      expr: prevailing_wage_flag
      comment: "Whether prevailing wage requirements apply"
    - name: "salary_threshold_met"
      expr: salary_threshold_met
      comment: "Whether FLSA salary threshold is met for exemption"
    - name: "dol_audit_flag"
      expr: dol_audit_flag
      comment: "Whether this determination is under DOL audit"
    - name: "pay_equity_review_flag"
      expr: pay_equity_review_flag
      comment: "Whether pay equity review was conducted"
    - name: "pay_equity_outcome"
      expr: pay_equity_outcome
      comment: "Outcome of pay equity review"
    - name: "co_employment_risk_level"
      expr: co_employment_risk_level
      comment: "Co-employment risk level associated with this determination"
    - name: "work_state"
      expr: work_state
      comment: "State where work is performed"
    - name: "determination_year"
      expr: YEAR(determination_date)
      comment: "Year the determination was made"
    - name: "determination_quarter"
      expr: CONCAT('Q', QUARTER(determination_date))
      comment: "Quarter the determination was made"
  measures:
    - name: "total_determinations"
      expr: COUNT(1)
      comment: "Total number of wage hour determinations"
    - name: "exempt_classifications"
      expr: COUNT(CASE WHEN flsa_classification = 'exempt' THEN 1 END)
      comment: "Number of workers classified as FLSA exempt"
    - name: "non_exempt_classifications"
      expr: COUNT(CASE WHEN flsa_classification = 'non-exempt' THEN 1 END)
      comment: "Number of workers classified as FLSA non-exempt"
    - name: "exempt_classification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN flsa_classification = 'exempt' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workers classified as FLSA exempt"
    - name: "determinations_under_dol_audit"
      expr: COUNT(CASE WHEN dol_audit_flag = TRUE THEN 1 END)
      comment: "Number of determinations under DOL audit"
    - name: "prevailing_wage_determinations"
      expr: COUNT(CASE WHEN prevailing_wage_flag = TRUE THEN 1 END)
      comment: "Number of determinations subject to prevailing wage requirements"
    - name: "pay_equity_reviews_conducted"
      expr: COUNT(CASE WHEN pay_equity_review_flag = TRUE THEN 1 END)
      comment: "Number of determinations with pay equity review conducted"
    - name: "avg_validated_pay_rate"
      expr: AVG(CAST(pay_rate_validated AS DOUBLE))
      comment: "Average validated pay rate across determinations"
    - name: "avg_minimum_wage_applicable"
      expr: AVG(CAST(minimum_wage_applicable AS DOUBLE))
      comment: "Average applicable minimum wage across determinations"
    - name: "avg_ot_threshold_hours"
      expr: AVG(CAST(ot_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_placement_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Placement compliance checkpoint metrics tracking pre-placement verification and clearance effectiveness"
  source: "`staffing_hr_ecm`.`compliance`.`placement_compliance_check`"
  dimensions:
    - name: "check_status"
      expr: check_status
      comment: "Current status of the compliance check"
    - name: "overall_compliance_result"
      expr: overall_compliance_result
      comment: "Overall compliance result (cleared, conditional, blocked)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (direct hire, contract, temp-to-perm, etc.)"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status"
    - name: "drug_screen_status"
      expr: drug_screen_status
      comment: "Drug screen status"
    - name: "credential_verification_status"
      expr: credential_verification_status
      comment: "Credential verification status"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding status"
    - name: "ofccp_applicability_flag"
      expr: ofccp_applicability_flag
      comment: "Whether OFCCP requirements apply to this placement"
    - name: "eeoc_self_id_collected"
      expr: eeoc_self_id_collected
      comment: "Whether EEOC self-identification data was collected"
    - name: "check_year"
      expr: YEAR(check_initiated_date)
      comment: "Year the compliance check was initiated"
    - name: "check_quarter"
      expr: CONCAT('Q', QUARTER(check_initiated_date))
      comment: "Quarter the compliance check was initiated"
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of placement compliance checks"
    - name: "cleared_placements"
      expr: COUNT(CASE WHEN overall_compliance_result = 'cleared' THEN 1 END)
      comment: "Number of placements cleared for compliance"
    - name: "blocked_placements"
      expr: COUNT(CASE WHEN overall_compliance_result = 'blocked' THEN 1 END)
      comment: "Number of placements blocked due to compliance issues"
    - name: "clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_compliance_result = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of placements cleared for compliance"
    - name: "block_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_compliance_result = 'blocked' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of placements blocked due to compliance issues"
    - name: "bgc_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bgc_status = 'clear' THEN 1 END) / NULLIF(COUNT(CASE WHEN bgc_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of background checks that passed"
    - name: "drug_screen_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drug_screen_status = 'negative' THEN 1 END) / NULLIF(COUNT(CASE WHEN drug_screen_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of drug screens that passed"
    - name: "avg_time_to_clearance_days"
      expr: AVG(DATEDIFF(clearance_date, check_initiated_date))
      comment: "Average time from check initiation to clearance in days"
    - name: "avg_bgc_completion_days"
      expr: AVG(DATEDIFF(bgc_completion_date, check_initiated_date))
      comment: "Average time to background check completion in days"
    - name: "ofccp_applicable_placements"
      expr: COUNT(CASE WHEN ofccp_applicability_flag = TRUE THEN 1 END)
      comment: "Number of placements subject to OFCCP requirements"
    - name: "eeoc_self_id_collection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eeoc_self_id_collected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of placements where EEOC self-identification was collected"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`compliance_workers_comp_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workers compensation policy and claims cost metrics for risk management and premium optimization"
  source: "`staffing_hr_ecm`.`compliance`.`workers_comp_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the workers compensation policy"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of workers compensation policy"
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the workers compensation claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of workers compensation claim"
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Whether the claim is in litigation"
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether subrogation is being pursued"
    - name: "policy_year"
      expr: YEAR(policy_effective_date)
      comment: "Policy year"
    - name: "claim_year"
      expr: YEAR(claim_filing_date)
      comment: "Year the claim was filed"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
  measures:
    - name: "total_policies"
      expr: COUNT(DISTINCT policy_number)
      comment: "Total number of distinct workers compensation policies"
    - name: "total_claims"
      expr: COUNT(CASE WHEN claim_number IS NOT NULL THEN 1 END)
      comment: "Total number of workers compensation claims"
    - name: "total_annual_premium"
      expr: SUM(CAST(annual_premium_amount AS DOUBLE))
      comment: "Total annual workers compensation premium"
    - name: "total_incurred_claims_cost"
      expr: SUM(CAST(total_incurred_amount AS DOUBLE))
      comment: "Total incurred cost across all claims"
    - name: "total_paid_medical"
      expr: SUM(CAST(paid_medical_amount AS DOUBLE))
      comment: "Total paid medical costs across all claims"
    - name: "total_paid_indemnity"
      expr: SUM(CAST(paid_indemnity_amount AS DOUBLE))
      comment: "Total paid indemnity costs across all claims"
    - name: "avg_claim_incurred_cost"
      expr: AVG(CAST(total_incurred_amount AS DOUBLE))
      comment: "Average incurred cost per claim"
    - name: "avg_emr"
      expr: AVG(CAST(emr AS DOUBLE))
      comment: "Average experience modification rate (EMR) across policies"
    - name: "claims_in_litigation"
      expr: COUNT(CASE WHEN litigation_flag = TRUE THEN 1 END)
      comment: "Number of claims in litigation"
    - name: "litigation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN litigation_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN claim_number IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of claims in litigation"
    - name: "claims_with_subrogation"
      expr: COUNT(CASE WHEN subrogation_flag = TRUE THEN 1 END)
      comment: "Number of claims with subrogation being pursued"
    - name: "avg_lost_work_days"
      expr: AVG(CAST(lost_work_days AS INT))
      comment: "Average number of lost work days per claim"
    - name: "loss_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_incurred_amount AS DOUBLE)) / NULLIF(SUM(CAST(annual_premium_amount AS DOUBLE)), 0), 2)
      comment: "Loss ratio (incurred claims cost as percentage of premium)"
$$;