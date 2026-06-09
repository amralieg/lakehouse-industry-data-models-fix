-- Metric views for domain: employee | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_staff_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount and demographic metrics for workforce planning and compliance reporting"
  source: "`staffing_hr_ecm`.`employee`.`staff_profile`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type classification (Full-Time, Part-Time, Contract, etc.)"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (Exempt, Non-Exempt) for compliance reporting"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity and EEO reporting"
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO-1 job category for regulatory compliance"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for diversity reporting"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for ADA compliance"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for trend analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for termination for retention analysis"
    - name: "rehire_flag"
      expr: rehire_flag
      comment: "Indicates if employee is a rehire"
    - name: "country_code"
      expr: country_code
      comment: "Country of employee location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of employee location"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT staff_profile_id)
      comment: "Total unique employee count for workforce sizing"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN staff_profile_id END)
      comment: "Count of active employees for current workforce capacity"
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN staff_profile_id END)
      comment: "Count of terminated employees for attrition analysis"
    - name: "rehire_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_flag = TRUE THEN staff_profile_id END)
      comment: "Count of rehired employees for retention quality assessment"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days for retention analysis"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation and pay equity metrics for total rewards strategy and compliance"
  source: "`staffing_hr_ecm`.`employee`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (Salary, Hourly, Commission, etc.)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (Weekly, Bi-Weekly, Monthly, etc.)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade or band for compensation structure analysis"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification for overtime eligibility"
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates if employee is eligible for overtime pay"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation for multi-currency analysis"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change (Promotion, Merit, Market Adjustment, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year compensation became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month compensation became effective"
    - name: "is_current_record"
      expr: is_current_record
      comment: "Indicates if this is the current compensation record"
    - name: "job_title"
      expr: job_title
      comment: "Job title for pay equity analysis"
    - name: "department_code"
      expr: department_code
      comment: "Department code for cost center analysis"
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary spend for budget planning"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary for market competitiveness analysis"
    - name: "median_base_salary"
      expr: PERCENTILE(CAST(base_salary_amount AS DOUBLE), 0.5)
      comment: "Median base salary for pay equity assessment"
    - name: "total_target_bonus"
      expr: SUM(CAST(target_bonus_amount AS DOUBLE))
      comment: "Total target bonus spend for incentive budget planning"
    - name: "avg_target_bonus_pct"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus as percentage of base for incentive design"
    - name: "avg_compa_ratio"
      expr: AVG(CAST(compa_ratio AS DOUBLE))
      comment: "Average compa-ratio for pay positioning vs market midpoint"
    - name: "total_hourly_rate_spend"
      expr: SUM(CAST(hourly_rate AS DOUBLE))
      comment: "Total hourly rate spend for contingent workforce budgeting"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for market rate benchmarking"
    - name: "compensation_change_count"
      expr: COUNT(DISTINCT compensation_id)
      comment: "Count of compensation changes for merit cycle tracking"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management and talent assessment metrics for workforce development and succession planning"
  source: "`staffing_hr_ecm`.`employee`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of performance review (Draft, Completed, Acknowledged, etc.)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (Annual, Mid-Year, Probationary, etc.)"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Review cycle classification for trend analysis"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating (Exceeds, Meets, Needs Improvement, etc.)"
    - name: "competency_rating_technical"
      expr: competency_rating_technical
      comment: "Technical competency rating for skill gap analysis"
    - name: "competency_rating_leadership"
      expr: competency_rating_leadership
      comment: "Leadership competency rating for succession planning"
    - name: "competency_rating_teamwork"
      expr: competency_rating_teamwork
      comment: "Teamwork competency rating for culture assessment"
    - name: "competency_rating_communication"
      expr: competency_rating_communication
      comment: "Communication competency rating for development planning"
    - name: "pip_initiated_flag"
      expr: pip_initiated_flag
      comment: "Indicates if performance improvement plan was initiated"
    - name: "promotion_triggered_flag"
      expr: promotion_triggered_flag
      comment: "Indicates if review triggered a promotion"
    - name: "compensation_change_triggered_flag"
      expr: compensation_change_triggered_flag
      comment: "Indicates if review triggered compensation change"
    - name: "succession_planning_flag"
      expr: succession_planning_flag
      comment: "Indicates if employee is flagged for succession planning"
    - name: "review_period_year"
      expr: YEAR(review_period_start_date)
      comment: "Year of review period for trend analysis"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month review was completed for cycle tracking"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total count of performance reviews for completion tracking"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed reviews for cycle compliance"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score for performance distribution analysis"
    - name: "avg_kpi_achievement_pct"
      expr: AVG(CAST(kpi_achievement_percentage AS DOUBLE))
      comment: "Average KPI achievement percentage for goal effectiveness"
    - name: "pip_initiation_rate"
      expr: COUNT(DISTINCT CASE WHEN pip_initiated_flag = TRUE THEN performance_review_id END)
      comment: "Count of PIPs initiated for performance intervention tracking"
    - name: "promotion_rate"
      expr: COUNT(DISTINCT CASE WHEN promotion_triggered_flag = TRUE THEN performance_review_id END)
      comment: "Count of promotions triggered for talent mobility"
    - name: "succession_candidate_count"
      expr: COUNT(DISTINCT CASE WHEN succession_planning_flag = TRUE THEN performance_review_id END)
      comment: "Count of succession planning candidates for pipeline strength"
    - name: "avg_goals_met_count"
      expr: AVG(CAST(goals_met_count AS DOUBLE))
      comment: "Average number of goals met per review for goal-setting effectiveness"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_commission_earning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales commission and incentive compensation metrics for revenue team performance and cost management"
  source: "`staffing_hr_ecm`.`employee`.`commission_earning`"
  dimensions:
    - name: "earning_event_type"
      expr: earning_event_type
      comment: "Type of commission earning event (Placement, Invoice, Milestone, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of commission (Pending, Paid, Held, Clawed Back, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for commission governance"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates if commission is disputed"
    - name: "accelerator_applied"
      expr: accelerator_applied
      comment: "Indicates if accelerator rate was applied"
    - name: "tier_level"
      expr: tier_level
      comment: "Commission tier level for performance segmentation"
    - name: "split_reason"
      expr: split_reason
      comment: "Reason for commission split (Team Sale, Referral, etc.)"
    - name: "earning_year"
      expr: YEAR(earning_date)
      comment: "Year commission was earned for annual planning"
    - name: "earning_month"
      expr: DATE_TRUNC('MONTH', earning_date)
      comment: "Month commission was earned for trend analysis"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month commission was paid for cash flow analysis"
    - name: "basis_currency_code"
      expr: basis_currency_code
      comment: "Currency of commission basis for multi-currency analysis"
  measures:
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total gross commission earned for incentive spend tracking"
    - name: "total_net_commission_amount"
      expr: SUM(CAST(net_commission_amount AS DOUBLE))
      comment: "Total net commission after adjustments for actual payout"
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total basis amount for commission calculation validation"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate for plan effectiveness"
    - name: "avg_accelerator_rate"
      expr: AVG(CAST(accelerator_rate AS DOUBLE))
      comment: "Average accelerator rate for high-performer incentive analysis"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total commission adjustments for plan accuracy assessment"
    - name: "dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN commission_earning_id END)
      comment: "Count of disputed commissions for plan clarity issues"
    - name: "clawback_count"
      expr: COUNT(DISTINCT CASE WHEN clawback_date IS NOT NULL THEN commission_earning_id END)
      comment: "Count of clawed-back commissions for risk management"
    - name: "total_earnings"
      expr: COUNT(DISTINCT commission_earning_id)
      comment: "Total commission earning transactions for volume tracking"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave and absence management metrics for workforce capacity planning and compliance"
  source: "`staffing_hr_ecm`.`employee`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (Vacation, Sick, FMLA, Parental, etc.)"
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Subtype of leave for detailed analysis"
    - name: "request_status"
      expr: request_status
      comment: "Status of leave request (Pending, Approved, Denied, Cancelled, etc.)"
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Indicates if leave is paid"
    - name: "is_fmla_eligible"
      expr: is_fmla_eligible
      comment: "Indicates if leave is FMLA-eligible for compliance tracking"
    - name: "is_intermittent_leave"
      expr: is_intermittent_leave
      comment: "Indicates if leave is intermittent"
    - name: "benefits_continuation_flag"
      expr: benefits_continuation_flag
      comment: "Indicates if benefits continue during leave"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of required documentation for compliance"
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for leave denial for policy review"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year leave was requested for trend analysis"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month leave was requested for seasonal pattern analysis"
    - name: "leave_start_month"
      expr: DATE_TRUNC('MONTH', leave_start_date)
      comment: "Month leave started for capacity planning"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total leave requests for volume tracking"
    - name: "approved_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'Approved' THEN leave_request_id END)
      comment: "Count of approved leave requests for approval rate analysis"
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total days of leave requested for capacity impact"
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total days of leave actually taken for utilization analysis"
    - name: "total_hours_requested"
      expr: SUM(CAST(total_hours_requested AS DOUBLE))
      comment: "Total hours of leave requested for detailed capacity planning"
    - name: "total_hours_taken"
      expr: SUM(CAST(actual_hours_taken AS DOUBLE))
      comment: "Total hours of leave taken for actual absence tracking"
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(total_days_requested AS DOUBLE))
      comment: "Average leave duration in days for policy design"
    - name: "fmla_leave_count"
      expr: COUNT(DISTINCT CASE WHEN is_fmla_eligible = TRUE THEN leave_request_id END)
      comment: "Count of FMLA-eligible leaves for compliance reporting"
    - name: "total_fmla_hours_ytd"
      expr: SUM(CAST(fmla_hours_used_ytd AS DOUBLE))
      comment: "Total FMLA hours used year-to-date for entitlement tracking"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_internal_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment and hiring pipeline metrics for talent acquisition effectiveness and workforce planning"
  source: "`staffing_hr_ecm`.`employee`.`internal_requisition`"
  dimensions:
    - name: "req_status"
      expr: req_status
      comment: "Status of requisition (Open, Filled, Cancelled, On Hold, etc.)"
    - name: "req_type"
      expr: req_type
      comment: "Type of requisition (New Hire, Replacement, Backfill, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for requisition governance"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for requisition (Full-Time, Part-Time, Contract, etc.)"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA status for compensation planning"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of requisition for resource allocation"
    - name: "eeoc_job_category"
      expr: eeoc_job_category
      comment: "EEO-1 job category for compliance reporting"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (On-Site, Remote, Hybrid, etc.)"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Primary sourcing channel for recruitment effectiveness"
    - name: "closure_reason"
      expr: closure_reason
      comment: "Reason for requisition closure for pipeline analysis"
    - name: "req_open_year"
      expr: YEAR(req_open_date)
      comment: "Year requisition was opened for trend analysis"
    - name: "req_open_month"
      expr: DATE_TRUNC('MONTH', req_open_date)
      comment: "Month requisition was opened for seasonal pattern analysis"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT internal_requisition_id)
      comment: "Total requisitions for hiring volume tracking"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN req_status = 'Open' THEN internal_requisition_id END)
      comment: "Count of open requisitions for current pipeline capacity"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN req_status = 'Filled' THEN internal_requisition_id END)
      comment: "Count of filled requisitions for hiring effectiveness"
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS DOUBLE))
      comment: "Total number of openings across all requisitions for capacity planning"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average time to fill in days for recruitment efficiency"
    - name: "avg_min_salary"
      expr: AVG(CAST(min_salary AS DOUBLE))
      comment: "Average minimum salary for budget planning"
    - name: "avg_max_salary"
      expr: AVG(CAST(max_salary AS DOUBLE))
      comment: "Average maximum salary for budget planning"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated for hiring for financial planning"
    - name: "cancelled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN req_status = 'Cancelled' THEN internal_requisition_id END)
      comment: "Count of cancelled requisitions for process waste analysis"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics for workforce capability building and compliance training tracking"
  source: "`staffing_hr_ecm`.`employee`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of training completion (Completed, In Progress, Not Started, Failed, etc.)"
    - name: "training_category"
      expr: training_category
      comment: "Category of training for skill development tracking"
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Delivery method (Online, Classroom, Virtual, On-the-Job, etc.)"
    - name: "training_provider"
      expr: training_provider
      comment: "Training provider for vendor management"
    - name: "is_compliance_required"
      expr: is_compliance_required
      comment: "Indicates if training is compliance-required"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework (OSHA, SOX, GDPR, etc.)"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Indicates if certificate was issued"
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Indicates if recertification is required"
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of training assessment (Pass, Fail, etc.)"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for trend analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for seasonal pattern analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of completion for throughput tracking"
  measures:
    - name: "total_training_enrollments"
      expr: COUNT(DISTINCT training_completion_id)
      comment: "Total training enrollments for L&D investment tracking"
    - name: "completed_trainings"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'Completed' THEN training_completion_id END)
      comment: "Count of completed trainings for completion rate analysis"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage for engagement tracking"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for training effectiveness"
    - name: "avg_employee_rating"
      expr: AVG(CAST(employee_rating AS DOUBLE))
      comment: "Average employee rating for training quality assessment"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered for capacity utilization"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration for program design"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost for L&D budget management"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per enrollment for ROI analysis"
    - name: "compliance_training_count"
      expr: COUNT(DISTINCT CASE WHEN is_compliance_required = TRUE THEN training_completion_id END)
      comment: "Count of compliance trainings for regulatory adherence"
    - name: "certificate_issued_count"
      expr: COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN training_completion_id END)
      comment: "Count of certificates issued for credential tracking"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_org_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational change and employee movement metrics for workforce mobility and retention analysis"
  source: "`staffing_hr_ecm`.`employee`.`org_change_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of organizational change event (Promotion, Transfer, Demotion, Termination, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Status of change event (Pending, Approved, Completed, Cancelled, etc.)"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for organizational change"
    - name: "is_termination_event"
      expr: is_termination_event
      comment: "Indicates if event is a termination"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (Voluntary, Involuntary, Retirement, etc.)"
    - name: "compensation_change_triggered_flag"
      expr: compensation_change_triggered_flag
      comment: "Indicates if event triggered compensation change"
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Indicates if employee is eligible for rehire"
    - name: "changed_attribute_name"
      expr: changed_attribute_name
      comment: "Name of attribute that changed (Job Title, Department, Manager, etc.)"
    - name: "prior_employment_type"
      expr: prior_employment_type
      comment: "Employment type before change"
    - name: "new_employment_type"
      expr: new_employment_type
      comment: "Employment type after change"
    - name: "event_year"
      expr: YEAR(event_effective_date)
      comment: "Year event became effective for trend analysis"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_effective_date)
      comment: "Month event became effective for seasonal pattern analysis"
  measures:
    - name: "total_org_change_events"
      expr: COUNT(DISTINCT org_change_event_id)
      comment: "Total organizational change events for mobility tracking"
    - name: "termination_events"
      expr: COUNT(DISTINCT CASE WHEN is_termination_event = TRUE THEN org_change_event_id END)
      comment: "Count of termination events for attrition analysis"
    - name: "voluntary_terminations"
      expr: COUNT(DISTINCT CASE WHEN termination_type = 'Voluntary' THEN org_change_event_id END)
      comment: "Count of voluntary terminations for retention strategy"
    - name: "involuntary_terminations"
      expr: COUNT(DISTINCT CASE WHEN termination_type = 'Involuntary' THEN org_change_event_id END)
      comment: "Count of involuntary terminations for performance management"
    - name: "promotion_events"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Promotion' THEN org_change_event_id END)
      comment: "Count of promotions for internal mobility tracking"
    - name: "transfer_events"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Transfer' THEN org_change_event_id END)
      comment: "Count of transfers for organizational fluidity"
    - name: "compensation_change_events"
      expr: COUNT(DISTINCT CASE WHEN compensation_change_triggered_flag = TRUE THEN org_change_event_id END)
      comment: "Count of events triggering compensation changes for total rewards impact"
    - name: "avg_prior_value"
      expr: AVG(CAST(prior_value AS DOUBLE))
      comment: "Average prior value for change magnitude analysis"
    - name: "avg_new_value"
      expr: AVG(CAST(new_value AS DOUBLE))
      comment: "Average new value for change magnitude analysis"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee engagement and sentiment metrics for culture assessment and retention strategy"
  source: "`staffing_hr_ecm`.`employee`.`survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (Engagement, Pulse, Exit, Onboarding, etc.)"
    - name: "survey_name"
      expr: survey_name
      comment: "Name of survey for campaign tracking"
    - name: "response_status"
      expr: response_status
      comment: "Status of survey response (Completed, Partial, Not Started, etc.)"
    - name: "enps_category"
      expr: enps_category
      comment: "eNPS category (Promoter, Passive, Detractor) for loyalty segmentation"
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Indicates if survey is anonymous"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of respondent for segment analysis"
    - name: "response_channel"
      expr: response_channel
      comment: "Channel used to respond (Web, Mobile, Email, etc.)"
    - name: "vendor"
      expr: vendor
      comment: "Survey vendor for platform comparison"
    - name: "action_plan_required"
      expr: action_plan_required
      comment: "Indicates if action plan is required based on results"
    - name: "follow_up_requested"
      expr: follow_up_requested
      comment: "Indicates if respondent requested follow-up"
    - name: "invitation_year"
      expr: YEAR(invitation_date)
      comment: "Year survey was sent for trend analysis"
    - name: "invitation_month"
      expr: DATE_TRUNC('MONTH', invitation_date)
      comment: "Month survey was sent for campaign tracking"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month response was received for completion tracking"
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(DISTINCT survey_id)
      comment: "Total surveys sent for participation tracking"
    - name: "completed_surveys"
      expr: COUNT(DISTINCT CASE WHEN response_status = 'Completed' THEN survey_id END)
      comment: "Count of completed surveys for response rate calculation"
    - name: "avg_overall_engagement_score"
      expr: AVG(CAST(overall_engagement_score AS DOUBLE))
      comment: "Average overall engagement score for culture health assessment"
    - name: "avg_manager_effectiveness_score"
      expr: AVG(CAST(manager_effectiveness_score AS DOUBLE))
      comment: "Average manager effectiveness score for leadership development"
    - name: "avg_career_development_score"
      expr: AVG(CAST(career_development_score AS DOUBLE))
      comment: "Average career development score for retention strategy"
    - name: "avg_compensation_satisfaction_score"
      expr: AVG(CAST(compensation_satisfaction_score AS DOUBLE))
      comment: "Average compensation satisfaction for total rewards effectiveness"
    - name: "avg_work_life_balance_score"
      expr: AVG(CAST(work_life_balance_score AS DOUBLE))
      comment: "Average work-life balance score for wellbeing assessment"
    - name: "avg_culture_score"
      expr: AVG(CAST(culture_score AS DOUBLE))
      comment: "Average culture score for organizational health"
    - name: "avg_collaboration_score"
      expr: AVG(CAST(collaboration_score AS DOUBLE))
      comment: "Average collaboration score for teamwork effectiveness"
    - name: "avg_recognition_score"
      expr: AVG(CAST(recognition_score AS DOUBLE))
      comment: "Average recognition score for rewards program effectiveness"
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN enps_category = 'Promoter' THEN survey_id END)
      comment: "Count of promoters for eNPS calculation"
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN enps_category = 'Detractor' THEN survey_id END)
      comment: "Count of detractors for eNPS calculation"
    - name: "avg_response_completion_pct"
      expr: AVG(CAST(response_completion_percentage AS DOUBLE))
      comment: "Average response completion percentage for survey design quality"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`employee_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team structure and performance metrics for organizational design and capacity planning"
  source: "`staffing_hr_ecm`.`employee`.`team`"
  dimensions:
    - name: "team_status"
      expr: team_status
      comment: "Status of team (Active, Inactive, Forming, Disbanding, etc.)"
    - name: "team_type"
      expr: team_type
      comment: "Type of team (Permanent, Project, Cross-Functional, etc.)"
    - name: "vertical_focus"
      expr: vertical_focus
      comment: "Industry vertical focus for specialization tracking"
    - name: "collaboration_model"
      expr: collaboration_model
      comment: "Collaboration model (Co-located, Distributed, Hybrid, etc.)"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (On-Site, Remote, Hybrid, etc.)"
    - name: "service_level_agreement_tier"
      expr: service_level_agreement_tier
      comment: "SLA tier for service quality tracking"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market served by team"
    - name: "specialization_tags"
      expr: specialization_tags
      comment: "Specialization tags for capability mapping"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year team became effective for lifecycle analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month team became effective for formation tracking"
  measures:
    - name: "total_teams"
      expr: COUNT(DISTINCT team_id)
      comment: "Total teams for organizational structure tracking"
    - name: "active_teams"
      expr: COUNT(DISTINCT CASE WHEN team_status = 'Active' THEN team_id END)
      comment: "Count of active teams for current capacity"
    - name: "total_current_headcount"
      expr: SUM(CAST(current_headcount AS DOUBLE))
      comment: "Total current headcount across teams for workforce sizing"
    - name: "total_target_headcount"
      expr: SUM(CAST(target_headcount AS DOUBLE))
      comment: "Total target headcount for hiring gap analysis"
    - name: "avg_current_headcount"
      expr: AVG(CAST(current_headcount AS DOUBLE))
      comment: "Average current headcount per team for span of control"
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target_annual AS DOUBLE))
      comment: "Total annual revenue target for business planning"
    - name: "avg_revenue_target"
      expr: AVG(CAST(revenue_target_annual AS DOUBLE))
      comment: "Average revenue target per team for quota setting"
    - name: "total_placement_target"
      expr: SUM(CAST(placement_target_annual AS DOUBLE))
      comment: "Total annual placement target for capacity planning"
    - name: "avg_quality_of_submission_target"
      expr: AVG(CAST(quality_of_submission_target_pct AS DOUBLE))
      comment: "Average quality of submission target for performance standards"
    - name: "avg_time_to_fill_target"
      expr: AVG(CAST(time_to_fill_target_days AS DOUBLE))
      comment: "Average time-to-fill target for efficiency benchmarking"
$$;