-- Metric views for domain: procurement | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and efficiency KPIs for purchase orders"
  source: "`construction_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO amounts"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the PO"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the PO belongs"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the PO"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the PO"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of PO creation"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value in currency of the PO"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "total_gmp_amount"
      expr: SUM(CAST(gmp_amount AS DOUBLE))
      comment: "Total guaranteed maximum price amount across all POs"
    - name: "avg_gmp_amount"
      expr: AVG(CAST(gmp_amount AS DOUBLE))
      comment: "Average GMP amount per PO"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount held across all POs"
    - name: "avg_retention_amount"
      expr: AVG(CAST(retention_amount AS DOUBLE))
      comment: "Average retention amount per PO"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
    - name: "gmp_po_count"
      expr: SUM(CASE WHEN gmp_flag THEN 1 ELSE 0 END)
      comment: "Count of POs flagged as GMP"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receipt and quantity variance KPIs for goods receipts"
  source: "`construction_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that supplied the goods"
    - name: "material_catalog_id"
      expr: material_catalog_id
      comment: "Material catalog identifier"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project associated with the receipt"
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date the goods were received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt value"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Result of inspection on receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered"
    - name: "total_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of goods receipts"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received items"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
    - name: "variance_quantity"
      expr: SUM(ordered_quantity - received_quantity)
      comment: "Net variance between ordered and received quantities"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk scores from vendor evaluations"
  source: "`construction_ecm`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (e.g., annual, project)"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation"
    - name: "evaluation_year"
      expr: DATE_TRUNC('year', evaluation_date)
      comment: "Year of the evaluation"
  measures:
    - name: "avg_overall_kpi_rating"
      expr: AVG(CAST(overall_kpi_rating AS DOUBLE))
      comment: "Average overall KPI rating for vendors"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score"
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planning and budgeting KPIs for purchase requisitions"
  source: "`construction_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Strategic approach for procurement"
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the requisition"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the requisition was created"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost across requisitions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_total_cost AS DOUBLE))
      comment: "Average estimated cost per requisition"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requested"
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per requisition"
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Number of purchase requisitions"
$$;