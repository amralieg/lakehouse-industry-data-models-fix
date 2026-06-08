-- Metric views for domain: compliance | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic regulatory compliance tracking metrics including risk exposure, penalty exposure, and compliance rate across obligations"
  source: "`health_insurance_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., reporting, accreditation, audit)"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body or agency imposing the obligation"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Framework or regulation set (e.g., HIPAA, ACA, state insurance law)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or legal jurisdiction of the obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "risk_impact"
      expr: risk_impact
      comment: "Impact level of non-compliance risk"
    - name: "risk_likelihood"
      expr: risk_likelihood
      comment: "Likelihood of non-compliance occurrence"
    - name: "is_federal"
      expr: is_federal
      comment: "Whether the obligation is federal (true) or state/local (false)"
    - name: "frequency"
      expr: frequency
      comment: "Reporting or compliance frequency"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the obligation became effective"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligations"
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation"
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across obligations for portfolio risk view"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per obligation"
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_impact = 'High' OR risk_likelihood = 'High' THEN 1 END)
      comment: "Count of obligations with high risk impact or likelihood"
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND compliance_status != 'Compliant' THEN 1 END)
      comment: "Count of obligations past due date and not compliant"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit program performance metrics including cost efficiency, finding rates, and remediation effectiveness"
  source: "`health_insurance_ecm`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external, regulatory)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit focus area"
    - name: "audit_engagement_status"
      expr: audit_engagement_status
      comment: "Current status of the audit engagement"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework being audited"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome or result of the audit"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit area"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "audit_priority"
      expr: audit_priority
      comment: "Priority level of the audit"
    - name: "audit_followup_required"
      expr: audit_followup_required
      comment: "Whether follow-up audit is required"
    - name: "engagement_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the audit engagement started"
    - name: "engagement_quarter"
      expr: CONCAT('Q', QUARTER(engagement_start_date), '-', YEAR(engagement_start_date))
      comment: "Quarter and year the audit engagement started"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit engagements"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual cost of audit engagements"
    - name: "total_audit_budget"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated budget for audit engagements"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average actual cost per audit engagement"
    - name: "audits_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings IS NOT NULL AND critical_findings != '' THEN 1 END)
      comment: "Count of audits that identified critical findings"
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Count of audits requiring follow-up action"
    - name: "high_risk_audits"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Count of audits with high risk rating"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation metrics including financial impact, closure rates, and repeat finding trends"
  source: "`health_insurance_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type or classification of the audit finding"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area where finding was identified"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action plan"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the finding is critical"
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Whether this is a repeat finding from prior audits"
    - name: "priority"
      expr: priority
      comment: "Priority level for remediation"
    - name: "affected_business_area"
      expr: affected_business_area
      comment: "Business area affected by the finding"
    - name: "identified_year"
      expr: YEAR(identified_timestamp)
      comment: "Year the finding was identified"
    - name: "identified_quarter"
      expr: CONCAT('Q', QUARTER(identified_timestamp), '-', YEAR(identified_timestamp))
      comment: "Quarter and year the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding"
    - name: "critical_findings"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical findings"
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Count of repeat findings indicating systemic issues"
    - name: "closed_findings"
      expr: COUNT(CASE WHEN closed_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of findings that have been closed"
    - name: "overdue_findings"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND closed_timestamp IS NULL THEN 1 END)
      comment: "Count of findings past due date and not yet closed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan effectiveness metrics including completion rates, cost variance, and remediation cycle time"
  source: "`health_insurance_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Current status of the corrective action plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category addressed by the plan"
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue being corrected"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "owner_role"
      expr: owner_role
      comment: "Role responsible for executing the plan"
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Whether the plan stems from an external audit"
    - name: "is_fwa_monitoring"
      expr: is_fwa_monitoring
      comment: "Whether the plan is related to fraud, waste, and abuse monitoring"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body requiring the corrective action"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the corrective action plan was created"
    - name: "created_quarter"
      expr: CONCAT('Q', QUARTER(created_timestamp), '-', YEAR(created_timestamp))
      comment: "Quarter and year the corrective action plan was created"
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of all corrective action plans"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of completed corrective action plans"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per corrective action plan"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per completed corrective action plan"
    - name: "completed_caps"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Count of corrective action plans that have been completed"
    - name: "overdue_caps"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND actual_completion_date IS NULL THEN 1 END)
      comment: "Count of corrective action plans past target date and not completed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data breach impact and response metrics including affected individuals, notification compliance, and resolution time"
  source: "`health_insurance_ecm`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach (e.g., unauthorized access, theft, loss)"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach incident"
    - name: "breach_source"
      expr: breach_source
      comment: "Source or origin of the breach"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify affected individuals"
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Status of regulatory filing for the breach"
    - name: "business_associate_involved"
      expr: business_associate_involved
      comment: "Whether a business associate was involved in the breach"
    - name: "hhs_notified"
      expr: hhs_notified
      comment: "Whether HHS (Department of Health and Human Services) was notified"
    - name: "state_notified"
      expr: state_notified
      comment: "Whether state authorities were notified"
    - name: "discovery_year"
      expr: YEAR(breach_discovery_date)
      comment: "Year the breach was discovered"
    - name: "discovery_quarter"
      expr: CONCAT('Q', QUARTER(breach_discovery_date), '-', YEAR(breach_discovery_date))
      comment: "Quarter and year the breach was discovered"
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total number of breach incidents"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach incidents"
    - name: "breaches_with_ba_involvement"
      expr: COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END)
      comment: "Count of breaches involving business associates"
    - name: "breaches_reported_to_hhs"
      expr: COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END)
      comment: "Count of breaches reported to HHS (typically 500+ individuals)"
    - name: "resolved_breaches"
      expr: COUNT(CASE WHEN breach_resolution_date IS NOT NULL THEN 1 END)
      comment: "Count of breach incidents that have been resolved"
    - name: "notification_confirmed_breaches"
      expr: COUNT(CASE WHEN notification_delivery_confirmation = TRUE THEN 1 END)
      comment: "Count of breaches where notification delivery was confirmed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud, waste, and abuse detection and recovery metrics including exposure amounts, recovery rates, and case resolution"
  source: "`health_insurance_ecm`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (fraud, waste, or abuse)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the FWA case"
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition or outcome of the case"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject (provider, member, broker, etc.)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the FWA referral"
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of initial triage assessment"
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Whether the case is classified as high risk"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the case requires regulatory reporting"
    - name: "case_open_year"
      expr: YEAR(case_open_timestamp)
      comment: "Year the case was opened"
    - name: "case_open_quarter"
      expr: CONCAT('Q', QUARTER(case_open_timestamp), '-', YEAR(case_open_timestamp))
      comment: "Quarter and year the case was opened"
  measures:
    - name: "total_fwa_cases"
      expr: COUNT(1)
      comment: "Total number of fraud, waste, and abuse cases"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all FWA cases"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases"
    - name: "avg_estimated_exposure"
      expr: AVG(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Average estimated exposure per FWA case"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per FWA case"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across FWA cases"
    - name: "high_risk_cases"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Count of high-risk FWA cases"
    - name: "cases_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of cases requiring regulatory reporting"
    - name: "closed_cases"
      expr: COUNT(CASE WHEN disposition_date IS NOT NULL THEN 1 END)
      comment: "Count of FWA cases that have been closed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio compliance metrics including MLR percentages, rebate obligations, and premium/claims ratios by market segment"
  source: "`health_insurance_ecm`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year for which MLR is being calculated and reported"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., individual, small group, large group)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for MLR calculation"
    - name: "mlr_calculation_status"
      expr: mlr_calculation_status
      comment: "Status of the MLR calculation"
    - name: "rebate_eligibility_flag"
      expr: rebate_eligibility_flag
      comment: "Whether rebates are required based on MLR threshold"
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement to members"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the MLR calculation was performed"
  measures:
    - name: "total_mlr_calculations"
      expr: COUNT(1)
      comment: "Total number of MLR calculations"
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium across all MLR calculations"
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims across all MLR calculations"
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses_amount AS DOUBLE))
      comment: "Total quality improvement expenses across all MLR calculations"
    - name: "total_rebate_obligation"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed to members due to MLR non-compliance"
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across calculations"
    - name: "calculations_requiring_rebate"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of MLR calculations that triggered rebate requirements"
    - name: "rebates_disbursed"
      expr: COUNT(CASE WHEN rebate_disbursement_date IS NOT NULL THEN 1 END)
      comment: "Count of MLR rebates that have been disbursed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics including on-time submission rates, filing costs, and acceptance rates"
  source: "`health_insurance_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission"
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the regulatory submission"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (e.g., electronic, paper)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the submission is critical/high priority"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for rejection if applicable"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was made"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter and year the submission was made"
    - name: "filing_period_year"
      expr: YEAR(filing_period_start)
      comment: "Year of the filing period being reported"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid for regulatory submissions"
    - name: "total_net_fees"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fees after adjustments"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission"
    - name: "critical_submissions"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical regulatory submissions"
    - name: "accepted_submissions"
      expr: COUNT(CASE WHEN acceptance_date IS NOT NULL THEN 1 END)
      comment: "Count of submissions that have been accepted"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN rejection_reason_code IS NOT NULL AND rejection_reason_code != '' THEN 1 END)
      comment: "Count of submissions that were rejected"
    - name: "on_time_submissions"
      expr: COUNT(CASE WHEN submission_date <= due_date THEN 1 END)
      comment: "Count of submissions made on or before due date"
    - name: "late_submissions"
      expr: COUNT(CASE WHEN submission_date > due_date THEN 1 END)
      comment: "Count of submissions made after due date"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics including completion rates, final scores, and accreditation status by body and type"
  source: "`health_insurance_ecm`.`compliance`.`accreditation_program`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., NCQA, URAC, AAAHC)"
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Organization providing the accreditation"
    - name: "accreditation_program_status"
      expr: accreditation_program_status
      comment: "Current status of the accreditation program"
    - name: "accreditation_program_level"
      expr: accreditation_program_level
      comment: "Level or tier of accreditation achieved"
    - name: "decision"
      expr: decision
      comment: "Accreditation decision (e.g., accredited, denied, provisional)"
    - name: "rating"
      expr: rating
      comment: "Rating or grade assigned by accrediting body"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the accreditation area"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the accreditation is critical for business operations"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether issues have been escalated"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of accreditation survey conducted"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the accreditation became effective"
  measures:
    - name: "total_accreditation_programs"
      expr: COUNT(1)
      comment: "Total number of accreditation programs"
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average final accreditation score"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across accreditation programs"
    - name: "critical_accreditations"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical accreditation programs"
    - name: "escalated_accreditations"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Count of accreditation programs with escalated issues"
    - name: "fully_accredited"
      expr: COUNT(CASE WHEN decision = 'Accredited' OR accreditation_program_status = 'Accredited' THEN 1 END)
      comment: "Count of programs that achieved full accreditation"
$$;