-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory position metrics tracking stock levels, valuation, par compliance, and expiration risk across all restaurant units and storage locations. Used by operations and supply chain leadership to manage working capital and prevent stockouts or overstock situations."
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location within the restaurant (e.g., walk-in cooler, dry storage) for granular inventory positioning."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., available, reserved, expired) for filtering active vs. problematic stock."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the stock item (A=high value/velocity, B=medium, C=low) for prioritized inventory management."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (e.g., frozen, refrigerated, ambient) for compliance and spoilage risk segmentation."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, LIFO, weighted average) for financial reporting context."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates whether the stock item is perishable, enabling targeted expiration risk monitoring."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency at which this item is cycle-counted, used to assess count coverage and compliance."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the inventory lot for near-expiry risk analysis."
    - name: "last_received_date"
      expr: last_received_date
      comment: "Date inventory was last received, used to assess freshness and supplier delivery cadence."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total on-hand inventory value (quantity × unit cost) across all locations. Core working capital KPI used by finance and operations leadership to manage inventory investment."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units physically on hand across all locations. Baseline stock level metric for supply chain and operations planning."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total units available for use (on-hand minus reserved). Reflects true usable inventory for production and service planning."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total units reserved/committed but not yet consumed. Indicates demand commitments against current stock."
    - name: "avg_days_until_expiration"
      expr: AVG(CAST(days_until_expiration AS DOUBLE))
      comment: "Average days remaining before inventory expires. Critical freshness and spoilage risk KPI for perishable item management."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Sum of variance between actual on-hand quantity and par level targets. Negative values indicate stockout risk; positive values indicate overstock. Drives replenishment decisions."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory on hand. Used to monitor cost trends and validate supplier pricing against expectations."
    - name: "count_sku_below_reorder_point"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN on_hand_balance_id END)
      comment: "Number of SKUs where current on-hand quantity has fallen below the reorder point. Directly triggers replenishment action and prevents stockouts."
    - name: "count_sku_below_safety_stock"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(safety_stock AS DOUBLE) THEN on_hand_balance_id END)
      comment: "Number of SKUs where on-hand quantity has fallen below safety stock threshold. Indicates critical supply risk requiring immediate intervention."
    - name: "pct_inventory_below_par"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(par_level AS DOUBLE) THEN on_hand_balance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKU-location combinations where on-hand quantity is below par level. Measures overall inventory health and replenishment effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste tracking and cost impact metrics for restaurant inventory. Enables leadership to quantify food waste costs, identify waste drivers by category and location, and measure progress against waste reduction initiatives — directly impacting food cost percentage and sustainability goals."
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g., spoilage, overproduction, trim, spillage) for root cause analysis and targeted reduction programs."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste event, enabling granular root cause analysis beyond category."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How waste was disposed of (e.g., composted, discarded, donated) for sustainability reporting."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (e.g., breakfast, lunch, dinner) during which waste occurred, enabling operational scheduling improvements."
    - name: "waste_date"
      expr: waste_date
      comment: "Date of waste event for trend analysis and period-over-period comparison."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Indicates whether the waste event was associated with a HACCP food safety violation — critical for regulatory compliance tracking."
    - name: "manager_approved"
      expr: manager_approved
      comment: "Indicates whether the waste record was approved by a manager, used to assess data quality and control compliance."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location where waste originated, enabling location-level waste hotspot identification."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total monetary value of wasted inventory. Primary financial KPI for food waste — directly impacts food cost percentage and profitability."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total units of inventory wasted. Volume-based waste metric used alongside cost to assess waste intensity and unit economics."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Identifies whether waste is driven by high-frequency small events or low-frequency high-cost incidents."
    - name: "count_waste_events"
      expr: COUNT(1)
      comment: "Total number of waste log entries. Measures waste event frequency as a leading indicator of operational discipline and process adherence."
    - name: "count_haccp_violation_waste_events"
      expr: COUNT(CASE WHEN haccp_violation = TRUE THEN waste_log_id END)
      comment: "Number of waste events associated with HACCP food safety violations. Critical compliance KPI — elevated counts signal regulatory risk and potential health inspection failures."
    - name: "pct_waste_events_with_haccp_violation"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_violation = TRUE THEN waste_log_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste events linked to HACCP violations. Measures food safety risk concentration within waste activity — a key compliance and brand risk metric."
    - name: "avg_on_hand_quantity_before_waste"
      expr: AVG(CAST(on_hand_quantity_before_waste AS DOUBLE))
      comment: "Average on-hand quantity at the time of waste. Contextualizes waste relative to stock levels — high waste with low on-hand signals systemic over-ordering or poor rotation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking the volume, value, and nature of stock corrections across restaurant units. Enables finance and operations leadership to monitor shrinkage, identify control weaknesses, and quantify the P&L impact of inventory discrepancies."
  source: "`vibe_restaurants_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment (e.g., shrinkage, write-off, correction, transfer) for categorized impact analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the adjustment (e.g., theft, spoilage, data entry error) enabling root cause trending."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category associated with the adjustment for cross-referencing with waste log metrics."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (e.g., pending, approved, rejected) for internal control monitoring."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Indicates whether the adjustment represents inventory shrinkage (theft, spoilage, unexplained loss) — a key loss prevention KPI."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Indicates whether the adjustment impacts cost of goods sold, enabling finance to isolate P&L-impacting corrections."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Indicates whether the adjustment was subsequently reversed, used to assess data quality and correction frequency."
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date of the inventory adjustment for trend and period-over-period analysis."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location where the adjustment occurred for location-level control analysis."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total monetary value of all inventory adjustments. Core financial control KPI — large absolute values indicate material inventory discrepancies impacting COGS and profitability."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total units adjusted across all adjustment events. Volume-based measure of inventory correction activity."
    - name: "total_shrinkage_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(value AS DOUBLE) ELSE 0 END)
      comment: "Total value of adjustments classified as shrinkage (theft, spoilage, unexplained loss). Direct loss prevention KPI used by operations and finance to quantify inventory leakage."
    - name: "total_cogs_impacting_adjustment_value"
      expr: SUM(CASE WHEN impacts_cogs = TRUE THEN CAST(value AS DOUBLE) ELSE 0 END)
      comment: "Total value of adjustments that directly impact cost of goods sold. Used by finance to reconcile inventory adjustments to P&L and ensure accurate food cost reporting."
    - name: "count_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment events. High frequency indicates systemic inventory control issues or operational process gaps."
    - name: "count_unapproved_adjustments"
      expr: COUNT(CASE WHEN approval_status != 'approved' AND requires_approval = TRUE THEN adjustment_id END)
      comment: "Number of adjustments that required approval but have not been approved. Internal control KPI — unapproved adjustments represent financial risk and audit exposure."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items being adjusted. Contextualizes adjustment value relative to item cost — high-cost item adjustments warrant greater scrutiny."
    - name: "pct_adjustments_shrinkage"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_shrinkage = TRUE THEN adjustment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all adjustments classified as shrinkage. Measures the proportion of inventory corrections attributable to loss — a key loss prevention and operational integrity metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy and variance metrics. Enables finance and operations leadership to assess inventory record integrity, quantify system-to-physical discrepancies, and monitor count program execution quality across restaurant units."
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, cycle, spot) for segmenting accuracy metrics by count methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used to conduct the count (e.g., manual, scanner-assisted) for process quality analysis."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (e.g., in-progress, submitted, approved, posted) for pipeline monitoring."
    - name: "count_period"
      expr: count_period
      comment: "Accounting or operational period the count belongs to for period-end reconciliation tracking."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Indicates whether this is a period-end count used for financial close — critical for finance to track close readiness."
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was conducted for trend and scheduling analysis."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location counted, enabling location-level variance analysis."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total monetary variance between physical count and system inventory value. Primary financial accuracy KPI — large variances indicate inventory record integrity issues impacting COGS and financial statements."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average percentage variance between physical and system inventory values. Normalized accuracy metric enabling fair comparison across units of different sizes."
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total value of inventory as physically counted. Used by finance for period-end balance sheet valuation and COGS reconciliation."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total value of inventory as recorded in the system prior to count. Compared against physical value to quantify record accuracy."
    - name: "total_sku_counted"
      expr: SUM(CAST(total_sku_counted AS DOUBLE))
      comment: "Total number of SKUs counted across all physical count events. Measures count program coverage and completeness."
    - name: "total_sku_with_variance"
      expr: SUM(CAST(total_sku_with_variance AS DOUBLE))
      comment: "Total number of SKUs where a variance was detected between physical and system quantities. Indicates breadth of inventory accuracy issues."
    - name: "pct_sku_with_variance"
      expr: ROUND(100.0 * SUM(CAST(total_sku_with_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_sku_counted AS DOUBLE)), 0), 2)
      comment: "Percentage of counted SKUs that had a variance. Key inventory accuracy rate — high percentages signal systemic record-keeping or process failures requiring corrective action."
    - name: "count_physical_counts_conducted"
      expr: COUNT(1)
      comment: "Total number of physical count events conducted. Measures adherence to the count schedule and program execution discipline."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_prep_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen prep usage efficiency and cost variance metrics. Enables culinary and operations leadership to monitor actual vs. theoretical ingredient consumption, identify recipe adherence gaps, and quantify prep cost overruns that directly impact food cost percentage."
  source: "`vibe_restaurants_v1`.`inventory`.`prep_usage`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep activity (e.g., batch cook, mise en place, portioning) for operational segmentation."
    - name: "prep_usage_status"
      expr: prep_usage_status
      comment: "Status of the prep usage record (e.g., completed, voided) for filtering valid production records."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the prep output, enabling quality-cost correlation analysis."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Indicates whether the prep activity was HACCP compliant — critical food safety compliance dimension."
    - name: "prep_date"
      expr: prep_date
      comment: "Date of the prep activity for trend and period-over-period analysis."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location from which ingredients were drawn for prep, enabling location-level consumption tracking."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for any waste generated during prep, enabling targeted waste reduction in kitchen operations."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of ingredients consumed in prep. Core food cost KPI — compared against theoretical cost to quantify recipe adherence and cost control effectiveness."
    - name: "total_theoretical_cost"
      expr: SUM(CAST(theoretical_cost AS DOUBLE))
      comment: "Total theoretical (expected) cost of ingredients based on standard recipes. Baseline for measuring prep efficiency and recipe compliance."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between actual and theoretical ingredient usage. Directly measures recipe adherence failure and over-portioning — a primary driver of food cost overruns."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and theoretical prep costs. Normalized efficiency metric enabling fair comparison across items and locations."
    - name: "total_actual_quantity_used"
      expr: SUM(CAST(actual_quantity_used AS DOUBLE))
      comment: "Total actual quantity of ingredients consumed in prep. Volume-based consumption metric for supply planning and yield analysis."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical quantity of ingredients expected to be consumed based on standard recipes. Baseline for yield and portioning compliance analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between actual and theoretical ingredient usage. Identifies over- or under-portioning patterns that drive food cost deviation."
    - name: "count_non_haccp_compliant_prep_events"
      expr: COUNT(CASE WHEN haccp_compliant = FALSE THEN prep_usage_id END)
      comment: "Number of prep events that were not HACCP compliant. Critical food safety KPI — non-compliant prep events represent regulatory risk and potential health hazards."
    - name: "pct_prep_events_haccp_compliant"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_compliant = TRUE THEN prep_usage_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prep events that were HACCP compliant. Overall food safety compliance rate for kitchen operations — a key regulatory and brand risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance and supply chain efficiency metrics. Enables supply chain and operations leadership to monitor order fulfillment speed, supplier reliability, cost accuracy, and replenishment program effectiveness across restaurant units."
  source: "`vibe_restaurants_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., submitted, approved, received, cancelled) for pipeline and fulfillment monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g., emergency, scheduled, auto-generated) for demand pattern analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source that triggered the order (e.g., manual, system-generated, par-triggered) for automation effectiveness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order for procurement control monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order (e.g., urgent, standard) for service level analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the order for logistics cost and speed analysis."
    - name: "order_date"
      expr: order_date
      comment: "Date the replenishment order was placed for trend and lead time analysis."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicates whether a variance was detected between ordered and received quantities — key supplier reliability indicator."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all replenishment orders placed. Core procurement spend KPI used by finance and supply chain to manage purchasing budgets and supplier spend."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due to suppliers for replenishment orders. Accounts payable and cash flow planning metric for finance leadership."
    - name: "total_shipping_fee"
      expr: SUM(CAST(shipping_fee AS DOUBLE))
      comment: "Total shipping fees incurred on replenishment orders. Logistics cost KPI — high shipping fees relative to order value indicate inefficient order sizing or emergency ordering patterns."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on replenishment orders for accurate total landed cost and tax liability reporting."
    - name: "count_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Measures ordering frequency and replenishment program activity."
    - name: "count_orders_with_variance"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN replenishment_order_id END)
      comment: "Number of replenishment orders where a variance was detected between ordered and received quantities. Supplier reliability and receiving accuracy KPI."
    - name: "pct_orders_with_variance"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN replenishment_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders with a quantity or value variance. Measures supplier fulfillment accuracy — high rates indicate supplier reliability issues or receiving process gaps."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per replenishment order. Used to assess order sizing efficiency — very low averages may indicate excessive emergency orders; very high averages may indicate over-ordering risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-unit stock transfer performance and value metrics. Enables supply chain and operations leadership to monitor internal inventory redistribution activity, transfer fulfillment quality, and the value of stock moved between restaurant units and locations."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "origin_restaurant_unit_id"
      expr: origin_restaurant_unit_id
      comment: "Restaurant unit that originated the stock transfer — identifies units that are net suppliers of inventory to the network."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g., requested, in-transit, received, cancelled) for pipeline monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., emergency, scheduled, inter-unit) for categorized volume and value analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (e.g., surplus redistribution, emergency replenishment) for root cause and demand pattern analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer for service level and urgency analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the transfer required temperature-controlled logistics — relevant for food safety compliance and logistics cost analysis."
    - name: "transfer_request_date"
      expr: transfer_request_date
      comment: "Date the transfer was requested for lead time and fulfillment speed analysis."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicates whether a variance was detected between transferred and received quantities — key transfer accuracy indicator."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the transfer, enabling quality-controlled transfer analysis."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total value of inventory transferred between units. Measures the scale of internal inventory redistribution — a key supply chain efficiency and working capital management KPI."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total units transferred across all stock transfer events. Volume-based measure of internal supply chain activity."
    - name: "total_item_count_transferred"
      expr: SUM(CAST(total_item_count AS DOUBLE))
      comment: "Total number of distinct line items transferred. Measures transfer complexity and breadth of redistribution activity."
    - name: "count_stock_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer events. High frequency may indicate systemic inventory imbalances across the restaurant network."
    - name: "count_transfers_with_variance"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN stock_transfer_id END)
      comment: "Number of transfers where a variance was detected between shipped and received quantities. Measures transfer accuracy and receiving process quality."
    - name: "pct_transfers_with_variance"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN stock_transfer_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock transfers with a quantity or value variance. Transfer accuracy rate — high rates indicate logistics, handling, or receiving process failures."
    - name: "avg_transfer_value"
      expr: AVG(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Average value per stock transfer event. Contextualizes transfer scale — very low averages may indicate inefficient micro-transfers; high averages indicate large-scale redistribution events."
$$;