-- Metric views for domain: inventory | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics derived from the stock balance fact table. Tracks on-hand quantities, stock values, safety stock coverage, and reorder health across materials, locations, and stock categories. Used by supply chain planners, inventory controllers, and operations executives to manage working capital and service levels."
  source: "`manufacturing_ecm`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record (e.g., unrestricted, blocked, in-quality-inspection). Used to filter active vs. restricted inventory."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., raw material, semi-finished, finished goods). Enables segmentation of inventory by production stage."
    - name: "stock_category"
      expr: stock_category
      comment: "Business category of the stock item. Supports category-level inventory analysis and reporting."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material (A=high value/velocity, B=medium, C=low). Drives prioritization of inventory management effort."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class assigned to the material for accounting purposes. Used to segment inventory value by financial category."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency in which the stock is valued. Enables multi-currency inventory reporting."
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Indicates special stock categories such as consignment, project stock, or sales order stock."
    - name: "obsolete_indicator"
      expr: obsolete_indicator
      comment: "Boolean flag indicating whether the stock item is classified as obsolete. Used to identify and quantify obsolete inventory exposure."
    - name: "slow_moving_indicator"
      expr: slow_moving_indicator
      comment: "Boolean flag indicating slow-moving inventory. Used to identify working capital tied up in low-velocity stock."
    - name: "consignment_indicator"
      expr: consignment_indicator
      comment: "Boolean flag indicating whether the stock is held on consignment from a supplier. Affects ownership and liability reporting."
    - name: "period_end_snapshot_date"
      expr: DATE_TRUNC('month', period_end_snapshot_date)
      comment: "Month-level time bucket of the period-end snapshot date. Enables month-over-month inventory trend analysis."
    - name: "last_goods_receipt_date"
      expr: DATE_TRUNC('month', last_goods_receipt_date)
      comment: "Month of the most recent goods receipt for the stock record. Used to assess inventory freshness and receipt patterns."
    - name: "last_goods_issue_date"
      expr: DATE_TRUNC('month', last_goods_issue_date)
      comment: "Month of the most recent goods issue. Used to identify stagnant stock with no recent consumption."
    - name: "source_system"
      expr: source_system
      comment: "Source ERP or WMS system that originated the stock balance record. Supports multi-system reconciliation."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand across all selected stock records. Primary working capital KPI for finance and supply chain leadership."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity of stock on hand. Baseline inventory volume metric used for capacity and supply planning."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (unrestricted, not reserved or blocked). Directly drives order fulfillment capability."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against open orders or production demands. Indicates committed inventory not yet consumed."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all materials. Represents the buffer inventory investment to protect against demand and supply variability."
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per stock record. Used to monitor price drift and validate standard cost accuracy."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN stock_balance_id END)
      comment: "Number of stock records where current on-hand quantity is below the defined reorder point. A critical replenishment risk indicator — high values signal imminent stockout exposure."
    - name: "stockout_risk_value"
      expr: SUM(CASE WHEN quantity_on_hand < safety_stock_quantity THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total inventory value of stock records where on-hand quantity has fallen below safety stock level. Quantifies the financial exposure of under-stocked positions."
    - name: "obsolete_inventory_value"
      expr: SUM(CASE WHEN obsolete_indicator = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of inventory flagged as obsolete. Directly represents write-off risk and working capital inefficiency for executive review."
    - name: "slow_moving_inventory_value"
      expr: SUM(CASE WHEN slow_moving_indicator = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of slow-moving inventory. Highlights working capital tied up in low-velocity stock that may require markdown or disposal action."
    - name: "available_to_on_hand_ratio"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is freely available (not reserved or blocked). A high ratio indicates healthy, unencumbered stock; a low ratio signals over-reservation or quality holds."
    - name: "last_count_variance_quantity_total"
      expr: SUM(CAST(last_count_variance_quantity AS DOUBLE))
      comment: "Sum of quantity variances recorded at the last physical count across all stock records. Measures systemic inventory accuracy issues that drive financial adjustments."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active stock balances. Indicates inventory breadth and complexity for portfolio management decisions."
    - name: "distinct_stock_location_count"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of distinct storage locations holding inventory. Used to assess inventory dispersion and consolidation opportunities."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and transaction metrics derived from the stock movement event table. Tracks goods receipts, goods issues, transfers, reversals, and movement volumes. Used by warehouse managers, supply chain analysts, and operations executives to monitor inventory velocity, throughput, and accuracy."
  source: "`manufacturing_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "ERP movement type code (e.g., 101=GR, 201=GI to cost center, 311=transfer). The primary classification for understanding the nature of each inventory transaction."
    - name: "movement_status"
      expr: movement_status
      comment: "Processing status of the stock movement (e.g., posted, reversed, pending). Used to filter completed vs. in-progress transactions."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement (e.g., unrestricted, quality inspection, blocked). Enables analysis of movements by stock category."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Business reason code for the movement (e.g., scrap, return, transfer). Supports root-cause analysis of inventory adjustments."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of the originating reference document (e.g., purchase order, production order, sales order). Links movements to upstream business processes."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Boolean flag indicating whether the movement is a goods receipt. Used to isolate inbound inventory flows."
    - name: "goods_issue_indicator"
      expr: goods_issue_indicator
      comment: "Boolean flag indicating whether the movement is a goods issue. Used to isolate outbound inventory consumption flows."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag indicating whether the movement is a reversal of a prior posting. High reversal rates signal process quality issues."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-level bucket of the posting date. Enables month-over-month trend analysis of inventory movements."
    - name: "document_date_month"
      expr: DATE_TRUNC('month', document_date)
      comment: "Month-level bucket of the document date. Used to compare document date vs. posting date for timeliness analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the movement quantity. Required for correct aggregation and cross-material comparisons."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates special stock categories involved in the movement (e.g., consignment, project stock)."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all stock movement transactions. Measures overall inventory throughput and activity volume."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity received into inventory via goods receipts. Tracks inbound supply flow and receiving throughput."
    - name: "total_goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity issued out of inventory. Measures consumption and outbound fulfillment volume."
    - name: "total_reversal_quantity"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity involved in reversal transactions. High reversal volumes indicate posting errors, process failures, or quality rejections requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN stock_movement_id END) / NULLIF(COUNT(stock_movement_id), 0), 2)
      comment: "Percentage of stock movement transactions that are reversals. A key process quality KPI — elevated reversal rates signal systemic posting errors or receiving/issuing process failures."
    - name: "distinct_movement_days"
      expr: COUNT(DISTINCT posting_date)
      comment: "Number of distinct posting dates with movement activity. Measures warehouse operational cadence and activity distribution."
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with movement activity in the period. Indicates inventory breadth being actively managed."
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per stock movement transaction. Used to detect anomalous large or small movements that may indicate data quality or process issues."
    - name: "total_movement_transactions"
      expr: COUNT(stock_movement_id)
      comment: "Total number of stock movement transactions. Baseline throughput metric for warehouse operations capacity planning."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count program metrics derived from the cycle count header table. Tracks count completion, variance exposure, accuracy rates, and recount frequency. Used by inventory controllers, warehouse managers, and finance to govern inventory accuracy and validate book values."
  source: "`manufacturing_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (e.g., planned, in-progress, completed, cancelled). Used to track count program execution."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., cycle count, annual physical inventory, spot check). Enables segmentation of count program by methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used to perform the count (e.g., blind count, system-guided, manual). Used to assess count quality by methodology."
    - name: "count_scope"
      expr: count_scope
      comment: "Scope of the count (e.g., full warehouse, zone, ABC class). Supports analysis of count coverage and completeness."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the counted inventory. Enables accuracy analysis by inventory criticality tier."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cycle count (e.g., pending, approved, rejected). Tracks governance and sign-off compliance."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the variance posting to the general ledger. Indicates whether count variances have been financially recognized."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Boolean flag indicating whether a recount was required due to tolerance breach. High recount rates signal systemic accuracy problems."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cycle count. Enables year-over-year accuracy trend analysis."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month-level bucket of the count date. Supports monthly cycle count program tracking and trend analysis."
    - name: "variance_currency_code"
      expr: variance_currency_code
      comment: "Currency in which variance values are expressed. Required for correct financial aggregation in multi-currency environments."
    - name: "count_zone"
      expr: count_zone
      comment: "Warehouse zone covered by the cycle count. Enables zone-level accuracy benchmarking."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(cycle_count_id)
      comment: "Total number of cycle count events. Measures the volume and cadence of the inventory count program."
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage across all cycle counts. The primary KPI for inventory record accuracy — directly impacts financial reporting reliability and order fulfillment confidence."
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified across all cycle counts. Measures the magnitude of inventory discrepancies between physical and book inventory."
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Directly represents P&L exposure from inventory inaccuracies — a key metric for finance and audit."
    - name: "recount_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN cycle_count_id END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of cycle counts requiring a recount due to tolerance breach. Elevated rates indicate systemic accuracy problems in specific zones, methods, or material classes."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance threshold applied across cycle counts. Used to assess whether tolerance policies are appropriately calibrated relative to observed accuracy."
    - name: "counts_below_target_accuracy"
      expr: COUNT(CASE WHEN accuracy_percentage < 95.0 THEN cycle_count_id END)
      comment: "Number of cycle counts where accuracy fell below the 95% industry benchmark threshold. Identifies locations, zones, or periods requiring corrective action."
    - name: "approved_count_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN cycle_count_id END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of cycle counts that have been formally approved. Measures governance compliance of the count program."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_cycle_count_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inventory accuracy metrics from cycle count detail records. Enables material-level and location-level variance analysis, tolerance compliance, and recount tracking. Used by inventory analysts and warehouse supervisors to identify specific materials and locations driving accuracy issues."
  source: "`manufacturing_ecm`.`inventory`.`cycle_count_line`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the individual count line (e.g., counted, recounted, posted). Tracks line-level completion."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock for the counted line item. Enables accuracy analysis by stock category."
    - name: "recount_indicator"
      expr: recount_indicator
      comment: "Boolean flag indicating whether this line required a recount. Used to identify materials and locations with persistent accuracy issues."
    - name: "posting_indicator"
      expr: posting_indicator
      comment: "Boolean flag indicating whether the variance for this line has been posted to the general ledger."
    - name: "freeze_book_inventory_indicator"
      expr: freeze_book_inventory_indicator
      comment: "Boolean flag indicating whether book inventory was frozen at count time. Ensures count integrity analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied to the counted material. Used for financial segmentation of variance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the count quantities. Required for correct aggregation."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates special stock categories (e.g., consignment, project stock) for the count line."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month-level bucket of the count date. Enables monthly trend analysis of line-level accuracy."
    - name: "recount_reason_code"
      expr: recount_reason_code
      comment: "Reason code explaining why a recount was required. Supports root-cause analysis of accuracy failures."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code assigned to explain the variance. Used to categorize and trend variance root causes."
  measures:
    - name: "total_difference_quantity"
      expr: SUM(CAST(difference_quantity AS DOUBLE))
      comment: "Total quantity difference between counted and book inventory across all count lines. Measures the aggregate magnitude of inventory discrepancies at the line level."
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book (system) inventory quantity across counted lines. Baseline for calculating accuracy rates and variance percentages."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity across all count lines. Compared against book quantity to derive variance."
    - name: "line_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN difference_quantity = 0 THEN cycle_count_line_id END) / NULLIF(COUNT(cycle_count_line_id), 0), 2)
      comment: "Percentage of count lines with zero variance (exact match between counted and book quantity). The most granular inventory accuracy KPI — directly measures record accuracy at the SKU-location level."
    - name: "recount_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_indicator = TRUE THEN cycle_count_line_id END) / NULLIF(COUNT(cycle_count_line_id), 0), 2)
      comment: "Percentage of count lines requiring a recount. Identifies materials and locations with persistent accuracy problems warranting process intervention."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance threshold applied at the line level. Used to assess tolerance policy calibration relative to observed variance rates."
    - name: "lines_exceeding_tolerance"
      expr: COUNT(CASE WHEN ABS(difference_quantity) > (book_quantity * tolerance_percentage / 100.0) THEN cycle_count_line_id END)
      comment: "Number of count lines where the absolute variance exceeds the defined tolerance threshold. Directly identifies out-of-tolerance inventory positions requiring financial adjustment and root-cause investigation."
    - name: "distinct_materials_counted"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials included in cycle count lines. Measures the breadth of inventory coverage in the count program."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability, quality, and shelf-life metrics. Tracks batch availability, blocked quantities, expiry exposure, and quality decisions across the supply chain. Used by quality managers, supply chain planners, and regulatory compliance teams to manage batch risk and traceability."
  source: "`manufacturing_ecm`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., unrestricted, blocked, restricted, expired). Primary dimension for batch availability analysis."
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch (e.g., standard, rework, trial). Used to segment batch quality and compliance analysis."
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality inspection decision for the batch (e.g., accepted, rejected, conditionally released). Drives batch disposition and supply risk assessment."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates special stock type for the batch (e.g., consignment, project). Used for ownership and liability segmentation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied to the batch. Used for financial segmentation of batch cost analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating whether the batch contains hazardous material. Used for compliance and safety reporting."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the batch. Supports trade compliance and supply chain risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which batch cost is expressed. Required for correct financial aggregation."
    - name: "goods_receipt_date_month"
      expr: DATE_TRUNC('month', goods_receipt_date)
      comment: "Month-level bucket of the goods receipt date. Enables monthly inbound batch volume and cost trend analysis."
    - name: "manufacturing_date_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Month-level bucket of the manufacturing date. Used for production batch aging and shelf-life analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month-level bucket of the batch expiry date. Critical for identifying near-term expiry exposure."
  measures:
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available across all batches. Measures the usable inventory pool from a batch perspective."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked across all batches (e.g., quality hold, regulatory block). Quantifies supply at risk due to quality or compliance issues."
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total quantity in restricted status. Represents inventory with conditional use limitations that may impact production or fulfillment."
    - name: "total_batch_cost_value"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total cost value of all batches. Measures the financial exposure of the batch inventory portfolio."
    - name: "blocked_quantity_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE) + CAST(blocked_quantity AS DOUBLE) + CAST(restricted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total batch quantity that is blocked. A high rate signals quality or compliance issues constraining supply availability."
    - name: "expiring_batch_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN lot_batch_id END)
      comment: "Number of batches expiring within the next 90 days. A critical supply risk KPI — enables proactive disposition planning to avoid waste and stockouts."
    - name: "expired_batch_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN lot_batch_id END)
      comment: "Number of batches that have already passed their expiry date. Represents immediate write-off risk and compliance exposure."
    - name: "avg_batch_cost_amount"
      expr: AVG(CAST(batch_cost_amount AS DOUBLE))
      comment: "Average cost per batch. Used to benchmark batch economics and identify cost outliers requiring investigation."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches. Measures production output volume tracked at the batch level."
    - name: "distinct_active_batches"
      expr: COUNT(DISTINCT lot_batch_id)
      comment: "Number of distinct active batch records. Measures batch portfolio complexity and traceability scope."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance and fulfillment metrics. Tracks order quantities, fulfillment rates, lead times, cost, and safety stock coverage. Used by supply chain planners, procurement managers, and operations executives to manage replenishment effectiveness and inventory availability."
  source: "`manufacturing_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., open, in-progress, fulfilled, cancelled). Primary dimension for order pipeline analysis."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (e.g., MRP-driven, kanban, manual, safety stock). Enables analysis of replenishment strategy effectiveness."
    - name: "source_type"
      expr: source_type
      comment: "Source of the replenishment (e.g., external purchase, internal transfer, production). Used to segment supply chain by sourcing strategy."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order. Used to assess urgency distribution and identify expediting patterns."
    - name: "reference_order_type"
      expr: reference_order_type
      comment: "Type of the originating reference document (e.g., MRP planned order, sales order, project). Links replenishment to demand drivers."
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement type (e.g., consignment, subcontracting, third-party). Used for procurement strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the replenishment order cost is expressed. Required for correct financial aggregation."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Boolean flag indicating whether incoming goods require quality inspection. Used to assess quality gate coverage."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month-level bucket of the requested delivery date. Enables monthly demand and replenishment planning analysis."
    - name: "confirmed_delivery_date_month"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Month-level bucket of the confirmed delivery date. Used to assess supplier commitment reliability."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for replenishment quantities. Required for correct aggregation."
  measures:
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity required across all replenishment orders. Measures aggregate demand placed on the replenishment system."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled across all replenishment orders. Measures actual supply delivered against replenishment demand."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required replenishment quantity that has been fulfilled. The primary replenishment effectiveness KPI — directly impacts inventory availability and service levels."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all replenishment orders. Measures the financial commitment of the replenishment pipeline for budget and cash flow management."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against replenishment orders. Indicates committed supply not yet received."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity targeted across replenishment orders. Measures the safety buffer investment being managed through the replenishment system."
    - name: "open_order_count"
      expr: COUNT(CASE WHEN order_status NOT IN ('CLOSED', 'CANCELLED') THEN replenishment_order_id END)
      comment: "Number of open (non-closed, non-cancelled) replenishment orders. Measures the active replenishment workload and pipeline size."
    - name: "avg_estimated_cost_per_order"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per replenishment order. Used to benchmark order economics and identify high-cost replenishment patterns."
    - name: "unfulfilled_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE) - CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity still outstanding (required minus fulfilled) across all replenishment orders. Directly quantifies the open supply gap that threatens inventory availability."
    - name: "distinct_materials_replenished"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active replenishment orders. Measures the breadth of the replenishment program."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_serialized_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Serialized unit tracking and valuation metrics for high-value, individually tracked inventory items. Monitors stock status, quality inspection outcomes, valuation, and physical characteristics. Used by asset managers, quality teams, and supply chain executives for high-value item traceability and compliance."
  source: "`manufacturing_ecm`.`inventory`.`serialized_unit`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current stock status of the serialized unit (e.g., available, blocked, in-transit, scrapped). Primary dimension for unit availability analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock for the serialized unit. Used to segment units by inventory category."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status of the serialized unit (e.g., passed, failed, pending). Tracks quality gate compliance for high-value items."
    - name: "unit_type"
      expr: unit_type
      comment: "Type classification of the serialized unit (e.g., finished product, spare part, component). Enables portfolio segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the unit (e.g., company-owned, customer-owned, consignment). Used for asset ownership and liability reporting."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the most recent stock movement for the unit. Used to understand current unit activity and disposition."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Boolean flag indicating whether the serialized unit contains hazardous material. Required for compliance and safety reporting."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the serialized unit. Supports trade compliance and customs reporting."
    - name: "manufacturing_date_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Month-level bucket of the manufacturing date. Used for unit aging and shelf-life analysis."
    - name: "last_movement_month"
      expr: DATE_TRUNC('month', CAST(last_movement_timestamp AS DATE))
      comment: "Month-level bucket of the last movement timestamp. Used to identify dormant or stagnant serialized units."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the serialized unit quantity. Required for correct aggregation."
  measures:
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of all serialized units. Measures the financial value of the serialized inventory portfolio — a key asset management KPI."
    - name: "total_unit_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all serialized unit records. Measures the physical volume of the serialized inventory pool."
    - name: "avg_valuation_per_unit"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation amount per serialized unit record. Used to benchmark unit economics and identify high-value outliers."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_status = 'PASSED' THEN serialized_unit_id END) / NULLIF(COUNT(CASE WHEN quality_inspection_status IS NOT NULL THEN serialized_unit_id END), 0), 2)
      comment: "Percentage of inspected serialized units that passed quality inspection. Measures first-pass quality yield for high-value serialized items."
    - name: "blocked_unit_value"
      expr: SUM(CASE WHEN stock_status = 'BLOCKED' THEN CAST(valuation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total valuation of serialized units in blocked status. Quantifies the financial value of high-value inventory at risk due to quality or compliance holds."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all serialized units in kilograms. Used for logistics capacity planning and shipping cost estimation."
    - name: "distinct_serialized_units"
      expr: COUNT(DISTINCT serialized_unit_id)
      comment: "Number of distinct serialized units tracked. Measures the size and complexity of the serialized inventory portfolio."
    - name: "expiring_units_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN serialized_unit_id END)
      comment: "Number of serialized units expiring within the next 90 days. Enables proactive disposition planning for high-value items to avoid write-offs."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, utilization, and compliance metrics. Tracks storage capacity, operational status, certification compliance, and facility characteristics. Used by operations executives, facility managers, and compliance teams to optimize warehouse network capacity and regulatory standing."
  source: "`manufacturing_ecm`.`inventory`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse (e.g., active, inactive, under-maintenance). Used to filter the active warehouse network."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (e.g., distribution center, manufacturing plant, cross-dock). Enables network segmentation by facility role."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the warehouse (e.g., owned, leased, 3PL). Used for make-vs-buy and network strategy analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located. Enables geographic network analysis and regional capacity planning."
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Boolean flag indicating whether the warehouse is climate-controlled. Used to match storage requirements to facility capabilities."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Boolean flag indicating hazardous material storage certification. Critical for compliance and risk management reporting."
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Boolean flag indicating whether the warehouse uses automated storage and retrieval systems. Used to assess automation investment and throughput capability."
    - name: "iso_9001_certified_flag"
      expr: iso_9001_certified_flag
      comment: "Boolean flag indicating ISO 9001 quality management certification. Used for quality compliance network reporting."
    - name: "iso_14001_certified_flag"
      expr: iso_14001_certified_flag
      comment: "Boolean flag indicating ISO 14001 environmental management certification. Used for sustainability and regulatory compliance reporting."
    - name: "customs_bonded_flag"
      expr: customs_bonded_flag
      comment: "Boolean flag indicating whether the warehouse is customs-bonded. Used for trade compliance and import/export planning."
  measures:
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total storage area in square meters across all warehouses. Primary capacity metric for network planning and real estate decisions."
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable volumetric capacity across all warehouses. Measures the effective storage capacity available for inventory."
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total theoretical volumetric capacity across all warehouses. Used as the denominator for utilization rate calculations."
    - name: "usable_capacity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of total warehouse capacity that is designated as usable. Measures space efficiency and identifies facilities with high unusable space ratios."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN operational_status = 'ACTIVE' THEN warehouse_id END)
      comment: "Number of operationally active warehouses. Measures the size of the active warehouse network for capacity and cost planning."
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN warehouse_id END)
      comment: "Number of warehouses certified for hazardous material storage. Measures compliance network capacity for hazmat supply chains."
    - name: "avg_storage_area_sqm"
      expr: AVG(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Average storage area per warehouse in square meters. Used to benchmark facility size and identify outliers in the network."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area across all warehouses in square meters. Used for real estate portfolio management and lease cost benchmarking."
$$;