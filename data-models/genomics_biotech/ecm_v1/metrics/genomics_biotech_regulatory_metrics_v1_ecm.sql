-- Metric views for domain: regulatory | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_adverse_event_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for adverse event reporting"
  source: "`genomics_biotech_ecm`.`regulatory`.`adverse_event_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the adverse event report"
    - name: "report_type"
      expr: report_type
      comment: "Type/category of the adverse event report"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the report"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the adverse event occurrence"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of adverse event reports"
    - name: "serious_reports"
      expr: SUM(CASE WHEN patient_impact = 'Serious' THEN 1 ELSE 0 END)
      comment: "Count of reports with serious patient impact"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, event_date))
      comment: "Average number of days from event occurrence to report closure"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval lifecycle and performance metrics"
  source: "`genomics_biotech_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway for the approval"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of jurisdiction"
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (e.g., PMA, 510k)"
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year of approval"
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of approvals"
    - name: "avg_time_to_approval_days"
      expr: AVG(DATEDIFF(approval_date, effective_date))
      comment: "Average days between effective date and approval date"
    - name: "active_approvals"
      expr: SUM(CASE WHEN approval_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of approvals currently active"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Submission pipeline performance metrics"
  source: "`genomics_biotech_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway for the submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission"
    - name: "target_jurisdiction"
      expr: target_jurisdiction
      comment: "Target jurisdiction for the submission"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of submissions"
    - name: "submissions_with_adverse_event_reporting"
      expr: SUM(CASE WHEN adverse_event_reporting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Submissions that require adverse event reporting"
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount per submission"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_post_market_surveillance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post‑market surveillance activity and timeliness"
  source: "`genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`"
  dimensions:
    - name: "pms_status"
      expr: pms_status
      comment: "Current status of the post‑market surveillance"
    - name: "product_name"
      expr: product_name
      comment: "Name of the product under surveillance"
    - name: "product_code"
      expr: product_code
      comment: "Product code"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of jurisdiction"
    - name: "report_month"
      expr: DATE_TRUNC('month', last_report_submission_date)
      comment: "Month of the last report submission"
  measures:
    - name: "total_pms"
      expr: COUNT(1)
      comment: "Total number of post‑market surveillance records"
    - name: "pms_records_with_adverse_event"
      expr: SUM(CASE WHEN adverse_event_count IS NOT NULL AND adverse_event_count <> '' THEN 1 ELSE 0 END)
      comment: "Count of PMS records that include an adverse event count"
    - name: "avg_time_to_next_report_days"
      expr: AVG(DATEDIFF(next_report_due_date, last_report_submission_date))
      comment: "Average days between last report submission and next due date"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_field_safety_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field safety action effectiveness metrics"
  source: "`genomics_biotech_ecm`.`regulatory`.`field_safety_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the field safety action"
    - name: "action_type"
      expr: action_type
      comment: "Type of field safety action"
  measures:
    - name: "total_fsa"
      expr: COUNT(1)
      comment: "Total number of field safety actions"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(closure_date, initiation_date))
      comment: "Average days from initiation to closure"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection performance metrics"
  source: "`genomics_biotech_ecm`.`regulatory`.`inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of jurisdiction"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the inspection was scheduled"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections"
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score"
    - name: "inspections_with_followup"
      expr: SUM(CASE WHEN follow_up_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections that require a follow‑up inspection"
$$;