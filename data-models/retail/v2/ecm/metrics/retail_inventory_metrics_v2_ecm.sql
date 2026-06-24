-- Metric views for domain: inventory | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and valuation ledger metrics. Tracks every stock transaction (receipts, sales, adjustments, transfers) with financial impact. Used by finance, supply chain, and loss prevention to reconcile inventory value, identify shrinkage, and audit stock movements."
  source: "`vibe_retail_v1`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory movement (e.g., sale, receipt, adjustment, transfer) for movement-type analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the ledger entry for reconciliation tracking."
    - name: "location_id"
      expr: location_id
      comment: "Store or DC location for location-level ledger analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level movement analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandising category for category-level financial reconciliation."
    - name: "channel"
      expr: channel
      comment: "Sales or fulfillment channel (e.g., store, online, wholesale) for channel-level inventory analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period financial inventory reporting."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, WAC) for financial reporting segmentation."
    - name: "shrinkage_flag"
      expr: shrinkage_flag
      comment: "Indicates whether the transaction represents a shrinkage event."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the transaction is a reversal of a prior entry."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates direct-store-delivery transactions for DSD program analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Transaction date for daily movement trending."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Transaction month for monthly financial reconciliation."
    - name: "posting_date"
      expr: posting_date
      comment: "Accounting posting date for financial period alignment."
  measures:
    - name: "total_movement_units"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Net total inventory units moved across all transaction types. Core throughput KPI for supply chain and store operations."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost value of inventory movements. Used for COGS calculation and inventory financial reconciliation."
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total retail value of inventory movements. Used for shrinkage rate calculation and retail inventory method accounting."
    - name: "total_shrinkage_cost"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN extended_cost ELSE 0 END)
      comment: "Total cost value of shrinkage transactions. Primary loss-prevention financial KPI; drives LP investment and process improvement decisions."
    - name: "shrinkage_transaction_count"
      expr: COUNT(CASE WHEN shrinkage_flag = TRUE THEN 1 END)
      comment: "Number of shrinkage transactions recorded. Frequency metric for loss-prevention pattern analysis."
    - name: "total_reversal_cost"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN extended_cost ELSE 0 END)
      comment: "Total cost value of reversal transactions. High reversal values indicate data quality or process issues in inventory recording."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across ledger entries. Used to monitor cost drift and validate valuation consistency."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across ledger entries. Used to compute gross margin on inventory movements."
    - name: "distinct_skus_moved"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with inventory movements. Breadth-of-activity metric for assortment and supply chain coverage."
    - name: "distinct_locations_active"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct locations with inventory activity. Indicates operational footprint of inventory movements."
    - name: "dsd_movement_units"
      expr: SUM(CASE WHEN dsd_flag = TRUE THEN movement_quantity ELSE 0 END)
      comment: "Total units moved via direct-store-delivery. Tracks DSD program volume for vendor performance and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking quantity corrections, shrinkage events, and their financial impact. Used by loss prevention, finance, and store operations to identify adjustment patterns, quantify shrinkage costs, and drive corrective action."
  source: "`vibe_retail_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, approved, posted, reversed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for audit and control analysis."
    - name: "reason_category"
      expr: reason_category
      comment: "High-level reason category (e.g., shrinkage, damage, receiving error) for root-cause analysis."
    - name: "reason_sub_category"
      expr: reason_sub_category
      comment: "Detailed reason sub-category for granular loss-prevention analysis."
    - name: "location_id"
      expr: location_id
      comment: "Location where the adjustment occurred for geographic loss analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU adjusted for item-level shrinkage and error analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandising category for category-level adjustment analysis."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents a shrinkage event."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Distinguishes system-generated adjustments from manual entries for process quality analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "How the discrepancy was detected (e.g., cycle count, POS, RFID) for detection effectiveness analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period adjustment trending."
    - name: "location_type"
      expr: location_type
      comment: "Type of location (store, DC, backroom) for location-type benchmarking."
    - name: "adjustment_date"
      expr: DATE_TRUNC('day', adjustment_timestamp)
      comment: "Date of adjustment for daily trend analysis."
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', adjustment_timestamp)
      comment: "Month of adjustment for monthly loss reporting."
  measures:
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Net total units adjusted. Positive values indicate additions; negative values indicate removals. Core adjustment volume KPI."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all adjustments. Primary KPI for quantifying inventory write-offs and corrections in financial reporting."
    - name: "total_shrinkage_cost_impact"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN cost_impact ELSE 0 END)
      comment: "Total cost impact of shrinkage-classified adjustments. Core loss-prevention financial KPI used in LP dashboards and executive reviews."
    - name: "shrinkage_adjustment_count"
      expr: COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END)
      comment: "Number of shrinkage-classified adjustments. Frequency metric for LP pattern detection and store benchmarking."
    - name: "total_adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. Baseline volume metric for adjustment rate benchmarking."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of adjustments awaiting approval. Operational metric for workflow bottleneck identification."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of adjusted items. Used to contextualize adjustment financial impact relative to item value."
    - name: "distinct_skus_adjusted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with adjustments. Breadth metric indicating how widely adjustment activity is spread across the assortment."
    - name: "distinct_locations_with_adjustments"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct locations with adjustment activity. Used to identify high-adjustment locations for targeted LP intervention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics. Measures inventory count accuracy, variance rates, and shrinkage detection effectiveness. Used by store operations, supply chain, and finance to assess inventory record accuracy and drive process improvements."
  source: "`vibe_retail_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (e.g., scheduled, in-progress, completed, approved)."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, partial, spot-check, ABC) for count methodology analysis."
    - name: "count_frequency"
      expr: count_frequency
      comment: "Frequency classification (e.g., daily, weekly, monthly) for scheduling analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of counted items for prioritization analysis."
    - name: "location_id"
      expr: location_id
      comment: "Location where the count was performed for location-level accuracy benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU counted for item-level accuracy analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandising category for category-level count accuracy analysis."
    - name: "shrinkage_category"
      expr: shrinkage_category
      comment: "Shrinkage category identified during count for loss-prevention classification."
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating whether a recount was required due to variance exceeding tolerance."
    - name: "adjustment_generated"
      expr: adjustment_generated
      comment: "Flag indicating whether the count resulted in an inventory adjustment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period count accuracy trending."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled count date for compliance and scheduling analysis."
    - name: "count_month"
      expr: DATE_TRUNC('month', count_start_timestamp)
      comment: "Month the count was performed for monthly accuracy trending."
  measures:
    - name: "total_counts_performed"
      expr: COUNT(1)
      comment: "Total number of cycle counts performed. Baseline compliance metric for count program execution."
    - name: "total_variance_units"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Net total variance units (counted minus system quantity). Positive values indicate overages; negative values indicate shortages."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total financial cost of inventory variances. Primary financial accuracy KPI used in finance and LP reviews."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts. Key inventory accuracy KPI; industry benchmark is typically below 1-2%."
    - name: "avg_variance_tolerance_pct"
      expr: AVG(CAST(variance_tolerance_pct AS DOUBLE))
      comment: "Average variance tolerance threshold set for counts. Used to contextualize whether variances are within acceptable bounds."
    - name: "counts_exceeding_tolerance"
      expr: COUNT(CASE WHEN ABS(variance_percentage) > variance_tolerance_pct THEN 1 END)
      comment: "Number of counts where variance exceeded the tolerance threshold. Drives recount scheduling and LP investigation."
    - name: "recount_rate"
      expr: COUNT(CASE WHEN recount_required = TRUE THEN 1 END)
      comment: "Number of counts requiring a recount. High recount rates indicate process or accuracy issues."
    - name: "adjustment_generation_rate"
      expr: COUNT(CASE WHEN adjustment_generated = TRUE THEN 1 END)
      comment: "Number of counts that generated an inventory adjustment. Indicates how frequently counts reveal actionable discrepancies."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total units physically counted. Volume metric for count program scope and coverage."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Paired with counted quantity to compute accuracy."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of counted items. Used to weight variance analysis by item value."
    - name: "distinct_skus_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs counted. Measures breadth of count program coverage across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and compliance metrics. Tracks receiving accuracy, discrepancy rates, and quality inspection outcomes. Used by supply chain, procurement, and vendor management to measure supplier delivery performance and receiving process quality."
  source: "`vibe_retail_v1`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., pending, complete, discrepancy, rejected)."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (e.g., manual, EDI, RFID) for process analysis."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (e.g., passed, failed, conditional) for supplier quality tracking."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receiving discrepancy (e.g., shortage, overage, damage) for root-cause analysis."
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Status of discrepancy resolution for operational follow-up tracking."
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Receiving node for location-level receiving performance analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for supplier-level delivery performance benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU received for item-level receiving analysis."
    - name: "receiving_node_type"
      expr: receiving_node_type
      comment: "Type of receiving node (store, DC) for node-type benchmarking."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Flag indicating whether the discrepancy is eligible for vendor chargeback."
    - name: "rfid_verified"
      expr: rfid_verified
      comment: "Flag indicating RFID-verified receipts for RFID program performance tracking."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date of receipt for daily receiving volume trending."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt for monthly supplier performance reporting."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed. Baseline receiving volume KPI."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received. Core inbound supply chain volume metric."
    - name: "total_accepted_qty"
      expr: SUM(CAST(accepted_qty AS DOUBLE))
      comment: "Total units accepted after inspection. Measures net usable inbound supply."
    - name: "total_rejected_qty"
      expr: SUM(CAST(rejected_qty AS DOUBLE))
      comment: "Total units rejected at receiving. High rejection rates indicate supplier quality issues requiring vendor action."
    - name: "total_shortage_qty"
      expr: SUM(CAST(shortage_qty AS DOUBLE))
      comment: "Total units short-shipped versus ordered. Drives chargeback claims and supplier performance management."
    - name: "total_overage_qty"
      expr: SUM(CAST(overage_qty AS DOUBLE))
      comment: "Total units received in excess of ordered quantity. Indicates supplier shipping errors and creates inventory reconciliation work."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_receipt_cost AS DOUBLE))
      comment: "Total cost value of goods received. Core financial inbound metric for AP reconciliation and inventory capitalization."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Used to monitor cost variance against purchase order prices."
    - name: "receipts_with_discrepancy"
      expr: COUNT(CASE WHEN discrepancy_type IS NOT NULL THEN 1 END)
      comment: "Number of receipts with any discrepancy. Measures receiving accuracy and supplier compliance rate."
    - name: "chargeback_eligible_receipts"
      expr: COUNT(CASE WHEN chargeback_eligible = TRUE THEN 1 END)
      comment: "Number of receipts eligible for vendor chargeback. Drives accounts payable recovery actions."
    - name: "rfid_verified_receipts"
      expr: COUNT(CASE WHEN rfid_verified = TRUE THEN 1 END)
      comment: "Number of receipts verified via RFID. Measures RFID program adoption and receiving accuracy improvement."
    - name: "distinct_vendors_received"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with receipts in the period. Measures active supplier base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking order fulfillment rates, lead times, and cost efficiency. Used by supply chain, merchandising, and finance to optimize replenishment processes, vendor performance, and inventory investment."
  source: "`vibe_retail_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., pending, approved, shipped, received, cancelled)."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g., automatic, manual, emergency, VMI) for process analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the order (e.g., reorder point, forecast, manual) for replenishment method analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel for the replenishment (e.g., DC, direct-to-store, cross-dock)."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority (e.g., standard, urgent, emergency) for prioritization analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for supplier-level replenishment performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level replenishment analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag for emergency replenishment orders. High emergency rates indicate poor demand planning."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Flag for vendor-managed inventory orders for VMI program performance analysis."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Flag indicating whether the order meets minimum order quantity requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the order was placed for monthly replenishment trend analysis."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Baseline volume metric for replenishment program activity."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered for replenishment. Measures inbound supply pipeline volume."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total units approved for replenishment. Compared against ordered quantity to measure approval rate."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units actually received from replenishment orders. Measures fulfillment completion."
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of replenishment orders. Core financial KPI for inventory investment and COGS planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across replenishment orders. Used to monitor cost trends and negotiate vendor pricing."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency replenishment orders. High counts indicate demand planning failures and drive premium freight costs."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled replenishment orders. Indicates supply chain disruptions or demand forecast errors."
    - name: "moq_non_compliant_count"
      expr: COUNT(CASE WHEN moq_compliant = FALSE THEN 1 END)
      comment: "Number of orders not meeting minimum order quantity. Drives vendor compliance management and cost optimization."
    - name: "distinct_vendors_ordered"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with replenishment orders. Measures active supplier base utilization."
    - name: "distinct_skus_replenished"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs replenished. Measures breadth of replenishment activity across the assortment."
    - name: "vmi_order_count"
      expr: COUNT(CASE WHEN is_vmi = TRUE THEN 1 END)
      comment: "Number of vendor-managed inventory replenishment orders. Measures VMI program scale and adoption."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_expiry_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Perishable and dated inventory expiry risk metrics. Tracks near-expiry quantities, disposal rates, and financial exposure from expiring stock. Used by store operations, supply chain, and finance to minimize waste, comply with food safety regulations, and optimize markdown timing."
  source: "`vibe_retail_v1`.`inventory`.`expiry_tracking`"
  dimensions:
    - name: "expiry_risk_status"
      expr: expiry_risk_status
      comment: "Risk classification of expiry status (e.g., critical, near-expiry, safe) for prioritization."
    - name: "action_status"
      expr: action_status
      comment: "Status of the action taken on expiring inventory (e.g., pending, marked-down, disposed)."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of disposal (e.g., markdown, donate, destroy) for waste management analysis."
    - name: "recommended_action"
      expr: recommended_action
      comment: "System-recommended action for expiring inventory for compliance and process analysis."
    - name: "location_id"
      expr: location_id
      comment: "Location for geographic waste and expiry analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level expiry pattern analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category for category-level perishable management analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone (e.g., ambient, chilled, frozen) for cold chain compliance analysis."
    - name: "is_recall_active"
      expr: is_recall_active
      comment: "Flag indicating active recall on the tracked item for compliance prioritization."
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Flag for vendor-managed expiry tracking for VMI accountability analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of location for location-type benchmarking of expiry rates."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of expiry for forward-looking expiry pipeline analysis."
  measures:
    - name: "total_quantity_at_risk"
      expr: SUM(CAST(quantity_at_risk AS DOUBLE))
      comment: "Total units at risk of expiry. Primary perishable management KPI driving markdown and disposal decisions."
    - name: "total_quantity_disposed"
      expr: SUM(CAST(quantity_disposed AS DOUBLE))
      comment: "Total units disposed due to expiry. Measures waste volume and drives waste reduction initiatives."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand quantity of tracked expiry items. Baseline for expiry risk rate calculation."
    - name: "total_expiry_cost_at_risk"
      expr: SUM(CAST(quantity_at_risk AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost value of inventory at expiry risk. Quantifies financial exposure from perishable stock for executive review."
    - name: "total_disposal_cost"
      expr: SUM(CAST(quantity_disposed AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost of disposed expired inventory. Measures waste cost for P&L impact and waste reduction ROI analysis."
    - name: "avg_remaining_shelf_life_pct"
      expr: AVG(CAST(remaining_shelf_life_pct AS DOUBLE))
      comment: "Average remaining shelf life percentage across tracked items. Low values indicate systemic ordering or rotation issues."
    - name: "recall_active_quantity"
      expr: SUM(CASE WHEN is_recall_active = TRUE THEN quantity_on_hand ELSE 0 END)
      comment: "Total on-hand quantity with active recalls. Critical compliance KPI requiring immediate action."
    - name: "distinct_skus_at_expiry_risk"
      expr: COUNT(DISTINCT CASE WHEN quantity_at_risk > 0 THEN sku_id END)
      comment: "Number of distinct SKUs with expiry risk. Breadth metric for perishable assortment management."
    - name: "distinct_locations_with_expiry_risk"
      expr: COUNT(DISTINCT CASE WHEN quantity_at_risk > 0 THEN location_id END)
      comment: "Number of distinct locations with expiry risk. Identifies geographic concentration of waste risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-node stock transfer performance metrics. Tracks transfer volumes, costs, and fulfillment accuracy across the store and DC network. Used by supply chain and store operations to optimize inventory rebalancing, ship-from-store programs, and cross-dock efficiency."
  source: "`vibe_retail_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g., initiated, in-transit, received, cancelled)."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., store-to-store, DC-to-store, store-to-DC) for network flow analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (e.g., rebalance, replenishment, return-to-DC) for root-cause analysis."
    - name: "source_node_type"
      expr: source_node_type
      comment: "Type of originating node for transfer flow analysis."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node for transfer flow analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU transferred for item-level transfer analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Transfer priority for urgency and resource allocation analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Flag for cross-dock transfers for cross-dock program performance analysis."
    - name: "is_ship_from_store"
      expr: is_ship_from_store
      comment: "Flag for ship-from-store transfers for omnichannel fulfillment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "transfer_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the transfer was initiated for monthly transfer volume trending."
  measures:
    - name: "total_transfer_cost"
      expr: SUM(CAST(transfer_cost AS DOUBLE))
      comment: "Total cost of stock transfers. Core financial KPI for supply chain cost management and network optimization."
    - name: "avg_inventory_cost_per_unit"
      expr: AVG(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Average inventory cost per unit transferred. Used to assess the value of inventory being moved across the network."
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfers. Baseline volume metric for network rebalancing activity."
    - name: "ship_from_store_transfer_count"
      expr: COUNT(CASE WHEN is_ship_from_store = TRUE THEN 1 END)
      comment: "Number of ship-from-store transfers. Measures omnichannel fulfillment program utilization."
    - name: "cross_dock_transfer_count"
      expr: COUNT(CASE WHEN is_cross_dock = TRUE THEN 1 END)
      comment: "Number of cross-dock transfers. Measures cross-dock program efficiency and volume."
    - name: "cancelled_transfer_count"
      expr: COUNT(CASE WHEN transfer_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled transfers. High cancellation rates indicate planning or execution issues."
    - name: "distinct_skus_transferred"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs transferred. Measures breadth of inventory rebalancing activity."
    - name: "ship_from_store_transfer_cost"
      expr: SUM(CASE WHEN is_ship_from_store = TRUE THEN transfer_cost ELSE 0 END)
      comment: "Total cost of ship-from-store transfers. Used to assess omnichannel fulfillment cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation metrics tracking committed stock for orders, BOPIS, and fulfillment. Used by omnichannel operations and supply chain to monitor reservation fill rates, expiry rates, and inventory commitment accuracy."
  source: "`vibe_retail_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation (e.g., active, released, expired, fulfilled)."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the reservation for fulfillment pipeline analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel (e.g., BOPIS, ship-from-store, DC) for channel-level reservation analysis."
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of inventory encumbrance (e.g., order, hold, promo) for reservation purpose analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for inventory holds for root-cause analysis of reservation patterns."
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Node where inventory is reserved for location-level reservation analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU reserved for item-level reservation analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Reservation priority for fulfillment sequencing analysis."
    - name: "is_recalled"
      expr: is_recalled
      comment: "Flag for reservations on recalled items requiring compliance action."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "reservation_month"
      expr: DATE_TRUNC('month', reservation_timestamp)
      comment: "Month the reservation was created for monthly reservation volume trending."
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total units currently reserved. Measures committed inventory volume across all channels and purposes."
    - name: "total_reservation_value"
      expr: SUM(CAST(reserved_quantity AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost value of reserved inventory. Quantifies capital committed to pending fulfillment."
    - name: "active_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'active' THEN 1 END)
      comment: "Number of currently active reservations. Operational metric for fulfillment pipeline management."
    - name: "expired_reservation_count"
      expr: COUNT(CASE WHEN reservation_status = 'expired' THEN 1 END)
      comment: "Number of expired reservations. High expiry rates indicate fulfillment delays or customer cancellations."
    - name: "recalled_item_reservation_count"
      expr: COUNT(CASE WHEN is_recalled = TRUE THEN 1 END)
      comment: "Number of reservations on recalled items. Critical compliance metric requiring immediate release and customer notification."
    - name: "avg_inventory_cost_per_unit"
      expr: AVG(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of reserved inventory. Used to assess the value profile of committed stock."
    - name: "distinct_skus_reserved"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active reservations. Measures breadth of inventory commitment across the assortment."
    - name: "distinct_nodes_with_reservations"
      expr: COUNT(DISTINCT inventory_node_id)
      comment: "Number of distinct nodes with reservations. Measures geographic spread of fulfillment commitments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor-managed inventory agreement performance metrics. Tracks VMI program coverage, fill rate targets, and agreement compliance. Used by merchandising, supply chain, and vendor management to evaluate VMI program effectiveness and vendor accountability."
  source: "`vibe_retail_v1`.`inventory`.`vmi_agreement`"
  dimensions:
    - name: "vmi_agreement_status"
      expr: vmi_agreement_status
      comment: "Current status of the VMI agreement (e.g., active, expired, terminated, pending)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of VMI agreement for program classification analysis."
    - name: "inventory_ownership"
      expr: inventory_ownership
      comment: "Who owns the inventory under the agreement (retailer vs vendor) for financial reporting."
    - name: "inventory_visibility_method"
      expr: inventory_visibility_method
      comment: "Method by which vendor accesses inventory data (e.g., EDI, portal, API) for integration analysis."
    - name: "replenishment_frequency"
      expr: replenishment_frequency
      comment: "How frequently the vendor replenishes under the agreement for supply cadence analysis."
    - name: "location_id"
      expr: location_id
      comment: "Location covered by the VMI agreement for geographic VMI coverage analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category covered by the VMI agreement for category-level VMI analysis."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Flag for auto-renewing agreements for contract management analysis."
    - name: "chargeback_enabled"
      expr: chargeback_enabled
      comment: "Flag indicating chargeback provisions are active for financial accountability analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Agreement start date for contract lifecycle analysis."
  measures:
    - name: "active_vmi_agreement_count"
      expr: COUNT(CASE WHEN vmi_agreement_status = 'active' THEN 1 END)
      comment: "Number of active VMI agreements. Measures VMI program scale and vendor partnership breadth."
    - name: "total_vmi_agreements"
      expr: COUNT(1)
      comment: "Total VMI agreements including all statuses. Baseline for agreement lifecycle analysis."
    - name: "avg_target_fill_rate_pct"
      expr: AVG(CAST(target_fill_rate_pct AS DOUBLE))
      comment: "Average target fill rate across VMI agreements. Benchmark for vendor performance expectations."
    - name: "avg_target_otd_rate_pct"
      expr: AVG(CAST(target_otd_rate_pct AS DOUBLE))
      comment: "Average target on-time delivery rate across VMI agreements. Benchmark for vendor delivery performance expectations."
    - name: "avg_target_weeks_of_supply"
      expr: AVG(CAST(target_weeks_of_supply AS DOUBLE))
      comment: "Average target weeks of supply across VMI agreements. Used to assess inventory coverage commitments."
    - name: "avg_chargeback_rate_pct"
      expr: AVG(CAST(chargeback_rate_pct AS DOUBLE))
      comment: "Average chargeback rate across VMI agreements. Measures financial penalty exposure for vendor non-compliance."
    - name: "chargeback_enabled_agreement_count"
      expr: COUNT(CASE WHEN chargeback_enabled = TRUE THEN 1 END)
      comment: "Number of VMI agreements with chargeback provisions. Measures financial accountability coverage across the VMI program."
    - name: "distinct_locations_in_vmi"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct locations covered by VMI agreements. Measures geographic VMI program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_promo_stock_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional inventory allocation performance metrics. Tracks promotional stock reservation, sell-through, and revenue generation. Used by merchandising, marketing, and supply chain to evaluate promotional inventory effectiveness and optimize future allocations."
  source: "`vibe_retail_v1`.`inventory`.`promo_stock_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the promotional allocation (e.g., active, expired, fulfilled, cancelled)."
    - name: "promo_offer_id"
      expr: promo_offer_id
      comment: "Promotional offer for offer-level allocation performance analysis."
    - name: "display_location_code"
      expr: display_location_code
      comment: "Display location for in-store promotional placement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "offer_start_date"
      expr: offer_start_date
      comment: "Promotional offer start date for promotional period analysis."
    - name: "offer_end_date"
      expr: offer_end_date
      comment: "Promotional offer end date for promotional period analysis."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_created_date)
      comment: "Month the allocation was created for monthly promotional planning analysis."
  measures:
    - name: "total_promotional_inventory_reserved"
      expr: SUM(CAST(promotional_inventory_reserve_qty AS DOUBLE))
      comment: "Total units reserved for promotional events. Measures promotional inventory commitment volume."
    - name: "total_actual_units_sold"
      expr: SUM(CAST(actual_units_sold AS DOUBLE))
      comment: "Total units actually sold under promotional allocations. Measures promotional sell-through performance."
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_revenue AS DOUBLE))
      comment: "Total revenue generated from promotional inventory allocations. Core promotional ROI KPI."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional selling price across allocations. Used to assess promotional depth and margin impact."
    - name: "total_promotional_inventory_value"
      expr: SUM(CAST(promotional_inventory_reserve_qty AS DOUBLE) * CAST(promotional_price AS DOUBLE))
      comment: "Total retail value of promotional inventory reserved. Measures promotional program scale."
    - name: "active_promo_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'active' THEN 1 END)
      comment: "Number of currently active promotional allocations. Operational metric for promotional inventory management."
    - name: "distinct_promo_offers_with_allocation"
      expr: COUNT(DISTINCT promo_offer_id)
      comment: "Number of distinct promotional offers with inventory allocations. Measures promotional program breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot-level inventory quality and traceability metrics. Tracks lot availability, quality status, recall exposure, and shelf life. Used by supply chain, compliance, and quality management to ensure product traceability, food safety compliance, and recall readiness."
  source: "`vibe_retail_v1`.`inventory`.`lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (e.g., available, quarantine, recalled, expired, consumed)."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the lot for quality management analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of quality inspection (e.g., passed, failed, conditional) for supplier quality analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level lot analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for supplier-level lot quality analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category for category-level lot management analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for cold chain compliance analysis."
    - name: "is_recalled"
      expr: is_recalled
      comment: "Flag for recalled lots requiring immediate action."
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Flag for vendor-managed lots for VMI accountability."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for sourcing and compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary measures."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date lot was received for aging and FEFO analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of lot expiry for forward-looking expiry pipeline analysis."
  measures:
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all lots. Baseline lot inventory volume metric."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available (non-quarantine, non-recalled) lot quantity. Measures usable lot inventory."
    - name: "total_lot_value"
      expr: SUM(CAST(quantity AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total cost value of lot inventory. Financial KPI for lot-level inventory valuation."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN is_recalled = TRUE THEN 1 END)
      comment: "Number of recalled lots. Critical compliance KPI requiring immediate quarantine and customer notification."
    - name: "recalled_lot_quantity"
      expr: SUM(CASE WHEN is_recalled = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity in recalled lots. Measures recall exposure volume for compliance and financial impact assessment."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across lots. Used to monitor cost consistency and detect pricing anomalies."
    - name: "distinct_vendors_with_lots"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active lots. Measures supplier diversity in lot inventory."
    - name: "failed_inspection_lot_count"
      expr: COUNT(CASE WHEN inspection_result = 'failed' THEN 1 END)
      comment: "Number of lots that failed quality inspection. Drives supplier quality management and chargeback decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_assortment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment deployment compliance and execution metrics. Tracks how effectively planned assortments are deployed to inventory nodes. Used by merchandising and store operations to measure planogram compliance and assortment execution quality."
  source: "`vibe_retail_v1`.`inventory`.`assortment_deployment`"
  dimensions:
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the deployment (e.g., planned, in-progress, complete, non-compliant)."
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where the assortment is being deployed for location-level compliance analysis."
    - name: "assortment_plan_id"
      expr: assortment_plan_id
      comment: "Assortment plan for plan-level deployment performance analysis."
    - name: "deployment_start_date"
      expr: deployment_start_date
      comment: "Deployment start date for timeline analysis."
    - name: "deployment_month"
      expr: DATE_TRUNC('month', deployment_start_date)
      comment: "Month of deployment for monthly execution trending."
  measures:
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average assortment compliance percentage across deployments. Core planogram execution KPI; low values indicate store non-compliance requiring intervention."
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of assortment deployments. Baseline execution volume metric."
    - name: "fully_compliant_deployments"
      expr: COUNT(CASE WHEN compliance_percentage >= 100 THEN 1 END)
      comment: "Number of deployments achieving full assortment compliance. Measures execution excellence."
    - name: "non_compliant_deployments"
      expr: COUNT(CASE WHEN compliance_percentage < 80 THEN 1 END)
      comment: "Number of deployments below 80% compliance threshold. Identifies locations requiring remediation."
    - name: "distinct_nodes_deployed"
      expr: COUNT(DISTINCT inventory_node_id)
      comment: "Number of distinct nodes with assortment deployments. Measures geographic deployment coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reorder_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reorder policy configuration and coverage metrics. Tracks policy parameters, automation rates, and coverage across SKUs and locations. Used by supply chain and merchandising to ensure replenishment policies are current, appropriately configured, and driving efficient inventory levels."
  source: "`vibe_retail_v1`.`inventory`.`reorder_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the reorder policy (e.g., active, inactive, expired, draft)."
    - name: "reorder_method"
      expr: reorder_method
      comment: "Replenishment method (e.g., min-max, reorder-point, days-of-supply) for method effectiveness analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU for policy differentiation analysis."
    - name: "location_id"
      expr: location_id
      comment: "Location for location-level policy coverage analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level policy analysis."
    - name: "is_auto_replenishment"
      expr: is_auto_replenishment
      comment: "Flag for automated replenishment policies for automation rate analysis."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag for seasonal policies for seasonal planning analysis."
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Flag for vendor-managed replenishment policies."
    - name: "location_type"
      expr: location_type
      comment: "Type of location for location-type policy benchmarking."
    - name: "effective_date"
      expr: effective_date
      comment: "Policy effective date for policy lifecycle analysis."
  measures:
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of active reorder policies. Measures replenishment policy coverage across the assortment."
    - name: "auto_replenishment_policy_count"
      expr: COUNT(CASE WHEN is_auto_replenishment = TRUE THEN 1 END)
      comment: "Number of policies with automated replenishment enabled. Measures automation adoption for supply chain efficiency."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across policies. Used to assess buffer inventory investment levels."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across policies. Used to calibrate replenishment trigger sensitivity."
    - name: "avg_target_days_of_supply"
      expr: AVG(CAST(target_days_of_supply AS DOUBLE))
      comment: "Average target days of supply across policies. Measures intended inventory coverage levels."
    - name: "avg_target_wos"
      expr: AVG(CAST(target_wos AS DOUBLE))
      comment: "Average target weeks of supply across policies. Used to assess inventory investment strategy."
    - name: "avg_max_stock_quantity"
      expr: AVG(CAST(max_stock_quantity AS DOUBLE))
      comment: "Average maximum stock quantity across policies. Used to assess overstock risk exposure."
    - name: "avg_min_stock_quantity"
      expr: AVG(CAST(min_stock_quantity AS DOUBLE))
      comment: "Average minimum stock quantity across policies. Used to assess stockout risk exposure."
    - name: "distinct_skus_with_policy"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with reorder policies. Measures replenishment policy coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asn business metrics"
  source: "`vibe_retail_v1`.`inventory`.`asn`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Asn Number"
      expr: asn_number
    - name: "Asn Status"
      expr: asn_status
    - name: "Asn Type"
      expr: asn_type
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Node Type"
      expr: destination_node_type
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Type"
      expr: discrepancy_type
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Expected Arrival Date"
      expr: expected_arrival_date
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Po Number"
      expr: po_number
    - name: "Pro Number"
      expr: pro_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asn"
      expr: COUNT(DISTINCT asn_id)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_inventory_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Node business metrics"
  source: "`vibe_retail_v1`.`inventory`.`inventory_node`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Close Date"
      expr: close_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count Frequency"
      expr: cycle_count_frequency
    - name: "District Code"
      expr: district_code
    - name: "Dock Door Count"
      expr: dock_door_count
    - name: "Format Code"
      expr: format_code
    - name: "Gln"
      expr: gln
    - name: "Is Bopis Enabled"
      expr: is_bopis_enabled
    - name: "Is Drop Ship Origin"
      expr: is_drop_ship_origin
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Is Ropis Enabled"
      expr: is_ropis_enabled
    - name: "Is Ship From Store Enabled"
      expr: is_ship_from_store_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Node"
      expr: COUNT(DISTINCT inventory_node_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Selling Area Sqft"
      expr: SUM(selling_area_sqft)
    - name: "Average Selling Area Sqft"
      expr: AVG(selling_area_sqft)
    - name: "Total Total Storage Capacity Sqft"
      expr: SUM(total_storage_capacity_sqft)
    - name: "Average Total Storage Capacity Sqft"
      expr: AVG(total_storage_capacity_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_location_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location Assignment business metrics"
  source: "`vibe_retail_v1`.`inventory`.`location_assignment`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Primary Location Flag"
      expr: primary_location_flag
    - name: "Role At Location"
      expr: role_at_location
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
    - name: "Assignment Start Date Month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location Assignment"
      expr: COUNT(DISTINCT location_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_node_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Node Assortment business metrics"
  source: "`vibe_retail_v1`.`inventory`.`node_assortment`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Assortment Status"
      expr: assortment_status
    - name: "Category Manager Override Name"
      expr: category_manager_override_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Local Assortment Override"
      expr: local_assortment_override
    - name: "Max Presentation Qty"
      expr: max_presentation_qty
    - name: "Min Presentation Qty"
      expr: min_presentation_qty
    - name: "Planogram Count"
      expr: planogram_count
    - name: "Replenishment Priority"
      expr: replenishment_priority
    - name: "Shelf Capacity Units"
      expr: shelf_capacity_units
    - name: "Target Sku Count"
      expr: target_sku_count
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Node Assortment"
      expr: COUNT(DISTINCT node_assortment_id)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_rfid_tag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfid Tag business metrics"
  source: "`vibe_retail_v1`.`inventory`.`rfid_tag`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Decommission Timestamp"
      expr: decommission_timestamp
    - name: "Encoding Date"
      expr: encoding_date
    - name: "Encoding Standard"
      expr: encoding_standard
    - name: "Epc Code"
      expr: epc_code
    - name: "Epc Memory Bank Size"
      expr: epc_memory_bank_size
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequency Band"
      expr: frequency_band
    - name: "Gtin"
      expr: gtin
    - name: "Is Locked"
      expr: is_locked
    - name: "Is Password Protected"
      expr: is_password_protected
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Kill Password Set"
      expr: kill_password_set
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfid Tag"
      expr: COUNT(DISTINCT rfid_tag_id)
    - name: "Total Signal Strength Dbm"
      expr: SUM(signal_strength_dbm)
    - name: "Average Signal Strength Dbm"
      expr: AVG(signal_strength_dbm)
$$;