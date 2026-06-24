-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer probe run KPIs tracking yield, throughput, and test coverage at the wafer level — core operational metrics for fab test engineering and yield management."
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the wafer probe run (e.g., completed, in-progress, failed) for operational filtering."
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Detailed status of the wafer probe run used for workflow tracking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the probe run started, used for trend analysis over time."
    - name: "start_week"
      expr: DATE_TRUNC('WEEK', start_timestamp)
      comment: "Week the probe run started, used for weekly operational reporting."
    - name: "parametric_test_data_available"
      expr: parametric_test_data_available
      comment: "Flag indicating whether parametric test data is available for this run, used to segment runs with full data coverage."
  measures:
    - name: "total_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed. Baseline throughput KPI for test operations."
    - name: "avg_wafer_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average wafer probe yield percentage across all runs. Primary quality KPI — a decline triggers immediate engineering investigation."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage achieved during probe runs. Drives decisions on test program completeness and escape risk."
    - name: "avg_contact_yield_percent"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average contact yield percentage, indicating probe card and handler quality. Low values signal probe card maintenance needs."
    - name: "total_probe_cost"
      expr: SUM(CAST(probe_cost AS DOUBLE))
      comment: "Total probe cost across all runs. Directly informs cost-per-wafer and test economics decisions."
    - name: "avg_probe_cost_per_run"
      expr: AVG(CAST(probe_cost AS DOUBLE))
      comment: "Average probe cost per run. Used to benchmark test efficiency and identify cost outliers."
    - name: "runs_with_parametric_data_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN parametric_test_data_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of probe runs with parametric test data available. Low values indicate data capture gaps that impair yield learning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test run KPIs covering yield, test time, power consumption, and throughput at the unit/package level — critical for product quality sign-off and cost management."
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Status of the final test run (e.g., pass, fail, in-progress) for operational and quality filtering."
    - name: "test_type"
      expr: test_type
      comment: "Type of final test performed (e.g., functional, parametric, burn-in) for segmenting test economics."
    - name: "test_shift"
      expr: test_shift
      comment: "Production shift during which the test was performed, used for shift-level quality and throughput analysis."
    - name: "insertion_type"
      expr: insertion_type
      comment: "Insertion type (e.g., wafer sort, final test) for segmenting yield and cost by test stage."
    - name: "test_location"
      expr: test_location
      comment: "Physical location where the final test was performed, used for site-level benchmarking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the final test run started, for trend and capacity planning analysis."
  measures:
    - name: "total_final_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs. Baseline throughput metric for test operations capacity planning."
    - name: "avg_final_test_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average final test yield percentage. Primary product quality KPI — directly tied to revenue and customer satisfaction."
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per run in seconds. Drives test cost-per-unit and tester utilization decisions."
    - name: "total_test_time_seconds"
      expr: SUM(CAST(test_time_seconds AS DOUBLE))
      comment: "Total test time consumed across all final test runs. Used for tester capacity and cost allocation."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption during final test in milliwatts. Elevated values may indicate device quality issues or test condition anomalies."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN test_result = 'PASS' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of final test runs with a passing result. Core quality KPI for product release decisions."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius. Deviations from spec trigger process and equipment investigations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-level test result KPIs tracking pass/fail rates, yield, and parametric performance at the individual die or package level — foundational for quality and yield management."
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail outcome of the unit test, primary quality dimension."
    - name: "test_stage"
      expr: test_stage
      comment: "Stage of test (e.g., wafer sort, final test, burn-in) for yield analysis by test insertion."
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hard bin assignment for the unit, used for failure mode analysis and yield loss attribution."
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Soft bin assignment providing finer failure categorization for engineering analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status, critical for die bank and advanced packaging decisions."
    - name: "test_timestamp_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month of test execution for trend analysis of yield and quality over time."
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Flag indicating whether this result is from a retest, used to separate first-pass from retest yield."
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of units tested. Baseline throughput metric for test operations."
    - name: "pass_fail_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "First-pass yield rate as a percentage. Core product quality KPI directly tied to revenue and customer commitments."
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds. Drives cost-per-unit and tester utilization optimization."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average parametric result value across units. Tracks process centering and parameter drift over time."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius. Deviations indicate test condition control issues."
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts. Used to verify test condition compliance and identify outliers."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN retest_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units that required a retest. High retest rates signal test instability or marginal devices."
    - name: "kgd_certified_units"
      expr: COUNT(CASE WHEN kgd_status = 'CERTIFIED' THEN 1 END)
      comment: "Count of units achieving Known Good Die certification. Directly drives die bank inventory value and advanced packaging supply."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric measurement KPIs tracking measurement quality, spec compliance, and process centering — essential for SPC, yield learning, and process control decisions."
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement (e.g., voltage, current, frequency) for segmenting process control analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the parametric measurement against its limit."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the measurement record for data quality filtering."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the measured parameter, used to drill into specific electrical characteristics."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode under which the measurement was taken (e.g., DC, AC) for condition-based analysis."
    - name: "measurement_timestamp_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend and SPC analysis over time."
    - name: "measurement_quality_flag"
      expr: measurement_quality_flag
      comment: "Flag indicating measurement quality issues, used to filter suspect data from analysis."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements. Baseline for measurement coverage and data completeness assessment."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parametric value. Tracks process centering and detects drift requiring corrective action."
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average measurement standard deviation. Indicates process variability — high values trigger SPC investigations."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty. Drives decisions on calibration frequency and guard band adjustments."
    - name: "spec_fail_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'FAIL' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements failing specification limits. Core process quality KPI — directly tied to yield loss and customer escapes."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across measurements. Used to validate limit consistency and detect unauthorized limit changes."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across measurements. Paired with upper limit for spec window analysis."
    - name: "avg_measurement_condition_temperature_c"
      expr: AVG(CAST(measurement_condition_temperature_c AS DOUBLE))
      comment: "Average measurement condition temperature in Celsius. Validates test condition compliance across measurement runs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_reliability_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test run KPIs covering stress test outcomes, failure rates, and yield impact — critical for product qualification, customer commitments, and long-term quality assurance."
  source: "`vibe_semiconductors_v1`.`test`.`reliability_test_run`"
  dimensions:
    - name: "stress_type"
      expr: stress_type
      comment: "Type of reliability stress applied (e.g., HTOL, ELFR, TC) for segmenting qualification results."
    - name: "test_type"
      expr: test_type
      comment: "Category of reliability test for grouping qualification program coverage."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification outcome status (e.g., passed, failed, in-progress) for product release decisions."
    - name: "run_status"
      expr: run_status
      comment: "Current operational status of the reliability test run."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Industry compliance standard governing the test (e.g., AEC-Q100, JEDEC) for regulatory and customer reporting."
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_timestamp)
      comment: "Month the reliability test started, for qualification pipeline and trend analysis."
    - name: "stress_mode"
      expr: stress_mode
      comment: "Stress mode applied during the test (e.g., voltage, temperature, humidity) for failure mode analysis."
  measures:
    - name: "total_reliability_runs"
      expr: COUNT(1)
      comment: "Total number of reliability test runs. Baseline for qualification pipeline throughput."
    - name: "avg_test_failure_rate_percent"
      expr: AVG(CAST(test_failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage across reliability test runs. Primary qualification KPI — high values block product release."
    - name: "avg_pre_stress_yield_percent"
      expr: AVG(CAST(pre_stress_yield_percent AS DOUBLE))
      comment: "Average yield before stress application. Establishes baseline for yield degradation measurement."
    - name: "avg_post_stress_yield_percent"
      expr: AVG(CAST(post_stress_yield_percent AS DOUBLE))
      comment: "Average yield after stress application. Directly measures reliability-induced yield loss."
    - name: "avg_yield_improvement_percent"
      expr: AVG(CAST(test_yield_improvement_percent AS DOUBLE))
      comment: "Average yield improvement achieved through reliability screening. Quantifies the value of burn-in and stress screening programs."
    - name: "avg_infant_mortality_rate"
      expr: AVG(CAST(infant_mortality_rate AS DOUBLE))
      comment: "Average infant mortality rate across reliability runs. High values indicate latent defects reaching customers — a critical quality risk."
    - name: "avg_acceleration_factor"
      expr: AVG(CAST(acceleration_factor AS DOUBLE))
      comment: "Average acceleration factor used in reliability testing. Validates that test conditions adequately accelerate field failure mechanisms."
    - name: "avg_stress_temperature_c"
      expr: AVG(CAST(stress_temperature_c AS DOUBLE))
      comment: "Average stress temperature in Celsius. Validates test condition compliance with qualification standards."
    - name: "avg_screen_effectiveness_percent"
      expr: AVG(CAST(screen_effectiveness_percent AS DOUBLE))
      comment: "Average screening effectiveness percentage. Measures how well reliability screens remove defective units before shipment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test program KPIs tracking coverage, lifecycle status, and program health — used by test engineering leadership to manage program portfolio quality and coverage targets."
  source: "`vibe_semiconductors_v1`.`test`.`test_program`"
  dimensions:
    - name: "test_program_status"
      expr: test_program_status
      comment: "Lifecycle status of the test program (e.g., active, deprecated, in-development) for portfolio management."
    - name: "test_type"
      expr: test_type
      comment: "Type of test program (e.g., functional, parametric, BIST) for segmenting coverage analysis."
    - name: "program_category"
      expr: program_category
      comment: "Category of the test program for portfolio grouping and resource allocation."
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE platform the program runs on, used for platform utilization and migration planning."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating whether the test program is deprecated, used to filter active vs. retired programs."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the test program was released, for program lifecycle and release cadence analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the test program, used to track programs pending release approval."
  measures:
    - name: "total_test_programs"
      expr: COUNT(1)
      comment: "Total number of test programs in the portfolio. Baseline for program management and resource planning."
    - name: "avg_actual_coverage_percent"
      expr: AVG(CAST(actual_coverage_percent AS DOUBLE))
      comment: "Average actual test coverage percentage across programs. Core quality KPI — gaps below target trigger program enhancement investments."
    - name: "avg_coverage_target_percent"
      expr: AVG(CAST(coverage_target_percent AS DOUBLE))
      comment: "Average coverage target percentage across programs. Used to benchmark actual vs. target coverage performance."
    - name: "coverage_gap_pct"
      expr: ROUND(AVG(CAST(coverage_target_percent AS DOUBLE)) - AVG(CAST(actual_coverage_percent AS DOUBLE)), 2)
      comment: "Average gap between target and actual test coverage. Negative values indicate programs meeting or exceeding targets; positive values flag programs requiring investment."
    - name: "avg_test_limit_value"
      expr: AVG(CAST(test_limit_value AS DOUBLE))
      comment: "Average test limit value across programs. Used to validate limit consistency and detect outlier programs."
    - name: "deprecated_program_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_deprecated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test programs that are deprecated. High values indicate portfolio hygiene issues requiring cleanup investment."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN is_deprecated = FALSE THEN 1 END)
      comment: "Count of active (non-deprecated) test programs. Used for resource planning and platform capacity allocation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test coverage KPIs tracking fault coverage, DFT effectiveness, and yield estimation — used by design and test engineering to validate test completeness and manage escape risk."
  source: "`vibe_semiconductors_v1`.`test`.`coverage`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage measurement (e.g., stuck-at, transition, IDDQ) for segmenting coverage analysis by fault model."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Status of the coverage record (e.g., approved, pending review) for governance filtering."
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage (e.g., functional, structural) for portfolio-level coverage analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for which coverage was measured, enabling product-level coverage benchmarking."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating whether the coverage record has been approved for release decisions."
    - name: "coverage_month"
      expr: DATE_TRUNC('MONTH', coverage_date)
      comment: "Month of coverage measurement for trend analysis of test program improvements."
    - name: "tapeout_ready"
      expr: tapeout_ready
      comment: "Flag indicating whether coverage meets tapeout readiness criteria — gates design sign-off."
  measures:
    - name: "avg_fault_coverage_percent"
      expr: AVG(CAST(fault_coverage_percent AS DOUBLE))
      comment: "Average fault coverage percentage. Primary test completeness KPI — below-target values block tapeout and product release."
    - name: "avg_stuck_at_fault_coverage_percent"
      expr: AVG(CAST(stuck_at_fault_coverage_percent AS DOUBLE))
      comment: "Average stuck-at fault coverage percentage. Industry-standard DFT metric for structural test completeness."
    - name: "avg_transition_fault_coverage_percent"
      expr: AVG(CAST(transition_fault_coverage_percent AS DOUBLE))
      comment: "Average transition fault coverage percentage. Measures dynamic fault detection capability critical for high-speed designs."
    - name: "avg_iddq_coverage_percent"
      expr: AVG(CAST(iddq_coverage_percent AS DOUBLE))
      comment: "Average IDDQ coverage percentage. Detects bridging and leakage faults not caught by logic tests."
    - name: "avg_dft_structure_coverage_percent"
      expr: AVG(CAST(dft_structure_coverage_percent AS DOUBLE))
      comment: "Average DFT structure coverage percentage. Validates that DFT insertion achieved its structural coverage goals."
    - name: "avg_yield_estimate_percent"
      expr: AVG(CAST(yield_estimate_percent AS DOUBLE))
      comment: "Average yield estimate derived from coverage analysis. Bridges test coverage to expected manufacturing yield for financial planning."
    - name: "total_fault_count"
      expr: SUM(CAST(fault_count AS DOUBLE))
      comment: "Total number of faults detected across all coverage records. Tracks absolute fault detection volume for test program benchmarking."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across coverage records. Directly informs yield models and process quality assessments."
    - name: "tapeout_ready_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tapeout_ready = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coverage records meeting tapeout readiness criteria. Gates design-to-manufacturing handoff decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_correlation_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Correlation study KPIs tracking test platform alignment, guard band effectiveness, and study outcomes — used by test engineering to ensure multi-site and multi-platform test equivalence."
  source: "`vibe_semiconductors_v1`.`test`.`correlation_study`"
  dimensions:
    - name: "correlation_study_status"
      expr: correlation_study_status
      comment: "Status of the correlation study (e.g., approved, in-progress, expired) for pipeline management."
    - name: "study_type"
      expr: study_type
      comment: "Type of correlation study (e.g., site-to-site, platform-to-platform) for segmenting equivalence analysis."
    - name: "test_platform"
      expr: test_platform
      comment: "Test platform involved in the correlation study, used for platform-level equivalence benchmarking."
    - name: "correlation_methodology"
      expr: correlation_methodology
      comment: "Statistical methodology used for correlation (e.g., Pearson, Spearman) for methodology governance."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the correlation study was approved, for tracking study pipeline velocity."
  measures:
    - name: "total_correlation_studies"
      expr: COUNT(1)
      comment: "Total number of correlation studies. Baseline for test equivalence program coverage."
    - name: "avg_correlation_coefficient"
      expr: AVG(CAST(correlation_coefficient AS DOUBLE))
      comment: "Average correlation coefficient across studies. Values below threshold indicate platform misalignment requiring corrective action."
    - name: "avg_systematic_offset"
      expr: AVG(CAST(systematic_offset AS DOUBLE))
      comment: "Average systematic offset between correlated platforms. Large offsets drive guard band adjustments and limit changes."
    - name: "avg_cpk_impact"
      expr: AVG(CAST(cpk_impact AS DOUBLE))
      comment: "Average Cpk impact from correlation offsets. Quantifies how platform differences affect process capability and yield."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level of correlation studies. Low confidence triggers study repetition with larger sample sizes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_adaptive_test_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adaptive test flow KPIs tracking test time reduction, risk management, and flow effectiveness — used by test engineering leadership to optimize test economics while managing quality escape risk."
  source: "`vibe_semiconductors_v1`.`test`.`adaptive_test_flow`"
  dimensions:
    - name: "adaptive_test_flow_status"
      expr: adaptive_test_flow_status
      comment: "Status of the adaptive test flow (e.g., active, deprecated, under-review) for portfolio management."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of adaptive flow (e.g., skip-based, ML-driven, rule-based) for segmenting optimization strategy analysis."
    - name: "is_enabled"
      expr: is_enabled
      comment: "Flag indicating whether the adaptive flow is currently enabled in production."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating whether the adaptive flow has been deprecated."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard governing the adaptive flow, used for regulatory and customer audit filtering."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the adaptive flow became effective, for deployment timeline analysis."
  measures:
    - name: "total_adaptive_flows"
      expr: COUNT(1)
      comment: "Total number of adaptive test flows defined. Baseline for test optimization program scope."
    - name: "avg_test_time_reduction_target_percent"
      expr: AVG(CAST(test_time_reduction_target_percent AS DOUBLE))
      comment: "Average test time reduction target percentage across adaptive flows. Directly quantifies the cost savings potential of the adaptive test program."
    - name: "avg_quality_escape_risk_threshold"
      expr: AVG(CAST(quality_escape_risk_threshold AS DOUBLE))
      comment: "Average quality escape risk threshold set for adaptive flows. Tracks the risk tolerance level accepted in exchange for test time savings."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across adaptive flows. High scores flag flows requiring additional review before production deployment."
    - name: "enabled_flow_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adaptive flows currently enabled in production. Tracks adoption rate of test optimization initiatives."
    - name: "total_adaptive_flow_insertions"
      expr: SUM(CAST(adaptive_flow_at_insertion AS DOUBLE))
      comment: "Total number of insertions where adaptive flows are applied. Measures the production scale of adaptive test deployment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_bin_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bin definition KPIs tracking yield targets, bin distribution health, and limit compliance — used by test and product engineering to manage yield loss attribution and disposition rules."
  source: "`vibe_semiconductors_v1`.`test`.`bin_definition`"
  dimensions:
    - name: "bin_category"
      expr: bin_category
      comment: "Category of the bin (e.g., pass, functional fail, parametric fail) for yield loss attribution."
    - name: "bin_definition_status"
      expr: bin_definition_status
      comment: "Status of the bin definition (e.g., active, retired) for filtering current vs. historical definitions."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode associated with the bin, used for root cause analysis and process improvement prioritization."
    - name: "test_level"
      expr: test_level
      comment: "Test level at which the bin is applied (e.g., wafer sort, final test) for stage-specific yield analysis."
    - name: "yield_impact_classification"
      expr: yield_impact_classification
      comment: "Classification of the bin's yield impact (e.g., high, medium, low) for prioritizing yield improvement efforts."
    - name: "device_family"
      expr: device_family
      comment: "Device family associated with the bin definition for product-level yield benchmarking."
  measures:
    - name: "total_bin_definitions"
      expr: COUNT(1)
      comment: "Total number of bin definitions. Baseline for test program complexity and yield attribution coverage."
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target percentage across bin definitions. Tracks the aggregate yield commitment embedded in test programs."
    - name: "avg_bin_limit_pct"
      expr: AVG(CAST(bin_limit_pct AS DOUBLE))
      comment: "Average bin limit percentage (maximum allowed bin rate). Exceeding this triggers product hold and engineering escalation."
    - name: "high_impact_bin_count"
      expr: COUNT(CASE WHEN yield_impact_classification = 'HIGH' THEN 1 END)
      comment: "Count of bins classified as high yield impact. Prioritizes engineering focus on the most significant yield loss contributors."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe card KPIs tracking utilization, maintenance compliance, and cost — used by test operations to manage probe card lifecycle, prevent yield-impacting failures, and control consumable costs."
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "probe_card_status"
      expr: probe_card_status
      comment: "Current operational status of the probe card (e.g., active, in-maintenance, retired)."
    - name: "probe_card_type"
      expr: probe_card_type
      comment: "Type of probe card (e.g., cantilever, vertical, MEMS) for technology-level cost and performance analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the probe card, used to filter qualified vs. unqualified cards in production."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Probe card manufacturer for supplier performance and cost benchmarking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the probe card for regulatory and quality audit filtering."
  measures:
    - name: "total_probe_cards"
      expr: COUNT(1)
      comment: "Total number of probe cards in the fleet. Baseline for capacity planning and consumable inventory management."
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per probe card. Tracks utilization against maintenance thresholds to prevent yield-impacting failures."
    - name: "total_probe_card_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total probe card fleet cost in USD. Directly informs test consumable budget and cost-per-wafer calculations."
    - name: "avg_probe_card_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average probe card cost in USD. Used for procurement benchmarking and supplier negotiation."
    - name: "avg_contact_resistance_ohm"
      expr: AVG(CAST(contact_resistance_ohm AS DOUBLE))
      comment: "Average contact resistance in ohms. Elevated values indicate probe card degradation requiring maintenance or replacement."
    - name: "avg_pitch_um"
      expr: AVG(CAST(pitch_um AS DOUBLE))
      comment: "Average probe pitch in micrometers. Tracks technology node alignment of the probe card fleet."
    - name: "overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_due < CURRENT_DATE() THEN 1 END)
      comment: "Count of probe cards with overdue maintenance. Overdue cards risk yield loss and require immediate operational intervention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_insertion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test insertion KPIs tracking cost, coverage, and temperature compliance across test insertions — used by test engineering and finance to optimize test flow economics and ensure insertion completeness."
  source: "`vibe_semiconductors_v1`.`test`.`insertion`"
  dimensions:
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of test insertion (e.g., wafer sort, final test, burn-in) for stage-level cost and coverage analysis."
    - name: "insertion_status"
      expr: insertion_status
      comment: "Current status of the insertion definition (e.g., active, retired) for filtering production-relevant insertions."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the insertion is mandatory, used to separate required vs. optional test steps."
    - name: "ate_platform_type"
      expr: ate_platform_type
      comment: "ATE platform type for the insertion, used for platform utilization and cost allocation."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the insertion became effective, for tracking test flow evolution over time."
  measures:
    - name: "total_insertions"
      expr: COUNT(1)
      comment: "Total number of test insertions defined. Baseline for test flow complexity and coverage scope."
    - name: "total_cost_per_unit_usd"
      expr: SUM(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Total cost per unit across all insertions in USD. Aggregates the full test cost stack for cost-per-unit analysis."
    - name: "avg_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Average cost per unit per insertion in USD. Drives test economics optimization and insertion prioritization decisions."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage per insertion. Validates that each insertion contributes meaningful fault detection."
    - name: "avg_yield_gate_criteria_percent"
      expr: AVG(CAST(yield_gate_criteria_percent AS DOUBLE))
      comment: "Average yield gate criteria percentage across insertions. Tracks the yield thresholds that gate product progression through the test flow."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum test temperature in Celsius. Validates thermal stress compliance across insertions."
    - name: "mandatory_insertion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mandatory_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of insertions that are mandatory. Tracks the proportion of non-skippable test steps in the flow."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_ate_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ATE configuration KPIs tracking calibration compliance, platform utilization, and lifecycle health — used by test operations management to ensure tester readiness and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`test`.`ate_configuration`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "ATE platform type (e.g., Advantest, Teradyne) for platform-level utilization and cost benchmarking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the ATE configuration (e.g., active, end-of-life) for fleet management decisions."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status of the ATE configuration, critical for measurement validity and compliance."
    - name: "load_board_qualification_status"
      expr: load_board_qualification_status
      comment: "Qualification status of the load board, used to filter production-ready configurations."
    - name: "compliance_itar_status"
      expr: compliance_itar_status
      comment: "ITAR compliance status of the ATE configuration, required for export control and customer access decisions."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the ATE configuration became effective, for fleet deployment timeline analysis."
  measures:
    - name: "total_ate_configurations"
      expr: COUNT(1)
      comment: "Total number of ATE configurations. Baseline for tester fleet capacity planning."
    - name: "avg_test_coverage_percentage"
      expr: AVG(CAST(test_coverage_percentage AS DOUBLE))
      comment: "Average test coverage percentage achievable by ATE configurations. Validates that the tester fleet supports required coverage targets."
    - name: "avg_test_yield_target_percentage"
      expr: AVG(CAST(test_yield_target_percentage AS DOUBLE))
      comment: "Average yield target percentage set for ATE configurations. Tracks the yield commitments embedded in tester setup."
    - name: "calibration_overdue_count"
      expr: COUNT(CASE WHEN calibration_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of ATE configurations with overdue calibration. Overdue calibrations invalidate test results and create compliance risk."
    - name: "parametric_test_supported_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN parametric_test_supported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ATE configurations supporting parametric testing. Tracks fleet capability for advanced test requirements."
$$;