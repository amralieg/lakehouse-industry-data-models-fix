-- Metric views for domain: design | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for IC design projects — tracks NRE spend efficiency, tapeout schedule adherence, and portfolio health across process nodes and design phases."
  source: "`vibe_semiconductors_v1`.`design`.`ic_design_project`"
  dimensions:
    - name: "design_phase"
      expr: design_phase
      comment: "Current phase of the IC design project (e.g., RTL, synthesis, layout, tapeout) for phase-gate analysis."
    - name: "design_type"
      expr: design_type
      comment: "Type of design (ASIC, SoC, IP, custom) for portfolio segmentation."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers (e.g., 7nm, 5nm) for technology-node-level analysis."
    - name: "project_status"
      expr: project_status
      comment: "Current status of the design project (active, on-hold, cancelled, completed) for pipeline health monitoring."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (DUV, EUV) for cost and complexity segmentation."
    - name: "tapeout_target_year_month"
      expr: DATE_TRUNC('MONTH', tapeout_target_date)
      comment: "Month of planned tapeout for schedule trend analysis."
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the project started for cohort and vintage analysis."
    - name: "dft_enabled"
      expr: dft_enabled
      comment: "Whether design-for-test is enabled, for DFT adoption tracking."
    - name: "iatf_automotive_grade"
      expr: iatf_automotive_grade
      comment: "Whether the project targets automotive-grade qualification, for market segment analysis."
  measures:
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total NRE budget committed across all design projects. Drives investment planning and resource allocation decisions."
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend across all design projects. Compared against budget to assess cost control."
    - name: "avg_nre_budget_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per design project. Benchmarks investment level per project for portfolio planning."
    - name: "nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed. A key financial health indicator — over 100% signals cost overrun requiring executive intervention."
    - name: "total_gate_count_target_k"
      expr: SUM(CAST(gate_count_target_k AS DOUBLE))
      comment: "Total gate count target (in thousands) across active projects. Indicates design complexity and resource demand."
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area in mm². Drives mask cost and wafer yield forecasting."
    - name: "avg_target_power_budget_mw"
      expr: AVG(CAST(target_power_budget_mw AS DOUBLE))
      comment: "Average target power budget in milliwatts. Critical for thermal and packaging qualification decisions."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'active' THEN ic_design_project_id END)
      comment: "Number of currently active design projects. Tracks pipeline capacity and engineering resource load."
    - name: "tapeout_on_time_count"
      expr: COUNT(CASE WHEN tapeout_actual_date <= tapeout_target_date AND tapeout_actual_date IS NOT NULL THEN ic_design_project_id END)
      comment: "Number of projects that taped out on or before the target date. Measures schedule execution discipline."
    - name: "tapeout_schedule_attainment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tapeout_actual_date <= tapeout_target_date AND tapeout_actual_date IS NOT NULL THEN ic_design_project_id END) / NULLIF(COUNT(CASE WHEN tapeout_actual_date IS NOT NULL THEN ic_design_project_id END), 0), 2)
      comment: "Percentage of completed tapeouts delivered on schedule. A top-tier KPI for design execution — directly impacts revenue timing and customer commitments."
    - name: "avg_target_clock_freq_mhz"
      expr: AVG(CAST(target_clock_freq_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz across projects. Tracks performance ambition and process node utilization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout execution KPIs — tracks design quality at tapeout, cost efficiency, yield expectations, and signoff completeness. Tapeout is the highest-stakes milestone in IC design."
  source: "`vibe_semiconductors_v1`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Current status of the tapeout (submitted, approved, rejected, in-progress) for pipeline tracking."
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (full, MPW, re-spin) for cost and risk segmentation."
    - name: "process_node"
      expr: process_node
      comment: "Process node (e.g., 7nm, 5nm) for technology-level tapeout analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (DUV, EUV) for cost and complexity analysis."
    - name: "design_type"
      expr: design_type
      comment: "Design type (ASIC, SoC, IP) for portfolio segmentation."
    - name: "tapeout_year_month"
      expr: DATE_TRUNC('MONTH', tapeout_date)
      comment: "Month of actual tapeout for trend and cadence analysis."
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Whether timing closure was achieved at tapeout — a critical quality gate indicator."
    - name: "drc_clean"
      expr: drc_clean
      comment: "Whether the design passed DRC (Design Rule Check) cleanly at tapeout."
    - name: "lvs_clean"
      expr: lvs_clean
      comment: "Whether the design passed LVS (Layout vs. Schematic) cleanly at tapeout."
  measures:
    - name: "total_tapeout_count"
      expr: COUNT(1)
      comment: "Total number of tapeouts. Tracks design throughput and foundry submission volume."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost across all tapeouts. A primary financial KPI for design investment tracking."
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost across tapeouts. Mask costs are a major capital commitment — tracked for budget control."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm² across tapeouts. Drives wafer cost and yield projections."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected die yield percentage at tapeout. A leading indicator of wafer economics and product profitability."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design-for-Manufacturability score at tapeout. Higher scores correlate with better yield and fewer re-spins."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average Design-for-Test coverage percentage. Drives test escape risk and quality cost decisions."
    - name: "drc_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drc_clean = TRUE THEN tapeout_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts with clean DRC. A critical quality gate metric — low rates indicate design process issues requiring intervention."
    - name: "signoff_complete_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_checklist_complete = TRUE THEN tapeout_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tapeouts with complete signoff checklists. Measures process discipline and risk management at the most critical design milestone."
    - name: "on_schedule_tapeout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tapeout_date <= target_tapeout_date AND tapeout_date IS NOT NULL THEN tapeout_id END) / NULLIF(COUNT(CASE WHEN tapeout_date IS NOT NULL THEN tapeout_id END), 0), 2)
      comment: "Percentage of tapeouts completed on or before the target date. Directly impacts revenue recognition and customer delivery commitments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_simulation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulation execution KPIs — tracks verification coverage attainment, compute resource consumption, and pass/fail rates across design simulation runs."
  source: "`vibe_semiconductors_v1`.`design`.`simulation_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of simulation run (functional, timing, power, formal) for coverage analysis by verification method."
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the simulation run (pass, fail, running, aborted) for pipeline health monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Final pass/fail outcome of the simulation run for quality gate tracking."
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage at which the simulation was run (RTL, gate-level, post-layout) for stage-gate analysis."
    - name: "process_corner"
      expr: process_corner
      comment: "PVT corner (TT, SS, FF, etc.) used in the simulation for corner coverage analysis."
    - name: "run_year_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the simulation run started for trend analysis of verification throughput."
    - name: "signoff_approved"
      expr: signoff_approved
      comment: "Whether the run was approved for signoff — distinguishes exploratory from gate-critical runs."
    - name: "run_subtype"
      expr: run_subtype
      comment: "Sub-type of simulation run for granular verification methodology analysis."
  measures:
    - name: "total_simulation_runs"
      expr: COUNT(1)
      comment: "Total number of simulation runs. Tracks verification throughput and engineering activity."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'pass' THEN simulation_run_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulation runs that passed. A primary verification quality KPI — low pass rates signal design instability requiring escalation."
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage achieved across simulation runs. Measures verification completeness — below target triggers additional test development."
    - name: "avg_code_coverage_pct"
      expr: AVG(CAST(code_coverage_pct AS DOUBLE))
      comment: "Average code coverage percentage. Tracks RTL verification thoroughness and identifies untested logic paths."
    - name: "avg_toggle_coverage_pct"
      expr: AVG(CAST(toggle_coverage_pct AS DOUBLE))
      comment: "Average toggle coverage percentage. Complements functional coverage to ensure all logic nodes are exercised."
    - name: "avg_assertion_coverage_pct"
      expr: AVG(CAST(assertion_coverage_pct AS DOUBLE))
      comment: "Average assertion coverage percentage. Measures formal property verification completeness."
    - name: "total_cpu_hours_consumed"
      expr: SUM(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Total CPU hours consumed by simulation runs. Drives compute infrastructure investment and cost allocation decisions."
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average simulation run duration in minutes. Tracks verification cycle time — long runtimes constrain tapeout schedules."
    - name: "avg_peak_memory_gb"
      expr: AVG(CAST(peak_memory_gb AS DOUBLE))
      comment: "Average peak memory consumption per simulation run. Informs compute cluster sizing and capacity planning."
    - name: "signoff_approved_run_count"
      expr: COUNT(CASE WHEN signoff_approved = TRUE THEN simulation_run_id END)
      comment: "Number of simulation runs approved for tapeout signoff. Tracks verification milestone completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_timing_analysis_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timing closure KPIs — tracks worst-case slack, violation counts, and signoff readiness across timing analysis runs. Timing closure is a critical tapeout gate."
  source: "`vibe_semiconductors_v1`.`design`.`timing_analysis_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the timing analysis run (pass, fail, in-progress) for pipeline tracking."
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Whether timing closure was achieved — the primary gate for tapeout authorization."
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage (synthesis, place-and-route, signoff) for stage-gate timing analysis."
    - name: "pvt_corner"
      expr: pvt_corner
      comment: "Process-Voltage-Temperature corner analyzed for corner coverage completeness."
    - name: "is_signoff_run"
      expr: is_signoff_run
      comment: "Whether this is a formal signoff timing run — distinguishes exploratory from gate-critical analysis."
    - name: "is_multi_corner_run"
      expr: is_multi_corner_run
      comment: "Whether the run covers multiple PVT corners for comprehensive timing sign-off."
    - name: "run_year_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month the timing run was executed for trend analysis."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology-level timing performance benchmarking."
  measures:
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timing_closure_status = 'closed' THEN timing_analysis_run_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timing runs achieving closure. The primary timing quality KPI — below target blocks tapeout and delays revenue."
    - name: "avg_worst_negative_slack_ps"
      expr: AVG(CAST(worst_negative_slack_ps AS DOUBLE))
      comment: "Average worst negative setup slack in picoseconds. Negative values indicate timing violations — drives re-spin risk assessment."
    - name: "avg_worst_hold_slack_ps"
      expr: AVG(CAST(worst_hold_slack_ps AS DOUBLE))
      comment: "Average worst hold slack in picoseconds. Hold violations are critical — they cannot be fixed post-silicon."
    - name: "avg_total_negative_slack_ps"
      expr: AVG(CAST(total_negative_slack_ps AS DOUBLE))
      comment: "Average total negative slack (TNS) in picoseconds. TNS quantifies the aggregate timing debt across all violating paths."
    - name: "avg_total_hold_negative_slack_ps"
      expr: AVG(CAST(total_hold_negative_slack_ps AS DOUBLE))
      comment: "Average total hold negative slack in picoseconds. Aggregate hold timing debt across all paths."
    - name: "avg_clock_frequency_target_mhz"
      expr: AVG(CAST(clock_frequency_target_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz. Tracks performance ambition vs. achievable timing closure."
    - name: "signoff_run_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_signoff_run = TRUE AND timing_closure_status = 'closed' THEN timing_analysis_run_id END) / NULLIF(COUNT(CASE WHEN is_signoff_run = TRUE THEN timing_analysis_run_id END), 0), 2)
      comment: "Percentage of formal signoff timing runs achieving closure. The most critical timing KPI — directly gates tapeout authorization."
    - name: "avg_supply_voltage_v"
      expr: AVG(CAST(supply_voltage_v AS DOUBLE))
      comment: "Average supply voltage used in timing analysis. Tracks operating condition coverage for reliability sign-off."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical layout quality KPIs — tracks DRC/LVS cleanliness, area utilization, power, and timing closure across layout iterations. Layout quality directly determines tapeout readiness."
  source: "`vibe_semiconductors_v1`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Current status of the physical layout (in-progress, complete, tapeout-ready) for pipeline tracking."
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Implementation stage (floorplan, placement, routing, signoff) for stage-gate quality analysis."
    - name: "eda_tool"
      expr: eda_tool
      comment: "EDA tool used for layout implementation for tool performance benchmarking."
    - name: "lvs_clean"
      expr: lvs_clean
      comment: "Whether the layout passed LVS cleanly — a hard tapeout gate."
    - name: "em_compliant"
      expr: em_compliant
      comment: "Whether the layout meets electromigration rules — critical for long-term reliability."
    - name: "tapeout_year_month"
      expr: DATE_TRUNC('MONTH', tapeout_date)
      comment: "Month of tapeout for layout completion trend analysis."
    - name: "metal_layer_count"
      expr: metal_layer_count
      comment: "Number of metal layers in the layout for complexity and cost segmentation."
  measures:
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in mm². Directly drives mask cost, wafer yield, and product pricing."
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage. Low utilization wastes die area; high utilization risks routing congestion."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts at layout stage. Drives thermal and packaging qualification decisions."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts. Critical for mobile and IoT product power budgets."
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts. Excessive IR drop causes functional failures — a key power integrity KPI."
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage. High congestion blocks timing closure and increases re-spin risk."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average DFM score across layouts. Higher scores predict better manufacturing yield."
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average DFT coverage percentage at layout stage. Drives test escape risk and quality cost."
    - name: "lvs_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lvs_clean = TRUE THEN physical_layout_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of layouts passing LVS cleanly. A hard tapeout gate — below 100% requires immediate engineering action."
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds at layout stage. Tracks timing closure progress through implementation."
    - name: "avg_metal_fill_density_pct"
      expr: AVG(CAST(metal_fill_density_pct AS DOUBLE))
      comment: "Average metal fill density percentage. Ensures CMP planarity compliance — deviations cause yield loss."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_netlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Netlist quality and synthesis KPIs — tracks gate count, timing, power, and DFT coverage at the netlist stage. Netlist quality gates physical implementation."
  source: "`vibe_semiconductors_v1`.`design`.`netlist`"
  dimensions:
    - name: "netlist_type"
      expr: netlist_type
      comment: "Type of netlist (RTL, gate-level, post-layout) for stage-specific quality analysis."
    - name: "synthesis_status"
      expr: synthesis_status
      comment: "Status of synthesis run that produced the netlist (pass, fail, warning) for quality gate tracking."
    - name: "timing_closure_achieved"
      expr: timing_closure_achieved
      comment: "Whether timing closure was achieved at netlist stage — gates progression to physical implementation."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology-level netlist benchmarking."
    - name: "synthesis_year_month"
      expr: DATE_TRUNC('MONTH', synthesis_run_timestamp)
      comment: "Month of synthesis run for throughput trend analysis."
    - name: "format"
      expr: format
      comment: "Netlist file format (Verilog, VHDL, SPICE) for tool compatibility tracking."
  measures:
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count across netlists. Tracks design complexity growth and correlates with die area and cost."
    - name: "total_gate_count"
      expr: SUM(CAST(gate_count AS DOUBLE))
      comment: "Total gate count across all netlists. Aggregate design complexity metric for portfolio analysis."
    - name: "avg_critical_path_delay_ps"
      expr: AVG(CAST(critical_path_delay_ps AS DOUBLE))
      comment: "Average critical path delay in picoseconds. Directly determines maximum achievable clock frequency."
    - name: "avg_total_power_estimate_mw"
      expr: AVG(CAST(total_power_estimate_mw AS DOUBLE))
      comment: "Average total power estimate in milliwatts at netlist stage. Early power budget validation KPI."
    - name: "avg_dynamic_power_mw"
      expr: AVG(CAST(dynamic_power_mw AS DOUBLE))
      comment: "Average dynamic power in milliwatts. Drives thermal design and battery life projections."
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts. Critical for standby power specifications."
    - name: "avg_dft_scan_coverage_pct"
      expr: AVG(CAST(dft_scan_coverage_pct AS DOUBLE))
      comment: "Average DFT scan coverage percentage at netlist stage. Drives test quality and escape risk assessment."
    - name: "avg_synthesis_runtime_minutes"
      expr: AVG(CAST(synthesis_runtime_minutes AS DOUBLE))
      comment: "Average synthesis runtime in minutes. Tracks EDA tool efficiency and design cycle time."
    - name: "timing_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timing_closure_achieved = TRUE THEN netlist_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of netlists achieving timing closure. Gates progression to physical implementation — low rates delay tapeout."
    - name: "avg_area_estimate_um2"
      expr: AVG(CAST(area_estimate_um2 AS DOUBLE))
      comment: "Average area estimate in square microns at netlist stage. Early die size predictor for cost and yield modeling."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design milestone execution KPIs — tracks gate review outcomes, schedule adherence, and quality metrics at key design checkpoints. Milestone health predicts tapeout success."
  source: "`vibe_semiconductors_v1`.`design`.`design_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of design milestone (PDR, CDR, tapeout, silicon bring-up) for stage-gate analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (planned, in-review, passed, failed, waived) for pipeline health monitoring."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Gate review disposition (approved, approved-with-conditions, rejected) for quality gate tracking."
    - name: "nre_phase"
      expr: nre_phase
      comment: "NRE phase associated with the milestone for financial milestone tracking."
    - name: "process_node"
      expr: process_node
      comment: "Process node for technology-level milestone performance analysis."
    - name: "planned_year_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned for schedule trend analysis."
    - name: "gate_criteria_met"
      expr: gate_criteria_met
      comment: "Whether all gate criteria were met at the milestone review."
    - name: "tapeout_authorized"
      expr: tapeout_authorized
      comment: "Whether tapeout was authorized at this milestone — the ultimate design gate."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of design milestones. Tracks design program activity and gate review cadence."
    - name: "gate_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_criteria_met = TRUE THEN design_milestone_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones where all gate criteria were met. Primary design quality KPI — low rates indicate systemic design process issues."
    - name: "tapeout_authorization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tapeout_authorized = TRUE THEN design_milestone_id END) / NULLIF(COUNT(CASE WHEN milestone_type = 'tapeout' THEN design_milestone_id END), 0), 2)
      comment: "Percentage of tapeout milestones resulting in authorization. Measures final design readiness and executive go/no-go decision quality."
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area at milestone review in mm². Tracks area growth through design iterations."
    - name: "avg_power_budget_mw"
      expr: AVG(CAST(power_budget_mw AS DOUBLE))
      comment: "Average power budget at milestone in milliwatts. Tracks power compliance through design gates."
    - name: "avg_timing_slack_worst_ps"
      expr: AVG(CAST(timing_slack_worst_ps AS DOUBLE))
      comment: "Average worst timing slack in picoseconds at milestone. Tracks timing closure progress through design gates."
    - name: "on_schedule_milestone_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date AND actual_date IS NOT NULL THEN design_milestone_id END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN design_milestone_id END), 0), 2)
      comment: "Percentage of milestones completed on or before the planned date. Schedule execution KPI — directly impacts tapeout timing and revenue."
    - name: "dfm_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_sign_off = TRUE THEN design_milestone_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones with DFM sign-off completed. Tracks manufacturability validation discipline."
    - name: "ip_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ip_clearance_confirmed = TRUE THEN design_milestone_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones with IP clearance confirmed. Tracks IP compliance — failures create legal and export control risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core portfolio KPIs — tracks IP reuse economics, licensing costs, qualification status, and silicon validation across the IP library. IP reuse is a primary design cost lever."
  source: "`vibe_semiconductors_v1`.`design`.`design_ip_core`"
  dimensions:
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (hard, soft, firm) for portfolio composition analysis."
    - name: "function_category"
      expr: function_category
      comment: "Functional category of the IP (memory, interface, processor, analog) for technology portfolio analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the IP core (active, deprecated, obsolete) for portfolio health management."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the IP core for risk assessment in design integration."
    - name: "silicon_proven"
      expr: silicon_proven
      comment: "Whether the IP has been silicon-proven — a key risk differentiator for design decisions."
    - name: "license_type"
      expr: license_type
      comment: "License type (royalty-bearing, paid-up, open-source) for IP cost model analysis."
    - name: "source_type"
      expr: source_type
      comment: "Source of the IP (internal, third-party, open-source) for make-vs-buy analysis."
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the IP core was released for vintage and technology currency analysis."
  measures:
    - name: "total_ip_core_count"
      expr: COUNT(1)
      comment: "Total number of IP cores in the library. Tracks IP portfolio breadth and reuse potential."
    - name: "silicon_proven_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN silicon_proven = TRUE THEN design_ip_core_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are silicon-proven. Higher rates reduce design risk and re-spin probability."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total IP licensing fees across the portfolio. A major NRE cost component — tracked for IP spend optimization."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average IP license fee per core. Benchmarks IP acquisition cost for make-vs-buy decisions."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate percentage across licensed IP cores. Drives product margin modeling and pricing decisions."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average IP core area in square microns. Drives die area contribution analysis for cost optimization."
    - name: "avg_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in MHz. Tracks IP performance capability across the portfolio."
    - name: "avg_power_uw"
      expr: AVG(CAST(power_uw AS DOUBLE))
      comment: "Average IP core power consumption in microwatts. Drives power budget allocation in SoC design."
    - name: "avg_scan_coverage_pct"
      expr: AVG(CAST(scan_coverage_pct AS DOUBLE))
      comment: "Average scan coverage percentage across IP cores. Tracks DFT quality of the IP library."
    - name: "dfm_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_compliant = TRUE THEN design_ip_core_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP cores that are DFM-compliant. Non-compliant IP increases yield risk and re-spin probability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_mpw_shuttle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MPW shuttle economics and execution KPIs — tracks shuttle cost efficiency, schedule adherence, and capacity utilization. MPW shuttles are a critical cost-sharing mechanism for design validation."
  source: "`vibe_semiconductors_v1`.`design`.`mpw_shuttle`"
  dimensions:
    - name: "shuttle_status"
      expr: shuttle_status
      comment: "Current status of the MPW shuttle (open, closed, in-fab, complete) for pipeline tracking."
    - name: "shuttle_type"
      expr: shuttle_type
      comment: "Type of shuttle (MPW, engineering, production) for cost and purpose segmentation."
    - name: "process_node"
      expr: process_node
      comment: "Process node for technology-level shuttle economics analysis."
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV) for cost driver analysis."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Whether the shuttle is eligible for CHIPS Act funding — impacts net cost and investment decisions."
    - name: "scheduled_tapeout_year_month"
      expr: DATE_TRUNC('MONTH', scheduled_tapeout_date)
      comment: "Month of scheduled tapeout for shuttle capacity planning."
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter (200mm, 300mm) for cost and capacity analysis."
  measures:
    - name: "total_shuttle_cost_usd"
      expr: SUM(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Total cost across all MPW shuttles. Primary financial KPI for design validation investment tracking."
    - name: "avg_shuttle_cost_usd"
      expr: AVG(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Average cost per MPW shuttle. Benchmarks shuttle economics for make-vs-buy and foundry selection decisions."
    - name: "avg_cost_per_mm2_usd"
      expr: AVG(CAST(cost_per_mm2_usd AS DOUBLE))
      comment: "Average cost per mm² of reticle area. The key unit economics metric for MPW shuttle pricing and design area optimization."
    - name: "total_mask_set_cost_usd"
      expr: SUM(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Total mask set cost across shuttles. Mask costs are a major capital commitment in advanced node design."
    - name: "avg_total_reticle_area_mm2"
      expr: AVG(CAST(total_reticle_area_mm2 AS DOUBLE))
      comment: "Average total reticle area per shuttle in mm². Tracks shuttle capacity utilization."
    - name: "on_schedule_tapeout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_tapeout_date <= scheduled_tapeout_date AND actual_tapeout_date IS NOT NULL THEN mpw_shuttle_id END) / NULLIF(COUNT(CASE WHEN actual_tapeout_date IS NOT NULL THEN mpw_shuttle_id END), 0), 2)
      comment: "Percentage of shuttles that taped out on schedule. Schedule adherence directly impacts customer design validation timelines."
    - name: "avg_nre_cost_center_utilization"
      expr: COUNT(DISTINCT nre_cost_center_code)
      comment: "Number of distinct NRE cost centers using MPW shuttles. Tracks cross-organizational shuttle utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_verification_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification planning KPIs — tracks coverage targets, signoff readiness, and safety compliance across verification plans. Verification completeness is a primary quality and risk management KPI."
  source: "`vibe_semiconductors_v1`.`design`.`verification_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the verification plan (draft, approved, active, complete) for pipeline tracking."
    - name: "verification_methodology"
      expr: verification_methodology
      comment: "Verification methodology (UVM, OVM, formal, emulation) for methodology adoption analysis."
    - name: "design_type"
      expr: design_type
      comment: "Design type being verified for portfolio-level verification analysis."
    - name: "safety_criticality_level"
      expr: safety_criticality_level
      comment: "Safety criticality level (ASIL-A through ASIL-D, QM) for functional safety compliance tracking."
    - name: "signoff_approved"
      expr: signoff_approved
      comment: "Whether the verification plan has been approved for signoff — gates tapeout authorization."
    - name: "plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the verification plan started for cohort analysis."
    - name: "fault_injection_campaign_planned"
      expr: fault_injection_campaign_planned
      comment: "Whether a fault injection campaign is planned — indicates safety-critical verification rigor."
  measures:
    - name: "signoff_approved_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_approved = TRUE THEN verification_plan_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification plans approved for signoff. Primary verification completion KPI — gates tapeout authorization."
    - name: "avg_functional_coverage_target_pct"
      expr: AVG(CAST(functional_coverage_target_pct AS DOUBLE))
      comment: "Average functional coverage target percentage. Tracks verification ambition level across the design portfolio."
    - name: "avg_code_coverage_target_pct"
      expr: AVG(CAST(code_coverage_target_pct AS DOUBLE))
      comment: "Average code coverage target percentage. Benchmarks verification thoroughness standards."
    - name: "avg_toggle_coverage_target_pct"
      expr: AVG(CAST(toggle_coverage_target_pct AS DOUBLE))
      comment: "Average toggle coverage target percentage. Tracks node-level verification completeness standards."
    - name: "avg_assertion_coverage_target_pct"
      expr: AVG(CAST(assertion_coverage_target_pct AS DOUBLE))
      comment: "Average assertion coverage target percentage. Tracks formal verification rigor standards."
    - name: "avg_safety_mechanism_coverage_target_pct"
      expr: AVG(CAST(safety_mechanism_coverage_target_pct AS DOUBLE))
      comment: "Average safety mechanism coverage target percentage. Critical for ISO 26262 / ASIL compliance — directly impacts automotive market access."
    - name: "avg_fault_coverage_target_pct"
      expr: AVG(CAST(fault_coverage_target_pct AS DOUBLE))
      comment: "Average fault coverage target percentage. Drives test quality and field escape risk assessment."
    - name: "on_schedule_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_date <= tapeout_target_date AND signoff_date IS NOT NULL THEN verification_plan_id END) / NULLIF(COUNT(CASE WHEN signoff_date IS NOT NULL THEN verification_plan_id END), 0), 2)
      comment: "Percentage of verification plans signed off before the tapeout target date. Schedule compliance KPI for verification teams."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design change management KPIs — tracks change request volume, cost impact, approval cycle times, and risk distribution. Change management efficiency directly impacts design schedule and NRE cost."
  source: "`vibe_semiconductors_v1`.`design`.`change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change request (design, process, IP, tool) for change category analysis."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change for portfolio-level change management analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (pending, approved, rejected, withdrawn) for pipeline tracking."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request (critical, high, medium, low) for workload prioritization."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (high, medium, low) for risk management analysis."
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current workflow status of the change request for pipeline health monitoring."
    - name: "request_year_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the change request was submitted for trend and volume analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the change has compliance implications — flags regulatory risk."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests. Tracks design change velocity — high volumes may indicate design instability."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN change_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests approved. Tracks change management effectiveness and design governance quality."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost impact of all change requests. Drives NRE budget revision and resource reallocation decisions."
    - name: "total_cost_actual_usd"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of implemented changes. Compared against estimates to assess change cost predictability."
    - name: "cost_estimate_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_actual AS DOUBLE)) / NULLIF(SUM(CAST(cost_estimate AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated change cost. Values above 100% indicate systematic underestimation — drives process improvement."
    - name: "high_risk_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'high' THEN change_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests classified as high risk. Tracks design risk exposure — high rates require executive attention."
    - name: "compliance_impacted_change_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN change_request_id END)
      comment: "Number of change requests with compliance implications. Tracks regulatory risk exposure from design changes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_eda_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDA tool portfolio KPIs — tracks license utilization, cost efficiency, and qualification status across the EDA tool suite. EDA tool management directly impacts design capacity and NRE cost."
  source: "`vibe_semiconductors_v1`.`design`.`eda_tool`"
  dimensions:
    - name: "tool_category"
      expr: tool_category
      comment: "Category of EDA tool (synthesis, simulation, place-and-route, verification) for portfolio analysis."
    - name: "tool_status"
      expr: tool_status
      comment: "Current status of the EDA tool (active, deprecated, evaluation) for portfolio health management."
    - name: "vendor_name"
      expr: vendor_name
      comment: "EDA tool vendor name for vendor spend and dependency analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the tool for process node compatibility tracking."
    - name: "design_flow_stage"
      expr: design_flow_stage
      comment: "Design flow stage the tool supports for coverage gap analysis."
    - name: "license_type"
      expr: license_type
      comment: "License type (floating, node-locked, cloud) for license model optimization."
    - name: "dft_support_flag"
      expr: dft_support_flag
      comment: "Whether the tool supports DFT flows — tracks DFT capability coverage."
    - name: "euv_process_support_flag"
      expr: euv_process_support_flag
      comment: "Whether the tool supports EUV process nodes — critical for advanced node design capability."
  measures:
    - name: "total_annual_license_cost_usd"
      expr: SUM(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Total annual EDA tool license cost. A major NRE overhead — tracked for vendor negotiation and cost optimization."
    - name: "avg_annual_license_cost_usd"
      expr: AVG(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Average annual license cost per EDA tool. Benchmarks tool cost for make-vs-buy and vendor selection decisions."
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(license_utilization_pct AS DOUBLE))
      comment: "Average license utilization percentage across EDA tools. Low utilization indicates over-licensing — drives cost reduction opportunities."
    - name: "qualified_tool_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'qualified' THEN eda_tool_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDA tools that are fully qualified for production use. Unqualified tools create design risk and potential re-work."
    - name: "expiring_license_count"
      expr: COUNT(CASE WHEN license_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND license_expiry_date >= CURRENT_DATE() THEN eda_tool_id END)
      comment: "Number of EDA tool licenses expiring within 90 days. Drives procurement action to prevent design flow disruption."
    - name: "total_tool_count"
      expr: COUNT(1)
      comment: "Total number of EDA tools in the portfolio. Tracks tool portfolio breadth and vendor diversity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`design_ip_core_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core reuse and integration KPIs — tracks reuse rates, integration costs, royalty exposure, and verification completeness across IP core usage instances. IP reuse is a primary design productivity and cost lever."
  source: "`vibe_semiconductors_v1`.`design`.`ip_core_usage`"
  dimensions:
    - name: "integration_status"
      expr: integration_status
      comment: "Current integration status of the IP core instance (in-progress, complete, failed) for pipeline tracking."
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status of the IP integration for quality gate tracking."
    - name: "license_type"
      expr: license_type
      comment: "License type of the IP usage instance for cost model analysis."
    - name: "ip_reuse_flag"
      expr: ip_reuse_flag
      comment: "Whether this is a reuse of an existing IP instance — tracks reuse vs. new integration ratio."
    - name: "is_silicon_proven"
      expr: is_silicon_proven
      comment: "Whether the IP instance is silicon-proven — key risk differentiator."
    - name: "pdk_node"
      expr: pdk_node
      comment: "PDK process node for the IP usage for technology-level analysis."
    - name: "integration_year_month"
      expr: DATE_TRUNC('MONTH', integration_start_date)
      comment: "Month integration started for trend analysis of IP adoption."
    - name: "is_dft_enabled"
      expr: is_dft_enabled
      comment: "Whether DFT is enabled for this IP instance — tracks DFT coverage completeness."
  measures:
    - name: "total_ip_usage_instances"
      expr: COUNT(1)
      comment: "Total number of IP core usage instances. Tracks IP reuse volume and library adoption."
    - name: "ip_reuse_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ip_reuse_flag = TRUE THEN ip_core_usage_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP integrations that are reuses of existing instances. Higher reuse rates reduce NRE cost and integration risk."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost for IP core integrations. Tracks IP integration investment for portfolio cost management."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per IP integration. Benchmarks integration cost for IP selection and make-vs-buy decisions."
    - name: "avg_royalty_rate_per_unit"
      expr: AVG(CAST(royalty_rate_per_unit AS DOUBLE))
      comment: "Average royalty rate per unit across IP usage instances. Drives product margin modeling and pricing decisions."
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage achieved for IP integrations. Tracks verification completeness across IP instances."
    - name: "avg_area_consumed_um2"
      expr: AVG(CAST(area_consumed_um2 AS DOUBLE))
      comment: "Average die area consumed per IP instance in square microns. Drives die area optimization and cost analysis."
    - name: "avg_power_contribution_mw"
      expr: AVG(CAST(power_contribution_mw AS DOUBLE))
      comment: "Average power contribution per IP instance in milliwatts. Tracks IP power budget allocation."
    - name: "silicon_proven_usage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_silicon_proven = TRUE THEN ip_core_usage_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IP usage instances that are silicon-proven. Higher rates reduce first-silicon risk and re-spin probability."
$$;