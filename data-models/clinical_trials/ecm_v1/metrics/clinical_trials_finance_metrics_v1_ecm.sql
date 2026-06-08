-- Metric views for domain: finance | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial accrual metrics tracking financial accrual amounts, variances, and reversal patterns to ensure accurate period-end financial reporting and SOX compliance."
  source: "`clinical_trials_ecm`.`finance`.`accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g., service fee, pass-through, investigator grant)"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual (e.g., posted, pending, reversed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual for period reporting"
    - name: "period"
      expr: period
      comment: "Accounting period within the fiscal year"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the accrual (e.g., units-based, percentage-of-completion)"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the accrual"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether the accrual is a pass-through cost billable to sponsor"
    - name: "is_sox_controlled"
      expr: is_sox_controlled
      comment: "Whether the accrual is subject to SOX internal controls"
    - name: "is_auto_reversal"
      expr: is_auto_reversal
      comment: "Whether the accrual auto-reverses in the next period"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of accrual posting for trend analysis"
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for entity-level reporting"
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount in transaction currency across all accruals"
    - name: "total_accrual_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total accrual amount in USD for standardized cross-currency reporting"
    - name: "total_cumulative_accrual"
      expr: SUM(CAST(cumulative_accrual_amount AS DOUBLE))
      comment: "Sum of cumulative accrual balances for study-level tracking"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between accrued and actual amounts indicating estimation accuracy"
    - name: "avg_accrual_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average accrual amount in USD per accrual entry"
    - name: "total_prior_period_accrual"
      expr: SUM(CAST(prior_period_accrual_amount AS DOUBLE))
      comment: "Total prior period accrual amounts for period-over-period comparison"
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Total number of accrual entries for volume tracking"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across accruals for rate benchmarking"
    - name: "total_supporting_units"
      expr: SUM(CAST(supporting_units AS DOUBLE))
      comment: "Total supporting units (e.g., patient visits, procedures) driving accrual calculations"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics for clinical trial services under ASC 606, tracking recognized revenue, completion percentages, deferred revenue, and unbilled receivables."
  source: "`clinical_trials_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (e.g., percentage-of-completion, milestone-based)"
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition (e.g., recognized, deferred, reversed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for revenue reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "service_line"
      expr: service_line
      comment: "Service line generating revenue (e.g., data management, monitoring, biostatistics)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the study driving revenue"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (I, II, III, IV)"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for revenue"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a revenue reversal entry"
    - name: "recognition_month"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Month of revenue recognition for trend analysis"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center for P&L reporting"
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period under ASC 606"
    - name: "total_recognized_revenue_functional"
      expr: SUM(CAST(recognized_amount_functional AS DOUBLE))
      comment: "Total recognized revenue in functional currency for consolidated reporting"
    - name: "total_cumulative_recognized"
      expr: SUM(CAST(cumulative_recognized_amount AS DOUBLE))
      comment: "Cumulative recognized revenue across all periods for contract-level tracking"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance representing future performance obligations"
    - name: "total_unbilled_receivables"
      expr: SUM(CAST(unbilled_receivable_amount AS DOUBLE))
      comment: "Total unbilled receivables where revenue is recognized but not yet invoiced"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average percentage-of-completion across active contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value for revenue pipeline visibility"
    - name: "recognition_entry_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition entries processed"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_study_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study budget metrics tracking total budgeted amounts, cost composition, and budget health for clinical trial financial planning and sponsor reporting."
  source: "`clinical_trials_ecm`.`finance`.`study_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., draft, approved, amended, closed)"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., original, amendment, change order)"
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget for tracking amendments"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency"
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., direct, indirect, pass-through)"
    - name: "is_sox_controlled"
      expr: is_sox_controlled
      comment: "Whether budget is under SOX controls"
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for entity reporting"
    - name: "budget_effective_month"
      expr: DATE_TRUNC('month', budget_effective_date)
      comment: "Month when budget becomes effective"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across all studies"
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct costs (staff, services) budgeted"
    - name: "total_indirect_cost"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect/overhead costs budgeted"
    - name: "total_pass_through_estimate"
      expr: SUM(CAST(pass_through_estimate_amount AS DOUBLE))
      comment: "Total estimated pass-through costs (labs, imaging, etc.)"
    - name: "total_investigator_grant"
      expr: SUM(CAST(investigator_grant_amount AS DOUBLE))
      comment: "Total investigator grant amounts budgeted for site payments"
    - name: "total_patient_stipend_budget"
      expr: SUM(CAST(patient_stipend_amount AS DOUBLE))
      comment: "Total patient stipend amounts budgeted"
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves for budget risk mitigation"
    - name: "total_overhead"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total overhead amounts allocated to studies"
    - name: "avg_budget_amount"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget size per study for benchmarking"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of study budgets for portfolio sizing"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecasting metrics for clinical trials tracking revenue forecasts, cost forecasts, margins, and variances to support financial planning and sponsor reporting."
  source: "`clinical_trials_ecm`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., quarterly, annual, LRP)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g., draft, submitted, approved)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "forecast_version"
      expr: forecast_version
      comment: "Version of the forecast for tracking revisions"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the forecast (e.g., high, medium, low)"
    - name: "scope_level"
      expr: scope_level
      comment: "Scope of the forecast (e.g., study, program, portfolio)"
    - name: "currency_code"
      expr: currency_code
      comment: "Forecast currency"
    - name: "is_baseline_forecast"
      expr: is_baseline_forecast
      comment: "Whether this is the baseline forecast for variance analysis"
    - name: "forecast_basis"
      expr: forecast_basis
      comment: "Basis for the forecast (e.g., bottom-up, top-down, hybrid)"
    - name: "forecast_period_start"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Start month of the forecast period"
  measures:
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue for the period"
    - name: "total_direct_cost_forecast"
      expr: SUM(CAST(direct_cost_forecast_amount AS DOUBLE))
      comment: "Total forecasted direct costs"
    - name: "total_indirect_cost_forecast"
      expr: SUM(CAST(indirect_cost_forecast_amount AS DOUBLE))
      comment: "Total forecasted indirect costs"
    - name: "total_gross_margin_forecast"
      expr: SUM(CAST(gross_margin_forecast_amount AS DOUBLE))
      comment: "Total forecasted gross margin amount"
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_forecast_pct AS DOUBLE))
      comment: "Average forecasted gross margin percentage across studies"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (forecast vs budget) indicating budget adherence"
    - name: "total_revenue_variance"
      expr: SUM(CAST(revenue_variance_amount AS DOUBLE))
      comment: "Total revenue variance (forecast vs budget) indicating revenue risk"
    - name: "total_cash_inflow_forecast"
      expr: SUM(CAST(cash_inflow_forecast_amount AS DOUBLE))
      comment: "Total forecasted cash inflows for liquidity planning"
    - name: "total_cash_outflow_forecast"
      expr: SUM(CAST(cash_outflow_forecast_amount AS DOUBLE))
      comment: "Total forecasted cash outflows for liquidity planning"
    - name: "total_pass_through_cost_forecast"
      expr: SUM(CAST(pass_through_cost_forecast_amount AS DOUBLE))
      comment: "Total forecasted pass-through costs"
    - name: "avg_milestone_completion_pct"
      expr: AVG(CAST(milestone_completion_pct AS DOUBLE))
      comment: "Average milestone completion percentage for progress tracking"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_sponsor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsor invoicing metrics tracking billing amounts, collections, aging, and payment performance for clinical trial revenue cycle management."
  source: "`clinical_trials_ecm`.`finance`.`sponsor_invoice`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., paid, partial, outstanding, disputed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency"
    - name: "document_type"
      expr: document_type
      comment: "Type of billing document (e.g., invoice, credit memo, debit memo)"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether invoice contains pass-through costs"
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied to this invoice"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms (e.g., Net 30, Net 45, Net 60)"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance for trend analysis"
    - name: "sap_company_code"
      expr: sap_company_code
      comment: "SAP company code for entity-level AR reporting"
  measures:
    - name: "total_gross_invoiced"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount invoiced to sponsors"
    - name: "total_net_invoiced"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount invoiced (after discounts, before tax)"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total payments received from sponsors"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all sponsor invoices"
    - name: "total_pass_through_billed"
      expr: SUM(CAST(pass_through_amount AS DOUBLE))
      comment: "Total pass-through costs billed to sponsors"
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to sponsor invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on sponsor invoices"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of sponsor invoices issued"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount for billing pattern analysis"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice metrics tracking payables, payment processing, and vendor cost management for clinical trial outsourced services."
  source: "`clinical_trials_ecm`.`finance`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice (e.g., received, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of vendor invoice (e.g., standard, credit, prepayment)"
    - name: "service_category"
      expr: service_category
      comment: "Category of service provided (e.g., lab, imaging, CRO, logistics)"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether cost is pass-through billable to sponsor"
    - name: "sponsor_reimbursement_status"
      expr: sponsor_reimbursement_status
      comment: "Status of sponsor reimbursement for pass-through costs"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO-GR-Invoice three-way match status for payment release"
    - name: "accrual_flag"
      expr: accrual_flag
      comment: "Whether invoice has been accrued"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of vendor invoice for AP trend analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., wire, ACH, check)"
  measures:
    - name: "total_gross_payable"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount payable to vendors"
    - name: "total_net_payable"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount payable to vendors"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on vendor invoices"
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discounts available/taken"
    - name: "vendor_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed"
    - name: "avg_vendor_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average vendor invoice amount for cost benchmarking"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoicing in the period"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_site_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigator site payment metrics tracking payment amounts, timeliness, and processing for clinical trial site relationship management and regulatory compliance."
  source: "`clinical_trials_ecm`.`finance`.`site_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., scheduled, approved, paid, on-hold)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of site payment (e.g., per-patient, milestone, startup, closeout)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., wire, check, ACH)"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether payment is a pass-through cost"
    - name: "is_advance_payment"
      expr: is_advance_payment
      comment: "Whether this is an advance/prepayment to the site"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for trend analysis"
    - name: "bank_country_code"
      expr: bank_country_code
      comment: "Country of the receiving bank for geographic analysis"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount to investigator sites"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after withholding taxes"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from site payments"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments in functional currency for consolidated reporting"
    - name: "site_payment_count"
      expr: COUNT(1)
      comment: "Total number of site payments processed"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average site payment amount for benchmarking"
    - name: "distinct_sites_paid"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites receiving payments in the period"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics tracking planned vs actual spending, committed amounts, and budget utilization for granular clinical trial cost management."
  source: "`clinical_trials_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., personnel, pass-through, overhead)"
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost subcategory for granular analysis"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity driving the cost (e.g., monitoring, data management)"
    - name: "line_status"
      expr: line_status
      comment: "Status of the budget line (e.g., active, closed, on-hold)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic budget tracking"
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version for amendment tracking"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether the line item is a pass-through cost"
    - name: "is_milestone_based"
      expr: is_milestone_based
      comment: "Whether payment is milestone-triggered vs time-based"
    - name: "currency_code"
      expr: currency_code
      comment: "Budget line currency"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based budget lines"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned/budgeted amount across all lines"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget lines"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) amount"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued amount on budget lines"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned units/quantity for volume-based budgets"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines for rate analysis"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line items for complexity assessment"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics tracking procurement spend, PO utilization, and vendor management for clinical trial outsourced services and supplies."
  source: "`clinical_trials_ecm`.`finance`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current PO status (e.g., open, partially invoiced, closed, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, blanket, service)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor (e.g., CRO, lab, logistics, technology)"
    - name: "currency_code"
      expr: currency_code
      comment: "PO currency"
    - name: "pass_through_flag"
      expr: pass_through_flag
      comment: "Whether PO costs are pass-through to sponsor"
    - name: "sponsor_billable_flag"
      expr: sponsor_billable_flag
      comment: "Whether PO costs are billable to sponsor"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice receipt status against the PO"
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods/service receipt status"
    - name: "po_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO creation for procurement trend analysis"
  measures:
    - name: "total_po_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net PO value for procurement spend analysis"
    - name: "total_po_gross_amount"
      expr: SUM(CAST(po_gross_amount AS DOUBLE))
      comment: "Total gross PO amount including taxes"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced against POs"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued amount on POs for uninvoiced obligations"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "avg_po_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average PO value for procurement benchmarking"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active POs"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking debit/credit volumes, posting patterns, and financial close activities for clinical trial general ledger management."
  source: "`clinical_trials_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., standard, accrual, reclassification, reversal)"
    - name: "document_type_code"
      expr: document_type_code
      comment: "SAP document type code for entry classification"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for close cycle tracking"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (e.g., posted, parked, held)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for expense classification"
    - name: "is_reversed"
      expr: is_reversed
      comment: "Whether the entry has been reversed"
    - name: "sponsor_billable"
      expr: sponsor_billable
      comment: "Whether the entry relates to sponsor-billable costs"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for trend analysis"
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for entity reporting"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amounts posted"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amounts posted"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total amounts in local currency for entity reporting"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries for close cycle volume tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts in journal entries"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`finance_billing_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing milestone metrics tracking milestone-based revenue triggers, payment collection, and billing pipeline for clinical trial contract management."
  source: "`clinical_trials_ecm`.`finance`.`finance_billing_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the billing milestone (e.g., pending, triggered, invoiced, paid)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., enrollment, database lock, regulatory)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the milestone billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency"
    - name: "is_at_risk"
      expr: is_at_risk
      comment: "Whether milestone is at risk of not being achieved"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether milestone relates to pass-through costs"
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method for the milestone"
    - name: "planned_billing_month"
      expr: DATE_TRUNC('month', planned_billing_date)
      comment: "Planned billing month for pipeline forecasting"
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total billing amount across all milestones"
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount_received AS DOUBLE))
      comment: "Total payments received against billed milestones"
    - name: "total_original_billing_amount"
      expr: SUM(CAST(original_billing_amount AS DOUBLE))
      comment: "Total original billing amounts before amendments"
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total withholding amounts deducted from milestone payments"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued revenue on milestones not yet billed"
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of billing milestones"
    - name: "avg_milestone_billing_amount"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per milestone for contract sizing"
$$;