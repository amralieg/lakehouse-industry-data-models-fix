-- Metric views for domain: workforce | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount and tenure metrics for workforce planning"
  source: "`food_beverage_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employee_status"
      expr: employee_status
      comment: "Current employment status (e.g., active, terminated)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (e.g., full-time, part-time)"
    - name: "job_code"
      expr: job_code
      comment: "Job classification code"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the employee"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
  measures:
    - name: "employee_count"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "average_tenure_days"
      expr: AVG(DATEDIFF(current_date(), hire_date))
      comment: "Average tenure in days calculated from hire date"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial payroll metrics to monitor compensation expense and overtime"
  source: "`food_beverage_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier"
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (e.g., regular, bonus)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll amounts"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the payroll period"
  measures:
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Number of payroll records processed"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount across all payroll records"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay amount after deductions"
    - name: "average_overtime_hours"
      expr: AVG(CAST(overtime_hours AS DOUBLE))
      comment: "Average overtime hours per payroll record"
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deductions_amount AS DOUBLE))
      comment: "Total benefit deductions across payroll"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning metrics for capacity and attrition analysis"
  source: "`food_beverage_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit linked to the plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (e.g., annual, seasonal)"
    - name: "headcount_plan_status"
      expr: headcount_plan_status
      comment: "Current status of the headcount plan"
  measures:
    - name: "headcount_plan_record_count"
      expr: COUNT(1)
      comment: "Number of headcount plan records"
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Sum of actual full-time equivalents"
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Sum of approved full-time equivalents"
    - name: "total_budget_fte"
      expr: SUM(CAST(budget_fte AS DOUBLE))
      comment: "Sum of budgeted full-time equivalents"
    - name: "average_attrition_rate"
      expr: AVG(CAST(attrition_rate AS DOUBLE))
      comment: "Average attrition rate across plans"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation plan performance and incentive metrics"
  source: "`food_beverage_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Compensation plan type (e.g., salary, hourly)"
    - name: "plan_category"
      expr: plan_category
      comment: "Category of the plan (e.g., executive, staff)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for compensation amounts"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the plan"
    - name: "is_global"
      expr: is_global
      comment: "Flag indicating if the plan is global"
  measures:
    - name: "compensation_plan_record_count"
      expr: COUNT(1)
      comment: "Number of compensation plans"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount across all plans"
    - name: "average_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate"
    - name: "average_incentive_rate"
      expr: AVG(CAST(incentive_rate AS DOUBLE))
      comment: "Average incentive rate"
    - name: "average_target_achievement_percent"
      expr: AVG(CAST(target_achievement_percent AS DOUBLE))
      comment: "Average target achievement percentage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting requisition metrics to track hiring demand and compensation offers"
  source: "`food_beverage_ecm`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition"
    - name: "job_family"
      expr: job_family
      comment: "Job family associated with the requisition"
    - name: "job_level"
      expr: job_level
      comment: "Job level for the position"
    - name: "location_type"
      expr: location_type
      comment: "Location type (e.g., plant, office)"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the requisition was created"
  measures:
    - name: "requisition_record_count"
      expr: COUNT(1)
      comment: "Total number of requisitions"
    - name: "average_budgeted_salary_max"
      expr: AVG(CAST(budgeted_salary_max AS DOUBLE))
      comment: "Average maximum budgeted salary for requisitions"
    - name: "average_offer_amount"
      expr: AVG(CAST(offer_amount AS DOUBLE))
      comment: "Average offer amount extended"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`workforce_talent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent review metrics to assess performance and compensation adjustments"
  source: "`food_beverage_ecm`.`workforce`.`talent_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of the talent review (e.g., completed, pending)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., annual, mid-year)"
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle identifier"
    - name: "review_start_date"
      expr: review_start_date
      comment: "Start date of the review period"
  measures:
    - name: "talent_review_record_count"
      expr: COUNT(1)
      comment: "Number of talent review records"
    - name: "average_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating"
    - name: "average_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percentage awarded"
$$;