-- Metric views for domain: finance | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics for financial analysis."
  source: "`consumer_goods_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the invoice."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice."
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date."
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AP invoices."
    - name: "average_payment_delay_days"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average days between invoice date and payment date."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice performance metrics."
  source: "`consumer_goods_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR invoice."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the AR invoice."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the AR invoice."
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account identifier."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Days Sales Outstanding aging bucket."
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_date)
      comment: "Month of billing date."
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AR invoices."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across AR invoices."
    - name: "average_days_to_collect"
      expr: AVG(DATEDIFF(due_date, billing_date))
      comment: "Average days between billing date and due date."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning metrics per cost center and profit center."
  source: "`consumer_goods_ecm`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier."
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center code."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the budget."
  measures:
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records."
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned amount in local currency."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity."
    - name: "average_planned_amount_local"
      expr: AVG(CAST(planned_amount_local AS DOUBLE))
      comment: "Average planned amount per budget record."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_revenue_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue contract performance and value metrics."
  source: "`consumer_goods_ecm`.`finance`.`revenue_contract`"
  dimensions:
    - name: "contract_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the contract became effective."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of the contract."
    - name: "status"
      expr: status
      comment: "Current status of the contract."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates if the contract is set for renewal."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms defined in the contract."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of revenue contracts."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all contracts."
    - name: "total_annual_recurring_revenue"
      expr: SUM(CAST(annual_recurring_revenue AS DOUBLE))
      comment: "Sum of annual recurring revenue from contracts."
    - name: "average_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance obligation KPI metrics."
  source: "`consumer_goods_ecm`.`finance`.`performance_obligation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code linked to the obligation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation."
    - name: "status"
      expr: status
      comment: "Current status of the obligation."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of performance obligations."
    - name: "total_metric_target_value"
      expr: SUM(CAST(metric_target_value AS DOUBLE))
      comment: "Sum of target metric values across obligations."
    - name: "average_actual_metric_value"
      expr: AVG(CAST(actual_metric_value AS DOUBLE))
      comment: "Average actual metric value achieved."
    - name: "total_actual_metric_value"
      expr: SUM(CAST(actual_metric_value AS DOUBLE))
      comment: "Total actual metric value across obligations."
$$;