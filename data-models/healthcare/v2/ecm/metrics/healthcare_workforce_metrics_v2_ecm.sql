-- Metric views for domain: workforce | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount, FTE, labor rate, and compliance KPIs derived from the employee master. Used by HR leadership and CHRO for staffing, cost, and credential-risk steering."
  source: "`vibe_healthcare_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active/terminated/on-leave status used to segment headcount and turnover analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time/part-time/per-diem/contract category for workforce mix decisions."
    - name: "worker_category"
      expr: worker_category
      comment: "Employee vs agency/contractor classification for contingent-labor spend management."
    - name: "clinical_role_type"
      expr: clinical_role_type
      comment: "Clinical vs non-clinical role grouping for care-delivery staffing analysis."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "Exempt/non-exempt classification for overtime exposure and compliance."
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Provider specialty for clinical workforce capacity planning."
    - name: "department_code"
      expr: department_code
      comment: "Department for cost-center level staffing analysis."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure and cohort analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for turnover trending."
  measures:
    - name: "headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employee count — core headcount KPI for staffing decisions."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Active workforce headcount used to size operational capacity."
    - name: "terminated_count"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Employees who terminated — numerator for turnover-rate analysis."
    - name: "total_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total budgeted FTE capacity across the workforce."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average hourly/base pay rate for labor-cost benchmarking."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for contingent/agency staff margin analysis."
    - name: "rehire_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible = TRUE THEN employee_id END)
      comment: "Rehire-eligible terminated staff representing a re-recruitment pipeline."
    - name: "oig_exclusion_unchecked_count"
      expr: COUNT(DISTINCT CASE WHEN oig_exclusion_checked = FALSE THEN employee_id END)
      comment: "Employees without OIG exclusion screening — compliance risk requiring remediation."
    - name: "osha_training_lapsed_count"
      expr: COUNT(DISTINCT CASE WHEN osha_training_current = FALSE THEN employee_id END)
      comment: "Staff with lapsed OSHA training — safety/regulatory compliance gap."
    - name: "avg_cme_completion_gap"
      expr: AVG(CAST(cme_hours_required AS DOUBLE) - CAST(cme_hours_completed AS DOUBLE))
      comment: "Average outstanding CME hours per provider — credentialing-readiness signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours, pay, and overtime KPIs for productivity, labor-cost, and FLSA-compliance steering."
  source: "`vibe_healthcare_v1`.`workforce`.`time_attendance`"
  dimensions:
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (regular/overtime/on-call) for labor mix analysis."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Worked vs leave entry classification for productive-hours analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval state for payroll-integrity monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift (day/night/weekend) for differential and staffing analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of worked shift for labor-cost trending."
    - name: "flsa_exempt_flag"
      expr: flsa_exempt
      comment: "FLSA exempt indicator for overtime-eligibility segmentation."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total productive regular hours — base for productivity and labor-cost analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — key driver of premium labor cost and burnout risk."
    - name: "total_on_call_hours"
      expr: SUM(CAST(on_call_hours AS DOUBLE))
      comment: "On-call hours for coverage-cost analysis."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross labor pay — primary labor-spend KPI."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime premium pay for cost-containment targeting."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate for benchmarking."
    - name: "flsa_noncompliant_count"
      expr: COUNT(DISTINCT CASE WHEN flsa_compliance_flag = FALSE THEN time_attendance_id END)
      comment: "Time entries flagged as FLSA non-compliant — wage-and-hour risk."
    - name: "missed_punch_records"
      expr: COUNT(DISTINCT CASE WHEN timekeeper_corrected = TRUE THEN time_attendance_id END)
      comment: "Records requiring timekeeper correction — data-integrity and audit signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_fte_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FTE budget vs actual and labor-cost variance KPIs for finance/operations productivity steering."
  source: "`vibe_healthcare_v1`.`workforce`.`fte_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval state for planning-cycle tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for budget-period comparison."
    - name: "job_family"
      expr: job_family
      comment: "Job family for labor-cost segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for permanent vs contingent labor planning."
    - name: "is_union_position"
      expr: is_union_position
      comment: "Union flag for labor-relations cost analysis."
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Total budgeted FTE — planned staffing capacity."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE — realized staffing for variance analysis."
    - name: "total_vacancy_fte"
      expr: SUM(CAST(vacancy_fte AS DOUBLE))
      comment: "Vacant FTE — open-position pipeline driving recruitment priorities."
    - name: "total_agency_fte"
      expr: SUM(CAST(agency_fte AS DOUBLE))
      comment: "Agency FTE reliance — premium-labor and continuity risk indicator."
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost AS DOUBLE))
      comment: "Planned labor cost — finance budget baseline."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Realized labor cost — primary spend KPI."
    - name: "total_labor_cost_variance"
      expr: SUM(CAST(labor_cost_variance AS DOUBLE))
      comment: "Labor-cost variance — surfaces over/under-budget units for intervention."
    - name: "avg_productivity_target_pct"
      expr: AVG(CAST(productivity_target_pct AS DOUBLE))
      comment: "Average productivity target for benchmarking staffing efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent-acquisition funnel, time-to-fill, and cost-per-hire KPIs for recruiting effectiveness steering."
  source: "`vibe_healthcare_v1`.`workforce`.`recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Open/filled/closed requisition state for pipeline health."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Candidate funnel stage for conversion analysis."
    - name: "hire_decision"
      expr: hire_decision
      comment: "Final hiring decision for funnel-yield analysis."
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Recruiting source/channel for spend-effectiveness analysis."
    - name: "is_clinical_position"
      expr: is_clinical_position
      comment: "Clinical vs non-clinical hiring for critical-role prioritization."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for hiring-velocity trending."
  measures:
    - name: "requisition_count"
      expr: COUNT(DISTINCT requisition_number)
      comment: "Distinct requisitions — open demand volume."
    - name: "hires_count"
      expr: COUNT(DISTINCT CASE WHEN hire_date IS NOT NULL THEN recruitment_id END)
      comment: "Completed hires — primary recruiting output KPI."
    - name: "offers_accepted_count"
      expr: COUNT(DISTINCT CASE WHEN offer_status = 'Accepted' THEN recruitment_id END)
      comment: "Accepted offers — offer-acceptance yield numerator."
    - name: "avg_cost_per_hire"
      expr: AVG(CAST(cost_per_hire AS DOUBLE))
      comment: "Average cost per hire — recruiting efficiency benchmark."
    - name: "avg_offered_salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average offered salary for compensation-competitiveness analysis."
    - name: "background_check_pending_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Pending' THEN recruitment_id END)
      comment: "Pending background checks — onboarding bottleneck and compliance signal."
    - name: "onboarding_incomplete_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status <> 'Complete' THEN recruitment_id END)
      comment: "Incomplete onboarding — time-to-productivity risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave and FMLA KPIs for absence-management, coverage-planning, and compliance steering."
  source: "`vibe_healthcare_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA/PTO/disability) for absence-mix analysis."
    - name: "request_status"
      expr: request_status
      comment: "Approval status for leave-pipeline monitoring."
    - name: "pay_status"
      expr: pay_status
      comment: "Paid/unpaid status for cost-of-absence analysis."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible
      comment: "FMLA eligibility for entitlement-compliance segmentation."
    - name: "requested_start_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Requested start month for absence-trend planning."
  measures:
    - name: "leave_request_count"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total leave requests — absence-demand volume."
    - name: "approved_leave_count"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'Approved' THEN leave_request_id END)
      comment: "Approved leaves — coverage-impact driver."
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(leave_duration_days AS DOUBLE))
      comment: "Average leave length for staffing-backfill planning."
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "FMLA hours consumed — entitlement utilization and compliance tracking."
    - name: "intermittent_leave_count"
      expr: COUNT(DISTINCT CASE WHEN is_intermittent = TRUE THEN leave_request_id END)
      comment: "Intermittent leaves — scheduling-complexity indicator."
    - name: "cert_overdue_count"
      expr: COUNT(DISTINCT CASE WHEN medical_certification_required = TRUE AND medical_certification_received_date IS NULL THEN leave_request_id END)
      comment: "Missing required medical certifications — FMLA-compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace-safety incident KPIs for OSHA recordability, severity, and corrective-action steering."
  source: "`vibe_healthcare_v1`.`workforce`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Incident category for safety-trend analysis."
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Injury/illness nature for prevention targeting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity for risk-prioritization."
    - name: "incident_status"
      expr: incident_status
      comment: "Investigation/closure status for case-management tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root-cause grouping for systemic-prevention action."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Month of incident for safety-trend monitoring."
  measures:
    - name: "incident_count"
      expr: COUNT(DISTINCT osha_incident_id)
      comment: "Total safety incidents — base safety-volume KPI."
    - name: "recordable_count"
      expr: COUNT(DISTINCT CASE WHEN is_osha_recordable = TRUE THEN osha_incident_id END)
      comment: "OSHA-recordable incidents — regulatory recordkeeping and TRIR numerator."
    - name: "lost_time_count"
      expr: COUNT(DISTINCT CASE WHEN is_work_related = TRUE AND severity_level = 'Lost Time' THEN osha_incident_id END)
      comment: "Lost-time incidents — severity and productivity-impact KPI."
    - name: "bloodborne_exposure_count"
      expr: COUNT(DISTINCT CASE WHEN bloodborne_pathogen_exposure = TRUE THEN osha_incident_id END)
      comment: "Bloodborne pathogen exposures — high-priority healthcare safety risk."
    - name: "fatality_count"
      expr: COUNT(DISTINCT CASE WHEN is_fatality = TRUE THEN osha_incident_id END)
      comment: "Fatalities — critical safety outcome requiring executive escalation."
    - name: "corrective_action_open_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_completed_date IS NULL THEN osha_incident_id END)
      comment: "Incidents with open corrective actions — remediation backlog."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance, talent, and retention-risk KPIs for talent-management steering."
  source: "`vibe_healthcare_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Completion status for review-cycle compliance."
    - name: "review_type"
      expr: review_type
      comment: "Annual/probationary review type for cycle analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall rating band for performance-distribution analysis."
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment for succession and retention prioritization."
    - name: "review_period_end_month"
      expr: DATE_TRUNC('MONTH', review_period_end_date)
      comment: "Review-period end month for cycle trending."
  measures:
    - name: "review_count"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total reviews — performance-cycle volume."
    - name: "completed_review_count"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Completed reviews — cycle-completion compliance KPI."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average performance score for workforce-quality trending."
    - name: "high_potential_count"
      expr: COUNT(DISTINCT CASE WHEN is_high_potential = TRUE THEN performance_review_id END)
      comment: "High-potential employees — succession-pipeline strength."
    - name: "pip_count"
      expr: COUNT(DISTINCT CASE WHEN pip_start_date IS NOT NULL THEN performance_review_id END)
      comment: "Employees on performance-improvement plans — managed-performance risk."
    - name: "promotion_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_eligible = TRUE THEN performance_review_id END)
      comment: "Promotion-eligible employees — talent-mobility pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staffing-coverage, agency-reliance, and nurse-ratio KPIs for clinical operations steering."
  source: "`vibe_healthcare_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule publication/coverage status for staffing-readiness."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment fill state for gap analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift category for coverage-pattern analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for unit-level staffing analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift for staffing-trend monitoring."
  measures:
    - name: "scheduled_shift_count"
      expr: COUNT(DISTINCT shift_schedule_id)
      comment: "Total scheduled shifts — coverage-volume base KPI."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours — planned coverage capacity."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Actual hours worked — realized coverage for variance analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Schedule overtime hours — premium-labor and burnout indicator."
    - name: "agency_shift_count"
      expr: COUNT(DISTINCT CASE WHEN is_agency_staff = TRUE THEN shift_schedule_id END)
      comment: "Agency-staffed shifts — contingent-labor reliance KPI."
    - name: "float_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN is_float_assignment = TRUE THEN shift_schedule_id END)
      comment: "Float assignments — staffing-flexibility and continuity indicator."
    - name: "avg_nurse_to_patient_ratio"
      expr: AVG(CAST(nurse_to_patient_ratio AS DOUBLE))
      comment: "Average nurse-to-patient ratio — care-quality and safety staffing KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation, premium cost, and ACA-compliance KPIs for total-rewards steering."
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Benefit category (medical/dental/retirement) for participation analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment state for active-coverage tracking."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (single/family) for cost-mix analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for open-enrollment-period comparison."
    - name: "aca_mec_flag"
      expr: aca_minimum_essential_coverage_flag
      comment: "ACA minimum-essential-coverage flag for employer-mandate compliance."
  measures:
    - name: "enrollment_count"
      expr: COUNT(DISTINCT benefit_enrollment_id)
      comment: "Total enrollments — benefits participation volume."
    - name: "enrolled_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct enrolled employees — participation reach KPI."
    - name: "total_employer_premium"
      expr: SUM(CAST(employer_premium_amount AS DOUBLE))
      comment: "Total employer premium cost — primary benefits-spend KPI."
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Total employee premium contribution for cost-share analysis."
    - name: "avg_annual_election"
      expr: AVG(CAST(annual_election_amount AS DOUBLE))
      comment: "Average annual election amount for plan-utilization analysis."
    - name: "cobra_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN cobra_eligible_flag = TRUE THEN benefit_enrollment_id END)
      comment: "COBRA-eligible enrollments — continuation-coverage compliance signal."
    - name: "aca_noncompliant_count"
      expr: COUNT(DISTINCT CASE WHEN aca_minimum_value_flag = FALSE THEN benefit_enrollment_id END)
      comment: "Enrollments failing ACA minimum-value test — employer-mandate penalty risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll spend and processing KPIs for finance and payroll-operations steering."
  source: "`vibe_healthcare_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Run status for payroll-cycle completion tracking."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Regular/off-cycle run type for processing analysis."
    - name: "payroll_frequency"
      expr: payroll_frequency
      comment: "Pay frequency for cadence analysis."
    - name: "check_month"
      expr: DATE_TRUNC('MONTH', check_date)
      comment: "Pay-check month for payroll-spend trending."
  measures:
    - name: "payroll_run_count"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total payroll runs — processing-volume base KPI."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_total AS DOUBLE))
      comment: "Total gross payroll — primary labor-spend KPI."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_total AS DOUBLE))
      comment: "Total net payroll disbursed for cash-flow planning."
    - name: "total_tax_deductions"
      expr: SUM(CAST(tax_deductions_total AS DOUBLE))
      comment: "Total tax withholdings for remittance and compliance analysis."
    - name: "avg_employees_per_run"
      expr: AVG(CAST(employee_count AS DOUBLE))
      comment: "Average employees paid per run for payroll-scale tracking."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`workforce_benefit_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of employee benefit enrollments"
  source: "`vibe_healthcare_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (e.g., health, dental, vision)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Benefit carrier name"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the enrollment"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the benefit became effective"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee associated with the enrollment"
  measures:
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Sum of employee premium contributions across all enrollments"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Sum of employer contributions across all enrollments"
    - name: "total_premium"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount (employee + employer)"
    - name: "average_premium_per_enrollment"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium per benefit enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollments"
$$;