-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory health metrics derived from stock balance snapshots. Covers on-hand value, availability, safety stock coverage, and slow/obsolete stock exposure — core KPIs for inventory investment decisions and working capital management."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_category"
      expr: stock_category
      comment: "Categorisation of stock (e.g. raw material, WIP, finished goods) for segmented inventory analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g. unrestricted, quality inspection, blocked) used to filter usable vs. restricted inventory."
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record, enabling drill-down into active, blocked, or obsolete positions."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material (A=high value, B=medium, C=low) for prioritised inventory management."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class grouping materials by accounting treatment, supporting financial inventory reporting."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency in which stock value is expressed, enabling multi-currency inventory reporting."
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Identifies consignment, project, or customer-owned stock for segregated reporting."
    - name: "slow_moving_indicator"
      expr: slow_moving_indicator
      comment: "Flag indicating whether the stock position is classified as slow-moving, supporting write-down risk analysis."
    - name: "obsolete_indicator"
      expr: obsolete_indicator
      comment: "Flag indicating obsolete stock, critical for write-off exposure and working capital risk reporting."
    - name: "period_end_snapshot_date"
      expr: DATE_TRUNC('month', period_end_snapshot_date)
      comment: "Month-end snapshot date bucketed to month for period-over-period inventory trend analysis."
    - name: "last_goods_receipt_date_month"
      expr: DATE_TRUNC('month', last_goods_receipt_date)
      comment: "Month of last goods receipt, used to identify aging stock positions with no recent inbound activity."
    - name: "last_goods_issue_date_month"
      expr: DATE_TRUNC('month', last_goods_issue_date)
      comment: "Month of last goods issue, used to identify stock with no recent consumption or shipment activity."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of all stock positions. Primary working capital KPI used by finance and supply chain leadership to manage inventory investment."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity on hand across all stock positions. Baseline supply availability metric for operations and demand fulfilment planning."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (excluding reserved and blocked stock). Directly drives order fulfilment capability assessments."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against open orders or production demands. Indicates committed inventory that cannot be reallocated."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all positions. Measures the buffer inventory investment maintained to protect against demand and supply variability."
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per stock record. Used to monitor unit cost trends and detect valuation anomalies across the inventory portfolio."
    - name: "slow_moving_stock_value"
      expr: SUM(CASE WHEN slow_moving_indicator = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock flagged as slow-moving. Key risk metric for working capital tied up in low-velocity inventory, informing markdown or disposal decisions."
    - name: "obsolete_stock_value"
      expr: SUM(CASE WHEN obsolete_indicator = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock flagged as obsolete. Directly quantifies write-off exposure and is a critical input to inventory impairment reviews."
    - name: "available_to_on_hand_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is freely available (not reserved or blocked). Measures inventory liquidity and fulfilment readiness; low values signal over-reservation or quality holds."
    - name: "safety_stock_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(safety_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Safety stock as a percentage of total on-hand quantity. Indicates what proportion of inventory is held purely as buffer, informing safety stock optimisation decisions."
    - name: "slow_and_obsolete_stock_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slow_moving_indicator = TRUE OR obsolete_indicator = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "SLOB (Slow-moving and Obsolete) stock as a percentage of total inventory value. A headline KPI for inventory quality reviewed at executive and board level."
    - name: "last_count_variance_quantity_total"
      expr: SUM(CAST(last_count_variance_quantity AS DOUBLE))
      comment: "Sum of quantity variances recorded at last physical count. Measures inventory record accuracy exposure and drives cycle count prioritisation."
    - name: "distinct_material_positions"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active stock positions. Measures inventory breadth and complexity, informing rationalisation and SKU reduction initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational inventory flow metrics derived from stock movement transactions. Covers goods receipt, goods issue, transfer, and reversal activity — essential for throughput, accuracy, and supply chain velocity analysis."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "ERP movement type code (e.g. 101=GR, 261=GI to production) classifying the nature of each inventory transaction."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code associated with the movement, enabling root-cause analysis of adjustments, returns, and transfers."
    - name: "movement_status"
      expr: movement_status
      comment: "Processing status of the movement document, used to identify pending, posted, or reversed transactions."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the movement (unrestricted, quality inspection, blocked), enabling analysis by inventory category."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Boolean flag identifying inbound goods receipt movements, used to isolate and measure receiving activity."
    - name: "goods_issue_indicator"
      expr: goods_issue_indicator
      comment: "Boolean flag identifying outbound goods issue movements, used to isolate and measure consumption and shipment activity."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag identifying reversal transactions. High reversal rates signal process errors or data quality issues."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates whether the movement involves special stock (consignment, project stock, etc.)."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date bucketed to month for period-over-period movement volume and value trend analysis."
    - name: "document_date_month"
      expr: DATE_TRUNC('month', document_date)
      comment: "Document date bucketed to month, used to compare document creation timing against posting timing for process lag analysis."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where the movement occurred, enabling location-level throughput and activity analysis."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of the reference document (purchase order, production order, sales order) driving the movement, for source-of-demand analysis."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions. Primary throughput metric for warehouse and inventory operations."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity received into inventory. Measures inbound supply flow and is a key input to receiving productivity and supplier performance analysis."
    - name: "total_goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity issued from inventory. Measures outbound consumption and shipment flow, directly linked to production and customer fulfilment performance."
    - name: "total_reversal_quantity"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity involved in reversal transactions. High values indicate process errors, mis-postings, or returns requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total movement quantity that was subsequently reversed. A quality and process accuracy KPI — high rates signal systemic posting errors."
    - name: "goods_receipt_transaction_count"
      expr: COUNT(CASE WHEN goods_receipt_indicator = TRUE THEN stock_movement_id END)
      comment: "Number of goods receipt transactions. Measures receiving workload and throughput for warehouse capacity and staffing decisions."
    - name: "goods_issue_transaction_count"
      expr: COUNT(CASE WHEN goods_issue_indicator = TRUE THEN stock_movement_id END)
      comment: "Number of goods issue transactions. Measures outbound picking and issuing workload for warehouse operations management."
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with movement activity in the period. Measures inventory velocity breadth and identifies dormant SKUs with no movement."
    - name: "distinct_source_locations_active"
      expr: COUNT(DISTINCT source_stock_location_id)
      comment: "Number of distinct source stock locations with outbound movement activity. Measures warehouse utilisation and identifies inactive storage areas."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count programme metrics. Covers count completion, variance exposure, accuracy rates, and recount frequency — essential KPIs for inventory record accuracy governance and audit readiness."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (e.g. planned, in-progress, completed, cancelled) for pipeline and completion tracking."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g. full, sample, continuous) used to segment accuracy results by counting methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g. manual, RF scanner, RFID) enabling comparison of accuracy by technology."
    - name: "count_scope"
      expr: count_scope
      comment: "Scope of the count (e.g. full location, ABC-A items only) for segmented accuracy and coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the count document, used to track governance compliance and identify counts pending sign-off."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of variance posting to the general ledger, critical for financial close and inventory valuation accuracy."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating whether a recount was required due to variance exceeding tolerance. High rates indicate systemic accuracy issues."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification flag on the count, enabling accuracy analysis segmented by material criticality."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count for year-over-year accuracy trend analysis and audit period reporting."
    - name: "posting_period"
      expr: posting_period
      comment: "Accounting posting period of the count, used for period-level inventory accuracy and variance reporting."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Count date bucketed to month for trend analysis of counting activity and accuracy over time."
  measures:
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total monetary value of inventory variances identified across all cycle counts. Primary financial exposure metric for inventory accuracy, reviewed at CFO and audit committee level."
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance across all cycle counts. Measures the physical magnitude of inventory discrepancies independent of value."
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory record accuracy percentage across completed cycle counts. Headline KPI for inventory data quality and a key metric in operational excellence programmes."
    - name: "total_items_counted"
      expr: SUM(CAST(total_items_counted AS DOUBLE))
      comment: "Total number of line items counted across all cycle count documents. Measures counting programme throughput and coverage."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount due to variance exceeding tolerance. High rates indicate systemic accuracy problems or process failures requiring management intervention."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance threshold applied across cycle counts. Monitors whether tolerance settings are appropriately calibrated relative to observed accuracy levels."
    - name: "counts_with_variance_above_tolerance"
      expr: COUNT(CASE WHEN CAST(accuracy_percentage AS DOUBLE) < (100.0 - CAST(tolerance_percentage AS DOUBLE)) THEN cycle_count_id END)
      comment: "Number of cycle counts where accuracy fell below the defined tolerance threshold. Directly measures the frequency of material inventory discrepancies requiring corrective action."
    - name: "completed_count_documents"
      expr: COUNT(CASE WHEN count_status = 'Completed' THEN cycle_count_id END)
      comment: "Number of completed cycle count documents. Measures programme execution rate against the planned counting schedule."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning and execution metrics covering order fulfilment rates, lead times, cost, and safety stock adequacy. Supports supply chain leadership decisions on replenishment strategy, supplier performance, and inventory investment."
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. open, in-progress, closed, cancelled) for pipeline and fulfilment tracking."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment trigger (e.g. MRP, kanban, reorder point, manual) enabling analysis of planning method effectiveness."
    - name: "source_type"
      expr: source_type
      comment: "Source of supply for the replenishment (e.g. internal production, external purchase, transfer) for make-vs-buy analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order, used to analyse whether high-priority orders are fulfilled faster than standard orders."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the replenishment order cost, enabling multi-currency procurement cost analysis."
    - name: "reference_order_type"
      expr: reference_order_type
      comment: "Type of the originating reference document (e.g. sales order, forecast, MRP run) for demand-source analysis."
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement type (e.g. consignment, subcontracting) for segmented supply strategy analysis."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Requested delivery date bucketed to month for demand timing and replenishment lead time analysis."
    - name: "confirmed_delivery_date_month"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Confirmed delivery date bucketed to month for supply commitment and on-time delivery performance analysis."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the replenishment order was created, used for order creation volume trends and planning cycle analysis."
  measures:
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity demanded across all replenishment orders. Measures aggregate replenishment demand volume for capacity and supply planning."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled against replenishment orders. Measures actual supply delivery performance against demand."
    - name: "order_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required replenishment quantity that has been fulfilled. A headline supply chain performance KPI measuring how well replenishment meets demand."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all replenishment orders. Primary procurement spend metric for inventory replenishment budget management and cost control."
    - name: "avg_estimated_cost_per_order"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per replenishment order. Monitors unit replenishment cost trends and identifies high-cost outliers for sourcing review."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against replenishment orders. Measures committed supply pipeline that is not yet physically received."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity targeted across replenishment orders. Measures the planned buffer inventory investment in the replenishment programme."
    - name: "open_replenishment_orders"
      expr: COUNT(CASE WHEN order_status NOT IN ('Closed', 'Cancelled') THEN replenishment_order_id END)
      comment: "Number of open (non-closed, non-cancelled) replenishment orders. Measures the active replenishment pipeline and workload for supply chain operations."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size quantity across replenishment orders. Monitors ordering patterns and identifies opportunities for lot size optimisation to reduce inventory carrying costs."
    - name: "reorder_point_quantity_total"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Sum of reorder point quantities across all replenishment orders. Measures the aggregate inventory trigger level, informing whether reorder points are appropriately calibrated relative to actual demand."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics covering inventory availability, quality status, expiry risk, and batch cost. Supports quality, compliance, and supply chain decisions on batch disposition, shelf-life management, and cost tracking."
  source: "`vibe_manufacturing_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g. unrestricted, blocked, restricted) for quality and availability segmentation."
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch (e.g. standard, rework, trial) enabling analysis by batch origin and quality tier."
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality inspection decision for the batch (e.g. accepted, rejected, conditional release) for quality performance analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied to the batch, used for financial inventory analysis by cost layer."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which batch cost is expressed, enabling multi-currency batch cost analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the batch contains hazardous material, used for compliance and storage risk reporting."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin of the batch, used for trade compliance, tariff, and supply chain risk analysis."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates whether the batch is held as special stock (consignment, project, etc.) for segregated reporting."
    - name: "manufacturing_date_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Manufacturing date bucketed to month for batch age and shelf-life trend analysis."
    - name: "goods_receipt_date_month"
      expr: DATE_TRUNC('month', goods_receipt_date)
      comment: "Goods receipt date bucketed to month for inbound batch volume and lead time trend analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Expiry date bucketed to month for near-term expiry risk monitoring and batch disposition planning."
  measures:
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity across all batches. Measures usable inventory at batch level, critical for production scheduling and order fulfilment."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked across all batches. Measures inventory held back due to quality holds or other restrictions — a key quality risk exposure metric."
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total quantity under restricted use across all batches. Indicates inventory with conditional release status requiring management decision."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced and recorded at batch level. Measures production output volume for yield and throughput analysis."
    - name: "total_batch_cost"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total cost of all batches. Primary batch-level cost metric for inventory valuation, cost of goods sold analysis, and margin management."
    - name: "avg_batch_cost"
      expr: AVG(CAST(batch_cost_amount AS DOUBLE))
      comment: "Average cost per batch. Monitors unit batch cost trends and identifies cost outliers for production efficiency and procurement review."
    - name: "blocked_to_available_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE) + CAST(blocked_quantity AS DOUBLE) + CAST(restricted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total batch inventory that is blocked. A quality health KPI — high values indicate systemic quality issues reducing usable supply."
    - name: "distinct_active_batches"
      expr: COUNT(DISTINCT CASE WHEN batch_status NOT IN ('Closed', 'Cancelled', 'Expired') THEN lot_batch_id END)
      comment: "Number of distinct active batches in inventory. Measures batch portfolio complexity and traceability workload for quality and compliance teams."
    - name: "hazardous_batch_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN lot_batch_id END)
      comment: "Number of batches containing hazardous materials. Measures regulatory compliance exposure and informs hazmat storage and handling resource requirements."
$$;