-- Metric views for domain: claims | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claims performance metrics tracking claim volumes, financial exposure, payment efficiency, and fraud/litigation risk across the life insurance claims lifecycle. Primary KPI layer for claims operations and executive reporting."
  source: "`life_insurance_ecm`.`claims`.`claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., death benefit, disability, annuity) used to segment claim volumes and financials by product line."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g., open, closed, denied, paid) for pipeline and throughput analysis."
    - name: "cause_of_loss"
      expr: cause_of_loss
      comment: "Cause of loss category (e.g., natural death, accidental, critical illness) for mortality and morbidity trend analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final claim disposition (e.g., approved, denied, withdrawn) for outcome distribution reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized denial reason code for root-cause analysis of denied claims."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of claim payment (e.g., EFT, check, annuity settlement) for operational efficiency tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the claim is denominated for multi-currency financial reporting."
    - name: "contestability_period_flag"
      expr: contestability_period_flag
      comment: "Indicates whether the claim falls within the contestability period, a key underwriting risk flag."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the claim has been flagged for fraud investigation, critical for SIU and risk management."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the claim is subject to litigation, relevant for legal reserve and exposure management."
    - name: "ibnr_flag"
      expr: ibnr_flag
      comment: "Indicates whether the claim is classified as Incurred But Not Reported (IBNR) for actuarial reserve purposes."
    - name: "date_of_loss_month"
      expr: DATE_TRUNC('MONTH', date_of_loss)
      comment: "Month of loss event for trend analysis of claim incidence over time."
    - name: "date_reported_month"
      expr: DATE_TRUNC('MONTH', date_reported)
      comment: "Month the claim was reported for reporting lag and IBNR development analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of claim payment for cash flow and payment cycle analysis."
    - name: "claimant_relationship"
      expr: claimant_relationship
      comment: "Relationship of the claimant to the insured (e.g., spouse, child, estate) for beneficiary pattern analysis."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims submitted. Baseline volume KPI for capacity planning and trend monitoring."
    - name: "total_amount_requested"
      expr: SUM(CAST(amount_requested AS DOUBLE))
      comment: "Total gross benefit amount requested by claimants. Measures total financial exposure entering the claims pipeline."
    - name: "total_amount_approved"
      expr: SUM(CAST(amount_approved AS DOUBLE))
      comment: "Total benefit amount approved for payment. Core financial outflow KPI for claims cost management."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total benefit amount actually paid to claimants. Measures realized claims cash outflow."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve held against open claims. Critical actuarial and financial solvency KPI."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk across all claims after reinsurance. Key risk exposure metric for capital management."
    - name: "avg_amount_approved"
      expr: AVG(CAST(amount_approved AS DOUBLE))
      comment: "Average approved benefit amount per claim. Benchmarks claim severity and informs pricing adequacy reviews."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims approved out of total claims. Key quality and adjudication efficiency KPI for executive dashboards."
    - name: "denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims denied. Elevated denial rates may signal underwriting issues, fraud, or process problems requiring intervention."
    - name: "fraud_flagged_claims"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims flagged for fraud investigation. Tracks SIU workload and fraud exposure volume."
    - name: "fraud_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims flagged for fraud. A rising rate signals emerging fraud patterns requiring SIU resource escalation."
    - name: "litigation_flagged_claims"
      expr: SUM(CASE WHEN litigation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims in active litigation. Drives legal reserve adequacy and external counsel budget decisions."
    - name: "contestability_period_claims"
      expr: SUM(CASE WHEN contestability_period_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims falling within the contestability period. High volumes indicate early-duration mortality risk and potential misrepresentation exposure."
    - name: "ibnr_claims"
      expr: SUM(CASE WHEN ibnr_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of IBNR-flagged claims. Supports actuarial IBNR reserve development and financial close accuracy."
    - name: "reopened_claims"
      expr: SUM(CASE WHEN reopened_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims that were reopened after closure. A quality and process efficiency indicator; high reopen rates signal adjudication deficiencies."
    - name: "investigation_required_claims"
      expr: SUM(CASE WHEN investigation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims requiring investigation. Drives SIU staffing and vendor capacity planning."
    - name: "payment_to_approved_ratio"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(amount_approved AS DOUBLE)), 0), 2)
      comment: "Ratio of amount paid to amount approved as a percentage. Values below 100% indicate payment delays or partial settlements requiring follow-up."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims payment financial metrics tracking gross and net payment flows, tax withholding, stop payments, and settlement efficiency. Supports treasury, tax reporting, and operational payment management."
  source: "`life_insurance_ecm`.`claims`.`claim_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., death benefit, surrender, annuity payout) for financial categorization."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., issued, cleared, stopped, voided) for payment lifecycle tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment delivery method (e.g., EFT, check, wire) for operational efficiency and cost analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payment (e.g., lump sum, monthly, annual) for cash flow forecasting."
    - name: "settlement_option"
      expr: settlement_option
      comment: "Settlement option elected by the beneficiary (e.g., lump sum, annuity certain) for product and liability analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the payment for multi-currency treasury reporting."
    - name: "form_1099_type"
      expr: form_1099_type
      comment: "IRS Form 1099 type associated with the payment for tax compliance reporting."
    - name: "escheatment_state"
      expr: escheatment_state
      comment: "State to which unclaimed property is escheated, for regulatory compliance tracking."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow trend analysis and financial close reporting."
    - name: "stop_payment_flag"
      expr: stop_payment_flag
      comment: "Indicates whether a stop payment was issued, flagging operational exceptions requiring resolution."
    - name: "reissue_flag"
      expr: reissue_flag
      comment: "Indicates whether the payment was reissued, a quality and operational efficiency indicator."
    - name: "form_1099_reporting_flag"
      expr: form_1099_reporting_flag
      comment: "Indicates whether the payment requires IRS 1099 reporting for tax compliance monitoring."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of claim payments issued. Baseline payment volume KPI for operations and treasury."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross benefit payments disbursed before tax withholding. Primary claims cash outflow KPI for financial reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payments after tax withholding. Represents actual cash disbursed to beneficiaries."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld from claim payments. Required for IRS reporting and tax liability reconciliation."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state income tax withheld from claim payments. Required for state tax authority reporting and compliance."
    - name: "avg_gross_payment_amount"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross payment per claim payment transaction. Benchmarks payment severity and informs benefit adequacy reviews."
    - name: "avg_beneficiary_allocation_percentage"
      expr: AVG(CAST(beneficiary_allocation_percentage AS DOUBLE))
      comment: "Average beneficiary allocation percentage across payments. Useful for multi-beneficiary claim distribution analysis."
    - name: "stop_payment_count"
      expr: SUM(CASE WHEN stop_payment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payments with stop payment orders. Elevated counts indicate operational issues with payment delivery or beneficiary disputes."
    - name: "stop_payment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN stop_payment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments stopped. A key payment quality KPI; high rates signal address/banking data quality issues."
    - name: "reissue_count"
      expr: SUM(CASE WHEN reissue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reissued payments. Reissues represent operational cost and beneficiary experience failures."
    - name: "reissue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reissue_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments reissued. Tracks payment quality and operational rework burden."
    - name: "total_tax_withholding_percentage_avg"
      expr: AVG(CAST(tax_withholding_percentage AS DOUBLE))
      comment: "Average tax withholding percentage applied across payments. Supports tax compliance monitoring and withholding adequacy reviews."
    - name: "net_to_gross_payment_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net to gross payment amounts as a percentage. Measures effective tax withholding burden across the payment portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial and financial reserve metrics for claims, tracking reserve adequacy, IBNR development, reinsurance recoverables, and reserve movements. Essential for statutory, GAAP, and IFRS17 financial reporting."
  source: "`life_insurance_ecm`.`claims`.`claim_reserve`"
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (e.g., case reserve, IBNR, ULAE) for actuarial and financial categorization."
    - name: "reserve_basis"
      expr: reserve_basis
      comment: "Basis of reserve calculation (e.g., statutory, GAAP, IFRS17) for multi-framework financial reporting."
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve (e.g., active, released, closed) for reserve lifecycle management."
    - name: "reserve_adequacy_indicator"
      expr: reserve_adequacy_indicator
      comment: "Actuarial indicator of reserve adequacy (e.g., adequate, deficient, redundant) for solvency monitoring."
    - name: "estimation_methodology"
      expr: estimation_methodology
      comment: "Actuarial methodology used to estimate reserves (e.g., chain ladder, Bornhuetter-Ferguson) for methodology governance."
    - name: "reserve_currency_code"
      expr: reserve_currency_code
      comment: "Currency of the reserve for multi-currency financial consolidation."
    - name: "catastrophic_event_flag"
      expr: catastrophic_event_flag
      comment: "Indicates whether the reserve is associated with a catastrophic event for CAT reserve segregation and reinsurance recovery."
    - name: "catastrophic_event_code"
      expr: catastrophic_event_code
      comment: "Code identifying the specific catastrophic event for event-level reserve aggregation."
    - name: "actuarial_signoff_status"
      expr: actuarial_signoff_status
      comment: "Status of actuarial sign-off on the reserve for governance and audit trail purposes."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of reserve valuation for period-over-period reserve development analysis."
    - name: "reserve_change_reason_code"
      expr: reserve_change_reason_code
      comment: "Reason code for reserve changes (e.g., new information, methodology change) for reserve movement attribution."
  measures:
    - name: "total_current_reserve"
      expr: SUM(CAST(current_reserve_amount AS DOUBLE))
      comment: "Total current reserve held across all claim reserves. Primary solvency and financial strength KPI for actuarial and finance leadership."
    - name: "total_initial_reserve"
      expr: SUM(CAST(initial_reserve_amount AS DOUBLE))
      comment: "Total initial reserve established at claim opening. Baseline for reserve development and adequacy analysis."
    - name: "total_net_reserve"
      expr: SUM(CAST(net_reserve_amount AS DOUBLE))
      comment: "Total net reserve after reinsurance recoverables. Represents the company's retained reserve obligation."
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable amounts on claim reserves. Critical for reinsurance asset valuation and counterparty risk management."
    - name: "total_reserve_change"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Net reserve change amount across the portfolio. Positive values indicate reserve strengthening; negative values indicate releases. Key P&L driver."
    - name: "total_reserve_release"
      expr: SUM(CAST(reserve_release_amount AS DOUBLE))
      comment: "Total reserve amounts released. Reserve releases flow through to income; tracking prevents premature or excessive releases."
    - name: "total_ibnr_development_variance"
      expr: SUM(CAST(ibnr_development_variance AS DOUBLE))
      comment: "Total IBNR development variance from prior estimates. Measures actuarial estimation accuracy and reserve volatility."
    - name: "total_prior_period_ibnr"
      expr: SUM(CAST(prior_period_ibnr_amount AS DOUBLE))
      comment: "Total prior period IBNR reserve amounts for year-over-year development comparison and actuarial credibility assessment."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to reserves. Monitors interest rate assumption adequacy for IFRS17 and statutory reserve calculations."
    - name: "avg_loss_development_factor"
      expr: AVG(CAST(loss_development_factor AS DOUBLE))
      comment: "Average loss development factor used in reserve projections. Key actuarial assumption metric for reserve adequacy governance."
    - name: "avg_confidence_interval_lower"
      expr: AVG(CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average lower bound of the reserve confidence interval. Supports risk-based capital and stress testing analysis."
    - name: "avg_confidence_interval_upper"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE))
      comment: "Average upper bound of the reserve confidence interval. Measures reserve uncertainty and tail risk exposure."
    - name: "reinsurance_cession_rate"
      expr: ROUND(100.0 * SUM(CAST(reinsurance_recoverable_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_reserve_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of current reserves covered by reinsurance recoverables. Measures reinsurance program effectiveness in reducing net reserve exposure."
    - name: "reserve_development_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(initial_reserve_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of current to initial reserve amounts. Values above 100% indicate reserve strengthening (adverse development); below 100% indicates favorable development."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk across reserved claims. Measures retained mortality/morbidity exposure after reinsurance for capital adequacy purposes."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_claim_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims investigation metrics tracking fraud detection, investigation costs, SIU activity, and regulatory referrals. Supports Special Investigations Unit (SIU) management, fraud loss prevention, and regulatory compliance."
  source: "`life_insurance_ecm`.`claims`.`claim_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g., fraud, contestability, AML) for SIU workload categorization."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (e.g., open, closed, referred) for pipeline management."
    - name: "investigation_disposition"
      expr: investigation_disposition
      comment: "Final disposition of the investigation (e.g., fraud confirmed, no fraud, inconclusive) for outcome analysis."
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level assigned to the investigation for resource allocation and SLA management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the investigation for management oversight and resource escalation tracking."
    - name: "investigation_reason"
      expr: investigation_reason
      comment: "Reason the investigation was initiated for root-cause and trigger pattern analysis."
    - name: "external_vendor_used_flag"
      expr: external_vendor_used_flag
      comment: "Indicates whether an external vendor was engaged, relevant for vendor cost management and make-vs-buy decisions."
    - name: "law_enforcement_referral_flag"
      expr: law_enforcement_referral_flag
      comment: "Indicates whether the case was referred to law enforcement, a key fraud severity indicator."
    - name: "state_doi_filing_flag"
      expr: state_doi_filing_flag
      comment: "Indicates whether a state Department of Insurance filing was required, for regulatory compliance tracking."
    - name: "stoli_indicator_flag"
      expr: stoli_indicator_flag
      comment: "Indicates Stranger-Originated Life Insurance (STOLI) suspicion, a critical policy integrity and fraud risk flag."
    - name: "investigation_open_month"
      expr: DATE_TRUNC('MONTH', investigation_open_date)
      comment: "Month the investigation was opened for trend analysis of investigation incidence."
    - name: "policy_rescission_recommended_flag"
      expr: policy_rescission_recommended_flag
      comment: "Indicates whether policy rescission was recommended as an outcome, a high-severity fraud resolution action."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of claim investigations opened. Baseline SIU volume KPI for capacity and trend management."
    - name: "total_investigation_cost"
      expr: SUM(CAST(investigation_cost AS DOUBLE))
      comment: "Total cost incurred for claim investigations. Key expense management KPI for SIU budget oversight and vendor cost control."
    - name: "avg_investigation_cost"
      expr: AVG(CAST(investigation_cost AS DOUBLE))
      comment: "Average cost per investigation. Benchmarks SIU efficiency and vendor cost-effectiveness."
    - name: "total_estimated_loss_amount"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated loss amount across investigated claims. Measures potential fraud exposure and informs SIU prioritization."
    - name: "total_benefit_reduction_amount"
      expr: SUM(CAST(benefit_reduction_amount AS DOUBLE))
      comment: "Total benefit reductions resulting from investigations. Measures the financial value recovered through SIU activity."
    - name: "avg_fraud_indicator_score"
      expr: AVG(CAST(fraud_indicator_score AS DOUBLE))
      comment: "Average fraud indicator score across investigations. Tracks the overall fraud risk profile of the investigated claims portfolio."
    - name: "fraud_confirmed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN investigation_disposition = 'fraud confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations resulting in confirmed fraud. Measures SIU detection effectiveness and fraud prevalence."
    - name: "law_enforcement_referral_count"
      expr: SUM(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of investigations referred to law enforcement. Tracks the volume of high-severity fraud cases escalated for prosecution."
    - name: "stoli_flagged_investigations"
      expr: SUM(CASE WHEN stoli_indicator_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of investigations with STOLI indicators. STOLI represents a systemic policy integrity risk requiring executive attention."
    - name: "rescission_recommended_count"
      expr: SUM(CASE WHEN policy_rescission_recommended_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of investigations where policy rescission was recommended. High-severity outcome metric for underwriting and legal risk management."
    - name: "external_vendor_investigation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN external_vendor_used_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations using external vendors. Informs make-vs-buy decisions for SIU capabilities and vendor dependency risk."
    - name: "investigation_cost_to_estimated_loss_ratio"
      expr: ROUND(100.0 * SUM(CAST(investigation_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_loss_amount AS DOUBLE)), 0), 2)
      comment: "Investigation cost as a percentage of estimated loss amount. Measures SIU return on investment; high ratios indicate inefficient investigation spend."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims adjudication decision metrics tracking approval outcomes, benefit amounts, denial patterns, fraud flags, and regulatory compliance. Core KPI layer for adjudication quality, compliance, and financial governance."
  source: "`life_insurance_ecm`.`claims`.`adjudication`"
  dimensions:
    - name: "outcome"
      expr: outcome
      comment: "Adjudication outcome (e.g., approved, denied, partially approved) for decision distribution analysis."
    - name: "decision_basis"
      expr: decision_basis
      comment: "Basis for the adjudication decision (e.g., policy provision, exclusion, contestability) for quality and compliance review."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized denial reason code for root-cause analysis of denied adjudications."
    - name: "authority_level"
      expr: authority_level
      comment: "Authority level required for the adjudication decision for governance and delegation-of-authority compliance."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of settlement elected (e.g., lump sum, structured settlement) for liability and cash flow analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of benefit payment (e.g., monthly, lump sum) for annuity and structured settlement tracking."
    - name: "benefit_currency_code"
      expr: benefit_currency_code
      comment: "Currency of the approved benefit for multi-currency financial reporting."
    - name: "fraud_investigation_flag"
      expr: fraud_investigation_flag
      comment: "Indicates whether a fraud investigation was active at adjudication, for SIU and adjudication quality analysis."
    - name: "contestability_review_flag"
      expr: contestability_review_flag
      comment: "Indicates whether a contestability review was conducted, for underwriting risk and policy integrity monitoring."
    - name: "doi_complaint_flag"
      expr: doi_complaint_flag
      comment: "Indicates whether a Department of Insurance complaint was filed, a critical regulatory risk indicator."
    - name: "litigation_hold_flag"
      expr: litigation_hold_flag
      comment: "Indicates whether a litigation hold is in place, for legal risk and document preservation compliance."
    - name: "adjudication_date_month"
      expr: DATE_TRUNC('MONTH', adjudication_date)
      comment: "Month of adjudication decision for throughput trend analysis and SLA reporting."
    - name: "supervisor_review_flag"
      expr: supervisor_review_flag
      comment: "Indicates whether supervisor review was required, for quality control and escalation pattern analysis."
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total number of adjudication decisions rendered. Baseline throughput KPI for adjudication operations management."
    - name: "total_benefit_amount_approved"
      expr: SUM(CAST(benefit_amount_approved AS DOUBLE))
      comment: "Total benefit amount approved across all adjudications. Primary financial outflow KPI for claims cost management and financial reporting."
    - name: "avg_benefit_amount_approved"
      expr: AVG(CAST(benefit_amount_approved AS DOUBLE))
      comment: "Average approved benefit amount per adjudication. Benchmarks claim severity and informs pricing and reserve adequacy."
    - name: "total_federal_withholding_pct_avg"
      expr: AVG(CAST(federal_withholding_percentage AS DOUBLE))
      comment: "Average federal withholding percentage applied at adjudication. Monitors tax withholding compliance and adequacy."
    - name: "total_state_withholding_pct_avg"
      expr: AVG(CAST(state_withholding_percentage AS DOUBLE))
      comment: "Average state withholding percentage applied at adjudication. Supports state tax compliance monitoring."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications resulting in approval. Core adjudication quality KPI for executive and regulatory reporting."
    - name: "denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications resulting in denial. Elevated rates may trigger regulatory scrutiny and DOI complaints."
    - name: "fraud_investigation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_investigation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with active fraud investigations. Measures fraud exposure within the adjudicated claims portfolio."
    - name: "doi_complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN doi_complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with DOI complaints filed. A critical regulatory risk KPI; high rates attract regulatory examination."
    - name: "contestability_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contestability_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications requiring contestability review. Measures early-duration claim risk and underwriting quality."
    - name: "supervisor_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supervisor_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications requiring supervisor review. High rates indicate complexity, quality issues, or training gaps in the adjudication team."
    - name: "litigation_hold_count"
      expr: SUM(CASE WHEN litigation_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjudications under litigation hold. Drives legal reserve requirements and document management obligations."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims appeal metrics tracking appeal volumes, outcomes, arbitration and litigation escalations, and regulatory complaint rates. Supports claims quality management, regulatory compliance, and legal risk oversight."
  source: "`life_insurance_ecm`.`claims`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., internal, external, regulatory) for appeal pathway analysis."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., pending, decided, withdrawn) for pipeline management."
    - name: "decision"
      expr: decision
      comment: "Appeal decision outcome (e.g., upheld, overturned, modified) for adjudication quality assessment."
    - name: "exhaustion_status"
      expr: exhaustion_status
      comment: "Status of internal appeal exhaustion (e.g., exhausted, not exhausted) for external review eligibility tracking."
    - name: "review_role"
      expr: review_role
      comment: "Role of the reviewer (e.g., medical director, legal counsel, committee) for governance and delegation analysis."
    - name: "basis"
      expr: basis
      comment: "Basis for the appeal (e.g., medical necessity, policy interpretation, procedural error) for root-cause analysis."
    - name: "arbitration_filed_flag"
      expr: arbitration_filed_flag
      comment: "Indicates whether arbitration was filed, a key legal escalation and cost risk indicator."
    - name: "litigation_filed_flag"
      expr: litigation_filed_flag
      comment: "Indicates whether litigation was filed, the highest-severity legal escalation indicator."
    - name: "doi_complaint_filed_flag"
      expr: doi_complaint_filed_flag
      comment: "Indicates whether a DOI complaint was filed in connection with the appeal, a critical regulatory risk flag."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the appeal was filed for trend analysis of appeal incidence and seasonality."
    - name: "vote_outcome"
      expr: vote_outcome
      comment: "Committee vote outcome for appeals decided by committee, for governance and decision quality analysis."
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals filed. Baseline volume KPI for appeals management and adjudication quality monitoring."
    - name: "total_revised_amount_approved"
      expr: SUM(CAST(revised_claim_amount_approved AS DOUBLE))
      comment: "Total revised claim amounts approved through the appeals process. Measures the financial impact of appeal decisions on claims costs."
    - name: "total_revised_amount_paid"
      expr: SUM(CAST(revised_claim_amount_paid AS DOUBLE))
      comment: "Total revised claim amounts paid following appeal decisions. Tracks incremental payment obligations created by successful appeals."
    - name: "total_hours_spent"
      expr: SUM(CAST(hours_spent AS DOUBLE))
      comment: "Total staff hours spent on appeals. Measures operational burden and informs staffing and process improvement decisions."
    - name: "avg_hours_per_appeal"
      expr: AVG(CAST(hours_spent AS DOUBLE))
      comment: "Average hours spent per appeal. Benchmarks appeals processing efficiency and identifies complexity outliers."
    - name: "overturn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN decision = 'overturned' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that resulted in the original decision being overturned. A high overturn rate signals systemic adjudication quality issues requiring corrective action."
    - name: "arbitration_escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN arbitration_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalating to arbitration. Measures legal escalation risk and the effectiveness of internal dispute resolution."
    - name: "litigation_escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN litigation_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalating to litigation. The highest-severity legal risk KPI for claims; drives legal reserve and outside counsel budget decisions."
    - name: "doi_complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN doi_complaint_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals with associated DOI complaints. A critical regulatory compliance KPI; high rates attract market conduct examinations."
    - name: "distinct_claims_appealed"
      expr: COUNT(DISTINCT claim_id)
      comment: "Count of distinct claims with at least one appeal. Measures the breadth of claims quality issues driving appeal activity."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_contestability_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contestability review metrics tracking misrepresentation findings, rescission decisions, premium refunds, and regulatory notifications. Critical for underwriting integrity, policy rescission governance, and regulatory compliance."
  source: "`life_insurance_ecm`.`claims`.`contestability_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the contestability review (e.g., open, completed, escalated) for pipeline management."
    - name: "rescission_decision"
      expr: rescission_decision
      comment: "Decision on policy rescission (e.g., rescinded, not rescinded, partial) for policy integrity outcome analysis."
    - name: "misrepresentation_category"
      expr: misrepresentation_category
      comment: "Category of misrepresentation found (e.g., medical history, financial, lifestyle) for underwriting quality root-cause analysis."
    - name: "review_trigger_reason"
      expr: review_trigger_reason
      comment: "Reason the contestability review was triggered for pattern analysis of review initiation drivers."
    - name: "underwriting_decision_impact"
      expr: underwriting_decision_impact
      comment: "Impact of the review findings on the original underwriting decision for underwriting quality feedback."
    - name: "within_contestability_flag"
      expr: within_contestability_flag
      comment: "Indicates whether the claim falls within the contestability period, the primary eligibility criterion for review."
    - name: "material_misrepresentation_found_flag"
      expr: material_misrepresentation_found_flag
      comment: "Indicates whether a material misrepresentation was found, the key outcome driving rescission decisions."
    - name: "rescission_recommended_flag"
      expr: rescission_recommended_flag
      comment: "Indicates whether rescission was recommended by the reviewer, for governance and approval workflow tracking."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Indicates whether legal review was required, for legal resource planning and case complexity analysis."
    - name: "state_doi_notification_required_flag"
      expr: state_doi_notification_required_flag
      comment: "Indicates whether state DOI notification was required, for regulatory compliance tracking."
    - name: "review_initiated_month"
      expr: DATE_TRUNC('MONTH', review_initiated_date)
      comment: "Month the contestability review was initiated for trend analysis of review volumes."
    - name: "premium_refund_currency_code"
      expr: premium_refund_currency_code
      comment: "Currency of premium refunds issued upon rescission for multi-currency financial reporting."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of contestability reviews initiated. Baseline volume KPI for underwriting integrity and claims quality management."
    - name: "total_claim_denial_amount"
      expr: SUM(CAST(claim_denial_amount AS DOUBLE))
      comment: "Total claim amounts denied as a result of contestability reviews. Measures the financial value of underwriting integrity enforcement."
    - name: "total_premium_refund_amount"
      expr: SUM(CAST(premium_refund_amount AS DOUBLE))
      comment: "Total premium refunds issued upon policy rescission. Measures the financial cost of rescission decisions."
    - name: "avg_premium_refund_amount"
      expr: AVG(CAST(premium_refund_amount AS DOUBLE))
      comment: "Average premium refund per rescinded policy. Benchmarks rescission financial impact and informs reserve adequacy for contestability outcomes."
    - name: "material_misrepresentation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN material_misrepresentation_found_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contestability reviews finding material misrepresentation. A key underwriting quality KPI; high rates indicate systemic application fraud or underwriting process gaps."
    - name: "rescission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rescission_recommended_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contestability reviews resulting in a rescission recommendation. Measures the severity of misrepresentation findings and policy integrity enforcement."
    - name: "within_contestability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN within_contestability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where the claim falls within the contestability period. Measures the proportion of claims eligible for full contestability investigation."
    - name: "doi_notification_required_count"
      expr: SUM(CASE WHEN state_doi_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews requiring state DOI notification. Tracks regulatory reporting obligations arising from contestability outcomes."
    - name: "legal_review_required_count"
      expr: SUM(CASE WHEN legal_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews requiring legal review. Drives legal resource planning and identifies high-complexity contestability cases."
    - name: "distinct_policies_reviewed"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Count of distinct in-force policies subject to contestability review. Measures the breadth of underwriting integrity exposure across the policy portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_living_benefit_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Living benefit claim metrics for long-term care, chronic illness, and annuity living benefit riders. Tracks benefit utilization, monthly payment volumes, reinsurance recoverables, and elimination period compliance. Critical for product profitability and actuarial reserve management."
  source: "`life_insurance_ecm`.`claims`.`claim`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_living_benefit_claims"
      expr: COUNT(1)
      comment: "Total number of living benefit claims. Baseline volume KPI for morbidity monitoring and product utilization management."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves held for living benefit claims. Critical actuarial KPI for long-term liability management and solvency."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_fnol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "First Notice of Loss (FNOL) intake metrics tracking notification volumes, channels, fraud indicators, NIGO rates, and triage classifications. Supports claims intake quality, SLA management, and early fraud detection."
  source: "`life_insurance_ecm`.`claims`.`fnol`"
  dimensions:
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel through which the FNOL was received (e.g., phone, web, agent, mail) for intake channel mix analysis."
    - name: "loss_event_type"
      expr: loss_event_type
      comment: "Type of loss event reported (e.g., death, disability, critical illness) for early claim type classification."
    - name: "triage_classification"
      expr: triage_classification
      comment: "Triage classification assigned at FNOL (e.g., routine, complex, SIU referral) for workload routing and prioritization."
    - name: "fnol_status"
      expr: fnol_status
      comment: "Current status of the FNOL (e.g., received, claim created, incomplete) for intake pipeline management."
    - name: "reporter_type"
      expr: reporter_type
      comment: "Type of party reporting the loss (e.g., beneficiary, agent, attorney, funeral home) for reporter pattern analysis."
    - name: "reporter_relationship"
      expr: reporter_relationship
      comment: "Relationship of the reporter to the insured for beneficiary and claimant pattern analysis."
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Indicates whether a fraud indicator was flagged at FNOL intake, for early fraud detection monitoring."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the FNOL was Not In Good Order (NIGO), a key intake quality and SLA risk indicator."
    - name: "contestability_flag"
      expr: contestability_flag
      comment: "Indicates whether the FNOL was flagged for contestability review at intake, for early underwriting integrity monitoring."
    - name: "notification_date_month"
      expr: DATE_TRUNC('MONTH', notification_date)
      comment: "Month of FNOL notification for intake volume trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system from which the FNOL originated for data quality and system integration monitoring."
  measures:
    - name: "total_fnols"
      expr: COUNT(1)
      comment: "Total number of First Notices of Loss received. Baseline intake volume KPI for claims operations capacity planning."
    - name: "fraud_flagged_fnols"
      expr: SUM(CASE WHEN fraud_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FNOLs flagged with fraud indicators at intake. Measures early fraud detection volume for SIU triage."
    - name: "fraud_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs flagged for fraud at intake. A rising rate signals emerging fraud patterns requiring SIU resource escalation."
    - name: "nigo_count"
      expr: SUM(CASE WHEN nigo_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FNOLs received Not In Good Order. NIGO items delay claim processing and increase SLA breach risk."
    - name: "nigo_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nigo_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs that are Not In Good Order. A key intake quality KPI; high rates indicate documentation or process issues at the point of notification."
    - name: "contestability_flagged_fnols"
      expr: SUM(CASE WHEN contestability_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FNOLs flagged for contestability review at intake. Enables early identification of underwriting integrity risk in the incoming claims pipeline."
    - name: "contestability_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contestability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FNOLs flagged for contestability at intake. Monitors early-duration mortality risk concentration in the incoming claims pipeline."
    - name: "distinct_policies_with_fnol"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Count of distinct in-force policies with an FNOL filed. Measures the breadth of claim incidence across the policy portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`claims_beneficiary_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary verification metrics tracking identity verification outcomes, AML/OFAC screening compliance, disbursement authorization rates, and contested claim volumes. Supports compliance, fraud prevention, and payment release governance."
  source: "`life_insurance_ecm`.`claims`.`beneficiary_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current status of the beneficiary verification (e.g., pending, completed, failed) for pipeline management."
    - name: "verification_type"
      expr: verification_type
      comment: "Type of verification performed (e.g., identity, legal standing, AML) for compliance coverage analysis."
    - name: "identity_verification_method"
      expr: identity_verification_method
      comment: "Method used for identity verification (e.g., government ID, biometric, notarized) for process standardization analysis."
    - name: "identity_verification_outcome"
      expr: identity_verification_outcome
      comment: "Outcome of identity verification (e.g., verified, failed, pending) for quality and compliance monitoring."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening status (e.g., clear, flagged, pending) for anti-money laundering compliance tracking."
    - name: "ofac_sanctions_check_status"
      expr: ofac_sanctions_check_status
      comment: "OFAC sanctions check status (e.g., clear, match, pending) for sanctions compliance monitoring."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "Know Your Customer verification status for regulatory compliance and payment release governance."
    - name: "adverse_findings_flag"
      expr: adverse_findings_flag
      comment: "Indicates whether adverse findings were identified during verification, triggering enhanced due diligence."
    - name: "contested_claim_flag"
      expr: contested_claim_flag
      comment: "Indicates whether the claim is contested by multiple claimants, a key legal and payment hold risk indicator."
    - name: "disbursement_authorized_flag"
      expr: disbursement_authorized_flag
      comment: "Indicates whether disbursement has been authorized following verification, for payment release pipeline tracking."
    - name: "minor_beneficiary_flag"
      expr: minor_beneficiary_flag
      comment: "Indicates a minor beneficiary, requiring guardian verification and court approval processes."
    - name: "verification_initiated_month"
      expr: DATE_TRUNC('MONTH', verification_initiated_date)
      comment: "Month verification was initiated for throughput trend analysis."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of beneficiary verifications initiated. Baseline volume KPI for compliance operations capacity planning."
    - name: "verification_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications completed. Measures throughput efficiency of the beneficiary verification process."
    - name: "disbursement_authorization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disbursement_authorized_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications resulting in disbursement authorization. Measures the end-to-end effectiveness of the verification-to-payment pipeline."
    - name: "adverse_findings_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_findings_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with adverse findings. Elevated rates signal fraud, AML, or identity risk concentration in the claimant population."
    - name: "aml_flagged_count"
      expr: SUM(CASE WHEN aml_screening_status = 'flagged' THEN 1 ELSE 0 END)
      comment: "Count of verifications with AML flags. Tracks anti-money laundering compliance exposure in the claims payment pipeline."
    - name: "ofac_match_count"
      expr: SUM(CASE WHEN ofac_sanctions_check_status = 'match' THEN 1 ELSE 0 END)
      comment: "Count of verifications with OFAC sanctions matches. Any OFAC match requires immediate payment hold and regulatory reporting — a zero-tolerance compliance KPI."
    - name: "contested_claim_count"
      expr: SUM(CASE WHEN contested_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of verifications involving contested claims. Contested claims require interpleader or legal resolution, driving legal cost and payment delay."
    - name: "interpleader_filed_count"
      expr: SUM(CASE WHEN interpleader_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of verifications where interpleader was filed. Measures the volume of multi-claimant disputes escalated to court for resolution."
    - name: "minor_beneficiary_count"
      expr: SUM(CASE WHEN minor_beneficiary_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of verifications involving minor beneficiaries. Drives guardian verification and court approval workload planning."
    - name: "distinct_claims_verified"
      expr: COUNT(DISTINCT claim_id)
      comment: "Count of distinct claims with beneficiary verification activity. Measures the breadth of verification coverage across the claims portfolio."
$$;