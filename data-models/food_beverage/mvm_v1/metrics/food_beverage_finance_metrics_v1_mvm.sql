-- Metric views for domain: finance | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking supplier payment performance, discount capture, and cash flow management"
  source: "`food_beverage_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g., open, paid, blocked)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, check, ACH)"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status indicating whether invoice has been settled"
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (invoice, PO, goods receipt)"
    - name: "discount_captured_flag"
      expr: discount_captured
      comment: "Boolean indicating whether early payment discount was captured"
    - name: "is_intercompany_flag"
      expr: is_intercompany
      comment: "Boolean indicating intercompany transaction"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the invoice"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment date"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discount amount"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discount_captured = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices where early payment discount was captured"
    - name: "avg_days_to_payment"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average number of days from invoice date to payment date"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices"
    - name: "unique_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers invoiced"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics tracking customer payment performance, collections efficiency, and revenue realization"
  source: "`food_beverage_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., open, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, check, credit card)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any customer dispute on the invoice"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel type (e.g., retail, foodservice, direct)"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the invoice"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment date"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and deductions"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding amount not yet collected"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount collected from customers"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken"
    - name: "total_short_payment_amount"
      expr: SUM(CAST(short_payment_amount AS DOUBLE))
      comment: "Total short payment amount (underpayments)"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net invoice amount collected"
    - name: "avg_days_to_payment"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average number of days from invoice date to payment date (Days Sales Outstanding component)"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers invoiced"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking financial transaction volume, balance accuracy, and posting patterns"
  source: "`food_beverage_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., SA, DR, KR)"
    - name: "journal_entry_type"
      expr: journal_entry_type
      comment: "Classification of journal entry (e.g., manual, automatic, recurring)"
    - name: "document_status"
      expr: document_status
      comment: "Current status of the journal entry document"
    - name: "reversal_flag"
      expr: reversal_indicator
      comment: "Boolean indicating whether this is a reversal entry"
    - name: "intercompany_flag"
      expr: intercompany_indicator
      comment: "Boolean indicating intercompany transaction"
    - name: "currency"
      expr: currency_code
      comment: "Transaction currency code"
    - name: "local_currency"
      expr: local_currency_code
      comment: "Local currency code"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of posting date"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date"
    - name: "document_year"
      expr: YEAR(document_date)
      comment: "Year of document date"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount in transaction currency"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount in transaction currency"
    - name: "total_debit_amount_local"
      expr: SUM(CAST(total_debit_amount_lc AS DOUBLE))
      comment: "Total debit amount in local currency"
    - name: "total_credit_amount_local"
      expr: SUM(CAST(total_credit_amount_lc AS DOUBLE))
      comment: "Total credit amount in local currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all journal entries"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal journal entries"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals (quality indicator)"
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount_lc AS DOUBLE))
      comment: "Average journal entry debit amount in local currency"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking planned spend, approval status, and budget utilization"
  source: "`food_beverage_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, project)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget (e.g., revenue, expense, investment)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the budget"
    - name: "is_locked_flag"
      expr: is_locked
      comment: "Boolean indicating whether budget is locked for changes"
    - name: "is_carry_forward_flag"
      expr: is_carry_forward
      comment: "Boolean indicating whether budget was carried forward from prior period"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "version_code"
      expr: version_code
      comment: "Budget version code (e.g., original, revised, forecast)"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the budget"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of budget approval"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of budget approval"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount across all budget lines"
    - name: "total_budget_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total budgeted quantity (for volume-based budgets)"
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per budget line"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines"
    - name: "approved_budget_amount"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget amount for approved budgets only"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of budget lines that are approved"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast metrics tracking projected performance, forecast accuracy, and variance to budget"
  source: "`food_beverage_ecm`.`finance`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., revenue, expense, cash flow)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., draft, published, approved)"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the forecast (e.g., high, medium, low)"
    - name: "scenario_code"
      expr: scenario_code
      comment: "Scenario code (e.g., base case, best case, worst case)"
    - name: "driver_type"
      expr: driver_type
      comment: "Type of driver used for forecasting (e.g., volume, price, mix)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast"
    - name: "version_code"
      expr: version_code
      comment: "Forecast version code"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the forecast"
    - name: "forecast_year"
      expr: YEAR(forecast_date)
      comment: "Year of forecast date"
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month of forecast date"
  measures:
    - name: "total_forecasted_amount"
      expr: SUM(CAST(forecasted_amount AS DOUBLE))
      comment: "Total forecasted amount across all forecast lines"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount for comparison to forecast"
    - name: "total_prior_forecast_amount"
      expr: SUM(CAST(prior_forecast_amount AS DOUBLE))
      comment: "Total prior forecast amount for trend analysis"
    - name: "total_variance_to_budget"
      expr: SUM(CAST(variance_to_budget_amount AS DOUBLE))
      comment: "Total variance between forecast and budget"
    - name: "total_variance_to_prior_forecast"
      expr: SUM(CAST(variance_to_prior_forecast_amount AS DOUBLE))
      comment: "Total variance between current and prior forecast"
    - name: "avg_forecasted_amount"
      expr: AVG(CAST(forecasted_amount AS DOUBLE))
      comment: "Average forecasted amount per forecast line"
    - name: "forecast_line_count"
      expr: COUNT(1)
      comment: "Total number of forecast lines"
    - name: "forecast_vs_budget_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_to_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between forecast and budget"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation, and asset utilization"
  source: "`food_beverage_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class_code
      comment: "Asset class code (e.g., building, machinery, vehicle)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g., active, retired, disposed)"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method used (e.g., straight-line, declining balance)"
    - name: "asset_location"
      expr: asset_location
      comment: "Physical location of the asset"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of asset valuation"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition"
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year of asset capitalization"
    - name: "disposal_year"
      expr: YEAR(disposal_date)
      comment: "Year of asset disposal"
  measures:
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original acquisition cost of all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (original cost minus accumulated depreciation)"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges taken on assets"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years"
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life of assets in years"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(original_cost AS DOUBLE)), 0), 2)
      comment: "Overall depreciation rate as percentage of original cost"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax transaction metrics tracking tax liability, compliance, and jurisdictional tax exposure"
  source: "`food_beverage_ecm`.`finance`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., VAT, sales tax, excise, income tax)"
    - name: "tax_status"
      expr: tax_status
      comment: "Status of the tax record (e.g., posted, cleared, disputed)"
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code used for the transaction"
    - name: "tax_exemption_flag"
      expr: tax_exemption_indicator
      comment: "Boolean indicating whether transaction is tax-exempt"
    - name: "reverse_charge_flag"
      expr: reverse_charge_indicator
      comment: "Boolean indicating reverse charge mechanism"
    - name: "intercompany_flag"
      expr: intercompany_indicator
      comment: "Boolean indicating intercompany transaction"
    - name: "currency"
      expr: currency_code
      comment: "Transaction currency code"
    - name: "local_currency"
      expr: local_currency_code
      comment: "Local currency code"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax record"
    - name: "tax_posting_year"
      expr: YEAR(tax_posting_date)
      comment: "Year of tax posting date"
    - name: "tax_posting_month"
      expr: DATE_TRUNC('MONTH', tax_posting_date)
      comment: "Month of tax posting date"
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount in transaction currency"
    - name: "total_tax_amount_local"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency"
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount (amount subject to tax)"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage across all tax records"
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount_local_currency AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as percentage of taxable base"
    - name: "tax_record_count"
      expr: COUNT(1)
      comment: "Total number of tax records"
    - name: "tax_exempt_count"
      expr: SUM(CASE WHEN tax_exemption_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tax-exempt transactions"
    - name: "tax_exemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tax_exemption_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are tax-exempt"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product standard cost metrics tracking cost structure, variance analysis, and cost component breakdown for manufacturing and procurement"
  source: "`food_beverage_ecm`.`finance`.`finance_standard_cost`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost"
    - name: "cost_estimate_status"
      expr: cost_estimate_status
      comment: "Status of the cost estimate (e.g., draft, released, active)"
    - name: "costing_variant"
      expr: costing_variant
      comment: "Costing variant used for calculation"
    - name: "costing_version"
      expr: costing_version
      comment: "Costing version (e.g., standard, planned, actual)"
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance (e.g., material, labor, overhead)"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the standard cost"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year of cost estimate release"
    - name: "valid_from_year"
      expr: YEAR(valid_from_date)
      comment: "Year from which standard cost is valid"
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_price_per_unit AS DOUBLE))
      comment: "Total standard cost per unit across all SKUs"
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost component"
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material cost component"
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost component"
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead cost component"
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost component"
    - name: "total_co_packing_cost"
      expr: SUM(CAST(co_packing_cost AS DOUBLE))
      comment: "Total co-packing cost component"
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost component"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance amount (actual vs standard)"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage"
    - name: "material_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE) + CAST(packaging_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(standard_price_per_unit AS DOUBLE)), 0), 2)
      comment: "Material cost as percentage of total standard cost"
    - name: "overhead_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(fixed_overhead_cost AS DOUBLE) + CAST(variable_overhead_cost AS DOUBLE)) / NULLIF(SUM(CAST(standard_price_per_unit AS DOUBLE)), 0), 2)
      comment: "Overhead cost as percentage of total standard cost"
    - name: "cost_estimate_count"
      expr: COUNT(1)
      comment: "Total number of standard cost estimates"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal period close metrics tracking period-end close performance, SLA compliance, and financial reporting readiness"
  source: "`food_beverage_ecm`.`finance`.`fiscal_period`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "fiscal_period_number"
      expr: fiscal_period_number
      comment: "Fiscal period number within the year"
    - name: "period_type"
      expr: period_type
      comment: "Type of period (e.g., regular, adjustment, year-end)"
    - name: "period_status"
      expr: period_status
      comment: "Current status of the period (e.g., open, closed, locked)"
    - name: "close_status"
      expr: close_status
      comment: "Status of the period close process"
    - name: "close_sla_met_flag"
      expr: close_sla_met
      comment: "Boolean indicating whether close SLA was met"
    - name: "sox_certification_status"
      expr: sox_certification_status
      comment: "SOX certification status for the period"
    - name: "revenue_posting_status"
      expr: revenue_posting_status
      comment: "Status of revenue posting for the period"
    - name: "expense_posting_status"
      expr: expense_posting_status
      comment: "Status of expense posting for the period"
    - name: "period_start_year"
      expr: YEAR(period_start_date)
      comment: "Year of period start date"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of period start date"
  measures:
    - name: "fiscal_period_count"
      expr: COUNT(1)
      comment: "Total number of fiscal periods"
    - name: "close_sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN close_sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods where close SLA was met"
    - name: "avg_close_delay_days"
      expr: AVG(CAST(CAST(close_delay_days AS INT) AS DOUBLE))
      comment: "Average number of days the close was delayed beyond target"
    - name: "avg_close_duration_days"
      expr: AVG(CAST(DATEDIFF(close_actual_date, close_start_date) AS DOUBLE))
      comment: "Average number of days to complete the period close"
    - name: "closed_period_count"
      expr: SUM(CASE WHEN period_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of periods that are closed"
    - name: "open_period_count"
      expr: SUM(CASE WHEN period_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Number of periods that are still open"
$$;