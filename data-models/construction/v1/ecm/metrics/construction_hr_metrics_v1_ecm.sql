-- Metric views for domain: hr | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_employee_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount and tenure metrics for workforce planning"
  source: "`construction_ecm`.`hr`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g., Active, Terminated)"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records (headcount)"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_payroll_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost analysis by payroll group and period"
  source: "`construction_ecm`.`hr`.`payroll_record`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary paid in the period"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_leave_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request volume and utilization"
  source: "`construction_ecm`.`hr`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (e.g., Vacation, Sick)"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Number of leave requests submitted"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_recruitment_funnel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel metrics to monitor hiring efficiency"
  source: "`construction_ecm`.`hr`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of job applications received"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_performance_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review outcomes and competency scores"
  source: "`construction_ecm`.`hr`.`performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall rating assigned in the review"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews completed"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training enrollment and completion effectiveness"
  source: "`construction_ecm`.`hr`.`training_enrollment`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., Safety, Technical)"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of training enrollments"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`hr_benefit_cost_share`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit enrollment cost sharing analysis"
  source: "`construction_ecm`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan"
  measures:
    - name: "total_employee_contribution"
      expr: SUM(CAST(elected_contribution_amount AS DOUBLE))
      comment: "Total employee elected contributions"
$$;