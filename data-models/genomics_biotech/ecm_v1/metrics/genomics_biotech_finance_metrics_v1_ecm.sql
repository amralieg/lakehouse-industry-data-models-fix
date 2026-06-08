-- Metric views for domain: finance | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AP financial exposure metrics"
  source: "`genomics_biotech_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the payable"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payable"
  measures:
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount across all AP records"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_accounts_payable_dpd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payable timing efficiency"
  source: "`genomics_biotech_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
  measures:
    - name: "average_days_payable_outstanding"
      expr: AVG(CAST(DATEDIFF(due_date, invoice_date) AS DOUBLE))
      comment: "Average days between invoice date and due date (DPD)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AR exposure metrics"
  source: "`genomics_biotech_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the receivable"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment"
  measures:
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding AR amount"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_accounts_receivable_dso`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receivable timing efficiency"
  source: "`genomics_biotech_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment"
  measures:
    - name: "average_days_sales_outstanding"
      expr: AVG(CAST(DATEDIFF(due_date, invoice_date) AS DOUBLE))
      comment: "Average days between invoice date and due date for AR (DSO)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution metrics"
  source: "`genomics_biotech_ecm`.`finance`.`finance_budget`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center owning the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "budget_type"
      expr: budget_type
      comment: "Budget classification"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend amount"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset valuation metrics"
  source: "`genomics_biotech_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the asset"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "useful_life_years"
      expr: useful_life_years
      comment: "Planned useful life in years"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition performance metrics"
  source: "`genomics_biotech_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the revenue"
    - name: "revenue_type"
      expr: revenue_type
      comment: "Revenue classification"
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Total gross margin"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core GL posting totals"
  source: "`genomics_biotech_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of posting"
    - name: "gl_account_number"
      expr: gl_account_number
      comment: "GL account number"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center associated with the entry"
  measures:
    - name: "total_debit_amount_local"
      expr: SUM(CAST(debit_amount_local AS DOUBLE))
      comment: "Total debit amount in local currency"
    - name: "total_credit_amount_local"
      expr: SUM(CAST(credit_amount_local AS DOUBLE))
      comment: "Total credit amount in local currency"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance indicators"
  source: "`genomics_biotech_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Associated cost center"
  measures:
    - name: "average_profit_margin_percent"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percent across profit center records"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend amount for the profit center"
$$;