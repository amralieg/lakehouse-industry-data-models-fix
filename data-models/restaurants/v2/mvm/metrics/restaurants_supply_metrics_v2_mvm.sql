-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering spend, delivery performance, and approval efficiency. Used by procurement leadership to steer supplier relationships and operational planning."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. open, closed, cancelled) for pipeline segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order, used to track procurement governance compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated, enabling multi-currency spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms on the purchase order, used to assess cash flow obligations."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement, used for trend analysis of procurement activity over time."
    - name: "expected_delivery_date_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery, used to forecast inbound supply volumes."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the purchase order has been formally approved."
    - name: "is_received"
      expr: is_received
      comment: "Boolean flag indicating whether goods against this purchase order have been received."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement cost KPI used by CFO and VP Procurement to manage budget adherence."
    - name: "total_po_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-freight subtotals across purchase orders, used to isolate product cost from logistics and tax."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across purchase orders. Tracks logistics cost as a component of total procurement spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax obligations across purchase orders, used for financial accruals and tax reporting."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Indicates order sizing trends and supplier engagement patterns."
    - name: "count_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement activity."
    - name: "count_approved_orders"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of purchase orders that have received formal approval. Tracks governance compliance in the procurement process."
    - name: "count_received_orders"
      expr: COUNT(CASE WHEN is_received = TRUE THEN 1 END)
      comment: "Number of purchase orders where goods have been received. Measures fulfillment completion rate."
    - name: "count_distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers engaged via purchase orders. Indicates supplier base breadth and concentration risk."
    - name: "count_late_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Number of purchase orders where actual delivery exceeded the expected delivery date. Key supplier on-time delivery KPI."
    - name: "avg_delivery_delay_days"
      expr: AVG(CASE WHEN actual_delivery_date > expected_delivery_date THEN DATEDIFF(actual_delivery_date, expected_delivery_date) ELSE 0 END)
      comment: "Average number of days by which deliveries are late. Quantifies supplier delivery performance degradation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement metrics covering ordered quantities, unit pricing, and receipt variance. Used by category managers and supply planners to evaluate ingredient-level procurement efficiency."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual purchase order line (e.g. open, received, cancelled)."
    - name: "purchase_order_line_status"
      expr: purchase_order_line_status
      comment: "Operational status of the purchase order line from the source system."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the line item, enabling multi-currency cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity, used for volume normalization across ingredients."
    - name: "is_fully_received"
      expr: is_fully_received
      comment: "Boolean flag indicating whether the full ordered quantity has been received."
    - name: "expected_delivery_date_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery at line level, used for supply planning horizon analysis."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all purchase order lines. Core supply volume KPI for demand planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity confirmed as received. Used to measure fulfillment completeness against orders."
    - name: "total_line_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total spend at line level. Enables ingredient-level cost analysis and category spend management."
    - name: "total_tax_on_lines"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level across all purchase order lines."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase order lines. Tracks ingredient cost trends and price inflation."
    - name: "receipt_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was received. Critical supplier fulfillment KPI — low fill rate signals supply risk."
    - name: "count_fully_received_lines"
      expr: COUNT(CASE WHEN is_fully_received = TRUE THEN 1 END)
      comment: "Number of purchase order lines fully received. Measures procurement completion at line granularity."
    - name: "count_po_lines"
      expr: COUNT(1)
      comment: "Total number of purchase order lines. Baseline volume metric for procurement line activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving operations KPIs covering inbound volume, cost, cold chain compliance, and temperature deviation. Used by operations and food safety teams to ensure supply integrity at point of receipt."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g. pending, complete, rejected), used to track receiving workflow."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (e.g. dock, direct), used to analyze receiving process efficiency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt transaction."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Boolean flag indicating cold chain compliance at receipt. Critical food safety dimension."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Boolean flag indicating a temperature deviation was recorded at receipt. Used to identify food safety risk events."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of goods receipt, used for inbound volume trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of expiration for received goods, used to manage shelf life and waste risk."
  measures:
    - name: "total_received_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received. Core inbound supply cost KPI for COGS management."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Measures inbound supply volume."
    - name: "avg_receipt_temperature"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature recorded at goods receipt. Used to monitor cold chain integrity across deliveries."
    - name: "count_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline receiving activity volume metric."
    - name: "count_cold_chain_non_compliant"
      expr: COUNT(CASE WHEN is_cold_chain_compliant = FALSE THEN 1 END)
      comment: "Number of receipts with cold chain non-compliance. Directly tied to food safety risk and potential regulatory exposure."
    - name: "count_temperature_deviations"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Number of receipts with recorded temperature deviations. Key food safety KPI for supplier and logistics quality."
    - name: "cold_chain_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cold_chain_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that are cold chain compliant. Executive-level food safety and supplier quality KPI."
    - name: "avg_cost_per_receipt"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per goods receipt event. Used to benchmark receiving cost efficiency across units and suppliers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level receiving quality and cost metrics including rejection rates, variance analysis, and COGS. Used by quality assurance and supply chain teams to manage supplier performance at item level."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome for the receipt line (e.g. passed, failed, pending). Used to segment quality performance."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the received item. Critical food safety and regulatory compliance dimension."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Boolean flag indicating whether the received item is perishable. Used to prioritize quality controls."
    - name: "is_returned"
      expr: is_returned
      comment: "Boolean flag indicating whether the line item was returned to the supplier."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating regulatory or quality compliance for the receipt line."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Boolean flag indicating whether temperature control was required for this item."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the receipt line cost."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities, enabling volume normalization."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month goods were received at line level, used for trend analysis."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all receipt lines. Core inbound volume metric."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt. High rejection volume signals supplier quality issues requiring intervention."
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of received goods at line level. Used for COGS attribution and supplier spend analysis."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold amount attributed to received lines. Directly feeds into margin calculations."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total financial variance between ordered and received cost. Tracks invoice accuracy and supplier pricing compliance."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received. Measures supplier fulfillment accuracy."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected. Primary supplier quality KPI — high rejection rate triggers supplier review."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned during inspection. Tracks supplier quality trends over time."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received items. Used to monitor price consistency against purchase orders."
    - name: "count_returned_lines"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of receipt lines returned to supplier. Indicates supplier quality failures requiring corrective action."
    - name: "count_non_compliant_lines"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of receipt lines flagged as non-compliant. Regulatory and quality risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs covering payment status, outstanding liabilities, and invoice cycle efficiency. Used by finance and procurement leadership to manage cash flow and supplier payment compliance."
  source: "`vibe_restaurants_v1`.`supply`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. pending, approved, paid, disputed). Core AP workflow dimension."
    - name: "is_paid"
      expr: is_paid
      comment: "Boolean flag indicating whether the invoice has been paid. Used to segment outstanding vs settled liabilities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice, enabling multi-currency AP analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the supplier, used to assess early payment discount opportunities and overdue risk."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued, used for AP aging and cash flow forecasting."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the invoice is due, used for cash flow planning and overdue detection."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices. Core AP liability KPI for cash flow management."
    - name: "total_tax_invoiced"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices. Used for tax accrual and compliance reporting."
    - name: "total_unpaid_amount"
      expr: SUM(CASE WHEN is_paid = FALSE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding unpaid invoice amount. Critical cash flow and AP liability KPI for the CFO."
    - name: "total_paid_amount"
      expr: SUM(CASE WHEN is_paid = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount settled through paid invoices. Tracks payment throughput and AP clearance rate."
    - name: "count_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices. Baseline AP volume metric."
    - name: "count_unpaid_invoices"
      expr: COUNT(CASE WHEN is_paid = FALSE THEN 1 END)
      comment: "Number of invoices not yet paid. Used to prioritize AP workload and manage supplier relationships."
    - name: "invoice_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_paid = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been paid. Measures AP clearance efficiency and supplier payment compliance."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Used to benchmark transaction size and detect anomalous invoices."
    - name: "count_distinct_suppliers_invoiced"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with invoices. Measures active supplier billing relationships."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply quality inspection KPIs covering pass/fail rates, corrective action requirements, and temperature compliance. Used by food safety officers and quality managers to ensure regulatory compliance and supplier accountability."
  source: "`vibe_restaurants_v1`.`supply`.`quality_inspection`"
  dimensions:
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Overall status of the quality inspection (e.g. passed, failed, pending). Primary quality outcome dimension."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Detailed result of the inspection. Used to classify quality outcomes for trend analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. incoming, periodic, HACCP). Used to segment quality activity by process."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g. visual, lab test). Used to evaluate inspection rigor."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect identified during inspection. Used to prioritize corrective actions by defect type."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken on inspected goods (e.g. accept, reject, quarantine). Tracks quality disposition outcomes."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the inspection result is compliant with standards."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating a corrective action was required. Used to track quality remediation workload."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection, used for quality trend analysis over time."
  measures:
    - name: "count_inspections"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed. Baseline quality activity volume metric."
    - name: "count_failed_inspections"
      expr: COUNT(CASE WHEN inspection_result = 'FAIL' THEN 1 END)
      comment: "Number of inspections that resulted in a failure. Key quality KPI — high failure count triggers supplier review."
    - name: "count_corrective_actions_required"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Measures quality remediation burden and supplier non-conformance."
    - name: "count_non_compliant_inspections"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of inspections flagged as non-compliant. Directly tied to regulatory risk and potential audit findings."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected across all quality inspections. Measures the volume impact of quality failures on supply."
    - name: "avg_inspection_temperature"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during inspections. Used to monitor cold chain and storage compliance."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity recorded during inspections. Used to assess storage condition compliance for sensitive ingredients."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed. Primary supplier quality scorecard KPI used in QBRs and supplier reviews."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action. Tracks systemic quality issues requiring management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability and quality KPIs covering yield, waste, cost, and recall exposure. Used by food safety, supply chain, and operations leadership to manage ingredient quality and traceability compliance."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (e.g. active, quarantined, consumed, disposed)."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of ingredient lot (e.g. production, purchased). Used to segment lot origin."
    - name: "lot_source_type"
      expr: lot_source_type
      comment: "Source type of the lot (e.g. direct supplier, distribution center). Used for traceability analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome for the lot. Used to segment quality-cleared vs pending lots."
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of the ingredient in the lot. Used for category-level quality and cost analysis."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Boolean flag indicating the lot is subject to a recall. Critical food safety and regulatory risk dimension."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Boolean flag indicating organic certification for the lot. Used for menu labeling and compliance tracking."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Boolean flag indicating whether the lot requires temperature-controlled storage."
    - name: "traceability_enabled"
      expr: traceability_enabled
      comment: "Boolean flag indicating full traceability is enabled for the lot. Regulatory compliance dimension."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the ingredient lot. Used for sourcing compliance and import risk analysis."
    - name: "received_date_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month the lot was received, used for inbound volume and quality trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of lot expiration, used to manage waste risk and shelf life planning."
  measures:
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all ingredient lots. Core inventory supply volume metric."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots. Used for ingredient-level COGS and procurement cost management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across ingredient lots. Tracks ingredient price trends and supplier cost competitiveness."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ingredient lots. Used to benchmark supplier quality and ingredient standards."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across ingredient lots. Directly impacts food cost and recipe costing accuracy."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across ingredient lots. Key sustainability and food cost KPI — high waste drives margin erosion."
    - name: "count_recalled_lots"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of ingredient lots subject to recall. Critical food safety KPI requiring immediate executive attention."
    - name: "count_lots"
      expr: COUNT(1)
      comment: "Total number of ingredient lots. Baseline traceability volume metric."
    - name: "recall_exposure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingredient lots subject to recall. Measures food safety exposure and supply chain risk concentration."
    - name: "count_distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers contributing ingredient lots. Used to assess supplier diversity and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master data KPIs covering active supplier base, approval status, and geographic distribution. Used by procurement leadership to manage supplier portfolio health and onboarding pipeline."
  source: "`vibe_restaurants_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Operational status of the supplier (e.g. active, inactive, suspended). Core supplier portfolio dimension."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g. distributor, direct, local). Used to segment procurement strategy by supplier category."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the supplier is currently active."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the supplier has been formally approved for procurement."
    - name: "country"
      expr: country
      comment: "Country of the supplier. Used for geographic sourcing analysis and import risk assessment."
    - name: "onboarded_month"
      expr: DATE_TRUNC('month', onboarded_date)
      comment: "Month the supplier was onboarded. Used to track supplier acquisition rate and pipeline growth."
  measures:
    - name: "count_suppliers"
      expr: COUNT(1)
      comment: "Total number of suppliers in the master list. Baseline supplier portfolio size metric."
    - name: "count_active_suppliers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active suppliers. Measures the effective size of the procurement supplier base."
    - name: "count_approved_suppliers"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of formally approved suppliers. Tracks governance compliance in supplier qualification."
    - name: "supplier_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers that are formally approved. Measures procurement governance maturity."
    - name: "count_distinct_countries"
      expr: COUNT(DISTINCT country)
      comment: "Number of distinct countries from which suppliers originate. Measures geographic diversification of the supply base."
    - name: "avg_payment_terms"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (in days) across suppliers. Used to assess working capital impact of supplier payment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio KPIs covering contract value, compliance status, rebate potential, and liability exposure. Used by legal, procurement, and finance leadership to manage contractual risk and commercial terms."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current status of the supplier contract (e.g. active, expired, under review)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract (e.g. master supply agreement, spot purchase). Used to segment contract portfolio."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract. Used to identify contracts at regulatory or operational risk."
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the contract. Used to track contract governance and audit readiness."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of contract renewal (e.g. auto-renew, manual). Used to manage contract expiry risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract. Used for multi-currency contract value analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean flag indicating an exclusivity clause. Used to identify single-source supply risk."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the contract became effective. Used for contract portfolio vintage analysis."
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the contract expires. Used to manage contract renewal pipeline and avoid supply disruption."
  measures:
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total contractual liability limit across all supplier contracts. Measures maximum financial exposure from supplier agreements."
    - name: "total_rebate_threshold"
      expr: SUM(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Total rebate threshold amount across contracts. Used to track volume targets required to unlock supplier rebates."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across supplier contracts. Measures commercial benefit achievable through volume compliance."
    - name: "avg_volume_tier_1_price"
      expr: AVG(CAST(volume_tier_1_price AS DOUBLE))
      comment: "Average tier-1 volume pricing across contracts. Used to benchmark contracted unit economics."
    - name: "count_contracts"
      expr: COUNT(1)
      comment: "Total number of supplier contracts. Baseline contract portfolio size metric."
    - name: "count_exclusive_contracts"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of contracts with exclusivity clauses. Measures single-source supply concentration risk."
    - name: "count_non_compliant_contracts"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of contracts flagged as non-compliant. Tracks legal and regulatory exposure in the supplier contract portfolio."
    - name: "avg_liability_limit"
      expr: AVG(CAST(liability_limit AS DOUBLE))
      comment: "Average liability limit per contract. Used to benchmark risk exposure per supplier relationship."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_ingredient_sourcing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient sourcing economics KPIs covering unit pricing, minimum order quantities, and preferred supplier coverage. Used by category managers and procurement teams to optimize ingredient sourcing strategies."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_ingredient_sourcing`"
  dimensions:
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Boolean flag indicating whether this is the preferred supplier for the ingredient. Used to segment preferred vs alternative sourcing."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the sourcing agreement became effective. Used for pricing trend analysis."
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the sourcing agreement expires. Used to manage sourcing contract renewal pipeline."
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all ingredient sourcing agreements. Tracks ingredient cost benchmarks across suppliers."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across sourcing agreements. Used to compare total landed cost across supplier options."
    - name: "avg_min_order_quantity"
      expr: AVG(CAST(min_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across sourcing agreements. Used to assess ordering flexibility and working capital requirements."
    - name: "total_min_order_quantity"
      expr: SUM(CAST(min_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitment across all sourcing agreements. Measures aggregate procurement volume obligations."
    - name: "count_sourcing_agreements"
      expr: COUNT(1)
      comment: "Total number of supplier-ingredient sourcing agreements. Measures breadth of sourcing coverage."
    - name: "count_preferred_sourcing_agreements"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of sourcing agreements with preferred supplier designation. Tracks preferred supplier coverage across the ingredient portfolio."
    - name: "count_distinct_ingredients_sourced"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of distinct ingredients with active sourcing agreements. Measures ingredient portfolio coverage through contracted suppliers."
    - name: "count_distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with sourcing agreements. Measures supplier base breadth for ingredient procurement."
    - name: "preferred_supplier_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sourcing agreements designated as preferred supplier. Measures procurement strategy alignment and supplier consolidation progress."
$$;