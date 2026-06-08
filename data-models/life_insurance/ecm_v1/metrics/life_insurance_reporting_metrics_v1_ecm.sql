-- Metric views for domain: reporting | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_statutory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statutory filing performance and compliance metrics tracking submission timeliness, acceptance rates, and filing volume by jurisdiction and type"
  source: "`life_insurance_ecm`.`reporting`.`statutory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the statutory filing (submitted, accepted, rejected, pending)"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of statutory filing (annual, quarterly, special)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction where the filing is submitted"
    - name: "naic_company_code"
      expr: naic_company_code
      comment: "NAIC company code for the filing entity"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (electronic, paper, portal)"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Whether the filing is consolidated across multiple entities"
    - name: "actuarial_opinion_attached"
      expr: actuarial_opinion_attached
      comment: "Whether an actuarial opinion is attached to the filing"
    - name: "audit_opinion_attached"
      expr: audit_opinion_attached
      comment: "Whether an audit opinion is attached to the filing"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of statutory filings"
    - name: "accepted_filings"
      expr: COUNT(CASE WHEN filing_status = 'Accepted' THEN 1 END)
      comment: "Number of filings accepted by regulatory authorities"
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Number of filings rejected by regulatory authorities"
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings accepted on first submission - key compliance quality indicator"
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average number of days from submission to regulatory acceptance"
    - name: "late_filings"
      expr: COUNT(CASE WHEN submission_date > due_date THEN 1 END)
      comment: "Number of filings submitted after the due date"
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings submitted on or before due date - critical compliance metric"
    - name: "avg_days_before_deadline"
      expr: AVG(DATEDIFF(due_date, submission_date))
      comment: "Average number of days filings are submitted before deadline - operational efficiency indicator"
    - name: "amended_filings"
      expr: COUNT(CASE WHEN amendment_number IS NOT NULL THEN 1 END)
      comment: "Number of filings that are amendments to prior submissions"
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_number IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings requiring amendments - quality and accuracy indicator"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_report_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report generation performance and reliability metrics tracking execution success rates, duration, data quality, and operational efficiency"
  source: "`life_insurance_ecm`.`reporting`.`report_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the report run (completed, failed, running, cancelled)"
    - name: "report_type"
      expr: report_type
      comment: "Type of report being generated"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Reporting framework used (GAAP, IFRS17, Statutory, Management)"
    - name: "output_format"
      expr: output_format
      comment: "Format of the generated report output (PDF, Excel, CSV, XBRL)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the report run (scheduled, manual, event-driven)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the report run"
    - name: "regulatory_filing_indicator"
      expr: regulatory_filing_indicator
      comment: "Whether this report is for regulatory filing purposes"
    - name: "approval_required_indicator"
      expr: approval_required_indicator
      comment: "Whether the report requires approval before distribution"
    - name: "run_year"
      expr: YEAR(run_start_timestamp)
      comment: "Year when the report run started"
    - name: "run_month"
      expr: MONTH(run_start_timestamp)
      comment: "Month when the report run started"
  measures:
    - name: "total_report_runs"
      expr: COUNT(1)
      comment: "Total number of report execution runs"
    - name: "successful_runs"
      expr: COUNT(CASE WHEN run_status = 'Completed' THEN 1 END)
      comment: "Number of report runs that completed successfully"
    - name: "failed_runs"
      expr: COUNT(CASE WHEN run_status = 'Failed' THEN 1 END)
      comment: "Number of report runs that failed"
    - name: "success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN run_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of report runs completing successfully - key operational reliability metric"
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE) / 60.0)
      comment: "Average report generation time in minutes - performance efficiency indicator"
    - name: "total_run_duration_hours"
      expr: SUM(CAST(run_duration_seconds AS DOUBLE) / 3600.0)
      comment: "Total compute time spent on report generation in hours"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across report runs - data integrity indicator"
    - name: "runs_requiring_retry"
      expr: COUNT(CASE WHEN CAST(retry_count AS INT) > 0 THEN 1 END)
      comment: "Number of report runs that required retry attempts"
    - name: "retry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(retry_count AS INT) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs requiring retries - system stability indicator"
    - name: "avg_output_file_size_mb"
      expr: AVG(CAST(output_file_size_bytes AS DOUBLE) / 1048576.0)
      comment: "Average report output file size in megabytes"
    - name: "total_records_processed"
      expr: SUM(CAST(record_count AS BIGINT))
      comment: "Total number of records processed across all report runs"
    - name: "regulatory_filing_runs"
      expr: COUNT(CASE WHEN regulatory_filing_indicator = true THEN 1 END)
      comment: "Number of report runs for regulatory filing purposes"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_close_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial close task execution and cycle time metrics tracking completion rates, duration, escalations, and SOX compliance"
  source: "`life_insurance_ecm`.`reporting`.`close_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the close task (completed, in progress, pending, blocked)"
    - name: "task_type"
      expr: task_type
      comment: "Type of close task (reconciliation, journal entry, report generation, review)"
    - name: "task_category"
      expr: task_category
      comment: "Category grouping of the close task"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the task (high, medium, low)"
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team assigned to complete the task"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the task relates to"
    - name: "legal_entity_code"
      expr: legal_entity_code
      comment: "Legal entity code for the task scope"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether the task is part of SOX control framework"
    - name: "evidence_required_flag"
      expr: evidence_required_flag
      comment: "Whether evidence documentation is required for the task"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the task has been escalated"
    - name: "dependency_status"
      expr: dependency_status
      comment: "Status of task dependencies (met, pending, blocked)"
  measures:
    - name: "total_close_tasks"
      expr: COUNT(1)
      comment: "Total number of financial close tasks"
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'Completed' THEN 1 END)
      comment: "Number of tasks completed"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of close tasks completed - key close cycle efficiency metric"
    - name: "avg_task_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average time to complete close tasks in hours - operational efficiency indicator"
    - name: "total_task_effort_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total effort hours spent on close tasks"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration for close tasks"
    - name: "duration_variance_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE) - CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average variance between actual and estimated duration - planning accuracy indicator"
    - name: "escalated_tasks"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of tasks that required escalation"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks requiring escalation - risk and complexity indicator"
    - name: "overdue_tasks"
      expr: COUNT(CASE WHEN completion_timestamp > due_date THEN 1 END)
      comment: "Number of tasks completed after due date"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_timestamp <= due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN completion_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of tasks completed on or before due date - close cycle discipline metric"
    - name: "sox_control_tasks"
      expr: COUNT(CASE WHEN sox_control_flag = true THEN 1 END)
      comment: "Number of tasks that are SOX controls"
    - name: "tasks_with_issues"
      expr: COUNT(CASE WHEN issue_description IS NOT NULL THEN 1 END)
      comment: "Number of tasks with documented issues"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_report_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report data quality and exception management metrics tracking exception volume, severity, resolution rates, and root cause patterns"
  source: "`life_insurance_ecm`.`reporting`.`report_exception`"
  dimensions:
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, resolved, waived, escalated)"
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception identified (data quality, calculation error, threshold breach)"
    - name: "exception_category"
      expr: exception_category
      comment: "Category grouping of the exception"
    - name: "exception_severity"
      expr: exception_severity
      comment: "Severity level of the exception (critical, high, medium, low)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the exception (automated rule, manual review, reconciliation)"
    - name: "affected_line_of_business"
      expr: affected_line_of_business
      comment: "Line of business affected by the exception"
    - name: "affected_legal_entity"
      expr: affected_legal_entity
      comment: "Legal entity affected by the exception"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the exception"
    - name: "sox_reportable_flag"
      expr: sox_reportable_flag
      comment: "Whether the exception is reportable under SOX controls"
    - name: "waiver_approved_flag"
      expr: waiver_approved_flag
      comment: "Whether a waiver was approved for the exception"
    - name: "source_system"
      expr: source_system
      comment: "Source system where the exception originated"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of report exceptions identified"
    - name: "resolved_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Resolved' THEN 1 END)
      comment: "Number of exceptions that have been resolved"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions resolved - data quality management effectiveness metric"
    - name: "critical_exceptions"
      expr: COUNT(CASE WHEN exception_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity exceptions"
    - name: "critical_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_severity = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions at critical severity - risk exposure indicator"
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(resolution_timestamp, detection_timestamp))
      comment: "Average days from detection to resolution - exception management efficiency metric"
    - name: "overdue_exceptions"
      expr: COUNT(CASE WHEN resolution_due_date < CURRENT_DATE() AND exception_status != 'Resolved' THEN 1 END)
      comment: "Number of exceptions past their resolution due date"
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average monetary variance amount for exceptions"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total monetary variance across all exceptions - financial impact measure"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance for exceptions"
    - name: "waived_exceptions"
      expr: COUNT(CASE WHEN waiver_approved_flag = true THEN 1 END)
      comment: "Number of exceptions approved for waiver"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_approved_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions waived - control override frequency indicator"
    - name: "sox_reportable_exceptions"
      expr: COUNT(CASE WHEN sox_reportable_flag = true THEN 1 END)
      comment: "Number of exceptions reportable under SOX controls"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_report_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reconciliation quality and variance metrics tracking reconciliation completion, variance tolerance, and cross-framework alignment"
  source: "`life_insurance_ecm`.`reporting`.`report_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation (completed, in progress, pending review)"
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (balance sheet, income statement, cross-framework)"
    - name: "source_framework"
      expr: source_framework
      comment: "Source reporting framework (GAAP, IFRS17, Statutory)"
    - name: "target_framework"
      expr: target_framework
      comment: "Target reporting framework being reconciled to"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the reconciliation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for reconciliation amounts"
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status of the reconciliation"
    - name: "sox_scope_flag"
      expr: sox_scope_flag
      comment: "Whether the reconciliation is in scope for SOX controls"
    - name: "external_auditor_reviewed_flag"
      expr: external_auditor_reviewed_flag
      comment: "Whether external auditors have reviewed the reconciliation"
    - name: "variance_within_tolerance_flag"
      expr: variance_within_tolerance_flag
      comment: "Whether variance is within acceptable tolerance threshold"
    - name: "audit_trail_required_flag"
      expr: audit_trail_required_flag
      comment: "Whether audit trail documentation is required"
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of reconciliations performed"
    - name: "completed_reconciliations"
      expr: COUNT(CASE WHEN reconciliation_status = 'Completed' THEN 1 END)
      comment: "Number of reconciliations completed"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations completed - close process efficiency metric"
    - name: "total_source_balance"
      expr: SUM(CAST(source_balance_amount AS DOUBLE))
      comment: "Total source balance amount across reconciliations"
    - name: "total_target_balance"
      expr: SUM(CAST(target_balance_amount AS DOUBLE))
      comment: "Total target balance amount across reconciliations"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount across all reconciliations - financial accuracy indicator"
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation"
    - name: "total_reconciling_items_amount"
      expr: SUM(CAST(total_reconciling_items_amount AS DOUBLE))
      comment: "Total amount of reconciling items identified"
    - name: "reconciliations_within_tolerance"
      expr: COUNT(CASE WHEN variance_within_tolerance_flag = true THEN 1 END)
      comment: "Number of reconciliations with variance within tolerance"
    - name: "tolerance_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_within_tolerance_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations within tolerance - data quality and control effectiveness metric"
    - name: "avg_reconciling_item_count"
      expr: AVG(CAST(reconciling_item_count AS DOUBLE))
      comment: "Average number of reconciling items per reconciliation - complexity indicator"
    - name: "auditor_reviewed_reconciliations"
      expr: COUNT(CASE WHEN external_auditor_reviewed_flag = true THEN 1 END)
      comment: "Number of reconciliations reviewed by external auditors"
    - name: "sox_scope_reconciliations"
      expr: COUNT(CASE WHEN sox_scope_flag = true THEN 1 END)
      comment: "Number of reconciliations in SOX control scope"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reporting_report_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report approval workflow efficiency metrics tracking approval cycle time, rejection rates, escalations, and regulatory compliance"
  source: "`life_insurance_ecm`.`reporting`.`report_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (approved, rejected, pending, escalated)"
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken by approver (approve, reject, request changes)"
    - name: "approval_stage"
      expr: approval_stage
      comment: "Stage in the approval workflow"
    - name: "approval_method"
      expr: approval_method
      comment: "Method used for approval (electronic signature, manual, system)"
    - name: "approver_title"
      expr: approver_title
      comment: "Title of the person approving the report"
    - name: "delegated_approval_flag"
      expr: delegated_approval_flag
      comment: "Whether approval was delegated to another person"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the approval was escalated"
    - name: "regulatory_filing_flag"
      expr: regulatory_filing_flag
      comment: "Whether the report is for regulatory filing"
    - name: "sox_scope_flag"
      expr: sox_scope_flag
      comment: "Whether the approval is in SOX control scope"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for rejection"
    - name: "digital_signature_method"
      expr: digital_signature_method
      comment: "Method used for digital signature"
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of report approval requests"
    - name: "approved_reports"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of reports approved"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports approved - report quality and readiness indicator"
    - name: "rejected_reports"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of reports rejected"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports rejected - quality issue frequency metric"
    - name: "avg_approval_duration_hours"
      expr: AVG(CAST(approval_duration_hours AS DOUBLE))
      comment: "Average time from submission to approval in hours - approval workflow efficiency metric"
    - name: "total_approval_duration_hours"
      expr: SUM(CAST(approval_duration_hours AS DOUBLE))
      comment: "Total time spent in approval workflows"
    - name: "escalated_approvals"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of approvals that required escalation"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals requiring escalation - workflow bottleneck indicator"
    - name: "delegated_approvals"
      expr: COUNT(CASE WHEN delegated_approval_flag = true THEN 1 END)
      comment: "Number of approvals that were delegated"
    - name: "overdue_approvals"
      expr: COUNT(CASE WHEN approval_timestamp > approval_due_date THEN 1 END)
      comment: "Number of approvals completed after due date"
    - name: "on_time_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_timestamp <= approval_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN approval_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of approvals completed on time - workflow discipline metric"
    - name: "regulatory_filing_approvals"
      expr: COUNT(CASE WHEN regulatory_filing_flag = true THEN 1 END)
      comment: "Number of approvals for regulatory filings"
    - name: "avg_reminder_count"
      expr: AVG(CAST(reminder_count AS DOUBLE))
      comment: "Average number of reminders sent per approval - engagement indicator"
$$;