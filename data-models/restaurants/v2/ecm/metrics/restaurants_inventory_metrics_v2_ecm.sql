-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_food_cost_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food cost period metrics tracking actual vs theoretical food cost, variance, and COGS performance by restaurant unit and period. Core financial KPI for food cost management and profitability steering."
  source: "`vibe_restaurants_v1`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of inventory period (weekly, monthly, period-end) for time-based grouping of food cost analysis."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the food cost period (open, closed, approved) to filter active vs finalized periods."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the food cost period for time-series trending of cost performance."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the food cost period for period-over-period comparison."
    - name: "count_method"
      expr: count_method
      comment: "Inventory count method used (physical, cycle, estimated) affecting reliability of cost calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which food cost values are denominated for multi-currency reporting."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for any cost period adjustment, enabling root-cause analysis of cost variances."
  measures:
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost incurred across all periods. Primary cost KPI for food P&L management."
    - name: "total_theoretical_food_cost"
      expr: SUM(CAST(theoretical_food_cost AS DOUBLE))
      comment: "Total theoretical (expected) food cost based on recipes and sales mix. Baseline for variance analysis."
    - name: "total_food_cost_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total dollar variance between actual and theoretical food cost. Negative variance indicates over-spend vs recipe standards."
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS as a percentage of sales. Key profitability ratio tracked by finance and operations leadership."
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe standards. Benchmark for actual COGS performance."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average food cost variance as a percentage. Drives investigation when exceeding threshold (typically >1-2%)."
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue across periods. Denominator for food cost percentage calculations."
    - name: "total_beverage_sales_revenue"
      expr: SUM(CAST(beverage_sales_revenue AS DOUBLE))
      comment: "Total beverage sales revenue. Used to separate food vs beverage cost ratios for category-level P&L."
    - name: "total_sales_revenue"
      expr: SUM(CAST(total_sales_revenue AS DOUBLE))
      comment: "Total combined sales revenue (food + beverage). Primary revenue denominator for overall COGS ratio."
    - name: "total_purchases_value"
      expr: SUM(CAST(purchases_value AS DOUBLE))
      comment: "Total value of inventory purchases in the period. Key input to food cost calculation and procurement spend tracking."
    - name: "total_waste_value"
      expr: SUM(CAST(waste_value AS DOUBLE))
      comment: "Total dollar value of food waste in the period. Directly impacts food cost and is a key operational efficiency KPI."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of food cost. Drives waste reduction programs and operational coaching."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total value of manual adjustments applied to food cost periods. High values indicate data quality or operational issues."
    - name: "closing_inventory_value_total"
      expr: SUM(CAST(closing_inventory_value AS DOUBLE))
      comment: "Total closing inventory value across periods. Used for balance sheet reporting and period-end reconciliation."
    - name: "opening_inventory_value_total"
      expr: SUM(CAST(opening_inventory_value AS DOUBLE))
      comment: "Total opening inventory value. Combined with purchases and closing inventory to derive food cost."
    - name: "period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods. Used to track reporting cadence and identify missing or unclosed periods."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking the volume, value, and nature of inventory corrections. Critical for shrinkage control, COGS accuracy, and audit compliance."
  source: "`vibe_restaurants_v1`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment (waste, theft, spoilage, count correction) for root-cause categorization."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment. Enables trend analysis by adjustment cause."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste associated with the adjustment (prep waste, spoilage, over-production) for waste reduction targeting."
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the adjustment was recorded for time-series trending of adjustment activity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (pending, approved, rejected) for governance and control monitoring."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents shrinkage (theft, unexplained loss). Key loss prevention KPI dimension."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Flag indicating whether the adjustment impacts COGS. Used to filter financially material adjustments."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the adjusted quantity, enabling volume-based analysis across different item types."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total dollar value of all inventory adjustments. Primary financial impact KPI for inventory control."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all inventory adjustment records. Volume measure for operational impact assessment."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. High frequency indicates operational or data quality issues requiring investigation."
    - name: "shrinkage_adjustment_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN adjustment_value ELSE 0 END)
      comment: "Total dollar value of shrinkage-flagged adjustments. Key loss prevention KPI for security and operations leadership."
    - name: "pending_approval_adjustment_value"
      expr: SUM(CASE WHEN approval_status = 'pending' THEN adjustment_value ELSE 0 END)
      comment: "Total value of adjustments awaiting approval. Highlights control gaps and approval backlog risk."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost at time of adjustment. Used to assess whether high-value items are disproportionately adjusted."
    - name: "cogs_impacting_adjustment_value"
      expr: SUM(CASE WHEN impacts_cogs = TRUE THEN adjustment_value ELSE 0 END)
      comment: "Total value of adjustments that directly impact COGS. Critical for P&L accuracy and financial close processes."
    - name: "reversed_adjustment_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of adjustments that were subsequently reversed. High reversal rate signals data quality or process issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_ingredient_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient usage metrics tracking actual vs theoretical consumption, waste, and cost efficiency at the ingredient level. Drives recipe compliance, food cost control, and procurement planning."
  source: "`vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage`"
  dimensions:
    - name: "usage_type"
      expr: usage_type
      comment: "Type of ingredient usage (actual, theoretical, waste) for separating planned vs actual consumption analysis."
    - name: "usage_date"
      expr: usage_date
      comment: "Date of ingredient usage for daily and weekly consumption trending."
    - name: "usage_period"
      expr: usage_period
      comment: "Named usage period (e.g., week 1, period 3) for period-over-period ingredient consumption comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ingredient quantities, enabling volume-normalized comparisons across items."
    - name: "is_theoretical"
      expr: is_theoretical
      comment: "Flag distinguishing theoretical (recipe-based) from actual usage records. Core dimension for variance analysis."
    - name: "usage_period_start"
      expr: usage_period_start
      comment: "Start date of the usage period for time-window based aggregation."
    - name: "usage_period_end"
      expr: usage_period_end
      comment: "End date of the usage period for period boundary filtering."
  measures:
    - name: "total_quantity_used"
      expr: SUM(CAST(quantity_used AS DOUBLE))
      comment: "Total ingredient quantity consumed. Primary volume KPI for ingredient consumption tracking and procurement forecasting."
    - name: "total_usage_cost"
      expr: SUM(CAST(usage_cost AS DOUBLE))
      comment: "Total cost of ingredient usage. Key food cost input for P&L and recipe cost analysis."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total ingredient quantity wasted. Drives waste reduction initiatives and recipe yield improvement programs."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of ingredient used. Tracks ingredient price trends and cost efficiency over time."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount for ingredient usage records. Used for period-level food cost reconciliation."
    - name: "avg_monthly_usage"
      expr: AVG(CAST(average_monthly_usage AS DOUBLE))
      comment: "Average monthly ingredient usage volume. Key input for safety stock and reorder point calculations."
    - name: "total_total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Sum of total cost across all ingredient usage records. Aggregate food cost for the selected period and filters."
    - name: "ingredient_count_distinct"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of distinct ingredients consumed. Tracks menu complexity and ingredient portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-hand inventory balance metrics tracking stock levels, valuation, par compliance, and expiration risk. Core operational KPI for inventory health and working capital management."
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, reserved, expired, quarantine) for stock health categorization."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (ambient, refrigerated, frozen) for cold chain compliance monitoring."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, weighted average) for financial reporting consistency."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating perishable items requiring tighter expiration and waste monitoring."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "How frequently this item is cycle-counted. Used to assess count coverage and compliance."
    - name: "snapshot_timestamp"
      expr: snapshot_timestamp
      comment: "Timestamp of the inventory snapshot for point-in-time balance reporting."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand inventory quantity across all locations. Primary stock level KPI for replenishment decisions."
    - name: "total_extended_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total extended inventory value (quantity × unit cost). Key working capital and balance sheet metric."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total available (unreserved) inventory quantity. Drives replenishment triggers and availability commitments."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total reserved inventory quantity. Indicates committed stock for pending orders or production runs."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory positions. Tracks cost trends and supports valuation accuracy reviews."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from par level across all stock positions. Negative values indicate under-stocked items risking stockouts."
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock items below reorder point. Critical replenishment alert KPI for operations and procurement."
    - name: "items_near_expiration"
      expr: COUNT(CASE WHEN days_until_expiration <= 3 THEN 1 END)
      comment: "Number of inventory positions with 3 or fewer days until expiration. Drives urgent markdown or usage decisions."
    - name: "avg_days_until_expiration"
      expr: AVG(CAST(days_until_expiration AS DOUBLE))
      comment: "Average days until expiration across perishable inventory. Lower values signal elevated waste risk."
    - name: "stock_position_count"
      expr: COUNT(1)
      comment: "Total number of active stock positions. Tracks inventory portfolio breadth and location coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count metrics tracking count accuracy, variance, and process compliance. Drives inventory accuracy programs and financial period-end close quality."
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (full, cycle, spot-check) for segmenting count scope and effort."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, scanner, blind count) affecting count accuracy benchmarking."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (scheduled, in-progress, submitted, approved) for process monitoring."
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was conducted for time-series accuracy trending."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Flag indicating whether this is a period-end count used for financial close. Critical for audit and compliance."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating a recount was required due to variance. High recount rates signal counting process issues."
    - name: "count_period"
      expr: count_period
      comment: "Named count period for grouping counts within fiscal periods."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total dollar variance between physical count and system inventory value. Primary accuracy KPI for inventory control."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance percentage across physical counts. Benchmark for inventory accuracy; target typically <0.5%."
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value as counted. Used for balance sheet reconciliation and period-end close."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system-recorded inventory value. Compared against physical count to derive variance."
    - name: "avg_sku_count_per_count"
      expr: AVG(CAST(total_sku_counted AS DOUBLE))
      comment: "Average number of SKUs counted per physical count event. Tracks count scope and completeness."
    - name: "avg_sku_with_variance"
      expr: AVG(CAST(total_sku_with_variance AS DOUBLE))
      comment: "Average number of SKUs with variance per count. High values indicate systemic accuracy issues."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts requiring a recount. Tracks counting process quality and rework rate."
    - name: "physical_count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events. Tracks counting cadence compliance against policy requirements."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food waste metrics tracking waste quantity, cost, and root causes by category, reason, and location. Drives waste reduction programs, food cost improvement, and sustainability reporting."
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (prep waste, spoilage, over-production, expired) for targeted waste reduction initiatives."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste event. Enables root-cause analysis and corrective action prioritization."
    - name: "waste_date"
      expr: waste_date
      comment: "Date of waste event for daily and weekly waste trending and pattern identification."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late night) when waste occurred. Identifies peak waste periods for staffing and prep adjustments."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (trash, compost, donation) for sustainability and compliance reporting."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Flag indicating waste was associated with a HACCP violation. Critical food safety dimension for compliance monitoring."
    - name: "responsible_station"
      expr: responsible_station
      comment: "Kitchen station responsible for the waste. Enables station-level waste accountability and coaching."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for waste quantity, enabling volume-normalized waste comparisons."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total dollar cost of food waste. Primary financial KPI for waste reduction programs and food cost management."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of food wasted. Volume KPI for waste trending and sustainability reporting."
    - name: "waste_event_count"
      expr: COUNT(1)
      comment: "Total number of waste events recorded. High frequency indicates operational issues or over-production patterns."
    - name: "haccp_violation_waste_cost"
      expr: SUM(CASE WHEN haccp_violation = TRUE THEN waste_cost ELSE 0 END)
      comment: "Total waste cost associated with HACCP violations. Critical food safety and compliance KPI for operations and QA leadership."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Tracks whether individual waste incidents are increasing in severity."
    - name: "manager_approved_waste_cost"
      expr: SUM(CASE WHEN manager_approved = TRUE THEN waste_cost ELSE 0 END)
      comment: "Total waste cost that has been manager-approved. Tracks governance compliance for waste documentation."
    - name: "on_hand_quantity_before_waste_total"
      expr: SUM(CAST(on_hand_quantity_before_waste AS DOUBLE))
      comment: "Total on-hand quantity before waste events. Used to calculate waste as a percentage of available stock."
    - name: "distinct_items_wasted"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct stock items with waste events. Broad waste across many items signals systemic over-ordering or prep issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving order metrics tracking delivery performance, quality, and variance at the dock. Drives supplier performance management, receiving compliance, and inventory accuracy."
  source: "`vibe_restaurants_v1`.`inventory`.`receiving_order`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving order (pending, received, rejected, partial) for receiving pipeline monitoring."
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Timeliness classification of the delivery (on-time, early, late) for supplier on-time delivery KPI."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection at receiving (pass, fail, conditional) for supplier quality tracking."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual delivery date for time-series analysis of receiving volume and supplier delivery patterns."
    - name: "receiving_shift"
      expr: receiving_shift
      comment: "Shift during which receiving occurred. Identifies shift-level receiving patterns and staffing needs."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a quantity or quality variance was detected at receiving. Drives supplier dispute and correction processes."
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of temperature check at receiving (pass, fail). Critical food safety KPI for cold chain compliance."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total value of goods received. Primary procurement spend KPI and input to food cost calculations."
    - name: "total_items_received"
      expr: SUM(CAST(total_items_received AS DOUBLE))
      comment: "Total number of items received across all receiving orders. Volume KPI for receiving workload and supplier activity."
    - name: "total_items_ordered"
      expr: SUM(CAST(total_items_ordered AS DOUBLE))
      comment: "Total items ordered across receiving orders. Used with items received to calculate fill rate."
    - name: "receiving_order_count"
      expr: COUNT(1)
      comment: "Total number of receiving orders. Tracks receiving activity volume and supplier delivery frequency."
    - name: "variance_receiving_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of receiving orders with variances. High variance rate signals supplier reliability or receiving process issues."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving. Tracks cold chain compliance trends across deliveries."
    - name: "failed_quality_inspection_count"
      expr: COUNT(CASE WHEN quality_inspection_result = 'fail' THEN 1 END)
      comment: "Number of receiving orders failing quality inspection. Key supplier quality KPI driving corrective action."
    - name: "posted_to_inventory_count"
      expr: COUNT(CASE WHEN posted_to_inventory_flag = TRUE THEN 1 END)
      comment: "Number of receiving orders posted to inventory. Tracks receiving-to-inventory processing completeness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock transfer metrics tracking inter-location inventory movement, value, and quality compliance. Drives distribution efficiency, HACCP compliance, and inter-unit cost allocation."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of stock transfer (inter-unit, DC-to-unit, unit-to-unit) for categorizing transfer flows."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (requested, in-transit, received, cancelled) for pipeline monitoring."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason code for the transfer (rebalancing, emergency, planned) for transfer pattern analysis."
    - name: "transfer_request_date"
      expr: transfer_request_date
      comment: "Date transfer was requested for lead time and fulfillment speed analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled transfer required. Tracks cold chain compliance in transfer operations."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the transfer. Enables cost and speed analysis by transport mode."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (urgent, standard, low) for workload and fulfillment prioritization."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total dollar value of inventory transferred. Key inter-unit cost allocation and working capital movement KPI."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of inventory transferred across all transfer orders. Volume KPI for distribution activity."
    - name: "total_item_count_transferred"
      expr: SUM(CAST(total_item_count AS DOUBLE))
      comment: "Total number of line items transferred. Tracks transfer complexity and fulfillment workload."
    - name: "transfer_order_count"
      expr: COUNT(1)
      comment: "Total number of stock transfer orders. Tracks inter-unit transfer frequency and distribution network activity."
    - name: "variance_transfer_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of transfers with quantity or quality variances. Signals distribution accuracy issues requiring investigation."
    - name: "temperature_controlled_transfer_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of temperature-controlled transfers. Tracks cold chain transfer volume for compliance and cost management."
    - name: "haccp_monitoring_required_count"
      expr: COUNT(CASE WHEN haccp_monitoring_required_flag = TRUE THEN 1 END)
      comment: "Number of transfers requiring HACCP monitoring. Tracks food safety compliance requirements in transfer operations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield record metrics tracking actual vs standard yield percentages, waste, and cost efficiency in food preparation. Drives recipe compliance, prep efficiency, and food cost optimization."
  source: "`vibe_restaurants_v1`.`inventory`.`yield_record`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep activity (butchering, portioning, cooking) for yield analysis by preparation method."
    - name: "prep_date"
      expr: prep_date
      comment: "Date of prep activity for time-series yield trending and seasonal pattern identification."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the yield output. Tracks quality consistency and premium vs standard yield rates."
    - name: "yield_record_status"
      expr: yield_record_status
      comment: "Status of the yield record (draft, submitted, approved) for data completeness monitoring."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Flag indicating HACCP compliance during prep. Non-compliant yields require immediate corrective action."
    - name: "prep_station_name"
      expr: prep_station_name
      comment: "Name of the prep station where yield was recorded. Enables station-level yield performance benchmarking."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for yield waste. Drives targeted waste reduction by prep stage and cause."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage across all prep records. Core recipe compliance KPI; gap vs standard drives food cost variance."
    - name: "avg_standard_yield_percentage"
      expr: AVG(CAST(standard_yield_percentage AS DOUBLE))
      comment: "Average standard (recipe-specified) yield percentage. Benchmark for actual yield performance evaluation."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average variance between actual and standard yield percentage. Negative values indicate below-standard prep efficiency."
    - name: "total_raw_quantity_in"
      expr: SUM(CAST(raw_quantity_in AS DOUBLE))
      comment: "Total raw ingredient quantity input to prep. Used to calculate overall yield efficiency across prep volume."
    - name: "total_usable_yield_quantity"
      expr: SUM(CAST(usable_yield_quantity_out AS DOUBLE))
      comment: "Total usable yield quantity produced. Primary output volume KPI for prep productivity."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity from prep activities. Drives waste reduction programs and recipe yield improvement."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage in prep. Tracks prep efficiency and identifies high-waste items or stations."
    - name: "total_raw_cost"
      expr: SUM(CAST(total_raw_cost AS DOUBLE))
      comment: "Total raw ingredient cost input to prep. Used to calculate cost per usable yield unit and recipe cost accuracy."
    - name: "avg_cost_per_yield_unit"
      expr: AVG(CAST(cost_per_yield_unit AS DOUBLE))
      comment: "Average cost per usable yield unit. Tracks effective ingredient cost after prep losses for recipe costing accuracy."
    - name: "non_haccp_compliant_count"
      expr: COUNT(CASE WHEN haccp_compliant = FALSE THEN 1 END)
      comment: "Number of yield records with HACCP non-compliance. Critical food safety KPI requiring immediate operational response."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_prep_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prep usage metrics tracking actual vs theoretical ingredient consumption during food preparation. Drives recipe adherence, food cost control, and prep efficiency optimization."
  source: "`vibe_restaurants_v1`.`inventory`.`prep_usage`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep activity for categorizing usage patterns by preparation method."
    - name: "prep_date"
      expr: prep_date
      comment: "Date of prep activity for daily and weekly usage trending."
    - name: "prep_station_name"
      expr: prep_station_name
      comment: "Prep station name for station-level usage accountability and efficiency benchmarking."
    - name: "prep_usage_status"
      expr: prep_usage_status
      comment: "Status of the prep usage record (draft, submitted, approved) for data completeness monitoring."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "HACCP compliance flag for prep activity. Non-compliant prep records require immediate food safety response."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code during which prep occurred. Enables shift-level usage analysis for staffing and scheduling optimization."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for prep quantities, enabling volume-normalized comparisons."
  measures:
    - name: "total_actual_quantity_used"
      expr: SUM(CAST(actual_quantity_used AS DOUBLE))
      comment: "Total actual ingredient quantity used in prep. Primary consumption volume KPI for food cost and recipe compliance."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical ingredient quantity per recipe standards. Benchmark for actual usage comparison."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between actual and theoretical prep usage. Positive variance indicates over-use vs recipe."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of prep ingredient usage. Key food cost input for period-level P&L."
    - name: "total_theoretical_cost"
      expr: SUM(CAST(theoretical_cost AS DOUBLE))
      comment: "Total theoretical cost based on recipe standards. Benchmark for actual cost performance."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between actual and theoretical prep. Drives recipe compliance and cost reduction programs."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average prep usage variance percentage. Tracks recipe adherence trend; high values trigger retraining or recipe review."
    - name: "non_haccp_compliant_prep_count"
      expr: COUNT(CASE WHEN haccp_compliant = FALSE THEN 1 END)
      comment: "Number of prep usage records with HACCP non-compliance. Critical food safety KPI for operations and QA."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order metrics tracking order fulfillment, delivery performance, and procurement efficiency. Drives stockout prevention, supplier management, and inventory cost optimization."
  source: "`vibe_restaurants_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (draft, submitted, confirmed, received, cancelled) for pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (automatic, manual, emergency) for analyzing order trigger patterns."
    - name: "order_source"
      expr: order_source
      comment: "Source system or trigger for the order (par-based, forecast, manual) for process efficiency analysis."
    - name: "order_date"
      expr: order_date
      comment: "Date the replenishment order was placed for time-series ordering pattern analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order for governance and spend control monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (urgent, standard) for workload and fulfillment prioritization."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method for the replenishment order. Enables cost and speed analysis by transport mode."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of replenishment orders placed. Primary procurement spend KPI for inventory investment tracking."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due for replenishment orders including tax and shipping. Tracks total procurement liability."
    - name: "total_shipping_fee"
      expr: SUM(CAST(shipping_fee AS DOUBLE))
      comment: "Total shipping fees across replenishment orders. Tracks logistics cost and identifies optimization opportunities."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on replenishment orders. Used for tax accrual and compliance reporting."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Tracks ordering frequency and procurement workload."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of replenishment orders with delivery variances. Tracks supplier fulfillment accuracy."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average replenishment order value. Tracks order size trends and procurement efficiency."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled replenishment orders. High cancellation rates indicate planning or supplier reliability issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_lot_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot tracking metrics monitoring ingredient lot status, recall exposure, quarantine activity, and cold chain compliance. Critical for food safety traceability and recall response management."
  source: "`vibe_restaurants_v1`.`inventory`.`lot_tracking`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (active, quarantined, recalled, consumed, expired) for lot lifecycle monitoring."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the lot (ambient, refrigerated, frozen) for cold chain compliance tracking."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the lot at receiving. Tracks quality distribution across supplier lots."
    - name: "received_date"
      expr: received_date
      comment: "Date the lot was received for FIFO compliance and shelf-life management."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Flag indicating lot is under quarantine. Active quarantine lots require immediate operational response."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating lot is subject to a recall. Critical food safety dimension for recall response tracking."
    - name: "condition_at_receiving"
      expr: condition_at_receiving
      comment: "Condition of the lot when received (acceptable, damaged, temperature-compromised) for supplier quality analysis."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all tracked lots. Primary receiving volume KPI for supply chain activity."
    - name: "total_quantity_remaining"
      expr: SUM(CAST(quantity_remaining AS DOUBLE))
      comment: "Total quantity remaining in active lots. Tracks current lot-level inventory exposure for traceability."
    - name: "quarantined_lot_count"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of lots currently under quarantine. Critical food safety KPI requiring immediate management attention."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to active recalls. Drives recall response urgency and regulatory reporting."
    - name: "recalled_quantity_remaining"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN quantity_remaining ELSE 0 END)
      comment: "Total quantity remaining in recalled lots. Measures recall exposure and urgency of removal from service."
    - name: "avg_temperature_at_receiving"
      expr: AVG(CAST(temperature_at_receiving_f AS DOUBLE))
      comment: "Average temperature recorded at lot receiving. Tracks cold chain compliance trends across supplier deliveries."
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Total number of tracked lots. Tracks traceability coverage and lot management workload."
    - name: "distinct_suppliers_with_quarantine"
      expr: COUNT(DISTINCT CASE WHEN quarantine_flag = TRUE THEN procurement_supplier_id END)
      comment: "Number of distinct suppliers with quarantined lots. Identifies suppliers with systemic quality issues."
$$;