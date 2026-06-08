-- Metric views for domain: commercial | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_cargo_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for cargo nomination activity"
  source: "`oil_gas_ecm`.`commercial`.`cargo_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the nomination (e.g., pending, confirmed)"
  measures:
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated across all cargo nominations"
    - name: "average_nominated_volume"
      expr: AVG(CAST(nominated_volume AS DOUBLE))
      comment: "Average nominated volume per cargo nomination"
    - name: "total_freight_cost"
      expr: SUM(freight_rate * nominated_volume)
      comment: "Total freight cost calculated as freight rate multiplied by nominated volume"
    - name: "count_nominations"
      expr: COUNT(1)
      comment: "Number of cargo nomination records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_term_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic contract financial metrics"
  source: "`oil_gas_ecm`.`commercial`.`commercial_term_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed, variable)"
  measures:
    - name: "total_contract_value_estimate"
      expr: SUM(CAST(contract_value_estimate AS DOUBLE))
      comment: "Sum of estimated contract values"
    - name: "average_price_differential"
      expr: AVG(CAST(price_differential AS DOUBLE))
      comment: "Average price differential across contracts"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Total volume commitment quantity across contracts"
    - name: "count_contracts"
      expr: COUNT(1)
      comment: "Number of term contracts"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and volume metrics for sales orders"
  source: "`oil_gas_ecm`.`commercial`.`sales_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the sales order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., spot, contract)"
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total monetary value of sales orders"
    - name: "average_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average order value per sales order"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders"
    - name: "total_volume_quantity"
      expr: SUM(CAST(volume_quantity AS DOUBLE))
      comment: "Total volume sold across orders"
    - name: "count_orders"
      expr: COUNT(1)
      comment: "Number of sales order records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_trading_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key trading position performance indicators"
  source: "`oil_gas_ecm`.`commercial`.`trading_position`"
  dimensions:
    - name: "trading_book"
      expr: trading_book
      comment: "Trading book classification"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity identifier for the position"
  measures:
    - name: "total_mark_to_market"
      expr: SUM(CAST(mark_to_market_value AS DOUBLE))
      comment: "Aggregate mark‑to‑market value of trading positions"
    - name: "average_price"
      expr: AVG(CAST(average_price AS DOUBLE))
      comment: "Average price across trading positions"
    - name: "total_physical_volume"
      expr: SUM(CAST(physical_volume AS DOUBLE))
      comment: "Total physical volume held in positions"
    - name: "count_positions"
      expr: COUNT(1)
      comment: "Number of trading position records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_commodity_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exposure risk and performance metrics"
  source: "`oil_gas_ecm`.`commercial`.`commodity_exposure`"
  dimensions:
    - name: "exposure_status"
      expr: exposure_status
      comment: "Current status of the exposure (e.g., active, closed)"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity for the exposure"
  measures:
    - name: "total_notional_value_usd"
      expr: SUM(CAST(notional_value_usd AS DOUBLE))
      comment: "Total notional value of commodity exposures in USD"
    - name: "total_mark_to_market_usd"
      expr: SUM(CAST(mark_to_market_value_usd AS DOUBLE))
      comment: "Aggregate mark‑to‑market value of exposures in USD"
    - name: "average_hedge_effectiveness"
      expr: AVG(CAST(hedge_effectiveness_percentage AS DOUBLE))
      comment: "Average hedge effectiveness percentage"
    - name: "total_net_exposure_boe"
      expr: SUM(CAST(net_exposure_boe AS DOUBLE))
      comment: "Total net exposure measured in barrels of oil equivalent"
    - name: "count_exposures"
      expr: COUNT(1)
      comment: "Number of commodity exposure records"
$$;