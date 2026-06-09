-- Metric views for domain: wealth | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_managed_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core portfolio‑level KPIs for wealth management"
  source: "`banking_ecm`.`wealth`.`managed_portfolio`"
  dimensions:
    - name: "portfolio_status"
      expr: managed_portfolio_status
      comment: "Current status of the portfolio (e.g., Active, Closed)"
    - name: "portfolio_strategy"
      expr: portfolio_strategy
      comment: "Strategic classification of the portfolio"
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk profile assigned to the portfolio"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month when the portfolio was activated"
  measures:
    - name: "total_aum"
      expr: SUM(CAST(aum_amount AS DOUBLE))
      comment: "Total assets under management across all portfolios"
    - name: "average_management_fee_rate"
      expr: AVG(CAST(management_fee_rate AS DOUBLE))
      comment: "Average management fee rate applied to portfolios"
    - name: "average_high_water_mark"
      expr: AVG(CAST(high_water_mark AS DOUBLE))
      comment: "Average high‑water mark value across portfolios"
    - name: "portfolio_count"
      expr: COUNT(1)
      comment: "Number of managed portfolios"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_performance_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk metrics for managed portfolios"
  source: "`banking_ecm`.`wealth`.`performance_return`"
  dimensions:
    - name: "period_year"
      expr: DATE_TRUNC('year', period_start_date)
      comment: "Fiscal year of the performance period"
    - name: "managed_portfolio_id"
      expr: managed_portfolio_id
      comment: "Identifier of the managed portfolio"
  measures:
    - name: "average_annualized_return"
      expr: AVG(CAST(annualized_return AS DOUBLE))
      comment: "Average annualized return for the period"
    - name: "average_sharpe_ratio"
      expr: AVG(CAST(sharpe_ratio AS DOUBLE))
      comment: "Average Sharpe ratio across returns"
    - name: "return_record_count"
      expr: COUNT(1)
      comment: "Number of performance return records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_asset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation efficiency and compliance metrics"
  source: "`banking_ecm`.`wealth`.`asset_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., Approved, Pending)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type/category of allocation"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the allocation became effective"
  measures:
    - name: "total_target_weight_percent"
      expr: SUM(CAST(target_weight_percent AS DOUBLE))
      comment: "Sum of target allocation weights across assets"
    - name: "average_drift_percent"
      expr: AVG(CAST(drift_percent AS DOUBLE))
      comment: "Average drift between target and actual weights"
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Number of asset allocation records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_fee_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue‑related fee billing KPIs"
  source: "`banking_ecm`.`wealth`.`fee_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing (e.g., Paid, Pending)"
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the billing period"
  measures:
    - name: "total_gross_fee_amount"
      expr: SUM(CAST(gross_fee_amount AS DOUBLE))
      comment: "Total gross fees billed"
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fees after discounts and waivers"
    - name: "total_fee_discount_amount"
      expr: SUM(CAST(fee_discount_amount AS DOUBLE))
      comment: "Aggregate amount of fee discounts applied"
    - name: "fee_billing_record_count"
      expr: COUNT(1)
      comment: "Number of fee billing records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_portfolio_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holding‑level exposure and valuation metrics"
  source: "`banking_ecm`.`wealth`.`portfolio_holding`"
  dimensions:
    - name: "holding_period_classification"
      expr: holding_period_classification
      comment: "Classification of the holding period (e.g., Short‑Term, Long‑Term)"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the holding"
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Aggregate market value of all holdings"
    - name: "average_portfolio_weight"
      expr: AVG(CAST(portfolio_weight AS DOUBLE))
      comment: "Average weight of holdings within portfolios"
    - name: "holding_record_count"
      expr: COUNT(1)
      comment: "Number of holding records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_rebalancing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for portfolio rebalancing"
  source: "`banking_ecm`.`wealth`.`rebalancing_order`"
  dimensions:
    - name: "rebalancing_method"
      expr: rebalancing_method
      comment: "Method used for rebalancing (e.g., Threshold, Calendar)"
    - name: "execution_month"
      expr: DATE_TRUNC('month', actual_execution_date)
      comment: "Month when the rebalancing order was executed"
  measures:
    - name: "average_drift_tolerance_percentage"
      expr: AVG(CAST(drift_tolerance_percentage AS DOUBLE))
      comment: "Average tolerance for drift used in rebalancing orders"
    - name: "total_estimated_trade_value"
      expr: SUM(CAST(total_estimated_trade_value AS DOUBLE))
      comment: "Sum of estimated trade values for rebalancing"
    - name: "rebalancing_order_count"
      expr: COUNT(1)
      comment: "Number of rebalancing orders executed"
$$;