-- Metric views for domain: finance | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AP invoice KPIs for cash management and supplier performance"
  source: "`manufacturing_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "currency"
      expr: currency
      comment: "Invoice currency code"
    - name: "invoice_year"
      expr: DATE_TRUNC('year', invoice_date)
      comment: "Fiscal year of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of the invoice"
    - name: "due_year"
      expr: DATE_TRUNC('year', due_date)
      comment: "Year of invoice due date"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code associated with the invoice"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center charged"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts across all AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts and taxes"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "average_payment_delay_days"
      expr: AVG(DATEDIFF(payment_date, due_date))
      comment: "Average number of days between due date and actual payment date"
    - name: "discount_taken_total"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total cash discounts taken on paid invoices"
    - name: "overdue_amount_total"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE() AND payment_status != 'Paid' THEN net_amount ELSE 0 END)
      comment: "Total net amount of invoices that are past due and not yet paid"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_ar_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable health metrics for collection effectiveness"
  source: "`manufacturing_ecm`.`finance`.`ar_item`"
  dimensions:
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the AR item"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the AR item"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Predefined aging bucket category"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR item"
    - name: "due_year"
      expr: DATE_TRUNC('year', due_date)
      comment: "Year of due date"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of due date"
    - name: "posting_year"
      expr: DATE_TRUNC('year', posting_date)
      comment: "Fiscal year of posting"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Fiscal month of posting"
  measures:
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (unpaid) amount across AR items"
    - name: "total_overdue_amount"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE() AND cleared_flag = FALSE THEN open_amount ELSE 0 END)
      comment: "Total amount overdue and not cleared"
    - name: "ar_item_count"
      expr: COUNT(1)
      comment: "Number of AR items"
    - name: "average_days_outstanding"
      expr: AVG(DATEDIFF(CURRENT_DATE(), due_date))
      comment: "Average days outstanding based on due date"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation efficiency and distribution metrics"
  source: "`manufacturing_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for allocation"
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of allocation"
    - name: "allocation_year"
      expr: DATE_TRUNC('year', allocation_date)
      comment: "Fiscal year of allocation"
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year attribute"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period attribute"
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total amount allocated across all cost allocations"
    - name: "average_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of allocation records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_financial_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic financial planning KPIs for budgeting and forecasting"
  source: "`manufacturing_ecm`.`finance`.`financial_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of financial plan (e.g., annual, rolling)"
    - name: "plan_owner_department"
      expr: plan_owner_department
      comment: "Department owning the plan"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the plan amounts"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the plan"
    - name: "plan_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year derived from plan effective start date"
  measures:
    - name: "total_capex_plan_amount"
      expr: SUM(CAST(capex_plan_amount AS DOUBLE))
      comment: "Sum of capital expenditure planned amounts"
    - name: "total_opex_plan_amount"
      expr: SUM(CAST(opex_plan_amount AS DOUBLE))
      comment: "Sum of operating expenditure planned amounts"
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Sum of revenue planned amounts"
    - name: "ebitda_target_total"
      expr: SUM(CAST(ebitda_target_amount AS DOUBLE))
      comment: "Total EBITDA target across all plans"
    - name: "financial_plan_count"
      expr: COUNT(1)
      comment: "Number of financial plan records"
$$;