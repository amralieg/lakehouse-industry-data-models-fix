-- Metric views for domain: inventory | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_food_cost_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food cost performance, COGS variance, and waste efficiency across restaurant units and financial periods. Core P&L steering metric for operations and finance leadership."
  source: "`restaurants_ecm`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of financial period (weekly, monthly, period) used to segment food cost reporting cadence."
    - name: "period_status"
      expr: period_status
      comment: "Status of the food cost period (open, closed, approved) to filter for finalized vs. in-progress periods."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which food cost values are denominated, enabling multi-currency analysis."
    - name: "count_method"
      expr: count_method
      comment: "Physical count method used (manual, scanner, etc.) to assess data quality impact on food cost accuracy."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month bucket of the period start date for time-series trending of food cost metrics."
    - name: "period_number"
      expr: period_number
      comment: "Business period number (e.g., Period 1–13) for alignment with fiscal calendar reporting."
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit identifier for unit-level food cost benchmarking and ranking."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier to compare food cost performance across franchise operators."
  measures:
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost incurred in the period. Primary cost driver for restaurant P&L and a key input to margin analysis."
    - name: "total_theoretical_food_cost"
      expr: SUM(CAST(theoretical_food_cost AS DOUBLE))
      comment: "Total theoretical (expected) food cost based on sales mix and standard recipes. Baseline for variance analysis."
    - name: "total_food_cost_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Aggregate dollar variance between actual and theoretical food cost. Negative variance signals over-consumption, theft, or waste."
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS as a percentage of sales across periods. Key margin KPI tracked by operations and finance leadership."
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percentage. Compared against actual to identify systemic recipe or portioning issues."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average food cost variance as a percentage of theoretical cost. Drives investigation thresholds and corrective action triggers."
    - name: "total_waste_value"
      expr: SUM(CAST(waste_value AS DOUBLE))
      comment: "Total dollar value of food waste recorded in the period. Directly impacts food cost and sustainability targets."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of food cost. Benchmarks waste reduction program effectiveness across units."
    - name: "total_purchases_value"
      expr: SUM(CAST(purchases_value AS DOUBLE))
      comment: "Total value of inventory purchases in the period. Key input to food cost calculation and procurement spend analysis."
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue in the period. Denominator for food cost percentage and top-line performance indicator."
    - name: "total_beverage_sales_revenue"
      expr: SUM(CAST(beverage_sales_revenue AS DOUBLE))
      comment: "Total beverage sales revenue. Tracked separately to assess beverage margin contribution vs. food."
    - name: "total_sales_revenue"
      expr: SUM(CAST(total_sales_revenue AS DOUBLE))
      comment: "Total combined sales revenue (food + beverage). Primary denominator for all cost percentage KPIs."
    - name: "total_transfers_in_value"
      expr: SUM(CAST(transfers_in_value AS DOUBLE))
      comment: "Total value of inventory transferred into the unit during the period. Impacts food cost calculation accuracy."
    - name: "total_transfers_out_value"
      expr: SUM(CAST(transfers_out_value AS DOUBLE))
      comment: "Total value of inventory transferred out of the unit. Reduces effective food cost and must be tracked for accurate P&L."
    - name: "food_cost_period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods recorded. Used to validate completeness of period-end close process."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food waste events by category, reason, station, and daypart to drive waste reduction programs and HACCP compliance. Directly impacts food cost and sustainability KPIs."
  source: "`restaurants_ecm`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g., prep waste, expired, overproduction) for root-cause analysis and targeted reduction programs."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste event. Drives corrective action prioritization and training interventions."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How waste was disposed (trash, compost, donation) for sustainability and regulatory reporting."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (breakfast, lunch, dinner, late night) when waste occurred. Identifies overproduction patterns by daypart."
    - name: "responsible_station"
      expr: responsible_station
      comment: "Kitchen station responsible for the waste event. Enables station-level accountability and coaching."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Flag indicating whether the waste event was associated with a HACCP violation. Critical for food safety compliance tracking."
    - name: "manager_approved"
      expr: manager_approved
      comment: "Whether the waste entry was manager-approved. Filters for verified vs. unverified waste records."
    - name: "waste_date_month"
      expr: DATE_TRUNC('month', waste_date)
      comment: "Month of waste event for time-series trending of waste volumes and costs."
    - name: "restaurant_unit_id"
      expr: primary_waste_restaurant_unit_id
      comment: "Restaurant unit where waste occurred. Enables unit-level waste benchmarking and ranking."
    - name: "stock_item_id"
      expr: stock_item_id
      comment: "Stock item wasted. Identifies highest-waste SKUs for procurement and portioning adjustments."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee associated with the waste event for franchise-level waste performance comparison."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total dollar value of food waste. Primary financial impact metric for waste reduction ROI calculations."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of food wasted (in unit of measure). Tracks volume trends independent of price fluctuations."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Identifies high-cost waste incidents that warrant immediate investigation."
    - name: "total_waste_events"
      expr: COUNT(1)
      comment: "Total number of waste log entries. Tracks waste event frequency as a leading indicator of operational discipline."
    - name: "haccp_violation_waste_events"
      expr: COUNT(CASE WHEN haccp_violation = TRUE THEN 1 END)
      comment: "Number of waste events linked to HACCP violations. Critical food safety KPI monitored by QA and operations leadership."
    - name: "distinct_waste_stock_items"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct SKUs with waste events. Broad SKU waste spread signals systemic overproduction vs. isolated issues."
    - name: "avg_temperature_at_waste"
      expr: AVG(CAST(temperature_at_waste AS DOUBLE))
      comment: "Average temperature recorded at time of waste. Elevated averages may indicate cold chain or equipment failures driving waste."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a real-time and historical view of inventory on-hand levels, par compliance, and valuation across stock locations and restaurant units. Drives replenishment decisions and working capital management."
  source: "`restaurants_ecm`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (available, reserved, expired, quarantine) for operational filtering."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the stock item (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (frozen, refrigerated, ambient) for cold chain compliance monitoring."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, WAC) applied to the balance record for financial reporting context."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Whether the stock item is perishable. Perishable items require tighter par management and expiration monitoring."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "How frequently this item is cycle-counted. Drives audit scheduling and count resource allocation."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of expiration for identifying near-term expiry risk and proactive markdown or transfer decisions."
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the inventory snapshot for point-in-time balance trending."
    - name: "restaurant_unit_id"
      expr: primary_on_restaurant_unit_id
      comment: "Restaurant unit holding the inventory. Enables unit-level stock position analysis."
    - name: "stock_item_id"
      expr: primary_on_sku_stock_item_id
      comment: "Stock item (SKU) identifier for item-level inventory position analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee associated with the inventory balance for franchise-level stock management oversight."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand. Primary stock position metric for replenishment and availability decisions."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for use (on hand minus reserved). Drives real-time production and ordering decisions."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders or transfers. Indicates committed inventory not yet consumed."
    - name: "total_extended_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total dollar value of on-hand inventory (quantity × unit cost). Key working capital and balance sheet metric."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across on-hand inventory records. Tracks cost inflation trends for procurement negotiations."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance between on-hand quantity and par level. Negative values signal stockout risk; positive signals overstock."
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of SKU-location combinations where on-hand quantity is below reorder point. Drives urgent replenishment actions."
    - name: "items_below_safety_stock"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of SKU-location combinations below safety stock threshold. Critical stockout risk indicator for operations."
    - name: "distinct_active_skus"
      expr: COUNT(DISTINCT primary_on_sku_stock_item_id)
      comment: "Number of distinct SKUs with on-hand inventory. Tracks active assortment breadth and inventory complexity."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inventory adjustments including shrinkage, waste, reversals, and corrections. Monitors adjustment value impact on COGS and identifies patterns requiring operational or compliance intervention."
  source: "`restaurants_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment (waste, theft, spoilage, correction, transfer) for root-cause categorization."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment. Enables trend analysis by cause category."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (pending, approved, rejected). Filters for authorized vs. unapproved adjustments."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category associated with the adjustment for alignment with waste reduction program tracking."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents shrinkage (theft, spoilage, unexplained loss). Key loss prevention KPI."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Whether the adjustment has been reversed. High reversal rates may indicate data quality or process issues."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Whether the adjustment impacts COGS. Filters for financially material adjustments in P&L analysis."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month of adjustment for time-series trending of adjustment volumes and values."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the adjustment for departmental cost accountability."
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where the adjustment occurred. Enables unit-level shrinkage and adjustment benchmarking."
    - name: "stock_item_id"
      expr: stock_item_id
      comment: "Stock item adjusted. Identifies high-adjustment SKUs for targeted controls."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total dollar value of all inventory adjustments. Measures financial impact of adjustments on inventory valuation and COGS."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all adjustment events. Tracks volume of inventory corrections independent of cost."
    - name: "total_shrinkage_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(adjustment_value AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of shrinkage adjustments (theft, spoilage, unexplained loss). Key loss prevention and P&L metric."
    - name: "total_adjustment_events"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment events. High frequency may indicate process or system issues requiring investigation."
    - name: "unapproved_adjustment_count"
      expr: COUNT(CASE WHEN requires_approval = TRUE AND approval_status != 'Approved' THEN 1 END)
      comment: "Number of adjustments requiring approval that have not yet been approved. Compliance and control risk indicator."
    - name: "cogs_impacting_adjustment_value"
      expr: SUM(CASE WHEN impacts_cogs = TRUE THEN CAST(adjustment_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of adjustments that directly impact COGS. Isolates financially material adjustments for P&L review."
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average dollar value per adjustment event. Tracks severity trend of individual adjustment incidents."
    - name: "distinct_adjusted_skus"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct SKUs with adjustment activity. Broad SKU spread signals systemic issues vs. isolated item problems."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors inbound delivery performance, quality inspection outcomes, and receiving accuracy. Drives supplier accountability, HACCP compliance, and inventory accuracy at point of receipt."
  source: "`restaurants_ecm`.`inventory`.`receiving_order`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving order (pending, received, rejected, partial) for operational pipeline visibility."
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Whether delivery was on-time, early, or late. Key supplier performance dimension for SLA management."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection at receiving (pass, fail, conditional). Drives supplier quality scorecards."
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of temperature check at receiving. HACCP-critical dimension for cold chain compliance."
    - name: "seal_integrity_check"
      expr: seal_integrity_check
      comment: "Result of seal integrity check at receiving. Indicates tamper or cold chain breach risk."
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier for this receiving order. Enables supplier-level performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receiving order value for multi-currency procurement analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of delivery for time-series trending of receiving volumes and supplier performance."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether a quantity or value variance was detected at receiving. Filters for exception-based review."
    - name: "restaurant_unit_id"
      expr: receiving_restaurant_unit_id
      comment: "Restaurant unit receiving the delivery. Enables unit-level receiving performance analysis."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total dollar value of inventory received. Primary procurement spend metric and input to food cost calculation."
    - name: "total_receiving_orders"
      expr: COUNT(1)
      comment: "Total number of receiving orders processed. Tracks inbound delivery volume and receiving team workload."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN delivery_timeliness = 'On Time' THEN 1 END)
      comment: "Number of deliveries received on time. Numerator for on-time delivery rate calculation in supplier scorecards."
    - name: "quality_fail_count"
      expr: COUNT(CASE WHEN quality_inspection_result = 'Fail' THEN 1 END)
      comment: "Number of receiving orders that failed quality inspection. Drives supplier corrective action and disqualification decisions."
    - name: "temperature_fail_count"
      expr: COUNT(CASE WHEN temperature_check_result = 'Fail' THEN 1 END)
      comment: "Number of deliveries with failed temperature checks. Critical HACCP compliance metric for food safety leadership."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of receiving orders with quantity or value variances. Drives invoice reconciliation and supplier dispute management."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving across all deliveries. Monitors cold chain integrity trends by supplier or unit."
    - name: "distinct_suppliers_received_from"
      expr: COUNT(DISTINCT supplier_name)
      comment: "Number of distinct suppliers with receiving activity. Tracks supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures physical inventory count accuracy, variance from system records, and count process compliance. Drives period-end close quality and inventory shrinkage visibility."
  source: "`restaurants_ecm`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (full, cycle, spot) to segment accuracy metrics by count scope."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, scanner, blind) to assess methodology impact on variance rates."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (in-progress, submitted, approved, posted) for process pipeline monitoring."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Whether this is a period-end count. Period-end counts are financially material and require higher accuracy standards."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Whether a recount was required due to variance thresholds. High recount rates indicate counting process quality issues."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code for count variance. Enables root-cause categorization of inventory discrepancies."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of physical count for time-series trending of count frequency and variance patterns."
    - name: "restaurant_unit_id"
      expr: primary_physical_restaurant_unit_id
      comment: "Restaurant unit where the count was performed. Enables unit-level count accuracy benchmarking."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee associated with the count for franchise-level inventory accuracy oversight."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total dollar variance between physical count and system inventory value. Primary inventory accuracy KPI for finance and operations."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance as a percentage of system inventory value. Benchmarks count accuracy against industry thresholds."
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value as counted. Used to reconcile against system value for balance sheet accuracy."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system (book) inventory value at time of count. Paired with physical value to compute shrinkage."
    - name: "total_counts_performed"
      expr: COUNT(1)
      comment: "Total number of physical counts performed. Validates count frequency compliance against policy requirements."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts requiring a recount. High recount rates signal counting process failures or systemic inventory issues."
    - name: "period_end_count_variance"
      expr: SUM(CASE WHEN is_period_end_count = TRUE THEN CAST(total_variance_amount AS DOUBLE) ELSE 0 END)
      comment: "Total variance amount from period-end counts only. Financially material variance that directly impacts period-close P&L."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks replenishment order activity, fulfillment performance, and procurement spend. Drives supply chain efficiency, stockout prevention, and vendor management decisions."
  source: "`restaurants_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (draft, submitted, approved, received, cancelled) for pipeline visibility."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (standard, emergency, promotional) to segment procurement patterns."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order. Pending approvals may delay replenishment and create stockout risk."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (standard, urgent, critical). High-priority order frequency signals inventory management gaps."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the replenishment. Impacts lead time and freight cost analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source of the replenishment order (auto-replenishment, manual, system-generated) for process efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order value for multi-currency procurement spend analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement for time-series trending of replenishment activity and spend."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether a variance was detected on the order (quantity, price, or delivery). Drives exception-based procurement review."
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit that placed the replenishment order. Enables unit-level procurement analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee associated with the order for franchise-level procurement compliance and spend oversight."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of replenishment orders placed. Primary procurement spend metric for budget management and supplier negotiations."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due to suppliers including tax and shipping. Drives accounts payable forecasting and cash flow management."
    - name: "total_shipping_fees"
      expr: SUM(CAST(shipping_fee AS DOUBLE))
      comment: "Total freight and shipping costs on replenishment orders. Tracks logistics cost as a percentage of procurement spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on replenishment orders. Required for tax liability reporting and cost analysis."
    - name: "total_orders_placed"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Tracks ordering frequency and workload for procurement team capacity planning."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled replenishment orders. High cancellation rates signal demand forecasting or supplier reliability issues."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN priority_level = 'Critical' OR order_type = 'Emergency' THEN 1 END)
      comment: "Number of emergency or critical priority orders. Elevated counts indicate reactive vs. proactive inventory management."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per replenishment order. Tracks order consolidation efficiency and minimum order compliance."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of replenishment orders with variances. Drives supplier dispute resolution and invoice reconciliation workload."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inter-unit inventory transfers including value, volume, quality inspection compliance, and temperature control. Supports network-level inventory balancing and waste reduction through proactive redistribution."
  source: "`restaurants_ecm`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (requested, approved, shipped, received, cancelled) for pipeline visibility."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (inter-unit, emergency, promotional support) to segment transfer activity by business purpose."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (overstock, shortage, expiry risk, event support). Drives network balancing strategy analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer. High-priority transfers indicate urgent stockout risk at destination units."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the transfer. Impacts lead time and logistics cost analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the transfer required temperature-controlled transport. Critical for cold chain compliance tracking."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Result of quality inspection on transferred goods. Ensures transferred inventory meets standards at destination."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether a quantity or condition variance was detected on the transfer. Drives exception-based review."
    - name: "transfer_request_date_month"
      expr: DATE_TRUNC('month', transfer_request_date)
      comment: "Month of transfer request for time-series trending of inter-unit transfer activity."
    - name: "origin_restaurant_unit_id"
      expr: origin_restaurant_unit_id
      comment: "Restaurant unit originating the transfer. Identifies units with chronic overstock that are net senders."
    - name: "destination_restaurant_unit_id"
      expr: destination_restaurant_unit_id
      comment: "Restaurant unit receiving the transfer. Identifies units with chronic shortages that are net receivers."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total dollar value of inventory transferred between units. Measures scale of network inventory redistribution activity."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of inventory transferred. Tracks volume of inter-unit balancing independent of cost fluctuations."
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer events. High frequency may indicate systemic demand forecasting or par-level calibration issues."
    - name: "variance_transfer_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of transfers with quantity or condition variances. Drives investigation of in-transit loss or handling issues."
    - name: "avg_transfer_value"
      expr: AVG(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Average value per stock transfer. Tracks transfer size trends and identifies high-value redistribution events."
    - name: "distinct_origin_units"
      expr: COUNT(DISTINCT origin_restaurant_unit_id)
      comment: "Number of distinct restaurant units sending transfers. Broad sender base indicates network-wide inventory imbalance."
    - name: "distinct_destination_units"
      expr: COUNT(DISTINCT destination_restaurant_unit_id)
      comment: "Number of distinct restaurant units receiving transfers. Identifies units with persistent supply gaps."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks vendor item performance including cost, quality ratings, delivery reliability, and contract compliance. Drives supplier rationalization, cost negotiation, and preferred vendor management."
  source: "`restaurants_ecm`.`inventory`.`vendor_item`"
  dimensions:
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Status of the vendor item (active, inactive, discontinued) for assortment management and supplier compliance."
    - name: "vendor_product_category"
      expr: vendor_product_category
      comment: "Product category as classified by the vendor. Enables category-level spend and quality analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether this vendor is the preferred source for the item. Tracks preferred vendor compliance and sourcing discipline."
    - name: "contract_price_flag"
      expr: contract_price_flag
      comment: "Whether the item is priced under a contract. Identifies off-contract purchases that may indicate compliance gaps."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the item is manufactured or sourced. Supports supply chain risk and regulatory compliance analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the vendor item cost for multi-currency procurement analysis."
    - name: "last_cost_update_month"
      expr: DATE_TRUNC('month', last_cost_update_date)
      comment: "Month of last cost update for tracking cost change frequency and inflation trends."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier for supplier-level performance aggregation and scorecarding."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items. Tracks cost trends and supports benchmark pricing in supplier negotiations."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across vendor items. Primary supplier quality KPI for vendor scorecards and rationalization decisions."
    - name: "avg_on_time_delivery_percent"
      expr: AVG(CAST(on_time_delivery_percent AS DOUBLE))
      comment: "Average on-time delivery percentage across vendor items. Key supplier reliability KPI for SLA management."
    - name: "total_active_vendor_items"
      expr: COUNT(CASE WHEN vendor_item_status = 'Active' THEN 1 END)
      comment: "Number of active vendor items. Tracks assortment breadth and supplier catalog complexity."
    - name: "preferred_vendor_item_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of items sourced from preferred vendors. Tracks preferred vendor compliance rate across the assortment."
    - name: "contract_priced_item_count"
      expr: COUNT(CASE WHEN contract_price_flag = TRUE THEN 1 END)
      comment: "Number of items with contract pricing. Measures contract coverage and off-contract spend exposure."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across vendor items. Impacts order consolidation strategy and working capital requirements."
    - name: "distinct_active_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct active suppliers. Tracks supplier base concentration and diversification for supply chain risk management."
$$;