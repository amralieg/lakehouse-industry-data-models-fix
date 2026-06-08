-- Metric views for domain: sales | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key order‑level performance metrics for revenue, margin and order volume"
  source: "`consumer_goods_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization code"
    - name: "division"
      expr: division
      comment: "Division code"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which the order was received"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Identifier of the trade account"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
    - name: "total_order_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total order amount (gross)"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin amount"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "average_order_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order amount per order"
    - name: "average_gross_margin"
      expr: AVG(CAST(gross_margin_amount AS DOUBLE))
      comment: "Average gross margin per order"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial summary of invoicing activity"
  source: "`consumer_goods_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of the billing period"
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End of the billing period"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding amount across invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid on invoices"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point‑of‑sale transaction performance metrics"
  source: "`consumer_goods_ecm`.`sales`.`pos_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the POS transaction"
    - name: "store_name"
      expr: store_name
      comment: "Retail store where the transaction occurred"
    - name: "sku"
      expr: sku
      comment: "SKU identifier of the product sold"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account associated with the transaction"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for the transaction"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Promotion type applied, if any"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of POS transactions"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold across transactions"
    - name: "total_sales_value"
      expr: SUM(CAST(retail_selling_price AS DOUBLE))
      comment: "Sum of retail selling price per transaction"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied at POS"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku)
      comment: "Number of unique SKUs sold"
$$;