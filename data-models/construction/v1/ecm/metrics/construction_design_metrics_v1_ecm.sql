-- Metric views for domain: design | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for BIM model assets"
  source: "`construction_ecm`.`design`.`bim_model`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Discipline associated with the BIM model (e.g., structural, MEP)"
    - name: "model_status"
      expr: model_status
      comment: "Current status of the BIM model"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the model (e.g., concept, detailed, as-built)"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the BIM model record was created"
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of BIM models created"
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Aggregate file size of all BIM models in megabytes"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status overview of change notices"
  source: "`construction_ecm`.`design`.`change_notice`"
  dimensions:
    - name: "change_notice_status"
      expr: change_notice_status
      comment: "Current workflow status of the change notice"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the change notice"
    - name: "discipline"
      expr: discipline
      comment: "Discipline affected by the change"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the change notice was created"
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of change notices recorded"
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Sum of actual cost impact amounts across all change notices"
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Sum of estimated cost impact amounts across all change notices"
    - name: "cost_impact_count"
      expr: SUM(CASE WHEN cost_impact_flag THEN 1 ELSE 0 END)
      comment: "Count of change notices that have a cost impact"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and schedule impact metrics for design submittals"
  source: "`construction_ecm`.`design`.`design_submittal`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Discipline of the submittal"
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the submittal"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the submittal record was created"
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of design submittals"
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Sum of estimated cost impact from submittals"
    - name: "schedule_impact_count"
      expr: SUM(CASE WHEN schedule_impact_flag THEN 1 ELSE 0 END)
      comment: "Number of submittals that affect schedule"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall package delivery health"
  source: "`construction_ecm`.`design`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package"
    - name: "discipline"
      expr: discipline
      comment: "Discipline associated with the package"
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g., mechanical, electrical)"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the package record was created"
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of design packages"
    - name: "average_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across packages"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and quality metrics for design reviews"
  source: "`construction_ecm`.`design`.`review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
    - name: "discipline"
      expr: discipline
      comment: "Discipline of the review"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., internal, client)"
    - name: "review_date"
      expr: DATE_TRUNC('day', review_date)
      comment: "Date the review took place"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of design reviews conducted"
    - name: "average_review_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of reviews in hours"
    - name: "clash_detection_count"
      expr: SUM(CASE WHEN clash_detection_performed THEN 1 ELSE 0 END)
      comment: "Number of reviews where clash detection was performed"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFI volume and financial impact overview"
  source: "`construction_ecm`.`design`.`rfi`"
  dimensions:
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI"
    - name: "discipline"
      expr: discipline
      comment: "Discipline to which the RFI pertains"
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI"
    - name: "date_raised"
      expr: DATE_TRUNC('day', date_raised)
      comment: "Date the RFI was raised"
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs logged"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Aggregate cost impact associated with RFIs"
    - name: "response_received_count"
      expr: SUM(CASE WHEN response_content IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of RFIs that have a recorded response"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_value_engineering_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of value engineering activities"
  source: "`construction_ecm`.`design`.`value_engineering_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current approval status of the proposal"
    - name: "originator_discipline"
      expr: originator_discipline
      comment: "Discipline of the proposal originator"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the proposal"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the proposal was created"
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of value engineering proposals submitted"
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Sum of estimated cost savings across proposals"
    - name: "total_implemented_savings"
      expr: SUM(CAST(implemented_saving_value AS DOUBLE))
      comment: "Sum of actual savings realized from implemented proposals"
    - name: "approved_proposal_count"
      expr: SUM(CASE WHEN proposal_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of proposals that received approval"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_clash_detection_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance metrics from clash detection processes"
  source: "`construction_ecm`.`design`.`clash_detection_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the clash detection run"
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Discipline primarily involved in the run"
    - name: "run_date"
      expr: DATE_TRUNC('day', run_date)
      comment: "Date the clash detection run was performed"
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of clash detection runs executed"
    - name: "baseline_run_count"
      expr: SUM(CASE WHEN baseline_run_flag THEN 1 ELSE 0 END)
      comment: "Number of runs flagged as baseline runs"
    - name: "clash_free_certification_count"
      expr: SUM(CASE WHEN clash_free_certification_flag THEN 1 ELSE 0 END)
      comment: "Count of runs that achieved clash‑free certification"
$$;