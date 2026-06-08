-- Metric views for domain: compliance | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for compliance controls — tracks control effectiveness, remediation posture, and key/compensating control coverage to steer the firm's internal control environment."
  source: "`legal_ecm`.`compliance`.`compliance_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of control (preventive, detective, corrective) used to segment effectiveness analysis."
    - name: "control_status"
      expr: control_status
      comment: "Current lifecycle status of the control (active, retired, draft) for portfolio health monitoring."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Assessed effectiveness rating of the control, enabling prioritisation of remediation effort."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the control, used to focus management attention on high-risk areas."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current remediation status for controls with identified deficiencies."
    - name: "nature"
      expr: nature
      comment: "Nature of the control (manual, automated, hybrid) for operational efficiency analysis."
    - name: "frequency"
      expr: frequency
      comment: "Operating frequency of the control (daily, monthly, annual) for scheduling and coverage analysis."
    - name: "key_control_flag"
      expr: key_control_flag
      comment: "Indicates whether the control is designated as a key control, enabling focused executive reporting."
    - name: "sox_scoping_flag"
      expr: sox_scoping_flag
      comment: "Indicates whether the control is in scope for SOX compliance, critical for regulatory reporting."
    - name: "compensating_control_flag"
      expr: compensating_control_flag
      comment: "Flags controls that are compensating in nature, indicating reliance on secondary mitigations."
    - name: "last_test_date"
      expr: last_test_date
      comment: "Date the control was last tested, used to identify stale or untested controls."
    - name: "next_test_due_date"
      expr: next_test_due_date
      comment: "Date the next control test is due, enabling proactive scheduling and overdue tracking."
  measures:
    - name: "total_active_controls"
      expr: COUNT(CASE WHEN control_status = 'Active' THEN compliance_control_id END)
      comment: "Total number of active compliance controls in the portfolio. Executives use this to gauge the breadth of the control environment."
    - name: "key_controls_count"
      expr: COUNT(CASE WHEN key_control_flag = TRUE THEN compliance_control_id END)
      comment: "Number of controls designated as key controls. A decline signals erosion of the most critical risk mitigations."
    - name: "remediation_required_controls_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN compliance_control_id END)
      comment: "Number of controls requiring remediation. Directly drives remediation workload planning and risk exposure assessment."
    - name: "overdue_remediation_controls_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE AND remediation_due_date < CURRENT_DATE() THEN compliance_control_id END)
      comment: "Controls where remediation is past due. A leading indicator of regulatory exposure and audit findings risk."
    - name: "remediation_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE AND remediation_due_date < CURRENT_DATE() THEN compliance_control_id END) / NULLIF(COUNT(CASE WHEN remediation_required_flag = TRUE THEN compliance_control_id END), 0), 2)
      comment: "Percentage of remediation-required controls that are past their due date. A key risk management KPI for steering committees."
    - name: "sox_scoped_controls_count"
      expr: COUNT(CASE WHEN sox_scoping_flag = TRUE THEN compliance_control_id END)
      comment: "Number of controls in SOX scope. Directly relevant to external audit readiness and regulatory compliance posture."
    - name: "controls_overdue_for_testing_count"
      expr: COUNT(CASE WHEN next_test_due_date < CURRENT_DATE() AND control_status = 'Active' THEN compliance_control_id END)
      comment: "Active controls whose next test date has passed without a completed test. Signals gaps in the testing programme that increase audit risk."
    - name: "compensating_controls_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compensating_control_flag = TRUE THEN compliance_control_id END) / NULLIF(COUNT(compliance_control_id), 0), 2)
      comment: "Proportion of controls that are compensating rather than primary. A high rate indicates structural control weaknesses requiring investment."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_control_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the control testing programme — measures test outcomes, exception rates, and remediation posture to inform audit readiness and control assurance quality."
  source: "`legal_ecm`.`compliance`.`control_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the control test (completed, in-progress, overdue) for pipeline monitoring."
    - name: "test_conclusion"
      expr: test_conclusion
      comment: "Outcome conclusion of the test (effective, ineffective, partially effective) for assurance reporting."
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed (walkthrough, sample, full population) for methodology analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the tested control, enabling prioritisation of follow-up actions."
    - name: "control_deficiency_severity"
      expr: control_deficiency_severity
      comment: "Severity of any identified control deficiency (material weakness, significant deficiency, deficiency)."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Indicates whether the test result requires remediation action."
    - name: "external_auditor_flag"
      expr: external_auditor_flag
      comment: "Indicates whether the test was performed by an external auditor, relevant for independence and reliance assessments."
    - name: "testing_frequency"
      expr: testing_frequency
      comment: "Frequency at which the control is tested, used for programme coverage analysis."
    - name: "test_date"
      expr: test_date
      comment: "Date the test was performed, used for trend and timeliness analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework under which the test was conducted (SOX, ISO 27001, GDPR etc.)."
  measures:
    - name: "total_tests_completed"
      expr: COUNT(CASE WHEN test_status = 'Completed' THEN control_test_id END)
      comment: "Total number of completed control tests. Baseline measure of testing programme throughput used in audit readiness reporting."
    - name: "tests_with_exceptions_count"
      expr: COUNT(CASE WHEN test_conclusion = 'Ineffective' OR test_conclusion = 'Partially Effective' THEN control_test_id END)
      comment: "Number of tests that identified control exceptions or failures. Directly informs risk exposure and remediation prioritisation."
    - name: "exception_rate_pct"
      expr: ROUND(AVG(CAST(exception_rate_percentage AS DOUBLE)), 2)
      comment: "Average exception rate percentage across control tests. A rising rate signals deteriorating control effectiveness and increased regulatory risk."
    - name: "material_deficiency_count"
      expr: COUNT(CASE WHEN control_deficiency_severity = 'Material Weakness' THEN control_test_id END)
      comment: "Number of tests identifying material weaknesses. A critical board-level KPI with direct implications for financial reporting integrity and regulatory standing."
    - name: "remediation_required_tests_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN control_test_id END)
      comment: "Number of tests requiring remediation action. Drives remediation backlog management and resource allocation decisions."
    - name: "overdue_remediation_tests_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE AND remediation_due_date < CURRENT_DATE() THEN control_test_id END)
      comment: "Tests where remediation is past the due date. Escalation metric for compliance officers and audit committees."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_conclusion = 'Effective' THEN control_test_id END) / NULLIF(COUNT(CASE WHEN test_status = 'Completed' THEN control_test_id END), 0), 2)
      comment: "Percentage of completed tests concluding controls are effective. Primary KPI for overall control environment health reported to the board."
    - name: "external_auditor_test_count"
      expr: COUNT(CASE WHEN external_auditor_flag = TRUE THEN control_test_id END)
      comment: "Number of tests conducted by external auditors. Relevant for assessing reliance on external assurance and associated cost management."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the regulatory obligation register — tracks compliance status, penalty exposure, and filing timeliness across all regulatory requirements to steer the firm's regulatory risk posture."
  source: "`legal_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (compliant, non-compliant, partially compliant) for executive risk dashboards."
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of the regulatory obligation (reporting, licensing, conduct) for portfolio segmentation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (statutory, regulatory, contractual) for governance classification."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction to which the obligation applies, enabling geographic compliance risk analysis."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation (FCA, SRA, ICO etc.) for regulator-level reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation for triage and resource allocation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation, used to focus compliance investment on highest-risk requirements."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the obligation falls under (GDPR, AML, SOX etc.) for framework-level compliance tracking."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the obligation is currently active, used to filter live compliance exposure."
    - name: "filing_frequency"
      expr: filing_frequency
      comment: "Frequency of required regulatory filings, used for scheduling and workload planning."
    - name: "next_filing_due_date"
      expr: next_filing_due_date
      comment: "Date of the next required regulatory filing, used for proactive deadline management."
  measures:
    - name: "non_compliant_obligations_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Number of active obligations currently in non-compliant status. A primary board-level risk indicator with direct regulatory penalty implications."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' AND is_active = TRUE THEN regulatory_obligation_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN regulatory_obligation_id END), 0), 2)
      comment: "Percentage of active regulatory obligations in compliant status. The headline regulatory health KPI for executive and board reporting."
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum financial penalty exposure across all active regulatory obligations. Critical for risk quantification, insurance provisioning, and board risk appetite discussions."
    - name: "avg_maximum_penalty_per_obligation"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per regulatory obligation. Used to benchmark severity of the obligation portfolio and prioritise compliance investment."
    - name: "non_compliant_penalty_exposure"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' AND is_active = TRUE THEN CAST(maximum_penalty_amount AS DOUBLE) ELSE 0 END)
      comment: "Total maximum penalty exposure attributable to currently non-compliant obligations. Quantifies the immediate financial risk requiring urgent remediation."
    - name: "overdue_filings_count"
      expr: COUNT(CASE WHEN next_filing_due_date < CURRENT_DATE() AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Number of active obligations with overdue regulatory filings. A direct indicator of regulatory breach risk requiring immediate escalation."
    - name: "obligations_requiring_external_audit_count"
      expr: COUNT(CASE WHEN external_audit_required_flag = TRUE AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Number of active obligations requiring external audit. Drives external audit budget planning and scheduling."
    - name: "high_risk_non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' AND risk_rating = 'High' AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Non-compliant obligations rated as high risk. The most critical escalation metric for the Chief Compliance Officer and board risk committee."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the policy management lifecycle — tracks policy currency, review compliance, and training obligations to ensure the firm's policy framework remains effective and up to date."
  source: "`legal_ecm`.`compliance`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (active, draft, retired, under review) for portfolio health monitoring."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (regulatory, operational, governance) for categorised reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction the policy applies to, enabling geographic policy coverage analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Department responsible for the policy, used for accountability and workload distribution analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the policy for triage and resource allocation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the policy area, used to focus review and enforcement effort."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the policy supports (GDPR, AML, SOX etc.)."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the policy is currently active."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Indicates whether staff training is required for this policy."
    - name: "next_review_date"
      expr: next_review_date
      comment: "Date the policy is next due for review, used for proactive scheduling."
  measures:
    - name: "active_policies_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN policy_id END)
      comment: "Total number of active policies in the policy framework. Baseline measure for policy portfolio management."
    - name: "overdue_review_policies_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND is_active = TRUE THEN policy_id END)
      comment: "Number of active policies past their scheduled review date. Stale policies create regulatory and operational risk; this KPI drives review prioritisation."
    - name: "policy_review_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND is_active = TRUE THEN policy_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN policy_id END), 0), 2)
      comment: "Percentage of active policies overdue for review. A governance health KPI reported to the board and audit committee."
    - name: "policies_requiring_external_audit_count"
      expr: COUNT(CASE WHEN external_audit_required_flag = TRUE AND is_active = TRUE THEN policy_id END)
      comment: "Number of active policies subject to external audit requirements. Drives external audit scope and budget planning."
    - name: "policies_with_training_obligation_count"
      expr: COUNT(CASE WHEN training_required_flag = TRUE AND is_active = TRUE THEN policy_id END)
      comment: "Number of active policies requiring mandatory staff training. Informs L&D planning and compliance training budget allocation."
    - name: "expiring_policies_next_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN policy_id END)
      comment: "Active policies expiring within the next 90 days. Enables proactive renewal management to avoid policy coverage gaps."
    - name: "high_risk_active_policies_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' AND is_active = TRUE THEN policy_id END)
      comment: "Number of active policies in high-risk areas. Used by the CCO to prioritise policy governance effort on the most consequential areas."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_indemnity_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for professional indemnity claims — tracks claim volumes, financial exposure, settlement performance, and SRA reportability to manage the firm's PI risk profile."
  source: "`legal_ecm`.`compliance`.`indemnity_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the indemnity claim (open, closed, settled, disputed) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (negligence, breach of duty, fraud etc.) for root cause and trend analysis."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (individual, corporate, government) for portfolio segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the claim, used to prioritise management attention and reserve adequacy review."
    - name: "sra_reportable_flag"
      expr: sra_reportable_flag
      comment: "Indicates whether the claim is reportable to the SRA, a critical regulatory compliance dimension."
    - name: "coverage_confirmation_status"
      expr: coverage_confirmation_status
      comment: "Status of insurer coverage confirmation, relevant for financial provisioning decisions."
    - name: "insurer_name"
      expr: insurer_name
      comment: "Name of the insurer handling the claim, used for insurer performance and relationship management."
    - name: "incident_date"
      expr: incident_date
      comment: "Date of the underlying incident, used for vintage analysis and trend identification."
    - name: "notification_date"
      expr: notification_date
      comment: "Date the claim was notified to the insurer, used for notification timeliness analysis."
  measures:
    - name: "open_claims_count"
      expr: COUNT(CASE WHEN claim_status = 'Open' THEN indemnity_claim_id END)
      comment: "Number of currently open indemnity claims. Primary operational KPI for PI risk management and insurer reporting."
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all claims. Critical for reserve adequacy assessment, financial provisioning, and board risk reporting."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves held against indemnity claims. Compared against estimated exposure to assess reserve adequacy — a key financial governance metric."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid in claim settlements. Tracks actual PI cost to the firm and informs premium renewal negotiations."
    - name: "total_defence_costs"
      expr: SUM(CAST(defence_costs_amount AS DOUBLE))
      comment: "Total defence costs incurred across all claims. A significant cost line for legal firms; trends inform litigation strategy and cost management."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per closed claim. Benchmarks claim severity and informs limit of indemnity adequacy reviews."
    - name: "sra_reportable_claims_count"
      expr: COUNT(CASE WHEN sra_reportable_flag = TRUE THEN indemnity_claim_id END)
      comment: "Number of claims reportable to the SRA. A direct regulatory compliance metric; failure to report is itself a regulatory breach."
    - name: "reserve_to_exposure_ratio"
      expr: ROUND(SUM(CAST(reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_exposure_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total reserves to total estimated exposure. A value below 1.0 signals under-reserving, a critical financial risk indicator for the CFO and board."
    - name: "high_risk_open_claims_count"
      expr: COUNT(CASE WHEN claim_status = 'Open' AND risk_rating = 'High' THEN indemnity_claim_id END)
      comment: "Number of open claims rated as high risk. The most critical subset of the claims portfolio requiring senior management oversight."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_indemnity_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for professional indemnity insurance policy management — tracks coverage adequacy, premium obligations, and regulatory compliance of the firm's PI insurance portfolio."
  source: "`legal_ecm`.`compliance`.`indemnity_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the indemnity policy (active, expired, cancelled) for portfolio health monitoring."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of indemnity policy (primary, excess, run-off) for coverage structure analysis."
    - name: "insurer_name"
      expr: insurer_name
      comment: "Name of the insurer, used for insurer concentration risk and relationship management."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the policy is currently active."
    - name: "qualifying_insurer_flag"
      expr: qualifying_insurer_flag
      comment: "Indicates whether the insurer meets SRA qualifying insurer requirements — a mandatory regulatory compliance dimension."
    - name: "claims_made_basis_flag"
      expr: claims_made_basis_flag
      comment: "Indicates whether the policy is on a claims-made basis, relevant for coverage gap analysis."
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current premium payment status, used to identify policies at risk of lapse due to non-payment."
    - name: "renewal_date"
      expr: renewal_date
      comment: "Policy renewal date, used for proactive renewal management."
    - name: "coverage_territory"
      expr: coverage_territory
      comment: "Geographic territory covered by the policy, relevant for multi-jurisdictional firms."
  measures:
    - name: "total_annual_premium"
      expr: SUM(CAST(annual_premium_amount AS DOUBLE))
      comment: "Total annual premium spend across all active PI policies. A significant cost line; tracked against claims experience to assess value and inform renewal strategy."
    - name: "total_limit_of_indemnity"
      expr: SUM(CAST(limit_of_indemnity_amount AS DOUBLE))
      comment: "Total aggregate limit of indemnity across all active policies. Compared against estimated claim exposure to assess coverage adequacy — a board-level risk metric."
    - name: "total_limit_per_claim"
      expr: SUM(CAST(limit_per_claim_amount AS DOUBLE))
      comment: "Total per-claim limit across all active policies. Used to assess whether individual claim limits are adequate relative to the firm's risk profile."
    - name: "total_excess_amount"
      expr: SUM(CAST(excess_amount AS DOUBLE))
      comment: "Total excess (deductible) exposure across all active policies. Represents the firm's self-insured retention; relevant for cash flow and risk management planning."
    - name: "avg_annual_premium"
      expr: AVG(CAST(annual_premium_amount AS DOUBLE))
      comment: "Average annual premium per policy. Used for benchmarking and insurer negotiation analysis."
    - name: "policies_renewing_next_90_days_count"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN indemnity_policy_id END)
      comment: "Number of active policies renewing within 90 days. Drives proactive renewal management to prevent coverage lapses — a critical regulatory compliance obligation."
    - name: "non_qualifying_insurer_policies_count"
      expr: COUNT(CASE WHEN qualifying_insurer_flag = FALSE AND is_active = TRUE THEN indemnity_policy_id END)
      comment: "Number of active policies with non-qualifying insurers. Any non-zero value represents a direct SRA regulatory breach requiring immediate remediation."
    - name: "coverage_to_premium_ratio"
      expr: ROUND(SUM(CAST(limit_of_indemnity_amount AS DOUBLE)) / NULLIF(SUM(CAST(annual_premium_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of total indemnity limit to total annual premium. Measures coverage efficiency; a declining ratio signals deteriorating value from the PI insurance spend."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_sar_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Suspicious Activity Report (SAR) filing management — tracks filing volumes, timeliness, consent outcomes, and tipping-off risk to ensure AML regulatory compliance and MLRO accountability."
  source: "`legal_ecm`.`compliance`.`sar_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the SAR filing (submitted, pending, withdrawn) for pipeline management."
    - name: "filing_jurisdiction"
      expr: filing_jurisdiction
      comment: "Jurisdiction in which the SAR was filed, enabling geographic AML risk analysis."
    - name: "filing_authority"
      expr: filing_authority
      comment: "Authority to which the SAR was filed (NCA, FinCEN etc.) for regulator-level reporting."
    - name: "suspicion_category"
      expr: suspicion_category
      comment: "Category of suspicious activity reported, used for typology analysis and AML programme tuning."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject reported (individual, corporate) for portfolio segmentation."
    - name: "consent_outcome"
      expr: consent_outcome
      comment: "Outcome of any consent request (granted, refused, deemed) — critical for determining whether transactions can proceed."
    - name: "consent_request_flag"
      expr: consent_request_flag
      comment: "Indicates whether a consent request was made alongside the SAR filing."
    - name: "tipping_off_risk_flag"
      expr: tipping_off_risk_flag
      comment: "Indicates whether a tipping-off risk was identified — a critical AML compliance and legal privilege dimension."
    - name: "relationship_terminated_flag"
      expr: relationship_terminated_flag
      comment: "Indicates whether the client relationship was terminated following the SAR filing."
    - name: "filing_date"
      expr: filing_date
      comment: "Date the SAR was filed, used for trend analysis and timeliness measurement."
  measures:
    - name: "total_sars_filed"
      expr: COUNT(CASE WHEN filing_status = 'Submitted' THEN sar_filing_id END)
      comment: "Total number of SARs successfully filed with the relevant authority. Primary AML programme activity metric reported to the MLRO and board."
    - name: "consent_refused_count"
      expr: COUNT(CASE WHEN consent_outcome = 'Refused' THEN sar_filing_id END)
      comment: "Number of SARs where consent to proceed was refused. Directly impacts client relationship management and transaction execution decisions."
    - name: "tipping_off_risk_count"
      expr: COUNT(CASE WHEN tipping_off_risk_flag = TRUE THEN sar_filing_id END)
      comment: "Number of SAR filings with identified tipping-off risk. A critical legal and regulatory risk metric requiring immediate MLRO and legal counsel attention."
    - name: "relationship_terminations_count"
      expr: COUNT(CASE WHEN relationship_terminated_flag = TRUE THEN sar_filing_id END)
      comment: "Number of client relationships terminated following SAR filings. Tracks the business impact of AML enforcement actions."
    - name: "total_transaction_amount_reported"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total value of transactions reported in SAR filings. Quantifies the financial scale of suspicious activity identified by the firm's AML programme."
    - name: "avg_transaction_amount_reported"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction value per SAR filing. Used to identify shifts in the scale of suspicious activity and calibrate risk thresholds."
    - name: "follow_up_action_required_count"
      expr: COUNT(CASE WHEN follow_up_action_required = TRUE THEN sar_filing_id END)
      comment: "Number of SAR filings requiring follow-up action. Drives MLRO workload planning and ensures no regulatory follow-up obligations are missed."
    - name: "consent_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_request_flag = TRUE THEN sar_filing_id END) / NULLIF(COUNT(sar_filing_id), 0), 2)
      comment: "Percentage of SAR filings accompanied by a consent request. Indicates the proportion of filings where transactions are pending regulatory approval — a key AML operational metric."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_aml_kyc_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for AML/KYC programme management — tracks programme risk ratings, training completion, audit currency, and regulatory approval status to ensure the firm's AML framework meets regulatory expectations."
  source: "`legal_ecm`.`compliance`.`aml_kyc_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the AML/KYC programme (active, under review, suspended) for portfolio monitoring."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating of the programme, used to prioritise oversight and resource allocation."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls, used to assess control effectiveness at the programme level."
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Overall control effectiveness rating for the programme, a key AML governance metric."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Status of regulatory approval for the programme — non-approved programmes represent a direct regulatory breach."
    - name: "client_risk_rating"
      expr: client_risk_rating
      comment: "Client risk rating profile of the programme, used for risk-based AML resource allocation."
    - name: "geographic_risk_rating"
      expr: geographic_risk_rating
      comment: "Geographic risk rating, used to identify programmes with elevated jurisdiction-level AML exposure."
    - name: "applicable_jurisdictions"
      expr: applicable_jurisdictions
      comment: "Jurisdictions covered by the programme, enabling geographic AML compliance analysis."
    - name: "risk_assessment_frequency"
      expr: risk_assessment_frequency
      comment: "Frequency of risk assessments for the programme, used to ensure assessment cadence meets regulatory expectations."
    - name: "next_audit_due_date"
      expr: next_audit_due_date
      comment: "Date the next programme audit is due, used for proactive audit scheduling."
  measures:
    - name: "avg_training_completion_rate"
      expr: AVG(CAST(training_completion_rate AS DOUBLE))
      comment: "Average AML/KYC training completion rate across programmes. A key regulatory expectation; low rates signal non-compliance with mandatory training obligations and are reportable to the MLRO."
    - name: "min_training_completion_rate"
      expr: MIN(CAST(training_completion_rate AS DOUBLE))
      comment: "Minimum training completion rate across all programmes. Identifies the worst-performing programme — the tail risk that regulators focus on during inspections."
    - name: "programmes_without_regulatory_approval_count"
      expr: COUNT(CASE WHEN regulatory_approval_status != 'Approved' AND program_status = 'Active' THEN aml_kyc_program_id END)
      comment: "Number of active AML/KYC programmes without regulatory approval. Any non-zero value represents a critical regulatory compliance failure requiring immediate escalation."
    - name: "programmes_overdue_for_audit_count"
      expr: COUNT(CASE WHEN next_audit_due_date < CURRENT_DATE() AND program_status = 'Active' THEN aml_kyc_program_id END)
      comment: "Active programmes past their scheduled audit date. Overdue audits are a common regulatory finding and signal weaknesses in the AML governance framework."
    - name: "programmes_overdue_for_risk_assessment_count"
      expr: COUNT(CASE WHEN next_risk_assessment_due_date < CURRENT_DATE() AND program_status = 'Active' THEN aml_kyc_program_id END)
      comment: "Active programmes past their scheduled risk assessment date. Regulators require periodic risk assessments; overdue assessments indicate AML programme governance failures."
    - name: "high_inherent_risk_programmes_count"
      expr: COUNT(CASE WHEN inherent_risk_rating = 'High' AND program_status = 'Active' THEN aml_kyc_program_id END)
      comment: "Number of active programmes with high inherent risk ratings. Drives prioritisation of enhanced due diligence and senior management oversight."
    - name: "training_completion_below_threshold_count"
      expr: COUNT(CASE WHEN training_completion_rate < 80.0 AND program_status = 'Active' THEN aml_kyc_program_id END)
      comment: "Number of active programmes with training completion below 80%. The 80% threshold is a common regulatory benchmark; programmes below this level face heightened scrutiny."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_control_framework`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the compliance control framework portfolio — tracks framework adoption, compliance percentages, certification status, and review currency to ensure the firm's control architecture remains robust and current."
  source: "`legal_ecm`.`compliance`.`control_framework`"
  dimensions:
    - name: "framework_status"
      expr: framework_status
      comment: "Current status of the control framework (active, retired, under review) for portfolio management."
    - name: "framework_type"
      expr: framework_type
      comment: "Type of framework (regulatory, industry standard, internal) for categorised reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction the framework applies to, enabling geographic compliance architecture analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Body that issued the framework (ISO, NIST, FCA etc.) for standards-level reporting."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Indicates whether adoption of the framework is mandatory, used to prioritise compliance investment."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Indicates whether certification is required under the framework, relevant for audit and accreditation planning."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the framework, used to focus governance effort."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency of framework reviews, used to ensure review cadence meets governance standards."
    - name: "next_review_due_date"
      expr: next_review_due_date
      comment: "Date the framework is next due for review, used for proactive scheduling."
  measures:
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all active control frameworks. The headline KPI for the firm's overall control framework adherence, reported to the board and audit committee."
    - name: "min_compliance_percentage"
      expr: MIN(CAST(compliance_percentage AS DOUBLE))
      comment: "Minimum compliance percentage across all frameworks. Identifies the weakest framework — the tail risk that drives the most urgent remediation investment."
    - name: "frameworks_below_threshold_count"
      expr: COUNT(CASE WHEN compliance_percentage < 75.0 AND framework_status = 'Active' THEN control_framework_id END)
      comment: "Number of active frameworks with compliance below 75%. Frameworks below this threshold typically trigger mandatory remediation plans and regulatory notifications."
    - name: "mandatory_frameworks_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE AND framework_status = 'Active' THEN control_framework_id END)
      comment: "Number of active mandatory control frameworks. Establishes the non-negotiable compliance baseline the firm must maintain."
    - name: "certification_overdue_count"
      expr: COUNT(CASE WHEN certification_required_flag = TRUE AND next_certification_due_date < CURRENT_DATE() AND framework_status = 'Active' THEN control_framework_id END)
      comment: "Active frameworks where required certification is overdue. Lapsed certifications can result in regulatory sanctions, client contract breaches, and reputational damage."
    - name: "frameworks_overdue_for_review_count"
      expr: COUNT(CASE WHEN next_review_due_date < CURRENT_DATE() AND framework_status = 'Active' THEN control_framework_id END)
      comment: "Active frameworks past their scheduled review date. Stale frameworks may not reflect current regulatory requirements, creating compliance gaps."
    - name: "mandatory_frameworks_avg_compliance_pct"
      expr: AVG(CASE WHEN mandatory_flag = TRUE AND framework_status = 'Active' THEN CAST(compliance_percentage AS DOUBLE) END)
      comment: "Average compliance percentage for mandatory frameworks only. A more focused governance KPI than overall average — mandatory framework non-compliance carries the highest regulatory consequence."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`compliance_data_privacy_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for GDPR and data privacy compliance — tracks DPIA completion, third-country transfer safeguards, special category data handling, and supervisory authority consultation obligations to manage the firm's data protection risk."
  source: "`legal_ecm`.`compliance`.`data_privacy_register`"
  dimensions:
    - name: "data_privacy_register_status"
      expr: data_privacy_register_status
      comment: "Current status of the data privacy register entry (active, under review, closed) for portfolio management."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of register entry (processing activity, data transfer, consent record) for categorised reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (consent, legitimate interest, legal obligation etc.) — a fundamental GDPR compliance dimension."
    - name: "dpia_required_flag"
      expr: dpia_required_flag
      comment: "Indicates whether a Data Protection Impact Assessment is required for this processing activity."
    - name: "special_category_data_flag"
      expr: special_category_data_flag
      comment: "Indicates whether the processing involves special category data, which carries heightened GDPR obligations."
    - name: "third_country_transfer_flag"
      expr: third_country_transfer_flag
      comment: "Indicates whether personal data is transferred to third countries, triggering additional GDPR safeguard requirements."
    - name: "supervisory_authority_consultation_required_flag"
      expr: supervisory_authority_consultation_required_flag
      comment: "Indicates whether prior consultation with the supervisory authority is required — a mandatory GDPR obligation."
    - name: "transfer_safeguard_mechanism"
      expr: transfer_safeguard_mechanism
      comment: "Mechanism used to safeguard third-country data transfers (SCCs, BCRs, adequacy decision etc.)."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency of register entry reviews, used to ensure data privacy records remain current."
    - name: "next_review_date"
      expr: next_review_date
      comment: "Date the register entry is next due for review."
  measures:
    - name: "dpia_required_without_completion_count"
      expr: COUNT(CASE WHEN dpia_required_flag = TRUE AND dpia_completion_date IS NULL THEN data_privacy_register_id END)
      comment: "Processing activities requiring a DPIA that have not yet been completed. Incomplete DPIAs are a direct GDPR Article 35 violation with significant regulatory penalty exposure."
    - name: "third_country_transfers_without_safeguard_count"
      expr: COUNT(CASE WHEN third_country_transfer_flag = TRUE AND (transfer_safeguard_mechanism IS NULL OR transfer_safeguard_mechanism = '') THEN data_privacy_register_id END)
      comment: "Third-country data transfers without a documented safeguard mechanism. Each instance represents a potential GDPR Chapter V violation — a critical data protection risk metric."
    - name: "special_category_processing_count"
      expr: COUNT(CASE WHEN special_category_data_flag = TRUE AND data_privacy_register_status = 'Active' THEN data_privacy_register_id END)
      comment: "Number of active processing activities involving special category data. Quantifies the firm's exposure under GDPR Article 9, which carries the highest penalty tier."
    - name: "supervisory_consultation_overdue_count"
      expr: COUNT(CASE WHEN supervisory_authority_consultation_required_flag = TRUE AND supervisory_authority_consultation_date IS NULL THEN data_privacy_register_id END)
      comment: "Processing activities requiring supervisory authority consultation that have not yet been completed. A mandatory GDPR Article 36 obligation; non-compliance is a direct regulatory breach."
    - name: "overdue_review_entries_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND data_privacy_register_status = 'Active' THEN data_privacy_register_id END)
      comment: "Active register entries past their scheduled review date. Stale privacy records undermine GDPR accountability obligations and increase ICO audit risk."
    - name: "dpia_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dpia_required_flag = TRUE AND dpia_completion_date IS NOT NULL THEN data_privacy_register_id END) / NULLIF(COUNT(CASE WHEN dpia_required_flag = TRUE THEN data_privacy_register_id END), 0), 2)
      comment: "Percentage of required DPIAs that have been completed. A key GDPR programme maturity KPI reported to the DPO and board."
    - name: "third_country_transfer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_country_transfer_flag = TRUE THEN data_privacy_register_id END) / NULLIF(COUNT(data_privacy_register_id), 0), 2)
      comment: "Percentage of processing activities involving third-country data transfers. Tracks the firm's international data transfer exposure profile, relevant for post-Brexit and Schrems II compliance."
$$;