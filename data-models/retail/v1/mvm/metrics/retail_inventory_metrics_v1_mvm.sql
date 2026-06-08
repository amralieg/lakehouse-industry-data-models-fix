-- Metric views for domain: inventory | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory health metrics derived from the stock position fact. Covers on-hand availability, safety stock coverage, replenishment pressure, and capital-at-risk signals used by supply chain planners, merchandising VPs, and operations leadership."
  source: "`retail_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node (store, DC, or fulfilment centre) for location-level analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier enabling product-level inventory drill-down."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level inventory performance reporting."
    - name: "department_id"
      expr: department_id
      comment: "Department grouping for departmental inventory health dashboards."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor/supplier identifier to assess vendor-specific stock health."
    - name: "position_status"
      expr: position_status
      comment: "Current status of the stock position (e.g., active, discontinued, clearance)."
    - name: "replenishment_status"
      expr: replenishment_status
      comment: "Replenishment workflow status (e.g., pending, ordered, in-transit) for supply chain triage."
    - name: "velocity_band"
      expr: velocity_band
      comment: "Sales velocity classification (e.g., fast, medium, slow, dead) for assortment decisions."
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Valuation method (FIFO, LIFO, WAC) for finance-aligned inventory reporting."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating dead stock positions requiring markdown or liquidation action."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag to separate VMI from retailer-managed positions."
    - name: "position_date"
      expr: DATE_TRUNC('day', position_timestamp)
      comment: "Date of the stock position snapshot for time-series trending."
    - name: "position_month"
      expr: DATE_TRUNC('month', position_timestamp)
      comment: "Month bucket for monthly inventory health trend analysis."
    - name: "last_sale_date"
      expr: last_sale_date
      comment: "Date of last sale on this position, used to identify slow-moving or dead stock."
  measures:
    - name: "total_on_hand_qty"
      expr: SUM(CAST(on_hand_qty AS DOUBLE))
      comment: "Total on-hand inventory quantity across selected positions. Core availability KPI used by operations and supply chain leadership."
    - name: "total_available_to_promise_qty"
      expr: SUM(CAST(available_to_promise_qty AS DOUBLE))
      comment: "Total ATP quantity — the quantity that can be committed to new orders. Critical for omnichannel fulfilment capacity planning."
    - name: "total_in_transit_qty"
      expr: SUM(CAST(in_transit_qty AS DOUBLE))
      comment: "Total quantity currently in transit. Indicates inbound supply pipeline and expected near-term availability."
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total quantity on open purchase/replenishment orders. Reflects committed future supply for demand coverage planning."
    - name: "total_reserved_qty"
      expr: SUM(CAST(reserved_qty AS DOUBLE))
      comment: "Total quantity reserved for existing orders. Measures demand encumbrance against on-hand stock."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock buffer quantity. Baseline for assessing whether current stock provides adequate demand protection."
    - name: "total_damaged_qty"
      expr: SUM(CAST(damaged_qty AS DOUBLE))
      comment: "Total damaged inventory quantity. Drives write-off decisions and supplier quality escalations."
    - name: "total_quarantine_qty"
      expr: SUM(CAST(quarantine_qty AS DOUBLE))
      comment: "Total quantity in quarantine (quality hold). Indicates supply quality risk and potential availability shortfall."
    - name: "total_shrinkage_qty"
      expr: SUM(CAST(shrinkage_qty AS DOUBLE))
      comment: "Total shrinkage quantity recorded on stock positions. Feeds loss-prevention and P&L shrinkage reporting."
    - name: "total_inventory_cost"
      expr: SUM(on_hand_qty * unit_cost)
      comment: "Total cost value of on-hand inventory (on_hand_qty × unit_cost). Core balance-sheet inventory valuation KPI."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply across positions. Measures how long current stock will last at current sales rate — key replenishment trigger metric."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across positions. Measures what proportion of available inventory has been sold — critical for markdown and clearance decisions."
    - name: "avg_daily_sales_qty"
      expr: AVG(CAST(avg_daily_sales_qty AS DOUBLE))
      comment: "Average daily sales velocity across positions. Used to calibrate reorder points and safety stock levels."
    - name: "stock_positions_below_safety_stock"
      expr: COUNT(CASE WHEN on_hand_qty < safety_stock_qty THEN 1 END)
      comment: "Number of stock positions where on-hand quantity is below safety stock threshold. Directly triggers replenishment escalation."
    - name: "stock_positions_at_zero"
      expr: COUNT(CASE WHEN on_hand_qty <= 0 THEN 1 END)
      comment: "Number of stock positions with zero or negative on-hand quantity — a direct measure of out-of-stock exposure."
    - name: "dead_stock_position_count"
      expr: COUNT(CASE WHEN is_dead_stock = TRUE THEN 1 END)
      comment: "Count of positions flagged as dead stock. Drives markdown, liquidation, and assortment rationalisation decisions."
    - name: "dead_stock_cost_value"
      expr: SUM(CASE WHEN is_dead_stock = TRUE THEN on_hand_qty * unit_cost ELSE 0 END)
      comment: "Total cost value of dead stock positions. Quantifies capital tied up in non-moving inventory for executive write-down decisions."
    - name: "total_stock_positions"
      expr: COUNT(1)
      comment: "Total number of active stock position records. Baseline denominator for rate and ratio calculations."
    - name: "below_safety_stock_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_hand_qty < safety_stock_qty THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock positions below safety stock level. Executive-level supply risk indicator used in S&OP reviews."
    - name: "out_of_stock_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_hand_qty <= 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock positions that are out of stock. Directly linked to lost sales and customer satisfaction — a top-tier retail KPI."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational inventory movement metrics from the stock ledger. Covers inventory flow value, shrinkage cost, movement patterns, and retail margin signals used by finance, loss prevention, and supply chain leadership."
  source: "`retail_ecm`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the ledger movement occurred."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the ledger transaction for product-level P&L analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level inventory cost and value reporting."
    - name: "department_id"
      expr: department_id
      comment: "Department for departmental inventory financial reporting."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory movement (receipt, sale, adjustment, transfer, return) for movement-type analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the ledger transaction (posted, pending, reversed) for reconciliation filtering."
    - name: "channel"
      expr: channel
      comment: "Sales or fulfilment channel (store, online, wholesale) for omnichannel inventory analysis."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the inventory movement — essential for root-cause analysis of shrinkage and adjustments."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method applied to this ledger entry (FIFO, LIFO, WAC)."
    - name: "shrinkage_flag"
      expr: shrinkage_flag
      comment: "Flag indicating whether this movement represents shrinkage — used by loss prevention."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating a reversal transaction — used for reconciliation and audit."
    - name: "posting_date"
      expr: posting_date
      comment: "Financial posting date for period-aligned inventory accounting."
    - name: "posting_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month bucket of the transaction for monthly trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ledger entry for multi-currency inventory valuation."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total net inventory movement quantity across all ledger entries. Measures overall inventory flow volume."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost value of inventory movements. Core inventory cost-of-goods metric for finance and P&L reporting."
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total retail value of inventory movements. Used to compute gross margin and retail inventory method valuations."
    - name: "total_shrinkage_cost"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN extended_cost ELSE 0 END)
      comment: "Total cost value of shrinkage movements. Primary loss-prevention KPI — directly impacts gross margin and is reviewed at board level."
    - name: "total_shrinkage_quantity"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN movement_quantity ELSE 0 END)
      comment: "Total unit quantity lost to shrinkage. Operational complement to shrinkage cost for unit-level loss analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across ledger entries. Used to monitor cost inflation and supplier pricing trends."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across ledger entries. Tracks retail price positioning relative to cost."
    - name: "gross_margin_value"
      expr: SUM(extended_retail_value - extended_cost)
      comment: "Total gross margin value (retail value minus cost) from inventory movements. Direct P&L contribution metric reviewed by finance and merchandising leadership."
    - name: "shrinkage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shrinkage_flag = TRUE THEN extended_cost ELSE 0 END) / NULLIF(SUM(CAST(extended_retail_value AS DOUBLE)), 0), 2)
      comment: "Shrinkage as a percentage of total retail value. Industry-standard loss-prevention KPI — typically benchmarked at <1% for top-performing retailers."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(extended_retail_value - extended_cost) / NULLIF(SUM(CAST(extended_retail_value AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage from inventory movements. Core profitability KPI for merchandising and finance leadership."
    - name: "total_ledger_transactions"
      expr: COUNT(1)
      comment: "Total number of stock ledger transactions. Baseline volume metric for throughput and audit completeness."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversal transactions. Elevated reversal rates signal data quality issues or operational errors requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ledger transactions that are reversals. A quality and operational accuracy KPI — high rates indicate systemic process failures."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics covering shrinkage, write-offs, cost impact, and adjustment accuracy. Used by loss prevention, finance, and operations leadership to monitor inventory integrity and control losses."
  source: "`retail_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the adjustment was made — enables location-level shrinkage and loss analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU adjusted — for product-level loss and adjustment pattern analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level adjustment and shrinkage reporting."
    - name: "reason_category"
      expr: reason_category
      comment: "High-level reason category for the adjustment (e.g., theft, damage, admin error) — primary dimension for root-cause analysis."
    - name: "reason_sub_category"
      expr: reason_sub_category
      comment: "Detailed reason sub-category for granular loss classification and targeted intervention."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, approved, posted) for workflow monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment — used to track control compliance and authorisation rates."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents shrinkage — primary loss-prevention filter."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Distinguishes system-generated adjustments from manual ones — manual adjustments carry higher fraud/error risk."
    - name: "detection_method"
      expr: detection_method
      comment: "How the discrepancy was detected (cycle count, POS, RFID, audit) — informs detection effectiveness."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document triggering the adjustment for audit trail analysis."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates adjustments related to product recalls — critical for compliance and risk management."
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', adjustment_timestamp)
      comment: "Month of the adjustment for trend analysis of inventory losses over time."
    - name: "posting_date"
      expr: posting_date
      comment: "Financial posting date for period-aligned adjustment accounting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost impact for multi-currency financial reporting."
  measures:
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total net quantity adjusted across all adjustment records. Measures overall inventory correction volume."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all inventory adjustments. Core P&L metric for inventory write-offs reviewed by CFO and finance leadership."
    - name: "total_shrinkage_cost_impact"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN cost_impact ELSE 0 END)
      comment: "Total cost impact attributable to shrinkage adjustments. Primary loss-prevention financial KPI — directly impacts gross margin."
    - name: "total_shrinkage_quantity"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN adjusted_quantity ELSE 0 END)
      comment: "Total unit quantity lost to shrinkage adjustments. Operational shrinkage volume metric for loss prevention teams."
    - name: "total_recall_adjustment_cost"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN cost_impact ELSE 0 END)
      comment: "Total cost impact of recall-related adjustments. Compliance and risk management KPI for product safety incidents."
    - name: "avg_cost_impact_per_adjustment"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per adjustment record. Tracks severity of individual inventory discrepancies over time."
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. Volume baseline for adjustment frequency and operational control monitoring."
    - name: "shrinkage_adjustment_count"
      expr: COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END)
      comment: "Number of adjustments classified as shrinkage. Frequency metric for loss-prevention programme effectiveness."
    - name: "manual_adjustment_count"
      expr: COUNT(CASE WHEN is_system_generated = FALSE THEN 1 END)
      comment: "Count of manually created adjustments. High manual adjustment rates indicate control weaknesses or fraud risk."
    - name: "shrinkage_adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all adjustments that are shrinkage-related. Measures the proportion of inventory corrections driven by loss — a key loss-prevention governance metric."
    - name: "avg_quantity_variance"
      expr: AVG(ABS(quantity_after_adjustment - quantity_before_adjustment))
      comment: "Average absolute quantity change per adjustment. Measures typical adjustment magnitude — large averages signal systemic inventory accuracy problems."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics used by operations, loss prevention, and finance to assess inventory record accuracy, identify high-variance locations and SKUs, and drive corrective action."
  source: "`retail_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the cycle count was performed — enables location-level accuracy benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU counted — for product-level inventory accuracy analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level count accuracy reporting."
    - name: "department_id"
      expr: department_id
      comment: "Department for departmental inventory accuracy governance."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (full, partial, spot, ABC) for methodology-level analysis."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (scheduled, in-progress, completed, cancelled) for operational monitoring."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the counted SKU — used to prioritise high-value count accuracy."
    - name: "shrinkage_category"
      expr: shrinkage_category
      comment: "Shrinkage category identified during the count — links count variances to loss types."
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason the cycle count was triggered (scheduled, exception, post-adjustment) for process analysis."
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating a recount was required — high recount rates signal counting process quality issues."
    - name: "adjustment_generated"
      expr: adjustment_generated
      comment: "Flag indicating the count resulted in an inventory adjustment — measures count-to-adjustment conversion rate."
    - name: "count_frequency"
      expr: count_frequency
      comment: "Frequency classification of the count programme (daily, weekly, monthly, annual)."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the cycle count for compliance and scheduling analysis."
    - name: "count_month"
      expr: DATE_TRUNC('month', count_start_timestamp)
      comment: "Month the count was performed for trend analysis of inventory accuracy over time."
  measures:
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total net inventory variance quantity identified across all cycle counts. Measures overall inventory record inaccuracy volume."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total financial cost of inventory variances found during cycle counts. Core inventory accuracy financial KPI reviewed by finance and operations leadership."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage per count record. Industry benchmark KPI for inventory record accuracy — world-class retailers target <0.5%."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted. Baseline for computing count coverage and accuracy rates."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Paired with counted quantity to compute accuracy."
    - name: "inventory_record_accuracy_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ABS(variance_quantity) <= (system_quantity * variance_tolerance_pct / 100.0) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count records within tolerance — the standard Inventory Record Accuracy (IRA) KPI. World-class target is >98%. Used in S&OP and operational steering reviews."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount. Measures counting process quality — high rates indicate training or process gaps."
    - name: "adjustment_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that resulted in an inventory adjustment. Measures how often counts reveal actionable discrepancies."
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Baseline for count programme coverage and compliance reporting."
    - name: "counts_with_variance"
      expr: COUNT(CASE WHEN ABS(variance_quantity) > 0 THEN 1 END)
      comment: "Number of count records with any non-zero variance. Measures the breadth of inventory inaccuracy across the estate."
    - name: "avg_unit_cost_at_count"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items counted. Used to weight variance cost analysis and prioritise high-value accuracy improvement."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality and fulfilment metrics. Tracks receipt accuracy, discrepancy rates, rejection rates, and supplier delivery performance — used by supply chain, procurement, and vendor management leadership."
  source: "`retail_ecm`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Receiving inventory node (store or DC) for location-level inbound performance analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor/supplier for vendor-level receipt quality and compliance scoring."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU received for product-level inbound quality analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department for departmental inbound goods performance reporting."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (complete, partial, rejected) for inbound workflow monitoring."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (manual, RFID, scan) for process efficiency analysis."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (passed, failed, pending) for supplier quality governance."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receipt discrepancy (shortage, overage, damage) for root-cause analysis."
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Status of discrepancy resolution — tracks open supplier disputes and chargeback eligibility."
    - name: "receiving_node_type"
      expr: receiving_node_type
      comment: "Type of receiving node (store, DC, cross-dock) for network-level inbound analysis."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Flag indicating the receipt discrepancy is eligible for supplier chargeback — financial recovery signal."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date goods were received for time-series inbound performance trending."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt for monthly inbound volume and quality trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of receipt cost for multi-currency procurement reporting."
  measures:
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total quantity of goods physically received. Core inbound supply chain volume KPI."
    - name: "total_accepted_qty"
      expr: SUM(CAST(accepted_qty AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures effective inbound supply after quality filtering."
    - name: "total_rejected_qty"
      expr: SUM(CAST(rejected_qty AS DOUBLE))
      comment: "Total quantity rejected at receipt. Measures supplier quality failures and their supply impact."
    - name: "total_shortage_qty"
      expr: SUM(CAST(shortage_qty AS DOUBLE))
      comment: "Total quantity short-shipped versus purchase order. Measures supplier delivery compliance and supply risk."
    - name: "total_overage_qty"
      expr: SUM(CAST(overage_qty AS DOUBLE))
      comment: "Total quantity received in excess of order. Overages create inventory and financial reconciliation issues."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_receipt_cost AS DOUBLE))
      comment: "Total cost value of goods received. Core procurement spend and inventory capitalisation metric."
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions. Baseline inbound volume metric."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. Measures supplier delivery fulfilment rate — a primary vendor scorecard KPI."
    - name: "receipt_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that passes quality inspection. Measures inbound quality — low rates trigger supplier quality escalations."
    - name: "receipt_rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected. Vendor quality KPI — high rejection rates drive supplier corrective action and potential delisting."
    - name: "shortage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shortage_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that arrived short. Measures supplier delivery reliability — directly impacts in-stock rates."
    - name: "receipts_with_discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_type IS NOT NULL THEN 1 END)
      comment: "Number of receipts with any discrepancy. Measures inbound process quality and supplier compliance breadth."
    - name: "chargeback_eligible_receipt_count"
      expr: COUNT(CASE WHEN chargeback_eligible = TRUE THEN 1 END)
      comment: "Number of receipts eligible for supplier chargeback. Drives financial recovery actions and vendor accountability."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across goods receipts. Monitors cost inflation and supplier pricing compliance."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics covering order fulfilment rates, lead time compliance, cost efficiency, and emergency order frequency. Used by supply chain, merchandising, and procurement leadership to optimise replenishment programmes."
  source: "`retail_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "destination_node_inventory_node_id"
      expr: destination_node_inventory_node_id
      comment: "Destination inventory node receiving the replenishment — for location-level replenishment performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being replenished — for product-level replenishment efficiency analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor fulfilling the replenishment order — for vendor-level delivery performance scoring."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, in-transit, received, cancelled) for pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (auto, manual, emergency, VMI) for programme-level analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the replenishment (min/max, forecast, manual, promo) for demand-driven analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfilment channel for the replenishment (DC, direct-to-store, cross-dock)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order — high-priority orders indicate supply urgency."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag for emergency replenishment orders — high emergency rates signal poor demand forecasting or supply chain fragility."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag to separate VMI from retailer-managed replenishment performance."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Flag indicating whether the order meets minimum order quantity requirements — non-compliance drives cost inefficiency."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the replenishment order was placed for trend analysis."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Expected delivery date for on-time delivery performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order cost for multi-currency procurement reporting."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across replenishment orders. Measures overall replenishment demand volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against replenishment orders. Measures actual supply delivered versus ordered."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment. Measures authorised supply pipeline."
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of replenishment orders. Core procurement spend metric for budget management and cost control."
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Baseline volume metric for replenishment programme activity."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency replenishment orders. High counts indicate demand forecasting failures or supply chain fragility — a key supply chain risk KPI."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders classified as emergency. Measures supply chain planning effectiveness — world-class operations target <5%."
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. Primary replenishment fulfilment KPI — directly impacts in-stock rates and customer availability."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of replenishment orders delivered on or before expected date. Vendor delivery reliability KPI used in supplier scorecards and S&OP reviews."
    - name: "avg_order_cost"
      expr: AVG(CAST(total_order_cost AS DOUBLE))
      comment: "Average cost per replenishment order. Tracks order efficiency and cost-per-unit trends over time."
    - name: "moq_non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN moq_compliant = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that do not meet minimum order quantity requirements. Non-compliance drives excess freight and handling costs."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled replenishment orders. High cancellation rates signal demand volatility or supplier reliability issues."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-node stock transfer performance metrics covering transfer volume, cost efficiency, on-time delivery, and cross-dock utilisation. Used by supply chain and network planning leadership to optimise inventory redistribution."
  source: "`retail_ecm`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "destination_node_inventory_node_id"
      expr: destination_node_inventory_node_id
      comment: "Destination node receiving the transferred stock — for network flow analysis."
    - name: "primary_stock_inventory_node_id"
      expr: primary_stock_inventory_node_id
      comment: "Source node originating the transfer — for outbound transfer performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being transferred — for product-level transfer pattern analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the transferred stock for VMI transfer analysis."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (initiated, in-transit, received, cancelled) for pipeline monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (store-to-store, DC-to-store, cross-dock, emergency) for programme-level analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (replenishment, rebalancing, clearance, recall) for root-cause analysis."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node (store, DC, fulfilment centre) for network topology analysis."
    - name: "source_node_type"
      expr: source_node_type
      comment: "Type of source node for origin-level transfer analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Flag for cross-dock transfers — cross-dock utilisation is a key supply chain efficiency metric."
    - name: "is_ship_from_store"
      expr: is_ship_from_store
      comment: "Flag for ship-from-store transfers — measures omnichannel fulfilment network utilisation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer — high-priority transfers indicate supply urgency."
    - name: "shipment_date"
      expr: shipment_date
      comment: "Date the transfer was shipped for time-series transfer volume analysis."
    - name: "transfer_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the transfer was initiated for monthly transfer trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of transfer cost for multi-currency financial reporting."
  measures:
    - name: "total_transfer_cost"
      expr: SUM(CAST(transfer_cost AS DOUBLE))
      comment: "Total cost of all stock transfers. Core supply chain cost metric — transfer costs directly impact inventory carrying cost and network efficiency."
    - name: "total_inventory_cost_transferred"
      expr: SUM(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total inventory cost value per unit across transfers. Measures the value of inventory being redistributed across the network."
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Baseline volume metric for network redistribution activity."
    - name: "cross_dock_transfer_count"
      expr: COUNT(CASE WHEN is_cross_dock = TRUE THEN 1 END)
      comment: "Number of cross-dock transfers. Measures cross-dock programme utilisation — a key supply chain efficiency indicator."
    - name: "ship_from_store_transfer_count"
      expr: COUNT(CASE WHEN is_ship_from_store = TRUE THEN 1 END)
      comment: "Number of ship-from-store transfers. Measures omnichannel fulfilment network utilisation and store-as-DC strategy effectiveness."
    - name: "cross_dock_utilisation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cross_dock = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers using cross-dock. Measures supply chain network efficiency — higher cross-dock rates reduce handling costs and lead times."
    - name: "on_time_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_receipt_date <= expected_receipt_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_receipt_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of stock transfers received on or before expected date. Measures internal supply chain delivery reliability — impacts store in-stock rates."
    - name: "avg_transfer_cost"
      expr: AVG(CAST(transfer_cost AS DOUBLE))
      comment: "Average cost per stock transfer. Tracks transfer cost efficiency and identifies high-cost transfer lanes for network optimisation."
    - name: "cancelled_transfer_count"
      expr: COUNT(CASE WHEN transfer_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled stock transfers. High cancellation rates indicate planning instability or supply chain execution failures."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation metrics covering demand encumbrance, reservation fulfilment rates, expiry rates, and omnichannel hold patterns. Used by fulfilment, e-commerce, and supply chain leadership to manage committed inventory and customer promise accuracy."
  source: "`retail_ecm`.`inventory`.`reservation`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node holding the reservation — for location-level reservation demand analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU reserved — for product-level reservation demand and fulfilment analysis."
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation (active, released, expired, fulfilled) for pipeline monitoring."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the reservation — tracks how reservations are resolved."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfilment channel (BOPIS, ship-from-store, DC ship) for omnichannel reservation analysis."
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of inventory encumbrance (customer order, promo hold, safety hold) for hold-type analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for the inventory hold — used to analyse hold patterns and release efficiency."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the reservation — high-priority reservations represent committed customer promises."
    - name: "is_recalled"
      expr: is_recalled
      comment: "Flag for reservations on recalled products — compliance and customer safety signal."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the reserved inventory for VMI reservation analysis."
    - name: "reservation_month"
      expr: DATE_TRUNC('month', reservation_timestamp)
      comment: "Month the reservation was created for trend analysis of reservation demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reservation cost for multi-currency financial reporting."
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity currently reserved across all active reservations. Measures total inventory encumbrance — critical for ATP and available inventory calculations."
    - name: "total_reservation_cost_value"
      expr: SUM(reserved_quantity * inventory_cost_per_unit)
      comment: "Total cost value of reserved inventory (reserved_quantity × inventory_cost_per_unit). Measures capital committed to customer promises."
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation records. Baseline demand encumbrance volume metric."
    - name: "active_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active reservations. Measures live demand commitments against inventory."
    - name: "expired_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'EXPIRED' THEN 1 END)
      comment: "Number of expired reservations. High expiry rates indicate customer abandonment or fulfilment failures — impacts customer satisfaction."
    - name: "reservation_expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reservation_status = 'EXPIRED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that expired without fulfilment. Measures customer promise failure rate — directly linked to lost revenue and customer satisfaction."
    - name: "avg_reserved_quantity_per_reservation"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average quantity per reservation. Tracks typical order size for capacity planning and ATP buffer sizing."
    - name: "avg_inventory_cost_per_unit"
      expr: AVG(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Average inventory cost per unit across reservations. Monitors cost of committed inventory and margin exposure."
    - name: "recalled_reservation_count"
      expr: COUNT(CASE WHEN is_recalled = TRUE THEN 1 END)
      comment: "Number of reservations on recalled products. Compliance KPI — recalled reservations must be released and customers notified."
$$;