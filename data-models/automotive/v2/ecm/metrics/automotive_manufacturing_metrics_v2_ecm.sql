-- Metric views for domain: manufacturing | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_oee_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) performance metrics aggregated by plant, production line, shift and work center. Provides the primary manufacturing efficiency KPI dashboard used by plant managers and VPs of Manufacturing to steer production performance, identify losses, and benchmark against targets."
  source: "`vibe_automotive_v1`.`manufacturing`.`oee_metric_view`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables plant-level OEE benchmarking across the manufacturing network."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — allows drill-down from plant to individual line performance."
    - name: "shift_id"
      expr: shift_id
      comment: "Shift identifier — supports shift-over-shift OEE comparison to identify crew or time-of-day patterns."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — enables station-level OEE analysis to pinpoint bottlenecks."
    - name: "metric_date"
      expr: metric_date
      comment: "Calendar date of the OEE measurement — supports daily, weekly, and monthly trend analysis."
    - name: "aggregation_period"
      expr: aggregation_period
      comment: "Aggregation granularity (shift, day, week, month) — allows consistent period-over-period comparisons."
    - name: "metric_month"
      expr: DATE_TRUNC('MONTH', metric_date)
      comment: "Month bucket derived from metric_date — supports monthly OEE trend reporting."
  measures:
    - name: "avg_oee_rate"
      expr: AVG(CAST(oee_rate AS DOUBLE))
      comment: "Average OEE rate (Availability × Performance × Quality) across selected scope. The primary manufacturing efficiency KPI; a 1-point drop triggers plant-level investigation and corrective action."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate. Measures the proportion of planned production time that equipment is actually running; drives maintenance investment decisions."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate (actual vs. ideal cycle time ratio). Identifies speed losses and operator efficiency gaps that reduce throughput."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate (good units / total units). Directly links manufacturing quality to OEE; a decline signals process or tooling issues requiring immediate intervention."
    - name: "avg_teep_rate"
      expr: AVG(CAST(teep_rate AS DOUBLE))
      comment: "Average Total Effective Equipment Performance (TEEP) rate. Extends OEE to include scheduled downtime, giving executives the true asset utilization picture for capacity investment decisions."
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good (first-pass quality) units produced. Core throughput KPI used in production planning and customer delivery commitment reviews."
    - name: "total_scrap_units"
      expr: SUM(CAST(scrap_units AS DOUBLE))
      comment: "Total scrap units produced. Directly tied to material cost waste; an increase triggers root-cause analysis and supplier or process corrective actions."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across the selected scope. Key input to maintenance strategy and capacity planning; high values justify capital investment in reliability improvements."
    - name: "avg_planned_production_time_minutes"
      expr: AVG(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Average planned production time per period. Baseline denominator for availability calculations and shift utilization analysis."
    - name: "avg_operating_time_minutes"
      expr: AVG(CAST(operating_time_minutes AS DOUBLE))
      comment: "Average actual operating time per period. Compared against planned production time to quantify availability losses."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_units AS DOUBLE)) / NULLIF(SUM(CAST(total_units_produced AS DOUBLE)), 0), 2)
      comment: "Scrap rate as a percentage of total units produced. A compound quality KPI used in steering meetings to track waste reduction initiatives and ESG material efficiency goals."
    - name: "downtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(downtime_minutes AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_time_minutes AS DOUBLE)), 0), 2)
      comment: "Downtime as a percentage of planned production time. Compound availability loss metric that directly informs maintenance budget allocation and line redesign decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics covering cost performance, schedule adherence, labor and machine efficiency, and carbon footprint per order. Used by plant controllers, production managers, and sustainability officers to manage manufacturing cost, throughput, and ESG targets."
  source: "`vibe_automotive_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant production cost and efficiency benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level cost and throughput analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (Released, In-Process, Confirmed, Closed) — used to filter active vs. completed orders in operational dashboards."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (standard, rework, prototype) — enables cost segmentation by order category."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the order — supports model-year cost rollup for program profitability analysis."
    - name: "order_date"
      expr: order_date
      comment: "Date the production order was created — supports trend analysis of order volume and cost over time."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month bucket derived from order_date — supports monthly production cost and volume reporting."
    - name: "priority"
      expr: priority
      comment: "Order priority level — allows analysis of cost and schedule adherence by priority tier."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts — required for multi-currency manufacturing cost consolidation."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders. Baseline volume metric used to normalize cost and efficiency KPIs across periods and plants."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost across all production orders. Primary cost KPI for plant controllers and CFO manufacturing cost reviews."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard (planned) manufacturing cost. Baseline for cost variance analysis and standard cost roll-up in product costing."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Absolute cost variance (actual minus standard). A positive variance signals over-spend and triggers cost investigation; a key metric in monthly manufacturing reviews."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(standard_cost AS DOUBLE))) / NULLIF(SUM(CAST(standard_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of standard cost. Compound efficiency KPI used by plant controllers to assess manufacturing cost discipline and flag programs requiring corrective action."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total planned production quantity across orders. Used to measure schedule attainment and capacity utilization."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (completed) production quantity. Compared against target quantity to compute schedule attainment rate."
    - name: "schedule_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Production schedule attainment rate (confirmed / target quantity). A core operational KPI; below-target values trigger capacity reallocation and overtime decisions."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across production orders. Directly tied to material waste cost and quality performance; monitored in weekly quality steering meetings."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across production orders. Rework drives hidden cost and cycle time loss; tracked to justify process improvement investments."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate as a percentage of planned production quantity. Compound quality KPI linking manufacturing waste to program cost and ESG material efficiency targets."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed. Used to compute labor efficiency and benchmark against standard hours for workforce cost management."
    - name: "labor_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_labor_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_labor_hours AS DOUBLE)), 0), 2)
      comment: "Labor efficiency rate (planned vs. actual hours). A compound workforce productivity KPI; below-target values trigger staffing and training reviews."
    - name: "total_carbon_footprint_kg_co2"
      expr: SUM(CAST(carbon_footprint_kg_co2 AS DOUBLE))
      comment: "Total CO2 carbon footprint in kg across production orders. ESG KPI mandatory for CSRD and EU Taxonomy reporting; monitored by sustainability officers and reported to the board."
    - name: "avg_carbon_per_unit_kg"
      expr: ROUND(SUM(CAST(carbon_footprint_kg_co2 AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 4)
      comment: "Average carbon footprint per produced unit (kg CO2). Compound ESG efficiency metric used to track decarbonization progress and set science-based targets."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment and line downtime analytics covering duration, frequency, OEE availability loss, maintenance cost, and root-cause distribution. Used by maintenance managers, plant directors, and reliability engineers to prioritize maintenance investment and reduce unplanned stoppages."
  source: "`vibe_automotive_v1`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant downtime benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level downtime root-cause analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — pinpoints the specific station driving availability losses."
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level downtime category (planned, unplanned, quality hold) — used to separate controllable from uncontrollable losses."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific downtime type (mechanical, electrical, tooling, changeover) — drives maintenance strategy decisions."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code — enables Pareto analysis of top failure modes to prioritize corrective actions."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode code — supports FMEA-driven reliability improvement programs."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event (open, resolved, escalated) — used to track open issues requiring resolution."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating safety-related downtime — safety events are escalated immediately and tracked separately for regulatory compliance."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating a repeat failure on the same equipment — repeat failures signal inadequate root-cause resolution and drive escalation."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket of downtime event start — supports monthly downtime trend reporting."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline frequency metric; rising event counts signal deteriorating equipment reliability."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes. Primary availability loss metric used in OEE calculations and maintenance budget justification."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event. Measures mean time to restore (MTTR proxy); high values indicate slow repair response or parts availability issues."
    - name: "total_oee_availability_loss_pct"
      expr: AVG(CAST(oee_availability_loss_pct AS DOUBLE))
      comment: "Average OEE availability loss percentage attributed to downtime events. Directly links downtime to OEE degradation for executive reporting."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_local AS DOUBLE))
      comment: "Total maintenance cost incurred from downtime events. Key input to total cost of ownership analysis and maintenance budget planning."
    - name: "total_energy_waste_kwh"
      expr: SUM(CAST(energy_waste_kwh AS DOUBLE))
      comment: "Total energy wasted during downtime events in kWh. ESG metric linking equipment reliability to energy efficiency and CO2 reduction targets."
    - name: "repeat_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_failure = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are repeat failures. A compound reliability KPI; high repeat rates indicate systemic root-cause resolution failures requiring escalation."
    - name: "safety_downtime_event_count"
      expr: SUM(CASE WHEN is_safety_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of safety-related downtime events. Zero-tolerance KPI monitored by EHS and plant management; any non-zero value triggers immediate investigation."
    - name: "total_cycle_time_impact_seconds"
      expr: SUM(CAST(cycle_time_impact_total_seconds AS DOUBLE))
      comment: "Total cycle time impact in seconds caused by downtime events. Quantifies the throughput cost of downtime beyond simple duration, informing takt time and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing energy consumption and CO2 emissions metrics by plant, production line, work center, energy type, and period. Primary ESG and operational cost dashboard for sustainability officers, plant energy managers, and CFOs tracking CSRD and EU Taxonomy compliance."
  source: "`vibe_automotive_v1`.`manufacturing`.`energy_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant energy benchmarking and carbon footprint comparison."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level energy efficiency analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — pinpoints the highest energy-consuming stations for targeted efficiency investments."
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, natural gas, compressed air, steam) — enables energy mix analysis and renewable transition planning."
    - name: "energy_source"
      expr: energy_source
      comment: "Energy source (grid, on-site solar, wind, diesel) — supports renewable energy share tracking and Scope 2 emissions reporting."
    - name: "scope_category"
      expr: scope_category
      comment: "GHG Protocol scope category (Scope 1, Scope 2, Scope 3) — mandatory for CSRD and EU Taxonomy emissions reporting."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard applied (GHG Protocol, ISO 50001, EU ETS) — ensures metrics align with the correct regulatory framework."
    - name: "period_type"
      expr: period_type
      comment: "Measurement period type (shift, day, month, year) — supports consistent period-over-period energy trend analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month bucket of energy measurement — supports monthly energy and emissions trend reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of energy cost amounts — required for multi-currency energy cost consolidation."
  measures:
    - name: "total_consumption_kwh"
      expr: SUM(CAST(consumption_kwh_equivalent AS DOUBLE))
      comment: "Total energy consumption in kWh equivalent across all energy types. Primary energy KPI for ISO 50001 energy management and EU Taxonomy reporting."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions in kg. Mandatory ESG KPI for CSRD, EU Taxonomy, and science-based target tracking; reported to the board and disclosed in sustainability reports."
    - name: "total_energy_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total energy cost. Key operational cost KPI; energy is typically the second-largest manufacturing cost driver after labor."
    - name: "avg_consumption_per_unit"
      expr: AVG(CAST(consumption_per_unit AS DOUBLE))
      comment: "Average energy consumption per produced unit. Compound energy efficiency KPI used to track decarbonization progress and benchmark against industry peers."
    - name: "avg_renewable_pct"
      expr: AVG(CAST(renewable_pct AS DOUBLE))
      comment: "Average renewable energy share as a percentage. Tracks progress toward 100% renewable energy commitments; a key metric in ESG investor reporting."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters. ESG water stewardship KPI required for CSRD reporting and water-stressed region compliance."
    - name: "avg_variance_from_baseline_pct"
      expr: AVG(CAST(variance_from_baseline_pct AS DOUBLE))
      comment: "Average variance from energy baseline as a percentage. Measures energy efficiency improvement against the ISO 50001 baseline; negative values indicate efficiency gains."
    - name: "avg_peak_demand_kw"
      expr: AVG(CAST(peak_demand_kw AS DOUBLE))
      comment: "Average peak power demand in kW. Used to manage demand charges and assess grid capacity requirements for electrification investments."
    - name: "total_baseline_consumption"
      expr: SUM(CAST(baseline_consumption AS DOUBLE))
      comment: "Total baseline energy consumption. Denominator for efficiency improvement calculations; required for ISO 50001 energy performance indicator reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_vehicle_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle build execution metrics covering build cycle time, quality gate outcomes, rework rates, carbon footprint per vehicle, and build status distribution. Used by plant managers, quality directors, and program managers to monitor build quality, throughput, and sustainability performance at the vehicle level."
  source: "`vibe_automotive_v1`.`manufacturing`.`vehicle_build`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant build quality and throughput benchmarking."
    - name: "build_status"
      expr: build_status
      comment: "Current build status (In-Process, Complete, Hold, Rework) — used to monitor active build pipeline and identify holds requiring intervention."
    - name: "build_type"
      expr: build_type
      comment: "Type of build (standard, pilot, prototype, rework) — enables cost and quality segmentation by build category."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year — supports model-year quality and throughput trend analysis."
    - name: "vehicle_model_code"
      expr: vehicle_model_code
      comment: "Vehicle model code — enables model-level build quality and cycle time comparison."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, BEV, PHEV, HEV) — supports electrification mix analysis and BEV-specific build quality tracking."
    - name: "quality_gate_status"
      expr: quality_gate_status
      comment: "Final quality gate result (Pass, Fail, Conditional) — primary build quality outcome dimension for end-of-line quality reporting."
    - name: "end_of_line_test_result"
      expr: end_of_line_test_result
      comment: "End-of-line functional test result — used to track first-time quality and identify systemic test failures."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Flag indicating the vehicle build is on hold — used to monitor hold inventory and escalate resolution."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flag indicating the vehicle required rework — used to compute rework rate and track quality improvement trends."
    - name: "scheduled_build_month"
      expr: DATE_TRUNC('MONTH', scheduled_build_date)
      comment: "Month bucket of scheduled build date — supports monthly build volume and quality trend reporting."
  measures:
    - name: "total_vehicles_built"
      expr: COUNT(1)
      comment: "Total number of vehicle builds. Primary throughput KPI used in daily production meetings and customer delivery commitment tracking."
    - name: "avg_total_cycle_time_seconds"
      expr: AVG(CAST(total_cycle_time_seconds AS DOUBLE))
      comment: "Average total build cycle time in seconds. Compared against takt time to assess line balance and throughput capacity; a key input to capacity planning."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles requiring rework. Compound quality KPI; rising rework rates trigger process audits and supplier quality reviews."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles placed on quality or logistics hold. Measures build disruption rate; high hold rates delay customer deliveries and increase WIP inventory cost."
    - name: "quality_gate_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_gate_status = 'PASS' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles passing the final quality gate on first attempt. First-time quality (FTQ) KPI; a primary metric in quality steering meetings and customer satisfaction programs."
    - name: "total_build_carbon_footprint_kg"
      expr: SUM(CAST(build_carbon_footprint_kg AS DOUBLE))
      comment: "Total CO2 carbon footprint of all vehicle builds in kg. ESG KPI for CSRD reporting; tracks manufacturing Scope 1 emissions at the vehicle level."
    - name: "avg_carbon_per_vehicle_kg"
      expr: ROUND(SUM(CAST(build_carbon_footprint_kg AS DOUBLE)) / NULLIF(COUNT(1), 0), 4)
      comment: "Average carbon footprint per vehicle built in kg CO2. Compound ESG efficiency metric used to track per-vehicle decarbonization progress against science-based targets."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_scrap_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing scrap analytics covering scrap cost, quantity, energy waste, CO2 waste, and supplier-caused scrap attribution. Used by quality managers, plant controllers, and sustainability officers to drive waste reduction, supplier accountability, and ESG material efficiency improvements."
  source: "`vibe_automotive_v1`.`manufacturing`.`scrap_record`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant scrap cost and quantity benchmarking."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — pinpoints the highest scrap-generating stations for targeted process improvement."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Scrap reason code — enables Pareto analysis of top scrap causes to prioritize corrective actions."
    - name: "scrap_type"
      expr: scrap_type
      comment: "Type of scrap (material, process, design) — supports root-cause categorization and responsibility assignment."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Scrap disposition code (recycle, landfill, rework) — tracks circular economy and waste diversion performance."
    - name: "is_supplier_caused"
      expr: is_supplier_caused
      comment: "Flag indicating supplier-caused scrap — enables supplier accountability reporting and chargeback calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of scrap cost amounts — required for multi-currency scrap cost consolidation."
    - name: "scrap_month"
      expr: DATE_TRUNC('MONTH', scrap_timestamp)
      comment: "Month bucket of scrap event — supports monthly scrap trend reporting and target tracking."
  measures:
    - name: "total_scrap_cost"
      expr: SUM(CAST(scrap_cost AS DOUBLE))
      comment: "Total scrap cost in local currency. Primary financial waste KPI; directly impacts manufacturing cost of goods sold and is monitored in monthly cost reviews."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity of scrapped parts/units. Volume metric used alongside scrap cost to compute average scrap cost per unit and track waste reduction progress."
    - name: "total_energy_wasted_kwh"
      expr: SUM(CAST(energy_wasted_kwh AS DOUBLE))
      comment: "Total energy wasted due to scrap in kWh. ESG metric linking manufacturing quality to energy efficiency; reported in sustainability disclosures."
    - name: "total_co2_waste_kg"
      expr: SUM(CAST(co2_waste_kg AS DOUBLE))
      comment: "Total CO2 emissions wasted due to scrap in kg. ESG KPI for CSRD reporting; quantifies the carbon cost of poor manufacturing quality."
    - name: "supplier_caused_scrap_cost"
      expr: SUM(CASE WHEN is_supplier_caused = TRUE THEN scrap_cost ELSE 0 END)
      comment: "Total scrap cost attributable to supplier-caused defects. Used to calculate supplier chargebacks and inform supplier scorecard ratings."
    - name: "supplier_caused_scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_supplier_caused = TRUE THEN quantity_scrapped ELSE 0 END) / NULLIF(SUM(CAST(quantity_scrapped AS DOUBLE)), 0), 2)
      comment: "Percentage of total scrap quantity caused by suppliers. Compound supplier quality KPI used in supplier performance reviews and sourcing decisions."
    - name: "avg_scrap_cost_per_unit"
      expr: ROUND(SUM(CAST(scrap_cost AS DOUBLE)) / NULLIF(SUM(CAST(quantity_scrapped AS DOUBLE)), 0), 2)
      comment: "Average scrap cost per scrapped unit. Compound cost efficiency metric used to benchmark scrap cost across plants, lines, and suppliers."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_rework_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rework order analytics covering rework cost, hours, cycle time efficiency, safety-related rework, and re-inspection outcomes. Used by quality managers and plant controllers to quantify the hidden cost of poor quality and drive first-time quality improvement programs."
  source: "`vibe_automotive_v1`.`manufacturing`.`rework_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant rework cost and frequency benchmarking."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — identifies the stations generating the most rework for targeted process improvement."
    - name: "rework_status"
      expr: rework_status
      comment: "Current rework order status (Open, In-Progress, Complete, Rejected) — used to monitor open rework backlog."
    - name: "rework_type"
      expr: rework_type
      comment: "Type of rework (repair, replace, adjust) — supports rework cost segmentation by intervention type."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code triggering the rework — enables Pareto analysis of top defect types driving rework cost."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating safety-related rework — safety rework is tracked separately and escalated to EHS and product safety teams."
    - name: "re_inspection_result"
      expr: re_inspection_result
      comment: "Result of re-inspection after rework (Pass, Fail) — measures rework effectiveness and first-time fix rate."
    - name: "priority_level"
      expr: priority_level
      comment: "Rework priority level — used to manage rework queue and ensure high-priority vehicles are expedited."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of rework cost amounts — required for multi-currency rework cost consolidation."
    - name: "rework_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month bucket of rework start — supports monthly rework cost and volume trend reporting."
  measures:
    - name: "total_rework_orders"
      expr: COUNT(1)
      comment: "Total number of rework orders. Baseline frequency metric; rising counts signal deteriorating first-time quality and trigger process audits."
    - name: "total_rework_cost"
      expr: SUM(CAST(rework_cost AS DOUBLE))
      comment: "Total rework cost in local currency. Primary hidden quality cost KPI; included in cost of poor quality (COPQ) calculations reported to plant management."
    - name: "total_actual_rework_hours"
      expr: SUM(CAST(actual_rework_hours AS DOUBLE))
      comment: "Total actual labor hours consumed by rework. Quantifies the labor capacity consumed by quality failures; used to justify quality improvement investments."
    - name: "rework_hour_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_rework_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_rework_hours AS DOUBLE)), 0), 2)
      comment: "Rework labor efficiency (planned vs. actual hours). Measures rework execution efficiency; low values indicate complex or poorly diagnosed defects."
    - name: "safety_rework_count"
      expr: SUM(CASE WHEN is_safety_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of safety-related rework orders. Zero-tolerance KPI; any safety rework is escalated to product safety and regulatory teams immediately."
    - name: "re_inspection_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN re_inspection_result = 'PASS' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN re_inspection_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of re-inspected rework orders that pass on first re-inspection. Measures rework effectiveness; low rates indicate systemic repair quality issues."
    - name: "total_waste_generated_kg"
      expr: SUM(CAST(waste_generated_kg AS DOUBLE))
      comment: "Total waste generated by rework activities in kg. ESG metric linking rework to material waste; reported in sustainability disclosures and circular economy programs."
    - name: "avg_rework_cost_per_order"
      expr: ROUND(SUM(CAST(rework_cost AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average rework cost per order. Compound cost efficiency metric used to benchmark rework cost across defect types, plants, and model years."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_cycle_time_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle time performance metrics covering actual vs. planned cycle time, takt time adherence, value-added time ratio, and andon call frequency. Used by industrial engineers, production supervisors, and plant managers to optimize line balance, identify bottlenecks, and improve throughput."
  source: "`vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant cycle time benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level cycle time analysis and takt time adherence tracking."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — pinpoints bottleneck stations with the highest cycle time variance."
    - name: "shift_id"
      expr: shift_id
      comment: "Shift identifier — supports shift-over-shift cycle time comparison to identify crew performance patterns."
    - name: "station_code"
      expr: station_code
      comment: "Station code — enables station-level cycle time analysis for line balancing decisions."
    - name: "model_variant_code"
      expr: model_variant_code
      comment: "Vehicle model variant code — supports variant-level cycle time analysis to identify complex variants driving line imbalance."
    - name: "is_over_takt"
      expr: is_over_takt
      comment: "Flag indicating the cycle exceeded takt time — used to identify and prioritize over-takt events for immediate corrective action."
    - name: "andon_call_flag"
      expr: andon_call_flag
      comment: "Flag indicating an andon call was triggered — used to track andon frequency as a proxy for process stability."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for cycle time delay — enables Pareto analysis of top delay causes for targeted improvement."
    - name: "cycle_month"
      expr: DATE_TRUNC('MONTH', cycle_start_timestamp)
      comment: "Month bucket of cycle start — supports monthly cycle time trend reporting."
  measures:
    - name: "avg_actual_cycle_time_seconds"
      expr: AVG(CAST(actual_cycle_time_seconds AS DOUBLE))
      comment: "Average actual cycle time in seconds. Primary throughput metric; compared against takt time to assess line balance and identify bottlenecks."
    - name: "avg_planned_cycle_time_seconds"
      expr: AVG(CAST(planned_cycle_time_seconds AS DOUBLE))
      comment: "Average planned (standard) cycle time in seconds. Baseline for cycle time variance analysis and industrial engineering standard setting."
    - name: "avg_cycle_time_variance_seconds"
      expr: AVG(CAST(cycle_time_variance_seconds AS DOUBLE))
      comment: "Average cycle time variance (actual minus planned) in seconds. Measures process consistency; high variance indicates unstable processes requiring standardization."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average cycle time variance as a percentage of planned time. Compound efficiency KPI used in line balance reviews and continuous improvement programs."
    - name: "over_takt_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_over_takt = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles exceeding takt time. Compound throughput risk KPI; high over-takt rates signal capacity constraints and risk of missing daily production targets."
    - name: "andon_call_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN andon_call_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles triggering an andon call. Proxy for process stability and operator support needs; high rates indicate systemic issues requiring engineering intervention."
    - name: "avg_value_added_time_seconds"
      expr: AVG(CAST(value_added_time_seconds AS DOUBLE))
      comment: "Average value-added time per cycle in seconds. Lean manufacturing KPI measuring the proportion of cycle time that directly adds product value."
    - name: "avg_non_value_added_time_seconds"
      expr: AVG(CAST(non_value_added_time_seconds AS DOUBLE))
      comment: "Average non-value-added (waste) time per cycle in seconds. Lean waste metric; high values identify muda (waste) elimination opportunities."
    - name: "value_added_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(value_added_time_seconds AS DOUBLE)) / NULLIF(SUM(CAST(actual_cycle_time_seconds AS DOUBLE)), 0), 2)
      comment: "Value-added time as a percentage of total cycle time. Compound lean efficiency KPI; a core metric in value stream mapping and continuous improvement programs."
    - name: "avg_wait_time_seconds"
      expr: AVG(CAST(wait_time_seconds AS DOUBLE))
      comment: "Average wait time per cycle in seconds. Identifies queue and flow inefficiencies in the production line; high wait times indicate line imbalance or material supply issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_material_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption analytics covering actual vs. planned consumption, variance, material cost, recycled content, and scrap indicators. Used by plant controllers, supply chain managers, and sustainability officers to manage material efficiency, cost, and circular economy targets."
  source: "`vibe_automotive_v1`.`manufacturing`.`material_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant material consumption benchmarking."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — supports station-level material consumption analysis."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the material consumption posting (confirmed, reversed, pending) — used to filter valid consumption records."
    - name: "goods_movement_type"
      expr: goods_movement_type
      comment: "SAP goods movement type (261 = goods issue to production order) — supports material flow analysis and inventory reconciliation."
    - name: "scrap_indicator"
      expr: scrap_indicator
      comment: "Flag indicating the consumption was for scrap — used to separate productive consumption from waste for material efficiency analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating a reversed consumption posting — used to identify and exclude reversals from net consumption calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of material cost amounts — required for multi-currency material cost consolidation."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month bucket of material posting date — supports monthly material cost and consumption trend reporting."
  measures:
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total material quantity consumed. Primary material throughput metric used in production cost accounting and inventory reconciliation."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity. Baseline for consumption variance analysis and material requirements planning accuracy assessment."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total material quantity variance (actual minus planned). Measures material planning accuracy; large variances indicate BOM errors or process instability."
    - name: "consumption_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_variance AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Material consumption variance as a percentage of planned quantity. Compound material efficiency KPI used in monthly cost reviews and BOM accuracy improvement programs."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost consumed. Key manufacturing cost driver; monitored in monthly cost reviews and used in product cost rollup calculations."
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_pct AS DOUBLE))
      comment: "Average recycled content percentage of consumed materials. ESG circular economy KPI; tracks progress toward recycled material content targets required by EU End-of-Life Vehicle regulations."
    - name: "scrap_consumption_quantity"
      expr: SUM(CASE WHEN scrap_indicator = TRUE THEN quantity_consumed ELSE 0 END)
      comment: "Total material quantity consumed as scrap. Waste metric used alongside scrap cost to compute material waste rate and drive waste reduction initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_changeover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line changeover performance metrics covering duration efficiency, OEE loss, energy consumption, and SMED (Single-Minute Exchange of Die) improvement tracking. Used by industrial engineers and plant managers to reduce changeover time, improve line flexibility, and minimize OEE losses from model mix changes."
  source: "`vibe_automotive_v1`.`manufacturing`.`changeover`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant changeover performance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level changeover efficiency analysis."
    - name: "changeover_type"
      expr: changeover_type
      comment: "Type of changeover (model, color, tooling, shift) — enables changeover time analysis by type to prioritize SMED improvement efforts."
    - name: "changeover_status"
      expr: changeover_status
      comment: "Current changeover status (planned, in-progress, complete) — used to monitor active changeovers and track completion."
    - name: "from_variant_code"
      expr: from_variant_code
      comment: "Variant code being changed from — supports changeover matrix analysis to identify the most time-consuming variant transitions."
    - name: "to_variant_code"
      expr: to_variant_code
      comment: "Variant code being changed to — used with from_variant_code to build changeover time matrices for production sequencing optimization."
    - name: "operator_retraining_required"
      expr: operator_retraining_required
      comment: "Flag indicating operator retraining was required — used to identify changeovers with high skill complexity and training cost."
    - name: "changeover_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket of changeover start — supports monthly changeover frequency and duration trend reporting."
  measures:
    - name: "total_changeovers"
      expr: COUNT(1)
      comment: "Total number of changeovers. Baseline frequency metric; high changeover counts indicate high model mix complexity and drive SMED investment decisions."
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual changeover duration in minutes. Primary SMED KPI; compared against planned duration to measure changeover efficiency improvement."
    - name: "avg_planned_duration_minutes"
      expr: AVG(CAST(planned_duration_minutes AS DOUBLE))
      comment: "Average planned changeover duration in minutes. Baseline for changeover efficiency analysis and SMED target setting."
    - name: "changeover_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_duration_minutes AS DOUBLE)) / NULLIF(SUM(CAST(actual_duration_minutes AS DOUBLE)), 0), 2)
      comment: "Changeover efficiency rate (planned vs. actual duration). Compound SMED KPI; below-target values trigger changeover process improvement workshops."
    - name: "total_oee_loss_minutes"
      expr: SUM(CAST(oee_loss_minutes AS DOUBLE))
      comment: "Total OEE loss in minutes attributable to changeovers. Quantifies the throughput cost of model mix changes; used to optimize production sequencing and reduce changeover frequency."
    - name: "total_energy_consumed_kwh"
      expr: SUM(CAST(energy_consumed_kwh AS DOUBLE))
      comment: "Total energy consumed during changeovers in kWh. ESG metric tracking energy waste from non-productive changeover activities; used in energy efficiency improvement programs."
    - name: "avg_oee_loss_per_changeover_minutes"
      expr: ROUND(SUM(CAST(oee_loss_minutes AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average OEE loss per changeover in minutes. Compound efficiency metric used to prioritize which changeover types to target for SMED improvement to maximize OEE recovery."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing capacity planning metrics covering utilization, OEE targets, energy budget adherence, and capacity gap analysis. Used by production planning managers and plant directors to make capacity investment decisions, manage bottlenecks, and plan for new model introductions."
  source: "`vibe_automotive_v1`.`manufacturing`.`capacity_plan`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant capacity utilization benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier — supports line-level capacity gap analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (rough-cut, detailed, long-range) — enables analysis by planning horizon."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (draft, approved, active, closed) — used to filter active plans for operational decision-making."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern (1-shift, 2-shift, 3-shift) — supports capacity scenario analysis for different operating models."
    - name: "sustainability_constraint_flag"
      expr: sustainability_constraint_flag
      comment: "Flag indicating the plan includes a sustainability (energy/carbon) constraint — used to track ESG-constrained capacity plans."
    - name: "plan_period_start"
      expr: plan_period_start
      comment: "Start date of the planning period — supports time-series capacity planning analysis."
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_period_start)
      comment: "Month bucket of plan period start — supports monthly capacity planning trend reporting."
  measures:
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average planned capacity utilization percentage. Primary capacity efficiency KPI; values above 85% signal capacity constraints requiring investment or schedule adjustment."
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours AS DOUBLE))
      comment: "Total available capacity hours across plans. Baseline for capacity gap analysis and production scheduling."
    - name: "total_required_capacity_hours"
      expr: SUM(CAST(required_capacity_hours AS DOUBLE))
      comment: "Total required capacity hours based on production demand. Compared against available capacity to identify gaps requiring overtime, additional shifts, or capital investment."
    - name: "capacity_gap_hours"
      expr: SUM((CAST(required_capacity_hours AS DOUBLE)) - (CAST(available_capacity_hours AS DOUBLE)))
      comment: "Capacity gap in hours (required minus available). Positive values indicate capacity shortfalls requiring immediate action; a key input to capital expenditure decisions."
    - name: "avg_oee_target_pct"
      expr: AVG(CAST(oee_target_pct AS DOUBLE))
      comment: "Average OEE target percentage set in capacity plans. Benchmark for OEE performance management; used to assess whether actual OEE meets planned targets."
    - name: "total_energy_budget_kwh"
      expr: SUM(CAST(energy_budget_kwh AS DOUBLE))
      comment: "Total energy budget in kWh across capacity plans. ESG planning metric; compared against actual energy consumption to track energy budget adherence."
    - name: "capacity_utilization_gap_pct"
      expr: ROUND(100.0 * (SUM(CAST(required_capacity_hours AS DOUBLE)) - SUM(CAST(available_capacity_hours AS DOUBLE))) / NULLIF(SUM(CAST(available_capacity_hours AS DOUBLE)), 0), 2)
      comment: "Capacity gap as a percentage of available capacity. Compound capacity risk KPI; values above 10% trigger escalation to plant directors and VP of Manufacturing for resource decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_tooling_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing tooling usage metrics covering wear, OEE contribution, energy consumption, maintenance triggers, and tool life utilization. Used by maintenance engineers, plant managers, and asset managers to optimize tooling lifecycle, prevent unplanned failures, and manage tooling cost."
  source: "`vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier — enables cross-plant tooling performance benchmarking."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — supports station-level tooling wear and maintenance analysis."
    - name: "tool_type"
      expr: tool_type
      comment: "Type of tooling (weld gun, press die, fixture, torque tool) — enables tooling cost and wear analysis by category."
    - name: "process_type"
      expr: process_type
      comment: "Manufacturing process type (welding, stamping, assembly, painting) — supports process-level tooling efficiency analysis."
    - name: "usage_status"
      expr: usage_status
      comment: "Current tooling usage status (active, idle, maintenance, retired) — used to monitor tooling availability and maintenance backlog."
    - name: "maintenance_required_flag"
      expr: maintenance_required_flag
      comment: "Flag indicating maintenance is required — used to track overdue maintenance and prevent unplanned tooling failures."
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_start_timestamp)
      comment: "Month bucket of tooling usage start — supports monthly tooling wear and maintenance trend reporting."
  measures:
    - name: "total_tooling_usage_records"
      expr: COUNT(1)
      comment: "Total number of tooling usage records. Baseline activity metric used to normalize wear and energy metrics per usage event."
    - name: "avg_wear_percentage"
      expr: AVG(CAST(wear_percentage AS DOUBLE))
      comment: "Average tooling wear percentage. Primary tooling health KPI; values approaching 100% trigger preventive maintenance or replacement to avoid unplanned downtime."
    - name: "avg_oee_contribution_pct"
      expr: AVG(CAST(oee_contribution_pct AS DOUBLE))
      comment: "Average OEE contribution percentage per tooling usage. Measures how tooling performance impacts overall equipment effectiveness; low values identify tooling as an OEE loss driver."
    - name: "total_energy_consumed_kwh"
      expr: SUM(CAST(energy_consumed_kwh AS DOUBLE))
      comment: "Total energy consumed by tooling in kWh. ESG metric tracking tooling energy efficiency; used in energy reduction programs and ISO 50001 reporting."
    - name: "maintenance_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN maintenance_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tooling usage records flagging maintenance required. Compound maintenance readiness KPI; high rates indicate deferred maintenance backlog and unplanned failure risk."
    - name: "avg_energy_per_usage_kwh"
      expr: ROUND(SUM(CAST(energy_consumed_kwh AS DOUBLE)) / NULLIF(COUNT(1), 0), 4)
      comment: "Average energy consumed per tooling usage event in kWh. Compound energy efficiency metric used to benchmark tooling energy performance and identify inefficient tools for replacement."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation metrics covering yield, scrap, rework, labor and machine hour efficiency, and energy actuals. Used by production controllers and plant managers to validate production order completion, measure labor efficiency, and track actual vs. planned resource consumption."
  source: "`vibe_automotive_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier — supports station-level yield and efficiency analysis."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of confirmation (partial, final, reversal) — used to filter final confirmations for accurate yield and cost reporting."
    - name: "is_final_confirmation"
      expr: is_final_confirmation
      comment: "Flag indicating this is the final confirmation for the order — used to identify completed orders for cost settlement."
    - name: "oee_contribution_flag"
      expr: oee_contribution_flag
      comment: "Flag indicating this confirmation contributes to OEE calculation — used to filter confirmations relevant to OEE reporting."
    - name: "station_code"
      expr: station_code
      comment: "Station code where confirmation was posted — enables station-level yield and efficiency analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month bucket of confirmation posting date — supports monthly production yield and efficiency trend reporting."
  measures:
    - name: "total_yield_quantity"
      expr: SUM(CAST(yield_quantity AS DOUBLE))
      comment: "Total confirmed yield quantity. Primary production output metric used in production reporting and customer delivery commitment tracking."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity confirmed at production order level. Used in cost of poor quality calculations and material waste reporting."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity confirmed. Quantifies rework volume at the order level for cost settlement and quality reporting."
    - name: "first_time_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(yield_quantity AS DOUBLE)) / NULLIF(SUM(CAST(yield_quantity AS DOUBLE)) + SUM(CAST(scrap_quantity AS DOUBLE)) + SUM(CAST(rework_quantity AS DOUBLE)), 0), 2)
      comment: "First-time yield rate (good units / total attempted). Compound quality KPI measuring the proportion of production completed without scrap or rework; a core metric in quality management systems."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total actual labor hours confirmed. Used in labor cost settlement and workforce efficiency analysis."
    - name: "total_actual_machine_hours"
      expr: SUM(CAST(machine_hours AS DOUBLE))
      comment: "Total actual machine hours confirmed. Used in machine cost settlement and OEE-based capacity analysis."
    - name: "total_energy_consumed_kwh"
      expr: SUM(CAST(energy_consumed_kwh AS DOUBLE))
      comment: "Total energy consumed as confirmed at production order level in kWh. ESG metric for Scope 1 energy reporting at the production order granularity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_agv_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for Automated Guided Vehicle (AGV) movements."
  source: "`vibe_automotive_v1`.`manufacturing`.`agv_movement`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant where the AGV operated."
    - name: "movement_type"
      expr: movement_type
      comment: "Type of movement (e.g., transport, idle)."
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of AGV movements."
$$;