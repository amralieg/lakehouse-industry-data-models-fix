-- Metric views for domain: workforce | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_applicant_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key applicant pipeline metrics to monitor recruitment efficiency and conversion."
  source: "`consumer_goods_ecm`.`workforce`.`applicant`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "department_applied"
      expr: department_applied
      comment: "Department the applicant applied to"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruitment source channel"
    - name: "country"
      expr: country
      comment: "Applicant country"
    - name: "state"
      expr: state
      comment: "Applicant state"
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application"
  measures:
    - name: "total_applicants"
      expr: COUNT(1)
      comment: "Total number of applicant records"
    - name: "applications_with_offer"
      expr: COUNT(offer_date)
      comment: "Number of applicants who received an offer"
    - name: "avg_time_to_hire_days"
      expr: AVG(DATEDIFF(hire_date, application_date))
      comment: "Average days between application and hire date for hired applicants"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee turnover and tenure metrics for workforce planning."
  source: "`consumer_goods_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "work_location_country"
      expr: work_location_country_code
      comment: "Country of work location"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination (if any)"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total employee records"
    - name: "total_terminations"
      expr: COUNT(termination_date)
      comment: "Number of employees who have a termination date"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average tenure in days, using termination date or current date"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_payroll_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated payroll financials for cost analysis."
  source: "`consumer_goods_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Payroll month"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center identifier"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll record"
    - name: "pay_currency"
      expr: pay_currency_code
      comment: "Currency of payroll amounts"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay amount"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll records"
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident cost and frequency metrics for risk management."
  source: "`consumer_goods_ecm`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification"
    - name: "department"
      expr: department
      comment: "Department where incident occurred"
    - name: "plant_site"
      expr: plant_site
      comment: "Plant site of incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Month of incident occurrence"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "total_indemnity_cost"
      expr: SUM(CAST(indemnity_cost AS DOUBLE))
      comment: "Total indemnity cost incurred"
    - name: "total_medical_cost"
      expr: SUM(CAST(medical_cost AS DOUBLE))
      comment: "Total medical cost incurred"
    - name: "total_incident_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Aggregate cost of all incidents"
$$;