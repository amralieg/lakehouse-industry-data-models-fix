-- Metric views for domain: finance | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue recognition, collections performance, and aging analysis for guest and corporate billing"
  source: "`travel_hospitality_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., open, paid, disputed, written off)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., room, group, event, corporate)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category for outstanding receivables (e.g., current, 30-60 days, 60-90 days, 90+ days)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating recovery efforts and likelihood"
    - name: "billing_entity_type"
      expr: billing_entity_type
      comment: "Type of billing entity (e.g., individual, corporate, travel agent)"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice issuance"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when invoice payment is due"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the invoice has been written off as uncollectible"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed amount across all invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance not yet collected"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected from invoices"
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue billed on invoices"
    - name: "total_fnb_revenue"
      expr: SUM(CAST(fnb_revenue_amount AS DOUBLE))
      comment: "Total food and beverage revenue billed on invoices"
    - name: "total_event_revenue"
      expr: SUM(CAST(event_revenue_amount AS DOUBLE))
      comment: "Total event and meeting revenue billed on invoices"
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue_amount AS DOUBLE))
      comment: "Total ancillary revenue (spa, parking, resort fees, etc.) billed on invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on invoices"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount successfully collected (paid / total billed)"
    - name: "avg_days_outstanding"
      expr: AVG(CAST(days_outstanding AS DOUBLE))
      comment: "Average number of days invoices remain outstanding"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices currently under dispute"
    - name: "write_off_count"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices written off as uncollectible"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount per invoice"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor payment obligations, cash flow management, and procurement spend analysis"
  source: "`travel_hospitality_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g., pending, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., goods, services, utilities, rent)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for the invoice"
    - name: "expense_category"
      expr: expense_category
      comment: "Category of expense (e.g., operating supplies, maintenance, professional services)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with vendor (e.g., Net 30, Net 60, Due on Receipt)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match validation (PO, goods receipt, invoice)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "invoice_year_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when invoice payment is due"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether this is a recurring invoice"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to vendors"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total amount still owed to vendors"
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoices paid (paid / net amount)"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of potential discounts captured through early payment"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices under dispute with vendors"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking accounting activity, posting volume, and financial close performance"
  source: "`travel_hospitality_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Status of journal entry posting (e.g., draft, posted, reversed)"
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., standard, accrual, reversal, adjustment)"
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the journal entry"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry"
    - name: "posting_year_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of journal entry posting"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the journal entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates whether this is an intercompany transaction"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether this entry reverses a prior entry"
    - name: "capex_indicator"
      expr: capex_indicator
      comment: "Indicates whether this entry relates to capital expenditure"
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency for the journal entry"
  measures:
    - name: "total_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries"
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries"
    - name: "net_balance"
      expr: SUM((CAST(debit_amount AS DOUBLE)) - (CAST(credit_amount AS DOUBLE)))
      comment: "Net balance (debits minus credits) - should be zero for balanced entries"
    - name: "posted_entry_count"
      expr: SUM(CASE WHEN posting_status = 'posted' THEN 1 ELSE 0 END)
      comment: "Count of journal entries successfully posted to the general ledger"
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal journal entries"
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intercompany journal entries requiring elimination"
    - name: "capex_entry_count"
      expr: SUM(CASE WHEN capex_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of capital expenditure journal entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line item metrics tracking planned spend, budget utilization, and variance analysis for financial planning and control"
  source: "`travel_hospitality_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, project)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget line (e.g., labor, supplies, utilities, marketing)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the budget"
    - name: "department_code"
      expr: department_code
      comment: "Department code responsible for the budget line"
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget (e.g., original, revised, forecast)"
    - name: "locked_flag"
      expr: locked_flag
      comment: "Indicates whether the budget line is locked from further changes"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget across periods or entities"
  measures:
    - name: "total_budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all line items"
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend for comparison"
    - name: "yoy_budget_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(planned_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Year-over-year budget growth percentage compared to prior year actuals"
    - name: "avg_planned_amount"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line"
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage for budget monitoring"
    - name: "approved_budget_line_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of budget lines that have been approved"
    - name: "locked_budget_line_count"
      expr: SUM(CASE WHEN locked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budget lines locked from further changes"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_management_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel management fee metrics tracking operator compensation under management contracts, fee calculation accuracy, and profitability impact"
  source: "`travel_hospitality_ecm`.`finance`.`management_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of management fee (e.g., base, incentive, technical services)"
    - name: "fee_status"
      expr: fee_status
      comment: "Status of the fee (e.g., calculated, approved, paid, disputed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the management fee"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the fee"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for fee calculation (e.g., gross revenue, GOP, NOI)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the management fee"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the management fee"
    - name: "calculation_year_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month when the fee was calculated"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates whether this is an intercompany management fee"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether this fee reverses a prior fee"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the fee is denominated"
  measures:
    - name: "total_fee_count"
      expr: COUNT(1)
      comment: "Total number of management fee records"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total management fee amount before adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments to management fees"
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net management fee amount after adjustments"
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total basis amount used for fee calculation (e.g., total revenue, GOP)"
    - name: "effective_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(basis_amount AS DOUBLE)), 0), 2)
      comment: "Effective management fee rate as percentage of basis amount"
    - name: "avg_fee_rate_pct"
      expr: AVG(CAST(fee_rate_percentage AS DOUBLE))
      comment: "Average contractual fee rate percentage"
    - name: "avg_fee_amount"
      expr: AVG(CAST(net_fee_amount AS DOUBLE))
      comment: "Average net management fee amount per record"
    - name: "paid_fee_count"
      expr: SUM(CASE WHEN payment_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Count of management fees that have been paid"
    - name: "reversal_fee_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of management fee reversals"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Owner distribution metrics tracking cash flow to property owners, reserve contributions, and net operating income distribution under hotel ownership structures"
  source: "`travel_hospitality_ecm`.`finance`.`owner_distribution`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the owner distribution (e.g., calculated, approved, paid, disputed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the distribution"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the distribution"
    - name: "calculation_year_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month when the distribution was calculated"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment to owner (e.g., wire, ACH, check)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the distribution is under dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the distribution is denominated"
  measures:
    - name: "total_distribution_count"
      expr: COUNT(1)
      comment: "Total number of owner distribution records"
    - name: "total_distribution_amount"
      expr: SUM(CAST(distribution_amount AS DOUBLE))
      comment: "Total cash distributed to property owners"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue for the distribution period"
    - name: "total_gop"
      expr: SUM(CAST(gop_amount AS DOUBLE))
      comment: "Total gross operating profit for the distribution period"
    - name: "total_noi"
      expr: SUM(CAST(noi_amount AS DOUBLE))
      comment: "Total net operating income for the distribution period"
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses for the distribution period"
    - name: "total_base_mgmt_fee"
      expr: SUM(CAST(base_management_fee_amount AS DOUBLE))
      comment: "Total base management fees deducted from owner distributions"
    - name: "total_incentive_mgmt_fee"
      expr: SUM(CAST(incentive_management_fee_amount AS DOUBLE))
      comment: "Total incentive management fees deducted from owner distributions"
    - name: "total_ffe_reserve_contribution"
      expr: SUM(CAST(ffe_reserve_contribution_amount AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment reserve contributions"
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service payments deducted from distributions"
    - name: "total_property_tax"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax payments deducted from distributions"
    - name: "distribution_to_revenue_pct"
      expr: ROUND(100.0 * SUM(CAST(distribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Owner distribution as percentage of gross revenue"
    - name: "distribution_to_noi_pct"
      expr: ROUND(100.0 * SUM(CAST(distribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(noi_amount AS DOUBLE)), 0), 2)
      comment: "Owner distribution as percentage of net operating income"
    - name: "gop_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gop_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Gross operating profit margin percentage"
    - name: "noi_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(noi_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Net operating income margin percentage"
    - name: "avg_distribution_amount"
      expr: AVG(CAST(distribution_amount AS DOUBLE))
      comment: "Average distribution amount per record"
    - name: "disputed_distribution_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of distributions under dispute"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital asset lifecycle, depreciation expense, net book value, and asset disposal performance for property plant and equipment management"
  source: "`travel_hospitality_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., active, disposed, impaired, under construction)"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of fixed asset (e.g., building, furniture, equipment, vehicles)"
    - name: "asset_class"
      expr: asset_class
      comment: "Accounting class of the asset for depreciation purposes"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used to depreciate the asset (e.g., straight-line, declining balance)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (e.g., sale, trade-in, scrap, donation)"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired"
    - name: "acquisition_year_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month the asset was acquired"
    - name: "disposal_year_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month the asset was disposed"
    - name: "ffe_reserve_eligible"
      expr: ffe_reserve_eligible
      comment: "Indicates whether the asset is eligible for FF&E reserve funding"
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Indicates whether the asset has been impaired"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the asset is valued"
    - name: "capex_approval_status"
      expr: capex_approval_status
      comment: "Approval status of the capital expenditure request for this asset"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all fixed assets (acquisition cost minus accumulated depreciation)"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of all assets"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds received from asset disposals"
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss recognized on asset disposals"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized on assets"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across all assets"
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset"
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Overall depreciation rate as percentage of acquisition cost"
    - name: "disposed_asset_count"
      expr: SUM(CASE WHEN disposal_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of assets that have been disposed"
    - name: "impaired_asset_count"
      expr: SUM(CASE WHEN impairment_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets that have been impaired"
    - name: "ffe_eligible_asset_count"
      expr: SUM(CASE WHEN ffe_reserve_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets eligible for FF&E reserve funding"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account metrics tracking cash positions, account balances, reconciliation status, and treasury management performance"
  source: "`travel_hospitality_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g., active, closed, dormant)"
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., checking, savings, money market, payroll)"
    - name: "account_purpose"
      expr: account_purpose
      comment: "Business purpose of the account (e.g., operating, payroll, reserve, escrow)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account is denominated"
    - name: "is_primary_account"
      expr: is_primary_account
      comment: "Indicates whether this is the primary operating account"
    - name: "is_zero_balance_account"
      expr: is_zero_balance_account
      comment: "Indicates whether this is a zero-balance account (ZBA)"
    - name: "interest_bearing"
      expr: interest_bearing
      comment: "Indicates whether the account earns interest"
    - name: "electronic_banking_enabled"
      expr: electronic_banking_enabled
      comment: "Indicates whether electronic banking is enabled"
    - name: "positive_pay_enabled"
      expr: positive_pay_enabled
      comment: "Indicates whether positive pay fraud prevention is enabled"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all bank accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available balance across all bank accounts"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance when accounts were established"
    - name: "total_last_statement_balance"
      expr: SUM(CAST(last_statement_balance AS DOUBLE))
      comment: "Total balance from most recent bank statements"
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Total minimum balance requirements across all accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across interest-bearing accounts"
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active bank accounts"
    - name: "reconciled_account_count"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Count of bank accounts that are fully reconciled"
    - name: "interest_bearing_account_count"
      expr: SUM(CASE WHEN interest_bearing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts that earn interest"
    - name: "positive_pay_enabled_count"
      expr: SUM(CASE WHEN positive_pay_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with positive pay fraud prevention enabled"
$$;