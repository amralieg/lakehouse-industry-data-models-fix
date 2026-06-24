-- Metric views for domain: supply | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic demand planning KPIs including forecast accuracy, consensus vs statistical variance, and promotional overlay impact for executive S&OP steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`demand_plan`"
  dimensions:
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time granularity of the demand plan (weekly, monthly, quarterly)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (launch, growth, maturity, decline) for segmented demand analysis"
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern classification (seasonal, trending, erratic, stable) for model selection"
    - name: "approval_status"
      expr: approval_status
      comment: "Plan approval workflow status for governance tracking"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the demand plan for executive escalation"
    - name: "planning_period_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month for time-series analysis"
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Flag indicating whether this is the agreed consensus plan"
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus demand quantity across all plans - primary S&OP steering metric"
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total statistical forecast quantity before consensus adjustments"
    - name: "total_commercial_overlay"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial team adjustments to statistical baseline - measures sales intelligence impact"
    - name: "total_promotional_overlay"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional uplift quantity - measures trade promotion impact on demand"
    - name: "total_marketing_event_uplift"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total marketing campaign uplift - measures brand marketing impact on demand"
    - name: "total_npd_launch_volume"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product launch volume - critical for innovation pipeline steering"
    - name: "avg_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage - key S&OP performance indicator"
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage - detects systematic over/under forecasting"
    - name: "total_variance_to_baseline"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between consensus and statistical baseline - measures human judgment impact"
    - name: "count_risky_plans"
      expr: SUM(CASE WHEN risk_flag = true THEN 1 ELSE 0 END)
      comment: "Count of demand plans flagged as risky - executive escalation trigger"
    - name: "count_demand_plans"
      expr: COUNT(1)
      comment: "Total number of demand plan records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_forecast_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast accuracy performance metrics including MAPE, WMAPE, bias, and demand sensing effectiveness for continuous improvement steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`forecast_accuracy`"
  dimensions:
    - name: "measurement_cycle"
      expr: measurement_cycle
      comment: "Measurement cycle period (weekly, monthly, quarterly) for trend analysis"
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Statistical model type used for forecast generation"
    - name: "planning_level"
      expr: planning_level
      comment: "Planning hierarchy level (SKU, family, category) for aggregation analysis"
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Product lifecycle stage for accuracy benchmarking by maturity"
    - name: "accuracy_status"
      expr: accuracy_status
      comment: "Accuracy performance status (on-target, below-target, critical) for exception management"
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Measurement period start month for time-series trending"
    - name: "demand_sensing_applied"
      expr: demand_sensing_applied_flag
      comment: "Flag indicating whether demand sensing was applied for effectiveness comparison"
    - name: "promotional_period"
      expr: promotional_period_flag
      comment: "Flag indicating promotional period for accuracy segmentation"
  measures:
    - name: "avg_mape"
      expr: AVG(CAST(mape_percentage AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error - primary forecast accuracy KPI"
    - name: "avg_wmape"
      expr: AVG(CAST(wmape_percentage AS DOUBLE))
      comment: "Average Weighted Mean Absolute Percentage Error - volume-weighted accuracy metric"
    - name: "avg_bias"
      expr: AVG(CAST(bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage - detects systematic directional error"
    - name: "avg_absolute_percent_error"
      expr: AVG(CAST(absolute_percent_error AS DOUBLE))
      comment: "Average absolute percentage error across all forecasts"
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted quantity for volume context"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual demand quantity for accuracy calculation context"
    - name: "total_forecast_error"
      expr: SUM(CAST(forecast_error AS DOUBLE))
      comment: "Total forecast error (forecast minus actual) - measures aggregate bias"
    - name: "avg_demand_volatility"
      expr: AVG(CAST(demand_volatility_coefficient AS DOUBLE))
      comment: "Average demand volatility coefficient - explains accuracy challenges"
    - name: "avg_sensing_uplift"
      expr: AVG(CAST(sensing_uplift_percent AS DOUBLE))
      comment: "Average demand sensing uplift percentage - measures short-term signal value"
    - name: "avg_sensing_confidence"
      expr: AVG(CAST(sensing_confidence_score AS DOUBLE))
      comment: "Average demand sensing confidence score - quality indicator for near-term adjustments"
    - name: "count_accuracy_records"
      expr: COUNT(1)
      comment: "Total number of forecast accuracy measurement records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_consensus_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "S&OP consensus demand KPIs including statistical vs consensus variance, constraint impact, and agreement status for executive decision-making."
  source: "`vibe_consumer_goods_v1`.`supply`.`consensus_demand`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Consensus agreement status across stakeholders for governance tracking"
    - name: "approval_status"
      expr: approval_status
      comment: "Executive approval status for final plan lock"
    - name: "demand_category"
      expr: demand_category
      comment: "Demand category classification (base, promotional, new product) for segmentation"
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Planning horizon type (short-term, mid-term, long-term) for accuracy benchmarking"
    - name: "constrained_flag"
      expr: constrained_flag
      comment: "Flag indicating whether demand is supply-constrained for gap analysis"
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Flag indicating promotional period for uplift analysis"
    - name: "consensus_month"
      expr: DATE_TRUNC('month', consensus_date)
      comment: "Consensus date month for time-series analysis"
    - name: "bias_indicator"
      expr: bias_indicator
      comment: "Bias direction indicator (over, under, neutral) for systematic error detection"
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus demand quantity - primary S&OP output metric"
    - name: "total_statistical_forecast"
      expr: SUM(CAST(statistical_forecast_quantity AS DOUBLE))
      comment: "Total statistical forecast quantity before consensus overlay"
    - name: "total_commercial_overlay"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial team adjustments to statistical baseline"
    - name: "total_customer_commitment"
      expr: SUM(CAST(customer_commitment_quantity AS DOUBLE))
      comment: "Total customer committed demand - measures contractual obligation"
    - name: "total_marketing_event_uplift"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total marketing event uplift quantity - measures campaign impact"
    - name: "total_new_product_launch"
      expr: SUM(CAST(new_product_launch_quantity AS DOUBLE))
      comment: "Total new product launch quantity - innovation pipeline metric"
    - name: "total_unconstrained_demand"
      expr: SUM(CAST(unconstrained_demand_quantity AS DOUBLE))
      comment: "Total unconstrained demand quantity - measures true market potential"
    - name: "total_variance_to_statistical"
      expr: SUM(CAST(variance_to_statistical AS DOUBLE))
      comment: "Total variance between consensus and statistical forecast - measures human judgment impact"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between consensus and statistical - bias indicator"
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality factor applied - measures seasonal pattern strength"
    - name: "avg_demand_volatility"
      expr: AVG(CAST(demand_volatility_index AS DOUBLE))
      comment: "Average demand volatility index - risk and complexity indicator"
    - name: "avg_forecast_accuracy_previous"
      expr: AVG(CAST(forecast_accuracy_previous_period AS DOUBLE))
      comment: "Average forecast accuracy from previous period - performance trend indicator"
    - name: "count_constrained_records"
      expr: SUM(CASE WHEN constrained_flag = true THEN 1 ELSE 0 END)
      comment: "Count of supply-constrained demand records - capacity gap indicator"
    - name: "count_consensus_records"
      expr: COUNT(1)
      comment: "Total number of consensus demand records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock optimization KPIs including days of supply, service level targets, and holding cost impact for inventory investment steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`safety_stock`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification (A=high value, B=medium, C=low) for differentiated policy"
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification (X=stable, Y=variable, Z=erratic) for demand pattern segmentation"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Safety stock calculation method (statistical, days of supply, fixed) for policy analysis"
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand pattern classification for model selection"
    - name: "review_status"
      expr: review_status
      comment: "Review status (current, overdue, pending) for governance tracking"
    - name: "is_active"
      expr: is_active
      comment: "Active status flag for current policy filtering"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Effective date month for time-series analysis"
  measures:
    - name: "total_approved_safety_stock"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units - primary inventory investment metric"
    - name: "total_calculated_safety_stock"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total calculated safety stock units before approval adjustments"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total safety stock quantity across all SKU-location combinations"
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply coverage - inventory efficiency indicator"
    - name: "avg_target_service_level"
      expr: AVG(CAST(target_service_level_percent AS DOUBLE))
      comment: "Average target service level percentage - customer service commitment"
    - name: "avg_demand_variability"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient - explains safety stock need"
    - name: "avg_lead_time_variability"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days - supply risk indicator"
    - name: "avg_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage - predictability indicator"
    - name: "total_holding_cost"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE) * CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Total safety stock holding cost - financial impact of inventory policy"
    - name: "avg_holding_cost_per_unit"
      expr: AVG(CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Average holding cost per unit - cost of capital and storage"
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit - opportunity cost of lost sales"
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score - risk-adjusted safety stock driver"
    - name: "count_safety_stock_policies"
      expr: COUNT(1)
      comment: "Total number of safety stock policy records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_planning_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply planning exception KPIs including gap quantity, resolution time, and escalation rate for operational steering and continuous improvement."
  source: "`vibe_consumer_goods_v1`.`supply`.`planning_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Exception type classification (shortage, excess, constraint, policy violation) for root cause analysis"
    - name: "exception_severity"
      expr: exception_severity
      comment: "Exception severity level (critical, high, medium, low) for prioritization"
    - name: "exception_status"
      expr: exception_status
      comment: "Exception status (open, in-progress, resolved, closed) for workflow tracking"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status for closure tracking"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for continuous improvement targeting"
    - name: "constraint_type"
      expr: constraint_type
      comment: "Constraint type (capacity, material, transportation) for bottleneck analysis"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation flag for executive attention tracking"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level (L1, L2, L3) for severity tracking"
    - name: "exception_month"
      expr: DATE_TRUNC('month', exception_date)
      comment: "Exception date month for time-series trending"
  measures:
    - name: "total_gap_quantity"
      expr: SUM(CAST(gap_quantity AS DOUBLE))
      comment: "Total supply-demand gap quantity - primary exception impact metric"
    - name: "total_exception_quantity"
      expr: SUM(CAST(exception_quantity AS DOUBLE))
      comment: "Total exception quantity across all exception types"
    - name: "total_business_impact"
      expr: SUM(CAST(business_impact_amount AS DOUBLE))
      comment: "Total business impact amount in currency - financial consequence of exceptions"
    - name: "avg_resolution_duration_hours"
      expr: AVG(CAST(resolution_duration_hours AS DOUBLE))
      comment: "Average resolution duration in hours - operational efficiency indicator"
    - name: "count_exceptions"
      expr: COUNT(1)
      comment: "Total count of planning exceptions - exception rate indicator"
    - name: "count_escalated_exceptions"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of escalated exceptions - severity and complexity indicator"
    - name: "count_resolved_exceptions"
      expr: SUM(CASE WHEN resolution_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Count of resolved exceptions - resolution effectiveness metric"
    - name: "avg_demand_forecast_quantity"
      expr: AVG(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Average demand forecast quantity for context"
    - name: "avg_supply_plan_quantity"
      expr: AVG(CAST(supply_plan_quantity AS DOUBLE))
      comment: "Average supply plan quantity for context"
    - name: "avg_projected_inventory"
      expr: AVG(CAST(projected_inventory_balance AS DOUBLE))
      comment: "Average projected inventory balance at exception time"
    - name: "avg_safety_stock_target"
      expr: AVG(CAST(safety_stock_target AS DOUBLE))
      comment: "Average safety stock target for policy compliance analysis"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain constraint KPIs including shortfall quantity, financial impact, and resolution effectiveness for capacity and bottleneck steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`constraint`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Constraint type (capacity, material, labor, transportation, regulatory) for bottleneck analysis"
    - name: "constraint_status"
      expr: constraint_status
      comment: "Constraint status (active, mitigated, resolved) for lifecycle tracking"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level (critical, high, medium, low) for prioritization"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for executive attention tracking"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for continuous improvement targeting"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method (pro-rata, priority, fair-share) for policy analysis"
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Customer impact flag for service level risk tracking"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Regulatory compliance flag for legal risk tracking"
    - name: "constraint_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Constraint start month for time-series analysis"
  measures:
    - name: "total_quantity_shortfall"
      expr: SUM(CAST(quantity_shortfall AS DOUBLE))
      comment: "Total quantity shortfall - primary constraint impact metric"
    - name: "total_quantity_required"
      expr: SUM(CAST(quantity_required AS DOUBLE))
      comment: "Total quantity required for demand context"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for supply context"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount - revenue/margin at risk from constraints"
    - name: "total_constraint_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total constraint value across all constraint types"
    - name: "avg_mitigation_effectiveness"
      expr: AVG(CAST(mitigation_effectiveness_score AS DOUBLE))
      comment: "Average mitigation effectiveness score - measures action plan success"
    - name: "count_constraints"
      expr: COUNT(1)
      comment: "Total count of constraints - bottleneck frequency indicator"
    - name: "count_customer_impacting"
      expr: SUM(CASE WHEN customer_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of customer-impacting constraints - service level risk metric"
    - name: "count_regulatory_compliance"
      expr: SUM(CASE WHEN regulatory_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Count of regulatory compliance constraints - legal risk metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk register KPIs including risk score, probability-impact matrix, and mitigation cost for enterprise risk steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (supplier, demand, capacity, quality, regulatory, geopolitical) for portfolio analysis"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Risk subcategory for detailed classification"
    - name: "risk_status"
      expr: risk_status
      comment: "Risk status (identified, assessed, mitigated, closed) for lifecycle tracking"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Impact severity level (catastrophic, major, moderate, minor) for prioritization"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation flag for executive attention tracking"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional risk exposure analysis"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Risk identified month for time-series trending"
  measures:
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score (probability × impact) - primary risk exposure metric"
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score - likelihood of risk occurrence"
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score - consequence severity if risk occurs"
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_estimate AS DOUBLE))
      comment: "Total contingency cost estimate - financial reserve requirement for risk mitigation"
    - name: "total_contingency_stock"
      expr: SUM(CAST(contingency_stock_quantity AS DOUBLE))
      comment: "Total contingency stock quantity - inventory buffer for supply risk"
    - name: "count_risks"
      expr: COUNT(1)
      comment: "Total count of risks in register - risk portfolio size"
    - name: "count_escalated_risks"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of escalated risks - high-severity risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_otif_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full (OTIF) target KPIs including composite target, on-time and in-full components, and penalty exposure for customer service steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`otif_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Target status (active, expired, pending) for current policy filtering"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance tracking"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel code for channel-specific target analysis"
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Customer segment code for differentiated service level analysis"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier (platinum, gold, silver, bronze) for customer stratification"
    - name: "retailer_mandated_target"
      expr: retailer_mandated_target_flag
      comment: "Retailer mandated target flag for contractual obligation tracking"
    - name: "penalty_clause"
      expr: penalty_clause_flag
      comment: "Penalty clause flag for financial risk tracking"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective start month for time-series analysis"
  measures:
    - name: "avg_otif_composite_target"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average OTIF composite target percentage - primary customer service commitment"
    - name: "avg_on_time_target"
      expr: AVG(CAST(on_time_target_percentage AS DOUBLE))
      comment: "Average on-time delivery target percentage - timeliness component"
    - name: "avg_in_full_target"
      expr: AVG(CAST(in_full_target_percentage AS DOUBLE))
      comment: "Average in-full fill rate target percentage - completeness component"
    - name: "avg_on_time_delivery_target"
      expr: AVG(CAST(on_time_delivery_target_percent AS DOUBLE))
      comment: "Average on-time delivery target percent - alternate timeliness metric"
    - name: "avg_in_full_fill_rate_target"
      expr: AVG(CAST(in_full_fill_rate_target_percent AS DOUBLE))
      comment: "Average in-full fill rate target percent - alternate completeness metric"
    - name: "avg_escalation_threshold"
      expr: AVG(CAST(escalation_threshold_percent AS DOUBLE))
      comment: "Average escalation threshold percentage - performance trigger for management action"
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate_percent AS DOUBLE))
      comment: "Average penalty rate percentage - financial exposure for non-compliance"
    - name: "avg_quantity_tolerance"
      expr: AVG(CAST(quantity_tolerance_percent AS DOUBLE))
      comment: "Average quantity tolerance percentage - acceptable variance for in-full compliance"
    - name: "count_otif_targets"
      expr: COUNT(1)
      comment: "Total count of OTIF target records"
    - name: "count_penalty_clause_targets"
      expr: SUM(CASE WHEN penalty_clause_flag = true THEN 1 ELSE 0 END)
      comment: "Count of targets with penalty clauses - financial risk exposure"
    - name: "count_retailer_mandated"
      expr: SUM(CASE WHEN retailer_mandated_target_flag = true THEN 1 ELSE 0 END)
      comment: "Count of retailer-mandated targets - contractual obligation volume"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply replenishment order KPIs including order quantity, fulfillment rate, and lead time performance for supply execution steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Order status (planned, confirmed, shipped, received, cancelled) for lifecycle tracking"
    - name: "order_type"
      expr: order_type
      comment: "Order type (regular, expedited, safety stock, promotional) for policy analysis"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for urgency segmentation"
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Transportation mode (truck, rail, ocean, air) for cost and speed analysis"
    - name: "safety_stock_trigger"
      expr: safety_stock_trigger_flag
      comment: "Safety stock trigger flag for policy-driven replenishment tracking"
    - name: "planned_ship_month"
      expr: DATE_TRUNC('month', planned_ship_date)
      comment: "Planned ship month for time-series analysis"
  measures:
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total order quantity - primary replenishment volume metric"
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total requested quantity for demand context"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity - supplier commitment metric"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total shipped quantity - in-transit supply metric"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received quantity - actual supply delivered"
    - name: "total_atp_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity - uncommitted supply available for allocation"
    - name: "total_forecast_demand"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity driving replenishment"
    - name: "total_order_cost"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total order cost amount - replenishment spend metric"
    - name: "count_replenishment_orders"
      expr: COUNT(1)
      comment: "Total count of replenishment orders"
    - name: "count_safety_stock_triggered"
      expr: SUM(CASE WHEN safety_stock_trigger_flag = true THEN 1 ELSE 0 END)
      comment: "Count of safety stock triggered orders - policy-driven replenishment volume"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_sop_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales & Operations Planning (S&OP) cycle KPIs including consensus achievement, supply gap, and executive approval for monthly business steering."
  source: "`vibe_consumer_goods_v1`.`supply`.`sop_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "S&OP cycle status (in-progress, completed, locked, archived) for governance tracking"
    - name: "cycle_phase"
      expr: cycle_phase
      comment: "S&OP cycle phase (data gathering, demand review, supply review, pre-SOP, executive SOP) for workflow tracking"
    - name: "cycle_type"
      expr: cycle_type
      comment: "S&OP cycle type (monthly, quarterly, annual) for cadence analysis"
    - name: "demand_consensus_achieved"
      expr: demand_consensus_achieved_flag
      comment: "Demand consensus achieved flag for process effectiveness tracking"
    - name: "supply_consensus_achieved"
      expr: supply_consensus_achieved_flag
      comment: "Supply consensus achieved flag for process effectiveness tracking"
    - name: "executive_approval"
      expr: executive_approval_flag
      comment: "Executive approval flag for final plan lock tracking"
    - name: "cycle_locked"
      expr: cycle_locked_flag
      comment: "Cycle locked flag for plan freeze tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual planning context"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly planning context"
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_month)
      comment: "Planning month for time-series analysis"
  measures:
    - name: "total_baseline_demand"
      expr: SUM(CAST(baseline_demand_volume AS DOUBLE))
      comment: "Total baseline demand volume - statistical forecast input to S&OP"
    - name: "total_consensus_demand"
      expr: SUM(CAST(consensus_demand_volume AS DOUBLE))
      comment: "Total consensus demand volume - agreed demand plan output from S&OP"
    - name: "total_constrained_supply"
      expr: SUM(CAST(constrained_supply_volume AS DOUBLE))
      comment: "Total constrained supply volume - realistic supply plan considering capacity"
    - name: "total_supply_gap"
      expr: SUM(CAST(supply_gap_volume AS DOUBLE))
      comment: "Total supply gap volume - unmet demand requiring mitigation action"
    - name: "count_sop_cycles"
      expr: COUNT(1)
      comment: "Total count of S&OP cycles"
    - name: "count_demand_consensus_achieved"
      expr: SUM(CASE WHEN demand_consensus_achieved_flag = true THEN 1 ELSE 0 END)
      comment: "Count of cycles with demand consensus achieved - process effectiveness metric"
    - name: "count_supply_consensus_achieved"
      expr: SUM(CASE WHEN supply_consensus_achieved_flag = true THEN 1 ELSE 0 END)
      comment: "Count of cycles with supply consensus achieved - process effectiveness metric"
    - name: "count_executive_approved"
      expr: SUM(CASE WHEN executive_approval_flag = true THEN 1 ELSE 0 END)
      comment: "Count of executive-approved cycles - governance completion metric"
    - name: "count_locked_cycles"
      expr: SUM(CASE WHEN cycle_locked_flag = true THEN 1 ELSE 0 END)
      comment: "Count of locked cycles - plan freeze and execution readiness metric"
$$;