-- Metric views for domain: finance | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial transaction metrics tracking debits, credits, and net transaction values across cost centers, profit centers, and GL accounts for financial reporting and variance analysis"
  source: "`shipping_ports_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "posting_key"
      expr: posting_key
      comment: "Posting key indicating debit or credit transaction type"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment reporting and profitability analysis"
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area for operational expense categorization"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the original transaction for multi-currency reporting"
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency for consolidated financial statements"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the entry is a reversal transaction"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', baseline_date)
      comment: "Month of posting for monthly financial close analysis"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', baseline_date)
      comment: "Quarter of posting for quarterly financial reporting"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entry lines for balance sheet verification"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entry lines for balance sheet verification"
    - name: "net_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Net transaction amount representing the financial impact of journal entries"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax liability tracking and compliance reporting"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax for vendor payment and tax authority remittance tracking"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of journal entry line items for transaction volume analysis"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per journal entry line for transaction size analysis"
    - name: "distinct_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of unique GL accounts touched for chart of accounts utilization analysis"
    - name: "distinct_cost_centres"
      expr: COUNT(DISTINCT cost_centre_id)
      comment: "Number of unique cost centers for cost allocation breadth analysis"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal transactions for error rate and correction tracking"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor payment obligations, aging, and cash flow management for working capital optimization"
  source: "`shipping_ports_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP analysis and budgeting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AP close and accrual tracking"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status for payment workflow and approval tracking"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Invoice type for expense categorization and procurement analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for treasury operations and bank reconciliation"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for cash flow forecasting and vendor negotiation analysis"
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category for spend analysis and budget variance reporting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency AP management and FX exposure analysis"
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block indicator for exception management and dispute resolution"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for monthly spend trending"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due for cash flow planning"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes for total spend visibility"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts for actual payment obligation"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding payable amount for working capital and liquidity management"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to vendors for cash outflow tracking"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured for early payment discount realization tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for input tax credit and VAT recovery analysis"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax for tax authority remittance and compliance"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices for vendor transaction volume analysis"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average invoice amount for spend pattern and vendor relationship analysis"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors for supplier diversity and concentration risk analysis"
    - name: "payment_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoice amount paid for payment completion tracking"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics tracking customer payment performance, aging, and collection effectiveness for cash conversion cycle optimization"
  source: "`shipping_ports_ecm`.`finance`.`receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AR analysis and revenue recognition"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR close and DSO tracking"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for overdue receivables analysis and collection prioritization"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status for payment receipt and cash application tracking"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level AR and revenue analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency AR management and FX exposure"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Dispute flag for customer dispute resolution and credit management"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Write-off flag for bad debt tracking and credit loss provisioning"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level for collection escalation and customer communication tracking"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for monthly revenue and AR trending"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due for cash collection forecasting"
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount for revenue recognition and AR balance tracking"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivable amount for working capital and liquidity management"
    - name: "total_posting_amount"
      expr: SUM(CAST(posting_amount AS DOUBLE))
      comment: "Total posting amount for financial statement reconciliation"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for output tax liability and VAT reporting"
    - name: "total_cash_discount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total cash discount offered for early payment incentive cost tracking"
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Number of receivable line items for transaction volume and billing frequency analysis"
    - name: "avg_receivable_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average receivable amount per transaction for customer transaction size analysis"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customer accounts for customer base and concentration risk analysis"
    - name: "disputed_receivables_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed receivables for dispute resolution effectiveness tracking"
    - name: "written_off_count"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of written-off receivables for bad debt rate and credit quality analysis"
    - name: "collection_rate"
      expr: ROUND(100.0 * (SUM(CAST(net_amount AS DOUBLE)) - SUM(CAST(outstanding_amount AS DOUBLE))) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of receivables collected for collection effectiveness measurement"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking planned vs actual spend, commitments, and variance analysis for financial control and resource allocation decisions"
  source: "`shipping_ports_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget planning and performance tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget monitoring and variance reporting"
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for CAPEX vs OPEX classification and spend analysis"
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type for operational vs strategic budget differentiation"
    - name: "budget_status"
      expr: budget_status
      comment: "Budget status for approval workflow and budget lock tracking"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for budget authorization and governance compliance"
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area for departmental budget allocation and accountability"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit for divisional budget performance and P&L responsibility"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency budget management and consolidation"
    - name: "is_carry_forward"
      expr: is_carry_forward
      comment: "Carry-forward flag for multi-year budget tracking and unspent budget analysis"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount for budget allocation and resource planning"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget for budget consumption tracking"
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed amount for encumbrance tracking and budget availability"
    - name: "total_available_budget"
      expr: SUM(CAST(available_budget AS DOUBLE))
      comment: "Total available budget remaining for spend authorization and control"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance for over/under spend analysis and corrective action"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line items for budget granularity and complexity analysis"
    - name: "avg_planned_amount"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line for budget sizing analysis"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget utilized for budget execution effectiveness"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(commitment_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed for pipeline visibility and forecast accuracy"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage for budget accuracy and forecasting quality assessment"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation, and asset utilization for capital allocation decisions and asset lifecycle management"
  source: "`shipping_ports_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Asset status for active vs retired asset tracking and lifecycle management"
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for asset class reporting and investment portfolio analysis"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for detailed asset classification and depreciation policy application"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for accounting policy compliance and tax optimization"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level asset allocation and ROA analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency asset valuation and consolidation"
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for capital structure analysis and grant tracking"
    - name: "is_leased"
      expr: is_leased
      comment: "Lease flag for owned vs leased asset differentiation and IFRS 16 compliance"
    - name: "acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of acquisition for vintage analysis and capital investment trending"
    - name: "capitalization_year"
      expr: DATE_TRUNC('YEAR', capitalization_date)
      comment: "Year of capitalization for asset activation and depreciation start tracking"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets for capital investment tracking"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation for asset age and book value calculation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets for balance sheet reporting and asset base valuation"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment losses for asset quality and write-down analysis"
    - name: "total_revaluation_reserve"
      expr: SUM(CAST(revaluation_reserve AS DOUBLE))
      comment: "Total revaluation reserve for fair value accounting and equity reporting"
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total grant funding received for government assistance and subsidy tracking"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value for risk management and insurance coverage adequacy"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed assets for asset portfolio size and complexity tracking"
    - name: "avg_useful_life"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years for asset longevity and replacement planning"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset for capital intensity and investment sizing"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of asset cost depreciated for asset age and replacement urgency assessment"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work breakdown structure project metrics tracking capital project performance, cost control, and investment ROI for strategic capital allocation decisions"
  source: "`shipping_ports_ecm`.`finance`.`wbs_element`"
  dimensions:
    - name: "wbs_status"
      expr: wbs_status
      comment: "WBS status for project lifecycle stage and completion tracking"
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "WBS element type for project vs phase vs task differentiation"
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase for stage-gate analysis and milestone tracking"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category for project risk assessment and mitigation prioritization"
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for capital structure and grant utilization tracking"
    - name: "strategic_objective"
      expr: strategic_objective
      comment: "Strategic objective for portfolio alignment and strategic value realization"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for project authorization and governance compliance"
    - name: "is_revenue_generating"
      expr: is_revenue_generating
      comment: "Revenue-generating flag for ROI classification and payback analysis"
    - name: "environmental_impact_assessment_required"
      expr: environmental_impact_assessment_required
      comment: "EIA requirement flag for regulatory compliance and sustainability tracking"
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year of planned start for project pipeline and resource planning"
  measures:
    - name: "total_planned_capex"
      expr: SUM(CAST(planned_capex_budget AS DOUBLE))
      comment: "Total planned capital expenditure for capital budgeting and allocation"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual project cost for spend tracking and budget consumption"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost for encumbrance tracking and forecast accuracy"
    - name: "total_forecast_final_cost"
      expr: SUM(CAST(forecast_final_cost AS DOUBLE))
      comment: "Total forecast final cost for project completion cost estimation and variance projection"
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance AS DOUBLE))
      comment: "Total budget variance for cost overrun identification and corrective action"
    - name: "total_expected_annual_revenue"
      expr: SUM(CAST(expected_annual_revenue AS DOUBLE))
      comment: "Total expected annual revenue from projects for ROI and payback calculation"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of WBS elements for project portfolio size and complexity tracking"
    - name: "avg_planned_capex"
      expr: AVG(CAST(planned_capex_budget AS DOUBLE))
      comment: "Average planned CAPEX per project for investment sizing and portfolio mix"
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_capex_budget AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Cost performance index (planned/actual) for project cost efficiency measurement"
    - name: "budget_overrun_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_variance AS DOUBLE)) / NULLIF(SUM(CAST(planned_capex_budget AS DOUBLE)), 0), 2)
      comment: "Percentage budget variance for cost control effectiveness and forecasting accuracy"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking overhead distribution, cross-charging, and cost transparency for accurate profitability analysis and transfer pricing"
  source: "`shipping_ports_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation and overhead rate analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost allocation and P&L accuracy"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Allocation type for direct vs indirect cost classification"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for posting completion and financial close tracking"
    - name: "allocation_basis_type"
      expr: allocation_basis_type
      comment: "Allocation basis type for cost driver transparency and methodology audit"
    - name: "business_area"
      expr: business_area
      comment: "Business area for segment-level cost allocation and profitability"
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for management accounting and internal reporting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency cost allocation and consolidation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal flag for allocation correction and restatement tracking"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for monthly cost allocation trending"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated for overhead distribution and full-cost visibility"
    - name: "total_sender_original_cost"
      expr: SUM(CAST(sender_original_cost_amount AS DOUBLE))
      comment: "Total original cost from sender cost centers for allocation reconciliation"
    - name: "total_allocation_basis_quantity"
      expr: SUM(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Total allocation basis quantity for cost driver volume tracking"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation transactions for allocation complexity and volume"
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocated amount per transaction for allocation sizing analysis"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage for cost distribution pattern analysis"
    - name: "distinct_sender_cost_centres"
      expr: COUNT(DISTINCT primary_sender_cost_centre_id)
      comment: "Number of unique sender cost centers for overhead source diversity"
    - name: "distinct_receiver_profit_centres"
      expr: COUNT(DISTINCT receiver_profit_centre_id)
      comment: "Number of unique receiver profit centers for cost absorption breadth"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed allocations for allocation accuracy and error rate tracking"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provision and contingent liability metrics tracking financial risk exposure, obligation estimation, and reserve adequacy for risk management and financial statement accuracy"
  source: "`shipping_ports_ecm`.`finance`.`provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual provision analysis and reserve trending"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly provision movement and financial close"
    - name: "provision_type"
      expr: provision_type
      comment: "Provision type for risk categorization and reserve policy application"
    - name: "provision_category"
      expr: provision_category
      comment: "Provision category for financial statement classification and disclosure"
    - name: "provision_status"
      expr: provision_status
      comment: "Provision status for lifecycle tracking and settlement monitoring"
    - name: "probability_assessment"
      expr: probability_assessment
      comment: "Probability assessment for likelihood classification and reserve sizing"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Estimation method for valuation approach transparency and audit trail"
    - name: "contingent_liability_flag"
      expr: contingent_liability_flag
      comment: "Contingent liability flag for off-balance-sheet risk disclosure"
    - name: "disclosure_required_flag"
      expr: disclosure_required_flag
      comment: "Disclosure requirement flag for financial statement note preparation"
    - name: "recognition_year"
      expr: DATE_TRUNC('YEAR', recognition_date)
      comment: "Year of recognition for provision vintage and aging analysis"
  measures:
    - name: "total_current_provision"
      expr: SUM(CAST(current_provision_amount AS DOUBLE))
      comment: "Total current provision amount for balance sheet liability and reserve adequacy"
    - name: "total_original_provision"
      expr: SUM(CAST(original_provision_amount AS DOUBLE))
      comment: "Total original provision amount for reserve movement and reassessment tracking"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding obligation amount for unsettled liability exposure"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled amount for provision utilization and release tracking"
    - name: "total_discount_unwinding"
      expr: SUM(CAST(discount_unwinding_amount AS DOUBLE))
      comment: "Total discount unwinding for time-value adjustment and interest expense"
    - name: "total_reimbursement_amount"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement for insurance recovery and third-party contribution"
    - name: "total_undiscounted_amount"
      expr: SUM(CAST(undiscounted_amount AS DOUBLE))
      comment: "Total undiscounted obligation for gross exposure and discount impact analysis"
    - name: "provision_count"
      expr: COUNT(1)
      comment: "Number of provisions for risk portfolio size and complexity tracking"
    - name: "avg_provision_amount"
      expr: AVG(CAST(current_provision_amount AS DOUBLE))
      comment: "Average provision amount for risk sizing and materiality assessment"
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_provision_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original provision settled for reserve accuracy and estimation quality"
$$;