-- Metric views for domain: finance | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial transaction metrics tracking debits, credits, and account balances across the general ledger for financial reporting and analysis"
  source: "`gaming_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the general ledger transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year for period-over-period analysis"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (asset, liability, equity, revenue, expense) for financial statement classification"
    - name: "document_type"
      expr: document_type
      comment: "Type of financial document (invoice, payment, journal entry, etc.)"
    - name: "business_area"
      expr: business_area
      comment: "Business area or segment for management reporting"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area for operational analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for time-series analysis"
    - name: "document_currency"
      expr: document_currency
      comment: "Currency of the original transaction"
    - name: "reversal_flag"
      expr: reversal_indicator
      comment: "Indicates whether the transaction is a reversal"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across all transactions for balance sheet verification"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across all transactions for balance sheet verification"
    - name: "net_transaction_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net transaction amount (debits minus credits) for account balance calculation"
    - name: "total_group_currency_debit"
      expr: SUM(CAST(group_currency_debit_amount AS DOUBLE))
      comment: "Total debit amount in group reporting currency for consolidated financial statements"
    - name: "total_group_currency_credit"
      expr: SUM(CAST(group_currency_credit_amount AS DOUBLE))
      comment: "Total credit amount in group reporting currency for consolidated financial statements"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of general ledger transactions for volume analysis"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(debit_amount AS DOUBLE) + CAST(credit_amount AS DOUBLE))
      comment: "Average transaction size for transaction pattern analysis"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across transactions for tax reporting and reconciliation"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_title_pl`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game title profit and loss metrics tracking revenue, costs, margins, and profitability KPIs for title-level financial performance management"
  source: "`gaming_ecm`.`finance`.`title_pl`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual performance tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly performance analysis"
    - name: "pl_status"
      expr: pl_status
      comment: "Status of the P&L statement (draft, approved, final)"
    - name: "reporting_currency"
      expr: reporting_currency_code
      comment: "Currency used for financial reporting"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue before platform fees and refunds - primary top-line metric for title performance"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after platform fees, refunds, and chargebacks - key revenue metric for profitability analysis"
    - name: "total_gross_profit"
      expr: SUM(CAST(gross_profit AS DOUBLE))
      comment: "Total gross profit (net revenue minus COGS) - critical margin metric for title viability"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda AS DOUBLE))
      comment: "Total EBITDA (earnings before interest, taxes, depreciation, amortization) - key profitability metric for executive decision-making"
    - name: "total_operating_income"
      expr: SUM(CAST(operating_income AS DOUBLE))
      comment: "Total operating income after all operating expenses - bottom-line profitability metric"
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage - efficiency metric for cost management"
    - name: "avg_operating_margin_pct"
      expr: AVG(CAST(operating_margin_percent AS DOUBLE))
      comment: "Average operating margin percentage - profitability efficiency metric for strategic planning"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fees AS DOUBLE))
      comment: "Total platform fees paid to distribution channels - key cost driver for margin analysis"
    - name: "total_marketing_spend"
      expr: SUM(CAST(total_marketing_spend AS DOUBLE))
      comment: "Total marketing expenditure including UA and brand - critical investment metric for ROI analysis"
    - name: "total_user_acquisition_spend"
      expr: SUM(CAST(user_acquisition_spend AS DOUBLE))
      comment: "Total user acquisition spend - key growth investment metric"
    - name: "total_royalty_expenses"
      expr: SUM(CAST(royalty_expenses AS DOUBLE))
      comment: "Total royalty expenses for licensed IP - critical cost component for licensed titles"
    - name: "avg_arppu"
      expr: AVG(CAST(arppu AS DOUBLE))
      comment: "Average revenue per paying user - key monetization efficiency metric"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user - overall monetization metric for title performance"
    - name: "avg_roi_pct"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average return on investment percentage - critical metric for investment decision-making"
    - name: "total_development_amortization"
      expr: SUM(CAST(development_amortization AS DOUBLE))
      comment: "Total development cost amortization - key non-cash expense for profitability analysis"
    - name: "total_server_hosting_costs"
      expr: SUM(CAST(server_hosting_costs AS DOUBLE))
      comment: "Total server and hosting infrastructure costs - key operational cost for live service titles"
    - name: "title_count"
      expr: COUNT(1)
      comment: "Number of title P&L records for portfolio analysis"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_studio_pl`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Studio-level profit and loss metrics tracking revenue, costs, headcount, and profitability for studio performance management and resource allocation decisions"
  source: "`gaming_ecm`.`finance`.`studio_pl`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual studio performance tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly studio performance"
    - name: "studio_name"
      expr: studio_name
      comment: "Name of the game studio for studio-level analysis"
    - name: "studio_type"
      expr: studio_type
      comment: "Type of studio (internal, external, partner) for portfolio segmentation"
    - name: "studio_status"
      expr: studio_status
      comment: "Operational status of the studio"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for organizational reporting"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional performance analysis"
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the P&L statement (draft, approved, final)"
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total studio revenue across all revenue streams - primary top-line metric for studio performance"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda AS DOUBLE))
      comment: "Total studio EBITDA - key profitability metric for executive resource allocation decisions"
    - name: "total_operating_profit"
      expr: SUM(CAST(operating_profit AS DOUBLE))
      comment: "Total operating profit after all expenses - bottom-line profitability for studio viability assessment"
    - name: "total_gross_profit"
      expr: SUM(CAST(gross_profit AS DOUBLE))
      comment: "Total gross profit before overhead allocation - margin metric for studio efficiency"
    - name: "total_headcount_cost"
      expr: SUM(CAST(headcount_cost AS DOUBLE))
      comment: "Total personnel costs - largest cost driver for studio operations"
    - name: "avg_headcount_fte"
      expr: AVG(CAST(headcount_fte AS DOUBLE))
      comment: "Average full-time equivalent headcount - key capacity metric for resource planning"
    - name: "total_marketing_cost"
      expr: SUM(CAST(marketing_cost AS DOUBLE))
      comment: "Total marketing expenditure - key investment metric for growth"
    - name: "total_outsourcing_cost"
      expr: SUM(CAST(outsourcing_cost AS DOUBLE))
      comment: "Total outsourcing and contractor costs - key variable cost for capacity management"
    - name: "total_infrastructure_cost"
      expr: SUM(CAST(infrastructure_cost AS DOUBLE))
      comment: "Total infrastructure and facilities costs - key fixed cost component"
    - name: "total_royalty_accrual"
      expr: SUM(CAST(royalty_accrual AS DOUBLE))
      comment: "Total royalty accruals for IP licensing - critical cost for licensed content studios"
    - name: "total_depreciation_amortization"
      expr: SUM(CAST(depreciation_amortization AS DOUBLE))
      comment: "Total depreciation and amortization - key non-cash expense for profitability analysis"
    - name: "revenue_per_fte"
      expr: SUM(CAST(total_revenue AS DOUBLE)) / NULLIF(SUM(CAST(headcount_fte AS DOUBLE)), 0)
      comment: "Revenue per full-time equivalent - key productivity metric for studio efficiency"
    - name: "ebitda_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(ebitda AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue AS DOUBLE)), 0), 2)
      comment: "EBITDA margin percentage - critical profitability efficiency metric for strategic decisions"
    - name: "total_qa_testing_cost"
      expr: SUM(CAST(qa_testing_cost AS DOUBLE))
      comment: "Total quality assurance and testing costs - key quality investment metric"
    - name: "total_engine_licensing_revenue"
      expr: SUM(CAST(engine_licensing_revenue AS DOUBLE))
      comment: "Total revenue from game engine licensing - key diversification revenue stream"
    - name: "studio_count"
      expr: COUNT(1)
      comment: "Number of studio P&L records for portfolio analysis"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_deferred_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred revenue liability metrics tracking unearned revenue recognition for subscription, pre-order, and virtual goods transactions critical for revenue forecasting and compliance"
  source: "`gaming_ecm`.`finance`.`deferred_revenue`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue recognition tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue recognition analysis"
    - name: "deferred_revenue_status"
      expr: deferred_revenue_status
      comment: "Status of the deferred revenue liability (active, fully recognized, cancelled)"
    - name: "liability_type"
      expr: liability_type
      comment: "Type of contract liability (subscription, pre-order, season pass, virtual currency)"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (straight-line, usage-based, milestone)"
    - name: "is_subscription"
      expr: is_subscription
      comment: "Flag indicating subscription-based revenue for recurring revenue analysis"
    - name: "is_pre_order"
      expr: is_pre_order
      comment: "Flag indicating pre-order revenue for launch forecasting"
    - name: "purchase_month"
      expr: DATE_TRUNC('MONTH', purchase_date)
      comment: "Month of purchase for cohort analysis"
    - name: "recognition_start_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month when revenue recognition begins"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deferred revenue liability"
  measures:
    - name: "total_initial_liability"
      expr: SUM(CAST(initial_liability_amount AS DOUBLE))
      comment: "Total initial deferred revenue liability - key metric for revenue forecasting and cash flow analysis"
    - name: "total_remaining_liability"
      expr: SUM(CAST(remaining_liability_balance AS DOUBLE))
      comment: "Total remaining unearned revenue liability - critical balance sheet metric for financial reporting"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_to_date AS DOUBLE))
      comment: "Total revenue recognized to date - key metric for revenue realization tracking"
    - name: "recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_revenue_to_date AS DOUBLE)) / NULLIF(SUM(CAST(initial_liability_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of initial liability recognized as revenue - key metric for revenue velocity analysis"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued - key metric for customer satisfaction and revenue quality"
    - name: "avg_liability_amount"
      expr: AVG(CAST(initial_liability_amount AS DOUBLE))
      comment: "Average initial liability per transaction - metric for transaction size analysis"
    - name: "liability_count"
      expr: COUNT(1)
      comment: "Total number of deferred revenue liabilities for volume analysis"
    - name: "active_liability_count"
      expr: COUNT(CASE WHEN deferred_revenue_status = 'active' THEN 1 END)
      comment: "Count of active deferred revenue liabilities - key metric for ongoing obligation tracking"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty statement metrics tracking IP licensing payments, revenue sharing, and royalty obligations for licensed content financial management and partner settlement"
  source: "`gaming_ecm`.`finance`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the royalty statement (draft, approved, paid, disputed)"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of royalty statement (quarterly, annual, ad-hoc)"
    - name: "royalty_tier"
      expr: royalty_tier
      comment: "Royalty tier or bracket for tiered royalty structures"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory or region for geographic royalty analysis"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the statement is under dispute"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for workflow tracking"
    - name: "reporting_period_start"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start of the reporting period for time-series analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty statement"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue subject to royalty calculation - base metric for royalty obligations"
    - name: "total_net_royalty_base"
      expr: SUM(CAST(net_royalty_base_amount AS DOUBLE))
      comment: "Total net royalty base after deductions - key metric for royalty calculation accuracy"
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty amount - primary royalty obligation metric"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after adjustments and recoupment - critical cash flow metric for payment planning"
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment applied - key metric for advance tracking and breakeven analysis"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fees_amount AS DOUBLE))
      comment: "Total platform fees deducted from gross revenue - key deduction component"
    - name: "total_marketing_cost"
      expr: SUM(CAST(marketing_cost_amount AS DOUBLE))
      comment: "Total marketing costs deducted - key deduction for net royalty calculation"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions applied to gross revenue - key metric for royalty base calculation"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments to calculated royalty - metric for variance analysis"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average royalty rate percentage - key metric for royalty structure analysis"
    - name: "effective_royalty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(calculated_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Effective royalty rate as percentage of gross revenue - key metric for royalty burden analysis"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold for volume-based royalty analysis"
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of royalty statements for volume tracking"
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of disputed statements - key metric for dispute management"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_budget_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget version metrics tracking planned vs actual spend, budget utilization, and variance analysis for financial planning and control"
  source: "`gaming_ecm`.`finance`.`budget_version`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly budget analysis"
    - name: "budget_version_status"
      expr: budget_version_status
      comment: "Status of the budget version (draft, approved, active, closed)"
    - name: "version_type"
      expr: version_type
      comment: "Type of budget version (original, forecast, revised)"
    - name: "is_baseline"
      expr: is_baseline
      comment: "Flag indicating the baseline budget version for variance analysis"
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle (annual, quarterly, rolling forecast)"
    - name: "scenario_description"
      expr: scenario_description
      comment: "Budget scenario description for scenario planning"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount across all categories - primary budget metric for financial planning"
    - name: "total_revenue_budget"
      expr: SUM(CAST(revenue_budget_amount AS DOUBLE))
      comment: "Total revenue budget - key top-line planning metric"
    - name: "total_opex_budget"
      expr: SUM(CAST(opex_budget_amount AS DOUBLE))
      comment: "Total operating expense budget - key cost planning metric"
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total capital expenditure budget - key investment planning metric"
    - name: "total_ebitda_budget"
      expr: SUM(CAST(ebitda_budget_amount AS DOUBLE))
      comment: "Total EBITDA budget - key profitability planning metric for executive decision-making"
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average variance threshold percentage - metric for budget control tolerance"
    - name: "budget_version_count"
      expr: COUNT(1)
      comment: "Number of budget versions for version control analysis"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project metrics tracking investment spend, capitalization, amortization, and ROI for capital allocation and asset management decisions"
  source: "`gaming_ecm`.`finance`.`capex_project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (game development, technology, infrastructure)"
    - name: "capitalization_status"
      expr: capitalization_status
      comment: "Status of capitalization (in-progress, capitalized, fully-amortized)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for financial reporting classification"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method of amortization (straight-line, accelerated, usage-based)"
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Flag indicating potential impairment for risk management"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance requirements"
    - name: "capitalization_year"
      expr: YEAR(capitalization_start_date)
      comment: "Year when capitalization began for cohort analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the capital project"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capital budget - key metric for capital allocation planning"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date - key metric for budget utilization tracking"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed but not yet spent - key metric for cash flow forecasting"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining budget available - key metric for budget control"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget utilization percentage - critical metric for capital spend efficiency"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of capitalized assets - key balance sheet metric"
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total accumulated amortization - key metric for asset age and value tracking"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized - key metric for asset quality and risk"
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI percentage - key metric for investment decision-making"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of capital projects for portfolio analysis"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transfers, eliminations, and reconciliation for consolidated financial reporting and transfer pricing compliance"
  source: "`gaming_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany tracking"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (goods, services, royalty, loan)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for workflow tracking"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for intercompany matching"
    - name: "elimination_status"
      expr: elimination_status
      comment: "Elimination status for consolidation reporting"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for cash management"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method for tax compliance"
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Currency of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for time-series analysis"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount - key metric for intercompany volume tracking"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total amount in group reporting currency - key metric for consolidated reporting"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total amount in functional currency - key metric for entity-level reporting"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on intercompany transactions - key metric for tax compliance"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax - key metric for cross-border tax management"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions for volume analysis"
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Count of unreconciled transactions - key metric for reconciliation quality"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction size for transaction pattern analysis"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking overhead distribution, allocation methods, and cost assignment for accurate product costing and profitability analysis"
  source: "`gaming_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost allocation tracking"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method of cost allocation (direct, step-down, reciprocal, activity-based)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (draft, posted, reversed)"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost being allocated (overhead, shared service, support)"
    - name: "allocation_key_name"
      expr: allocation_key_name
      comment: "Name of the allocation key or driver"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversed allocations"
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for management accounting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated - key metric for overhead distribution tracking"
    - name: "total_allocation_base_value"
      expr: SUM(CAST(allocation_base_value AS DOUBLE))
      comment: "Total allocation base value - key metric for allocation driver analysis"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage - metric for allocation distribution analysis"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocations for volume tracking"
$$;