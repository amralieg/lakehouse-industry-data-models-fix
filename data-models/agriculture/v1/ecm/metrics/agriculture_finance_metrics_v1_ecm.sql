-- Metric views for domain: finance | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_ap_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial metrics at the AP invoice line level"
  source: "`agriculture_ecm`.`finance`.`ap_invoice_line`"
  dimensions:
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity associated with the invoice line"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the expense"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "General ledger account linked to the line"
    - name: "vendor_contract_id"
      expr: vendor_contract_id
      comment: "Vendor contract reference"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "Indicates whether the line is CAPEX or OPEX"
    - name: "gmo_indicator"
      expr: gmo_indicator
      comment: "Whether the commodity is GMO"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of delivery for time‑based analysis"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoiced line amount across all AP invoice lines"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoice lines"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoice lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods/services invoiced"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines"
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Count of AP invoice line records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated AP payment metrics"
  source: "`agriculture_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code of the payment"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the payment"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account used for the payment"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor receiving the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, Check)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for time‑based analysis"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after deductions"
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total discounts taken on payments"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset valuation and depreciation metrics"
  source: "`agriculture_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code owning the asset"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the asset"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account linked to the asset"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset (e.g., Machinery, Buildings)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation"
    - name: "acquisition_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year the asset was acquired"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation to date"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed asset records"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life (years) across assets"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of capital projects"
  source: "`agriculture_ecm`.`finance`.`capital_project`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code sponsoring the project"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center associated with the project"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the project"
    - name: "planned_start_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Planned start year for time‑based analysis"
    - name: "planned_completion_year"
      expr: DATE_TRUNC('year', planned_completion_date)
      comment: "Planned completion year"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost for capital projects"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total cost that has been committed"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for projects"
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across projects"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of capital project records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loan portfolio exposure and pricing metrics"
  source: "`agriculture_ecm`.`finance`.`loan`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code of the loan"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the loan"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account linked to the loan"
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the loan"
    - name: "loan_type"
      expr: loan_type
      comment: "Type of loan (e.g., term, revolving)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the loan"
    - name: "origination_year"
      expr: DATE_TRUNC('year', origination_date)
      comment: "Year the loan was originated"
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding loan balance"
    - name: "total_principal_amount"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total principal amount across loans"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate of loans"
    - name: "loan_count"
      expr: COUNT(1)
      comment: "Number of loan records"
$$;