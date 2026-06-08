-- Metric views for domain: finance | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AP invoice financial metrics for payable analysis"
  source: "`food_beverage_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code identifier"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected"
    - name: "average_payment_delay_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days between invoice date and payment date"
    - name: "average_discount_rate_pct"
      expr: AVG(100.0 * discount_amount / NULLIF(gross_amount,0))
      comment: "Average discount rate as percentage of gross amount"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AR invoice performance metrics for receivable management"
  source: "`food_beverage_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code identifier"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center responsible for the sale"
    - name: "sales_org_code"
      expr: sales_org_code
      comment: "Sales organization code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after deductions and taxes"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (unpaid) amount"
    - name: "average_collection_delay_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days between invoice date and payment receipt"
    - name: "average_collection_rate_pct"
      expr: AVG(100.0 * payment_amount / NULLIF(gross_amount,0))
      comment: "Average collection rate as percentage of gross amount"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core journal entry financial aggregates for ledger health"
  source: "`food_beverage_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code identifier"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "General ledger account identifier"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date"
    - name: "document_type"
      expr: document_type
      comment: "Type of journal document"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Sum of debit amounts across journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Sum of credit amounts across journal entries"
    - name: "distinct_document_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Number of unique journal documents"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_cash_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash pool liquidity and utilization metrics"
  source: "`food_beverage_ecm`.`finance`.`cash_pool`"
  dimensions:
    - name: "currency"
      expr: currency
      comment: "Currency of the cash pool"
    - name: "cash_pool_category"
      expr: cash_pool_category
      comment: "Category of cash pool (e.g., operational, strategic)"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Indicates if cash pool spans multiple countries"
    - name: "region"
      expr: region
      comment: "Geographic region of the cash pool"
  measures:
    - name: "total_balance_amount"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total cash pool balance"
    - name: "average_utilization_pct"
      expr: AVG(CAST(cash_pool_utilization_pct AS DOUBLE))
      comment: "Average utilization percentage of cash pools"
    - name: "total_limit_amount"
      expr: SUM(CAST(cash_pool_limit_amount AS DOUBLE))
      comment: "Aggregate cash pool limit amount"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`finance_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecasting KPIs for planning and variance analysis"
  source: "`food_beverage_ecm`.`finance`.`forecast`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month or quarter)"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account associated with the forecast"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center for the forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., rolling, static)"
    - name: "scenario_code"
      expr: scenario_code
      comment: "Scenario identifier (e.g., best case, worst case)"
  measures:
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecasted_amount AS DOUBLE))
      comment: "Total forecasted amount for the period"
    - name: "total_variance_to_budget_amount"
      expr: SUM(CAST(variance_to_budget_amount AS DOUBLE))
      comment: "Aggregate variance between forecast and budget"
    - name: "average_forecast_accuracy_pct"
      expr: AVG(100.0 * (forecasted_amount - budget_amount) / NULLIF(forecasted_amount,0))
      comment: "Average forecast accuracy as percentage of forecasted amount"
$$;