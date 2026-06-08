-- Metric views for domain: laboratory | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_assay_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core assay result metrics tracking analytical quality, turnaround, and grade reporting performance for resource estimation and process control"
  source: "`mining_ecm`.`laboratory`.`assay_result`"
  dimensions:
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year when assay analysis was performed"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month when assay analysis was performed"
    - name: "analyte_code"
      expr: analyte_code
      comment: "Code identifying the element or compound analyzed"
    - name: "analyte_name"
      expr: analyte_name
      comment: "Name of the element or compound analyzed"
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "Quality assurance/quality control status of the result"
    - name: "result_status"
      expr: result_status
      comment: "Overall status of the assay result (e.g., pending, approved, rejected)"
    - name: "qaqc_sample_type"
      expr: qaqc_sample_type
      comment: "Type of QA/QC sample (blank, duplicate, standard, field sample)"
    - name: "certified_result_flag"
      expr: certified_result_flag
      comment: "Whether the result has been certified for use"
    - name: "below_detection_flag"
      expr: below_detection_flag
      comment: "Whether the result was below detection limit"
    - name: "over_limit_flag"
      expr: over_limit_flag
      comment: "Whether the result exceeded the upper measurement limit"
    - name: "grade_unit"
      expr: grade_unit
      comment: "Unit of measure for reported grade (e.g., ppm, %, g/t)"
  measures:
    - name: "total_assay_results"
      expr: COUNT(1)
      comment: "Total number of assay results reported"
    - name: "certified_result_count"
      expr: SUM(CASE WHEN certified_result_flag = True THEN 1 ELSE 0 END)
      comment: "Number of certified assay results approved for use"
    - name: "below_detection_count"
      expr: SUM(CASE WHEN below_detection_flag = True THEN 1 ELSE 0 END)
      comment: "Number of results below detection limit"
    - name: "over_limit_count"
      expr: SUM(CASE WHEN over_limit_flag = True THEN 1 ELSE 0 END)
      comment: "Number of results exceeding upper measurement limit"
    - name: "avg_reported_grade"
      expr: AVG(CAST(reported_grade AS DOUBLE))
      comment: "Average reported grade across all assay results"
    - name: "avg_accuracy_percent"
      expr: AVG(CAST(accuracy_percent AS DOUBLE))
      comment: "Average accuracy percentage of assay results"
    - name: "avg_precision_percent"
      expr: AVG(CAST(precision_percent AS DOUBLE))
      comment: "Average precision percentage of assay results"
    - name: "qaqc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qaqc_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assay results passing QA/QC checks"
    - name: "certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certified_result_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assay results that are certified"
    - name: "detection_limit_failure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN below_detection_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results below detection limit indicating method sensitivity issues"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample batch throughput and turnaround metrics tracking laboratory efficiency, SLA compliance, and QA/QC insertion rates"
  source: "`mining_ecm`.`laboratory`.`sample_batch`"
  dimensions:
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when sample batch was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when sample batch was submitted"
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the sample batch"
    - name: "batch_type"
      expr: batch_type
      comment: "Type of sample batch (e.g., exploration, grade control, metallurgical)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the batch"
    - name: "external_laboratory_flag"
      expr: external_laboratory_flag
      comment: "Whether batch was sent to external laboratory"
    - name: "qaqc_compliance_flag"
      expr: qaqc_compliance_flag
      comment: "Whether batch met QA/QC compliance requirements"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether batch met service level agreement turnaround time"
    - name: "reanalysis_flag"
      expr: reanalysis_flag
      comment: "Whether batch required reanalysis"
    - name: "mine_site_code"
      expr: mine_site_code
      comment: "Code identifying the mine site that submitted the batch"
    - name: "sample_origin_type"
      expr: sample_origin_type
      comment: "Origin type of samples in the batch"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of sample batches processed"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours from submission to completion"
    - name: "avg_qaqc_insertion_rate"
      expr: AVG(CAST(qaqc_insertion_rate_percent AS DOUBLE))
      comment: "Average QA/QC sample insertion rate as percentage of batch"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting SLA turnaround commitments"
    - name: "qaqc_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qaqc_compliance_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting QA/QC compliance standards"
    - name: "reanalysis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reanalysis_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches requiring reanalysis due to quality issues"
    - name: "external_laboratory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN external_laboratory_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches sent to external laboratories"
    - name: "total_batch_weight_kg"
      expr: SUM(CAST(batch_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of all sample batches"
    - name: "avg_batch_weight_kg"
      expr: AVG(CAST(batch_weight_kg AS DOUBLE))
      comment: "Average weight in kilograms per sample batch"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_qaqc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control result metrics tracking analytical precision, accuracy, contamination, and bias for resource estimation approval"
  source: "`mining_ecm`.`laboratory`.`qaqc_result`"
  dimensions:
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year when QA/QC analysis was performed"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month when QA/QC analysis was performed"
    - name: "analyte"
      expr: analyte
      comment: "Element or compound being quality controlled"
    - name: "control_sample_type"
      expr: control_sample_type
      comment: "Type of QA/QC control sample (blank, duplicate, standard)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the QA/QC result passed or failed acceptance criteria"
    - name: "bias_flag"
      expr: bias_flag
      comment: "Whether systematic bias was detected"
    - name: "precision_flag"
      expr: precision_flag
      comment: "Whether precision criteria were met"
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Whether contamination was detected"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on QA/QC result"
    - name: "resource_estimation_approved"
      expr: resource_estimation_approved
      comment: "Whether results are approved for use in resource estimation"
  measures:
    - name: "total_qaqc_results"
      expr: COUNT(1)
      comment: "Total number of QA/QC results evaluated"
    - name: "qaqc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QA/QC results passing acceptance criteria"
    - name: "bias_detection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bias_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QA/QC results showing systematic bias"
    - name: "precision_failure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN precision_flag = False THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QA/QC results failing precision criteria"
    - name: "contamination_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contamination_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QA/QC results showing contamination"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QA/QC results requiring corrective action"
    - name: "resource_estimation_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resource_estimation_approved = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results approved for resource estimation use"
    - name: "avg_absolute_difference"
      expr: AVG(CAST(absolute_difference AS DOUBLE))
      comment: "Average absolute difference between expected and reported values"
    - name: "avg_z_score"
      expr: AVG(CAST(z_score AS DOUBLE))
      comment: "Average z-score indicating deviation from expected value in standard deviations"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_metallurgical_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metallurgical test performance metrics tracking recovery rates, extraction efficiency, and process optimization for ore processing"
  source: "`mining_ecm`.`laboratory`.`metallurgical_test`"
  dimensions:
    - name: "test_start_year"
      expr: YEAR(test_start_date)
      comment: "Year when metallurgical test started"
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_date)
      comment: "Month when metallurgical test started"
    - name: "test_type"
      expr: test_type
      comment: "Type of metallurgical test (e.g., flotation, leach, comminution)"
    - name: "test_subtype"
      expr: test_subtype
      comment: "Subtype or specific variant of the test"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the metallurgical test"
    - name: "ore_type"
      expr: ore_type
      comment: "Type of ore being tested"
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "Quality assurance status of the test"
    - name: "flotation_reagent_type"
      expr: flotation_reagent_type
      comment: "Type of reagent used in flotation tests"
    - name: "leach_solution_type"
      expr: leach_solution_type
      comment: "Type of solution used in leach tests"
  measures:
    - name: "total_metallurgical_tests"
      expr: COUNT(1)
      comment: "Total number of metallurgical tests conducted"
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate percentage across all tests"
    - name: "avg_extraction_rate_percent"
      expr: AVG(CAST(extraction_rate_percent AS DOUBLE))
      comment: "Average extraction rate percentage for leach tests"
    - name: "avg_feed_grade_percent"
      expr: AVG(CAST(feed_grade_percent AS DOUBLE))
      comment: "Average feed grade percentage entering the test"
    - name: "avg_product_grade_percent"
      expr: AVG(CAST(product_grade_percent AS DOUBLE))
      comment: "Average product grade percentage produced by the test"
    - name: "avg_tailings_grade_percent"
      expr: AVG(CAST(tailings_grade_percent AS DOUBLE))
      comment: "Average tailings grade percentage indicating losses"
    - name: "avg_bond_work_index"
      expr: AVG(CAST(bond_work_index_kwh_per_tonne AS DOUBLE))
      comment: "Average Bond Work Index in kWh per tonne indicating ore hardness"
    - name: "avg_reagent_consumption"
      expr: AVG(CAST(reagent_consumption_g_per_tonne AS DOUBLE))
      comment: "Average reagent consumption in grams per tonne of ore"
    - name: "total_feed_mass_kg"
      expr: SUM(CAST(feed_mass_kg AS DOUBLE))
      comment: "Total feed mass in kilograms across all tests"
    - name: "total_concentrate_mass_kg"
      expr: SUM(CAST(concentrate_mass_kg AS DOUBLE))
      comment: "Total concentrate mass in kilograms produced across all tests"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample program execution metrics tracking budget performance, sample throughput, and QA/QC protocol compliance for exploration and production"
  source: "`mining_ecm`.`laboratory`.`sample_program`"
  dimensions:
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year when sample program started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when sample program started"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the sample program"
    - name: "program_type"
      expr: program_type
      comment: "Type of sample program (e.g., exploration, grade control, environmental)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard applied (e.g., JORC, NI 43-101)"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether program meets regulatory compliance requirements"
    - name: "sample_security_level"
      expr: sample_security_level
      comment: "Security level applied to sample handling"
    - name: "turnaround_priority"
      expr: turnaround_priority
      comment: "Priority level for sample turnaround"
  measures:
    - name: "total_sample_programs"
      expr: COUNT(1)
      comment: "Total number of sample programs executed"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all sample programs"
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per sample program"
    - name: "avg_qaqc_insertion_rate"
      expr: AVG(CAST(qaqc_insertion_rate_percent AS DOUBLE))
      comment: "Average QA/QC sample insertion rate across programs"
    - name: "avg_blank_insertion_rate"
      expr: AVG(CAST(blank_insertion_rate_percent AS DOUBLE))
      comment: "Average blank sample insertion rate for contamination monitoring"
    - name: "avg_duplicate_insertion_rate"
      expr: AVG(CAST(duplicate_insertion_rate_percent AS DOUBLE))
      comment: "Average duplicate sample insertion rate for precision monitoring"
    - name: "avg_standard_insertion_rate"
      expr: AVG(CAST(standard_insertion_rate_percent AS DOUBLE))
      comment: "Average standard sample insertion rate for accuracy monitoring"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs meeting regulatory compliance requirements"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory performance metrics tracking accreditation status, quality ratings, turnaround times, and cost efficiency"
  source: "`mining_ecm`.`laboratory`.`laboratory`"
  dimensions:
    - name: "laboratory_type"
      expr: laboratory_type
      comment: "Type of laboratory (e.g., internal, external, commercial)"
    - name: "laboratory_status"
      expr: laboratory_status
      comment: "Current operational status of the laboratory"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., company-owned, third-party)"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the laboratory"
    - name: "preferred_laboratory_flag"
      expr: preferred_laboratory_flag
      comment: "Whether laboratory is on preferred vendor list"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Body that issued accreditation (e.g., NATA, ISO)"
    - name: "country_code"
      expr: country_code
      comment: "Country where laboratory is located"
  measures:
    - name: "total_laboratories"
      expr: COUNT(1)
      comment: "Total number of laboratories in the network"
    - name: "preferred_laboratory_count"
      expr: SUM(CASE WHEN preferred_laboratory_flag = True THEN 1 ELSE 0 END)
      comment: "Number of laboratories on preferred vendor list"
    - name: "avg_cost_per_sample"
      expr: AVG(CAST(cost_per_sample_standard AS DOUBLE))
      comment: "Average cost per standard sample across all laboratories"
    - name: "total_cost_per_sample"
      expr: SUM(CAST(cost_per_sample_standard AS DOUBLE))
      comment: "Total cost per sample summed across laboratories for cost benchmarking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_sample_resubmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample resubmission metrics tracking QA/QC failure rates, reanalysis costs, and turnaround impact for quality improvement"
  source: "`mining_ecm`.`laboratory`.`sample_resubmission`"
  dimensions:
    - name: "resubmission_year"
      expr: YEAR(resubmission_date)
      comment: "Year when sample was resubmitted"
    - name: "resubmission_month"
      expr: DATE_TRUNC('MONTH', resubmission_date)
      comment: "Month when sample was resubmitted"
    - name: "resubmission_status"
      expr: resubmission_status
      comment: "Current status of the resubmission"
    - name: "resubmission_type"
      expr: resubmission_type
      comment: "Type of resubmission (e.g., full reanalysis, partial reanalysis)"
    - name: "qaqc_failure_type"
      expr: qaqc_failure_type
      comment: "Type of QA/QC failure that triggered resubmission"
    - name: "resubmission_reason_code"
      expr: resubmission_reason_code
      comment: "Code identifying the reason for resubmission"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the resubmission"
    - name: "result_validation_decision"
      expr: result_validation_decision
      comment: "Final validation decision after resubmission"
  measures:
    - name: "total_resubmissions"
      expr: COUNT(1)
      comment: "Total number of sample resubmissions required"
    - name: "total_resubmission_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all sample resubmissions"
    - name: "avg_resubmission_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cost per sample resubmission"
    - name: "avg_deviation_magnitude"
      expr: AVG(CAST(deviation_magnitude AS DOUBLE))
      comment: "Average magnitude of deviation that triggered resubmission"
    - name: "resubmission_rate_per_1000"
      expr: ROUND(1000.0 * COUNT(1) / NULLIF(COUNT(1), 0), 2)
      comment: "Resubmission rate normalized per 1000 samples for trend analysis"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory instrument performance metrics tracking calibration compliance, uptime, and maintenance efficiency"
  source: "`mining_ecm`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of analytical instrument"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Current calibration status"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the instrument"
    - name: "location"
      expr: location
      comment: "Physical location of the instrument"
    - name: "last_calibration_year"
      expr: YEAR(last_calibration_date)
      comment: "Year of last calibration"
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of laboratory instruments"
    - name: "total_usage_hours"
      expr: SUM(CAST(usage_hours AS DOUBLE))
      comment: "Total usage hours across all instruments"
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per instrument"
    - name: "calibration_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN calibration_status = 'Current' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments with current calibration status"
    - name: "operational_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'Operational' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments in operational status"
$$;