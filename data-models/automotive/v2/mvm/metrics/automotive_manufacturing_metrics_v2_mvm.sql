-- Metric views for domain: manufacturing | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production order execution, cost performance, quality yield, and carbon footprint tracking. Enables plant operations and executive teams to monitor manufacturing efficiency, cost variance, and sustainability targets."
  source: "`vibe_automotive_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier — enables plant-level performance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level throughput and cost analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g. Released, In Progress, Completed, Closed) — used to filter active vs. completed orders."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g. Standard, Rework, Prototype) — enables segmentation of regular vs. exception manufacturing."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the production order — supports model-year cohort analysis."
    - name: "priority"
      expr: priority
      comment: "Order priority level — allows analysis of high-priority order fulfillment rates."
    - name: "production_stage"
      expr: production_stage
      comment: "Current production stage (e.g. Body Shop, Paint, Final Assembly) — enables stage-level bottleneck identification."
    - name: "order_date"
      expr: order_date
      comment: "Date the production order was created — supports time-series trending of order volumes."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the production order — used for schedule adherence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are denominated — required for multi-currency cost reporting."
  measures:
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total planned production quantity across orders. Baseline volume KPI used to assess manufacturing capacity utilization and schedule attainment."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed as produced. Directly measures actual output vs. plan — a primary throughput KPI for operations reviews."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total units scrapped across production orders. High scrap drives material cost overruns and signals process quality issues requiring intervention."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total units requiring rework. Elevated rework indicates quality escapes and inflates labor and cycle time costs."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost incurred across production orders. Core financial KPI for cost-of-goods-sold and plant P&L reporting."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) manufacturing cost. Used as the denominator for cost variance analysis against actual spend."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(standard_cost AS DOUBLE))
      comment: "Aggregate cost variance (actual minus standard). Negative values indicate favorable performance; positive values signal cost overruns requiring management action."
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per production order. Tracks unit economics over time and across plants to identify cost efficiency trends."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed. Key input for workforce productivity analysis and labor cost management."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours. Used alongside actual labor hours to compute labor efficiency ratios in the BI layer."
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(actual_machine_hours AS DOUBLE))
      comment: "Total actual machine hours consumed. Drives asset utilization analysis and maintenance scheduling decisions."
    - name: "total_planned_machine_hours"
      expr: SUM(CAST(planned_machine_hours AS DOUBLE))
      comment: "Total planned machine hours. Paired with actual machine hours to compute machine utilization efficiency."
    - name: "total_carbon_footprint_kg_co2"
      expr: SUM(CAST(carbon_footprint_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions (kg) attributed to production orders. Critical sustainability KPI for regulatory reporting and net-zero target tracking."
    - name: "avg_carbon_footprint_per_unit"
      expr: ROUND(SUM(CAST(carbon_footprint_kg_co2 AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 4)
      comment: "Average CO2 emissions per confirmed unit produced. Enables per-vehicle carbon intensity benchmarking across plants and model years."
    - name: "total_cycle_time_planned_seconds"
      expr: SUM(CAST(total_cycle_time_planned_seconds AS DOUBLE))
      comment: "Total planned cycle time in seconds across all production orders. Baseline for cycle time efficiency and takt adherence analysis."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of production orders. Baseline volume metric for order load analysis and capacity planning."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate as a percentage of target quantity. A primary quality KPI — high scrap rates trigger process audits and corrective action."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Rework rate as a percentage of target quantity. Elevated rework rates signal systemic quality issues and inflate total manufacturing cost."
    - name: "schedule_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Production schedule attainment — confirmed quantity as a percentage of target. Core operational KPI for delivery performance and capacity utilization reviews."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_vehicle_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "End-to-end vehicle build execution metrics covering cycle time, quality gate outcomes, rework incidence, carbon footprint per build, and build status distribution. Used by plant managers and quality directors to monitor build quality and throughput."
  source: "`vibe_automotive_v1`.`manufacturing`.`vehicle_build`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping dimension for plant-level build performance comparison."
    - name: "build_status"
      expr: build_status
      comment: "Current status of the vehicle build (e.g. In Progress, Complete, On Hold) — used to monitor WIP and completion rates."
    - name: "build_type"
      expr: build_type
      comment: "Type of build (e.g. Standard, Pilot, Prototype) — enables segmentation of production vs. pre-production builds."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year — supports cohort-level quality and cycle time trending."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g. BEV, PHEV, ICE) — critical for electrification strategy KPI segmentation."
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style — enables product-mix analysis of build volumes and quality outcomes."
    - name: "quality_gate_status"
      expr: quality_gate_status
      comment: "Outcome of the final quality gate inspection — used to track first-time quality pass rates."
    - name: "end_of_line_test_result"
      expr: end_of_line_test_result
      comment: "End-of-line test result (Pass/Fail) — primary quality disposition KPI at the vehicle level."
    - name: "scheduled_build_date"
      expr: scheduled_build_date
      comment: "Scheduled build date — supports daily/weekly build volume trending and schedule adherence analysis."
    - name: "paint_color_code"
      expr: paint_color_code
      comment: "Paint color code — enables color-mix analysis for paint shop capacity and changeover planning."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean flag indicating whether the vehicle required rework — used to segment rework vs. clean builds."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean flag indicating the vehicle is on hold — used to monitor hold inventory and release velocity."
  measures:
    - name: "total_builds"
      expr: COUNT(1)
      comment: "Total number of vehicle builds initiated. Primary throughput volume KPI for plant output reporting."
    - name: "total_cycle_time_seconds"
      expr: SUM(CAST(total_cycle_time_seconds AS DOUBLE))
      comment: "Total actual build cycle time in seconds across all vehicles. Used to compute average cycle time and identify throughput constraints."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(total_cycle_time_seconds AS DOUBLE))
      comment: "Average actual build cycle time per vehicle in seconds. Compared against takt time to identify lines running over cycle — a key throughput KPI."
    - name: "total_build_carbon_footprint_kg"
      expr: SUM(CAST(build_carbon_footprint_kg AS DOUBLE))
      comment: "Total CO2 equivalent (kg) attributed to vehicle builds. Sustainability KPI for regulatory reporting and per-vehicle carbon intensity tracking."
    - name: "avg_build_carbon_footprint_kg"
      expr: AVG(CAST(build_carbon_footprint_kg AS DOUBLE))
      comment: "Average carbon footprint per vehicle build. Enables per-unit carbon intensity benchmarking across plants, powertrain types, and model years."
    - name: "rework_build_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Number of vehicle builds that required rework. Directly measures quality escape volume — a primary quality KPI for plant and program reviews."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicle builds requiring rework. A leading quality indicator — sustained elevation triggers process audits and corrective action plans."
    - name: "hold_build_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of vehicle builds currently on hold. Elevated hold counts signal quality, compliance, or supply chain issues blocking vehicle release."
    - name: "eol_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN end_of_line_test_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "End-of-line test first-pass rate. A critical quality KPI — low pass rates indicate systemic build quality issues and drive warranty cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-center-level production confirmation metrics covering actual yield, scrap, rework, labor and machine hours, energy consumption, and OEE contribution. Enables operations managers to monitor station-level efficiency and quality in real time."
  source: "`vibe_automotive_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — primary grouping for station-level performance analysis."
    - name: "production_order_id"
      expr: production_order_id
      comment: "Production order identifier — links confirmations to order-level performance."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (e.g. Partial, Final) — used to filter final vs. interim confirmations."
    - name: "station_code"
      expr: station_code
      comment: "Station code within the work center — enables granular station-level quality and cycle time analysis."
    - name: "operation_number"
      expr: operation_number
      comment: "Operation number within the routing — supports operation-level throughput and defect analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the confirmation was posted — supports daily and weekly production trend analysis."
    - name: "is_final_confirmation"
      expr: is_final_confirmation
      comment: "Boolean indicating whether this is the final confirmation for the operation — used to isolate completed operations."
    - name: "oee_contribution_flag"
      expr: oee_contribution_flag
      comment: "Boolean flag indicating whether this confirmation contributes to OEE calculation — used to filter OEE-relevant records."
  measures:
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total good units yielded across all confirmations. Primary output volume KPI for work center throughput reporting."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total units scrapped at work centers. Drives scrap cost analysis and quality improvement prioritization."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total units requiring rework identified at confirmation. Elevated rework at specific stations signals process or tooling issues."
    - name: "first_pass_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(yield_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)) + SUM(CAST(scrap_quantity AS DOUBLE)) + SUM(CAST(rework_quantity AS DOUBLE)), 0), 2)
      comment: "First-pass yield percentage — good units as a share of total output including scrap and rework. A foundational quality KPI for work center and line performance reviews."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed at work centers. Key input for workforce productivity and labor cost analysis."
    - name: "total_machine_hours"
      expr: SUM(CAST(machine_hours AS DOUBLE))
      comment: "Total machine hours consumed. Drives asset utilization analysis and informs maintenance scheduling."
    - name: "total_energy_consumed_kwh"
      expr: SUM(CAST(energy_consumed_kwh AS DOUBLE))
      comment: "Total energy consumed (kWh) across work center confirmations. Sustainability KPI for energy intensity monitoring and carbon reduction programs."
    - name: "avg_actual_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_actual_seconds AS DOUBLE))
      comment: "Average actual cycle time per confirmation in seconds. Compared against standard cycle time to identify stations running over takt — a core throughput KPI."
    - name: "total_actual_cycle_time_seconds"
      expr: SUM(CAST(cycle_time_actual_seconds AS DOUBLE))
      comment: "Total actual cycle time in seconds. Used alongside planned cycle time to compute aggregate cycle time efficiency at the work center level."
    - name: "avg_energy_per_unit_kwh"
      expr: ROUND(SUM(CAST(energy_consumed_kwh AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)), 0), 4)
      comment: "Average energy consumed per good unit produced (kWh/unit). Tracks energy intensity trends — a key sustainability and operational efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_material_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption metrics covering actual vs. planned quantities, cost, variance, scrap, and recycled content. Enables supply chain and plant finance teams to monitor material efficiency, cost control, and sustainability performance."
  source: "`vibe_automotive_v1`.`manufacturing`.`material_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping for plant-level material cost and efficiency analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where material was consumed — enables station-level material usage analysis."
    - name: "production_order_id"
      expr: production_order_id
      comment: "Production order associated with the consumption — links material usage to order-level cost."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the material consumption record — used to filter confirmed vs. pending consumption."
    - name: "goods_movement_type"
      expr: goods_movement_type
      comment: "SAP goods movement type — distinguishes standard consumption, reversals, and scrap postings."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of material cost — required for multi-currency cost consolidation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities — ensures correct aggregation across compatible UoMs."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the consumption was posted — supports time-series material cost trending."
    - name: "scrap_indicator"
      expr: scrap_indicator
      comment: "Boolean flag indicating whether the consumption was a scrap posting — used to isolate scrap material costs."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag indicating a reversal posting — used to exclude reversals from net consumption analysis."
  measures:
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total material quantity consumed in production. Baseline volume KPI for material usage monitoring and BOM accuracy validation."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity per production orders. Used alongside actual consumption to compute material efficiency ratios."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total material quantity variance (actual minus planned). Persistent positive variance signals BOM inaccuracies or process waste requiring corrective action."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost incurred. Core financial KPI for cost-of-goods-sold and plant material budget tracking."
    - name: "avg_material_cost_per_consumption"
      expr: AVG(CAST(material_cost_amount AS DOUBLE))
      comment: "Average material cost per consumption record. Tracks unit material cost trends and supports price variance analysis."
    - name: "material_quantity_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_consumed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Material quantity efficiency — actual consumption as a percentage of planned. Values above 100% indicate over-consumption; below 100% indicate favorable usage."
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_pct AS DOUBLE))
      comment: "Average recycled content percentage across consumed materials. Sustainability KPI for circular economy and regulatory reporting on recycled material usage."
    - name: "scrap_material_cost"
      expr: SUM(CASE WHEN scrap_indicator = TRUE THEN material_cost_amount ELSE 0 END)
      comment: "Total material cost attributed to scrap postings. Directly quantifies the financial impact of material waste — a key cost reduction target."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs covering utilization, OEE targets, available vs. required capacity, energy budgets, and cycle time constraints. Enables manufacturing engineering and plant management to identify capacity gaps and optimize resource allocation."
  source: "`vibe_automotive_v1`.`manufacturing`.`capacity_plan`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping for plant-level capacity analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line — enables line-level capacity gap identification."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center — supports granular work-center capacity utilization analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (e.g. Draft, Approved, Active) — used to filter active plans for operational reporting."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (e.g. Rough-Cut, Detailed, Finite) — enables comparison across planning horizons."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern associated with the plan — supports shift-level capacity analysis."
    - name: "plan_period_start"
      expr: plan_period_start
      comment: "Start date of the planning period — supports time-series capacity trend analysis."
    - name: "plan_period_end"
      expr: plan_period_end
      comment: "End date of the planning period — used to scope capacity analysis to specific planning horizons."
    - name: "sustainability_constraint_flag"
      expr: sustainability_constraint_flag
      comment: "Boolean flag indicating whether a sustainability constraint applies — used to segment plans with green manufacturing constraints."
  measures:
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours across plans. Baseline supply-side capacity KPI for resource planning and shift optimization."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total required capacity hours to fulfill planned production. Compared against available hours to identify capacity gaps."
    - name: "capacity_gap_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE) - CAST(required_capacity_hours AS DOUBLE))
      comment: "Net capacity gap (available minus required) in hours. Negative values indicate capacity shortfalls requiring overtime, additional shifts, or outsourcing decisions."
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average planned capacity utilization percentage. A primary capacity KPI — values consistently above 85% signal risk of schedule disruption; below 70% indicate underutilization."
    - name: "avg_oee_target_pct"
      expr: AVG(CAST(oee_target_pct AS DOUBLE))
      comment: "Average OEE (Overall Equipment Effectiveness) target across capacity plans. Tracks the ambition level of manufacturing efficiency targets — a key operational excellence KPI."
    - name: "total_energy_budget_kwh"
      expr: SUM(CAST(energy_budget_kwh AS DOUBLE))
      comment: "Total energy budget (kWh) across capacity plans. Sustainability KPI for energy planning and carbon budget management."
    - name: "avg_cycle_time_constraint_seconds"
      expr: AVG(CAST(cycle_time_constraint_seconds AS DOUBLE))
      comment: "Average cycle time constraint in seconds across capacity plans. Tracks takt time feasibility — constraints tighter than actual cycle times signal bottleneck risk."
    - name: "capacity_utilization_ratio"
      expr: ROUND(SUM(CAST(required_capacity_hours AS DOUBLE)) / NULLIF(SUM(CAST(available_capacity_hours AS DOUBLE)), 0), 4)
      comment: "Ratio of required to available capacity hours. Values above 1.0 indicate overloaded capacity requiring immediate management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_rework_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rework order metrics covering rework cost, hours variance, defect patterns, safety-related rework incidence, and waste generation. Enables quality and plant management to quantify the cost of poor quality and prioritize defect elimination programs."
  source: "`vibe_automotive_v1`.`manufacturing`.`rework_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping for plant-level rework cost and volume analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where rework is performed — identifies stations with highest rework burden."
    - name: "rework_status"
      expr: rework_status
      comment: "Current status of the rework order (e.g. Open, In Progress, Closed) — used to monitor open rework backlog."
    - name: "rework_type"
      expr: rework_type
      comment: "Type of rework (e.g. Cosmetic, Functional, Safety) — enables prioritization of safety-critical rework."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code driving the rework — used for Pareto analysis of top defect categories."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the rework order — used to monitor high-priority rework completion rates."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Boolean flag indicating safety-related rework — safety rework requires expedited tracking and regulatory reporting."
    - name: "re_inspection_required"
      expr: re_inspection_required
      comment: "Boolean flag indicating whether re-inspection is required after rework — used to track re-inspection workload."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of rework cost — required for multi-currency cost consolidation."
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the rework order was created — supports time-series rework trend analysis."
  measures:
    - name: "total_rework_orders"
      expr: COUNT(1)
      comment: "Total number of rework orders. Baseline volume KPI for rework incidence tracking — sustained increases trigger quality system reviews."
    - name: "total_rework_cost"
      expr: SUM(CAST(rework_cost AS DOUBLE))
      comment: "Total cost of rework across all orders. Directly quantifies the cost of poor quality — a primary financial KPI for quality improvement ROI analysis."
    - name: "avg_rework_cost_per_order"
      expr: AVG(CAST(rework_cost AS DOUBLE))
      comment: "Average rework cost per order. Tracks unit rework cost trends and enables comparison across defect types and work centers."
    - name: "total_actual_rework_hours"
      expr: SUM(CAST(actual_rework_hours AS DOUBLE))
      comment: "Total actual labor hours consumed on rework. Quantifies the labor burden of quality failures — drives workforce reallocation decisions."
    - name: "total_planned_rework_hours"
      expr: SUM(CAST(planned_rework_hours AS DOUBLE))
      comment: "Total planned rework hours. Used alongside actual hours to compute rework labor efficiency."
    - name: "rework_hours_variance"
      expr: SUM(CAST(actual_rework_hours AS DOUBLE) - CAST(planned_rework_hours AS DOUBLE))
      comment: "Aggregate rework hours variance (actual minus planned). Positive variance indicates rework complexity is being underestimated — signals process or tooling issues."
    - name: "safety_related_rework_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Number of safety-related rework orders. Safety rework is a regulatory and liability KPI — any increase requires immediate escalation and root cause analysis."
    - name: "safety_rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rework orders that are safety-related. A critical quality and compliance KPI — high rates indicate systemic safety design or process failures."
    - name: "total_waste_generated_kg"
      expr: SUM(CAST(waste_generated_kg AS DOUBLE))
      comment: "Total waste generated (kg) from rework activities. Sustainability KPI linking quality failures to environmental impact — used in waste reduction programs."
    - name: "avg_waste_per_rework_order_kg"
      expr: AVG(CAST(waste_generated_kg AS DOUBLE))
      comment: "Average waste generated per rework order (kg). Tracks waste intensity of rework — enables comparison across defect types and rework methods."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line asset and performance metrics covering throughput rates, takt time, energy consumption, automation levels, and maintenance status. Enables manufacturing engineering and plant leadership to benchmark line performance and plan capital investments."
  source: "`vibe_automotive_v1`.`manufacturing`.`production_line`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping for plant-level line performance comparison."
    - name: "line_status"
      expr: line_status
      comment: "Current operational status of the production line (e.g. Active, Idle, Maintenance) — used to filter active lines for throughput analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Assembly, Body Shop, Paint) — enables cross-line-type performance benchmarking."
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level of the line — used to analyze the relationship between automation investment and throughput/quality outcomes."
    - name: "energy_source_type"
      expr: energy_source_type
      comment: "Energy source type (e.g. Grid, Renewable) — supports sustainability segmentation of energy consumption KPIs."
    - name: "powertrain_type_capability"
      expr: powertrain_type_capability
      comment: "Powertrain types the line is capable of producing — critical for electrification capacity planning."
    - name: "mixed_model_capable"
      expr: mixed_model_capable
      comment: "Boolean indicating mixed-model production capability — used to assess flexibility for demand mix changes."
    - name: "sop_date"
      expr: sop_date
      comment: "Start of production date — used to analyze line age and performance maturity curves."
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status of the line — compliance KPI for regulatory and audit reporting."
  measures:
    - name: "total_lines"
      expr: COUNT(1)
      comment: "Total number of production lines. Baseline asset count for capacity portfolio analysis."
    - name: "avg_current_jph"
      expr: AVG(CAST(current_jph AS DOUBLE))
      comment: "Average current jobs-per-hour (JPH) across production lines. Primary throughput KPI — compared against designed JPH to measure line performance degradation."
    - name: "avg_designed_jph"
      expr: AVG(CAST(designed_jph AS DOUBLE))
      comment: "Average designed (nameplate) jobs-per-hour. Baseline capacity benchmark for throughput gap analysis."
    - name: "avg_jph_attainment_pct"
      expr: ROUND(100.0 * AVG(CAST(current_jph AS DOUBLE)) / NULLIF(AVG(CAST(designed_jph AS DOUBLE)), 0), 2)
      comment: "Average JPH attainment as a percentage of designed capacity. A core throughput efficiency KPI — values below 85% trigger line performance investigations."
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds across production lines. Fundamental pacing KPI — deviations from customer demand rate drive schedule and staffing adjustments."
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced (kWh/unit) across lines. Sustainability KPI for energy intensity benchmarking and green manufacturing programs."
    - name: "total_floor_space_sqm"
      expr: SUM(CAST(floor_space_sqm AS DOUBLE))
      comment: "Total floor space (sqm) occupied by production lines. Asset utilization KPI for facility planning and space optimization decisions."
    - name: "avg_line_length_meters"
      expr: AVG(CAST(line_length_meters AS DOUBLE))
      comment: "Average production line length in meters. Physical asset metric used in facility layout and expansion planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center asset efficiency and cost metrics covering capacity utilization, labor and machine rates, energy consumption, reliability (MTBF/MTTR), and quality gate coverage. Enables plant engineering and finance to optimize work center investments and maintenance strategies."
  source: "`vibe_automotive_v1`.`manufacturing`.`work_center`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant — primary grouping for plant-level work center analysis."
    - name: "work_center_status"
      expr: work_center_status
      comment: "Operational status of the work center (e.g. Active, Inactive, Under Maintenance) — used to filter active assets."
    - name: "work_center_type"
      expr: work_center_type
      comment: "Type of work center (e.g. Assembly, Welding, Paint, Inspection) — enables cross-type performance benchmarking."
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level of the work center — used to analyze automation ROI on throughput and quality."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category of the work center — used for capacity planning segmentation."
    - name: "is_bottleneck"
      expr: is_bottleneck
      comment: "Boolean flag indicating whether the work center is a known bottleneck — critical for constraint management and investment prioritization."
    - name: "is_quality_gate"
      expr: is_quality_gate
      comment: "Boolean flag indicating whether the work center is a quality gate — used to analyze quality gate coverage and effectiveness."
    - name: "process_category"
      expr: process_category
      comment: "Process category of the work center — enables process-level cost and efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost rates — required for multi-currency cost consolidation."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers. Baseline asset count for capacity portfolio and maintenance planning."
    - name: "total_available_capacity_hours_per_day"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across all work centers. Aggregate supply-side capacity KPI for daily production planning."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time per work center in seconds. Compared against takt time to identify stations running over cycle — a primary throughput constraint KPI."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour across work centers. Used in cost modeling and make-vs-buy analysis for manufacturing operations."
    - name: "avg_machine_rate_per_hour"
      expr: AVG(CAST(machine_rate_per_hour AS DOUBLE))
      comment: "Average machine rate per hour. Key input for product costing, capacity pricing, and capital investment justification."
    - name: "avg_energy_consumption_kw"
      expr: AVG(CAST(energy_consumption_kw AS DOUBLE))
      comment: "Average energy consumption (kW) per work center. Sustainability KPI for energy intensity benchmarking and carbon reduction targeting."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average MTBF (Mean Time Between Failures) in hours. A primary equipment reliability KPI — low MTBF drives unplanned downtime and schedule disruption."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average MTTR (Mean Time To Repair) in hours. Measures maintenance responsiveness — high MTTR amplifies the impact of failures on production throughput."
    - name: "bottleneck_work_center_count"
      expr: COUNT(CASE WHEN is_bottleneck = TRUE THEN 1 END)
      comment: "Number of work centers flagged as bottlenecks. Tracks constraint concentration — a high count signals systemic capacity imbalance requiring investment or rebalancing."
    - name: "quality_gate_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_quality_gate = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work centers that are quality gates. Tracks quality inspection coverage across the manufacturing process — low coverage increases escape risk."
$$;