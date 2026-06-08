-- Metric views for domain: distribution | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics for executive and operations review"
  source: "`food_beverage_ecm`.`distribution`.`shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for the shipment"
    - name: "center_id"
      expr: center_id
      comment: "Distribution center handling the shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates if the shipment contains hazardous material"
    - name: "scheduled_delivery_datetime"
      expr: scheduled_delivery_datetime
      comment: "Planned delivery date and time"
  measures:
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipment records"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Sum of actual weight of all shipments (kg)"
    - name: "total_shipment_volume_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Sum of total cubic volume of all shipments (m3)"
    - name: "average_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN otif_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on‑time according to OTIF compliance"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key fulfillment order KPIs to monitor order efficiency and OTIF performance"
  source: "`food_beverage_ecm`.`distribution`.`fulfillment_order`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier assigned to the fulfillment order"
    - name: "center_id"
      expr: center_id
      comment: "Distribution center fulfilling the order"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment order"
    - name: "priority_code"
      expr: priority_code
      comment: "Business priority of the order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, rush)"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Sum of weight for all fulfillment orders (kg)"
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Sum of volume for all fulfillment orders (m3)"
    - name: "average_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill‑rate across fulfillment orders"
    - name: "on_time_fulfillments"
      expr: SUM(CASE WHEN otif_target_flag THEN 1 ELSE 0 END)
      comment: "Count of orders meeting OTIF target"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_otif_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTIF performance and cost impact metrics for senior leadership"
  source: "`food_beverage_ecm`.`distribution`.`otif_record`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier linked to the OTIF record"
    - name: "center_id"
      expr: center_id
      comment: "Distribution center linked to the OTIF record"
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the OTIF record"
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of OTIF measurement"
  measures:
    - name: "otif_record_count"
      expr: COUNT(1)
      comment: "Number of OTIF records captured"
    - name: "average_otif_composite_score"
      expr: AVG(CAST(otif_composite_score AS DOUBLE))
      comment: "Average OTIF composite score across records"
    - name: "total_penalty_fine_amount"
      expr: SUM(CAST(penalty_fine_amount AS DOUBLE))
      comment: "Total penalty and fine amount associated with OTIF breaches"
    - name: "in_full_rate_numerator"
      expr: SUM(CASE WHEN in_full_flag THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered in full"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for freight invoicing to support cost control decisions"
  source: "`food_beverage_ecm`.`distribution`.`freight_invoice`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier billed on the invoice"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Sum of billed amounts on freight invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discounts applied to freight invoices"
    - name: "average_rate_variance"
      expr: AVG(CAST(rate_variance_amount AS DOUBLE))
      comment: "Average variance between contracted and actual rates"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_cold_chain_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold‑chain quality and compliance metrics for product safety oversight"
  source: "`food_beverage_ecm`.`distribution`.`cold_chain_event`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the cold‑chain event"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU monitored in the event"
    - name: "event_timestamp"
      expr: event_timestamp
      comment: "Timestamp of the cold‑chain event"
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Indicates if a temperature excursion occurred"
  measures:
    - name: "cold_chain_event_count"
      expr: COUNT(1)
      comment: "Total number of cold‑chain monitoring events"
    - name: "total_excursions"
      expr: SUM(CASE WHEN excursion_flag THEN 1 ELSE 0 END)
      comment: "Count of temperature excursions recorded"
    - name: "average_recorded_temperature_celsius"
      expr: AVG(CAST(recorded_temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature during events (°C)"
$$;