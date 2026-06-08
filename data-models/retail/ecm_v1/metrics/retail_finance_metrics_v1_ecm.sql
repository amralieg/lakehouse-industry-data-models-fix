-- Metric views for domain: finance | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue, collections, aging, and customer payment performance"
  source: "`retail_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (open, paid, disputed, written off)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (standard, credit memo, debit memo)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the invoice"
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Revenue recognition status per ASC 606"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for time-series analysis"
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of due date for aging analysis"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding receivable amount not yet collected"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied from customer payments"
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected (applied / net)"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount written off as bad debt"
    - name: "discount_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cash_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount discounted through early payment"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with invoices"
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN 1 END)
      comment: "Number of invoices currently in dispute"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor payments, cash flow, and procurement efficiency"
  source: "`retail_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (pending, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, debit memo)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (ACH, wire, check)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms negotiated with vendor"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block code if payment is held"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for time-series analysis"
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of due date for cash flow planning"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount payable to vendors"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount disputed with vendors"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured through early payment"
    - name: "chargeback_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoice amount disputed as chargebacks"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with invoices"
    - name: "edi_invoice_count"
      expr: COUNT(CASE WHEN is_edi_received = TRUE THEN 1 END)
      comment: "Number of invoices received via EDI"
    - name: "edi_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_edi_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices received electronically via EDI"
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN 1 END)
      comment: "Number of invoices with payment blocks"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volume, adjustments, and financial close activity"
  source: "`retail_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document"
    - name: "entry_type"
      expr: entry_type
      comment: "Entry type (manual, automatic, recurring)"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the journal entry"
    - name: "source_module"
      expr: source_module
      comment: "Source system module that generated the entry"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator"
    - name: "is_accrual"
      expr: accrual_indicator
      comment: "Whether the entry is an accrual"
    - name: "is_intercompany"
      expr: intercompany_indicator
      comment: "Whether the entry is intercompany"
    - name: "is_reversal"
      expr: reversal_indicator
      comment: "Whether the entry is a reversal"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for time-series analysis"
  measures:
    - name: "total_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries"
    - name: "total_document_amount"
      expr: SUM(CAST(document_amount AS DOUBLE))
      comment: "Total document amount in document currency"
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total amount in local currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(local_amount AS DOUBLE))
      comment: "Average journal entry amount in local currency"
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'manual' THEN 1 END)
      comment: "Number of manual journal entries"
    - name: "manual_entry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN entry_type = 'manual' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are manual (automation opportunity metric)"
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries that are reversals (error rate proxy)"
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries"
    - name: "accrual_entry_count"
      expr: COUNT(CASE WHEN accrual_indicator = TRUE THEN 1 END)
      comment: "Number of accrual journal entries"
    - name: "unique_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of unique GL accounts with activity"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers with activity"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget and forecast metrics tracking plan vs actual performance, variance analysis, and financial planning accuracy"
  source: "`retail_ecm`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget (revenue, expense, capex)"
    - name: "plan_version_type"
      expr: plan_version_type
      comment: "Type of plan version (budget, forecast, reforecast)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget"
    - name: "channel"
      expr: channel
      comment: "Sales or distribution channel"
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used for forecasting"
    - name: "is_reforecast"
      expr: is_reforecast
      comment: "Whether this is a reforecast"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the budget is locked from changes"
  measures:
    - name: "total_budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual amount incurred"
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted amount"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount (encumbrances)"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between plan and actual"
    - name: "total_revenue_projection"
      expr: SUM(CAST(revenue_projection AS DOUBLE))
      comment: "Total projected revenue"
    - name: "total_cogs_projection"
      expr: SUM(CAST(cogs_projection AS DOUBLE))
      comment: "Total projected cost of goods sold"
    - name: "total_ebitda_projection"
      expr: SUM(CAST(ebitda_projection AS DOUBLE))
      comment: "Total projected EBITDA"
    - name: "total_gross_margin_projection"
      expr: SUM(CAST(gross_margin_projection AS DOUBLE))
      comment: "Total projected gross margin"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget utilized (actual / planned)"
    - name: "forecast_accuracy_pct"
      expr: ROUND(100.0 * (1.0 - ABS(SUM(CAST(actual_amount AS DOUBLE)) - SUM(CAST(forecast_amount AS DOUBLE))) / NULLIF(SUM(CAST(actual_amount AS DOUBLE)), 0)), 2)
      comment: "Forecast accuracy percentage (100% minus absolute error rate)"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers with budgets"
    - name: "unique_profit_centers"
      expr: COUNT(DISTINCT profit_center_id)
      comment: "Number of unique profit centers with budgets"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation, and asset lifecycle management"
  source: "`retail_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for categorization"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance)"
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (book, tax, IFRS)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of the asset"
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Whether the asset has impairment indicators"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all assets"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years"
    - name: "avg_depreciation_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(accumulated_depreciation AS DOUBLE) / NULLIF(CAST(acquisition_cost AS DOUBLE), 0)), 2)
      comment: "Average depreciation rate as percentage of acquisition cost"
    - name: "asset_turnover_ratio"
      expr: ROUND(SUM(CAST(disposal_proceeds AS DOUBLE)) / NULLIF(SUM(CAST(net_book_value AS DOUBLE)), 0), 2)
      comment: "Asset turnover ratio (disposal proceeds / net book value)"
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator_flag = TRUE THEN 1 END)
      comment: "Number of assets with impairment indicators"
    - name: "impairment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impairment_indicator_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets with impairment indicators"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors supplying assets"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_lease_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease contract metrics tracking ASC 842 compliance, right-of-use assets, lease liabilities, and lease portfolio management"
  source: "`retail_ecm`.`finance`.`lease_contract`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease contract"
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (operating, finance)"
    - name: "leased_asset_category"
      expr: leased_asset_category
      comment: "Category of leased asset (real estate, equipment, vehicle)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease contract"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments"
    - name: "lessor_name"
      expr: lessor_name
      comment: "Name of the lessor"
    - name: "short_term_lease_flag"
      expr: short_term_lease_flag
      comment: "Whether the lease is short-term (12 months or less)"
    - name: "low_value_asset_flag"
      expr: low_value_asset_flag
      comment: "Whether the lease is for a low-value asset"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the lease has a renewal option"
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Whether the lease has a purchase option"
    - name: "variable_lease_payment_flag"
      expr: variable_lease_payment_flag
      comment: "Whether the lease has variable payment components"
  measures:
    - name: "total_lease_count"
      expr: COUNT(1)
      comment: "Total number of lease contracts"
    - name: "total_rou_asset_initial_value"
      expr: SUM(CAST(rou_asset_initial_value AS DOUBLE))
      comment: "Total initial right-of-use asset value"
    - name: "total_rou_asset_carrying_value"
      expr: SUM(CAST(rou_asset_carrying_value AS DOUBLE))
      comment: "Total current carrying value of right-of-use assets"
    - name: "total_lease_liability_initial"
      expr: SUM(CAST(lease_liability_initial AS DOUBLE))
      comment: "Total initial lease liability"
    - name: "total_lease_liability_balance"
      expr: SUM(CAST(lease_liability_balance AS DOUBLE))
      comment: "Total current lease liability balance"
    - name: "total_base_rent_monthly"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE))
      comment: "Total monthly base rent across all leases"
    - name: "total_initial_direct_cost"
      expr: SUM(CAST(initial_direct_cost AS DOUBLE))
      comment: "Total initial direct costs incurred"
    - name: "total_lease_incentive_amount"
      expr: SUM(CAST(lease_incentive_amount AS DOUBLE))
      comment: "Total lease incentives received"
    - name: "avg_incremental_borrowing_rate"
      expr: AVG(CAST(incremental_borrowing_rate AS DOUBLE))
      comment: "Average incremental borrowing rate across leases"
    - name: "avg_weighted_remaining_term"
      expr: AVG(CAST(weighted_avg_remaining_term AS DOUBLE))
      comment: "Average weighted remaining lease term in years"
    - name: "lease_liability_coverage_ratio"
      expr: ROUND(SUM(CAST(rou_asset_carrying_value AS DOUBLE)) / NULLIF(SUM(CAST(lease_liability_balance AS DOUBLE)), 0), 2)
      comment: "Ratio of ROU asset value to lease liability (asset coverage)"
    - name: "short_term_lease_count"
      expr: COUNT(CASE WHEN short_term_lease_flag = TRUE THEN 1 END)
      comment: "Number of short-term leases"
    - name: "low_value_lease_count"
      expr: COUNT(CASE WHEN low_value_asset_flag = TRUE THEN 1 END)
      comment: "Number of low-value asset leases"
    - name: "unique_lessors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique lessors"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking ASC 606 compliance, performance obligation satisfaction, and deferred revenue management"
  source: "`retail_ecm`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue"
    - name: "asc606_step"
      expr: asc606_step
      comment: "ASC 606 five-step model step"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of recognition"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of recognition"
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Whether the contract was modified"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the recognition was reversed"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month of revenue recognition start"
  measures:
    - name: "total_recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price of contracts"
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total allocated transaction price to performance obligations"
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance"
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration amount"
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed"
    - name: "avg_gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(recognized_amount AS DOUBLE)), 0), 2)
      comment: "Average gross margin percentage"
    - name: "revenue_recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated transaction price recognized"
    - name: "deferred_revenue_ratio"
      expr: ROUND(SUM(CAST(deferred_revenue_balance AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Ratio of deferred revenue to total transaction price"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with revenue recognition events"
    - name: "contract_modification_count"
      expr: COUNT(CASE WHEN contract_modification_flag = TRUE THEN 1 END)
      comment: "Number of contracts with modifications"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transfers, netting, reconciliation, and elimination for consolidated reporting"
  source: "`retail_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the intercompany transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities"
    - name: "netting_status"
      expr: netting_status
      comment: "Netting status of the transaction"
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether the transaction has been eliminated for consolidation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Company code of the sending entity"
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Company code of the receiving entity"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement"
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount"
    - name: "total_local_amount_sending"
      expr: SUM(CAST(local_currency_amount_sending AS DOUBLE))
      comment: "Total amount in sending entity local currency"
    - name: "total_local_amount_receiving"
      expr: SUM(CAST(local_currency_amount_receiving AS DOUBLE))
      comment: "Total amount in receiving entity local currency"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between sending and receiving amounts"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average intercompany transaction amount"
    - name: "reconciliation_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between sending and receiving amounts"
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions eliminated for consolidation"
    - name: "reconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END)
      comment: "Number of fully reconciled transactions"
    - name: "reconciliation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions fully reconciled"
    - name: "unique_sending_companies"
      expr: COUNT(DISTINCT sending_company_code)
      comment: "Number of unique sending company codes"
    - name: "unique_receiving_companies"
      expr: COUNT(DISTINCT receiving_company_code)
      comment: "Number of unique receiving company codes"
    - name: "unique_company_pairs"
      expr: COUNT(DISTINCT CONCAT(sending_company_code, '-', receiving_company_code))
      comment: "Number of unique intercompany trading pairs"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run metrics tracking payment processing efficiency, success rates, and cash disbursement operations"
  source: "`retail_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "status"
      expr: status
      comment: "Status of the payment run"
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (manual, automatic, scheduled)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (ACH, wire, check)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel used"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment run"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the payment run"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the payment run is recurring"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the payment run"
  measures:
    - name: "total_payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs"
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs"
    - name: "avg_payment_amount_per_run"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average payment amount per payment run"
    - name: "total_successful_payments"
      expr: SUM(CAST(successful_payment_count AS BIGINT))
      comment: "Total number of successful payments"
    - name: "total_failed_payments"
      expr: SUM(CAST(failed_payment_count AS BIGINT))
      comment: "Total number of failed payments"
    - name: "payment_success_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(successful_payment_count AS BIGINT)) / NULLIF(SUM(CAST(total_payment_count AS BIGINT)), 0), 2)
      comment: "Percentage of payments successfully processed"
    - name: "payment_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(failed_payment_count AS BIGINT)) / NULLIF(SUM(CAST(total_payment_count AS BIGINT)), 0), 2)
      comment: "Percentage of payments that failed"
    - name: "completed_run_count"
      expr: COUNT(CASE WHEN status = 'completed' THEN 1 END)
      comment: "Number of completed payment runs"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment runs completed successfully"
    - name: "reconciled_run_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END)
      comment: "Number of reconciled payment runs"
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment runs reconciled"
    - name: "unique_bank_accounts"
      expr: COUNT(DISTINCT bank_account_id)
      comment: "Number of unique bank accounts used"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax compliance, jurisdiction analysis, and tax liability management"
  source: "`retail_ecm`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (sales, use, VAT, GST)"
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of tax (input, output)"
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of tax jurisdiction"
    - name: "tax_jurisdiction_state"
      expr: tax_jurisdiction_state
      comment: "State of tax jurisdiction"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied"
    - name: "tax_authority_name"
      expr: tax_authority_name
      comment: "Name of the tax authority"
    - name: "document_type"
      expr: document_type
      comment: "Type of document"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the tax posting"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the transaction is tax exempt"
    - name: "reverse_charge_flag"
      expr: reverse_charge_flag
      comment: "Whether reverse charge mechanism applies"
    - name: "nexus_indicator"
      expr: nexus_indicator
      comment: "Whether nexus exists in the jurisdiction"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the posting is a reversal"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Tax reporting period"
  measures:
    - name: "total_tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount in transaction currency"
    - name: "total_tax_amount_local"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency"
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount"
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage"
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate (total tax / total taxable base)"
    - name: "tax_exempt_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt transactions"
    - name: "tax_exempt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are tax-exempt"
    - name: "reverse_charge_count"
      expr: COUNT(CASE WHEN reverse_charge_flag = TRUE THEN 1 END)
      comment: "Number of reverse charge transactions"
    - name: "unique_jurisdictions"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Number of unique tax jurisdictions"
    - name: "unique_tax_authorities"
      expr: COUNT(DISTINCT tax_authority_name)
      comment: "Number of unique tax authorities"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with tax postings"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with tax postings"
$$;