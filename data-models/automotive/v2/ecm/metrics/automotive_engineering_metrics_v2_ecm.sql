-- Metric views for domain: engineering | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_vehicle_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vehicle program portfolio management: budget performance, cost efficiency, program health, and engineering change velocity. Used by VP Engineering and Chief Program Officers to steer R&D investment and program execution."
  source: "`vibe_automotive_v1`.`engineering`.`vehicle_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of vehicle program (e.g., new model, facelift, derivative) for portfolio segmentation."
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle class (e.g., SUV, sedan, truck) for segment-level analysis."
    - name: "segment"
      expr: segment
      comment: "Market segment (e.g., premium, mass-market) for strategic portfolio analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain technology (BEV, PHEV, ICE, HEV) for electrification portfolio tracking."
    - name: "vehicle_program_status"
      expr: vehicle_program_status
      comment: "Current program lifecycle status (active, on-hold, cancelled, completed)."
    - name: "target_market"
      expr: target_market
      comment: "Target sales market/region for the program, enabling regional portfolio analysis."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for homologation tracking."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year of planned vehicle launch for pipeline timing analysis."
    - name: "model_year_start"
      expr: model_year_start
      comment: "Starting model year of the program for temporal portfolio grouping."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of vehicle programs in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total R&D budget allocated across all vehicle programs. Critical for CFO and VP Engineering investment oversight."
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average R&D budget per vehicle program. Benchmarks investment intensity per program."
    - name: "total_target_cost_per_vehicle"
      expr: SUM(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Sum of target cost-per-vehicle across programs. Used to assess cost competitiveness of the portfolio."
    - name: "avg_target_cost_per_vehicle"
      expr: AVG(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Average target cost per vehicle across programs. Key profitability planning metric."
    - name: "total_target_emissions_g_per_km"
      expr: AVG(CAST(target_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 target (g/km) across programs. Tracks fleet-level emissions compliance trajectory."
    - name: "avg_target_fuel_efficiency_mpg"
      expr: AVG(CAST(target_fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency target (MPG) across programs. Regulatory and ESG compliance indicator."
    - name: "programs_with_ota_capability"
      expr: COUNT(CASE WHEN ota_update_capability = TRUE THEN 1 END)
      comment: "Number of programs with OTA software update capability. Tracks software-defined vehicle readiness."
    - name: "programs_with_digital_twin"
      expr: COUNT(CASE WHEN digital_twin_enabled = TRUE THEN 1 END)
      comment: "Number of programs with digital twin enabled. Measures Industry 4.0 / simulation maturity."
    - name: "avg_target_weight_kg"
      expr: AVG(CAST(target_weight_kg AS DOUBLE))
      comment: "Average vehicle weight target (kg) across programs. Tracks lightweighting strategy execution."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project execution KPIs for engineering R&D projects: budget adherence, schedule performance, and completion rates. Used by Program Managers and VP Engineering to govern project delivery."
  source: "`vibe_automotive_v1`.`engineering`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of engineering project (e.g., design, validation, prototype) for portfolio segmentation."
    - name: "project_status"
      expr: project_status
      comment: "Current project status (active, completed, on-hold, cancelled) for pipeline health monitoring."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project was planned to start, for cohort and vintage analysis."
    - name: "planned_end_year"
      expr: YEAR(planned_end_date)
      comment: "Year the project was planned to complete, for delivery pipeline analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of engineering projects. Baseline for portfolio size and workload assessment."
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all engineering projects. Key R&D investment metric."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred across engineering projects. Compared to budget for cost control."
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_pct AS DOUBLE))
      comment: "Average project completion percentage. Tracks overall engineering delivery progress."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per engineering project. Benchmarks investment intensity."
    - name: "projects_over_budget"
      expr: COUNT(CASE WHEN actual_cost_amount > budget_amount THEN 1 END)
      comment: "Number of projects where actual cost exceeds budget. Critical risk indicator for CFO and program governance."
    - name: "total_budget_variance"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total budget overrun (positive) or underspend (negative) across all projects. Aggregate financial risk measure."
    - name: "completed_projects"
      expr: COUNT(CASE WHEN project_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed engineering projects. Tracks delivery throughput."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Management KPIs: change velocity, cost impact, and approval cycle performance. Used by Chief Engineers and Program Managers to control engineering change risk and cost."
  source: "`vibe_automotive_v1`.`engineering`.`change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g., design, process, material) for root-cause categorization."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change (open, approved, rejected, implemented) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Change priority (critical, high, medium, low) for triage and escalation analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause reason code for the change. Enables Pareto analysis of change drivers."
    - name: "requested_year"
      expr: YEAR(requested_date)
      comment: "Year the change was requested, for trend analysis of change volume over time."
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the change was approved, for approval cycle time trending."
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total number of engineering changes. Baseline for change velocity and complexity tracking."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of all engineering changes. Critical for program budget governance."
    - name: "avg_cost_impact_per_change"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per engineering change. Benchmarks change cost intensity."
    - name: "high_priority_changes"
      expr: COUNT(CASE WHEN priority = 'HIGH' OR priority = 'CRITICAL' THEN 1 END)
      comment: "Number of high or critical priority changes. Escalation and risk management KPI."
    - name: "approved_changes"
      expr: COUNT(CASE WHEN change_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved engineering changes. Tracks change throughput and governance effectiveness."
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approved_date, requested_date))
      comment: "Average days from change request to approval. Key cycle time KPI for engineering agility."
    - name: "avg_implementation_cycle_days"
      expr: AVG(DATEDIFF(implementation_date, approved_date))
      comment: "Average days from change approval to implementation. Measures execution speed post-approval."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_validation_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation and testing KPIs: test pass rates, regulatory compliance coverage, and DVP execution performance. Used by Chief Engineers and Quality Directors to ensure product readiness and homologation compliance."
  source: "`vibe_automotive_v1`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of validation test (e.g., durability, emissions, safety, NVH) for coverage analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current test status (planned, in-progress, completed, failed) for pipeline tracking."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Test pass/fail outcome for quality gate analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the test is linked to a regulatory compliance requirement. Enables compliance coverage analysis."
    - name: "test_standard"
      expr: test_standard
      comment: "Applicable test standard (e.g., ISO, SAE, ECE) for standards coverage analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the test was planned to start, for DVP schedule analysis."
    - name: "iot_data_collection_flag"
      expr: iot_data_collection_flag
      comment: "Whether IoT sensor data was collected during the test. Tracks digital test maturity."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of validation tests. Baseline for DVP coverage and test throughput."
    - name: "tests_passed"
      expr: COUNT(CASE WHEN pass_fail_result = 'PASS' THEN 1 END)
      comment: "Number of tests that passed. Core quality gate metric."
    - name: "tests_failed"
      expr: COUNT(CASE WHEN pass_fail_result = 'FAIL' THEN 1 END)
      comment: "Number of tests that failed. Drives engineering rework and risk escalation."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of validation tests that passed. Primary product readiness KPI for program gates."
    - name: "regulatory_tests_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of tests linked to regulatory compliance requirements. Tracks homologation readiness."
    - name: "avg_requirements_coverage_pct"
      expr: AVG(CAST(requirements_coverage_pct AS DOUBLE))
      comment: "Average requirements traceability coverage across validation tests. Measures completeness of test-to-requirement mapping."
    - name: "avg_test_duration_days"
      expr: AVG(DATEDIFF(completion_date, actual_start_date))
      comment: "Average duration of validation tests in days. Tracks test cycle time for DVP schedule management."
    - name: "tests_with_iot_data"
      expr: COUNT(CASE WHEN iot_data_collection_flag = TRUE THEN 1 END)
      comment: "Number of tests with IoT sensor data collection. Tracks digital/connected test capability adoption."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular test result KPIs: measurement accuracy, deviation from targets, and retest rates. Used by Test Engineers and Quality Directors to assess product performance against specifications."
  source: "`vibe_automotive_v1`.`engineering`.`engineering_test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of test (e.g., CFD, FEA, NVH, emissions) for result categorization."
    - name: "test_status"
      expr: test_status
      comment: "Status of the test result (pending review, approved, rejected)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the individual test result."
    - name: "pass_flag"
      expr: pass_flag
      comment: "Boolean pass indicator for the test result. Used for quick filtering."
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Whether a retest is required. Drives rework and schedule impact analysis."
    - name: "test_standard"
      expr: test_standard
      comment: "Test standard applied (ISO, SAE, ECE, etc.) for compliance coverage analysis."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted. Enables facility performance benchmarking."
    - name: "result_date_month"
      expr: DATE_TRUNC('MONTH', result_date)
      comment: "Month of test result for trend analysis of test throughput and quality."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results recorded. Baseline for test throughput tracking."
    - name: "results_passed"
      expr: COUNT(CASE WHEN pass_flag = TRUE THEN 1 END)
      comment: "Number of test results that passed. Core quality metric."
    - name: "result_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results that passed. Primary first-pass yield KPI for engineering quality."
    - name: "retests_required"
      expr: COUNT(CASE WHEN retest_required_flag = TRUE THEN 1 END)
      comment: "Number of test results requiring a retest. Drives rework cost and schedule risk."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results requiring retest. High retest rate signals systemic design or process issues."
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation of measured values from target specification. Measures design-to-spec accuracy."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of test results. Tracks test rigor and measurement reliability."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Used for test bench capacity planning and cycle time optimization."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test results. Baseline for performance benchmarking against target."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_cae_simulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAE/CFD/FEA/NVH simulation KPIs: simulation throughput, pass rates, and computational efficiency. Used by Simulation Directors and VP Engineering to manage virtual validation capacity and quality."
  source: "`vibe_automotive_v1`.`engineering`.`cae_simulation`"
  dimensions:
    - name: "simulation_type"
      expr: simulation_type
      comment: "Type of simulation (CFD, FEA, NVH, crash, thermal) for coverage and capacity analysis."
    - name: "simulation_status"
      expr: simulation_status
      comment: "Current simulation status (queued, running, completed, failed) for pipeline management."
    - name: "solver_software"
      expr: solver_software
      comment: "Solver software used (e.g., ANSYS, Abaqus, OpenFOAM) for tool utilization analysis."
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Boolean pass/fail outcome of the simulation. Core quality gate dimension."
    - name: "submitted_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year the simulation was submitted, for trend analysis of simulation volume."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the simulation was submitted, for capacity planning and throughput trending."
  measures:
    - name: "total_simulations"
      expr: COUNT(1)
      comment: "Total number of CAE simulations run. Baseline for virtual validation throughput."
    - name: "simulations_passed"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of simulations that passed acceptance criteria. Tracks virtual validation quality."
    - name: "simulation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulations passing acceptance criteria. Key virtual validation quality KPI."
    - name: "total_run_duration_hours"
      expr: SUM(CAST(run_duration_hours AS DOUBLE))
      comment: "Total compute hours consumed by simulations. Critical for HPC infrastructure cost management."
    - name: "avg_run_duration_hours"
      expr: AVG(CAST(run_duration_hours AS DOUBLE))
      comment: "Average simulation run duration in hours. Benchmarks computational efficiency and solver performance."
    - name: "unique_programs_simulated"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of distinct vehicle programs with simulation activity. Tracks virtual validation coverage across portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_fmea_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FMEA risk management KPIs: risk priority numbers, severity distribution, and action closure rates. Used by Chief Engineers and Quality Directors to manage design risk and ensure safety compliance."
  source: "`vibe_automotive_v1`.`engineering`.`fmea_record`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (DFMEA, PFMEA, SFMEA) for risk categorization."
    - name: "action_status"
      expr: action_status
      comment: "Status of recommended corrective actions (open, in-progress, closed). Tracks risk mitigation progress."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the failure mode (1-10 scale). Enables Pareto analysis of high-severity risks."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Description of the failure mode for root-cause categorization."
  measures:
    - name: "total_fmea_records"
      expr: COUNT(1)
      comment: "Total number of FMEA failure mode records. Baseline for design risk inventory."
    - name: "open_actions"
      expr: COUNT(CASE WHEN action_status = 'OPEN' THEN 1 END)
      comment: "Number of FMEA records with open corrective actions. Critical risk exposure indicator."
    - name: "action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'CLOSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FMEA actions closed. Measures risk mitigation effectiveness and program readiness."
    - name: "unique_programs_with_fmea"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of vehicle programs with FMEA coverage. Tracks risk management completeness across portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_cost_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering cost target KPIs: target vs. actual cost performance, variance analysis, and cost achievement rates. Used by CFO, VP Engineering, and Program Managers to govern cost competitiveness."
  source: "`vibe_automotive_v1`.`engineering`.`cost_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Status of the cost target (on-track, at-risk, exceeded, achieved) for portfolio cost health."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost target for multi-currency portfolio analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the cost target became effective, for temporal cost trend analysis."
  measures:
    - name: "total_target_amount"
      expr: SUM(CAST(target_amount AS DOUBLE))
      comment: "Total cost target amount across all engineering cost targets. Baseline for cost competitiveness planning."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual cost incurred against cost targets. Compared to target for cost performance assessment."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual minus target). Positive = overrun, negative = savings. Key CFO metric."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average cost variance per cost target record. Benchmarks cost discipline at part/program level."
    - name: "cost_targets_achieved"
      expr: COUNT(CASE WHEN target_status = 'ACHIEVED' THEN 1 END)
      comment: "Number of cost targets achieved. Tracks cost engineering success rate."
    - name: "cost_target_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN target_status = 'ACHIEVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost targets achieved. Primary cost engineering performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_prototype_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype build execution KPIs: build throughput, schedule adherence, and phase completion. Used by Program Managers and Chief Engineers to track physical validation readiness."
  source: "`vibe_automotive_v1`.`engineering`.`prototype_build`"
  dimensions:
    - name: "build_phase"
      expr: build_phase
      comment: "Development phase of the prototype build (e.g., P1, P2, SOP) for program gate tracking."
    - name: "build_status"
      expr: build_status
      comment: "Current build status (planned, in-progress, completed, cancelled) for pipeline management."
    - name: "build_location"
      expr: build_location
      comment: "Location where the prototype was built. Enables facility utilization analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the prototype build was planned to start, for program timeline analysis."
  measures:
    - name: "total_prototype_builds"
      expr: COUNT(1)
      comment: "Total number of prototype builds. Baseline for physical validation throughput."
    - name: "completed_builds"
      expr: COUNT(CASE WHEN build_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed prototype builds. Tracks physical validation delivery."
    - name: "build_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN build_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prototype builds completed. Key program readiness KPI."
    - name: "avg_build_duration_days"
      expr: AVG(DATEDIFF(completion_date, actual_start_date))
      comment: "Average prototype build duration in days. Tracks build cycle time for schedule planning."
    - name: "builds_delayed"
      expr: COUNT(CASE WHEN actual_start_date > planned_start_date THEN 1 END)
      comment: "Number of prototype builds that started later than planned. Schedule risk indicator."
    - name: "unique_programs_with_builds"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of vehicle programs with active prototype builds. Tracks physical validation portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_adas_feature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADAS/autonomous driving feature development KPIs: simulation pass rates, field test coverage, and regulatory approval status. Used by ADAS Directors and VP Engineering to govern autonomous driving program readiness."
  source: "`vibe_automotive_v1`.`engineering`.`engineering_adas_feature`"
  dimensions:
    - name: "sae_level"
      expr: sae_level
      comment: "SAE autonomy level (L1-L5) of the ADAS feature. Tracks autonomous driving portfolio maturity."
    - name: "development_status"
      expr: development_status
      comment: "Current development status of the ADAS feature (concept, development, validation, released)."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the ADAS feature. Critical for market launch readiness."
    - name: "functional_safety_status"
      expr: functional_safety_status
      comment: "ISO 26262 functional safety status. Tracks safety compliance for ADAS features."
    - name: "compute_platform"
      expr: compute_platform
      comment: "Compute platform used for the ADAS feature (e.g., NVIDIA DRIVE, Mobileye). Tracks hardware dependency."
    - name: "lidar_required_flag"
      expr: lidar_required_flag
      comment: "Whether LiDAR is required for the feature. Tracks sensor suite cost and complexity."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the ADAS feature (not started, in-progress, validated, failed)."
  measures:
    - name: "total_adas_features"
      expr: COUNT(1)
      comment: "Total number of ADAS features in development. Baseline for autonomous driving portfolio size."
    - name: "features_regulatory_approved"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of ADAS features with regulatory approval. Critical for market launch readiness."
    - name: "regulatory_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADAS features with regulatory approval. Key homologation readiness KPI."
    - name: "total_field_test_miles"
      expr: SUM(CAST(field_test_miles AS DOUBLE))
      comment: "Total field test miles accumulated across all ADAS features. Tracks real-world validation coverage."
    - name: "avg_field_test_miles"
      expr: AVG(CAST(field_test_miles AS DOUBLE))
      comment: "Average field test miles per ADAS feature. Benchmarks validation thoroughness."
    - name: "avg_simulation_pass_rate_pct"
      expr: AVG(CAST(simulation_pass_rate_pct AS DOUBLE))
      comment: "Average simulation pass rate across ADAS features. Tracks virtual validation quality for autonomous systems."
    - name: "features_with_lidar"
      expr: COUNT(CASE WHEN lidar_required_flag = TRUE THEN 1 END)
      comment: "Number of ADAS features requiring LiDAR. Tracks sensor cost exposure in the ADAS portfolio."
    - name: "unique_programs_with_adas"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of vehicle programs with ADAS feature development. Tracks autonomous driving portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering BOM KPIs: BOM completeness, cost performance, and weight targets. Used by Chief Engineers and Program Managers to govern product structure integrity and cost competitiveness."
  source: "`vibe_automotive_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (engineering, manufacturing, service) for structural analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "Current BOM status (draft, released, obsolete) for lifecycle management."
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the BOM for temporal portfolio analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code associated with the BOM for plant-level analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the BOM became effective, for version timeline analysis."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of engineering BOMs. Baseline for product structure complexity."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost across all BOMs. Key cost competitiveness metric for program management."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost_amount AS DOUBLE))
      comment: "Average standard cost per BOM. Benchmarks cost intensity across programs."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight across all BOMs. Tracks lightweighting progress at portfolio level."
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average BOM weight in kg. Benchmarks lightweighting performance across programs."
    - name: "released_boms"
      expr: COUNT(CASE WHEN bom_status = 'RELEASED' THEN 1 END)
      comment: "Number of released BOMs. Tracks product structure maturity and release readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_weight_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle weight management KPIs: weight target achievement, variance tracking, and compliance status. Used by Chief Engineers and Program Managers to govern lightweighting strategy and regulatory compliance."
  source: "`vibe_automotive_v1`.`engineering`.`weight_report`"
  dimensions:
    - name: "weight_category"
      expr: weight_category
      comment: "Weight category (e.g., body-in-white, powertrain, chassis) for subsystem weight analysis."
    - name: "report_status"
      expr: report_status
      comment: "Status of the weight report (draft, approved, superseded) for data quality filtering."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the weight is within compliance limits. Critical for regulatory and homologation tracking."
    - name: "report_year"
      expr: YEAR(report_date)
      comment: "Year of the weight report for trend analysis of weight performance over program lifecycle."
  measures:
    - name: "total_weight_reports"
      expr: COUNT(1)
      comment: "Total number of weight reports. Baseline for weight management activity."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight across all weight reports. Tracks cumulative weight performance."
    - name: "total_target_weight_kg"
      expr: SUM(CAST(target_weight_kg AS DOUBLE))
      comment: "Total target weight across all weight reports. Baseline for lightweighting target tracking."
    - name: "total_variance_kg"
      expr: SUM(CAST(variance_kg AS DOUBLE))
      comment: "Total weight variance (actual minus target) in kg. Positive = overweight, negative = underweight. Key lightweighting KPI."
    - name: "avg_variance_kg"
      expr: AVG(CAST(variance_kg AS DOUBLE))
      comment: "Average weight variance per report. Benchmarks lightweighting discipline at subsystem level."
    - name: "compliant_reports"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of weight reports within compliance limits. Tracks regulatory weight compliance."
    - name: "weight_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of weight reports within compliance limits. Primary weight compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_ota_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA software release KPIs: release throughput, regulatory compliance, and package size trends. Used by Software Directors and VP Engineering to govern software-defined vehicle update cadence and compliance."
  source: "`vibe_automotive_v1`.`engineering`.`ota_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of OTA release (feature, security patch, calibration, recall) for release categorization."
    - name: "release_status"
      expr: release_status
      comment: "Current release status (draft, approved, deployed, rolled-back) for pipeline management."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the OTA release meets regulatory compliance requirements. Critical for market deployment approval."
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year of the OTA release for trend analysis of software update cadence."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of the OTA release for cadence and throughput trending."
  measures:
    - name: "total_ota_releases"
      expr: COUNT(1)
      comment: "Total number of OTA releases. Baseline for software update cadence tracking."
    - name: "compliant_releases"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of OTA releases meeting regulatory compliance. Critical for market deployment governance."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA releases that are regulatory compliant. Key software governance KPI."
    - name: "total_package_size_mb"
      expr: SUM(CAST(package_size_mb AS DOUBLE))
      comment: "Total OTA package size in MB across all releases. Tracks bandwidth and infrastructure requirements."
    - name: "avg_package_size_mb"
      expr: AVG(CAST(package_size_mb AS DOUBLE))
      comment: "Average OTA package size in MB. Benchmarks software update efficiency and network impact."
    - name: "deployed_releases"
      expr: COUNT(CASE WHEN release_status = 'DEPLOYED' THEN 1 END)
      comment: "Number of OTA releases successfully deployed. Tracks software delivery throughput."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_ml_model_metadata`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI/ML model portfolio KPIs: model accuracy, deployment status, and inference performance. Used by AI/ML Directors and VP Engineering to govern predictive quality and autonomous driving model readiness."
  source: "`vibe_automotive_v1`.`engineering`.`ml_model_metadata`"
  dimensions:
    - name: "model_type"
      expr: model_type
      comment: "Type of ML model (classification, regression, computer vision, NLP) for portfolio categorization."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current deployment status (development, staging, production, retired) for lifecycle management."
    - name: "deployment_target"
      expr: deployment_target
      comment: "Target deployment environment (vehicle ECU, cloud, edge, test bench) for architecture analysis."
    - name: "framework"
      expr: framework
      comment: "ML framework used (TensorFlow, PyTorch, ONNX) for technology stack analysis."
    - name: "use_case"
      expr: use_case
      comment: "Business use case of the ML model (predictive quality, ADAS, anomaly detection) for value tracking."
  measures:
    - name: "total_ml_models"
      expr: COUNT(1)
      comment: "Total number of ML models in the engineering portfolio. Baseline for AI/ML capability inventory."
    - name: "models_in_production"
      expr: COUNT(CASE WHEN deployment_status = 'PRODUCTION' THEN 1 END)
      comment: "Number of ML models deployed to production. Tracks AI/ML value realization."
    - name: "production_deployment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deployment_status = 'PRODUCTION' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ML models deployed to production. Measures AI/ML operationalization effectiveness."
    - name: "avg_model_accuracy"
      expr: AVG(CAST(accuracy_metric AS DOUBLE))
      comment: "Average model accuracy metric across all ML models. Primary AI/ML quality KPI."
    - name: "avg_inference_latency_ms"
      expr: AVG(CAST(inference_latency_ms AS DOUBLE))
      comment: "Average inference latency in milliseconds. Critical for real-time ADAS and vehicle control applications."
    - name: "unique_programs_with_ml"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of vehicle programs with ML model development. Tracks AI/ML adoption across portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_test_bench`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test bench asset KPIs: utilization capacity, calibration compliance, and capability coverage. Used by Test Lab Directors and VP Engineering to optimize physical test infrastructure investment."
  source: "`vibe_automotive_v1`.`engineering`.`test_bench`"
  dimensions:
    - name: "bench_type"
      expr: bench_type
      comment: "Type of test bench (powertrain, NVH, emissions, durability, HIL) for capability analysis."
    - name: "bench_status"
      expr: bench_status
      comment: "Current operational status of the test bench (available, in-use, maintenance, decommissioned)."
    - name: "facility_location"
      expr: facility_location
      comment: "Physical location of the test bench for facility capacity planning."
    - name: "adas_validation_capable"
      expr: adas_validation_capable
      comment: "Whether the bench supports ADAS validation. Tracks advanced testing capability coverage."
    - name: "emissions_measurement_capable"
      expr: emissions_measurement_capable
      comment: "Whether the bench supports emissions measurement. Tracks regulatory testing capability."
    - name: "hil_capable"
      expr: hil_capable
      comment: "Whether the bench supports Hardware-in-the-Loop testing. Tracks software integration test capability."
  measures:
    - name: "total_test_benches"
      expr: COUNT(1)
      comment: "Total number of test benches in the engineering infrastructure. Baseline for capacity planning."
    - name: "total_annual_capacity_hours"
      expr: SUM(CAST(annual_capacity_hours AS DOUBLE))
      comment: "Total annual test bench capacity in hours. Key infrastructure investment metric."
    - name: "avg_utilization_target_pct"
      expr: AVG(CAST(utilization_target_pct AS DOUBLE))
      comment: "Average utilization target percentage across test benches. Benchmarks capacity planning efficiency."
    - name: "total_hourly_rate_cost"
      expr: SUM(CAST(hourly_rate AS DOUBLE))
      comment: "Total hourly rate cost across all test benches. Tracks test infrastructure cost exposure."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate per test bench. Benchmarks test cost efficiency."
    - name: "adas_capable_benches"
      expr: COUNT(CASE WHEN adas_validation_capable = TRUE THEN 1 END)
      comment: "Number of test benches capable of ADAS validation. Tracks advanced testing infrastructure readiness."
    - name: "emissions_capable_benches"
      expr: COUNT(CASE WHEN emissions_measurement_capable = TRUE THEN 1 END)
      comment: "Number of test benches capable of emissions measurement. Tracks regulatory testing capacity."
    - name: "benches_overdue_calibration"
      expr: COUNT(CASE WHEN next_calibration_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of test benches with overdue calibration. Critical compliance and data integrity risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_homologation_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Homologation and regulatory compliance KPIs: requirement coverage, compliance status, and market readiness. Used by Regulatory Affairs Directors and VP Engineering to govern type approval and market launch readiness."
  source: "`vibe_automotive_v1`.`engineering`.`homologation_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the homologation requirement (compliant, non-compliant, in-progress, waived)."
    - name: "market_region"
      expr: market_region
      comment: "Target market region (EU, US, China, etc.) for regional homologation coverage analysis."
    - name: "test_method"
      expr: test_method
      comment: "Test method used for homologation (e.g., WLTP, FTP-75, NCAP) for methodology coverage."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the homologation requirement became effective, for regulatory timeline analysis."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total number of homologation requirements. Baseline for regulatory compliance scope."
    - name: "compliant_requirements"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of homologation requirements in compliant status. Tracks type approval readiness."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of homologation requirements in compliant status. Primary market launch readiness KPI."
    - name: "non_compliant_requirements"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of non-compliant homologation requirements. Critical risk indicator blocking market launch."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value across requirements. Benchmarks regulatory stringency."
    - name: "unique_markets_covered"
      expr: COUNT(DISTINCT market_region)
      comment: "Number of distinct market regions with homologation requirements. Tracks global market coverage."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_powertrain_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain specification KPIs: electrification coverage, CO2 target performance, and power/efficiency benchmarks. Used by Powertrain Directors and VP Engineering to govern electrification strategy and emissions compliance."
  source: "`vibe_automotive_v1`.`engineering`.`powertrain_spec`"
  dimensions:
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain technology type (BEV, PHEV, HEV, ICE, FCEV) for electrification portfolio analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hydrogen) for energy mix analysis."
    - name: "drive_type"
      expr: drive_type
      comment: "Drive type (FWD, RWD, AWD) for product portfolio analysis."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (automatic, manual, CVT, e-drive) for drivetrain analysis."
    - name: "spec_status"
      expr: spec_status
      comment: "Specification status (draft, approved, released, obsolete) for lifecycle management."
  measures:
    - name: "total_powertrain_specs"
      expr: COUNT(1)
      comment: "Total number of powertrain specifications. Baseline for powertrain portfolio complexity."
    - name: "avg_co2_target_g_per_km"
      expr: AVG(CAST(co2_target_g_per_km AS DOUBLE))
      comment: "Average CO2 target (g/km) across powertrain specs. Key fleet emissions compliance KPI."
    - name: "avg_max_power_kw"
      expr: AVG(CAST(max_power_kw AS DOUBLE))
      comment: "Average maximum power output (kW) across powertrain specs. Benchmarks performance portfolio."
    - name: "avg_max_torque_nm"
      expr: AVG(CAST(max_torque_nm AS DOUBLE))
      comment: "Average maximum torque (Nm) across powertrain specs. Tracks performance competitiveness."
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity (kWh) across electrified powertrain specs. Tracks EV range capability."
    - name: "total_battery_capacity_kwh"
      expr: SUM(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Total battery capacity across all electrified specs. Tracks battery supply and cost exposure."
    - name: "bev_spec_count"
      expr: COUNT(CASE WHEN powertrain_type = 'BEV' THEN 1 END)
      comment: "Number of BEV powertrain specifications. Tracks pure electric vehicle portfolio depth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program milestone KPIs: on-time delivery rates, gate completion, and schedule adherence. Used by Program Directors and C-suite to govern program execution and launch readiness."
  source: "`vibe_automotive_v1`.`engineering`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (design freeze, SOP, SOS, gate review) for program phase analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current milestone status (planned, achieved, delayed, cancelled) for program health tracking."
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned, for program timeline analysis."
    - name: "gate_number"
      expr: gate_number
      comment: "Program gate number associated with the milestone. Tracks stage-gate process compliance."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of program milestones. Baseline for program complexity and governance scope."
    - name: "milestones_achieved"
      expr: COUNT(CASE WHEN milestone_status = 'ACHIEVED' THEN 1 END)
      comment: "Number of milestones achieved. Tracks program delivery performance."
    - name: "milestone_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'ACHIEVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved on or before planned date. Primary program execution KPI."
    - name: "milestones_delayed"
      expr: COUNT(CASE WHEN actual_date > planned_date THEN 1 END)
      comment: "Number of milestones completed after planned date. Schedule risk indicator for program governance."
    - name: "avg_delay_days"
      expr: AVG(CASE WHEN actual_date > planned_date THEN DATEDIFF(actual_date, planned_date) ELSE 0 END)
      comment: "Average delay in days for late milestones. Quantifies schedule slippage for program steering."
    - name: "unique_programs_tracked"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of vehicle programs with milestone tracking. Tracks governance coverage across portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_action_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for engineering actions, measuring effort, cost, and volume."
  source: "`vibe_automotive_v1`.`engineering`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of engineering action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action"
    - name: "priority"
      expr: priority
      comment: "Priority level of the action"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of actions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_bom_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and status overview of Bills of Materials across programs and plants."
  source: "`vibe_automotive_v1`.`engineering`.`bom`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the BOM"
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Number of BOM records"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_ota_release_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk metrics for OTA software releases."
  source: "`vibe_automotive_v1`.`engineering`.`ota_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of OTA release"
  measures:
    - name: "total_releases"
      expr: COUNT(1)
      comment: "Total OTA releases"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_project_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of engineering projects, tracking budget vs actual spend."
  source: "`vibe_automotive_v1`.`engineering`.`project`"
  dimensions:
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Associated vehicle program"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Count of projects"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of budgeted amounts"
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_validation_test_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance metrics for engineering validation tests."
  source: "`vibe_automotive_v1`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of validation test"
    - name: "test_status"
      expr: test_status
      comment: "Overall status of the test"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of validation tests"
    - name: "passed_tests"
      expr: SUM(CASE WHEN test_status='Passed' THEN 1 ELSE 0 END)
      comment: "Number of tests that passed"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`engineering_weight_report_variance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight compliance and variance tracking for vehicle programs."
  source: "`vibe_automotive_v1`.`engineering`.`weight_report`"
  dimensions:
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Vehicle program identifier"
    - name: "report_status"
      expr: report_status
      comment: "Status of the weight report"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Number of weight reports"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Sum of actual weight measured"
    - name: "weight_compliance_count"
      expr: SUM(CASE WHEN compliance_flag='True' THEN 1 ELSE 0 END)
      comment: "Count of reports marked compliant"
$$;