-- Metric views for domain: billing | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over premium invoices — tracks billed revenue, subsidy exposure, retroactive adjustments, and collection health across health plans, employer groups, and lines of business."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. draft, issued, paid, void) for pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (individual, group, COBRA) to segment billing volume."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid) driving premium revenue segmentation."
    - name: "billing_period_start"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Month bucket of billing period start for trend analysis."
    - name: "billing_period_end"
      expr: DATE_TRUNC('month', billing_period_end)
      comment: "Month bucket of billing period end for cohort analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status (current, delinquent, written-off) for receivables management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Invoice delivery channel (paper, electronic, portal) for operational efficiency tracking."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied (APTC, CSR, none) for subsidy exposure reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags invoices subject to regulatory reporting obligations."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date for cash flow forecasting."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued — baseline volume KPI for billing operations."
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium billed across all invoices — primary revenue recognition KPI."
    - name: "total_subsidy_applied"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total APTC/subsidy amounts applied to invoices — measures government subsidy exposure."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after subsidies and discounts — actual receivables balance."
    - name: "total_retroactive_adjustments"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive premium adjustments — signals enrollment change volatility and billing complexity."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed — required for tax liability and regulatory reporting."
    - name: "total_refunds_issued"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts on invoices — measures overpayment and billing error exposure."
    - name: "avg_premium_per_invoice"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium per invoice — benchmarks pricing and plan mix shifts over time."
    - name: "subsidy_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_eligible_for_subsidy = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices eligible for subsidy — measures ACA marketplace exposure."
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across invoices — tracks promotional and contractual discount impact on revenue."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs — tracks payment volumes, suspense activity, NSF events, and reconciliation status to manage cash flow and payment integrity."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (new, adjustment, reversal) for payment flow analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Category of payer (individual, employer, government) for revenue source segmentation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Payment reconciliation status (matched, unmatched, suspense) for cash management."
    - name: "suspense_status"
      expr: suspense_status
      comment: "Suspense resolution status for unidentified payment tracking."
    - name: "payment_timestamp_month"
      expr: DATE_TRUNC('month', CAST(payment_timestamp AS TIMESTAMP))
      comment: "Month of payment receipt for cash flow trend analysis."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Non-sufficient funds flag — identifies returned payment events for collections risk."
    - name: "suspense_reason_code"
      expr: suspense_reason_code
      comment: "Reason code for suspense placement — identifies root causes of unmatched payments."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions — baseline volume for payment operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount collected — primary cash receipt KPI."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment after fees and adjustments — actual cash applied to accounts."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments — measures correction volume and billing accuracy."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees — tracks cost of payment collection operations."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment amounts — measures suspense and unmatched payment exposure."
    - name: "total_tax_on_payments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payments — required for tax liability reconciliation."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Count of NSF (returned) payments — key risk indicator for payment collection quality."
    - name: "nsf_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned NSF — measures payment collection risk and member financial health."
    - name: "suspense_payment_count"
      expr: COUNT(CASE WHEN suspense_status IS NOT NULL AND suspense_status != '' THEN 1 END)
      comment: "Count of payments in suspense — measures unresolved payment matching backlog."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium reconciliation KPIs — tracks variance between billed and collected premiums, reconciliation completion rates, and financial accuracy across health plans and employer groups."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_reconciliation`"
  dimensions:
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (monthly, annual, retroactive) for process segmentation."
    - name: "premium_reconciliation_status"
      expr: premium_reconciliation_status
      comment: "Current reconciliation status (open, in-progress, finalized) for workflow management."
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of reconciliation period start for trend analysis."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for regulatory reconciliation reporting."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether reconciliation has been finalized — separates closed from open items."
    - name: "mlr_input_flag"
      expr: mlr_input_flag
      comment: "Flags reconciliations feeding into MLR calculations — critical for ACA compliance."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags reconciliations subject to regulatory reporting requirements."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total reconciliation records — baseline volume for reconciliation operations."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total premium billed across reconciliation periods — revenue baseline for variance analysis."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected_amount AS DOUBLE))
      comment: "Total premium collected across reconciliation periods — actual cash received."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billed-vs-collected variance — primary financial accuracy KPI for billing operations."
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied during reconciliation — measures retroactive correction volume."
    - name: "total_aptc_subsidy_reconciled"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts reconciled — measures government subsidy accuracy and CMS exposure."
    - name: "total_net_premium_reconciled"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after adjustments and subsidies — final reconciled revenue figure."
    - name: "avg_variance_per_reconciliation"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance per reconciliation record — benchmarks billing accuracy and data quality."
    - name: "finalized_reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations finalized — measures reconciliation process completion and timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate KPIs — tracks rate levels, subsidy amounts, tobacco surcharges, and employer/employee contribution splits across market segments, coverage tiers, and rating areas."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (individual, small group, large group) for rate segmentation."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for rate tier analysis."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for geographic premium variation analysis."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (base, COBRA, subsidized) for rate category analysis."
    - name: "premium_rate_status"
      expr: premium_rate_status
      comment: "Rate status (active, expired, pending) for rate lifecycle management."
    - name: "age_band"
      expr: age_band
      comment: "Age band for age-rated premium analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of rate effective date for rate change trend analysis."
    - name: "rating_method"
      expr: rating_method
      comment: "Rating methodology (community, experience, composite) for actuarial segmentation."
    - name: "family_tier_structure"
      expr: family_tier_structure
      comment: "Family tier structure for household premium analysis."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total premium rate records — baseline for rate catalog size and complexity."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average premium rate amount — key pricing benchmark for actuarial and underwriting review."
    - name: "avg_employee_contribution_rate"
      expr: AVG(CAST(employee_contribution_rate AS DOUBLE))
      comment: "Average employee contribution rate — measures member cost-sharing levels across plans."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate — measures employer benefit cost commitment."
    - name: "avg_cobra_rate"
      expr: AVG(CAST(cobra_rate AS DOUBLE))
      comment: "Average COBRA premium rate — benchmarks continuation coverage pricing."
    - name: "avg_tobacco_surcharge_rate"
      expr: AVG(CAST(tobacco_surcharge_rate AS DOUBLE))
      comment: "Average tobacco surcharge rate — measures wellness incentive pricing impact."
    - name: "avg_wellness_discount_rate"
      expr: AVG(CAST(wellness_discount_rate AS DOUBLE))
      comment: "Average wellness discount rate — measures wellness program financial incentive levels."
    - name: "avg_subsidy_amount"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy amount per rate record — measures government subsidy dependency in rate design."
    - name: "max_rate_amount"
      expr: MAX(rate_amount)
      comment: "Maximum premium rate amount — identifies rate ceiling for affordability and regulatory review."
    - name: "min_rate_amount"
      expr: MIN(rate_amount)
      comment: "Minimum premium rate amount — identifies rate floor for competitive and actuarial analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule KPIs — tracks rate schedule coverage, filing status, and premium structure across health plans, market segments, and regulatory jurisdictions."
  source: "`vibe_health_insurance_v1`.`billing`.`rate_schedule`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for rate schedule segmentation (individual, small group, large group)."
    - name: "rate_schedule_status"
      expr: rate_schedule_status
      comment: "Current status of the rate schedule (active, expired, pending approval)."
    - name: "filing_status"
      expr: filing_status
      comment: "Regulatory filing status (filed, approved, rejected) for compliance tracking."
    - name: "regulatory_state"
      expr: regulatory_state
      comment: "State jurisdiction for rate filing and regulatory compliance analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision) for rate schedule categorization."
    - name: "rating_method"
      expr: rating_method
      comment: "Rating methodology for actuarial segmentation."
    - name: "applicable_year"
      expr: applicable_year
      comment: "Plan year the rate schedule applies to for annual rate trend analysis."
    - name: "is_default_schedule"
      expr: is_default_schedule
      comment: "Whether this is the default rate schedule — identifies primary pricing baseline."
    - name: "tobacco_surcharge_flag"
      expr: tobacco_surcharge_flag
      comment: "Whether tobacco surcharge applies — measures wellness incentive program adoption."
    - name: "wellness_discount_flag"
      expr: wellness_discount_flag
      comment: "Whether wellness discount applies — measures wellness program financial incentive coverage."
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total rate schedules — baseline for rate catalog complexity and plan coverage."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average base rate amount across schedules — actuarial pricing benchmark."
    - name: "avg_employee_contribution_rate"
      expr: AVG(CAST(employee_contribution_rate AS DOUBLE))
      comment: "Average employee contribution rate — measures member cost-sharing design."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate — measures employer benefit cost commitment."
    - name: "avg_cobra_rate"
      expr: AVG(CAST(cobra_rate AS DOUBLE))
      comment: "Average COBRA rate — benchmarks continuation coverage pricing strategy."
    - name: "avg_tobacco_surcharge_rate"
      expr: AVG(CAST(tobacco_surcharge_rate AS DOUBLE))
      comment: "Average tobacco surcharge rate — measures wellness incentive pricing levels."
    - name: "avg_wellness_discount_rate"
      expr: AVG(CAST(wellness_discount_rate AS DOUBLE))
      comment: "Average wellness discount rate — measures wellness program financial incentive design."
    - name: "avg_subsidy_amount"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per rate schedule — measures government subsidy dependency."
    - name: "filed_schedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'filed' OR filing_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate schedules with active regulatory filings — measures compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APTC subsidy KPIs — tracks subsidy amounts, CMS reconciliation status, and year-to-date utilization to manage ACA marketplace financial exposure and compliance."
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "aptc_subsidy_status"
      expr: aptc_subsidy_status
      comment: "Current status of the APTC subsidy (active, terminated, suspended) for subsidy lifecycle management."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for APTC — measures government reconciliation compliance."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (APTC, CSR) for subsidy program segmentation."
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant for CSR benefit level analysis."
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange/marketplace code for state vs. federal exchange segmentation."
    - name: "subsidy_effective_month"
      expr: DATE_TRUNC('month', subsidy_effective_date)
      comment: "Month of subsidy effective date for enrollment trend analysis."
  measures:
    - name: "total_subsidy_records"
      expr: COUNT(1)
      comment: "Total APTC subsidy records — baseline for marketplace enrollment volume."
    - name: "total_monthly_aptc_amount"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amounts — primary government subsidy financial exposure KPI."
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap across all subsidy records — measures maximum subsidy liability."
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC applied — measures actual subsidy utilization vs. cap."
    - name: "avg_monthly_aptc_amount"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC per member — benchmarks subsidy generosity and income distribution."
    - name: "aptc_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(ytd_aptc_applied AS DOUBLE)) / NULLIF(SUM(CAST(annual_aptc_cap AS DOUBLE)), 0), 2)
      comment: "YTD APTC utilization as percentage of annual cap — measures subsidy consumption pace and CMS reconciliation risk."
    - name: "cms_reconciliation_pending_count"
      expr: COUNT(CASE WHEN cms_reconciliation_status != 'reconciled' AND cms_reconciliation_status IS NOT NULL THEN 1 END)
      comment: "Count of subsidies with pending CMS reconciliation — measures regulatory compliance backlog."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_mlr_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio rebate KPIs — tracks MLR percentages, rebate amounts due, and disbursement status to manage ACA compliance and member rebate obligations."
  source: "`vibe_health_insurance_v1`.`billing`.`mlr_rebate`"
  dimensions:
    - name: "mlr_rebate_status"
      expr: mlr_rebate_status
      comment: "Current status of the MLR rebate (calculated, approved, disbursed) for lifecycle management."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (individual, small group, large group) for MLR compliance segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for MLR calculation segmentation."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for state-level MLR compliance reporting."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual MLR trend analysis."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of rebate disbursement (check, premium credit, direct deposit) for operational analysis."
    - name: "hhs_submission_status"
      expr: hhs_submission_status
      comment: "HHS submission status for federal regulatory compliance tracking."
    - name: "eligibility_flag"
      expr: eligibility_flag
      comment: "Whether the plan is eligible for MLR rebate — identifies rebate-triggering plans."
  measures:
    - name: "total_mlr_rebate_records"
      expr: COUNT(1)
      comment: "Total MLR rebate records — baseline for rebate program scope."
    - name: "total_rebate_amount_due"
      expr: SUM(CAST(rebate_amount_due AS DOUBLE))
      comment: "Total MLR rebate amounts due to members — primary ACA compliance financial liability KPI."
    - name: "total_premium_earned"
      expr: SUM(CAST(total_premium_earned AS DOUBLE))
      comment: "Total premium earned used in MLR calculation — revenue base for MLR ratio computation."
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims used in MLR calculation — primary cost driver for MLR compliance."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses — ACA-allowable expenses that improve MLR ratio."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across plans — primary ACA compliance KPI (must meet 80%/85% thresholds)."
    - name: "plans_below_mlr_threshold"
      expr: COUNT(CASE WHEN mlr_percentage < 80.0 THEN 1 END)
      comment: "Count of plans below 80% MLR threshold — identifies plans triggering rebate obligations."
    - name: "total_rebate_eligible_records"
      expr: COUNT(CASE WHEN eligibility_flag = TRUE THEN 1 END)
      comment: "Count of rebate-eligible MLR records — measures scope of rebate liability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cms_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS remittance KPIs — tracks risk adjustment and premium remittance payments from CMS, reconciliation status, and MLR rebate offsets for ACA financial management."
  source: "`vibe_health_insurance_v1`.`billing`.`cms_remittance`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of CMS payment (risk adjustment, reinsurance, CSR) for remittance categorization."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the remittance for financial close management."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current status of the remittance (pending, received, disputed) for cash management."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (initial, corrected, final) for submission lifecycle analysis."
    - name: "payment_period_start_month"
      expr: DATE_TRUNC('month', payment_period_start)
      comment: "Month of payment period start for remittance trend analysis."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the member/plan is eligible for this remittance — filters valid remittance records."
  measures:
    - name: "total_remittances"
      expr: COUNT(1)
      comment: "Total CMS remittance records — baseline for government payment volume."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross CMS payment amount — primary government revenue KPI for ACA plans."
    - name: "total_net_remittance_amount"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net remittance after offsets — actual cash received from CMS."
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amounts — measures risk pool transfer impact on plan financials."
    - name: "total_mlr_rebate_offset"
      expr: SUM(CAST(mlr_rebate_offset_amount AS DOUBLE))
      comment: "Total MLR rebate offsets applied to remittances — measures rebate liability impact on CMS payments."
    - name: "avg_net_remittance_per_record"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Average net remittance per record — benchmarks per-member government payment levels."
    - name: "reconciled_remittance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remittances reconciled — measures CMS financial close completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_collection_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection case KPIs — tracks delinquent premium amounts, write-offs, case resolution rates, and reinstatement eligibility to manage premium collection effectiveness."
  source: "`vibe_health_insurance_v1`.`billing`.`collection_case`"
  dimensions:
    - name: "collection_case_status"
      expr: collection_case_status
      comment: "Current status of the collection case (open, resolved, written-off) for pipeline management."
    - name: "last_action_type"
      expr: last_action_type
      comment: "Most recent collection action type for operational workflow analysis."
    - name: "final_resolution"
      expr: final_resolution
      comment: "Final resolution outcome (paid, written-off, reinstated) for collection effectiveness measurement."
    - name: "reinstatement_eligibility_flag"
      expr: reinstatement_eligibility_flag
      comment: "Whether member is eligible for reinstatement — identifies recovery opportunities."
    - name: "case_open_month"
      expr: DATE_TRUNC('month', case_open_timestamp)
      comment: "Month case was opened for delinquency trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the collection case for multi-currency reporting."
  measures:
    - name: "total_collection_cases"
      expr: COUNT(1)
      comment: "Total collection cases — baseline for delinquency volume and collections workload."
    - name: "total_delinquent_amount"
      expr: SUM(CAST(delinquent_amount AS DOUBLE))
      comment: "Total delinquent premium amounts — primary collections financial exposure KPI."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across collection cases — actual receivables at risk."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total written-off amounts — measures uncollectable premium losses."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied in collection cases — measures billing correction impact on collections."
    - name: "avg_delinquent_amount_per_case"
      expr: AVG(CAST(delinquent_amount AS DOUBLE))
      comment: "Average delinquent amount per case — benchmarks collection case severity."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(delinquent_amount AS DOUBLE)), 0), 2)
      comment: "Write-off amount as percentage of total delinquent amount — measures collection recovery effectiveness."
    - name: "reinstatement_eligible_count"
      expr: COUNT(CASE WHEN reinstatement_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of cases eligible for reinstatement — identifies member recovery pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period KPIs — tracks grace period utilization, APTC eligibility, extension rates, and termination outcomes to manage member retention and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`billing`.`grace_period`"
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Current status of the grace period (active, expired, resolved) for lifecycle management."
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (initial, ongoing, COBRA) for regulatory compliance segmentation."
    - name: "outcome"
      expr: outcome
      comment: "Grace period outcome (paid, terminated, extended) for retention analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction for state-specific grace period compliance."
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic grace period analysis."
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Whether member is APTC-eligible during grace period — ACA 90-day grace period compliance."
    - name: "extension_flag"
      expr: extension_flag
      comment: "Whether grace period was extended — measures hardship accommodation frequency."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags grace periods subject to regulatory reporting."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month grace period started for trend analysis."
  measures:
    - name: "total_grace_periods"
      expr: COUNT(1)
      comment: "Total grace periods — baseline for member payment delinquency volume."
    - name: "total_subsidy_at_risk"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts at risk during grace periods — measures APTC exposure during non-payment."
    - name: "aptc_eligible_grace_count"
      expr: COUNT(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 END)
      comment: "Count of APTC-eligible grace periods — measures ACA 90-day grace period compliance scope."
    - name: "extended_grace_period_count"
      expr: COUNT(CASE WHEN extension_flag = TRUE THEN 1 END)
      comment: "Count of extended grace periods — measures hardship accommodation frequency."
    - name: "termination_warning_issued_count"
      expr: COUNT(CASE WHEN termination_warning_issued = TRUE THEN 1 END)
      comment: "Count of grace periods with termination warnings issued — measures collections escalation activity."
    - name: "grace_period_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome IS NOT NULL AND outcome != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods with a recorded outcome — measures resolution completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_retro_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retroactive adjustment KPIs — tracks retroactive billing corrections, dispute volumes, and resolution outcomes to manage billing accuracy and financial restatement risk."
  source: "`vibe_health_insurance_v1`.`billing`.`retro_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of retroactive adjustment (enrollment change, rate correction, refund) for root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (pending, approved, applied) for workflow management."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment — identifies systemic billing error patterns."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status for contested adjustments — measures billing dispute volume."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute associated with the adjustment for dispute categorization."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Resolution outcome type for adjustment disposition analysis."
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', adjustment_timestamp)
      comment: "Month of adjustment for retroactive correction trend analysis."
    - name: "original_billing_period_start_month"
      expr: DATE_TRUNC('month', original_billing_period_start)
      comment: "Original billing period month for retroactive lag analysis."
  measures:
    - name: "total_retro_adjustments"
      expr: COUNT(1)
      comment: "Total retroactive adjustments — baseline for billing correction volume and data quality."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amounts — measures financial restatement magnitude."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed amounts in retroactive adjustments — measures billing dispute financial exposure."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average retroactive adjustment amount — benchmarks correction severity per event."
    - name: "disputed_adjustment_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN 1 END)
      comment: "Count of adjustments with active disputes — measures billing accuracy and member satisfaction risk."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retroactive adjustments that are disputed — key billing quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_suspense_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspense account KPIs — tracks unidentified and unmatched payments, overpayments, and resolution timeliness to manage cash application accuracy and financial integrity."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_suspense_items"
      expr: COUNT(1)
      comment: "Total suspense account items — baseline for unmatched payment backlog volume."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cobra_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA billing KPIs — tracks COBRA premium collections, compliance flags, grace periods, and retroactive adjustments to manage continuation coverage financial and regulatory obligations."
  source: "`vibe_health_insurance_v1`.`billing`.`cobra_billing`"
  dimensions:
    - name: "cobra_status"
      expr: cobra_status
      comment: "Current COBRA coverage status (active, terminated, lapsed) for continuation coverage management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the COBRA billing record for collections management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for COBRA premium for channel analysis."
    - name: "billing_cycle_month"
      expr: billing_cycle_month
      comment: "Billing cycle month for COBRA premium trend analysis."
    - name: "compliance_flag_erisa"
      expr: compliance_flag_erisa
      comment: "ERISA compliance flag — identifies COBRA records with ERISA compliance issues."
    - name: "compliance_flag_dol"
      expr: compliance_flag_dol
      comment: "DOL compliance flag — identifies COBRA records with Department of Labor compliance issues."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether a retroactive adjustment was applied — measures COBRA billing correction frequency."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Month COBRA coverage started for enrollment trend analysis."
  measures:
    - name: "total_cobra_billing_records"
      expr: COUNT(1)
      comment: "Total COBRA billing records — baseline for continuation coverage population size."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium amounts billed — primary continuation coverage revenue KPI."
    - name: "total_premium_collected"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total COBRA premium collected including admin fees — actual COBRA revenue."
    - name: "total_admin_fee_amount"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total COBRA administration fees — measures administrative cost recovery."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total COBRA refunds issued — measures overpayment and billing error exposure."
    - name: "total_retroactive_adjustment_amount"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustments on COBRA billing — measures enrollment change correction volume."
    - name: "erisa_compliance_issue_count"
      expr: COUNT(CASE WHEN compliance_flag_erisa = TRUE THEN 1 END)
      comment: "Count of COBRA records with ERISA compliance flags — critical regulatory risk KPI."
    - name: "dol_compliance_issue_count"
      expr: COUNT(CASE WHEN compliance_flag_dol = TRUE THEN 1 END)
      comment: "Count of COBRA records with DOL compliance flags — measures federal regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute KPIs — tracks dispute volumes, disputed amounts, resolution rates, and regulatory reporting to manage billing accuracy and member/vendor satisfaction."
  source: "`vibe_health_insurance_v1`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the billing dispute (open, resolved, escalated) for pipeline management."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of billing dispute (premium error, coverage dispute, payment mismatch) for root cause analysis."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the dispute (member, employer, vendor) for stakeholder analysis."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Resolution outcome type for dispute disposition analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags disputes subject to regulatory reporting obligations."
    - name: "open_month"
      expr: DATE_TRUNC('month', open_timestamp)
      comment: "Month dispute was opened for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency reporting."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total billing disputes — baseline for billing quality and member satisfaction risk."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed billing amounts — primary financial exposure KPI for billing disputes."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case — benchmarks dispute severity."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'open' THEN 1 END)
      comment: "Count of open disputes — measures unresolved billing dispute backlog."
    - name: "dispute_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resolved — measures billing dispute management effectiveness."
    - name: "regulatory_dispute_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of disputes requiring regulatory reporting — measures compliance exposure from billing disputes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment allocation KPIs — tracks how collected premiums are allocated across invoice lines, measures overpayment rates, suspense resolution, and reconciliation accuracy."
  source: "`vibe_health_insurance_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of payment allocation (standard, suspense resolution, overpayment) for allocation categorization."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (pending, applied, reversed) for workflow management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the allocation for financial close management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation for allocation segmentation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the allocation for channel analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel for the allocation for operational routing analysis."
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Whether the allocation involves an overpayment — identifies refund obligations."
    - name: "is_suspense_resolution"
      expr: is_suspense_resolution
      comment: "Whether the allocation resolves a suspense item — measures suspense clearance activity."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for cash application trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total payment allocation records — baseline for cash application volume."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoice lines — primary cash application KPI."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed AS DOUBLE))
      comment: "Total billed amount across allocations — revenue baseline for allocation coverage analysis."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected AS DOUBLE))
      comment: "Total collected amount across allocations — actual cash received and applied."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected — measures allocation accuracy and billing discrepancies."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied during allocation — measures contractual discount impact on cash application."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts in allocations — required for tax liability reconciliation."
    - name: "overpayment_allocation_count"
      expr: COUNT(CASE WHEN is_overpayment = TRUE THEN 1 END)
      comment: "Count of overpayment allocations — measures refund obligation volume."
    - name: "suspense_resolution_count"
      expr: COUNT(CASE WHEN is_suspense_resolution = TRUE THEN 1 END)
      comment: "Count of suspense-resolving allocations — measures suspense clearance throughput."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(total_collected AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Total collected as percentage of total billed — primary premium collection effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_edi_820`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI 820 payment transaction KPIs — tracks electronic premium payment transaction volumes, reconciliation rates, and error rates for EDI operations management."
  source: "`vibe_health_insurance_v1`.`billing`.`edi_820`"
  dimensions:
    - name: "direction"
      expr: direction
      comment: "Transaction direction (inbound, outbound) for EDI flow analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of EDI payment transaction for categorization."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "EDI payment method code for channel analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the EDI transaction for processing pipeline management."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the EDI transaction has been reconciled — measures EDI matching completeness."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of EDI payment date for transaction volume trend analysis."
    - name: "error_code"
      expr: error_code
      comment: "EDI error code for error pattern analysis and operational improvement."
  measures:
    - name: "total_edi_820_transactions"
      expr: COUNT(1)
      comment: "Total EDI 820 transactions — baseline for electronic payment volume."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount across EDI 820 transactions — electronic premium revenue KPI."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average EDI 820 payment amount — benchmarks typical electronic payment size."
    - name: "reconciled_transaction_count"
      expr: COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END)
      comment: "Count of reconciled EDI transactions — measures EDI matching throughput."
    - name: "edi_reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDI 820 transactions reconciled — primary EDI operations quality KPI."
    - name: "error_transaction_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL AND error_code != '' THEN 1 END)
      comment: "Count of EDI transactions with errors — measures EDI processing quality and rework volume."
    - name: "edi_error_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN error_code IS NOT NULL AND error_code != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDI 820 transactions with errors — key EDI operations quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium refund KPIs — tracks refund volumes, amounts, processing fees, and approval rates to manage overpayment resolution and member financial satisfaction."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_refund`"
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (overpayment, cancellation, retroactive) for refund categorization."
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund disbursement (check, ACH, credit) for operational analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the refund (pending, approved, denied) for workflow management."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the refund for processing pipeline management."
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Reason code for the refund — identifies root causes of overpayments."
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Whether the refund is partial — measures partial resolution frequency."
    - name: "is_tax_refund"
      expr: is_tax_refund
      comment: "Whether the refund includes a tax component — measures tax refund volume."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags refunds subject to regulatory reporting."
    - name: "issued_month"
      expr: DATE_TRUNC('month', issued_timestamp)
      comment: "Month refund was issued for trend analysis."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total premium refund records — baseline for overpayment resolution volume."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued — primary financial liability KPI for premium overpayments."
    - name: "total_original_payment_amount"
      expr: SUM(CAST(original_payment_amount AS DOUBLE))
      comment: "Total original payment amounts associated with refunds — measures refund-to-payment ratio context."
    - name: "total_processing_fee"
      expr: SUM(CAST(refund_processing_fee AS DOUBLE))
      comment: "Total refund processing fees — measures administrative cost of refund operations."
    - name: "total_tax_refund_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts refunded — required for tax liability reconciliation."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount — benchmarks typical overpayment size."
    - name: "partial_refund_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_refund = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds that are partial — measures partial resolution frequency."
    - name: "refund_to_original_payment_ratio"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_payment_amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as percentage of original payment — measures overpayment rate and billing accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account KPIs — tracks account balances, payment due amounts, subsidy levels, and auto-pay adoption to manage premium receivables and member billing relationships."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (individual, group, COBRA) for account segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (active, suspended, closed) for portfolio management."
    - name: "billing_method"
      expr: billing_method
      comment: "Billing method (electronic, paper, payroll deduction) for channel analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash flow planning."
    - name: "billing_cycle_type"
      expr: billing_cycle_type
      comment: "Type of billing cycle for operational segmentation."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account for receivables management."
    - name: "auto_pay_enrollment"
      expr: auto_pay_enrollment
      comment: "Whether account is enrolled in auto-pay — measures payment automation adoption."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether account is tax-exempt — required for tax liability reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags accounts subject to regulatory reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month account became effective for cohort analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total billing accounts — baseline for billing portfolio size."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all accounts — primary receivables KPI."
    - name: "total_payment_due_amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total payment due across accounts — measures immediate cash collection obligation."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts on accounts — measures government subsidy exposure in billing portfolio."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total APTC amounts on accounts — measures ACA marketplace subsidy dependency."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limits extended — measures billing credit risk exposure."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account — benchmarks typical receivables per billing relationship."
    - name: "auto_pay_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in auto-pay — measures payment automation adoption and NSF risk reduction."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate across accounts — benchmarks premium pricing levels."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing cycle KPIs — tracks cycle-level premium amounts, pro-rata adjustments, discount levels, and renewal activity to manage billing period financial performance."
  source: "`vibe_health_insurance_v1`.`billing`.`cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of billing cycle (standard, renewal, COBRA) for cycle categorization."
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the billing cycle (active, closed, cancelled) for lifecycle management."
    - name: "billing_method"
      expr: billing_method
      comment: "Billing method for the cycle for channel analysis."
    - name: "billing_frequency_months"
      expr: billing_frequency_months
      comment: "Billing frequency in months for cash flow planning."
    - name: "is_pro_rata"
      expr: is_pro_rata
      comment: "Whether the cycle uses pro-rata billing — measures partial period billing frequency."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the cycle auto-renews — measures renewal automation adoption."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month cycle started for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing cycle for multi-currency reporting."
  measures:
    - name: "total_cycles"
      expr: COUNT(1)
      comment: "Total billing cycles — baseline for billing period volume."
    - name: "total_default_premium_amount"
      expr: SUM(CAST(default_premium_amount AS DOUBLE))
      comment: "Total default premium amounts across cycles — baseline premium revenue before adjustments."
    - name: "total_net_premium_amount"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after discounts and adjustments — actual cycle revenue KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across cycles — measures discount program financial impact."
    - name: "total_prorated_amount"
      expr: SUM(CAST(prorated_amount AS DOUBLE))
      comment: "Total pro-rated amounts — measures partial period billing volume."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts across cycles — required for tax liability reporting."
    - name: "total_cycle_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total cycle amounts including all components — comprehensive cycle revenue KPI."
    - name: "avg_net_premium_per_cycle"
      expr: AVG(CAST(net_premium_amount AS DOUBLE))
      comment: "Average net premium per billing cycle — benchmarks typical cycle revenue."
    - name: "pro_rata_cycle_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pro_rata = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles using pro-rata billing — measures mid-period enrollment change frequency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level metrics providing granular premium billing analysis by coverage tier, rate type, and member — enables per-member premium analytics and employer/employee contribution tracking."
  source: "`vibe_health_insurance_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the invoice line (e.g., Employee Only, Employee+Spouse, Family)."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied (e.g., Age-Rated, Community-Rated, Composite)."
    - name: "premium_status"
      expr: premium_status
      comment: "Status of the premium line item (e.g., Active, Adjusted, Cancelled)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice line (e.g., Paid, Unpaid, Partial)."
    - name: "is_refund"
      expr: is_refund
      comment: "Whether this line represents a refund."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether this line is a retroactive adjustment."
    - name: "premium_currency"
      expr: premium_currency
      comment: "Currency of the premium amount."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing period month for the invoice line."
    - name: "premium_reconciliation_flag"
      expr: premium_reconciliation_flag
      comment: "Whether this line has been reconciled."
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across invoice lines — granular premium revenue."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer contribution to premiums — tracks employer share of premium funding."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee contribution to premiums — tracks member out-of-pocket premium burden."
    - name: "total_aptc_subsidy_amount"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy applied at the line level — ACA marketplace subsidy tracking."
    - name: "total_csr_adjustment"
      expr: SUM(CAST(csr_adjustment_amount AS DOUBLE))
      comment: "Total Cost Sharing Reduction adjustments — ACA CSR variant tracking."
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount across all invoice lines including taxes and adjustments."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total invoice line items — granularity indicator for billing detail."
    - name: "avg_premium_per_line"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per invoice line — per-member premium level indicator."
    - name: "retroactive_line_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive adjustment lines — indicator of enrollment change churn impacting billing."
$$;