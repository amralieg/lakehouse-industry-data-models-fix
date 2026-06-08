-- Metric views for domain: hr | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce composition and cost metrics derived from the employee master record. Supports headcount planning, compensation benchmarking, FTE budgeting, and diversity reporting for institutional leadership."
  source: "`education_ecm`.`hr`.`employee`"
  filter: employment_status = 'Active'
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or contingent classification used to segment workforce composition analysis."
    - name: "worker_type"
      expr: worker_type
      comment: "Employee vs. contingent worker distinction for workforce planning and compliance reporting."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "Exempt or non-exempt FLSA status, critical for overtime liability and labor law compliance."
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO-1 job category for federally mandated diversity and equal employment opportunity reporting."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for workforce equity and diversity analysis."
    - name: "race_ethnicity_code"
      expr: race_ethnicity_code
      comment: "Race/ethnicity classification for IPEDS and EEO diversity reporting."
    - name: "department_code"
      expr: department_code
      comment: "Organizational department for headcount and compensation distribution analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial allocation and budget-to-actual workforce cost analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Compensation band for pay equity and market competitiveness analysis."
    - name: "remote_work_type"
      expr: remote_work_type
      comment: "Remote, hybrid, or on-site classification for facilities planning and workforce flexibility reporting."
    - name: "highest_degree_earned"
      expr: highest_degree_earned
      comment: "Highest academic credential for faculty qualification and workforce development analysis."
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for VEVRAA compliance and diversity reporting."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort-based tenure and retention trend analysis."
    - name: "benefits_eligible"
      expr: benefits_eligible
      comment: "Whether the employee qualifies for institutional benefits, used in benefits cost forecasting."
  measures:
    - name: "active_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total count of distinct active employees. Core workforce sizing metric used in every staffing and budget review."
    - name: "total_fte"
      expr: SUM(CAST(fte_percent AS DOUBLE))
      comment: "Sum of FTE percentages across active employees. Drives budget allocation, workload planning, and IPEDS FTE reporting."
    - name: "avg_fte_per_employee"
      expr: AVG(CAST(fte_percent AS DOUBLE))
      comment: "Average FTE percentage per active employee. Indicates prevalence of part-time arrangements across the workforce."
    - name: "total_annual_salary"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annualized salary obligation for active employees. Primary input for compensation budget and financial planning."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary across active employees. Used for compensation benchmarking and equity analysis."
    - name: "benefits_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN benefits_eligible = TRUE THEN employee_id END)
      comment: "Number of active employees eligible for institutional benefits. Drives benefits cost forecasting and ACA compliance tracking."
    - name: "remote_worker_headcount"
      expr: COUNT(DISTINCT CASE WHEN remote_work_type IN ('Remote', 'Hybrid') THEN employee_id END)
      comment: "Count of employees working remotely or in hybrid arrangements. Informs facilities utilization and remote work policy decisions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_employee_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation change and equity metrics derived from compensation history records. Supports merit cycle analysis, pay equity audits, market competitiveness benchmarking, and grant-funded salary oversight."
  source: "`education_ecm`.`hr`.`employee_compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation record (base salary, hourly, stipend) for segmenting compensation analysis."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Active or historical status of the compensation record for point-in-time analysis."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason driving the compensation change (merit, equity adjustment, market adjustment, promotion) for root-cause analysis."
    - name: "employee_category"
      expr: employee_category
      comment: "Faculty, staff, or administrator classification for compensation equity segmentation."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for market benchmarking and internal equity analysis."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA exempt/non-exempt status for overtime cost and compliance analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (general fund, grant, auxiliary) for salary cost allocation and grant compliance."
    - name: "ipeds_occupation_category"
      expr: ipeds_occupation_category
      comment: "IPEDS occupational category for federally mandated compensation reporting."
    - name: "cupa_hr_survey_category"
      expr: cupa_hr_survey_category
      comment: "CUPA-HR survey category for higher-education compensation benchmarking against peer institutions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation record for multi-currency institutions."
    - name: "is_equity_adjustment"
      expr: is_equity_adjustment
      comment: "Flags records representing pay equity corrections, enabling targeted equity adjustment spend analysis."
    - name: "is_market_adjustment"
      expr: is_market_adjustment
      comment: "Flags records representing market-driven salary adjustments for retention and competitiveness tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compensation change took effect, used for annual merit cycle trend analysis."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all active compensation records. Core input for institutional salary budget and financial planning."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per compensation record. Used for peer benchmarking and internal equity analysis."
    - name: "avg_compa_ratio"
      expr: AVG(CAST(compa_ratio AS DOUBLE))
      comment: "Average compa-ratio (actual salary / pay range midpoint). Values below 1.0 signal underpayment risk and retention exposure; values above 1.0 signal budget pressure."
    - name: "avg_range_penetration"
      expr: AVG(CAST(range_penetration AS DOUBLE))
      comment: "Average position within the salary pay range. Tracks whether employees are progressing through their pay bands as expected."
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_amount AS DOUBLE))
      comment: "Total dollar value of merit increases awarded. Measures the institutional investment in performance-based pay."
    - name: "avg_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percentage. Benchmarked against CUPA-HR and market surveys to assess competitiveness of merit pools."
    - name: "total_fte_annualized_salary"
      expr: SUM(CAST(fte_annualized_salary AS DOUBLE))
      comment: "Total FTE-adjusted annualized salary obligation. More accurate than raw salary sum for institutions with significant part-time workforces."
    - name: "total_grant_funded_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE) * CAST(grant_funded_percent AS DOUBLE) / 100.0)
      comment: "Estimated total salary funded by grants. Critical for sponsored research compliance and effort reporting."
    - name: "equity_adjustment_count"
      expr: COUNT(DISTINCT CASE WHEN is_equity_adjustment = TRUE THEN employee_compensation_id END)
      comment: "Number of compensation records representing equity adjustments. Tracks the scale of pay equity remediation efforts."
    - name: "total_salary_change_amount"
      expr: SUM(CAST(salary_change_amount AS DOUBLE))
      comment: "Total net salary change across all compensation events. Measures the aggregate compensation movement in a given period."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and tax liability metrics derived from processed payroll results. Supports total compensation cost analysis, employer tax burden tracking, retirement contribution oversight, and grant-funded payroll compliance."
  source: "`education_ecm`.`hr`.`payroll_result`"
  filter: run_status = 'Confirmed'
  dimensions:
    - name: "pay_group"
      expr: pay_group
      comment: "Payroll processing group for segmenting payroll cost by employee population."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay cycle frequency (biweekly, semi-monthly, monthly) for cash flow and payroll scheduling analysis."
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Salaried vs. hourly pay rate type for labor cost composition analysis."
    - name: "run_type"
      expr: run_type
      comment: "Regular, off-cycle, or supplemental payroll run type for payroll operations monitoring."
    - name: "tax_withholding_state"
      expr: tax_withholding_state
      comment: "State of tax withholding for multi-state payroll tax liability and nexus analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll result for multi-currency reporting."
    - name: "is_fica_exempt"
      expr: is_fica_exempt
      comment: "FICA exemption flag (common for student workers and certain visa holders) for tax liability segmentation."
    - name: "payment_method"
      expr: payment_method
      comment: "Direct deposit vs. check payment method for payroll operations and fraud risk monitoring."
    - name: "pay_period_start_date"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Pay period start month for time-series payroll cost trend analysis."
    - name: "check_year"
      expr: YEAR(check_date)
      comment: "Fiscal year of paycheck for annual payroll cost and W-2 reconciliation."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll cost before deductions. Primary measure of institutional labor expenditure for budget-to-actual analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees after all deductions. Measures actual cash outflow for treasury and cash management."
    - name: "total_employer_retirement_contribution"
      expr: SUM(CAST(employer_retirement_contribution AS DOUBLE))
      comment: "Total employer retirement contributions. A significant non-salary labor cost component tracked for benefits budget compliance."
    - name: "total_employer_payroll_tax"
      expr: SUM(CAST(employer_social_security_tax AS DOUBLE) + CAST(employer_medicare_tax AS DOUBLE))
      comment: "Total employer FICA tax burden (Social Security + Medicare). Quantifies the mandatory payroll tax cost on top of gross wages."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid. Elevated overtime signals understaffing or workload imbalances requiring management intervention."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all payroll records. Used for labor productivity and cost-per-hour analysis."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per payroll record. Used for compensation benchmarking and budget forecasting."
    - name: "total_ytd_gross_pay"
      expr: SUM(CAST(ytd_gross_pay AS DOUBLE))
      comment: "Sum of year-to-date gross pay across all employees. Used for W-2 reconciliation and annual compensation reporting."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction_amount AS DOUBLE))
      comment: "Total employee benefit deductions withheld from payroll. Reconciles against benefits enrollment records for audit purposes."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. A key labor efficiency KPI; sustained rates above threshold trigger staffing reviews."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_staffing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce flow and turnover metrics derived from staffing lifecycle events (hires, terminations, transfers, promotions). Supports attrition analysis, onboarding effectiveness, and salary change impact assessment."
  source: "`education_ecm`.`hr`.`staffing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of staffing event (Hire, Termination, Transfer, Promotion, Leave) for workforce flow segmentation."
    - name: "event_status"
      expr: event_status
      comment: "Processing status of the staffing event for pipeline and compliance monitoring."
    - name: "separation_type"
      expr: separation_type
      comment: "Voluntary vs. involuntary separation classification, critical for attrition root-cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the staffing event, enabling granular attrition and mobility analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or contingent classification for workforce flow segmentation."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA status at time of event for compliance and overtime liability tracking."
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave associated with the staffing event for absence pattern analysis."
    - name: "new_department_code"
      expr: new_department_code
      comment: "Destination department for transfer events, used to track internal mobility patterns."
    - name: "prior_department_code"
      expr: prior_department_code
      comment: "Source department for transfer events, used to identify departments with high outflow."
    - name: "rehire_eligible"
      expr: rehire_eligible
      comment: "Whether the departing employee is eligible for rehire, informing talent pipeline and alumni engagement strategy."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the staffing event took effect for time-series workforce flow trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the staffing event took effect for annual attrition and hiring trend reporting."
  measures:
    - name: "total_staffing_events"
      expr: COUNT(DISTINCT staffing_event_id)
      comment: "Total count of staffing events. Baseline volume metric for workforce flow monitoring."
    - name: "hire_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Hire' THEN staffing_event_id END)
      comment: "Number of new hire events. Tracks recruiting throughput and workforce growth rate."
    - name: "termination_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Termination' THEN staffing_event_id END)
      comment: "Number of termination events. Core attrition metric used in turnover rate calculations and retention strategy reviews."
    - name: "voluntary_separation_count"
      expr: COUNT(DISTINCT CASE WHEN separation_type = 'Voluntary' THEN staffing_event_id END)
      comment: "Count of voluntary separations. Voluntary attrition is the primary controllable turnover signal for leadership intervention."
    - name: "avg_salary_change_pct"
      expr: AVG(CAST(salary_change_pct AS DOUBLE))
      comment: "Average salary change percentage across staffing events involving compensation changes. Benchmarks the generosity of promotion and transfer salary adjustments."
    - name: "total_new_annual_salary"
      expr: SUM(CAST(new_annual_salary AS DOUBLE))
      comment: "Total new annual salary committed through staffing events. Measures the forward salary obligation created by hiring and promotion decisions."
    - name: "avg_new_fte"
      expr: AVG(CAST(new_fte AS DOUBLE))
      comment: "Average FTE of positions filled through staffing events. Tracks whether the institution is trending toward part-time workforce expansion."
    - name: "promotion_count"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Promotion' THEN staffing_event_id END)
      comment: "Number of promotion events. Measures internal career advancement activity and talent development effectiveness."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting pipeline efficiency and time-to-fill metrics derived from recruitment requisitions. Supports talent acquisition performance, open position cost analysis, and workforce planning alignment."
  source: "`education_ecm`.`hr`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (Open, Filled, Cancelled, On Hold) for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type
      comment: "New position vs. backfill classification for workforce growth vs. replacement analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or contingent classification for recruiting resource allocation."
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO job category for diversity pipeline and affirmative action plan reporting."
    - name: "ipeds_occupation_category"
      expr: ipeds_occupation_category
      comment: "IPEDS occupational category for federally mandated workforce reporting."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification of the open position for compensation and compliance planning."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Remote, hybrid, or on-site work arrangement for talent market and sourcing strategy analysis."
    - name: "posting_channel"
      expr: posting_channel
      comment: "Job posting channel (internal, external, LinkedIn, etc.) for sourcing effectiveness analysis."
    - name: "visa_sponsorship_eligible"
      expr: visa_sponsorship_eligible
      comment: "Whether the position is eligible for visa sponsorship, relevant for international faculty and researcher recruiting."
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year the requisition was posted for annual recruiting volume trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the requisition was posted for seasonal recruiting pattern analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total number of recruitment requisitions. Baseline measure of recruiting demand and talent acquisition workload."
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Number of currently open requisitions. Tracks unfilled position exposure and recruiting pipeline pressure."
    - name: "avg_days_to_fill"
      expr: AVG(CAST(DATEDIFF(filled_date, posting_date) AS DOUBLE))
      comment: "Average calendar days from job posting to position fill. The primary recruiting efficiency KPI; elevated values signal sourcing or process bottlenecks."
    - name: "avg_days_to_approve"
      expr: AVG(CAST(DATEDIFF(approved_date, created_timestamp) AS DOUBLE))
      comment: "Average days from requisition creation to approval. Measures internal approval process efficiency and administrative bottlenecks."
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Total FTE approved across all requisitions. Measures the authorized workforce expansion commitment."
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST(salary_range_midpoint AS DOUBLE))
      comment: "Average salary range midpoint across open requisitions. Used for compensation budget forecasting and market competitiveness assessment."
    - name: "cancelled_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Cancelled' THEN recruitment_requisition_id END)
      comment: "Number of cancelled requisitions. High cancellation rates signal workforce planning instability or budget volatility."
    - name: "fill_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN recruitment_requisition_id END) / NULLIF(COUNT(DISTINCT recruitment_requisition_id), 0), 2)
      comment: "Percentage of requisitions successfully filled. Core talent acquisition effectiveness KPI reported to institutional leadership."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_applicant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Applicant pipeline conversion and diversity metrics derived from applicant tracking records. Supports offer acceptance analysis, sourcing channel effectiveness, and EEO pipeline diversity reporting."
  source: "`education_ecm`.`hr`.`hr_applicant`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage of the applicant in the hiring pipeline for funnel conversion analysis."
    - name: "interview_stage"
      expr: interview_stage
      comment: "Interview stage reached by the applicant for pipeline stage conversion rate analysis."
    - name: "offer_response"
      expr: offer_response
      comment: "Accepted, declined, or no response to offer for offer acceptance rate analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel (LinkedIn, referral, career site, etc.) for sourcing effectiveness and cost-per-hire analysis."
    - name: "is_internal_applicant"
      expr: is_internal_applicant
      comment: "Internal vs. external applicant flag for internal mobility and promotion-from-within analysis."
    - name: "eeo_gender"
      expr: eeo_gender
      comment: "EEO gender for diversity pipeline reporting and affirmative action plan compliance."
    - name: "eeo_race_ethnicity"
      expr: eeo_race_ethnicity
      comment: "EEO race/ethnicity for diversity pipeline reporting and OFCCP compliance."
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest education level of applicants for minimum qualification analysis and talent pool quality assessment."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status for I-9 compliance planning and visa sponsorship demand analysis."
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for VEVRAA applicant flow log compliance reporting."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for seasonal recruiting volume and pipeline trend analysis."
  measures:
    - name: "total_applicants"
      expr: COUNT(DISTINCT hr_applicant_id)
      comment: "Total number of applicants. Measures recruiting funnel volume and employer brand reach."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offer_response = 'Accepted' THEN hr_applicant_id END) / NULLIF(COUNT(DISTINCT CASE WHEN offer_date IS NOT NULL THEN hr_applicant_id END), 0), 2)
      comment: "Percentage of offers extended that were accepted. A critical talent acquisition quality metric; declining rates signal compensation or employer brand issues."
    - name: "avg_offer_amount"
      expr: AVG(CAST(offer_amount AS DOUBLE))
      comment: "Average offer amount extended to candidates. Used for compensation budget calibration and market competitiveness assessment."
    - name: "internal_applicant_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_internal_applicant = TRUE THEN hr_applicant_id END) / NULLIF(COUNT(DISTINCT hr_applicant_id), 0), 2)
      comment: "Percentage of applicants who are internal employees. Measures internal mobility culture and promotion-from-within effectiveness."
    - name: "avg_desired_salary"
      expr: AVG(CAST(desired_salary AS DOUBLE))
      comment: "Average desired salary reported by applicants. Provides real-time market salary intelligence for compensation planning."
    - name: "applicants_reaching_offer"
      expr: COUNT(DISTINCT CASE WHEN offer_date IS NOT NULL THEN hr_applicant_id END)
      comment: "Number of applicants who received an offer. Measures the output of the recruiting funnel and hiring manager decision throughput."
    - name: "avg_days_application_to_offer"
      expr: AVG(CAST(DATEDIFF(offer_date, application_date) AS DOUBLE))
      comment: "Average days from application submission to offer extension. Measures end-to-end recruiting process speed; long cycles risk losing top candidates."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance distribution and merit eligibility metrics derived from performance review records. Supports talent calibration, succession planning, PIP tracking, and merit cycle alignment."
  source: "`education_ecm`.`hr`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Annual, mid-year, or probationary review type for performance cycle segmentation."
    - name: "review_status"
      expr: review_status
      comment: "Completion status of the review for compliance and process adherence monitoring."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Final performance rating label for talent distribution and calibration analysis."
    - name: "calibrated_overall_rating"
      expr: calibrated_overall_rating
      comment: "Post-calibration performance rating for normalized talent distribution analysis."
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment (High Potential, Solid Performer, etc.) for succession planning and development investment prioritization."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Whether the review has been through the calibration process for data quality and process compliance tracking."
    - name: "merit_eligible"
      expr: merit_eligible
      comment: "Whether the employee is eligible for a merit increase based on this review, for merit budget planning."
    - name: "pip_required"
      expr: pip_required
      comment: "Whether a Performance Improvement Plan is required, for HR risk and legal exposure monitoring."
    - name: "review_period_year"
      expr: YEAR(review_period_end_date)
      comment: "Performance review period year for annual talent distribution trend analysis."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Complete' THEN performance_review_id END)
      comment: "Number of completed performance reviews. Measures review cycle completion rate and HR process compliance."
    - name: "review_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN review_status = 'Complete' THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of initiated reviews that reached completion. A governance KPI; low completion rates expose the institution to merit and legal risk."
    - name: "avg_overall_rating_numeric"
      expr: AVG(CAST(overall_rating_numeric AS DOUBLE))
      comment: "Average numeric performance rating across reviewed employees. Tracks workforce performance trends and calibration drift over time."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage awarded through the performance cycle. Benchmarked against compensation budget and market surveys."
    - name: "pip_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN performance_review_id END)
      comment: "Number of employees placed on Performance Improvement Plans. Tracks performance risk concentration and potential involuntary attrition exposure."
    - name: "high_performer_count"
      expr: COUNT(DISTINCT CASE WHEN talent_segment IN ('High Potential', 'High Performer') THEN performance_review_id END)
      comment: "Count of employees identified as high performers or high potentials. Measures the depth of the talent pipeline for succession planning."
    - name: "self_assessment_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN self_assessment_completed = TRUE THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of reviews where the employee completed a self-assessment. Measures employee engagement in the performance process."
    - name: "merit_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN merit_eligible = TRUE THEN performance_review_id END)
      comment: "Number of employees eligible for merit increases. Drives merit budget sizing and compensation planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_absence_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and FMLA compliance metrics derived from absence event records. Supports workforce availability planning, FMLA exposure tracking, and leave cost analysis."
  source: "`education_ecm`.`hr`.`absence_event`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, medical, personal, parental) for absence pattern and policy utilization analysis."
    - name: "leave_reason"
      expr: leave_reason
      comment: "Reason for the leave event for root-cause absence analysis and wellness program targeting."
    - name: "leave_pay_type"
      expr: leave_pay_type
      comment: "Paid vs. unpaid leave classification for leave cost and liability analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request for compliance and process adherence monitoring."
    - name: "is_fmla_designated"
      expr: is_fmla_designated
      comment: "Whether the absence is FMLA-designated for federal compliance tracking and legal exposure monitoring."
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Whether the leave is intermittent vs. continuous for scheduling impact and workforce availability analysis."
    - name: "medical_certification_required"
      expr: medical_certification_required
      comment: "Whether medical certification is required for the leave, for compliance documentation tracking."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the absence event for higher-education-specific leave pattern analysis aligned to academic calendar."
    - name: "leave_start_month"
      expr: DATE_TRUNC('month', leave_start_date)
      comment: "Month the leave began for seasonal absence trend analysis."
  measures:
    - name: "total_leave_duration_days"
      expr: SUM(CAST(leave_duration_days AS DOUBLE))
      comment: "Total calendar days of approved leave. Measures aggregate workforce availability loss and operational impact."
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(leave_duration_days AS DOUBLE))
      comment: "Average leave duration per absence event. Benchmarks leave episode length for policy design and workforce planning."
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used_ytd AS DOUBLE))
      comment: "Total FMLA hours used year-to-date. Core FMLA compliance metric for legal exposure and entitlement tracking."
    - name: "total_approved_hours"
      expr: SUM(CAST(approved_hours AS DOUBLE))
      comment: "Total approved leave hours across all absence events. Measures the institutional leave liability and workforce availability impact."
    - name: "fmla_designated_count"
      expr: COUNT(DISTINCT CASE WHEN is_fmla_designated = TRUE THEN absence_event_id END)
      comment: "Number of FMLA-designated absence events. Tracks FMLA utilization volume for compliance reporting and legal risk monitoring."
    - name: "avg_fte_impact"
      expr: AVG(CAST(fte_impact AS DOUBLE))
      comment: "Average FTE impact per absence event. Quantifies the workforce capacity reduction caused by leave, informing backfill and coverage decisions."
    - name: "medical_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medical_certification_required = TRUE AND medical_certification_received = TRUE THEN absence_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN medical_certification_required = TRUE THEN absence_event_id END), 0), 2)
      comment: "Percentage of leaves requiring medical certification where certification was received. Measures HR compliance with FMLA documentation requirements."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation, cost, and ACA compliance metrics derived from benefit enrollment records. Supports open enrollment planning, employer cost forecasting, ACA affordability compliance, and retirement participation analysis."
  source: "`education_ecm`.`hr`.`benefit_enrollment`"
  filter: enrollment_status = 'Active'
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Category of benefit (medical, dental, vision, retirement, FSA, HSA) for benefits portfolio analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Employee-only, employee+spouse, family coverage tier for premium cost and enrollment mix analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Active, terminated, or waived enrollment status for benefits participation tracking."
    - name: "employee_class"
      expr: employee_class
      comment: "Employee classification for benefits eligibility and cost allocation analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Benefits plan year for annual enrollment trend and cost comparison analysis."
    - name: "election_source"
      expr: election_source
      comment: "How the election was made (open enrollment, qualifying life event, new hire) for enrollment process analysis."
    - name: "is_waived"
      expr: is_waived
      comment: "Whether the employee waived coverage, for benefits opt-out rate and ACA minimum coverage analysis."
    - name: "aca_affordability_met"
      expr: aca_affordability_met
      comment: "Whether the plan meets ACA affordability standards for employer mandate compliance monitoring."
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "COBRA eligibility flag for benefits continuation liability tracking."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of benefit contributions for payroll deduction scheduling and cash flow analysis."
  measures:
    - name: "total_enrolled_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employees with active benefit enrollments. Measures benefits participation breadth."
    - name: "total_annual_employer_premium"
      expr: SUM(CAST(annual_employer_premium AS DOUBLE))
      comment: "Total annual employer premium cost across all active enrollments. Primary benefits cost metric for budget planning and total compensation analysis."
    - name: "total_annual_employee_premium"
      expr: SUM(CAST(annual_employee_premium AS DOUBLE))
      comment: "Total annual employee premium contributions. Measures employee cost-sharing and benefits affordability from the employee perspective."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment record. Used for benefits cost benchmarking and plan design optimization."
    - name: "total_retirement_contributions"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee retirement contributions across active enrollments. Measures retirement savings participation and plan health."
    - name: "aca_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN aca_affordability_met = TRUE AND aca_minimum_value_met = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT benefit_enrollment_id), 0), 2)
      comment: "Percentage of enrollments meeting both ACA affordability and minimum value standards. Critical ACA employer mandate compliance KPI."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_waived = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT benefit_enrollment_id), 0), 2)
      comment: "Percentage of eligible employees who waived benefits coverage. High waiver rates may signal affordability concerns or workforce composition shifts."
    - name: "avg_fsa_election_amount"
      expr: AVG(CASE WHEN fsa_election_amount > 0 THEN CAST(fsa_election_amount AS DOUBLE) END)
      comment: "Average FSA election amount among employees who elected FSA coverage. Informs FSA plan design and IRS contribution limit utilization."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours utilization and overtime compliance metrics derived from time entry records. Supports FLSA overtime liability monitoring, grant effort reporting, and workforce productivity analysis."
  source: "`education_ecm`.`hr`.`time_entry`"
  filter: entry_status = 'Approved'
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, on-call, shift differential) for labor cost composition analysis."
    - name: "earning_code"
      expr: earning_code
      comment: "Earning code for granular labor cost categorization and payroll reconciliation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry for compliance and payroll readiness monitoring."
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA status of the time entry for overtime eligibility and liability analysis."
    - name: "is_overtime_eligible"
      expr: is_overtime_eligible
      comment: "Whether the employee is eligible for overtime pay for FLSA compliance and cost forecasting."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location for multi-site labor distribution and facilities utilization analysis."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the time entry has been processed through payroll for reconciliation and audit purposes."
    - name: "work_month"
      expr: DATE_TRUNC('month', work_date)
      comment: "Month of work for time-series labor hours trend analysis."
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work for annual labor hours and overtime cost reporting."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total approved hours worked. Core labor utilization metric for productivity analysis and grant effort reporting."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded. Elevated overtime signals understaffing or workload concentration requiring management action."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Baseline labor input measure for productivity and cost analysis."
    - name: "total_on_call_hours"
      expr: SUM(CAST(on_call_hours AS DOUBLE))
      comment: "Total on-call hours recorded. Relevant for healthcare, facilities, and IT staff scheduling and premium pay cost analysis."
    - name: "total_shift_differential_hours"
      expr: SUM(CAST(shift_differential_hours AS DOUBLE))
      comment: "Total shift differential hours. Measures premium pay exposure for evening, night, and weekend shift coverage."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. Key FLSA compliance and labor efficiency KPI; sustained rates above 10% trigger staffing reviews."
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours per approved time entry. Detects anomalous time entry patterns and supports audit and fraud detection."
$$;