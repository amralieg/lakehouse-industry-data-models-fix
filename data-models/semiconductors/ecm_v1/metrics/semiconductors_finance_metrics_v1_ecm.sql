-- Metric views for domain: finance | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset valuation and utilization metrics for the finance domain"
  source: "`semiconductors_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset (e.g., equipment, building)"
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Sum of accumulated depreciation across assets"
    - name: "average_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage of assets"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed asset records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPEX request volume and approval effectiveness"
  source: "`semiconductors_ecm`.`finance`.`capex_request`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node targeted by the request"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment being requested"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of the CAPEX request"
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(request_amount AS DOUBLE))
      comment: "Total amount requested in CAPEX requests"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for CAPEX requests"
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Number of CAPEX request records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budgeting totals and variance tracking"
  source: "`semiconductors_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan"
    - name: "cost_center_code"
      expr: cost_center_id
      comment: "Cost center linked to the budget plan"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operational, capital)"
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned amount in local currency for budget plans"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_to_prior_year_amount AS DOUBLE))
      comment: "Sum of variance to prior year across budget plans"
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Number of budget plan records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial flow and tax impact of intercompany transactions"
  source: "`semiconductors_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "cost_center_code"
      expr: cost_center_id
      comment: "Cost center associated with the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the transaction"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount of intercompany transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax amount across intercompany transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount after tax for intercompany transactions"
    - name: "intercompany_transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transaction records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance against budget"
  source: "`semiconductors_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Unique code identifying the profit center"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the profit center"
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the profit center"
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend recorded for profit centers"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for profit centers"
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Number of profit center records"
$$;