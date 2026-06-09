-- Metric views for domain: finance | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key payable metrics for monitoring outstanding liabilities and discounts."
  source: "`ecommerce_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification of the payable."
    - name: "ap_status"
      expr: ap_status
      comment: "Current status of the payable (e.g., Open, Paid, Overdue)."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the payable."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payable amounts."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of all AP invoices."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount offered."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN ap_status = 'Overdue' THEN 1 END)
      comment: "Count of overdue AP invoices."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP records."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core receivable metrics to assess cash collection and aging."
  source: "`ecommerce_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification of the receivable."
    - name: "ar_status"
      expr: ar_status
      comment: "Current status of the receivable (e.g., Open, Paid, Overdue)."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the receivable."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receivable amounts."
  measures:
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open amount outstanding."
    - name: "total_paid_amount"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid to date."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices."
    - name: "avg_days_past_due"
      expr: AVG(DATEDIFF(CURRENT_DATE, due_date))
      comment: "Average days past due for AR invoices."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN ar_status = 'Overdue' THEN 1 END)
      comment: "Count of overdue AR invoices."
    - name: "ar_record_count"
      expr: COUNT(1)
      comment: "Total number of AR records."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated ledger balances for financial statement preparation."
  source: "`ecommerce_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "account_number"
      expr: account_number
      comment: "Account number identifier."
    - name: "account_name"
      expr: account_name
      comment: "Human‑readable account name."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (Asset, Liability, Equity, Revenue, Expense)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the balance."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month) of the balance."
    - name: "company_code"
      expr: company_code
      comment: "Company code owning the account."
  measures:
    - name: "total_balance_gc"
      expr: SUM(CAST(account_balance_gc AS DOUBLE))
      comment: "Total group currency balance across accounts."
    - name: "total_balance_lc"
      expr: SUM(CAST(account_balance_lc AS DOUBLE))
      comment: "Total local currency balance across accounts."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of ledger accounts."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics to monitor spending vs. plan."
  source: "`ecommerce_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., Approved, Draft)."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Operational, Capital)."
    - name: "budget_name"
      expr: budget_name
      comment: "Descriptive name of the budget."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget."
  measures:
    - name: "total_actuals"
      expr: SUM(CAST(actuals_amount AS DOUBLE))
      comment: "Sum of actual expenditures."
    - name: "total_forecast"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Sum of forecasted expenditures."
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance between actuals and forecast."
    - name: "average_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across budgets."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_gmv_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMV and revenue reconciliation metrics for marketplace performance."
  source: "`ecommerce_ecm`.`finance`.`gmv_reconciliation`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g., Online, Marketplace)."
    - name: "marketplace_segment"
      expr: marketplace_segment
      comment: "Marketplace segment classification."
  measures:
    - name: "total_gross_gmv"
      expr: SUM(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Total gross GMV."
    - name: "total_net_gmv"
      expr: SUM(CAST(net_gmv_amount AS DOUBLE))
      comment: "Total net GMV after discounts."
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_net_revenue_amount AS DOUBLE))
      comment: "Total recognized net revenue."
    - name: "total_returns_amount"
      expr: SUM(CAST(returns_refunds_amount AS DOUBLE))
      comment: "Total amount refunded for returns."
    - name: "gmv_record_count"
      expr: COUNT(1)
      comment: "Number of GMV reconciliation records."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs to track timing and amount of recognized revenue."
  source: "`ecommerce_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue (e.g., Subscription, Transactional)."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the recognition."
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total recognized revenue amount."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue amount."
    - name: "average_recognition_period_days"
      expr: AVG(DATEDIFF(recognition_period_end_date, recognition_period_start_date))
      comment: "Average recognition period length in days."
    - name: "recognition_record_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition records."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset valuation and depreciation metrics for asset management."
  source: "`ecommerce_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset (e.g., Equipment, Furniture)."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g., Active, Retired)."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset."
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across assets."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed assets recorded."
$$;