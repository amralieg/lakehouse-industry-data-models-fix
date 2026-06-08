-- Metric views for domain: procurement | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and planning KPIs for purchase orders"
  source: "`agriculture_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the purchase order"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity being purchased"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "po_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO issuance"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value in base currency"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value per order"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
    - name: "avg_lead_time_days"
      expr: AVG(DATEDIFF(requested_delivery_date, po_date))
      comment: "Average planned lead time (days) between PO date and requested delivery"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPIs for goods receipts"
  source: "`agriculture_ecm`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that supplied the goods"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity of the received goods"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the receipt (e.g., posted, pending)"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all receipts"
    - name: "total_received_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total monetary value of received goods"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received items"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
    - name: "avg_quantity_variance"
      expr: AVG(CAST(ordered_quantity - received_quantity AS DOUBLE))
      comment: "Average variance between ordered and received quantities"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial liability KPIs for accounts payable invoices"
  source: "`agriculture_ecm`.`procurement`.`procurement_ap_invoice`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor billed on the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and taxes"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "avg_days_to_due"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average days between invoice date and due date"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic financial control KPIs for budgeting"
  source: "`agriculture_ecm`.`procurement`.`budget`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., active, closed)"
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity the budget pertains to"
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend against budgets"
    - name: "total_allocated"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to budgets"
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining (unspent) budget amount"
    - name: "avg_spend_to_budget_pct"
      expr: AVG(CAST(spend_to_budget_pct AS DOUBLE))
      comment: "Average spend-to-budget percentage"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance and compliance KPIs"
  source: "`agriculture_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (e.g., raw material, service)"
    - name: "country_code"
      expr: country_code
      comment: "Country where vendor is based"
    - name: "sds_compliance_flag"
      expr: sds_compliance_flag
      comment: "Whether vendor provides SDS compliance"
    - name: "fsma_svcp_compliant"
      expr: fsma_svcp_compliant
      comment: "FSMA compliance status"
  measures:
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across vendors"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate"
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Number of active vendors"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing and cost estimation KPIs for RFQs"
  source: "`agriculture_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ"
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing (e.g., competitive, direct)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the RFQ"
    - name: "rfq_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the RFQ was created"
  measures:
    - name: "total_target_price"
      expr: SUM(CAST(target_price AS DOUBLE))
      comment: "Sum of target prices across RFQs"
    - name: "avg_target_price"
      expr: AVG(CAST(target_price AS DOUBLE))
      comment: "Average target price per RFQ"
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Number of RFQs issued"
    - name: "avg_eval_weight_price"
      expr: AVG(CAST(eval_weight_price AS DOUBLE))
      comment: "Average evaluation weight for price"
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity requested in RFQs"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_approved_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and procurement policy KPIs for approved vendor items"
  source: "`agriculture_ecm`.`procurement`.`approved_vendor_item`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that received approval"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of pricing"
    - name: "certification_verified_flag"
      expr: certification_verified_flag
      comment: "Whether certification was verified"
    - name: "lead_time_days"
      expr: lead_time_days
      comment: "Documented lead time category"
  measures:
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price for approved items"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost for approved items"
    - name: "avg_minimum_order_qty"
      expr: AVG(CAST(minimum_order_qty AS DOUBLE))
      comment: "Average minimum order quantity"
    - name: "approved_item_count"
      expr: COUNT(1)
      comment: "Number of approved vendor items"
$$;