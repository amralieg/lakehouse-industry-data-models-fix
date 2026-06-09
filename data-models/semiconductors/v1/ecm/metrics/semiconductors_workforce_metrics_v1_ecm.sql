-- Metric views for domain: workforce | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_cleanroom_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cleanroom access utilization and temporary access metrics for operational safety and capacity planning"
  source: "`semiconductors_ecm`.`workforce`.`cleanroom_access`"
  dimensions:
    - name: "fab_site_id"
      expr: fab_site_id
      comment: "Fabrication site identifier"
    - name: "zone"
      expr: zone
      comment: "Cleanroom zone"
    - name: "access_level"
      expr: access_level
      comment: "Access level granted to employee"
    - name: "cleanroom_access_status"
      expr: cleanroom_access_status
      comment: "Current status of the access (e.g., Active, Revoked)"
    - name: "access_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the access record was created"
  measures:
    - name: "total_accesses"
      expr: COUNT(1)
      comment: "Total number of cleanroom access records"
    - name: "active_accesses"
      expr: COUNT(CASE WHEN cleanroom_access_status = 'Active' THEN 1 END)
      comment: "Count of currently active cleanroom accesses"
    - name: "temporary_accesses"
      expr: COUNT(CASE WHEN is_temporary = TRUE THEN 1 END)
      comment: "Count of temporary cleanroom accesses"
    - name: "avg_access_duration_days"
      expr: AVG(DATEDIFF(expiry_timestamp, grant_timestamp))
      comment: "Average duration (in days) between grant and expiry of cleanroom access"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation cost and distribution metrics to monitor labor expense and incentive effectiveness"
  source: "`semiconductors_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the employee"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for accounting"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (e.g., Salary, Equity)"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation became effective"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
  measures:
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base salary amount across all compensation records"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount paid"
    - name: "total_compensation"
      expr: SUM(base_amount + bonus_amount + variable_compensation_actual)
      comment: "Aggregate of base, bonus, and variable compensation"
    - name: "avg_compensation"
      expr: AVG(base_amount + bonus_amount + variable_compensation_actual)
      comment: "Average total compensation per record"
    - name: "current_compensation_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of compensation records marked as current"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnover and tenure metrics to assess workforce stability and retention effectiveness"
  source: "`semiconductors_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "location"
      expr: location
      comment: "Geographic location of the employee"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination (if applicable)"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "terminated_employees"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of employees who have terminated"
    - name: "avg_tenure_days"
      expr: AVG(CASE WHEN termination_date IS NOT NULL THEN DATEDIFF(termination_date, hire_date) END)
      comment: "Average tenure in days for terminated employees"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and effectiveness metrics to ensure skill development and regulatory adherence"
  source: "`semiconductors_ecm`.`workforce`.`training`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of the training (e.g., Safety, Technical)"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of delivery (e.g., Online, In-Person)"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Indicates if training is mandatory"
    - name: "location"
      expr: location
      comment: "Location where training was delivered"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
  measures:
    - name: "total_trainings"
      expr: COUNT(1)
      comment: "Total training records"
    - name: "completed_trainings"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN 1 END)
      comment: "Number of trainings completed"
    - name: "average_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across trainings"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident metrics to monitor operational risk, cost impact, and incident severity"
  source: "`semiconductors_ecm`.`workforce`.`safety_event`"
  dimensions:
    - name: "fab_site_id"
      expr: fab_site_id
      comment: "Fabrication site where incident occurred"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type/category of the safety incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., Open, Closed)"
    - name: "report_date"
      expr: report_date
      comment: "Date the incident was reported"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety events recorded"
    - name: "severe_incidents"
      expr: COUNT(CASE WHEN severity_level = 'Severe' THEN 1 END)
      comment: "Count of severe safety incidents"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Aggregate estimated cost of safety incidents"
    - name: "near_miss_count"
      expr: COUNT(CASE WHEN near_miss_flag = TRUE THEN 1 END)
      comment: "Number of near‑miss events"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor cost metrics to evaluate workforce utilization and overtime exposure"
  source: "`semiconductors_ecm`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "fab_site_id"
      expr: fab_site_id
      comment: "Fabrication site for the shift"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., Day, Night)"
    - name: "shift_schedule_status"
      expr: shift_schedule_status
      comment: "Current status of the shift schedule"
    - name: "primary_shift_employee_id"
      expr: primary_shift_employee_id
      comment: "Employee assigned as primary for the shift"
  measures:
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total shift schedule records"
    - name: "overtime_hours_total"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Aggregate overtime hours across all shifts"
    - name: "labor_cost_total"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost associated with shift schedules"
$$;