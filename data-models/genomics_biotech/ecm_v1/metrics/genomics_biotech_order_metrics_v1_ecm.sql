-- Metric views for domain: order | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level order‑level financial and fulfillment KPIs"
  source: "`genomics_biotech_ecm`.`order`.`header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., Open, Closed)"
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Sum of all order total values (gross) across orders"
    - name: "total_net_value"
      expr: SUM(CAST(total_net_value AS DOUBLE))
      comment: "Sum of net order values after discounts and adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_fulfillment_lead_days"
      expr: AVG(DATEDIFF(actual_delivery_date, order_date))
      comment: "Average number of days between order date and actual delivery date"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_header_by_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order value and count broken out by channel and type"
  source: "`genomics_biotech_ecm`.`order`.`header`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., Standard, Custom)"
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Sum of order total values"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line‑level revenue, quantity and discount KPIs"
  source: "`genomics_biotech_ecm`.`order`.`line`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the product"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the line (e.g., Pending, Shipped)"
    - name: "sequencing_service_type"
      expr: sequencing_service_type
      comment: "Type of sequencing service requested"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where the line is produced"
    - name: "regulatory_designation"
      expr: regulatory_designation
      comment: "Regulatory classification of the product"
  measures:
    - name: "total_line_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Sum of net value for all order lines"
    - name: "total_line_total_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Sum of total (gross) value for all order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered across all lines"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to order lines"
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of order line records"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance and weight KPIs"
  source: "`genomics_biotech_ecm`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., Standard, Express)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Delivery month for time‑based analysis"
  measures:
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Number of delivery records"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Sum of gross weight for all deliveries"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(total_net_weight_kg AS DOUBLE))
      comment: "Sum of net weight for all deliveries"
    - name: "avg_delivery_delay_days"
      expr: AVG(DATEDIFF(delivery_date, estimated_delivery_date))
      comment: "Average days delivery lag versus estimate"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`order_trade_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance risk and high‑risk check counts"
  source: "`genomics_biotech_ecm`.`order`.`trade_compliance_check`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Result of the compliance check (e.g., Approved, Denied)"
    - name: "product_category"
      expr: product_category
      comment: "Product category under review"
    - name: "product_sku"
      expr: product_sku
      comment: "SKU of the product being checked"
    - name: "customer_country_code"
      expr: customer_country_code
      comment: "ISO country code of the customer"
  measures:
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Aggregate risk score across all compliance checks"
    - name: "high_risk_check_count"
      expr: SUM(CASE WHEN risk_score > 80 THEN 1 ELSE 0 END)
      comment: "Count of checks with risk score above 80 (high risk)"
    - name: "check_count"
      expr: COUNT(1)
      comment: "Total number of trade compliance checks"
$$;