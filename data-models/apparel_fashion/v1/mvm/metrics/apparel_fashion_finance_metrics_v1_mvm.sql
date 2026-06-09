-- Metric views for domain: finance | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

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
      comment: "Current status of the AR invoice (open, paid, overdue, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (standard, credit memo, debit memo, prepayment)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the invoice was generated (retail, wholesale, e-commerce)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice posting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice posting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice (Net 30, Net 60, etc.)"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month in which the invoice was billed"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which the invoice was posted to the general ledger"
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used for revenue recognition (point-in-time, over-time, deferred)"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and deductions"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts, the primary revenue metric"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total amount still outstanding and unpaid across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges billed to customers"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ar_invoice_id)
      comment: "Number of unique AR invoices"
    - name: "customer_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers invoiced"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value per invoice"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable spend, payment timing, and supplier liability metrics"
  source: "`apparel_fashion_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (pending, approved, paid, blocked)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, debit memo, prepayment)"
    - name: "invoice_category"
      expr: invoice_category
      comment: "Category of the invoice (goods, services, freight, duty)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice posting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice posting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms negotiated with the supplier"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, ACH, letter of credit)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, goods receipt, and invoice"
    - name: "payment_block_indicator"
      expr: payment_block_indicator
      comment: "Whether the invoice is blocked for payment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month in which the invoice was issued by the supplier"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which the invoice was posted to the general ledger"
  measures:
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts, the primary spend metric"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured from suppliers"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on supplier invoices"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ap_invoice_id)
      comment: "Number of unique AP invoices"
    - name: "supplier_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique suppliers invoiced"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value per invoice"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured through early payment"
    - name: "blocked_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN payment_block_indicator = TRUE THEN ap_invoice_id END)
      comment: "Number of invoices currently blocked for payment"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_cogs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of goods sold recognition and margin analysis metrics by product, channel, and region"
  source: "`apparel_fashion_ecm`.`finance`.`cogs_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of COGS recognition"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of COGS recognition"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the product was sold"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Geographic region where the sale occurred"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category for margin analysis"
    - name: "collection_code"
      expr: collection_code
      comment: "Product collection or line"
    - name: "season_code"
      expr: season_code
      comment: "Season for which the product was designed"
    - name: "costing_method"
      expr: costing_method
      comment: "Method used to calculate COGS (FIFO, LIFO, weighted average, standard)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which COGS is recorded"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month in which COGS was recognized"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which COGS was posted to the general ledger"
  measures:
    - name: "total_cogs"
      expr: SUM(CAST(total_cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold, the primary cost metric for margin analysis"
    - name: "total_fob_cost"
      expr: SUM(CAST(fob_cost AS DOUBLE))
      comment: "Total free-on-board cost from suppliers before landed costs"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost component of COGS"
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total customs duty cost component of COGS"
    - name: "total_ldp_cost"
      expr: SUM(CAST(ldp_cost AS DOUBLE))
      comment: "Total landed duty paid cost"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost used for planning and variance analysis"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total variance between standard and actual cost"
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity of units sold"
    - name: "avg_unit_cogs"
      expr: AVG(CAST(total_cogs_amount AS DOUBLE))
      comment: "Average COGS per transaction line"
    - name: "freight_as_pct_of_cogs"
      expr: ROUND(100.0 * SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of total COGS"
    - name: "duty_as_pct_of_cogs"
      expr: ROUND(100.0 * SUM(CAST(duty_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Duty cost as a percentage of total COGS"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_landed_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landed cost components and duty optimization metrics for international sourcing"
  source: "`apparel_fashion_ecm`.`finance`.`landed_cost`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of landed cost calculation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of landed cost calculation"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country from which goods were shipped"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country to which goods were shipped"
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "International commercial terms defining cost responsibility"
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port from which goods were loaded"
    - name: "port_of_discharge"
      expr: port_of_discharge
      comment: "Port at which goods were discharged"
    - name: "hs_code"
      expr: hs_code
      comment: "Harmonized System code for tariff classification"
    - name: "gsp_preference_applied"
      expr: gsp_preference_applied
      comment: "Whether Generalized System of Preferences duty reduction was applied"
    - name: "landed_cost_status"
      expr: landed_cost_status
      comment: "Status of the landed cost calculation (draft, finalized, posted)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which landed cost is recorded"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month in which landed cost was calculated"
  measures:
    - name: "total_landed_cost"
      expr: SUM(CAST(total_landed_cost_amount AS DOUBLE))
      comment: "Total landed cost including all freight, duty, and handling charges"
    - name: "total_fob_price"
      expr: SUM(CAST(fob_price_amount AS DOUBLE))
      comment: "Total free-on-board price from suppliers"
    - name: "total_ocean_freight"
      expr: SUM(CAST(ocean_freight_amount AS DOUBLE))
      comment: "Total ocean freight cost"
    - name: "total_air_freight"
      expr: SUM(CAST(air_freight_amount AS DOUBLE))
      comment: "Total air freight cost"
    - name: "total_inland_freight"
      expr: SUM(CAST(inland_freight_amount AS DOUBLE))
      comment: "Total inland freight cost"
    - name: "total_customs_duty"
      expr: SUM(CAST(customs_duty_amount AS DOUBLE))
      comment: "Total customs duty paid"
    - name: "total_insurance"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance cost for shipments"
    - name: "total_port_handling"
      expr: SUM(CAST(port_handling_amount AS DOUBLE))
      comment: "Total port handling and terminal charges"
    - name: "total_customs_brokerage"
      expr: SUM(CAST(customs_brokerage_amount AS DOUBLE))
      comment: "Total customs brokerage fees"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of units received"
    - name: "avg_unit_landed_cost"
      expr: AVG(CAST(unit_landed_cost_amount AS DOUBLE))
      comment: "Average landed cost per unit"
    - name: "freight_as_pct_of_landed_cost"
      expr: ROUND(100.0 * (SUM(CAST(ocean_freight_amount AS DOUBLE)) + SUM(CAST(air_freight_amount AS DOUBLE)) + SUM(CAST(inland_freight_amount AS DOUBLE))) / NULLIF(SUM(CAST(total_landed_cost_amount AS DOUBLE)), 0), 2)
      comment: "Total freight as a percentage of landed cost"
    - name: "duty_as_pct_of_landed_cost"
      expr: ROUND(100.0 * SUM(CAST(customs_duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_landed_cost_amount AS DOUBLE)), 0), 2)
      comment: "Customs duty as a percentage of landed cost"
    - name: "avg_tariff_rate"
      expr: AVG(CAST(tariff_rate_percent AS DOUBLE))
      comment: "Average tariff rate applied across shipments"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution, cash flow timing, and working capital metrics"
  source: "`apparel_fashion_ecm`.`finance`.`finance_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (customer receipt, supplier payment, intercompany)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, ACH, credit card)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (pending, cleared, failed, cancelled)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was made"
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency for reporting"
    - name: "block_indicator"
      expr: block_indicator
      comment: "Whether the payment is blocked"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether the payment is between related entities"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month in which the payment was made"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which the payment was posted to the general ledger"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount in transaction currency"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after bank charges and discounts"
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total payment amount in local reporting currency"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken"
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld or paid on payments"
    - name: "payment_count"
      expr: COUNT(DISTINCT finance_payment_id)
      comment: "Number of unique payments processed"
    - name: "avg_payment_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment value per transaction"
    - name: "bank_charge_rate"
      expr: ROUND(100.0 * SUM(CAST(bank_charges AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Bank charges as a percentage of payment amount"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Discounts captured as a percentage of payment amount"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger posting volume, adjustment activity, and accounting close metrics"
  source: "`apparel_fashion_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (standard, accrual, reversal, reclassification)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry"
    - name: "accounting_principle"
      expr: accounting_principle
      comment: "Accounting principle applied (GAAP, IFRS, local statutory)"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Whether the entry is a debit or credit"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the entry is a reversal of a prior entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether the entry is an intercompany transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the entry is recorded"
    - name: "business_area"
      expr: business_area
      comment: "Business area or segment for the entry"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which the entry was posted"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the document date"
  measures:
    - name: "total_document_currency_amount"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total journal entry amount in document currency"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total journal entry amount in local reporting currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount recorded in journal entries"
    - name: "journal_entry_count"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Number of unique journal entries posted"
    - name: "reversal_entry_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of reversal journal entries"
    - name: "intercompany_entry_count"
      expr: COUNT(DISTINCT CASE WHEN intercompany_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of intercompany journal entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(amount_local_currency AS DOUBLE))
      comment: "Average journal entry amount in local currency"
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END) / NULLIF(COUNT(DISTINCT journal_entry_id), 0), 2)
      comment: "Percentage of journal entries that are reversals, indicating adjustment activity"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center budget performance, variance analysis, and overhead allocation metrics"
  source: "`apparel_fashion_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, service, administrative, sales)"
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Current status of the cost center (active, inactive, closed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for budget and actuals"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for budget and actuals"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the cost center"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales or distribution channel"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the cost center"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (marketing, operations, finance, IT)"
    - name: "is_locked_for_posting"
      expr: is_locked_for_posting
      comment: "Whether the cost center is locked for new postings"
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency in which the budget is set"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for cost centers"
    - name: "total_actual_cost_ytd"
      expr: SUM(CAST(actual_cost_ytd AS DOUBLE))
      comment: "Total actual cost incurred year-to-date"
    - name: "total_committed_cost_ytd"
      expr: SUM(CAST(committed_cost_ytd AS DOUBLE))
      comment: "Total committed cost (purchase orders, contracts) year-to-date"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual cost"
    - name: "cost_center_count"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers"
    - name: "avg_budget_per_cost_center"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget amount per cost center"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cost centers"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_ytd AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget utilized year-to-date"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_cost_ytd AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed but not yet spent"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction volume, reconciliation status, and transfer pricing metrics"
  source: "`apparel_fashion_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (goods transfer, service charge, royalty, loan)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the intercompany transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the intercompany transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities"
    - name: "elimination_status"
      expr: elimination_status
      comment: "Status of consolidation elimination entry"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (cost-plus, market-based, profit-split)"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the transaction"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which the transaction occurred"
    - name: "geographic_region_code"
      expr: geographic_region_code
      comment: "Geographic region of the transaction"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency in which the transaction was recorded"
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month in which the transaction occurred"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount in transaction currency"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany transaction amount in group reporting currency"
    - name: "total_transfer_price_adjustment"
      expr: SUM(CAST(transfer_price_adjustment_amount AS DOUBLE))
      comment: "Total transfer pricing adjustments made"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on intercompany transactions"
    - name: "transaction_count"
      expr: COUNT(DISTINCT intercompany_transaction_id)
      comment: "Number of unique intercompany transactions"
    - name: "unreconciled_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status != 'Reconciled' THEN intercompany_transaction_id END)
      comment: "Number of intercompany transactions not yet reconciled"
    - name: "avg_transaction_value"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average intercompany transaction value"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied"
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reconciliation_status = 'Reconciled' THEN intercompany_transaction_id END) / NULLIF(COUNT(DISTINCT intercompany_transaction_id), 0), 2)
      comment: "Percentage of intercompany transactions successfully reconciled"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`finance_tax_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax compliance, filing status, and effective tax rate metrics across jurisdictions"
  source: "`apparel_fashion_ecm`.`finance`.`tax_item`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (sales, use, VAT, GST, customs duty, withholding)"
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of tax (input, output, payable, receivable)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax item"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax item"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction (country, state, province, city)"
    - name: "country_code"
      expr: country_code
      comment: "Country in which the tax applies"
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status of the tax item (filed, pending, amended)"
    - name: "withholding_tax_indicator"
      expr: withholding_tax_indicator
      comment: "Whether the tax is a withholding tax"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the tax item is a reversal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the tax is recorded"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month in which the tax was posted"
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all tax items"
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount on which tax is calculated"
    - name: "tax_item_count"
      expr: COUNT(DISTINCT tax_item_id)
      comment: "Number of unique tax items"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage across tax items"
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable base"
    - name: "unfiled_tax_item_count"
      expr: COUNT(DISTINCT CASE WHEN filing_status != 'Filed' THEN tax_item_id END)
      comment: "Number of tax items not yet filed with authorities"
    - name: "withholding_tax_count"
      expr: COUNT(DISTINCT CASE WHEN withholding_tax_indicator = TRUE THEN tax_item_id END)
      comment: "Number of withholding tax items"
$$;