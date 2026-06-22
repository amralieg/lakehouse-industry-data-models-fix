-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic project budget performance metrics tracking budget utilization, variance, and forecast accuracy across construction projects. Used by CFOs and project controllers to steer cost performance."
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for budget segmentation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (equity, debt, client advance, etc.)"
    - name: "project_budget_status"
      expr: project_budget_status
      comment: "Current lifecycle status of the budget record"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether this budget record is currently active"
    - name: "revision_number"
      expr: revision_number
      comment: "Budget revision number for tracking budget evolution over time"
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget amount across projects. Baseline for all cost performance analysis."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including all approved change orders. Reflects the live authorized spend ceiling."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred to date. Core cost performance indicator for project controllers."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (POs, subcontracts) not yet invoiced. Critical for cash flow and exposure management."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve held across projects. Indicates risk buffer available to absorb overruns."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total forecast cost at completion (EAC). The primary forward-looking cost metric for executive reporting."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (approved budget minus actual cost). Negative values signal cost overrun risk."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total value of approved change orders added to the original budget. Tracks scope growth impact on cost."
    - name: "avg_budget_utilization_rate"
      expr: AVG(ROUND(100.0 * actual_cost_amount / NULLIF(current_approved_budget, 0), 2))
      comment: "Average budget utilization rate (actual cost as % of approved budget) per budget record. Flags projects burning budget faster than planned."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve held. Represents discretionary contingency controlled by senior management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_earned_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) performance metrics providing schedule and cost performance indices, variance analysis, and completion forecasts. Essential for project health dashboards and executive steering."
  source: "`vibe_construction_v1`.`finance`.`earned_value_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for EVM performance segmentation"
    - name: "data_date"
      expr: data_date
      comment: "Data date (status date) for the EVM snapshot — used for time-series trending"
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start of the reporting period for period-over-period EVM analysis"
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End of the reporting period for period-over-period EVM analysis"
    - name: "eac_calculation_method"
      expr: eac_calculation_method
      comment: "Method used to calculate Estimate at Completion (EAC) — e.g. CPI-based, ETC re-estimate"
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (draft, approved, locked)"
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level assigned to the EAC forecast (high/medium/low)"
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(bac_budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) — the total authorized budget for all work. Denominator for all EVM ratios."
    - name: "total_earned_value"
      expr: SUM(CAST(bcwp_earned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (BCWP / Earned Value). Measures the value of work actually completed."
    - name: "total_planned_value"
      expr: SUM(CAST(bcws_planned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (BCWS / Planned Value). Measures the value of work that should have been done."
    - name: "total_actual_cost"
      expr: SUM(CAST(acwp_actual_cost AS DOUBLE))
      comment: "Total Actual Cost of Work Performed (ACWP). The real spend incurred for completed work."
    - name: "total_estimate_at_completion"
      expr: SUM(CAST(eac_estimate_at_completion AS DOUBLE))
      comment: "Total Estimate at Completion (EAC) — the forecasted total project cost. Key executive cost forecast metric."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(etc_estimate_to_complete AS DOUBLE))
      comment: "Total Estimate to Complete (ETC) — remaining cost to finish all work. Drives cash flow and funding decisions."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (EV minus AC). Negative values indicate cost overrun — triggers management intervention."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (EV minus PV). Negative values indicate schedule slippage — triggers recovery planning."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(vac_variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (BAC minus EAC). Negative values signal projected overrun at project end."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average Cost Performance Index (CPI = EV/AC). Values below 1.0 indicate cost inefficiency requiring corrective action."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI = EV/PV). Values below 1.0 indicate schedule underperformance."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi_to_complete_performance_index AS DOUBLE))
      comment: "Average To-Complete Performance Index (TCPI). Values above 1.2 indicate the remaining work must be done significantly more efficiently — a key risk signal."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across EVM records. Used to assess overall portfolio progress."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job cost transaction metrics providing granular cost tracking by project, cost category, and time period. Used by project controllers and CFOs to monitor actual spend against budget and identify cost anomalies."
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for cost transaction segmentation"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date the cost transaction occurred — used for period cost trending"
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date for the transaction — used for financial period reporting"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost transaction (pending, approved, rejected)"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the cost is billable to the client — drives revenue recovery analysis"
    - name: "billed_flag"
      expr: billed_flag
      comment: "Whether the cost has already been billed — identifies unbilled cost exposure"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this transaction is a reversal entry — used to identify correction activity"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the cost transaction (hours, tonnes, m3, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency code"
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total job cost across all transactions. Primary cost accumulation metric for project cost control."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost in base/functional currency. Used for consolidated financial reporting across multi-currency projects."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed. Used for productivity and unit rate analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction. Benchmarked against budget unit rates to identify cost efficiency trends."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Volume indicator for cost posting activity and audit trail completeness."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN total_cost ELSE 0 END)
      comment: "Total billable cost. Represents recoverable costs that should be invoiced to the client."
    - name: "unbilled_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN total_cost ELSE 0 END)
      comment: "Total billable but not yet billed cost. Represents revenue at risk if not invoiced promptly."
    - name: "reversal_cost_total"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN total_cost ELSE 0 END)
      comment: "Total cost in reversal transactions. High reversal volumes indicate data quality or approval process issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing and payment application metrics tracking revenue recognition, collection performance, and billing cycle efficiency. Critical for cash flow management and client relationship health."
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for billing performance segmentation"
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency code"
    - name: "progress_billing_status"
      expr: progress_billing_status
      comment: "Current status of the progress billing (draft, submitted, certified, paid)"
    - name: "submission_date"
      expr: submission_date
      comment: "Date the billing application was submitted to the client"
    - name: "certification_date"
      expr: certification_date
      comment: "Date the payment was certified by the engineer/client"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for outstanding billing (current, 30-60, 60-90, 90+ days)"
  measures:
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount due across all progress billings. Top-line revenue billing metric."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention and deductions. Actual cash expected from client."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received against progress billings. Measures collection effectiveness."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance. Key liquidity risk indicator for the CFO."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld by client. Represents deferred cash that will be released at practical completion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on progress billings. Required for tax compliance reporting."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average physical completion percentage across billing applications. Tracks overall project progress for billing purposes."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Collection rate as percentage of gross billed amount received. Below 90% signals collection risk requiring escalation."
    - name: "retention_rate_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across billings. Tracks contractual retention terms compliance."
    - name: "billing_count"
      expr: COUNT(1)
      comment: "Total number of progress billing applications submitted. Measures billing cycle activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_accounts_receivable_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection, and dispute metrics. Used by the CFO and treasury team to manage working capital, identify overdue receivables, and track dispute resolution."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for AR segmentation"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute — used to segment clean vs. disputed AR"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency code"
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date for aging and overdue analysis"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoiced amount. Top-line AR balance metric."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld on AR invoices. Deferred cash requiring active release management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices. Required for VAT/GST compliance reporting."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High counts indicate contract administration or quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting metrics tracking projected inflows, outflows, net cash position, and working capital gaps. Used by CFO and treasury to manage liquidity and funding requirements."
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for cash flow segmentation"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (baseline, revised, scenario)"
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of the forecast (weekly, monthly, quarterly)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, approved, superseded)"
    - name: "forecast_period_start_date"
      expr: forecast_period_start_date
      comment: "Start of the forecast period for time-series cash flow analysis"
    - name: "forecast_period_end_date"
      expr: forecast_period_end_date
      comment: "End of the forecast period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash flow forecast"
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile indicator for spend pattern analysis (front-loaded, back-loaded, uniform)"
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total forecasted cash inflows (client payments, advances). Primary revenue cash metric."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total forecasted cash outflows (payroll, materials, subcontractors). Primary cost cash metric."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows). Negative values indicate funding gap requiring action."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Total peak funding requirement across forecast periods. Drives credit facility sizing decisions."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap. Quantifies the financing shortfall that must be covered by credit lines or equity."
    - name: "total_subcontractor_payment_amount"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payments. Largest single outflow category in construction — critical for supply chain liquidity."
    - name: "total_payroll_amount"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll outflows. Fixed obligation that must be met regardless of client payment timing."
    - name: "total_material_procurement_amount"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement outflows. Drives procurement scheduling and supplier payment terms."
    - name: "total_retention_release_amount"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention release inflows. Represents deferred cash recovery at project milestones."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast. High variance indicates forecast instability requiring process improvement."
    - name: "avg_credit_facility_utilization"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization rate. Above 80% triggers treasury alert for additional facility headroom."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_revenue_recognition_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking percentage-of-completion, deferred revenue, and gross profit performance under IFRS 15 / ASC 606. Used by CFO and auditors to ensure compliant revenue reporting."
  source: "`vibe_construction_v1`.`finance`.`revenue_recognition_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for revenue recognition segmentation"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (percentage-of-completion, milestone, completed contract)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period revenue reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue reporting"
    - name: "recognition_period"
      expr: recognition_period
      comment: "Recognition period label for revenue schedule analysis"
    - name: "revenue_recognition_entry_status"
      expr: revenue_recognition_entry_status
      comment: "Status of the revenue recognition entry (draft, posted, audited)"
    - name: "auditor_reviewed_flag"
      expr: auditor_reviewed_flag
      comment: "Whether the entry has been reviewed by the auditor — used for audit completeness tracking"
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Whether this entry includes a prior period adjustment — flags restatement risk"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all recognition entries. Top-line revenue backlog metric."
    - name: "total_revenue_recognized_in_period"
      expr: SUM(CAST(revenue_recognized_in_period AS DOUBLE))
      comment: "Total revenue recognized in the current period. Primary P&L revenue metric for construction."
    - name: "total_revenue_recognized_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Cumulative revenue recognized to date. Measures revenue earned against total contract value."
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue AS DOUBLE))
      comment: "Total unbilled revenue (earned but not yet invoiced). Represents cash conversion opportunity."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue AS DOUBLE))
      comment: "Total deferred revenue (billed but not yet earned). Liability on the balance sheet requiring monitoring."
    - name: "total_cumulative_costs_incurred"
      expr: SUM(CAST(cumulative_costs_incurred AS DOUBLE))
      comment: "Total cumulative costs incurred to date. Used as the denominator in cost-to-cost percentage-of-completion."
    - name: "total_estimated_total_costs"
      expr: SUM(CAST(estimated_total_costs AS DOUBLE))
      comment: "Total estimated costs at completion. Used to compute gross profit at completion."
    - name: "total_estimated_gross_profit_at_completion"
      expr: SUM(CAST(estimated_gross_profit_at_completion AS DOUBLE))
      comment: "Total estimated gross profit at project completion. Key profitability forecast metric for the CFO."
    - name: "total_loss_provision"
      expr: SUM(CAST(loss_provision AS DOUBLE))
      comment: "Total loss provision on onerous contracts. Signals projects requiring immediate management intervention."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average physical completion percentage across projects. Drives revenue recognition timing under POC method."
    - name: "avg_gross_profit_percentage"
      expr: AVG(CAST(gross_profit_percentage AS DOUBLE))
      comment: "Average gross profit margin percentage. Below-target margins trigger cost reduction or contract renegotiation."
    - name: "total_change_order_value_included"
      expr: SUM(CAST(change_order_value_included AS DOUBLE))
      comment: "Total change order value included in revenue recognition. Tracks scope growth impact on recognized revenue."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commitment management metrics tracking financial obligations (POs, subcontracts, LOIs) against budget. Used by project controllers and CFOs to manage cost exposure and cash flow obligations."
  source: "`vibe_construction_v1`.`finance`.`commitment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for commitment segmentation"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (purchase order, subcontract, letter of intent, rental agreement)"
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category of commitment (labor, material, equipment, subcontract, overhead)"
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (draft, approved, active, closed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for commitment period analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Commitment currency code"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the commitment is confidential — used for access control in reporting"
    - name: "is_retention"
      expr: is_retention
      comment: "Whether the commitment includes retention terms"
  measures:
    - name: "total_amount_committed"
      expr: SUM(CAST(amount_committed AS DOUBLE))
      comment: "Total committed amount across all commitments. Represents the full financial obligation exposure of the project."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across commitments. Tracks subcontractor/vendor retention terms compliance."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of commitments. Volume indicator for procurement and contracting activity."
    - name: "active_commitment_count"
      expr: COUNT(CASE WHEN commitment_status = 'active' THEN 1 END)
      comment: "Number of currently active commitments. Measures live financial obligation count."
    - name: "total_committed_with_retention"
      expr: SUM(CASE WHEN is_retention = TRUE THEN amount_committed ELSE 0 END)
      comment: "Total committed amount on contracts with retention terms. Identifies deferred payment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention ledger metrics tracking withheld retention balances, release schedules, and DLP (Defects Liability Period) exposure. Critical for cash flow planning and contract closeout management."
  source: "`vibe_construction_v1`.`finance`.`finance_retention_ledger`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for retention segmentation"
    - name: "retention_type"
      expr: retention_type
      comment: "Type of retention (performance, DLP, advance recovery)"
    - name: "retention_status"
      expr: retention_status
      comment: "Current status of the retention (held, partially released, fully released)"
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Trigger for retention release (practical completion, DLP expiry, milestone)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the retention is under dispute"
    - name: "retention_bond_indicator"
      expr: retention_bond_indicator
      comment: "Whether a retention bond has been provided in lieu of cash retention"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for retention period analysis"
    - name: "dlp_end_date"
      expr: dlp_end_date
      comment: "DLP end date — used to forecast retention release timing"
  measures:
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_withheld_amount AS DOUBLE))
      comment: "Total retention withheld across all ledger entries. Represents cash held back from contractors/subcontractors."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total retention released to date. Measures progress toward full retention recovery."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Total cumulative retention balance outstanding. Key balance sheet liability metric for construction."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross invoice amount underlying the retention ledger entries. Context for retention rate analysis."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied. Benchmarked against contract terms to identify over/under-retention."
    - name: "disputed_retention_total"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN cumulative_retention_balance ELSE 0 END)
      comment: "Total retention balance under dispute. Quantifies cash at risk from retention disputes."
    - name: "retention_bond_count"
      expr: COUNT(CASE WHEN retention_bond_indicator = TRUE THEN 1 END)
      comment: "Number of retention entries covered by a retention bond. Tracks bond-in-lieu-of-cash arrangements."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor payment obligations, dispute rates, and three-way match compliance. Used by the finance team to manage payables, cash outflows, and vendor relationships."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for AP invoice segmentation"
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status (pending, approved, rejected, on-hold)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Whether the invoice is on payment hold"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (matched, unmatched, partial) — compliance control for AP processing"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency code"
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date for payment scheduling"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for AP period reporting"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Primary payables obligation metric."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable after discounts and deductions. Actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Required for input tax credit and compliance reporting."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld on AP invoices. Deferred payment obligation to vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in optimizing payment timing."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of AP invoices under dispute. High counts indicate procurement or delivery quality issues."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'unmatched' THEN 1 END)
      comment: "Number of invoices failing three-way match. Compliance risk indicator requiring AP team intervention."
    - name: "on_hold_amount_total"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total amount on payment hold. Quantifies delayed payment exposure and vendor relationship risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution metrics tracking payment volumes, withholding tax, bank charges, and reconciliation status. Used by treasury and AP teams to monitor payment efficiency and compliance."
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for payment segmentation"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency code"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status (reconciled, unreconciled, in-progress)"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Payment clearing status in the banking system"
    - name: "approval_date"
      expr: approval_date
      comment: "Date the payment was approved — used for payment cycle time analysis"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount executed. Primary cash outflow metric for treasury reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and deductions. Actual cash disbursed."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Required for tax authority remittance reporting."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Cost of payment processing — benchmarked for treasury efficiency."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld in payment records. Tracks deferred payment obligations to vendors."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency. Used for consolidated financial reporting across currencies."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records executed. Volume metric for payment processing capacity planning."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'unreconciled' THEN 1 END)
      comment: "Number of unreconciled payments. High counts indicate bank reconciliation backlog and control risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget revision metrics tracking scope changes, cost escalations, and budget amendment patterns. Used by project controls and CFO to understand budget evolution and change order impact."
  source: "`vibe_construction_v1`.`finance`.`finance_budget_revision`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for budget revision segmentation"
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (change order, scope adjustment, escalation, contingency draw)"
    - name: "revision_reason_code"
      expr: revision_reason_code
      comment: "Reason code for the budget revision — used to categorize root causes of budget changes"
    - name: "revision_status"
      expr: revision_status
      comment: "Status of the revision (pending, approved, rejected)"
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Whether client approval is required for this revision — tracks client-facing budget change exposure"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget revision"
    - name: "approved_date"
      expr: approved_date
      comment: "Date the revision was approved — used for approval cycle time analysis"
  measures:
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total budget revision amount across all revisions. Measures cumulative scope and cost growth."
    - name: "total_original_budget_amount"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget amount before revisions. Baseline for measuring budget growth."
    - name: "total_revised_budget_amount"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget amount after all approved changes. Current authorized budget ceiling."
    - name: "total_labor_cost_revision"
      expr: SUM(CAST(labor_cost_revision AS DOUBLE))
      comment: "Total labor cost revision amount. Identifies labor escalation as a driver of budget growth."
    - name: "total_material_cost_revision"
      expr: SUM(CAST(material_cost_revision AS DOUBLE))
      comment: "Total material cost revision amount. Identifies material price escalation impact on budget."
    - name: "total_subcontractor_cost_revision"
      expr: SUM(CAST(subcontractor_cost_revision AS DOUBLE))
      comment: "Total subcontractor cost revision amount. Tracks subcontract scope growth and claims impact."
    - name: "total_contingency_revision"
      expr: SUM(CAST(contingency_revision AS DOUBLE))
      comment: "Total contingency revision amount. Tracks drawdown or replenishment of contingency reserves."
    - name: "avg_evm_cpi_impact"
      expr: AVG(CAST(evm_cpi_impact AS DOUBLE))
      comment: "Average CPI impact of budget revisions. Measures how budget changes affect cost performance index."
    - name: "revision_count"
      expr: COUNT(1)
      comment: "Total number of budget revisions. High revision counts indicate poor initial estimating or scope instability."
$$;