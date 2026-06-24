-- Metric views for domain: claim | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim volume, financial, and quality KPIs derived from the claim header fact table. Covers total billed/allowed/paid amounts, denial rates, SLA compliance, COB prevalence, and MLR exclusion flags — the primary steering dashboard for claims operations and finance leadership."
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., Professional, Institutional, Dental, Vision) — primary segmentation axis for all claim KPIs."
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim (e.g., Paid, Denied, Pending, Suspended) — used to filter operational queues."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) — critical segmentation for financial and regulatory reporting."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type code (e.g., UB-04, CMS-1500) — distinguishes institutional from professional claims."
    - name: "place_of_service"
      expr: place_of_service_code
      comment: "Place of service code (e.g., 11=Office, 21=Inpatient Hospital) — used for site-of-care cost analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of service admission date — enables trend analysis of claim volumes and costs over time."
    - name: "claim_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the claim record was created — used for lag and timeliness analysis."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Flag indicating whether coordination of benefits applies — segments COB vs. non-COB claim populations."
    - name: "is_mlr_excluded"
      expr: is_mlr_excluded
      comment: "Flag indicating the claim is excluded from MLR numerator calculations — critical for regulatory MLR reporting."
    - name: "sla_met"
      expr: sla_met
      comment: "Flag indicating whether the claim was processed within the required SLA window — drives operational compliance tracking."
    - name: "is_suspended"
      expr: is_suspended
      comment: "Flag indicating the claim is currently suspended — used to monitor pended claim inventory."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis-related group code assigned to the claim — used for inpatient cost benchmarking."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim headers — baseline volume KPI for operational throughput and trend monitoring."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Sum of all billed (charged) amounts across claims — represents gross provider charges before adjudication."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of contractually allowed amounts — the basis for plan liability and network discount calculations."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of amounts actually paid to providers — primary claims cost KPI for finance and actuarial teams."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim — used to benchmark cost per episode and detect outlier claims."
    - name: "network_discount_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE) - CAST(allowed_amount AS DOUBLE))
      comment: "Total network discount (billed minus allowed) — measures the value of provider network contracts."
    - name: "network_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(billed_amount AS DOUBLE) - CAST(allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Network discount as a percentage of billed charges — key contract performance indicator for network management."
    - name: "claims_with_cob_count"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Number of claims with coordination of benefits — used to size COB recovery opportunity."
    - name: "cob_prevalence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims with COB — monitors COB population size and recovery program effectiveness."
    - name: "sla_compliant_claims"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Number of claims processed within SLA — measures operational timeliness compliance."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims meeting SLA — critical regulatory and contractual compliance KPI."
    - name: "suspended_claims_count"
      expr: COUNT(CASE WHEN is_suspended = TRUE THEN 1 END)
      comment: "Number of currently suspended claims — operational inventory metric for pend queue management."
    - name: "mlr_excluded_paid_amount"
      expr: SUM(CASE WHEN is_mlr_excluded = TRUE THEN paid_amount ELSE 0 END)
      comment: "Total paid amount on MLR-excluded claims — required for accurate MLR numerator calculation in regulatory filings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication quality, financial accuracy, and processing efficiency KPIs. Covers auto-adjudication rates, edit override patterns, COB processing outcomes, and medical necessity flags — used by claims operations, compliance, and finance to govern adjudication integrity."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Current status of the adjudication record (e.g., Complete, Pending, Error) — primary filter for operational queues."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated — segments adjudication metrics by claim category."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status — drives cost-sharing and reimbursement rate differences."
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Whether the claim was auto-adjudicated without human intervention — key operational efficiency dimension."
    - name: "edit_override_flag"
      expr: edit_override_flag
      comment: "Whether an edit was overridden during adjudication — flags potential compliance and integrity risk."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether medical necessity was flagged during adjudication — used for UM and clinical review tracking."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization at time of adjudication — used to correlate auth compliance with payment outcomes."
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month of adjudication — enables trend analysis of adjudication throughput and financial accuracy."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service — used to analyze lag between service and adjudication."
    - name: "cob_processing_result"
      expr: cob_processing_result
      comment: "Outcome of COB processing during adjudication — used to evaluate COB accuracy and recovery."
    - name: "timeliness_flag"
      expr: timeliness_flag
      comment: "Whether the adjudication met timeliness requirements — regulatory compliance dimension."
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total adjudication records processed — baseline throughput KPI for claims operations."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of allowed amounts from adjudication — the contractual basis for plan payment liability."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net amounts paid after all adjustments — actual cash outflow from adjudication."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied across adjudications — measures member cost-sharing burden."
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts applied — used to monitor member accumulator progress toward OOP maximums."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted via COB — measures the financial impact of coordination of benefits processing."
    - name: "auto_adjudication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_adjudication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims auto-adjudicated — primary operational efficiency KPI; higher rates reduce unit cost."
    - name: "edit_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edit_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications with edit overrides — elevated rates signal compliance and integrity risk."
    - name: "medical_necessity_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications flagged for medical necessity review — used to size UM workload and clinical review queues."
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications requiring prior authorization — monitors auth compliance and potential leakage."
    - name: "avg_total_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average total charge amount per adjudication — used for cost benchmarking and outlier detection."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Sum of all adjustment amounts applied during adjudication — measures post-adjudication correction volume."
    - name: "timeliness_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeliness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjudications meeting timeliness standards — regulatory compliance KPI for state and federal reporting."
    - name: "accumulator_deductible_total"
      expr: SUM(CAST(accumulator_deductible_impact AS DOUBLE))
      comment: "Total deductible accumulator impact across all adjudications — used to reconcile member benefit accumulators."
    - name: "accumulator_oop_total"
      expr: SUM(CAST(accumulator_oop_impact AS DOUBLE))
      comment: "Total OOP accumulator impact across all adjudications — used to reconcile member OOP maximum tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs covering denial rates, financial impact, appeal eligibility, and resolution outcomes. Used by claims operations, compliance, and provider relations to reduce denial rates and improve first-pass resolution."
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Category of denial (e.g., Clinical, Administrative, Duplicate, Timely Filing) — primary segmentation for root-cause analysis."
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (e.g., Open, Appealed, Upheld, Overturned) — used to track denial lifecycle."
    - name: "denial_subtype"
      expr: subtype
      comment: "Sub-category of denial — provides granular root-cause segmentation within denial types."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code — standardized code explaining the denial reason for provider communications."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution of the denial (e.g., Paid, Upheld, Withdrawn) — used to measure denial overturn rates."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal — segments actionable vs. non-actionable denials."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether the denial is based on medical necessity — used to size clinical review workload."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial — enables trend analysis of denial volumes and financial impact over time."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month of denial resolution — used to measure resolution cycle time and backlog aging."
    - name: "letter_generated_flag"
      expr: letter_generated_flag
      comment: "Whether a denial letter was generated — regulatory compliance dimension for member notification requirements."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denial records — baseline volume KPI for denial management operations."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross dollar amount denied — measures the financial scale of the denial population."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net dollar amount denied after adjustments — the actual financial impact of denials on providers."
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_gross_amount AS DOUBLE))
      comment: "Average gross denied amount per denial record — used to prioritize high-value denial resolution efforts."
    - name: "appeal_eligible_denial_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of denials eligible for appeal — sizes the actionable denial population for provider outreach."
    - name: "appeal_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials eligible for appeal — used to assess provider appeal opportunity and compliance risk."
    - name: "medical_necessity_denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials based on medical necessity — monitors clinical criteria application consistency."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials with manual overrides — elevated rates may indicate inconsistent denial criteria application."
    - name: "letter_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN letter_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials with required notification letters generated — regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claims payment financial KPIs covering gross/net payment amounts, reconciliation status, void/return rates, and payment method distribution. Used by finance, treasury, and claims operations to govern cash outflow accuracy and payment integrity."
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Issued, Cleared, Voided, Returned) — primary operational filter."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., EFT, Check, Virtual Card) — used for payment channel analysis and cost optimization."
    - name: "payment_method"
      expr: method
      comment: "Payment delivery method — used to analyze electronic vs. paper payment distribution."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (e.g., Provider, Member, Vendor) — segments payment flows by recipient category."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the payment has been reconciled against bank records — used to monitor outstanding reconciliation items."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the payment was voided — used to track payment integrity and reissuance activity."
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the payment was returned (e.g., undeliverable check) — used to manage returned payment inventory."
    - name: "payment_cycle"
      expr: cycle
      comment: "Payment processing cycle identifier — used to analyze payment batch performance and timing."
    - name: "gl_posting_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting — aligns payment data with financial period close reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment — used to identify unreconciled items requiring finance action."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment records issued — baseline volume KPI for payment operations."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross payment amounts — total cash outflow before adjustments and taxes."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net payment amounts after adjustments — actual cash disbursed to payees."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts withheld on payments — required for tax reporting and compliance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of payment adjustment amounts — measures post-issuance correction volume."
    - name: "avg_net_payment_per_claim"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per payment record — used for cost benchmarking and outlier detection."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments voided — elevated rates indicate payment accuracy or process integrity issues."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned — measures address/routing data quality and undeliverable payment risk."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments successfully reconciled — financial control KPI for treasury and accounting."
    - name: "unreconciled_payment_amount"
      expr: SUM(CASE WHEN is_reconciled = FALSE THEN net_amount ELSE 0 END)
      comment: "Total net amount of unreconciled payments — outstanding reconciliation liability requiring finance resolution."
    - name: "voided_payment_amount"
      expr: SUM(CASE WHEN is_voided = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total gross amount of voided payments — measures financial exposure from payment integrity failures."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment KPIs covering adjustment volumes, financial impact, fraud/overpayment indicators, and recovery status. Used by finance, compliance, and audit teams to govern post-payment accuracy and overpayment recovery programs."
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., Overpayment, Underpayment, Fraud, Audit) — primary segmentation for root-cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., Initiated, Recovered, Written-Off) — used to track recovery lifecycle."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of the recovery effort — used to size outstanding recovery inventory and forecast cash receipts."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover overpayments (e.g., Offset, Refund, Legal) — used to optimize recovery strategy."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Whether the adjustment is fraud-related — segments FWA population for compliance and SIU reporting."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the adjustment is a reversal — used to distinguish corrections from new adjustments."
    - name: "is_void"
      expr: is_void
      comment: "Whether the adjustment voids the original claim — used to track claim void activity."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the adjustment requires regulatory reporting — compliance dimension for state/federal filings."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment became effective — used for financial period attribution."
    - name: "audit_source"
      expr: audit_source
      comment: "Source of the audit that triggered the adjustment (e.g., RAC, Internal, External) — used to measure audit ROI."
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role of the person who initiated the adjustment — used for accountability and workflow analysis."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustments — baseline volume KPI for post-payment correction activity."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Sum of all adjustment amounts — total financial impact of post-payment corrections."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Sum of net adjustment amounts after offsets — actual net financial impact on plan liability."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Sum of original claim amounts being adjusted — used to calculate adjustment rate as a percentage of original spend."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(adjusted_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Adjusted amount as a percentage of original amount — measures the scale of post-payment corrections relative to original spend."
    - name: "fraud_adjustment_count"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Number of fraud-related adjustments — FWA program performance KPI for compliance and SIU leadership."
    - name: "fraud_adjustment_amount"
      expr: SUM(CASE WHEN is_fraud = TRUE THEN adjusted_amount ELSE 0 END)
      comment: "Total dollar amount of fraud-related adjustments — measures FWA financial recovery and exposure."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reversal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are reversals — elevated rates indicate adjudication accuracy issues."
    - name: "regulatory_reporting_adjustment_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of adjustments requiring regulatory reporting — compliance workload KPI for state/federal filings."
    - name: "compliance_60_day_rule_count"
      expr: COUNT(CASE WHEN compliance_60_day_rule = TRUE THEN 1 END)
      comment: "Number of adjustments subject to the 60-day overpayment return rule — ACA compliance KPI for finance and legal."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_ibnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IBNR (Incurred But Not Reported) reserve KPIs covering estimated reserve amounts, development factors, completion factors, and reserve changes. Critical for actuarial, finance, and regulatory reporting — included per VREQ-022 as a Minimum Viable Model requirement."
  source: "`vibe_health_insurance_v1`.`claim`.`ibnr`"
  dimensions:
    - name: "ibnr_status"
      expr: ibnr_status
      comment: "Current status of the IBNR estimate (e.g., Preliminary, Final, Revised) — used to filter production vs. draft reserves."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the IBNR estimate — primary segmentation for actuarial reserve analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the IBNR estimate — used to segment reserves by product type."
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g., Inpatient, Outpatient, Pharmacy) — used to analyze IBNR by care setting."
    - name: "actuarial_method"
      expr: actuarial_method
      comment: "Actuarial method used to develop the IBNR estimate (e.g., Chain Ladder, Bornhuetter-Ferguson) — methodology audit dimension."
    - name: "incurred_month"
      expr: DATE_TRUNC('MONTH', incurred_month)
      comment: "Month services were incurred — primary time dimension for IBNR development triangle analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the IBNR estimate became effective — used to track reserve run dates and period attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the IBNR reserve amounts — used for multi-currency reserve reporting."
  measures:
    - name: "total_estimated_ibnr_amount"
      expr: SUM(CAST(estimated_ibnr_amount AS DOUBLE))
      comment: "Total estimated IBNR reserve amount — primary actuarial KPI representing the plan's liability for unreported claims."
    - name: "avg_estimated_ibnr_amount"
      expr: AVG(CAST(estimated_ibnr_amount AS DOUBLE))
      comment: "Average IBNR estimate per reserve record — used to benchmark reserve levels across periods and LOBs."
    - name: "total_paid_to_date_amount"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total claims paid to date against the IBNR period — used to calculate remaining reserve adequacy."
    - name: "total_reserve_change_amount"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Sum of reserve changes from prior period — measures actuarial reserve development and prior-period adequacy."
    - name: "total_prior_period_reserve_amount"
      expr: SUM(CAST(prior_period_reserve_amount AS DOUBLE))
      comment: "Sum of prior period reserve amounts — baseline for reserve development and run-off analysis."
    - name: "total_mlr_numerator_allocation"
      expr: SUM(CAST(mlr_numerator_allocation AS DOUBLE))
      comment: "Total IBNR amount allocated to the MLR numerator — required for accurate MLR calculation in regulatory filings."
    - name: "avg_completion_factor"
      expr: AVG(CAST(completion_factor AS DOUBLE))
      comment: "Average completion factor across IBNR estimates — measures how complete the claims development is for each incurred period."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average development factor (link ratio) — key actuarial parameter for chain-ladder IBNR development."
    - name: "reserve_to_paid_ratio"
      expr: ROUND(SUM(CAST(estimated_ibnr_amount AS DOUBLE)) / NULLIF(SUM(CAST(paid_to_date_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of estimated IBNR reserve to paid-to-date amount — measures reserve adequacy relative to known claims experience."
    - name: "ibnr_record_count"
      expr: COUNT(1)
      comment: "Number of IBNR reserve records — used to monitor reserve run completeness and actuarial process coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit accumulator KPIs covering deductible and OOP maximum tracking, accumulator utilization rates, and limit exhaustion. Used by member services, finance, and actuarial teams to monitor benefit consumption and cost-sharing accuracy."
  source: "`vibe_health_insurance_v1`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (e.g., Deductible, OOP Maximum, Benefit Limit) — primary segmentation for benefit tracking."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator (e.g., Active, Exhausted, Reset) — used to identify members who have met limits."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category associated with the accumulator — used to analyze accumulation by benefit type."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business — segments accumulator data by product for financial and actuarial analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (e.g., In-Network, Out-of-Network) — used to analyze cost-sharing by network status."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Whether the accumulator record is an adjustment — used to separate original accumulations from corrections."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the accumulator record is a reversal — used to track accumulator correction activity."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start)
      comment: "Start month of the benefit period — used to align accumulator data with plan year boundaries."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of accumulator amounts — used for multi-currency benefit tracking."
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated across all members and benefit categories — measures aggregate cost-sharing burden."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Sum of benefit limits across all accumulator records — total benefit exposure for the plan."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Sum of remaining balances before limits are reached — measures remaining benefit exposure."
    - name: "avg_accumulated_amount_per_member"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per accumulator record — used to benchmark member cost-sharing levels."
    - name: "accumulator_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_amount AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of benefit limit consumed — measures how close the population is to exhausting benefit limits; drives actuarial and financial forecasting."
    - name: "exhausted_accumulator_count"
      expr: COUNT(CASE WHEN accumulator_status = 'Exhausted' THEN 1 END)
      comment: "Number of accumulators where the benefit limit has been fully consumed — used to identify members with no remaining cost-sharing."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of accumulator reversals — elevated counts indicate benefit tracking accuracy issues requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) KPIs covering primary/secondary payer liability, recovery amounts, crossover claim rates, and MSP compliance. Used by COB operations, finance, and compliance to maximize recovery and ensure correct payment ordering."
  source: "`vibe_health_insurance_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB record (e.g., Pending, Processed, Closed) — primary operational filter."
    - name: "cob_method"
      expr: method
      comment: "COB determination method (e.g., Birthday Rule, Non-Duplication, Maintenance of Benefits) — used to analyze method distribution."
    - name: "other_insurance_type"
      expr: other_insurance_type
      comment: "Type of other insurance (e.g., Commercial, Medicare, Medicaid) — used to segment COB by secondary payer type."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Medicare Secondary Payer indicator — used to identify MSP claims requiring special COB processing."
    - name: "msp_type"
      expr: msp_type
      comment: "Type of MSP situation (e.g., Working Aged, ESRD, Disability) — used for CMS MSP compliance reporting."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Whether the claim is a Medicaid/Medicare crossover — used to track dual-eligible claim processing."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether COB was manually overridden — elevated rates may indicate data quality or system issues."
    - name: "cob_processed_month"
      expr: DATE_TRUNC('MONTH', processed_timestamp)
      comment: "Month COB was processed — used for trend analysis of COB volumes and recovery amounts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of COB amounts — used for multi-currency COB reporting."
  measures:
    - name: "total_cob_records"
      expr: COUNT(1)
      comment: "Total number of COB records processed — baseline volume KPI for COB operations."
    - name: "total_primary_payer_paid_amount"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the primary payer — used to calculate plan's secondary liability."
    - name: "total_secondary_payer_paid_amount"
      expr: SUM(CAST(secondary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the secondary payer — measures COB recovery from other insurers."
    - name: "total_net_liability_amount"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net plan liability after COB — the actual plan payment obligation after primary payer offset."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total billed charges across COB claims — used to calculate COB savings rate."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amount across COB claims — used to measure COB impact on plan liability."
    - name: "cob_savings_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE) - CAST(net_liability_amount AS DOUBLE))
      comment: "Total savings from COB (charges minus net liability) — measures the financial value of the COB program."
    - name: "cob_savings_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_charge_amount AS DOUBLE) - CAST(net_liability_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "COB savings as a percentage of total charges — measures COB program effectiveness and ROI."
    - name: "msp_claim_count"
      expr: COUNT(CASE WHEN msp_indicator = TRUE THEN 1 END)
      comment: "Number of Medicare Secondary Payer claims — used for CMS MSP compliance monitoring and reporting."
    - name: "crossover_claim_count"
      expr: COUNT(CASE WHEN crossover_claim_flag = TRUE THEN 1 END)
      comment: "Number of Medicaid/Medicare crossover claims — used to monitor dual-eligible claim processing volumes."
    - name: "manual_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COB records with manual overrides — elevated rates indicate automation or data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_subrogation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subrogation recovery KPIs covering demand amounts, gross/net recovery, settlement rates, and lien management. Used by subrogation operations, legal, and finance to maximize third-party liability recovery and monitor program ROI."
  source: "`vibe_health_insurance_v1`.`claim`.`subrogation`"
  dimensions:
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Current status of the subrogation case (e.g., Open, Settled, Closed, Litigated) — primary operational filter."
    - name: "subrogation_type"
      expr: subrogation_type
      comment: "Type of subrogation (e.g., Auto, Workers Comp, Liability) — used to segment recovery by liability category."
    - name: "liability_type"
      expr: liability_type
      comment: "Type of third-party liability — used to analyze recovery rates by liability category."
    - name: "lien_status"
      expr: lien_status
      comment: "Status of any lien applied — used to track lien enforcement and resolution."
    - name: "is_lien_applied"
      expr: is_lien_applied
      comment: "Whether a lien has been applied — used to segment cases with active lien enforcement."
    - name: "is_settlement_agreed"
      expr: is_settlement_agreed
      comment: "Whether a settlement has been agreed — used to track settlement pipeline and forecast recovery."
    - name: "is_recovery_closed"
      expr: is_recovery_closed
      comment: "Whether the recovery case is closed — used to measure case closure rates and cycle times."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the subrogation case requires regulatory reporting — compliance dimension."
    - name: "accident_state_code"
      expr: accident_state_code
      comment: "State where the accident occurred — used for geographic analysis of subrogation activity."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month the subrogation case was initiated — used for trend analysis of case volumes and recovery timing."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement — used to analyze settlement timing and recovery cycle time."
  measures:
    - name: "total_subrogation_cases"
      expr: COUNT(1)
      comment: "Total number of subrogation cases — baseline volume KPI for subrogation operations."
    - name: "total_demand_amount"
      expr: SUM(CAST(demand_amount AS DOUBLE))
      comment: "Total demand amounts sent to third parties — measures the gross recovery opportunity in the subrogation pipeline."
    - name: "total_gross_recovery_amount"
      expr: SUM(CAST(gross_recovery_amount AS DOUBLE))
      comment: "Total gross amounts recovered from third parties — primary financial KPI for subrogation program performance."
    - name: "total_net_recovery_amount"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery after legal fees — actual financial benefit of the subrogation program."
    - name: "total_legal_fees_amount"
      expr: SUM(CAST(legal_fees_amount AS DOUBLE))
      comment: "Total legal fees incurred in subrogation — used to calculate net recovery ROI."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts agreed — measures the value of negotiated resolutions."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(demand_amount AS DOUBLE)), 0), 2)
      comment: "Gross recovery as a percentage of demand amount — measures subrogation collection effectiveness."
    - name: "net_recovery_roi_pct"
      expr: ROUND(100.0 * SUM(CAST(net_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(legal_fees_amount AS DOUBLE)), 0), 2)
      comment: "Net recovery as a multiple of legal fees — measures the ROI of the subrogation legal program."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_settlement_agreed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with agreed settlements — measures negotiation effectiveness and case resolution rate."
    - name: "total_lien_amount"
      expr: SUM(CAST(lien_amount AS DOUBLE))
      comment: "Total lien amounts applied — measures the financial value of liens enforced in subrogation cases."
    - name: "closed_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recovery_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subrogation cases closed — measures case throughput and backlog management effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG (Diagnosis-Related Group) assignment and payment KPIs covering case mix index, outlier payments, geometric mean LOS, and grouper accuracy. Used by finance, clinical operations, and contracting to benchmark inpatient cost efficiency and negotiate hospital rates."
  source: "`vibe_health_insurance_v1`.`claim`.`drg`"
  dimensions:
    - name: "drg_code"
      expr: drg_code
      comment: "DRG code assigned to the inpatient claim — primary clinical grouping dimension for cost benchmarking."
    - name: "drg_type"
      expr: drg_type
      comment: "Type of DRG system (e.g., MS-DRG, APR-DRG) — used to segment by grouper methodology."
    - name: "major_diagnostic_category"
      expr: major_diagnostic_category
      comment: "Major Diagnostic Category (MDC) — broad clinical grouping for high-level inpatient cost analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the DRG assignment (e.g., Final, Preliminary, Error) — used to filter production vs. draft assignments."
    - name: "grouper_status"
      expr: grouper_status
      comment: "Status of the grouper run — used to identify failed or incomplete DRG assignments."
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Whether the case has a complication or comorbidity (CC/MCC) — used to analyze severity-adjusted cost patterns."
    - name: "grouper_run_month"
      expr: DATE_TRUNC('MONTH', grouper_run_timestamp)
      comment: "Month the DRG grouper was run — used to track grouper processing timeliness."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the DRG assignment became effective — used for period-based cost analysis."
  measures:
    - name: "total_drg_assignments"
      expr: COUNT(1)
      comment: "Total number of DRG assignments — baseline volume KPI for inpatient claim processing."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total DRG-based payment amounts — primary inpatient cost KPI for finance and contracting."
    - name: "avg_payment_per_drg"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per DRG assignment — used to benchmark inpatient costs against national norms."
    - name: "total_outlier_payment_amount"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payment amounts — measures the financial impact of high-cost inpatient cases exceeding DRG thresholds."
    - name: "outlier_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(outlier_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Outlier payments as a percentage of total DRG payments — elevated rates indicate high-acuity or potentially miscoded cases."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay across DRG assignments — used to benchmark LOS efficiency against national standards."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay — used alongside geometric mean for inpatient utilization benchmarking."
    - name: "avg_drg_weight"
      expr: AVG(CAST(weight AS DOUBLE))
      comment: "Average DRG relative weight — measures case mix complexity; higher weights indicate more resource-intensive cases."
    - name: "total_case_mix_index_contribution"
      expr: SUM(CAST(case_mix_index_contribution AS DOUBLE))
      comment: "Sum of case mix index contributions — aggregate measure of inpatient case complexity for the plan population."
    - name: "cc_mcc_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cc_mcc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inpatient cases with CC/MCC — measures severity distribution and coding completeness."
    - name: "avg_base_rate_applied"
      expr: AVG(CAST(base_rate_applied AS DOUBLE))
      comment: "Average base rate applied in DRG payment calculation — used to monitor contract rate application accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level financial and utilization KPIs covering procedure-level costs, units of service, denial rates, and COB paid amounts. Used by medical economics, contracting, and clinical analytics teams for procedure-level cost and utilization analysis."
  source: "`vibe_health_insurance_v1`.`claim`.`line`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code on the claim line — primary clinical dimension for procedure-level cost analysis."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the claim line (e.g., Paid, Denied, Pending) — used to filter paid vs. denied line populations."
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line (e.g., Professional, Ancillary, DME) — used to segment line-level costs by service type."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code — used to analyze procedure costs by care setting."
    - name: "emergency_indicator"
      expr: emergency_indicator
      comment: "Whether the service was provided in an emergency — used to segment emergency vs. elective utilization."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service — primary time dimension for procedure-level trend analysis."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code on the claim line — used for medical drug cost analysis (e.g., infused biologics)."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier — used to analyze modifier usage patterns and their impact on reimbursement."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of claim lines — baseline utilization volume KPI."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Sum of billed amounts at the line level — gross provider charges by procedure."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of allowed amounts at the line level — contractual reimbursement basis by procedure."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of paid amounts at the line level — actual procedure-level cost to the plan."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Sum of patient responsibility amounts — measures member cost-sharing burden at the procedure level."
    - name: "total_cob_paid_amount"
      expr: SUM(CAST(cob_paid_amount AS DOUBLE))
      comment: "Sum of COB paid amounts at the line level — measures secondary payer offset at the procedure level."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Sum of units of service — measures procedure utilization volume for medical economics analysis."
    - name: "avg_allowed_amount_per_unit"
      expr: ROUND(SUM(CAST(allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(units_of_service AS DOUBLE)), 0), 2)
      comment: "Average allowed amount per unit of service — unit cost KPI for procedure-level benchmarking and contract analysis."
    - name: "line_denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN line_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claim lines denied — procedure-level denial rate for provider relations and contracting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of line-level adjustment amounts — measures post-adjudication corrections at the procedure level."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_eob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Explanation of Benefits (EOB) delivery and financial summary KPIs. Used by member services, compliance, and operations to monitor EOB generation timeliness, delivery method distribution, member financial responsibility, and FHIR compliance."
  source: "`vibe_health_insurance_v1`.`claim`.`eob`"
  dimensions:
    - name: "eob_type"
      expr: eob_type
      comment: "Type of EOB (e.g., Medical, Dental, Pharmacy) — primary segmentation for EOB analysis."
    - name: "eob_status"
      expr: eob_status
      comment: "Current status of the EOB (e.g., Generated, Delivered, Suppressed) — used to monitor EOB lifecycle."
    - name: "delivery_method"
      expr: delivery_method
      comment: "EOB delivery method (e.g., Mail, Portal, Email) — used to analyze digital adoption and delivery cost."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Whether EOB delivery was suppressed — used to monitor suppression rates and compliance risk."
    - name: "language_code"
      expr: language_code
      comment: "Language of the EOB — used to monitor language access compliance and translation program coverage."
    - name: "member_responsibility_type"
      expr: member_responsibility_type
      comment: "Type of member financial responsibility (e.g., Deductible, Copay, Coinsurance) — used for cost-sharing analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of EOB delivery — used for trend analysis of EOB volumes and delivery timeliness."
    - name: "generation_month"
      expr: DATE_TRUNC('MONTH', generation_timestamp)
      comment: "Month of EOB generation — used to measure lag between claim adjudication and EOB production."
  measures:
    - name: "total_eobs_generated"
      expr: COUNT(1)
      comment: "Total number of EOBs generated — baseline volume KPI for member communications operations."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Sum of billed amounts on EOBs — used to reconcile EOB financial data against claim header totals."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of allowed amounts on EOBs — used to verify EOB accuracy against adjudication records."
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Sum of plan-paid amounts on EOBs — used to reconcile member-facing financial data with plan payment records."
    - name: "total_member_responsibility_amount"
      expr: SUM(CAST(member_responsibility_amount AS DOUBLE))
      comment: "Sum of member responsibility amounts on EOBs — measures aggregate member cost-sharing communicated via EOBs."
    - name: "total_cob_adjustment_amount"
      expr: SUM(CAST(cob_adjustment_amount AS DOUBLE))
      comment: "Sum of COB adjustment amounts on EOBs — used to verify COB transparency in member communications."
    - name: "suppression_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOBs suppressed — elevated rates may indicate compliance risk for member notification requirements."
    - name: "digital_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_method IN ('Portal', 'Email') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOBs delivered digitally — measures digital adoption and paper reduction program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim status event KPIs covering status transition volumes, manual intervention rates, and event source distribution. Used by claims operations and compliance to monitor claim lifecycle velocity, manual override patterns, and audit trail completeness."
  source: "`vibe_health_insurance_v1`.`claim`.`status_event`"
  dimensions:
    - name: "status_code"
      expr: status_code
      comment: "Current status code after the event — used to analyze status distribution and transition patterns."
    - name: "previous_status_code"
      expr: previous_status_code
      comment: "Status code before the event — used to analyze status transition flows and identify bottlenecks."
    - name: "event_source"
      expr: event_source
      comment: "Source system or process that triggered the status event — used to attribute status changes to specific workflows."
    - name: "is_manual"
      expr: is_manual
      comment: "Whether the status event was manually triggered — used to monitor manual intervention rates."
    - name: "user_role"
      expr: user_role
      comment: "Role of the user who triggered the event — used for accountability and workflow analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the status change — used to categorize the drivers of claim status transitions."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the status event — used for trend analysis of claim processing velocity."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of claim status events — measures claim processing activity and workflow throughput."
    - name: "manual_event_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN 1 END)
      comment: "Number of manually triggered status events — measures human intervention volume in claim processing."
    - name: "manual_intervention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status events triggered manually — elevated rates indicate automation gaps in claim processing workflows."
$$;