-- Metric views for domain: workforce | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, compensation, and demographic distribution for strategic workforce planning and DEI analysis"
  source: "`life_insurance_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type classification (Full-Time, Part-Time, Contract, etc.)"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification (Exempt, Non-Exempt) for overtime eligibility"
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO job category for regulatory reporting"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity analysis"
    - name: "ethnicity"
      expr: ethnicity
      comment: "Ethnicity for diversity and inclusion metrics"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for compliance and diversity reporting"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for ADA compliance and inclusion metrics"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade level for compensation analysis"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort and retention analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition trend analysis"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count - primary workforce sizing metric"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees for current workforce capacity"
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees for attrition analysis"
    - name: "total_annual_base_salary"
      expr: SUM(CAST(annual_base_salary AS DOUBLE))
      comment: "Total annual base salary spend across workforce"
    - name: "avg_annual_base_salary"
      expr: AVG(CAST(annual_base_salary AS DOUBLE))
      comment: "Average annual base salary per employee for compensation benchmarking"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly workforce compensation analysis"
    - name: "avg_tenure_days"
      expr: AVG(CAST(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date) AS DOUBLE))
      comment: "Average employee tenure in days for retention and experience analysis"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation and pay equity metrics including base salary, bonuses, merit increases, and pay band distribution for total rewards strategy and compliance"
  source: "`life_insurance_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (Base, Bonus, Commission, etc.)"
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of compensation record (Active, Pending, Superseded)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (Weekly, Bi-Weekly, Monthly, etc.)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade for compensation structure analysis"
    - name: "pay_band"
      expr: pay_band
      comment: "Pay band within grade for market positioning"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification for overtime eligibility"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency compensation analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year compensation became effective for trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month compensation became effective for cycle analysis"
    - name: "commission_eligible_flag"
      expr: commission_eligible
      comment: "Whether employee is eligible for commission"
    - name: "overtime_eligible_flag"
      expr: overtime_eligible
      comment: "Whether employee is eligible for overtime pay"
  measures:
    - name: "total_compensation_records"
      expr: COUNT(DISTINCT compensation_id)
      comment: "Total unique compensation records for audit and tracking"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary across all compensation records"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary for benchmarking and pay equity analysis"
    - name: "total_annualized_base"
      expr: SUM(CAST(annualized_base AS DOUBLE))
      comment: "Total annualized base compensation for budget planning"
    - name: "avg_annualized_base"
      expr: AVG(CAST(annualized_base AS DOUBLE))
      comment: "Average annualized base for total rewards analysis"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly workforce compensation"
    - name: "avg_target_bonus_pct"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus percentage for incentive plan design"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage for capacity planning"
    - name: "avg_compa_ratio"
      expr: AVG(CAST(compa_ratio AS DOUBLE))
      comment: "Average compa-ratio (actual pay vs midpoint) for pay equity and market positioning"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(last_merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage for compensation trend analysis"
    - name: "avg_market_percentile"
      expr: AVG(CAST(market_reference_percentile AS DOUBLE))
      comment: "Average market reference percentile for competitive positioning"
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average standard hours per week for workload and capacity analysis"
    - name: "commission_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN commission_eligible = TRUE THEN compensation_id END)
      comment: "Count of commission-eligible compensation records for sales force sizing"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition metrics including time-to-fill, requisition status, hiring velocity, and recruitment pipeline health for workforce planning and TA effectiveness"
  source: "`life_insurance_ecm`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of requisition (Open, Filled, Cancelled, etc.)"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (New Hire, Replacement, Backfill, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for requisition workflow tracking"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for requisition (Full-Time, Part-Time, Contract)"
    - name: "job_family"
      expr: job_family
      comment: "Job family for talent pipeline analysis"
    - name: "job_level"
      expr: job_level
      comment: "Job level for seniority-based hiring metrics"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation and urgency tracking"
    - name: "is_critical_role"
      expr: is_critical_role
      comment: "Whether requisition is for a critical role requiring expedited hiring"
    - name: "requires_insurance_license"
      expr: requires_insurance_license
      comment: "Whether role requires insurance license for compliance tracking"
    - name: "requires_finra_registration"
      expr: requires_finra_registration
      comment: "Whether role requires FINRA registration for regulatory compliance"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year requisition was opened for trend analysis"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened for seasonal hiring patterns"
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year for headcount planning alignment"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT requisition_id)
      comment: "Total unique requisitions for hiring volume tracking"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN requisition_id END)
      comment: "Count of open requisitions for current hiring pipeline"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN requisition_id END)
      comment: "Count of filled requisitions for hiring success rate"
    - name: "cancelled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Cancelled' THEN requisition_id END)
      comment: "Count of cancelled requisitions for hiring plan volatility"
    - name: "critical_role_requisitions"
      expr: COUNT(DISTINCT CASE WHEN is_critical_role = TRUE THEN requisition_id END)
      comment: "Count of critical role requisitions for priority hiring focus"
    - name: "total_fte_count"
      expr: SUM(CAST(fte_count AS DOUBLE))
      comment: "Total FTE count across all requisitions for capacity planning"
    - name: "avg_fte_per_requisition"
      expr: AVG(CAST(fte_count AS DOUBLE))
      comment: "Average FTE per requisition for hiring scope analysis"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(actual_time_to_fill_days AS DOUBLE))
      comment: "Average actual time-to-fill in days - key TA efficiency metric"
    - name: "avg_salary_range_minimum"
      expr: AVG(CAST(salary_range_minimum AS DOUBLE))
      comment: "Average minimum salary range for compensation planning"
    - name: "avg_salary_range_maximum"
      expr: AVG(CAST(salary_range_maximum AS DOUBLE))
      comment: "Average maximum salary range for budget forecasting"
    - name: "avg_salary_range_spread"
      expr: AVG(CAST(salary_range_maximum - salary_range_minimum AS DOUBLE))
      comment: "Average salary range spread for pay equity and market competitiveness"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_candidate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate pipeline and recruitment funnel metrics including application volume, conversion rates, and time-to-hire for talent acquisition optimization"
  source: "`life_insurance_ecm`.`workforce`.`candidate`"
  dimensions:
    - name: "candidate_status"
      expr: candidate_status
      comment: "Current candidate status in recruitment pipeline"
    - name: "source_channel"
      expr: source_channel
      comment: "Source channel for candidate acquisition (Referral, Job Board, Agency, etc.)"
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest education level for qualification analysis"
    - name: "eeoc_gender"
      expr: eeoc_gender
      comment: "EEOC gender for diversity pipeline tracking"
    - name: "eeoc_ethnicity"
      expr: eeoc_ethnicity
      comment: "EEOC ethnicity for diversity sourcing analysis"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for diversity and compliance"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for inclusion metrics"
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status for compliance and eligibility"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for hiring process tracking"
    - name: "drug_test_status"
      expr: drug_test_status
      comment: "Drug test status for compliance and safety-sensitive roles"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application for trend analysis"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application for seasonal sourcing patterns"
    - name: "willing_to_relocate"
      expr: willing_to_relocate_flag
      comment: "Whether candidate is willing to relocate for geographic hiring strategy"
  measures:
    - name: "total_candidates"
      expr: COUNT(DISTINCT candidate_id)
      comment: "Total unique candidates in pipeline for sourcing volume"
    - name: "candidates_with_offers"
      expr: COUNT(DISTINCT CASE WHEN offer_extended_date IS NOT NULL THEN candidate_id END)
      comment: "Count of candidates who received offers for conversion funnel"
    - name: "candidates_offer_accepted"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_date IS NOT NULL THEN candidate_id END)
      comment: "Count of candidates who accepted offers for hiring success"
    - name: "candidates_offer_declined"
      expr: COUNT(DISTINCT CASE WHEN offer_declined_date IS NOT NULL THEN candidate_id END)
      comment: "Count of candidates who declined offers for offer competitiveness analysis"
    - name: "candidates_started"
      expr: COUNT(DISTINCT CASE WHEN actual_start_date IS NOT NULL THEN candidate_id END)
      comment: "Count of candidates who actually started for final conversion rate"
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience for candidate quality assessment"
    - name: "avg_salary_expectation"
      expr: AVG(CAST(salary_expectation_amount AS DOUBLE))
      comment: "Average salary expectation for compensation competitiveness"
    - name: "avg_days_application_to_offer"
      expr: AVG(CAST(DATEDIFF(offer_extended_date, application_date) AS DOUBLE))
      comment: "Average days from application to offer for recruitment velocity"
    - name: "avg_days_offer_to_acceptance"
      expr: AVG(CAST(DATEDIFF(offer_accepted_date, offer_extended_date) AS DOUBLE))
      comment: "Average days from offer to acceptance for offer decision speed"
    - name: "avg_days_acceptance_to_start"
      expr: AVG(CAST(DATEDIFF(actual_start_date, offer_accepted_date) AS DOUBLE))
      comment: "Average days from acceptance to start for onboarding lead time"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_performance_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics including goal achievement, performance ratings, and objective completion for talent development and organizational effectiveness"
  source: "`life_insurance_ecm`.`workforce`.`performance_goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of performance goal (Active, Completed, Cancelled, etc.)"
    - name: "goal_type"
      expr: goal_type
      comment: "Type of goal (Individual, Team, Organizational, etc.)"
    - name: "goal_category"
      expr: goal_category
      comment: "Category of goal for strategic alignment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for goal governance"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating for goal achievement"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether goal is mandatory for compliance tracking"
    - name: "is_stretch_goal"
      expr: is_stretch_goal
      comment: "Whether goal is a stretch goal for high-performer development"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year goal started for performance cycle analysis"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year goal is targeted for completion"
  measures:
    - name: "total_goals"
      expr: COUNT(DISTINCT performance_goal_id)
      comment: "Total unique performance goals for goal-setting volume"
    - name: "completed_goals"
      expr: COUNT(DISTINCT CASE WHEN goal_status = 'Completed' THEN performance_goal_id END)
      comment: "Count of completed goals for achievement tracking"
    - name: "active_goals"
      expr: COUNT(DISTINCT CASE WHEN goal_status = 'Active' THEN performance_goal_id END)
      comment: "Count of active goals for current performance focus"
    - name: "stretch_goals"
      expr: COUNT(DISTINCT CASE WHEN is_stretch_goal = TRUE THEN performance_goal_id END)
      comment: "Count of stretch goals for high-performer engagement"
    - name: "avg_achievement_pct"
      expr: AVG(CAST(achievement_percentage AS DOUBLE))
      comment: "Average achievement percentage - key performance effectiveness metric"
    - name: "avg_weight_pct"
      expr: AVG(CAST(weight_percentage AS DOUBLE))
      comment: "Average goal weight percentage for priority distribution"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for goal ambition level"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value for goal outcome measurement"
    - name: "avg_days_to_complete"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, start_date) AS DOUBLE))
      comment: "Average days to complete goals for execution velocity"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics including training completion rates, compliance training, and skill development for workforce capability building"
  source: "`life_insurance_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Enrolled, Completed, Withdrawn, etc.)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (Mandatory, Voluntary, etc.)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (Online, In-Person, Hybrid, etc.)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail status for training effectiveness"
    - name: "mandatory_compliance_flag"
      expr: mandatory_compliance_flag
      comment: "Whether training is mandatory for compliance"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether certificate was issued for credential tracking"
    - name: "manager_approval_flag"
      expr: manager_approval_flag
      comment: "Whether manager approved enrollment for governance"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for training trend analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for seasonal training patterns"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of completion for training effectiveness tracking"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total unique training enrollments for L&D volume"
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Count of completed enrollments for training completion rate"
    - name: "withdrawn_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Withdrawn' THEN training_enrollment_id END)
      comment: "Count of withdrawn enrollments for training dropout analysis"
    - name: "mandatory_compliance_enrollments"
      expr: COUNT(DISTINCT CASE WHEN mandatory_compliance_flag = TRUE THEN training_enrollment_id END)
      comment: "Count of mandatory compliance enrollments for regulatory training tracking"
    - name: "certificates_issued"
      expr: COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Count of certificates issued for credential management"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage for training engagement"
    - name: "avg_attendance_pct"
      expr: AVG(CAST(attendance_percentage AS DOUBLE))
      comment: "Average attendance percentage for training participation"
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average score achieved for training effectiveness"
    - name: "avg_passing_threshold"
      expr: AVG(CAST(passing_score_threshold AS DOUBLE))
      comment: "Average passing score threshold for training rigor"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost for L&D budget tracking"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per enrollment for ROI analysis"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours_awarded AS DOUBLE))
      comment: "Total credit hours awarded for learning volume measurement"
    - name: "avg_credit_hours"
      expr: AVG(CAST(credit_hours_awarded AS DOUBLE))
      comment: "Average credit hours per enrollment for training depth"
    - name: "total_ceu_awarded"
      expr: SUM(CAST(ceu_awarded AS DOUBLE))
      comment: "Total continuing education units awarded for professional development"
    - name: "avg_days_to_complete"
      expr: AVG(CAST(DATEDIFF(completion_date, enrollment_date) AS DOUBLE))
      comment: "Average days to complete training for learning velocity"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_staff_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensing and regulatory compliance metrics including license status, renewal tracking, and continuing education for insurance industry workforce compliance"
  source: "`life_insurance_ecm`.`workforce`.`staff_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current license status (Active, Expired, Suspended, etc.)"
    - name: "license_type"
      expr: license_type
      comment: "Type of license (Life, Health, Property & Casualty, etc.)"
    - name: "designation_type"
      expr: designation_type
      comment: "Professional designation type (CLU, ChFC, CFP, etc.)"
    - name: "issuing_jurisdiction"
      expr: issuing_jurisdiction
      comment: "State or jurisdiction that issued license"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued license for regulatory tracking"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status with carrier for producer compliance"
    - name: "ce_compliance_status"
      expr: ce_compliance_status
      comment: "Continuing education compliance status for regulatory risk"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for licensing compliance"
    - name: "company_sponsored_flag"
      expr: company_sponsored_flag
      comment: "Whether license is company-sponsored for cost allocation"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year license was issued for cohort analysis"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year license expires for renewal planning"
  measures:
    - name: "total_licenses"
      expr: COUNT(DISTINCT staff_license_id)
      comment: "Total unique licenses for compliance inventory"
    - name: "active_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'Active' THEN staff_license_id END)
      comment: "Count of active licenses for current compliance status"
    - name: "expired_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'Expired' THEN staff_license_id END)
      comment: "Count of expired licenses for compliance risk"
    - name: "licenses_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) <= 90 AND license_status = 'Active' THEN staff_license_id END)
      comment: "Count of licenses expiring within 90 days for proactive renewal"
    - name: "company_sponsored_licenses"
      expr: COUNT(DISTINCT CASE WHEN company_sponsored_flag = TRUE THEN staff_license_id END)
      comment: "Count of company-sponsored licenses for cost tracking"
    - name: "avg_ce_credits_required"
      expr: AVG(CAST(ce_credits_required AS DOUBLE))
      comment: "Average CE credits required for compliance planning"
    - name: "avg_ce_credits_completed"
      expr: AVG(CAST(ce_credits_completed AS DOUBLE))
      comment: "Average CE credits completed for compliance progress"
    - name: "avg_ce_credits_remaining"
      expr: AVG(CAST(ce_credits_remaining AS DOUBLE))
      comment: "Average CE credits remaining for compliance gap analysis"
    - name: "avg_days_to_expiration"
      expr: AVG(CAST(DATEDIFF(expiration_date, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until license expiration for renewal urgency"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll and labor cost metrics including gross pay, deductions, taxes, and net pay for financial planning and labor cost management"
  source: "`life_insurance_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of payroll record (Processed, Pending, Voided, etc.)"
    - name: "pay_method"
      expr: pay_method
      comment: "Payment method (Direct Deposit, Check, etc.)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (Weekly, Bi-Weekly, Monthly, etc.)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "GL account code for financial reporting"
    - name: "pay_year"
      expr: YEAR(pay_date)
      comment: "Year of pay date for annual labor cost analysis"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of pay date for monthly labor cost tracking"
    - name: "pay_period_start_year"
      expr: YEAR(pay_period_start_date)
      comment: "Year of pay period start for period-based analysis"
  measures:
    - name: "total_payroll_records"
      expr: COUNT(DISTINCT payroll_record_id)
      comment: "Total unique payroll records for payroll volume"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay - primary labor cost metric"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per record for compensation benchmarking"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay for actual cash disbursement tracking"
    - name: "avg_net_pay"
      expr: AVG(CAST(net_pay_amount AS DOUBLE))
      comment: "Average net pay per record for take-home pay analysis"
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay_amount AS DOUBLE))
      comment: "Total regular pay for base labor cost"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay for overtime cost management"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount for incentive compensation tracking"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission amount for sales compensation analysis"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked for capacity utilization"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours for overtime management"
    - name: "avg_regular_hours"
      expr: AVG(CAST(regular_hours_worked AS DOUBLE))
      comment: "Average regular hours per record for workload analysis"
    - name: "avg_overtime_hours"
      expr: AVG(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Average overtime hours per record for overtime trend"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld for tax liability tracking"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld for state tax compliance"
    - name: "total_social_security_tax"
      expr: SUM(CAST(social_security_tax_withheld AS DOUBLE))
      comment: "Total social security tax withheld for FICA compliance"
    - name: "total_medicare_tax"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withheld for FICA compliance"
    - name: "total_pretax_deductions"
      expr: SUM(CAST(total_pretax_deductions AS DOUBLE))
      comment: "Total pre-tax deductions for benefits cost analysis"
    - name: "total_posttax_deductions"
      expr: SUM(CAST(total_posttax_deductions AS DOUBLE))
      comment: "Total post-tax deductions for voluntary deduction tracking"
    - name: "total_retirement_deductions"
      expr: SUM(CAST(retirement_plan_pretax_deduction AS DOUBLE))
      comment: "Total retirement plan deductions for 401k participation"
    - name: "total_health_insurance_deductions"
      expr: SUM(CAST(health_insurance_pretax_deduction AS DOUBLE))
      comment: "Total health insurance deductions for benefits cost"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave and absence management metrics including leave utilization, FMLA compliance, and absence patterns for workforce planning and compliance"
  source: "`life_insurance_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of leave request (Approved, Pending, Denied, etc.)"
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, Sick, Parental, etc.)"
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether leave is FMLA-eligible for compliance tracking"
    - name: "fmla_qualifying_reason"
      expr: fmla_qualifying_reason
      comment: "FMLA qualifying reason for regulatory reporting"
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether leave is paid for cost impact analysis"
    - name: "intermittent_leave_flag"
      expr: intermittent_leave_flag
      comment: "Whether leave is intermittent for scheduling complexity"
    - name: "medical_certification_required_flag"
      expr: medical_certification_required_flag
      comment: "Whether medical certification is required for compliance"
    - name: "medical_certification_received_flag"
      expr: medical_certification_received_flag
      comment: "Whether medical certification was received for compliance status"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of leave request for trend analysis"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of leave request for seasonal absence patterns"
    - name: "approved_start_year"
      expr: YEAR(approved_start_date)
      comment: "Year leave starts for capacity planning"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total unique leave requests for absence volume"
    - name: "approved_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN leave_status = 'Approved' THEN leave_request_id END)
      comment: "Count of approved leave requests for leave utilization"
    - name: "denied_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN leave_status = 'Denied' THEN leave_request_id END)
      comment: "Count of denied leave requests for policy impact analysis"
    - name: "fmla_eligible_requests"
      expr: COUNT(DISTINCT CASE WHEN fmla_eligible_flag = TRUE THEN leave_request_id END)
      comment: "Count of FMLA-eligible requests for compliance tracking"
    - name: "paid_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN paid_leave_flag = TRUE THEN leave_request_id END)
      comment: "Count of paid leave requests for cost impact"
    - name: "intermittent_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN intermittent_leave_flag = TRUE THEN leave_request_id END)
      comment: "Count of intermittent leave requests for scheduling complexity"
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total days of leave requested for absence volume"
    - name: "total_days_approved"
      expr: SUM(CAST(total_days_approved AS DOUBLE))
      comment: "Total days of leave approved for capacity impact"
    - name: "avg_days_requested"
      expr: AVG(CAST(total_days_requested AS DOUBLE))
      comment: "Average days requested per leave for leave duration analysis"
    - name: "avg_days_approved"
      expr: AVG(CAST(total_days_approved AS DOUBLE))
      comment: "Average days approved per leave for actual absence impact"
    - name: "total_hours_requested"
      expr: SUM(CAST(total_hours_requested AS DOUBLE))
      comment: "Total hours of leave requested for granular absence tracking"
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total hours of leave approved for capacity planning"
    - name: "avg_leave_balance_before"
      expr: AVG(CAST(leave_balance_before AS DOUBLE))
      comment: "Average leave balance before request for accrual adequacy"
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance after request for remaining capacity"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and headcount forecasting metrics including planned hires, attrition assumptions, and budget alignment for strategic workforce planning"
  source: "`life_insurance_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of headcount plan (Draft, Approved, Active, etc.)"
    - name: "planning_year"
      expr: planning_year
      comment: "Planning year for annual workforce planning"
    - name: "planning_quarter"
      expr: planning_quarter
      comment: "Planning quarter for quarterly workforce planning"
    - name: "planning_month"
      expr: planning_month
      comment: "Planning month for monthly workforce planning"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (Annual, Quarterly, Monthly)"
    - name: "critical_role_flag"
      expr: critical_role_flag
      comment: "Whether plan is for critical role requiring priority"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether plan is driven by regulatory requirement"
    - name: "succession_plan_exists_flag"
      expr: succession_plan_exists_flag
      comment: "Whether succession plan exists for continuity planning"
    - name: "capacity_driver"
      expr: capacity_driver
      comment: "Driver for capacity need (Growth, Replacement, Regulatory, etc.)"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency for budget planning"
  measures:
    - name: "total_headcount_plans"
      expr: COUNT(DISTINCT headcount_plan_id)
      comment: "Total unique headcount plans for planning volume"
    - name: "approved_headcount_plans"
      expr: COUNT(DISTINCT CASE WHEN plan_status = 'Approved' THEN headcount_plan_id END)
      comment: "Count of approved headcount plans for committed capacity"
    - name: "total_approved_headcount"
      expr: SUM(CAST(approved_headcount AS DOUBLE))
      comment: "Total approved headcount for workforce capacity target"
    - name: "total_current_filled_headcount"
      expr: SUM(CAST(current_filled_headcount AS DOUBLE))
      comment: "Total current filled headcount for baseline capacity"
    - name: "total_open_headcount"
      expr: SUM(CAST(open_headcount AS DOUBLE))
      comment: "Total open headcount for hiring pipeline demand"
    - name: "total_fte_budget"
      expr: SUM(CAST(fte_budget AS DOUBLE))
      comment: "Total FTE budget for capacity planning"
    - name: "total_planned_new_hires"
      expr: SUM(CAST(planned_new_hires AS DOUBLE))
      comment: "Total planned new hires for growth capacity"
    - name: "total_planned_backfills"
      expr: SUM(CAST(planned_backfills AS DOUBLE))
      comment: "Total planned backfills for replacement capacity"
    - name: "total_planned_eliminations"
      expr: SUM(CAST(planned_eliminations AS DOUBLE))
      comment: "Total planned eliminations for restructuring impact"
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percentage AS DOUBLE))
      comment: "Average attrition assumption percentage for turnover planning"
    - name: "total_compensation_budget"
      expr: SUM(CAST(compensation_budget_amount AS DOUBLE))
      comment: "Total compensation budget for labor cost planning"
    - name: "avg_compensation_budget"
      expr: AVG(CAST(compensation_budget_amount AS DOUBLE))
      comment: "Average compensation budget per plan for cost per hire"
    - name: "avg_productivity_assumption"
      expr: AVG(CAST(productivity_assumption AS DOUBLE))
      comment: "Average productivity assumption for capacity modeling"
    - name: "avg_workload_volume_assumption"
      expr: AVG(CAST(workload_volume_assumption AS DOUBLE))
      comment: "Average workload volume assumption for demand forecasting"
$$;