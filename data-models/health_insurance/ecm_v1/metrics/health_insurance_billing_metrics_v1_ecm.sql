-- Metric views for domain: billing | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core premium invoicing metrics tracking billed premiums, subsidies, discounts, collections, and invoice aging for health insurance billing operations."
  source: "`health_insurance_ecm`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the premium invoice (e.g., Open, Paid, Past Due, Void)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Individual, Group, COBRA, Exchange)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the invoice pertains to (e.g., Commercial, Medicare, Medicaid, Individual)."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the invoice (e.g., Current, Delinquent, In Collections, Written Off)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the invoice (e.g., ACH, Credit Card, Check)."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment is expected or received (e.g., Online Portal, Mail, Phone)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice is delivered to the member or group (e.g., Email, Mail, Portal)."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied to the invoice (e.g., APTC, CSR, State)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the invoice."
    - name: "is_eligible_for_subsidy"
      expr: is_eligible_for_subsidy
      comment: "Whether the member/group is eligible for premium subsidies."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing period month derived from billing_period_start for time-series analysis."
    - name: "billing_period_quarter"
      expr: DATE_TRUNC('quarter', billing_period_start)
      comment: "Billing period quarter for quarterly financial reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date for aging and cash flow analysis."
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the health plan associated with the invoice."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this invoice is flagged for regulatory reporting."
  measures:
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium amount billed across all invoices — primary revenue indicator for the health plan."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after subsidies and discounts — represents actual expected cash collections."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts (APTC/CSR) applied to invoices — critical for CMS reconciliation and ACA compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to premium invoices — tracks pricing concessions and group discount impact."
    - name: "total_retroactive_adjustment"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustments on invoices — monitors enrollment change impacts on billing."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued on invoices — tracks overpayment returns and cancellation refunds."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on premium invoices for tax reporting and compliance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of premium invoices generated — baseline volume metric for billing operations."
    - name: "avg_net_amount_due"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per invoice — indicator of per-member or per-group premium levels."
    - name: "subsidy_eligible_invoice_count"
      expr: SUM(CASE WHEN is_eligible_for_subsidy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices eligible for subsidies — measures ACA marketplace penetration in billing."
    - name: "avg_premium_per_invoice"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average gross premium per invoice — tracks premium adequacy and rate trends."
    - name: "subsidy_ratio_numerator"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Numerator for subsidy-to-premium ratio: total subsidies. Divide by total_premium_billed in BI layer to get subsidy penetration rate."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium payment metrics tracking cash collections, payment methods, suspense activity, and payment processing efficiency for health insurance premium revenue."
  source: "`health_insurance_ecm`.`billing`.`premium_payment`"
  dimensions:
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Status of the premium payment (e.g., Applied, Pending, Returned, Suspense)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., ACH, Wire, Check, Credit Card)."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g., Online, Lockbox, Phone, Walk-in)."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (e.g., Individual, Employer, Government, Third-Party)."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g., Premium, Adjustment, Refund)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment (e.g., Reconciled, Unreconciled, Pending)."
    - name: "suspense_status"
      expr: suspense_status
      comment: "Suspense status for unmatched or problematic payments."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Whether the payment was returned for non-sufficient funds."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_timestamp)
      comment: "Month of payment for time-series cash flow analysis."
    - name: "payment_quarter"
      expr: DATE_TRUNC('quarter', payment_timestamp)
      comment: "Quarter of payment for quarterly financial reporting."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross premium payments received — primary cash collection metric for the health plan."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments — actual cash applied to accounts."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments — tracks write-offs, corrections, and reconciliation adjustments."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total processing fees on payments — cost of payment processing operations."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment amounts — indicator of suspense backlog and operational efficiency."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of premium payments received — baseline transaction volume."
    - name: "nsf_payment_count"
      expr: SUM(CASE WHEN nsf_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of NSF (bounced) payments — indicator of member payment reliability and bad debt risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction — tracks payment size trends."
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_name)
      comment: "Distinct payers making payments — breadth of premium collection base."
    - name: "total_tax_on_payments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts associated with premium payments for tax compliance reporting."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium reconciliation metrics tracking billed-vs-collected variance, APTC subsidies, and reconciliation completeness — critical for financial close and CMS reporting."
  source: "`health_insurance_ecm`.`billing`.`premium_reconciliation`"
  dimensions:
    - name: "premium_reconciliation_status"
      expr: premium_reconciliation_status
      comment: "Status of the reconciliation record (e.g., Open, In Progress, Finalized, Disputed)."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., Monthly, Quarterly, Annual, CMS)."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the reconciliation has been finalized and approved."
    - name: "mlr_input_flag"
      expr: mlr_input_flag
      comment: "Whether this reconciliation feeds into Medical Loss Ratio calculations."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for the reconciliation — important for state-level regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation amounts."
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Reconciliation period month for time-series financial analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this reconciliation is flagged for regulatory reporting."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for variance between billed and collected amounts."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total premium amount billed in reconciliation — the expected revenue baseline."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected_amount AS DOUBLE))
      comment: "Total premium amount collected in reconciliation — actual cash received."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected — key indicator of collection effectiveness and billing accuracy."
    - name: "total_adjustments_amount"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total adjustment amounts applied during reconciliation — tracks corrections and write-offs."
    - name: "total_aptc_subsidy_amount"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts in reconciliation — critical for CMS APTC reconciliation and ACA compliance."
    - name: "total_net_premium_amount"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after subsidies and adjustments — actual earned premium revenue."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of reconciliation records — operational volume metric."
    - name: "finalized_reconciliation_count"
      expr: SUM(CASE WHEN is_finalized = TRUE THEN 1 ELSE 0 END)
      comment: "Count of finalized reconciliations — measures financial close completeness."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance per reconciliation — indicator of systemic billing-collection mismatches."
    - name: "mlr_eligible_net_premium"
      expr: SUM(CASE WHEN mlr_input_flag = TRUE THEN CAST(net_premium_amount AS DOUBLE) ELSE 0 END)
      comment: "Net premium amount feeding into MLR calculations — denominator for Medical Loss Ratio compliance."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_collection_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection case metrics tracking delinquent accounts, write-offs, recovery effectiveness, and aging — critical for bad debt management and revenue protection."
  source: "`health_insurance_ecm`.`billing`.`collection_case`"
  dimensions:
    - name: "collection_case_status"
      expr: collection_case_status
      comment: "Current status of the collection case (e.g., Open, In Progress, Closed, Referred to Agency)."
    - name: "final_resolution"
      expr: final_resolution
      comment: "Final resolution outcome of the collection case (e.g., Paid in Full, Payment Plan, Written Off, Reinstated)."
    - name: "last_action_type"
      expr: last_action_type
      comment: "Type of the most recent collection action taken (e.g., Letter, Call, Final Notice)."
    - name: "reinstatement_eligibility_flag"
      expr: reinstatement_eligibility_flag
      comment: "Whether the member is eligible for coverage reinstatement upon payment."
    - name: "case_open_month"
      expr: DATE_TRUNC('month', case_open_timestamp)
      comment: "Month the collection case was opened for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the collection amounts."
  measures:
    - name: "total_delinquent_amount"
      expr: SUM(CAST(delinquent_amount AS DOUBLE))
      comment: "Total delinquent premium amount across all collection cases — primary bad debt exposure metric."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount still due on collection cases — outstanding receivable at risk."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amounts written off as uncollectible — direct impact on revenue and financial statements."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to collection cases — tracks negotiated settlements and corrections."
    - name: "collection_case_count"
      expr: COUNT(1)
      comment: "Total number of collection cases — volume indicator for collections operations."
    - name: "open_case_count"
      expr: SUM(CASE WHEN collection_case_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open collection cases — workload indicator for collections team."
    - name: "avg_delinquent_amount"
      expr: AVG(CAST(delinquent_amount AS DOUBLE))
      comment: "Average delinquent amount per case — severity indicator for collections prioritization."
    - name: "distinct_delinquent_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with collection cases — breadth of delinquency across the member population."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute metrics tracking dispute volumes, amounts, resolution rates, and aging — key indicators of billing accuracy and member/provider satisfaction."
  source: "`health_insurance_ecm`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the billing dispute (e.g., Open, Under Review, Resolved, Escalated)."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (e.g., Premium Amount, Coverage Period, Subsidy, Duplicate Charge)."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g., Adjusted, Denied, Partial Credit, Full Refund)."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the dispute (e.g., Member, Employer, Provider, Internal)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount."
    - name: "dispute_open_month"
      expr: DATE_TRUNC('month', open_timestamp)
      comment: "Month the dispute was opened for trend analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this dispute is flagged for regulatory reporting."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar amount under dispute — financial exposure from billing disagreements."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes — indicator of billing accuracy and member satisfaction."
    - name: "open_dispute_count"
      expr: SUM(CASE WHEN dispute_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open disputes — backlog indicator for dispute resolution team."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case — severity indicator for dispute management."
    - name: "distinct_disputing_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers with billing disputes — breadth of billing dissatisfaction."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_cobra_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation billing metrics tracking COBRA premium volumes, payment status, compliance, and retroactive adjustments — essential for ERISA/DOL compliance."
  source: "`health_insurance_ecm`.`billing`.`cobra_billing`"
  dimensions:
    - name: "cobra_status"
      expr: cobra_status
      comment: "Status of the COBRA billing record (e.g., Active, Terminated, Pending Election)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the COBRA premium (e.g., Paid, Past Due, Grace Period)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for COBRA premium."
    - name: "billing_cycle_month"
      expr: billing_cycle_month
      comment: "Billing cycle month for the COBRA premium."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Whether a retroactive adjustment was applied to this COBRA billing."
    - name: "compliance_flag_erisa"
      expr: compliance_flag_erisa
      comment: "ERISA compliance flag for the COBRA billing record."
    - name: "compliance_flag_dol"
      expr: compliance_flag_dol
      comment: "Department of Labor compliance flag."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the COBRA billing amounts."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Month of COBRA coverage start for cohort analysis."
  measures:
    - name: "total_cobra_premium"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total COBRA premium amount billed including admin fees — total COBRA revenue."
    - name: "total_admin_fee"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total COBRA administrative fees collected (typically 2% surcharge) — COBRA-specific revenue."
    - name: "total_retroactive_adjustment"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustments on COBRA billing — tracks coverage change impacts."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total COBRA refund amounts — tracks overpayments and cancellation refunds."
    - name: "cobra_billing_count"
      expr: COUNT(1)
      comment: "Total COBRA billing records — volume of COBRA continuation coverage."
    - name: "active_cobra_count"
      expr: SUM(CASE WHEN cobra_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active COBRA billings — current COBRA enrollment volume."
    - name: "avg_cobra_premium"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average COBRA premium per billing — tracks COBRA cost trends."
    - name: "distinct_cobra_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members on COBRA continuation — COBRA population size."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_mlr_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio rebate metrics tracking MLR percentages, rebate obligations, and claims-to-premium ratios — mandatory ACA compliance reporting to CMS/HHS."
  source: "`health_insurance_ecm`.`billing`.`mlr_rebate`"
  dimensions:
    - name: "mlr_rebate_status"
      expr: mlr_rebate_status
      comment: "Status of the MLR rebate (e.g., Calculated, Approved, Disbursed, Filed)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for MLR calculation (e.g., Individual, Small Group, Large Group)."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for MLR reporting (e.g., Individual, Small Group, Large Group)."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for MLR reporting — MLR is calculated and reported at the state level."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the MLR calculation — annual ACA requirement."
    - name: "hhs_submission_status"
      expr: hhs_submission_status
      comment: "HHS submission status for the MLR filing."
    - name: "eligibility_flag"
      expr: eligibility_flag
      comment: "Whether the plan is eligible for MLR rebate calculation."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the MLR (e.g., Standard, Credibility-Adjusted)."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of rebate disbursement (e.g., Premium Credit, Check, Lump Sum)."
  measures:
    - name: "total_rebate_amount_due"
      expr: SUM(CAST(rebate_amount_due AS DOUBLE))
      comment: "Total MLR rebate amount owed to members/groups — direct financial liability under ACA."
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims used in MLR calculation — numerator of the MLR ratio."
    - name: "total_premium_earned"
      expr: SUM(CAST(total_premium_earned AS DOUBLE))
      comment: "Total premium earned used in MLR calculation — denominator of the MLR ratio."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses included in MLR numerator per ACA rules."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across rebate records — indicator of compliance with 80/85% ACA thresholds."
    - name: "mlr_rebate_count"
      expr: COUNT(1)
      comment: "Total MLR rebate records — volume of MLR calculations across plans and states."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level metrics providing granular premium billing analysis by coverage tier, rate type, and member — enables per-member premium analytics and employer/employee contribution tracking."
  source: "`health_insurance_ecm`.`billing`.`invoice_line`"
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
    - name: "distinct_members_billed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with invoice lines — billed member population size."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_suspense_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspense account metrics tracking unmatched and unapplied payments — critical for cash management, operational efficiency, and financial close timeliness."
  source: "`health_insurance_ecm`.`billing`.`account`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the suspense amount."
  measures:
    - name: "suspense_item_count"
      expr: COUNT(1)
      comment: "Total suspense items — operational backlog indicator for payment processing team."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_cms_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS remittance metrics tracking government payments, risk adjustments, and reconciliation for Medicare/Medicaid/ACA marketplace — critical for government program revenue management."
  source: "`health_insurance_ecm`.`billing`.`cms_remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of the CMS remittance (e.g., Received, Applied, Disputed, Reconciled)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the remittance against expected amounts."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of CMS payment (e.g., Capitation, Risk Adjustment, APTC, Reinsurance)."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (e.g., Original, Corrected, Void)."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for CMS payment adjustment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the remittance."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the member/claim is eligible for CMS payment."
    - name: "payment_period_month"
      expr: DATE_TRUNC('month', payment_period_start)
      comment: "Payment period month for CMS remittance time-series analysis."
  measures:
    - name: "total_gross_payment"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross CMS payment amount — government revenue before adjustments."
    - name: "total_net_remittance"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net CMS remittance after adjustments — actual government revenue received."
    - name: "total_risk_adjustment"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amounts from CMS — revenue impact of HCC/RAF score accuracy."
    - name: "total_mlr_rebate_offset"
      expr: SUM(CAST(mlr_rebate_offset_amount AS DOUBLE))
      comment: "Total MLR rebate offsets applied to CMS remittances."
    - name: "remittance_count"
      expr: COUNT(1)
      comment: "Total CMS remittance records — volume of government payment transactions."
    - name: "avg_net_remittance"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Average net remittance per record — per-transaction government payment level."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period metrics tracking members in premium payment grace periods — critical for ACA compliance, coverage continuity decisions, and termination risk management."
  source: "`health_insurance_ecm`.`billing`.`grace_period`"
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Status of the grace period (e.g., Active, Expired, Resolved, Terminated)."
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (e.g., ACA 90-Day, Standard 30-Day, State-Mandated)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the grace period (e.g., Payment Received, Terminated, Extended)."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction governing the grace period rules."
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Whether the member receives APTC — ACA mandates 90-day grace period for APTC recipients."
    - name: "extension_flag"
      expr: extension_flag
      comment: "Whether the grace period was extended beyond standard duration."
    - name: "termination_warning_issued"
      expr: termination_warning_issued
      comment: "Whether a termination warning was issued to the member."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the grace period initiation."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the grace period started for trend analysis."
  measures:
    - name: "grace_period_count"
      expr: COUNT(1)
      comment: "Total grace period records — volume of members at risk of coverage termination."
    - name: "active_grace_period_count"
      expr: SUM(CASE WHEN grace_period_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active grace periods — members currently at risk of losing coverage."
    - name: "total_subsidy_at_risk"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount associated with grace period members — APTC dollars at risk if members terminate."
    - name: "aptc_grace_period_count"
      expr: SUM(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 ELSE 0 END)
      comment: "Count of grace periods for APTC-eligible members — these require 90-day grace period under ACA."
    - name: "distinct_members_in_grace"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members currently in grace period — population at risk of coverage loss."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium refund metrics tracking refund volumes, amounts, processing, and reasons — monitors overpayment management and member satisfaction."
  source: "`health_insurance_ecm`.`billing`.`premium_refund`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the refund (e.g., Initiated, Approved, Issued, Cleared)."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g., Overpayment, Cancellation, Rate Correction, Duplicate Payment)."
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund disbursement (e.g., Check, ACH, Premium Credit)."
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Reason code for the refund."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the refund request."
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Whether this is a partial refund of the original payment."
    - name: "refund_currency"
      expr: refund_currency
      comment: "Currency of the refund."
    - name: "issued_month"
      expr: DATE_TRUNC('month', issued_timestamp)
      comment: "Month the refund was issued for trend analysis."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total premium refund amounts issued — cash outflow from overpayments and cancellations."
    - name: "total_original_payment_amount"
      expr: SUM(CAST(original_payment_amount AS DOUBLE))
      comment: "Total original payment amounts associated with refunds — context for refund-to-payment ratio."
    - name: "total_processing_fees"
      expr: SUM(CAST(refund_processing_fee AS DOUBLE))
      comment: "Total refund processing fees — cost of refund operations."
    - name: "refund_count"
      expr: COUNT(1)
      comment: "Total refund records — volume of refund processing activity."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount — indicator of typical overpayment or cancellation refund size."
    - name: "distinct_members_refunded"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members receiving refunds — breadth of refund activity across membership."
$$;