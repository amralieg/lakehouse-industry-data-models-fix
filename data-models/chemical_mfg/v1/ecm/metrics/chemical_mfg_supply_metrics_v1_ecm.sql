-- Metric views for domain: supply | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order financial summary metrics."
  source: "`chemical_mfg_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order."
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type (e.g., standard, subcontract)."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the order."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier where the order is placed."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the order."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order amounts."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of purchase order creation."
  measures:
    - name: "total_gross_value"
      expr: SUM(CAST(total_gross_value AS DOUBLE))
      comment: "Sum of gross value of all purchase orders."
    - name: "total_net_value"
      expr: SUM(CAST(total_net_value AS DOUBLE))
      comment: "Sum of net value of all purchase orders."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Sum of tax amounts on purchase orders."
    - name: "average_gross_value"
      expr: AVG(CAST(total_gross_value AS DOUBLE))
      comment: "Average gross value per purchase order."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Shipping Notice (ASN) timeliness and logistics metrics."
  source: "`chemical_mfg_ecm`.`supply`.`asn`"
  dimensions:
    - name: "asn_status"
      expr: asn_status
      comment: "Current status of the ASN."
    - name: "asn_type"
      expr: asn_type
      comment: "Type/category of the ASN."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the shipment."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the ASN."
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant code where the ASN is received."
    - name: "shipping_point_code"
      expr: shipping_point_code
      comment: "Shipping point code for the ASN."
    - name: "asn_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the ASN was created."
  measures:
    - name: "total_asn_count"
      expr: COUNT(1)
      comment: "Total number of ASNs."
    - name: "on_time_asn_count"
      expr: SUM(CASE WHEN DATE(actual_arrival_timestamp) <= expected_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of ASNs that arrived on or before the expected delivery date."
    - name: "total_gross_weight"
      expr: SUM(CAST(total_gross_weight AS DOUBLE))
      comment: "Total gross weight of shipments."
    - name: "total_net_weight"
      expr: SUM(CAST(total_net_weight AS DOUBLE))
      comment: "Total net weight of shipments."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery freight and weight efficiency metrics."
  source: "`chemical_mfg_ecm`.`supply`.`inbound_delivery`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor delivering the inbound shipment."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the inbound delivery."
    - name: "actual_arrival_date"
      expr: actual_arrival_date
      comment: "Date the inbound delivery actually arrived."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the inbound delivery."
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Plant code where the delivery is destined."
    - name: "inbound_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the inbound delivery record was created."
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for inbound deliveries."
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight (kg) of inbound deliveries."
    - name: "total_net_weight"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight (kg) of inbound deliveries."
    - name: "inbound_delivery_count"
      expr: COUNT(1)
      comment: "Number of inbound deliveries."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and compliance metrics."
  source: "`chemical_mfg_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that supplied the goods."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where goods were received."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier of the received goods."
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', gr_date)
      comment: "Month of the goods receipt."
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts."
    - name: "damaged_receipt_count"
      expr: SUM(CASE WHEN damage_description IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with reported damage."
    - name: "hazmat_receipt_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipts flagged as hazardous."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all goods receipts."
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard aggregated metrics."
  source: "`chemical_mfg_ecm`.`supply`.`vendor_scorecard`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated."
    - name: "evaluation_period_start_date"
      expr: evaluation_period_start_date
      comment: "Start date of the evaluation period."
    - name: "evaluation_period_end_date"
      expr: evaluation_period_end_date
      comment: "End date of the evaluation period."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score for the vendor."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage."
    - name: "avg_price_variance"
      expr: AVG(CAST(price_variance_pct AS DOUBLE))
      comment: "Average price variance percentage."
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Number of scorecard records."
$$;