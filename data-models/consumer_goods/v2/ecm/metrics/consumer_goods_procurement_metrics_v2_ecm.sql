-- Metric views for domain: procurement | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs tracking purchase order value, volume, and cycle efficiency to inform spend management and supplier relationship decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (e.g., draft, approved, closed) for lifecycle analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend analysis"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery and risk transfer"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with supplier for cash flow planning"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year of purchase order creation for trend analysis"
    - name: "po_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Quarter of purchase order creation for seasonal spend patterns"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order creation for monthly spend tracking"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order value - primary spend metric for procurement budget management and supplier spend analysis"
    - name: "po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders - volume metric for procurement workload and efficiency analysis"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value - efficiency metric indicating order consolidation and strategic sourcing effectiveness"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers - supplier base concentration metric for risk management and relationship strategy"
    - name: "unique_buyers"
      expr: COUNT(DISTINCT buyer_employee_id)
      comment: "Number of unique buyers - workload distribution metric for procurement team capacity planning"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance and risk KPIs tracking quality, delivery, diversity, and strategic value to inform supplier selection and relationship management decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Supplier status (active, inactive, blocked) for supplier base health analysis"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Supplier classification (e.g., manufacturer, distributor, service provider) for category management"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating tier for supplier performance segmentation"
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Sustainability rating for ESG-driven sourcing decisions"
    - name: "is_strategic_supplier"
      expr: is_strategic_supplier
      comment: "Strategic supplier flag for relationship prioritization"
    - name: "is_minority_owned"
      expr: is_minority_owned
      comment: "Minority-owned business flag for diversity spend tracking"
    - name: "is_woman_owned"
      expr: is_woman_owned
      comment: "Woman-owned business flag for diversity spend tracking"
    - name: "currency_code"
      expr: currency_code
      comment: "Supplier currency for multi-currency supplier base analysis"
  measures:
    - name: "supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of suppliers - supplier base size metric for concentration risk and rationalization strategy"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage - critical supply chain reliability metric for supplier performance management"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across suppliers - financial exposure metric for risk management"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per supplier - supplier financial capacity indicator"
    - name: "strategic_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN is_strategic_supplier = true THEN supplier_id END)
      comment: "Number of strategic suppliers - relationship management focus metric for executive supplier strategy"
    - name: "diversity_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN is_minority_owned = true OR is_woman_owned = true THEN supplier_id END)
      comment: "Number of diversity suppliers - diversity spend program metric for corporate social responsibility reporting"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive supplier performance KPIs tracking quality, delivery, cost, and overall scores to drive supplier development and sourcing decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Evaluation period (e.g., Q1 2024, 2024-01) for time-series performance tracking"
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score - primary supplier performance metric for executive dashboards and supplier awards"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score - product quality metric for supplier quality management and corrective action prioritization"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery score - supply chain reliability metric for supplier performance improvement programs"
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost score - cost competitiveness metric for strategic sourcing and negotiation leverage"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage - operational reliability metric for supply chain planning and risk mitigation"
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in parts per million - quality metric for supplier quality engineering and Six Sigma programs"
    - name: "scorecard_count"
      expr: COUNT(DISTINCT supplier_scorecard_id)
      comment: "Number of supplier scorecards - evaluation coverage metric for supplier performance management program maturity"
    - name: "evaluated_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of evaluated suppliers - program reach metric for supplier relationship management scope"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and cash flow KPIs tracking invoice value, volume, aging, and payment status to inform working capital management and supplier payment decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status (e.g., pending, approved, paid, disputed) for AP workflow analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP management"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for cash flow forecasting and early payment discount analysis"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice for annual spend analysis"
    - name: "invoice_quarter"
      expr: CONCAT('Q', QUARTER(invoice_date))
      comment: "Quarter of invoice for quarterly cash flow planning"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for monthly AP tracking"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoice amount - primary AP liability metric for cash flow forecasting and working capital management"
    - name: "invoice_count"
      expr: COUNT(DISTINCT supplier_invoice_id)
      comment: "Number of invoices - AP processing volume metric for operational efficiency and automation ROI analysis"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice amount - invoice size metric for payment processing efficiency and fraud detection thresholds"
    - name: "unique_suppliers_invoiced"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with invoices - active supplier base metric for supplier relationship breadth"
    - name: "unique_pos_invoiced"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders invoiced - PO-to-invoice matching metric for three-way match efficiency"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics and quality KPIs tracking receipt volume, quantity accuracy, and quality inspection requirements to inform receiving operations and supplier quality management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Receipt status (e.g., received, inspected, accepted, rejected) for receiving workflow analysis"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Quality inspection requirement flag for quality control workload planning"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization and reporting"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of receipt for annual inbound volume trends"
    - name: "receipt_quarter"
      expr: CONCAT('Q', QUARTER(receipt_date))
      comment: "Quarter of receipt for seasonal inbound pattern analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt for monthly receiving operations tracking"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received quantity - inbound volume metric for warehouse capacity planning and receiving labor forecasting"
    - name: "receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Number of goods receipts - receiving transaction volume metric for operational efficiency and dock scheduling"
    - name: "avg_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average received quantity per receipt - shipment size metric for receiving process optimization"
    - name: "unique_pos_received"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders received - PO fulfillment metric for procurement cycle completion tracking"
    - name: "inspection_required_count"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_required = true THEN goods_receipt_id END)
      comment: "Number of receipts requiring quality inspection - quality workload metric for QC resource planning and supplier quality program effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract management KPIs tracking contract value, volume, renewal risk, and compliance to inform strategic sourcing and supplier relationship decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status (active, expired, pending) for contract lifecycle management"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (e.g., blanket, spot, framework) for sourcing strategy analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency contract portfolio management"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms for logistics cost allocation and risk analysis"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for cash flow impact analysis"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Auto-renewal flag for contract renewal risk assessment"
    - name: "contract_year"
      expr: YEAR(start_date)
      comment: "Year of contract start for contract portfolio age analysis"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total contract value - committed spend metric for budget planning and supplier relationship value assessment"
    - name: "contract_count"
      expr: COUNT(DISTINCT supplier_contract_id)
      comment: "Number of contracts - contract portfolio size metric for contract management workload and compliance risk"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average contract value - contract size metric for sourcing strategy and negotiation leverage"
    - name: "unique_suppliers_contracted"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with contracts - contracted supplier base metric for strategic sourcing coverage"
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = true THEN supplier_contract_id END)
      comment: "Number of auto-renewal contracts - renewal risk metric for contract renegotiation planning and cost optimization opportunities"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs tracking RFx event value, volume, and outcomes to measure sourcing program effectiveness and cost savings opportunities."
  source: "`vibe_consumer_goods_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Sourcing event status (draft, active, closed, awarded) for pipeline management"
    - name: "event_type"
      expr: event_type
      comment: "Event type (RFI, RFQ, RFP, auction) for sourcing strategy analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Event currency for multi-currency sourcing value tracking"
    - name: "event_year"
      expr: YEAR(start_date)
      comment: "Year of event start for annual sourcing activity trends"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter of event start for quarterly sourcing pipeline management"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated sourcing event value - sourcing pipeline value metric for cost savings opportunity assessment and strategic sourcing program ROI"
    - name: "sourcing_event_count"
      expr: COUNT(DISTINCT sourcing_event_id)
      comment: "Number of sourcing events - sourcing activity volume metric for strategic sourcing team productivity and category coverage"
    - name: "avg_event_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average sourcing event value - event size metric for sourcing strategy prioritization and resource allocation"
    - name: "unique_buyers_sourcing"
      expr: COUNT(DISTINCT buyer_employee_id)
      comment: "Number of unique buyers running sourcing events - sourcing team engagement metric for capability development and workload distribution"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier competitiveness and sourcing effectiveness KPIs tracking quote pricing, lead times, and response rates to inform supplier selection and negotiation strategy."
  source: "`vibe_consumer_goods_v1`.`procurement`.`rfq_response`"
  dimensions:
    - name: "response_status"
      expr: response_status
      comment: "Response status (submitted, accepted, rejected) for RFQ outcome analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Quote currency for multi-currency price comparison"
    - name: "response_year"
      expr: YEAR(response_date)
      comment: "Year of response for annual supplier engagement trends"
    - name: "response_quarter"
      expr: CONCAT('Q', QUARTER(response_date))
      comment: "Quarter of response for quarterly sourcing effectiveness"
  measures:
    - name: "total_quoted_value"
      expr: SUM(CAST(quoted_price AS DOUBLE))
      comment: "Total quoted price value - supplier pricing competitiveness metric for cost benchmarking and negotiation leverage"
    - name: "rfq_response_count"
      expr: COUNT(DISTINCT rfq_response_id)
      comment: "Number of RFQ responses - supplier engagement metric for sourcing event effectiveness and supplier base competitiveness"
    - name: "avg_quoted_price"
      expr: AVG(CAST(quoted_price AS DOUBLE))
      comment: "Average quoted price - market pricing metric for cost estimation and budget planning"
    - name: "unique_suppliers_responding"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers responding - supplier participation metric for sourcing event competitiveness and supplier relationship health"
    - name: "unique_rfqs_responded"
      expr: COUNT(DISTINCT rfq_id)
      comment: "Number of unique RFQs with responses - RFQ effectiveness metric for sourcing process quality and supplier engagement"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category management KPIs tracking category structure, strategic focus, and management coverage to inform spend analysis and category strategy decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_level"
      expr: category_level
      comment: "Category hierarchy level (L1, L2, L3) for spend rollup analysis"
    - name: "is_strategic_category"
      expr: is_strategic_category
      comment: "Strategic category flag for prioritization and resource allocation"
  measures:
    - name: "category_count"
      expr: COUNT(DISTINCT spend_category_id)
      comment: "Number of spend categories - category taxonomy size metric for spend visibility and category management scope"
    - name: "strategic_category_count"
      expr: COUNT(DISTINCT CASE WHEN is_strategic_category = true THEN spend_category_id END)
      comment: "Number of strategic categories - strategic sourcing focus metric for category strategy prioritization and resource allocation decisions"
    - name: "unique_category_managers"
      expr: COUNT(DISTINCT category_manager_employee_id)
      comment: "Number of unique category managers - category management coverage metric for organizational capability and span of control"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality and compliance KPIs tracking qualification status, audit scores, and certification currency to inform supplier approval and risk management decisions."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, pending, expired, rejected) for supplier approval tracking"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Qualification type (e.g., ISO, GMP, safety) for compliance program management"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year of qualification for qualification program trend analysis"
  measures:
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score - supplier quality metric for supplier development prioritization and approved supplier list management"
    - name: "qualification_count"
      expr: COUNT(DISTINCT supplier_qualification_id)
      comment: "Number of supplier qualifications - qualification program activity metric for supplier quality assurance coverage"
    - name: "unique_suppliers_qualified"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique qualified suppliers - qualified supplier base metric for supply chain risk management and sourcing options"
    - name: "unique_auditors"
      expr: COUNT(DISTINCT auditor_employee_id)
      comment: "Number of unique auditors - auditor resource metric for qualification program capacity and independence"
$$;