-- Metric views for domain: finance | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_accounts_receivable_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core receivable KPIs per invoice"
  source: "`construction_ecm`.`finance`.`invoice`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Associated construction project"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of accounts receivable invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of invoices"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice financial performance metrics"
  source: "`construction_ecm`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice processing status"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type/category of invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project linked to the invoice"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount invoiced"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per invoice"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting KPIs"
  source: "`construction_ecm`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date of the cash flow forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., rolling, static)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast"
  measures:
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of cash flow forecast records"
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total forecasted cash inflow"
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total forecasted cash outflow"
    - name: "net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Net cash flow forecast (inflow minus outflow)"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budgeting and cost performance"
  source: "`construction_ecm`.`finance`.`project_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., active, closed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project associated with the budget"
    - name: "budget_period_start_date"
      expr: budget_period_start_date
      comment: "Start date of the budgeting period"
  measures:
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of project budget records"
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Original approved budget amount"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total cost committed to date"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Actual cost incurred"
    - name: "budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_revenue_recognition_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition performance metrics"
  source: "`construction_ecm`.`finance`.`revenue_recognition_entry`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project linked to the revenue"
  measures:
    - name: "revenue_entry_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition entries"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Total revenue recognized to date"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue AS DOUBLE))
      comment: "Total deferred revenue"
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue AS DOUBLE))
      comment: "Total unbilled revenue"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job cost transaction financials"
  source: "`construction_ecm`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Category of the cost"
    - name: "cost_code"
      expr: cost_code
      comment: "Cost code identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the transaction"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of job cost transactions"
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost recorded"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items/services"
    - name: "average_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance indicators"
  source: "`construction_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center"
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category classification of the profit center"
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the profit center"
  measures:
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Number of profit centers"
    - name: "total_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total revenue generated"
    - name: "total_ebit"
      expr: SUM(CAST(ebit AS DOUBLE))
      comment: "Total earnings before interest and taxes"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda AS DOUBLE))
      comment: "Total earnings before interest, taxes, depreciation, and amortization"
    - name: "average_profit_margin_percent"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percent"
$$;