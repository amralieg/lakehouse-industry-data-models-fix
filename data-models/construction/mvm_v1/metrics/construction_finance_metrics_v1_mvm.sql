-- Metric views for domain: finance | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget performance metrics for construction projects. Tracks budget utilization, variance, cost-at-completion forecasting, and contingency consumption — essential for project financial control and executive steering."
  source: "`construction_ecm`.`finance`.`project_budget`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping dimension for all budget KPIs."
    - name: "budget_type"
      expr: budget_type
      comment: "Classifies the budget (e.g. original, revised, supplemental) to distinguish baseline from change-driven budgets."
    - name: "budget_status"
      expr: budget_status
      comment: "Current lifecycle status of the budget record (e.g. approved, draft, closed) for filtering active budgets."
    - name: "phase_id"
      expr: phase_id
      comment: "Project phase associated with this budget line — enables phase-level financial performance analysis."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code dimension for granular cost-category budget analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for this budget — supports organisational financial accountability reporting."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (e.g. equity, debt, government grant) — critical for capital allocation and funding-mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated — required for multi-currency portfolio reporting."
    - name: "budget_period_start_date"
      expr: budget_period_start_date
      comment: "Start of the budget period — used for time-series and period-over-period budget analysis."
    - name: "is_baseline_budget"
      expr: is_baseline_budget
      comment: "Boolean flag identifying the approved baseline budget — enables baseline vs. current budget comparison."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the budget record is currently active."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget across selected projects/phases. Baseline for all variance calculations."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including all approved change orders. Reflects the live authorised spend ceiling."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred to date. Core measure for cost performance and burn-rate analysis."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (purchase orders, subcontracts) not yet invoiced. Critical for cash-flow and exposure management."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total forecast cost at project completion (EAC). Primary executive KPI for predicting final project cost."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between current approved budget and actual cost. Negative values signal cost overrun."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve held across budget lines. Monitors risk buffer availability."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve — discretionary funds held above contingency for unforeseen scope."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total value of approved change orders added to the budget. Tracks scope growth and contract variation impact."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of current approved budget consumed by actual costs. Key executive KPI for spend control — values above 100% indicate overrun."
    - name: "cost_at_completion_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(forecast_at_completion AS DOUBLE)) - SUM(CAST(current_approved_budget AS DOUBLE))) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage variance of forecast-at-completion vs. current approved budget. Positive = projected overrun; negative = projected saving. Critical for early warning."
    - name: "contingency_consumption_pct"
      expr: ROUND(100.0 * (SUM(CAST(current_approved_budget AS DOUBLE)) - SUM(CAST(original_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(contingency_reserve_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of contingency reserve consumed by approved change orders. Signals risk buffer erosion and potential exposure."
    - name: "committed_plus_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) + CAST(committed_cost_amount AS DOUBLE))
      comment: "Total financial exposure combining actual spend and committed obligations. Used for cash-flow forecasting and remaining budget headroom analysis."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular job cost transaction metrics for construction projects. Tracks cost posting volumes, cost categories, billability, and unit economics — the operational heartbeat of project cost control."
  source: "`construction_ecm`.`finance`.`job_cost_transaction`"
  filter: reversal_flag = False
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project associated with the cost transaction — primary grouping for project cost analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. labour, materials, equipment, subcontract) — essential for cost-mix and variance analysis."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Detailed cost code for granular cost breakdown and WBS alignment."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the transaction — supports organisational cost accountability."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the cost transaction (e.g. posted, pending, reversed) — used to filter to confirmed costs."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — distinguishes approved costs from those pending authorisation."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Boolean indicating whether the cost is billable to the client — critical for revenue recovery analysis."
    - name: "billed_flag"
      expr: billed_flag
      comment: "Boolean indicating whether the billable cost has been invoiced — identifies unbilled cost exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency cost consolidation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction — enables period-over-period cost trend analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the cost was posted to the ledger — used for time-series cost burn analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the cost — supports vendor spend concentration and performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis (e.g. m3, hours, tonnes)."
  measures:
    - name: "total_cost_posted"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost posted across all job cost transactions. Primary cost accumulation measure for project financial reporting."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost in base/functional currency after exchange rate conversion. Enables consistent multi-currency cost comparison."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units consumed (hours, materials, etc.). Used for productivity and unit-rate benchmarking."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions posted. Indicates cost posting activity volume and potential processing bottlenecks."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with cost activity. Measures portfolio breadth of cost exposure."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across transactions. Benchmarks cost efficiency and identifies rate anomalies vs. standard rates."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = True THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost flagged as billable to the client. Measures revenue recovery opportunity and client cost exposure."
    - name: "unbilled_billable_cost"
      expr: SUM(CASE WHEN billable_flag = True AND billed_flag = False THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Billable costs not yet invoiced to the client. Critical cash-flow KPI — high values indicate billing lag and working capital risk."
    - name: "billable_cost_recovery_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = True AND billed_flag = True THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CASE WHEN billable_flag = True THEN CAST(total_cost AS DOUBLE) ELSE 0 END), 0), 2)
      comment: "Percentage of billable costs that have been invoiced. Measures billing efficiency — low values signal revenue leakage risk."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across transactions. Monitors FX exposure and rate consistency for multi-currency projects."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics for construction projects. Tracks invoice volumes, payment performance, dispute rates, retention, and tax exposure — critical for cash-flow management and vendor relationship governance."
  source: "`construction_ecm`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project associated with the invoice — primary grouping for project-level AP analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. progress claim, final, retention release) — enables invoice-mix analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. received, approved, paid, disputed) — core dimension for AP aging and workflow analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — distinguishes approved invoices from those pending authorisation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean flag indicating the invoice is under dispute — used to isolate disputed invoice exposure."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean flag indicating the invoice is on payment hold — identifies blocked payment exposure."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor who issued the invoice — enables vendor-level spend and payment performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AP reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. EFT, cheque, SWIFT) — supports payment channel optimisation analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) — used for payment timing compliance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — enables period-over-period AP trend analysis."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued — used for aging and payment cycle time calculations."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / invoice) — critical for AP control and fraud prevention."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value before discounts and tax. Primary AP liability measure."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after discounts and adjustments. Actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax (GST/VAT/withholding) on invoices. Required for tax compliance reporting and cash-flow planning."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices. Tracks retention liability and future release obligations."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures procurement savings from prompt payment."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices. Baseline volume measure for AP workload and processing capacity analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = True THEN 1 END)
      comment: "Number of invoices currently under dispute. High values signal vendor relationship or quality issues."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = True THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross value of disputed invoices. Measures financial exposure from unresolved vendor disputes."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. Executive KPI for vendor quality and AP process health — high rates indicate systemic issues."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Benchmarks invoice size and identifies outliers requiring additional scrutiny."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'MATCHED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match (PO/GR/invoice). Critical internal control KPI — low rates indicate procurement or receiving process failures."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across invoices. Monitors tax rate consistency and flags anomalous tax treatments."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution and cash disbursement metrics. Tracks payment volumes, timing, retention releases, FX costs, and reconciliation status — essential for treasury management and vendor payment governance."
  source: "`construction_ecm`.`finance`.`payment_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project associated with the payment — primary grouping for project-level cash outflow analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. pending, cleared, rejected) — core dimension for payment pipeline monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. progress, retention release, advance, final) — enables payment-mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment channel used (e.g. EFT, SWIFT, cheque) — supports payment channel cost and efficiency analysis."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval workflow status of the payment — identifies payments pending authorisation."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor receiving the payment — enables vendor-level payment performance and concentration analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency — required for multi-currency treasury reporting."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Boolean flag identifying advance payments — tracks mobilisation funding and advance recovery exposure."
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Boolean flag indicating partial payment — identifies invoices with outstanding balances."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status — critical for treasury control and unreconciled payment identification."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status in the general ledger — identifies payments not yet matched to open items."
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was executed — used for payment timing and days-to-pay analysis."
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority assigned to the payment run — supports payment scheduling and cash-flow optimisation."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow measure for treasury reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and deductions. Actual cash disbursed to vendors."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention released to vendors via payment. Tracks retention liability reduction and cash-flow impact."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Required for tax compliance and remittance reporting."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Monitors transaction cost efficiency and banking fee exposure."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured at payment execution. Measures working capital optimisation through prompt payment."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records. Baseline volume measure for payment processing workload."
    - name: "advance_payment_total"
      expr: SUM(CASE WHEN advance_payment_flag = True THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total advance payments disbursed. Tracks mobilisation funding exposure and advance recovery obligations."
    - name: "unreconciled_payment_amount"
      expr: SUM(CASE WHEN reconciliation_status != 'RECONCILED' THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of payments not yet reconciled to bank statements. Critical treasury control KPI — high values indicate reconciliation backlog risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks payment size and identifies outliers requiring additional approval scrutiny."
    - name: "functional_currency_total"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments in functional/reporting currency after FX conversion. Enables consistent cross-currency cash outflow reporting."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_revenue_recognition_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics for construction contracts under percentage-of-completion and IFRS 15 / ASC 606 methods. Tracks recognised revenue, deferred revenue, gross profit, and completion progress — the most critical financial reporting domain for construction."
  source: "`construction_ecm`.`finance`.`revenue_recognition_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for all revenue recognition KPIs."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. percentage-of-completion, completed-contract, milestone) — critical for accounting policy analysis."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Processing status of the recognition entry (e.g. posted, draft, reversed) — used to filter to confirmed recognised revenue."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition entry — enables year-over-year revenue trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period — enables monthly/quarterly revenue recognition trend analysis."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit centre associated with the recognition entry — supports P&L reporting by business unit."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre dimension for organisational revenue attribution."
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency of the underlying contract — required for multi-currency revenue reporting."
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Boolean flag identifying prior-period adjustments — used to isolate restatements from current-period revenue."
    - name: "auditor_reviewed_flag"
      expr: auditor_reviewed_flag
      comment: "Boolean flag indicating auditor review completion — supports audit readiness and financial close governance."
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date revenue was recognised — used for time-series revenue accrual analysis."
  measures:
    - name: "total_revenue_recognised_in_period"
      expr: SUM(CAST(revenue_recognized_in_period AS DOUBLE))
      comment: "Total revenue recognised in the current period. Primary top-line revenue KPI for construction financial reporting."
    - name: "total_revenue_recognised_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Cumulative revenue recognised to date on contracts. Measures total revenue earned vs. contract value."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value (including approved change orders) across selected projects. Measures total revenue backlog and order book."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue AS DOUBLE))
      comment: "Total deferred revenue (billed but not yet earned). Balance sheet liability measure — high values indicate billing ahead of performance."
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue AS DOUBLE))
      comment: "Total unbilled revenue (earned but not yet invoiced). Asset measure — high values indicate billing lag and working capital risk."
    - name: "total_gross_profit_to_date"
      expr: SUM(CAST(gross_profit_to_date AS DOUBLE))
      comment: "Total gross profit recognised to date. Core profitability measure for construction contract performance."
    - name: "total_estimated_gross_profit_at_completion"
      expr: SUM(CAST(estimated_gross_profit_at_completion AS DOUBLE))
      comment: "Total estimated gross profit at project completion. Forward-looking profitability KPI for executive portfolio review."
    - name: "total_loss_provision"
      expr: SUM(CAST(loss_provision AS DOUBLE))
      comment: "Total loss provisions raised on loss-making contracts. Critical risk KPI — any non-zero value requires executive attention and board disclosure."
    - name: "total_cumulative_costs_incurred"
      expr: SUM(CAST(cumulative_costs_incurred AS DOUBLE))
      comment: "Total cumulative costs incurred on contracts. Used as the denominator in percentage-of-completion calculations."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average percentage of completion across contracts. Portfolio-level progress indicator for revenue recognition timing."
    - name: "avg_gross_profit_percentage"
      expr: AVG(CAST(gross_profit_percentage AS DOUBLE))
      comment: "Average gross profit margin percentage across contracts. Executive KPI for portfolio profitability benchmarking."
    - name: "revenue_to_contract_value_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_recognized_to_date AS DOUBLE)) / NULLIF(SUM(CAST(contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value recognised as revenue to date. Measures revenue realisation progress across the portfolio."
    - name: "total_change_order_value_included"
      expr: SUM(CAST(change_order_value_included AS DOUBLE))
      comment: "Total change order value included in revenue recognition. Tracks scope growth impact on recognised revenue and contract profitability."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing and client receivables metrics for construction contracts. Tracks billing performance, collection efficiency, retention exposure, and outstanding balances — critical for working capital management and client cash-flow."
  source: "`construction_ecm`.`finance`.`progress_billing`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for all progress billing KPIs."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the billing application (e.g. submitted, certified, paid, overdue) — core dimension for AR aging analysis."
    - name: "payment_certificate_type"
      expr: payment_certificate_type
      comment: "Type of payment certificate (e.g. interim, final, retention release) — enables billing-type mix analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (e.g. current, 30-60 days, 60-90 days, 90+ days) — critical for collections prioritisation and credit risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency — required for multi-currency AR reporting."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre associated with the billing — supports organisational AR attribution."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of the billing period — used for period-over-period billing trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the billing record — used for data lineage and reconciliation."
  measures:
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount due from clients across all billing applications. Primary AR balance measure."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention and tax adjustments. Actual receivable balance for cash-flow forecasting."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received from clients against billing applications. Measures collection performance."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance not yet collected. Critical working capital KPI — high values indicate collection risk."
    - name: "total_retention_held"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld by clients. Tracks client-side retention liability and future cash inflow from retention releases."
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Total value of current period billing claims submitted. Measures billing activity and revenue claim velocity."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Total cumulative value of work completed and certified to date. Measures contract execution progress in financial terms."
    - name: "total_scheduled_value"
      expr: SUM(CAST(scheduled_value AS DOUBLE))
      comment: "Total scheduled contract value across billing applications. Baseline for percentage-complete and billing coverage analysis."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount due that has been collected. Primary AR collection efficiency KPI — low values signal client payment risk."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage completion across billing applications. Portfolio-level progress indicator for billing coverage analysis."
    - name: "billing_count"
      expr: COUNT(1)
      comment: "Total number of billing applications submitted. Measures billing activity volume and administrative workload."
    - name: "total_materials_stored_on_site"
      expr: SUM(CAST(materials_stored_on_site AS DOUBLE))
      comment: "Total value of materials stored on site included in billing. Tracks inventory-based billing exposure and site asset value."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting and liquidity metrics for construction projects. Tracks inflow/outflow projections, working capital gaps, peak funding requirements, and forecast accuracy — essential for treasury planning and project financing decisions."
  source: "`construction_ecm`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for all cash flow forecast KPIs."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. base case, optimistic, pessimistic) — enables scenario comparison analysis."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g. draft, approved, superseded) — used to filter to current approved forecasts."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of the forecast (e.g. weekly, monthly, quarterly) — enables appropriate aggregation level selection."
    - name: "currency_code"
      expr: currency_code
      comment: "Forecast currency — required for multi-currency treasury reporting."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre associated with the forecast — supports organisational cash flow attribution."
    - name: "phase_id"
      expr: phase_id
      comment: "Project phase — enables phase-level cash flow planning and S-curve analysis."
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile type applied to the forecast — used for cash flow shape analysis and front/back-loading assessment."
    - name: "forecast_period_start_date"
      expr: forecast_period_start_date
      comment: "Start of the forecast period — used for time-series cash flow projection analysis."
    - name: "forecast_version"
      expr: forecast_version
      comment: "Version of the forecast — enables version-over-version forecast evolution tracking."
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total forecasted cash inflows (client payments, milestone receipts). Primary revenue cash-flow planning measure."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total forecasted cash outflows (subcontractors, materials, payroll). Primary cost cash-flow planning measure."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows). Core liquidity KPI — negative values indicate funding requirement periods."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Total peak funding requirement across forecast periods. Critical for credit facility sizing and project financing decisions."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap (funding shortfall). Measures liquidity risk and credit facility utilisation need."
    - name: "avg_credit_facility_utilization"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilisation percentage across forecast periods. Monitors debt headroom and refinancing risk."
    - name: "avg_bonding_capacity_utilization"
      expr: AVG(CAST(bonding_capacity_utilization AS DOUBLE))
      comment: "Average bonding capacity utilisation. Tracks surety bond headroom — critical for bidding on new projects."
    - name: "total_payroll_outflow"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll cash outflow. Largest recurring cost component — critical for workforce cost planning."
    - name: "total_subcontractor_payment_outflow"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payment outflow. Typically the largest single cost category on construction projects."
    - name: "total_material_procurement_outflow"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement outflow. Tracks supply chain cash demand and procurement timing."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast versions. Measures forecast accuracy and stability — high variance signals planning uncertainty."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance of actual vs. forecast cash flows. Key forecast quality KPI for treasury governance."
    - name: "total_retention_release_inflow"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention release inflows. Tracks expected cash receipts from retention held by clients — important for project close-out planning."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for construction financial reporting. Tracks posting volumes, debit/credit balances, intercompany activity, tax postings, and percentage-of-completion accounting — supports financial close governance and audit readiness."
  source: "`construction_ecm`.`finance`.`journal_entry`"
  filter: reversal_indicator = False
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project associated with the journal entry — primary grouping for project-level GL analysis."
    - name: "document_type"
      expr: document_type
      comment: "GL document type (e.g. SA, KR, DR) — classifies the nature of the journal entry for audit and reporting."
    - name: "entry_status"
      expr: entry_status
      comment: "Processing status of the journal entry (e.g. posted, parked, reversed) — used to filter to confirmed postings."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — enables year-over-year GL trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period — enables monthly financial close and period-end reporting."
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code — enables legal entity-level financial reporting and intercompany elimination."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre dimension for organisational GL analysis."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit centre — supports P&L reporting by business unit."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Boolean flag identifying intercompany journal entries — used for intercompany elimination and related-party reporting."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied (e.g. POC, completed-contract) — critical for accounting policy compliance monitoring."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the journal entry was posted — used for financial close timing and period-cut analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry — required for multi-currency GL reporting."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings in transaction currency. Core GL balance measure for financial reporting."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings in transaction currency. Core GL balance measure — should equal total debits for a balanced ledger."
    - name: "total_local_currency_debit"
      expr: SUM(CAST(local_currency_debit_amount AS DOUBLE))
      comment: "Total debit postings in local/functional currency. Required for statutory financial reporting."
    - name: "total_local_currency_credit"
      expr: SUM(CAST(local_currency_credit_amount AS DOUBLE))
      comment: "Total credit postings in local/functional currency. Required for statutory financial reporting."
    - name: "total_tax_posted"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries. Required for tax compliance reporting and VAT/GST reconciliation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Measures GL posting volume and financial close workload."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = True THEN 1 END)
      comment: "Number of intercompany journal entries. Monitors intercompany transaction volume for elimination and related-party disclosure."
    - name: "avg_percentage_of_completion"
      expr: AVG(CAST(percentage_of_completion AS DOUBLE))
      comment: "Average percentage of completion recorded on journal entries. Monitors POC accounting consistency across projects."
    - name: "net_gl_balance"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net GL balance (debits minus credits) in transaction currency. A non-zero aggregate signals an unbalanced ledger — critical audit control KPI."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit centre financial performance metrics for construction business units. Tracks revenue, EBIT, EBITDA, profit margins, and budget utilisation — the primary P&L reporting layer for executive and board-level financial governance."
  source: "`construction_ecm`.`finance`.`profit_center`"
  filter: profit_center_status = 'ACTIVE'
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code — enables legal entity-level P&L reporting and consolidation."
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of the profit centre (e.g. project, region, division) — enables organisational P&L segmentation."
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type classification of the profit centre — supports business unit type analysis."
    - name: "profit_center_level"
      expr: profit_center_level
      comment: "Hierarchy level of the profit centre — enables roll-up P&L reporting at different organisational levels."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Active/inactive status of the profit centre — used to filter to reporting-active entities."
    - name: "region"
      expr: region
      comment: "Geographic region of the profit centre — enables regional P&L performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency of the profit centre — required for multi-currency P&L consolidation."
    - name: "financial_reporting_standard"
      expr: financial_reporting_standard
      comment: "Accounting standard applied (e.g. IFRS, US GAAP) — critical for multi-standard reporting environments."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Boolean flag indicating whether the profit centre is included in group consolidation."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency (e.g. monthly, quarterly) — used for report scheduling and period alignment."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total revenue across profit centres. Top-line financial performance measure for executive reporting."
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Total actual profit (net income) across profit centres. Bottom-line financial performance KPI."
    - name: "total_ebit"
      expr: SUM(CAST(ebit AS DOUBLE))
      comment: "Total Earnings Before Interest and Tax. Standard operating profitability measure used in executive and board reporting."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda AS DOUBLE))
      comment: "Total Earnings Before Interest, Tax, Depreciation and Amortisation. Primary cash earnings proxy used in construction industry valuation and covenant compliance."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold (direct project costs). Used to derive gross margin and assess cost efficiency."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted profit/revenue across profit centres. Baseline for budget vs. actual variance analysis."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across profit centres. Portfolio-level profitability benchmark — key executive KPI for construction margin management."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across profit centres. Monitors tax efficiency and identifies jurisdictions with anomalous tax burdens."
    - name: "ebit_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(ebit AS DOUBLE)) / NULLIF(SUM(CAST(revenue AS DOUBLE)), 0), 2)
      comment: "EBIT margin as a percentage of revenue. Core operating profitability ratio — primary KPI for construction business unit performance benchmarking."
    - name: "budget_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_profit AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Actual profit as a percentage of budgeted profit. Measures financial plan achievement — values below 100% trigger management intervention."
$$;