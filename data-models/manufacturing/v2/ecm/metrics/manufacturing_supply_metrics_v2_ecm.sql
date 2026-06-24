-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for MRP planning runs — tracks run efficiency, exception volume, and planning throughput to steer supply planning quality."
  source: "`vibe_manufacturing_v1`.`supply`.`mrp_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (regenerative, net-change, etc.) for segmenting planning performance."
    - name: "run_status"
      expr: run_status
      comment: "Current status of the MRP run (completed, failed, in-progress) for operational monitoring."
    - name: "planning_mode"
      expr: planning_mode
      comment: "Planning mode used (forward, backward, etc.) to analyze run behavior by approach."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which the MRP run was executed, enabling site-level performance comparison."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month bucket of the planning horizon start date for trend analysis."
  measures:
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average MRP run duration in minutes — a key efficiency KPI; rising durations signal data or model complexity issues requiring intervention."
    - name: "total_planned_orders_created"
      expr: SUM(CAST(planned_orders_created_count AS DOUBLE))
      comment: "Total planned orders created across MRP runs — indicates planning output volume and demand coverage."
    - name: "total_planned_orders_cancelled"
      expr: SUM(CAST(planned_orders_cancelled_count AS DOUBLE))
      comment: "Total planned orders cancelled — high cancellation rates signal instability in demand or supply parameters."
    - name: "total_planned_orders_rescheduled"
      expr: SUM(CAST(planned_orders_rescheduled_count AS DOUBLE))
      comment: "Total planned orders rescheduled — a leading indicator of supply plan churn and replanning cost."
    - name: "total_exception_messages"
      expr: SUM(CAST(exception_messages_count AS DOUBLE))
      comment: "Total exception messages generated — high exception counts indicate supply imbalances requiring planner attention."
    - name: "total_materials_processed"
      expr: SUM(CAST(materials_processed_count AS DOUBLE))
      comment: "Total materials processed across MRP runs — measures planning scope and throughput."
    - name: "exception_rate_per_material"
      expr: ROUND(SUM(CAST(exception_messages_count AS DOUBLE)) / NULLIF(SUM(CAST(materials_processed_count AS DOUBLE)), 0), 4)
      comment: "Ratio of exception messages to materials processed — a normalized quality score for MRP run health; higher values indicate systemic planning issues."
    - name: "cancellation_rate"
      expr: ROUND(SUM(CAST(planned_orders_cancelled_count AS DOUBLE)) / NULLIF(SUM(CAST(planned_orders_created_count AS DOUBLE)), 0), 4)
      comment: "Ratio of cancelled to created planned orders — measures planning stability; high rates drive replanning cost and supply risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy and bias KPIs — the primary metrics for evaluating forecast quality and driving S&OP decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (approved, draft, superseded) for filtering active forecasts."
    - name: "demand_class"
      expr: demand_class
      comment: "Demand class (make-to-stock, make-to-order, etc.) for segmenting forecast performance by fulfillment strategy."
    - name: "forecast_model_code"
      expr: forecast_model_code
      comment: "Statistical model used to generate the forecast — enables model performance benchmarking."
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment driving the forecast — supports demand segmentation analysis."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the forecast planning period for time-series trend analysis."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the forecast includes a promotional uplift — used to isolate baseline vs. promotional demand."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage (launch, growth, maturity, decline) for lifecycle-adjusted forecast analysis."
  measures:
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage — the primary KPI for S&OP quality; below-target accuracy drives excess inventory or stockouts."
    - name: "avg_mean_absolute_percentage_error"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average MAPE across forecasts — the standard statistical measure of forecast error used in executive S&OP reviews."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage — persistent positive or negative bias signals systematic over/under-forecasting requiring model recalibration."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity — the aggregate demand signal used for capacity and supply planning."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total quantity adjusted by sales teams — measures the degree of manual override on statistical forecasts, indicating forecast model trust."
    - name: "avg_promotional_uplift_percent"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional uplift percentage — quantifies the demand impact of promotions for trade planning decisions."
    - name: "avg_seasonality_index"
      expr: AVG(CAST(seasonality_index AS DOUBLE))
      comment: "Average seasonality index — measures demand seasonality strength to inform safety stock and capacity planning."
    - name: "outlier_forecast_count"
      expr: COUNT(CASE WHEN outlier_flag = TRUE THEN 1 END)
      comment: "Count of forecasts flagged as outliers — high outlier counts indicate data quality issues or demand volatility requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order pipeline KPIs — tracks supply proposal volume, firming rates, and exception exposure to steer procurement and production planning."
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (purchase, production, transfer) for segmenting supply proposals by procurement mode."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the planned order proposal (open, firmed, converted, cancelled) for pipeline analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the planned order for site-level supply planning analysis."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the planned order scheduled start date for supply pipeline time-phasing."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the planned order for analyzing high-priority supply gaps."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code on the planned order for categorizing supply planning issues."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned order quantity — the aggregate supply proposal volume used to assess coverage against demand."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity manually overridden by planners — high override volumes indicate low confidence in automated MRP output."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders — a composite risk KPI used to prioritize supply chain interventions."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firming_indicator = TRUE THEN 1 END)
      comment: "Count of firmed planned orders — measures planning commitment and execution readiness."
    - name: "total_planned_orders"
      expr: COUNT(1)
      comment: "Total number of planned orders in the pipeline — baseline volume metric for supply planning throughput."
    - name: "firming_rate"
      expr: ROUND(COUNT(CASE WHEN firming_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Ratio of firmed to total planned orders — low firming rates indicate planning instability or excessive replanning cycles."
    - name: "avg_required_capacity_hours"
      expr: AVG(CAST(required_capacity_hours AS DOUBLE))
      comment: "Average capacity hours required per planned order — used to assess capacity load from the supply plan."
    - name: "avg_available_capacity_hours"
      expr: AVG(CAST(available_capacity_hours AS DOUBLE))
      comment: "Average available capacity hours per planned order — compared against required hours to identify capacity gaps."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across planned orders — informs procurement cost and inventory investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs — measures utilization, overload, and efficiency to drive production scheduling and investment decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (draft, approved, active) for filtering actionable plans."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the capacity planning period for time-series utilization trending."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position KPIs — tracks stock coverage, stockout risk, and excess inventory to drive replenishment and working capital decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`inventory_position`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material for segmenting inventory management focus (A=high value, C=low value)."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification (demand variability) for combined ABC-XYZ inventory segmentation analysis."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, reorder point, kanban) for analyzing inventory by replenishment strategy."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (external, in-house) for make-vs-buy inventory analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant location of the inventory position for site-level stock analysis."
    - name: "stock_out_risk_flag"
      expr: stock_out_risk_flag
      comment: "Flag indicating stockout risk — used to filter and prioritize at-risk materials for expediting."
    - name: "snapshot_date"
      expr: DATE_TRUNC('week', snapshot_date)
      comment: "Week bucket of the inventory snapshot date for time-series stock position trending."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand stock quantity — the primary inventory asset measure used for working capital and coverage analysis."
    - name: "total_available_to_promise_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity — the key metric for order fulfillment capability and customer service level."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply — measures how long current stock will last at current demand rates; drives replenishment urgency."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity — the buffer stock investment; used to balance service level against working capital cost."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net requirement quantity — the uncovered demand signal driving procurement and production actions."
    - name: "stockout_risk_item_count"
      expr: COUNT(CASE WHEN stock_out_risk_flag = TRUE THEN 1 END)
      comment: "Count of materials at stockout risk — a critical service level KPI; high counts require immediate supply chain intervention."
    - name: "excess_stock_item_count"
      expr: COUNT(CASE WHEN excess_stock_flag = TRUE THEN 1 END)
      comment: "Count of materials with excess stock — quantifies working capital tied up in overstock, driving disposition decisions."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity — stock unavailable for use due to quality holds; high values indicate quality or supplier issues."
    - name: "avg_average_daily_demand"
      expr: AVG(CAST(average_daily_demand AS DOUBLE))
      comment: "Average daily demand rate across materials — used to normalize inventory coverage and set replenishment parameters."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation KPIs — measures fulfillment coverage, allocation efficiency, and constraint exposure to steer constrained supply decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (approved, pending, escalated) for pipeline and decision-stage analysis."
    - name: "method"
      expr: method
      comment: "Allocation method (proportional, priority-based, FIFO) for analyzing allocation strategy effectiveness."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier (strategic, preferred, standard) for analyzing allocation fairness and priority adherence."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of allocation recipient (customer, plant, distribution center) for supply flow analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Source plant of the allocation for site-level supply distribution analysis."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month bucket of the allocation period start for time-series supply allocation trending."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating the allocation required escalation — used to identify constrained supply situations."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to customers/plants — the primary supply distribution volume metric."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested — the demand signal against which allocation coverage is measured."
    - name: "total_available_supply_quantity"
      expr: SUM(CAST(available_supply_quantity AS DOUBLE))
      comment: "Total available supply quantity — the supply pool available for allocation decisions."
    - name: "avg_fulfillment_percentage"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across allocations — the primary customer service KPI for constrained supply situations."
    - name: "allocation_fill_rate"
      expr: ROUND(SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of allocated to requested quantity — measures how well supply meets demand; below-target rates drive customer escalations."
    - name: "escalated_allocation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of allocations requiring escalation — measures supply constraint severity and management intervention frequency."
    - name: "contractual_commitment_count"
      expr: COUNT(CASE WHEN contractual_commitment_flag = TRUE THEN 1 END)
      comment: "Count of allocations with contractual commitments — identifies legally binding supply obligations requiring priority fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk KPIs — quantifies financial exposure, mitigation coverage, and risk concentration to steer supply resilience investments."
  source: "`vibe_manufacturing_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of supply risk (supplier, logistics, geopolitical, demand) for risk portfolio analysis."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk event for detailed risk classification and response planning."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (open, mitigated, closed) for active risk portfolio management."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity level of the risk (critical, high, medium, low) for prioritizing mitigation resources."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of the mitigation plan (planned, in-progress, completed) for tracking risk response execution."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the risk for geopolitical and regional concentration analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flag indicating whether the risk requires executive escalation — used to filter high-priority risks."
  measures:
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of supply risks — the aggregate monetary exposure used for risk-adjusted supply planning and insurance decisions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the supply risk register — the composite risk health KPI for executive supply chain reviews."
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost AS DOUBLE))
      comment: "Total cost of risk mitigation activities — used to evaluate the cost-effectiveness of supply risk management investments."
    - name: "total_potential_supply_impact_quantity"
      expr: SUM(CAST(potential_supply_impact_quantity AS DOUBLE))
      comment: "Total potential supply quantity at risk — quantifies the volume exposure from active supply risks."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'open' THEN 1 END)
      comment: "Count of open supply risks — the primary risk portfolio size metric for supply chain resilience dashboards."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Count of risks requiring executive escalation — measures the volume of critical supply threats needing leadership attention."
    - name: "avg_potential_impact_duration_days"
      expr: AVG(CAST(potential_impact_duration_days AS DOUBLE))
      comment: "Average potential duration of supply disruption in days — used to assess business continuity exposure and safety stock requirements."
    - name: "alternative_supplier_coverage_rate"
      expr: ROUND(COUNT(CASE WHEN alternative_supplier_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of risks with an identified alternative supplier — measures supply resilience and single-source dependency exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP cycle KPIs — measures demand-supply balance, planning cycle health, and financial alignment to steer executive S&OP decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Status of the S&OP cycle (in-progress, completed, approved) for tracking cycle completion."
    - name: "demand_review_status"
      expr: demand_review_status
      comment: "Status of the demand review stage for monitoring S&OP process adherence."
    - name: "supply_review_status"
      expr: supply_review_status
      comment: "Status of the supply review stage for monitoring S&OP process adherence."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Overall supply risk level for the S&OP cycle — used to prioritize executive attention."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the S&OP cycle for annual planning performance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the S&OP cycle for monthly planning cadence analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the S&OP cycle for site-level planning performance comparison."
  measures:
    - name: "total_demand_supply_gap_quantity"
      expr: SUM(CAST(demand_supply_gap_quantity AS DOUBLE))
      comment: "Total demand-supply gap quantity across S&OP cycles — the primary imbalance metric driving executive supply decisions."
    - name: "total_demand_supply_gap_value"
      expr: SUM(CAST(demand_supply_gap_value AS DOUBLE))
      comment: "Total financial value of the demand-supply gap — translates volume imbalance into revenue-at-risk for executive decision-making."
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Total planned revenue across S&OP cycles — the financial baseline for supply plan alignment and variance analysis."
    - name: "total_cost_plan_amount"
      expr: SUM(CAST(cost_plan_amount AS DOUBLE))
      comment: "Total planned cost across S&OP cycles — used for margin planning and supply cost management."
    - name: "total_inventory_plan_value"
      expr: SUM(CAST(inventory_plan_value AS DOUBLE))
      comment: "Total planned inventory value — the working capital commitment from the supply plan, used for cash flow planning."
    - name: "avg_capacity_utilization_target_percentage"
      expr: AVG(CAST(capacity_utilization_target_percentage AS DOUBLE))
      comment: "Average capacity utilization target across S&OP cycles — the planned efficiency benchmark for production operations."
    - name: "completed_cycle_count"
      expr: COUNT(CASE WHEN cycle_status = 'completed' THEN 1 END)
      comment: "Count of completed S&OP cycles — measures planning process execution discipline and cadence adherence."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_aps_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced planning schedule KPIs — measures scheduling efficiency, capacity utilization, and execution readiness to steer production scheduling decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`aps_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the APS schedule record (planned, released, completed) for pipeline analysis."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method used (forward, backward, finite capacity) for analyzing scheduling approach effectiveness."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint (capacity, material, tooling) for constraint-based analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the schedule for site-level scheduling performance analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for analyzing schedule distribution and utilization across shifts."
    - name: "released_to_mes_flag"
      expr: released_to_mes_flag
      comment: "Flag indicating whether the schedule has been released to MES — measures execution readiness."
    - name: "scheduled_start_timestamp"
      expr: DATE_TRUNC('week', scheduled_start_timestamp)
      comment: "Week bucket of the scheduled start timestamp for time-phased schedule analysis."
  measures:
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across scheduled operations — the primary scheduling efficiency KPI."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across the APS schedule — the aggregate output commitment for the planning horizon."
    - name: "total_run_time_minutes"
      expr: SUM(CAST(run_time_minutes AS DOUBLE))
      comment: "Total scheduled run time in minutes — measures productive time commitment across the schedule."
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(setup_time_minutes AS DOUBLE))
      comment: "Total setup time in minutes — measures changeover burden; high values indicate opportunities for SMED improvement."
    - name: "total_slack_time_minutes"
      expr: SUM(CAST(slack_time_minutes AS DOUBLE))
      comment: "Total slack time in minutes — measures scheduling buffer; low slack indicates high schedule risk and limited recovery capacity."
    - name: "released_to_mes_rate"
      expr: ROUND(COUNT(CASE WHEN released_to_mes_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of scheduled operations released to MES — measures schedule execution readiness and planning-to-execution conversion."
    - name: "avg_queue_time_minutes"
      expr: AVG(CAST(queue_time_minutes AS DOUBLE))
      comment: "Average queue time per scheduled operation — high queue times indicate bottlenecks and WIP accumulation points."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost of scheduled production — the planned cost commitment used for production cost variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planning exception KPIs — tracks exception volume, financial impact, and resolution performance to drive supply planner prioritization."
  source: "`vibe_manufacturing_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of planning exception (late delivery, capacity overload, stockout risk) for categorizing supply planning issues."
    - name: "exception_status"
      expr: exception_status
      comment: "Status of the exception (open, resolved, escalated) for tracking resolution progress."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the exception (critical, high, medium, low) for prioritizing planner response."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating the exception has been escalated — used to filter high-priority supply issues."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the exception for site-level exception analysis."
    - name: "exception_date"
      expr: DATE_TRUNC('week', exception_date)
      comment: "Week bucket of the exception date for time-series exception volume trending."
    - name: "demand_source"
      expr: demand_source
      comment: "Source of the demand driving the exception (sales order, forecast, safety stock) for root cause analysis."
  measures:
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost impact of planning exceptions — the aggregate monetary exposure from supply planning failures."
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total quantity affected by planning exceptions — measures the volume of supply at risk from planning issues."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'open' THEN 1 END)
      comment: "Count of open planning exceptions — the primary workload metric for supply planners; high counts indicate systemic planning issues."
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated exceptions — measures the volume of supply issues requiring management intervention."
    - name: "avg_available_stock_quantity"
      expr: AVG(CAST(available_stock_quantity AS DOUBLE))
      comment: "Average available stock quantity at time of exception — used to assess buffer adequacy against exception events."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity at time of exception — compared against available stock to assess policy adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy KPIs — evaluates policy coverage, service level targets, and inventory investment to optimize the balance between service and working capital."
  source: "`vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for segmenting safety stock policy by material value tier."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for combined ABC-XYZ safety stock policy analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (statistical, days-of-supply, fixed) for policy approach analysis."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type for analyzing safety stock policy by replenishment strategy."
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the safety stock policy (active, under review, expired) for filtering current policies."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant location for site-level safety stock policy analysis."
    - name: "criticality_code"
      expr: criticality_code
      comment: "Material criticality code for prioritizing safety stock investment in critical components."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all policies — the aggregate buffer inventory investment for service level protection."
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage — the policy-level customer service commitment used to evaluate safety stock adequacy."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across policies — the aggregate replenishment trigger level for inventory management."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient — measures demand uncertainty driving safety stock requirements; high values indicate volatile demand."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — measures supplier reliability impact on safety stock requirements."
    - name: "avg_holding_cost_percent_annual"
      expr: AVG(CAST(holding_cost_percent_annual AS DOUBLE))
      comment: "Average annual holding cost percentage — used to calculate the working capital cost of safety stock policies."
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit — used to evaluate the cost-benefit tradeoff of safety stock investment levels."
    - name: "avg_moq_minimum_order_quantity"
      expr: AVG(CAST(moq_minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across policies — measures procurement constraint impact on safety stock and inventory levels."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sourcing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing rule KPIs — evaluates sourcing strategy coverage, supplier preference, and procurement parameter health to steer strategic sourcing decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`sourcing_rule`"
  dimensions:
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing rule (external purchase, in-house production, subcontracting) for make-vs-buy analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the sourcing rule (active, expired, pending) for filtering current sourcing strategies."
    - name: "sourcing_priority"
      expr: sourcing_priority
      comment: "Priority of the sourcing rule for analyzing primary vs. secondary sourcing strategy distribution."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level associated with the sourcing rule for risk-adjusted sourcing analysis."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flag indicating preferred supplier status — used to analyze preferred vs. non-preferred sourcing split."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make-or-buy indicator for analyzing the production vs. procurement sourcing balance."
    - name: "valid_from_date"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year bucket of the sourcing rule effective date for analyzing sourcing strategy evolution over time."
  measures:
    - name: "total_active_sourcing_rules"
      expr: COUNT(CASE WHEN rule_status = 'active' THEN 1 END)
      comment: "Count of active sourcing rules — measures the breadth of the sourcing strategy portfolio."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across sourcing rules — measures the typical supply split across sources for multi-sourcing analysis."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across sourcing rules — measures procurement constraint burden on inventory and cash flow."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across sourcing rules — the baseline cost benchmark for procurement performance and variance analysis."
    - name: "preferred_supplier_rule_rate"
      expr: ROUND(COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of sourcing rules using preferred suppliers — measures strategic supplier relationship utilization."
    - name: "automatic_po_rule_rate"
      expr: ROUND(COUNT(CASE WHEN automatic_po_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of sourcing rules with automatic PO creation — measures procurement automation coverage and efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_material_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requirement KPIs — tracks net requirements, procurement coverage, and exception exposure to drive MRP-driven procurement and production decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`material_requirement`"
  dimensions:
    - name: "mrp_element_type"
      expr: mrp_element_type
      comment: "MRP element type (planned order, purchase requisition, production order) for analyzing requirement coverage by supply element."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the material requirement (open, covered, partially covered) for supply gap analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (external, in-house) for make-vs-buy requirement analysis."
    - name: "requirement_priority"
      expr: requirement_priority
      comment: "Priority of the material requirement for analyzing high-priority supply gaps."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the material requirement for site-level demand analysis."
    - name: "requirement_date"
      expr: DATE_TRUNC('week', requirement_date)
      comment: "Week bucket of the requirement date for time-phased demand analysis."
    - name: "exception_message_code"
      expr: exception_message_code
      comment: "Exception message code for categorizing MRP planning issues by type."
  measures:
    - name: "total_gross_requirement_quantity"
      expr: SUM(CAST(gross_requirement_quantity AS DOUBLE))
      comment: "Total gross material requirement quantity — the aggregate demand signal before netting against available stock."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirement quantity — the uncovered demand requiring procurement or production action."
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total planned order quantity proposed to cover requirements — measures MRP supply proposal coverage."
    - name: "total_scheduled_receipt_quantity"
      expr: SUM(CAST(scheduled_receipt_quantity AS DOUBLE))
      comment: "Total scheduled receipt quantity — the confirmed inbound supply used to assess coverage against net requirements."
    - name: "avg_projected_available_balance"
      expr: AVG(CAST(projected_available_balance AS DOUBLE))
      comment: "Average projected available balance — the forward-looking stock position used to identify future stockout risks."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across material requirements — the buffer stock investment for service level protection."
    - name: "requirement_coverage_rate"
      expr: ROUND(SUM(CAST(planned_order_quantity AS DOUBLE)) / NULLIF(SUM(CAST(net_requirement_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of planned order quantity to net requirement quantity — measures how well MRP proposals cover uncovered demand."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key supply planning KPIs that drive capacity and demand alignment decisions"
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the plan is executed"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan (e.g., Approved, Draft)"
    - name: "plan_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of plan creation for time‑based analysis"
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total quantity of supply that has been planned across all plans"
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity associated with the plan"
    - name: "average_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization % across plans"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance % between planned supply and forecasted demand"
$$;