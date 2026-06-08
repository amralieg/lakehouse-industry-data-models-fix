-- Metric views for domain: compliance | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic regulatory compliance KPIs tracking obligation status, risk exposure, and penalty exposure across jurisdictions and frameworks"
  source: "`legal_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or legal jurisdiction where the obligation applies"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework or standard (e.g., GDPR, SOX, AML)"
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of regulatory obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the obligation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for addressing the obligation"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body or authority governing this obligation"
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active"
    - name: "external_audit_required_flag"
      expr: external_audit_required_flag
      comment: "Whether external audit is required for this obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total count of regulatory obligations"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations"
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty amount per obligation"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with obligations"
    - name: "distinct_frameworks"
      expr: COUNT(DISTINCT regulatory_framework)
      comment: "Number of distinct regulatory frameworks"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_regulatory_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical breach management KPIs tracking regulatory violations, financial impact, remediation effectiveness, and regulatory notification compliance"
  source: "`legal_ecm`.`compliance`.`regulatory_breach`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the regulatory breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type of regulatory breach"
    - name: "breach_category"
      expr: breach_category
      comment: "Category of regulatory breach"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the breach"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "client_notification_required_flag"
      expr: client_notification_required_flag
      comment: "Whether client notification is required"
    - name: "escalated_to_executive_flag"
      expr: escalated_to_executive_flag
      comment: "Whether breach was escalated to executive level"
    - name: "professional_indemnity_claim_flag"
      expr: professional_indemnity_claim_flag
      comment: "Whether a professional indemnity claim was filed"
    - name: "discovery_method"
      expr: discovery_method
      comment: "Method by which the breach was discovered"
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total count of regulatory breaches"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all breaches"
    - name: "total_regulatory_penalties"
      expr: SUM(CAST(regulatory_penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed"
    - name: "avg_financial_impact_per_breach"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per breach"
    - name: "avg_regulatory_penalty"
      expr: AVG(CAST(regulatory_penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per breach"
    - name: "breaches_requiring_notification"
      expr: SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring regulatory notification"
    - name: "breaches_escalated_to_executive"
      expr: SUM(CASE WHEN escalated_to_executive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches escalated to executive level"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit effectiveness and remediation KPIs tracking finding severity, closure rates, and remediation timeliness"
  source: "`legal_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the audit finding"
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "verification_status"
      expr: verification_status
      comment: "Status of finding verification"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for remediation"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework related to the finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total count of audit findings"
    - name: "findings_requiring_escalation"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings requiring escalation"
    - name: "findings_requiring_regulatory_report"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings requiring regulatory reporting"
    - name: "distinct_responsible_departments"
      expr: COUNT(DISTINCT responsible_department)
      comment: "Number of distinct departments with findings"
    - name: "distinct_audit_engagements"
      expr: COUNT(DISTINCT audit_engagement_id)
      comment: "Number of distinct audit engagements with findings"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_privacy_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data privacy incident KPIs tracking breach impact, notification compliance, regulatory penalties, and remediation effectiveness"
  source: "`legal_ecm`.`compliance`.`privacy_breach`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the privacy breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type of privacy breach"
    - name: "risk_assessment_to_data_subjects"
      expr: risk_assessment_to_data_subjects
      comment: "Risk assessment outcome for affected data subjects"
    - name: "supervisory_authority_notification_required_flag"
      expr: supervisory_authority_notification_required_flag
      comment: "Whether supervisory authority notification is required"
    - name: "data_subject_notification_required_flag"
      expr: data_subject_notification_required_flag
      comment: "Whether data subject notification is required"
    - name: "special_category_data_involved_flag"
      expr: special_category_data_involved_flag
      comment: "Whether special category data was involved"
    - name: "dpo_notified_flag"
      expr: dpo_notified_flag
      comment: "Whether the DPO was notified"
    - name: "insurance_claim_filed_flag"
      expr: insurance_claim_filed_flag
      comment: "Whether an insurance claim was filed"
    - name: "post_incident_review_completed_flag"
      expr: post_incident_review_completed_flag
      comment: "Whether post-incident review was completed"
    - name: "discovery_method"
      expr: discovery_method
      comment: "Method by which the breach was discovered"
  measures:
    - name: "total_privacy_breaches"
      expr: COUNT(1)
      comment: "Total count of privacy breaches"
    - name: "total_regulatory_penalties"
      expr: SUM(CAST(regulatory_penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties for privacy breaches"
    - name: "avg_regulatory_penalty"
      expr: AVG(CAST(regulatory_penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per breach"
    - name: "breaches_requiring_authority_notification"
      expr: SUM(CASE WHEN supervisory_authority_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring supervisory authority notification"
    - name: "breaches_requiring_subject_notification"
      expr: SUM(CASE WHEN data_subject_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring data subject notification"
    - name: "breaches_with_special_category_data"
      expr: SUM(CASE WHEN special_category_data_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches involving special category data"
    - name: "breaches_with_insurance_claims"
      expr: SUM(CASE WHEN insurance_claim_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches with insurance claims filed"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_control_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control testing effectiveness KPIs tracking test outcomes, exception rates, and remediation requirements"
  source: "`legal_ecm`.`compliance`.`compliance_control_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the control test"
    - name: "test_conclusion"
      expr: test_conclusion
      comment: "Conclusion of the control test"
    - name: "test_type"
      expr: test_type
      comment: "Type of control test performed"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on test results"
    - name: "control_deficiency_severity"
      expr: control_deficiency_severity
      comment: "Severity of any control deficiency identified"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required"
    - name: "external_auditor_flag"
      expr: external_auditor_flag
      comment: "Whether test was performed by external auditor"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework under which test was performed"
    - name: "sampling_method"
      expr: sampling_method
      comment: "Sampling method used for testing"
    - name: "testing_frequency"
      expr: testing_frequency
      comment: "Frequency of control testing"
  measures:
    - name: "total_control_tests"
      expr: COUNT(1)
      comment: "Total count of control tests performed"
    - name: "avg_exception_rate"
      expr: AVG(CAST(exception_rate_percentage AS DOUBLE))
      comment: "Average exception rate across all tests"
    - name: "tests_requiring_remediation"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tests requiring remediation"
    - name: "tests_by_external_auditors"
      expr: SUM(CASE WHEN external_auditor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tests performed by external auditors"
    - name: "distinct_controls_tested"
      expr: COUNT(DISTINCT compliance_control_id)
      comment: "Number of distinct controls tested"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_aml_kyc_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AML/KYC program effectiveness KPIs tracking risk ratings, training completion, and audit status"
  source: "`legal_ecm`.`compliance`.`aml_kyc_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the AML/KYC program"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating of the program"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Rating of control effectiveness"
    - name: "client_risk_rating"
      expr: client_risk_rating
      comment: "Client risk rating"
    - name: "geographic_risk_rating"
      expr: geographic_risk_rating
      comment: "Geographic risk rating"
    - name: "product_service_risk_rating"
      expr: product_service_risk_rating
      comment: "Product/service risk rating"
    - name: "delivery_channel_risk_rating"
      expr: delivery_channel_risk_rating
      comment: "Delivery channel risk rating"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status"
    - name: "risk_assessment_frequency"
      expr: risk_assessment_frequency
      comment: "Frequency of risk assessments"
  measures:
    - name: "total_aml_programs"
      expr: COUNT(1)
      comment: "Total count of AML/KYC programs"
    - name: "avg_training_completion_rate"
      expr: AVG(CAST(training_completion_rate AS DOUBLE))
      comment: "Average training completion rate across programs"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT applicable_jurisdictions)
      comment: "Number of distinct jurisdictions covered"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_indemnity_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional indemnity claim KPIs tracking claim exposure, settlement amounts, and defence costs"
  source: "`legal_ecm`.`compliance`.`indemnity_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the indemnity claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of indemnity claim"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the claim"
    - name: "coverage_confirmation_status"
      expr: coverage_confirmation_status
      comment: "Status of coverage confirmation"
    - name: "sra_reportable_flag"
      expr: sra_reportable_flag
      comment: "Whether claim is reportable to SRA"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant"
    - name: "closure_reason"
      expr: closure_reason
      comment: "Reason for claim closure"
    - name: "insurer_name"
      expr: insurer_name
      comment: "Name of the insurer"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the claim"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total count of indemnity claims"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated exposure across all claims"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid"
    - name: "total_defence_costs"
      expr: SUM(CAST(defence_costs_amount AS DOUBLE))
      comment: "Total defence costs incurred"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amounts held"
    - name: "avg_estimated_exposure"
      expr: AVG(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Average estimated exposure per claim"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "claims_reportable_to_sra"
      expr: SUM(CASE WHEN sra_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims reportable to SRA"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_training_programme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training effectiveness KPIs tracking program coverage, CPD credits, and assessment requirements"
  source: "`legal_ecm`.`compliance`.`training_programme`"
  dimensions:
    - name: "programme_status"
      expr: programme_status
      comment: "Current status of the training programme"
    - name: "training_category"
      expr: training_category
      comment: "Category of training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format of training delivery"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience for the training"
    - name: "target_role_category"
      expr: target_role_category
      comment: "Target role category"
    - name: "assessment_required_flag"
      expr: assessment_required_flag
      comment: "Whether assessment is required"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether certificate is issued upon completion"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework addressed by training"
    - name: "frequency"
      expr: frequency
      comment: "Frequency of training requirement"
  measures:
    - name: "total_training_programmes"
      expr: COUNT(1)
      comment: "Total count of training programmes"
    - name: "total_cpd_credits"
      expr: SUM(CAST(cpd_credits AS DOUBLE))
      comment: "Total CPD credits available across all programmes"
    - name: "avg_cpd_credits_per_programme"
      expr: AVG(CAST(cpd_credits AS DOUBLE))
      comment: "Average CPD credits per programme"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration in hours per programme"
    - name: "avg_cost_per_participant"
      expr: AVG(CAST(cost_per_participant AS DOUBLE))
      comment: "Average cost per participant"
    - name: "avg_pass_mark_percentage"
      expr: AVG(CAST(pass_mark_percentage AS DOUBLE))
      comment: "Average pass mark percentage across programmes"
    - name: "programmes_requiring_assessment"
      expr: SUM(CASE WHEN assessment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programmes requiring assessment"
    - name: "programmes_issuing_certificates"
      expr: SUM(CASE WHEN certificate_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programmes issuing certificates"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_data_subject_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDPR data subject request KPIs tracking request volumes, processing times, and statutory deadline compliance"
  source: "`legal_ecm`.`compliance`.`data_subject_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the data subject request"
    - name: "request_type"
      expr: request_type
      comment: "Type of data subject request"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the request"
    - name: "receipt_channel"
      expr: receipt_channel
      comment: "Channel through which request was received"
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification"
    - name: "extension_applied_flag"
      expr: extension_applied_flag
      comment: "Whether deadline extension was applied"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether request was escalated"
    - name: "complaint_lodged_flag"
      expr: complaint_lodged_flag
      comment: "Whether complaint was lodged"
    - name: "lpp_exemption_flag"
      expr: lpp_exemption_flag
      comment: "Whether legal professional privilege exemption applies"
    - name: "third_party_data_flag"
      expr: third_party_data_flag
      comment: "Whether third party data is involved"
  measures:
    - name: "total_data_subject_requests"
      expr: COUNT(1)
      comment: "Total count of data subject requests"
    - name: "requests_with_extensions"
      expr: SUM(CASE WHEN extension_applied_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests with deadline extensions"
    - name: "requests_escalated"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated requests"
    - name: "requests_with_complaints"
      expr: SUM(CASE WHEN complaint_lodged_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests with complaints lodged"
    - name: "requests_with_lpp_exemption"
      expr: SUM(CASE WHEN lpp_exemption_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests with LPP exemption applied"
    - name: "distinct_request_types"
      expr: COUNT(DISTINCT request_type)
      comment: "Number of distinct request types"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_sar_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspicious Activity Report filing KPIs tracking SAR volumes, filing timeliness, consent requests, and law enforcement engagement"
  source: "`legal_ecm`.`compliance`.`sar_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the SAR filing"
    - name: "filing_jurisdiction"
      expr: filing_jurisdiction
      comment: "Jurisdiction where SAR was filed"
    - name: "filing_authority"
      expr: filing_authority
      comment: "Authority to which SAR was filed"
    - name: "suspicion_category"
      expr: suspicion_category
      comment: "Category of suspicious activity"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject (individual, entity, etc.)"
    - name: "consent_request_flag"
      expr: consent_request_flag
      comment: "Whether consent was requested"
    - name: "consent_outcome"
      expr: consent_outcome
      comment: "Outcome of consent request"
    - name: "follow_up_action_required"
      expr: follow_up_action_required
      comment: "Whether follow-up action is required"
    - name: "relationship_terminated_flag"
      expr: relationship_terminated_flag
      comment: "Whether client relationship was terminated"
    - name: "tipping_off_risk_flag"
      expr: tipping_off_risk_flag
      comment: "Whether tipping off risk was identified"
  measures:
    - name: "total_sar_filings"
      expr: COUNT(1)
      comment: "Total count of SAR filings"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all SARs"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per SAR"
    - name: "sars_with_consent_requests"
      expr: SUM(CASE WHEN consent_request_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SARs with consent requests"
    - name: "sars_requiring_follow_up"
      expr: SUM(CASE WHEN follow_up_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SARs requiring follow-up action"
    - name: "sars_with_relationship_termination"
      expr: SUM(CASE WHEN relationship_terminated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SARs resulting in relationship termination"
    - name: "sars_with_tipping_off_risk"
      expr: SUM(CASE WHEN tipping_off_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SARs with tipping off risk"
    - name: "distinct_filing_authorities"
      expr: COUNT(DISTINCT filing_authority)
      comment: "Number of distinct filing authorities"
$$;