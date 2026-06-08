-- Metric views for domain: order | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key order‑level financial and timing KPIs"
  source: "`manufacturing_ecm`.`order`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_type"
      expr: order_type
      comment: "Business type of the order"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority classification of the order"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_placed_timestamp)
      comment: "Month of order placement"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross amount for all orders"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net amount for all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Sum of tax amount for all orders"
    - name: "average_gross_amount"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross amount per order"
    - name: "average_net_amount"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net amount per order"
    - name: "average_order_to_delivery_days"
      expr: AVG(DATEDIFF(requested_delivery_date, order_placed_timestamp))
      comment: "Average number of days between order placement and requested delivery date"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line‑level revenue and quantity KPIs"
  source: "`manufacturing_ecm`.`order`.`line`"
  dimensions:
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU identifier for the line item"
    - name: "plant"
      expr: plant
      comment: "Plant where the line is produced/fulfilled"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the line"
    - name: "line_number"
      expr: line_number
      comment: "Line number within the order"
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of order lines"
    - name: "line_gross_price_total"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Total gross price across all lines"
    - name: "line_net_price_total"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price across all lines"
    - name: "quantity_ordered_total"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "average_gross_price"
      expr: AVG(CAST(gross_price AS DOUBLE))
      comment: "Average gross price per line"
    - name: "average_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line"
    - name: "average_quantity_per_line"
      expr: AVG(CAST(requested_quantity AS DOUBLE))
      comment: "Average ordered quantity per line"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance and cost KPIs"
  source: "`manufacturing_ecm`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., standard, express)"
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier handling the delivery"
  measures:
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Number of deliveries"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total freight cost for deliveries"
    - name: "average_freight_amount"
      expr: AVG(CAST(freight_total_amount AS DOUBLE))
      comment: "Average freight cost per delivery"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN actual_delivery_date <= planned_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of deliveries that arrived on or before the planned date"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service‑level agreement KPIs"
  source: "`manufacturing_ecm`.`order`.`fulfillment_sla`"
  dimensions:
    - name: "sla_name"
      expr: sla_name
      comment: "Descriptive name of the SLA"
    - name: "sla_type"
      expr: sla_type
      comment: "Category/type of SLA"
    - name: "expedite_eligible"
      expr: expedite_eligible
      comment: "Whether the SLA allows expedited handling"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when SLA became effective"
  measures:
    - name: "sla_count"
      expr: COUNT(1)
      comment: "Number of SLA records"
    - name: "average_on_time_threshold_pct"
      expr: AVG(CAST(on_time_delivery_threshold_pct AS DOUBLE))
      comment: "Average on‑time delivery threshold percentage across SLAs"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract‑level commitment and release KPIs"
  source: "`manufacturing_ecm`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed, variable)"
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Whether Just‑In‑Time delivery is enabled"
    - name: "plant"
      expr: plant
      comment: "Plant associated with the blanket order"
    - name: "region"
      expr: region
      comment: "Geographic region of the blanket order"
  measures:
    - name: "blanket_order_count"
      expr: COUNT(1)
      comment: "Number of blanket orders"
    - name: "total_committed_quantity"
      expr: SUM(CAST(total_committed_quantity AS DOUBLE))
      comment: "Total quantity committed under blanket orders"
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total monetary value committed"
    - name: "cumulative_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Cumulative quantity released to date"
    - name: "cumulative_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Cumulative value released to date"
$$;