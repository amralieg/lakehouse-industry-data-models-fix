-- Metric views for domain: supply | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_otif_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full (OTIF) delivery performance metrics tracking customer service levels, fill rates, and penalty exposure across channels, carriers, and customers"
  source: "`food_beverage_ecm`.`supply`.`otif_performance`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date when OTIF performance was measured"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of OTIF measurement for trend analysis"
    - name: "channel"
      expr: channel
      comment: "Sales channel (retail, foodservice, DTC) for performance segmentation"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transportation mode (truck, rail, intermodal) affecting delivery performance"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (delivered, in-transit, delayed)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of OTIF failure root cause for corrective action"
    - name: "root_cause_detail"
      expr: root_cause_detail
      comment: "Detailed root cause of OTIF failure for deep-dive analysis"
    - name: "is_otif"
      expr: is_otif
      comment: "Boolean flag indicating whether delivery met both on-time and in-full criteria"
    - name: "is_on_time"
      expr: is_on_time
      comment: "Boolean flag indicating whether delivery was on time"
    - name: "is_in_full"
      expr: is_in_full
      comment: "Boolean flag indicating whether delivery was in full quantity"
    - name: "is_penalty_assessed"
      expr: is_penalty_assessed
      comment: "Boolean flag indicating whether retailer assessed a penalty for OTIF failure"
    - name: "retailer_scorecard_window"
      expr: retailer_scorecard_window
      comment: "Retailer's measurement window for OTIF scorecard compliance"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery records measured for OTIF performance"
    - name: "otif_delivery_count"
      expr: SUM(CASE WHEN is_otif = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries meeting both on-time and in-full criteria"
    - name: "otif_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_otif = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting OTIF criteria - primary customer service KPI"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN is_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries meeting on-time criteria"
    - name: "on_time_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_on_time = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting on-time criteria"
    - name: "in_full_delivery_count"
      expr: SUM(CASE WHEN is_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries meeting in-full quantity criteria"
    - name: "in_full_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_in_full = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting in-full criteria"
    - name: "case_fill_rate_avg_pct"
      expr: ROUND(AVG(CAST(case_fill_rate AS DOUBLE)), 2)
      comment: "Average case fill rate across deliveries - measures quantity fulfillment accuracy"
    - name: "line_fill_rate_avg_pct"
      expr: ROUND(AVG(CAST(line_fill_rate AS DOUBLE)), 2)
      comment: "Average line fill rate across deliveries - measures SKU-level fulfillment accuracy"
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total quantity ordered across all deliveries"
    - name: "total_delivered_qty"
      expr: SUM(CAST(delivered_qty AS DOUBLE))
      comment: "Total quantity delivered across all deliveries"
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total quantity shipped across all deliveries"
    - name: "delivery_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully delivered - overall fulfillment effectiveness"
    - name: "penalty_assessed_count"
      expr: SUM(CASE WHEN is_penalty_assessed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries where retailer assessed a penalty for OTIF failure"
    - name: "penalty_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_penalty_assessed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries incurring retailer penalties - financial risk indicator"
    - name: "total_penalty_exposure_amt"
      expr: SUM(CAST(penalty_exposure_amt AS DOUBLE))
      comment: "Total financial exposure from OTIF penalties - direct P&L impact"
    - name: "avg_penalty_exposure_amt"
      expr: ROUND(AVG(CAST(penalty_exposure_amt AS DOUBLE)), 2)
      comment: "Average penalty exposure per delivery - unit economics of OTIF failure"
    - name: "backorder_count"
      expr: SUM(CASE WHEN is_backorder = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries resulting in backorders - supply chain disruption indicator"
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_backorder = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries resulting in backorders - inventory availability metric"
    - name: "substitution_count"
      expr: SUM(CASE WHEN is_substitution = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries involving product substitutions"
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_substitution = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries involving substitutions - product availability signal"
    - name: "avg_otif_score"
      expr: ROUND(AVG(CAST(otif_score AS DOUBLE)), 2)
      comment: "Average OTIF score across deliveries - composite performance metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order execution metrics tracking order fulfillment, lead time performance, inventory flow, and supply chain responsiveness"
  source: "`food_beverage_ecm`.`supply`.`replenishment_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date when replenishment order was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order creation for trend analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current status of replenishment order (open, confirmed, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (stock, safety stock, promotional, emergency)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transportation mode for replenishment delivery"
    - name: "priority"
      expr: priority
      comment: "Order priority level affecting fulfillment sequence"
    - name: "rotation_policy"
      expr: rotation_policy
      comment: "Inventory rotation policy (FIFO, FEFO, LIFO) for perishable goods management"
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Boolean flag indicating whether order meets minimum order quantity requirements"
    - name: "quality_hold"
      expr: quality_hold
      comment: "Boolean flag indicating whether order is on quality hold pending inspection"
    - name: "safety_stock_trigger"
      expr: safety_stock_trigger
      comment: "Boolean flag indicating whether order was triggered by safety stock breach"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Date when delivery was requested by demand planner"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date when order was delivered"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all replenishment orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by supplier or source location"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination location"
    - name: "order_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed - supplier/source reliability metric"
    - name: "order_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity received - end-to-end fulfillment effectiveness"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total financial value of all replenishment orders - working capital deployed"
    - name: "avg_order_value"
      expr: ROUND(AVG(CAST(total_order_value AS DOUBLE)), 2)
      comment: "Average value per replenishment order - order economics metric"
    - name: "avg_unit_cost"
      expr: ROUND(AVG(CAST(unit_cost AS DOUBLE)), 2)
      comment: "Average unit cost across replenishment orders - procurement efficiency indicator"
    - name: "avg_lead_time_days"
      expr: ROUND(AVG(CAST(lead_time_days AS DOUBLE)), 2)
      comment: "Average lead time in days from order to delivery - supply chain responsiveness"
    - name: "avg_moq_quantity"
      expr: ROUND(AVG(CAST(moq_quantity AS DOUBLE)), 2)
      comment: "Average minimum order quantity across orders - procurement constraint metric"
    - name: "moq_compliant_count"
      expr: SUM(CASE WHEN moq_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders meeting MOQ requirements"
    - name: "moq_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN moq_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders meeting MOQ - procurement policy adherence"
    - name: "quality_hold_count"
      expr: SUM(CASE WHEN quality_hold = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders on quality hold - quality risk indicator"
    - name: "quality_hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_hold = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders on quality hold - supplier quality performance"
    - name: "safety_stock_trigger_count"
      expr: SUM(CASE WHEN safety_stock_trigger = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders triggered by safety stock breach - inventory risk signal"
    - name: "safety_stock_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_stock_trigger = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders triggered by safety stock breach - demand volatility indicator"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_capacity_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production and distribution capacity utilization metrics tracking bottlenecks, resource efficiency, and operational constraints across the supply network"
  source: "`food_beverage_ecm`.`supply`.`capacity_constraint`"
  dimensions:
    - name: "bucket_start_date"
      expr: bucket_start_date
      comment: "Start date of capacity planning bucket"
    - name: "bucket_month"
      expr: DATE_TRUNC('MONTH', bucket_start_date)
      comment: "Month of capacity bucket for trend analysis"
    - name: "capacity_bucket"
      expr: capacity_bucket
      comment: "Time bucket granularity (daily, weekly, monthly) for capacity planning"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of capacity constraint (production, storage, labor, transportation)"
    - name: "constraint_category"
      expr: constraint_category
      comment: "Category of constraint for root cause analysis"
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of constraint (active, resolved, planned)"
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource being constrained (line, warehouse, labor pool, fleet)"
    - name: "bottleneck_flag"
      expr: bottleneck_flag
      comment: "Boolean flag indicating whether this constraint is a system bottleneck"
    - name: "otif_risk_flag"
      expr: otif_risk_flag
      comment: "Boolean flag indicating whether constraint poses OTIF delivery risk"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Boolean flag indicating whether constraint is due to regulatory hold"
    - name: "planning_version"
      expr: planning_version
      comment: "Version of capacity plan for scenario comparison"
    - name: "constraint_source"
      expr: constraint_source
      comment: "Source system or process that identified the constraint"
  measures:
    - name: "total_constraints"
      expr: COUNT(1)
      comment: "Total number of capacity constraint records"
    - name: "bottleneck_count"
      expr: SUM(CASE WHEN bottleneck_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of constraints identified as system bottlenecks - critical path analysis"
    - name: "bottleneck_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN bottleneck_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints that are bottlenecks - operational efficiency indicator"
    - name: "otif_risk_count"
      expr: SUM(CASE WHEN otif_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of constraints posing OTIF delivery risk - customer service threat"
    - name: "otif_risk_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints posing OTIF risk - service level exposure"
    - name: "total_available_capacity"
      expr: SUM(CAST(available_capacity AS DOUBLE))
      comment: "Total available capacity across all resources and time buckets"
    - name: "total_utilized_capacity"
      expr: SUM(CAST(utilized_capacity AS DOUBLE))
      comment: "Total utilized capacity across all resources and time buckets"
    - name: "total_effective_capacity"
      expr: SUM(CAST(effective_capacity AS DOUBLE))
      comment: "Total effective capacity after accounting for downtime and constraints"
    - name: "avg_utilization_pct"
      expr: ROUND(AVG(CAST(utilization_pct AS DOUBLE)), 2)
      comment: "Average capacity utilization percentage - operational efficiency KPI"
    - name: "network_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(utilized_capacity AS DOUBLE)) / NULLIF(SUM(CAST(available_capacity AS DOUBLE)), 0), 2)
      comment: "Network-wide capacity utilization rate - asset productivity metric"
    - name: "effective_capacity_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(effective_capacity AS DOUBLE)) / NULLIF(SUM(CAST(available_capacity AS DOUBLE)), 0), 2)
      comment: "Effective capacity as percentage of available - constraint impact measure"
    - name: "avg_utilization_ceiling_pct"
      expr: ROUND(AVG(CAST(utilization_ceiling_pct AS DOUBLE)), 2)
      comment: "Average utilization ceiling across resources - maximum safe operating level"
    - name: "total_labor_hours_available"
      expr: SUM(CAST(labor_hours_available AS DOUBLE))
      comment: "Total labor hours available across all resources"
    - name: "total_labor_hours_utilized"
      expr: SUM(CAST(labor_hours_utilized AS DOUBLE))
      comment: "Total labor hours utilized across all resources"
    - name: "labor_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_utilized AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours_available AS DOUBLE)), 0), 2)
      comment: "Labor utilization rate - workforce productivity metric"
    - name: "total_changeover_hours"
      expr: SUM(CAST(changeover_hours AS DOUBLE))
      comment: "Total changeover hours across all production resources - setup efficiency"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours - maintenance and scheduling impact"
    - name: "avg_oee_target_pct"
      expr: ROUND(AVG(CAST(oee_target_pct AS DOUBLE)), 2)
      comment: "Average Overall Equipment Effectiveness target - operational excellence benchmark"
    - name: "total_safety_stock_impact"
      expr: SUM(CAST(safety_stock_impact AS DOUBLE))
      comment: "Total safety stock impact from capacity constraints - inventory buffer requirement"
    - name: "regulatory_hold_count"
      expr: SUM(CASE WHEN regulatory_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of constraints due to regulatory holds - compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning and forecast accuracy metrics tracking consensus forecasts, promotional uplifts, and forecast error across products and channels"
  source: "`food_beverage_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "plan_period_start_date"
      expr: plan_period_start_date
      comment: "Start date of demand planning period"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_period_start_date)
      comment: "Month of demand plan for trend analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of demand plan for annual planning cycles"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of demand plan for financial alignment"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of demand plan (baseline, consensus, promotional, new product)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of demand plan (draft, approved, locked, archived)"
    - name: "channel"
      expr: channel
      comment: "Sales channel for demand segmentation (retail, foodservice, DTC)"
    - name: "demand_class"
      expr: demand_class
      comment: "Classification of demand (regular, promotional, seasonal, new product)"
    - name: "forecast_algorithm"
      expr: forecast_algorithm
      comment: "Algorithm used for statistical forecasting (time series, ML, causal)"
    - name: "planning_horizon"
      expr: planning_horizon
      comment: "Planning horizon timeframe (short-term, medium-term, long-term)"
    - name: "is_frozen"
      expr: is_frozen
      comment: "Boolean flag indicating whether plan is frozen for execution"
    - name: "is_new_product"
      expr: is_new_product
      comment: "Boolean flag indicating whether plan is for new product launch"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of demand plan records"
    - name: "total_consensus_forecast_qty"
      expr: SUM(CAST(consensus_forecast_qty AS DOUBLE))
      comment: "Total consensus forecast quantity - cross-functional agreed demand"
    - name: "total_baseline_forecast_qty"
      expr: SUM(CAST(baseline_forecast_qty AS DOUBLE))
      comment: "Total baseline forecast quantity - statistical forecast before adjustments"
    - name: "total_statistical_forecast_qty"
      expr: SUM(CAST(statistical_forecast_qty AS DOUBLE))
      comment: "Total statistical forecast quantity - algorithm-driven forecast"
    - name: "total_adjusted_forecast_qty"
      expr: SUM(CAST(adjusted_forecast_qty AS DOUBLE))
      comment: "Total adjusted forecast quantity - final forecast after all overrides"
    - name: "total_customer_order_qty"
      expr: SUM(CAST(customer_order_qty AS DOUBLE))
      comment: "Total customer order quantity - actual demand signal"
    - name: "total_pos_sales_qty"
      expr: SUM(CAST(pos_sales_qty AS DOUBLE))
      comment: "Total point-of-sale quantity - consumer demand signal"
    - name: "total_promotional_uplift_qty"
      expr: SUM(CAST(promotional_uplift_qty AS DOUBLE))
      comment: "Total promotional uplift quantity - incremental demand from promotions"
    - name: "total_demand_sensing_qty"
      expr: SUM(CAST(demand_sensing_qty AS DOUBLE))
      comment: "Total demand sensing quantity - near-term demand signal from real-time data"
    - name: "avg_forecast_error_pct"
      expr: ROUND(AVG(CAST(forecast_error_pct AS DOUBLE)), 2)
      comment: "Average forecast error percentage - forecast accuracy KPI"
    - name: "avg_forecast_confidence_pct"
      expr: ROUND(AVG(CAST(forecast_confidence_pct AS DOUBLE)), 2)
      comment: "Average forecast confidence percentage - forecast reliability indicator"
    - name: "consensus_vs_baseline_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(consensus_forecast_qty AS DOUBLE)) - SUM(CAST(baseline_forecast_qty AS DOUBLE))) / NULLIF(SUM(CAST(baseline_forecast_qty AS DOUBLE)), 0), 2)
      comment: "Variance between consensus and baseline forecast - human judgment impact"
    - name: "promotional_uplift_pct"
      expr: ROUND(100.0 * SUM(CAST(promotional_uplift_qty AS DOUBLE)) / NULLIF(SUM(CAST(baseline_forecast_qty AS DOUBLE)), 0), 2)
      comment: "Promotional uplift as percentage of baseline - promotion effectiveness"
    - name: "avg_uplift_factor"
      expr: ROUND(AVG(CAST(uplift_factor AS DOUBLE)), 2)
      comment: "Average uplift factor applied to forecasts - demand shaping magnitude"
    - name: "avg_seasonality_index"
      expr: ROUND(AVG(CAST(seasonality_index AS DOUBLE)), 2)
      comment: "Average seasonality index - seasonal demand pattern strength"
    - name: "frozen_plan_count"
      expr: SUM(CASE WHEN is_frozen = TRUE THEN 1 ELSE 0 END)
      comment: "Count of frozen plans - execution-ready demand plans"
    - name: "frozen_plan_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_frozen = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans frozen for execution - planning cycle maturity"
    - name: "new_product_plan_count"
      expr: SUM(CASE WHEN is_new_product = TRUE THEN 1 ELSE 0 END)
      comment: "Count of new product plans - innovation pipeline indicator"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales and Operations Planning (S&OP) cycle performance metrics tracking consensus building, revenue gaps, supply gaps, and planning cycle effectiveness"
  source: "`food_beverage_ecm`.`supply`.`sop_cycle`"
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of S&OP planning period"
    - name: "planning_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month of S&OP cycle for trend analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of S&OP cycle for annual planning alignment"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of S&OP cycle for financial synchronization"
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of S&OP cycle (open, in-progress, closed, archived)"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of S&OP cycle (monthly, quarterly, annual, special)"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Type of planning scenario (baseline, optimistic, pessimistic, risk-adjusted)"
    - name: "financial_reconciliation_status"
      expr: financial_reconciliation_status
      comment: "Status of financial reconciliation with finance team"
    - name: "is_locked"
      expr: is_locked
      comment: "Boolean flag indicating whether S&OP cycle is locked for execution"
    - name: "safety_stock_review_flag"
      expr: safety_stock_review_flag
      comment: "Boolean flag indicating whether safety stock policies were reviewed this cycle"
    - name: "demand_review_date"
      expr: demand_review_date
      comment: "Date of demand review meeting"
    - name: "supply_review_date"
      expr: supply_review_date
      comment: "Date of supply review meeting"
    - name: "executive_review_date"
      expr: executive_review_date
      comment: "Date of executive S&OP review meeting"
  measures:
    - name: "total_sop_cycles"
      expr: COUNT(1)
      comment: "Total number of S&OP cycle records"
    - name: "total_consensus_demand_volume"
      expr: SUM(CAST(consensus_demand_volume AS DOUBLE))
      comment: "Total consensus demand volume agreed across functions - unified demand view"
    - name: "total_consensus_revenue_target"
      expr: SUM(CAST(consensus_revenue_target AS DOUBLE))
      comment: "Total consensus revenue target - financial commitment from S&OP"
    - name: "total_revenue_gap_amount"
      expr: SUM(CAST(revenue_gap_amount AS DOUBLE))
      comment: "Total revenue gap between target and plan - strategic risk indicator"
    - name: "total_supply_gap_volume"
      expr: SUM(CAST(supply_gap_volume AS DOUBLE))
      comment: "Total supply gap volume - capacity shortfall requiring action"
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(AVG(CAST(capacity_utilization_pct AS DOUBLE)), 2)
      comment: "Average capacity utilization percentage across S&OP cycles - asset productivity"
    - name: "avg_service_level_target_pct"
      expr: ROUND(AVG(CAST(service_level_target_pct AS DOUBLE)), 2)
      comment: "Average service level target percentage - customer service commitment"
    - name: "avg_inventory_target_days"
      expr: ROUND(AVG(CAST(inventory_target_days AS DOUBLE)), 2)
      comment: "Average inventory target in days of supply - working capital efficiency target"
    - name: "avg_promotional_volume_pct"
      expr: ROUND(AVG(CAST(promotional_volume_pct AS DOUBLE)), 2)
      comment: "Average promotional volume as percentage of total - trade spend effectiveness"
    - name: "revenue_gap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_gap_amount AS DOUBLE)) / NULLIF(SUM(CAST(consensus_revenue_target AS DOUBLE)), 0), 2)
      comment: "Revenue gap as percentage of target - strategic plan risk metric"
    - name: "supply_gap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(supply_gap_volume AS DOUBLE)) / NULLIF(SUM(CAST(consensus_demand_volume AS DOUBLE)), 0), 2)
      comment: "Supply gap as percentage of demand - capacity adequacy metric"
    - name: "locked_cycle_count"
      expr: SUM(CASE WHEN is_locked = TRUE THEN 1 ELSE 0 END)
      comment: "Count of locked S&OP cycles - execution-ready plans"
    - name: "locked_cycle_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_locked = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles locked for execution - planning cycle maturity"
    - name: "safety_stock_review_count"
      expr: SUM(CASE WHEN safety_stock_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cycles with safety stock policy review - inventory governance"
    - name: "avg_open_action_item_count"
      expr: ROUND(AVG(CAST(open_action_item_count AS DOUBLE)), 2)
      comment: "Average open action items per cycle - execution follow-through metric"
    - name: "avg_new_product_items_count"
      expr: ROUND(AVG(CAST(new_product_items_count AS DOUBLE)), 2)
      comment: "Average new product items per cycle - innovation pipeline activity"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`supply_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receipt and goods receiving metrics tracking receipt accuracy, quality inspection, shelf life, and inventory valuation at receiving"
  source: "`food_beverage_ecm`.`supply`.`inbound_receipt`"
  dimensions:
    - name: "receipt_timestamp"
      expr: receipt_timestamp
      comment: "Timestamp when goods were received"
    - name: "receipt_date"
      expr: DATE_TRUNC('DAY', receipt_timestamp)
      comment: "Date of goods receipt for daily trend analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of goods receipt for monthly trend analysis"
    - name: "posting_date"
      expr: posting_date
      comment: "Financial posting date for accounting alignment"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of receipt (posted, pending, blocked, cancelled)"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement (goods receipt, return, transfer)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, quality inspection, blocked)"
    - name: "quality_usage_decision"
      expr: quality_usage_decision
      comment: "Quality inspection decision (accepted, rejected, conditional release)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for traceability and compliance"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Boolean flag indicating whether receipt is consignment inventory"
    - name: "is_return_delivery"
      expr: is_return_delivery
      comment: "Boolean flag indicating whether receipt is a return delivery"
    - name: "receiving_plant_type"
      expr: receiving_plant_type
      comment: "Type of receiving plant (manufacturing, distribution, co-packer)"
    - name: "manufacture_date"
      expr: manufacture_date
      comment: "Manufacture date of received goods for shelf life tracking"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of received goods for FEFO management"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipt transactions"
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total quantity received across all receipts"
    - name: "total_po_ordered_qty"
      expr: SUM(CAST(po_ordered_qty AS DOUBLE))
      comment: "Total quantity ordered on purchase orders"
    - name: "receipt_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_qty AS DOUBLE)) / NULLIF(SUM(CAST(po_ordered_qty AS DOUBLE)), 0), 2)
      comment: "Receipt accuracy as percentage of ordered quantity - supplier delivery performance"
    - name: "total_receipt_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total financial value of all receipts - inventory investment"
    - name: "avg_receipt_value"
      expr: ROUND(AVG(CAST(total_receipt_value AS DOUBLE)), 2)
      comment: "Average value per receipt transaction - receipt economics"
    - name: "avg_valuation_price"
      expr: ROUND(AVG(CAST(valuation_price AS DOUBLE)), 2)
      comment: "Average valuation price per unit - cost basis for inventory"
    - name: "consignment_receipt_count"
      expr: SUM(CASE WHEN is_consignment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consignment receipts - vendor-managed inventory activity"
    - name: "consignment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_consignment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts that are consignment - VMI program penetration"
    - name: "return_delivery_count"
      expr: SUM(CASE WHEN is_return_delivery = TRUE THEN 1 ELSE 0 END)
      comment: "Count of return deliveries - supplier quality issue indicator"
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_return_delivery = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts that are returns - supplier performance metric"
    - name: "quality_accepted_count"
      expr: SUM(CASE WHEN quality_usage_decision = 'accepted' THEN 1 ELSE 0 END)
      comment: "Count of receipts accepted by quality inspection"
    - name: "quality_rejected_count"
      expr: SUM(CASE WHEN quality_usage_decision = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of receipts rejected by quality inspection - supplier quality risk"
    - name: "quality_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_usage_decision = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Quality acceptance rate - supplier quality performance KPI"
    - name: "quality_rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_usage_decision = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Quality rejection rate - incoming quality defect rate"
$$;