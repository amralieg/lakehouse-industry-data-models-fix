-- Metric views for domain: engineering | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_vehicle_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vehicle program portfolio management — tracks budget allocation, cost targets, emissions targets, and program health across the engineering portfolio."
  source: "`vibe_automotive_v1`.`engineering`.`vehicle_program`"
  dimensions:
    - name: "program_code"
      expr: program_code
      comment: "Unique program code used to identify and filter individual vehicle programs."
    - name: "program_name"
      expr: program_name
      comment: "Human-readable vehicle program name for reporting and dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program (e.g., new model, facelift, derivative) for portfolio segmentation."
    - name: "vehicle_program_status"
      expr: vehicle_program_status
      comment: "Current lifecycle status of the vehicle program (e.g., active, on-hold, cancelled, completed)."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification (e.g., BEV, PHEV, ICE, HEV) for electrification portfolio analysis."
    - name: "segment"
      expr: segment
      comment: "Market segment (e.g., SUV, sedan, truck) for competitive and portfolio analysis."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Regulatory emission standard the program must comply with (e.g., Euro 6, CAFE)."
    - name: "platform_architecture"
      expr: platform_architecture
      comment: "Underlying vehicle platform architecture enabling cross-program cost and engineering sharing analysis."
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic market the vehicle program is designed for."
    - name: "model_year_start"
      expr: model_year_start
      comment: "First model year of the vehicle program for time-based portfolio analysis."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Current regulatory approval status, critical for launch readiness tracking."
    - name: "digital_twin_enabled"
      expr: digital_twin_enabled
      comment: "Flag indicating whether the program leverages digital twin technology for simulation-driven engineering."
    - name: "ota_update_capability"
      expr: ota_update_capability
      comment: "Flag indicating over-the-air software update capability, a key differentiator in connected vehicle programs."
    - name: "launch_date"
      expr: launch_date
      comment: "Planned vehicle launch date for program timeline and milestone tracking."
    - name: "start_date"
      expr: start_date
      comment: "Program start date for duration and elapsed time calculations."
  measures:
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across vehicle programs. Drives investment prioritization and portfolio funding decisions."
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocation per vehicle program. Benchmarks investment intensity across program types and segments."
    - name: "total_target_cost_per_vehicle"
      expr: SUM(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Sum of target cost-per-vehicle across programs. Used for portfolio-level cost competitiveness assessment."
    - name: "avg_target_cost_per_vehicle"
      expr: AVG(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Average target cost per vehicle across programs. Key profitability and competitiveness KPI for engineering leadership."
    - name: "avg_target_emissions_g_per_km"
      expr: AVG(CAST(target_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions target (g/km) across programs. Tracks fleet-level regulatory compliance trajectory."
    - name: "avg_target_fuel_efficiency_mpg"
      expr: AVG(CAST(target_fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency target (MPG) across programs. Monitors engineering progress toward efficiency mandates."
    - name: "avg_target_weight_kg"
      expr: AVG(CAST(target_weight_kg AS DOUBLE))
      comment: "Average target vehicle weight (kg) across programs. Weight is a primary driver of emissions, efficiency, and performance."
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN vehicle_program_status = 'active' THEN vehicle_program_id END)
      comment: "Count of currently active vehicle programs. Indicates engineering capacity demand and portfolio breadth."
    - name: "digital_twin_enabled_program_count"
      expr: COUNT(DISTINCT CASE WHEN digital_twin_enabled = TRUE THEN vehicle_program_id END)
      comment: "Number of programs leveraging digital twin technology. Tracks digital engineering adoption across the portfolio."
    - name: "ota_capable_program_count"
      expr: COUNT(DISTINCT CASE WHEN ota_update_capability = TRUE THEN vehicle_program_id END)
      comment: "Number of programs with OTA update capability. Measures connected vehicle readiness across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) KPIs — tracks change volume, cost impact, cycle times, and implementation effectiveness. Critical for program cost control and quality governance."
  source: "`vibe_automotive_v1`.`engineering`.`change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g., design, process, supplier) for root-cause and trend analysis."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change order (e.g., open, approved, implemented, rejected) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Change priority level (e.g., critical, high, medium, low) for triage and resource allocation."
    - name: "impact_type"
      expr: impact_type
      comment: "Nature of the change impact (e.g., cost, quality, safety, regulatory) for risk classification."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause reason code for the change. Enables Pareto analysis of change drivers."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation progress status for tracking execution against approved changes."
    - name: "requested_date"
      expr: requested_date
      comment: "Date the change was requested. Used for aging and cycle time analysis."
    - name: "approved_date"
      expr: approved_date
      comment: "Date the change was approved. Used to compute approval cycle time."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the change becomes effective in production. Used for implementation lead time analysis."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial impact of all engineering changes. A primary KPI for program cost control and budget variance management."
    - name: "avg_cost_impact_per_change"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per engineering change order. Benchmarks change complexity and cost exposure per event."
    - name: "total_change_count"
      expr: COUNT(DISTINCT change_id)
      comment: "Total number of distinct engineering change orders. Tracks change velocity and engineering churn rate."
    - name: "open_change_count"
      expr: COUNT(DISTINCT CASE WHEN change_status = 'open' THEN change_id END)
      comment: "Number of open (unresolved) engineering changes. Indicates backlog pressure and risk exposure."
    - name: "critical_priority_change_count"
      expr: COUNT(DISTINCT CASE WHEN priority = 'critical' THEN change_id END)
      comment: "Count of critical-priority engineering changes. Flags urgent issues requiring immediate leadership attention."
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approved_date, requested_date) AS DOUBLE))
      comment: "Average number of days from change request to approval. Measures engineering change governance efficiency."
    - name: "avg_implementation_lead_days"
      expr: AVG(CAST(DATEDIFF(effective_date, approved_date) AS DOUBLE))
      comment: "Average days from change approval to effective implementation. Tracks execution speed of approved changes."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials (BOM) KPIs — tracks BOM cost, weight, component complexity, and revision health across vehicle programs and model years."
  source: "`vibe_automotive_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., released, draft, obsolete) for release readiness tracking."
    - name: "bom_type"
      expr: bom_type
      comment: "BOM classification (e.g., engineering BOM, manufacturing BOM) for process-stage analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the BOM for year-over-year cost and weight trend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code for plant-level BOM cost and complexity benchmarking."
    - name: "revision_level"
      expr: revision_level
      comment: "BOM revision level for tracking engineering maturity and change frequency."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date from which the BOM version is effective. Used for time-series BOM cost and weight analysis."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost across all BOMs. Primary financial KPI for engineering cost management and target-to-actual tracking."
    - name: "avg_standard_cost_per_bom"
      expr: AVG(CAST(standard_cost_amount AS DOUBLE))
      comment: "Average standard cost per BOM version. Benchmarks cost competitiveness across model years and programs."
    - name: "total_bom_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total vehicle weight (kg) summed across BOMs. Tracks fleet-level weight reduction progress against targets."
    - name: "avg_bom_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average BOM weight (kg). Monitors weight engineering performance against program targets."
    - name: "released_bom_count"
      expr: COUNT(DISTINCT CASE WHEN bom_status = 'released' THEN bom_id END)
      comment: "Number of released BOMs. Indicates engineering release cadence and program readiness."
    - name: "total_bom_count"
      expr: COUNT(DISTINCT bom_id)
      comment: "Total number of distinct BOMs. Tracks BOM portfolio size and revision proliferation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line-level KPIs — tracks component weight, cost targets, scrap factors, and critical path coverage at the part level. Drives component-level cost and quality decisions."
  source: "`vibe_automotive_v1`.`engineering`.`engineering_bom_line`"
  dimensions:
    - name: "assembly_level"
      expr: assembly_level
      comment: "Assembly hierarchy level of the BOM line for structural complexity analysis."
    - name: "make_buy_indicator"
      expr: make_buy_indicator
      comment: "Make vs. buy classification for sourcing strategy and cost structure analysis."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the BOM line (e.g., active, obsolete, pending) for release readiness tracking."
    - name: "material_code"
      expr: material_code
      comment: "Material classification code for material cost and sustainability analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity and weight normalization."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the component is on the critical engineering path. Prioritizes risk management focus."
    - name: "supplier_nomination_status"
      expr: supplier_nomination_status
      comment: "Supplier nomination status for the component. Tracks sourcing readiness and supply chain risk."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the BOM line component. Tracks engineering validation completeness."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Effective start date of the BOM line for time-series component analysis."
  measures:
    - name: "total_component_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all BOM line components (kg). Tracks component-level contribution to vehicle weight targets."
    - name: "avg_component_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average component weight (kg) per BOM line. Benchmarks part-level weight engineering performance."
    - name: "total_cost_target_amount"
      expr: SUM(CAST(cost_target_amount AS DOUBLE))
      comment: "Total cost target across all BOM lines. Tracks component-level cost target coverage and engineering cost commitments."
    - name: "avg_scrap_factor_pct"
      expr: AVG(CAST(scrap_factor_pct AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines. High scrap factors inflate manufacturing cost and indicate process inefficiency."
    - name: "critical_path_component_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN engineering_bom_line_id END)
      comment: "Number of BOM line components on the critical engineering path. Quantifies schedule and quality risk concentration."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average quantity per assembly across BOM lines. Informs complexity and standardization opportunities."
    - name: "unvalidated_line_count"
      expr: COUNT(DISTINCT CASE WHEN validation_status != 'validated' THEN engineering_bom_line_id END)
      comment: "Number of BOM lines not yet validated. Tracks engineering validation backlog and launch readiness risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_validation_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation test program KPIs — tracks test coverage, pass rates, regulatory compliance, and requirements traceability. Directly informs launch readiness and regulatory approval decisions."
  source: "`vibe_automotive_v1`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of validation test (e.g., durability, safety, emissions) for test portfolio analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the validation test (e.g., planned, in-progress, complete, failed) for pipeline management."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Overall pass/fail outcome of the validation test. Primary quality gate indicator."
    - name: "test_standard"
      expr: test_standard
      comment: "Industry or regulatory standard the test is conducted against (e.g., ISO, FMVSS) for compliance tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the test is required for regulatory compliance. Prioritizes compliance-critical test tracking."
    - name: "iot_data_collection_flag"
      expr: iot_data_collection_flag
      comment: "Flag indicating IoT-enabled data collection for the test. Tracks digital testing capability adoption."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date for the validation test. Used for schedule adherence and test pipeline planning."
    - name: "completion_date"
      expr: completion_date
      comment: "Actual completion date of the validation test. Used for cycle time and schedule variance analysis."
  measures:
    - name: "total_validation_test_count"
      expr: COUNT(DISTINCT validation_test_id)
      comment: "Total number of distinct validation tests. Tracks test program scope and engineering validation throughput."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_result = 'pass' THEN validation_test_id END) / NULLIF(COUNT(DISTINCT validation_test_id), 0), 2)
      comment: "Percentage of validation tests that passed. Primary quality KPI for launch readiness and regulatory approval decisions."
    - name: "regulatory_compliance_test_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN validation_test_id END)
      comment: "Number of regulatory compliance-required validation tests. Tracks compliance test coverage critical for homologation."
    - name: "avg_requirements_coverage_pct"
      expr: AVG(CAST(requirements_coverage_pct AS DOUBLE))
      comment: "Average requirements traceability coverage percentage across validation tests. Measures completeness of validation against design specifications."
    - name: "failed_test_count"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_result = 'fail' THEN validation_test_id END)
      comment: "Number of failed validation tests. Directly triggers engineering investigation and rework decisions."
    - name: "avg_test_cycle_days"
      expr: AVG(CAST(DATEDIFF(completion_date, actual_start_date) AS DOUBLE))
      comment: "Average number of days from test start to completion. Tracks validation throughput efficiency and schedule risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual test result KPIs — tracks measured vs. target performance, deviation, confidence levels, and retest rates. Drives engineering quality decisions at the component and system level."
  source: "`vibe_automotive_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of test (e.g., structural, thermal, NVH) for test category performance analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the individual test result. Primary quality gate indicator at the result level."
    - name: "test_standard"
      expr: test_standard
      comment: "Standard against which the test was conducted for compliance and benchmarking analysis."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted for capacity and quality benchmarking across test sites."
    - name: "result_unit"
      expr: result_unit
      comment: "Unit of measurement for the test result value for dimensional analysis."
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Flag indicating whether a retest is required. Tracks rework burden and test efficiency."
    - name: "test_date"
      expr: test_date
      comment: "Date the test was conducted for trend and time-series quality analysis."
    - name: "result_date"
      expr: result_date
      comment: "Date the result was recorded. Used for result processing lag analysis."
  measures:
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation of measured values from engineering targets. Quantifies systematic engineering performance gaps."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level across test results. Measures reliability of test data for engineering decisions."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Tracks test efficiency and resource utilization at test facilities."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retest_required_flag = TRUE THEN test_result_id END) / NULLIF(COUNT(DISTINCT test_result_id), 0), 2)
      comment: "Percentage of test results requiring a retest. High retest rates signal systemic quality or process issues driving cost and schedule risk."
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_flag = TRUE AND retest_required_flag = FALSE THEN test_result_id END) / NULLIF(COUNT(DISTINCT test_result_id), 0), 2)
      comment: "Percentage of tests passing on the first attempt without retest. Key engineering quality and efficiency KPI."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test hours consumed across all results. Tracks test facility capacity utilization and program testing investment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_cost_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering cost target KPIs — tracks target vs. actual cost performance and variance across vehicle programs and parts. Directly informs program profitability and cost reduction decisions."
  source: "`vibe_automotive_v1`.`engineering`.`cost_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Status of the cost target (e.g., on-track, at-risk, exceeded) for cost performance management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost target for multi-currency portfolio normalization."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the cost target is effective. Used for time-series cost target trend analysis."
  measures:
    - name: "total_target_amount"
      expr: SUM(CAST(target_amount AS DOUBLE))
      comment: "Total engineering cost target amount. Baseline for cost performance and variance tracking."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual cost incurred against engineering cost targets. Primary cost performance KPI."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual minus target) across all cost targets. Negative variance indicates cost overrun; positive indicates savings."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average cost variance per cost target record. Benchmarks typical cost deviation magnitude for risk assessment."
    - name: "cost_overrun_count"
      expr: COUNT(DISTINCT CASE WHEN variance_amount < 0 THEN cost_target_id END)
      comment: "Number of cost targets in overrun (actual exceeds target). Tracks the breadth of cost performance issues across the program."
    - name: "cost_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN variance_amount >= 0 THEN cost_target_id END) / NULLIF(COUNT(DISTINCT cost_target_id), 0), 2)
      comment: "Percentage of cost targets met or beaten. Executive-level KPI for engineering cost discipline and program financial health."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program milestone KPIs — tracks schedule adherence, milestone completion rates, and gate performance across vehicle programs. Critical for program management and launch readiness."
  source: "`vibe_automotive_v1`.`engineering`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., completed, at-risk, delayed, not-started) for schedule health monitoring."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., design freeze, SOP, prototype) for phase-gate analysis."
    - name: "gate_number"
      expr: gate_number
      comment: "Phase gate number associated with the milestone for stage-gate process tracking."
    - name: "owner_name"
      expr: owner_name
      comment: "Owner responsible for the milestone. Enables accountability and workload analysis."
    - name: "planned_date"
      expr: planned_date
      comment: "Planned completion date for the milestone. Used for schedule variance calculation."
    - name: "actual_date"
      expr: actual_date
      comment: "Actual completion date of the milestone. Used to compute schedule adherence."
  measures:
    - name: "total_milestone_count"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Total number of program milestones. Tracks program complexity and gate coverage."
    - name: "completed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN milestone_status = 'completed' THEN milestone_id END)
      comment: "Number of completed milestones. Tracks program execution progress against the plan."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN milestone_status = 'completed' THEN milestone_id END) / NULLIF(COUNT(DISTINCT milestone_id), 0), 2)
      comment: "Percentage of milestones completed. Primary program health KPI for executive steering reviews."
    - name: "avg_schedule_slip_days"
      expr: AVG(CAST(DATEDIFF(actual_date, planned_date) AS DOUBLE))
      comment: "Average number of days milestones slipped past their planned date. Positive values indicate delays; tracks schedule discipline across programs."
    - name: "delayed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN actual_date > planned_date THEN milestone_id END)
      comment: "Number of milestones completed after their planned date. Quantifies schedule risk and program execution issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_fmea_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FMEA (Failure Mode and Effects Analysis) KPIs — tracks risk exposure, action completion, and failure mode distribution. Drives proactive quality and safety risk management decisions."
  source: "`vibe_automotive_v1`.`engineering`.`fmea_record`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (e.g., design FMEA, process FMEA) for risk analysis segmentation."
    - name: "action_status"
      expr: action_status
      comment: "Status of the recommended corrective action (e.g., open, in-progress, closed) for risk mitigation tracking."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Description of the failure mode for Pareto analysis of top engineering risks."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the failure mode (typically 1-10 scale). Used to prioritize high-severity risk items."
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence likelihood rating of the failure mode. Combined with severity and detection for RPN calculation."
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection difficulty rating for the failure mode. Low detection scores indicate high risk of field escape."
    - name: "rpn"
      expr: rpn
      comment: "Risk Priority Number (RPN = Severity × Occurrence × Detection). Primary FMEA risk ranking metric."
  measures:
    - name: "total_fmea_record_count"
      expr: COUNT(DISTINCT fmea_record_id)
      comment: "Total number of FMEA records. Tracks risk identification coverage across programs and parts."
    - name: "open_action_count"
      expr: COUNT(DISTINCT CASE WHEN action_status = 'open' THEN fmea_record_id END)
      comment: "Number of FMEA records with open corrective actions. Quantifies unmitigated risk exposure requiring engineering intervention."
    - name: "action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN action_status = 'closed' THEN fmea_record_id END) / NULLIF(COUNT(DISTINCT fmea_record_id), 0), 2)
      comment: "Percentage of FMEA corrective actions closed. Tracks risk mitigation effectiveness and engineering quality discipline."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_design_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design specification KPIs — tracks specification coverage, traceability, and lifecycle health. Ensures engineering requirements are fully captured and traceable to regulatory and program needs."
  source: "`vibe_automotive_v1`.`engineering`.`design_specification`"
  dimensions:
    - name: "spec_status"
      expr: spec_status
      comment: "Current status of the design specification (e.g., draft, approved, obsolete) for release readiness tracking."
    - name: "spec_type"
      expr: spec_type
      comment: "Type of specification (e.g., system, subsystem, component) for requirements hierarchy analysis."
    - name: "revision_level"
      expr: revision_level
      comment: "Revision level of the specification for change frequency and maturity analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the specification became effective. Used for time-series specification coverage analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the specification. Used to identify specifications requiring renewal or update."
  measures:
    - name: "avg_requirements_traceability_coverage_pct"
      expr: AVG(CAST(requirements_traceability_coverage_pct AS DOUBLE))
      comment: "Average requirements traceability coverage percentage across design specifications. Low coverage indicates gaps between design intent and validation — a key regulatory and quality risk."
    - name: "approved_spec_count"
      expr: COUNT(DISTINCT CASE WHEN spec_status = 'approved' THEN design_specification_id END)
      comment: "Number of approved design specifications. Tracks engineering release readiness and specification governance health."
    - name: "total_spec_count"
      expr: COUNT(DISTINCT design_specification_id)
      comment: "Total number of design specifications. Tracks requirements portfolio size and engineering documentation coverage."
    - name: "spec_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN spec_status = 'approved' THEN design_specification_id END) / NULLIF(COUNT(DISTINCT design_specification_id), 0), 2)
      comment: "Percentage of design specifications in approved status. Measures engineering documentation maturity and program readiness."
$$;