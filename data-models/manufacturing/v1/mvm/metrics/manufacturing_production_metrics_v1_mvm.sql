-- Metric views for domain: production | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production runs covering throughput efficiency, quality yield, scrap loss, downtime impact, and OEE performance. Primary steering dashboard for operations leadership."
  source: "`manufacturing_ecm`.`production`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the production run (e.g. In Progress, Completed, Cancelled) — used to filter active vs. closed runs."
    - name: "run_type"
      expr: run_type
      comment: "Classification of the run (e.g. Standard, Rework, Trial) — enables segmentation of performance by run category."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the run — supports triage of high-priority production performance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities produced — ensures consistent aggregation across product families."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which cost values are denominated — required for multi-currency cost analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('day', planned_start_timestamp)
      comment: "Planned start date of the run — used for scheduling adherence and trend analysis."
    - name: "actual_start_date"
      expr: DATE_TRUNC('day', actual_start_timestamp)
      comment: "Actual start date of the run — used to measure schedule adherence vs. planned start."
    - name: "actual_finish_date"
      expr: DATE_TRUNC('day', actual_finish_timestamp)
      comment: "Actual finish date of the run — used for on-time completion analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level performance segmentation."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to the work center — enables work-center-level throughput and efficiency analysis."
    - name: "shift_id"
      expr: shift_id
      comment: "Foreign key to the shift — enables shift-level performance comparison."
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "Foreign key to the SKU master — enables product-level yield and scrap analysis."
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of production runs — baseline volume metric for capacity and throughput planning."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity planned across all runs — used to assess production plan coverage and capacity utilization."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total quantity actually produced — primary output volume KPI for operations leadership."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped units across all runs — directly tied to material cost loss and quality performance."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total reworked units — indicates hidden quality cost and process instability."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate (%) across runs — key quality KPI; rising scrap rate triggers material cost and process investigations."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate (%) across runs — measures the proportion of good output vs. total input; core quality and efficiency KPI."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across runs — the single most important manufacturing efficiency KPI used in executive steering reviews."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability (%) — OEE availability pillar; low values indicate excessive downtime or maintenance issues."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate (%) — OEE performance pillar; measures speed losses vs. ideal cycle time."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate (%) — OEE quality pillar; measures first-pass yield contribution to OEE."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost across all runs — used for cost variance analysis against standard cost."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (budgeted) production cost — baseline for cost variance and profitability analysis."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all runs — directly impacts throughput capacity and OEE; triggers maintenance and scheduling interventions."
    - name: "avg_throughput_rate"
      expr: AVG(CAST(throughput_rate AS DOUBLE))
      comment: "Average throughput rate per run — measures production speed; used to identify bottlenecks and capacity constraints."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(total_cycle_time_minutes AS DOUBLE))
      comment: "Average total cycle time per run — used to benchmark against takt time and identify process inefficiencies."
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time per run — customer demand rate benchmark; deviations from takt time signal over/under-production risk."
    - name: "quantity_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Production quantity attainment rate (%) — ratio of actual to planned output; primary schedule adherence KPI for operations and supply chain leadership."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus standard) — positive values indicate cost overruns; key financial performance indicator for manufacturing P&L."
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(total_setup_time_minutes AS DOUBLE))
      comment: "Total setup time across all runs — high setup time reduces available production time; drives changeover reduction initiatives (SMED)."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution KPIs covering schedule adherence, cost performance, OEE, scrap, and WIP. Used by production planners, operations managers, and finance for work order governance."
  source: "`manufacturing_ecm`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Released, In Progress, Completed, Closed) — used to filter and segment active vs. historical orders."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Standard, Rework, Repair) — enables segmentation of performance by order category."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the work order — supports escalation and resource allocation decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost values — required for multi-currency financial reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities — ensures consistent aggregation."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the work order — used for schedule adherence and capacity planning."
    - name: "planned_finish_date"
      expr: planned_finish_date
      comment: "Planned finish date of the work order — used for on-time delivery analysis."
    - name: "release_date"
      expr: release_date
      comment: "Date the work order was released to the shop floor — used to measure release-to-start lead time."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level work order performance analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to the work center — enables work-center-level load and efficiency analysis."
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "Foreign key to the SKU — enables product-level work order performance analysis."
    - name: "shift_id"
      expr: shift_id
      comment: "Foreign key to the shift — enables shift-level work order analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for production load and planning."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across work orders — used for capacity and demand alignment."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced — primary output volume KPI for work order execution."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity across work orders — material loss KPI directly tied to cost and quality."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate (%) across work orders — quality KPI; high scrap rates trigger process and supplier investigations."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate (%) across work orders — measures first-pass quality; core KPI for quality and operations leadership."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE (%) at work order level — measures combined availability, performance, and quality efficiency per order."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across work orders — used for cost variance and manufacturing P&L analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across work orders — budget baseline for cost variance analysis."
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total work-in-progress inventory value — critical for balance sheet accuracy and cash flow management; high WIP signals bottlenecks."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded on work orders — used to quantify production loss and prioritize maintenance investments."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average work order completion percentage — used to monitor in-flight execution progress and identify at-risk orders."
    - name: "quantity_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Work order quantity attainment rate (%) — ratio of actual to planned output; primary schedule adherence KPI for production management."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus standard) across work orders — positive values indicate cost overruns requiring management action."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order — used to benchmark against takt time and identify process inefficiencies."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work order — high setup times reduce productive capacity; drives changeover improvement programs."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event KPIs covering frequency, duration, production loss, OEE impact, and recurrence. Used by maintenance, operations, and reliability engineering to drive uptime improvement."
  source: "`manufacturing_ecm`.`production`.`production_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. Mechanical, Electrical, Process, Planned Maintenance) — primary segmentation for root cause analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (e.g. Unplanned, Planned, Minor Stop) — used to separate controllable from uncontrollable losses."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Specific reason for the downtime — enables Pareto analysis of top downtime causes."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the downtime event — used to prioritize corrective actions and escalations."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code assigned to the event — enables systematic root cause analysis and recurrence prevention."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the downtime — used for accountability tracking and resource allocation."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift during which the downtime occurred — used for daily and weekly trend analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the downtime event is a recurring issue — used to identify chronic problems requiring systemic fixes."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level downtime analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to the work center — enables work-center-level reliability analysis."
    - name: "shift_id"
      expr: shift_id
      comment: "Foreign key to the shift — enables shift-level downtime comparison."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency KPI; rising event counts signal deteriorating equipment reliability."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary capacity loss KPI; directly impacts throughput and OEE availability pillar."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per downtime event — used to assess event severity and benchmark against MTTR targets."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime — quantifies the direct output impact of equipment failures."
    - name: "total_production_loss_value"
      expr: SUM(CAST(production_loss_value AS DOUBLE))
      comment: "Total financial value of production lost due to downtime — used to justify maintenance investments and prioritize reliability improvements."
    - name: "avg_oee_impact"
      expr: AVG(CAST(impact_on_oee AS DOUBLE))
      comment: "Average OEE impact per downtime event — quantifies how much each event degrades overall equipment effectiveness."
    - name: "total_oee_impact"
      expr: SUM(CAST(impact_on_oee AS DOUBLE))
      comment: "Total cumulative OEE impact from all downtime events — used to quantify aggregate efficiency loss for executive reporting."
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in minutes — key maintenance efficiency KPI; high MTTR indicates slow repair response or parts availability issues."
    - name: "recurring_event_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Count of recurring downtime events — high recurrence indicates systemic equipment or process issues requiring root cause elimination."
    - name: "unplanned_downtime_events"
      expr: COUNT(CASE WHEN downtime_type = 'Unplanned' THEN 1 END)
      comment: "Count of unplanned downtime events — unplanned events are the most disruptive; tracking them drives predictive maintenance investment decisions."
    - name: "unplanned_downtime_minutes"
      expr: SUM(CASE WHEN downtime_type = 'Unplanned' THEN CAST(duration_minutes AS DOUBLE) ELSE 0 END)
      comment: "Total unplanned downtime duration in minutes — the most critical availability loss metric; directly used in OEE availability calculations and maintenance ROI analysis."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level operational KPIs covering OEE, throughput, quality, scrap, downtime, and energy consumption. Primary real-time and daily operations dashboard for shift supervisors and plant managers."
  source: "`manufacturing_ecm`.`production`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for daily operational trend analysis."
    - name: "shift_week"
      expr: DATE_TRUNC('week', shift_date)
      comment: "Week of the shift — used for weekly performance aggregation and trend reporting."
    - name: "shift_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift — used for monthly KPI rollups and management reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities — ensures consistent aggregation across product types."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flag indicating whether the shift required escalation — used to identify high-risk shifts and systemic issues."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Flag indicating a quality hold was placed during the shift — used to track quality incidents and their frequency."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating a safety incident occurred during the shift — critical for safety performance tracking and regulatory compliance."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level shift performance comparison."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to the work center — enables work-center-level shift analysis."
    - name: "shift_id"
      expr: shift_id
      comment: "Foreign key to the shift definition — enables shift-pattern performance comparison (e.g. Day vs. Night)."
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "Foreign key to the SKU — enables product-level shift performance analysis."
  measures:
    - name: "total_shift_reports"
      expr: COUNT(1)
      comment: "Total number of shift reports — baseline volume metric for shift coverage and reporting completeness."
    - name: "total_produced_quantity"
      expr: SUM(CAST(total_produced_quantity AS DOUBLE))
      comment: "Total units produced across all shifts — primary throughput volume KPI for operations leadership."
    - name: "total_good_quantity"
      expr: SUM(CAST(actual_good_quantity AS DOUBLE))
      comment: "Total good (conforming) units produced — measures first-pass quality output; used in OEE quality pillar calculations."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across shifts — used for shift attainment analysis."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped units across shifts — material waste KPI directly tied to cost and quality performance."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total reworked units across shifts — hidden quality cost indicator; high rework signals process instability."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE (%) across shifts — the primary manufacturing efficiency KPI; used in daily operations reviews and executive dashboards."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability (%) across shifts — OEE availability pillar; low values indicate excessive downtime."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate (%) across shifts — OEE performance pillar; measures speed losses vs. ideal cycle time."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate (%) across shifts — OEE quality pillar; measures first-pass yield contribution."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate (%) per shift — quality KPI; rising scrap rates trigger immediate process investigations."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate (%) per shift — measures proportion of good output; core quality and efficiency KPI."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across shifts — capacity loss KPI; used to quantify availability losses and prioritize maintenance."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across shifts (kWh) — sustainability and cost KPI; used for energy efficiency benchmarking and carbon footprint reporting."
    - name: "avg_throughput_rate_per_hour"
      expr: AVG(CAST(throughput_rate_per_hour AS DOUBLE))
      comment: "Average throughput rate per hour across shifts — speed efficiency KPI; used to identify bottlenecks and benchmark against takt time."
    - name: "shift_quantity_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_produced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Shift quantity attainment rate (%) — ratio of actual to planned output per shift; primary schedule adherence KPI for shift supervisors and plant managers."
    - name: "safety_incident_shifts"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of shifts with safety incidents — critical safety KPI; zero-incident target is a non-negotiable executive priority in industrial manufacturing."
    - name: "quality_hold_shifts"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Number of shifts with quality holds — indicates frequency of quality escapes; used to drive quality system improvements."
    - name: "total_material_waste_quantity"
      expr: SUM(CAST(material_waste_quantity AS DOUBLE))
      comment: "Total material waste quantity across shifts — sustainability and cost KPI; used for waste reduction programs and lean manufacturing initiatives."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs covering inbound quantity performance, yield, scrap, and reversal rates. Used by supply chain, quality, and production planning to govern material inflows and supplier performance."
  source: "`manufacturing_ecm`.`production`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt document — used to filter confirmed vs. pending or reversed receipts."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt — distinguishes production receipts, returns, and reversals."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) — used to track quality-held inventory."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities — ensures consistent aggregation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the goods receipt — used for annual financial and production reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the goods receipt — used for period-level financial and inventory reporting."
    - name: "posting_date"
      expr: posting_date
      comment: "Posting date of the goods receipt — primary time dimension for inventory and production reporting."
    - name: "document_date"
      expr: document_date
      comment: "Document date of the goods receipt — used for document-level audit and reconciliation."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection was required — used to segment receipts by quality risk level."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the goods receipt was reversed — used to identify and exclude reversed transactions from net quantity calculations."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level receipt analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Foreign key to the supplier — enables supplier-level receipt performance analysis."
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "Foreign key to the SKU — enables product-level receipt and yield analysis."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — baseline volume metric for inbound material flow."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity across goods receipts — used to measure planned inbound material volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received — primary inbound volume KPI for inventory and production planning."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity at goods receipt — measures inbound material quality losses; used for supplier quality scorecards."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage at goods receipt — measures the proportion of usable material received; key supplier quality KPI."
    - name: "receipt_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Goods receipt attainment rate (%) — ratio of received to ordered quantity; measures supplier delivery completeness and impacts production schedule adherence."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts — high reversal counts indicate data quality issues, supplier disputes, or process errors requiring investigation."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection — used to assess quality risk exposure in inbound material flow."
    - name: "scrap_rate_at_receipt"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate at goods receipt (%) — measures the proportion of received material that is scrapped; used in supplier quality scorecards and cost-of-poor-quality analysis."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level strategic KPIs covering OEE performance, energy consumption, carbon emissions, water usage, waste generation, and safety. Used by plant managers, sustainability officers, and executive leadership for plant portfolio governance."
  source: "`manufacturing_ecm`.`production`.`plant`"
  dimensions:
    - name: "plant_name"
      expr: plant_name
      comment: "Name of the plant — primary grouping dimension for plant-level performance comparison."
    - name: "plant_code"
      expr: plant_code
      comment: "Unique plant code — used for system integration and cross-reference with ERP data."
    - name: "plant_type"
      expr: plant_type
      comment: "Type of plant (e.g. Assembly, Fabrication, Distribution) — enables segmentation of performance by plant category."
    - name: "plant_status"
      expr: plant_status
      comment: "Operational status of the plant — used to filter active vs. inactive plants."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plant is located — enables geographic performance analysis and regulatory reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the plant — used for regional performance aggregation and benchmarking."
    - name: "city"
      expr: city
      comment: "City where the plant is located — used for location-level analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the plant is currently active — used to filter operational plants."
    - name: "operational_since"
      expr: operational_since
      comment: "Date the plant became operational — used for plant age analysis and lifecycle management."
    - name: "last_inspection_date"
      expr: last_inspection_date
      comment: "Date of the last plant inspection — used for compliance and maintenance governance."
  measures:
    - name: "total_active_plants"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active plants — baseline capacity metric for portfolio management."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across plants — primary plant efficiency KPI; used in executive portfolio reviews to identify underperforming plants."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across plants — benchmark for OEE gap analysis."
    - name: "oee_gap"
      expr: AVG(CAST(oee_actual AS DOUBLE)) - AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE gap (actual minus target) across plants — negative values indicate plants not meeting efficiency targets; drives capital investment and improvement program decisions."
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total installed capacity in megawatts across plants — used for capacity planning and investment decisions."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across plants — sustainability KPI; used for energy cost management and carbon reduction programs."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg across plants — ESG and regulatory reporting KPI; used for Scope 1 emissions tracking and net-zero commitments."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters across plants — sustainability KPI; used for water stewardship reporting and regulatory compliance."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons across plants — sustainability and cost KPI; used for waste reduction programs and environmental compliance reporting."
    - name: "avg_energy_intensity"
      expr: ROUND(SUM(CAST(energy_consumption_mwh AS DOUBLE)) / NULLIF(SUM(CAST(capacity_mw AS DOUBLE)), 0), 4)
      comment: "Average energy intensity (MWh per MW of capacity) across plants — efficiency KPI for energy management; high values indicate energy-inefficient plants requiring investment."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line master KPIs covering OEE performance, throughput capacity, cycle time, changeover efficiency, and reliability (MTBF/MTTR). Used by operations engineers and plant managers for line-level performance governance."
  source: "`manufacturing_ecm`.`production`.`production_line`"
  dimensions:
    - name: "line_name"
      expr: line_name
      comment: "Name of the production line — primary grouping dimension for line-level performance comparison."
    - name: "line_code"
      expr: line_code
      comment: "Unique code for the production line — used for system integration and cross-reference."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Assembly, Machining, Painting) — enables segmentation by line category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the line — used to filter active vs. inactive lines."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line (e.g. Manual, Semi-Automated, Fully Automated) — used to benchmark performance by automation tier."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern for the line (e.g. 2-shift, 3-shift, continuous) — used for capacity and utilization analysis."
    - name: "capacity_constraint_flag"
      expr: capacity_constraint_flag
      comment: "Flag indicating whether the line is a capacity constraint — used to identify bottleneck lines requiring investment."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Flag indicating environmental compliance status — used for regulatory and sustainability governance."
    - name: "plant_id"
      expr: plant_id
      comment: "Foreign key to the plant — enables plant-level aggregation of line performance."
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the line was commissioned — used for asset age analysis and lifecycle planning."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines — baseline capacity metric for portfolio management."
    - name: "avg_actual_oee_percentage"
      expr: AVG(CAST(actual_oee_percentage AS DOUBLE))
      comment: "Average actual OEE (%) across production lines — primary line efficiency KPI; used to identify underperforming lines and prioritize improvement investments."
    - name: "avg_target_oee_percentage"
      expr: AVG(CAST(target_oee_percentage AS DOUBLE))
      comment: "Average OEE target (%) across production lines — benchmark for OEE gap analysis."
    - name: "oee_gap"
      expr: AVG(CAST(actual_oee_percentage AS DOUBLE)) - AVG(CAST(target_oee_percentage AS DOUBLE))
      comment: "Average OEE gap (actual minus target) across lines — negative values identify lines not meeting efficiency targets; drives capital and improvement program prioritization."
    - name: "avg_design_throughput_rate"
      expr: AVG(CAST(design_throughput_rate AS DOUBLE))
      comment: "Average design throughput rate across lines — theoretical capacity benchmark used for utilization analysis."
    - name: "avg_cycle_time_seconds"
      expr: AVG(CAST(cycle_time_seconds AS DOUBLE))
      comment: "Average cycle time in seconds across lines — used to benchmark against takt time and identify speed losses."
    - name: "avg_takt_time_seconds"
      expr: AVG(CAST(takt_time_seconds AS DOUBLE))
      comment: "Average takt time in seconds across lines — customer demand rate benchmark; deviations signal over/under-production risk."
    - name: "avg_changeover_time_minutes"
      expr: AVG(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Average changeover time in minutes across lines — high changeover times reduce available production time; drives SMED improvement programs."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours across lines — reliability KPI; low MTBF indicates frequent breakdowns requiring maintenance strategy review."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours across lines — maintenance efficiency KPI; high MTTR indicates slow repair response or spare parts issues."
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced (kWh/unit) across lines — energy efficiency KPI; used for sustainability reporting and cost reduction programs."
    - name: "constrained_line_count"
      expr: COUNT(CASE WHEN capacity_constraint_flag = TRUE THEN 1 END)
      comment: "Number of lines flagged as capacity constraints — identifies bottleneck lines that limit overall plant throughput; drives investment prioritization."
    - name: "avg_planned_availability_hours_per_day"
      expr: AVG(CAST(planned_availability_hours_per_day AS DOUBLE))
      comment: "Average planned availability hours per day across lines — used for capacity planning and shift scheduling decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production schedule KPIs covering plan adherence, capacity utilization, lot sizing efficiency, and schedule execution. Used by production planners, supply chain managers, and operations leadership for scheduling governance."
  source: "`manufacturing_ecm`.`production`.`schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (e.g. Planned, Released, Completed, Cancelled) — used to filter active vs. historical schedules."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g. MRP, Manual, Firm) — enables segmentation by planning method."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "Planning strategy used (e.g. Make-to-Stock, Make-to-Order) — used to segment schedule performance by demand fulfillment strategy."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source of the schedule (e.g. MRP, Manual, Sales Order) — used to assess planning system effectiveness."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Flag indicating whether the schedule has been firmed — used to distinguish firm vs. tentative production plans."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating whether approval is required — used for governance and change management tracking."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date — primary time dimension for schedule adherence analysis."
    - name: "scheduled_finish_date"
      expr: scheduled_finish_date
      comment: "Scheduled finish date — used for on-time completion analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to the work center — enables work-center-level schedule load analysis."
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "Foreign key to the SKU — enables product-level schedule analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of production schedules — baseline volume metric for planning activity."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across schedules — used for demand coverage and capacity alignment analysis."
    - name: "total_lot_size_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total lot size quantity across schedules — used for batch sizing efficiency analysis and inventory optimization."
    - name: "total_capacity_requirement_hours"
      expr: SUM(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Total capacity required across schedules in hours — primary capacity load KPI; used to identify overloaded work centers and drive capacity investment decisions."
    - name: "total_run_time_hours"
      expr: SUM(CAST(run_time_hours AS DOUBLE))
      comment: "Total scheduled run time in hours — used for capacity utilization and scheduling efficiency analysis."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total scheduled setup time in hours — measures changeover burden on capacity; used to drive setup reduction initiatives."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity planned across schedules — used for inventory investment analysis and supply risk management."
    - name: "firmed_schedule_count"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Number of firmed production schedules — measures planning stability; low firmed counts indicate high schedule volatility and supply chain risk."
    - name: "setup_to_run_time_ratio"
      expr: ROUND(SUM(CAST(setup_time_hours AS DOUBLE)) / NULLIF(SUM(CAST(run_time_hours AS DOUBLE)), 0), 4)
      comment: "Ratio of setup time to run time across schedules — measures changeover efficiency; high ratios indicate excessive setup burden relative to productive time, driving SMED investment decisions."
$$;