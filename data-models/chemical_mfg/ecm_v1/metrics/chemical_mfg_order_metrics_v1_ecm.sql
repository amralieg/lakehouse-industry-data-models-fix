-- Metric views for domain: order | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for blanket orders, focusing on volume, pricing, rebates and confidentiality."
  source: "`chemical_mfg_ecm`.`order`.`blanket_order`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement governing the blanket order"
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the blanket order"
    - name: "product_grade"
      expr: product_grade
      comment: "Grade of product covered by the blanket order"
    - name: "approval_date"
      expr: approval_date
      comment: "Date the blanket order was approved"
    - name: "effective_from"
      expr: effective_from
      comment: "Start date of the blanket order's effective period"
    - name: "effective_until"
      expr: effective_until
      comment: "End date of the blanket order's effective period"
  measures:
    - name: "blanket_order_count"
      expr: COUNT(1)
      comment: "Total number of blanket orders"
    - name: "total_committed_volume"
      expr: SUM(CAST(total_committed_volume AS DOUBLE))
      comment: "Sum of total committed volume across all blanket orders"
    - name: "average_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit for blanket orders"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount granted across blanket orders"
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity yet to be called off"
    - name: "confidential_order_count"
      expr: SUM(CASE WHEN is_confidential THEN 1 ELSE 0 END)
      comment: "Number of confidential blanket orders"
    - name: "exclusive_order_count"
      expr: SUM(CASE WHEN is_exclusive THEN 1 ELSE 0 END)
      comment: "Number of exclusive blanket orders"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`order_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that capture financial and volume aspects of product inquiries."
  source: "`chemical_mfg_ecm`.`order`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry"
    - name: "product_code"
      expr: product_code
      comment: "Code identifying the product being inquired about"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for pricing in the inquiry"
    - name: "inquiry_timestamp"
      expr: inquiry_timestamp
      comment: "Timestamp when the inquiry was created"
    - name: "delivery_date_required"
      expr: delivery_date_required
      comment: "Requested delivery date for the inquiry"
    - name: "validity_start_date"
      expr: validity_start_date
      comment: "Start of the inquiry's validity period"
    - name: "validity_end_date"
      expr: validity_end_date
      comment: "End of the inquiry's validity period"
  measures:
    - name: "inquiry_count"
      expr: COUNT(1)
      comment: "Total number of inquiries received"
    - name: "total_gross_price_amount"
      expr: SUM(CAST(gross_price_amount AS DOUBLE))
      comment: "Sum of gross price amounts across inquiries"
    - name: "total_net_price_amount"
      expr: SUM(CAST(net_price_amount AS DOUBLE))
      comment: "Sum of net price amounts across inquiries"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount applied to inquiries"
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all inquiries"
    - name: "confidential_inquiry_count"
      expr: SUM(CASE WHEN is_confidential THEN 1 ELSE 0 END)
      comment: "Number of confidential inquiries"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`order_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic quotation metrics focusing on revenue, discounts and win performance."
  source: "`chemical_mfg_ecm`.`order`.`quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the quotation (e.g., Won, Lost, Pending)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quotation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the quotation amounts"
    - name: "quotation_date"
      expr: quotation_date
      comment: "Date the quotation was issued"
    - name: "valid_from"
      expr: valid_from
      comment: "Start date of quotation validity"
    - name: "valid_until"
      expr: valid_until
      comment: "End date of quotation validity"
    - name: "pricing_method"
      expr: pricing_method
      comment: "Method used to price the quotation"
  measures:
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of quotations issued"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross amounts across all quotations"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net amounts across all quotations"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount amount granted across quotations"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to quotations"
    - name: "won_quotation_count"
      expr: SUM(CASE WHEN quotation_status = 'Won' THEN 1 ELSE 0 END)
      comment: "Number of quotations that resulted in a win"
$$;