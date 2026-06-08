-- Metric views for domain: finance | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_premium_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium revenue metrics for health insurance plans — tracks written, earned, net earned premiums, reinsurance ceded, risk adjustments, and capitation to support revenue recognition, MLR reporting, and actuarial analysis."
  source: "`health_insurance_ecm`.`finance`.`premium_revenue`"
  dimensions:
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) for segmenting premium revenue."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., Individual, Small Group, Large Group) for ACA and regulatory reporting."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (e.g., Medical, Dental, Vision, Pharmacy)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue trending and budgeting."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly revenue recognition and close."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for GL alignment."
    - name: "is_capitated"
      expr: CAST(is_capitated AS STRING)
      comment: "Whether the premium is under a capitated arrangement."
    - name: "premium_revenue_status"
      expr: premium_revenue_status
      comment: "Status of the premium revenue record (e.g., Active, Reversed, Adjusted)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reporting."
    - name: "revenue_month"
      expr: DATE_TRUNC('month', revenue_date)
      comment: "Revenue date truncated to month for time-series analysis."
    - name: "mlr_denominator_flag"
      expr: CAST(mlr_denominator_flag AS STRING)
      comment: "Flag indicating if premium counts toward MLR denominator calculation."
  measures:
    - name: "total_written_premium"
      expr: SUM(CAST(written_premium AS DOUBLE))
      comment: "Total written premium — the full contractual premium amount before adjustments. Key top-line revenue indicator."
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium AS DOUBLE))
      comment: "Total earned premium — revenue recognized for the coverage period elapsed. Primary GAAP revenue measure."
    - name: "total_net_earned_premium"
      expr: SUM(CAST(net_earned_premium AS DOUBLE))
      comment: "Net earned premium after reinsurance and risk adjustments. Used for MLR calculations and profitability analysis."
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium AS DOUBLE))
      comment: "Total premium ceded to reinsurers. Monitors reinsurance cost and risk transfer strategy."
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation payments — fixed per-member payments under capitated arrangements."
    - name: "total_unearned_premium_reserve"
      expr: SUM(CAST(unearned_premium_reserve AS DOUBLE))
      comment: "Total unearned premium reserve — liability for future coverage periods. Critical for balance sheet and statutory reporting."
    - name: "total_risk_corridor_adjustment"
      expr: SUM(CAST(risk_corridor_adjustment AS DOUBLE))
      comment: "Total risk corridor adjustments under ACA 3Rs programs."
    - name: "total_vbc_shared_savings"
      expr: SUM(CAST(vbc_shared_savings_amount AS DOUBLE))
      comment: "Total value-based care shared savings amounts impacting premium revenue."
    - name: "total_deficiency_reserve"
      expr: SUM(CAST(deficiency_reserve AS DOUBLE))
      comment: "Total premium deficiency reserves — indicates products where future claims are expected to exceed premiums."
    - name: "total_premium_tax_base"
      expr: SUM(CAST(premium_tax_base AS DOUBLE))
      comment: "Total premium tax base amount for state premium tax calculations."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across premium records — indicates population acuity relative to benchmark."
    - name: "premium_record_count"
      expr: COUNT(1)
      comment: "Count of premium revenue records for volume tracking."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_actuarial_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial reserve metrics tracking IBNR, case reserves, and total liabilities by line of business and reserve type — essential for statutory reporting, RBC calculations, and financial close."
  source: "`health_insurance_ecm`.`finance`.`actuarial_reserve`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for reserve segmentation (e.g., Commercial, Medicare, Medicaid)."
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of actuarial reserve (e.g., IBNR, Case, LAE, Premium Deficiency)."
    - name: "product_type"
      expr: product_type
      comment: "Product type (e.g., HMO, PPO, EPO) for reserve analysis."
    - name: "development_method"
      expr: development_method
      comment: "Actuarial development method used (e.g., Chain Ladder, Bornhuetter-Ferguson)."
    - name: "actuarial_reserve_status"
      expr: actuarial_reserve_status
      comment: "Status of the reserve estimate (e.g., Preliminary, Final, Approved)."
    - name: "reserve_period_month"
      expr: DATE_TRUNC('month', reserve_period)
      comment: "Reserve period truncated to month for trending."
    - name: "mlr_flag"
      expr: CAST(mlr_flag AS STRING)
      comment: "Whether the reserve is included in MLR calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for reporting."
  measures:
    - name: "total_reserve_estimate"
      expr: SUM(CAST(reserve_estimate_amount AS DOUBLE))
      comment: "Total actuarial reserve estimate — the best estimate of outstanding claim liabilities. Core statutory and GAAP balance sheet item."
    - name: "total_liability_amount"
      expr: SUM(CAST(total_liability_amount AS DOUBLE))
      comment: "Total liability amount including all reserve components. Key for RBC and solvency calculations."
    - name: "total_paid_claims"
      expr: SUM(CAST(paid_claims_amount AS DOUBLE))
      comment: "Total paid claims used in reserve development — tracks claim payment emergence against estimates."
    - name: "total_paid_lae"
      expr: SUM(CAST(paid_lae_amount AS DOUBLE))
      comment: "Total paid loss adjustment expenses — operational costs of settling claims."
    - name: "avg_confidence_interval_high"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE))
      comment: "Average upper bound of actuarial confidence interval — indicates reserve uncertainty."
    - name: "avg_confidence_interval_low"
      expr: AVG(CAST(confidence_interval_low AS DOUBLE))
      comment: "Average lower bound of actuarial confidence interval."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reserves."
    - name: "reserve_record_count"
      expr: COUNT(1)
      comment: "Count of actuarial reserve records."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_mlr_financial_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio (MLR) financial metrics — tracks incurred claims, earned premiums, quality improvement expenses, and rebate liabilities for ACA compliance and regulatory reporting."
  source: "`health_insurance_ecm`.`finance`.`mlr_financial_entry`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for MLR segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — MLR thresholds vary by segment."
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level MLR reporting to CMS."
    - name: "reporting_year"
      expr: reporting_year
      comment: "MLR reporting year for annual filing."
    - name: "mlr_financial_entry_status"
      expr: mlr_financial_entry_status
      comment: "Status of the MLR entry (e.g., Draft, Final, Submitted)."
    - name: "submission_status"
      expr: submission_status
      comment: "CMS submission status for the MLR filing."
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Calculation date truncated to month for trending."
  measures:
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims amount — the numerator component of the MLR calculation."
    - name: "total_earned_premium"
      expr: SUM(CAST(total_earned_premium AS DOUBLE))
      comment: "Total earned premium — the denominator component of the MLR calculation."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses — added to claims in MLR numerator per ACA rules."
    - name: "total_rebate_liability"
      expr: SUM(CAST(rebate_liability_amount AS DOUBLE))
      comment: "Total MLR rebate liability — amount owed to policyholders when MLR falls below minimum threshold. Direct P&L impact."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across entries — key regulatory compliance metric. ACA requires 80% (individual/small group) or 85% (large group)."
    - name: "avg_minimum_mlr_threshold"
      expr: AVG(CAST(minimum_mlr_threshold AS DOUBLE))
      comment: "Average minimum MLR threshold for compliance benchmarking."
    - name: "mlr_entry_count"
      expr: COUNT(1)
      comment: "Count of MLR financial entries."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics — tracks vendor payment obligations, discount capture, and payment processing for health plan operational expenses and provider payments."
  source: "`health_insurance_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "ap_invoice_status"
      expr: ap_invoice_status
      comment: "Invoice processing status (e.g., Open, Approved, Paid, Void)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., Standard, Credit Memo, Prepayment)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., Check, EFT, Wire)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business allocation for the expense."
    - name: "division_code"
      expr: division_code
      comment: "Division code for organizational reporting."
    - name: "void_flag"
      expr: CAST(void_flag AS STRING)
      comment: "Whether the invoice has been voided."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for AP aging and trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency AP reporting."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount — represents total vendor payment obligations before discounts and taxes."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts — actual cash outflow obligation."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured — measures AP efficiency and working capital optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total count of AP invoices for volume and throughput tracking."
    - name: "voided_invoice_count"
      expr: COUNT(CASE WHEN void_flag = true THEN 1 END)
      comment: "Count of voided invoices — monitors AP processing quality and error rates."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics — tracks premium billing, collections, write-offs, and unapplied amounts for employer groups and individual policyholders."
  source: "`health_insurance_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "AR invoice status (e.g., Open, Paid, Past Due, Written Off)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the AR invoice."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for aging and dunning analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle (e.g., Monthly, Quarterly) for cash flow forecasting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for revenue segmentation."
    - name: "party_type"
      expr: party_type
      comment: "Type of billed party (e.g., Employer Group, Individual, Government)."
    - name: "payment_method"
      expr: payment_method
      comment: "Expected payment method."
    - name: "is_written_off"
      expr: CAST(is_written_off AS STRING)
      comment: "Whether the invoice has been written off as uncollectible."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for AR aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for reporting."
  measures:
    - name: "total_gross_billed"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount — represents total premium and fee invoices issued."
    - name: "total_net_billed"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts and adjustments."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash — payments received but not yet matched to invoices. Indicates reconciliation backlog."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on AR invoices."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total count of AR invoices."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN is_written_off = true THEN 1 END)
      comment: "Count of invoices written off as uncollectible — monitors bad debt and credit risk."
    - name: "voided_invoice_count"
      expr: COUNT(CASE WHEN is_void = true THEN 1 END)
      comment: "Count of voided AR invoices."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics — tracks financial posting activity, debit/credit balances, intercompany eliminations, and budget alignment for financial close and consolidation."
  source: "`health_insurance_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., Standard, Adjusting, Closing, Reversing)."
    - name: "posting_status"
      expr: posting_status
      comment: "GL posting status (e.g., Posted, Unposted, Error)."
    - name: "entry_status"
      expr: entry_status
      comment: "Entry workflow status."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual financial reporting."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly close tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business allocation."
    - name: "source_module"
      expr: source_module
      comment: "Originating module (e.g., AP, AR, Claims, Payroll) for traceability."
    - name: "is_intercompany"
      expr: CAST(is_intercompany AS STRING)
      comment: "Whether the entry is an intercompany transaction requiring elimination."
    - name: "is_consolidation_elimination"
      expr: CAST(is_consolidation_elimination AS STRING)
      comment: "Whether the entry is a consolidation elimination."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency GL reporting."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amounts across journal entries — must balance with credits for GL integrity."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amounts across journal entries."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net journal entry amount (debits minus credits) — should be zero for balanced entries."
    - name: "total_statistical_amount"
      expr: SUM(CAST(statistical_amount AS DOUBLE))
      comment: "Total statistical (non-financial) amounts for operational tracking."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Count of journal entries for close process monitoring."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = true THEN 1 END)
      comment: "Count of intercompany journal entries requiring elimination — monitors consolidation complexity."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_reinsurance_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance transaction metrics — tracks ceded premiums, recoveries, and net reinsurance positions for risk transfer management and statutory Schedule F reporting."
  source: "`health_insurance_ecm`.`finance`.`reinsurance_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of reinsurance transaction (e.g., Cession, Recovery, Settlement)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the reinsurance transaction."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for cash flow tracking."
    - name: "reporting_category"
      expr: reporting_category
      comment: "Reporting category for statutory and GAAP classification."
    - name: "is_ceded"
      expr: CAST(is_ceded AS STRING)
      comment: "Whether the transaction is ceded (risk transferred out)."
    - name: "is_assumed"
      expr: CAST(is_assumed AS STRING)
      comment: "Whether the transaction is assumed (risk taken in)."
    - name: "is_quota_share"
      expr: CAST(is_quota_share AS STRING)
      comment: "Whether the arrangement is quota share (proportional)."
    - name: "is_stop_loss"
      expr: CAST(is_stop_loss AS STRING)
      comment: "Whether the arrangement is stop loss (excess of loss)."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Coverage start date truncated to month."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for reinsurance reporting."
  measures:
    - name: "total_ceded_premium"
      expr: SUM(CAST(ceded_premium_amount AS DOUBLE))
      comment: "Total ceded premium — cost of reinsurance protection. Key expense item impacting net income."
    - name: "total_ceded_loss"
      expr: SUM(CAST(ceded_loss_amount AS DOUBLE))
      comment: "Total ceded losses — claims transferred to reinsurers."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total reinsurance recoveries — cash received from reinsurers for covered claims."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net reinsurance position — indicates overall cost/benefit of reinsurance program."
    - name: "total_rbc_credit"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total risk-based capital credit from reinsurance — reduces required capital under NAIC RBC formula."
    - name: "total_attachment_point"
      expr: SUM(CAST(attachment_point_amount AS DOUBLE))
      comment: "Total attachment point amounts — the retention level before reinsurance coverage begins."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total reinsurance limit amounts — maximum coverage available."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reinsurance transactions."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Count of reinsurance transactions."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_vbc_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care settlement metrics — tracks shared savings/losses, quality performance, and provider settlement amounts for ACO and alternative payment model programs."
  source: "`health_insurance_ecm`.`finance`.`vbc_settlement`"
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of VBC settlement (e.g., Shared Savings, Shared Risk, Bundled Payment)."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Status of the settlement (e.g., Preliminary, Final, Paid)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the settlement."
    - name: "is_shared_risk"
      expr: CAST(is_shared_risk AS STRING)
      comment: "Whether the arrangement includes downside risk (two-sided model)."
    - name: "performance_period_start_quarter"
      expr: DATE_TRUNC('quarter', performance_period_start)
      comment: "Performance period start truncated to quarter for trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for settlement reporting."
  measures:
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditures under VBC arrangements — compared against benchmarks to determine savings/losses."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditures — the target spend level set by the VBC contract."
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings generated (actual vs benchmark) — positive values indicate cost reduction success."
    - name: "total_final_settlement"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts — the actual payments made/received based on performance."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC settlements — quality gates determine shared savings eligibility."
    - name: "avg_shared_savings_percentage"
      expr: AVG(CAST(shared_savings_percentage AS DOUBLE))
      comment: "Average shared savings percentage — the contractual share of savings retained by the provider."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to VBC benchmarks."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Count of VBC settlements."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget metrics — tracks budgeted amounts, variances, and prior year actuals for financial planning, cost control, and departmental accountability across the health plan."
  source: "`health_insurance_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Operating, Capital, Claims, Administrative)."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval/lifecycle status."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for budget segmentation."
    - name: "department_code"
      expr: department_code
      comment: "Department code for cost center accountability."
    - name: "division_code"
      expr: division_code
      comment: "Division code for organizational hierarchy reporting."
    - name: "year"
      expr: year
      comment: "Budget year."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget reporting."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(total_budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount — the approved spending plan. Foundation for variance analysis."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(total_adjusted_amount AS DOUBLE))
      comment: "Total adjusted budget amount after mid-year revisions."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs budget) — negative indicates overspend, positive indicates underspend."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual amounts for year-over-year comparison."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net budget amount after all adjustments."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Count of budget records."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing metrics — tracks tax liabilities, payments, and filing compliance for premium taxes, federal/state income taxes, and other regulatory tax obligations."
  source: "`health_insurance_ecm`.`finance`.`tax_filing`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., Premium Tax, Income Tax, Franchise Tax)."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for classification."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction (state/federal) for geographic tax analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status (e.g., Draft, Filed, Accepted, Rejected)."
    - name: "tax_payment_status"
      expr: tax_payment_status
      comment: "Tax payment status for cash flow tracking."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual reporting."
    - name: "filing_method"
      expr: filing_method
      comment: "Filing method (e.g., Electronic, Paper)."
    - name: "is_amended"
      expr: CAST(is_amended AS STRING)
      comment: "Whether the filing is an amendment."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability amount — the computed tax owed across all filings."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — the premium or income base subject to taxation."
    - name: "total_estimated_payments"
      expr: SUM(CAST(estimated_payments_amount AS DOUBLE))
      comment: "Total estimated tax payments made — compared against final liability to determine balance due/refund."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due after credits and estimated payments."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total tax payments made."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across filings."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Count of tax filings."
    - name: "amended_filing_count"
      expr: COUNT(CASE WHEN is_amended = true THEN 1 END)
      comment: "Count of amended filings — monitors filing accuracy and compliance risk."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation metrics — tracks GL-to-bank statement reconciliation status, outstanding items, and deposits in transit for cash management and internal controls."
  source: "`health_insurance_ecm`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (e.g., In Progress, Completed, Approved)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the reconciliation."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., Monthly, Daily, Ad Hoc)."
    - name: "is_adjusted"
      expr: CAST(is_adjusted AS STRING)
      comment: "Whether adjustments were made during reconciliation."
    - name: "reconciliation_period_month"
      expr: DATE_TRUNC('month', reconciliation_period_end)
      comment: "Reconciliation period end truncated to month for trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cash reporting."
  measures:
    - name: "total_bank_statement_balance"
      expr: SUM(CAST(bank_statement_balance AS DOUBLE))
      comment: "Total bank statement balance — the bank-reported cash position."
    - name: "total_gl_balance"
      expr: SUM(CAST(gl_balance AS DOUBLE))
      comment: "Total GL balance — the book-reported cash position."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks — issued but not yet cleared. Impacts cash forecasting."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_amount AS DOUBLE))
      comment: "Total deposits in transit — recorded in GL but not yet on bank statement."
    - name: "total_unreconciled_items"
      expr: SUM(CAST(unreconciled_items_amount AS DOUBLE))
      comment: "Total unreconciled items — indicates reconciliation exceptions requiring investigation. Key internal control metric."
    - name: "total_reconciled_balance"
      expr: SUM(CAST(reconciled_balance AS DOUBLE))
      comment: "Total reconciled balance after adjustments."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Count of bank reconciliations performed."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics — tracks acquisition costs, depreciation, net book values, and disposal activity for capital asset management and financial reporting."
  source: "`health_insurance_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (e.g., IT Equipment, Furniture, Leasehold Improvements)."
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Asset subcategory for detailed classification."
    - name: "asset_status"
      expr: asset_status
      comment: "Asset lifecycle status (e.g., Active, Disposed, Fully Depreciated)."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (e.g., Straight Line, Declining Balance)."
    - name: "disposal_status"
      expr: disposal_status
      comment: "Disposal status for asset retirement tracking."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department the asset is assigned to."
    - name: "location_code"
      expr: location_code
      comment: "Physical location code of the asset."
    - name: "asset_condition"
      expr: asset_condition
      comment: "Current condition of the asset."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets — represents capital investment."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — the cumulative depreciation expense recognized."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (cost minus accumulated depreciation) — the carrying value on the balance sheet."
    - name: "total_depreciation_expense"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total current period depreciation expense."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value at end of useful life."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance costs incurred on fixed assets."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Count of fixed assets."
$$;