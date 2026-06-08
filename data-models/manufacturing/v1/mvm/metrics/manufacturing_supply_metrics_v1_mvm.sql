-- Metric views for domain: supply | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs measuring work-center load, utilization, overload/underload exposure, and efficiency across planning horizons. Used by supply planners and operations VPs to identify bottlenecks, rebalance capacity, and drive leveling decisions."
  source: "`manufacturing_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan (e.g., draft, approved, released) for pipeline visibility."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month-truncated planning period start date for time-series capacity trend analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and volume KPIs used by supply chain planners, S&OP leaders, and commercial teams to assess forecast quality, bias, and demand signal reliability across products, customers, and planning horizons."
  source: "`manufacturing_ecm`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Name of the statistical or ML forecast model used, enabling model performance benchmarking."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g., draft, approved, consumed) for pipeline and governance tracking."
    - name: "demand_class"
      expr: demand_class
      comment: "Demand classification (e.g., independent, dependent, promotional) for segmented forecast analysis."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Demand pattern type (e.g., seasonal, intermittent, trend) to contextualize forecast model selection."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage (e.g., introduction, growth, maturity, decline) for lifecycle-adjusted forecast review."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Forecast scenario (e.g., base, upside, downside) for scenario-based planning and risk assessment."
    - name: "version_type"
      expr: version_type
      comment: "Version type of the forecast (e.g., statistical, consensus, final) to track S&OP process stage."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month-truncated planning period start for time-series forecast volume and accuracy trending."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the forecast includes a promotional uplift, enabling baseline vs. promoted demand split."
    - name: "outlier_flag"
      expr: outlier_flag
      comment: "Flags forecast records identified as statistical outliers, supporting data quality governance."
    - name: "planning_group_code"
      expr: planning_group_code
      comment: "Planning group code for aggregated demand planning by product family or business unit."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity across all records. Primary volume signal for supply planning and capacity alignment."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy (%) across forecast records. Core S&OP KPI; low accuracy drives safety stock increases and service level risk."
    - name: "avg_mean_absolute_percentage_error"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average MAPE across forecasts. Standard industry measure of forecast error magnitude; used to benchmark and improve forecasting models."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias (%). Persistent positive or negative bias signals systematic over- or under-forecasting, driving inventory imbalance."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total manual sales adjustments applied to statistical forecasts. High adjustment volumes indicate low model trust and drive model recalibration."
    - name: "avg_promotional_uplift_percent"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional uplift percentage applied to forecasts. Quantifies the demand lift attributed to promotions for trade planning ROI analysis."
    - name: "avg_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Lower confidence signals higher demand uncertainty and informs safety stock policy adjustments."
    - name: "avg_seasonality_index"
      expr: AVG(CAST(seasonality_index AS DOUBLE))
      comment: "Average seasonality index across forecast records. Quantifies seasonal demand amplification for production and procurement pre-positioning."
    - name: "outlier_forecast_count"
      expr: COUNT(DISTINCT CASE WHEN outlier_flag = TRUE THEN demand_forecast_id END)
      comment: "Count of forecast records flagged as outliers. High outlier counts indicate data quality or demand volatility issues requiring planner review."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of active forecast records. Used as a denominator baseline for rate calculations and forecast coverage assessment."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_demand_plan_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand plan version governance and quality KPIs tracking forecast accuracy, bias, approval status, and planned demand volumes across planning cycles. Used by S&OP leaders to govern the demand planning process and version lifecycle."
  source: "`manufacturing_ecm`.`supply`.`demand_plan_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Status of the demand plan version (e.g., draft, approved, superseded) for lifecycle governance."
    - name: "version_type"
      expr: version_type
      comment: "Type of demand plan version (e.g., statistical, consensus, final) to track S&OP process maturity."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario associated with the demand plan version for multi-scenario planning comparison."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method used (e.g., MRP, DRP, kanban) to segment plan versions by methodology."
    - name: "approved_flag"
      expr: approved_flag
      comment: "Indicates whether the demand plan version has been formally approved, supporting governance tracking."
    - name: "baseline_version_flag"
      expr: baseline_version_flag
      comment: "Flags the baseline version for each planning cycle, enabling baseline vs. revision comparison."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month-truncated planning horizon start date for time-phased demand plan volume trending."
    - name: "forecast_model_code"
      expr: forecast_model_code
      comment: "Forecast model code used in this plan version for model performance benchmarking."
  measures:
    - name: "total_planned_demand_quantity"
      expr: SUM(CAST(total_planned_demand_quantity AS DOUBLE))
      comment: "Total planned demand quantity across all demand plan versions. Primary volume signal for supply and capacity alignment in S&OP."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy (%) across demand plan versions. Core S&OP governance KPI; tracks improvement over planning cycles."
    - name: "avg_bias_percentage"
      expr: AVG(CAST(bias_percentage AS DOUBLE))
      comment: "Average demand plan bias (%). Persistent bias indicates systematic over- or under-planning, driving inventory and service level risk."
    - name: "avg_confidence_level_percentage"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average confidence level (%) of demand plan versions. Lower confidence signals higher uncertainty and informs risk buffer decisions."
    - name: "approved_version_count"
      expr: COUNT(DISTINCT CASE WHEN approved_flag = TRUE THEN demand_plan_version_id END)
      comment: "Count of formally approved demand plan versions. Tracks S&OP governance compliance and approval cycle throughput."
    - name: "total_version_count"
      expr: COUNT(1)
      comment: "Total number of demand plan versions. Used as denominator for approval rate and as a measure of planning iteration volume."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approved_flag = TRUE THEN demand_plan_version_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demand plan versions that have been approved. Measures S&OP process discipline and governance effectiveness."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_material_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP-driven material requirement KPIs covering net/gross requirement volumes, planned order quantities, safety stock coverage, and exception exposure. Used by supply planners and procurement teams to manage material availability and MRP exception resolution."
  source: "`manufacturing_ecm`.`supply`.`material_requirement`"
  dimensions:
    - name: "mrp_element_type"
      expr: mrp_element_type
      comment: "Type of MRP element (e.g., planned order, purchase requisition, production order) for supply element analysis."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the material requirement (e.g., open, firmed, converted) for pipeline and action tracking."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house, external, subcontracting) for make-vs-buy analysis."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the material for prioritized planning and inventory management focus."
    - name: "requirement_priority"
      expr: requirement_priority
      comment: "Priority of the material requirement for scheduling and expediting decisions."
    - name: "exception_message_code"
      expr: exception_message_code
      comment: "MRP exception message code (e.g., reschedule in, cancel, expedite) for exception-driven action management."
    - name: "lot_size_key"
      expr: lot_size_key
      comment: "Lot sizing rule applied to the requirement for procurement and production batch analysis."
    - name: "requirement_date"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month-truncated requirement date for time-phased demand and supply gap trending."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the material, enabling workload and accountability analysis."
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement type (e.g., consignment, third-party) for non-standard supply channel analysis."
  measures:
    - name: "total_gross_requirement_quantity"
      expr: SUM(CAST(gross_requirement_quantity AS DOUBLE))
      comment: "Total gross material requirement quantity before netting. Represents total demand signal from MRP explosion."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirement quantity after netting against available stock and receipts. Primary procurement and production trigger volume."
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total quantity of planned orders generated by MRP. Drives procurement and production scheduling workload."
    - name: "total_scheduled_receipt_quantity"
      expr: SUM(CAST(scheduled_receipt_quantity AS DOUBLE))
      comment: "Total scheduled receipt quantity (open POs, production orders). Measures inbound supply pipeline coverage against requirements."
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Total projected available balance across all material requirements. Negative values signal stockout risk requiring immediate action."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held across all material requirements. Quantifies the buffer investment protecting service levels."
    - name: "exception_message_count"
      expr: COUNT(DISTINCT CASE WHEN exception_message_code IS NOT NULL AND exception_message_code <> '' THEN material_requirement_id END)
      comment: "Count of material requirements with active MRP exception messages. High exception counts signal planning instability and drive planner workload."
    - name: "net_to_gross_requirement_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_requirement_quantity AS DOUBLE)) / NULLIF(SUM(CAST(gross_requirement_quantity AS DOUBLE)), 0), 2)
      comment: "Ratio of net to gross requirements (%). Low ratios indicate high stock coverage; high ratios signal inventory shortfalls and procurement urgency."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across materials. Benchmarks replenishment trigger levels for policy review and optimization."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP run execution and quality KPIs tracking planning run performance, exception volumes, and planned order outcomes. Used by supply chain IT and planning managers to govern MRP process health, run frequency, and output quality."
  source: "`manufacturing_ecm`.`supply`.`mrp_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the MRP run (e.g., completed, failed, in-progress) for run health monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (e.g., regenerative, net change) to distinguish full vs. incremental planning cycles."
    - name: "planning_mode"
      expr: planning_mode
      comment: "Planning mode used in the MRP run (e.g., forward, backward scheduling) for methodology analysis."
    - name: "lot_sizing_rule"
      expr: lot_sizing_rule
      comment: "Lot sizing rule applied during the MRP run for batch policy analysis."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method used (e.g., lead-time, capacity-based) for planning approach benchmarking."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month-truncated planning horizon start date for time-phased MRP run volume and quality trending."
    - name: "include_forecast_flag"
      expr: include_forecast_flag
      comment: "Indicates whether forecast demand was included in the MRP run, enabling forecast-driven vs. order-driven run comparison."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP system code for multi-system MRP run governance and reconciliation."
  measures:
    - name: "total_mrp_runs"
      expr: COUNT(1)
      comment: "Total number of MRP runs executed. Baseline measure for run frequency and planning cadence governance."
    - name: "successful_run_count"
      expr: COUNT(DISTINCT CASE WHEN run_status = 'COMPLETED' THEN mrp_run_id END)
      comment: "Count of successfully completed MRP runs. Tracks planning process reliability and system stability."
    - name: "failed_run_count"
      expr: COUNT(DISTINCT CASE WHEN run_status = 'FAILED' THEN mrp_run_id END)
      comment: "Count of failed MRP runs. Failed runs leave supply plans stale and create material shortage risk; drives IT escalation."
    - name: "mrp_run_success_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN run_status = 'COMPLETED' THEN mrp_run_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MRP runs that completed successfully. Core system reliability KPI for supply chain IT governance."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply plan performance KPIs covering demand-supply balance, capacity utilization, safety stock adequacy, and plan variance. Used by supply chain VPs and S&OP leaders to govern plan quality, identify supply risk, and drive corrective actions."
  source: "`manufacturing_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the supply plan (e.g., draft, approved, released) for pipeline and governance tracking."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method used (e.g., MRP, kanban, reorder point) for methodology-based plan performance comparison."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "Planning strategy (e.g., make-to-stock, make-to-order, assemble-to-order) for strategy-level supply analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house, external) for make-vs-buy supply plan analysis."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assigned to the plan (e.g., low, medium, high, critical) for risk-tiered management."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group code for commodity-level supply plan aggregation and analysis."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month-truncated planning period start date for time-series supply plan volume and variance trending."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure applied (e.g., fixed lot, economic order quantity) for batch policy analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP system code for multi-system supply plan reconciliation."
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total planned supply quantity across all plans. Primary supply-side volume signal for demand-supply balance analysis."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total demand forecast quantity embedded in supply plans. Used alongside planned supply to compute demand-supply gap."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between planned supply and demand. Positive variance = oversupply risk; negative = shortage risk. Core S&OP balancing KPI."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average plan variance percentage. Measures plan accuracy and demand-supply alignment quality across the planning portfolio."
    - name: "avg_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage across supply plans. Drives investment decisions in capacity expansion or reduction."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned across all supply plans. Quantifies the working capital tied up in buffer inventory."
    - name: "high_risk_plan_count"
      expr: COUNT(DISTINCT CASE WHEN supply_risk_level IN ('HIGH', 'CRITICAL') THEN plan_id END)
      comment: "Count of supply plans flagged as high or critical risk. Directly informs executive escalation and supply risk mitigation prioritization."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across supply plans. Benchmarks replenishment trigger levels for policy optimization."
    - name: "supply_demand_coverage_ratio"
      expr: ROUND(SUM(CAST(planned_supply_quantity AS DOUBLE)) / NULLIF(SUM(CAST(demand_forecast_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of total planned supply to total demand forecast. Values below 1.0 signal supply shortfall; above 1.0 signal overstock risk. Key S&OP balance KPI."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order execution KPIs covering order volumes, supply risk, capacity load, lead times, and firming status. Used by supply planners, procurement managers, and operations VPs to manage the planned order portfolio and convert supply proposals into executable orders."
  source: "`manufacturing_ecm`.`supply`.`planned_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g., purchase, production, transfer) for supply channel analysis."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Status of the planned order proposal (e.g., open, firmed, converted, cancelled) for pipeline management."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Indicates whether the planned order has been firmed, distinguishing MRP-generated from planner-committed orders."
    - name: "lot_size_rule"
      expr: lot_size_rule
      comment: "Lot sizing rule applied to the planned order for batch policy analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the planned order for scheduling and expediting prioritization."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code on the planned order (e.g., reschedule, cancel, expedite) for exception-driven action management."
    - name: "multi_tier_supplier_flag"
      expr: multi_tier_supplier_flag
      comment: "Flags orders involving multi-tier supplier networks, indicating higher supply chain complexity and risk."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month-truncated scheduled start date for time-phased planned order volume and capacity load trending."
    - name: "requirement_date"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month-truncated requirement date for demand-driven planned order time-series analysis."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the planned order, enabling workload and accountability analysis."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned order quantity across all proposals. Primary supply volume signal for procurement and production scheduling."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity overridden by planners from MRP-generated proposals. High override volumes indicate low MRP plan trust and drive model recalibration."
    - name: "total_moq_quantity"
      expr: SUM(CAST(moq_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments across planned orders. Quantifies MOQ-driven over-procurement exposure and working capital impact."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders. Aggregated risk signal used by supply chain leadership to prioritize mitigation actions."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required by planned orders. Used to validate capacity plan adequacy and identify overload risk."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours associated with planned orders. Compared against required hours to compute capacity gap at order level."
    - name: "firmed_order_count"
      expr: COUNT(DISTINCT CASE WHEN firming_indicator = TRUE THEN planned_order_id END)
      comment: "Count of firmed planned orders. Tracks the proportion of the supply plan that is committed and protected from MRP re-planning."
    - name: "exception_order_count"
      expr: COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN planned_order_id END)
      comment: "Count of planned orders with active exception messages. High exception counts signal planning instability and drive planner action queues."
    - name: "firming_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN firming_indicator = TRUE THEN planned_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned orders that have been firmed. Measures supply plan stability and planner execution discipline."
    - name: "capacity_load_ratio"
      expr: ROUND(SUM(CAST(required_capacity_hours AS DOUBLE)) / NULLIF(SUM(CAST(available_capacity_hours AS DOUBLE)), 0), 4)
      comment: "Ratio of required to available capacity hours across planned orders. Values above 1.0 signal overload; used to trigger capacity leveling actions."
    - name: "high_risk_order_count"
      expr: COUNT(DISTINCT CASE WHEN supply_risk_score > 7.0 THEN planned_order_id END)
      comment: "Count of planned orders with supply risk score above 7.0 (high risk threshold). Directly informs procurement escalation and dual-sourcing decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy KPIs measuring buffer inventory levels, service level targets, demand and lead time variability, and holding cost exposure. Used by supply chain planners and inventory managers to optimize buffer policies and balance service levels against working capital."
  source: "`manufacturing_ecm`.`supply`.`safety_stock_policy`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material (A=high value, B=medium, C=low) for tiered safety stock policy management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification of demand variability (X=stable, Y=variable, Z=irregular) for demand-risk-adjusted buffer policies."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g., statistical, fixed, days-of-supply) for methodology benchmarking."
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the safety stock policy (e.g., active, inactive, under review) for policy governance."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house, external) for make-vs-buy safety stock analysis."
    - name: "criticality_code"
      expr: criticality_code
      comment: "Criticality code of the material (e.g., critical, standard, non-critical) for risk-tiered buffer management."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP type applied to the material for planning method-based safety stock analysis."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month-truncated effective from date for time-series safety stock policy evolution tracking."
    - name: "coverage_profile"
      expr: coverage_profile
      comment: "Coverage profile assigned to the material for demand-coverage-based buffer segmentation."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all active policies. Quantifies total buffer inventory investment and working capital exposure."
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target (%) across safety stock policies. Benchmarks the organization's customer service ambition and its cost implications."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across materials. Higher values indicate more volatile demand requiring larger safety buffers."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability (days) across supplier-material combinations. Key driver of safety stock sizing; high variability increases buffer requirements."
    - name: "total_holding_cost_exposure"
      expr: SUM(CAST(holding_cost_percent_annual AS DOUBLE) * CAST(safety_stock_quantity AS DOUBLE) / 100.0)
      comment: "Estimated annual holding cost exposure from safety stock (holding cost % × quantity). Quantifies the financial cost of buffer inventory for working capital optimization."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across safety stock policies. Benchmarks replenishment trigger levels for policy review and optimization."
    - name: "avg_average_daily_demand"
      expr: AVG(CAST(average_daily_demand AS DOUBLE))
      comment: "Average daily demand rate across materials with safety stock policies. Used to contextualize safety stock levels in terms of days-of-supply coverage."
    - name: "total_stockout_cost_exposure"
      expr: SUM(CAST(stockout_cost_per_unit AS DOUBLE) * CAST(safety_stock_quantity AS DOUBLE))
      comment: "Estimated stockout cost exposure (stockout cost per unit × safety stock quantity). Quantifies the financial risk being mitigated by current buffer levels."
    - name: "policy_count_active"
      expr: COUNT(DISTINCT CASE WHEN policy_status = 'ACTIVE' THEN safety_stock_policy_id END)
      comment: "Count of active safety stock policies. Tracks policy coverage breadth across the material portfolio."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supply_sourcing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing rule portfolio KPIs measuring supplier allocation, MOQ exposure, pricing, lead times, and supply risk across the approved vendor base. Used by procurement managers and supply chain VPs to govern sourcing strategy, dual-sourcing coverage, and supplier risk."
  source: "`manufacturing_ecm`.`supply`.`sourcing_rule`"
  dimensions:
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing rule (e.g., single-source, dual-source, spot buy) for supply risk and resilience analysis."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make-or-buy decision indicator for strategic sourcing portfolio analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the sourcing rule (e.g., active, inactive, pending approval) for governance and coverage tracking."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assigned to the sourcing rule (e.g., low, medium, high, critical) for risk-tiered management."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flags preferred supplier sourcing rules, enabling preferred vs. non-preferred supplier spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms applied to the sourcing rule for logistics cost and risk allocation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing rule for multi-currency procurement cost analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the sourcing rule for organizational spend governance."
    - name: "valid_from_date"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month-truncated valid from date for sourcing rule portfolio evolution and contract renewal tracking."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure applied in the sourcing rule for procurement batch policy analysis."
  measures:
    - name: "total_active_sourcing_rules"
      expr: COUNT(DISTINCT CASE WHEN rule_status = 'ACTIVE' THEN sourcing_rule_id END)
      comment: "Count of active sourcing rules. Measures the breadth of governed sourcing coverage across the material and supplier portfolio."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average supplier allocation percentage across sourcing rules. Identifies concentration risk where single suppliers hold disproportionate allocation."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across sourcing rules. Benchmarks procurement cost levels and supports price variance analysis."
    - name: "total_moq_exposure"
      expr: SUM(CAST(moq AS DOUBLE))
      comment: "Total minimum order quantity commitments across sourcing rules. Quantifies MOQ-driven over-procurement risk and working capital lock-up."
    - name: "avg_fixed_lot_size"
      expr: AVG(CAST(fixed_lot_size AS DOUBLE))
      comment: "Average fixed lot size across sourcing rules. Informs procurement batch efficiency and inventory build-up risk from large fixed lots."
    - name: "high_risk_sourcing_rule_count"
      expr: COUNT(DISTINCT CASE WHEN supply_risk_level IN ('HIGH', 'CRITICAL') THEN sourcing_rule_id END)
      comment: "Count of sourcing rules flagged as high or critical supply risk. Directly informs dual-sourcing investment and supply resilience strategy."
    - name: "preferred_supplier_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN preferred_supplier_flag = TRUE THEN sourcing_rule_id END) / NULLIF(COUNT(DISTINCT CASE WHEN rule_status = 'ACTIVE' THEN sourcing_rule_id END), 0), 2)
      comment: "Percentage of active sourcing rules assigned to preferred suppliers. Measures preferred supplier program penetration and strategic sourcing discipline."
    - name: "automatic_po_rule_count"
      expr: COUNT(DISTINCT CASE WHEN automatic_po_flag = TRUE THEN sourcing_rule_id END)
      comment: "Count of sourcing rules with automatic PO generation enabled. Tracks procurement automation coverage and touchless ordering efficiency."
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity across sourcing rules. Benchmarks order size caps and their impact on procurement flexibility and inventory risk."
$$;