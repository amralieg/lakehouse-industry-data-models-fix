-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPIs for production work orders covering throughput, quality, cost variance, OEE, and cycle efficiency. Used by production managers and plant directors to steer daily and weekly manufacturing performance."
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Released, Confirmed, Closed) for filtering and grouping."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Standard, Rework, Repair) to segment performance by order category."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority classification of the work order for capacity and scheduling analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned start date for trend analysis."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Month bucket of planned finish date for delivery performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost figures for multi-currency reporting."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of production work orders. Baseline volume metric for capacity and throughput analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Sum of all planned production quantities across work orders. Drives capacity planning and demand fulfillment tracking."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Sum of all actual produced quantities. Compared against planned to assess production attainment."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped units across all work orders. High scrap drives cost and quality investigations."
    - name: "avg_scrap_rate_pct"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage across work orders. Key quality KPI — elevated rates trigger root-cause and process improvement actions."
    - name: "avg_yield_rate_pct"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate percentage. Directly measures production efficiency and product quality output."
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness across work orders. Premier manufacturing KPI used in executive steering reviews."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred. Compared against standard cost to identify cost overruns."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) production cost. Baseline for cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(standard_cost AS DOUBLE))
      comment: "Aggregate cost variance (actual minus standard). Negative variance indicates cost savings; positive indicates overrun requiring management action."
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average work order completion percentage. Tracks in-progress execution against plan for on-time delivery risk assessment."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded against work orders. Directly impacts OEE and production throughput."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order. Compared against takt time to identify bottlenecks and capacity constraints."
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time across work orders. Represents customer demand rate — used to align production pace with demand."
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total work-in-progress inventory value. High WIP ties up working capital and signals flow inefficiencies."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work order. Reducing setup time is a key lean manufacturing lever for increasing available production time."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for individual production runs covering OEE components (availability, performance, quality), throughput, cost, and downtime. Used by production supervisors and plant managers for shift-level and campaign-level performance management."
  source: "`vibe_manufacturing_v1`.`production`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the production run (e.g. Active, Completed, Cancelled)."
    - name: "run_type"
      expr: run_type
      comment: "Type of production run (e.g. Standard, Campaign, Trial) for segmented performance analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the run for scheduling and escalation analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_timestamp)
      comment: "Month bucket of planned run start for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost-based measures."
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of production runs. Volume baseline for throughput and scheduling analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned output quantity across all runs. Used to assess production plan attainment."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual output quantity. Compared to planned to compute production attainment rate."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped units across runs. Drives quality and waste reduction initiatives."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total reworked units. Rework consumes capacity and signals process quality issues."
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE across production runs. The single most important manufacturing efficiency KPI."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage. One of the three OEE components — low availability signals maintenance or changeover issues."
    - name: "avg_performance_pct"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate percentage. Measures speed losses relative to ideal cycle time."
    - name: "avg_quality_pct"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate percentage. Measures first-pass yield — low quality drives scrap and rework costs."
    - name: "avg_scrap_rate_pct"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate across runs. Directly tied to material cost and quality performance."
    - name: "avg_yield_rate_pct"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate across runs. Key output quality measure for production steering."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all runs. Downtime is the primary driver of OEE loss and production shortfalls."
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(total_setup_time_minutes AS DOUBLE))
      comment: "Total setup time across runs. Reducing setup time (SMED) is a key lean lever for increasing net production time."
    - name: "avg_throughput_rate"
      expr: AVG(CAST(throughput_rate AS DOUBLE))
      comment: "Average throughput rate per run. Measures production speed against design capacity."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across runs. Used for cost-per-unit and budget variance analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across runs. Baseline for cost variance and profitability analysis."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(total_cycle_time_minutes AS DOUBLE))
      comment: "Average total cycle time per run. Compared against takt time to identify capacity gaps."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level production performance KPIs covering OEE, throughput, quality, downtime, and energy consumption. Used by shift supervisors, production managers, and plant directors for daily operational steering."
  source: "`vibe_manufacturing_v1`.`production`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: DATE_TRUNC('week', shift_date)
      comment: "Week bucket of shift date for weekly trend analysis."
    - name: "shift_date_day"
      expr: shift_date
      comment: "Exact shift date for daily drill-down analysis."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system (MES, SCADA, manual) for data quality and lineage tracking."
    - name: "escalation_required_flag"
      expr: CAST(escalation_required_flag AS STRING)
      comment: "Whether the shift required escalation — used to filter high-risk shifts for management review."
    - name: "safety_incident_flag"
      expr: CAST(safety_incident_flag AS STRING)
      comment: "Whether a safety incident occurred during the shift — critical for safety performance tracking."
    - name: "quality_hold_flag"
      expr: CAST(quality_hold_flag AS STRING)
      comment: "Whether a quality hold was placed during the shift — used to identify quality risk periods."
  measures:
    - name: "total_shifts_reported"
      expr: COUNT(1)
      comment: "Total number of shift reports. Baseline for shift coverage and reporting compliance."
    - name: "total_produced_quantity"
      expr: SUM(CAST(total_produced_quantity AS DOUBLE))
      comment: "Total units produced across all shifts. Primary throughput measure for production volume tracking."
    - name: "total_good_quantity"
      expr: SUM(CAST(actual_good_quantity AS DOUBLE))
      comment: "Total good (conforming) units produced. Directly measures quality output and first-pass yield."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped units across shifts. High scrap drives cost and quality improvement actions."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total reworked units. Rework consumes capacity and signals process instability."
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE across shifts. The headline manufacturing efficiency KPI for executive and operational dashboards."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability per shift. Low availability indicates unplanned downtime or maintenance issues."
    - name: "avg_performance_pct"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate per shift. Measures speed efficiency against ideal cycle time."
    - name: "avg_quality_pct"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate per shift. Measures first-pass yield — drives scrap and rework cost analysis."
    - name: "avg_scrap_rate_pct"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate per shift. Key quality KPI for process control and improvement prioritization."
    - name: "avg_yield_rate_pct"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate per shift. Measures output quality efficiency across the production floor."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across shifts. Primary driver of OEE loss — used to prioritize maintenance and process improvements."
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time. Denominator for availability and utilization calculations."
    - name: "total_actual_production_time_minutes"
      expr: SUM(CAST(actual_production_time_minutes AS DOUBLE))
      comment: "Total actual production time. Compared against planned to measure schedule adherence."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across shifts. Used for energy cost analysis and sustainability reporting."
    - name: "total_material_waste_quantity"
      expr: SUM(CAST(material_waste_quantity AS DOUBLE))
      comment: "Total material waste generated. Drives lean waste reduction and sustainability initiatives."
    - name: "total_changeover_time_minutes"
      expr: SUM(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Total changeover time across shifts. Reducing changeover time (SMED) directly increases available production time."
    - name: "shifts_with_safety_incidents"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shifts with safety incidents. Safety is a non-negotiable KPI — any incident triggers immediate management review."
    - name: "shifts_with_quality_holds"
      expr: SUM(CASE WHEN quality_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shifts where quality holds were placed. Indicates quality risk events requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event KPIs covering duration, frequency, production loss, OEE impact, and recurrence. Used by maintenance managers, production engineers, and plant directors to prioritize reliability improvements and reduce unplanned downtime."
  source: "`vibe_manufacturing_v1`.`production`.`production_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. Planned, Unplanned, Quality) for structured loss analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event for root-cause categorization and Pareto analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for downtime — used to identify systemic issues and prioritize corrective actions."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the downtime event for risk-based prioritization."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the downtime — used for accountability and resource allocation."
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month bucket of shift date for downtime trend analysis."
    - name: "production_downtime_event_status"
      expr: production_downtime_event_status
      comment: "Current status of the downtime event (e.g. Open, Resolved, Approved)."
    - name: "is_recurring"
      expr: CAST(is_recurring AS STRING)
      comment: "Whether the downtime event is recurring — recurring events indicate systemic reliability issues."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Frequency metric for reliability and maintenance performance tracking."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes. Primary measure of production time lost to equipment or process failures."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event. Used to assess mean time to repair and maintenance effectiveness."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime. Directly quantifies the throughput impact of reliability failures."
    - name: "total_production_loss_value"
      expr: SUM(CAST(production_loss_value AS DOUBLE))
      comment: "Total financial value of production lost due to downtime. Used to justify maintenance investment and reliability programs."
    - name: "avg_oee_impact"
      expr: AVG(CAST(impact_on_oee AS DOUBLE))
      comment: "Average OEE impact per downtime event. Quantifies how each event degrades overall equipment effectiveness."
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair across downtime events. Key maintenance KPI — high MTTR indicates repair process inefficiency."
    - name: "recurring_event_count"
      expr: SUM(CASE WHEN is_recurring = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring downtime events. Recurring failures indicate unresolved root causes requiring systemic corrective action."
    - name: "unresolved_event_count"
      expr: SUM(CASE WHEN production_downtime_event_status NOT IN ('Resolved', 'Closed', 'Approved') THEN 1 ELSE 0 END)
      comment: "Count of downtime events not yet resolved. Tracks open reliability issues requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption KPIs covering actual vs planned quantities, scrap, cost variance, and backflush compliance. Used by production planners, cost accountants, and materials managers to control material usage and cost."
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "consumption_type"
      expr: consumption_type
      comment: "Type of material consumption (e.g. Backflush, Manual, Reversal) for process compliance analysis."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the consumption record for completeness and audit tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code for material flow analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of posting date for period-based material cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost-based measures."
    - name: "backflush_indicator"
      expr: CAST(backflush_indicator AS STRING)
      comment: "Whether consumption was backflushed automatically — used to assess automation compliance."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the consumption was reversed — used to identify correction transactions."
  measures:
    - name: "total_consumption_records"
      expr: COUNT(1)
      comment: "Total number of material consumption records. Volume baseline for material tracking completeness."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual material quantity consumed. Primary measure for material usage tracking and inventory reconciliation."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity. Baseline for consumption variance analysis."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned). Positive variance indicates over-consumption driving material cost overruns."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total material scrapped during consumption. Drives material waste cost and quality improvement actions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual material cost consumed. Key input to production cost of goods manufactured."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard material cost. Baseline for cost variance and budget adherence analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(standard_cost AS DOUBLE))
      comment: "Total material cost variance (actual minus standard). Positive variance indicates cost overrun requiring investigation."
    - name: "total_total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total aggregated material cost including all components. Used for period-end cost reporting and COGS calculation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production goods receipt KPIs covering received quantities, yield, scrap, and quality inspection compliance. Used by production planners and warehouse managers to track finished goods inflow and quality gate performance."
  source: "`vibe_manufacturing_v1`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt (e.g. Posted, Reversed, Pending) for completeness tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for goods receipt classification."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) for inventory quality analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of posting date for period-based receipt volume analysis."
    - name: "quality_inspection_required"
      expr: CAST(quality_inspection_required AS STRING)
      comment: "Whether quality inspection was required — used to track quality gate compliance."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the receipt was reversed — used to identify correction transactions."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of production goods receipts. Volume baseline for finished goods inflow tracking."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received into stock. Primary measure of production output entering inventory."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity across receipts. Denominator for receipt attainment rate calculation."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity at goods receipt. Measures end-of-line quality losses."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage at goods receipt. Measures the proportion of ordered quantity successfully received as good stock."
    - name: "receipts_requiring_inspection"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring quality inspection. Used to manage inspection workload and quality gate compliance."
    - name: "reversed_receipts"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed goods receipts. High reversal rates indicate posting errors or quality rejections."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production schedule adherence and planning KPIs covering schedule attainment, capacity requirements, lot sizing, and planning horizon. Used by production planners and supply chain managers to manage schedule reliability and capacity."
  source: "`vibe_manufacturing_v1`.`production`.`production_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the production schedule (e.g. Planned, Released, Completed, Cancelled)."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (e.g. MRP, Manual, APS) for planning method analysis."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system that generated the schedule for data lineage and planning method tracking."
    - name: "lot_sizing_rule"
      expr: lot_sizing_rule
      comment: "Lot sizing rule applied (e.g. Fixed, Dynamic, Period) for planning parameter analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of scheduled start date for planning horizon analysis."
    - name: "firmed_flag"
      expr: CAST(firmed_flag AS STRING)
      comment: "Whether the schedule is firmed (frozen) — used to assess planning stability."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of production schedules. Volume baseline for planning workload and coverage analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all schedules. Drives capacity and material requirements planning."
    - name: "total_capacity_requirement_hours"
      expr: SUM(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Total capacity hours required by all schedules. Used to identify capacity constraints and overloads."
    - name: "total_run_time_hours"
      expr: SUM(CAST(run_time_hours AS DOUBLE))
      comment: "Total planned run time hours. Used for work center loading and capacity utilization analysis."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total planned setup time hours. Setup time is a key capacity consumption driver — reducing it increases available production time."
    - name: "total_lot_size_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total lot size quantity across schedules. Used for inventory and batch size optimization analysis."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned. Measures inventory buffer levels for supply risk management."
    - name: "firmed_schedule_count"
      expr: SUM(CASE WHEN firmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of firmed (frozen) schedules. Higher firmed counts indicate greater planning stability and reduced nervousness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_order_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order confirmation KPIs covering actual vs standard costs, labor and machine hours, yield, scrap, and rework. Used by production controllers and cost accountants to validate production execution against plan."
  source: "`vibe_manufacturing_v1`.`production`.`order_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of the order confirmation (e.g. Posted, Reversed, Final) for completeness tracking."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g. Partial, Final, Automatic) for process compliance analysis."
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type confirmed (e.g. Labor, Machine, Setup) for cost allocation analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of posting date for period-based cost and labor analysis."
    - name: "final_confirmation_flag"
      expr: CAST(final_confirmation_flag AS STRING)
      comment: "Whether this is a final confirmation — final confirmations close the work order and trigger cost settlement."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the confirmation was reversed — used to identify correction transactions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost-based measures."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of order confirmations. Volume baseline for production reporting completeness."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual production cost confirmed. Key input to cost of goods manufactured and variance analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost for confirmed operations. Baseline for cost variance calculation."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(standard_cost_amount AS DOUBLE))
      comment: "Total cost variance (actual minus standard) across confirmations. Positive variance indicates cost overrun."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours confirmed. Used for workforce productivity and labor cost analysis."
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(actual_machine_hours AS DOUBLE))
      comment: "Total actual machine hours confirmed. Used for equipment utilization and capacity analysis."
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total good yield quantity confirmed. Primary measure of production output quality."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity confirmed. Drives material waste cost and quality improvement actions."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total reworked quantity confirmed. Rework consumes capacity and signals process quality issues."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total setup time hours confirmed. Used for changeover efficiency and SMED improvement tracking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and efficiency KPIs covering OEE targets, utilization, efficiency rates, and capacity availability. Used by production planners and plant managers to manage work center loading and performance."
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current status of the work center (e.g. Active, Inactive, Under Maintenance)."
    - name: "work_center_category"
      expr: work_center_category
      comment: "Category of the work center (e.g. Machine, Labor, Process) for capacity planning segmentation."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category for work center loading and scheduling analysis."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type (e.g. Backwards, Forwards) for production planning method analysis."
    - name: "quality_inspection_required"
      expr: CAST(quality_inspection_required AS STRING)
      comment: "Whether quality inspection is required at this work center — used for quality gate planning."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers. Baseline for capacity network analysis."
    - name: "total_available_capacity_per_shift"
      expr: SUM(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Total available capacity hours per shift across all work centers. Used for aggregate capacity planning."
    - name: "avg_efficiency_rate_pct"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate across work centers. Measures how effectively work centers convert available time into productive output."
    - name: "avg_utilization_rate_pct"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate across work centers. High utilization indicates capacity constraints; low indicates underutilization."
    - name: "avg_oee_baseline_target_pct"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target across work centers. Used to benchmark actual OEE against targets."
    - name: "avg_standard_setup_time_minutes"
      expr: AVG(CAST(standard_setup_time_minutes AS DOUBLE))
      comment: "Average standard setup time across work centers. Used for changeover planning and SMED improvement prioritization."
    - name: "avg_standard_processing_time_minutes"
      expr: AVG(CAST(standard_processing_time_minutes AS DOUBLE))
      comment: "Average standard processing time per work center. Used for cycle time benchmarking and capacity calculation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line performance and capacity KPIs covering OEE, throughput, cycle time, MTBF/MTTR, and energy efficiency. Used by plant managers and industrial engineers to optimize line design and performance."
  source: "`vibe_manufacturing_v1`.`production`.`production_line`"
  dimensions:
    - name: "production_line_status"
      expr: production_line_status
      comment: "Current operational status of the production line."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Assembly, Machining, Packaging) for segmented performance analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line — used to correlate automation investment with OEE and throughput outcomes."
    - name: "environmental_compliance_flag"
      expr: CAST(environmental_compliance_flag AS STRING)
      comment: "Whether the line meets environmental compliance requirements — used for regulatory risk tracking."
    - name: "capacity_constraint_flag"
      expr: CAST(capacity_constraint_flag AS STRING)
      comment: "Whether the line is a capacity constraint — used to identify bottlenecks in the production network."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines. Baseline for capacity network analysis."
    - name: "avg_actual_oee_pct"
      expr: AVG(CAST(actual_oee_percentage AS DOUBLE))
      comment: "Average actual OEE across production lines. Premier line-level efficiency KPI for executive and operational dashboards."
    - name: "avg_target_oee_pct"
      expr: AVG(CAST(target_oee_percentage AS DOUBLE))
      comment: "Average OEE target across lines. Used to benchmark actual performance against design targets."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time per line. Compared against takt time to identify capacity gaps."
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time across lines. Represents customer demand rate — used to align line speed with demand."
    - name: "avg_design_throughput_rate"
      expr: AVG(CAST(design_throughput_rate AS DOUBLE))
      comment: "Average design throughput rate across lines. Baseline for actual throughput benchmarking."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across lines. Key reliability KPI — low MTBF drives maintenance investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across lines. Measures maintenance responsiveness and repair efficiency."
    - name: "avg_energy_per_unit_kwh"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced. Used for energy cost optimization and sustainability reporting."
    - name: "avg_planned_availability_hours_per_day"
      expr: AVG(CAST(planned_availability_hours_per_day AS DOUBLE))
      comment: "Average planned availability hours per day across lines. Used for capacity planning and shift scheduling."
    - name: "constrained_line_count"
      expr: SUM(CASE WHEN capacity_constraint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lines flagged as capacity constraints. Bottleneck lines require priority investment and scheduling attention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WIP lot tracking KPIs covering in-process quantities, hold quantities, scrap, completion rates, and quality inspection compliance. Used by production supervisors and quality managers to manage WIP flow and quality risk."
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the WIP lot (e.g. In Process, On Hold, Completed, Scrapped)."
    - name: "wip_lot_status"
      expr: wip_lot_status
      comment: "Operational status of the WIP lot for workflow tracking."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the WIP lot for scheduling and escalation analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lots on hold — used to identify and resolve quality or process holds."
    - name: "rework_flag"
      expr: CAST(rework_flag AS STRING)
      comment: "Whether the lot is flagged for rework — used to track rework volume and capacity impact."
    - name: "quality_inspection_required_flag"
      expr: CAST(quality_inspection_required_flag AS STRING)
      comment: "Whether quality inspection is required for the lot — used for quality gate compliance tracking."
    - name: "scheduled_completion_month"
      expr: DATE_TRUNC('month', scheduled_completion_date)
      comment: "Month bucket of scheduled completion date for WIP aging and on-time delivery analysis."
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of WIP lots. Volume baseline for WIP inventory and flow analysis."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in process. Measures WIP inventory level — high WIP ties up working capital and signals flow issues."
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity on hold. High hold quantities indicate quality or process issues blocking production flow."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP. Measures production throughput from the WIP perspective."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped from WIP. Drives material cost and quality improvement analysis."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across WIP lots. Denominator for WIP completion rate calculation."
    - name: "lots_on_hold"
      expr: SUM(CASE WHEN lot_status = 'On Hold' THEN 1 ELSE 0 END)
      comment: "Count of WIP lots currently on hold. High hold counts indicate quality or process issues requiring immediate management attention."
    - name: "lots_requiring_rework"
      expr: SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of WIP lots flagged for rework. Rework consumes capacity and signals process quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level operational and sustainability KPIs covering OEE, energy consumption, carbon emissions, water usage, waste generation, and safety performance. Used by plant directors, sustainability officers, and executives for strategic plant portfolio management."
  source: "`vibe_manufacturing_v1`.`production`.`plant`"
  dimensions:
    - name: "plant_status"
      expr: plant_status
      comment: "Current operational status of the plant (e.g. Active, Inactive, Under Construction)."
    - name: "plant_type"
      expr: plant_type
      comment: "Type of plant (e.g. Assembly, Fabrication, Distribution) for portfolio segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plant is located for geographic performance analysis."
    - name: "region"
      expr: region
      comment: "Regional grouping of plants for regional performance benchmarking."
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the plant is currently active — used to filter active vs inactive plants."
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of plants in the portfolio. Baseline for capacity network and footprint analysis."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across plants. Premier plant-level efficiency KPI for executive portfolio reviews."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across plants. Used to benchmark actual performance against strategic targets."
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total installed capacity in megawatts across the plant portfolio. Used for capacity planning and investment decisions."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption across plants. Key sustainability and cost KPI — drives energy efficiency investment decisions."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions across plants. Critical sustainability KPI for regulatory compliance and ESG reporting."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption across plants. Sustainability KPI for water stewardship and regulatory compliance."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated across plants. Sustainability KPI for waste reduction and circular economy initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order allocation KPIs covering allocated quantities, confirmation rates, release status, and allocation efficiency. Used by production planners and order managers to ensure production capacity is correctly allocated to customer orders."
  source: "`vibe_manufacturing_v1`.`production`.`work_order_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g. Planned, Confirmed, Released, Cancelled)."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g. Full, Partial, Reserved) for allocation strategy analysis."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority of the allocation for scheduling and conflict resolution analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month bucket of allocation date for trend analysis."
    - name: "is_partial_flag"
      expr: CAST(is_partial_flag AS STRING)
      comment: "Whether the allocation is partial — partial allocations indicate supply shortfalls against order demand."
    - name: "released_flag"
      expr: CAST(released_flag AS STRING)
      comment: "Whether the allocation has been released to production — used to track execution readiness."
    - name: "work_order_allocation_status"
      expr: work_order_allocation_status
      comment: "Operational status of the work order allocation record."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of work order allocations. Volume baseline for order-to-production linkage analysis."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to production work orders. Measures how much demand has been committed to production."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by production. Measures production commitment against allocated demand."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity released to production floor. Measures execution readiness of allocated orders."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity not yet fulfilled. Measures open production obligations against customer orders."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across records. Measures how fully demand is being covered by production allocations."
    - name: "partial_allocation_count"
      expr: SUM(CASE WHEN is_partial_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of partial allocations. High partial allocation counts indicate supply shortfalls requiring escalation."
    - name: "released_allocation_count"
      expr: SUM(CASE WHEN released_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of released allocations. Measures production execution readiness against planned demand."
$$;