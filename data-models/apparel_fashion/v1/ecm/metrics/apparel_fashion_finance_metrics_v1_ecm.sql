-- Metric views for domain: finance | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable revenue, collections, and aging metrics for customer invoicing performance"
  source: "`apparel_fashion_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (open, paid, overdue, etc.)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the invoice was generated"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month in which the invoice was billed"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level for overdue invoices"
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
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivable amount not yet collected"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given on invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of gross amount"
    - name: "collection_rate"
      expr: ROUND(100.0 * (SUM(CAST(net_amount AS DOUBLE)) - SUM(CAST(outstanding_amount AS DOUBLE))) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Collection rate as percentage of net amount invoiced"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers invoiced"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable spend, payment efficiency, and vendor management metrics"
  source: "`apparel_fashion_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (pending, approved, paid, blocked, etc.)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit, debit, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (wire, check, ACH, etc.)"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month in which the invoice was issued"
    - name: "payment_block_indicator"
      expr: payment_block_indicator
      comment: "Whether the invoice is blocked for payment"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discount amount captured"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured through early payment"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoiced"
    - name: "blocked_invoice_count"
      expr: SUM(CASE WHEN payment_block_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices blocked for payment"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_cogs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of goods sold metrics for product profitability and margin analysis"
  source: "`apparel_fashion_ecm`.`finance`.`cogs_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the COGS entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the COGS entry"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the transaction"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category code"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the product"
    - name: "costing_method"
      expr: costing_method
      comment: "Costing method used (FIFO, LIFO, weighted average, etc.)"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month in which COGS was recognized"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region code"
  measures:
    - name: "total_cogs_entries"
      expr: COUNT(1)
      comment: "Total number of COGS entries"
    - name: "total_cogs_amount"
      expr: SUM(CAST(total_cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity of units sold"
    - name: "total_fob_cost"
      expr: SUM(CAST(fob_cost AS DOUBLE))
      comment: "Total free-on-board cost"
    - name: "total_ldp_cost"
      expr: SUM(CAST(ldp_cost AS DOUBLE))
      comment: "Total landed duty paid cost"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost"
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total customs duty cost"
    - name: "avg_unit_cogs"
      expr: AVG(CAST(total_cogs_amount AS DOUBLE) / NULLIF(CAST(quantity_sold AS DOUBLE), 0))
      comment: "Average COGS per unit sold"
    - name: "freight_as_pct_of_cogs"
      expr: ROUND(100.0 * SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as percentage of total COGS"
    - name: "duty_as_pct_of_cogs"
      expr: ROUND(100.0 * SUM(CAST(duty_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Duty cost as percentage of total COGS"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_margin_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gross margin, contribution margin, and profitability metrics by product and channel"
  source: "`apparel_fashion_ecm`.`finance`.`margin_record`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the margin record"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the margin record"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel type"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category code"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "season_code"
      expr: season_code
      comment: "Season code"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of margin records"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue before discounts and markdowns"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after discounts and markdowns"
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin (net revenue minus COGS)"
    - name: "total_contribution_margin"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin after variable costs"
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity of units sold"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage of net revenue"
    - name: "avg_selling_price"
      expr: AVG(CAST(asp_amount AS DOUBLE))
      comment: "Average selling price per unit"
    - name: "avg_unit_retail"
      expr: AVG(CAST(aur_amount AS DOUBLE))
      comment: "Average unit retail price"
    - name: "markdown_rate"
      expr: ROUND(100.0 * SUM(CAST(markdown_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Markdown rate as percentage of gross revenue"
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average gross margin return on investment ratio"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning, variance analysis, and financial control metrics"
  source: "`apparel_fashion_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, project, etc.)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (draft, approved, active, closed)"
    - name: "period_type"
      expr: period_type
      comment: "Period type (annual, quarterly, monthly)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "channel"
      expr: channel
      comment: "Sales or distribution channel"
    - name: "is_baseline"
      expr: is_baseline
      comment: "Whether this is the baseline budget version"
  measures:
    - name: "total_budgets"
      expr: COUNT(1)
      comment: "Total number of budget records"
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budgeted amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated budget amount"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount (encumbered but not yet spent)"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget utilization rate as percentage of total budget"
    - name: "commitment_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_amount AS DOUBLE)) + SUM(CAST(committed_amount AS DOUBLE))) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Commitment rate (actual plus committed) as percentage of budget"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budgets"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center performance, spend control, and overhead allocation metrics"
  source: "`apparel_fashion_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period"
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, service, administrative, etc.)"
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Current status of the cost center"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (HR, IT, Finance, Operations, etc.)"
    - name: "is_overhead_sender"
      expr: is_overhead_sender
      comment: "Whether this cost center sends overhead allocations"
  measures:
    - name: "total_cost_centers"
      expr: COUNT(1)
      comment: "Total number of cost centers"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across cost centers"
    - name: "total_actual_cost_ytd"
      expr: SUM(CAST(actual_cost_ytd AS DOUBLE))
      comment: "Total actual cost year-to-date"
    - name: "total_committed_cost_ytd"
      expr: SUM(CAST(committed_cost_ytd AS DOUBLE))
      comment: "Total committed cost year-to-date"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_ytd AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget utilization rate as percentage of budget"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cost centers"
    - name: "over_budget_count"
      expr: SUM(CASE WHEN CAST(variance_amount AS DOUBLE) < 0 THEN 1 ELSE 0 END)
      comment: "Number of cost centers over budget"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_landed_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landed cost components, duty optimization, and total cost of ownership metrics"
  source: "`apparel_fashion_ecm`.`finance`.`landed_cost`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period"
    - name: "landed_cost_status"
      expr: landed_cost_status
      comment: "Status of the landed cost calculation"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country"
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm code (FOB, CIF, DDP, etc.)"
    - name: "gsp_preference_applied"
      expr: gsp_preference_applied
      comment: "Whether GSP (Generalized System of Preferences) was applied"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of landed cost calculation"
  measures:
    - name: "total_landed_cost_records"
      expr: COUNT(1)
      comment: "Total number of landed cost records"
    - name: "total_landed_cost"
      expr: SUM(CAST(total_landed_cost_amount AS DOUBLE))
      comment: "Total landed cost amount"
    - name: "total_fob_price"
      expr: SUM(CAST(fob_price_amount AS DOUBLE))
      comment: "Total free-on-board price"
    - name: "total_customs_duty"
      expr: SUM(CAST(customs_duty_amount AS DOUBLE))
      comment: "Total customs duty paid"
    - name: "total_ocean_freight"
      expr: SUM(CAST(ocean_freight_amount AS DOUBLE))
      comment: "Total ocean freight cost"
    - name: "total_air_freight"
      expr: SUM(CAST(air_freight_amount AS DOUBLE))
      comment: "Total air freight cost"
    - name: "total_inland_freight"
      expr: SUM(CAST(inland_freight_amount AS DOUBLE))
      comment: "Total inland freight cost"
    - name: "total_insurance"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance cost"
    - name: "duty_as_pct_of_landed_cost"
      expr: ROUND(100.0 * SUM(CAST(customs_duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_landed_cost_amount AS DOUBLE)), 0), 2)
      comment: "Customs duty as percentage of total landed cost"
    - name: "freight_as_pct_of_landed_cost"
      expr: ROUND(100.0 * (SUM(CAST(ocean_freight_amount AS DOUBLE)) + SUM(CAST(air_freight_amount AS DOUBLE)) + SUM(CAST(inland_freight_amount AS DOUBLE))) / NULLIF(SUM(CAST(total_landed_cost_amount AS DOUBLE)), 0), 2)
      comment: "Total freight as percentage of landed cost"
    - name: "avg_tariff_rate"
      expr: AVG(CAST(tariff_rate_percent AS DOUBLE))
      comment: "Average tariff rate percentage"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger posting volume, adjustment tracking, and accounting control metrics"
  source: "`apparel_fashion_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry"
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document"
    - name: "accounting_principle"
      expr: accounting_principle
      comment: "Accounting principle (GAAP, IFRS, etc.)"
    - name: "business_area"
      expr: business_area
      comment: "Business area"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether this is an intercompany transaction"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting"
  measures:
    - name: "total_journal_entries"
      expr: COUNT(1)
      comment: "Total number of journal entries"
    - name: "total_document_currency_amount"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total amount in document currency"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total amount in local currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount"
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal entries"
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of intercompany entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(amount_local_currency AS DOUBLE))
      comment: "Average journal entry amount in local currency"
    - name: "unique_gl_accounts"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of unique GL accounts posted to"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset valuation, depreciation tracking, and capital asset management metrics"
  source: "`apparel_fashion_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (active, retired, under construction, etc.)"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance, etc.)"
    - name: "asset_group_code"
      expr: asset_group_code
      comment: "Asset group code"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area code"
    - name: "lease_indicator"
      expr: lease_indicator
      comment: "Whether the asset is leased"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment amount recognized"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of assets"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Depreciation rate as percentage of acquisition cost"
    - name: "leased_asset_count"
      expr: SUM(CASE WHEN lease_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leased assets"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction volume, reconciliation status, and elimination tracking metrics"
  source: "`apparel_fashion_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between entities"
    - name: "elimination_status"
      expr: elimination_status
      comment: "Consolidation elimination status"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method used"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount in transaction currency"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total amount in group reporting currency"
    - name: "total_transfer_price_adjustment"
      expr: SUM(CAST(transfer_price_adjustment_amount AS DOUBLE))
      comment: "Total transfer pricing adjustment amount"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount"
    - name: "reconciled_transaction_count"
      expr: SUM(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 ELSE 0 END)
      comment: "Number of reconciled transactions"
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions reconciled"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate"
$$;