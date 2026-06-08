-- Metric views for domain: quality | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_batch_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key batch-level quality metrics for production and rejection analysis."
  source: "`agriculture_ecm`.`quality`.`batch`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date the batch was produced"
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the facility where batch was produced"
    - name: "product_id"
      expr: product_id
      comment: "Identifier of the product"
    - name: "batch_type"
      expr: batch_type
      comment: "Type/category of the batch"
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the batch"
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Number of batch records"
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across batches"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected across batches"
    - name: "total_quantity_released"
      expr: SUM(CAST(quantity_released AS DOUBLE))
      comment: "Total quantity released across batches"
    - name: "average_quantity_produced"
      expr: AVG(CAST(quantity_produced AS DOUBLE))
      comment: "Average quantity produced per batch"
    - name: "average_quantity_rejected"
      expr: AVG(CAST(quantity_rejected AS DOUBLE))
      comment: "Average quantity rejected per batch"
    - name: "certified_batch_count"
      expr: COUNT(CASE WHEN certification_status = 'Certified' THEN 1 END)
      comment: "Count of batches with certification status 'Certified'"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_inspection_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection performance and scoring metrics."
  source: "`agriculture_ecm`.`quality`.`inspection`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where inspection took place"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Number of inspection records"
    - name: "inspections_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Inspections that required corrective action"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall inspection score"
    - name: "average_gap_module_worker_health_score"
      expr: AVG(CAST(gap_module_worker_health_score AS DOUBLE))
      comment: "Average worker health GAP module score"
    - name: "average_gap_module_soil_amendments_score"
      expr: AVG(CAST(gap_module_soil_amendments_score AS DOUBLE))
      comment: "Average soil amendments GAP module score"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_test_result_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test result compliance and measurement metrics."
  source: "`agriculture_ecm`.`quality`.`test_result`"
  dimensions:
    - name: "test_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the test result was recorded"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where test was performed"
    - name: "test_method_code"
      expr: test_method_code
      comment: "Code of the test method used"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the parameter measured"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Number of test result records"
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of tests that passed"
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of tests that failed"
    - name: "total_measured_value"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Sum of measured values across tests"
    - name: "average_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value per test"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_hold_records`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hold record metrics for inventory and risk management."
  source: "`agriculture_ecm`.`quality`.`hold_record`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for the hold"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where hold was applied"
    - name: "hold_initiated_date"
      expr: DATE_TRUNC('day', hold_initiated_timestamp)
      comment: "Date the hold was initiated"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Number of hold records"
    - name: "total_hold_cost_estimate"
      expr: SUM(CAST(hold_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of holds"
    - name: "total_quantity_held"
      expr: SUM(CAST(quantity_held AS DOUBLE))
      comment: "Total quantity held"
    - name: "average_hold_duration_hours"
      expr: AVG(CAST(hold_duration_hours AS DOUBLE))
      comment: "Average hold duration in hours"
    - name: "recall_potential_holds"
      expr: COUNT(CASE WHEN recall_potential = TRUE THEN 1 END)
      comment: "Count of holds with recall potential"
$$;