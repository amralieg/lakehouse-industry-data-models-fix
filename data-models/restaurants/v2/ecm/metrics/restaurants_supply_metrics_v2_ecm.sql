-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master health and onboarding metrics. Tracks active supplier counts, approval rates, and supplier type distribution to support vendor management and sourcing decisions."
  source: "`vibe_restaurants_v1`.`supply`.`supply_supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Category of supplier (e.g., distributor, direct, broadline) for segmentation analysis."
    - name: "supplier_status"
      expr: supply_supplier_status
      comment: "Current operational status of the supplier (active, inactive, suspended)."
    - name: "country"
      expr: country
      comment: "Country where the supplier is headquartered, used for geographic sourcing analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the supplier is currently active."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the supplier has passed vendor approval."
    - name: "onboarded_date"
      expr: DATE_TRUNC('month', onboarded_date)
      comment: "Month the supplier was onboarded, used for cohort and ramp analysis."
  measures:
    - name: "total_suppliers"
      expr: COUNT(1)
      comment: "Total number of supplier records. Baseline headcount for vendor portfolio management."
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active suppliers. Tracks the live vendor base available for ordering."
    - name: "approved_supplier_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of suppliers that have passed the vendor approval process. Indicates sourcing readiness."
    - name: "supplier_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers that are approved. Low rates signal onboarding bottlenecks or compliance gaps."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (in days) across suppliers. Informs cash flow and AP planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order volume, value, and fulfillment metrics. Tracks PO approval rates, spend, and delivery performance to support procurement efficiency and cost management."
  source: "`vibe_restaurants_v1`.`supply`.`supply_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: supply_purchase_order_status
      comment: "Current status of the purchase order (draft, approved, received, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, used to track bottlenecks in the approval process."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the PO is denominated, for multi-currency spend analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was placed, used for trend and seasonality analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the PO (e.g., Net 30), used for cash flow planning."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the PO has been formally approved."
    - name: "is_received"
      expr: is_received
      comment: "Boolean flag indicating whether goods have been received against this PO."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement activity."
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total spend across all purchase orders. Primary cost metric for supply chain budget management."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Indicates typical order size and helps detect anomalies."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across all POs. Required for tax reporting and cost reconciliation."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across all POs. Tracks logistics spend as a component of total procurement cost."
    - name: "po_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs that have been approved. Low rates indicate approval workflow delays."
    - name: "po_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs where goods have been received. Tracks fulfillment completion rate."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-freight subtotals across all POs. Used for net spend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order metrics covering ordered quantities, unit pricing, and receipt performance. Enables ingredient-level spend analysis and delivery variance tracking."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: purchase_order_line_status
      comment: "Status of the individual PO line (open, partially received, closed, cancelled)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered ingredient (e.g., case, lb, kg)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the line item pricing."
    - name: "is_fully_received"
      expr: is_fully_received
      comment: "Boolean flag indicating whether the full ordered quantity has been received."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month the line item was expected to be delivered, for delivery performance trending."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of purchase order lines. Baseline volume for line-level procurement activity."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Tracks procurement volume by ingredient."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received. Compared against ordered quantity to measure fulfillment."
    - name: "total_line_spend"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total spend across all PO lines. Primary cost metric at the ingredient level."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid per ingredient line. Used for price benchmarking and contract compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all PO lines. Required for tax reconciliation."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was received. Core supplier fill-rate KPI; low values indicate supply shortfalls."
    - name: "fully_received_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fully_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PO lines fully received. Tracks complete fulfillment at the line level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice payment and reconciliation metrics. Tracks invoice volumes, outstanding balances, payment timeliness, and tax exposure to support AP management and cash flow planning."
  source: "`vibe_restaurants_v1`.`supply`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (pending, approved, paid, disputed, cancelled)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice (e.g., Net 30, Net 60). Used for cash flow and aging analysis."
    - name: "is_paid"
      expr: is_paid
      comment: "Boolean flag indicating whether the invoice has been paid."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued, used for AP volume trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the invoice is due, used for cash flow forecasting."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume metric."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all supplier invoices. Primary AP spend metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across all invoices. Required for tax reporting and reconciliation."
    - name: "unpaid_invoice_amount"
      expr: SUM(CASE WHEN is_paid = FALSE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding unpaid invoice amount. Critical for AP aging and cash flow management."
    - name: "paid_invoice_amount"
      expr: SUM(CASE WHEN is_paid = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount paid across all invoices. Tracks actual cash outflow to suppliers."
    - name: "invoice_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_paid = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been paid. Low rates signal AP processing bottlenecks."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Used to detect anomalous invoices and benchmark supplier billing patterns."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality and compliance metrics. Tracks receipt volumes, temperature compliance, cold chain adherence, and total received costs to support receiving operations and food safety."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (pending, accepted, rejected, partial)."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (dock, direct store delivery, etc.)."
    - name: "condition"
      expr: condition
      comment: "Physical condition of goods upon receipt (good, damaged, temperature-compromised)."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Boolean flag indicating whether cold chain requirements were maintained during receipt."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Boolean flag indicating a temperature deviation was detected at receipt."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of receipt expiration date, used for shelf-life and waste risk analysis."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline inbound volume metric."
    - name: "total_received_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received. Primary inbound spend metric for COGS and inventory valuation."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Tracks inbound supply volume."
    - name: "avg_receipt_temperature_c"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature recorded at receipt. Used to monitor cold chain compliance trends."
    - name: "cold_chain_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cold_chain_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts that were cold chain compliant. Critical food safety KPI; non-compliance triggers corrective action."
    - name: "temperature_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with a temperature deviation. High rates indicate supplier or logistics failures."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level receiving quality, variance, and cost metrics. Enables ingredient-level analysis of receipt accuracy, rejection rates, and cost variances to drive supplier accountability."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection result for the receipt line (passed, failed, pending)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the received item."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Boolean flag indicating whether the received item is perishable. Used for prioritization and waste risk."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the receipt line met compliance requirements."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the received item (none, under review, recalled). Critical for food safety response."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Boolean flag indicating whether temperature control was required for this item."
  measures:
    - name: "total_receipt_lines"
      expr: COUNT(1)
      comment: "Total number of goods receipt lines. Baseline volume for line-level receiving activity."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lines. Tracks inbound supply volume at the ingredient level."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt. High rejection volumes indicate supplier quality issues."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected. Core supplier quality KPI; drives corrective action and contract review."
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received at the line level. Used for ingredient-level COGS and inventory valuation."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance between PO price and actual receipt cost. Tracks pricing discrepancies for AP reconciliation."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned at receipt inspection. Tracks supplier quality trends over time."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipt lines meeting compliance requirements. Low rates trigger supplier review."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier scorecard and performance metrics. Tracks on-time delivery, fill rates, quality rejection, invoice accuracy, and food safety compliance to support vendor management and contract decisions."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_performance`"
  dimensions:
    - name: "rating_tier"
      expr: rating_tier
      comment: "Supplier performance tier (e.g., Gold, Silver, Bronze) based on composite scorecard."
    - name: "contract_compliance_flag"
      expr: contract_compliance_flag
      comment: "Boolean flag indicating whether the supplier met contract compliance requirements in the period."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Boolean flag indicating whether a corrective action was issued to the supplier in the period."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Start month of the performance measurement period, used for trend analysis."
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total number of supplier performance evaluation records."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across suppliers. Core logistics KPI; low rates indicate supply chain risk."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across suppliers. Measures supplier ability to fulfill ordered quantities."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate across suppliers. High rates signal ingredient quality issues and food safety risk."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate. Low accuracy increases AP processing costs and dispute resolution effort."
    - name: "avg_food_safety_compliance_score"
      expr: AVG(CAST(food_safety_compliance_score AS DOUBLE))
      comment: "Average food safety compliance score across suppliers. Critical for regulatory compliance and brand protection."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days. Informs safety stock levels and replenishment planning."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier performance periods requiring corrective action. High rates indicate systemic supplier issues."
    - name: "total_orders_evaluated"
      expr: SUM(CAST(total_orders_evaluated AS DOUBLE))
      comment: "Total number of orders evaluated across all supplier performance records. Provides statistical confidence context."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound and in-process quality inspection metrics. Tracks inspection pass/fail rates, corrective action requirements, and temperature compliance to support food safety and supplier quality management."
  source: "`vibe_restaurants_v1`.`supply`.`quality_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of quality inspection (receiving, in-process, audit, etc.)."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (pass, fail, conditional pass)."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the inspection (visual, lab test, temperature check, etc.)."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect identified during inspection (temperature, contamination, packaging, etc.)."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the inspected item met compliance requirements."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required following the inspection."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of the inspection, used for quality trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed. Baseline volume for quality control activity."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed. Core quality KPI; declining rates trigger supplier review."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action. High rates indicate systemic quality failures."
    - name: "total_rejection_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected across all inspections. Tracks waste and supplier quality impact on inventory."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during inspections. Used to monitor cold chain compliance trends."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections meeting compliance requirements. Regulatory and food safety KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability, quality, and waste metrics. Tracks lot quantities, quality scores, recall exposure, and yield to support food safety traceability and inventory cost management."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (active, quarantined, consumed, disposed, recalled)."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (production, purchased, transferred) for traceability classification."
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of the ingredient in this lot (protein, produce, dairy, etc.)."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Boolean flag indicating whether this lot is subject to a recall. Critical food safety dimension."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Boolean flag indicating whether the lot is certified organic."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Boolean flag indicating whether the lot requires temperature-controlled storage."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month the lot was received, used for aging and shelf-life analysis."
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of ingredient lots. Baseline traceability volume metric."
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all ingredient lots. Tracks available supply volume."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots. Used for inventory valuation and COGS analysis."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ingredient lots. Tracks ingredient quality trends by supplier and category."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across lots. High waste rates drive cost reduction initiatives."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across lots. Low yields indicate quality or handling issues."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to a recall. Critical food safety metric requiring immediate executive attention."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across lots. Used to verify cold chain compliance in storage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment logistics performance metrics. Tracks on-time arrival, freight costs, temperature compliance, and delay patterns to support logistics optimization and supplier accountability."
  source: "`vibe_restaurants_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (in transit, delivered, delayed, cancelled)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (truck, rail, air, ocean) for logistics cost and performance analysis."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier responsible for the shipment. Used for carrier performance benchmarking."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Boolean flag indicating whether temperature control was required for the shipment."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Boolean flag indicating whether the shipment was expedited. Expedited shipments carry premium freight costs."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_timestamp)
      comment: "Month of scheduled arrival, used for inbound volume planning and trend analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (prepaid, collect, third-party) for cost allocation."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline logistics volume metric."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments. Key logistics cost metric for supply chain budget management."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Used for carrier benchmarking and freight budget planning."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all inbound shipments in kilograms. Used for freight rate analysis and capacity planning."
    - name: "total_volume_cubic_m"
      expr: SUM(CAST(volume_cubic_m AS DOUBLE))
      comment: "Total volume of all inbound shipments in cubic meters. Used for warehouse capacity planning."
    - name: "expedited_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments that were expedited. High rates indicate supply planning failures and excess freight spend."
    - name: "temperature_controlled_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments requiring temperature control. Used for cold chain capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety recall event metrics. Tracks recall volumes, costs, severity, and regulatory compliance to support crisis management, food safety governance, and brand risk mitigation."
  source: "`vibe_restaurants_v1`.`supply`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall event (initiated, in progress, closed)."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (Class I, II, III) indicating severity of health risk."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity level of the recall (critical, high, medium, low)."
    - name: "product_category"
      expr: product_category
      comment: "Category of the recalled product (protein, produce, dairy, etc.)."
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "Boolean flag indicating FDA compliance status for the recall."
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('month', recall_initiation_timestamp)
      comment: "Month the recall was initiated, used for recall frequency trending."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events. Baseline food safety risk metric; any increase demands executive attention."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity of product recalled. Measures the scale of supply chain impact from recall events."
    - name: "total_recall_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total financial cost of recall events. Quantifies the business impact of food safety failures."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across recall events. Used to prioritize response resources and assess supplier risk."
    - name: "open_recall_count"
      expr: COUNT(CASE WHEN recall_status != 'closed' THEN 1 END)
      comment: "Number of currently open recall events. Active recalls require immediate operational response."
    - name: "fda_compliant_recall_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_fda = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls that are FDA compliant. Non-compliance exposes the business to regulatory penalties."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply contract portfolio and value metrics. Tracks contract values, status distribution, pricing protections, and renewal patterns to support strategic sourcing and contract lifecycle management."
  source: "`vibe_restaurants_v1`.`supply`.`supply_contract`"
  dimensions:
    - name: "contract_status"
      expr: supply_contract_status
      comment: "Current status of the supply contract (active, expired, pending, terminated)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supply contract (fixed price, cost-plus, volume-based, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Boolean flag indicating whether the contract auto-renews. Used for contract expiry risk management."
    - name: "price_protection_flag"
      expr: price_protection_flag
      comment: "Boolean flag indicating whether the contract includes price protection clauses."
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month the contract became effective, used for contract cohort analysis."
    - name: "contract_end_month"
      expr: DATE_TRUNC('month', contract_end_date)
      comment: "Month the contract expires, used for renewal pipeline management."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supply contracts. Baseline portfolio size metric."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total committed value across all supply contracts. Primary strategic sourcing spend metric."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value. Used to benchmark deal sizes and identify outlier contracts."
    - name: "total_rebate_value"
      expr: SUM(CAST(rebate_percent AS DOUBLE))
      comment: "Sum of rebate percentages across contracts. Tracks total rebate exposure for financial planning."
    - name: "price_protected_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN price_protection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with price protection. Higher rates reduce commodity price volatility exposure."
    - name: "auto_renew_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renew = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts set to auto-renew. Used to manage contract renewal pipeline and negotiation windows."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average contracted service level target across supply contracts. Benchmarks supplier commitment levels."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_commodity_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity category spend, risk, and compliance metrics. Tracks category-level cost, risk scores, and compliance requirements to support strategic sourcing and category management decisions."
  source: "`vibe_restaurants_v1`.`supply`.`commodity_category`"
  dimensions:
    - name: "category_type"
      expr: category_type
      comment: "Type of commodity category (direct, indirect, perishable, etc.)."
    - name: "commodity_category_status"
      expr: commodity_category_status
      comment: "Current status of the commodity category (active, inactive, under review)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the category (high, medium, low). Used for sourcing prioritization."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Boolean flag indicating whether the category contains perishable items."
    - name: "is_leaf_category"
      expr: is_leaf_category
      comment: "Boolean flag indicating whether this is a leaf-level category in the hierarchy."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the commodity category hierarchy (1=top, N=leaf). Used for roll-up analysis."
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of commodity categories. Baseline portfolio breadth metric."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(average_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across commodity categories. Used for category-level cost benchmarking."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across commodity categories. High scores indicate categories requiring strategic sourcing attention."
    - name: "total_spend_percentage"
      expr: SUM(CAST(spend_percentage AS DOUBLE))
      comment: "Sum of spend percentages across categories. Used to validate category spend coverage totals to 100%."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(strategic_sourcing_tier AS DOUBLE))
      comment: "Average strategic sourcing tier value across categories. Used to prioritize sourcing investment by category importance."
    - name: "avg_typical_cogs_percent"
      expr: AVG(CAST(typical_cogs_percent AS DOUBLE))
      comment: "Average COGS percentage contribution across commodity categories. Informs menu costing and margin management."
$$;