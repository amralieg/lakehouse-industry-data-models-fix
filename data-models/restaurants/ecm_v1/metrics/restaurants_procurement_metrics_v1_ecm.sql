-- Metric views for domain: procurement | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spend and urgency metrics at the purchase order level"
  source: "`restaurants_ecm`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type classification of the purchase order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the purchase order"
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created"
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date promised for delivery"
    - name: "procurement_supplier_id"
      expr: procurement_supplier_id
      comment: "Identifier of the supplier linked to the purchase order"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit receiving the order"
  measures:
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_gross_spend"
      expr: SUM(CAST(total_amount_gross AS DOUBLE))
      comment: "Sum of gross amount for all purchase orders"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amount for all purchase orders"
    - name: "average_gross_spend"
      expr: AVG(CAST(total_amount_gross AS DOUBLE))
      comment: "Average gross spend per purchase order"
    - name: "urgent_po_count"
      expr: SUM(CASE WHEN is_urgent THEN 1 ELSE 0 END)
      comment: "Count of purchase orders marked as urgent"
    - name: "consolidated_po_count"
      expr: SUM(CASE WHEN is_consolidated THEN 1 ELSE 0 END)
      comment: "Count of purchase orders that are consolidated"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics at the PO line level"
  source: "`restaurants_ecm`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line"
    - name: "line_type"
      expr: line_type
      comment: "Classification of the PO line (e.g., material, service)"
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the line item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the line transaction"
    - name: "procurement_purchase_order_id"
      expr: procurement_purchase_order_id
      comment: "Parent purchase order identifier"
  measures:
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO line items"
    - name: "total_line_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amount across all PO lines"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts applied on PO lines"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across PO lines"
    - name: "late_line_count"
      expr: SUM(CASE WHEN is_late THEN 1 ELSE 0 END)
      comment: "Count of PO lines delivered late"
    - name: "three_way_match_count"
      expr: SUM(CASE WHEN is_three_way_match THEN 1 ELSE 0 END)
      comment: "Count of PO lines that passed three‑way match"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and dispute tracking for supplier invoices"
  source: "`restaurants_ecm`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: supplier_invoice_status
      comment: "Current processing status of the invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment settlement status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates if the invoice is tax‑exempt"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices received"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts granted on invoices"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN is_disputed THEN 1 ELSE 0 END)
      comment: "Count of invoices flagged as disputed"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor governance and risk overview"
  source: "`restaurants_ecm`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "approved_status"
      expr: approved_status
      comment: "Approval status descriptor"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (e.g., local, global)"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Flag indicating if vendor is preferred"
  measures:
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the approved list"
    - name: "approved_vendor_count"
      expr: SUM(CASE WHEN is_currently_approved THEN 1 ELSE 0 END)
      comment: "Count of vendors that are currently approved"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across approved vendors"
    - name: "average_vendor_rating"
      expr: AVG(CAST(vendor_rating AS DOUBLE))
      comment: "Average rating assigned to vendors"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier performance metrics"
  source: "`restaurants_ecm`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: supplier_scorecard_status
      comment: "Current status of the scorecard"
    - name: "region"
      expr: region
      comment: "Geographic region of the supplier"
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category classification of the supplier"
  measures:
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Number of supplier scorecards evaluated"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Mean overall performance score across suppliers"
    - name: "average_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate"
    - name: "average_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across suppliers"
    - name: "average_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate"
    - name: "average_cost_savings_percent"
      expr: AVG(CAST(cost_savings_percent AS DOUBLE))
      comment: "Average cost‑savings percentage achieved"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`procurement_supplier_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment overview for procurement suppliers"
  source: "`restaurants_ecm`.`procurement`.`supplier_risk`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification"
    - name: "risk_category"
      expr: risk_category
      comment: "Broad risk category (e.g., operational, financial)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Supplier's primary geographic region"
  measures:
    - name: "supplier_risk_count"
      expr: COUNT(1)
      comment: "Total number of supplier risk records"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Mean risk score across suppliers"
    - name: "average_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score"
    - name: "average_dependency_percentage"
      expr: AVG(CAST(dependency_percentage AS DOUBLE))
      comment: "Average dependency percentage on single source"
$$;