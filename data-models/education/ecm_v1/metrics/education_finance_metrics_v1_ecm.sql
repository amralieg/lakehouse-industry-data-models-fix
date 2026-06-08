-- Metric views for domain: finance | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking vendor payment obligations, invoice processing efficiency, and discount capture performance"
  source: "`education_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_fiscal_year"
      expr: YEAR(invoice_date)
      comment: "Fiscal year when invoice was issued"
    - name: "invoice_fiscal_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Fiscal month when invoice was issued"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type classification of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for invoice payment"
    - name: "form_1099_reportable"
      expr: form_1099_reportable_flag
      comment: "Whether invoice is reportable on Form 1099"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which invoice is denominated"
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross amount of all invoices before discounts and adjustments"
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_invoice_amount AS DOUBLE))
      comment: "Total net amount of all invoices after discounts"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and shipping charges"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_invoice_amount AS DOUBLE))
      comment: "Average net invoice amount"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ap_invoice_id)
      comment: "Number of unique invoices"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average number of days from invoice date to payment date"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of potential discounts captured (discount amount as % of gross amount)"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics tracking revenue recognition, collection efficiency, and customer payment behavior"
  source: "`education_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_fiscal_year"
      expr: YEAR(invoice_date)
      comment: "Fiscal year when invoice was issued"
    - name: "invoice_fiscal_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Fiscal month when invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the receivable invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type classification of the invoice"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category for outstanding receivables"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for invoice payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which invoice is denominated"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before discounts and adjustments"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total outstanding receivables not yet collected"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected from customers"
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts provided to customers"
    - name: "invoice_count"
      expr: COUNT(DISTINCT ar_invoice_id)
      comment: "Number of unique receivable invoices"
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount successfully collected"
    - name: "avg_days_to_collect"
      expr: AVG(DATEDIFF(last_payment_date, invoice_date))
      comment: "Average number of days from invoice date to payment receipt"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking budget utilization, variance analysis, and fiscal discipline across cost centers and programs"
  source: "`education_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_fiscal_year"
      expr: YEAR(period_start_date)
      comment: "Fiscal year of the budget period"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type classification of the budget"
    - name: "budget_category"
      expr: budget_category
      comment: "Category classification of the budget"
    - name: "is_restricted"
      expr: is_restricted
      comment: "Whether budget has donor or regulatory restrictions"
    - name: "is_salary_budget"
      expr: is_salary_budget
      comment: "Whether budget is designated for salary expenses"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which budget is denominated"
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total amount budgeted across all budget lines"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditures against budgets"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining budget available for spending"
    - name: "total_encumbrance_balance"
      expr: SUM(CAST(encumbrance_balance AS DOUBLE))
      comment: "Total amount committed but not yet spent"
    - name: "total_carry_forward"
      expr: SUM(CAST(carry_forward_amount AS DOUBLE))
      comment: "Total amount carried forward from prior periods"
    - name: "total_fte_count"
      expr: SUM(CAST(fte_count AS DOUBLE))
      comment: "Total full-time equivalent positions budgeted"
    - name: "budget_count"
      expr: COUNT(DISTINCT budget_id)
      comment: "Number of unique budget lines"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed by actual expenditures"
    - name: "avg_budget_per_fte"
      expr: AVG(CAST(budgeted_amount AS DOUBLE) / NULLIF(CAST(fte_count AS DOUBLE), 0))
      comment: "Average budgeted amount per full-time equivalent"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant expenditure metrics tracking research and sponsored program spending, cost sharing, and compliance with sponsor requirements"
  source: "`education_ecm`.`finance`.`grant_expenditure`"
  dimensions:
    - name: "expenditure_fiscal_year"
      expr: YEAR(expenditure_date)
      comment: "Fiscal year when expenditure occurred"
    - name: "expenditure_fiscal_month"
      expr: DATE_TRUNC('MONTH', expenditure_date)
      comment: "Fiscal month when expenditure occurred"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type classification of the grant expenditure"
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category classification of the expenditure"
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category to which expenditure is charged"
    - name: "allowability_status"
      expr: allowability_status
      comment: "Whether expenditure is allowable under grant terms"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expenditure"
    - name: "cost_sharing_indicator"
      expr: cost_sharing_indicator
      comment: "Whether expenditure includes institutional cost sharing"
    - name: "sponsor_billing_status"
      expr: sponsor_billing_status
      comment: "Status of billing to sponsor for this expenditure"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which expenditure is recorded"
  measures:
    - name: "total_grant_expenditure"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total direct expenditures charged to grants"
    - name: "total_cost_sharing"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost sharing committed"
    - name: "total_fa_recovery"
      expr: SUM(CAST(facilities_administrative_amount AS DOUBLE))
      comment: "Total facilities and administrative cost recovery"
    - name: "expenditure_count"
      expr: COUNT(DISTINCT grant_expenditure_id)
      comment: "Number of unique grant expenditure transactions"
    - name: "avg_expenditure_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average expenditure amount per transaction"
    - name: "avg_fa_rate"
      expr: AVG(CAST(facilities_administrative_rate AS DOUBLE))
      comment: "Average facilities and administrative rate applied"
    - name: "cost_sharing_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_sharing_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Cost sharing as percentage of total direct expenditure"
    - name: "fa_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(facilities_administrative_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "F&A recovery as percentage of total direct expenditure"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking transaction volume, posting efficiency, and financial close performance"
  source: "`education_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_fiscal_year"
      expr: YEAR(journal_date)
      comment: "Fiscal year of the journal entry"
    - name: "journal_fiscal_month"
      expr: DATE_TRUNC('MONTH', journal_date)
      comment: "Fiscal month of the journal entry"
    - name: "journal_type"
      expr: journal_type
      comment: "Type classification of the journal entry"
    - name: "journal_category"
      expr: journal_category
      comment: "Category classification of the journal entry"
    - name: "journal_source"
      expr: journal_source
      comment: "Source system or process that created the entry"
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry"
    - name: "encumbrance_indicator"
      expr: encumbrance_indicator
      comment: "Whether entry represents an encumbrance"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether entry is a reversal of a prior entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether entry involves intercompany transactions"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which entry is recorded"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries"
    - name: "journal_entry_count"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Number of unique journal entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average journal entry amount (using debit side)"
    - name: "avg_days_to_post"
      expr: AVG(DATEDIFF(posted_date, journal_date))
      comment: "Average number of days from journal date to posting date"
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END) / NULLIF(COUNT(DISTINCT journal_entry_id), 0), 2)
      comment: "Percentage of journal entries that are reversals"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics tracking procurement volume, vendor performance, and encumbrance management"
  source: "`education_ecm`.`finance`.`purchase_order`"
  dimensions:
    - name: "po_fiscal_year"
      expr: YEAR(po_date)
      comment: "Fiscal year when purchase order was created"
    - name: "po_fiscal_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Fiscal month when purchase order was created"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type classification of the purchase order"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the purchase order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which purchase order is denominated"
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order value before tax"
    - name: "total_po_amount_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total purchase order value including tax"
    - name: "total_encumbrance"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered funds for open purchase orders"
    - name: "total_invoiced"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced against purchase orders"
    - name: "total_received"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total amount received against purchase orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders"
    - name: "po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value"
    - name: "receipt_rate"
      expr: ROUND(100.0 * SUM(CAST(received_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of purchase order value received"
    - name: "invoice_rate"
      expr: ROUND(100.0 * SUM(CAST(invoiced_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of purchase order value invoiced"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_endowment_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Endowment distribution metrics tracking spending policy execution, donor restriction compliance, and endowment sustainability"
  source: "`education_ecm`.`finance`.`endowment_distribution`"
  dimensions:
    - name: "distribution_fiscal_year"
      expr: YEAR(distribution_date)
      comment: "Fiscal year when distribution occurred"
    - name: "distribution_fiscal_month"
      expr: DATE_TRUNC('MONTH', distribution_date)
      comment: "Fiscal month when distribution occurred"
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type classification of the endowment distribution"
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution"
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used for calculating distribution"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the distribution"
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "FASB net asset classification of the distribution"
    - name: "underwater_indicator"
      expr: underwater_indicator
      comment: "Whether endowment market value is below historic gift value"
    - name: "upmifa_compliance"
      expr: upmifa_compliance_flag
      comment: "Whether distribution complies with UPMIFA prudence standards"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which distribution is made"
  measures:
    - name: "total_distribution_amount"
      expr: SUM(CAST(distribution_amount AS DOUBLE))
      comment: "Total amount distributed from endowments"
    - name: "total_endowment_market_value"
      expr: SUM(CAST(endowment_market_value_basis AS DOUBLE))
      comment: "Total market value of endowments at distribution"
    - name: "total_restriction_released"
      expr: SUM(CAST(restriction_released_amount AS DOUBLE))
      comment: "Total donor restrictions released through distributions"
    - name: "distribution_count"
      expr: COUNT(DISTINCT endowment_distribution_id)
      comment: "Number of unique endowment distributions"
    - name: "avg_distribution_amount"
      expr: AVG(CAST(distribution_amount AS DOUBLE))
      comment: "Average distribution amount per transaction"
    - name: "avg_spending_rate"
      expr: AVG(CAST(spending_rate AS DOUBLE))
      comment: "Average spending rate applied to endowments"
    - name: "effective_spending_rate"
      expr: ROUND(100.0 * SUM(CAST(distribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(endowment_market_value_basis AS DOUBLE)), 0), 2)
      comment: "Actual spending rate as percentage of endowment market value"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation expense, and asset lifecycle management"
  source: "`education_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "acquisition_fiscal_year"
      expr: YEAR(acquisition_date)
      comment: "Fiscal year when asset was acquired"
    - name: "in_service_fiscal_year"
      expr: YEAR(in_service_date)
      comment: "Fiscal year when asset was placed in service"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset"
    - name: "asset_category"
      expr: asset_category
      comment: "Category classification of the asset"
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory classification of the asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for calculating depreciation"
    - name: "gasb_classification"
      expr: gasb_classification
      comment: "GASB classification for governmental accounting"
    - name: "capitalization_threshold_met"
      expr: capitalization_threshold_met
      comment: "Whether asset met capitalization threshold"
    - name: "federal_property_indicator"
      expr: federal_property_indicator
      comment: "Whether asset is federally owned property"
    - name: "lease_indicator"
      expr: lease_indicator
      comment: "Whether asset is leased rather than owned"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical cost of all fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total depreciation accumulated to date"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all fixed assets"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value at end of useful life"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from disposed assets"
    - name: "asset_count"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Number of unique fixed assets"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset"
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of original cost that has been depreciated"
$$;