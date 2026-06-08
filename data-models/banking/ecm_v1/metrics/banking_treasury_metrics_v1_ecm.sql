-- Metric views for domain: treasury | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_alco_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive view of ALCO meeting activity and key capital ratio reviews"
  source: "`banking_ecm`.`treasury`.`alco_meeting`"
  dimensions:
    - name: "meeting_date"
      expr: meeting_date
      comment: "Date of the ALCO meeting"
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of ALCO meeting"
    - name: "meeting_status"
      expr: meeting_status
      comment: "Current status of the meeting"
  measures:
    - name: "meeting_count"
      expr: COUNT(1)
      comment: "Total number of ALCO meetings"
    - name: "avg_cet1_ratio_reviewed"
      expr: AVG(CAST(cet1_ratio_reviewed AS DOUBLE))
      comment: "Average CET1 ratio reviewed across meetings"
    - name: "avg_lcr_ratio_reviewed"
      expr: AVG(CAST(lcr_ratio_reviewed AS DOUBLE))
      comment: "Average LCR ratio reviewed across meetings"
    - name: "quorum_achieved_meetings"
      expr: SUM(CASE WHEN quorum_achieved_flag THEN 1 ELSE 0 END)
      comment: "Number of meetings where quorum was achieved"
    - name: "dissenting_opinion_meetings"
      expr: SUM(CASE WHEN dissenting_opinions_flag THEN 1 ELSE 0 END)
      comment: "Number of meetings with dissenting opinions"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_alm_hedge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key hedge performance and exposure metrics for treasury risk management"
  source: "`banking_ecm`.`treasury`.`alm_hedge`"
  dimensions:
    - name: "hedge_instrument_type"
      expr: hedge_instrument_type
      comment: "Type of hedge instrument"
    - name: "hedge_status"
      expr: hedge_status
      comment: "Current status of the hedge"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the hedge"
    - name: "legal_entity_identifier"
      expr: legal_entity_identifier
      comment: "Legal entity identifier for the hedge"
  measures:
    - name: "hedge_count"
      expr: COUNT(1)
      comment: "Total number of hedge records"
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Aggregate notional amount of all hedges"
    - name: "total_fair_value_amount"
      expr: SUM(CAST(fair_value_amount AS DOUBLE))
      comment: "Total fair value of hedged items"
    - name: "avg_hedge_effectiveness_prospective"
      expr: AVG(CAST(hedge_effectiveness_ratio_prospective AS DOUBLE))
      comment: "Average prospective hedge effectiveness ratio"
    - name: "ineffective_hedge_count"
      expr: SUM(CASE WHEN hedge_effectiveness_ratio_prospective < 0.9 THEN 1 ELSE 0 END)
      comment: "Count of hedges with effectiveness below 90%"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_balance_sheet_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated balance‑sheet position metrics for capital and risk monitoring"
  source: "`banking_ecm`.`treasury`.`balance_sheet_position`"
  dimensions:
    - name: "position_date"
      expr: position_date
      comment: "Date of the balance‑sheet position"
    - name: "asset_liability_indicator"
      expr: asset_liability_indicator
      comment: "Indicates whether the position is an asset or liability"
    - name: "business_line"
      expr: business_line
      comment: "Business line associated with the position"
  measures:
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of balance sheet positions"
    - name: "total_market_value"
      expr: SUM(CAST(market_value_amount AS DOUBLE))
      comment: "Total market value across all positions"
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total base currency amount"
    - name: "avg_risk_weight_percent"
      expr: AVG(CAST(risk_weight_percent AS DOUBLE))
      comment: "Average risk weight percent"
    - name: "total_rwa_amount"
      expr: SUM(CAST(rwa_amount AS DOUBLE))
      comment: "Total risk‑weighted assets amount"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_liquidity_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity health metrics used for funding and regulatory monitoring"
  source: "`banking_ecm`.`treasury`.`liquidity_position`"
  dimensions:
    - name: "position_date"
      expr: position_date
      comment: "Date of the liquidity position"
    - name: "position_type"
      expr: position_type
      comment: "Type/category of the liquidity position"
  measures:
    - name: "liquidity_position_count"
      expr: COUNT(1)
      comment: "Number of liquidity position records"
    - name: "total_available_liquidity"
      expr: SUM(CAST(available_liquidity_amount AS DOUBLE))
      comment: "Total available liquidity amount"
    - name: "avg_lcr_ratio"
      expr: AVG(CAST(lcr_ratio AS DOUBLE))
      comment: "Average LCR ratio across positions"
    - name: "avg_nsfr_ratio"
      expr: AVG(CAST(nsfr_ratio AS DOUBLE))
      comment: "Average NSFR ratio across positions"
    - name: "total_cash_balance"
      expr: SUM(CAST(cash_balance AS DOUBLE))
      comment: "Aggregate cash balance"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_capital_ratio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core capital adequacy metrics for regulatory and strategic oversight"
  source: "`banking_ecm`.`treasury`.`capital_ratio`"
  dimensions:
    - name: "reporting_date"
      expr: reporting_date
      comment: "Reporting date for the capital ratio"
  measures:
    - name: "capital_ratio_record_count"
      expr: COUNT(1)
      comment: "Number of capital ratio records"
    - name: "avg_cet1_ratio"
      expr: AVG(CAST(cet1_ratio AS DOUBLE))
      comment: "Average CET1 ratio"
    - name: "avg_tier1_ratio"
      expr: AVG(CAST(tier1_ratio AS DOUBLE))
      comment: "Average Tier‑1 capital ratio"
    - name: "total_capital_amount"
      expr: SUM(CAST(total_capital_amount AS DOUBLE))
      comment: "Total capital amount reported"
    - name: "total_rwa_amount"
      expr: SUM(CAST(total_rwa_amount AS DOUBLE))
      comment: "Total risk‑weighted assets amount"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash‑flow forecasting KPIs supporting liquidity planning and stress testing"
  source: "`banking_ecm`.`treasury`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date of the cash‑flow forecast"
    - name: "business_line"
      expr: business_line
      comment: "Business line for which the forecast is made"
  measures:
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of cash‑flow forecast records"
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash‑flow amount forecasted"
    - name: "total_behavioral_inflow"
      expr: SUM(CAST(behavioral_inflow_amount AS DOUBLE))
      comment: "Total behavioral inflow amount"
    - name: "total_contractual_inflow"
      expr: SUM(CAST(contractual_inflow_amount AS DOUBLE))
      comment: "Total contractual inflow amount"
    - name: "total_behavioral_outflow"
      expr: SUM(CAST(behavioral_outflow_amount AS DOUBLE))
      comment: "Total behavioral outflow amount"
    - name: "total_contractual_outflow"
      expr: SUM(CAST(contractual_outflow_amount AS DOUBLE))
      comment: "Total contractual outflow amount"
$$;