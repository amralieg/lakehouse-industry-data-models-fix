-- Metric views for domain: finance | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key AP invoice financial KPIs for cash‑flow and vendor management"
  source: "`energy_utilities_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code of the invoicing entity"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for time‑based analysis"
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross amount invoiced across all AP invoices"
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after discounts and taxes"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per invoice"
    - name: "average_payment_delay_days"
      expr: AVG(DATEDIFF(payment_run_date, invoice_date))
      comment: "Average number of days between invoice date and payment run date"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Count of AP invoices"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AP payment execution KPIs to monitor cash outflow efficiency"
  source: "`energy_utilities_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor receiving the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, Wire)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment"
    - name: "payment_run_month"
      expr: DATE_TRUNC('month', payment_run_date)
      comment: "Month of the payment run"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid to vendors"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Net payment amount after discounts and taxes"
    - name: "average_payment_delay_days"
      expr: AVG(DATEDIFF(value_date, document_date))
      comment: "Average days between document date and value date"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of AP payments processed"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed‑asset valuation and depreciation health metrics for asset management"
  source: "`energy_utilities_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation"
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Associated power plant identifier"
  measures:
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Aggregate net book value of all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Cumulative depreciation recorded"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed assets recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_capex_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPEX spending KPIs to track investment efficiency"
  source: "`energy_utilities_ecm`.`finance`.`capex_expenditure`"
  dimensions:
    - name: "capital_project_id"
      expr: capital_project_id
      comment: "Project linked to the CAPEX spend"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center bearing the expense"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the capital asset"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "rab_eligible_flag"
      expr: rab_eligible_flag
      comment: "Regulatory asset base eligibility flag"
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with CAPEX"
    - name: "average_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average CAPEX amount per transaction"
    - name: "capex_expenditure_count"
      expr: COUNT(1)
      comment: "Number of CAPEX expenditure records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_treasury_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity and risk metrics for treasury management"
  source: "`energy_utilities_ecm`.`finance`.`treasury_position`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code of the treasury entity"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the treasury position"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of financial instrument (e.g., loan, bond)"
    - name: "position_status"
      expr: position_status
      comment: "Current status of the position"
    - name: "treasury_gl_account_id"
      expr: treasury_gl_account_id
      comment: "GL account linked to the treasury position"
  measures:
    - name: "total_statement_balance"
      expr: SUM(CAST(statement_balance AS DOUBLE))
      comment: "Aggregate statement balance across treasury positions"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance of treasury instruments"
    - name: "average_debt_service_coverage_ratio"
      expr: AVG(CAST(debt_service_coverage_ratio AS DOUBLE))
      comment: "Average DSCR indicating liquidity health"
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of treasury positions recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL account inventory and compliance overview"
  source: "`energy_utilities_ecm`.`finance`.`gl_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Classification of the GL account"
    - name: "account_group"
      expr: account_group
      comment: "Group to which the account belongs"
    - name: "company_code"
      expr: company_code
      comment: "Company code owning the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the account balances"
    - name: "rab_eligible_flag"
      expr: rab_eligible_flag
      comment: "Regulatory asset base eligibility flag"
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of GL accounts"
    - name: "sox_controlled_account_count"
      expr: SUM(CASE WHEN sox_control_flag THEN 1 ELSE 0 END)
      comment: "Number of accounts flagged for SOX control"
$$;