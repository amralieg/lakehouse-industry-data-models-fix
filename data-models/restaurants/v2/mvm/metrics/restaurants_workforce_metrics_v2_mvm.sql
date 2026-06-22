-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift-level KPIs covering labor cost, hours variance, overtime exposure, and scheduling efficiency. Primary steering dashboard for restaurant labor operations."
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  filter: is_deleted = False
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the shift, used for daily and weekly trend analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period or daypart (e.g., breakfast, lunch, dinner) for intra-day labor analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Classification of the shift (e.g., regular, on-call, split) for workforce mix analysis."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (e.g., completed, no-show, cancelled) for attendance tracking."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift incurred overtime, enabling overtime exposure segmentation."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Indicates whether the shift was an on-call assignment for on-call utilization analysis."
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts. Core cost driver for restaurant P&L and labor budget adherence."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all shifts. Baseline for productivity and labor efficiency analysis."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours originally scheduled. Used to compute schedule adherence and variance."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(scheduled_hours AS DOUBLE)))
      comment: "Difference between actual and scheduled hours. Positive values indicate over-staffing or overtime; negative values indicate under-staffing."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift record. Benchmarks cost efficiency across dayparts, positions, and units."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of sales for shifts where this is captured. Key profitability ratio monitored by operations leadership."
    - name: "total_overtime_shifts"
      expr: COUNT(CASE WHEN overtime_flag = True THEN shift_id END)
      comment: "Count of shifts that incurred overtime. Elevated counts signal scheduling inefficiency or understaffing and drive corrective action."
    - name: "overtime_shift_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = True THEN shift_id END) / NULLIF(COUNT(shift_id), 0), 2)
      comment: "Percentage of shifts with overtime. A rising rate triggers scheduling review and potential headcount adjustment."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per shift in minutes. Compliance with labor law break requirements is a regulatory and HR risk metric."
    - name: "total_shifts"
      expr: COUNT(shift_id)
      comment: "Total number of shift records. Baseline volume metric for normalizing other shift KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financial KPIs covering gross pay, net pay, tax burden, overtime costs, tips, and bonus distribution. Used by Finance and HR leadership for payroll cost governance and compensation benchmarking."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was disbursed, enabling period-over-period payroll trend analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Fiscal tax year for annual payroll cost reporting and regulatory compliance."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Internal fiscal period label for aligning payroll costs to financial reporting cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payroll was processed, required for multi-currency operations."
    - name: "employee_type"
      expr: employee_type
      comment: "Employment classification (e.g., full-time, part-time, contractor) for workforce cost segmentation."
    - name: "job_title"
      expr: job_title
      comment: "Job title at time of payroll processing for role-level compensation benchmarking."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates union membership, enabling union vs. non-union payroll cost comparison."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Flags payroll records that include a bonus component for bonus distribution analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost. Primary payroll expense line item for budget vs. actuals reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees after deductions. Cash flow impact metric for treasury management."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total taxes withheld across all payroll records. Regulatory compliance and tax liability metric."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions from payroll. Tracks total benefits cost burden on the workforce."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments disbursed. Tracks incentive compensation spend and its distribution across the workforce."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts processed through payroll. Relevant for tipped employee compliance and total compensation analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid across all payroll records. Elevated totals signal scheduling inefficiency and excess labor cost."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours paid. Baseline for workforce capacity and cost-per-hour analysis."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels across employee types and job titles."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of sales as captured in payroll records. Key operational efficiency ratio for restaurant management."
    - name: "avg_overtime_rate"
      expr: AVG(CAST(overtime_rate AS DOUBLE))
      comment: "Average overtime pay rate across payroll records. Monitors premium pay exposure and informs scheduling policy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce composition and headcount KPIs covering employment status, tenure, compensation benchmarks, and workforce mix. Used by HR and Operations leadership for headcount planning and retention strategy."
  source: "`vibe_restaurants_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g., active, terminated, on-leave) for headcount segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g., full-time, part-time, seasonal) for workforce mix analysis."
    - name: "department"
      expr: department
      comment: "Organizational department for departmental headcount and cost allocation."
    - name: "role_classification"
      expr: role_classification
      comment: "Role classification (e.g., hourly, salaried, management) for compensation tier analysis."
    - name: "work_schedule_type"
      expr: work_schedule_type
      comment: "Work schedule type (e.g., fixed, flexible, rotating) for scheduling pattern analysis."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Assigned shift pattern for workforce scheduling coverage analysis."
    - name: "union_member"
      expr: union_member
      comment: "Union membership flag for union vs. non-union workforce composition reporting."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the employee is eligible for overtime pay, relevant for labor cost risk assessment."
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "Indicates whether the employee holds a current ServSafe certification, a food safety compliance requirement."
    - name: "hire_date"
      expr: hire_date
      comment: "Employee hire date for tenure cohort analysis and retention tracking."
  measures:
    - name: "total_active_employees"
      expr: COUNT(CASE WHEN employment_status = 'active' THEN employee_id END)
      comment: "Count of currently active employees. Core headcount metric for capacity planning and labor budget."
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count including all statuses. Baseline for workforce size reporting."
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total annualized salary cost across the workforce. Primary input for compensation budget planning."
    - name: "avg_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary amount across employees. Benchmarks compensation competitiveness and equity."
    - name: "avg_pay_grade"
      expr: AVG(CAST(pay_grade AS DOUBLE))
      comment: "Average pay grade across the workforce. Tracks compensation band distribution and progression."
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target set at the employee level. Used to assess alignment between individual targets and actual labor cost ratios."
    - name: "servsafe_certified_count"
      expr: COUNT(CASE WHEN servsafe_certified = True THEN employee_id END)
      comment: "Count of employees with active ServSafe certification. Food safety compliance metric required for health inspections and brand standards."
    - name: "servsafe_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN servsafe_certified = True THEN employee_id END) / NULLIF(COUNT(CASE WHEN employment_status = 'active' THEN employee_id END), 0), 2)
      comment: "Percentage of active employees who are ServSafe certified. A rate below threshold triggers compliance remediation and training investment."
    - name: "overtime_eligible_headcount"
      expr: COUNT(CASE WHEN overtime_eligible = True THEN employee_id END)
      comment: "Count of employees eligible for overtime. Quantifies overtime cost exposure in the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance KPIs covering actual hours worked, overtime, missed punches, and labor cost accuracy. Used by Operations and HR to monitor attendance compliance and labor cost integrity."
  source: "`vibe_restaurants_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the time entry for daily attendance and labor cost trend analysis."
    - name: "job_role"
      expr: job_role
      comment: "Job role at time of entry for role-level hours and cost analysis."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of the time entry (e.g., approved, pending, rejected) for payroll readiness tracking."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (e.g., regular, overtime, break) for hours classification."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the time entry includes overtime hours."
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Flags time entries with a missed clock-in or clock-out punch, indicating a data quality or attendance compliance issue."
    - name: "approved_by_manager"
      expr: approved_by_manager
      comment: "Indicates whether the time entry has been approved by a manager, required for payroll processing."
    - name: "break_flag"
      expr: break_flag
      comment: "Indicates whether the entry includes a break period for break compliance monitoring."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all time entries. Primary labor volume metric for productivity and cost analysis."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Baseline for standard labor cost calculation."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated totals signal scheduling gaps and excess labor cost exposure."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Used to reconcile time-and-attendance labor cost against payroll records."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per time entry. Benchmarks effective pay rates across roles and units."
    - name: "missed_punch_count"
      expr: COUNT(CASE WHEN missed_punch_flag = True THEN time_entry_id END)
      comment: "Count of time entries with missed punches. A leading indicator of payroll data quality issues and potential wage compliance risk."
    - name: "missed_punch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN missed_punch_flag = True THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries with missed punches. Drives corrective action on timekeeping compliance and manager accountability."
    - name: "unapproved_entry_count"
      expr: COUNT(CASE WHEN approved_by_manager = False THEN time_entry_id END)
      comment: "Count of time entries not yet approved by a manager. Unapproved entries block payroll processing and represent a payroll risk."
    - name: "overtime_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = True THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries that include overtime. Monitors overtime prevalence and informs scheduling optimization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management KPIs covering leave utilization, approval rates, coverage gaps, and payroll impact. Used by HR and Operations to manage workforce availability and leave liability."
  source: "`vibe_restaurants_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of leave requested (e.g., PTO, FMLA, sick, bereavement) for leave category analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the leave request (e.g., approved, pending, denied) for approval pipeline monitoring."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Indicates whether the leave is paid, for paid vs. unpaid leave liability analysis."
    - name: "coverage_needed_flag"
      expr: coverage_needed_flag
      comment: "Flags leave requests requiring shift coverage, indicating operational risk to staffing levels."
    - name: "backfill_assigned_flag"
      expr: backfill_assigned_flag
      comment: "Indicates whether a backfill has been assigned for the leave period, tracking coverage resolution."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Flags leave requests with a payroll impact for payroll processing prioritization."
    - name: "start_date"
      expr: start_date
      comment: "Leave start date for temporal analysis of leave demand patterns."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(leave_request_id)
      comment: "Total number of leave requests submitted. Baseline volume metric for leave demand analysis."
    - name: "total_leave_days_requested"
      expr: SUM(CAST(leave_days_requested AS DOUBLE))
      comment: "Total leave days requested across all submissions. Quantifies workforce availability risk from leave demand."
    - name: "total_leave_days_approved"
      expr: SUM(CAST(leave_days_approved AS DOUBLE))
      comment: "Total leave days approved. Tracks actual workforce absence liability and informs scheduling coverage planning."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'approved' THEN leave_request_id END) / NULLIF(COUNT(leave_request_id), 0), 2)
      comment: "Percentage of leave requests that were approved. Monitors leave policy consistency and manager approval behavior."
    - name: "coverage_gap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_needed_flag = True AND backfill_assigned_flag = False THEN leave_request_id END) / NULLIF(COUNT(CASE WHEN coverage_needed_flag = True THEN leave_request_id END), 0), 2)
      comment: "Percentage of leave requests requiring coverage where no backfill has been assigned. A high rate signals operational staffing risk and scheduling failure."
    - name: "avg_leave_days_per_request"
      expr: AVG(CAST(leave_days_approved AS DOUBLE))
      comment: "Average approved leave days per request. Benchmarks leave utilization patterns and informs leave policy design."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average remaining leave balance after approval. Monitors leave liability and identifies employees at risk of leave exhaustion."
    - name: "payroll_impacted_requests"
      expr: COUNT(CASE WHEN payroll_impact_flag = True THEN leave_request_id END)
      comment: "Count of leave requests with a payroll impact. Drives payroll processing workload and financial accrual estimates."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and compliance KPIs covering completion rates, assessment performance, certification linkage, and training effectiveness. Used by HR, Operations, and Food Safety leadership to ensure workforce compliance and skill readiness."
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of training (e.g., food safety, customer service, onboarding) for training investment analysis."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., e-learning, in-person, OJT) for delivery method effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method for comparing completion and pass rates across modalities."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Completion status of the training record (e.g., completed, in-progress, failed) for compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record for regulatory and brand standard adherence reporting."
    - name: "certification_required"
      expr: certification_required
      comment: "Indicates whether the training is linked to a required certification, for mandatory training compliance analysis."
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Indicates whether the employee passed the associated assessment, for training effectiveness measurement."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which training was completed, for scheduling and operational impact analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(training_completion_id)
      comment: "Total number of training completion records. Baseline volume metric for training activity reporting."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_status = 'completed' THEN training_completion_id END) / NULLIF(COUNT(training_completion_id), 0), 2)
      comment: "Percentage of training records with a completed status. Core compliance KPI for workforce readiness and regulatory audit defense."
    - name: "assessment_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = True THEN training_completion_id END) / NULLIF(COUNT(CASE WHEN assessment_passed IS NOT NULL THEN training_completion_id END), 0), 2)
      comment: "Percentage of assessed training completions where the employee passed. Measures training effectiveness and identifies programs requiring redesign."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions with assessments. Benchmarks knowledge retention and training quality."
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average training duration in minutes. Used to estimate training time investment and optimize program length."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_minutes AS DOUBLE)) / 60.0
      comment: "Total training hours invested across all completions. Quantifies workforce development investment for budget and ROI analysis."
    - name: "mandatory_certification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required = True AND training_completion_status = 'completed' THEN training_completion_id END) / NULLIF(COUNT(CASE WHEN certification_required = True THEN training_completion_id END), 0), 2)
      comment: "Completion rate for training records tied to mandatory certifications. A rate below 100% represents a direct regulatory compliance risk and potential health code violation exposure."
    - name: "non_compliant_training_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN training_completion_id END)
      comment: "Count of training records in a non-compliant status. Drives immediate remediation actions and is a key metric for health inspection readiness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification compliance KPIs covering active certifications, expiration risk, mandatory compliance rates, and renewal pipeline. Used by HR, Operations, and Food Safety leadership to maintain regulatory and brand standard compliance."
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ServSafe, food handler, allergen awareness) for compliance category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., active, expired, pending) for compliance pipeline monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certification record for regulatory audit and brand standard reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the role, enabling mandatory vs. optional compliance segmentation."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates whether the certification requires renewal, for renewal pipeline management."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for issuer-level compliance analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Certification expiration date for expiry risk and renewal urgency analysis."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the certification was issued for cohort and tenure analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(certification_id)
      comment: "Total number of certification records. Baseline for certification portfolio size and compliance coverage."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN certification_id END)
      comment: "Count of currently active certifications. Core compliance headcount metric for regulatory readiness."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN certification_id END)
      comment: "Count of expired certifications. Directly represents compliance risk and potential regulatory violation exposure."
    - name: "mandatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = True AND certification_status = 'active' THEN certification_id END) / NULLIF(COUNT(CASE WHEN is_mandatory = True THEN certification_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. A rate below 100% is a direct regulatory and brand standard compliance failure requiring immediate remediation."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN certification_id END)
      comment: "Count of certifications expiring within the next 30 days. Leading indicator for renewal urgency and proactive compliance management."
    - name: "renewal_pending_count"
      expr: COUNT(CASE WHEN renewal_required = True AND certification_status != 'active' THEN certification_id END)
      comment: "Count of certifications requiring renewal that are not currently active. Drives renewal outreach and training scheduling."
    - name: "non_compliant_certification_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN certification_id END)
      comment: "Count of certifications in a non-compliant status. Aggregated compliance risk metric for executive and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule planning KPIs covering FTE coverage, labor percentage targets by daypart, and scheduling efficiency. Used by Operations leadership to optimize staffing levels and labor cost allocation across dayparts."
  source: "`vibe_restaurants_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the schedule period for weekly and period-over-period scheduling trend analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the schedule period for schedule duration and coverage analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (e.g., draft, approved, published) for schedule readiness tracking."
    - name: "approved_by"
      expr: approved_by
      comment: "Manager who approved the schedule for accountability and approval pattern analysis."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedule records. Primary labor capacity metric for workforce planning."
    - name: "avg_total_fte"
      expr: AVG(CAST(fte_total AS DOUBLE))
      comment: "Average total FTE coverage per schedule. Benchmarks staffing levels against operational requirements."
    - name: "avg_morning_fte"
      expr: AVG(CAST(fte_morning AS DOUBLE))
      comment: "Average FTE coverage during the morning daypart. Used to assess breakfast/opening staffing adequacy."
    - name: "avg_midday_fte"
      expr: AVG(CAST(fte_midday AS DOUBLE))
      comment: "Average FTE coverage during the midday daypart. Used to assess lunch rush staffing adequacy."
    - name: "avg_evening_fte"
      expr: AVG(CAST(fte_evening AS DOUBLE))
      comment: "Average FTE coverage during the evening daypart. Used to assess dinner service staffing adequacy."
    - name: "avg_night_fte"
      expr: AVG(CAST(fte_night AS DOUBLE))
      comment: "Average FTE coverage during the night daypart. Used to assess late-night and closing staffing adequacy."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average scheduled labor percentage across all schedule records. Tracks whether planned labor cost ratios align with financial targets."
    - name: "avg_morning_labor_pct"
      expr: AVG(CAST(labor_pct_morning AS DOUBLE))
      comment: "Average labor cost percentage for the morning daypart. Enables daypart-level labor efficiency benchmarking."
    - name: "avg_evening_labor_pct"
      expr: AVG(CAST(labor_pct_evening AS DOUBLE))
      comment: "Average labor cost percentage for the evening daypart. Enables daypart-level labor efficiency benchmarking."
    - name: "approved_schedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_status = 'approved' THEN schedule_id END) / NULLIF(COUNT(schedule_id), 0), 2)
      comment: "Percentage of schedules in approved status. Tracks scheduling process compliance and readiness for publication."
$$;