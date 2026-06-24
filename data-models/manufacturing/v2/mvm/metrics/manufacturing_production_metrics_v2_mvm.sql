-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production work orders covering throughput, quality, cost efficiency, OEE, and schedule adherence. Primary steering dashboard for manufacturing operations leadership."
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (e.g. Released, In-Progress, Completed, Closed) — used to filter active vs. historical performance."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Classification of the work order (e.g. Standard, Rework, Repair) — enables segmentation of production vs. rework volumes."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the work order — supports triage and escalation analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of the planned start date — enables trend analysis of production scheduling over time."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Month bucket of the planned finish date — used for capacity and delivery planning analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are denominated — required for multi-currency cost comparisons."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities produced — ensures consistent volume comparisons across product lines."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for production throughput tracking."
    - name: "total_actual_quantity_produced"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total units actually produced across all work orders — primary throughput KPI for manufacturing output."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total units planned for production — denominator for schedule attainment and plan vs. actual analysis."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total units scrapped — direct quality and waste KPI; high scrap drives cost and yield investigations."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred — core cost management KPI for manufacturing P&L."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) production cost — denominator for cost variance analysis."
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total value of work-in-progress inventory — critical for working capital and inventory management decisions."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across work orders — top-level manufacturing efficiency KPI used in executive steering reviews."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage — quality KPI directly tied to material cost and customer satisfaction outcomes."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate percentage — inverse of scrap rate; measures the proportion of good output from total production input."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order in minutes — operational efficiency KPI; deviations signal bottlenecks or process drift."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work order in minutes — changeover efficiency metric; reduction drives throughput improvement."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all work orders — availability loss KPI; directly impacts OEE and production capacity."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across open work orders — schedule attainment indicator for in-flight production."
    - name: "distinct_active_work_orders"
      expr: COUNT(DISTINCT production_work_order_id)
      comment: "Count of distinct work orders — used to validate volume counts and support per-order ratio calculations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring finished goods receipt performance from production — covering yield, receipt volumes, scrap at receipt, and quality inspection rates. Used by supply chain and production management to assess output quality and delivery reliability."
  source: "`vibe_manufacturing_v1`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "production_goods_receipt_status"
      expr: production_goods_receipt_status
      comment: "Status of the goods receipt document — enables filtering of completed vs. reversed or pending receipts."
    - name: "gr_status"
      expr: gr_status
      comment: "Goods receipt processing status — used to segment receipts by processing state for operational tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP/ERP movement type code for the goods receipt — distinguishes standard receipts from reversals and special movements."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) — critical for inventory availability analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of the goods receipt posting date — enables trend analysis of production output over time."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the goods receipt — aligns production output metrics with financial reporting periods."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the goods receipt — supports year-over-year production output comparisons."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether a quality inspection was required at receipt — used to segment high-risk vs. standard receipts."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities — ensures consistent volume comparisons."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of production goods receipt transactions — baseline throughput volume for finished goods output."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of finished goods received from production — primary output volume KPI for supply chain and production management."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total quantity ordered on the associated production work orders — denominator for receipt fill-rate and schedule attainment calculations."
    - name: "total_scrap_quantity_at_receipt"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity recorded at goods receipt — quality KPI measuring end-of-production waste before inventory posting."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage at goods receipt — measures the proportion of good output relative to ordered quantity; key quality and efficiency KPI."
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed goods receipts — operational quality indicator; high reversals signal process or data integrity issues."
    - name: "quality_inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring quality inspection — risk exposure metric for quality management; drives inspection resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for bill-of-materials material consumption during production — covering actual vs. planned usage, cost variance, scrap, and backflush efficiency. Used by production controllers and cost accountants to manage material efficiency and variance."
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "bom_consumption_status"
      expr: bom_consumption_status
      comment: "Status of the BOM consumption record — used to filter active, reversed, or completed consumption entries."
    - name: "consumption_type"
      expr: consumption_type
      comment: "Type of material consumption (e.g. Backflush, Manual, Automatic) — enables analysis of consumption method efficiency."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Processing status of the consumption transaction — supports operational tracking of open vs. posted consumptions."
    - name: "movement_type"
      expr: movement_type
      comment: "ERP movement type for the goods issue — distinguishes standard consumption from reversals and special movements."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates whether consumption was recorded via backflushing — used to segment automated vs. manual consumption for process analysis."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating quality inspection was required for the consumed material — risk segmentation for quality management."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of the consumption posting date — enables trend analysis of material usage over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost values — required for multi-currency cost variance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for consumed quantities — ensures consistent volume comparisons across materials."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code explaining quantity variance — used to categorize and investigate root causes of material over/under-consumption."
  measures:
    - name: "total_consumption_transactions"
      expr: COUNT(1)
      comment: "Total number of BOM consumption transactions — baseline volume for material usage activity."
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual material quantity consumed in production — primary material usage KPI for cost and efficiency management."
    - name: "total_planned_quantity_consumed"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity for consumption — denominator for material usage variance analysis."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned) — material efficiency KPI; positive variance indicates over-consumption driving cost overruns."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total material quantity scrapped during consumption — waste KPI directly tied to material cost and sustainability targets."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual material cost consumed — core cost management KPI for production cost accounting."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard material cost for consumed quantities — budget baseline for cost variance calculation."
    - name: "total_cost_variance"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of consumption transactions as recorded — used alongside standard cost to compute cost variance in BI layer."
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed consumption transactions — data quality and process integrity KPI; high reversals indicate posting errors or process issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for production scheduling performance — covering plan adherence, capacity utilization, schedule stability, and lead time. Used by production planners and supply chain managers to optimize scheduling and meet delivery commitments."
  source: "`vibe_manufacturing_v1`.`production`.`production_schedule`"
  dimensions:
    - name: "production_schedule_status"
      expr: production_schedule_status
      comment: "Current status of the production schedule (e.g. Planned, Firmed, Released, Completed) — primary filter for active vs. historical schedule analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Detailed schedule processing status — used for operational tracking of schedule lifecycle."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (e.g. MRP, Manual, Forecast) — enables segmentation of demand-driven vs. supply-driven schedules."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system or process that generated the schedule — used to assess planning system effectiveness."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Indicates whether the schedule has been firmed (frozen from MRP changes) — used to measure schedule stability and planning horizon discipline."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled production start date — enables trend analysis of production planning volumes over time."
    - name: "scheduled_finish_date"
      expr: DATE_TRUNC('month', scheduled_finish_date)
      comment: "Month bucket of the scheduled finish date — used for delivery commitment and capacity planning analysis."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (e.g. Day, Week, Month) — used to segment schedule granularity for capacity analysis."
    - name: "lot_sizing_rule"
      expr: lot_sizing_rule
      comment: "Lot sizing rule applied to the schedule — used to analyze inventory and batch size optimization strategies."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for scheduled quantities — ensures consistent volume comparisons."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total number of production schedule lines — baseline volume metric for planning workload and schedule complexity."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity planned for production across all schedule lines — primary volume KPI for production planning and capacity management."
    - name: "total_capacity_requirement_hours"
      expr: SUM(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Total capacity hours required by the production schedule — critical for capacity planning and bottleneck identification."
    - name: "total_run_time_hours"
      expr: SUM(CAST(run_time_hours AS DOUBLE))
      comment: "Total planned run time hours across schedule lines — used to assess production load and resource utilization."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total planned setup time hours — changeover burden metric; high setup time relative to run time signals inefficient batch sizing."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned — inventory buffer KPI; used to assess risk coverage and working capital tied up in safety stock."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size across schedule lines — batch sizing efficiency KPI; drives changeover frequency and inventory carrying cost decisions."
    - name: "firmed_schedule_count"
      expr: SUM(CASE WHEN firmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of firmed (frozen) schedule lines — schedule stability KPI; low firmed ratio indicates planning instability and execution risk."
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedule lines requiring approval — governance and bottleneck metric; high counts may delay production release."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for production line performance and capacity — covering OEE, throughput rates, reliability (MTBF/MTTR), energy efficiency, and changeover performance. Used by plant managers and operations directors to drive continuous improvement and capital investment decisions."
  source: "`vibe_manufacturing_v1`.`production`.`production_line`"
  dimensions:
    - name: "production_line_status"
      expr: production_line_status
      comment: "Current operational status of the production line — primary filter for active vs. inactive line performance analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Assembly, Fabrication, Packaging) — enables benchmarking across line categories."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line (e.g. Manual, Semi-Automated, Fully Automated) — used to correlate automation investment with OEE and throughput outcomes."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern assigned to the line — used to normalize performance metrics by operating hours."
    - name: "capacity_constraint_flag"
      expr: capacity_constraint_flag
      comment: "Indicates whether the line is a capacity constraint (bottleneck) — critical for production scheduling and investment prioritization."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the line meets environmental compliance requirements — regulatory and ESG risk dimension."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether quality inspection is required on this line — used to segment lines by quality risk profile."
    - name: "commissioning_date"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the production line was commissioned — used to analyze performance trends by asset age and investment vintage."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines — baseline asset count for capacity and investment portfolio management."
    - name: "avg_actual_oee_percentage"
      expr: AVG(CAST(actual_oee_percentage AS DOUBLE))
      comment: "Average actual OEE percentage across production lines — top-level manufacturing effectiveness KPI used in executive and board-level reviews."
    - name: "avg_target_oee_percentage"
      expr: AVG(CAST(target_oee_percentage AS DOUBLE))
      comment: "Average target OEE percentage — benchmark for OEE gap analysis; difference from actual OEE drives improvement investment decisions."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours — equipment reliability KPI; low MTBF drives maintenance strategy and capital replacement decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours — maintenance responsiveness KPI; high MTTR indicates repair capability gaps impacting availability."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time per unit in seconds — throughput rate KPI; deviations from takt time signal capacity or quality issues."
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds — customer demand rate benchmark; used to assess whether line speed matches demand pace."
    - name: "avg_changeover_time_minutes"
      expr: AVG(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Average changeover time in minutes — flexibility and efficiency KPI; reduction directly increases available production time."
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced (kWh) — sustainability and cost efficiency KPI; drives energy reduction investment decisions."
    - name: "total_planned_availability_hours_per_day"
      expr: SUM(CAST(planned_availability_hours_per_day AS DOUBLE))
      comment: "Total planned availability hours per day across all lines — aggregate capacity baseline for production planning."
    - name: "constrained_line_count"
      expr: SUM(CASE WHEN capacity_constraint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lines flagged as capacity constraints — bottleneck exposure metric; drives prioritization of capacity expansion investments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for work-in-progress lot management — covering WIP volume, hold exposure, scrap, rework rates, and completion progress. Used by production supervisors and quality managers to manage in-process inventory risk and flow efficiency."
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "wip_lot_status"
      expr: wip_lot_status
      comment: "Current status of the WIP lot (e.g. In-Process, On-Hold, Completed, Scrapped) — primary filter for active vs. closed WIP analysis."
    - name: "lot_status"
      expr: lot_status
      comment: "Detailed lot processing status — used for granular WIP flow and bottleneck analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the WIP lot — used to triage high-priority lots and assess expediting exposure."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lots placed on hold — root cause analysis dimension for WIP hold management and quality investigations."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped lots — quality and waste root cause dimension; drives corrective action prioritization."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether the lot is undergoing rework — used to quantify rework volume and associated cost exposure."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether quality inspection is required for the lot — risk segmentation for quality resource planning."
    - name: "scheduled_completion_date"
      expr: DATE_TRUNC('month', scheduled_completion_date)
      comment: "Month bucket of the scheduled lot completion date — used for WIP aging and delivery commitment analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for lot quantities — ensures consistent volume comparisons."
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of WIP lots — baseline volume metric for in-process inventory complexity and flow management."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in process across all WIP lots — primary WIP inventory volume KPI for production flow management."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP lots — throughput output KPI measuring production completion performance."
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity on hold across WIP lots — risk exposure KPI; high hold quantities signal quality or supply issues blocking production flow."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped from WIP lots — waste and quality KPI directly tied to material cost and yield performance."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered on WIP lots — denominator for WIP completion rate and yield calculations in the BI layer."
    - name: "rework_lot_count"
      expr: SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of WIP lots flagged for rework — quality cost exposure metric; high rework counts drive process improvement and cost reduction actions."
    - name: "on_hold_lot_count"
      expr: SUM(CASE WHEN lot_status = 'On-Hold' THEN 1 ELSE 0 END)
      comment: "Count of WIP lots currently on hold — operational risk KPI; held lots represent blocked production capacity and potential delivery delays."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for manufacturing plant performance — covering OEE, energy consumption, carbon emissions, waste generation, and safety. Used by operations executives and sustainability officers to steer plant investment, compliance, and ESG reporting."
  source: "`vibe_manufacturing_v1`.`production`.`plant`"
  dimensions:
    - name: "plant_status"
      expr: plant_status
      comment: "Operational status of the plant (e.g. Active, Inactive, Under Maintenance) — primary filter for active plant performance analysis."
    - name: "plant_type"
      expr: plant_type
      comment: "Type of manufacturing plant (e.g. Assembly, Fabrication, Distribution) — enables benchmarking across plant categories."
    - name: "region"
      expr: region
      comment: "Geographic region of the plant — used for regional performance benchmarking and resource allocation decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plant is located — used for regulatory compliance segmentation and international performance comparison."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the plant is currently active — used to filter operational vs. closed plants."
    - name: "next_maintenance_date"
      expr: DATE_TRUNC('month', next_maintenance_date)
      comment: "Month bucket of the next scheduled maintenance date — used for maintenance planning and capacity risk forecasting."
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of plants in the portfolio — baseline asset count for capacity and investment management."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across plants — top-level plant effectiveness KPI used in executive steering and board reporting."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across plants — benchmark for OEE gap analysis; drives plant improvement investment prioritization."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across all plants — sustainability and cost KPI; drives energy efficiency investment and carbon reduction programs."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg across all plants — ESG and regulatory compliance KPI; directly tied to sustainability targets and carbon reporting obligations."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons across all plants — environmental KPI for waste reduction programs and regulatory compliance."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters — resource efficiency and sustainability KPI; critical for water-stressed regions and ESG reporting."
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total installed capacity in MW across all plants — strategic capacity baseline for production planning and investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for work center performance and capacity — covering efficiency rates, utilization, OEE baseline targets, and capacity availability. Used by production planners and operations managers to optimize work center loading and identify improvement opportunities."
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current operational status of the work center — primary filter for active vs. inactive work center analysis."
    - name: "category"
      expr: category
      comment: "Category of the work center (e.g. Machine, Labor, External) — enables segmentation of capacity by resource type."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity planning category assigned to the work center — used for capacity grouping and load balancing analysis."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type for the work center (e.g. Finite, Infinite) — used to identify capacity-constrained vs. unconstrained resources."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Indicates whether quality inspection is required at this work center — risk segmentation for quality resource planning."
    - name: "valid_from_date"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year the work center became valid — used to analyze performance by asset age and configuration vintage."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers — baseline asset count for capacity portfolio management."
    - name: "avg_efficiency_rate_percent"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate percentage across work centers — operational performance KPI; deviations from 100% drive labor and process improvement actions."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate percentage — capacity loading KPI; low utilization signals underused assets, high utilization signals bottleneck risk."
    - name: "avg_oee_baseline_target_percent"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target percentage across work centers — benchmark for work center performance gap analysis."
    - name: "total_available_capacity_per_shift"
      expr: SUM(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Total available capacity per shift across all work centers — aggregate capacity supply metric for production scheduling and load balancing."
    - name: "avg_standard_queue_time_hours"
      expr: AVG(CAST(standard_queue_time_hours AS DOUBLE))
      comment: "Average standard queue time in hours — lead time component KPI; high queue times inflate manufacturing lead times and reduce delivery responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for production routing efficiency — covering total operation counts, labor and machine time, setup time, and lead time. Used by process engineers and production planners to optimize routing structures and reduce manufacturing lead times."
  source: "`vibe_manufacturing_v1`.`production`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Current status of the routing (e.g. Active, Obsolete, In-Review) — primary filter for valid vs. deprecated routings."
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing (e.g. Standard, Reference, Rate) — enables segmentation of routing structures for process analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the routing — governance KPI dimension; unapproved routings in production signal process control gaps."
    - name: "is_default_routing"
      expr: is_default_routing
      comment: "Indicates whether this is the default routing for the material — used to distinguish primary vs. alternate process paths."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type applied to the routing — used to segment finite vs. infinite capacity routings."
    - name: "valid_from_date"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year the routing became valid — used to analyze routing age and identify candidates for process modernization."
  measures:
    - name: "total_routings"
      expr: COUNT(1)
      comment: "Total number of routings — baseline count for process complexity and routing portfolio management."
    - name: "avg_total_labor_time_minutes"
      expr: AVG(CAST(total_labor_time_minutes AS DOUBLE))
      comment: "Average total labor time per routing in minutes — labor content KPI; drives labor cost estimation and workforce planning."
    - name: "avg_total_machine_time_minutes"
      expr: AVG(CAST(total_machine_time_minutes AS DOUBLE))
      comment: "Average total machine time per routing in minutes — machine utilization input KPI; used for capacity planning and bottleneck analysis."
    - name: "avg_total_setup_time_minutes"
      expr: AVG(CAST(total_setup_time_minutes AS DOUBLE))
      comment: "Average total setup time per routing in minutes — changeover burden KPI; reduction drives throughput improvement and flexibility."
    - name: "avg_total_lead_time_hours"
      expr: AVG(CAST(total_lead_time_hours AS DOUBLE))
      comment: "Average total manufacturing lead time per routing in hours — delivery responsiveness KPI; directly impacts customer promise dates and inventory levels."
    - name: "avg_total_operation_count"
      expr: AVG(CAST(total_operation_count AS DOUBLE))
      comment: "Average number of operations per routing — process complexity KPI; high operation counts increase lead time and quality risk."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost across all routings — aggregate cost baseline for routing cost management and variance analysis."
$$;