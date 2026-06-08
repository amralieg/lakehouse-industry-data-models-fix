-- Metric views for domain: trading | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trade activity metrics capturing volume, value and pricing."
  source: "`energy_utilities_ecm`.`trading`.`trade`"
  dimensions:
    - name: "trade_date"
      expr: trade_date
      comment: "Date of the trade."
    - name: "market_type"
      expr: market_type
      comment: "Market classification (e.g., day-ahead, real-time)."
    - name: "commodity"
      expr: commodity
      comment: "Commodity being traded."
    - name: "trade_status"
      expr: trade_status
      comment: "Current status of the trade."
  measures:
    - name: "trade_count"
      expr: COUNT(1)
      comment: "Number of trades."
    - name: "total_trade_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Sum of trade monetary value."
    - name: "total_quantity_mwh"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity traded (MWh)."
    - name: "average_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average price per unit across trades."
    - name: "total_collateral_posted"
      expr: SUM(CAST(collateral_posted AS DOUBLE))
      comment: "Total collateral posted for trades."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_market_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement financials by date, market and currency."
  source: "`energy_utilities_ecm`.`trading`.`market_settlement`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of the settlement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the settlement."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement record."
  measures:
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of settlement records."
    - name: "total_settlement_amount"
      expr: SUM(CAST(total_settlement_amount AS DOUBLE))
      comment: "Total monetary amount settled."
    - name: "total_energy_charge"
      expr: SUM(CAST(energy_charge_amount AS DOUBLE))
      comment: "Sum of energy charges across settlements."
    - name: "total_congestion_charge"
      expr: SUM(CAST(congestion_charge_amount AS DOUBLE))
      comment: "Sum of congestion charges across settlements."
    - name: "total_imbalance_charge"
      expr: SUM(CAST(imbalance_charge_amount AS DOUBLE))
      comment: "Sum of imbalance charges across settlements."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_capacity_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capacity obligation performance indicators."
  source: "`energy_utilities_ecm`.`trading`.`capacity_obligation`"
  dimensions:
    - name: "auction_date"
      expr: auction_date
      comment: "Date of the capacity auction."
    - name: "capacity_market_program"
      expr: capacity_market_program
      comment: "Program under which capacity was procured."
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO identifier."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the capacity obligation."
  measures:
    - name: "total_committed_capacity_mw"
      expr: SUM(CAST(committed_capacity_mw AS DOUBLE))
      comment: "Total committed capacity (MW) across obligations."
    - name: "total_capacity_shortfall_mw"
      expr: SUM(CAST(capacity_shortfall_mw AS DOUBLE))
      comment: "Total capacity shortfall (MW) across obligations."
    - name: "total_capacity_cost_usd"
      expr: SUM(CAST(total_capacity_cost_usd AS DOUBLE))
      comment: "Total cost of capacity obligations in USD."
    - name: "average_clearing_price_per_mw_day"
      expr: AVG(CAST(capacity_clearing_price_per_mw_day AS DOUBLE))
      comment: "Average clearing price per MW‑day."
    - name: "average_required_capacity_mw"
      expr: AVG(CAST(required_capacity_mw AS DOUBLE))
      comment: "Average required capacity (MW)."
    - name: "average_committed_capacity_mw"
      expr: AVG(CAST(committed_capacity_mw AS DOUBLE))
      comment: "Average committed capacity (MW)."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_credit_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit exposure health metrics for risk management."
  source: "`energy_utilities_ecm`.`trading`.`credit_exposure`"
  dimensions:
    - name: "exposure_status"
      expr: exposure_status
      comment: "Status of the exposure record."
    - name: "counterparty_id"
      expr: counterparty_id
      comment: "Counterparty identifier."
    - name: "exposure_currency_code"
      expr: exposure_currency_code
      comment: "Currency of the exposure amount."
    - name: "exposure_as_of_date"
      expr: exposure_as_of_date
      comment: "Date the exposure was measured."
  measures:
    - name: "exposure_count"
      expr: COUNT(1)
      comment: "Number of credit exposure records."
    - name: "total_exposure_amount"
      expr: SUM(CAST(total_exposure_amount AS DOUBLE))
      comment: "Total exposure amount across counterparties."
    - name: "average_credit_limit_utilization_pct"
      expr: AVG(CAST(credit_limit_utilization_pct AS DOUBLE))
      comment: "Average credit limit utilization percentage."
    - name: "total_margin_call_amount"
      expr: SUM(CAST(margin_call_threshold_amount AS DOUBLE))
      comment: "Sum of margin call threshold amounts."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`trading_ancillary_service_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost metrics for ancillary service awards."
  source: "`energy_utilities_ecm`.`trading`.`ancillary_service_award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current status of the award."
    - name: "service_type"
      expr: service_type
      comment: "Type of ancillary service awarded."
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO identifier."
    - name: "award_month"
      expr: DATE_TRUNC('month', market_interval_start)
      comment: "Month of the award interval start."
  measures:
    - name: "award_count"
      expr: COUNT(1)
      comment: "Number of ancillary service awards."
    - name: "total_deployment_payment"
      expr: SUM(CAST(deployment_payment AS DOUBLE))
      comment: "Total payment for service deployment."
    - name: "average_cleared_price_per_mw"
      expr: AVG(CAST(cleared_price_per_mw AS DOUBLE))
      comment: "Average cleared price per MW."
    - name: "total_procurement_cost"
      expr: SUM(CAST(total_procurement_cost AS DOUBLE))
      comment: "Total procurement cost for ancillary services."
    - name: "total_actual_deployment_mw"
      expr: SUM(CAST(actual_deployment_mw AS DOUBLE))
      comment: "Total actual deployment in MW."
$$;