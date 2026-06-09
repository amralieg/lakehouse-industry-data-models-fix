-- Metric views for domain: procurement | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core purchase order financial and volume KPIs"
  source: "`automotive_ecm`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_number"
      expr: po_number
      comment: "Purchase order identifier"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the PO"
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order"
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group responsible for the PO"
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the PO is destined"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order date"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of purchase orders"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per purchase order"
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity ordered across all purchase orders"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`procurement_spend_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend transaction financial KPIs"
  source: "`automotive_ecm`.`procurement`.`spend_transaction`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category of the transaction"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant associated with the transaction"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code"
    - name: "supplier_id"
      expr: procurement_supplier_id
      comment: "Supplier involved in the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the transaction"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of spend transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross spend amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend amount"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per transaction"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`procurement_supplier_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier evaluation performance metrics"
  source: "`automotive_ecm`.`procurement`.`supplier_evaluation`"
  dimensions:
    - name: "supplier_id"
      expr: procurement_supplier_id
      comment: "Supplier being evaluated"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_date)
      comment: "Month of the evaluation"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (e.g., annual, ad-hoc)"
    - name: "evaluator_employee_id"
      expr: evaluator_employee_id
      comment: "Employee who performed the evaluation"
    - name: "supplier_region"
      expr: supplier_region
      comment: "Geographic region of the supplier"
  measures:
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Number of supplier evaluations performed"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier evaluation score"
    - name: "average_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across evaluations"
    - name: "average_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`procurement_approval_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval process efficiency and spend impact"
  source: "`automotive_ecm`.`procurement`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval"
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the approver"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the approval is for a critical transaction"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_timestamp)
      comment: "Month of the approval action"
  measures:
    - name: "approval_count"
      expr: COUNT(1)
      comment: "Number of approval records"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved"
    - name: "average_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved amount per record"
    - name: "auto_approval_count"
      expr: SUM(CASE WHEN is_auto_approved THEN 1 ELSE 0 END)
      comment: "Count of approvals that were auto‑approved"
$$;