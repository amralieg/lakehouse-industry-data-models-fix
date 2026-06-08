-- Metric views for domain: invoice | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`invoice_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key invoice financial performance metrics at invoice level."
  source: "`semiconductors_ecm`.`invoice`.`ar_invoice`"
  dimensions:
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for time-based analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "customer_name"
      expr: customer_name
      comment: "Name of the customer"
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating if invoice is a credit memo"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice"
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Business status of the AR invoice"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount invoiced"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount invoiced"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "average_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per invoice"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`invoice_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment receipt performance metrics."
  source: "`semiconductors_ecm`.`invoice`.`payment_receipt`"
  dimensions:
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "overpayment_flag"
      expr: overpayment_flag
      comment: "Indicates if payment exceeds invoice amount"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment receipts"
    - name: "total_payment_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount received (including tax)"
    - name: "total_net_payment"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount"
    - name: "average_net_payment"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per receipt"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line item level revenue and quantity metrics."
  source: "`semiconductors_ecm`.`invoice`.`invoice_line`"
  dimensions:
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing month of the line item"
    - name: "product_sku"
      expr: product_sku
      comment: "SKU of the product"
    - name: "product_name"
      expr: product_name
      comment: "Name of the product"
    - name: "sales_region"
      expr: sales_region
      comment: "Region where the sale occurred"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel of the sale"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line"
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of invoice line items"
    - name: "total_line_gross"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount across line items"
    - name: "total_line_net"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity sold"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per line item"
$$;