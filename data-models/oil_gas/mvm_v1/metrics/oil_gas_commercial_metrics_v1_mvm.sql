-- Metric views for domain: commercial | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order financial performance"
  source: "`oil_gas_ecm`.`commercial`.`sales_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center associated with the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing the transaction"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order"
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total monetary value of sales orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on sales orders"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all order lines"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of sales orders"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line‑level revenue and volume metrics"
  source: "`oil_gas_ecm`.`commercial`.`sales_order_line`"
  dimensions:
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product being sold"
    - name: "vessel_id"
      expr: vessel_id
      comment: "Vessel used for transport"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis for the line"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm for the line"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the line"
    - name: "delivery_date"
      expr: delivery_date
      comment: "Scheduled delivery date"
  measures:
    - name: "line_amount_total"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total line amount across all sales order lines"
    - name: "confirmed_quantity_total"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity shipped"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per line"
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of sales order lines"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_trading_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk metrics for trading positions"
  source: "`oil_gas_ecm`.`commercial`.`trading_position`"
  dimensions:
    - name: "position_date"
      expr: position_date
      comment: "Date of the trading position"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code of the position"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of hedging instrument"
    - name: "trading_book"
      expr: trading_book
      comment: "Trading book identifier"
  measures:
    - name: "net_volume_total"
      expr: SUM(CAST(net_volume AS DOUBLE))
      comment: "Total net volume across trading positions"
    - name: "mark_to_market_total"
      expr: SUM(CAST(mark_to_market_value AS DOUBLE))
      comment: "Aggregate mark‑to‑market value"
    - name: "average_market_price"
      expr: AVG(CAST(market_price AS DOUBLE))
      comment: "Average market price for positions"
    - name: "average_hedge_effectiveness"
      expr: AVG(CAST(hedge_effectiveness_ratio AS DOUBLE))
      comment: "Average hedge effectiveness ratio"
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of trading positions"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_hedging_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial metrics for hedging instruments"
  source: "`oil_gas_ecm`.`commercial`.`hedging_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of hedging instrument"
    - name: "underlying_commodity"
      expr: underlying_commodity
      comment: "Underlying commodity being hedged"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the instrument"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the instrument became effective"
  measures:
    - name: "notional_volume_total"
      expr: SUM(CAST(notional_volume AS DOUBLE))
      comment: "Total notional volume of hedging instruments"
    - name: "fair_value_total"
      expr: SUM(CAST(fair_value_amount AS DOUBLE))
      comment: "Aggregate fair value of hedging instruments"
    - name: "average_ceiling_price"
      expr: AVG(CAST(ceiling_price AS DOUBLE))
      comment: "Average ceiling price across instruments"
    - name: "collateral_total"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral posted for hedging instruments"
    - name: "instrument_count"
      expr: COUNT(1)
      comment: "Number of hedging instruments"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`commercial_cargo_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for cargo nominations"
  source: "`oil_gas_ecm`.`commercial`.`cargo_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the nomination"
    - name: "nomination_date"
      expr: nomination_date
      comment: "Date the nomination was made"
    - name: "vessel_type"
      expr: vessel_type
      comment: "Type of vessel nominated"
    - name: "loading_port_code"
      expr: loading_port_code
      comment: "Loading port code"
    - name: "discharge_port_code"
      expr: discharge_port_code
      comment: "Discharge port code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the nomination"
  measures:
    - name: "nominated_volume_total"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated for cargo"
    - name: "average_demurrage_rate"
      expr: AVG(CAST(demurrage_rate AS DOUBLE))
      comment: "Average demurrage rate across nominations"
    - name: "average_freight_rate"
      expr: AVG(CAST(freight_rate AS DOUBLE))
      comment: "Average freight rate across nominations"
    - name: "average_price_differential"
      expr: AVG(CAST(price_differential AS DOUBLE))
      comment: "Average price differential applied"
    - name: "nomination_count"
      expr: COUNT(1)
      comment: "Number of cargo nominations"
$$;