-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for project budget health, cost variance, contingency utilization, and forecast accuracy. Used by CFOs, project controllers, and PMO leadership to steer budget allocation and identify cost overrun risk."
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping dimension for all budget KPIs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated, enabling multi-currency analysis."
    - name: "project_budget_status"
      expr: project_budget_status
      comment: "Current lifecycle status of the budget record (e.g. Draft, Approved, Closed)."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. equity, debt, client advance) for capital allocation analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the budget record is currently active."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the budget was formally approved — used for time-series trending of approvals."
    - name: "baseline_date"
      expr: baseline_date
      comment: "Date the budget baseline was established — anchors variance calculations."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget across selected projects. Baseline for all cost performance comparisons."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including all approved change orders. Reflects the live authorized spend ceiling."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred to date. Core input for cost performance and overrun detection."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (POs, subcontracts) not yet invoiced. Critical for cash flow and exposure management."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total estimated cost at project completion. Key executive metric for final cost exposure."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve held across projects. Indicates risk buffer available before overrun."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve held. Represents discretionary buffer controlled by senior leadership."
    - name: "total_approved_change_orders"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total value of approved change orders. Tracks scope growth and its budget impact."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between budgeted and actual costs. Negative values signal overrun risk."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Actual cost as a percentage of current approved budget. Values above 100% indicate cost overrun — a primary executive alert metric."
    - name: "contingency_utilization_pct"
      expr: ROUND(100.0 * (SUM(CAST(current_approved_budget AS DOUBLE)) - SUM(CAST(original_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(contingency_reserve_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of contingency reserve consumed by approved change orders. High values signal contingency exhaustion risk."
    - name: "forecast_vs_budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(forecast_at_completion AS DOUBLE)) - SUM(CAST(current_approved_budget AS DOUBLE))) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage by which the forecast at completion exceeds or falls below the current approved budget. Drives executive intervention decisions."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records in scope. Used to normalize per-project averages and assess portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_earned_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) KPIs for construction project cost and schedule performance. Used by project controls, PMO, and executive leadership to assess project health, forecast final costs, and detect performance degradation early."
  source: "`vibe_construction_v1`.`finance`.`earned_value_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for EVM performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EVM record for multi-currency portfolio analysis."
    - name: "earned_value_record_status"
      expr: earned_value_record_status
      comment: "Lifecycle status of the EVM record (e.g. Draft, Approved, Superseded)."
    - name: "eac_calculation_method"
      expr: eac_calculation_method
      comment: "Method used to calculate Estimate at Completion (e.g. CPI-based, ETC re-estimate). Affects forecast reliability interpretation."
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Qualitative confidence level assigned to the EAC forecast (e.g. High, Medium, Low)."
    - name: "data_date"
      expr: data_date
      comment: "The status date of the EVM snapshot — used for time-series trending of performance indices."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start of the reporting period for period-over-period EVM comparison."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End of the reporting period for period-over-period EVM comparison."
    - name: "sap_wbs_element_code"
      expr: sap_wbs_element_code
      comment: "SAP WBS element code for drill-down into work breakdown structure performance."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(bac_budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) — the authorized total budget for all work. Baseline denominator for EVM ratios."
    - name: "total_earned_value"
      expr: SUM(CAST(bcwp_earned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (BCWP / Earned Value). Measures the value of work actually completed."
    - name: "total_planned_value"
      expr: SUM(CAST(bcws_planned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (BCWS / Planned Value). Measures the value of work that should have been done by the data date."
    - name: "total_actual_cost"
      expr: SUM(CAST(acwp_actual_cost AS DOUBLE))
      comment: "Total Actual Cost of Work Performed (ACWP). Measures real spend incurred for completed work."
    - name: "total_estimate_at_completion"
      expr: SUM(CAST(eac_estimate_at_completion AS DOUBLE))
      comment: "Total Estimate at Completion (EAC) — the current best forecast of total project cost. Key executive cost exposure metric."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(etc_estimate_to_complete AS DOUBLE))
      comment: "Total Estimate to Complete (ETC) — remaining cost to finish all work. Drives cash flow and funding decisions."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (CV = EV - AC). Negative values indicate cost overrun across the portfolio."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (SV = EV - PV). Negative values indicate schedule slippage across the portfolio."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(vac_variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (VAC = BAC - EAC). Negative values signal projected final cost overrun."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average Cost Performance Index (CPI = EV/AC). Values below 1.0 indicate cost inefficiency. Critical executive health indicator."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI = EV/PV). Values below 1.0 indicate schedule underperformance."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi_to_complete_performance_index AS DOUBLE))
      comment: "Average To-Complete Performance Index (TCPI). Values significantly above 1.0 indicate the remaining work must be executed far more efficiently than historical performance — a recovery risk signal."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across EVM records. Used to assess overall portfolio progress."
    - name: "eac_vs_bac_overrun_pct"
      expr: ROUND(100.0 * (SUM(CAST(eac_estimate_at_completion AS DOUBLE)) - SUM(CAST(bac_budget_at_completion AS DOUBLE))) / NULLIF(SUM(CAST(bac_budget_at_completion AS DOUBLE)), 0), 2)
      comment: "Percentage by which the current EAC exceeds the original BAC. The primary executive metric for final cost overrun exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational cost transaction KPIs for construction projects. Used by project controllers, finance managers, and operations leadership to monitor actual cost flow, identify cost category concentrations, and manage billable vs. non-billable spend."
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for cost transaction analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost analysis."
    - name: "job_cost_transaction_status"
      expr: job_cost_transaction_status
      comment: "Lifecycle status of the cost transaction (e.g. Posted, Pending, Reversed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the transaction — used to identify unapproved cost exposure."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Boolean indicating whether the cost is billable to the client. Drives revenue recovery analysis."
    - name: "billed_flag"
      expr: billed_flag
      comment: "Boolean indicating whether the billable cost has been invoiced. Identifies unbilled revenue exposure."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Boolean indicating whether the transaction is a reversal entry. Used to assess data quality and correction volume."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction for period-over-period cost trending."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the transaction was posted to the ledger — primary time dimension for cost flow analysis."
    - name: "transaction_date"
      expr: transaction_date
      comment: "Business date of the underlying cost event — used for accrual and cut-off analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the transaction quantity — enables unit rate benchmarking."
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost posted across all job cost transactions. Primary cost accumulation metric for project financial control."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost in base (functional) currency after exchange rate conversion. Enables consistent cross-project cost comparison."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed across transactions. Used for productivity and unit rate benchmarking."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction. Benchmarks resource pricing against budget rates and market rates."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Used to assess transaction volume and normalize per-transaction averages."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost classified as billable to the client. Measures recoverable cost exposure."
    - name: "unbilled_billable_cost"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total billable cost not yet invoiced to the client. Represents unbilled revenue — a critical cash flow and revenue recognition metric."
    - name: "reversal_cost_total"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost in reversal transactions. High values indicate data correction activity or disputed costs."
    - name: "billable_cost_recovery_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billed_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END), 0), 2)
      comment: "Percentage of billable costs that have been invoiced. Low values signal revenue leakage and billing backlog risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and receivable invoice KPIs for construction projects. Used by finance directors, project managers, and treasury to monitor invoice volumes, payment exposure, retention balances, and dispute risk."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for invoice analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice (e.g. Pending, Approved, Rejected)."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean indicating whether the invoice is under dispute. Drives dispute resolution prioritization."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicating whether the invoice is on payment hold. Affects cash flow forecasting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / Invoice). Unmatched invoices represent payment risk and process failure."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for period-over-period payables trending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual payables reporting."
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date — primary time dimension for aging and overdue analysis."
    - name: "received_date"
      expr: received_date
      comment: "Date the invoice was received — used for processing cycle time analysis."
    - name: "approved_date"
      expr: approved_date
      comment: "Date the invoice was approved — used for approval cycle time analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value before discounts and tax. Primary payables exposure metric."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after discounts and retention. Represents actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across invoices. Used for tax liability reporting and compliance."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from invoices. Represents deferred payment obligations to subcontractors and vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in capturing discount opportunities."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices. Used to normalize per-invoice averages and assess processing volume."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High counts signal vendor relationship or quality issues."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross value of disputed invoices. Measures financial exposure from unresolved invoice disputes."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. A key vendor management and procurement quality KPI."
    - name: "three_way_match_failure_amount"
      expr: SUM(CASE WHEN three_way_match_status != 'MATCHED' THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total invoice value where three-way match has not been achieved. Represents payment risk and process control failure exposure."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Used for benchmarking and detecting anomalous invoice sizes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting KPIs for construction projects. Used by CFOs, treasury managers, and project finance teams to monitor liquidity, peak funding requirements, working capital gaps, and forecast accuracy."
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for cash flow analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash flow forecast for multi-currency treasury analysis."
    - name: "cash_flow_forecast_status"
      expr: cash_flow_forecast_status
      comment: "Lifecycle status of the forecast record (e.g. Draft, Approved, Superseded)."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (e.g. Weekly, Monthly, Milestone-based) for granularity analysis."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of the forecast period (e.g. Weekly, Monthly, Quarterly)."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Operational status of the forecast (e.g. Active, Archived, Under Review)."
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile type assigned to the forecast — used to assess spend distribution shape."
    - name: "forecast_period_start_date"
      expr: forecast_period_start_date
      comment: "Start date of the forecast period — primary time dimension for cash flow timeline analysis."
    - name: "forecast_period_end_date"
      expr: forecast_period_end_date
      comment: "End date of the forecast period."
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date the forecast was prepared — used for forecast vintage analysis."
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total forecasted cash inflows (client payments, advances). Primary liquidity source metric."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total forecasted cash outflows (payroll, materials, subcontractors). Primary cash demand metric."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows). Negative values indicate periods of cash deficit requiring financing."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Total peak funding requirement across forecast periods. Drives credit facility sizing and treasury planning."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap across forecast periods. Measures the shortfall between current assets and current liabilities — a critical liquidity risk metric."
    - name: "total_payroll_outflow"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll cash outflow. Largest fixed cost component — used for workforce cost planning."
    - name: "total_subcontractor_payment_outflow"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payment outflow. Key supply chain cash obligation metric."
    - name: "total_material_procurement_outflow"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement cash outflow. Drives procurement scheduling and supplier payment planning."
    - name: "total_retention_release"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention release amounts. Represents deferred cash inflows from milestone completions."
    - name: "avg_credit_facility_utilization_pct"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization percentage across forecast periods. High values signal liquidity stress and covenant risk."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast versions. Measures forecast stability and reliability."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance of actual vs. forecasted cash flows. Measures forecast accuracy — a key treasury process quality metric."
    - name: "closing_cash_balance_total"
      expr: SUM(CAST(closing_cash_balance AS DOUBLE))
      comment: "Sum of closing cash balances across forecast periods. Provides a view of projected cash position trajectory."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing and payment application KPIs for construction projects. Used by project managers, finance directors, and client account teams to monitor billing completeness, outstanding receivables, retention exposure, and payment collection efficiency."
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for billing performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing record for multi-currency receivables analysis."
    - name: "progress_billing_status"
      expr: progress_billing_status
      comment: "Lifecycle status of the billing application (e.g. Submitted, Certified, Paid, Disputed)."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the outstanding balance (e.g. 0-30, 31-60, 61-90, 90+ days). Primary dimension for receivables aging analysis."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the billing application was submitted — used for billing cycle time analysis."
    - name: "certification_date"
      expr: certification_date
      comment: "Date the billing was certified by the client — used for certification cycle time analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Billing cutoff date — used for period-end revenue recognition analysis."
  measures:
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount due across all billing applications. Primary receivables exposure metric."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention and adjustments. Represents actual cash receivable."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received against billing applications. Measures collection effectiveness."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance. A primary executive metric for cash collection risk."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld by the client across all billing applications. Represents deferred receivables requiring milestone completion to release."
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Total value claimed in the current billing period. Measures billing activity and revenue recognition pace."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed. Used for tax compliance and cash flow planning."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average physical percentage complete across billing applications. Measures overall project progress as recognized through billing."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount due that has been collected. A primary cash collection efficiency KPI — low values signal receivables risk."
    - name: "outstanding_balance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Outstanding balance as a percentage of total gross amount due. Measures uncollected receivables concentration."
    - name: "billing_application_count"
      expr: COUNT(1)
      comment: "Total number of billing applications submitted. Used to assess billing activity volume and normalize per-application averages."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution KPIs for construction project disbursements. Used by treasury, accounts payable, and project finance teams to monitor payment volumes, retention releases, reconciliation status, and withholding tax obligations."
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for payment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency disbursement analysis."
    - name: "payment_record_status"
      expr: payment_record_status
      comment: "Lifecycle status of the payment record (e.g. Pending, Cleared, Cancelled)."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment — used for reconciliation and cash position management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment against bank statements. Unreconciled payments represent financial control risk."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the payment was approved — used for approval cycle time analysis."
    - name: "clearing_date"
      expr: clearing_date
      comment: "Date the payment cleared the bank — primary time dimension for cash outflow analysis."
    - name: "reconciliation_date"
      expr: reconciliation_date
      comment: "Date the payment was reconciled — used for reconciliation timeliness analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow metric for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and deductions. Represents actual cash disbursed."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency after exchange rate conversion. Enables consistent cross-currency cash flow reporting."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts released through payments. Measures deferred obligation settlement pace."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Used for tax compliance reporting and vendor net payment analysis."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Measures transaction cost efficiency of payment channels."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in optimizing payment timing."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records. Used to normalize per-payment averages and assess disbursement volume."
    - name: "unreconciled_payment_amount"
      expr: SUM(CASE WHEN reconciliation_status != 'RECONCILED' THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total payment amount not yet reconciled against bank statements. Represents financial control exposure and audit risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per disbursement. Used for anomaly detection and payment pattern benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry KPIs for construction project accounting. Used by controllers, auditors, and finance leadership to monitor posting volumes, intercompany activity, reversal rates, and revenue recognition progress."
  source: "`vibe_construction_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for GL activity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry."
    - name: "journal_entry_status"
      expr: journal_entry_status
      comment: "Lifecycle status of the journal entry (e.g. Draft, Posted, Reversed)."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. Invoice, Payment, Accrual, Reversal) — primary classification dimension."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity and intercompany analysis."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level GL analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for period-end close analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual financial reporting."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the entry was posted to the ledger — primary time dimension for GL activity trending."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Boolean indicating intercompany transactions — used for intercompany elimination analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean indicating whether the entry is a reversal — used for reversal rate and data quality analysis."
    - name: "wbs_element_code"
      expr: wbs_element_code
      comment: "WBS element code for drill-down into work breakdown structure GL activity."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings across journal entries. Used for ledger balance verification and activity volume analysis."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings across journal entries. Used for ledger balance verification."
    - name: "total_local_currency_debit"
      expr: SUM(CAST(local_currency_debit_amount AS DOUBLE))
      comment: "Total debit amount in local (functional) currency. Enables consistent multi-currency GL analysis."
    - name: "total_local_currency_credit"
      expr: SUM(CAST(local_currency_credit_amount AS DOUBLE))
      comment: "Total credit amount in local (functional) currency."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted through journal entries. Used for tax liability reconciliation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries. Used to assess posting volume and normalize per-entry averages."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. High counts relative to total entries indicate data quality issues or excessive accrual corrections."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. A key financial close quality and internal control metric."
    - name: "avg_percentage_of_completion"
      expr: AVG(CAST(percentage_of_completion AS DOUBLE))
      comment: "Average percentage of completion recognized through journal entries. Used for revenue recognition progress monitoring under POC method."
    - name: "intercompany_debit_amount"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN CAST(debit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total debit amount from intercompany journal entries. Used for intercompany reconciliation and elimination in consolidated reporting."
$$;