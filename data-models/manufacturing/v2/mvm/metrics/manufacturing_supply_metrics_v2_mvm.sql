-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs measuring utilization, overload/underload exposure, efficiency, and bottleneck risk across work centers and planning periods. Drives decisions on capacity investment, shift scheduling, and constraint resolution."
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan (e.g., draft, approved, active) for governance filtering."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the planning period start date for trend analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and volume KPIs. Measures forecast quality, bias, and demand volume to drive S&OP decisions, inventory positioning, and production planning."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Name of the forecasting model used, enabling model performance benchmarking."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g., draft, approved, consumed) for governance filtering."
    - name: "demand_class"
      expr: demand_class
      comment: "Classification of demand type (e.g., independent, dependent) for segmented planning analysis."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Demand pattern (e.g., seasonal, trend, lumpy) for model selection and safety stock calibration."
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment driving the forecast, enabling revenue-weighted accuracy analysis."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage (e.g., launch, growth, decline) for lifecycle-adjusted forecasting."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the forecast planning period for trend and seasonality analysis."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario label (e.g., base, optimistic, pessimistic) for scenario-based planning comparisons."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the forecast includes a promotional uplift, enabling baseline vs. promotional demand separation."
    - name: "outlier_flag"
      expr: outlier_flag
      comment: "Flags forecast records identified as statistical outliers, enabling data quality governance."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted demand quantity. Primary volume KPI for production and procurement planning."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage. Core S&OP KPI; low accuracy drives excess inventory or stockouts and triggers model review."
    - name: "avg_mean_absolute_percentage_error"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average MAPE across forecasts. Industry-standard forecast error metric used to benchmark and select forecasting models."
    - name: "avg_bias_percent"
      expr: AVG(CAST(bias_percent AS DOUBLE))
      comment: "Average forecast bias percentage. Persistent positive or negative bias signals systematic over- or under-forecasting requiring process correction."
    - name: "total_sales_adjustment_quantity"
      expr: SUM(CAST(sales_adjustment_quantity AS DOUBLE))
      comment: "Total manual sales adjustments applied to statistical forecasts. High values indicate low model trust and drive investment in better forecasting tools."
    - name: "avg_promotional_uplift_percent"
      expr: AVG(CAST(promotional_uplift_percent AS DOUBLE))
      comment: "Average promotional uplift percentage applied to forecasts. Informs trade promotion ROI and demand shaping strategy."
    - name: "avg_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Low confidence drives safety stock increases and supply buffer decisions."
    - name: "outlier_forecast_count"
      expr: COUNT(CASE WHEN outlier_flag = TRUE THEN demand_forecast_id END)
      comment: "Number of forecast records flagged as outliers. High counts signal data quality issues that degrade planning accuracy."
    - name: "avg_seasonality_index"
      expr: AVG(CAST(seasonality_index AS DOUBLE))
      comment: "Average seasonality index across forecasts. Informs seasonal inventory build strategies and capacity pre-positioning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_plan_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand plan version governance and quality KPIs. Tracks planning accuracy, version lifecycle, and consensus process health to support S&OP governance and continuous improvement."
  source: "`vibe_manufacturing_v1`.`supply`.`demand_plan_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Status of the demand plan version (e.g., draft, approved, superseded) for governance lifecycle tracking."
    - name: "version_type"
      expr: version_type
      comment: "Type of version (e.g., baseline, revision, scenario) for version classification analysis."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method used (e.g., statistical, consensus, judgmental) for method effectiveness benchmarking."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario label for multi-scenario S&OP comparison."
    - name: "approved_flag"
      expr: approved_flag
      comment: "Indicates whether the version has been formally approved, enabling governance compliance tracking."
    - name: "baseline_version_flag"
      expr: baseline_version_flag
      comment: "Flags the baseline version for each planning cycle, enabling baseline vs. revision comparison."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month bucket of the planning horizon start for trend analysis of plan quality over time."
    - name: "forecast_model_code"
      expr: forecast_model_code
      comment: "Forecasting model code used in this version for model performance benchmarking."
  measures:
    - name: "total_planned_demand_quantity"
      expr: SUM(CAST(total_planned_demand_quantity AS DOUBLE))
      comment: "Total planned demand quantity across all versions. Primary volume KPI for production and procurement alignment."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across plan versions. Core S&OP governance KPI; tracks improvement over planning cycles."
    - name: "avg_bias_percentage"
      expr: AVG(CAST(bias_percentage AS DOUBLE))
      comment: "Average bias percentage across plan versions. Persistent bias signals systematic planning errors requiring process intervention."
    - name: "avg_confidence_level_percentage"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average confidence level of demand plan versions. Low confidence drives safety stock and supply buffer decisions."
    - name: "approved_version_count"
      expr: COUNT(CASE WHEN approved_flag = TRUE THEN demand_plan_version_id END)
      comment: "Number of formally approved demand plan versions. Tracks S&OP governance compliance and approval cycle velocity."
    - name: "total_version_count"
      expr: COUNT(1)
      comment: "Total number of demand plan versions created. High revision counts signal planning instability and process improvement needs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_material_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP material requirement KPIs measuring net/gross requirement volumes, safety stock adequacy, exception rates, and procurement lead time compliance. Drives procurement, production scheduling, and inventory policy decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`material_requirement`"
  dimensions:
    - name: "mrp_element_type"
      expr: mrp_element_type
      comment: "Type of MRP element (e.g., planned order, purchase requisition, production order) for supply element analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house, external, subcontracting) for make-vs-buy analysis."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the material requirement (e.g., open, firmed, converted) for pipeline visibility."
    - name: "requirement_priority"
      expr: requirement_priority
      comment: "Priority of the requirement for triage and expediting decisions."
    - name: "exception_message_code"
      expr: exception_message_code
      comment: "MRP exception code (e.g., reschedule in, reschedule out, cancel) for exception-driven action management."
    - name: "requirement_date"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month bucket of the material requirement date for demand pipeline trend analysis."
    - name: "lot_size_key"
      expr: lot_size_key
      comment: "Lot sizing rule applied to the requirement for policy effectiveness analysis."
    - name: "special_procurement_type"
      expr: special_procurement_type
      comment: "Special procurement type (e.g., consignment, third-party) for supply strategy segmentation."
  measures:
    - name: "total_gross_requirement_quantity"
      expr: SUM(CAST(gross_requirement_quantity AS DOUBLE))
      comment: "Total gross material requirement quantity before netting. Primary demand volume KPI for procurement and production planning."
    - name: "total_net_requirement_quantity"
      expr: SUM(CAST(net_requirement_quantity AS DOUBLE))
      comment: "Total net material requirement quantity after netting against available stock. Drives actual procurement and production order creation."
    - name: "total_planned_order_quantity"
      expr: SUM(CAST(planned_order_quantity AS DOUBLE))
      comment: "Total quantity in planned orders generated by MRP. Measures supply response volume to net requirements."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all material requirements. Informs working capital tied up in buffer inventory."
    - name: "total_projected_available_balance"
      expr: SUM(CAST(projected_available_balance AS DOUBLE))
      comment: "Total projected available balance across requirements. Negative values signal stockout risk requiring immediate supply action."
    - name: "exception_message_count"
      expr: COUNT(CASE WHEN exception_message_code IS NOT NULL AND exception_message_code <> '' THEN material_requirement_id END)
      comment: "Number of MRP exception messages generated. High exception counts signal planning instability and drive planner workload and process improvement decisions."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across requirements. Informs supplier negotiation strategy and inventory carrying cost optimization."
    - name: "total_scheduled_receipt_quantity"
      expr: SUM(CAST(scheduled_receipt_quantity AS DOUBLE))
      comment: "Total scheduled receipt quantity (open POs, production orders) covering requirements. Measures supply pipeline coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP run performance and quality KPIs measuring planning cycle efficiency, exception volume, and planning output quality. Drives decisions on MRP configuration, planning frequency, and system performance investment."
  source: "`vibe_manufacturing_v1`.`supply`.`mrp_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of MRP run (e.g., regenerative, net change) for run strategy analysis."
    - name: "run_status"
      expr: run_status
      comment: "Status of the MRP run (e.g., completed, failed, in-progress) for reliability monitoring."
    - name: "planning_mode"
      expr: planning_mode
      comment: "Planning mode used in the run for configuration benchmarking."
    - name: "scheduling_method"
      expr: scheduling_method
      comment: "Scheduling method applied (e.g., forward, backward) for method effectiveness analysis."
    - name: "lot_sizing_rule"
      expr: lot_sizing_rule
      comment: "Lot sizing rule applied during the MRP run for policy impact analysis."
    - name: "planning_horizon_start_date"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month bucket of the planning horizon start for run frequency and trend analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that initiated the MRP run for multi-system environment governance."
  measures:
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average MRP run duration in minutes. System performance KPI; increasing run times signal data volume growth or configuration issues requiring IT investment."
    - name: "total_run_duration_minutes"
      expr: SUM(CAST(run_duration_minutes AS DOUBLE))
      comment: "Total MRP run duration across all runs. Measures cumulative planning system load and infrastructure cost."
    - name: "failed_run_count"
      expr: COUNT(CASE WHEN run_status = 'FAILED' THEN mrp_run_id END)
      comment: "Number of failed MRP runs. Failed runs leave the supply plan stale and create downstream procurement and production risk."
    - name: "total_mrp_run_count"
      expr: COUNT(1)
      comment: "Total number of MRP runs executed. Baseline for run frequency governance and planning cycle cadence analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply plan KPIs measuring planned supply volumes, capacity utilization, safety stock adequacy, and plan variance. Core S&OP metrics used by supply chain leadership to balance supply and demand."
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the supply plan (e.g., draft, approved, active) for governance lifecycle tracking."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method applied (e.g., MRP, kanban, reorder point) for method effectiveness benchmarking."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g., in-house, external) for make-vs-buy supply analysis."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assigned to the plan for risk-tiered supply management."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group for commodity-level supply planning analysis."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month bucket of the planning period start for supply volume trend analysis."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure applied for policy impact and inventory optimization analysis."
    - name: "mrp_controller_code"
      expr: mrp_controller_code
      comment: "MRP controller responsible for the plan for accountability and workload analysis."
  measures:
    - name: "total_planned_supply_quantity"
      expr: SUM(CAST(planned_supply_quantity AS DOUBLE))
      comment: "Total planned supply quantity. Primary supply volume KPI for demand coverage analysis in S&OP."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total demand forecast quantity embedded in supply plans. Enables supply-demand gap analysis at the plan level."
    - name: "avg_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage across supply plans. Core operational KPI; drives shift scheduling and capital investment decisions."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across plans. Measures working capital tied up in buffer inventory; informs inventory policy optimization."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average plan variance percentage (actual vs. planned). High variance signals planning accuracy issues requiring process or model improvement."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total supply plan variance quantity. Measures absolute supply-demand imbalance volume driving expediting or cancellation costs."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN supply_risk_level = 'HIGH' THEN plan_id END)
      comment: "Number of supply plans flagged as high risk. Executives use this to prioritize supply risk mitigation and dual-sourcing decisions."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across plans. Informs inventory policy calibration and working capital optimization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order KPIs measuring supply proposal volume, capacity coverage, risk exposure, and planner override activity. Drives procurement, production scheduling, and supply risk management decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g., purchase, production, transfer) for supply mode analysis."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Status of the planned order proposal (e.g., open, firmed, converted) for pipeline governance."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code on the planned order (e.g., reschedule, cancel, expedite) for exception-driven action management."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Indicates whether the planned order has been firmed, enabling firmed vs. unfirmed supply analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the planned order for triage and expediting decisions."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled start date for supply pipeline trend analysis."
    - name: "requirement_date"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month bucket of the requirement date for demand-driven supply timing analysis."
    - name: "multi_tier_supplier_flag"
      expr: multi_tier_supplier_flag
      comment: "Flags orders involving multi-tier suppliers, enabling supply chain complexity and risk analysis."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned order quantity. Primary supply volume KPI for procurement and production planning."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total capacity hours required by planned orders. Drives capacity loading and constraint identification."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours for planned orders. Compared against required hours to identify capacity gaps."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across planned orders. High scores trigger dual-sourcing, safety stock increases, or expediting actions."
    - name: "total_planner_override_quantity"
      expr: SUM(CAST(planner_override_quantity AS DOUBLE))
      comment: "Total quantity manually overridden by planners. High override volumes signal low MRP plan trust and drive model improvement investment."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firming_indicator = TRUE THEN planned_order_id END)
      comment: "Number of firmed planned orders. Measures supply commitment level and planning stability within the planning time fence."
    - name: "exception_order_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN planned_order_id END)
      comment: "Number of planned orders with active exception messages. High counts signal planning instability and drive planner workload analysis."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across planned orders. Informs supplier negotiation strategy and lot size policy optimization."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity embedded in planned orders. Measures buffer inventory investment driven by supply uncertainty."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sourcing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing rule KPIs measuring supplier allocation, pricing, lead time, and risk exposure across the supply base. Drives strategic sourcing, supplier rationalization, and supply risk management decisions."
  source: "`vibe_manufacturing_v1`.`supply`.`sourcing_rule`"
  dimensions:
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing rule (e.g., single-source, multi-source, transfer) for supply strategy analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the sourcing rule (e.g., active, inactive, pending) for governance and compliance filtering."
    - name: "supply_risk_level"
      expr: supply_risk_level
      comment: "Supply risk level assigned to the sourcing rule for risk-tiered supplier management."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms code (e.g., FOB, CIF, DDP) for trade terms analysis and landed cost optimization."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flags preferred suppliers for preferred vs. non-preferred sourcing performance comparison."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make-or-buy decision indicator for strategic sourcing portfolio analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the sourcing rule for spend governance and compliance."
    - name: "valid_from_date"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month bucket of the sourcing rule effective date for contract lifecycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing rule for multi-currency spend and FX risk analysis."
  measures:
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average supplier allocation percentage. Measures supply concentration risk; low diversification drives dual-sourcing strategy decisions."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across sourcing rules. Baseline for price benchmarking, negotiation tracking, and cost reduction initiatives."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across sourcing rules. Informs supplier negotiation strategy and inventory carrying cost optimization."
    - name: "high_risk_sourcing_rule_count"
      expr: COUNT(CASE WHEN supply_risk_level = 'HIGH' THEN sourcing_rule_id END)
      comment: "Number of sourcing rules flagged as high supply risk. Executives use this to prioritize dual-sourcing and supply chain resilience investments."
    - name: "preferred_supplier_rule_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN sourcing_rule_id END)
      comment: "Number of sourcing rules with preferred supplier designation. Tracks preferred supplier program coverage and compliance."
    - name: "active_sourcing_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'ACTIVE' THEN sourcing_rule_id END)
      comment: "Number of currently active sourcing rules. Measures supply base breadth and sourcing policy coverage."
    - name: "avg_fixed_lot_size"
      expr: AVG(CAST(fixed_lot_size AS DOUBLE))
      comment: "Average fixed lot size across sourcing rules. Informs inventory policy and working capital optimization decisions."
$$;