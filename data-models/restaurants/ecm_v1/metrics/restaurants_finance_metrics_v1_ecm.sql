-- Metric views for domain: finance | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice financial summary"
  source: "`restaurants_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AP invoices"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per AP invoice"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice financial summary"
  source: "`restaurants_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month"
  measures:
    - name: "ar_invoice_count"
      expr: COUNT(1)
      comment: "Number of AR invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AR invoices"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per AR invoice"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget allocation and planning metrics"
  source: "`restaurants_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code linked to the budget"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center code linked to the budget"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the budget"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for the budget"
  measures:
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount"
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline amount"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance targets"
  source: "`restaurants_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Unique profit center identifier"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the profit center"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area code"
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Current status of the profit center"
    - name: "valid_from_year"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year the profit center became valid"
  measures:
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Number of profit centers"
    - name: "total_ebitda_target_amount"
      expr: SUM(CAST(ebitda_target_amount AS DOUBLE))
      comment: "Total EBITDA target amount across profit centers"
    - name: "total_aov_target_amount"
      expr: SUM(CAST(aov_target_amount AS DOUBLE))
      comment: "Total AOV target amount across profit centers"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ledger balances summary"
  source: "`restaurants_ecm`.`finance`.`ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the ledger entry"
    - name: "ledger_type"
      expr: ledger_type
      comment: "Type of ledger"
    - name: "ledger_category"
      expr: ledger_category
      comment: "Category of ledger"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code associated with the ledger"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ledger amounts"
  measures:
    - name: "ledger_count"
      expr: COUNT(1)
      comment: "Number of ledger records"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across ledgers"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance across ledgers"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run financial totals"
  source: "`restaurants_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment run"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment run"
    - name: "status"
      expr: status
      comment: "Current status of the payment run"
    - name: "payment_run_type"
      expr: payment_run_type
      comment: "Type of payment run"
    - name: "run_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Month of the payment run"
  measures:
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Number of payment runs"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount processed in payment runs"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount processed in payment runs"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount processed in payment runs"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation amounts"
  source: "`restaurants_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Method type of cost allocation"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation"
  measures:
    - name: "cost_allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation records"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated"
$$;