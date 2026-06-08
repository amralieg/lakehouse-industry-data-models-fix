-- Metric views for domain: test | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance metrics for final test runs, reflecting yield, test duration and power consumption."
  source: "`semiconductors_ecm`.`test`.`final_test_run`"
  dimensions:
    - name: "test_program_id"
      expr: test_program_id
      comment: "Identifier of the test program"
    - name: "test_type"
      expr: test_type
      comment: "Type of test (e.g., functional, parametric)"
    - name: "test_location"
      expr: test_location
      comment: "Physical location where test was executed"
    - name: "test_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date of the test run"
  measures:
    - name: "total_test_runs"
      expr: COUNT(1)
      comment: "Number of final test run records"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across runs"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test execution time in seconds"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coverage KPIs that indicate test completeness and projected yield."
  source: "`semiconductors_ecm`.`test`.`coverage`"
  dimensions:
    - name: "test_program_id"
      expr: test_program_id
      comment: "Test program identifier"
    - name: "device_type"
      expr: device_type
      comment: "Device type under test"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage (e.g., functional, parametric)"
    - name: "coverage_date"
      expr: DATE_TRUNC('day', coverage_date)
      comment: "Date of the coverage measurement"
  measures:
    - name: "total_coverage_records"
      expr: COUNT(1)
      comment: "Number of coverage records"
    - name: "avg_fault_coverage_percent"
      expr: AVG(CAST(fault_coverage_percent AS DOUBLE))
      comment: "Average fault coverage percentage"
    - name: "avg_yield_estimate_percent"
      expr: AVG(CAST(yield_estimate_percent AS DOUBLE))
      comment: "Average estimated yield percentage"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric measurement quality metrics, focusing on value stability and spec compliance."
  source: "`semiconductors_ecm`.`test`.`parametric_measurement`"
  dimensions:
    - name: "test_program_id"
      expr: test_program_id
      comment: "Associated test program"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement"
    - name: "measurement_tool_version"
      expr: measurement_tool_version
      comment: "Version of the measurement tool used"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Number of parametric measurement records"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across records"
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of measurements"
    - name: "out_of_spec_count"
      expr: SUM(CASE WHEN measured_value > upper_spec_limit OR measured_value < lower_spec_limit THEN 1 ELSE 0 END)
      comment: "Count of measurements outside spec limits"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limit definition metrics to monitor specification boundaries across programs."
  source: "`semiconductors_ecm`.`test`.`limit`"
  dimensions:
    - name: "test_program_id"
      expr: test_program_id
      comment: "Test program associated with the limit"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Measurement type the limit applies to"
    - name: "limit_category"
      expr: limit_category
      comment: "Category of the limit (e.g., performance, reliability)"
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Date when the limit became effective"
  measures:
    - name: "total_limits"
      expr: COUNT(1)
      comment: "Number of limit definitions"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target limit value"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`test_reliability_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test run KPIs that track failure rates and yield impact of stress conditions."
  source: "`semiconductors_ecm`.`test`.`reliability_test_run`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test"
    - name: "stress_mode"
      expr: stress_mode
      comment: "Stress mode applied (e.g., temperature, voltage)"
    - name: "test_location"
      expr: test_location
      comment: "Location where reliability test was performed"
    - name: "test_start_date"
      expr: DATE_TRUNC('day', test_start_timestamp)
      comment: "Date the reliability test started"
  measures:
    - name: "total_reliability_runs"
      expr: COUNT(1)
      comment: "Number of reliability test run records"
    - name: "avg_failure_rate_percent"
      expr: AVG(CAST(test_failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage"
    - name: "avg_post_stress_yield_percent"
      expr: AVG(CAST(post_stress_yield_percent AS DOUBLE))
      comment: "Average yield after stress testing"
    - name: "avg_pre_stress_yield_percent"
      expr: AVG(CAST(pre_stress_yield_percent AS DOUBLE))
      comment: "Average yield before stress testing"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of reliability tests in hours"
$$;