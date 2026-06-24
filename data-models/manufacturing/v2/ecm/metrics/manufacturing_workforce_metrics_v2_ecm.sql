-- Metric views for domain: workforce | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce composition and cost metrics derived from the employee master record. Supports headcount planning, compensation benchmarking, and workforce risk management."
  source: "`vibe_manufacturing_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave) for workforce segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor classification for workforce mix analysis."
    - name: "department_name"
      expr: department_name
      comment: "Department grouping for headcount and cost distribution analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family classification for compensation benchmarking and succession planning."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation equity and range analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Union membership indicator for labor relations and agreement compliance tracking."
    - name: "safety_certification_status"
      expr: safety_certification_status
      comment: "Safety certification status to identify compliance gaps across the workforce."
    - name: "work_location_name"
      expr: work_location_name
      comment: "Work location for geographic workforce distribution analysis."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort and attrition trend analysis."
  measures:
    - name: "active_headcount"
      expr: COUNT(CASE WHEN is_active = TRUE THEN employee_id END)
      comment: "Total number of active employees. Core workforce sizing KPI used in capacity planning and cost forecasting."
    - name: "total_annual_salary_cost"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annualized salary expenditure across the workforce. Drives compensation budget planning and cost-per-department analysis."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary per employee. Used for compensation benchmarking against industry and internal equity reviews."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly workforce. Key input for labor cost modeling in production and service operations."
    - name: "avg_training_hours_ytd"
      expr: AVG(CAST(training_hours_ytd AS DOUBLE))
      comment: "Average year-to-date training hours per employee. Indicates investment in workforce development and compliance training completion."
    - name: "total_training_hours_ytd"
      expr: SUM(CAST(training_hours_ytd AS DOUBLE))
      comment: "Total training hours invested year-to-date across the workforce. Supports L&D budget justification and regulatory compliance reporting."
    - name: "work_permit_expiry_risk_count"
      expr: COUNT(CASE WHEN work_permit_required_flag = TRUE AND work_permit_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) THEN employee_id END)
      comment: "Number of employees with work permits expiring within 30 days. Critical compliance risk metric to prevent unauthorized employment."
    - name: "safety_cert_expired_count"
      expr: COUNT(CASE WHEN safety_certification_expiry_date < CURRENT_DATE() THEN employee_id END)
      comment: "Number of employees with expired safety certifications. Directly tied to regulatory compliance and workplace safety risk."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN employee_id END)
      comment: "Total number of union members. Informs labor relations strategy and collective bargaining scope."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost analytics covering gross pay, net pay, deductions, overtime, and labor cost allocation. Supports payroll budget control, overtime management, and cost center accountability."
  source: "`vibe_manufacturing_v1`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll processing status (Processed, Pending, Error) for payroll cycle monitoring."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (Weekly, Bi-weekly, Monthly) for payroll cycle segmentation."
    - name: "pay_group"
      expr: pay_group
      comment: "Pay group classification for payroll batch and cost allocation analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for labor cost distribution and budget variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll disbursement for multi-currency payroll reporting."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Pay period month for trend analysis of payroll costs over time."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll cost. Primary payroll budget KPI used in financial planning and cost center reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees. Represents actual cash outflow for treasury and cash flow management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay expenditure. High overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Operational KPI for workforce scheduling optimization and labor law compliance."
    - name: "avg_overtime_hours_per_employee"
      expr: AVG(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Average overtime hours per payroll record. Identifies chronic overtime patterns that increase burnout and turnover risk."
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost_amount AS DOUBLE))
      comment: "Total fully-loaded labor cost including employer taxes and benefits. Used for product costing, margin analysis, and make-vs-buy decisions."
    - name: "total_employer_tax"
      expr: SUM(CAST(employer_tax_amount AS DOUBLE))
      comment: "Total employer tax burden. Input for total compensation cost modeling and tax planning."
    - name: "total_employer_benefits_cost"
      expr: SUM(CAST(employer_benefits_cost_amount AS DOUBLE))
      comment: "Total employer-side benefits cost. Supports benefits program ROI analysis and total rewards benchmarking."
    - name: "overtime_pay_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay_amount AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay. Ratio above threshold triggers workforce planning review and scheduling intervention."
    - name: "avg_regular_hours_worked"
      expr: AVG(CAST(regular_hours_worked AS DOUBLE))
      comment: "Average regular hours worked per payroll record. Baseline for productivity and utilization benchmarking."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement plan contributions (employee + employer). Supports benefits liability forecasting and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time tracking analytics covering productive hours, overtime, labor cost, and approval compliance. Supports operational efficiency, payroll accuracy, and cost center accountability."
  source: "`vibe_manufacturing_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "labor_type"
      expr: labor_type
      comment: "Labor type classification (Direct, Indirect, Overhead) for cost allocation and productivity analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Time entry approval status for payroll readiness and compliance monitoring."
    - name: "job_code"
      expr: job_code
      comment: "Job code for labor cost allocation to work orders and projects."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level productivity and cost analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Overtime eligibility flag for overtime cost exposure analysis."
    - name: "work_date_month"
      expr: DATE_TRUNC('month', work_date)
      comment: "Work month for trend analysis of labor hours and costs."
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code for granular labor cost allocation to production activities."
    - name: "payroll_processed"
      expr: payroll_processed
      comment: "Payroll processing flag to identify unprocessed time entries that may delay payroll."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total labor hours recorded. Foundational KPI for workforce utilization, capacity planning, and production scheduling."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Drives product costing, project cost tracking, and cost center budget variance analysis."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per time entry. Used for standard cost setting and labor rate variance analysis."
    - name: "total_shift_premium_cost"
      expr: SUM(CAST(shift_premium_amount AS DOUBLE))
      comment: "Total shift premium pay. Quantifies the cost of off-hours operations to support shift scheduling optimization."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total units produced as recorded in time entries. Links labor input to production output for productivity rate calculation."
    - name: "unapproved_time_entry_count"
      expr: COUNT(CASE WHEN approval_status != 'Approved' THEN time_entry_id END)
      comment: "Number of time entries not yet approved. Payroll risk metric — unapproved entries delay payroll processing and may indicate compliance gaps."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per time entry. Supports labor law compliance monitoring for mandatory rest period requirements."
    - name: "labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Effective labor cost per productive hour. Key efficiency ratio for benchmarking against standard rates and identifying cost overruns."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce absence analytics covering absence frequency, duration, FMLA exposure, and return-to-work compliance. Supports attendance management, productivity impact assessment, and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type_code"
      expr: absence_type_code
      comment: "Absence type (Sick, Vacation, FMLA, Personal) for absence pattern analysis."
    - name: "absence_reason_code"
      expr: absence_reason_code
      comment: "Specific absence reason code for root cause analysis and wellness program targeting."
    - name: "approval_status"
      expr: approval_status
      comment: "Absence approval status for compliance and policy adherence monitoring."
    - name: "is_fmla_protected"
      expr: is_fmla_protected
      comment: "FMLA protection flag for legal compliance tracking and exposure management."
    - name: "is_paid"
      expr: is_paid
      comment: "Paid vs unpaid absence classification for payroll cost impact analysis."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Absence start month for seasonal absence trend analysis."
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Intermittent absence flag for identifying chronic intermittent absence patterns."
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total calendar days lost to absence. Primary KPI for workforce availability and productivity impact quantification."
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours lost to absence. Used for production capacity planning and labor cost impact assessment."
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average absence duration per incident. Longer averages may indicate serious health issues or policy abuse requiring HR intervention."
    - name: "fmla_absence_count"
      expr: COUNT(CASE WHEN is_fmla_protected = TRUE THEN absence_record_id END)
      comment: "Number of FMLA-protected absences. Legal compliance KPI — mismanagement of FMLA absences creates significant litigation risk."
    - name: "total_accrual_balance_deducted"
      expr: SUM(CAST(accrual_balance_deducted AS DOUBLE))
      comment: "Total accrual balance consumed by absences. Tracks PTO liability reduction and informs accrual policy adequacy."
    - name: "medical_cert_outstanding_count"
      expr: COUNT(CASE WHEN medical_certification_required = TRUE AND medical_certification_received = FALSE THEN absence_record_id END)
      comment: "Absences requiring medical certification that have not yet received it. Compliance risk metric for absence policy enforcement."
    - name: "return_to_work_cert_outstanding_count"
      expr: COUNT(CASE WHEN return_to_work_certification_received = FALSE AND return_to_work_date <= CURRENT_DATE() THEN absence_record_id END)
      comment: "Employees past return-to-work date without certification received. Safety and compliance risk requiring immediate HR follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance analytics covering rating distributions, merit eligibility, promotion pipeline, and succession planning. Supports talent management, compensation decisions, and leadership development."
  source: "`vibe_manufacturing_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for talent segmentation and calibration analysis."
    - name: "review_type"
      expr: review_type
      comment: "Review type (Annual, Mid-Year, Probation) for review cycle management."
    - name: "review_status"
      expr: review_status
      comment: "Review completion status for cycle completion tracking and manager accountability."
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Review cycle year for year-over-year performance trend analysis."
    - name: "department_at_review"
      expr: department_at_review
      comment: "Department at time of review for departmental performance distribution analysis."
    - name: "merit_increase_eligible"
      expr: merit_increase_eligible
      comment: "Merit increase eligibility flag for compensation planning and budget forecasting."
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Promotion recommendation flag for talent pipeline and succession planning."
  measures:
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Tracks workforce performance trends and calibration effectiveness across departments."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score AS DOUBLE))
      comment: "Average competency assessment score. Identifies skill gaps requiring targeted development investment."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score. Measures organizational goal execution effectiveness and individual accountability."
    - name: "merit_eligible_count"
      expr: COUNT(CASE WHEN merit_increase_eligible = TRUE THEN performance_review_id END)
      comment: "Number of employees eligible for merit increases. Drives compensation budget planning for the upcoming cycle."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended = TRUE THEN performance_review_id END)
      comment: "Number of employees recommended for promotion. Key talent pipeline metric for succession planning and career development."
    - name: "pip_required_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_required = TRUE THEN performance_review_id END)
      comment: "Number of employees requiring a performance improvement plan. Signals performance risk and potential involuntary attrition exposure."
    - name: "succession_candidate_count"
      expr: COUNT(CASE WHEN succession_plan_candidate = TRUE THEN performance_review_id END)
      comment: "Number of employees identified as succession plan candidates. Critical for leadership continuity and key role risk management."
    - name: "review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Completed' THEN performance_review_id END) / NULLIF(COUNT(performance_review_id), 0), 2)
      comment: "Percentage of performance reviews completed. Measures HR process compliance and manager accountability in the review cycle."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance analytics covering certification coverage, expiry risk, renewal rates, and regulatory compliance. Supports safety compliance, skills management, and audit readiness."
  source: "`vibe_manufacturing_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_category"
      expr: certification_category
      comment: "Certification category (Safety, Technical, Regulatory) for compliance portfolio analysis."
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current certification status (Active, Expired, Pending Renewal) for compliance gap identification."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Certifying body for regulatory compliance tracking and audit evidence."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Mandatory compliance certification flag for regulatory risk prioritization."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Examination pass/fail outcome for training effectiveness analysis."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Renewal requirement flag for proactive expiry management."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Certification expiry year for forward-looking renewal planning."
  measures:
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Active' THEN workforce_certification_id END)
      comment: "Total active certifications held by the workforce. Baseline compliance coverage metric for regulatory audits."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN workforce_certification_id END)
      comment: "Number of expired certifications. Critical compliance risk — expired certifications may result in regulatory violations and work stoppages."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN workforce_certification_id END)
      comment: "Certifications expiring within 30 days. Proactive risk metric enabling timely renewal actions before compliance gaps occur."
    - name: "mandatory_cert_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirement_flag = TRUE AND workforce_certification_status = 'Active' THEN workforce_certification_id END) / NULLIF(COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN workforce_certification_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. Regulatory compliance KPI directly tied to audit outcomes and legal risk."
    - name: "avg_examination_score"
      expr: AVG(CAST(examination_score AS DOUBLE))
      comment: "Average certification examination score. Measures training program effectiveness and workforce competency levels."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in workforce certifications. Supports L&D budget planning and ROI analysis for certification programs."
    - name: "avg_training_hours_completed"
      expr: AVG(CAST(training_hours_completed AS DOUBLE))
      comment: "Average training hours completed per certification. Benchmarks training intensity against certification requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce assignment analytics covering FTE allocation, compensation structure, employment mix, and assignment lifecycle. Supports organizational design, compensation equity, and workforce planning."
  source: "`vibe_manufacturing_v1`.`workforce`.`assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (Active, Terminated, On Leave) for workforce availability analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type (Primary, Secondary, Acting) for workforce deployment analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (Full-time, Part-time, Contract) for workforce mix and cost structure analysis."
    - name: "job_family"
      expr: job_family
      comment: "Job family for compensation benchmarking and skills distribution analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level for organizational hierarchy and compensation band analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation equity and range penetration analysis."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Union membership status for labor relations and agreement compliance tracking."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year assignment became effective for workforce tenure and stability analysis."
  measures:
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN assignment_id END)
      comment: "Total active workforce assignments. Core headcount metric for organizational capacity and span-of-control analysis."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE)) / 100.0
      comment: "Total full-time equivalent workforce. Normalized headcount metric for capacity planning and budget allocation."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate across assignments. Compensation benchmarking KPI for pay equity analysis and market positioning."
    - name: "avg_bonus_target_percentage"
      expr: AVG(CAST(bonus_target_percentage AS DOUBLE))
      comment: "Average bonus target percentage. Informs variable compensation budget planning and incentive program design."
    - name: "avg_scheduled_weekly_hours"
      expr: AVG(CAST(scheduled_weekly_hours AS DOUBLE))
      comment: "Average scheduled weekly hours per assignment. Supports workforce capacity modeling and overtime risk assessment."
    - name: "union_member_assignment_count"
      expr: COUNT(CASE WHEN union_membership_flag = TRUE THEN assignment_id END)
      comment: "Number of union member assignments. Informs collective bargaining scope and labor agreement compliance monitoring."
    - name: "termination_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN assignment_id END)
      comment: "Number of terminated assignments. Attrition volume metric for workforce stability and retention program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition analytics covering open requisitions, time-to-fill, salary range competitiveness, and sourcing effectiveness. Supports recruiting strategy, headcount planning, and talent pipeline management."
  source: "`vibe_manufacturing_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status (Open, Filled, Cancelled) for recruiting pipeline management."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Requisition type (Backfill, New Headcount, Replacement) for headcount growth vs. attrition analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type being recruited for workforce mix planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority for recruiting resource allocation and escalation management."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel (Internal, External, Agency) for recruiting channel effectiveness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for headcount authorization compliance and budget control."
    - name: "opened_month"
      expr: DATE_TRUNC('month', opened_date)
      comment: "Month requisition was opened for recruiting volume trend analysis."
  measures:
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Open' AND is_active = TRUE THEN requisition_id END)
      comment: "Total open requisitions. Measures unfilled headcount demand and recruiting backlog impacting operational capacity."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST(salary_range_min AS DOUBLE) + CAST(salary_range_max AS DOUBLE)) / 2.0
      comment: "Average salary range midpoint across open requisitions. Informs compensation budget planning and market competitiveness assessment."
    - name: "avg_salary_range_spread"
      expr: AVG(CAST(salary_range_max AS DOUBLE) - CAST(salary_range_min AS DOUBLE))
      comment: "Average salary range spread (max minus min). Wider spreads indicate greater compensation flexibility or role complexity."
    - name: "security_clearance_required_count"
      expr: COUNT(CASE WHEN security_clearance_required = TRUE THEN requisition_id END)
      comment: "Number of requisitions requiring security clearance. Identifies specialized recruiting pipeline constraints and longer time-to-fill risk."
    - name: "internal_only_posting_count"
      expr: COUNT(CASE WHEN internal_posting_only = TRUE THEN requisition_id END)
      comment: "Number of internal-only postings. Measures internal mobility program utilization and career development investment."
    - name: "avg_travel_percentage"
      expr: AVG(CAST(travel_percentage AS DOUBLE))
      comment: "Average travel requirement percentage across requisitions. Informs candidate pool sizing and compensation premium planning for high-travel roles."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program analytics covering course portfolio, cost efficiency, compliance coverage, and delivery effectiveness. Supports L&D investment decisions, regulatory compliance, and workforce capability building."
  source: "`vibe_manufacturing_v1`.`workforce`.`training_course`"
  dimensions:
    - name: "course_status"
      expr: course_status
      comment: "Course status (Active, Retired, Draft) for training catalog management."
    - name: "course_type"
      expr: course_type
      comment: "Course type (Instructor-Led, eLearning, On-the-Job) for delivery channel analysis."
    - name: "course_category"
      expr: course_category
      comment: "Course category (Safety, Technical, Leadership, Compliance) for training portfolio analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for cost-per-participant benchmarking across modalities."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory compliance framework the course supports for compliance coverage mapping."
    - name: "recurrence_required"
      expr: recurrence_required
      comment: "Recurrence requirement flag for ongoing training obligation planning."
    - name: "certification_awarded"
      expr: certification_awarded
      comment: "Whether course awards a certification for skills credentialing program analysis."
  measures:
    - name: "active_course_count"
      expr: COUNT(CASE WHEN course_status = 'Active' THEN training_course_id END)
      comment: "Total active training courses in the catalog. Measures breadth of workforce development offerings."
    - name: "avg_cost_per_participant"
      expr: AVG(CAST(cost_per_participant AS DOUBLE))
      comment: "Average training cost per participant. Key L&D efficiency metric for budget optimization and vendor negotiation."
    - name: "total_course_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours available across the course catalog. Measures training investment capacity and workforce development depth."
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across courses. Informs assessment rigor and quality standards for certification programs."
    - name: "compliance_course_count"
      expr: COUNT(CASE WHEN compliance_framework IS NOT NULL AND compliance_framework != '' THEN training_course_id END)
      comment: "Number of courses tied to a regulatory compliance framework. Measures regulatory training coverage for audit readiness."
    - name: "certification_awarding_course_count"
      expr: COUNT(CASE WHEN certification_awarded = TRUE THEN training_course_id END)
      comment: "Number of courses that award certifications. Supports workforce credentialing strategy and skills verification program design."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling analytics covering productive hours, overtime scheduling, schedule exceptions, and labor cost center allocation. Supports production capacity planning, scheduling efficiency, and labor cost management."
  source: "`vibe_manufacturing_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status (Published, Confirmed, Cancelled) for scheduling pipeline management."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day, Night, Weekend) for shift mix and premium cost analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Overtime schedule flag for overtime volume and cost exposure analysis."
    - name: "is_night_shift"
      expr: is_night_shift
      comment: "Night shift flag for shift differential cost and workforce health impact analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday shift flag for holiday premium cost tracking and scheduling compliance."
    - name: "schedule_month"
      expr: schedule_month
      comment: "Schedule month for seasonal workforce demand and capacity trend analysis."
    - name: "schedule_exception_flag"
      expr: schedule_exception_flag
      comment: "Exception flag for identifying scheduling disruptions requiring management attention."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Total scheduled labor hours. Primary capacity planning metric linking workforce availability to production demand."
    - name: "total_net_productive_hours"
      expr: SUM(CAST(net_productive_hours AS DOUBLE))
      comment: "Total net productive hours after breaks. Actual available labor capacity for production scheduling and OEE calculation."
    - name: "avg_net_productive_hours_per_shift"
      expr: AVG(CAST(net_productive_hours AS DOUBLE))
      comment: "Average net productive hours per scheduled shift. Efficiency benchmark for shift design and break policy optimization."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN shift_schedule_id END)
      comment: "Number of overtime shifts scheduled. Elevated overtime scheduling signals capacity shortfall requiring headcount or scheduling intervention."
    - name: "schedule_exception_count"
      expr: COUNT(CASE WHEN schedule_exception_flag = TRUE THEN shift_schedule_id END)
      comment: "Number of schedule exceptions. High exception rates indicate scheduling instability impacting production reliability."
    - name: "cancelled_shift_count"
      expr: COUNT(CASE WHEN schedule_status = 'Cancelled' THEN shift_schedule_id END)
      comment: "Number of cancelled shifts. Cancellations represent lost productive capacity and may indicate demand volatility or workforce availability issues."
    - name: "productive_hours_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(net_productive_hours AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_duration_hours AS DOUBLE)), 0), 2)
      comment: "Net productive hours as a percentage of total scheduled hours. Measures scheduling efficiency and break/non-productive time ratio."
$$;