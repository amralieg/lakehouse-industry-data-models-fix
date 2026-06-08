-- Metric views for domain: procurement | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial KPIs for purchase orders"
  source: "`ecommerce_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the order"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating if the order is marked urgent"
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Flag indicating drop‑ship orders"
    - name: "purchasing_org"
      expr: purchasing_org
      comment: "Purchasing organization responsible for the order"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per purchase order"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk metrics for suppliers"
  source: "`ecommerce_ecm`.`procurement`.`supplier_performance`"
  dimensions:
    - name: "evaluation_period_id"
      expr: evaluation_period_id
      comment: "Evaluation period identifier"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the supplier"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the performance scorecard"
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across suppliers"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate"
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead‑time adherence rate"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_compliance_score AS DOUBLE))
      comment: "Average sustainability compliance score"
    - name: "avg_cost_variance_pct"
      expr: AVG(CAST(procurement_cost_variance_pct AS DOUBLE))
      comment: "Average procurement cost variance percentage"
    - name: "supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers evaluated"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key sourcing efficiency metrics from RFQ process"
  source: "`ecommerce_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ"
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Strategic approach used for sourcing"
    - name: "category_name"
      expr: category_name
      comment: "Category of goods/services requested"
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "awarded_rfq_count"
      expr: SUM(CASE WHEN award_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of RFQs that resulted in an award"
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average awarded contract amount"
    - name: "avg_estimated_annual_spend"
      expr: AVG(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Average estimated annual spend across RFQs"
    - name: "avg_realized_savings"
      expr: AVG(CAST(realized_savings AS DOUBLE))
      comment: "Average realized savings from awarded RFQs"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier portfolio health metrics"
  source: "`ecommerce_ecm`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of supplier (e.g., manufacturer, distributor)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the supplier is based"
  measures:
    - name: "supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers"
    - name: "diversity_supplier_count"
      expr: SUM(CASE WHEN is_diversity_supplier THEN 1 ELSE 0 END)
      comment: "Number of suppliers flagged as diversity suppliers"
    - name: "preferred_vendor_count"
      expr: SUM(CASE WHEN is_preferred_vendor THEN 1 ELSE 0 END)
      comment: "Number of preferred vendors"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across suppliers"
    - name: "gdpr_compliant_count"
      expr: SUM(CASE WHEN gdpr_compliant THEN 1 ELSE 0 END)
      comment: "Number of GDPR‑compliant suppliers"
    - name: "iso_certified_count"
      expr: SUM(CASE WHEN iso_certified THEN 1 ELSE 0 END)
      comment: "Number of ISO‑certified suppliers"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractual and SLA performance metrics for vendors"
  source: "`ecommerce_ecm`.`procurement`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed‑price, time‑and‑materials)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the contract"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total monetary value of all vendor contracts"
    - name: "avg_contract_duration_days"
      expr: AVG(CAST(DATEDIFF(expiry_date, effective_date) AS DOUBLE))
      comment: "Average contract length in days"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of active vendor contracts"
    - name: "avg_sla_defect_rate_pct"
      expr: AVG(CAST(sla_defect_rate_pct AS DOUBLE))
      comment: "Average SLA defect rate percentage"
    - name: "avg_sla_fill_rate_pct"
      expr: AVG(CAST(sla_fill_rate_pct AS DOUBLE))
      comment: "Average SLA fill rate percentage"
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_pct AS DOUBLE))
      comment: "Average SLA on‑time delivery percentage"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for goods receipt processing"
  source: "`ecommerce_ecm`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "gr_posting_date"
      expr: gr_posting_date
      comment: "Date the goods receipt was posted"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three‑way match (matched/unmatched)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Result of quality inspection"
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Flag indicating hazardous material"
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of items received"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of items rejected on receipt"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for receipts"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt events"
$$;