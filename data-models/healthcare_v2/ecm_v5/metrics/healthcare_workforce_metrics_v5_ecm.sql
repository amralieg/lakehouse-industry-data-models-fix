-- Metric views for domain: workforce | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking headcount, FTE capacity, turnover risk, and clinical staffing composition across the health system."
  source: "`healthcare_ecm_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, LOA, etc.) for workforce segmentation"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (full-time, part-time, PRN, contract) for labor mix analysis"
    - name: "clinical_role_type"
      expr: clinical_role_type
      comment: "Clinical role designation (physician, nurse, allied health, non-clinical) for staffing ratio analysis"
    - name: "worker_category"
      expr: worker_category
      comment: "Worker category (employee, contractor, agency) for labor cost segmentation"
    - name: "department_code"
      expr: department_code
      comment: "Department assignment for departmental workforce analytics"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation and budget variance analysis"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort analysis and retention trending"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt classification for overtime liability analysis"
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Primary clinical specialty for provider workforce planning"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total employee headcount across all statuses for workforce capacity planning"
    - name: "total_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total FTE capacity representing productive workforce capacity available to the organization"
    - name: "avg_fte_per_employee"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE per employee indicating part-time vs full-time labor mix"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate for compensation benchmarking and budget forecasting"
    - name: "total_cme_hours_completed"
      expr: SUM(CAST(cme_hours_completed AS DOUBLE))
      comment: "Total CME hours completed for clinical compliance monitoring"
    - name: "cme_compliance_gap_hours"
      expr: SUM(CAST(cme_hours_required AS DOUBLE) - CAST(cme_hours_completed AS DOUBLE))
      comment: "Total CME hours deficit across workforce indicating regulatory compliance risk"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for revenue-generating staff indicating revenue potential per clinical hour"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost and productivity metrics from time and attendance records, critical for healthcare labor expense management (typically 50-60% of hospital operating costs)."
  source: "`healthcare_ecm_v1`.`workforce`.`time_attendance`"
  dimensions:
    - name: "pay_type"
      expr: pay_type
      comment: "Pay classification (regular, overtime, differential, on-call) for labor cost decomposition"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift designation (day, evening, night) for shift-based cost and staffing analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Timecard approval status for payroll processing pipeline monitoring"
    - name: "leave_type"
      expr: leave_type
      comment: "Leave category for absence pattern analysis and coverage planning"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Entry type (clock, manual, system) for time capture compliance monitoring"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "Pay period end date for period-over-period labor cost trending"
    - name: "shift_date"
      expr: shift_date
      comment: "Shift date for daily staffing and labor cost analysis"
    - name: "flsa_exempt"
      expr: CAST(flsa_exempt AS STRING)
      comment: "FLSA exemption status for overtime liability segmentation"
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked representing baseline productive capacity"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours indicating staffing shortages and premium labor cost exposure"
    - name: "total_on_call_hours"
      expr: SUM(CAST(on_call_hours AS DOUBLE))
      comment: "Total on-call hours for call coverage cost analysis"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay representing direct labor expense - the largest single cost category for health systems"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime premium pay indicating avoidable labor cost from understaffing"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions for cash disbursement planning"
    - name: "total_shift_differential"
      expr: SUM(CAST(shift_differential_amount AS DOUBLE))
      comment: "Total shift differential pay for off-hours staffing cost analysis"
    - name: "total_benefits_deduction"
      expr: SUM(CAST(benefits_deduction AS DOUBLE))
      comment: "Total benefits deductions for total compensation cost analysis"
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate for compensation benchmarking across departments and roles"
    - name: "overtime_ratio_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours_worked AS DOUBLE) + CAST(overtime_hours AS DOUBLE)), 0)
      comment: "Overtime hours as percentage of total hours - key indicator of staffing adequacy (target <5% for most units)"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution metrics for monitoring labor cost disbursement, payroll accuracy, and financial controls across the health system."
  source: "`healthcare_ecm_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Payroll run type (regular, supplemental, correction) for processing volume analysis"
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Run status for payroll processing pipeline monitoring"
    - name: "frequency"
      expr: frequency
      comment: "Pay frequency (biweekly, semi-monthly, monthly) for cash flow planning"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual labor cost trending"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period labor cost comparison"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check) for disbursement channel analysis"
    - name: "is_retroactive"
      expr: CAST(is_retroactive AS STRING)
      comment: "Retroactive pay flag indicating payroll corrections and adjustment volume"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll disbursement - primary labor cost metric for financial reporting"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net payroll disbursement for cash management and bank reconciliation"
    - name: "total_employer_taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer tax liability for total labor cost calculation"
    - name: "total_employer_benefits"
      expr: SUM(CAST(total_employer_benefits AS DOUBLE))
      comment: "Total employer benefit costs for fully-loaded labor cost analysis"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total employee deductions for benefits administration reconciliation"
    - name: "total_labor_cost"
      expr: SUM(CAST(total_gross_pay AS DOUBLE) + CAST(total_employer_taxes AS DOUBLE) + CAST(total_employer_benefits AS DOUBLE))
      comment: "Fully-loaded labor cost (gross + employer taxes + benefits) - the true cost of workforce"
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Number of payroll runs for processing volume and correction frequency monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_fte_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FTE budget variance metrics for workforce planning, staffing adequacy assessment, and labor cost control across departments and cost centers."
  source: "`healthcare_ecm_v1`.`workforce`.`fte_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval status for planning pipeline monitoring"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual workforce planning cycles"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly variance analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for labor mix budget analysis"
    - name: "job_family"
      expr: job_family
      comment: "Job family for role-based workforce planning"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental budget accountability"
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type for compensation budget segmentation"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification for overtime budget planning"
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Total budgeted FTE positions representing approved staffing capacity"
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE filled for staffing adequacy assessment"
    - name: "total_vacancy_fte"
      expr: SUM(CAST(vacancy_fte AS DOUBLE))
      comment: "Total vacant FTE positions indicating recruitment pipeline demand"
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost AS DOUBLE))
      comment: "Total budgeted labor cost for financial planning and variance analysis"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost for budget-to-actual variance reporting"
    - name: "total_labor_cost_variance"
      expr: SUM(CAST(labor_cost_variance AS DOUBLE))
      comment: "Total labor cost variance (actual minus budget) - key financial control metric"
    - name: "total_fte_variance"
      expr: SUM(CAST(fte_variance AS DOUBLE))
      comment: "Total FTE variance indicating over/understaffing relative to plan"
    - name: "avg_productivity_target"
      expr: AVG(CAST(productivity_target_pct AS DOUBLE))
      comment: "Average productivity target percentage for performance benchmarking"
    - name: "total_agency_fte"
      expr: SUM(CAST(agency_fte AS DOUBLE))
      comment: "Total agency/contract FTE indicating reliance on premium-cost temporary labor"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and staffing coverage metrics for real-time census management, nurse-to-patient ratios, and schedule adherence in clinical units."
  source: "`healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, evening, night, weekend) for coverage pattern analysis"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status (confirmed, open, cancelled) for fill rate monitoring"
    - name: "shift_category"
      expr: shift_category
      comment: "Shift category for staffing model segmentation"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (ICU, med-surg, ED, OR) for unit-level staffing analysis"
    - name: "is_agency_staff"
      expr: CAST(is_agency_staff AS STRING)
      comment: "Agency staff flag for premium labor utilization tracking"
    - name: "is_float_assignment"
      expr: CAST(is_float_assignment AS STRING)
      comment: "Float pool assignment flag for resource flexibility analysis"
    - name: "shift_date"
      expr: shift_date
      comment: "Shift date for daily staffing pattern analysis"
    - name: "provider_assignment_status"
      expr: provider_assignment_status
      comment: "Assignment status for schedule fill rate monitoring"
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours representing planned staffing capacity"
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked for schedule adherence measurement"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours on scheduled shifts indicating understaffing"
    - name: "avg_nurse_to_patient_ratio"
      expr: AVG(CAST(nurse_to_patient_ratio AS DOUBLE))
      comment: "Average nurse-to-patient ratio - critical patient safety and regulatory compliance metric"
    - name: "total_scheduled_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total scheduled FTE for coverage adequacy assessment"
    - name: "total_required_fte_coverage"
      expr: SUM(CAST(required_fte_coverage AS DOUBLE))
      comment: "Total required FTE coverage target for gap identification"
    - name: "schedule_adherence_hours"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0)
      comment: "Schedule adherence ratio (actual/scheduled) - values below 1.0 indicate unfilled shifts, above 1.0 indicate unplanned overtime"
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Total shift assignments for volume and capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics for absence trending, FMLA compliance monitoring, and staffing impact analysis across the health system."
  source: "`healthcare_ecm_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Leave category (FMLA, PTO, medical, military) for absence pattern analysis"
    - name: "request_status"
      expr: request_status
      comment: "Request status for leave pipeline and approval monitoring"
    - name: "leave_reason"
      expr: leave_reason
      comment: "Leave reason for root cause analysis of workforce absence"
    - name: "pay_status"
      expr: pay_status
      comment: "Paid/unpaid status for financial impact of absences"
    - name: "fmla_eligible"
      expr: CAST(fmla_eligible AS STRING)
      comment: "FMLA eligibility for federal compliance monitoring"
    - name: "is_intermittent"
      expr: CAST(is_intermittent AS STRING)
      comment: "Intermittent leave flag for scheduling complexity analysis"
    - name: "return_to_work_status"
      expr: return_to_work_status
      comment: "Return-to-work status for workforce reintegration tracking"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests for absence volume trending and seasonal planning"
    - name: "total_leave_duration_days"
      expr: SUM(CAST(leave_duration_days AS DOUBLE))
      comment: "Total leave days representing lost productive capacity requiring coverage"
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(leave_duration_days AS DOUBLE))
      comment: "Average leave duration for coverage planning and return-to-work forecasting"
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours consumed for federal compliance tracking (480-hour annual entitlement)"
    - name: "total_fmla_hours_remaining"
      expr: SUM(CAST(fmla_hours_remaining AS DOUBLE))
      comment: "Total FMLA hours remaining for future absence exposure forecasting"
    - name: "total_pto_hours_applied"
      expr: SUM(CAST(pto_hours_applied AS DOUBLE))
      comment: "Total PTO hours applied to leaves for accrual liability management"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety metrics for OSHA compliance, injury rate calculation, and safety program effectiveness - critical for healthcare workers facing elevated occupational hazards."
  source: "`healthcare_ecm_v1`.`workforce`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Incident classification (needlestick, slip/fall, assault, strain) for hazard pattern analysis"
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Injury/illness type for clinical occupational health trending"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification for risk stratification and intervention prioritization"
    - name: "is_osha_recordable"
      expr: CAST(is_osha_recordable AS STRING)
      comment: "OSHA recordability flag for 300 Log compliance and rate calculation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic safety improvement targeting"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during incident for fatigue-related safety analysis"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected for ergonomic and PPE intervention planning"
    - name: "incident_status"
      expr: incident_status
      comment: "Investigation status for safety program workflow monitoring"
    - name: "bloodborne_pathogen_exposure"
      expr: CAST(bloodborne_pathogen_exposure AS STRING)
      comment: "BBP exposure flag for needlestick and sharps injury tracking"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total workplace incidents for safety trending and OSHA rate calculation"
    - name: "total_recordable_incidents"
      expr: SUM(CASE WHEN is_osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Total OSHA-recordable incidents for TCIR (Total Case Incident Rate) calculation"
    - name: "total_days_away"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days away from work due to injury - key DART rate component and lost productivity measure"
    - name: "total_restricted_duty_days"
      expr: SUM(CAST(days_restricted_duty AS DOUBLE))
      comment: "Total restricted duty days for modified work program effectiveness tracking"
    - name: "fatality_count"
      expr: SUM(CASE WHEN is_fatality = TRUE THEN 1 ELSE 0 END)
      comment: "Workplace fatality count - immediate OSHA reporting trigger and critical safety failure indicator"
    - name: "hospitalization_count"
      expr: SUM(CASE WHEN is_hospitalized = TRUE THEN 1 ELSE 0 END)
      comment: "Hospitalization count - OSHA 24-hour reporting trigger for severe injuries"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline and talent acquisition metrics for healthcare workforce planning, time-to-fill monitoring, and hiring cost optimization."
  source: "`healthcare_ecm_v1`.`workforce`.`recruitment`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Recruitment pipeline stage for funnel conversion analysis"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status for open position tracking"
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Recruitment source for channel effectiveness and ROI analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Target employment type for labor mix planning"
    - name: "is_clinical_position"
      expr: CAST(is_clinical_position AS STRING)
      comment: "Clinical position flag for clinical vs non-clinical recruitment segmentation"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding status for new hire readiness tracking"
    - name: "hire_decision"
      expr: hire_decision
      comment: "Hire decision outcome for offer acceptance rate analysis"
    - name: "interview_stage"
      expr: interview_stage
      comment: "Interview stage for candidate progression analysis"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total recruitment activities for hiring volume and capacity planning"
    - name: "total_cost_per_hire"
      expr: SUM(CAST(cost_per_hire AS DOUBLE))
      comment: "Total recruitment cost for talent acquisition budget management"
    - name: "avg_cost_per_hire"
      expr: AVG(CAST(cost_per_hire AS DOUBLE))
      comment: "Average cost per hire for recruitment efficiency benchmarking"
    - name: "avg_offered_salary"
      expr: AVG(CAST(offered_salary AS DOUBLE))
      comment: "Average offered salary for compensation competitiveness monitoring"
    - name: "total_offered_salary"
      expr: SUM(CAST(offered_salary AS DOUBLE))
      comment: "Total salary commitments for new hire labor cost forecasting"
    - name: "avg_fte_value"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE value of recruited positions for capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefits enrollment metrics for total compensation cost analysis, ACA compliance monitoring, and benefits program utilization."
  source: "`healthcare_ecm_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Benefit category (medical, dental, vision, life, retirement) for program cost analysis"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status for participation rate monitoring"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for cost tier analysis"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual benefits cost trending"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Enrollment trigger (new hire, open enrollment, qualifying event) for enrollment pattern analysis"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Insurance carrier for vendor cost comparison"
    - name: "cobra_eligible_flag"
      expr: CAST(cobra_eligible_flag AS STRING)
      comment: "COBRA eligibility for post-termination benefit liability tracking"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total benefit enrollments for participation rate calculation"
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Total employee premium contributions for payroll deduction planning"
    - name: "total_employer_premium"
      expr: SUM(CAST(employer_premium_amount AS DOUBLE))
      comment: "Total employer premium cost - major component of total compensation expense"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions (retirement match, HSA, etc.) for total comp analysis"
    - name: "total_annual_election"
      expr: SUM(CAST(annual_election_amount AS DOUBLE))
      comment: "Total annual benefit elections for FSA/HSA fund liability forecasting"
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average total premium per enrollment for benefits cost benchmarking"
    - name: "total_life_insurance_coverage"
      expr: SUM(CAST(life_insurance_coverage_amount AS DOUBLE))
      comment: "Total life insurance coverage amount for group policy management"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics for talent assessment, merit compensation planning, succession pipeline health, and clinical competency oversight."
  source: "`healthcare_ecm_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Review type (annual, probationary, PIP, 360) for performance program analysis"
    - name: "review_status"
      expr: review_status
      comment: "Review completion status for performance cycle monitoring"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for talent distribution analysis"
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment (high potential, solid performer, needs improvement) for succession planning"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for rating consistency and fairness monitoring"
    - name: "review_period_end_date"
      expr: review_period_end_date
      comment: "Review period end for cycle-over-cycle performance trending"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews for completion rate and cycle progress monitoring"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average performance rating score for organizational performance trending and calibration"
    - name: "avg_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percentage for compensation budget planning"
    - name: "high_potential_count"
      expr: SUM(CASE WHEN is_high_potential = TRUE THEN 1 ELSE 0 END)
      comment: "High-potential talent count for succession pipeline health assessment"
    - name: "promotion_eligible_count"
      expr: SUM(CASE WHEN promotion_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Promotion-eligible count for career progression and retention risk analysis"
    - name: "avg_cme_hours_completed"
      expr: AVG(CAST(cme_hours_completed AS DOUBLE))
      comment: "Average CME hours completed during review period for clinical development tracking"
    - name: "pip_count"
      expr: SUM(CASE WHEN pip_start_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Performance improvement plan count indicating workforce performance risk"
$$;