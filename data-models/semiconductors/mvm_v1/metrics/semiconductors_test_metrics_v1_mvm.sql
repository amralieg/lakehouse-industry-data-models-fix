-- Metric views for domain: test | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test run KPIs tracking yield, test time, throughput, and quality metrics for packaged semiconductor units"
  source: "`semiconductors_ecm`.`test`.`final_test_run`"
  dimensions:
    - name: "test_result"
      expr: test_result
      comment: "Pass/fail outcome of the final test run"
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Operational status of the final test run (completed, in-progress, aborted)"
    - name: "test_type"
      expr: test_type
      comment: "Type of final test performed (functional, parametric, burn-in)"
    - name: "test_location"
      expr: test_location
      comment: "Geographic or facility location where final test was executed"
    - name: "ate_name"
      expr: ate_name
      comment: "Automated test equipment identifier used for the test run"
    - name: "test_shift"
      expr: test_shift
      comment: "Production shift during which the test was executed"
    - name: "test_program_version"
      expr: test_program_version
      comment: "Version of the test program used for this run"
    - name: "test_date"
      expr: DATE(start_timestamp)
      comment: "Calendar date when the final test run started"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket for time-series analysis of test runs"
    - name: "test_quarter"
      expr: DATE_TRUNC('QUARTER', start_timestamp)
      comment: "Quarter bucket for executive reporting of test performance"
  measures:
    - name: "total_final_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs executed"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average final test yield percentage across all runs - key quality and profitability indicator"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per run in seconds - key throughput and cost driver"
    - name: "total_test_time_hours"
      expr: SUM(CAST(test_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total test time in hours - capacity utilization metric"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - process control metric"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts - product performance and reliability indicator"
    - name: "total_units_tested"
      expr: SUM((CAST(pass_count AS BIGINT)) + (CAST(fail_count AS BIGINT)))
      comment: "Total semiconductor units tested across all runs - volume metric"
    - name: "total_pass_count"
      expr: SUM(CAST(pass_count AS BIGINT))
      comment: "Total units that passed final test - good die output"
    - name: "total_fail_count"
      expr: SUM(CAST(fail_count AS BIGINT))
      comment: "Total units that failed final test - scrap and rework driver"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer probe KPIs tracking die yield, test coverage, and wafer-level quality before packaging"
  source: "`semiconductors_ecm`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Status of the wafer probe run (completed, in-progress, aborted)"
    - name: "probe_date"
      expr: DATE(start_timestamp)
      comment: "Calendar date when the wafer probe run started"
    - name: "probe_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket for time-series analysis of wafer probe performance"
    - name: "probe_quarter"
      expr: DATE_TRUNC('QUARTER', start_timestamp)
      comment: "Quarter bucket for executive reporting of wafer yield trends"
    - name: "bin_map_version"
      expr: bin_map_version
      comment: "Version of the bin mapping used for die classification"
    - name: "run_number"
      expr: run_number
      comment: "Sequential run number for tracking and traceability"
  measures:
    - name: "total_wafer_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed"
    - name: "avg_contact_yield_percent"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average contact yield percentage - probe card and process health indicator"
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage - quality assurance completeness metric"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS BIGINT))
      comment: "Total gross die count across all wafers - maximum potential output"
    - name: "total_pass_die"
      expr: SUM(CAST(pass_die_count AS BIGINT))
      comment: "Total die that passed wafer probe - known good die for packaging"
    - name: "total_fail_die"
      expr: SUM(CAST(fail_die_count AS BIGINT))
      comment: "Total die that failed wafer probe - yield loss and defect indicator"
    - name: "total_die_tested"
      expr: SUM(CAST(total_die_count AS BIGINT))
      comment: "Total die tested across all wafer probe runs"
    - name: "avg_probe_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(end_timestamp) - UNIX_TIMESTAMP(start_timestamp) AS DOUBLE)) / 3600.0
      comment: "Average wafer probe run duration in hours - throughput and efficiency metric"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric test measurement KPIs tracking electrical parameter compliance, process control, and device performance"
  source: "`semiconductors_ecm`.`test`.`parametric_measurement`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the parametric measurement against specification limits"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Operational status of the measurement (valid, invalid, flagged)"
    - name: "test_parameter_name"
      expr: test_parameter_name
      comment: "Name of the electrical parameter being measured (Vdd, Idd, frequency, etc.)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement (DC, AC, functional, leakage)"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location or site where the measurement was taken"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode of measurement execution (normal, debug, characterization)"
    - name: "measurement_quality_flag"
      expr: measurement_quality_flag
      comment: "Quality flag indicating measurement reliability (good, suspect, invalid)"
    - name: "measurement_flagged"
      expr: measurement_flagged
      comment: "Boolean flag indicating if measurement was flagged for review"
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Calendar date when the parametric measurement was taken"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month bucket for time-series analysis of parametric trends"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parametric value (V, mA, MHz, ohm)"
  measures:
    - name: "total_parametric_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements recorded"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all parametric tests - central tendency indicator"
    - name: "avg_measurement_average_value"
      expr: AVG(CAST(measurement_average_value AS DOUBLE))
      comment: "Average of measurement average values - process centering metric"
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of measurements - process variation indicator"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty - metrology quality metric"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit - process window reference"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit - process window reference"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(measurement_condition_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - environmental condition tracking"
    - name: "avg_test_voltage_mv"
      expr: AVG(CAST(measurement_condition_voltage_mv AS DOUBLE))
      comment: "Average test voltage in millivolts - operating condition tracking"
    - name: "avg_test_frequency_mhz"
      expr: AVG(CAST(measurement_condition_frequency_mhz AS DOUBLE))
      comment: "Average test frequency in MHz - performance condition tracking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_reliability_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test KPIs tracking stress testing, burn-in effectiveness, failure rates, and product qualification"
  source: "`semiconductors_ecm`.`test`.`reliability_test_run`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Status of the reliability test run (completed, in-progress, aborted)"
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, burn-in, ESD)"
    - name: "stress_mode"
      expr: stress_mode
      comment: "Stress mode applied during reliability testing (thermal, voltage, combined)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status outcome (passed, failed, in-progress)"
    - name: "test_location"
      expr: test_location
      comment: "Geographic or facility location where reliability test was executed"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Industry compliance standard applied (JEDEC, AEC-Q100, MIL-STD)"
    - name: "test_failure_mode"
      expr: test_failure_mode
      comment: "Failure mode observed during reliability testing"
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_timestamp)
      comment: "Month bucket for time-series analysis of reliability test execution"
    - name: "test_start_quarter"
      expr: DATE_TRUNC('QUARTER', test_start_timestamp)
      comment: "Quarter bucket for executive reporting of reliability performance"
  measures:
    - name: "total_reliability_test_runs"
      expr: COUNT(1)
      comment: "Total number of reliability test runs executed"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average reliability test duration in hours - test rigor and cost indicator"
    - name: "avg_stress_temperature_c"
      expr: AVG(CAST(stress_temperature_c AS DOUBLE))
      comment: "Average stress temperature in Celsius - test severity metric"
    - name: "avg_stress_voltage_v"
      expr: AVG(CAST(stress_voltage_v AS DOUBLE))
      comment: "Average stress voltage in volts - electrical stress level"
    - name: "avg_stress_humidity_percent"
      expr: AVG(CAST(stress_humidity_percent AS DOUBLE))
      comment: "Average stress humidity percentage - environmental stress level"
    - name: "avg_acceleration_factor"
      expr: AVG(CAST(acceleration_factor AS DOUBLE))
      comment: "Average acceleration factor - time-to-market and test efficiency metric"
    - name: "avg_test_failure_rate_percent"
      expr: AVG(CAST(test_failure_rate_percent AS DOUBLE))
      comment: "Average test failure rate percentage - reliability and quality indicator"
    - name: "avg_infant_mortality_rate"
      expr: AVG(CAST(infant_mortality_rate AS DOUBLE))
      comment: "Average infant mortality rate - early-life failure risk metric"
    - name: "avg_pre_stress_yield_percent"
      expr: AVG(CAST(pre_stress_yield_percent AS DOUBLE))
      comment: "Average pre-stress yield percentage - baseline quality before stress"
    - name: "avg_post_stress_yield_percent"
      expr: AVG(CAST(post_stress_yield_percent AS DOUBLE))
      comment: "Average post-stress yield percentage - quality after stress exposure"
    - name: "avg_screen_effectiveness_percent"
      expr: AVG(CAST(screen_effectiveness_percent AS DOUBLE))
      comment: "Average screen effectiveness percentage - burn-in and screening quality metric"
    - name: "avg_test_yield_improvement_percent"
      expr: AVG(CAST(test_yield_improvement_percent AS DOUBLE))
      comment: "Average yield improvement percentage from reliability screening - ROI of burn-in"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test coverage KPIs tracking fault coverage, DFT effectiveness, and design-for-test quality metrics"
  source: "`semiconductors_ecm`.`test`.`coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Status of the coverage analysis (approved, pending, rejected)"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of test coverage (structural, functional, parametric)"
    - name: "coverage_method"
      expr: coverage_method
      comment: "Method used to achieve coverage (ATPG, scan, BIST, functional)"
    - name: "device_type"
      expr: device_type
      comment: "Type of device under test coverage analysis"
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating if coverage has been approved for production"
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating if this is a critical coverage metric"
    - name: "tapeout_ready"
      expr: tapeout_ready
      comment: "Boolean flag indicating if coverage meets tapeout readiness criteria"
    - name: "tool"
      expr: tool
      comment: "EDA tool used for coverage analysis"
    - name: "coverage_month"
      expr: DATE_TRUNC('MONTH', coverage_date)
      comment: "Month bucket for time-series analysis of coverage trends"
  measures:
    - name: "total_coverage_analyses"
      expr: COUNT(1)
      comment: "Total number of test coverage analyses performed"
    - name: "avg_fault_coverage_percent"
      expr: AVG(CAST(fault_coverage_percent AS DOUBLE))
      comment: "Average fault coverage percentage - overall test quality indicator"
    - name: "avg_stuck_at_fault_coverage_percent"
      expr: AVG(CAST(stuck_at_fault_coverage_percent AS DOUBLE))
      comment: "Average stuck-at fault coverage percentage - basic structural test quality"
    - name: "avg_transition_fault_coverage_percent"
      expr: AVG(CAST(transition_fault_coverage_percent AS DOUBLE))
      comment: "Average transition fault coverage percentage - delay defect detection quality"
    - name: "avg_path_delay_coverage_percent"
      expr: AVG(CAST(path_delay_coverage_percent AS DOUBLE))
      comment: "Average path delay coverage percentage - timing defect detection quality"
    - name: "avg_dft_structure_coverage_percent"
      expr: AVG(CAST(dft_structure_coverage_percent AS DOUBLE))
      comment: "Average DFT structure coverage percentage - design-for-test effectiveness"
    - name: "avg_iddq_coverage_percent"
      expr: AVG(CAST(iddq_coverage_percent AS DOUBLE))
      comment: "Average IDDQ coverage percentage - quiescent current test quality"
    - name: "avg_correlation_score"
      expr: AVG(CAST(correlation_score AS DOUBLE))
      comment: "Average correlation score between test and silicon - test accuracy metric"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density - quality and yield prediction metric"
    - name: "avg_yield_estimate_percent"
      expr: AVG(CAST(yield_estimate_percent AS DOUBLE))
      comment: "Average yield estimate percentage - predicted production yield based on coverage"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-level test result KPIs tracking individual die/device pass/fail, bin distribution, and retest rates"
  source: "`semiconductors_ecm`.`test`.`unit_test_result`"
  dimensions:
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail outcome for the individual unit test"
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hardware bin code assigned to the unit - final disposition"
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Software bin code assigned to the unit - detailed failure classification"
    - name: "test_stage"
      expr: test_stage
      comment: "Stage of testing (wafer probe, final test, system-level test)"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known good die status - quality classification for packaging"
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Boolean flag indicating if this unit was retested"
    - name: "test_yield_flag"
      expr: test_yield_flag
      comment: "Boolean flag indicating if unit contributes to yield calculation"
    - name: "test_condition"
      expr: test_condition
      comment: "Test condition applied (hot, cold, nominal)"
    - name: "test_date"
      expr: DATE(test_timestamp)
      comment: "Calendar date when the unit test was executed"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month bucket for time-series analysis of unit test results"
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of individual units tested"
    - name: "total_retest_count"
      expr: SUM(CAST(retest_count AS BIGINT))
      comment: "Total retest count across all units - quality and efficiency indicator"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds - throughput and cost driver"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - test condition tracking"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts - operating condition tracking"
    - name: "distinct_units_tested"
      expr: COUNT(DISTINCT unit_identifier)
      comment: "Distinct count of unique units tested - deduplication for retest scenarios"
    - name: "distinct_device_serial_numbers"
      expr: COUNT(DISTINCT device_serial_number)
      comment: "Distinct count of unique device serial numbers - traceability metric"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test program KPIs tracking program coverage, validation status, and test flow effectiveness"
  source: "`semiconductors_ecm`.`test`.`program`"
  dimensions:
    - name: "test_program_status"
      expr: test_program_status
      comment: "Status of the test program (active, deprecated, under development)"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the test program (validated, pending, failed)"
    - name: "program_category"
      expr: program_category
      comment: "Category of test program (production, characterization, debug)"
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed by this program (functional, parametric, structural)"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment where test program is executed (production, lab, qualification)"
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE platform for which the test program is designed"
    - name: "target_device_family"
      expr: target_device_family
      comment: "Device family targeted by this test program"
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Boolean flag indicating if the test program is deprecated"
    - name: "owner"
      expr: owner
      comment: "Owner or responsible engineer for the test program"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month bucket for time-series analysis of test program releases"
  measures:
    - name: "total_test_programs"
      expr: COUNT(1)
      comment: "Total number of test programs in the portfolio"
    - name: "avg_actual_coverage_percent"
      expr: AVG(CAST(actual_coverage_percent AS DOUBLE))
      comment: "Average actual test coverage percentage achieved by programs - quality metric"
    - name: "avg_coverage_target_percent"
      expr: AVG(CAST(coverage_target_percent AS DOUBLE))
      comment: "Average target test coverage percentage - quality goal benchmark"
    - name: "avg_test_limit_value"
      expr: AVG(CAST(test_limit_value AS DOUBLE))
      comment: "Average test limit value across programs - specification tightness indicator"
    - name: "distinct_owners"
      expr: COUNT(DISTINCT owner)
      comment: "Distinct count of test program owners - resource allocation metric"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_insertion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test insertion KPIs tracking test flow sequence, cost per insertion, and yield gate effectiveness"
  source: "`semiconductors_ecm`.`test`.`insertion`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Status of the test insertion (active, inactive, under review)"
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of test insertion (wafer probe, final test, burn-in, system test)"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Boolean flag indicating if this insertion is mandatory in the flow"
    - name: "optional_flag"
      expr: optional_flag
      comment: "Boolean flag indicating if this insertion is optional"
    - name: "conditional_flag"
      expr: conditional_flag
      comment: "Boolean flag indicating if this insertion is conditionally applied"
    - name: "correlation_study_flag"
      expr: correlation_study_flag
      comment: "Boolean flag indicating if this insertion is part of a correlation study"
    - name: "insertion_name"
      expr: insertion_name
      comment: "Name of the test insertion"
    - name: "handler_requirement"
      expr: handler_requirement
      comment: "Handler equipment requirement for this insertion"
  measures:
    - name: "total_test_insertions"
      expr: COUNT(1)
      comment: "Total number of test insertions defined in test flows"
    - name: "avg_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Average cost per unit for test insertion - cost of test metric"
    - name: "total_cost_per_unit_usd"
      expr: SUM(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Total cost per unit across all insertions - cumulative test cost"
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage per insertion - quality contribution metric"
    - name: "avg_yield_gate_criteria_percent"
      expr: AVG(CAST(yield_gate_criteria_percent AS DOUBLE))
      comment: "Average yield gate criteria percentage - quality threshold for flow progression"
    - name: "avg_min_temperature_c"
      expr: AVG(CAST(min_temperature_c AS DOUBLE))
      comment: "Average minimum test temperature in Celsius - test condition range"
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum test temperature in Celsius - test condition range"
$$;