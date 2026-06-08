-- Metric views for domain: logistics | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order cost and weight efficiency metrics"
  source: "`manufacturing_ecm`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier assigned to the freight order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the freight order"
    - name: "order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the freight order was created"
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders"
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Sum of freight cost across all orders"
    - name: "avg_freight_cost"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of goods in freight orders (kg)"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per freight order (kg)"
    - name: "high_priority_orders"
      expr: SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of freight orders marked as high priority"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`logistics_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and safety metrics for bills of lading"
  source: "`manufacturing_ecm`.`logistics`.`bill_of_lading`"
  dimensions:
    - name: "bill_of_lading_status"
      expr: bill_of_lading_status
      comment: "Current status of the BOL"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the BOL"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode indicated on the BOL"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Date the shipment was actually delivered"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the BOL was created"
  measures:
    - name: "total_bols"
      expr: COUNT(1)
      comment: "Total number of bills of lading"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Sum of declared monetary value on all BOLs"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per BOL"
    - name: "hazmat_bol_count"
      expr: SUM(CASE WHEN hazmat_flag THEN 1 ELSE 0 END)
      comment: "Count of BOLs that contain hazardous materials"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics for freight invoicing"
  source: "`manufacturing_ecm`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier linked to the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of the invoice date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the invoice"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Sum of invoiced amounts across all freight invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average invoice amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount captured on invoices"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Count of invoices that have been paid"
$$;