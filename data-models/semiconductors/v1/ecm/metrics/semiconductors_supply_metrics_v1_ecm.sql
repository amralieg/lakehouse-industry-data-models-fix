-- Metric views for domain: supply | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core purchase order financial and volume KPIs"
  source: "`semiconductors_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
    - name: "order_type"
      expr: purchase_order_type
      comment: "Type of purchase order (e.g., standard, blanket)"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the order"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order creation"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount across all purchase orders"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount across all purchase orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items ordered"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per line item"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk KPIs for goods receipt events"
  source: "`semiconductors_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier that delivered the goods"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of goods received"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of goods received"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of items received"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score for receipts"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics cost and risk KPIs for inbound shipments"
  source: "`semiconductors_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the shipment"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the shipment"
    - name: "shipment_status"
      expr: inbound_shipment_status
      comment: "Current status of the inbound shipment"
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for the shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., air, sea)"
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_timestamp)
      comment: "Month of shipment"
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for inbound shipments"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of inbound shipments (kg)"
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of inbound shipments (m3)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across shipments"
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Number of inbound shipment records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier risk and sustainability KPIs"
  source: "`semiconductors_ecm`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of the supplier"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of supplier (e.g., tier 1, tier 2)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the supplier is registered"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the supplier"
  measures:
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across suppliers"
    - name: "average_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across suppliers"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit granted to suppliers"
    - name: "supplier_count"
      expr: COUNT(1)
      comment: "Total number of active suppliers"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost, duration, and risk outcomes of supplier audits"
  source: "`semiconductors_ecm`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., completed, pending)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit performed"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier being audited"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (e.g., financial, compliance)"
  measures:
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_usd AS DOUBLE))
      comment: "Total cost of supplier audits in USD"
    - name: "average_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average duration of supplier audits (hours)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score derived from audits"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of supplier audit records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quantity and value forecasts for supply planning"
  source: "`semiconductors_ecm`.`supply`.`supply_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., demand, supply)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecasted values"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the forecast"
    - name: "forecast_month"
      expr: DATE_TRUNC('month', horizon_start_date)
      comment: "Forecast horizon start month"
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted quantity for the period"
    - name: "total_forecast_value_usd"
      expr: SUM(price_per_unit * quantity)
      comment: "Total forecasted monetary value (price per unit * quantity)"
    - name: "average_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average forecasted price per unit"
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;