-- Metric views for domain: manufacturing | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production order execution metrics tracking order fulfillment, cost performance, and labor/machine efficiency"
  source: "`automotive_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g., released, in-progress, completed)"
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g., standard, rework, prototype)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being produced"
    - name: "production_stage"
      expr: production_stage
      comment: "Current production stage (e.g., body, paint, assembly)"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month when the production order was created"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when production was planned to start"
    - name: "priority"
      expr: priority
      comment: "Production order priority level"
    - name: "sop_indicator"
      expr: sop_indicator
      comment: "Flag indicating if this is a start-of-production order"
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders"
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed production quantity across all orders"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all production orders"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across all production orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred across all orders"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (planned) production cost across all orders"
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all production orders"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all production orders"
    - name: "total_planned_machine_hours"
      expr: SUM(CAST(planned_machine_hours AS DOUBLE))
      comment: "Total planned machine hours across all production orders"
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(actual_machine_hours AS DOUBLE))
      comment: "Total actual machine hours consumed across all production orders"
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per production order"
    - name: "order_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target quantity that was confirmed (order fulfillment rate)"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target quantity that became scrap"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target quantity that required rework"
    - name: "labor_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_labor_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_labor_hours AS DOUBLE)), 0), 2)
      comment: "Labor efficiency percentage (planned vs actual labor hours)"
    - name: "machine_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_machine_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_machine_hours AS DOUBLE)), 0), 2)
      comment: "Machine efficiency percentage (planned vs actual machine hours)"
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(standard_cost AS DOUBLE))) / NULLIF(SUM(CAST(standard_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance percentage (actual vs standard cost)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing downtime and availability metrics tracking equipment failures, production losses, and maintenance effectiveness"
  source: "`automotive_ecm`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g., planned, unplanned, maintenance)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime (e.g., mechanical failure, material shortage, changeover)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event (e.g., open, resolved, escalated)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code for the downtime"
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode classification code"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when the downtime event occurred"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating if the downtime was safety-related"
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating if this is a repeat failure"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the downtime event"
    - name: "model_year"
      expr: model_year
      comment: "Model year affected by the downtime"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes across all events"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_local AS DOUBLE))
      comment: "Total maintenance cost incurred for downtime events"
    - name: "total_time_to_repair_minutes"
      expr: SUM(CAST(time_to_repair_minutes AS DOUBLE))
      comment: "Total time to repair across all downtime events"
    - name: "total_time_to_respond_minutes"
      expr: SUM(CAST(time_to_respond_minutes AS DOUBLE))
      comment: "Total time to respond across all downtime events"
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "avg_time_to_repair_minutes"
      expr: AVG(CAST(time_to_repair_minutes AS DOUBLE))
      comment: "Average time to repair per downtime event (MTTR)"
    - name: "avg_time_to_respond_minutes"
      expr: AVG(CAST(time_to_respond_minutes AS DOUBLE))
      comment: "Average time to respond to downtime events"
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(maintenance_cost_local AS DOUBLE))
      comment: "Average maintenance cost per downtime event"
    - name: "total_oee_availability_loss_pct"
      expr: SUM(CAST(oee_availability_loss_pct AS DOUBLE))
      comment: "Total OEE availability loss percentage across all events"
    - name: "avg_oee_availability_loss_pct"
      expr: AVG(CAST(oee_availability_loss_pct AS DOUBLE))
      comment: "Average OEE availability loss percentage per event"
    - name: "repeat_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are repeat failures"
    - name: "safety_related_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are safety-related"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_vehicle_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle build execution metrics tracking build cycle times, quality holds, rework, and end-of-line test results"
  source: "`automotive_ecm`.`manufacturing`.`vehicle_build`"
  dimensions:
    - name: "build_status"
      expr: build_status
      comment: "Current status of the vehicle build (e.g., in-progress, completed, on-hold)"
    - name: "build_type"
      expr: build_type
      comment: "Type of build (e.g., standard, pilot, pre-production)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being built"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g., ICE, hybrid, electric)"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the vehicle"
    - name: "quality_gate_status"
      expr: quality_gate_status
      comment: "Quality gate status (e.g., passed, failed, pending)"
    - name: "end_of_line_test_result"
      expr: end_of_line_test_result
      comment: "Result of end-of-line testing"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Flag indicating if the build is on quality hold"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flag indicating if the build required rework"
    - name: "sop_flag"
      expr: sop_flag
      comment: "Flag indicating if this is a start-of-production build"
    - name: "scheduled_build_month"
      expr: DATE_TRUNC('MONTH', scheduled_build_date)
      comment: "Month when the build was scheduled"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for quality hold"
  measures:
    - name: "total_vehicle_builds"
      expr: COUNT(1)
      comment: "Total number of vehicle builds"
    - name: "total_builds_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Total number of builds currently on quality hold"
    - name: "total_builds_with_rework"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Total number of builds that required rework"
    - name: "quality_hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds placed on quality hold"
    - name: "rework_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds requiring rework"
    - name: "first_time_quality_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds completed without rework (first-time quality)"
    - name: "distinct_vins_built"
      expr: COUNT(DISTINCT vin)
      comment: "Distinct count of VINs built"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation metrics tracking yield, scrap, rework, and operational efficiency at the work center level"
  source: "`automotive_ecm`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of the production confirmation (e.g., confirmed, reversed, pending)"
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g., final, partial, milestone)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the production"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type being produced"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the confirmation was posted"
    - name: "final_confirmation_flag"
      expr: final_confirmation_flag
      comment: "Flag indicating if this is the final confirmation for the operation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this confirmation was reversed"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrap"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Reason code for downtime during the operation"
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of production confirmations"
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total yield quantity confirmed across all operations"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all confirmations"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across all confirmations"
    - name: "total_planned_labor_time_min"
      expr: SUM(CAST(labor_time_planned_min AS DOUBLE))
      comment: "Total planned labor time in minutes"
    - name: "total_actual_labor_time_min"
      expr: SUM(CAST(labor_time_actual_min AS DOUBLE))
      comment: "Total actual labor time in minutes"
    - name: "total_planned_machine_time_min"
      expr: SUM(CAST(machine_time_planned_min AS DOUBLE))
      comment: "Total planned machine time in minutes"
    - name: "total_actual_machine_time_min"
      expr: SUM(CAST(machine_time_actual_min AS DOUBLE))
      comment: "Total actual machine time in minutes"
    - name: "total_setup_time_planned_min"
      expr: SUM(CAST(setup_time_planned_min AS DOUBLE))
      comment: "Total planned setup time in minutes"
    - name: "total_setup_time_actual_min"
      expr: SUM(CAST(setup_time_actual_min AS DOUBLE))
      comment: "Total actual setup time in minutes"
    - name: "total_downtime_duration_min"
      expr: SUM(CAST(downtime_duration_min AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "avg_takt_time_actual_sec"
      expr: AVG(CAST(takt_time_actual_sec AS DOUBLE))
      comment: "Average actual takt time in seconds per confirmation"
    - name: "yield_rate"
      expr: ROUND(100.0 * SUM(CAST(yield_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)) + SUM(CAST(scrap_quantity AS DOUBLE)), 0), 2)
      comment: "Yield rate percentage (yield vs total input)"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)) + SUM(CAST(scrap_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate percentage"
    - name: "labor_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_time_planned_min AS DOUBLE)) / NULLIF(SUM(CAST(labor_time_actual_min AS DOUBLE)), 0), 2)
      comment: "Labor efficiency percentage (planned vs actual labor time)"
    - name: "machine_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(machine_time_planned_min AS DOUBLE)) / NULLIF(SUM(CAST(machine_time_actual_min AS DOUBLE)), 0), 2)
      comment: "Machine efficiency percentage (planned vs actual machine time)"
    - name: "setup_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(setup_time_planned_min AS DOUBLE)) / NULLIF(SUM(CAST(setup_time_actual_min AS DOUBLE)), 0), 2)
      comment: "Setup efficiency percentage (planned vs actual setup time)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_material_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and variance metrics tracking planned vs actual usage, scrap, and cost variances"
  source: "`automotive_ecm`.`manufacturing`.`material_consumption`"
  dimensions:
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the material consumption transaction"
    - name: "goods_movement_type"
      expr: goods_movement_type
      comment: "Type of goods movement (e.g., consumption, return, scrap)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the material consumption was posted"
    - name: "scrap_indicator"
      expr: scrap_indicator
      comment: "Flag indicating if the consumption was for scrap"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if the consumption was reversed"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrap consumption"
    - name: "assembly_station_code"
      expr: assembly_station_code
      comment: "Assembly station where material was consumed"
  measures:
    - name: "total_consumption_transactions"
      expr: COUNT(1)
      comment: "Total number of material consumption transactions"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity"
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total actual material quantity consumed"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (actual vs planned)"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost amount"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance amount"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all consumption transactions"
    - name: "material_usage_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_consumed AS DOUBLE)), 0), 2)
      comment: "Material usage efficiency percentage (planned vs actual consumption)"
    - name: "scrap_consumption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scrap_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption transactions that are scrap"
    - name: "distinct_materials_consumed"
      expr: COUNT(DISTINCT goods_movement_number)
      comment: "Distinct count of goods movement numbers (material consumption events)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_rework_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rework order metrics tracking defect resolution, rework costs, labor hours, and quality hold impacts"
  source: "`automotive_ecm`.`manufacturing`.`rework_order`"
  dimensions:
    - name: "rework_order_status"
      expr: rework_order_status
      comment: "Current status of the rework order (e.g., open, in-progress, completed)"
    - name: "rework_type"
      expr: rework_type
      comment: "Type of rework (e.g., mechanical, electrical, cosmetic)"
    - name: "defect_code"
      expr: defect_code
      comment: "Defect classification code"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code for the defect"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code (e.g., rework, scrap, use-as-is)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the rework order"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle requiring rework"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating if the rework is safety-related"
    - name: "is_regulatory_hold"
      expr: is_regulatory_hold
      comment: "Flag indicating if the rework is due to regulatory hold"
    - name: "line_stoppage_flag"
      expr: line_stoppage_flag
      comment: "Flag indicating if the defect caused a line stoppage"
    - name: "detection_method_code"
      expr: detection_method_code
      comment: "Method by which the defect was detected"
  measures:
    - name: "total_rework_orders"
      expr: COUNT(1)
      comment: "Total number of rework orders"
    - name: "total_planned_rework_hours"
      expr: SUM(CAST(planned_rework_hours AS DOUBLE))
      comment: "Total planned rework hours across all orders"
    - name: "total_actual_rework_hours"
      expr: SUM(CAST(actual_rework_hours AS DOUBLE))
      comment: "Total actual rework hours consumed"
    - name: "total_rework_labor_cost"
      expr: SUM(CAST(rework_labor_cost AS DOUBLE))
      comment: "Total rework labor cost"
    - name: "total_rework_material_cost"
      expr: SUM(CAST(rework_material_cost AS DOUBLE))
      comment: "Total rework material cost"
    - name: "avg_actual_rework_hours"
      expr: AVG(CAST(actual_rework_hours AS DOUBLE))
      comment: "Average actual rework hours per order"
    - name: "avg_rework_labor_cost"
      expr: AVG(CAST(rework_labor_cost AS DOUBLE))
      comment: "Average rework labor cost per order"
    - name: "avg_rework_material_cost"
      expr: AVG(CAST(rework_material_cost AS DOUBLE))
      comment: "Average rework material cost per order"
    - name: "rework_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_rework_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_rework_hours AS DOUBLE)), 0), 2)
      comment: "Rework efficiency percentage (planned vs actual hours)"
    - name: "safety_related_rework_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rework orders that are safety-related"
    - name: "line_stoppage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN line_stoppage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rework orders that caused line stoppages"
    - name: "regulatory_hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_hold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rework orders due to regulatory holds"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning metrics tracking utilization, bottlenecks, capacity gaps, and capital investment requirements"
  source: "`automotive_ecm`.`manufacturing`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (e.g., draft, approved, active)"
    - name: "capacity_plan_type"
      expr: capacity_plan_type
      comment: "Type of capacity plan (e.g., annual, quarterly, tactical)"
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (e.g., baseline, optimistic, pessimistic)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capacity plan"
    - name: "model_year"
      expr: model_year
      comment: "Model year covered by the capacity plan"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type covered by the plan"
    - name: "is_bottleneck_constrained"
      expr: is_bottleneck_constrained
      comment: "Flag indicating if the plan is constrained by bottlenecks"
    - name: "capex_required"
      expr: capex_required
      comment: "Flag indicating if capital expenditure is required"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g., daily, weekly, monthly)"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the capacity plan starts"
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total number of capacity plans"
    - name: "total_rated_capacity_units"
      expr: SUM(CAST(rated_capacity_units AS DOUBLE))
      comment: "Total rated capacity in units across all plans"
    - name: "total_demonstrated_capacity_units"
      expr: SUM(CAST(demonstrated_capacity_units AS DOUBLE))
      comment: "Total demonstrated capacity in units"
    - name: "total_planned_production_units"
      expr: SUM(CAST(planned_production_units AS DOUBLE))
      comment: "Total planned production units across all plans"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available production hours"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours"
    - name: "total_planned_maintenance_hours"
      expr: SUM(CAST(planned_maintenance_hours AS DOUBLE))
      comment: "Total planned maintenance hours"
    - name: "total_planned_overtime_hours"
      expr: SUM(CAST(planned_overtime_hours AS DOUBLE))
      comment: "Total planned overtime hours"
    - name: "total_changeover_hours"
      expr: SUM(CAST(changeover_hours AS DOUBLE))
      comment: "Total changeover hours"
    - name: "total_capex_amount"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure amount required"
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across all plans"
    - name: "avg_rated_capacity_jph"
      expr: AVG(CAST(rated_capacity_jph AS DOUBLE))
      comment: "Average rated capacity in jobs per hour"
    - name: "capacity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_production_units AS DOUBLE)) / NULLIF(SUM(CAST(rated_capacity_units AS DOUBLE)), 0), 2)
      comment: "Overall capacity utilization percentage (planned production vs rated capacity)"
    - name: "bottleneck_constrained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bottleneck_constrained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capacity plans that are bottleneck-constrained"
    - name: "capex_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capex_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capacity plans requiring capital expenditure"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line performance metrics tracking throughput, automation levels, energy efficiency, and line capability"
  source: "`automotive_ecm`.`manufacturing`.`production_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current operational status of the production line"
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g., body, paint, assembly)"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation (e.g., manual, semi-automated, fully-automated)"
    - name: "mixed_model_capable"
      expr: mixed_model_capable
      comment: "Flag indicating if the line can produce mixed models"
    - name: "jis_enabled"
      expr: jis_enabled
      comment: "Flag indicating if just-in-sequence is enabled"
    - name: "agv_integration_enabled"
      expr: agv_integration_enabled
      comment: "Flag indicating if automated guided vehicles are integrated"
    - name: "model_year_capability"
      expr: model_year_capability
      comment: "Model year capability of the line"
    - name: "powertrain_type_capability"
      expr: powertrain_type_capability
      comment: "Powertrain types the line is capable of producing"
    - name: "iatf_audit_status"
      expr: iatf_audit_status
      comment: "IATF 16949 audit status"
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status"
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines"
    - name: "total_designed_jph"
      expr: SUM(CAST(designed_jph AS DOUBLE))
      comment: "Total designed jobs per hour capacity across all lines"
    - name: "total_current_jph"
      expr: SUM(CAST(current_jph AS DOUBLE))
      comment: "Total current jobs per hour throughput across all lines"
    - name: "total_floor_space_sqm"
      expr: SUM(CAST(floor_space_sqm AS DOUBLE))
      comment: "Total floor space in square meters"
    - name: "total_line_length_meters"
      expr: SUM(CAST(line_length_meters AS DOUBLE))
      comment: "Total line length in meters"
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds across all lines"
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption in kWh per unit produced"
    - name: "avg_designed_jph"
      expr: AVG(CAST(designed_jph AS DOUBLE))
      comment: "Average designed jobs per hour per line"
    - name: "avg_current_jph"
      expr: AVG(CAST(current_jph AS DOUBLE))
      comment: "Average current jobs per hour per line"
    - name: "line_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(current_jph AS DOUBLE)) / NULLIF(SUM(CAST(designed_jph AS DOUBLE)), 0), 2)
      comment: "Overall line utilization percentage (current vs designed throughput)"
    - name: "mixed_model_capable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mixed_model_capable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines that are mixed-model capable"
    - name: "jis_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN jis_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines with just-in-sequence enabled"
    - name: "agv_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN agv_integration_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines with AGV integration"
$$;