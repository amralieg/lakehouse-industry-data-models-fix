-- Metric views for domain: asset | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core holding metrics derived from asset unit register"
  source: "`banking_ecm`.`asset`.`asset_unit_register`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the holding"
    - name: "fund_class_id"
      expr: fund_class_id
      comment: "Fund class identifier"
    - name: "investor_account_id"
      expr: investor_account_id
      comment: "Investor account owning the holding"
    - name: "register_status"
      expr: register_status
      comment: "Current status of the register"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., direct, omnibus)"
    - name: "source_system"
      expr: source_system
      comment: "Originating source system"
    - name: "first_investment_year"
      expr: DATE_TRUNC('year', first_investment_date)
      comment: "Year of first investment"
  measures:
    - name: "register_count"
      expr: COUNT(1)
      comment: "Number of asset unit register records"
    - name: "total_market_value"
      expr: SUM(CAST(current_market_value AS DOUBLE))
      comment: "Total market value of all holdings"
    - name: "total_units_held"
      expr: SUM(CAST(units_held AS DOUBLE))
      comment: "Aggregate number of units held across all registers"
    - name: "average_cost_per_unit"
      expr: AVG(CAST(average_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across holdings"
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Sum of unrealized gain/loss across holdings"
    - name: "average_unrealized_gain_loss_pct"
      expr: AVG(CAST(unrealized_gain_loss_percentage AS DOUBLE))
      comment: "Average unrealized gain/loss percentage"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_fund_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance KPIs for each fund over time"
  source: "`banking_ecm`.`asset`.`fund_performance`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund identifier"
    - name: "fund_class_id"
      expr: fund_class_id
      comment: "Fund class identifier"
    - name: "performance_year"
      expr: DATE_TRUNC('year', calculation_date)
      comment: "Year of the performance calculation"
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Number of performance records"
    - name: "total_return_amount"
      expr: SUM(CAST(total_return_amount AS DOUBLE))
      comment: "Sum of total return amounts"
    - name: "average_sharpe_ratio"
      expr: AVG(CAST(sharpe_ratio AS DOUBLE))
      comment: "Average Sharpe ratio across periods"
    - name: "average_expense_ratio_pct"
      expr: AVG(CAST(expense_ratio_pct AS DOUBLE))
      comment: "Average expense ratio percentage"
    - name: "average_active_return_pct"
      expr: AVG(CAST(active_return_pct AS DOUBLE))
      comment: "Average active return percentage"
    - name: "average_mwr_return_pct"
      expr: AVG(CAST(mwr_return_pct AS DOUBLE))
      comment: "Average money-weighted return percentage"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_fund_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction level financial flows for funds"
  source: "`banking_ecm`.`asset`.`fund_transaction`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund involved in the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., purchase, sale, dividend)"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of fund transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross transaction amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net transaction amounts after fees"
    - name: "total_commission"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid"
    - name: "average_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per transaction"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_investor_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statement level financial summary per investor"
  source: "`banking_ecm`.`asset`.`investor_statement`"
  dimensions:
    - name: "investor_account_id"
      expr: investor_account_id
      comment: "Investor account identifier"
    - name: "statement_year"
      expr: DATE_TRUNC('year', statement_date)
      comment: "Year of the statement"
  measures:
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Number of investor statements generated"
    - name: "total_distributions_amount"
      expr: SUM(CAST(total_distributions_amount AS DOUBLE))
      comment: "Aggregate amount of distributions paid"
    - name: "total_redemptions_amount"
      expr: SUM(CAST(total_redemptions_amount AS DOUBLE))
      comment: "Aggregate amount of redemptions received"
    - name: "total_subscriptions_amount"
      expr: SUM(CAST(total_subscriptions_amount AS DOUBLE))
      comment: "Aggregate amount of new subscriptions"
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Sum of unrealized gains/losses reported"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`asset_nav_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Asset Value and NAV calculations per fund and period"
  source: "`banking_ecm`.`asset`.`nav_record`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund identifier"
  measures:
    - name: "nav_record_count"
      expr: COUNT(1)
      comment: "Number of NAV records"
    - name: "average_nav_per_unit"
      expr: AVG(CAST(nav_per_unit AS DOUBLE))
      comment: "Average NAV per unit across records"
    - name: "total_net_asset_value"
      expr: SUM(CAST(net_asset_value AS DOUBLE))
      comment: "Total net asset value across all funds"
    - name: "average_total_expense_ratio"
      expr: AVG(CAST(total_expense_ratio AS DOUBLE))
      comment: "Average total expense ratio"
$$;