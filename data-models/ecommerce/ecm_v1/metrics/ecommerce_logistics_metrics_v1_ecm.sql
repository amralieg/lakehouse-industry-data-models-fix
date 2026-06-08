-- Metric views for domain: logistics | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key logistics shipment performance metrics for executive and operational insight"
  source: "`ecommerce_ecm`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the shipment"
    - name: "carrier_service_code"
      expr: carrier_service_code
      comment: "Service code used for the shipment"
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for the shipment"
    - name: "destination_country"
      expr: destination_country
      comment: "Country of destination for the shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Business classification of the shipment (e.g., standard, express)"
    - name: "logistics_shipment_status"
      expr: logistics_shipment_status
      comment: "Current status of the shipment"
    - name: "shipping_cost_currency"
      expr: shipping_cost_currency
      comment: "Currency of the shipping cost"
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Flag indicating hazardous material presence"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments recorded"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Aggregate weight of all shipments (kg)"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_total_amount AS DOUBLE))
      comment: "Sum of total shipping cost across shipments, in the shipment currency"
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost_total_amount AS DOUBLE))
      comment: "Average shipping cost per shipment"
    - name: "hazardous_shipment_count"
      expr: SUM(CASE WHEN is_hazardous_material THEN 1 ELSE 0 END)
      comment: "Count of shipments flagged as hazardous material"
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on or before the estimated delivery date"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic freight order KPIs to monitor cost, volume, and priority handling"
  source: "`ecommerce_ecm`.`logistics`.`freight_order`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for the freight order"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Financial cost center linked to the order"
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order"
    - name: "freight_order_type"
      expr: freight_order_type
      comment: "Classification of the freight order (e.g., import, export)"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Boolean flag indicating if the order is high priority"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode used (e.g., truck, rail, air)"
    - name: "shipping_terms"
      expr: shipping_terms
      comment: "Incoterms or shipping terms applied"
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders"
    - name: "total_agreed_rate_amount"
      expr: SUM(CAST(agreed_rate_amount AS DOUBLE))
      comment: "Sum of agreed rate amounts across freight orders"
    - name: "avg_freight_weight"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per freight order (kg)"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped across orders (cubic meters)"
    - name: "high_priority_order_count"
      expr: SUM(CASE WHEN priority_flag THEN 1 ELSE 0 END)
      comment: "Count of freight orders marked as high priority"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_transport_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial efficiency metrics for transportation operations"
  source: "`ecommerce_ecm`.`logistics`.`transport_cost`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the transport cost"
    - name: "route_id"
      expr: route_id
      comment: "Route identifier for the transport"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Mode of transport (e.g., road, sea, air)"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (e.g., fuel, tolls)"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g., fixed, variable)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost amounts"
  measures:
    - name: "total_transport_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total transport cost incurred"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with transport costs"
    - name: "avg_cost_per_mile"
      expr: AVG(cost_amount / NULLIF(distance_km, 0))
      comment: "Average cost per mile (or km) across transport records"
    - name: "late_delivery_count"
      expr: SUM(CASE WHEN is_late_delivery THEN 1 ELSE 0 END)
      comment: "Count of transport cost records flagged as late delivery"
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total number of transport cost records"
$$;