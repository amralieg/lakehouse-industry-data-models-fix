-- Metric views for domain: route | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_lane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core lane performance metrics tracking on-time delivery, cost efficiency, transit reliability, and sustainability across shipping lanes. Essential for network optimization decisions and carrier performance management."
  source: "`transport_shipping_ecm`.`route`.`lane_performance`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (ocean, air, road, rail) for segmenting lane performance"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for geographic performance analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of destination for geographic performance analysis"
    - name: "period_type"
      expr: period_type
      comment: "Measurement period granularity (daily, weekly, monthly)"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the performance measurement record"
    - name: "sla_breach_flag"
      expr: CAST(sla_breach_flag AS STRING)
      comment: "Whether the lane breached SLA targets during the measurement period"
    - name: "measurement_period_start_date"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Measurement period start month for time-series trending"
  measures:
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(otd_rate AS DOUBLE))
      comment: "Average on-time delivery rate across lanes - primary SLA compliance indicator"
    - name: "avg_otif_rate"
      expr: AVG(CAST(otif_rate AS DOUBLE))
      comment: "Average on-time-in-full rate measuring complete and punctual delivery performance"
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across measured lanes for cost management"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(avg_freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment for unit economics analysis"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours for speed-of-service monitoring"
    - name: "avg_delay_hours"
      expr: AVG(CAST(avg_delay_hours AS DOUBLE))
      comment: "Average delay hours per lane indicating service reliability degradation"
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(total_co2e_kg AS DOUBLE))
      comment: "Total CO2-equivalent emissions in kg for sustainability reporting and carbon reduction targets"
    - name: "avg_co2e_per_shipment_kg"
      expr: AVG(CAST(co2e_per_shipment_kg AS DOUBLE))
      comment: "Average carbon emissions per shipment for sustainability benchmarking"
    - name: "avg_carrier_performance_score"
      expr: AVG(CAST(carrier_performance_score AS DOUBLE))
      comment: "Average carrier performance score for vendor management and allocation decisions"
    - name: "avg_damage_rate"
      expr: AVG(CAST(damage_rate AS DOUBLE))
      comment: "Average damage rate across lanes indicating cargo handling quality"
    - name: "avg_exception_rate"
      expr: AVG(CAST(exception_rate AS DOUBLE))
      comment: "Average exception rate measuring operational disruption frequency"
    - name: "avg_pod_completion_rate"
      expr: AVG(CAST(pod_completion_rate AS DOUBLE))
      comment: "Average proof-of-delivery completion rate for delivery confirmation compliance"
    - name: "avg_customs_clearance_delay_hours"
      expr: AVG(CAST(customs_clearance_delay_hours AS DOUBLE))
      comment: "Average customs clearance delay for cross-border efficiency monitoring"
    - name: "lane_measurement_count"
      expr: COUNT(1)
      comment: "Number of lane performance measurement records for data completeness tracking"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_eta_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ETA prediction accuracy and shipment visibility metrics tracking delivery predictability, SLA compliance, and exception management for real-time operations steering."
  source: "`transport_shipping_ecm`.`route`.`eta_event`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for segmenting ETA performance by modality"
    - name: "event_type"
      expr: event_type
      comment: "Type of ETA event (update, milestone, exception) for event classification"
    - name: "service_type"
      expr: service_type
      comment: "Service product type (express, standard, economy) for service-level analysis"
    - name: "sla_breach_flag"
      expr: CAST(sla_breach_flag AS STRING)
      comment: "Whether the shipment breached its SLA delivery target"
    - name: "exception_flag"
      expr: CAST(exception_flag AS STRING)
      comment: "Whether an exception was raised for this ETA event"
    - name: "exception_severity"
      expr: exception_severity
      comment: "Severity level of exceptions for prioritization"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Root cause code for delays enabling Pareto analysis of delay drivers"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for cross-border visibility"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Event month for time-series trending of ETA performance"
  measures:
    - name: "avg_eta_variance_hours"
      expr: AVG(CAST(eta_variance_hours AS DOUBLE))
      comment: "Average ETA variance in hours - key measure of delivery predictability and planning accuracy"
    - name: "avg_etd_variance_hours"
      expr: AVG(CAST(etd_variance_hours AS DOUBLE))
      comment: "Average ETD variance measuring departure reliability"
    - name: "avg_prediction_confidence_score"
      expr: AVG(CAST(prediction_confidence_score AS DOUBLE))
      comment: "Average ETA prediction confidence score measuring AI/ML model reliability"
    - name: "avg_actual_transit_time_hours"
      expr: AVG(CAST(actual_transit_time_hours AS DOUBLE))
      comment: "Average actual transit time for speed-of-service monitoring"
    - name: "avg_planned_transit_time_hours"
      expr: AVG(CAST(planned_transit_time_hours AS DOUBLE))
      comment: "Average planned transit time as baseline for variance analysis"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Count of SLA breaches for compliance monitoring and penalty exposure assessment"
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_flag = true THEN 1 ELSE 0 END)
      comment: "Count of exceptions raised for operational disruption quantification"
    - name: "total_eta_events"
      expr: COUNT(1)
      comment: "Total ETA events for volume and coverage analysis"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route exception analytics measuring operational disruption frequency, severity, resolution efficiency, and financial impact. Critical for identifying systemic issues and driving continuous improvement."
  source: "`transport_shipping_ecm`.`route`.`route_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of exception (delay, damage, customs hold, etc.) for root cause classification"
    - name: "severity"
      expr: severity
      comment: "Exception severity level for prioritization and escalation analysis"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception (open, in-progress, resolved, closed)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for Pareto analysis of systemic issues"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for modal exception pattern analysis"
    - name: "sla_breach_flag"
      expr: CAST(sla_breach_flag AS STRING)
      comment: "Whether the exception resulted in an SLA breach"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached for management attention analysis"
    - name: "affected_country_code"
      expr: affected_country_code
      comment: "Country affected by the exception for geographic risk mapping"
    - name: "raised_month"
      expr: DATE_TRUNC('month', raised_timestamp)
      comment: "Month exception was raised for trending analysis"
  measures:
    - name: "total_exception_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total financial impact of route exceptions in USD for cost-of-failure quantification"
    - name: "total_recovery_cost_usd"
      expr: SUM(CAST(recovery_cost_usd AS DOUBLE))
      comment: "Total recovery/remediation costs incurred to resolve exceptions"
    - name: "avg_exception_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per exception for unit economics of failure"
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of route exceptions for volume and frequency analysis"
    - name: "sla_breach_exception_count"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Count of exceptions that resulted in SLA breaches for penalty exposure"
    - name: "recurrence_count"
      expr: SUM(CASE WHEN recurrence_flag = true THEN 1 ELSE 0 END)
      comment: "Count of recurring exceptions indicating systemic unresolved issues"
    - name: "customer_notified_count"
      expr: SUM(CASE WHEN customer_notified_flag = true THEN 1 ELSE 0 END)
      comment: "Count of exceptions where customer was proactively notified for CX impact assessment"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route planning metrics measuring planning efficiency, cost estimation accuracy, transit time planning, and cross-border complexity. Supports capacity planning and network design decisions."
  source: "`transport_shipping_ecm`.`route`.`plan`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for modal planning analysis"
    - name: "plan_status"
      expr: plan_status
      comment: "Plan lifecycle status (draft, confirmed, in-execution, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Service product type for service-level planning analysis"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for geographic planning patterns"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane planning analysis"
    - name: "is_cross_border"
      expr: CAST(is_cross_border AS STRING)
      comment: "Whether the plan involves cross-border movement requiring customs"
    - name: "is_hazmat"
      expr: CAST(is_hazmat AS STRING)
      comment: "Whether the plan involves hazardous materials requiring special handling"
    - name: "temperature_controlled"
      expr: CAST(temperature_controlled AS STRING)
      comment: "Whether temperature-controlled transport is required"
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_timestamp)
      comment: "Month of plan creation for planning volume trending"
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned freight cost for budget forecasting and cost management"
    - name: "avg_planned_cost"
      expr: AVG(CAST(planned_cost_amount AS DOUBLE))
      comment: "Average planned cost per route plan for unit cost benchmarking"
    - name: "total_planned_distance_km"
      expr: SUM(CAST(total_planned_distance_km AS DOUBLE))
      comment: "Total planned distance for network utilization and carbon footprint estimation"
    - name: "avg_planned_transit_time_hours"
      expr: AVG(CAST(total_planned_transit_time_hours AS DOUBLE))
      comment: "Average planned transit time for service level planning"
    - name: "total_planned_co2e_kg"
      expr: SUM(CAST(planned_co2e_emissions_kg AS DOUBLE))
      comment: "Total planned CO2e emissions for sustainability forecasting"
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of route plans for planning volume and capacity analysis"
    - name: "cross_border_plan_count"
      expr: SUM(CASE WHEN is_cross_border = true THEN 1 ELSE 0 END)
      comment: "Count of cross-border plans for customs workload forecasting"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_network_optimization_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network optimization effectiveness metrics measuring cost savings achieved, CO2 reduction, transit time improvements, and capacity utilization gains from optimization algorithms. Critical for justifying network design investments."
  source: "`transport_shipping_ecm`.`route`.`network_optimization_run`"
  dimensions:
    - name: "optimization_type"
      expr: optimization_type
      comment: "Type of optimization (cost, transit-time, sustainability, multi-objective)"
    - name: "run_status"
      expr: run_status
      comment: "Optimization run status (completed, failed, in-progress)"
    - name: "objective_function"
      expr: objective_function
      comment: "Optimization objective for categorizing run purpose"
    - name: "convergence_status"
      expr: convergence_status
      comment: "Whether the solver converged to an optimal solution"
    - name: "solver_engine"
      expr: solver_engine
      comment: "Solver engine used for algorithm performance comparison"
    - name: "planning_start_month"
      expr: DATE_TRUNC('month', planning_start_date)
      comment: "Planning horizon start month for temporal analysis"
  measures:
    - name: "total_cost_savings"
      expr: SUM(CAST(cost_savings_amount AS DOUBLE))
      comment: "Total cost savings achieved through network optimization - primary ROI measure"
    - name: "avg_cost_savings_percentage"
      expr: AVG(CAST(cost_savings_percentage AS DOUBLE))
      comment: "Average percentage cost reduction achieved per optimization run"
    - name: "total_co2e_reduction_kg"
      expr: SUM(CAST(co2e_reduction_kg AS DOUBLE))
      comment: "Total CO2e emissions reduced through optimization for sustainability reporting"
    - name: "avg_co2e_reduction_percentage"
      expr: AVG(CAST(co2e_reduction_percentage AS DOUBLE))
      comment: "Average percentage CO2e reduction per optimization run"
    - name: "avg_transit_time_improvement_hours"
      expr: AVG(CAST(transit_time_improvement_hours AS DOUBLE))
      comment: "Average transit time improvement in hours from optimization"
    - name: "avg_capacity_utilization_improvement"
      expr: AVG(CAST(optimized_capacity_utilization_percentage AS DOUBLE) - CAST(baseline_capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization improvement percentage from baseline to optimized state"
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average solver execution time for computational performance monitoring"
    - name: "optimization_run_count"
      expr: COUNT(1)
      comment: "Total optimization runs for activity and investment tracking"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_carrier_lane_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier lane allocation metrics measuring capacity commitment, cost efficiency, and carrier diversification across the network. Supports procurement negotiations and carrier management strategy."
  source: "`transport_shipping_ecm`.`route`.`carrier_lane_allocation`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for modal allocation analysis"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status (active, pending, expired)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (primary, backup, spot)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for governance tracking"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type allocated for capacity planning"
    - name: "carrier_certification_level"
      expr: carrier_certification_level
      comment: "Carrier certification level for quality tier analysis"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Allocation effective start month for temporal analysis"
  measures:
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage indicating carrier concentration risk"
    - name: "total_contracted_capacity_teu"
      expr: SUM(CAST(contracted_capacity_teu AS DOUBLE))
      comment: "Total contracted capacity in TEU for capacity planning"
    - name: "total_contracted_capacity_weight_kg"
      expr: SUM(CAST(contracted_capacity_weight_kg AS DOUBLE))
      comment: "Total contracted weight capacity for capacity utilization analysis"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across allocations for rate benchmarking"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average carrier performance score for allocation quality assessment"
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_pct AS DOUBLE))
      comment: "Average contracted SLA on-time delivery percentage target"
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor_kg_co2e AS DOUBLE))
      comment: "Average carbon emission factor across allocations for green procurement tracking"
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of carrier lane allocations for network diversity measurement"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers allocated for concentration risk assessment"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_plan_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan leg execution metrics measuring transit time adherence, cost per leg, carbon emissions, and operational delays at the granular leg level. Enables identification of specific bottleneck segments in the network."
  source: "`transport_shipping_ecm`.`route`.`plan_leg`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the leg segment"
    - name: "leg_status"
      expr: leg_status
      comment: "Current execution status of the plan leg"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for the leg"
    - name: "load_type"
      expr: load_type
      comment: "Load type (FCL, LCL, FTL, LTL) for utilization analysis"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for cross-border leg analysis"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('month', planned_departure_datetime)
      comment: "Planned departure month for temporal trending"
  measures:
    - name: "total_leg_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost across all plan legs for cost allocation analysis"
    - name: "avg_leg_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per leg for unit cost benchmarking"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered across legs for network utilization"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit hours per leg for speed monitoring"
    - name: "avg_planned_transit_hours"
      expr: AVG(CAST(planned_transit_hours AS DOUBLE))
      comment: "Average planned transit hours for baseline comparison"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions across legs for sustainability tracking"
    - name: "avg_carbon_emissions_per_leg_kg"
      expr: AVG(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Average carbon emissions per leg for green routing decisions"
    - name: "total_plan_legs"
      expr: COUNT(1)
      comment: "Total number of plan legs for network complexity analysis"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_optimization_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Optimization recommendation tracking metrics measuring implementation progress, projected vs actual impact, and decision-making velocity. Critical for network improvement program governance."
  source: "`transport_shipping_ecm`.`route`.`optimization_recommendation`"
  dimensions:
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of recommendation (lane change, carrier switch, mode shift, consolidation)"
    - name: "recommendation_status"
      expr: recommendation_status
      comment: "Implementation status (proposed, approved, in-progress, completed, rejected)"
    - name: "implementation_complexity"
      expr: implementation_complexity
      comment: "Complexity level for resource planning"
    - name: "implementation_priority"
      expr: implementation_priority
      comment: "Priority ranking for implementation sequencing"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode affected by the recommendation"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the recommendation for risk assessment"
    - name: "service_level"
      expr: service_level
      comment: "Service level impacted by the recommendation"
  measures:
    - name: "total_annual_cost_impact"
      expr: SUM(CAST(total_annual_cost_impact AS DOUBLE))
      comment: "Total projected annual cost impact of recommendations for business case quantification"
    - name: "total_annual_co2e_impact_kg"
      expr: SUM(CAST(total_annual_co2e_impact_kg AS DOUBLE))
      comment: "Total projected annual CO2e impact for sustainability business case"
    - name: "avg_cost_impact_per_shipment"
      expr: AVG(CAST(cost_impact_per_shipment AS DOUBLE))
      comment: "Average cost impact per shipment for unit economics improvement tracking"
    - name: "avg_transit_time_impact_hours"
      expr: AVG(CAST(transit_time_impact_hours AS DOUBLE))
      comment: "Average transit time improvement per recommendation"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of recommendations for quality assessment"
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual realized cost impact for ROI validation"
    - name: "total_actual_co2e_impact_kg"
      expr: SUM(CAST(actual_co2e_impact_kg AS DOUBLE))
      comment: "Total actual CO2e reduction realized for sustainability reporting"
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of optimization recommendations generated"
$$;