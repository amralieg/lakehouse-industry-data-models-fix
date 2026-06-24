-- Metric views for domain: inventory | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health metrics derived from the stock position snapshot. Tracks on-hand availability, safety stock coverage, weeks of supply, and sell-through performance by SKU and node — the primary dashboard for inventory planners and supply chain executives."
  source: "`vibe_retail_v1`.`inventory`.`stock_position`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node (store or DC) identifier for location-level analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier enabling product-level inventory analysis."
    - name: "position_status"
      expr: position_status
      comment: "Current status of the stock position (e.g. active, inactive, discontinued)."
    - name: "replenishment_status"
      expr: replenishment_status
      comment: "Replenishment workflow status (e.g. pending, ordered, received) for operational triage."
    - name: "velocity_band"
      expr: velocity_band
      comment: "Sales velocity classification (e.g. fast, medium, slow) used for prioritisation and space allocation."
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Valuation method applied (e.g. FIFO, LIFO, WAC) for financial reporting segmentation."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating whether the position is classified as dead stock — no movement for an extended period."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag, distinguishing VMI positions from buyer-managed stock."
    - name: "position_date"
      expr: DATE_TRUNC('day', position_timestamp)
      comment: "Date of the stock position snapshot, used for trend analysis over time."
    - name: "last_sale_date"
      expr: last_sale_date
      comment: "Date of the most recent sale for this SKU-node combination, used to identify slow-moving inventory."
  measures:
    - name: "total_on_hand_qty"
      expr: SUM(CAST(on_hand_qty AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions. Core availability KPI used by supply chain and store operations."
    - name: "total_available_to_promise_qty"
      expr: SUM(CAST(available_to_promise_qty AS DOUBLE))
      comment: "Total ATP quantity — on-hand minus reservations and holds. Drives order fulfilment capability and customer promise accuracy."
    - name: "total_reserved_qty"
      expr: SUM(CAST(reserved_qty AS DOUBLE))
      comment: "Total quantity reserved for open orders and fulfilment commitments. Indicates demand encumbrance against on-hand stock."
    - name: "total_in_transit_qty"
      expr: SUM(CAST(in_transit_qty AS DOUBLE))
      comment: "Total quantity currently in transit from suppliers or DCs. Critical for projected availability and replenishment planning."
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total quantity on open purchase or replenishment orders. Reflects future supply pipeline for demand coverage planning."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity held as buffer against demand variability and supply uncertainty."
    - name: "total_damaged_qty"
      expr: SUM(CAST(damaged_qty AS DOUBLE))
      comment: "Total damaged inventory quantity. Drives write-off decisions and supplier quality escalations."
    - name: "total_quarantine_qty"
      expr: SUM(CAST(quarantine_qty AS DOUBLE))
      comment: "Total quantity in quarantine (quality hold). Indicates potential supply risk and compliance exposure."
    - name: "total_shrinkage_qty"
      expr: SUM(CAST(shrinkage_qty AS DOUBLE))
      comment: "Total shrinkage quantity recorded on stock positions. Directly impacts inventory accuracy and P&L loss prevention."
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_qty AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total inventory value at cost (on-hand qty × unit cost). Primary balance-sheet inventory asset metric."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply across positions. Indicates how long current stock will last at current sales rates — key replenishment trigger metric."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across positions. Measures what proportion of received inventory has been sold — critical for markdown and clearance decisions."
    - name: "avg_daily_sales_qty"
      expr: AVG(CAST(avg_daily_sales_qty AS DOUBLE))
      comment: "Average daily sales quantity across positions. Used to calibrate reorder points and safety stock levels."
    - name: "below_safety_stock_position_count"
      expr: COUNT(CASE WHEN on_hand_qty < safety_stock_qty THEN 1 END)
      comment: "Number of SKU-node positions where on-hand quantity is below safety stock threshold. Directly triggers replenishment escalation."
    - name: "dead_stock_position_count"
      expr: COUNT(CASE WHEN is_dead_stock = TRUE THEN 1 END)
      comment: "Number of positions classified as dead stock. Drives markdown, liquidation, and space reallocation decisions."
    - name: "stockout_position_count"
      expr: COUNT(CASE WHEN on_hand_qty <= 0 THEN 1 END)
      comment: "Number of SKU-node positions with zero or negative on-hand quantity. Measures stockout exposure and lost-sales risk."
    - name: "safety_stock_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_hand_qty >= safety_stock_qty THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positions meeting or exceeding their safety stock threshold. Executive KPI for supply chain resilience."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transactional inventory movement metrics from the stock ledger. Captures all inventory flow events (receipts, sales, transfers, adjustments) with financial valuation. Used by finance, operations, and loss prevention for inventory P&L, shrinkage analysis, and movement auditing."
  source: "`vibe_retail_v1`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the stock movement occurred."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the stock movement."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory transaction (e.g. receipt, sale, transfer, adjustment) — primary segmentation for movement analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the ledger transaction (e.g. posted, pending, reversed)."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the inventory movement, enabling root-cause analysis of adjustments and shrinkage."
    - name: "channel"
      expr: channel
      comment: "Sales or fulfilment channel associated with the movement (e.g. store, online, wholesale)."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction for financial period-close reporting."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the transaction was posted to the ledger — used for period-close inventory reconciliation."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the transaction timestamp for trend and period-over-period analysis."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method applied to this transaction (e.g. FIFO, WAC) for financial segmentation."
    - name: "shrinkage_flag"
      expr: shrinkage_flag
      comment: "Indicates whether this transaction represents a shrinkage event — used by loss prevention."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this transaction is a reversal of a prior posting — used for reconciliation quality."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of source document driving the movement (e.g. PO, transfer order, POS receipt)."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Net total inventory movement quantity across all transactions. Measures overall inventory flow volume."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost value of inventory movements. Core financial metric for COGS, inventory valuation, and period-close reporting."
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total retail value of inventory movements. Used to compute gross margin and retail inventory method valuations."
    - name: "total_shrinkage_cost"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN CAST(extended_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of shrinkage transactions. Directly measures inventory loss P&L impact — key loss prevention KPI."
    - name: "shrinkage_transaction_count"
      expr: COUNT(CASE WHEN shrinkage_flag = TRUE THEN 1 END)
      comment: "Number of shrinkage events recorded. Tracks frequency of loss events for operational investigation."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversal transactions. High reversal counts indicate data quality or process compliance issues."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across ledger transactions. Used to monitor cost drift and validate valuation consistency."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across ledger transactions. Supports margin analysis and pricing effectiveness review."
    - name: "gross_margin_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE) - CAST(extended_cost AS DOUBLE))
      comment: "Total gross margin value (retail value minus cost) across inventory movements. Core profitability metric for merchandise and finance teams."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with inventory movements. Measures breadth of active inventory flow."
    - name: "distinct_node_count"
      expr: COUNT(DISTINCT inventory_node_id)
      comment: "Number of distinct inventory nodes with activity. Measures operational footprint of inventory movements."
    - name: "shrinkage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shrinkage_flag = TRUE THEN CAST(extended_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(extended_cost AS DOUBLE)), 0), 4)
      comment: "Shrinkage as a percentage of total inventory cost moved. Industry-standard loss prevention KPI — typically benchmarked at <1.5% for retail."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking quantity corrections, shrinkage events, and cost impacts. Used by loss prevention, store operations, and finance to monitor inventory accuracy, identify systemic issues, and quantify financial exposure from adjustments."
  source: "`vibe_retail_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the adjustment was recorded."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU subject to the adjustment."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g. pending, approved, posted, reversed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — used to track compliance with adjustment authorisation controls."
    - name: "reason_category"
      expr: reason_category
      comment: "High-level reason category for the adjustment (e.g. shrinkage, damage, receiving error) — primary loss analysis dimension."
    - name: "reason_sub_category"
      expr: reason_sub_category
      comment: "Detailed reason sub-category for root-cause drill-down analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "How the discrepancy was detected (e.g. cycle count, POS audit, RFID scan) — informs process improvement."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents a shrinkage event."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Distinguishes system-generated adjustments from manual entries — used for automation quality monitoring."
    - name: "location_type"
      expr: location_type
      comment: "Type of location where the adjustment occurred (e.g. store, DC, warehouse)."
    - name: "department_code"
      expr: department_code
      comment: "Department associated with the adjustment for merchandise-level loss analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the adjustment for period-close financial reporting."
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', adjustment_timestamp)
      comment: "Month of the adjustment for trend analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the adjustment was posted to inventory records."
  measures:
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Net total quantity adjusted across all adjustment transactions. Measures overall inventory correction volume."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all adjustments. Core P&L metric for inventory write-offs and loss quantification."
    - name: "total_shrinkage_cost_impact"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(cost_impact AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact attributable to shrinkage adjustments. Primary loss prevention financial KPI."
    - name: "shrinkage_adjustment_count"
      expr: COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END)
      comment: "Number of shrinkage-classified adjustments. Tracks frequency of loss events for operational response."
    - name: "total_adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. Baseline volume metric for adjustment rate benchmarking."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of adjustments awaiting approval. Operational metric for compliance and control monitoring."
    - name: "avg_cost_impact_per_adjustment"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per adjustment transaction. Identifies high-value adjustment patterns requiring investigation."
    - name: "shrinkage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments classified as shrinkage. Tracks loss event frequency as a proportion of all corrections."
    - name: "distinct_sku_adjusted_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with inventory adjustments. Measures breadth of inventory accuracy issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving accuracy and supplier performance metrics from goods receipt records. Tracks fill rates, discrepancies, quality rejections, and receipt cost. Used by procurement, supply chain, and vendor management to evaluate supplier reliability and receiving process efficiency."
  source: "`vibe_retail_v1`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Receiving node (store or DC) for location-level receiving performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU received — enables product-level supplier fill rate and quality analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor who supplied the goods — primary dimension for supplier performance scorecards."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. complete, partial, rejected) for operational triage."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method used to receive goods (e.g. manual, RFID, ASN-based) for process efficiency analysis."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (e.g. passed, failed, pending) for supplier quality management."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receiving discrepancy (e.g. shortage, overage, damage) for root-cause analysis."
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Resolution status of identified discrepancies — tracks open issues requiring vendor follow-up."
    - name: "receiving_node_type"
      expr: receiving_node_type
      comment: "Type of receiving node (e.g. store, DC, cross-dock) for network-level analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt date for trend and period-over-period supplier performance analysis."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Flag indicating whether the receipt qualifies for a vendor chargeback — financial recovery tracking."
  measures:
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total quantity received across all goods receipts. Baseline inbound supply volume metric."
    - name: "total_accepted_qty"
      expr: SUM(CAST(accepted_qty AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures usable inbound supply after quality screening."
    - name: "total_rejected_qty"
      expr: SUM(CAST(rejected_qty AS DOUBLE))
      comment: "Total quantity rejected at receiving. Drives return-to-vendor decisions and supplier quality escalations."
    - name: "total_shortage_qty"
      expr: SUM(CAST(shortage_qty AS DOUBLE))
      comment: "Total shortage quantity (ordered but not received). Measures supplier fill rate gaps and supply risk."
    - name: "total_overage_qty"
      expr: SUM(CAST(overage_qty AS DOUBLE))
      comment: "Total overage quantity received beyond ordered amount. Indicates supplier shipping accuracy issues."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_receipt_cost AS DOUBLE))
      comment: "Total cost value of all goods received. Core procurement spend and inventory capitalisation metric."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. Primary supplier fill rate KPI — industry benchmark typically >95%."
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that passes quality inspection. Measures supplier quality compliance."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected at inspection. Supplier quality KPI — high rates trigger vendor review."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_type IS NOT NULL AND discrepancy_type <> '' THEN 1 END)
      comment: "Number of receipts with a recorded discrepancy. Measures receiving accuracy and supplier compliance."
    - name: "chargeback_eligible_receipt_count"
      expr: COUNT(CASE WHEN chargeback_eligible = TRUE THEN 1 END)
      comment: "Number of receipts eligible for vendor chargeback. Tracks financial recovery opportunity from supplier non-compliance."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across goods receipts. Used to monitor cost inflation and validate PO pricing compliance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count performance metrics. Tracks count variances, shrinkage classification, and recount rates by location and SKU. Used by store operations, loss prevention, and supply chain to measure inventory record accuracy and drive corrective action."
  source: "`vibe_retail_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the cycle count was performed."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU counted — enables product-level accuracy analysis."
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g. scheduled, in-progress, complete, cancelled)."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g. full, partial, spot-check, RFID) for methodology segmentation."
    - name: "count_frequency"
      expr: count_frequency
      comment: "Frequency classification of the count (e.g. daily, weekly, monthly, annual)."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the counted SKU — used to prioritise count frequency and investigate high-value variances."
    - name: "shrinkage_category"
      expr: shrinkage_category
      comment: "Shrinkage category identified during the count (e.g. theft, damage, admin error)."
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating whether a recount was required due to variance exceeding tolerance."
    - name: "adjustment_generated"
      expr: adjustment_generated
      comment: "Flag indicating whether the count variance triggered an inventory adjustment."
    - name: "count_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled count date for trend and compliance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cycle count for period-close accuracy reporting."
  measures:
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Net total variance quantity (counted minus system quantity). Measures overall inventory record accuracy gap."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total financial value of count variances. Core inventory accuracy P&L metric for finance and loss prevention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts. Industry-standard inventory accuracy KPI — benchmark typically <1%."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted. Baseline volume metric for count programme coverage."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Used alongside counted quantity to compute accuracy."
    - name: "inventory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ABS(variance_percentage) <= variance_tolerance_pct THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines within acceptable variance tolerance. Primary inventory accuracy KPI for operations and audit."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount due to out-of-tolerance variance. Measures count quality and process reliability."
    - name: "adjustment_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that generated an inventory adjustment. Indicates how often physical counts reveal material discrepancies."
    - name: "total_count_lines"
      expr: COUNT(1)
      comment: "Total number of cycle count lines executed. Measures count programme throughput and coverage."
    - name: "distinct_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs counted. Measures breadth of inventory accuracy programme coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking order fulfilment, lead time compliance, cost efficiency, and emergency order rates. Used by supply chain planners, buyers, and operations executives to evaluate replenishment effectiveness and supplier responsiveness."
  source: "`vibe_retail_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "destination_node_inventory_node_id"
      expr: destination_node_inventory_node_id
      comment: "Destination inventory node receiving the replenishment — enables node-level supply performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being replenished — enables product-level replenishment performance analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor fulfilling the replenishment order — primary dimension for supplier lead time and fill rate scorecards."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. open, in-transit, received, cancelled)."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g. regular, emergency, VMI, seasonal)."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfilment channel for the replenishment (e.g. DC-to-store, vendor-direct, cross-dock)."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the replenishment (e.g. reorder point, forecast, manual, VMI) — informs automation effectiveness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the order (e.g. standard, urgent, critical) for operational triage."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag for emergency replenishment orders — high rates indicate planning failures or demand volatility."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag — distinguishes VMI from buyer-initiated replenishment."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Flag indicating whether the order meets minimum order quantity requirements."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the replenishment order was placed for trend and planning cycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the replenishment order for multi-currency financial reporting."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all replenishment orders. Measures inbound supply pipeline volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against replenishment orders. Measures actual supply delivery vs. plan."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment. Measures authorised supply demand."
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of replenishment orders. Core procurement spend metric for inventory investment planning."
    - name: "replenishment_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered replenishment quantity actually received. Measures supplier and DC fulfilment reliability."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders classified as emergency. High rates signal planning failures or chronic stockout risk."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders cancelled. Indicates demand volatility, supplier issues, or planning inaccuracy."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across replenishment orders. Used to monitor cost trends and validate vendor pricing compliance."
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Baseline volume metric for replenishment programme activity."
    - name: "distinct_sku_replenished_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active replenishment orders. Measures breadth of replenishment programme coverage."
    - name: "moq_non_compliant_order_count"
      expr: COUNT(CASE WHEN moq_compliant = FALSE THEN 1 END)
      comment: "Number of orders that do not meet minimum order quantity requirements. Tracks compliance with vendor contract terms."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation and encumbrance metrics tracking demand commitments against available stock. Used by fulfilment operations, omnichannel teams, and supply chain to monitor reservation fulfilment rates, expiry leakage, and inventory encumbrance by channel."
  source: "`vibe_retail_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node holding the reserved stock."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU subject to the reservation."
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation (e.g. active, released, expired, fulfilled)."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the reservation — tracks whether inventory has been released back to available pool."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfilment channel for the reservation (e.g. BOPIS, ship-from-store, online) — key omnichannel dimension."
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of inventory encumbrance (e.g. customer order, corporate hold, recall hold)."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for inventory holds — used to categorise and resolve encumbrances."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the reservation — used to manage fulfilment sequencing."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the reservation for period-level demand commitment reporting."
    - name: "reservation_month"
      expr: DATE_TRUNC('month', reservation_timestamp)
      comment: "Month the reservation was created for trend analysis."
    - name: "is_recalled"
      expr: is_recalled
      comment: "Flag indicating whether the reserved inventory is subject to a product recall — compliance and risk dimension."
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all active reservations. Measures total inventory encumbrance against available stock."
    - name: "total_reservation_value"
      expr: SUM(CAST(reserved_quantity AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost value of reserved inventory (reserved qty × cost per unit). Measures financial exposure of inventory commitments."
    - name: "active_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active reservations. Operational metric for fulfilment workload and inventory encumbrance monitoring."
    - name: "expired_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'EXPIRED' THEN 1 END)
      comment: "Number of reservations that expired without fulfilment. Indicates demand leakage and customer experience failures."
    - name: "recall_hold_reservation_count"
      expr: COUNT(CASE WHEN is_recalled = TRUE THEN 1 END)
      comment: "Number of reservations on recalled inventory. Critical compliance and risk metric requiring immediate operational response."
    - name: "avg_inventory_cost_per_unit"
      expr: AVG(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Average inventory cost per unit across reservations. Used to monitor cost mix of reserved inventory."
    - name: "reservation_expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reservation_status = 'EXPIRED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that expired without fulfilment. High rates indicate fulfilment process failures or over-reservation."
    - name: "distinct_sku_reserved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active reservations. Measures breadth of inventory commitment across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reorder_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reorder policy configuration and coverage metrics. Tracks safety stock levels, reorder points, days of supply targets, and policy compliance across SKU-node combinations. Used by supply chain planners and inventory managers to govern replenishment parameters and identify policy gaps."
  source: "`vibe_retail_v1`.`inventory`.`reorder_policy`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node the reorder policy applies to."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU governed by the reorder policy."
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the reorder policy (e.g. active, inactive, pending review)."
    - name: "reorder_method"
      expr: reorder_method
      comment: "Replenishment method (e.g. min-max, reorder point, days of supply, VMI) — key planning methodology dimension."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU — used to validate that policy parameters are calibrated to item importance."
    - name: "is_auto_replenishment"
      expr: is_auto_replenishment
      comment: "Flag indicating whether replenishment is automated — measures automation coverage of the inventory base."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag for seasonal items — used to segment policy analysis by demand pattern type."
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Flag for vendor-managed inventory policies — distinguishes VMI from buyer-managed replenishment."
    - name: "location_type"
      expr: location_type
      comment: "Type of location the policy applies to (e.g. store, DC, warehouse)."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the policy is effective — used for policy version and change management analysis."
  measures:
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across reorder policies. Measures buffer stock investment level across the network."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity. Indicates the average trigger threshold for replenishment across SKU-node combinations."
    - name: "avg_target_days_of_supply"
      expr: AVG(CAST(target_days_of_supply AS DOUBLE))
      comment: "Average target days of supply across policies. Measures intended inventory coverage level — key planning parameter."
    - name: "avg_target_weeks_of_supply"
      expr: AVG(CAST(target_wos AS DOUBLE))
      comment: "Average target weeks of supply across policies. Complements days-of-supply metric for executive-level inventory coverage reporting."
    - name: "avg_max_stock_quantity"
      expr: AVG(CAST(max_stock_quantity AS DOUBLE))
      comment: "Average maximum stock quantity across policies. Measures upper inventory investment boundary across the network."
    - name: "avg_min_stock_quantity"
      expr: AVG(CAST(min_stock_quantity AS DOUBLE))
      comment: "Average minimum stock quantity across policies. Measures lower inventory floor across the network."
    - name: "auto_replenishment_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto_replenishment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reorder policies with automated replenishment enabled. Measures supply chain automation maturity."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN policy_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active reorder policies. Measures coverage of the governed inventory base."
    - name: "distinct_sku_policy_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with a reorder policy. Measures breadth of replenishment governance coverage."
$$;