-- Metric views for domain: compliance | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance and compliance tracking metrics for monitoring filing timeliness, fee management, and regulatory body relationships."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority receiving the submission (e.g., CMS, state DOI)"
    - name: "submission_type"
      expr: submission_type
      comment: "Category of regulatory filing (e.g., rate filing, network adequacy, MLR report)"
    - name: "submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (e.g., draft, submitted, accepted, rejected)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was filed"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date))
      comment: "Quarter the submission was filed"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the submission was filed"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the submission is business-critical"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used for submission (e.g., SERFF, portal, email)"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all submissions"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission"
    - name: "accepted_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'accepted' THEN 1 END)
      comment: "Number of submissions accepted by regulatory bodies"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'rejected' THEN 1 END)
      comment: "Number of submissions rejected by regulatory bodies"
    - name: "critical_submissions"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of business-critical submissions"
    - name: "on_time_submissions"
      expr: COUNT(CASE WHEN submission_date <= due_date THEN 1 END)
      comment: "Number of submissions filed on or before the due date"
    - name: "late_submissions"
      expr: COUNT(CASE WHEN submission_date > due_date THEN 1 END)
      comment: "Number of submissions filed after the due date"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit engagement performance metrics tracking audit costs, outcomes, findings, and remediation effectiveness across regulatory and internal audits."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., regulatory, internal, financial, operational)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit focus area"
    - name: "audit_status"
      expr: audit_engagement_status
      comment: "Current status of the audit engagement"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the audit (e.g., pass, fail, conditional)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit engagement"
    - name: "audit_body"
      expr: audit_body
      comment: "Organization conducting the audit"
    - name: "audit_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the audit engagement started"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(engagement_start_date))
      comment: "Quarter the audit engagement started"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework being audited (e.g., HIPAA, SOC2, NCQA)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts following the audit"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit engagements"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual cost of all audit engagements"
    - name: "total_audit_estimate"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all audit engagements"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average actual cost per audit engagement"
    - name: "total_findings"
      expr: SUM(CAST(total_findings AS DOUBLE))
      comment: "Total number of audit findings across all engagements"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(total_findings AS DOUBLE))
      comment: "Average number of findings per audit engagement"
    - name: "audits_with_followup"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up action"
    - name: "high_risk_audits"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN 1 END)
      comment: "Number of audits with high risk rating"
    - name: "completed_audits"
      expr: COUNT(CASE WHEN audit_engagement_status = 'completed' THEN 1 END)
      comment: "Number of completed audit engagements"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan effectiveness metrics tracking remediation progress, costs, milestone completion, and compliance deadline adherence."
  source: "`vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: corrective_action_plan_status
      comment: "Current status of the corrective action plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action plan"
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue being addressed"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance issue being remediated"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body requiring the corrective action"
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Flag indicating whether the CAP stems from an external audit"
    - name: "is_fwa_monitoring"
      expr: is_fwa_monitoring
      comment: "Flag indicating whether the CAP is related to fraud, waste, and abuse monitoring"
    - name: "cap_year"
      expr: YEAR(target_completion_date)
      comment: "Year the CAP is targeted for completion"
    - name: "cap_quarter"
      expr: CONCAT('Q', QUARTER(target_completion_date))
      comment: "Quarter the CAP is targeted for completion"
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of all corrective action plans"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of all corrective action plans"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per corrective action plan"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per corrective action plan"
    - name: "completed_caps"
      expr: COUNT(CASE WHEN corrective_action_plan_status = 'completed' THEN 1 END)
      comment: "Number of completed corrective action plans"
    - name: "overdue_caps"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND corrective_action_plan_status != 'completed' THEN 1 END)
      comment: "Number of corrective action plans past their target completion date"
    - name: "high_priority_caps"
      expr: COUNT(CASE WHEN priority = 'high' THEN 1 END)
      comment: "Number of high-priority corrective action plans"
    - name: "external_audit_caps"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Number of corrective action plans stemming from external audits"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Breach incident impact and response metrics tracking affected individuals, notification compliance, resolution time, and regulatory reporting."
  source: "`vibe_health_insurance_v1`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach incident (e.g., unauthorized access, theft, loss)"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach incident"
    - name: "breach_source"
      expr: breach_source
      comment: "Source or origin of the breach"
    - name: "business_associate_involved"
      expr: business_associate_involved
      comment: "Flag indicating whether a business associate was involved in the breach"
    - name: "hhs_notified"
      expr: hhs_notified
      comment: "Flag indicating whether HHS was notified of the breach"
    - name: "state_notified"
      expr: state_notified
      comment: "Flag indicating whether state authorities were notified"
    - name: "breach_year"
      expr: YEAR(breach_occurrence_date)
      comment: "Year the breach occurred"
    - name: "breach_quarter"
      expr: CONCAT('Q', QUARTER(breach_occurrence_date))
      comment: "Quarter the breach occurred"
    - name: "breach_month"
      expr: DATE_TRUNC('MONTH', breach_occurrence_date)
      comment: "Month the breach occurred"
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Status of regulatory filing for the breach"
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total number of breach incidents"
    - name: "breaches_with_ba_involvement"
      expr: COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END)
      comment: "Number of breaches involving business associates"
    - name: "breaches_reported_to_hhs"
      expr: COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END)
      comment: "Number of breaches reported to HHS"
    - name: "breaches_reported_to_state"
      expr: COUNT(CASE WHEN state_notified = TRUE THEN 1 END)
      comment: "Number of breaches reported to state authorities"
    - name: "resolved_breaches"
      expr: COUNT(CASE WHEN breach_status = 'resolved' THEN 1 END)
      comment: "Number of resolved breach incidents"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across all breach incidents"
    - name: "high_risk_breaches"
      expr: COUNT(CASE WHEN risk_assessment_score >= 7.0 THEN 1 END)
      comment: "Number of breaches with high risk assessment scores (7.0 or above)"
    - name: "breaches_with_notification_confirmed"
      expr: COUNT(CASE WHEN notification_delivery_confirmation = TRUE THEN 1 END)
      comment: "Number of breaches where notification delivery was confirmed"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio calculation and rebate metrics tracking MLR percentages, premium and claims amounts, rebate obligations, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year for which the MLR is being calculated"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., individual, small group, large group)"
    - name: "market_segment"
      expr: market_segment_code
      comment: "Market segment code for the MLR calculation"
    - name: "mlr_status"
      expr: mlr_calculation_status
      comment: "Status of the MLR calculation"
    - name: "rebate_eligibility"
      expr: rebate_eligibility_flag
      comment: "Flag indicating whether a rebate is required"
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement to members"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the MLR calculation was performed"
    - name: "calculation_quarter"
      expr: CONCAT('Q', QUARTER(calculation_date))
      comment: "Quarter the MLR calculation was performed"
  measures:
    - name: "total_calculations"
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
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed to members"
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across all calculations"
    - name: "calculations_requiring_rebate"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of MLR calculations requiring rebate payments"
    - name: "rebates_disbursed"
      expr: COUNT(CASE WHEN rebate_disbursement_status = 'disbursed' THEN 1 END)
      comment: "Number of rebates successfully disbursed to members"
    - name: "avg_rebate_per_calculation"
      expr: AVG(CAST(rebate_amount AS DOUBLE))
      comment: "Average rebate amount per MLR calculation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud, waste, and abuse case management metrics tracking case volume, exposure amounts, recovery, disposition outcomes, and investigation effectiveness."
  source: "`vibe_health_insurance_v1`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (e.g., fraud, waste, abuse)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the FWA case"
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition of the FWA case"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject under investigation (e.g., provider, member, employee)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the FWA case referral"
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of the initial case triage"
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Flag indicating whether the case is high risk"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether the case requires regulatory reporting"
    - name: "case_open_year"
      expr: YEAR(case_open_timestamp)
      comment: "Year the FWA case was opened"
    - name: "case_open_quarter"
      expr: CONCAT('Q', QUARTER(case_open_timestamp))
      comment: "Quarter the FWA case was opened"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of FWA cases"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all FWA cases"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases"
    - name: "avg_estimated_exposure"
      expr: AVG(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Average estimated financial exposure per FWA case"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per FWA case"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all FWA cases"
    - name: "high_risk_cases"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Number of high-risk FWA cases"
    - name: "cases_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of FWA cases requiring regulatory reporting"
    - name: "closed_cases"
      expr: COUNT(CASE WHEN case_status = 'closed' THEN 1 END)
      comment: "Number of closed FWA cases"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and compliance metrics tracking completion rates, assessment scores, certification status, and regulatory training requirements."
  source: "`vibe_health_insurance_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "training_status"
      expr: training_completion_status
      comment: "Status of the training completion"
    - name: "training_type"
      expr: training_type
      comment: "Type of training completed"
    - name: "training_category"
      expr: training_category
      comment: "Category of training (e.g., compliance, clinical, technical)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the training assessment"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (e.g., online, in-person, hybrid)"
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met_flag
      comment: "Flag indicating whether compliance requirements were met"
    - name: "renewal_required"
      expr: renewal_required_flag
      comment: "Flag indicating whether training renewal is required"
    - name: "is_external_training"
      expr: is_external_training
      comment: "Flag indicating whether the training was provided by an external vendor"
    - name: "completion_year"
      expr: YEAR(completion_timestamp)
      comment: "Year the training was completed"
    - name: "completion_quarter"
      expr: CONCAT('Q', QUARTER(completion_timestamp))
      comment: "Quarter the training was completed"
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total number of training completions"
    - name: "total_training_hours"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total training hours completed across all records"
    - name: "avg_training_hours"
      expr: AVG(CAST(hours_completed AS DOUBLE))
      comment: "Average training hours completed per record"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of all training completions"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion"
    - name: "passed_trainings"
      expr: COUNT(CASE WHEN pass_fail_status = 'pass' THEN 1 END)
      comment: "Number of training completions with pass status"
    - name: "failed_trainings"
      expr: COUNT(CASE WHEN pass_fail_status = 'fail' THEN 1 END)
      comment: "Number of training completions with fail status"
    - name: "compliance_met_completions"
      expr: COUNT(CASE WHEN compliance_requirements_met_flag = TRUE THEN 1 END)
      comment: "Number of training completions meeting compliance requirements"
    - name: "external_trainings"
      expr: COUNT(CASE WHEN is_external_training = TRUE THEN 1 END)
      comment: "Number of training completions provided by external vendors"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics tracking accreditation status, survey outcomes, compliance scores, and renewal cycles."
  source: "`vibe_health_insurance_v1`.`compliance`.`accreditation_program`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., NCQA, URAC, AAAHC)"
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Organization providing the accreditation"
    - name: "program_status"
      expr: accreditation_program_status
      comment: "Current status of the accreditation program"
    - name: "decision"
      expr: decision
      comment: "Accreditation decision outcome"
    - name: "rating"
      expr: rating
      comment: "Accreditation rating received"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the accreditation program"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance being accredited"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the accreditation is business-critical"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Flag indicating whether the accreditation has been escalated"
    - name: "program_year"
      expr: YEAR(effective_from)
      comment: "Year the accreditation program became effective"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of accreditation programs"
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average final accreditation score across all programs"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all accreditation programs"
    - name: "critical_programs"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of business-critical accreditation programs"
    - name: "escalated_programs"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated accreditation programs"
    - name: "high_risk_programs"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of high-risk accreditation programs"
    - name: "accredited_programs"
      expr: COUNT(CASE WHEN decision = 'accredited' THEN 1 END)
      comment: "Number of programs that received accreditation"
    - name: "programs_with_high_score"
      expr: COUNT(CASE WHEN final_score >= 85.0 THEN 1 END)
      comment: "Number of programs with final score of 85 or above"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding metrics tracking finding volume, severity distribution, financial impact, remediation timeliness, and repeat finding rates."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type/classification of the audit finding"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding (critical, major, minor, observation)"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the audit finding"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area impacted by the finding"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the finding for remediation"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken for the finding"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the finding is classified as critical"
    - name: "is_repeat_finding"
      expr: CAST(is_repeat_finding AS STRING)
      comment: "Whether this is a repeat/recurring finding — key quality indicator"
    - name: "affected_business_area"
      expr: affected_business_area
      comment: "Business area affected by the finding"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit that produced this finding"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month when the finding was identified for trending"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume for compliance health assessment"
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical findings — high-priority executive escalation metric"
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings — indicates systemic compliance failures requiring root cause analysis"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount across all findings — quantifies compliance risk exposure"
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding — severity benchmark"
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status IN ('Open', 'In Progress', 'Pending') THEN 1 END)
      comment: "Count of findings still open or in progress — operational backlog indicator"
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND audit_finding_status NOT IN ('Closed', 'Resolved', 'Completed') THEN 1 END)
      comment: "Count of findings past their due date and not yet resolved — compliance risk escalation trigger"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_hipaa_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy request metrics tracking request volume, response timeliness, disposition outcomes, and appeal rates for member privacy rights compliance."
  source: "`vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of HIPAA privacy request (access, amendment, restriction, accounting of disclosures, etc.)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the privacy request"
    - name: "disposition"
      expr: disposition
      comment: "Disposition/outcome of the privacy request"
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the request was received"
    - name: "request_source"
      expr: request_source
      comment: "Source of the privacy request"
    - name: "is_appealed"
      expr: CAST(is_appealed AS STRING)
      comment: "Whether the request decision was appealed"
    - name: "disclosure_recipient_type"
      expr: disclosure_recipient_type
      comment: "Type of recipient for disclosure requests"
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of the PHI disclosure"
    - name: "request_received_month"
      expr: DATE_TRUNC('month', request_received_timestamp)
      comment: "Month when the request was received for trending"
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy requests — member rights compliance volume"
    - name: "appealed_request_count"
      expr: COUNT(CASE WHEN is_appealed = TRUE THEN 1 END)
      comment: "Number of privacy requests that were appealed — quality of initial decision-making indicator"
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND request_status NOT IN ('Completed', 'Closed', 'Responded') THEN 1 END)
      comment: "Number of privacy requests past their response due date — HIPAA compliance deadline risk"
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN disposition = 'Denied' THEN 1 END)
      comment: "Number of denied privacy requests — potential member satisfaction and compliance review trigger"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_policy_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy document lifecycle metrics tracking policy volume, review currency, expiration risk, and approval status to ensure governance documentation remains current and compliant."
  source: "`vibe_health_insurance_v1`.`compliance`.`policy_document`"
  dimensions:
    - name: "policy_document_category"
      expr: policy_document_category
      comment: "Category of the policy document"
    - name: "policy_document_status"
      expr: policy_document_status
      comment: "Current status of the policy document"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area the policy covers"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy document"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the policy"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the policy is currently active"
    - name: "policy_owner_department"
      expr: policy_owner_department
      comment: "Department owning the policy"
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted on the policy"
  measures:
    - name: "total_policy_documents"
      expr: COUNT(1)
      comment: "Total number of policy documents — governance documentation scope"
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active policies — operational governance coverage"
    - name: "expired_policy_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active policies past their expiration date — governance gap risk"
    - name: "policies_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of policies due for review — governance currency indicator"
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status IN ('Pending', 'In Review', 'Draft') THEN 1 END)
      comment: "Number of policies pending approval — governance pipeline backlog"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory change tracking metrics monitoring the volume, criticality, implementation status, and risk of regulatory changes impacting the health insurance organization."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "change_category"
      expr: change_category
      comment: "Category of regulatory change"
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (federal, state, local, etc.)"
    - name: "regulatory_change_status"
      expr: regulatory_change_status
      comment: "Current status of the regulatory change tracking"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of implementation of the regulatory change"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area impacted by the regulatory change"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory change (federal, specific state, etc.)"
    - name: "governing_body"
      expr: governing_body
      comment: "Governing body issuing the regulatory change"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the regulatory change is classified as critical"
    - name: "effective_date_quarter"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter when the regulatory change becomes effective"
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes tracked — regulatory landscape complexity indicator"
    - name: "critical_change_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical regulatory changes — high-priority compliance action items"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of regulatory changes — overall regulatory risk posture"
    - name: "pending_implementation_count"
      expr: COUNT(CASE WHEN implementation_status IN ('Pending', 'In Progress', 'Not Started') THEN 1 END)
      comment: "Number of regulatory changes pending implementation — compliance readiness gap"
    - name: "overdue_implementation_count"
      expr: COUNT(CASE WHEN implementation_target_date < CURRENT_DATE() AND implementation_status NOT IN ('Completed', 'Implemented') THEN 1 END)
      comment: "Number of regulatory changes past their implementation target date — compliance deadline risk"
$$;