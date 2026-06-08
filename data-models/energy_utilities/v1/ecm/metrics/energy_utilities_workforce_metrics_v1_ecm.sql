-- Metric views for domain: workforce | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount and compensation metrics for workforce planning"
  source: "`energy_utilities_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department the employee belongs to"
    - name: "job_classification"
      expr: job_classification
      comment: "Job classification of the employee"
    - name: "job_title"
      expr: job_title
      comment: "Job title of the employee"
    - name: "work_location"
      expr: work_location
      comment: "Work location code or name"
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the employee"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the employee was hired"
  measures:
    - name: "total_employee_count"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "active_employee_count"
      expr: COUNT(CASE WHEN active_flag = True THEN 1 END)
      comment: "Count of employees currently active"
    - name: "average_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary across employees"
    - name: "average_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across employees"
    - name: "total_annual_salary"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Sum of annual salaries for all employees"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`workforce_contractor_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and compliance metrics for contractor workforce"
  source: "`energy_utilities_ecm`.`workforce`.`contractor_worker`"
  dimensions:
    - name: "contractor_company_id"
      expr: contractor_company_id
      comment: "Identifier of the contractor company"
    - name: "primary_crew_id"
      expr: primary_crew_id
      comment: "Primary crew assignment for the contractor worker"
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location code where the contractor operates"
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification of the contractor worker"
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the contractor worker"
    - name: "worker_status"
      expr: worker_status
      comment: "Current status of the contractor worker"
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the contractor engagement started"
  measures:
    - name: "total_contractor_workers"
      expr: COUNT(1)
      comment: "Total number of contractor workers"
    - name: "average_daily_rate_usd"
      expr: AVG(CAST(daily_rate_usd AS DOUBLE))
      comment: "Average daily rate (USD) for contractor workers"
    - name: "average_hourly_rate_usd"
      expr: AVG(CAST(hourly_rate_usd AS DOUBLE))
      comment: "Average hourly rate (USD) for contractor workers"
    - name: "workers_with_nerc_cip_access"
      expr: COUNT(CASE WHEN nerc_cip_access_id IS NOT NULL THEN 1 END)
      comment: "Count of contractor workers with NERC CIP access"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`workforce_labor_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost allocation by crew, employee and cost center"
  source: "`energy_utilities_ecm`.`workforce`.`labor_cost_allocation`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "crew_id"
      expr: crew_id
      comment: "Crew identifier"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
    - name: "work_date"
      expr: work_date
      comment: "Date of the labor allocation"
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location code"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of labor activity"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the labor"
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost AS DOUBLE))
      comment: "Total labor cost allocated"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Sum of regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Sum of overtime hours worked"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident tracking and compliance metrics"
  source: "`energy_utilities_ecm`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the safety incident"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the incident"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Identifier of the power plant involved"
    - name: "location_description"
      expr: location_description
      comment: "Free‑text description of incident location"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents recorded"
    - name: "recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = True THEN 1 END)
      comment: "Count of OSHA recordable incidents"
    - name: "nerc_cip_reportable_incidents"
      expr: COUNT(CASE WHEN nerc_cip_reportable_flag = True THEN 1 END)
      comment: "Count of incidents reportable under NERC CIP"
$$;