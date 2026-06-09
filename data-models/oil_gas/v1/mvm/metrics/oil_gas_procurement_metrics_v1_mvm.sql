-- Metric views for domain: procurement | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial KPIs for purchase orders"
  source: "`oil_gas_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_date"
      expr: po_date
      comment: "Purchase order date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category of procurement"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
  measures:
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_po_value_usd AS DOUBLE))
      comment: "Total purchase order value in USD"
    - name: "total_po_value_local"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value in transaction currency"
    - name: "average_po_value_usd"
      expr: AVG(CAST(total_po_value_usd AS DOUBLE))
      comment: "Average purchase order value in USD"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders"
    - name: "count_purchase_orders"
      expr: COUNT(1)
      comment: "Number of purchase order records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and compliance KPIs for vendors"
  source: "`oil_gas_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "evaluation_date"
      expr: evaluation_date
      comment: "Date of the performance evaluation"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (e.g., quarterly, annual)"
  measures:
    - name: "avg_commercial_compliance_score"
      expr: AVG(CAST(commercial_compliance_score AS DOUBLE))
      comment: "Average commercial compliance score"
    - name: "avg_cost_competitiveness_score"
      expr: AVG(CAST(cost_competitiveness_score AS DOUBLE))
      comment: "Average cost competitiveness score"
    - name: "avg_hse_score"
      expr: AVG(CAST(hse_score AS DOUBLE))
      comment: "Average HSE (Health, Safety, Environment) score"
    - name: "avg_quality_acceptance_rate_percent"
      expr: AVG(CAST(quality_acceptance_rate_percent AS DOUBLE))
      comment: "Average quality acceptance rate percent"
    - name: "avg_on_time_delivery_rate_percent"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on‑time delivery rate percent"
    - name: "count_vendor_performance_records"
      expr: COUNT(1)
      comment: "Number of vendor performance evaluation records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_afe_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution KPIs for Authorization for Expenditure (AFE)"
  source: "`oil_gas_ecm`.`procurement`.`afe_budget`"
  dimensions:
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Actual completion date of the AFE"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the AFE"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the AFE"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts"
    - name: "project_number"
      expr: project_number
      comment: "Project number linked to the AFE"
  measures:
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend against AFE"
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend AS DOUBLE))
      comment: "Total committed spend"
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage"
    - name: "count_afe_records"
      expr: COUNT(1)
      comment: "Number of AFE budget records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving KPIs for goods receipts"
  source: "`oil_gas_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_date"
      expr: gr_date
      comment: "Goods receipt date"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt transaction"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where goods were received"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received"
    - name: "total_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of goods received"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received items"
    - name: "count_goods_receipts"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs for supplier management"
  source: "`oil_gas_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (e.g., service, material)"
    - name: "country"
      expr: country
      comment: "Country where vendor is located"
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates if vendor is currently active"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates if vendor is marked as preferred"
  measures:
    - name: "count_vendors"
      expr: COUNT(1)
      comment: "Total number of vendor records"
    - name: "count_active_vendors"
      expr: SUM(CASE WHEN active_flag THEN 1 ELSE 0 END)
      comment: "Number of active vendors"
    - name: "count_preferred_vendors"
      expr: SUM(CASE WHEN preferred_vendor_flag THEN 1 ELSE 0 END)
      comment: "Number of preferred vendors"
    - name: "count_small_business_vendors"
      expr: SUM(CASE WHEN small_business_flag THEN 1 ELSE 0 END)
      comment: "Number of small‑business vendors"
$$;