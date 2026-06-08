-- Metric views for domain: procurement | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and volume KPIs for purchase orders"
  source: "`consumer_goods_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order date"
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Sum of all purchase order total values"
    - name: "average_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average purchase order value per order"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial planning KPIs for purchase requisitions"
  source: "`consumer_goods_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Business type of the requisition"
    - name: "requested_month"
      expr: DATE_TRUNC('month', requested_date)
      comment: "Month the requisition was requested"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Sum of estimated total value for requisitions"
    - name: "average_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions"
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Number of purchase requisitions"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier performance KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_period_start_date)
      comment: "Month of the evaluation period start"
  measures:
    - name: "average_overall_weighted_score"
      expr: AVG(CAST(overall_weighted_score AS DOUBLE))
      comment: "Average overall weighted score across suppliers"
    - name: "average_otif_delivery_rate_pct"
      expr: AVG(CAST(otif_delivery_rate_pct AS DOUBLE))
      comment: "Average OTIF delivery rate percentage"
    - name: "average_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate percentage"
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Number of supplier scorecards"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational receipt and valuation KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of goods receipt creation"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all goods receipts"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of received goods"
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial invoice line KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`invoice_line`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of invoice line creation"
  measures:
    - name: "total_line_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net amounts for invoice lines"
    - name: "total_line_tax_amount"
      expr: SUM(CAST(line_tax_amount AS DOUBLE))
      comment: "Sum of tax amounts for invoice lines"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied on invoice lines"
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Number of invoice line records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing efficiency KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "event_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the event was created"
  measures:
    - name: "total_awarded_savings_amount"
      expr: SUM(CAST(awarded_savings_amount AS DOUBLE))
      comment: "Total savings awarded from sourcing events"
    - name: "total_baseline_spend_amount"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend amount for sourcing events"
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Number of sourcing events"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend management KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_name"
      expr: category_name
      comment: "Name of the spend category"
    - name: "category_level"
      expr: category_level
      comment: "Hierarchy level of the category"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the category became effective"
  measures:
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Total annual spend budget across categories"
    - name: "average_contract_coverage_percentage"
      expr: AVG(CAST(contract_coverage_percentage AS DOUBLE))
      comment: "Average contract coverage percentage"
    - name: "spend_category_count"
      expr: COUNT(1)
      comment: "Number of spend categories"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier portfolio health KPIs"
  source: "`consumer_goods_ecm`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier"
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Tier classification of the supplier"
  measures:
    - name: "average_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across suppliers"
    - name: "supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers"
$$;