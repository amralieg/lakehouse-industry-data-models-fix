-- Metric views for domain: design | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_ic_design_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for IC design project portfolio management: NRE spend efficiency, project velocity, design complexity, and tapeout success tracking"
  source: "`semiconductors_ecm`.`design`.`ic_design_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the IC design project (active, on-hold, completed, cancelled)"
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (architecture, RTL, synthesis, physical design, verification, tapeout)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design (ASIC, SoC, IP block, analog/mixed-signal)"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (DUV, EUV, immersion)"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Target packaging technology (flip-chip, wire-bond, 2.5D, 3D-IC)"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification (EAR99, ECCN, ITAR) for compliance tracking"
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the design project was initiated"
    - name: "project_start_quarter"
      expr: CONCAT('Q', QUARTER(project_start_date), '-', YEAR(project_start_date))
      comment: "Quarter and year the design project was initiated"
    - name: "tapeout_target_year"
      expr: YEAR(tapeout_target_date)
      comment: "Target year for tapeout milestone"
    - name: "tapeout_actual_year"
      expr: YEAR(tapeout_actual_date)
      comment: "Actual year tapeout was achieved"
    - name: "dft_enabled_flag"
      expr: dft_enabled
      comment: "Whether design-for-test features are enabled"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulations"
    - name: "iatf_automotive_grade_flag"
      expr: iatf_automotive_grade
      comment: "IATF 16949 automotive grade qualification status"
  measures:
    - name: "total_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Total number of unique IC design projects"
    - name: "total_nre_budget_usd"
      expr: SUM(CAST(nre_budget_usd AS DOUBLE))
      comment: "Total non-recurring engineering budget allocated across all design projects"
    - name: "total_nre_actual_spend_usd"
      expr: SUM(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Total actual NRE spend across all design projects"
    - name: "avg_nre_budget_per_project_usd"
      expr: AVG(CAST(nre_budget_usd AS DOUBLE))
      comment: "Average NRE budget per design project"
    - name: "avg_nre_actual_spend_per_project_usd"
      expr: AVG(CAST(nre_actual_spend_usd AS DOUBLE))
      comment: "Average actual NRE spend per design project"
    - name: "nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of NRE budget consumed (actual spend / budget) - key efficiency metric"
    - name: "avg_target_die_area_mm2"
      expr: AVG(CAST(target_die_area_mm2 AS DOUBLE))
      comment: "Average target die area in square millimeters - design complexity indicator"
    - name: "avg_target_power_budget_mw"
      expr: AVG(CAST(target_power_budget_mw AS DOUBLE))
      comment: "Average target power budget in milliwatts - power efficiency target"
    - name: "avg_target_clock_freq_mhz"
      expr: AVG(CAST(target_clock_freq_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz - performance target"
    - name: "avg_gate_count_target_k"
      expr: AVG(CAST(gate_count_target_k AS DOUBLE))
      comment: "Average target gate count in thousands - design complexity metric"
    - name: "projects_with_tapeout"
      expr: COUNT(DISTINCT CASE WHEN tapeout_actual_date IS NOT NULL THEN ic_design_project_id END)
      comment: "Number of projects that have achieved tapeout"
    - name: "tapeout_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tapeout_actual_date IS NOT NULL THEN ic_design_project_id END) / NULLIF(COUNT(DISTINCT ic_design_project_id), 0), 2)
      comment: "Percentage of projects that achieved tapeout - project success rate"
    - name: "projects_on_schedule"
      expr: COUNT(DISTINCT CASE WHEN tapeout_actual_date <= tapeout_target_date THEN ic_design_project_id END)
      comment: "Number of projects that met or beat tapeout target date"
    - name: "on_time_tapeout_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tapeout_actual_date <= tapeout_target_date THEN ic_design_project_id END) / NULLIF(COUNT(DISTINCT CASE WHEN tapeout_actual_date IS NOT NULL THEN ic_design_project_id END), 0), 2)
      comment: "Percentage of taped-out projects that met schedule - execution quality metric"
    - name: "projects_with_dft"
      expr: COUNT(DISTINCT CASE WHEN dft_enabled = TRUE THEN ic_design_project_id END)
      comment: "Number of projects with design-for-test enabled - testability coverage"
    - name: "dft_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dft_enabled = TRUE THEN ic_design_project_id END) / NULLIF(COUNT(DISTINCT ic_design_project_id), 0), 2)
      comment: "Percentage of projects with DFT enabled - quality practice adoption"
    - name: "rohs_compliant_projects"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN ic_design_project_id END)
      comment: "Number of RoHS-compliant projects - environmental compliance coverage"
    - name: "automotive_grade_projects"
      expr: COUNT(DISTINCT CASE WHEN iatf_automotive_grade = TRUE THEN ic_design_project_id END)
      comment: "Number of IATF automotive-grade projects - automotive market coverage"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive tapeout KPIs: mask cost efficiency, design quality at tapeout, yield expectations, and time-to-market velocity"
  source: "`semiconductors_ecm`.`design`.`tapeout`"
  dimensions:
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Status of tapeout (submitted, in-fab, completed, cancelled)"
    - name: "tapeout_type"
      expr: tapeout_type
      comment: "Type of tapeout (production, MPW, prototype, engineering)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design being taped out (ASIC, SoC, IP, analog)"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (DUV, EUV)"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging technology (flip-chip, wire-bond, 2.5D, 3D)"
    - name: "foundry_name"
      expr: foundry_name
      comment: "Name of foundry partner"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment (mobile, automotive, datacenter, IoT)"
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout"
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(tapeout_date), '-', YEAR(tapeout_date))
      comment: "Quarter and year of tapeout"
    - name: "tapeout_month"
      expr: DATE_TRUNC('MONTH', tapeout_date)
      comment: "Month of tapeout for trend analysis"
    - name: "drc_clean_flag"
      expr: drc_clean
      comment: "Whether design rule check passed cleanly"
    - name: "lvs_clean_flag"
      expr: lvs_clean
      comment: "Whether layout-versus-schematic check passed cleanly"
    - name: "erc_clean_flag"
      expr: erc_clean
      comment: "Whether electrical rule check passed cleanly"
    - name: "ip_sign_off_complete_flag"
      expr: ip_sign_off_complete
      comment: "Whether IP sign-off is complete"
    - name: "signoff_checklist_complete_flag"
      expr: signoff_checklist_complete
      comment: "Whether full sign-off checklist is complete"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance"
  measures:
    - name: "total_tapeouts"
      expr: COUNT(DISTINCT tapeout_id)
      comment: "Total number of tapeouts - volume metric"
    - name: "total_mask_cost_usd"
      expr: SUM(CAST(mask_cost_usd AS DOUBLE))
      comment: "Total mask set cost across all tapeouts"
    - name: "avg_mask_cost_per_tapeout_usd"
      expr: AVG(CAST(mask_cost_usd AS DOUBLE))
      comment: "Average mask cost per tapeout - cost efficiency indicator"
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non-recurring engineering cost for tapeouts"
    - name: "avg_nre_cost_per_tapeout_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters - design complexity metric"
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected yield percentage - quality forecast"
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage - testability quality"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score - manufacturability quality"
    - name: "tapeouts_drc_clean"
      expr: COUNT(DISTINCT CASE WHEN drc_clean = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with clean DRC - design quality metric"
    - name: "drc_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN drc_clean = TRUE THEN tapeout_id END) / NULLIF(COUNT(DISTINCT tapeout_id), 0), 2)
      comment: "Percentage of tapeouts with clean DRC - first-pass quality rate"
    - name: "tapeouts_lvs_clean"
      expr: COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with clean LVS"
    - name: "lvs_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN tapeout_id END) / NULLIF(COUNT(DISTINCT tapeout_id), 0), 2)
      comment: "Percentage of tapeouts with clean LVS - verification quality rate"
    - name: "tapeouts_erc_clean"
      expr: COUNT(DISTINCT CASE WHEN erc_clean = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with clean ERC"
    - name: "erc_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN erc_clean = TRUE THEN tapeout_id END) / NULLIF(COUNT(DISTINCT tapeout_id), 0), 2)
      comment: "Percentage of tapeouts with clean ERC - electrical quality rate"
    - name: "tapeouts_fully_signed_off"
      expr: COUNT(DISTINCT CASE WHEN signoff_checklist_complete = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with complete sign-off checklist"
    - name: "full_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN signoff_checklist_complete = TRUE THEN tapeout_id END) / NULLIF(COUNT(DISTINCT tapeout_id), 0), 2)
      comment: "Percentage of tapeouts with full sign-off - process compliance rate"
    - name: "tapeouts_with_ip_signoff"
      expr: COUNT(DISTINCT CASE WHEN ip_sign_off_complete = TRUE THEN tapeout_id END)
      comment: "Number of tapeouts with IP sign-off complete"
    - name: "mask_cost_per_mm2_usd"
      expr: ROUND(SUM(CAST(mask_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(die_size_mm2 AS DOUBLE)), 0), 2)
      comment: "Mask cost per square millimeter of die area - cost efficiency ratio"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design milestone tracking KPIs: schedule adherence, gate review quality, design convergence velocity, and risk indicators"
  source: "`semiconductors_ecm`.`design`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of milestone (planned, in-progress, completed, delayed, waived)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (gate review, tapeout, signoff, verification)"
    - name: "nre_phase"
      expr: nre_phase
      comment: "NRE phase (architecture, RTL, synthesis, physical, verification, tapeout)"
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Approval outcome (approved, conditional, rejected, waived)"
    - name: "gate_criteria_met_flag"
      expr: gate_criteria_met
      comment: "Whether gate review criteria were met"
    - name: "dfm_sign_off_flag"
      expr: dfm_sign_off
      comment: "Whether design-for-manufacturing sign-off achieved"
    - name: "dft_sign_off_flag"
      expr: dft_sign_off
      comment: "Whether design-for-test sign-off achieved"
    - name: "tapeout_authorized_flag"
      expr: tapeout_authorized
      comment: "Whether tapeout is authorized"
    - name: "ip_clearance_confirmed_flag"
      expr: ip_clearance_confirmed
      comment: "Whether IP clearance is confirmed"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year milestone was planned"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date), '-', YEAR(planned_date))
      comment: "Quarter milestone was planned"
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year milestone was actually achieved"
    - name: "actual_quarter"
      expr: CONCAT('Q', QUARTER(actual_date), '-', YEAR(actual_date))
      comment: "Quarter milestone was actually achieved"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification"
  measures:
    - name: "total_milestones"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Total number of design milestones"
    - name: "milestones_completed"
      expr: COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN milestone_id END)
      comment: "Number of milestones completed"
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones completed - execution velocity"
    - name: "milestones_on_schedule"
      expr: COUNT(DISTINCT CASE WHEN actual_date <= planned_date THEN milestone_id END)
      comment: "Number of milestones completed on or before planned date"
    - name: "on_time_milestone_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_date <= planned_date THEN milestone_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN milestone_id END), 0), 2)
      comment: "Percentage of completed milestones that met schedule - schedule adherence"
    - name: "milestones_gate_criteria_met"
      expr: COUNT(DISTINCT CASE WHEN gate_criteria_met = TRUE THEN milestone_id END)
      comment: "Number of milestones where gate criteria were met"
    - name: "gate_criteria_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gate_criteria_met = TRUE THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones passing gate criteria - quality gate effectiveness"
    - name: "milestones_dfm_signed_off"
      expr: COUNT(DISTINCT CASE WHEN dfm_sign_off = TRUE THEN milestone_id END)
      comment: "Number of milestones with DFM sign-off"
    - name: "dfm_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dfm_sign_off = TRUE THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones with DFM sign-off - manufacturability readiness"
    - name: "milestones_dft_signed_off"
      expr: COUNT(DISTINCT CASE WHEN dft_sign_off = TRUE THEN milestone_id END)
      comment: "Number of milestones with DFT sign-off"
    - name: "dft_signoff_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dft_sign_off = TRUE THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones with DFT sign-off - testability readiness"
    - name: "milestones_tapeout_authorized"
      expr: COUNT(DISTINCT CASE WHEN tapeout_authorized = TRUE THEN milestone_id END)
      comment: "Number of milestones with tapeout authorization"
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area at milestone - design size trend"
    - name: "avg_power_budget_mw"
      expr: AVG(CAST(power_budget_mw AS DOUBLE))
      comment: "Average power budget at milestone - power target trend"
    - name: "avg_timing_slack_worst_ps"
      expr: AVG(CAST(timing_slack_worst_ps AS DOUBLE))
      comment: "Average worst-case timing slack in picoseconds - timing closure health"
    - name: "milestones_with_ip_clearance"
      expr: COUNT(DISTINCT CASE WHEN ip_clearance_confirmed = TRUE THEN milestone_id END)
      comment: "Number of milestones with IP clearance confirmed"
    - name: "ip_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ip_clearance_confirmed = TRUE THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones with IP clearance - legal/compliance readiness"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_physical_layout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical design quality KPIs: timing closure, power efficiency, routing congestion, DRC/LVS quality, and design convergence"
  source: "`semiconductors_ecm`.`design`.`physical_layout`"
  dimensions:
    - name: "layout_status"
      expr: layout_status
      comment: "Status of physical layout (in-progress, converged, signed-off, released)"
    - name: "implementation_stage"
      expr: implementation_stage
      comment: "Implementation stage (floorplan, placement, CTS, routing, optimization)"
    - name: "lvs_clean_flag"
      expr: lvs_clean
      comment: "Whether layout-versus-schematic check is clean"
    - name: "em_compliant_flag"
      expr: em_compliant
      comment: "Whether electromigration rules are compliant"
    - name: "gds_file_format"
      expr: gds_file_format
      comment: "GDS file format version"
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout"
    - name: "tapeout_quarter"
      expr: CONCAT('Q', QUARTER(tapeout_date), '-', YEAR(tapeout_date))
      comment: "Quarter of tapeout"
    - name: "iteration_year"
      expr: YEAR(iteration_timestamp)
      comment: "Year of layout iteration"
    - name: "iteration_month"
      expr: DATE_TRUNC('MONTH', iteration_timestamp)
      comment: "Month of layout iteration"
  measures:
    - name: "total_physical_layouts"
      expr: COUNT(DISTINCT physical_layout_id)
      comment: "Total number of physical layout iterations"
    - name: "avg_die_area_mm2"
      expr: AVG(CAST(die_area_mm2 AS DOUBLE))
      comment: "Average die area in square millimeters"
    - name: "avg_core_area_mm2"
      expr: AVG(CAST(core_area_mm2 AS DOUBLE))
      comment: "Average core area in square millimeters"
    - name: "avg_cell_utilization_pct"
      expr: AVG(CAST(cell_utilization_pct AS DOUBLE))
      comment: "Average cell utilization percentage - area efficiency"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts"
    - name: "avg_leakage_power_uw"
      expr: AVG(CAST(leakage_power_uw AS DOUBLE))
      comment: "Average leakage power in microwatts - static power metric"
    - name: "avg_wns_ps"
      expr: AVG(CAST(wns_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds - timing closure health"
    - name: "avg_tns_ps"
      expr: AVG(CAST(tns_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds - overall timing health"
    - name: "avg_cts_skew_ps"
      expr: AVG(CAST(cts_skew_ps AS DOUBLE))
      comment: "Average clock tree synthesis skew in picoseconds - clock quality"
    - name: "avg_cts_insertion_delay_ps"
      expr: AVG(CAST(cts_insertion_delay_ps AS DOUBLE))
      comment: "Average CTS insertion delay in picoseconds"
    - name: "avg_ir_drop_max_mv"
      expr: AVG(CAST(ir_drop_max_mv AS DOUBLE))
      comment: "Average maximum IR drop in millivolts - power integrity metric"
    - name: "avg_routing_congestion_max_pct"
      expr: AVG(CAST(routing_congestion_max_pct AS DOUBLE))
      comment: "Average maximum routing congestion percentage - routability health"
    - name: "avg_metal_fill_density_pct"
      expr: AVG(CAST(metal_fill_density_pct AS DOUBLE))
      comment: "Average metal fill density percentage - CMP uniformity"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturing score - manufacturability quality"
    - name: "avg_dft_coverage_pct"
      expr: AVG(CAST(dft_coverage_pct AS DOUBLE))
      comment: "Average design-for-test coverage percentage - testability quality"
    - name: "layouts_lvs_clean"
      expr: COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN physical_layout_id END)
      comment: "Number of layouts with clean LVS"
    - name: "lvs_clean_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN lvs_clean = TRUE THEN physical_layout_id END) / NULLIF(COUNT(DISTINCT physical_layout_id), 0), 2)
      comment: "Percentage of layouts with clean LVS - verification quality rate"
    - name: "layouts_em_compliant"
      expr: COUNT(DISTINCT CASE WHEN em_compliant = TRUE THEN physical_layout_id END)
      comment: "Number of layouts compliant with electromigration rules"
    - name: "em_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN em_compliant = TRUE THEN physical_layout_id END) / NULLIF(COUNT(DISTINCT physical_layout_id), 0), 2)
      comment: "Percentage of layouts EM-compliant - reliability quality rate"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_simulation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verification productivity and quality KPIs: coverage metrics, compute efficiency, pass rates, and signoff readiness"
  source: "`semiconductors_ecm`.`design`.`simulation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of simulation run (running, completed, failed, aborted)"
    - name: "run_type"
      expr: run_type
      comment: "Type of simulation (functional, timing, power, formal)"
    - name: "run_subtype"
      expr: run_subtype
      comment: "Subtype of simulation run"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of simulation"
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage when simulation was run"
    - name: "process_corner"
      expr: process_corner
      comment: "Process corner (TT, SS, FF, SF, FS)"
    - name: "tapeout_milestone"
      expr: tapeout_milestone
      comment: "Tapeout milestone context"
    - name: "signoff_approved_flag"
      expr: signoff_approved
      comment: "Whether simulation run is signoff-approved"
    - name: "compute_cluster"
      expr: compute_cluster
      comment: "Compute cluster used for simulation"
    - name: "regression_suite_name"
      expr: regression_suite_name
      comment: "Name of regression test suite"
    - name: "start_year"
      expr: YEAR(start_timestamp)
      comment: "Year simulation started"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_timestamp), '-', YEAR(start_timestamp))
      comment: "Quarter simulation started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month simulation started"
  measures:
    - name: "total_simulation_runs"
      expr: COUNT(DISTINCT simulation_run_id)
      comment: "Total number of simulation runs"
    - name: "total_cpu_hours_consumed"
      expr: SUM(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Total CPU hours consumed across all simulation runs"
    - name: "avg_cpu_hours_per_run"
      expr: AVG(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Average CPU hours per simulation run - compute efficiency"
    - name: "total_run_duration_minutes"
      expr: SUM(CAST(run_duration_minutes AS DOUBLE))
      comment: "Total wall-clock runtime in minutes"
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average wall-clock runtime per simulation - turnaround time"
    - name: "avg_peak_memory_gb"
      expr: AVG(CAST(peak_memory_gb AS DOUBLE))
      comment: "Average peak memory usage in gigabytes - resource footprint"
    - name: "avg_functional_coverage_pct"
      expr: AVG(CAST(functional_coverage_pct AS DOUBLE))
      comment: "Average functional coverage percentage - verification completeness"
    - name: "avg_code_coverage_pct"
      expr: AVG(CAST(code_coverage_pct AS DOUBLE))
      comment: "Average code coverage percentage - design exercised"
    - name: "avg_assertion_coverage_pct"
      expr: AVG(CAST(assertion_coverage_pct AS DOUBLE))
      comment: "Average assertion coverage percentage - property verification"
    - name: "avg_toggle_coverage_pct"
      expr: AVG(CAST(toggle_coverage_pct AS DOUBLE))
      comment: "Average toggle coverage percentage - signal activity"
    - name: "runs_passed"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'pass' THEN simulation_run_id END)
      comment: "Number of simulation runs that passed"
    - name: "simulation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_status = 'pass' THEN simulation_run_id END) / NULLIF(COUNT(DISTINCT simulation_run_id), 0), 2)
      comment: "Percentage of simulation runs that passed - quality health"
    - name: "runs_signoff_approved"
      expr: COUNT(DISTINCT CASE WHEN signoff_approved = TRUE THEN simulation_run_id END)
      comment: "Number of simulation runs approved for signoff"
    - name: "signoff_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN signoff_approved = TRUE THEN simulation_run_id END) / NULLIF(COUNT(DISTINCT simulation_run_id), 0), 2)
      comment: "Percentage of runs approved for signoff - readiness metric"
    - name: "avg_supply_voltage_v"
      expr: AVG(CAST(supply_voltage_v AS DOUBLE))
      comment: "Average supply voltage in volts - operating condition"
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature in Celsius - operating condition"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_eda_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDA tool portfolio management KPIs: license utilization, cost efficiency, qualification coverage, and tool adoption"
  source: "`semiconductors_ecm`.`design`.`eda_tool`"
  dimensions:
    - name: "tool_status"
      expr: tool_status
      comment: "Status of EDA tool (active, deprecated, evaluation, retired)"
    - name: "tool_category"
      expr: tool_category
      comment: "Category of EDA tool (synthesis, P&R, verification, simulation, signoff)"
    - name: "design_flow_stage"
      expr: design_flow_stage
      comment: "Design flow stage where tool is used"
    - name: "license_type"
      expr: license_type
      comment: "Type of license (floating, node-locked, cloud, subscription)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, in-qualification, not-qualified)"
    - name: "compute_platform_type"
      expr: compute_platform_type
      comment: "Compute platform (on-prem, cloud, hybrid)"
    - name: "dft_support_flag"
      expr: dft_support_flag
      comment: "Whether tool supports design-for-test"
    - name: "formal_verification_flag"
      expr: formal_verification_flag
      comment: "Whether tool supports formal verification"
    - name: "euv_process_support_flag"
      expr: euv_process_support_flag
      comment: "Whether tool supports EUV lithography processes"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Whether tool is ITAR-controlled"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification"
    - name: "license_expiry_year"
      expr: YEAR(license_expiry_date)
      comment: "Year license expires"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year tool was qualified"
  measures:
    - name: "total_eda_tools"
      expr: COUNT(DISTINCT eda_tool_id)
      comment: "Total number of EDA tools in portfolio"
    - name: "total_annual_license_cost_usd"
      expr: SUM(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Total annual license cost across all EDA tools"
    - name: "avg_annual_license_cost_per_tool_usd"
      expr: AVG(CAST(annual_license_cost_usd AS DOUBLE))
      comment: "Average annual license cost per tool"
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(license_utilization_pct AS DOUBLE))
      comment: "Average license utilization percentage - license efficiency"
    - name: "tools_qualified"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'qualified' THEN eda_tool_id END)
      comment: "Number of qualified EDA tools"
    - name: "tool_qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qualification_status = 'qualified' THEN eda_tool_id END) / NULLIF(COUNT(DISTINCT eda_tool_id), 0), 2)
      comment: "Percentage of tools that are qualified - readiness metric"
    - name: "tools_with_dft_support"
      expr: COUNT(DISTINCT CASE WHEN dft_support_flag = TRUE THEN eda_tool_id END)
      comment: "Number of tools with DFT support"
    - name: "dft_tool_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dft_support_flag = TRUE THEN eda_tool_id END) / NULLIF(COUNT(DISTINCT eda_tool_id), 0), 2)
      comment: "Percentage of tools with DFT support - capability coverage"
    - name: "tools_with_formal_verification"
      expr: COUNT(DISTINCT CASE WHEN formal_verification_flag = TRUE THEN eda_tool_id END)
      comment: "Number of tools with formal verification capability"
    - name: "formal_verification_tool_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN formal_verification_flag = TRUE THEN eda_tool_id END) / NULLIF(COUNT(DISTINCT eda_tool_id), 0), 2)
      comment: "Percentage of tools with formal verification - advanced capability coverage"
    - name: "tools_with_euv_support"
      expr: COUNT(DISTINCT CASE WHEN euv_process_support_flag = TRUE THEN eda_tool_id END)
      comment: "Number of tools supporting EUV processes"
    - name: "euv_tool_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN euv_process_support_flag = TRUE THEN eda_tool_id END) / NULLIF(COUNT(DISTINCT eda_tool_id), 0), 2)
      comment: "Percentage of tools supporting EUV - advanced node readiness"
    - name: "tools_itar_controlled"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled_flag = TRUE THEN eda_tool_id END)
      comment: "Number of ITAR-controlled tools - compliance tracking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_mpw_shuttle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-project wafer shuttle KPIs: cost efficiency, utilization, schedule adherence, and foundry partnership health"
  source: "`semiconductors_ecm`.`design`.`mpw_shuttle`"
  dimensions:
    - name: "shuttle_status"
      expr: shuttle_status
      comment: "Status of MPW shuttle (planned, open, closed, in-fab, completed)"
    - name: "shuttle_type"
      expr: shuttle_type
      comment: "Type of shuttle (MPW, dedicated, shared)"
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology (DUV, EUV)"
    - name: "cost_sharing_model"
      expr: cost_sharing_model
      comment: "Cost sharing model (equal, area-based, custom)"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant
      comment: "RoHS compliance status"
    - name: "chips_act_eligible_flag"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility flag"
    - name: "dft_requirement_flag"
      expr: dft_requirement_flag
      comment: "Whether DFT is required"
    - name: "ip_nda_required_flag"
      expr: ip_nda_required
      comment: "Whether IP NDA is required"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification"
    - name: "scheduled_tapeout_year"
      expr: YEAR(scheduled_tapeout_date)
      comment: "Year of scheduled tapeout"
    - name: "scheduled_tapeout_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_tapeout_date), '-', YEAR(scheduled_tapeout_date))
      comment: "Quarter of scheduled tapeout"
    - name: "actual_tapeout_year"
      expr: YEAR(actual_tapeout_date)
      comment: "Year of actual tapeout"
  measures:
    - name: "total_mpw_shuttles"
      expr: COUNT(DISTINCT mpw_shuttle_id)
      comment: "Total number of MPW shuttles"
    - name: "total_shuttle_cost_usd"
      expr: SUM(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Total cost of all MPW shuttles"
    - name: "avg_shuttle_cost_usd"
      expr: AVG(CAST(total_shuttle_cost_usd AS DOUBLE))
      comment: "Average cost per MPW shuttle"
    - name: "total_mask_set_cost_usd"
      expr: SUM(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Total mask set cost across all shuttles"
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost per shuttle"
    - name: "avg_cost_per_mm2_usd"
      expr: AVG(CAST(cost_per_mm2_usd AS DOUBLE))
      comment: "Average cost per square millimeter - cost efficiency metric"
    - name: "avg_total_reticle_area_mm2"
      expr: AVG(CAST(total_reticle_area_mm2 AS DOUBLE))
      comment: "Average total reticle area in square millimeters"
    - name: "shuttles_on_schedule"
      expr: COUNT(DISTINCT CASE WHEN actual_tapeout_date <= scheduled_tapeout_date THEN mpw_shuttle_id END)
      comment: "Number of shuttles that taped out on or before schedule"
    - name: "shuttle_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_tapeout_date <= scheduled_tapeout_date THEN mpw_shuttle_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_tapeout_date IS NOT NULL THEN mpw_shuttle_id END), 0), 2)
      comment: "Percentage of shuttles that met tapeout schedule - execution quality"
    - name: "shuttles_rohs_compliant"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN mpw_shuttle_id END)
      comment: "Number of RoHS-compliant shuttles"
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN mpw_shuttle_id END) / NULLIF(COUNT(DISTINCT mpw_shuttle_id), 0), 2)
      comment: "Percentage of shuttles that are RoHS-compliant - environmental compliance"
    - name: "shuttles_chips_act_eligible"
      expr: COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN mpw_shuttle_id END)
      comment: "Number of CHIPS Act eligible shuttles"
    - name: "chips_act_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN chips_act_eligible = TRUE THEN mpw_shuttle_id END) / NULLIF(COUNT(DISTINCT mpw_shuttle_id), 0), 2)
      comment: "Percentage of shuttles eligible for CHIPS Act funding - strategic opportunity"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_timing_analysis_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timing closure KPIs: slack distribution, violation trends, signoff readiness, and timing convergence velocity"
  source: "`semiconductors_ecm`.`design`.`timing_analysis_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of timing analysis run (running, completed, failed)"
    - name: "analysis_mode"
      expr: analysis_mode
      comment: "Analysis mode (setup, hold, multi-corner, OCV)"
    - name: "timing_closure_status"
      expr: timing_closure_status
      comment: "Timing closure status (met, violated, marginal)"
    - name: "design_stage"
      expr: design_stage
      comment: "Design stage when timing analysis was run"
    - name: "pvt_corner"
      expr: pvt_corner
      comment: "Process-voltage-temperature corner (TT, SS, FF, etc.)"
    - name: "is_signoff_run_flag"
      expr: is_signoff_run
      comment: "Whether this is a signoff-quality run"
    - name: "is_multi_corner_run_flag"
      expr: is_multi_corner_run
      comment: "Whether this is a multi-corner analysis"
    - name: "run_year"
      expr: YEAR(run_timestamp)
      comment: "Year timing analysis was run"
    - name: "run_quarter"
      expr: CONCAT('Q', QUARTER(run_timestamp), '-', YEAR(run_timestamp))
      comment: "Quarter timing analysis was run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month timing analysis was run"
  measures:
    - name: "total_timing_analysis_runs"
      expr: COUNT(DISTINCT timing_analysis_run_id)
      comment: "Total number of timing analysis runs"
    - name: "avg_worst_negative_slack_ps"
      expr: AVG(CAST(worst_negative_slack_ps AS DOUBLE))
      comment: "Average worst negative slack in picoseconds - timing health indicator"
    - name: "avg_total_negative_slack_ps"
      expr: AVG(CAST(total_negative_slack_ps AS DOUBLE))
      comment: "Average total negative slack in picoseconds - overall timing debt"
    - name: "avg_worst_hold_slack_ps"
      expr: AVG(CAST(worst_hold_slack_ps AS DOUBLE))
      comment: "Average worst hold slack in picoseconds - hold timing health"
    - name: "avg_total_hold_negative_slack_ps"
      expr: AVG(CAST(total_hold_negative_slack_ps AS DOUBLE))
      comment: "Average total hold negative slack in picoseconds - hold timing debt"
    - name: "avg_clock_frequency_target_mhz"
      expr: AVG(CAST(clock_frequency_target_mhz AS DOUBLE))
      comment: "Average target clock frequency in MHz"
    - name: "avg_clock_period_target_ps"
      expr: AVG(CAST(clock_period_target_ps AS DOUBLE))
      comment: "Average target clock period in picoseconds"
    - name: "avg_supply_voltage_v"
      expr: AVG(CAST(supply_voltage_v AS DOUBLE))
      comment: "Average supply voltage in volts"
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature in Celsius"
    - name: "avg_derating_factor_setup"
      expr: AVG(CAST(derating_factor_setup AS DOUBLE))
      comment: "Average setup derating factor - margin applied"
    - name: "avg_derating_factor_hold"
      expr: AVG(CAST(derating_factor_hold AS DOUBLE))
      comment: "Average hold derating factor - margin applied"
    - name: "runs_timing_closure_met"
      expr: COUNT(DISTINCT CASE WHEN timing_closure_status = 'met' THEN timing_analysis_run_id END)
      comment: "Number of runs where timing closure was met"
    - name: "timing_closure_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN timing_closure_status = 'met' THEN timing_analysis_run_id END) / NULLIF(COUNT(DISTINCT timing_analysis_run_id), 0), 2)
      comment: "Percentage of runs achieving timing closure - convergence health"
    - name: "signoff_runs"
      expr: COUNT(DISTINCT CASE WHEN is_signoff_run = TRUE THEN timing_analysis_run_id END)
      comment: "Number of signoff-quality timing runs"
    - name: "signoff_run_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_signoff_run = TRUE THEN timing_analysis_run_id END) / NULLIF(COUNT(DISTINCT timing_analysis_run_id), 0), 2)
      comment: "Percentage of runs that are signoff-quality - readiness metric"
    - name: "multi_corner_runs"
      expr: COUNT(DISTINCT CASE WHEN is_multi_corner_run = TRUE THEN timing_analysis_run_id END)
      comment: "Number of multi-corner timing runs"
$$;