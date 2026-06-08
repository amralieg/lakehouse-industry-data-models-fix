-- Metric views for domain: compliance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_aml_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anti-Money Laundering (AML) case management metrics tracking suspicious activity volumes, transaction risk exposure, regulatory filing compliance, and case resolution efficiency. Used by the BSA/AML Officer and Chief Compliance Officer to monitor financial crime risk and FinCEN reporting obligations."
  source: "`life_insurance_ecm`.`compliance`.`aml_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current lifecycle status of the AML case (e.g., Open, Closed, Pending Review) — used to segment active vs. resolved caseload."
    - name: "case_type"
      expr: case_type
      comment: "Classification of the AML case type (e.g., SAR, CTR, Internal Review) — drives regulatory reporting routing."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level assigned to the case (e.g., High, Medium, Low) — used to triage investigator workload."
    - name: "suspicious_activity_type"
      expr: suspicious_activity_type
      comment: "Category of suspicious activity detected (e.g., Structuring, Layering, Fraud) — informs typology analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction where the suspicious activity occurred — supports geographic risk concentration analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final outcome of the AML case (e.g., SAR Filed, No Action, Referred to Law Enforcement) — measures investigative effectiveness."
    - name: "fincen_filing_type"
      expr: fincen_filing_type
      comment: "Type of FinCEN filing associated with the case (e.g., SAR, CTR) — used to track regulatory filing mix."
    - name: "ofac_screening_status"
      expr: ofac_screening_status
      comment: "OFAC sanctions screening result for the case subject — critical for sanctions compliance monitoring."
    - name: "initiation_source"
      expr: initiation_source
      comment: "Source that triggered the AML case (e.g., System Alert, Employee Report, Regulator Referral) — used to evaluate detection channel effectiveness."
    - name: "detection_date_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month in which suspicious activity was detected — enables trend analysis of AML case volumes over time."
    - name: "law_enforcement_referral"
      expr: CASE WHEN law_enforcement_referral = TRUE THEN 'Referred' ELSE 'Not Referred' END
      comment: "Indicates whether the case was referred to law enforcement — used to measure escalation rates."
    - name: "kyc_review_required"
      expr: CASE WHEN kyc_review_required = TRUE THEN 'KYC Review Required' ELSE 'No KYC Review' END
      comment: "Flags cases requiring Know Your Customer re-review — used to track KYC remediation workload."
  measures:
    - name: "total_aml_cases"
      expr: COUNT(1)
      comment: "Total number of AML cases opened. Baseline volume metric used by the BSA Officer to monitor financial crime caseload and staffing adequacy."
    - name: "total_suspicious_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total dollar value of transactions flagged as suspicious across all AML cases. Measures aggregate financial crime exposure and informs risk appetite decisions."
    - name: "avg_suspicious_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per AML case. Helps identify whether the organization is seeing high-value or low-value suspicious activity patterns."
    - name: "avg_case_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score assigned to AML cases. Tracks overall portfolio risk level and whether the AML program is detecting higher-risk activity over time."
    - name: "max_case_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Maximum risk score observed across all AML cases in the period. Identifies the highest-severity financial crime exposure in the portfolio."
    - name: "fincen_filed_cases"
      expr: COUNT(CASE WHEN fincen_filed_date IS NOT NULL THEN 1 END)
      comment: "Number of AML cases where a FinCEN filing was completed. Measures regulatory filing compliance and SAR/CTR submission volume."
    - name: "law_enforcement_referral_cases"
      expr: COUNT(CASE WHEN law_enforcement_referral = TRUE THEN 1 END)
      comment: "Number of AML cases escalated to law enforcement. Indicates severity of financial crime activity and the organization's cooperation with authorities."
    - name: "ofac_match_cases"
      expr: COUNT(CASE WHEN ofac_match_reference IS NOT NULL AND ofac_match_reference <> '' THEN 1 END)
      comment: "Number of AML cases with an OFAC sanctions match. Critical sanctions compliance KPI — any positive match requires immediate executive attention."
    - name: "open_cases_past_sar_deadline"
      expr: COUNT(CASE WHEN case_status <> 'Closed' AND sar_filing_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of open AML cases where the SAR filing deadline has passed. Directly measures regulatory non-compliance risk and potential FinCEN penalty exposure."
    - name: "kyc_review_required_cases"
      expr: COUNT(CASE WHEN kyc_review_required = TRUE THEN 1 END)
      comment: "Number of AML cases requiring KYC re-review. Tracks the remediation workload generated by the AML program and KYC program gaps."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_sar_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspicious Activity Report (SAR) filing metrics tracking FinCEN submission compliance, filing volumes by activity type and jurisdiction, and approval cycle performance. Used by the BSA/AML Officer and Chief Compliance Officer to ensure timely and complete SAR obligations under the Bank Secrecy Act."
  source: "`life_insurance_ecm`.`compliance`.`sar_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the SAR filing (e.g., Filed, Pending Approval, Rejected) — used to track submission pipeline health."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of SAR filing (e.g., Initial, Continuing, Joint) — used to analyze filing mix and recurring suspicious activity."
    - name: "suspicious_activity_type"
      expr: suspicious_activity_type
      comment: "Category of suspicious activity reported (e.g., Structuring, Fraud, Money Laundering) — drives typology trend analysis."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the suspicious activity occurred — supports geographic concentration analysis."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject named in the SAR (e.g., Individual, Entity) — used to segment SAR population by subject category."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the SAR was filed with FinCEN — enables trend analysis of SAR submission volumes."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the suspicious activity (e.g., System Alert, Manual Review) — used to evaluate detection channel effectiveness."
    - name: "confidentiality_flag"
      expr: CASE WHEN confidentiality_flag = TRUE THEN 'Confidential' ELSE 'Standard' END
      comment: "Indicates whether the SAR is subject to confidentiality restrictions — used to manage disclosure controls."
  measures:
    - name: "total_sar_filings"
      expr: COUNT(1)
      comment: "Total number of SAR filings submitted. Baseline volume metric for BSA/AML program activity and regulatory reporting throughput."
    - name: "total_sar_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total dollar value of transactions reported across all SAR filings. Measures aggregate suspicious financial activity volume reported to FinCEN."
    - name: "avg_sar_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per SAR filing. Tracks whether the organization is reporting higher or lower value suspicious transactions over time."
    - name: "rejected_sar_filings"
      expr: COUNT(CASE WHEN rejection_date IS NOT NULL THEN 1 END)
      comment: "Number of SAR filings rejected by FinCEN. Measures filing quality and compliance program effectiveness — high rejection rates signal process deficiencies."
    - name: "sar_filings_with_law_enforcement_contact"
      expr: COUNT(CASE WHEN law_enforcement_contact_flag = TRUE THEN 1 END)
      comment: "Number of SAR filings where law enforcement was contacted. Indicates severity of reported activity and cooperation with authorities."
    - name: "continuing_sar_filings"
      expr: COUNT(CASE WHEN prior_sar_filing_id IS NOT NULL THEN 1 END)
      comment: "Number of SAR filings that are continuations of prior SARs. Measures persistent suspicious activity patterns requiring ongoing monitoring."
    - name: "avg_sar_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, filing_date))
      comment: "Average number of days between SAR filing date and internal approval date. Measures internal review efficiency and compliance with 30-day FinCEN filing window."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_exam_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory examination finding metrics tracking severity, financial exposure, remediation progress, and repeat finding rates across market conduct and other regulatory exams. Used by the Chief Compliance Officer and General Counsel to manage regulatory risk, prioritize remediation, and demonstrate corrective action to regulators."
  source: "`life_insurance_ecm`.`compliance`.`exam_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the exam finding (e.g., Open, Remediated, Closed) — used to track remediation pipeline."
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding type (e.g., Market Conduct, Financial, Operational) — used to segment findings by regulatory domain."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the finding (e.g., Critical, Major, Minor) — primary dimension for prioritizing remediation resources."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the finding has been escalated (e.g., Board, Executive, Department) — used to track governance escalation."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body that issued the finding (e.g., State DOI, NAIC, SEC) — used to segment findings by regulator."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the finding was issued — supports geographic regulatory risk analysis."
    - name: "affected_business_process"
      expr: affected_business_process
      comment: "Business process cited in the finding (e.g., Claims, Underwriting, Sales) — identifies operational areas with highest regulatory risk."
    - name: "is_repeat_finding"
      expr: CASE WHEN is_repeat_finding = TRUE THEN 'Repeat Finding' ELSE 'New Finding' END
      comment: "Indicates whether the finding recurs from a prior examination — repeat findings signal systemic control failures."
    - name: "aml_bsa_related"
      expr: CASE WHEN aml_bsa_related = TRUE THEN 'AML/BSA Related' ELSE 'Non-AML/BSA' END
      comment: "Flags findings related to AML/BSA compliance — used to track financial crime regulatory exposure."
    - name: "hipaa_related"
      expr: CASE WHEN hipaa_related = TRUE THEN 'HIPAA Related' ELSE 'Non-HIPAA' END
      comment: "Flags findings related to HIPAA privacy compliance — used to track health data regulatory exposure."
    - name: "finding_identified_date_month"
      expr: DATE_TRUNC('MONTH', finding_identified_date)
      comment: "Month the finding was identified during examination — enables trend analysis of regulatory finding volumes."
    - name: "suitability_review_required"
      expr: CASE WHEN suitability_review_required = TRUE THEN 'Suitability Review Required' ELSE 'No Suitability Review' END
      comment: "Indicates whether the finding requires a suitability review — used to track consumer protection remediation obligations."
  measures:
    - name: "total_exam_findings"
      expr: COUNT(1)
      comment: "Total number of regulatory exam findings. Baseline volume metric for regulatory examination exposure — used by CCO to track overall regulatory risk posture."
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed from exam findings. Direct measure of financial cost of regulatory non-compliance — key board-level risk metric."
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure from open exam findings. Forward-looking risk metric used to size regulatory reserves and prioritize remediation investment."
    - name: "total_consumer_restitution_amount"
      expr: SUM(CAST(consumer_restitution_amount AS DOUBLE))
      comment: "Total consumer restitution amounts ordered from exam findings. Measures policyholder harm and reputational risk from regulatory non-compliance."
    - name: "avg_actual_penalty_amount"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average penalty amount per exam finding. Benchmarks penalty severity and tracks whether regulatory enforcement intensity is increasing."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of findings that are repeats from prior examinations. Critical quality metric — repeat findings indicate systemic control failures and attract heightened regulatory scrutiny."
    - name: "open_findings_past_target_remediation"
      expr: COUNT(CASE WHEN finding_status <> 'Closed' AND target_remediation_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open findings where the target remediation date has passed. Measures remediation program timeliness and regulatory commitment adherence."
    - name: "critical_findings_count"
      expr: COUNT(CASE WHEN severity_classification = 'Critical' THEN 1 END)
      comment: "Number of findings classified as Critical severity. Highest-priority regulatory risk indicator — drives immediate executive escalation and resource allocation."
    - name: "findings_requiring_board_attestation"
      expr: COUNT(CASE WHEN compliance_attestation_required = TRUE THEN 1 END)
      comment: "Number of findings requiring formal compliance attestation. Tracks governance obligations arising from regulatory examinations."
    - name: "findings_requiring_training"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of findings that require staff training as part of remediation. Measures the training remediation workload generated by regulatory examinations."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_market_conduct_exam`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market conduct examination metrics tracking exam outcomes, financial penalties, corrective action plan compliance, and repeat examination rates. Used by the Chief Compliance Officer and General Counsel to manage state DOI examination relationships and demonstrate regulatory responsiveness."
  source: "`life_insurance_ecm`.`compliance`.`market_conduct_exam`"
  dimensions:
    - name: "exam_status"
      expr: exam_status
      comment: "Current status of the market conduct examination (e.g., In Progress, Closed, Pending CAP) — used to track active examination workload."
    - name: "exam_type"
      expr: exam_type
      comment: "Type of market conduct examination (e.g., Routine, Targeted, Complaint-Based) — used to segment examination triggers."
    - name: "exam_outcome"
      expr: exam_outcome
      comment: "Final outcome of the examination (e.g., No Action, Penalty Assessed, CAP Required) — primary KPI dimension for regulatory performance."
    - name: "initiating_state_code"
      expr: initiating_state_code
      comment: "State code of the DOI that initiated the examination — used to track examination activity by jurisdiction."
    - name: "exam_scope"
      expr: exam_scope
      comment: "Scope of the examination (e.g., Full, Targeted, Financial) — used to understand examination breadth and resource requirements."
    - name: "corrective_action_plan_required"
      expr: CASE WHEN corrective_action_plan_required = TRUE THEN 'CAP Required' ELSE 'No CAP' END
      comment: "Indicates whether a Corrective Action Plan was required — used to track remediation obligations from examinations."
    - name: "repeat_exam_indicator"
      expr: CASE WHEN repeat_exam_indicator = TRUE THEN 'Repeat Exam' ELSE 'Initial Exam' END
      comment: "Indicates whether this is a repeat examination of the same area — repeat exams signal unresolved prior findings."
    - name: "appeal_filed"
      expr: CASE WHEN appeal_filed = TRUE THEN 'Appeal Filed' ELSE 'No Appeal' END
      comment: "Indicates whether the company filed an appeal of the examination findings — used to track contested regulatory outcomes."
    - name: "exam_period_start_year"
      expr: YEAR(exam_period_start_date)
      comment: "Year of the examination period start — used to analyze examination activity trends over time."
  measures:
    - name: "total_market_conduct_exams"
      expr: COUNT(1)
      comment: "Total number of market conduct examinations. Baseline volume metric for regulatory examination activity — used to track DOI engagement intensity."
    - name: "total_monetary_penalty_amount"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all market conduct examinations. Direct measure of financial cost of market conduct non-compliance — key board-level risk metric."
    - name: "total_restitution_amount"
      expr: SUM(CAST(restitution_amount AS DOUBLE))
      comment: "Total policyholder restitution ordered from market conduct examinations. Measures consumer harm and reputational risk from market conduct deficiencies."
    - name: "avg_monetary_penalty_amount"
      expr: AVG(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Average penalty per market conduct examination. Benchmarks penalty severity and tracks whether DOI enforcement intensity is increasing."
    - name: "exams_requiring_corrective_action_plan"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Number of examinations requiring a Corrective Action Plan. Measures the volume of formal remediation commitments made to state regulators."
    - name: "repeat_examinations"
      expr: COUNT(CASE WHEN repeat_exam_indicator = TRUE THEN 1 END)
      comment: "Number of repeat market conduct examinations. Indicates persistent compliance deficiencies that have attracted recurring regulatory scrutiny."
    - name: "exams_with_cap_submission_overdue"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE AND cap_submission_date IS NULL AND cap_submission_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of examinations where a CAP was required but not yet submitted past the due date. Measures regulatory commitment adherence and risk of additional enforcement action."
    - name: "avg_exam_duration_days"
      expr: AVG(DATEDIFF(exam_close_date, onsite_start_date))
      comment: "Average number of days from onsite examination start to exam close. Measures examination efficiency and resource burden on the compliance function."
    - name: "exams_with_appeal_filed"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END)
      comment: "Number of examinations where the company filed an appeal. Tracks contested regulatory outcomes and legal resource utilization."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing metrics tracking submission timeliness, late filing rates, penalty exposure, and filing status across all statutory and regulatory reporting obligations. Used by the Chief Compliance Officer and CFO to monitor filing compliance, avoid regulatory penalties, and demonstrate governance to state DOIs and the NAIC."
  source: "`life_insurance_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., Submitted, Accepted, Rejected, Pending) — primary dimension for pipeline health monitoring."
    - name: "filing_form_name"
      expr: filing_form_name
      comment: "Name of the regulatory form filed (e.g., Annual Statement, ORSA, RBC Report) — used to segment filing activity by obligation type."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel used to submit the filing (e.g., SERFF, NAIC, Direct) — used to track submission method compliance."
    - name: "lead_state_code"
      expr: lead_state_code
      comment: "Lead state jurisdiction for the filing — used to analyze filing activity and compliance by state."
    - name: "late_filing_flag"
      expr: CASE WHEN late_filing_flag = TRUE THEN 'Late Filing' ELSE 'On-Time Filing' END
      comment: "Indicates whether the filing was submitted after the regulatory due date — primary timeliness compliance dimension."
    - name: "is_amended"
      expr: CASE WHEN is_amended = TRUE THEN 'Amended Filing' ELSE 'Original Filing' END
      comment: "Indicates whether the filing is an amendment to a prior submission — used to track filing quality and restatement rates."
    - name: "aml_transaction_type"
      expr: aml_transaction_type
      comment: "AML transaction type associated with the filing (e.g., CTR, SAR) — used to segment AML-related regulatory filings."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the filing was submitted — enables trend analysis of filing volumes and timeliness over time."
    - name: "erisa_plan_type"
      expr: erisa_plan_type
      comment: "ERISA plan type associated with the filing — used to segment ERISA-related regulatory filings."
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted. Baseline volume metric for regulatory reporting activity across all obligations."
    - name: "late_filings_count"
      expr: COUNT(CASE WHEN late_filing_flag = TRUE THEN 1 END)
      comment: "Number of regulatory filings submitted after the due date. Direct measure of filing compliance failure — late filings trigger regulatory penalties and reputational risk."
    - name: "late_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_filing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings submitted late. Key compliance KPI — tracks the organization's overall regulatory filing timeliness performance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed for regulatory filing violations. Measures the financial cost of filing non-compliance — directly informs compliance investment decisions."
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN rejection_date IS NOT NULL THEN 1 END)
      comment: "Number of regulatory filings rejected by the regulatory authority. Measures filing quality and process effectiveness — high rejection rates signal systemic preparation deficiencies."
    - name: "amended_filings_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of amended regulatory filings. Tracks restatement frequency — high amendment rates indicate data quality or process issues in the filing preparation workflow."
    - name: "accepted_filings_count"
      expr: COUNT(CASE WHEN acceptance_date IS NOT NULL THEN 1 END)
      comment: "Number of regulatory filings formally accepted by the regulatory authority. Measures successful filing completion rate."
    - name: "avg_filing_days_late"
      expr: AVG(CAST(days_late AS DOUBLE))
      comment: "Average number of days late for filings submitted past their due date. Measures the severity of filing timeliness failures — large averages indicate systemic process breakdowns."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_jurisdiction_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Jurisdiction license management metrics tracking license status, renewal compliance, capital adequacy, and statutory deposit obligations across all states where the company is authorized to operate. Used by the Chief Compliance Officer and CFO to ensure continuous licensure and avoid market access disruptions."
  source: "`life_insurance_ecm`.`compliance`.`jurisdiction_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the jurisdiction license (e.g., Active, Expired, Suspended, Revoked) — primary dimension for license portfolio health monitoring."
    - name: "license_type"
      expr: license_type
      comment: "Type of license held (e.g., Life, Annuity, Variable) — used to segment license portfolio by product authorization."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State code of the licensing jurisdiction — used to analyze license compliance by state."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the license renewal process (e.g., Renewed, Pending, Overdue) — used to track renewal pipeline health."
    - name: "is_domestic"
      expr: CASE WHEN is_domestic = TRUE THEN 'Domestic' ELSE 'Foreign' END
      comment: "Indicates whether the license is in the company's domicile state — used to distinguish domestic vs. foreign jurisdiction obligations."
    - name: "license_condition_flag"
      expr: CASE WHEN license_condition_flag = TRUE THEN 'Conditional License' ELSE 'Unconditional License' END
      comment: "Indicates whether the license has conditions attached — conditional licenses require active monitoring and compliance with specific requirements."
    - name: "variable_product_flag"
      expr: CASE WHEN variable_product_flag = TRUE THEN 'Variable Products Authorized' ELSE 'Non-Variable Only' END
      comment: "Indicates whether the license covers variable products — used to track SEC/FINRA-regulated product authorization."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires — used to plan renewal workload and identify near-term expiration risk."
  measures:
    - name: "total_jurisdiction_licenses"
      expr: COUNT(1)
      comment: "Total number of jurisdiction licenses held. Baseline metric for the company's geographic market access footprint."
    - name: "active_licenses_count"
      expr: COUNT(CASE WHEN license_status = 'Active' THEN 1 END)
      comment: "Number of currently active jurisdiction licenses. Measures the company's authorized operating footprint — declines indicate market access risk."
    - name: "expired_licenses_count"
      expr: COUNT(CASE WHEN license_status = 'Expired' OR expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired jurisdiction licenses. Critical compliance risk metric — operating in a jurisdiction with an expired license exposes the company to regulatory sanctions."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN license_status = 'Active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active licenses expiring within the next 90 days. Forward-looking renewal risk metric — used to prioritize renewal workload and avoid lapses."
    - name: "conditional_licenses_count"
      expr: COUNT(CASE WHEN license_condition_flag = TRUE THEN 1 END)
      comment: "Number of licenses with regulatory conditions attached. Measures the volume of licenses requiring active compliance monitoring beyond standard renewal obligations."
    - name: "total_renewal_fee_amount"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total license renewal fees across all jurisdictions. Measures the direct cost of maintaining the company's geographic operating footprint."
    - name: "total_statutory_deposit_amount"
      expr: SUM(CAST(statutory_deposit_amount AS DOUBLE))
      comment: "Total statutory deposits held across all jurisdictions. Measures capital tied up in regulatory deposit requirements — informs capital allocation decisions."
    - name: "total_minimum_capital_requirement"
      expr: SUM(CAST(minimum_capital_requirement AS DOUBLE))
      comment: "Total minimum capital requirements across all licensed jurisdictions. Measures aggregate regulatory capital obligations — used by CFO for capital planning."
    - name: "suspended_or_revoked_licenses_count"
      expr: COUNT(CASE WHEN license_status IN ('Suspended', 'Revoked') THEN 1 END)
      comment: "Number of licenses that have been suspended or revoked. Highest-severity license compliance metric — any suspension or revocation requires immediate executive escalation."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_policy_form_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy form approval metrics tracking filing status, approval cycle times, rate change impacts, and regulatory compliance across all product form submissions to state DOIs. Used by the Chief Actuary, Chief Compliance Officer, and Product Management to manage product launch timelines and regulatory approval pipelines."
  source: "`life_insurance_ecm`.`compliance`.`policy_form_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the policy form filing (e.g., Approved, Pending, Disapproved, Withdrawn) — primary dimension for approval pipeline monitoring."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the form was filed for approval — used to analyze approval rates and cycle times by state."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the form filing (e.g., Term Life, Whole Life, Annuity) — used to segment approval activity by product."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to file the form (e.g., SERFF, Prior Approval, File and Use) — used to analyze filing channel effectiveness."
    - name: "rate_filing_type"
      expr: rate_filing_type
      comment: "Type of rate filing associated with the form (e.g., New Rate, Rate Increase, Rate Decrease) — used to segment filings by rate action type."
    - name: "is_currently_approved"
      expr: CASE WHEN is_currently_approved = TRUE THEN 'Currently Approved' ELSE 'Not Currently Approved' END
      comment: "Indicates whether the form is currently approved for use — used to track the active approved form portfolio."
    - name: "variable_product_flag"
      expr: CASE WHEN variable_product_flag = TRUE THEN 'Variable Product' ELSE 'Non-Variable Product' END
      comment: "Indicates whether the form is for a variable product — variable products have additional SEC/FINRA regulatory requirements."
    - name: "irc_7702_compliant_flag"
      expr: CASE WHEN irc_7702_compliant_flag = TRUE THEN 'IRC 7702 Compliant' ELSE 'IRC 7702 Review Required' END
      comment: "Indicates whether the form has been certified as IRC Section 7702 compliant — critical for life insurance tax qualification."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the form was submitted for regulatory approval — enables trend analysis of filing volumes and approval pipeline."
  measures:
    - name: "total_form_filings"
      expr: COUNT(1)
      comment: "Total number of policy form approval filings. Baseline volume metric for product development and regulatory filing activity."
    - name: "approved_form_filings"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of policy form filings that received regulatory approval. Measures product launch pipeline throughput and regulatory approval success rate."
    - name: "disapproved_form_filings"
      expr: COUNT(CASE WHEN approval_status = 'Disapproved' THEN 1 END)
      comment: "Number of policy form filings that were disapproved by the regulator. Measures filing quality and product design compliance — high disapproval rates delay product launches."
    - name: "form_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN approval_status IN ('Approved', 'Disapproved') THEN 1 END), 0), 2)
      comment: "Percentage of decided form filings that received approval. Key product compliance KPI — tracks regulatory acceptance rate of new product forms."
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average number of days from form submission to regulatory approval. Measures regulatory review cycle time — directly impacts product launch timelines."
    - name: "total_rate_change_percentage_avg"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage across approved form filings. Tracks the magnitude of rate actions being approved — informs pricing strategy and consumer impact assessment."
    - name: "total_ltc_rate_increase_percentage_avg"
      expr: AVG(CAST(ltc_rate_increase_percentage AS DOUBLE))
      comment: "Average long-term care rate increase percentage across LTC form filings. Critical LTC-specific KPI — LTC rate increases are heavily scrutinized by state DOIs and require actuarial justification."
    - name: "withdrawn_form_filings"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of policy form filings that were withdrawn before a decision. Measures filing abandonment rate — high withdrawal rates may indicate regulatory pushback or product strategy changes."
    - name: "forms_in_use_count"
      expr: COUNT(CASE WHEN is_in_use = TRUE THEN 1 END)
      comment: "Number of policy forms currently in active use. Measures the active approved product form portfolio size — used to manage form version control and compliance obligations."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_rate_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate filing metrics tracking regulatory approval status, rate change magnitudes, loss ratio performance, and LTC rate increase activity. Used by the Chief Actuary, Chief Compliance Officer, and CFO to manage pricing regulatory compliance, monitor rate adequacy, and ensure timely DOI approvals."
  source: "`life_insurance_ecm`.`compliance`.`rate_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the rate filing (e.g., Approved, Pending, Disapproved, Withdrawn) — primary dimension for rate filing pipeline monitoring."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the rate filing was submitted — used to analyze rate approval activity and outcomes by state."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the rate filing (e.g., Term Life, LTC, Annuity) — used to segment rate filing activity by product."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the rate filing — used to analyze rate change trends by business segment."
    - name: "rate_change_type"
      expr: rate_change_type
      comment: "Type of rate change being filed (e.g., Increase, Decrease, No Change) — used to segment filings by rate action direction."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to submit the rate filing (e.g., SERFF, Prior Approval, File and Use) — used to analyze filing channel compliance."
    - name: "ltc_rate_increase_flag"
      expr: CASE WHEN ltc_rate_increase_flag = TRUE THEN 'LTC Rate Increase' ELSE 'Non-LTC Increase' END
      comment: "Indicates whether the filing is an LTC rate increase — LTC rate increases are subject to heightened regulatory scrutiny and consumer notice requirements."
    - name: "hearing_required_flag"
      expr: CASE WHEN hearing_required_flag = TRUE THEN 'Hearing Required' ELSE 'No Hearing' END
      comment: "Indicates whether a regulatory hearing is required for the rate filing — hearings add significant time and cost to the approval process."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the rate filing was submitted — enables trend analysis of filing volumes and approval pipeline."
  measures:
    - name: "total_rate_filings"
      expr: COUNT(1)
      comment: "Total number of rate filings submitted. Baseline volume metric for pricing regulatory activity."
    - name: "approved_rate_filings"
      expr: COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END)
      comment: "Number of rate filings that received DOI approval. Measures pricing regulatory approval throughput."
    - name: "rate_filing_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_status IN ('Approved', 'Disapproved') THEN 1 END), 0), 2)
      comment: "Percentage of decided rate filings that received approval. Measures actuarial filing quality and regulatory relationship effectiveness."
    - name: "avg_approved_rate_change_pct"
      expr: AVG(CAST(approved_rate_change_percentage AS DOUBLE))
      comment: "Average approved rate change percentage across approved filings. Tracks the magnitude of rate changes regulators are approving — informs pricing strategy and profitability projections."
    - name: "avg_proposed_rate_change_pct"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average proposed rate change percentage across all rate filings. Measures the magnitude of rate actions being pursued — compared against approved rates to assess regulatory haircut."
    - name: "total_annual_premium_impact"
      expr: SUM(CAST(annual_premium_impact_amount AS DOUBLE))
      comment: "Total annual premium impact from all rate filings. Measures the aggregate revenue effect of rate actions — key input for financial planning and investor communications."
    - name: "avg_current_loss_ratio"
      expr: AVG(CAST(loss_ratio_current AS DOUBLE))
      comment: "Average current loss ratio across rate filings. Measures pricing adequacy — loss ratios above target trigger rate increase filings and inform reserve adequacy assessments."
    - name: "avg_projected_loss_ratio"
      expr: AVG(CAST(loss_ratio_projected AS DOUBLE))
      comment: "Average projected loss ratio across rate filings. Forward-looking pricing adequacy metric — used by actuaries and CFO to assess whether proposed rates will achieve target profitability."
    - name: "ltc_rate_increase_filings"
      expr: COUNT(CASE WHEN ltc_rate_increase_flag = TRUE THEN 1 END)
      comment: "Number of LTC rate increase filings. Tracks the volume of LTC repricing activity — LTC rate increases are a major regulatory and reputational risk area for life insurers."
    - name: "avg_rate_approval_cycle_days"
      expr: AVG(DATEDIFF(doi_approval_date, submission_date))
      comment: "Average number of days from rate filing submission to DOI approval. Measures regulatory review cycle time — directly impacts the timing of rate changes taking effect."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident and data breach metrics tracking incident volumes, breach determinations, regulatory notification compliance, and remediation timeliness. Used by the Chief Privacy Officer, Chief Compliance Officer, and General Counsel to manage HIPAA, state breach notification, and HHS reporting obligations."
  source: "`life_insurance_ecm`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident (e.g., Open, Under Investigation, Closed) — used to track active incident workload."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (e.g., Unauthorized Access, Lost Device, Phishing) — used to analyze incident patterns and root causes."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the privacy incident (e.g., Human Error, System Failure, Malicious Actor) — used to prioritize preventive controls investment."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the incident occurred or where notification is required — used to track state-specific breach notification obligations."
    - name: "is_breach_determined"
      expr: CASE WHEN is_breach_determined = TRUE THEN 'Breach Confirmed' ELSE 'Not a Breach / Under Review' END
      comment: "Indicates whether the incident has been formally determined to be a reportable breach — drives regulatory notification obligations."
    - name: "includes_health_information"
      expr: CASE WHEN includes_health_information = TRUE THEN 'PHI Involved' ELSE 'No PHI' END
      comment: "Indicates whether the incident involved Protected Health Information — PHI breaches trigger HIPAA notification requirements."
    - name: "includes_ssn"
      expr: CASE WHEN includes_ssn = TRUE THEN 'SSN Exposed' ELSE 'No SSN' END
      comment: "Indicates whether Social Security Numbers were exposed — SSN exposure triggers state breach notification laws in all 50 states."
    - name: "multi_state_flag"
      expr: CASE WHEN multi_state_flag = TRUE THEN 'Multi-State Incident' ELSE 'Single-State Incident' END
      comment: "Indicates whether the incident spans multiple state jurisdictions — multi-state incidents require coordinated notification across multiple regulatory frameworks."
    - name: "discovery_date_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the privacy incident was discovered — enables trend analysis of incident volumes over time."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents reported. Baseline volume metric for privacy risk monitoring — used by CPO to track incident trends."
    - name: "confirmed_breaches"
      expr: COUNT(CASE WHEN is_breach_determined = TRUE THEN 1 END)
      comment: "Number of incidents formally determined to be reportable data breaches. Critical compliance metric — confirmed breaches trigger mandatory regulatory notification obligations."
    - name: "breach_determination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_breach_determined = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy incidents that result in a confirmed breach determination. Measures the severity of the organization's privacy incident portfolio."
    - name: "hhs_notification_overdue"
      expr: COUNT(CASE WHEN hhs_notification_required = TRUE AND hhs_notification_date IS NULL AND notification_deadline_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of breaches requiring HHS notification where the deadline has passed without notification. Measures HIPAA Breach Notification Rule compliance — overdue notifications expose the company to OCR enforcement."
    - name: "doi_notification_overdue"
      expr: COUNT(CASE WHEN doi_notification_required = TRUE AND doi_notification_date IS NULL AND notification_deadline_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of breaches requiring state DOI notification where the deadline has passed. Measures state insurance breach notification compliance — overdue notifications trigger regulatory penalties."
    - name: "incidents_with_phi_exposure"
      expr: COUNT(CASE WHEN includes_health_information = TRUE THEN 1 END)
      comment: "Number of privacy incidents involving Protected Health Information. Measures HIPAA exposure volume — PHI incidents carry the highest regulatory and reputational risk."
    - name: "incidents_with_ssn_exposure"
      expr: COUNT(CASE WHEN includes_ssn = TRUE THEN 1 END)
      comment: "Number of privacy incidents where Social Security Numbers were exposed. Measures identity theft risk exposure — SSN exposure triggers notification obligations in all 50 states."
    - name: "avg_breach_determination_days"
      expr: AVG(DATEDIFF(breach_determination_date, discovery_date))
      comment: "Average number of days from incident discovery to breach determination. Measures investigation timeliness — HIPAA requires breach determination within 60 days of discovery."
    - name: "remediation_overdue_incidents"
      expr: COUNT(CASE WHEN incident_status <> 'Closed' AND remediation_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open privacy incidents where the remediation due date has passed. Measures remediation program timeliness and ongoing exposure from unresolved incidents."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_remediation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance remediation plan metrics tracking plan status, completion timeliness, financial exposure, and recurrence rates across all regulatory and compliance deficiencies. Used by the Chief Compliance Officer and Board Risk Committee to monitor the organization's ability to resolve compliance deficiencies and demonstrate corrective action to regulators."
  source: "`life_insurance_ecm`.`compliance`.`remediation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the remediation plan (e.g., Open, In Progress, Completed, Overdue) — primary dimension for remediation pipeline monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of remediation plan (e.g., Corrective Action Plan, Regulatory Commitment, Internal Remediation) — used to segment plans by obligation type."
    - name: "corrective_action_type"
      expr: corrective_action_type
      comment: "Type of corrective action being taken (e.g., Process Change, System Enhancement, Training) — used to analyze remediation approach patterns."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the underlying deficiency (e.g., Critical, High, Medium, Low) — used to prioritize remediation resources."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the remediation plan — used to triage remediation workload."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the remediation plan — used to track remediation accountability by business unit."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the remediation obligation (e.g., HIPAA, AML/BSA, State DOI) — used to segment remediation activity by regulatory domain."
    - name: "recurrence_indicator"
      expr: CASE WHEN recurrence_indicator = TRUE THEN 'Recurring Deficiency' ELSE 'New Deficiency' END
      comment: "Indicates whether the deficiency has recurred from a prior remediation — recurring deficiencies signal systemic control failures."
    - name: "affected_business_domain"
      expr: affected_business_domain
      comment: "Business domain affected by the compliance deficiency (e.g., Underwriting, Claims, Sales) — used to identify operational areas with highest compliance risk."
    - name: "plan_open_date_month"
      expr: DATE_TRUNC('MONTH', plan_open_date)
      comment: "Month the remediation plan was opened — enables trend analysis of remediation plan volumes over time."
  measures:
    - name: "total_remediation_plans"
      expr: COUNT(1)
      comment: "Total number of remediation plans. Baseline volume metric for compliance remediation workload — used by CCO to track overall remediation pipeline."
    - name: "open_remediation_plans"
      expr: COUNT(CASE WHEN plan_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of currently open remediation plans. Measures active compliance remediation backlog — large backlogs indicate resource constraints or systemic compliance issues."
    - name: "overdue_remediation_plans"
      expr: COUNT(CASE WHEN plan_status NOT IN ('Completed', 'Closed') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open remediation plans past their target completion date. Critical compliance KPI — overdue plans risk regulatory escalation and demonstrate inadequate remediation commitment."
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status IN ('Completed', 'Closed') AND actual_completion_date <= target_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN plan_status IN ('Completed', 'Closed') THEN 1 END), 0), 2)
      comment: "Percentage of completed remediation plans finished on or before the target date. Measures remediation program effectiveness and commitment reliability — key metric for regulator confidence."
    - name: "total_financial_exposure_amount"
      expr: SUM(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Total financial exposure associated with open compliance deficiencies. Measures aggregate financial risk from unresolved compliance issues — used to size regulatory reserves."
    - name: "total_remediation_cost_amount"
      expr: SUM(CAST(remediation_cost_amount AS DOUBLE))
      comment: "Total cost incurred to execute remediation plans. Measures the financial investment in compliance remediation — used to justify compliance program budgets."
    - name: "recurring_deficiency_plans"
      expr: COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END)
      comment: "Number of remediation plans addressing recurring deficiencies. Measures systemic control failure rate — recurring deficiencies attract heightened regulatory scrutiny and signal inadequate root cause resolution."
    - name: "avg_remediation_cycle_days"
      expr: AVG(DATEDIFF(actual_completion_date, plan_open_date))
      comment: "Average number of days from plan opening to actual completion. Measures remediation execution speed — used to benchmark program efficiency and set realistic regulatory commitments."
    - name: "plans_requiring_regulatory_acceptance"
      expr: COUNT(CASE WHEN regulatory_acceptance_date IS NOT NULL OR regulatory_acceptance_status IS NOT NULL THEN 1 END)
      comment: "Number of remediation plans requiring formal regulatory acceptance. Tracks the volume of plans subject to regulator sign-off — these carry the highest compliance risk if not completed on time."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_suitability_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suitability review metrics tracking review outcomes, override rates, remediation requirements, and financial profile adequacy across all annuity and life insurance product sales. Used by the Chief Compliance Officer and Head of Distribution to ensure compliance with NAIC Suitability in Annuity Transactions Model Regulation and FINRA Reg BI obligations."
  source: "`life_insurance_ecm`.`compliance`.`suitability_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the suitability review (e.g., Approved, Pending, Rejected, Escalated) — primary dimension for suitability pipeline monitoring."
    - name: "suitability_determination"
      expr: suitability_determination
      comment: "Final suitability determination (e.g., Suitable, Not Suitable, Conditionally Suitable) — measures consumer protection compliance outcomes."
    - name: "review_type"
      expr: review_type
      comment: "Type of suitability review (e.g., New Business, Replacement, 1035 Exchange) — used to segment reviews by transaction type."
    - name: "product_type"
      expr: product_type
      comment: "Product type subject to suitability review (e.g., Fixed Annuity, Variable Annuity, IUL) — used to analyze suitability compliance by product."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction where the sale occurred — used to analyze suitability compliance by state regulatory framework."
    - name: "risk_tolerance"
      expr: risk_tolerance
      comment: "Client's stated risk tolerance (e.g., Conservative, Moderate, Aggressive) — used to analyze product-to-client risk alignment."
    - name: "investment_objective"
      expr: investment_objective
      comment: "Client's stated investment objective (e.g., Growth, Income, Capital Preservation) — used to assess product-objective alignment."
    - name: "override_flag"
      expr: CASE WHEN override_flag = TRUE THEN 'Override Applied' ELSE 'No Override' END
      comment: "Indicates whether a supervisory override was applied to the suitability determination — overrides require heightened scrutiny and documentation."
    - name: "is_replacement"
      expr: CASE WHEN is_replacement = TRUE THEN 'Replacement Sale' ELSE 'New Sale' END
      comment: "Indicates whether the sale involves replacing an existing policy — replacement sales carry additional suitability and disclosure obligations."
    - name: "finra_reg_bi_applicable_flag"
      expr: CASE WHEN finra_reg_bi_applicable_flag = TRUE THEN 'Reg BI Applicable' ELSE 'Reg BI Not Applicable' END
      comment: "Indicates whether FINRA Regulation Best Interest applies to the transaction — Reg BI transactions require enhanced documentation and best interest analysis."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the suitability review was conducted — enables trend analysis of review volumes and outcomes over time."
  measures:
    - name: "total_suitability_reviews"
      expr: COUNT(1)
      comment: "Total number of suitability reviews conducted. Baseline volume metric for suitability compliance program activity."
    - name: "not_suitable_determinations"
      expr: COUNT(CASE WHEN suitability_determination = 'Not Suitable' THEN 1 END)
      comment: "Number of transactions determined to be not suitable for the client. Critical consumer protection metric — not suitable determinations require immediate intervention to prevent policy issuance."
    - name: "suitability_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suitability_determination = 'Suitable' THEN 1 END) / NULLIF(COUNT(CASE WHEN suitability_determination IN ('Suitable', 'Not Suitable') THEN 1 END), 0), 2)
      comment: "Percentage of completed suitability reviews resulting in a suitable determination. Measures overall suitability compliance rate — used to benchmark against industry standards and regulatory expectations."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suitability reviews where a supervisory override was applied. High override rates attract regulatory scrutiny and may indicate systematic mis-selling — key sales practice compliance KPI."
    - name: "remediation_required_reviews"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Number of suitability reviews requiring remediation action. Measures the volume of consumer protection remediation obligations generated by the sales process."
    - name: "replacement_sale_reviews"
      expr: COUNT(CASE WHEN is_replacement = TRUE THEN 1 END)
      comment: "Number of suitability reviews for replacement sales. Tracks replacement activity volume — high replacement rates may indicate churning and trigger regulatory examination."
    - name: "avg_client_net_worth"
      expr: AVG(CAST(net_worth AS DOUBLE))
      comment: "Average net worth of clients undergoing suitability review. Measures the financial profile of the customer base being sold complex insurance products — used to assess product-to-client wealth alignment."
    - name: "avg_investment_amount"
      expr: AVG(CAST(investment_amount AS DOUBLE))
      comment: "Average investment amount per suitability review. Measures the average transaction size — used to assess concentration risk and the financial impact of any suitability failures."
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total investment amount across all suitability reviews. Measures the aggregate dollar value of transactions subject to suitability review — used to size consumer protection exposure."
    - name: "reg_bi_applicable_reviews"
      expr: COUNT(CASE WHEN finra_reg_bi_applicable_flag = TRUE THEN 1 END)
      comment: "Number of suitability reviews subject to FINRA Regulation Best Interest. Tracks the volume of transactions requiring enhanced Reg BI documentation and best interest analysis."
    - name: "reviews_missing_client_acknowledgment"
      expr: COUNT(CASE WHEN client_acknowledgment_flag = FALSE OR client_acknowledgment_date IS NULL THEN 1 END)
      comment: "Number of suitability reviews where client acknowledgment was not obtained. Measures documentation compliance — missing acknowledgments are a common exam finding and regulatory deficiency."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation inventory metrics tracking obligation status, materiality, penalty exposure, and filing frequency across all compliance requirements. Used by the Chief Compliance Officer to maintain a complete regulatory obligation register, prioritize compliance resources, and report to the Board Risk Committee on the regulatory obligation landscape."
  source: "`life_insurance_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the regulatory obligation (e.g., Active, Expired, Pending) — used to track the active obligation portfolio."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., Filing, Reporting, Licensing, Examination) — used to segment obligations by compliance category."
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Compliance domain of the obligation (e.g., AML/BSA, HIPAA, Market Conduct, RBC) — used to analyze obligation distribution across regulatory frameworks."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation (e.g., NAIC, State DOI, FinCEN, SEC) — used to segment obligations by regulator."
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Type of jurisdiction (e.g., State, Federal, International) — used to analyze obligation distribution by regulatory level."
    - name: "filing_frequency"
      expr: filing_frequency
      comment: "Frequency of the filing obligation (e.g., Annual, Quarterly, Monthly, Ad Hoc) — used to plan compliance calendar and resource allocation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation (e.g., Critical, High, Medium, Low) — used to triage compliance resources."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the obligation — used to track compliance accountability by business unit."
    - name: "is_material_obligation"
      expr: CASE WHEN is_material_obligation = TRUE THEN 'Material Obligation' ELSE 'Non-Material Obligation' END
      comment: "Indicates whether the obligation is material to the business — material obligations require board-level awareness and enhanced monitoring."
    - name: "rbc_relevance_flag"
      expr: CASE WHEN rbc_relevance_flag = TRUE THEN 'RBC Relevant' ELSE 'Non-RBC' END
      comment: "Indicates whether the obligation is relevant to Risk-Based Capital requirements — RBC obligations are critical for solvency regulation compliance."
  measures:
    - name: "total_regulatory_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations in the compliance register. Baseline metric for the organization's regulatory obligation footprint — used to size the compliance function."
    - name: "active_obligations_count"
      expr: COUNT(CASE WHEN obligation_status = 'Active' THEN 1 END)
      comment: "Number of currently active regulatory obligations. Measures the active compliance workload — used to assess compliance function capacity requirements."
    - name: "material_obligations_count"
      expr: COUNT(CASE WHEN is_material_obligation = TRUE THEN 1 END)
      comment: "Number of material regulatory obligations. Tracks the subset of obligations requiring board-level oversight — used in board risk reporting."
    - name: "total_penalty_exposure_usd"
      expr: SUM(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Total potential penalty exposure across all active regulatory obligations. Measures aggregate regulatory financial risk — used to size compliance reserves and justify compliance investment."
    - name: "avg_penalty_exposure_usd"
      expr: AVG(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Average penalty amount per regulatory obligation. Benchmarks the financial severity of individual obligations — used to prioritize high-penalty obligations for enhanced monitoring."
    - name: "obligations_requiring_attestation"
      expr: COUNT(CASE WHEN is_attestation_required = TRUE THEN 1 END)
      comment: "Number of obligations requiring formal compliance attestation. Tracks the volume of attestation obligations — used to plan attestation calendar and governance workload."
    - name: "obligations_past_statutory_due_date"
      expr: COUNT(CASE WHEN obligation_status = 'Active' AND statutory_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of active obligations where the statutory due date has passed. Measures potential regulatory non-compliance exposure — any overdue statutory obligation requires immediate escalation."
    - name: "external_filing_obligations_count"
      expr: COUNT(CASE WHEN is_external_filing = TRUE THEN 1 END)
      comment: "Number of obligations requiring external regulatory filings. Measures the volume of public regulatory reporting commitments — used to plan filing calendar and external counsel resources."
$$;