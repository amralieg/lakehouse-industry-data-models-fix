-- Metric views for domain: workforce | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_associate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics. Drives staffing decisions, turnover analysis, and labor cost planning across locations and employment types."
  source: "`vibe_retail_v1`.`workforce`.`associate`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on-leave) for headcount segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, seasonal, or contractor classification for workforce mix analysis."
    - name: "pay_type"
      expr: pay_type
      comment: "Hourly vs. salaried classification for compensation analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation benchmarking and equity analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA exempt/non-exempt classification for overtime eligibility and compliance."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether the associate is a union member, for labor relations reporting."
    - name: "primary_work_location_type"
      expr: primary_work_location_type
      comment: "Store, DC, corporate, or remote — for location-type workforce distribution."
    - name: "rehire_eligible_flag"
      expr: rehire_eligible_flag
      comment: "Whether the associate is eligible for rehire, for talent pipeline planning."
    - name: "hire_date_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire for cohort-based tenure and attrition analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for termination (voluntary, involuntary, retirement) for attrition root-cause analysis."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'active' THEN associate_id END)
      comment: "Total number of active associates. Core headcount KPI for workforce planning and capacity management."
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total associate records including all statuses. Baseline for workforce composition analysis."
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average contracted hours per week across the workforce. Indicates FTE density and part-time vs. full-time mix."
    - name: "total_standard_hours_per_week"
      expr: SUM(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Total contracted weekly hours across all associates. Proxy for total labor capacity in hours."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN associate_id END)
      comment: "Number of union-represented associates. Critical for CBA compliance and labor relations risk management."
    - name: "termination_count"
      expr: COUNT(CASE WHEN employment_status = 'terminated' THEN associate_id END)
      comment: "Number of terminated associates in the period. Drives attrition rate calculation and retention strategy."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible_flag = TRUE THEN associate_id END)
      comment: "Associates eligible for rehire. Informs talent pipeline and reduces cost-per-hire for future openings."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics by pay period, location, and job type. Drives labor cost management, budget variance analysis, and compensation equity reviews."
  source: "`vibe_retail_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Weekly, bi-weekly, semi-monthly, or monthly pay cycle for payroll cadence analysis."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record (processed, pending, error) for payroll operations monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Direct deposit, check, or pay card — for payment operations and compliance."
    - name: "department_code"
      expr: department_code
      comment: "Department for labor cost allocation and departmental P&L analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial allocation and budget variance reporting."
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Month of pay date for trend analysis of labor costs over time."
    - name: "location_code"
      expr: location_code
      comment: "Location identifier for geographic labor cost distribution analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost KPI for P&L management and budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to associates. Drives cash flow planning for payroll funding."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay cost. High overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay_amount AS DOUBLE))
      comment: "Total regular (straight-time) pay. Baseline labor cost excluding premium pay components."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Operational KPI for scheduling efficiency and labor law compliance."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked. Core labor utilization measure for productivity benchmarking."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels and detects anomalies."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld. Required for tax liability reporting and IRS compliance."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions. Tracks benefit cost and 401(k) match obligations."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments). Measures total cost-of-employment beyond base wages."
    - name: "overtime_hours_to_regular_hours_ratio"
      expr: ROUND(SUM(CAST(overtime_hours_worked AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours_worked AS DOUBLE)), 0), 4)
      comment: "Ratio of overtime to regular hours. Exceeding thresholds triggers scheduling review and potential hiring decisions."
    - name: "ytd_gross_pay_total"
      expr: SUM(CAST(year_to_date_gross_pay_amount AS DOUBLE))
      comment: "Year-to-date gross pay total. Used for W-2 preparation, benefits eligibility thresholds, and annual compensation reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution metrics for operational oversight of payroll processing cycles. Tracks run totals, processing efficiency, and GL posting status."
  source: "`vibe_retail_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Regular, off-cycle, bonus, or correction run type for payroll operations categorization."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Current status of the payroll run (pending, processing, complete, error) for operational monitoring."
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "GL posting status for financial close tracking and accounting reconciliation."
    - name: "frequency"
      expr: frequency
      comment: "Pay frequency of the run (weekly, bi-weekly, etc.) for payroll cycle management."
    - name: "is_final_run"
      expr: is_final_run
      comment: "Whether this is the final run for the period, distinguishing test/preview runs from official payroll."
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Month of pay date for trend analysis of payroll run volumes and costs."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity or company code for multi-entity payroll cost segregation."
  measures:
    - name: "total_gross_pay_runs"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay across all payroll runs. Primary payroll cost KPI for financial close and budget variance."
    - name: "total_net_pay_runs"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed across runs. Drives cash management and bank funding requirements."
    - name: "total_employer_tax"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer-side payroll tax (FICA, FUTA, SUTA). Measures true cost-of-employment beyond wages."
    - name: "total_payroll_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total all-in payroll cost including wages, employer taxes, and benefits. Primary input to labor cost P&L."
    - name: "total_deductions_runs"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total employee deductions across runs. Reconciliation KPI for benefits administration and garnishment compliance."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Number of payroll runs executed. Operational volume metric for payroll team capacity planning."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll run. Detects anomalous runs that may indicate errors or off-cycle corrections."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and cost metrics from time and attendance records. Drives scheduling efficiency, overtime management, and labor cost allocation by department and location."
  source: "`vibe_retail_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, holiday, training) for labor cost categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval status for payroll readiness and compliance monitoring."
    - name: "department_code"
      expr: department_code
      comment: "Department for labor cost allocation and departmental productivity analysis."
    - name: "shift_differential_type"
      expr: shift_differential_type
      comment: "Type of shift differential (evening, overnight, weekend) for premium pay cost analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether the time entry has an exception requiring review. Drives payroll accuracy and compliance."
    - name: "exception_type"
      expr: exception_type
      comment: "Category of time entry exception (missed punch, overtime threshold, etc.) for root-cause analysis."
    - name: "is_holiday_work"
      expr: is_holiday_work
      comment: "Whether hours were worked on a holiday, for premium pay cost tracking."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the time entry has been included in a payroll run, for reconciliation."
    - name: "work_date_week"
      expr: DATE_TRUNC('week', work_date)
      comment: "Work week for weekly labor hour trend analysis and scheduling optimization."
    - name: "shift_differential_eligible"
      expr: shift_differential_eligible
      comment: "Whether the entry qualifies for shift differential pay, for premium labor cost forecasting."
  measures:
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked across all time entries. Core labor utilization KPI for productivity and capacity analysis."
    - name: "total_regular_hours_te"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours. Baseline for labor cost budgeting and scheduling efficiency."
    - name: "total_overtime_hours_te"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Elevated overtime signals scheduling gaps or understaffing requiring corrective action."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time is a significant cost driver and compliance risk indicator."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost from time entries. Primary input to store/DC labor cost P&L and budget variance reporting."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average hourly pay rate across time entries. Benchmarks compensation levels and detects rate anomalies."
    - name: "avg_shift_differential_rate"
      expr: AVG(CASE WHEN shift_differential_eligible = TRUE THEN shift_differential_rate END)
      comment: "Average shift differential rate for eligible entries. Informs premium pay cost forecasting and scheduling decisions."
    - name: "exception_entry_count"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN time_entry_id END)
      comment: "Number of time entries with exceptions. High exception rates indicate time-keeping compliance issues requiring manager intervention."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Key scheduling efficiency KPI; thresholds trigger staffing reviews."
    - name: "unprocessed_hours"
      expr: SUM(CASE WHEN payroll_processed_flag = FALSE THEN actual_hours_worked ELSE 0 END)
      comment: "Hours not yet processed through payroll. Operational KPI for payroll close completeness and accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and compliance metrics. Tracks FMLA eligibility, leave approval rates, and absence volumes to manage workforce availability and regulatory compliance."
  source: "`vibe_retail_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, personal, medical, parental) for absence pattern analysis."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Sub-classification of leave type for granular absence management."
    - name: "approval_status"
      expr: approval_status
      comment: "Leave approval status (approved, pending, denied) for HR workflow monitoring."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether the leave qualifies under FMLA. Critical for legal compliance and employee rights protection."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether the leave is paid or unpaid, for payroll cost impact analysis."
    - name: "intermittent_leave_flag"
      expr: intermittent_leave_flag
      comment: "Whether leave is taken intermittently, for scheduling impact assessment."
    - name: "medical_certification_required_flag"
      expr: medical_certification_required_flag
      comment: "Whether medical certification is required, for compliance process tracking."
    - name: "requested_start_date_month"
      expr: DATE_TRUNC('month', requested_start_date)
      comment: "Month leave begins for seasonal absence trend analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests submitted. Volume KPI for HR capacity planning and absence trend monitoring."
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total leave days requested. Measures workforce availability impact and informs backfill planning."
    - name: "total_days_approved"
      expr: SUM(CAST(total_days_approved AS DOUBLE))
      comment: "Total leave days approved. Actual absence volume for scheduling and labor cost impact analysis."
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total leave hours approved. Granular absence measure for hourly workforce scheduling impact."
    - name: "fmla_leave_request_count"
      expr: COUNT(CASE WHEN fmla_eligible_flag = TRUE THEN leave_request_id END)
      comment: "Number of FMLA-qualifying leave requests. Compliance KPI; high volumes may indicate workforce health or management issues."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN leave_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved. Low rates may signal policy inconsistency or employee relations risk."
    - name: "avg_days_approved_per_request"
      expr: AVG(CAST(total_days_approved AS DOUBLE))
      comment: "Average approved leave duration per request. Benchmarks absence length and informs coverage planning."
    - name: "leave_balance_avg_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average remaining leave balance after approval. Low balances signal risk of unpaid leave and workforce availability issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance rating distribution and merit eligibility metrics. Drives talent management, succession planning, and merit budget allocation decisions."
  source: "`vibe_retail_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Annual, mid-year, PIP, or disciplinary review type for performance cycle analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Performance rating category (exceeds, meets, below) for talent distribution analysis."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Completion status of the review for cycle management and HR compliance."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Whether the rating has been calibrated by management, for rating consistency governance."
    - name: "pip_flag"
      expr: pip_flag
      comment: "Whether the associate is on a Performance Improvement Plan. Tracks at-risk population for HR intervention."
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Whether the associate qualifies for a merit increase. Drives merit budget allocation."
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether a promotion is recommended. Informs succession planning and career development investment."
    - name: "review_period_end_month"
      expr: DATE_TRUNC('month', review_period_end_date)
      comment: "Review period end month for performance cycle timing analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of action resulting from review (merit, promotion, PIP, termination) for outcome tracking."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN performance_review_status = 'completed' THEN performance_review_id END)
      comment: "Number of completed performance reviews. Measures review cycle completion rate for HR governance."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average numeric performance rating score. Tracks workforce performance trends and calibration consistency across managers."
    - name: "avg_merit_increase_pct"
      expr: AVG(CASE WHEN merit_increase_eligible_flag = TRUE THEN merit_increase_percentage END)
      comment: "Average merit increase percentage for eligible associates. Benchmarks compensation competitiveness and budget utilization."
    - name: "pip_population_count"
      expr: COUNT(CASE WHEN pip_flag = TRUE THEN performance_review_id END)
      comment: "Number of associates on PIPs. Elevated PIP counts signal management effectiveness or hiring quality issues."
    - name: "promotion_recommendation_count"
      expr: COUNT(CASE WHEN promotion_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Number of promotion recommendations. Informs succession pipeline depth and internal mobility investment."
    - name: "termination_recommendation_count"
      expr: COUNT(CASE WHEN termination_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Number of termination recommendations from reviews. Tracks involuntary attrition pipeline for workforce planning."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN performance_review_id END)
      comment: "Number of performance review appeals filed. High appeal rates indicate rating fairness or process integrity issues."
    - name: "merit_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN merit_increase_eligible_flag = TRUE THEN performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed associates eligible for merit increases. Informs merit budget sizing and compensation strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_compensation_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation change volume, cost impact, and equity metrics. Drives merit budget management, pay equity analysis, and compensation strategy execution."
  source: "`vibe_retail_v1`.`workforce`.`compensation_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of compensation change (merit, promotion, equity, market adjustment) for budget categorization."
    - name: "change_reason"
      expr: change_reason
      comment: "Business reason for the compensation change for root-cause and equity analysis."
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR approval status for compensation governance and workflow compliance."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Whether the change is a one-time lump sum vs. base pay increase, for budget impact classification."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Whether the change is retroactive, for payroll liability and accrual management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation change for multi-currency reporting."
    - name: "change_effective_date_month"
      expr: DATE_TRUNC('month', change_effective_date)
      comment: "Month the change takes effect for compensation cost trend analysis."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating associated with the change for pay-for-performance analysis."
    - name: "new_pay_grade"
      expr: new_pay_grade
      comment: "New pay grade after the change for grade distribution and equity analysis."
  measures:
    - name: "total_budget_impact"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total annualized budget impact of all compensation changes. Primary KPI for merit cycle budget management and financial planning."
    - name: "avg_pay_rate_change_pct"
      expr: AVG(CAST(pay_rate_change_percentage AS DOUBLE))
      comment: "Average percentage pay rate change. Benchmarks merit increase competitiveness against market and internal equity targets."
    - name: "avg_compa_ratio_after"
      expr: AVG(CAST(compa_ratio_after AS DOUBLE))
      comment: "Average compa-ratio after the change. Measures pay equity relative to market midpoint; ratios far from 1.0 signal equity risk."
    - name: "total_lump_sum_cost"
      expr: SUM(CAST(lump_sum_amount AS DOUBLE))
      comment: "Total one-time lump sum compensation cost. Tracks non-recurring compensation spend separate from base pay increases."
    - name: "total_retroactive_cost"
      expr: SUM(CAST(retroactive_amount AS DOUBLE))
      comment: "Total retroactive pay liability. Measures financial exposure from delayed compensation actions."
    - name: "compensation_change_count"
      expr: COUNT(1)
      comment: "Total number of compensation changes processed. Volume KPI for HR operations capacity and merit cycle execution tracking."
    - name: "avg_pay_rate_change_amount"
      expr: AVG(CAST(pay_rate_change_amount AS DOUBLE))
      comment: "Average absolute pay rate change amount. Informs compensation budget modeling and equity adjustment sizing."
    - name: "compa_ratio_improvement"
      expr: ROUND(AVG(CAST(compa_ratio_after AS DOUBLE)) - AVG(CAST(compa_ratio_before AS DOUBLE)), 4)
      comment: "Average improvement in compa-ratio from compensation changes. Measures effectiveness of equity adjustment programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and effectiveness metrics. Drives mandatory training compliance, certification attainment, and learning investment ROI analysis."
  source: "`vibe_retail_v1`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (completed, in-progress, not-started, overdue) for compliance monitoring."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (compliance, skills, leadership, onboarding) for learning investment categorization."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e-learning, instructor-led, on-the-job) for effectiveness and cost analysis."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether the training is mandatory. Mandatory completion rates are a compliance KPI."
    - name: "compliance_training_flag"
      expr: compliance_training_flag
      comment: "Whether the training is regulatory compliance training. Non-completion creates legal and audit risk."
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether the training is past its due date. Overdue compliance training is an immediate risk indicator."
    - name: "certification_earned_flag"
      expr: certification_earned_flag
      comment: "Whether a certification was earned upon completion. Tracks credential attainment for workforce capability planning."
    - name: "pass_fail_indicator"
      expr: pass_fail_indicator
      comment: "Pass or fail outcome for scored training. Informs training effectiveness and remediation needs."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for training volume trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments. Volume KPI for learning program reach and training operations capacity."
    - name: "completion_count"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN training_enrollment_id END)
      comment: "Number of completed training enrollments. Core training effectiveness KPI."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN training_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Training completion rate. Mandatory training completion below threshold triggers compliance escalation."
    - name: "mandatory_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_training_flag = TRUE AND completion_status = 'completed' THEN training_enrollment_id END) / NULLIF(COUNT(CASE WHEN mandatory_training_flag = TRUE THEN training_enrollment_id END), 0), 2)
      comment: "Completion rate for mandatory training only. Regulatory compliance KPI; below 100% creates legal exposure."
    - name: "overdue_training_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of overdue training enrollments. Immediate compliance risk indicator requiring management escalation."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score. Measures training effectiveness and identifies knowledge gaps requiring curriculum revision."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours. Informs learning investment sizing and scheduling impact on labor availability."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost investment. Drives L&D budget management and ROI analysis against performance outcomes."
    - name: "certification_attainment_count"
      expr: COUNT(CASE WHEN certification_earned_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certifications earned through training. Tracks workforce credential attainment for capability planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline and recruiting efficiency metrics. Drives hiring velocity, cost-per-hire, and workforce planning execution against approved headcount."
  source: "`vibe_retail_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, filled, cancelled, on-hold) for pipeline management."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Backfill, new headcount, or replacement — for workforce growth vs. attrition analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or seasonal hiring mix for workforce composition planning."
    - name: "job_family"
      expr: job_family
      comment: "Job family for talent demand analysis by functional area."
    - name: "job_level"
      expr: job_level
      comment: "Seniority level of the open position for compensation budget and sourcing strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Hiring priority (critical, high, standard) for recruiter resource allocation."
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Whether the role is remote-eligible, for talent pool sizing and location strategy."
    - name: "hiring_location_type"
      expr: hiring_location_type
      comment: "Store, DC, or corporate hiring location type for workforce distribution planning."
    - name: "open_date_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month requisition opened for hiring volume trend analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification of the open role for compensation compliance planning."
  measures:
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'open' THEN requisition_id END)
      comment: "Number of currently open requisitions. Core talent pipeline KPI for workforce capacity gap analysis."
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total requisitions created. Volume KPI for recruiting team capacity planning and hiring demand analysis."
    - name: "filled_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'filled' THEN requisition_id END)
      comment: "Number of filled requisitions. Measures recruiting execution effectiveness against hiring targets."
    - name: "avg_budgeted_salary_midpoint"
      expr: AVG((CAST(budgeted_salary_min AS DOUBLE) + CAST(budgeted_salary_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of budgeted salary range for open roles. Informs compensation budget planning and market competitiveness."
    - name: "total_budgeted_salary_max_exposure"
      expr: SUM(CAST(budgeted_salary_max AS DOUBLE))
      comment: "Total maximum salary budget exposure across open requisitions. Drives labor budget reserve planning."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requisition_status = 'filled' THEN requisition_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions successfully filled. Measures recruiting effectiveness; low rates signal sourcing or compensation competitiveness issues."
    - name: "cancelled_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'cancelled' THEN requisition_id END)
      comment: "Number of cancelled requisitions. High cancellation rates indicate planning instability or budget volatility."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and candidate conversion metrics. Tracks application-to-hire conversion, offer acceptance rates, and time-to-hire efficiency for talent acquisition optimization."
  source: "`vibe_retail_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage of the application (applied, screening, interview, offer, hired, rejected) for funnel analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel (job board, referral, agency, direct) for sourcing effectiveness analysis."
    - name: "is_internal_candidate"
      expr: is_internal_candidate
      comment: "Whether the applicant is an internal employee. Internal mobility rate is a retention and development KPI."
    - name: "is_rehire"
      expr: is_rehire
      comment: "Whether the applicant is a former employee being rehired. Rehire rates indicate employer brand strength."
    - name: "offer_accepted_flag"
      expr: offer_accepted_flag
      comment: "Whether the job offer was accepted. Offer acceptance rate measures compensation competitiveness and candidate experience."
    - name: "offer_extended_flag"
      expr: offer_extended_flag
      comment: "Whether an offer was extended. Offer extension rate measures interview-to-offer conversion efficiency."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check outcome for compliance and hiring risk management."
    - name: "application_date_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for recruiting volume trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total job applications received. Top-of-funnel volume KPI for recruiting pipeline health."
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_flag = TRUE THEN job_application_id END) / NULLIF(COUNT(CASE WHEN offer_extended_flag = TRUE THEN job_application_id END), 0), 2)
      comment: "Percentage of extended offers accepted. Below-target rates signal compensation or candidate experience issues requiring immediate action."
    - name: "internal_candidate_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_internal_candidate = TRUE THEN job_application_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications from internal candidates. Measures internal mobility and career development program effectiveness."
    - name: "avg_offer_amount"
      expr: AVG(CAST(offer_amount AS DOUBLE))
      comment: "Average offer amount extended to candidates. Benchmarks compensation competitiveness and budget utilization."
    - name: "hired_count"
      expr: COUNT(CASE WHEN application_status = 'hired' THEN job_application_id END)
      comment: "Number of applications resulting in a hire. Core recruiting output KPI for workforce planning execution."
    - name: "application_to_hire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'hired' THEN job_application_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications resulting in a hire. Measures overall recruiting funnel efficiency and sourcing quality."
    - name: "rehire_count"
      expr: COUNT(CASE WHEN is_rehire = TRUE THEN job_application_id END)
      comment: "Number of rehire applications. Rehires typically have lower onboarding cost and faster productivity ramp."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation, cost, and compliance metrics. Drives benefits program management, ACA compliance, and total compensation cost analysis."
  source: "`vibe_retail_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (medical, dental, vision, 401k, life) for benefits portfolio cost analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (enrolled, waived, terminated) for participation rate tracking."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee-only, employee+spouse, family) for cost tier distribution analysis."
    - name: "aca_eligible_flag"
      expr: aca_eligible_flag
      comment: "Whether the associate is ACA-eligible. ACA compliance requires tracking and reporting on eligible population."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Whether the associate is COBRA-eligible. Tracks post-termination benefits liability."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "How the enrollment was submitted (self-service, HR-assisted, paper) for process efficiency analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Benefits plan year for annual enrollment cycle analysis and year-over-year cost comparison."
    - name: "qualifying_life_event_type"
      expr: qualifying_life_event_type
      comment: "Type of qualifying life event triggering mid-year enrollment change for benefits administration planning."
  measures:
    - name: "total_enrollments_benefit"
      expr: COUNT(CASE WHEN enrollment_status = 'enrolled' THEN benefit_enrollment_id END)
      comment: "Total active benefit enrollments. Measures benefits program participation and coverage breadth."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contributions. Measures employee cost-sharing and benefits affordability."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions. Primary benefits cost KPI for total compensation budget management."
    - name: "total_premium_cost"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total benefits premium cost (employer + employee). Drives benefits budget planning and vendor negotiation."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution per enrollment. Benchmarks benefits affordability and cost-sharing strategy."
    - name: "aca_eligible_enrollment_count"
      expr: COUNT(CASE WHEN aca_eligible_flag = TRUE THEN benefit_enrollment_id END)
      comment: "Number of ACA-eligible enrollments. Required for ACA employer mandate compliance and 1095-C reporting."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN enrollment_status = 'waived' THEN benefit_enrollment_id END)
      comment: "Number of benefit waivers. High waiver rates may indicate affordability issues or competing coverage, informing benefits design decisions."
    - name: "total_annual_election_amount"
      expr: SUM(CAST(annual_election_amount AS DOUBLE))
      comment: "Total annual FSA/HSA election amounts. Drives pre-tax benefit program cost and tax savings analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning and variance metrics. Drives workforce cost management, FTE planning accuracy, and budget-to-actual labor cost analysis."
  source: "`vibe_retail_v1`.`workforce`.`labor_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval status (draft, approved, locked) for planning cycle governance."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Annual, quarterly, or monthly planning horizon for budget cycle management."
    - name: "budget_version_code"
      expr: budget_version_code
      comment: "Budget version (original, revised, final) for version-controlled planning analysis."
    - name: "budgeted_labor_cost_currency_code"
      expr: budgeted_labor_cost_currency_code
      comment: "Currency of the labor budget for multi-currency financial reporting."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month for budget timeline analysis."
  measures:
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost_amount AS DOUBLE))
      comment: "Total budgeted labor cost. Primary financial planning KPI for workforce cost management and P&L forecasting."
    - name: "total_budgeted_regular_hours"
      expr: SUM(CAST(budgeted_regular_hours AS DOUBLE))
      comment: "Total budgeted regular hours. Capacity planning KPI for scheduling and staffing model validation."
    - name: "total_budgeted_overtime_hours"
      expr: SUM(CAST(budgeted_overtime_hours AS DOUBLE))
      comment: "Total budgeted overtime hours. Planned premium labor cost indicator for scheduling strategy."
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte_count AS DOUBLE))
      comment: "Total planned FTE count across all budget lines. Core workforce capacity planning KPI."
    - name: "avg_budgeted_labor_cost_pct_of_sales"
      expr: AVG(CAST(budgeted_labor_cost_percent_of_sales AS DOUBLE))
      comment: "Average budgeted labor cost as a percentage of sales. Key retail productivity ratio for store and DC profitability management."
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percent AS DOUBLE))
      comment: "Average attrition assumption built into labor budgets. Validates planning assumptions against actual attrition for budget accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staffing plan execution and headcount variance metrics. Tracks planned vs. actual headcount and FTE to identify gaps requiring recruiting or scheduling action."
  source: "`vibe_retail_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "staffing_plan_status"
      expr: staffing_plan_status
      comment: "Plan status (draft, approved, active, closed) for planning cycle governance."
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle (annual, quarterly, seasonal) for staffing plan cadence analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the staffing plan takes effect for workforce planning timeline analysis."
  measures:
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total budgeted FTE across all staffing plans. Planned workforce capacity for financial and operational planning."
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS DOUBLE))
      comment: "Total actual headcount against staffing plans. Measures workforce fulfillment vs. plan."
    - name: "total_headcount_allocated"
      expr: SUM(CAST(headcount_allocated AS DOUBLE))
      comment: "Total allocated headcount in staffing plans. Measures approved workforce capacity deployment."
    - name: "total_fte_variance"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (actual vs. planned). Negative variance signals understaffing requiring immediate recruiting or scheduling action."
    - name: "avg_annual_labor_budget"
      expr: AVG(CAST(annual_labor_budget AS DOUBLE))
      comment: "Average annual labor budget per staffing plan. Benchmarks labor investment by org unit for budget equity analysis."
    - name: "total_annual_labor_cost_budget"
      expr: SUM(CAST(annual_labor_cost_budget AS DOUBLE))
      comment: "Total annual labor cost budget across all staffing plans. Primary workforce financial planning KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling efficiency and labor cost metrics from shift schedules. Drives scheduling optimization, overtime management, and labor cost forecasting."
  source: "`vibe_retail_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Shift schedule status (scheduled, confirmed, cancelled, completed) for scheduling operations monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (opening, closing, mid, overnight) for coverage pattern analysis."
    - name: "is_overtime_eligible"
      expr: is_overtime_eligible
      comment: "Whether the shift is overtime-eligible for premium labor cost forecasting."
    - name: "is_holiday_shift"
      expr: is_holiday_shift
      comment: "Whether the shift falls on a holiday for premium pay cost planning."
    - name: "shift_priority"
      expr: shift_priority
      comment: "Scheduling priority level for coverage gap management."
    - name: "shift_date_week"
      expr: DATE_TRUNC('week', shift_date)
      comment: "Week of the shift for weekly labor cost trend analysis and scheduling pattern review."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source of the schedule (automated, manual, manager-override) for scheduling process quality analysis."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled labor hours. Core capacity planning KPI for store and DC operations management."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost from scheduled shifts. Drives weekly labor cost forecasting and budget management."
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_hours AS DOUBLE))
      comment: "Average hours per scheduled shift. Measures shift length distribution for scheduling efficiency analysis."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN is_overtime_eligible = TRUE THEN shift_schedule_id END)
      comment: "Number of overtime-eligible shifts scheduled. High counts signal scheduling inefficiency or understaffing."
    - name: "holiday_shift_count"
      expr: COUNT(CASE WHEN is_holiday_shift = TRUE THEN shift_schedule_id END)
      comment: "Number of holiday shifts scheduled. Drives premium pay cost forecasting for peak period planning."
    - name: "cancelled_shift_count"
      expr: COUNT(CASE WHEN schedule_status = 'cancelled' THEN shift_schedule_id END)
      comment: "Number of cancelled shifts. High cancellation rates indicate scheduling instability and coverage risk."
    - name: "avg_estimated_labor_cost_per_shift"
      expr: AVG(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Average estimated labor cost per shift. Benchmarks shift cost efficiency across locations and departments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_wf_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification attainment, compliance, and cost metrics. Tracks mandatory credential coverage, expiration risk, and certification investment for regulatory and operational readiness."
  source: "`vibe_retail_v1`.`workforce`.`wf_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (active, expired, pending, revoked) for compliance monitoring."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, food-handler, forklift, professional) for compliance category analysis."
    - name: "is_compliance_required"
      expr: is_compliance_required
      comment: "Whether the certification is required for regulatory compliance. Non-compliance creates legal and operational risk."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role. Mandatory gaps require immediate remediation."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of issuing authority (government, industry body, internal) for credential credibility classification."
    - name: "reimbursement_eligible_flag"
      expr: reimbursement_eligible_flag
      comment: "Whether the certification cost is reimbursable. Tracks tuition/certification reimbursement program utilization."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of certification expiration for renewal pipeline management."
    - name: "job_eligibility_flag"
      expr: job_eligibility_flag
      comment: "Whether the certification affects job eligibility. Expired mandatory certs may require role reassignment."
  measures:
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN wf_certification_id END)
      comment: "Number of active certifications held by the workforce. Measures current compliance credential coverage."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN wf_certification_id END)
      comment: "Number of expired certifications. Immediate compliance risk indicator; expired mandatory certs require urgent renewal action."
    - name: "mandatory_compliance_gap_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND certification_status != 'active' THEN wf_certification_id END)
      comment: "Number of mandatory certifications not in active status. Critical compliance gap KPI requiring immediate management escalation."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of workforce certifications. Drives L&D budget management and certification program ROI analysis."
    - name: "total_reimbursement_amount"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total certification reimbursement paid to associates. Tracks tuition/certification benefit program utilization and cost."
    - name: "avg_continuing_education_hours_completed"
      expr: AVG(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed per certification. Measures ongoing professional development investment."
    - name: "ce_hours_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(continuing_education_hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(continuing_education_hours_required AS DOUBLE)), 0), 2)
      comment: "Continuing education hours completed as a percentage of required hours. Measures CE compliance progress for credential maintenance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_merit_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merit cycle budget utilization and planning metrics. Tracks merit budget allocation, guideline adherence, and cycle execution for compensation governance."
  source: "`vibe_retail_v1`.`workforce`.`merit_cycle`"
  dimensions:
    - name: "merit_cycle_status"
      expr: merit_cycle_status
      comment: "Current status of the merit cycle (planning, active, closed) for cycle governance."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of merit cycle (annual, mid-year, off-cycle) for compensation program categorization."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the merit cycle for year-over-year compensation trend analysis."
    - name: "calibration_required"
      expr: calibration_required
      comment: "Whether calibration is required for this cycle. Calibration ensures rating consistency and pay equity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the merit budget for multi-currency compensation reporting."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month merit increases take effect for compensation cost timing analysis."
  measures:
    - name: "total_merit_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total merit budget allocated across cycles. Primary compensation investment KPI for financial planning."
    - name: "avg_guideline_increase_pct"
      expr: AVG(CAST(guideline_increase_percentage AS DOUBLE))
      comment: "Average merit increase guideline percentage. Benchmarks compensation competitiveness against market and internal equity targets."
    - name: "avg_budget_percentage"
      expr: AVG(CAST(budget_percentage AS DOUBLE))
      comment: "Average merit budget as a percentage of payroll. Measures compensation investment intensity relative to total labor cost."
    - name: "avg_max_increase_pct"
      expr: AVG(CAST(maximum_increase_percentage AS DOUBLE))
      comment: "Average maximum allowable merit increase. Defines the upper bound of compensation flexibility for high performers."
    - name: "active_cycle_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN merit_cycle_id END)
      comment: "Number of currently active merit cycles. Operational KPI for compensation administration workload management."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`workforce_org_unit_compliance_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational compliance program coverage and training completion metrics. Tracks compliance scope adherence, audit results, and training completion rates by org unit."
  source: "`vibe_retail_v1`.`workforce`.`org_unit_compliance_scope`"
  dimensions:
    - name: "scope_status"
      expr: scope_status
      comment: "Compliance scope status (active, exempt, suspended) for coverage monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Compliance risk level (high, medium, low) for prioritized audit and remediation planning."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Required audit frequency (annual, quarterly, monthly) for compliance program scheduling."
    - name: "last_audit_result"
      expr: last_audit_result
      comment: "Most recent audit outcome (pass, fail, conditional) for compliance health monitoring."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month compliance scope became effective for program rollout tracking."
  measures:
    - name: "avg_training_completion_rate"
      expr: AVG(CAST(training_completion_rate AS DOUBLE))
      comment: "Average training completion rate across org unit compliance scopes. Below-target rates indicate compliance program execution gaps."
    - name: "high_risk_scope_count"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN org_unit_compliance_scope_id END)
      comment: "Number of high-risk compliance scopes. Drives audit prioritization and compliance resource allocation decisions."
    - name: "failed_audit_scope_count"
      expr: COUNT(CASE WHEN last_audit_result = 'fail' THEN org_unit_compliance_scope_id END)
      comment: "Number of org unit scopes with failed audit results. Immediate compliance risk indicator requiring corrective action."
    - name: "total_active_scopes"
      expr: COUNT(CASE WHEN scope_status = 'active' THEN org_unit_compliance_scope_id END)
      comment: "Total active compliance scopes across org units. Measures compliance program coverage breadth."
$$;