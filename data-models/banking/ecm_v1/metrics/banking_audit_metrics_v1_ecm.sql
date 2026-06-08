-- Metric views for domain: audit | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`audit_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit budgeting performance metrics."
  source: "`banking_ecm`.`audit`.`audit_budget`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the budget approval."
    - name: "budget_status"
      expr: budget_status
      comment: "Overall status of the budget."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts."
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year of budget approval."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Cycle type (e.g., annual, quarterly)."
  measures:
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all budgets."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure incurred."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between planned and actual."
    - name: "total_actual_hours"
      expr: SUM(CAST(total_actual_hours AS DOUBLE))
      comment: "Sum of actual hours logged."
    - name: "total_planned_hours"
      expr: SUM(CAST(total_planned_hours AS DOUBLE))
      comment: "Sum of planned hours."
    - name: "avg_cost_per_audit_day"
      expr: AVG(CAST(cost_per_audit_day AS DOUBLE))
      comment: "Average cost per audit day."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement execution and efficiency metrics."
  source: "`banking_ecm`.`audit`.`engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of audit engagement (e.g., internal, external)."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the engagement."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the engagement."
    - name: "planned_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year of the planned start date."
  measures:
    - name: "engagement_count"
      expr: COUNT(1)
      comment: "Number of audit engagements."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent on engagements."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours for engagements."
    - name: "avg_actual_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average actual engagement duration in days."
    - name: "avg_planned_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned engagement duration in days."
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finding severity and financial impact metrics."
  source: "`banking_ecm`.`audit`.`finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Category of the finding (e.g., control, operational)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., open, closed)."
    - name: "finding_year"
      expr: DATE_TRUNC('year', identified_date)
      comment: "Year the finding was identified."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total number of audit findings."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of all findings."
    - name: "high_risk_finding_count"
      expr: SUM(CASE WHEN risk_rating = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings rated as high risk."
    - name: "avg_remediation_cost"
      expr: AVG(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Average estimated remediation cost per finding."
$$;