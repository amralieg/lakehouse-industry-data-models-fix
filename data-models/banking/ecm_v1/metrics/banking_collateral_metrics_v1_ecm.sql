-- Metric views for domain: collateral | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for collateral assets, supporting capital and risk management decisions"
  source: "`banking_ecm`.`collateral`.`collateral_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of collateral asset (e.g., security, cash)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g., active, pledged)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the asset"
    - name: "valuation_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of the valuation date"
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Total market value of all collateral assets"
    - name: "average_market_value"
      expr: AVG(CAST(market_value AS DOUBLE))
      comment: "Average market value per collateral asset"
    - name: "total_risk_weighted_assets"
      expr: SUM(risk_weight_percentage * market_value)
      comment: "Sum of risk-weighted exposure (risk weight % * market value) across assets"
    - name: "eligible_market_value"
      expr: SUM(CASE WHEN eligibility_flag THEN market_value ELSE 0 END)
      comment: "Market value of assets that are eligible as collateral"
    - name: "count_assets"
      expr: COUNT(1)
      comment: "Number of collateral asset records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation metrics that inform asset re‑pricing and risk exposure"
  source: "`banking_ecm`.`collateral`.`collateral_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used for valuation (e.g., market, model)"
    - name: "valuation_source"
      expr: valuation_source
      comment: "Source system or provider of the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of the valuation date"
  measures:
    - name: "total_gross_market_value"
      expr: SUM(CAST(gross_market_value AS DOUBLE))
      comment: "Total gross market value from collateral valuations"
    - name: "total_net_collateral_value"
      expr: SUM(CAST(net_collateral_value AS DOUBLE))
      comment: "Total net collateral value after adjustments"
    - name: "average_value_change_pct"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage change in valuation amounts"
    - name: "count_valuations"
      expr: COUNT(1)
      comment: "Number of valuation records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`collateral_margin_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin call KPIs used for liquidity and margin management"
  source: "`banking_ecm`.`collateral`.`collateral_margin_call`"
  dimensions:
    - name: "call_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month of the margin call"
    - name: "call_direction"
      expr: call_direction
      comment: "Direction of the call (e.g., inbound, outbound)"
    - name: "margin_call_status"
      expr: margin_call_status
      comment: "Current status of the margin call"
  measures:
    - name: "total_margin_call_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of margin calls issued"
    - name: "average_margin_call_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average margin call amount per event"
    - name: "count_margin_calls"
      expr: COUNT(1)
      comment: "Number of margin call events"
$$;