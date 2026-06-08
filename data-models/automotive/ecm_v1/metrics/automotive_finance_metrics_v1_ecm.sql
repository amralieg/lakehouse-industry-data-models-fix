-- Metric views for domain: finance | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_accruals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accruals KPI view – tracks total and average accrual amounts and tax exposure across fiscal periods and cost centers."
  source: "`automotive_ecm`.`finance`.`accrual`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Identifier of the cost center linked to the accrual"
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type/category of the accrual"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual"
    - name: "accrual_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Accrual month for time‑based analysis"
  measures:
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Number of accrual records"
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for accruals"
    - name: "average_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per record"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_ap_invoices`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice view – provides spend visibility, discounts and tax impact."
  source: "`automotive_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date"
  measures:
    - name: "ap_invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AP invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted on AP invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_ar_invoices`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice view – tracks revenue, tax and collection performance."
  source: "`automotive_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "customer_party_id"
      expr: customer_party_id
      comment: "Customer party identifier"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center linked to the invoice"
    - name: "invoice_status"
      expr: ar_invoice_status
      comment: "Current status of the AR invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice posting"
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
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_received_date, due_date))
      comment: "Average days between due date and actual payment receipt"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_budget_lines`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line view – compares planned vs revised amounts and tracks quantity metrics."
  source: "`automotive_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the line"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account for the line"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the line"
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Current status of the budget line"
  measures:
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned (budgeted) amount"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised (actual) amount"
    - name: "total_line_quantity"
      expr: SUM(CAST(line_quantity AS DOUBLE))
      comment: "Sum of line quantities"
    - name: "avg_line_quantity"
      expr: AVG(CAST(line_quantity AS DOUBLE))
      comment: "Average line quantity"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_capex_requests`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capex request view – monitors investment budgeting, spend and financial performance indicators."
  source: "`automotive_ecm`.`finance`.`capex_request`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capex request"
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Current approval/status of the request"
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the request"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month when the request was submitted"
  measures:
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Number of capital expenditure requests"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for capex requests"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend recorded for approved capex"
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return across requests"
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_vehicle_profitability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle profitability view – key profitability levers for each model/line."
  source: "`automotive_ecm`.`finance`.`vehicle_profitability`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the profitability record"
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle product line"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center responsible for the vehicle"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (e.g., dealer, direct)"
  measures:
    - name: "vehicle_count"
      expr: COUNT(1)
      comment: "Number of vehicle profitability records"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_msrp AS DOUBLE))
      comment: "Total gross revenue (MSRP) across vehicles"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Total gross margin amount"
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution from vehicles"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after discounts and incentives"
    - name: "avg_gross_margin"
      expr: AVG(CAST(gross_margin AS DOUBLE))
      comment: "Average gross margin per vehicle"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_warranty_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty reserve view – tracks reserve adequacy and claim exposure."
  source: "`automotive_ecm`.`finance`.`warranty_reserve`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reserve record"
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle line associated with the reserve"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "reserve_status"
      expr: warranty_reserve_status
      comment: "Current status of the warranty reserve"
  measures:
    - name: "warranty_reserve_count"
      expr: COUNT(1)
      comment: "Number of warranty reserve records"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total amount set aside for warranty reserves"
    - name: "total_warranty_claims_amount"
      expr: SUM(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Total amount of warranty claims incurred"
    - name: "avg_reserve_balance"
      expr: AVG(CAST(reserve_balance AS DOUBLE))
      comment: "Average remaining reserve balance"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_manufacturing_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing cost view – enables cost variance analysis and efficiency monitoring."
  source: "`automotive_ecm`.`finance`.`manufacturing_cost`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the production order"
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle product line"
  measures:
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost incurred"
    - name: "total_standard_material_cost"
      expr: SUM(CAST(standard_material_cost AS DOUBLE))
      comment: "Standard (budgeted) material cost"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred"
    - name: "total_standard_labor_cost"
      expr: SUM(CAST(standard_labor_cost AS DOUBLE))
      comment: "Standard (budgeted) labor cost"
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost (all categories)"
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) manufacturing cost"
    - name: "avg_cost_variance_percent"
      expr: AVG(CAST(cost_variance_percent AS DOUBLE))
      comment: "Average cost variance percentage across records"
$$;