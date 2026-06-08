-- Metric views for domain: quality | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core defect tracking metrics for quality management, certification readiness, and release gate decisions"
  source: "`gaming_ecm`.`quality`.`defect`"
  dimensions:
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (open, in progress, resolved, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the defect"
    - name: "priority"
      expr: priority
      comment: "Priority level for defect resolution"
    - name: "defect_type"
      expr: defect_type
      comment: "Type or category of defect"
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform where the defect was discovered"
    - name: "is_certification_blocker"
      expr: is_certification_blocker
      comment: "Whether this defect blocks platform certification"
    - name: "is_regression"
      expr: is_regression
      comment: "Whether this defect is a regression from a previous build"
    - name: "discovery_phase"
      expr: discovery_phase
      comment: "Development phase when the defect was discovered"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for defect analysis"
    - name: "environment"
      expr: environment
      comment: "Environment where the defect was found (dev, staging, production)"
    - name: "reported_year"
      expr: YEAR(reported_timestamp)
      comment: "Year when the defect was reported"
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month when the defect was reported"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defects reported"
    - name: "certification_blocker_count"
      expr: SUM(CASE WHEN is_certification_blocker = TRUE THEN 1 ELSE 0 END)
      comment: "Count of defects blocking platform certification"
    - name: "regression_defect_count"
      expr: SUM(CASE WHEN is_regression = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regression defects"
    - name: "certification_blocker_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_certification_blocker = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are certification blockers"
    - name: "regression_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regression = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are regressions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_crash_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crash stability metrics for game quality, certification readiness, and player experience monitoring"
  source: "`gaming_ecm`.`quality`.`crash_report`"
  dimensions:
    - name: "crash_type"
      expr: crash_type
      comment: "Type or category of crash"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the crash"
    - name: "priority"
      expr: priority
      comment: "Priority level for crash resolution"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the crash"
    - name: "is_certification_blocker"
      expr: is_certification_blocker
      comment: "Whether this crash blocks platform certification"
    - name: "is_regression"
      expr: is_regression
      comment: "Whether this crash is a regression from a previous build"
    - name: "environment"
      expr: environment
      comment: "Environment where the crash occurred"
    - name: "os_version"
      expr: os_version
      comment: "Operating system version where crash occurred"
    - name: "device_manufacturer"
      expr: device_manufacturer
      comment: "Device manufacturer for hardware-specific crash analysis"
    - name: "crash_year"
      expr: YEAR(crash_timestamp)
      comment: "Year when the crash occurred"
    - name: "crash_month"
      expr: DATE_TRUNC('MONTH', crash_timestamp)
      comment: "Month when the crash occurred"
  measures:
    - name: "total_crash_reports"
      expr: COUNT(1)
      comment: "Total number of crash reports"
    - name: "unique_crash_signatures"
      expr: COUNT(DISTINCT crash_signature_hash)
      comment: "Count of unique crash signatures for deduplication"
    - name: "certification_blocker_crashes"
      expr: SUM(CASE WHEN is_certification_blocker = TRUE THEN 1 ELSE 0 END)
      comment: "Count of crashes blocking platform certification"
    - name: "avg_fps_at_crash"
      expr: AVG(CAST(fps_at_crash AS DOUBLE))
      comment: "Average frames per second at time of crash"
    - name: "avg_memory_usage_mb"
      expr: AVG(CAST(memory_usage_mb AS DOUBLE))
      comment: "Average memory usage in MB at time of crash"
    - name: "certification_blocker_crash_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_certification_blocker = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crashes that are certification blockers"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_release_gate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release gate approval metrics for launch readiness, compliance verification, and quality sign-off tracking"
  source: "`gaming_ecm`.`quality`.`release_gate`"
  dimensions:
    - name: "gate_status"
      expr: gate_status
      comment: "Current status of the release gate"
    - name: "gate_type"
      expr: gate_type
      comment: "Type of release gate (certification, compliance, performance)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the gate review (approved, rejected, conditional)"
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status for the release gate"
    - name: "coppa_compliance_verified"
      expr: coppa_compliance_verified
      comment: "Whether COPPA compliance has been verified"
    - name: "gdpr_compliance_verified"
      expr: gdpr_compliance_verified
      comment: "Whether GDPR compliance has been verified"
    - name: "pci_dss_compliance_verified"
      expr: pci_dss_compliance_verified
      comment: "Whether PCI DSS compliance has been verified"
    - name: "esrb_rating_confirmed"
      expr: esrb_rating_confirmed
      comment: "Whether ESRB rating has been confirmed"
    - name: "pegi_rating_confirmed"
      expr: pegi_rating_confirmed
      comment: "Whether PEGI rating has been confirmed"
    - name: "performance_benchmark_met"
      expr: performance_benchmark_met
      comment: "Whether performance benchmarks have been met"
    - name: "review_year"
      expr: YEAR(actual_review_date)
      comment: "Year of the gate review"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', actual_review_date)
      comment: "Month of the gate review"
  measures:
    - name: "total_release_gates"
      expr: COUNT(1)
      comment: "Total number of release gates"
    - name: "approved_gates"
      expr: SUM(CASE WHEN disposition = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved release gates"
    - name: "rejected_gates"
      expr: SUM(CASE WHEN disposition = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected release gates"
    - name: "avg_actual_fps"
      expr: AVG(CAST(actual_fps AS DOUBLE))
      comment: "Average actual FPS achieved at gate review"
    - name: "avg_target_fps"
      expr: AVG(CAST(target_fps AS DOUBLE))
      comment: "Average target FPS for gate review"
    - name: "avg_stability_crash_rate"
      expr: AVG(CAST(stability_crash_rate AS DOUBLE))
      comment: "Average crash rate at gate review"
    - name: "gate_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of release gates approved on review"
    - name: "coppa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coppa_compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gates with COPPA compliance verified"
    - name: "gdpr_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gates with GDPR compliance verified"
    - name: "performance_benchmark_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN performance_benchmark_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gates meeting performance benchmarks"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_test_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test execution metrics for QA efficiency, test coverage, and defect detection effectiveness"
  source: "`gaming_ecm`.`quality`.`quality_test_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the test execution (passed, failed, blocked, skipped)"
    - name: "execution_type"
      expr: execution_type
      comment: "Type of test execution (manual, automated)"
    - name: "test_category"
      expr: test_category
      comment: "Category of test being executed"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment where test was executed"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the test execution was automated"
    - name: "is_cert_blocking"
      expr: is_cert_blocking
      comment: "Whether this test is certification blocking"
    - name: "is_regression"
      expr: is_regression
      comment: "Whether this is a regression test"
    - name: "crash_occurred"
      expr: crash_occurred
      comment: "Whether a crash occurred during test execution"
    - name: "priority"
      expr: priority
      comment: "Priority level of the test"
    - name: "severity"
      expr: severity
      comment: "Severity level of test failures"
    - name: "execution_year"
      expr: YEAR(execution_timestamp)
      comment: "Year of test execution"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_timestamp)
      comment: "Month of test execution"
  measures:
    - name: "total_test_executions"
      expr: COUNT(1)
      comment: "Total number of test executions"
    - name: "passed_executions"
      expr: SUM(CASE WHEN execution_status = 'passed' THEN 1 ELSE 0 END)
      comment: "Count of passed test executions"
    - name: "failed_executions"
      expr: SUM(CASE WHEN execution_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed test executions"
    - name: "automated_executions"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automated test executions"
    - name: "crash_executions"
      expr: SUM(CASE WHEN crash_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Count of test executions where crashes occurred"
    - name: "avg_fps_observed"
      expr: AVG(CAST(fps_observed AS DOUBLE))
      comment: "Average FPS observed during test execution"
    - name: "avg_memory_usage_mb"
      expr: AVG(CAST(memory_usage_mb AS DOUBLE))
      comment: "Average memory usage in MB during test execution"
    - name: "test_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN execution_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test executions that passed"
    - name: "automation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test executions that are automated"
    - name: "crash_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN crash_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test executions that resulted in crashes"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_perf_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance test metrics for FPS, latency, resource utilization, and certification readiness benchmarking"
  source: "`gaming_ecm`.`quality`.`perf_test_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the performance test run"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the performance test"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment where performance test was executed"
    - name: "test_scenario_type"
      expr: test_scenario_type
      comment: "Type of performance test scenario"
    - name: "cert_readiness_status"
      expr: cert_readiness_status
      comment: "Certification readiness status based on performance results"
    - name: "release_gate_approved"
      expr: release_gate_approved
      comment: "Whether the performance test passed release gate criteria"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the performance test was automated"
    - name: "is_regression"
      expr: is_regression
      comment: "Whether this is a regression performance test"
    - name: "hardware_config_profile"
      expr: hardware_config_profile
      comment: "Hardware configuration profile used for testing"
    - name: "run_year"
      expr: YEAR(run_timestamp)
      comment: "Year of the performance test run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month of the performance test run"
  measures:
    - name: "total_perf_test_runs"
      expr: COUNT(1)
      comment: "Total number of performance test runs"
    - name: "avg_fps"
      expr: AVG(CAST(avg_fps AS DOUBLE))
      comment: "Average frames per second across test runs"
    - name: "avg_min_fps"
      expr: AVG(CAST(min_fps AS DOUBLE))
      comment: "Average minimum FPS across test runs"
    - name: "avg_peak_fps"
      expr: AVG(CAST(peak_fps AS DOUBLE))
      comment: "Average peak FPS across test runs"
    - name: "avg_frame_time_ms"
      expr: AVG(CAST(avg_frame_time_ms AS DOUBLE))
      comment: "Average frame time in milliseconds"
    - name: "avg_p99_frame_time_ms"
      expr: AVG(CAST(p99_frame_time_ms AS DOUBLE))
      comment: "Average 99th percentile frame time in milliseconds"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(avg_cpu_utilization_pct AS DOUBLE))
      comment: "Average CPU utilization percentage"
    - name: "avg_gpu_utilization_pct"
      expr: AVG(CAST(avg_gpu_utilization_pct AS DOUBLE))
      comment: "Average GPU utilization percentage"
    - name: "avg_memory_usage_mb"
      expr: AVG(CAST(avg_memory_usage_mb AS DOUBLE))
      comment: "Average memory usage in MB"
    - name: "avg_network_latency_ms"
      expr: AVG(CAST(avg_network_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds"
    - name: "release_gate_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN release_gate_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance tests passing release gate criteria"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_compliance_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and regulatory test metrics for certification, privacy, accessibility, and content rating verification"
  source: "`gaming_ecm`.`quality`.`compliance_test_result`"
  dimensions:
    - name: "test_result_status"
      expr: test_result_status
      comment: "Status of the compliance test result"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework being tested (COPPA, GDPR, WCAG, etc.)"
    - name: "test_category"
      expr: test_category
      comment: "Category of compliance test"
    - name: "severity"
      expr: severity
      comment: "Severity of compliance findings"
    - name: "release_gate_blocking"
      expr: release_gate_blocking
      comment: "Whether this compliance issue blocks release gate"
    - name: "retest_required"
      expr: retest_required
      comment: "Whether a retest is required"
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status for compliance test"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "automated_test_flag"
      expr: automated_test_flag
      comment: "Whether the compliance test was automated"
    - name: "region"
      expr: region
      comment: "Geographic region for compliance testing"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year of compliance test"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of compliance test"
  measures:
    - name: "total_compliance_tests"
      expr: COUNT(1)
      comment: "Total number of compliance test results"
    - name: "passed_compliance_tests"
      expr: SUM(CASE WHEN test_result_status = 'passed' THEN 1 ELSE 0 END)
      comment: "Count of passed compliance tests"
    - name: "failed_compliance_tests"
      expr: SUM(CASE WHEN test_result_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed compliance tests"
    - name: "release_blocking_issues"
      expr: SUM(CASE WHEN release_gate_blocking = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compliance issues blocking release"
    - name: "retest_required_count"
      expr: SUM(CASE WHEN retest_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compliance tests requiring retest"
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN test_result_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance tests that passed"
    - name: "release_blocking_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN release_gate_blocking = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance issues that block release"
    - name: "automation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN automated_test_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance tests that are automated"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_playtest_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playtest session metrics for user feedback, fun rating, usability, and release readiness assessment"
  source: "`gaming_ecm`.`quality`.`playtest_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the playtest session"
    - name: "session_type"
      expr: session_type
      comment: "Type of playtest session (internal, external, focus group)"
    - name: "location_type"
      expr: location_type
      comment: "Location type of playtest (on-site, remote)"
    - name: "certification_readiness_status"
      expr: certification_readiness_status
      comment: "Certification readiness status based on playtest results"
    - name: "release_readiness_flag"
      expr: release_readiness_flag
      comment: "Whether the game is deemed release-ready based on playtest"
    - name: "accessibility_evaluated"
      expr: accessibility_evaluated
      comment: "Whether accessibility was evaluated in this session"
    - name: "ftue_evaluated"
      expr: ftue_evaluated
      comment: "Whether first-time user experience was evaluated"
    - name: "performance_evaluated"
      expr: performance_evaluated
      comment: "Whether performance was evaluated"
    - name: "consent_collected"
      expr: consent_collected
      comment: "Whether participant consent was collected"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year of scheduled playtest"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled playtest"
  measures:
    - name: "total_playtest_sessions"
      expr: COUNT(1)
      comment: "Total number of playtest sessions"
    - name: "avg_fun_rating"
      expr: AVG(CAST(fun_rating AS DOUBLE))
      comment: "Average fun rating from playtest participants"
    - name: "avg_difficulty_rating"
      expr: AVG(CAST(difficulty_rating AS DOUBLE))
      comment: "Average difficulty rating from playtest participants"
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction score from playtest"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from playtest"
    - name: "avg_fps_recorded"
      expr: AVG(CAST(avg_fps_recorded AS DOUBLE))
      comment: "Average FPS recorded during playtest sessions"
    - name: "release_ready_sessions"
      expr: SUM(CASE WHEN release_readiness_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions indicating release readiness"
    - name: "release_readiness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN release_readiness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playtest sessions indicating release readiness"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`quality_test_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test cycle metrics for QA campaign effectiveness, defect density, and release gate readiness tracking"
  source: "`gaming_ecm`.`quality`.`test_cycle`"
  dimensions:
    - name: "test_cycle_status"
      expr: test_cycle_status
      comment: "Status of the test cycle"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of test cycle (regression, smoke, full)"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment where test cycle was executed"
    - name: "release_gate_status"
      expr: release_gate_status
      comment: "Release gate status for this test cycle"
    - name: "is_gold_master_candidate"
      expr: is_gold_master_candidate
      comment: "Whether this cycle is for a gold master candidate build"
    - name: "is_regression_baseline"
      expr: is_regression_baseline
      comment: "Whether this cycle establishes a regression baseline"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework being validated in this cycle"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification body for this test cycle"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned cycle start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned cycle start"
  measures:
    - name: "total_test_cycles"
      expr: COUNT(1)
      comment: "Total number of test cycles"
    - name: "avg_actual_pass_rate_pct"
      expr: AVG(CAST(actual_pass_rate_pct AS DOUBLE))
      comment: "Average actual pass rate percentage across test cycles"
    - name: "avg_pass_rate_threshold_pct"
      expr: AVG(CAST(pass_rate_threshold_pct AS DOUBLE))
      comment: "Average pass rate threshold percentage"
    - name: "gold_master_candidate_cycles"
      expr: SUM(CASE WHEN is_gold_master_candidate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of test cycles for gold master candidates"
    - name: "cycles_meeting_threshold"
      expr: SUM(CASE WHEN actual_pass_rate_pct >= pass_rate_threshold_pct THEN 1 ELSE 0 END)
      comment: "Count of test cycles meeting pass rate threshold"
    - name: "threshold_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_pass_rate_pct >= pass_rate_threshold_pct THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test cycles meeting pass rate threshold"
$$;