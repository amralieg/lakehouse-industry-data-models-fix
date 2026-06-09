-- Metric views for domain: engineering | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_action_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for engineering actions, measuring effort, cost, and volume."
  source: "`automotive_ecm`.`engineering`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of engineering action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the action is marked critical"
    - name: "priority"
      expr: priority
      comment: "Priority level of the action"
    - name: "assigned_engineer"
      expr: assigned_engineer_employee_id
      comment: "Engineer assigned to the action"
    - name: "action_month"
      expr: DATE_TRUNC('month', action_timestamp)
      comment: "Month of the action occurrence"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of actions"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Sum of actual effort hours spent"
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per action"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total cost estimate for actions"
    - name: "critical_action_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of critical actions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_bom_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and status overview of Bills of Materials across programs and plants."
  source: "`automotive_ecm`.`engineering`.`bom`"
  dimensions:
    - name: "plant_location"
      expr: plant_location
      comment: "Manufacturing plant location"
    - name: "program_name"
      expr: program_name
      comment: "Engineering program name"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the BOM"
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the BOM"
    - name: "vehicle_variant"
      expr: vehicle_variant
      comment: "Vehicle variant linked to the BOM"
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Number of BOM records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_project_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of engineering projects, tracking budget vs actual spend."
  source: "`automotive_ecm`.`engineering`.`project`"
  dimensions:
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Associated vehicle program"
    - name: "project_status"
      expr: status
      comment: "Current project status"
    - name: "project_type"
      expr: type
      comment: "Project type classification"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month project started"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Count of projects"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of budgeted amounts"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred"
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project"
    - name: "avg_actual_cost_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per project"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_validation_test_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance metrics for engineering validation tests."
  source: "`automotive_ecm`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of validation test"
    - name: "test_status"
      expr: test_status
      comment: "Overall status of the test"
    - name: "test_category"
      expr: test_category
      comment: "Category of the test"
    - name: "test_month"
      expr: DATE_TRUNC('month', test_timestamp)
      comment: "Month when test was executed"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of validation tests"
    - name: "passed_tests"
      expr: SUM(CASE WHEN test_status='Passed' THEN 1 ELSE 0 END)
      comment: "Number of tests that passed"
    - name: "avg_emission_co2_g_per_km"
      expr: AVG(CAST(emission_co2_g_per_km AS DOUBLE))
      comment: "Average CO2 emission measured in tests"
    - name: "avg_noise_db"
      expr: AVG(CAST(noise_db AS DOUBLE))
      comment: "Average noise level recorded in tests"
    - name: "avg_torque_nm"
      expr: AVG(CAST(torque_nm AS DOUBLE))
      comment: "Average torque measured in tests"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_ota_release_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and risk metrics for OTA software releases."
  source: "`automotive_ecm`.`engineering`.`ota_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of OTA release"
    - name: "target_market"
      expr: target_market
      comment: "Target market for the release"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the release is marked critical"
    - name: "release_status"
      expr: ota_release_status
      comment: "Current status of the OTA release"
    - name: "release_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the release effective date"
  measures:
    - name: "total_releases"
      expr: COUNT(1)
      comment: "Total OTA releases"
    - name: "total_estimated_download_mb"
      expr: SUM(CAST(estimated_download_size_mb AS DOUBLE))
      comment: "Sum of estimated download size for releases"
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity score across releases"
    - name: "successful_release_count"
      expr: SUM(CASE WHEN ota_release_status='Successful' THEN 1 ELSE 0 END)
      comment: "Count of successful OTA releases"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_weight_report_variance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight compliance and variance tracking for vehicle programs."
  source: "`automotive_ecm`.`engineering`.`weight_report`"
  dimensions:
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Vehicle program identifier"
    - name: "report_status"
      expr: report_status
      comment: "Status of the weight report"
    - name: "report_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the report"
    - name: "system_scope"
      expr: system_scope
      comment: "System scope of the weight measurement"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Number of weight reports"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Sum of actual weight measured"
    - name: "avg_weight_delta_percent"
      expr: AVG(CAST(weight_delta_percent AS DOUBLE))
      comment: "Average weight delta percentage"
    - name: "weight_compliance_count"
      expr: SUM(CASE WHEN compliance_flag='True' THEN 1 ELSE 0 END)
      comment: "Count of reports marked compliant"
$$;