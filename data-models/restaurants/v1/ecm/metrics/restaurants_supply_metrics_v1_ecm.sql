-- Metric views for domain: supply | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key receipt KPIs for inbound goods, tracking cost, quantity, and compliance."
  source: "`restaurants_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_date"
      expr: DATE_TRUNC('day', receipt_timestamp)
      comment: "Date of goods receipt"
    - name: "distribution_center_id"
      expr: distribution_center_id
      comment: "Distribution center identifier"
    - name: "supplier_id"
      expr: procurement_supplier_id
      comment: "Supplier identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "receipt_status"
      expr: goods_receipt_status
      comment: "Current status of the receipt"
  measures:
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity received"
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of received goods"
    - name: "average_cost_per_unit"
      expr: AVG(total_cost/NULLIF(total_quantity,0))
      comment: "Average cost per unit received"
    - name: "cold_chain_compliant_count"
      expr: SUM(CASE WHEN is_cold_chain_compliant THEN 1 ELSE 0 END)
      comment: "Count of receipts compliant with cold chain requirements"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line‑level receipt metrics for quality and cost analysis."
  source: "`restaurants_ecm`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "sku"
      expr: sku
      comment: "Stock keeping unit of the item"
    - name: "lot_number"
      expr: lot_number
      comment: "Lot identifier"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Result of line inspection"
    - name: "supplier_id"
      expr: procurement_supplier_id
      comment: "Supplier identifier"
    - name: "receipt_id"
      expr: goods_receipt_id
      comment: "Parent receipt identifier"
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of receipt line records"
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Sum of line total cost"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Sum of quantity received on line"
    - name: "perishable_line_count"
      expr: SUM(CASE WHEN is_perishable THEN 1 ELSE 0 END)
      comment: "Count of perishable items"
    - name: "quality_score_average"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score for lines"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance and cost KPIs for inbound logistics."
  source: "`restaurants_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport"
    - name: "scheduled_arrival_date"
      expr: DATE_TRUNC('day', scheduled_arrival_timestamp)
      comment: "Scheduled arrival date"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether shipment was expedited"
  measures:
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms"
    - name: "total_volume_cubic_m"
      expr: SUM(CAST(volume_cubic_m AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "expedited_shipment_count"
      expr: SUM(CASE WHEN is_expedited THEN 1 ELSE 0 END)
      comment: "Count of expedited shipments"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance indicators for lead time, fill rate and quality."
  source: "`restaurants_ecm`.`supply`.`supplier_performance`"
  dimensions:
    - name: "rating_tier"
      expr: rating_tier
      comment: "Supplier rating tier"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of performance measurement"
    - name: "supplier_id"
      expr: procurement_supplier_id
      comment: "Supplier identifier"
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Number of performance records"
    - name: "average_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across records"
    - name: "average_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate"
    - name: "average_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate"
    - name: "total_orders_evaluated"
      expr: SUM(CAST(total_orders_evaluated AS DOUBLE))
      comment: "Total orders evaluated in period"
    - name: "total_invoices_evaluated"
      expr: SUM(CAST(total_invoices_evaluated AS DOUBLE))
      comment: "Total invoices evaluated in period"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient cost and nutrition KPIs for sourcing decisions."
  source: "`restaurants_ecm`.`supply`.`ingredient`"
  dimensions:
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of ingredient"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where ingredient originates"
    - name: "organic_flag"
      expr: organic_flag
      comment: "Whether ingredient is certified organic"
    - name: "halal_flag"
      expr: halal_flag
      comment: "Halal certification flag"
    - name: "kosher_flag"
      expr: kosher_flag
      comment: "Kosher certification flag"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient"
  measures:
    - name: "ingredient_count"
      expr: COUNT(1)
      comment: "Number of ingredient records"
    - name: "average_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit"
    - name: "average_calories_per_unit"
      expr: AVG(CAST(nutritional_calories_per_unit AS DOUBLE))
      comment: "Average calories per unit"
    - name: "average_protein_percent"
      expr: AVG(CAST(protein_content_percent AS DOUBLE))
      comment: "Average protein content percent"
    - name: "average_fat_percent"
      expr: AVG(CAST(fat_content_percent AS DOUBLE))
      comment: "Average fat content percent"
    - name: "average_carbohydrate_percent"
      expr: AVG(CAST(carbohydrate_content_percent AS DOUBLE))
      comment: "Average carbohydrate content percent"
    - name: "average_sodium_mg_per_unit"
      expr: AVG(CAST(sodium_mg_per_unit AS DOUBLE))
      comment: "Average sodium mg per unit"
    - name: "average_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall event impact metrics for risk and compliance monitoring."
  source: "`restaurants_ecm`.`supply`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity level of the recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall"
    - name: "product_category"
      expr: product_category
      comment: "Category of the recalled product"
    - name: "recall_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when recall was created"
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "FDA compliance flag"
    - name: "compliance_haccp"
      expr: compliance_haccp
      comment: "HACCP compliance flag"
    - name: "compliance_usda"
      expr: compliance_usda
      comment: "USDA compliance flag"
  measures:
    - name: "recall_event_count"
      expr: COUNT(1)
      comment: "Number of recall events"
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity recalled"
    - name: "total_recall_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost associated with recalls"
$$;