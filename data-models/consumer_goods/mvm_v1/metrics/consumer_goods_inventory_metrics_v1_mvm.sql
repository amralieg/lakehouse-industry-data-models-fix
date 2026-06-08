-- Metric views for domain: inventory | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health and availability metrics derived from the stock position fact table. Covers on-hand quantity, value, safety stock coverage, blocked/quarantine exposure, and OOS risk — the primary KPI surface for inventory planners, supply chain VPs, and finance controllers."
  source: "`consumer_goods_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position (e.g. unrestricted, blocked, in-quality-inspection). Used to slice availability KPIs by usable vs. restricted inventory."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g. standard, consignment, VMI). Enables segmentation of inventory metrics by ownership and replenishment model."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity fields. Required to ensure quantity aggregations are compared on a like-for-like basis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which inventory value is expressed. Needed to avoid mixing multi-currency totals."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to the stock position (e.g. standard cost, moving average). Affects how total_value and unit_cost are interpreted."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates special stock categories such as project stock or sales order stock. Used to isolate non-standard inventory pools."
    - name: "stock_rotation_rule"
      expr: stock_rotation_rule
      comment: "FEFO/FIFO/LIFO rotation rule applied to this position. Relevant for shelf-life and expiry risk analysis."
    - name: "oos_risk_flag"
      expr: oos_risk_flag
      comment: "Boolean flag indicating the position is at risk of going out-of-stock. Primary filter for proactive replenishment dashboards."
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Boolean flag marking inventory as obsolete. Used to quantify write-off exposure."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Boolean flag indicating the stock is under quarantine. Used to measure quality-hold inventory exposure."
    - name: "recall_hold_flag"
      expr: recall_hold_flag
      comment: "Boolean flag indicating the stock is held due to a recall event. Critical for regulatory and financial exposure reporting."
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Boolean flag identifying slow-moving inventory. Used to drive markdown, liquidation, or write-down decisions."
    - name: "vmi_replenishment_flag"
      expr: vmi_replenishment_flag
      comment: "Indicates the position is managed under a vendor-managed inventory agreement. Used to segment supplier-owned vs. company-owned stock."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration date bucketed to month. Enables near-term expiry risk analysis and write-off forecasting."
    - name: "goods_receipt_date"
      expr: DATE_TRUNC('month', goods_receipt_date)
      comment: "Month of goods receipt. Used to age inventory and identify slow-moving or stale stock cohorts."
    - name: "last_goods_movement_date"
      expr: DATE_TRUNC('month', last_goods_movement_date)
      comment: "Month of last goods movement. Supports inventory aging and dormancy analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions. The primary volume KPI for inventory planners and supply chain executives."
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_quantity AS DOUBLE))
      comment: "Total quantity available for sale or consumption without restriction. Directly drives available-to-sell and order fulfillment capacity."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked from use (quality holds, recalls, etc.). Measures the volume of inventory unavailable for fulfillment."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection or quarantine. Indicates quality-hold exposure impacting available supply."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against open sales orders or production orders. Measures committed but not yet shipped inventory."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations. Represents pipeline inventory not yet available for fulfillment."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total ATP quantity — the quantity that can be promised to new customer orders. A critical order management and customer service KPI."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all positions. Measures the buffer inventory investment protecting against demand and supply variability."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of inventory on hand. A primary balance sheet and working capital KPI for finance and supply chain leadership."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock positions. Used to benchmark cost efficiency and detect cost anomalies by SKU or location."
    - name: "oos_risk_position_count"
      expr: COUNT(CASE WHEN oos_risk_flag = TRUE THEN stock_position_id END)
      comment: "Number of stock positions flagged as at-risk of going out-of-stock. A leading indicator for service level failures and lost sales."
    - name: "obsolete_inventory_value"
      expr: SUM(CASE WHEN obsolete_flag = TRUE THEN total_value ELSE 0 END)
      comment: "Total financial value of inventory flagged as obsolete. Quantifies write-off exposure and drives disposal or markdown decisions."
    - name: "recall_hold_inventory_value"
      expr: SUM(CASE WHEN recall_hold_flag = TRUE THEN total_value ELSE 0 END)
      comment: "Total value of inventory held due to recall events. Measures financial exposure from active product recalls — a key regulatory and risk KPI."
    - name: "slow_moving_inventory_value"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN total_value ELSE 0 END)
      comment: "Total value of slow-moving inventory. Drives markdown, liquidation, and working capital optimization decisions."
    - name: "unrestricted_pct_of_on_hand"
      expr: ROUND(100.0 * SUM(CAST(unrestricted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is unrestricted and available for use. A key inventory quality and availability ratio for supply chain executives."
    - name: "safety_stock_coverage_ratio"
      expr: ROUND(SUM(CAST(quantity_on_hand AS DOUBLE)) / NULLIF(SUM(CAST(safety_stock_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of on-hand quantity to safety stock quantity. Values below 1.0 indicate positions where on-hand stock has fallen below the safety buffer — a critical replenishment trigger KPI."
    - name: "reorder_breach_position_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point_quantity THEN stock_position_id END)
      comment: "Number of stock positions where on-hand quantity has fallen below the reorder point. Directly triggers replenishment actions and measures supply risk exposure."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active stock positions. Measures the breadth of the inventory portfolio and supports assortment management decisions."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and throughput metrics derived from the stock movement transaction log. Covers volume moved, value transferred, movement frequency, and reversal rates — essential for supply chain velocity, cost-of-goods, and operational efficiency analysis."
  source: "`consumer_goods_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP-style movement type code (e.g. 101=GR, 601=GI). The primary dimension for classifying inventory flows by business transaction type."
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of the movement (e.g. goods receipt, goods issue, transfer, adjustment). Used for executive-level flow analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement. Enables segmentation of flows by unrestricted, blocked, or quality-inspection stock."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement value. Required for consistent financial aggregation across multi-currency operations."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility code where the movement occurred. Enables geographic and facility-level throughput analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to the movement. Affects how total_value is interpreted for COGS and inventory accounting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag indicating the movement is a reversal of a prior transaction. Used to measure correction rates and data quality."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Boolean flag indicating quality inspection was required for this movement. Used to measure quality gate throughput and delays."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicates special stock categories involved in the movement. Used to isolate non-standard inventory flows."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date bucketed to month. The primary time dimension for trending inventory flow volumes and values over time."
    - name: "document_date_month"
      expr: DATE_TRUNC('month', document_date)
      comment: "Document date bucketed to month. Used to compare document date vs. posting date for period-close accuracy analysis."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of the reference document driving the movement (e.g. purchase order, sales order, production order). Enables source-of-movement analysis."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all stock movement transactions. The primary throughput volume KPI for warehouse and supply chain operations."
    - name: "total_movement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of all stock movements. Represents the monetary flow of inventory — a key input to COGS and inventory accounting."
    - name: "avg_unit_cost_per_movement"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movement transactions. Used to monitor cost trends and detect pricing anomalies in goods receipts or transfers."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Measures operational throughput and warehouse activity volume."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN stock_movement_id END)
      comment: "Number of movement transactions that are reversals. A high reversal rate signals data quality issues, process errors, or fraud risk."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN stock_movement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock movements that are reversals. A key process quality KPI — elevated rates indicate systemic booking errors or control weaknesses."
    - name: "quality_inspection_movement_count"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN stock_movement_id END)
      comment: "Number of movements requiring quality inspection. Measures the volume of inventory flowing through quality gates — relevant for throughput and lead time analysis."
    - name: "distinct_sku_moved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with stock movements in the period. Measures the breadth of active inventory flow and supports assortment velocity analysis."
    - name: "total_goods_receipt_value"
      expr: SUM(CASE WHEN movement_category = 'GOODS_RECEIPT' THEN total_value ELSE 0 END)
      comment: "Total value of goods receipt movements. Represents inventory inflows and is a key input to procurement spend and inventory build analysis."
    - name: "total_goods_issue_value"
      expr: SUM(CASE WHEN movement_category = 'GOODS_ISSUE' THEN total_value ELSE 0 END)
      comment: "Total value of goods issue movements. Represents inventory outflows to production or customers — a primary COGS driver."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and shrinkage metrics derived from stock adjustment transactions. Covers adjustment volumes, values, reversal rates, and reason-code distributions — critical for inventory accuracy governance, shrinkage control, and audit compliance."
  source: "`consumer_goods_ecm`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of stock adjustment (e.g. physical count, write-off, damage, theft). The primary dimension for classifying shrinkage and correction events."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for the adjustment. Used to identify root causes of inventory discrepancies and drive corrective action."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g. pending, approved, posted, reversed). Used to track adjustment workflow completion rates."
    - name: "movement_type"
      expr: movement_type
      comment: "Movement type associated with the adjustment. Enables linkage to the broader stock movement classification framework."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock being adjusted. Used to segment adjustments by unrestricted, blocked, or quality-inspection inventory."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment value. Required for consistent financial aggregation."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility where the adjustment was made. Enables facility-level shrinkage and accuracy benchmarking."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag indicating the adjustment is a reversal. Used to net out corrections and measure true adjustment activity."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Adjustment date bucketed to month. Primary time dimension for trending shrinkage and inventory accuracy over time."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date bucketed to month. Used for period-close inventory accuracy reporting."
  measures:
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Net total quantity adjusted across all stock adjustment transactions. Positive values indicate inventory additions; negative values indicate removals. A primary inventory accuracy KPI."
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value AS DOUBLE))
      comment: "Net total financial value of all stock adjustments. Represents the monetary impact of inventory discrepancies — a key shrinkage and write-off KPI for finance leadership."
    - name: "total_adjustment_transactions"
      expr: COUNT(1)
      comment: "Total number of stock adjustment transactions. High volumes relative to total movements indicate inventory accuracy problems."
    - name: "total_shrinkage_value"
      expr: SUM(CASE WHEN adjusted_quantity < 0 THEN ABS(adjusted_value) ELSE 0 END)
      comment: "Total value of negative adjustments (shrinkage, write-offs, damage). A critical loss-prevention and P&L KPI for retail and warehouse operations."
    - name: "total_shrinkage_quantity"
      expr: SUM(CASE WHEN adjusted_quantity < 0 THEN ABS(adjusted_quantity) ELSE 0 END)
      comment: "Total quantity lost through negative adjustments. Measures physical inventory shrinkage volume for operational benchmarking."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN stock_adjustment_id END)
      comment: "Number of adjustment transactions that are reversals. Elevated reversal counts signal process errors or control weaknesses in the adjustment workflow."
    - name: "avg_adjustment_value_per_transaction"
      expr: AVG(CAST(adjusted_value AS DOUBLE))
      comment: "Average financial value per stock adjustment transaction. Used to benchmark adjustment materiality and detect outlier events."
    - name: "distinct_sku_adjusted_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with stock adjustments in the period. A broad adjustment footprint may indicate systemic accuracy issues across the product range."
    - name: "quantity_variance_system_vs_physical"
      expr: SUM(system_quantity_after - system_quantity_before)
      comment: "Net change in system quantity resulting from adjustments (after minus before). Measures the cumulative system-level inventory correction applied in the period."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count program effectiveness metrics. Covers count accuracy rates, variance analysis, recount rates, and quarantine exposure — the primary KPI surface for warehouse managers, quality teams, and internal audit."
  source: "`consumer_goods_ecm`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count record (e.g. pending, completed, approved, disputed). Used to track count program completion and approval rates."
    - name: "count_method"
      expr: count_method
      comment: "Method used for the count (e.g. blind count, RF scan, manual). Used to compare accuracy outcomes across counting methodologies."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU being counted (A=high value/velocity, B=medium, C=low). Used to prioritize count frequency and analyze accuracy by inventory tier."
    - name: "count_zone"
      expr: count_zone
      comment: "Warehouse zone where the count was performed. Enables zone-level accuracy benchmarking and targeted improvement programs."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code assigned to explain the count variance. The primary dimension for root-cause analysis of inventory discrepancies."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Boolean flag indicating this is a recount of a prior discrepant count. High recount rates indicate persistent accuracy problems."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Boolean flag indicating the counted inventory is under quarantine. Used to measure quality-hold exposure discovered during cycle counts."
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Boolean flag indicating the variance adjustment has been posted to the system. Used to track count-to-adjustment cycle completion."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Boolean flag indicating the counted inventory requires temperature control. Used to segment accuracy metrics for cold-chain vs. ambient inventory."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for count quantities. Required for consistent quantity aggregation."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Count date bucketed to month. Primary time dimension for trending cycle count program performance and accuracy over time."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Measures the volume of counting activity and program coverage."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted across all cycle count records. Used to measure the scope of physical verification activity."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Compared against counted quantity to derive the aggregate variance."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Net total quantity variance (counted minus system). Positive values indicate system under-count; negative values indicate shrinkage. A primary inventory accuracy KPI."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Net total financial value of count variances. Measures the monetary impact of inventory discrepancies — a key audit and shrinkage KPI."
    - name: "total_inventory_value_at_count"
      expr: SUM(CAST(inventory_value_at_count AS DOUBLE))
      comment: "Total inventory value at the time of counting. Used as the denominator for variance rate calculations and to size the financial exposure of inaccuracies."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle count records. The primary inventory accuracy rate KPI — benchmarked against industry targets (typically <0.5% for A-class items)."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN inventory_cycle_count_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that required a recount due to discrepancy. High recount rates indicate persistent accuracy problems or counting process failures."
    - name: "adjustment_posted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_posted_flag = TRUE THEN inventory_cycle_count_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts where the variance adjustment has been posted to the system. Measures count-to-correction cycle completion — a process efficiency KPI."
    - name: "counts_with_variance_count"
      expr: COUNT(CASE WHEN variance_quantity <> 0 THEN inventory_cycle_count_id END)
      comment: "Number of cycle counts that identified a quantity variance. Used to measure the prevalence of inventory discrepancies across the counting program."
    - name: "variance_value_as_pct_of_counted_value"
      expr: ROUND(100.0 * SUM(CAST(variance_value AS DOUBLE)) / NULLIF(SUM(CAST(inventory_value_at_count AS DOUBLE)), 0), 4)
      comment: "Total variance value as a percentage of total inventory value counted. The definitive inventory accuracy rate in financial terms — a board-level supply chain quality KPI."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-stock event analytics covering frequency, duration, lost sales impact, forecast accuracy, and on-shelf availability. The primary KPI surface for commercial, supply chain, and category management teams to measure and reduce service level failures."
  source: "`consumer_goods_ecm`.`inventory`.`oos_event`"
  dimensions:
    - name: "oos_type"
      expr: oos_type
      comment: "Type of OOS event (e.g. phantom OOS, true OOS, distribution gap). Used to classify root causes and prioritize corrective actions."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the OOS event (e.g. open, resolved, escalated). Used to track resolution rates and open exposure."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category of the OOS event (e.g. forecast error, replenishment delay, supplier failure). The primary dimension for systemic OOS root-cause analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel where the OOS occurred (e.g. e-commerce, grocery, drug). Used to prioritize OOS reduction efforts by channel revenue impact."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the OOS event. Used to identify categories with disproportionate OOS frequency or lost sales impact."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity classification of the OOS event (e.g. critical, high, medium, low). Used to prioritize resolution resources and escalation."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the OOS event (e.g. system alert, store audit, customer complaint). Used to evaluate detection capability and speed."
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Boolean flag indicating the OOS event resulted in a customer-facing impact. Used to measure consumer experience degradation from supply failures."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean flag indicating the OOS event breached a service level agreement. Used to measure contractual compliance and retailer penalty exposure."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Boolean flag indicating this is a recurring OOS event for the same SKU/location. Recurring OOS events indicate structural supply chain failures requiring systemic fixes."
    - name: "oos_start_month"
      expr: DATE_TRUNC('month', oos_start_timestamp)
      comment: "Month the OOS event started. Primary time dimension for trending OOS frequency and lost sales over time."
    - name: "resolution_month"
      expr: DATE_TRUNC('month', resolution_timestamp)
      comment: "Month the OOS event was resolved. Used to measure resolution cycle times and backlog aging."
  measures:
    - name: "total_oos_events"
      expr: COUNT(1)
      comment: "Total number of out-of-stock events. The primary OOS frequency KPI — tracked against targets by channel, category, and time period."
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Total estimated revenue lost due to OOS events. The primary financial impact KPI for OOS — directly linked to top-line revenue and market share risk."
    - name: "total_estimated_lost_units"
      expr: SUM(CAST(estimated_lost_units AS DOUBLE))
      comment: "Total estimated units lost due to OOS events. Measures the volume impact of supply failures on consumer demand fulfillment."
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of OOS events in hours. A key service level KPI — longer durations indicate slower detection or replenishment response."
    - name: "total_oos_duration_hours"
      expr: SUM(CAST(oos_duration_hours AS DOUBLE))
      comment: "Total cumulative hours of OOS exposure across all events. Measures the aggregate service level failure burden in the period."
    - name: "avg_osa_actual_pct"
      expr: AVG(CAST(osa_actual_percent AS DOUBLE))
      comment: "Average actual on-shelf availability percentage across OOS events. The primary retail execution KPI — benchmarked against OSA targets (typically 97-99%)."
    - name: "avg_osa_target_pct"
      expr: AVG(CAST(osa_target_percent AS DOUBLE))
      comment: "Average OSA target percentage. Used as the benchmark denominator for OSA gap analysis."
    - name: "osa_gap_pct"
      expr: ROUND(AVG(CAST(osa_target_percent AS DOUBLE)) - AVG(CAST(osa_actual_percent AS DOUBLE)), 2)
      comment: "Average gap between OSA target and actual OSA percentage. Measures the magnitude of on-shelf availability underperformance — a key commercial and supply chain KPI."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage at the time of OOS events. Low forecast accuracy is a leading root cause of OOS — this KPI links demand planning quality to service level outcomes."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN oos_event_id END)
      comment: "Number of OOS events that breached a service level agreement. Measures contractual compliance failures and retailer penalty exposure."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN oos_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that resulted in an SLA breach. A critical customer service and contract compliance KPI for key account management."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN oos_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that are recurrences for the same SKU/location. High recurrence rates indicate structural supply chain failures that require systemic intervention."
    - name: "customer_impacting_oos_count"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN oos_event_id END)
      comment: "Number of OOS events with confirmed customer-facing impact. Directly measures consumer experience degradation and brand equity risk from supply failures."
    - name: "avg_lost_sales_per_oos_event"
      expr: AVG(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Average estimated lost sales value per OOS event. Used to prioritize OOS reduction investments by financial impact per event."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics covering order fulfillment rates, lead times, freight costs, and safety stock trigger rates. Essential for supply chain planners, procurement teams, and inventory managers to optimize replenishment efficiency and cost."
  source: "`consumer_goods_ecm`.`inventory`.`inventory_replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. pending, approved, shipped, received, cancelled). Primary dimension for order pipeline and fulfillment analysis."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (e.g. min-max, VMI, MRP, manual). Used to compare performance and cost across replenishment strategies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order (e.g. urgent, standard, low). Used to analyze whether high-priority orders are fulfilled faster."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for order quantities. Required for consistent quantity aggregation."
    - name: "freight_cost_currency_code"
      expr: freight_cost_currency_code
      comment: "Currency of the freight cost. Required for consistent freight cost aggregation across multi-currency operations."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Boolean flag indicating the order was triggered by a safety stock breach. Used to measure how often replenishment is reactive vs. planned."
    - name: "oos_prevention_flag"
      expr: oos_prevention_flag
      comment: "Boolean flag indicating the order was created specifically to prevent an OOS event. Used to measure proactive replenishment effectiveness."
    - name: "rotation_rule"
      expr: rotation_rule
      comment: "Stock rotation rule applied to the replenishment order (e.g. FEFO, FIFO). Used to ensure shelf-life compliance in replenishment decisions."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Requested delivery date bucketed to month. Primary time dimension for replenishment demand planning and lead time analysis."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Actual delivery date bucketed to month. Used to compare planned vs. actual delivery timing and measure supplier on-time performance."
    - name: "order_creation_month"
      expr: DATE_TRUNC('month', order_creation_timestamp)
      comment: "Month the replenishment order was created. Used to trend order creation volumes and identify seasonal replenishment patterns."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Measures the volume of replenishment activity and supply chain workload."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested across all replenishment orders. Measures aggregate replenishment demand volume."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment. Compared against requested quantity to measure approval fill rates."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped against replenishment orders. Measures supplier fulfillment volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against replenishment orders. The definitive measure of replenishment fulfillment — used to calculate fill rates."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all replenishment orders. A key supply chain cost KPI — tracked against budget and benchmarked by replenishment type and priority."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per replenishment order. Used to benchmark logistics efficiency and identify high-cost replenishment patterns."
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested replenishment quantity that was actually received. The primary replenishment fulfillment KPI — directly impacts inventory availability and service levels."
    - name: "ship_to_request_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was shipped. Measures supplier commitment fulfillment before receipt confirmation."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN inventory_replenishment_order_id END)
      comment: "Number of replenishment orders triggered by a safety stock breach. High counts indicate reactive replenishment patterns and potential supply chain instability."
    - name: "safety_stock_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN inventory_replenishment_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders triggered by safety stock breaches. A high rate signals that planned replenishment is failing and reactive ordering is the norm — a key supply chain health KPI."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN inventory_replenishment_order_id END)
      comment: "Number of cancelled replenishment orders. Cancellations represent wasted planning effort and potential supply disruption risk."
    - name: "distinct_sku_replenished_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active replenishment orders. Measures the breadth of the replenishment program and active inventory management coverage."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall performance and financial impact metrics. Covers recall effectiveness, recovery rates, financial exposure, and regulatory compliance — a critical KPI surface for quality, regulatory affairs, and executive leadership teams."
  source: "`consumer_goods_ecm`.`inventory`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall event (e.g. initiated, in-progress, closed). Used to track active recall exposure and program completion."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g. voluntary, mandatory, market withdrawal). Used to classify regulatory vs. voluntary recall activity."
    - name: "recall_classification"
      expr: recall_classification
      comment: "Regulatory classification of the recall (e.g. Class I, II, III). Class I recalls represent the highest consumer safety risk and require the most urgent response."
    - name: "depth_of_recall"
      expr: depth_of_recall
      comment: "Depth of the recall (e.g. consumer, retail, wholesale). Determines the scope of the recall program and associated costs."
    - name: "recall_scope_channel"
      expr: recall_scope_channel
      comment: "Sales channel scope of the recall. Used to assess channel-specific recall exposure and response requirements."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the recall (e.g. FDA, EFSA, Health Canada). Used to track regulatory engagement and compliance by jurisdiction."
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the estimated financial impact. Required for consistent financial aggregation across multi-currency recall events."
    - name: "initiation_date_month"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month the recall was initiated. Primary time dimension for trending recall frequency and financial impact over time."
    - name: "closure_date_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month the recall was closed. Used to measure recall resolution cycle times."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of product recall events. A primary quality and regulatory risk KPI — tracked at board level as a measure of product safety performance."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all recall events. A critical P&L and risk management KPI — directly informs insurance, reserve, and remediation investment decisions."
    - name: "avg_financial_impact_per_recall"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per recall event. Used to benchmark recall cost severity and prioritize prevention investments."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total quantity distributed that is subject to recall. Measures the scope of consumer exposure and the scale of the recall program."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity targeted for recall. Used as the denominator for recall effectiveness rate calculations."
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity successfully recovered through the recall program. Measures the physical effectiveness of recall execution."
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recall events. The primary recall program performance KPI — regulators typically require >99% effectiveness for Class I recalls."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_recovered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_recalled AS DOUBLE)), 0), 2)
      comment: "Percentage of recalled quantity that has been successfully recovered. Measures the aggregate physical effectiveness of recall programs — a key regulatory compliance KPI."
    - name: "class_i_recall_count"
      expr: COUNT(CASE WHEN recall_classification = 'Class I' THEN recall_event_id END)
      comment: "Number of Class I (highest severity) recall events. Class I recalls represent the most serious consumer safety risks and are tracked at board and regulatory level."
    - name: "open_recall_count"
      expr: COUNT(CASE WHEN recall_status NOT IN ('CLOSED', 'COMPLETED') THEN recall_event_id END)
      comment: "Number of currently open (unresolved) recall events. Measures active regulatory and financial exposure from ongoing recall programs."
    - name: "open_recall_financial_exposure"
      expr: SUM(CASE WHEN recall_status NOT IN ('CLOSED', 'COMPLETED') THEN estimated_financial_impact ELSE 0 END)
      comment: "Total estimated financial exposure from currently open recall events. A critical risk management KPI for CFO and board-level reporting."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch quality, compliance, and shelf-life metrics. Covers batch status distribution, hold rates, regulatory compliance, quality grades, and expiry risk — essential for quality assurance, regulatory affairs, and supply chain teams in consumer goods manufacturing."
  source: "`consumer_goods_ecm`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the lot/batch (e.g. released, on-hold, quarantine, rejected). The primary dimension for batch disposition and quality analysis."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the batch (e.g. A, B, C, reject). Used to segment production output by quality tier and measure grade distribution."
    - name: "gmp_status"
      expr: gmp_status
      comment: "GMP (Good Manufacturing Practice) compliance status of the batch. A critical regulatory dimension for pharmaceutical and personal care product batches."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status of the batch. Used to measure the volume and value of inventory under quality hold."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the batch was manufactured. Used for trade compliance, regulatory reporting, and supply chain risk analysis."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean flag indicating the batch is on hold. Used to measure the proportion of production output that is unavailable due to quality or compliance issues."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating the batch meets all regulatory compliance requirements. Used to measure compliance rates across the production portfolio."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for batch quantities. Required for consistent quantity aggregation."
    - name: "manufacturing_date_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Manufacturing date bucketed to month. Primary time dimension for trending batch production volumes and quality outcomes over time."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Expiry date bucketed to month. Used for near-term expiry risk analysis and write-off forecasting."
    - name: "storage_condition_requirement"
      expr: storage_condition_requirement
      comment: "Required storage conditions for the batch (e.g. refrigerated, ambient, frozen). Used to segment inventory by cold-chain requirements and associated cost."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of lot/batch records. Measures production output volume and batch program scale."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches. The primary production output volume KPI — used to measure manufacturing throughput and capacity utilization."
    - name: "batches_on_hold_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN lot_batch_id END)
      comment: "Number of batches currently on hold. Measures the volume of production output unavailable due to quality or compliance issues."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN lot_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches currently on hold. A key quality and supply risk KPI — high hold rates reduce available supply and increase working capital tied up in uninspected inventory."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN lot_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting all regulatory compliance requirements. A critical quality and regulatory affairs KPI — non-compliance risks market withdrawal and regulatory action."
    - name: "quantity_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN quantity_produced ELSE 0 END)
      comment: "Total quantity produced that is currently on hold. Measures the volume of supply unavailable due to quality or compliance holds — a key supply risk KPI."
    - name: "distinct_sku_batch_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active lot/batch records. Measures the breadth of the batch-managed product portfolio."
    - name: "avg_quantity_per_batch"
      expr: AVG(CAST(quantity_produced AS DOUBLE))
      comment: "Average quantity produced per batch. Used to benchmark batch size efficiency and identify deviations from standard batch sizes."
    - name: "near_expiry_batch_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN lot_batch_id END)
      comment: "Number of batches expiring within the next 90 days. A leading indicator of write-off risk and urgency for expedited distribution or disposal decisions."
    - name: "expired_batch_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN lot_batch_id END)
      comment: "Number of batches that have already passed their expiry date. Measures the extent of expired inventory exposure — a quality, regulatory, and financial risk KPI."
$$;