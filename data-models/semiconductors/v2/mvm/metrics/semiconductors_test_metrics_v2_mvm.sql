-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test run performance and yield metrics for packaged semiconductor units"
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "test_location"
      expr: test_location
      comment: "Geographic location where final test was performed"
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Status of the final test run execution"
    - name: "test_type"
      expr: test_type
      comment: "Type of final test performed"
    - name: "test_shift"
      expr: test_shift
      comment: "Production shift during which test was executed"
    - name: "insertion_type"
      expr: insertion_type
      comment: "Method of device insertion into test handler"
    - name: "ate_name"
      expr: ate_name
      comment: "Automated test equipment identifier"
    - name: "handler_name"
      expr: handler_name
      comment: "Handler equipment identifier"
    - name: "test_program_version"
      expr: test_program_version
      comment: "Version of test program executed"
    - name: "test_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date of test run start"
    - name: "test_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month of test run start"
  measures:
    - name: "total_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs executed"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across final test runs - key quality indicator"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test execution time in seconds - throughput efficiency metric"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts - product performance and reliability indicator"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - environmental condition tracking"
    - name: "total_pass_count"
      expr: SUM(CAST(pass_count AS DOUBLE))
      comment: "Total count of units passing final test - production output metric"
    - name: "total_fail_count"
      expr: SUM(CAST(fail_count AS DOUBLE))
      comment: "Total count of units failing final test - quality defect tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level probe test performance and yield metrics for die-level quality assessment"
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Status of wafer probe run execution"
    - name: "run_status"
      expr: run_status
      comment: "Operational status of the probe run"
    - name: "ate_configuration"
      expr: ate_configuration
      comment: "ATE configuration used for wafer probing"
    - name: "bin_map_version"
      expr: bin_map_version
      comment: "Version of bin mapping applied during probe"
    - name: "probe_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date of probe run start"
    - name: "probe_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month of probe run start"
  measures:
    - name: "total_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average die yield percentage - critical wafer quality indicator"
    - name: "avg_contact_yield_percent"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average contact yield percentage - probe card and contact quality metric"
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage - test completeness indicator"
    - name: "total_gross_die_count"
      expr: SUM(CAST(gross_die_count AS DOUBLE))
      comment: "Total gross die count across all wafers probed - production volume metric"
    - name: "total_pass_die_count"
      expr: SUM(CAST(pass_die_count AS DOUBLE))
      comment: "Total passing die count - good die output for downstream packaging"
    - name: "total_fail_die_count"
      expr: SUM(CAST(fail_die_count AS DOUBLE))
      comment: "Total failing die count - defect and scrap tracking"
    - name: "total_probe_cost"
      expr: SUM(CAST(probe_cost AS DOUBLE))
      comment: "Total probe cost across runs - cost of test operations"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric test measurement quality and compliance metrics for device electrical characterization"
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the electrical parameter measured"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the measurement against limits"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement execution"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement performed"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system or tool that generated the measurement"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode of measurement execution"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location where measurement was taken"
    - name: "measurement_review_status"
      expr: measurement_review_status
      comment: "Review status of the measurement data"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of parametric measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of parametric measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements recorded"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all parametric tests"
    - name: "avg_measurement_average_value"
      expr: AVG(CAST(measurement_average_value AS DOUBLE))
      comment: "Average of measurement average values - central tendency metric"
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of measurements - process stability indicator"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty - measurement system quality metric"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across measurements"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across measurements"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(measurement_condition_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - environmental condition tracking"
    - name: "avg_test_voltage_mv"
      expr: AVG(CAST(measurement_condition_voltage_mv AS DOUBLE))
      comment: "Average test voltage in millivolts - test condition tracking"
    - name: "avg_test_frequency_mhz"
      expr: AVG(CAST(measurement_condition_frequency_mhz AS DOUBLE))
      comment: "Average test frequency in MHz - test condition tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual unit test result metrics for device-level quality and traceability"
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail outcome of unit test"
    - name: "test_stage"
      expr: test_stage
      comment: "Stage of testing (wafer probe, final test, etc.)"
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hardware bin code assigned to unit"
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Software bin code assigned to unit"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status - critical for die bank and packaging decisions"
    - name: "test_condition"
      expr: test_condition
      comment: "Test condition applied during unit test"
    - name: "test_date"
      expr: DATE_TRUNC('day', test_timestamp)
      comment: "Date of unit test execution"
    - name: "test_month"
      expr: DATE_TRUNC('month', test_timestamp)
      comment: "Month of unit test execution"
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of units tested - production volume metric"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average test result value across units"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds - throughput efficiency metric"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius - environmental condition tracking"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts - test condition tracking"
    - name: "distinct_device_serial_numbers"
      expr: COUNT(DISTINCT device_serial_number)
      comment: "Count of unique device serial numbers tested - traceability metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test program coverage and qualification metrics for test content management"
  source: "`vibe_semiconductors_v1`.`test`.`program`"
  dimensions:
    - name: "test_program_name"
      expr: test_program_name
      comment: "Name of the test program"
    - name: "test_program_status"
      expr: test_program_status
      comment: "Status of test program lifecycle"
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed by program"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of test program - quality gate indicator"
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE platform for which program is designed"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment in which test program executes"
    - name: "owner"
      expr: owner
      comment: "Owner responsible for test program maintenance"
    - name: "release_date"
      expr: DATE_TRUNC('day', release_date)
      comment: "Date test program was released to production"
    - name: "approval_date"
      expr: DATE_TRUNC('day', approval_date)
      comment: "Date test program was approved"
  measures:
    - name: "total_test_programs"
      expr: COUNT(1)
      comment: "Total number of test programs in inventory"
    - name: "avg_actual_coverage_percent"
      expr: AVG(CAST(actual_coverage_percent AS DOUBLE))
      comment: "Average actual test coverage percentage achieved - quality metric"
    - name: "avg_coverage_target_percent"
      expr: AVG(CAST(coverage_target_percent AS DOUBLE))
      comment: "Average target test coverage percentage - quality goal tracking"
    - name: "avg_test_limit_value"
      expr: AVG(CAST(test_limit_value AS DOUBLE))
      comment: "Average test limit value across programs"
    - name: "distinct_owners"
      expr: COUNT(DISTINCT owner)
      comment: "Count of unique test program owners - resource allocation metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe card utilization and maintenance metrics for wafer test tooling management"
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "card_name"
      expr: card_name
      comment: "Name identifier of probe card"
    - name: "probe_card_status"
      expr: probe_card_status
      comment: "Current status of probe card"
    - name: "probe_card_type"
      expr: probe_card_type
      comment: "Type of probe card technology"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of probe card - readiness indicator"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of probe card"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of probe card"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of probe card"
    - name: "last_maintenance_date"
      expr: DATE_TRUNC('day', last_maintenance_date)
      comment: "Date of last maintenance performed"
    - name: "next_maintenance_due"
      expr: DATE_TRUNC('day', next_maintenance_due)
      comment: "Date next maintenance is due"
    - name: "qualification_date"
      expr: DATE_TRUNC('day', qualification_date)
      comment: "Date probe card was qualified"
  measures:
    - name: "total_probe_cards"
      expr: COUNT(1)
      comment: "Total number of probe cards in inventory"
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per probe card - utilization metric"
    - name: "avg_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per probe card in USD - capital investment tracking"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total probe card inventory cost in USD - asset value metric"
    - name: "avg_pitch_um"
      expr: AVG(CAST(pitch_um AS DOUBLE))
      comment: "Average probe pitch in micrometers - technology capability indicator"
    - name: "avg_contact_resistance_ohm"
      expr: AVG(CAST(contact_resistance_ohm AS DOUBLE))
      comment: "Average contact resistance in ohms - probe card quality metric"
    - name: "distinct_manufacturers"
      expr: COUNT(DISTINCT manufacturer)
      comment: "Count of unique probe card manufacturers - supply chain diversity metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_bin_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bin definition and yield target metrics for test result classification management"
  source: "`vibe_semiconductors_v1`.`test`.`bin_definition`"
  dimensions:
    - name: "bin_name"
      expr: bin_name
      comment: "Name of the bin definition"
    - name: "bin_category"
      expr: bin_category
      comment: "Category classification of bin"
    - name: "bin_definition_status"
      expr: bin_definition_status
      comment: "Status of bin definition"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode associated with bin - root cause tracking"
    - name: "yield_impact_classification"
      expr: yield_impact_classification
      comment: "Classification of bin impact on yield - prioritization metric"
    - name: "test_level"
      expr: test_level
      comment: "Test level at which bin is applied"
    - name: "disposition_rule"
      expr: disposition_rule
      comment: "Disposition rule for units falling into bin"
    - name: "effective_from"
      expr: DATE_TRUNC('day', effective_from)
      comment: "Effective start date of bin definition"
    - name: "effective_until"
      expr: DATE_TRUNC('day', effective_until)
      comment: "Effective end date of bin definition"
  measures:
    - name: "total_bin_definitions"
      expr: COUNT(1)
      comment: "Total number of bin definitions configured"
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target percentage across bins - quality goal metric"
    - name: "avg_bin_limit_pct"
      expr: AVG(CAST(bin_limit_pct AS DOUBLE))
      comment: "Average bin limit percentage - defect tolerance threshold"
    - name: "distinct_failure_modes"
      expr: COUNT(DISTINCT failure_mode)
      comment: "Count of unique failure modes defined - defect taxonomy breadth"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test limit specification and compliance metrics for parametric test boundary management"
  source: "`vibe_semiconductors_v1`.`test`.`limit`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of parameter for which limit is defined"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of test limit - governance indicator"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement for which limit applies"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard governing the limit"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with limit violation - prioritization metric"
    - name: "source"
      expr: source
      comment: "Source of limit specification"
    - name: "statistical_method"
      expr: statistical_method
      comment: "Statistical method used to derive limit"
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Effective date of limit"
    - name: "expiration_date"
      expr: DATE_TRUNC('day', expiration_date)
      comment: "Expiration date of limit"
  measures:
    - name: "total_test_limits"
      expr: COUNT(1)
      comment: "Total number of test limits defined"
    - name: "avg_lower_limit"
      expr: AVG(CAST(lower_limit AS DOUBLE))
      comment: "Average lower limit value across parameters"
    - name: "avg_upper_limit"
      expr: AVG(CAST(upper_limit AS DOUBLE))
      comment: "Average upper limit value across parameters"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across parameters - design center metric"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
    - name: "avg_tolerance_percent"
      expr: AVG(CAST(tolerance_percent AS DOUBLE))
      comment: "Average tolerance percentage - process capability indicator"
    - name: "distinct_compliance_standards"
      expr: COUNT(DISTINCT compliance_standard)
      comment: "Count of unique compliance standards - regulatory complexity metric"
$$;