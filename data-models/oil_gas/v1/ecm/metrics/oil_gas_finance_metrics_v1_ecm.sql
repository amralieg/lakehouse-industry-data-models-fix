-- Metric views for domain: finance | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key payable metrics to monitor cash obligations and vendor exposure"
  source: "`oil_gas_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code owning the payable"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods/services"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payable"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., Paid, Pending)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payable"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of accounts payable records (invoices)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_accounts_payable_amounts`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated monetary exposure from accounts payable"
  source: "`oil_gas_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code owning the payable"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amounts"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of all payables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across payables"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount captured on payables"
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payable amount expressed in local currency"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_actual_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost tracking at the actual cost line level"
  source: "`oil_gas_ecm`.`finance`.`actual_cost`"
  dimensions:
    - name: "finance_afe_id"
      expr: finance_afe_id
      comment: "Associated AFE identifier"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center responsible"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor linked to the cost"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category classification"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the cost was posted"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of actual cost records"
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cost amount recorded"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity associated with costs"
    - name: "average_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average cost amount per record"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level budgeting overview"
  source: "`oil_gas_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center the budget applies to"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center the budget applies to"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., Approved, Draft)"
    - name: "budget_type"
      expr: budget_type
      comment: "Budget classification (e.g., Capex, Opex)"
  measures:
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted amount"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_cash_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity and cash‑flow health metrics"
  source: "`oil_gas_ecm`.`finance`.`cash_management`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the cash snapshot"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cash amounts"
    - name: "cash_position_type"
      expr: cash_position_type
      comment: "Type of cash position (e.g., Operating, Investing)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of cash‑management snapshots"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Aggregate closing cash balance"
    - name: "total_net_change"
      expr: SUM(CAST(net_change_amount AS DOUBLE))
      comment: "Total net cash change for the period"
    - name: "total_inflow_operating"
      expr: SUM(CAST(inflow_operating_amount AS DOUBLE))
      comment: "Total operating cash inflows"
    - name: "total_outflow_operating"
      expr: SUM(CAST(outflow_operating_amount AS DOUBLE))
      comment: "Total operating cash outflows"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_financial_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core profitability and expense metrics from financial statements"
  source: "`oil_gas_ecm`.`finance`.`financial_statement`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the statement"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code reporting the statement"
    - name: "reporting_currency_code"
      expr: reporting_currency_code
      comment: "Currency used for reporting"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of financial statements"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Aggregate EBITDA across statements"
    - name: "total_opex"
      expr: SUM(CAST(opex_amount AS DOUBLE))
      comment: "Aggregate operating expenditures"
    - name: "total_capex"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Aggregate capital expenditures"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_hedge_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and market exposure metrics for hedging activities"
  source: "`oil_gas_ecm`.`finance`.`hedge_position`"
  dimensions:
    - name: "hedge_type"
      expr: hedge_type
      comment: "Type of hedge (e.g., Commodity, FX)"
    - name: "hedged_commodity"
      expr: hedged_commodity
      comment: "Commodity being hedged"
    - name: "currency_pair"
      expr: currency_pair
      comment: "Currency pair for FX hedges"
    - name: "hedge_status"
      expr: hedge_status
      comment: "Current status of the hedge"
    - name: "trade_date"
      expr: trade_date
      comment: "Trade date of the hedge"
  measures:
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of hedge positions"
    - name: "total_fair_value"
      expr: SUM(CAST(current_fair_value AS DOUBLE))
      comment: "Aggregate current fair value of hedges"
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Total unrealized P&L from hedges"
    - name: "total_realized_gain_loss"
      expr: SUM(CAST(realized_gain_loss AS DOUBLE))
      comment: "Total realized P&L from hedges"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`finance_project_economics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Economic performance indicators for capital projects"
  source: "`oil_gas_ecm`.`finance`.`project_economics`"
  dimensions:
    - name: "project_id"
      expr: project_id
      comment: "Identifier of the project"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the estimates"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of project economics records"
    - name: "total_gross_npv"
      expr: SUM(CAST(gross_npv AS DOUBLE))
      comment: "Aggregate gross Net Present Value across projects"
    - name: "total_net_npv"
      expr: SUM(CAST(net_npv AS DOUBLE))
      comment: "Aggregate net Net Present Value across projects"
    - name: "average_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average Internal Rate of Return across projects"
    - name: "total_capex"
      expr: SUM(CAST(total_capex AS DOUBLE))
      comment: "Total capital expenditures projected"
    - name: "total_opex"
      expr: SUM(CAST(total_opex AS DOUBLE))
      comment: "Total operating expenditures projected"
$$;