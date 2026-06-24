-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for wafer lot management: cycle time, WIP throughput, hold rates, and on-time delivery performance. Used by fab operations and supply chain leadership to steer capacity and delivery commitments."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Current WIP status of the wafer lot (e.g., IN_PROCESS, ON_HOLD, COMPLETE) for operational segmentation."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of wafer lot (e.g., PRODUCTION, ENGINEERING, QUALIFICATION) to distinguish revenue-generating from R&D starts."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification of the lot (e.g., HOT, NORMAL, LOW) for cycle-time and escalation analysis."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process technology node in nanometers for yield and cycle-time benchmarking by node generation."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm (e.g., 200, 300) for capacity and cost segmentation."
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final or current disposition of the lot (e.g., PASS, SCRAP, REWORK) for quality and loss analysis."
    - name: "fab_facility_code"
      expr: fab_facility_code
      comment: "Fab facility identifier for multi-site performance comparison."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month bucket of planned completion date for on-time delivery trending."
    - name: "wafer_start_month"
      expr: DATE_TRUNC('month', wafer_start_timestamp)
      comment: "Month bucket of wafer start timestamp for WIP intake trending."
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lots in scope. Baseline throughput measure for fab capacity utilization."
    - name: "hot_lot_count"
      expr: COUNT(CASE WHEN is_hot_lot = TRUE THEN 1 END)
      comment: "Number of hot lots requiring expedited processing. High hot-lot counts signal capacity stress or customer escalations."
    - name: "on_hold_lot_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently on hold. Drives quality and operations intervention decisions."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots on hold. A rising hold rate signals systemic quality or process excursion issues requiring leadership action."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time in days across wafer lots. Core fab efficiency KPI used in QBRs and customer delivery commitments."
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average active process time in hours per lot, excluding queue time. Measures pure process efficiency."
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time in hours per lot. High queue time indicates bottleneck equipment or scheduling inefficiency."
    - name: "rework_lot_count"
      expr: COUNT(CASE WHEN CAST(rework_count AS INT) > 0 THEN 1 END)
      comment: "Number of lots that underwent at least one rework cycle. Rework drives cost and cycle-time inflation."
    - name: "scrap_wafer_total"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total scrapped wafers across all lots. Direct measure of material loss and fab cost impact."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level yield KPIs covering die yield, defect rates, and excursion frequency. Core quality and profitability metrics used by yield engineering, process integration, and executive leadership."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition outcome of the yield record (e.g., PASS, FAIL, SCRAP) for quality segmentation."
    - name: "checkpoint_code"
      expr: checkpoint_code
      comment: "Process checkpoint at which yield was measured, enabling step-level yield loss attribution."
    - name: "excursion_severity_level"
      expr: excursion_severity_level
      comment: "Severity classification of any yield excursion (e.g., CRITICAL, MAJOR, MINOR) for prioritized response."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of yield measurement for trend analysis and node ramp tracking."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether the wafer was reworked, enabling yield comparison between rework and non-rework populations."
    - name: "scrap_flag"
      expr: scrap_flag
      comment: "Indicates whether the wafer was scrapped, for scrap rate and cost-of-poor-quality analysis."
    - name: "yield_excursion_flag"
      expr: yield_excursion_flag
      comment: "Flags records with a yield excursion event for excursion frequency and impact analysis."
  measures:
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across wafers. Primary fab profitability KPI — every 1% yield improvement directly reduces cost per die."
    - name: "avg_defect_rate"
      expr: AVG(CAST(defect_rate AS DOUBLE))
      comment: "Average defect rate per wafer. Leading indicator of process health and yield trajectory."
    - name: "yield_excursion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN yield_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield records flagged as excursions. Drives process engineering escalation and corrective action prioritization."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN scrap_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafers scrapped. Direct measure of material loss and cost-of-poor-quality."
    - name: "avg_good_die_count"
      expr: AVG(CAST(good_die_count AS DOUBLE))
      comment: "Average number of good die per wafer. Directly drives revenue per wafer and cost-per-die calculations."
    - name: "avg_gross_die_count"
      expr: AVG(CAST(gross_die_count AS DOUBLE))
      comment: "Average gross die per wafer (theoretical maximum). Used as denominator for yield efficiency benchmarking."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average upper SPC control limit across yield records. Used to assess whether control limits are appropriately set for the process node."
    - name: "avg_specification_limit_lower"
      expr: AVG(CAST(specification_limit_lower AS DOUBLE))
      comment: "Average lower specification limit. Paired with yield percentage to assess process capability margin."
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total yield measurement records. Baseline for yield data coverage and sampling completeness assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment run performance KPIs including process efficiency, cooling optimization, waste elimination, and energy consumption. Used by fab engineering, sustainability, and operations leadership to optimize tool utilization and reduce environmental impact."
  source: "`vibe_semiconductors_v1`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the equipment run (e.g., COMPLETE, ABORTED, IN_PROGRESS) for throughput and abort-rate analysis."
    - name: "process_type"
      expr: process_type
      comment: "Type of process performed (e.g., ETCH, DEPOSITION, LITHO, CMP, IMPLANT) for process-specific KPI segmentation."
    - name: "cooling_method"
      expr: cooling_method
      comment: "Cooling method used during the run (e.g., WATER, AIR, CHILLER) for cooling efficiency benchmarking."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization was active during the run. Enables A/B comparison of optimized vs. non-optimized cooling energy consumption."
    - name: "cooling_optimization_mode"
      expr: cooling_optimization_mode
      comment: "Specific cooling optimization mode applied (e.g., ECO, PERFORMANCE, BALANCED) for mode-level energy analysis."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Flags runs that include a dedicated cooling process step for cooling-specific KPI isolation."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy applied during the run (e.g., RECIRCULATE, RECLAIM, NONE) for sustainability benchmarking."
    - name: "cooling_waste_eliminated_flag"
      expr: cooling_waste_eliminated_flag
      comment: "Indicates whether cooling waste was eliminated during this run. Key sustainability KPI dimension."
    - name: "waste_heat_recovery_flag"
      expr: waste_heat_recovery_flag
      comment: "Indicates whether waste heat was recovered during the run. Drives energy recovery program effectiveness measurement."
    - name: "run_start_month"
      expr: DATE_TRUNC('month', run_start_timestamp)
      comment: "Month bucket of run start for trend analysis of throughput, energy, and cooling efficiency over time."
    - name: "coolant_recycled_flag"
      expr: coolant_recycled_flag
      comment: "Indicates whether coolant was recycled during the run. Tracks coolant sustainability program adoption."
  measures:
    - name: "total_equipment_runs"
      expr: COUNT(1)
      comment: "Total number of equipment runs. Baseline throughput measure for tool utilization and scheduling analysis."
    - name: "avg_run_duration_seconds"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE))
      comment: "Average run duration in seconds. Core tool efficiency KPI — longer-than-expected runs signal process drift or equipment degradation."
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN run_status = 'ABORTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs that were aborted. High abort rates indicate equipment reliability or recipe issues requiring engineering intervention."
    - name: "total_cooling_energy_kwh"
      expr: SUM(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Total cooling energy consumed across all runs in kWh. Primary sustainability and cost KPI for fab cooling infrastructure."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy per run in kWh. Benchmarks cooling efficiency across tools, methods, and optimization modes."
    - name: "avg_cooling_energy_saving_pct"
      expr: AVG(CAST(cooling_energy_saving_pct AS DOUBLE))
      comment: "Average cooling energy saving percentage achieved per run. Measures the effectiveness of cooling optimization programs."
    - name: "total_coolant_waste_volume_liters"
      expr: SUM(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Total coolant waste volume in liters. Environmental compliance and waste reduction KPI tracked by sustainability leadership."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate percentage. Measures coolant recycling program effectiveness and environmental impact reduction."
    - name: "total_waste_heat_recovered_kwh"
      expr: SUM(CAST(waste_heat_recovered_kwh AS DOUBLE))
      comment: "Total waste heat energy recovered in kWh. Quantifies energy recovery program value and offsets cooling infrastructure cost."
    - name: "cooling_optimization_adoption_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_optimization_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs with cooling optimization enabled. Tracks rollout progress of cooling optimization initiatives across the fab."
    - name: "waste_elimination_adoption_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_waste_eliminated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs where cooling waste was eliminated. Measures waste elimination program penetration and effectiveness."
    - name: "avg_cooldown_rate_celsius_per_min"
      expr: AVG(CAST(cooldown_rate_celsius_per_min AS DOUBLE))
      comment: "Average cooldown rate in Celsius per minute. Faster controlled cooldown reduces cycle time; deviations signal thermal management issues."
    - name: "avg_actual_temperature_celsius"
      expr: AVG(CAST(actual_temperature_celsius AS DOUBLE))
      comment: "Average actual process temperature in Celsius. Compared against target temperature to assess process control accuracy."
    - name: "avg_target_temperature_celsius"
      expr: AVG(CAST(target_temperature_celsius AS DOUBLE))
      comment: "Average target process temperature in Celsius. Used as denominator baseline for temperature deviation analysis."
    - name: "avg_deposition_rate_angstrom_per_min"
      expr: AVG(CAST(deposition_rate_angstrom_per_min AS DOUBLE))
      comment: "Average deposition rate in Angstroms per minute for deposition runs. Measures process throughput and recipe stability."
    - name: "avg_deposition_uniformity_pct"
      expr: AVG(CAST(deposition_uniformity_percent AS DOUBLE))
      comment: "Average deposition uniformity percentage. Critical quality KPI for thin-film processes — poor uniformity drives yield loss."
    - name: "avg_cmp_removal_rate"
      expr: AVG(CAST(cmp_removal_rate_angstrom_per_min AS DOUBLE))
      comment: "Average CMP removal rate in Angstroms per minute. Measures CMP process efficiency and consumable health."
    - name: "avg_implant_dose"
      expr: AVG(CAST(implant_dose_atoms_per_cm2 AS DOUBLE))
      comment: "Average ion implant dose in atoms per cm². Deviation from target dose directly impacts device electrical performance."
    - name: "avg_lithography_overlay_x_nm"
      expr: AVG(CAST(lithography_overlay_x_nm AS DOUBLE))
      comment: "Average lithography overlay error in X direction in nm. Critical litho quality KPI — overlay errors cause device failures."
    - name: "avg_lithography_overlay_y_nm"
      expr: AVG(CAST(lithography_overlay_y_nm AS DOUBLE))
      comment: "Average lithography overlay error in Y direction in nm. Paired with X overlay for total overlay budget management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process recipe quality, qualification status, and cooling optimization coverage KPIs. Used by process engineering and quality leadership to govern recipe lifecycle, cooling efficiency, and environmental compliance."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current lifecycle status of the recipe (e.g., ACTIVE, OBSOLETE, UNDER_REVIEW) for recipe governance analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the recipe (e.g., QUALIFIED, IN_QUALIFICATION, FAILED) for process readiness tracking."
    - name: "process_operation_type"
      expr: process_operation_type
      comment: "Operation type (e.g., ETCH, DEPOSITION, ANNEAL, CMP) for process-category KPI segmentation."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization is enabled in the recipe. Enables comparison of energy consumption between optimized and standard recipes."
    - name: "cooling_optimization_option"
      expr: cooling_optimization_option
      comment: "Specific cooling optimization option configured in the recipe (e.g., RAPID_QUENCH, STAGED_COOL, ECO_MODE)."
    - name: "cooling_waste_elimination_option"
      expr: cooling_waste_elimination_option
      comment: "Waste elimination option configured for cooling in the recipe. Tracks adoption of waste-reduction recipe configurations."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the recipe meets environmental compliance requirements. Non-compliant recipes pose regulatory risk."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nm for node-level recipe portfolio analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of recipe effective start date for recipe introduction rate trending."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of process recipes. Baseline for recipe portfolio size and governance coverage."
    - name: "qualified_recipe_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes that are fully qualified. Unqualified recipes in production are a quality and compliance risk."
    - name: "cooling_optimized_recipe_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_optimization_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes with cooling optimization enabled. Tracks progress of cooling efficiency program across the recipe library."
    - name: "avg_cooling_energy_target_kwh"
      expr: AVG(CAST(cooling_energy_target_kwh AS DOUBLE))
      comment: "Average cooling energy target per recipe in kWh. Benchmarks recipe-level cooling efficiency design intent."
    - name: "avg_cooling_energy_consumption_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average actual cooling energy consumption per recipe in kWh. Compared against target to measure cooling efficiency gap."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate configured in recipes. Measures recipe-level sustainability design."
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percentage across recipes. Baseline for assessing whether recipe design intent aligns with fab yield goals."
    - name: "avg_defect_density_target"
      expr: AVG(CAST(defect_density_target_per_cm2 AS DOUBLE))
      comment: "Average defect density target per cm² across recipes. Drives recipe qualification pass/fail criteria and process node benchmarking."
    - name: "avg_process_temperature_celsius"
      expr: AVG(CAST(process_temperature_celsius AS DOUBLE))
      comment: "Average process temperature in Celsius across recipes. Used for thermal budget management and process integration planning."
    - name: "avg_cooling_target_temperature_celsius"
      expr: AVG(CAST(cooling_target_temperature_celsius AS DOUBLE))
      comment: "Average cooling target temperature in Celsius. Benchmarks thermal management design across the recipe portfolio."
    - name: "environmental_compliant_recipe_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes meeting environmental compliance requirements. Non-compliance poses regulatory and operational risk."
    - name: "avg_uniformity_target_pct"
      expr: AVG(CAST(uniformity_target_percent AS DOUBLE))
      comment: "Average uniformity target percentage across recipes. Uniformity is a key process quality parameter affecting die yield."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow portfolio KPIs covering qualification status, cycle time targets, cooling integration, and waste elimination coverage. Used by process integration and technology development leadership."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_flow`"
  dimensions:
    - name: "flow_status"
      expr: flow_status
      comment: "Current status of the process flow (e.g., ACTIVE, DEPRECATED, IN_QUALIFICATION) for portfolio governance."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (e.g., STANDARD, CUSTOM, MPW) for segmentation by business model."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the flow for production readiness tracking."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node associated with the flow for node-level portfolio analysis."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization is enabled in the flow. Tracks cooling efficiency program adoption at the flow level."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy configured in the flow for sustainability program tracking."
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Whether the flow is customer-specific. Customer-specific flows carry higher NRE and customization cost."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of flow effective start for new flow introduction rate analysis."
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of process flows in the portfolio. Baseline for technology breadth and process complexity management."
    - name: "qualified_flow_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows that are fully qualified. Unqualified flows in production are a quality and delivery risk."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days across process flows. Used for customer delivery commitment and capacity planning."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across flows. Benchmarks yield design intent and identifies flows with aggressive or conservative targets."
    - name: "cooling_optimized_flow_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_optimization_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows with cooling optimization enabled. Measures cooling efficiency program coverage across the flow portfolio."
    - name: "avg_cooling_energy_consumption_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption per flow in kWh. Identifies energy-intensive flows for optimization prioritization."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate across flows. Measures sustainability design intent at the flow level."
    - name: "customer_specific_flow_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_customer_specific = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows that are customer-specific. High customer-specific flow ratios increase process complexity and NRE cost."
    - name: "waste_heat_recovery_flow_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_heat_recovery_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows with waste heat recovery enabled. Tracks energy recovery program adoption at the flow design level."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot hold management KPIs covering hold frequency, cycle time, escalation rates, and disposition outcomes. Used by quality, operations, and customer service leadership to minimize hold-driven delivery disruptions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., ACTIVE, RELEASED, EXPIRED) for hold backlog management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (e.g., QUALITY, ENGINEERING, CUSTOMER, COMPLIANCE) for root-cause categorization."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold. Enables Pareto analysis of hold drivers for targeted corrective action."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the hold for systemic issue identification and CAPA prioritization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the hold for escalation and resolution sequencing."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the hold has been escalated. Escalated holds require executive visibility and expedited resolution."
    - name: "hold_placement_month"
      expr: DATE_TRUNC('month', hold_placement_timestamp)
      comment: "Month of hold placement for hold frequency trending and seasonal pattern analysis."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to resolve the hold (e.g., SCRAP, REWORK, USE_AS_IS, RETURN) for disposition outcome analysis."
  measures:
    - name: "total_lot_holds"
      expr: COUNT(1)
      comment: "Total number of lot holds placed. Baseline quality and operational disruption metric."
    - name: "escalated_hold_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that were escalated. High escalation rates signal systemic quality issues or inadequate first-response processes."
    - name: "avg_hold_cycle_time_hours"
      expr: AVG(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Average hold cycle time in hours from placement to release. Long hold cycle times directly impact customer delivery and fab throughput."
    - name: "customer_notification_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring customer notification. Measures customer-impacting quality event frequency."
    - name: "defect_density_threshold_exceeded_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_density_threshold_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds triggered by defect density threshold exceedance. Tracks process control effectiveness."
    - name: "approval_required_hold_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring formal approval for release. High approval-required rates indicate complex quality dispositions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot disposition outcome KPIs covering scrap rates, financial impact, yield loss, and corrective action requirements. Used by quality, finance, and operations leadership to quantify cost-of-poor-quality and drive process improvement."
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition action (e.g., SCRAP, REWORK, USE_AS_IS, RETURN_TO_VENDOR) for outcome categorization."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition (e.g., PENDING, APPROVED, EXECUTED) for workflow tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the disposition event for Pareto analysis and CAPA prioritization."
    - name: "defect_code"
      expr: defect_code
      comment: "Specific defect code driving the disposition for defect type frequency analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action is required for this disposition. Tracks CAPA trigger rate."
    - name: "customer_approval_received"
      expr: customer_approval_received
      comment: "Whether customer approval was received for the disposition. Pending customer approvals block lot release."
    - name: "disposition_month"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of disposition for trend analysis of scrap rates and financial impact over time."
  measures:
    - name: "total_dispositions"
      expr: COUNT(1)
      comment: "Total number of lot dispositions. Baseline for quality event frequency and process stability assessment."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of lot dispositions in USD. Primary cost-of-poor-quality KPI used in executive financial reviews."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disposition event in USD. Benchmarks severity of quality events for prioritization."
    - name: "avg_lot_yield_pct"
      expr: AVG(CAST(lot_yield_percent AS DOUBLE))
      comment: "Average lot yield percentage at disposition. Measures yield performance of lots reaching disposition decision points."
    - name: "corrective_action_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions requiring corrective action. High rates indicate systemic process issues requiring engineering intervention."
    - name: "customer_approval_pending_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_approval_received = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions awaiting customer approval. Pending approvals block lot release and impact delivery performance."
    - name: "avg_good_die_count"
      expr: AVG(CAST(good_die_count AS DOUBLE))
      comment: "Average good die count at disposition. Measures salvageable value from lots reaching disposition."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab facility capacity, environmental, and operational KPIs. Used by operations, sustainability, and capital planning leadership to benchmark facility performance and guide investment decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the facility (e.g., ACTIVE, RAMPING, SHUTDOWN) for capacity availability analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., LOGIC, MEMORY, ANALOG, MIXED) for technology portfolio segmentation."
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification for contamination control benchmarking."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology type (e.g., DUV, EUV) for technology capability segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the facility for geopolitical risk and regional capacity analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the facility (e.g., OPERATIONAL, EOL, PLANNED) for long-range capacity planning."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of fab facilities. Baseline for global manufacturing footprint analysis."
    - name: "total_capacity_wafers_per_month"
      expr: SUM(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Total installed wafer capacity per month across facilities. Primary capacity planning KPI for supply commitment and investment decisions."
    - name: "avg_capacity_wafers_per_month"
      expr: AVG(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Average wafer capacity per month per facility. Benchmarks facility scale for investment and consolidation decisions."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across facilities. Core sustainability and operating cost KPI for executive ESG reporting."
    - name: "total_carbon_footprint_kgco2e"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Total carbon footprint in kg CO2 equivalent across facilities. Primary ESG KPI for net-zero commitment tracking."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water usage in cubic meters across facilities. Environmental compliance and water stewardship KPI."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons across facilities. Environmental compliance and waste reduction program KPI."
    - name: "avg_fab_area_sqft"
      expr: AVG(CAST(fab_area_sqft AS DOUBLE))
      comment: "Average fab floor area in square feet. Used for capacity density benchmarking and expansion planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_start`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization KPIs covering start volumes, cycle time estimates, and production mix. Used by production planning, sales operations, and fab management to align supply with demand commitments."
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer_start`"
  dimensions:
    - name: "wafer_start_status"
      expr: wafer_start_status
      comment: "Status of the wafer start authorization (e.g., AUTHORIZED, PENDING, CANCELLED) for pipeline visibility."
    - name: "wafer_start_type"
      expr: wafer_start_type
      comment: "Type of wafer start (e.g., PRODUCTION, ENGINEERING, MPW, NRE) for demand mix analysis."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the wafer start for scheduling and capacity allocation analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for the wafer start for node-level demand and capacity matching."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter in mm for capacity planning by wafer size."
    - name: "fab_facility_code"
      expr: fab_facility_code
      comment: "Fab facility code for multi-site start volume distribution analysis."
    - name: "wafer_start_month"
      expr: DATE_TRUNC('month', wafer_start_date)
      comment: "Month of wafer start date for demand intake trending and capacity planning."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Whether the wafer start is ITAR-controlled. Drives export compliance workflow and facility eligibility constraints."
  measures:
    - name: "total_wafer_starts"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations. Primary fab demand intake KPI used in capacity planning and revenue forecasting."
    - name: "total_wafer_quantity"
      expr: SUM(CAST(wafer_quantity AS DOUBLE))
      comment: "Total number of wafers authorized to start. Converts start count to wafer volume for capacity utilization analysis."
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days for authorized starts. Used to project completion dates and customer delivery commitments."
    - name: "itar_controlled_start_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wafer starts that are ITAR-controlled. Drives export compliance resource allocation and facility eligibility planning."
    - name: "avg_resistivity_ohm_cm"
      expr: AVG(CAST(resistivity_ohm_cm AS DOUBLE))
      comment: "Average substrate resistivity in ohm-cm across wafer starts. Monitors substrate specification compliance and material quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology node portfolio KPIs covering qualification status, cost structure, yield targets, and compliance posture. Used by technology strategy, finance, and business development leadership."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_technology_node`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the technology node (e.g., QUALIFIED, IN_QUALIFICATION, DEPRECATED) for portfolio readiness tracking."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (e.g., PLANAR, FINFET, GAAFET) for technology generation segmentation."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (e.g., DUV, EUV) for technology capability and cost segmentation."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the node is currently active. Inactive nodes may still carry maintenance cost and customer commitments."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Whether the node is ITAR-controlled. Drives export compliance requirements and customer eligibility constraints."
    - name: "node_generation"
      expr: node_generation
      comment: "Generation classification of the node (e.g., LEADING_EDGE, MATURE, LEGACY) for portfolio lifecycle management."
  measures:
    - name: "total_technology_nodes"
      expr: COUNT(1)
      comment: "Total number of technology nodes in the portfolio. Baseline for technology breadth and portfolio complexity management."
    - name: "qualified_node_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technology nodes that are fully qualified. Unqualified nodes in production represent quality and delivery risk."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nm across nodes. Tracks technology portfolio advancement toward leading-edge capabilities."
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD per node. Critical NRE cost input for customer pricing and technology investment decisions."
    - name: "total_nre_cost_estimate_usd"
      expr: SUM(CAST(nre_cost_estimate_usd AS DOUBLE))
      comment: "Total NRE cost estimate across technology nodes. Measures R&D investment required to maintain the technology portfolio."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across nodes. Benchmarks yield design intent and identifies nodes with yield improvement opportunity."
    - name: "itar_controlled_node_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technology nodes that are ITAR-controlled. Drives export compliance program scope and customer eligibility management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot move transaction KPIs covering throughput, queue time, rework rates, and cooling process adoption at the move level. Used by MES operations and fab management to optimize WIP flow and identify bottlenecks."
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_move`"
  dimensions:
    - name: "move_status"
      expr: move_status
      comment: "Status of the lot move transaction (e.g., COMPLETE, PENDING, REJECTED) for WIP flow analysis."
    - name: "process_module"
      expr: process_module
      comment: "Process module where the move occurred for bottleneck identification and module-level throughput analysis."
    - name: "process_layer"
      expr: process_layer
      comment: "Process layer associated with the move for layer-level cycle time and yield analysis."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Whether the move involved a cooling process step. Enables cooling-specific throughput and energy analysis."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization was active during this move. Enables A/B analysis of cooling optimization impact on cycle time."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Whether the move was a rework move. Rework moves inflate cycle time and cost."
    - name: "sampling_flag"
      expr: sampling_flag
      comment: "Whether the move triggered a sampling event. Tracks sampling plan execution compliance."
    - name: "move_in_month"
      expr: DATE_TRUNC('month', move_in_timestamp)
      comment: "Month of move-in timestamp for WIP throughput trending."
  measures:
    - name: "total_lot_moves"
      expr: COUNT(1)
      comment: "Total number of lot move transactions. Primary WIP throughput KPI for fab operations management."
    - name: "rework_move_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of moves that are rework moves. High rework rates inflate cycle time and cost, signaling process instability."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average in-line measurement value recorded at move. Tracks process parameter trends for SPC and yield correlation."
    - name: "avg_cooling_energy_consumption_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumed per lot move in kWh. Measures cooling energy efficiency at the move transaction level."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate at the move level. Tracks coolant sustainability performance at granular process step level."
    - name: "total_coolant_waste_volume_liters"
      expr: SUM(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Total coolant waste volume in liters across all moves. Environmental compliance KPI for coolant waste reduction programs."
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_c AS DOUBLE))
      comment: "Average actual process temperature in Celsius at move level. Used for process control monitoring and SPC analysis."
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual process pressure in Torr at move level. Pressure deviations from target indicate equipment or recipe issues."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_spc_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SPC control plan coverage and specification limit KPIs. Used by process engineering and quality leadership to ensure adequate statistical process control coverage across technology nodes and process steps."
  source: "`vibe_semiconductors_v1`.`fabrication`.`spc_control_plan`"
  dimensions:
    - name: "spc_control_plan_status"
      expr: spc_control_plan_status
      comment: "Current status of the SPC control plan (e.g., ACTIVE, SUPERSEDED, DRAFT) for governance coverage analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of SPC control plan (e.g., XBAR_R, EWMA, CUSUM) for methodology coverage analysis."
    - name: "target_metric"
      expr: target_metric
      comment: "The process metric being controlled (e.g., CD, THICKNESS, OVERLAY) for metric-level SPC coverage analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the control plan covers a critical process parameter. Critical parameters require tighter monitoring and faster response."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the controlled metric for dimensional analysis and cross-plan comparison."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of plan effective start for SPC coverage expansion tracking."
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total number of SPC control plans. Baseline for process control coverage breadth."
    - name: "active_control_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN spc_control_plan_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of control plans that are currently active. Low active rates indicate stale or inadequate SPC coverage."
    - name: "critical_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of control plans covering critical parameters. Ensures adequate monitoring of yield-critical process parameters."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across control plans. Used for process centering analysis and specification alignment review."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average upper control limit across plans. Benchmarks control limit tightness relative to specification limits."
    - name: "avg_control_limit_lower"
      expr: AVG(CAST(control_limit_lower AS DOUBLE))
      comment: "Average lower control limit across plans. Paired with upper control limit for process capability assessment."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across plans. Used to assess control-to-spec margin and process capability."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across plans. Paired with upper spec limit for Cpk and process capability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_mask_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mask set portfolio KPIs covering cost, utilization, quality, and lifecycle status. Used by technology development, finance, and operations leadership to manage mask set investment and retirement decisions."
  source: "`vibe_semiconductors_v1`.`fabrication`.`mask_set`"
  dimensions:
    - name: "mask_set_status"
      expr: mask_set_status
      comment: "Current status of the mask set (e.g., ACTIVE, RETIRED, IN_INSPECTION) for portfolio lifecycle management."
    - name: "mask_type"
      expr: mask_type
      comment: "Type of mask (e.g., BINARY, ATTPSM, ALTPSM, EUV) for technology and cost segmentation."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology associated with the mask set for technology generation analysis."
    - name: "mask_set_category"
      expr: mask_set_category
      comment: "Category of the mask set (e.g., PRODUCTION, ENGINEERING, QUALIFICATION) for investment classification."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the most recent mask inspection (e.g., PASS, FAIL, CONDITIONAL) for quality monitoring."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the mask set for tiered usage and retirement decision support."
  measures:
    - name: "total_mask_sets"
      expr: COUNT(1)
      comment: "Total number of mask sets in the portfolio. Baseline for mask asset management and NRE investment tracking."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost in USD. Primary NRE investment KPI for technology node economics and customer pricing."
    - name: "avg_mask_cost_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD. Benchmarks mask cost trends across technology generations for investment planning."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average number of times mask sets have been used. Low usage counts on expensive mask sets indicate underutilization of NRE investment."
    - name: "avg_mask_thickness_nm"
      expr: AVG(CAST(mask_thickness_nm AS DOUBLE))
      comment: "Average mask thickness in nm. Monitors mask specification compliance and quality consistency."
    - name: "avg_wavelength_nm"
      expr: AVG(CAST(wavelength_nm AS DOUBLE))
      comment: "Average exposure wavelength in nm across mask sets. Tracks technology portfolio migration toward shorter wavelengths."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mask sets passing inspection. Low pass rates indicate mask quality issues that can drive yield loss."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process step configuration KPIs covering cycle time targets, cooling requirements, critical step coverage, and cost per wafer. Used by process engineering and operations leadership to optimize step-level efficiency and cost."
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_step`"
  dimensions:
    - name: "step_status"
      expr: step_status
      comment: "Current status of the process step (e.g., ACTIVE, DEPRECATED, UNDER_REVIEW) for step portfolio governance."
    - name: "operation_type"
      expr: operation_type
      comment: "Operation type of the step (e.g., ETCH, DEPOSITION, LITHO, CMP, IMPLANT) for process category analysis."
    - name: "process_category"
      expr: process_category
      comment: "Process category for higher-level step grouping and cost allocation analysis."
    - name: "critical_step_flag"
      expr: critical_step_flag
      comment: "Whether the step is classified as critical. Critical steps require tighter control and have higher yield impact."
    - name: "cooling_required_flag"
      expr: cooling_required_flag
      comment: "Whether a cooling step is required after this process step. Drives cooling capacity planning and cycle time estimation."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization is enabled for this step. Tracks cooling efficiency program adoption at step level."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether inspection is required after this step. Inspection-required steps add cycle time but protect yield."
    - name: "rework_loop_indicator"
      expr: rework_loop_indicator
      comment: "Whether this step is part of a rework loop. Rework loop steps contribute to cycle time inflation."
  measures:
    - name: "total_process_steps"
      expr: COUNT(1)
      comment: "Total number of process steps in the portfolio. Baseline for process complexity and flow length analysis."
    - name: "critical_step_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_step_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of steps classified as critical. High critical step ratios indicate complex processes with elevated yield risk."
    - name: "cooling_required_step_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of steps requiring cooling. Drives cooling infrastructure capacity planning and energy budget estimation."
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time per step in minutes. Used for total flow cycle time estimation and bottleneck identification."
    - name: "avg_step_cost_per_wafer"
      expr: AVG(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Average cost per wafer per process step in USD. Drives wafer cost model accuracy and process cost optimization."
    - name: "avg_sampling_rate_pct"
      expr: AVG(CAST(sampling_rate_percent AS DOUBLE))
      comment: "Average sampling rate percentage across steps. Balances quality assurance coverage against throughput impact."
    - name: "avg_max_queue_time_minutes"
      expr: AVG(CAST(max_queue_time_minutes AS DOUBLE))
      comment: "Average maximum allowed queue time in minutes. Steps with tight queue time limits constrain scheduling flexibility."
    - name: "avg_cooling_energy_consumption_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption per step in kWh. Identifies energy-intensive steps for cooling optimization prioritization."
$$;