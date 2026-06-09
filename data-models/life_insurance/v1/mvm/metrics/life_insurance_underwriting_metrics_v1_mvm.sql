-- Metric views for domain: underwriting | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core underwriting application pipeline metrics tracking volume, financial exposure, risk profile, and submission quality. Used by Chief Underwriting Officers and VP Underwriting to monitor new business flow, approval rates, and premium production."
  source: "`life_insurance_ecm`.`underwriting`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., Pending, Approved, Declined, Postponed) — primary pipeline segmentation dimension."
    - name: "application_type"
      expr: application_type
      comment: "Type of application (e.g., New Business, Conversion, Reinstatement) — used to segment production by business type."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g., Agent, Direct, Digital) — used to evaluate channel effectiveness."
    - name: "premium_mode"
      expr: premium_mode
      comment: "Premium payment frequency (e.g., Annual, Monthly, Quarterly) — used to analyze premium collection patterns."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Calendar month of application submission — used for trend analysis and monthly production reporting."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Calendar month of underwriting decision — used to track decision throughput over time."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Calendar month of formal submission — used to align production reporting with submission pipelines."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the application was Not In Good Order at submission — used to measure submission quality."
    - name: "replacement_indicator"
      expr: replacement_indicator
      comment: "Indicates whether the application involves replacement of an existing policy — regulatory and persistency risk dimension."
    - name: "exchange_1035_flag"
      expr: exchange_1035_flag
      comment: "Indicates a 1035 tax-free exchange — used to track exchange business volume and associated compliance requirements."
    - name: "medical_exam_required"
      expr: medical_exam_required
      comment: "Indicates whether a medical exam was required — used to segment applications by underwriting complexity."
    - name: "financial_underwriting_required"
      expr: financial_underwriting_required
      comment: "Indicates whether financial underwriting was required — used to segment high-face-amount or complex cases."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status — compliance dimension for AML/KYC monitoring."
    - name: "mib_check_status"
      expr: mib_check_status
      comment: "Status of the MIB (Medical Information Bureau) check — used to track completion of required pre-issue checks."
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating assigned to the application (e.g., Table 2, Table 4) — used to segment substandard risk production."
    - name: "decision_reason"
      expr: decision_reason
      comment: "Reason code or description for the underwriting decision — used to analyze decline and postpone drivers."
  measures:
    - name: "total_applications_submitted"
      expr: COUNT(1)
      comment: "Total number of applications submitted. Baseline production volume KPI used in every underwriting dashboard and QBR."
    - name: "total_applied_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total applied face amount (sum of death benefit requested). Primary measure of new business financial exposure and production volume in dollars."
    - name: "total_applied_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total annualized premium from submitted applications. Core revenue pipeline metric used by Finance and Actuarial to project earned premium."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) across submitted applications. Critical reinsurance and risk management metric — drives retention and cession decisions."
    - name: "avg_face_amount_per_application"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per application. Indicates average case size and is used to monitor shifts in product mix and target market."
    - name: "avg_premium_per_application"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per application. Used to track average case value and monitor premium adequacy trends."
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML (Anti-Money Laundering) risk score across applications. Compliance KPI — elevated averages trigger enhanced due diligence reviews."
    - name: "avg_stoli_risk_score"
      expr: AVG(CAST(stoli_risk_score AS DOUBLE))
      comment: "Average STOLI (Stranger-Originated Life Insurance) risk score. Fraud and risk management KPI — high scores indicate potential investor-driven policy schemes."
    - name: "total_flat_extra_amount"
      expr: SUM(CAST(flat_extra_amount AS DOUBLE))
      comment: "Total flat extra premium charged across applications. Measures the aggregate substandard risk surcharge applied to the book of business."
    - name: "nigo_application_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN 1 END)
      comment: "Count of applications flagged as Not In Good Order. Operational quality KPI — high NIGO rates indicate producer training gaps and delay new business issuance."
    - name: "replacement_application_count"
      expr: COUNT(CASE WHEN replacement_indicator = TRUE THEN 1 END)
      comment: "Count of replacement applications. Regulatory and persistency KPI — replacements require suitability review and are monitored for churning risk."
    - name: "medical_exam_required_count"
      expr: COUNT(CASE WHEN medical_exam_required = TRUE THEN 1 END)
      comment: "Count of applications requiring a medical exam. Operational throughput KPI — drives exam vendor capacity planning and cycle time management."
    - name: "financial_uw_required_count"
      expr: COUNT(CASE WHEN financial_underwriting_required = TRUE THEN 1 END)
      comment: "Count of applications requiring financial underwriting review. Capacity planning KPI for the financial underwriting team."
    - name: "exchange_1035_application_count"
      expr: COUNT(CASE WHEN exchange_1035_flag = TRUE THEN 1 END)
      comment: "Count of 1035 exchange applications. Used to monitor tax-free exchange volume, which carries specific compliance and suitability obligations."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting decision outcome metrics tracking approval rates, financial terms, risk ratings, and decision quality. Used by Chief Underwriting Officers, Actuarial, and Compliance to evaluate decision consistency, substandard risk pricing, and regulatory adherence."
  source: "`life_insurance_ecm`.`underwriting`.`decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Final status of the underwriting decision (e.g., Approved, Declined, Postponed, Referred) — primary outcome segmentation."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of underwriting decision (e.g., Standard, Substandard, Facultative) — used to segment decision complexity."
    - name: "decision_method"
      expr: decision_method
      comment: "Method used to reach the decision (e.g., Automated, Manual, Hybrid) — used to track STP (straight-through processing) rates."
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating assigned at decision (e.g., Table 2, Table 4) — used to segment substandard risk pricing outcomes."
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Standardized reason code for declined applications — used to analyze decline drivers and identify systemic underwriting issues."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Calendar month of the underwriting decision — used for trend analysis of decision throughput and outcome mix."
    - name: "reinsurance_required"
      expr: reinsurance_required
      comment: "Indicates whether reinsurance was required for this decision — used to monitor cession volume and reinsurer capacity utilization."
    - name: "exclusion_rider_applied"
      expr: exclusion_rider_applied
      comment: "Indicates whether an exclusion rider was applied — used to track frequency of conditional approvals."
    - name: "supervisory_approval_required"
      expr: supervisory_approval_required
      comment: "Indicates whether supervisory approval was required — used to monitor escalation rates and underwriter authority compliance."
    - name: "stoli_indicator"
      expr: stoli_indicator
      comment: "Indicates STOLI (Stranger-Originated Life Insurance) risk was identified — fraud risk dimension for compliance reporting."
    - name: "medical_exam_required"
      expr: medical_exam_required
      comment: "Indicates whether a medical exam was required at decision — used to correlate exam requirements with decision outcomes."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status at time of decision — compliance dimension for AML/KYC monitoring."
    - name: "financial_underwriting_completed"
      expr: financial_underwriting_completed
      comment: "Indicates whether financial underwriting was completed prior to decision — used to ensure process compliance on large-face cases."
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total number of underwriting decisions rendered. Baseline throughput KPI for the underwriting function."
    - name: "approved_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END)
      comment: "Count of approved underwriting decisions. Numerator for approval rate calculation — core new business production KPI."
    - name: "declined_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Declined' THEN 1 END)
      comment: "Count of declined underwriting decisions. Used to monitor decline rates and identify adverse selection trends."
    - name: "postponed_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Postponed' THEN 1 END)
      comment: "Count of postponed decisions. Indicates pipeline cases deferred for future re-evaluation — impacts new business conversion."
    - name: "total_approved_face_amount"
      expr: SUM(CAST(approved_face_amount AS DOUBLE))
      comment: "Total approved face amount (death benefit) across all approved decisions. Primary measure of issued risk exposure and new business production value."
    - name: "total_approved_premium_amount"
      expr: SUM(CAST(approved_premium_amount AS DOUBLE))
      comment: "Total approved premium across all approved decisions. Core revenue production metric — directly ties to earned premium projections."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) at decision. Critical reinsurance metric — drives automatic vs. facultative cession decisions and retention limit monitoring."
    - name: "avg_approved_face_amount"
      expr: AVG(CAST(approved_face_amount AS DOUBLE))
      comment: "Average approved face amount per decision. Used to monitor average case size trends and detect shifts in product mix."
    - name: "avg_flat_extra_per_thousand"
      expr: AVG(CAST(flat_extra_per_thousand AS DOUBLE))
      comment: "Average flat extra premium per thousand of face amount applied to substandard cases. Measures the average substandard risk surcharge — used by Actuarial to validate pricing adequacy."
    - name: "total_flat_extra_per_thousand"
      expr: SUM(CAST(flat_extra_per_thousand AS DOUBLE))
      comment: "Total flat extra premium per thousand across all substandard decisions. Aggregate measure of substandard risk surcharge production."
    - name: "supervisory_approval_required_count"
      expr: COUNT(CASE WHEN supervisory_approval_required = TRUE THEN 1 END)
      comment: "Count of decisions requiring supervisory approval. Escalation rate KPI — high counts indicate underwriter authority gaps or complex case volume."
    - name: "reinsurance_required_count"
      expr: COUNT(CASE WHEN reinsurance_required = TRUE THEN 1 END)
      comment: "Count of decisions requiring reinsurance. Used to monitor cession volume and reinsurer capacity utilization."
    - name: "exclusion_rider_applied_count"
      expr: COUNT(CASE WHEN exclusion_rider_applied = TRUE THEN 1 END)
      comment: "Count of decisions where an exclusion rider was applied. Measures conditional approval frequency — used to track substandard risk management practices."
    - name: "stoli_flagged_decision_count"
      expr: COUNT(CASE WHEN stoli_indicator = TRUE THEN 1 END)
      comment: "Count of decisions flagged with STOLI indicator. Fraud risk KPI — used by SIU and Compliance to monitor investor-driven policy activity."
    - name: "automated_decision_count"
      expr: COUNT(CASE WHEN decision_method = 'Automated' THEN 1 END)
      comment: "Count of decisions made via automated (STP) processing. Numerator for STP rate — operational efficiency KPI for underwriting automation programs."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics tracking medical and financial risk classification outcomes, STOLI exposure, reinsurance cession requirements, and underwriting decision quality. Used by Chief Underwriting Officers, Actuarial, and Risk Management to monitor portfolio risk profile."
  source: "`life_insurance_ecm`.`underwriting`.`risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g., Pending, Completed, Referred) — pipeline status dimension."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., Medical, Financial, Full) — used to segment assessment complexity and resource allocation."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Underwriting decision outcome from the risk assessment (e.g., Standard, Substandard, Decline) — primary risk outcome dimension."
    - name: "financial_risk_classification"
      expr: financial_risk_classification
      comment: "Financial risk classification assigned (e.g., Low, Medium, High) — used to segment financial underwriting outcomes."
    - name: "reinsurance_type"
      expr: reinsurance_type
      comment: "Type of reinsurance arrangement required (e.g., Automatic, Facultative) — used to monitor cession complexity."
    - name: "stoli_determination"
      expr: stoli_determination
      comment: "STOLI determination outcome — used to track fraud risk findings and compliance actions."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Calendar month of risk assessment — used for trend analysis of risk profile over time."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Indicates whether manual underwriter review was required — used to measure automation effectiveness."
    - name: "reinsurance_cession_required_flag"
      expr: reinsurance_cession_required_flag
      comment: "Indicates whether reinsurance cession was required — used to monitor retention limit breaches."
    - name: "stoli_indicator_flag"
      expr: stoli_indicator_flag
      comment: "Boolean STOLI risk flag — used to segment assessments with investor-driven policy risk."
    - name: "mib_inquiry_performed_flag"
      expr: mib_inquiry_performed_flag
      comment: "Indicates whether an MIB inquiry was performed — used to ensure process compliance on all eligible applications."
    - name: "premium_financing_flag"
      expr: premium_financing_flag
      comment: "Indicates premium financing involvement — used to monitor premium finance cases which carry elevated STOLI and lapse risk."
    - name: "siu_referral_flag"
      expr: siu_referral_flag
      comment: "Indicates referral to Special Investigations Unit — used to track fraud referral rates."
    - name: "nar_calculation_method"
      expr: nar_calculation_method
      comment: "Method used to calculate Net Amount at Risk — used to ensure actuarial consistency across the portfolio."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments completed. Baseline underwriting throughput KPI."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) across all risk assessments. Primary portfolio risk exposure metric — drives reinsurance program sizing and retention limit setting."
    - name: "total_human_life_value"
      expr: SUM(CAST(human_life_value_amount AS DOUBLE))
      comment: "Total Human Life Value (HLV) across assessed cases. Used to evaluate insurable interest adequacy and detect over-insurance."
    - name: "avg_medical_risk_score"
      expr: AVG(CAST(medical_risk_score AS DOUBLE))
      comment: "Average medical risk score across assessments. Actuarial KPI — tracks portfolio medical risk profile and informs mortality assumption setting."
    - name: "avg_income_replacement_multiple"
      expr: AVG(CAST(income_replacement_multiple AS DOUBLE))
      comment: "Average income replacement multiple across financial assessments. Used to monitor over-insurance risk and validate financial underwriting guidelines."
    - name: "total_existing_coverage_inforce"
      expr: SUM(CAST(existing_coverage_inforce_amount AS DOUBLE))
      comment: "Total existing in-force coverage amount across assessed applicants. Used to evaluate total insurance exposure per applicant and detect over-insurance patterns."
    - name: "manual_review_required_count"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments requiring manual underwriter review. Automation effectiveness KPI — high counts indicate rules engine gaps or complex case volume."
    - name: "reinsurance_cession_required_count"
      expr: COUNT(CASE WHEN reinsurance_cession_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments requiring reinsurance cession. Used to monitor retention limit breach frequency and reinsurer capacity utilization."
    - name: "stoli_flagged_assessment_count"
      expr: COUNT(CASE WHEN stoli_indicator_flag = TRUE THEN 1 END)
      comment: "Count of assessments flagged with STOLI indicator. Fraud risk KPI — used by Compliance and SIU to monitor investor-driven policy activity."
    - name: "siu_referral_count"
      expr: COUNT(CASE WHEN siu_referral_flag = TRUE THEN 1 END)
      comment: "Count of assessments referred to the Special Investigations Unit. Fraud management KPI — tracks volume of cases requiring SIU investigation."
    - name: "premium_financing_case_count"
      expr: COUNT(CASE WHEN premium_financing_flag = TRUE THEN 1 END)
      comment: "Count of assessments involving premium financing. Risk management KPI — premium finance cases carry elevated lapse and STOLI risk."
    - name: "mib_inquiry_performed_count"
      expr: COUNT(CASE WHEN mib_inquiry_performed_flag = TRUE THEN 1 END)
      comment: "Count of assessments where MIB inquiry was performed. Process compliance KPI — ensures MIB checks are completed on all eligible applications."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_evidence_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evidence review cycle time, quality, and outcome metrics. Used by Underwriting Operations and Medical Directors to monitor evidence processing efficiency, SLA compliance, and medical risk identification rates."
  source: "`life_insurance_ecm`.`underwriting`.`evidence_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the evidence review (e.g., Pending, In Progress, Completed) — pipeline status dimension."
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the evidence review (e.g., Standard, Substandard, Decline Recommended) — used to segment review results by risk impact."
    - name: "evidence_type_code"
      expr: evidence_type_code
      comment: "Type of evidence reviewed (e.g., APS, Lab Results, Exam Report) — used to analyze review volume and cycle time by evidence type."
    - name: "evidence_source"
      expr: evidence_source
      comment: "Source of the evidence (e.g., Physician, Lab, Examiner) — used to track evidence sourcing patterns."
    - name: "review_priority"
      expr: review_priority
      comment: "Priority level assigned to the review (e.g., Standard, Expedited, Rush) — used to monitor SLA compliance by priority tier."
    - name: "rating_action_recommended"
      expr: rating_action_recommended
      comment: "Rating action recommended based on evidence review (e.g., Standard, Table Rating, Flat Extra, Decline) — used to track substandard recommendation rates."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the review was completed within SLA — primary operational quality dimension."
    - name: "peer_review_required"
      expr: peer_review_required
      comment: "Indicates whether peer review was required — used to monitor complex case volume requiring second opinion."
    - name: "medical_director_review_required"
      expr: medical_director_review_required
      comment: "Indicates whether Medical Director review was required — used to track escalation rates to senior medical staff."
    - name: "facultative_reinsurance_required"
      expr: facultative_reinsurance_required
      comment: "Indicates whether facultative reinsurance was required based on evidence — used to monitor complex risk cession volume."
    - name: "exclusion_rider_recommended"
      expr: exclusion_rider_recommended
      comment: "Indicates whether an exclusion rider was recommended — used to track conditional approval frequency."
    - name: "evidence_received_month"
      expr: DATE_TRUNC('MONTH', evidence_received_date)
      comment: "Calendar month evidence was received — used for trend analysis of evidence receipt volume."
  measures:
    - name: "total_evidence_reviews"
      expr: COUNT(1)
      comment: "Total number of evidence reviews conducted. Baseline operational throughput KPI for the evidence review function."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average evidence review turnaround time in hours. Core operational efficiency KPI — directly impacts new business cycle time and producer satisfaction."
    - name: "total_turnaround_time_hours"
      expr: SUM(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Total hours spent on evidence reviews. Used to measure aggregate operational capacity consumption and staffing adequacy."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of evidence reviews completed within SLA. Numerator for SLA compliance rate — key operational quality KPI."
    - name: "sla_breached_count"
      expr: COUNT(CASE WHEN sla_met_flag = FALSE THEN 1 END)
      comment: "Count of evidence reviews that breached SLA. Used to identify operational bottlenecks and trigger process improvement actions."
    - name: "peer_review_required_count"
      expr: COUNT(CASE WHEN peer_review_required = TRUE THEN 1 END)
      comment: "Count of reviews requiring peer review. Complexity and quality KPI — high rates indicate difficult case volume or underwriter skill gaps."
    - name: "medical_director_escalation_count"
      expr: COUNT(CASE WHEN medical_director_review_required = TRUE THEN 1 END)
      comment: "Count of reviews escalated to Medical Director. Senior resource utilization KPI — used to manage Medical Director capacity and identify complex risk patterns."
    - name: "facultative_reinsurance_required_count"
      expr: COUNT(CASE WHEN facultative_reinsurance_required = TRUE THEN 1 END)
      comment: "Count of reviews requiring facultative reinsurance. Used to monitor complex risk cession volume and reinsurer relationship management."
    - name: "exclusion_rider_recommended_count"
      expr: COUNT(CASE WHEN exclusion_rider_recommended = TRUE THEN 1 END)
      comment: "Count of reviews where an exclusion rider was recommended. Tracks conditional approval frequency — used to monitor substandard risk management practices."
    - name: "avg_flat_extra_amount"
      expr: AVG(CAST(flat_extra_amount AS DOUBLE))
      comment: "Average flat extra premium amount recommended per review. Used by Actuarial to validate that substandard risk surcharges are consistent with evidence findings."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_financial_uw_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial underwriting review metrics tracking insurable interest, over-insurance risk, AML/KYC compliance, and financial decision outcomes. Used by Chief Underwriting Officers, Compliance, and Financial Underwriting teams to monitor large-face-amount case quality."
  source: "`life_insurance_ecm`.`underwriting`.`financial_uw_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the financial underwriting review (e.g., Pending, In Progress, Completed) — pipeline status dimension."
    - name: "review_type"
      expr: review_type
      comment: "Type of financial review (e.g., Business Insurance, Personal Insurance, Key Person) — used to segment review volume by purpose."
    - name: "financial_decision"
      expr: financial_decision
      comment: "Financial underwriting decision outcome (e.g., Approved, Declined, Reduced Coverage) — primary outcome dimension."
    - name: "insurable_interest_determination"
      expr: insurable_interest_determination
      comment: "Determination of insurable interest (e.g., Confirmed, Questionable, Denied) — compliance and fraud risk dimension."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status at time of financial review — AML compliance dimension."
    - name: "stoli_risk_indicator"
      expr: stoli_risk_indicator
      comment: "STOLI risk indicator from financial review — used to segment cases with investor-driven policy risk."
    - name: "over_insurance_indicator"
      expr: over_insurance_indicator
      comment: "Indicates whether over-insurance was identified — used to monitor cases where applied coverage exceeds financial justification."
    - name: "financial_statement_reviewed"
      expr: financial_statement_reviewed
      comment: "Indicates whether financial statements were reviewed — process compliance dimension for large-face cases."
    - name: "financial_statement_type"
      expr: financial_statement_type
      comment: "Type of financial statement reviewed (e.g., Tax Return, Audited Financials, Bank Statement) — used to assess evidence quality."
    - name: "review_start_month"
      expr: DATE_TRUNC('MONTH', review_start_date)
      comment: "Calendar month the financial review was initiated — used for trend analysis of review volume."
    - name: "review_completion_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Calendar month the financial review was completed — used for throughput trend analysis."
  measures:
    - name: "total_financial_reviews"
      expr: COUNT(1)
      comment: "Total number of financial underwriting reviews conducted. Baseline throughput KPI for the financial underwriting function."
    - name: "total_applied_coverage_amount"
      expr: SUM(CAST(applied_coverage_amount AS DOUBLE))
      comment: "Total applied coverage amount across financial reviews. Measures aggregate financial exposure submitted for financial underwriting evaluation."
    - name: "total_approved_coverage_amount"
      expr: SUM(CAST(approved_coverage_amount AS DOUBLE))
      comment: "Total approved coverage amount from financial reviews. Measures aggregate coverage approved after financial justification — key production metric."
    - name: "avg_income_replacement_multiple"
      expr: AVG(CAST(income_replacement_multiple AS DOUBLE))
      comment: "Average income replacement multiple across financial reviews. Used to monitor over-insurance risk and validate financial underwriting guidelines."
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML risk score across financial reviews. Compliance KPI — elevated averages trigger enhanced due diligence and SAR filing considerations."
    - name: "avg_net_worth"
      expr: AVG(CAST(net_worth AS DOUBLE))
      comment: "Average net worth of applicants undergoing financial review. Used to validate coverage amounts relative to financial capacity."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of applicants undergoing financial review. Used to assess income replacement multiples and validate financial justification."
    - name: "over_insurance_case_count"
      expr: COUNT(CASE WHEN over_insurance_indicator = TRUE THEN 1 END)
      comment: "Count of cases where over-insurance was identified. Risk management KPI — over-insured cases require coverage reduction or decline to prevent moral hazard."
    - name: "total_existing_inforce_amount"
      expr: SUM(CAST(existing_inforce_amount AS DOUBLE))
      comment: "Total existing in-force coverage amount across reviewed applicants. Used to assess total insurance exposure and detect over-insurance patterns."
    - name: "total_coverage_amount_reviewed"
      expr: SUM(CAST(total_coverage_amount AS DOUBLE))
      comment: "Total combined coverage amount (applied plus existing in-force) across financial reviews. Comprehensive exposure metric used to evaluate aggregate insurance-to-income ratios."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_reinsurance_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance placement metrics tracking cession volume, facultative submission outcomes, NAR ceded, and placement efficiency. Used by Reinsurance Managers, Actuarial, and CFO to monitor risk transfer effectiveness and reinsurer relationship performance."
  source: "`life_insurance_ecm`.`underwriting`.`reinsurance_placement`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of the reinsurance placement (e.g., Pending, Placed, Declined, Expired) — primary pipeline status dimension."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of reinsurance placement (e.g., Automatic, Facultative) — used to segment cession volume by placement method."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the placement (e.g., Term Life, Whole Life, UL) — used to analyze reinsurance utilization by product."
    - name: "reinsurer_decision"
      expr: reinsurer_decision
      comment: "Decision from the reinsurer (e.g., Accepted, Declined, Modified) — used to track facultative acceptance rates."
    - name: "ceding_risk_class_code"
      expr: ceding_risk_class_code
      comment: "Risk class code assigned by the ceding company — used to analyze cession patterns by risk classification."
    - name: "reinsurer_risk_class_code"
      expr: reinsurer_risk_class_code
      comment: "Risk class code assigned by the reinsurer — used to identify risk class discrepancies between ceding company and reinsurer."
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured — used to analyze reinsurance placement patterns by demographic."
    - name: "stoli_indicator"
      expr: stoli_indicator
      comment: "STOLI indicator on the placement — used to monitor reinsurer notification requirements for STOLI-flagged cases."
    - name: "placement_effective_month"
      expr: DATE_TRUNC('MONTH', placement_effective_date)
      comment: "Calendar month the reinsurance placement became effective — used for trend analysis of cession volume."
    - name: "facultative_submission_month"
      expr: DATE_TRUNC('MONTH', facultative_submission_date)
      comment: "Calendar month of facultative submission — used to track facultative pipeline volume over time."
    - name: "medical_evidence_transmitted"
      expr: medical_evidence_transmitted
      comment: "Indicates whether medical evidence was transmitted to the reinsurer — process compliance dimension."
    - name: "financial_evidence_transmitted"
      expr: financial_evidence_transmitted
      comment: "Indicates whether financial evidence was transmitted to the reinsurer — process compliance dimension."
  measures:
    - name: "total_placements"
      expr: COUNT(1)
      comment: "Total number of reinsurance placements. Baseline cession volume KPI."
    - name: "total_cession_amount"
      expr: SUM(CAST(cession_amount AS DOUBLE))
      comment: "Total face amount ceded to reinsurers. Primary reinsurance program utilization metric — used to monitor retention limit compliance and reinsurer capacity consumption."
    - name: "total_nar_ceded"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) ceded to reinsurers. Core risk transfer metric — used by Actuarial and CFO to measure mortality risk transferred off balance sheet."
    - name: "avg_cession_percentage"
      expr: AVG(CAST(cession_percentage AS DOUBLE))
      comment: "Average cession percentage across placements. Used to monitor treaty utilization efficiency and detect deviations from treaty terms."
    - name: "avg_reinsurer_flat_extra_per_thousand"
      expr: AVG(CAST(reinsurer_flat_extra_per_thousand AS DOUBLE))
      comment: "Average flat extra per thousand charged by reinsurers on substandard placements. Used to compare reinsurer pricing against internal pricing assumptions."
    - name: "total_reinsurer_flat_extra_per_thousand"
      expr: SUM(CAST(reinsurer_flat_extra_per_thousand AS DOUBLE))
      comment: "Total flat extra per thousand charged by reinsurers. Aggregate reinsurance cost metric for substandard risk cessions."
    - name: "facultative_accepted_count"
      expr: COUNT(CASE WHEN reinsurer_decision = 'Accepted' THEN 1 END)
      comment: "Count of facultative submissions accepted by reinsurers. Numerator for facultative acceptance rate — used to evaluate reinsurer relationship quality and case preparation effectiveness."
    - name: "facultative_declined_count"
      expr: COUNT(CASE WHEN reinsurer_decision = 'Declined' THEN 1 END)
      comment: "Count of facultative submissions declined by reinsurers. Used to identify risk categories where reinsurance capacity is constrained."
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML risk score across reinsurance placements. Compliance KPI — reinsurers may require AML clearance before accepting cessions."
    - name: "stoli_flagged_placement_count"
      expr: COUNT(CASE WHEN stoli_indicator = TRUE THEN 1 END)
      comment: "Count of reinsurance placements flagged with STOLI indicator. Used to monitor reinsurer notification compliance for STOLI-risk cases."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_paramedical_exam`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Paramedical exam operational metrics tracking exam completion rates, cycle times, costs, and abnormal findings. Used by Underwriting Operations and Medical Directors to monitor exam vendor performance, cost management, and medical evidence quality."
  source: "`life_insurance_ecm`.`underwriting`.`paramedical_exam`"
  dimensions:
    - name: "exam_status"
      expr: exam_status
      comment: "Current status of the paramedical exam (e.g., Ordered, Scheduled, Completed, Cancelled) — pipeline status dimension."
    - name: "exam_type"
      expr: exam_type
      comment: "Type of paramedical exam (e.g., Standard, Comprehensive, EKG) — used to segment exam volume and cost by complexity."
    - name: "exam_location_type"
      expr: exam_location_type
      comment: "Type of exam location (e.g., Home, Office, Lab) — used to analyze exam delivery channel preferences and costs."
    - name: "exam_location_state"
      expr: exam_location_state
      comment: "State where the exam was conducted — used for geographic analysis of exam volume and vendor coverage."
    - name: "abnormal_findings_flag"
      expr: abnormal_findings_flag
      comment: "Indicates whether abnormal findings were identified — used to track medical risk detection rates from exams."
    - name: "lab_results_received_flag"
      expr: lab_results_received_flag
      comment: "Indicates whether lab results were received — process completion KPI for exam workflow."
    - name: "blood_specimen_collected_flag"
      expr: blood_specimen_collected_flag
      comment: "Indicates whether a blood specimen was collected — used to monitor specimen collection completion rates."
    - name: "urine_specimen_collected_flag"
      expr: urine_specimen_collected_flag
      comment: "Indicates whether a urine specimen was collected — used to monitor specimen collection completion rates."
    - name: "exam_ordered_month"
      expr: DATE_TRUNC('MONTH', exam_ordered_date)
      comment: "Calendar month the exam was ordered — used for trend analysis of exam order volume."
    - name: "exam_completed_month"
      expr: DATE_TRUNC('MONTH', exam_completed_date)
      comment: "Calendar month the exam was completed — used for throughput trend analysis."
    - name: "exam_cost_currency_code"
      expr: exam_cost_currency_code
      comment: "Currency of the exam cost — used for multi-currency cost reporting."
  measures:
    - name: "total_exams_ordered"
      expr: COUNT(1)
      comment: "Total number of paramedical exams ordered. Baseline operational volume KPI for exam management."
    - name: "total_exam_cost"
      expr: SUM(CAST(exam_cost_amount AS DOUBLE))
      comment: "Total cost of paramedical exams. Direct underwriting expense KPI — used to manage exam vendor costs and budget adherence."
    - name: "avg_exam_cost"
      expr: AVG(CAST(exam_cost_amount AS DOUBLE))
      comment: "Average cost per paramedical exam. Used to benchmark vendor pricing and identify cost optimization opportunities."
    - name: "avg_bmi"
      expr: AVG(CAST(bmi AS DOUBLE))
      comment: "Average BMI across examined applicants. Actuarial and medical KPI — used to monitor portfolio health profile and validate build chart assumptions."
    - name: "avg_weight_pounds"
      expr: AVG(CAST(weight_pounds AS DOUBLE))
      comment: "Average weight in pounds across examined applicants. Used alongside BMI to monitor applicant health profile trends."
    - name: "avg_height_inches"
      expr: AVG(CAST(height_inches AS DOUBLE))
      comment: "Average height in inches across examined applicants. Used in conjunction with weight to validate BMI calculations and build chart results."
    - name: "abnormal_findings_count"
      expr: COUNT(CASE WHEN abnormal_findings_flag = TRUE THEN 1 END)
      comment: "Count of exams with abnormal findings. Medical risk detection KPI — used to measure the yield of paramedical exams in identifying undisclosed health conditions."
    - name: "lab_results_received_count"
      expr: COUNT(CASE WHEN lab_results_received_flag = TRUE THEN 1 END)
      comment: "Count of exams where lab results were received. Process completion KPI — used to monitor lab turnaround and identify bottlenecks in the exam workflow."
    - name: "blood_specimen_collected_count"
      expr: COUNT(CASE WHEN blood_specimen_collected_flag = TRUE THEN 1 END)
      comment: "Count of exams where blood specimens were collected. Used to monitor specimen collection completion rates and identify collection failures."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_rules_engine_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automated underwriting rules engine performance metrics tracking STP eligibility, decision quality, risk scoring, and automation rates. Used by Underwriting Technology, Chief Underwriting Officers, and Actuarial to monitor rules engine effectiveness and straight-through processing performance."
  source: "`life_insurance_ecm`.`underwriting`.`rules_engine_output`"
  dimensions:
    - name: "automated_decision"
      expr: automated_decision
      comment: "Decision rendered by the automated rules engine (e.g., Approve, Decline, Refer) — primary automation outcome dimension."
    - name: "rules_engine_output_status"
      expr: rules_engine_output_status
      comment: "Status of the rules engine output (e.g., Completed, Error, Pending) — used to monitor engine reliability."
    - name: "underwriting_method"
      expr: underwriting_method
      comment: "Underwriting method applied (e.g., Accelerated, Traditional, Simplified Issue) — used to segment automation performance by underwriting program."
    - name: "product_line"
      expr: product_line
      comment: "Product line evaluated by the rules engine — used to analyze automation rates and decision quality by product."
    - name: "stp_eligible_flag"
      expr: stp_eligible_flag
      comment: "Indicates whether the application was eligible for straight-through processing — primary STP rate dimension."
    - name: "aps_required_flag"
      expr: aps_required_flag
      comment: "Indicates whether the rules engine determined an APS was required — used to monitor APS ordering rates from automated decisions."
    - name: "financial_underwriting_required_flag"
      expr: financial_underwriting_required_flag
      comment: "Indicates whether financial underwriting was required per rules engine — used to monitor referral rates to financial underwriting."
    - name: "reinsurance_required_flag"
      expr: reinsurance_required_flag
      comment: "Indicates whether reinsurance was required per rules engine — used to monitor automatic cession trigger rates."
    - name: "retention_limit_exceeded_flag"
      expr: retention_limit_exceeded_flag
      comment: "Indicates whether the retention limit was exceeded — used to monitor cases requiring mandatory reinsurance cession."
    - name: "evidence_requirements_met_flag"
      expr: evidence_requirements_met_flag
      comment: "Indicates whether all evidence requirements were met at time of rules engine evaluation — used to monitor evidence completeness rates."
    - name: "mib_check_status"
      expr: mib_check_status
      comment: "MIB check status from the rules engine evaluation — used to monitor MIB integration performance."
    - name: "smoker_status"
      expr: smoker_status
      comment: "Smoker status of the applicant as evaluated by the rules engine — used to segment risk decisions by tobacco use."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_timestamp)
      comment: "Calendar month of rules engine evaluation — used for trend analysis of automation volume and performance."
    - name: "rules_engine_version"
      expr: rules_engine_version
      comment: "Version of the rules engine used — used to compare decision quality and STP rates across engine versions."
  measures:
    - name: "total_rules_engine_evaluations"
      expr: COUNT(1)
      comment: "Total number of rules engine evaluations. Baseline automation throughput KPI."
    - name: "stp_eligible_count"
      expr: COUNT(CASE WHEN stp_eligible_flag = TRUE THEN 1 END)
      comment: "Count of applications eligible for straight-through processing. Numerator for STP rate — core underwriting automation KPI used to measure digital transformation progress."
    - name: "total_face_amount_evaluated"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount evaluated by the rules engine. Used to measure the financial exposure processed through automated underwriting."
    - name: "total_calculated_nar_amount"
      expr: SUM(CAST(calculated_nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) calculated by the rules engine. Used to monitor automated NAR calculation volume and validate against manual assessments."
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML risk score from rules engine evaluations. Compliance KPI — used to monitor AML risk profile of the automated underwriting pipeline."
    - name: "avg_stoli_risk_score"
      expr: AVG(CAST(stoli_risk_score AS DOUBLE))
      comment: "Average STOLI risk score from rules engine evaluations. Fraud risk KPI — used to monitor investor-driven policy risk in the automated pipeline."
    - name: "avg_recommended_flat_extra_per_thousand"
      expr: AVG(CAST(recommended_flat_extra_per_thousand AS DOUBLE))
      comment: "Average flat extra per thousand recommended by the rules engine. Used to validate automated substandard risk pricing against actuarial guidelines."
    - name: "retention_limit_exceeded_count"
      expr: COUNT(CASE WHEN retention_limit_exceeded_flag = TRUE THEN 1 END)
      comment: "Count of evaluations where the retention limit was exceeded. Used to monitor mandatory reinsurance cession trigger frequency."
    - name: "reinsurance_required_count"
      expr: COUNT(CASE WHEN reinsurance_required_flag = TRUE THEN 1 END)
      comment: "Count of evaluations where reinsurance was required. Used to monitor automated cession referral rates."
    - name: "aps_required_count"
      expr: COUNT(CASE WHEN aps_required_flag = TRUE THEN 1 END)
      comment: "Count of evaluations where APS was required. Used to monitor APS ordering rates from automated decisions and manage APS vendor capacity."
    - name: "financial_uw_referral_count"
      expr: COUNT(CASE WHEN financial_underwriting_required_flag = TRUE THEN 1 END)
      comment: "Count of evaluations referred to financial underwriting. Used to monitor financial underwriting team workload driven by automated referrals."
$$;