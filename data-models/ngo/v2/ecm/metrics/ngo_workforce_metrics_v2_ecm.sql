-- Metric views for domain: workforce | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and compensation metrics. Source of truth for active staff counts, salary benchmarking, and workforce composition analysis used in board reporting and donor audits. Aligns with SAP HCM / Workday headcount reporting conventions used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`staff_member`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, On Leave, Separated) — primary filter for headcount dashboards."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, consultant, volunteer — drives FTE normalization and benefit eligibility analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Fixed-term, open-ended, emergency surge — critical for workforce planning and donor compliance reporting."
    - name: "department"
      expr: department
      comment: "Organizational department for headcount and cost distribution analysis."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — enables geographic workforce distribution reporting required by cluster coordination and donor reports."
    - name: "gender"
      expr: gender
      comment: "Gender self-identification — required for gender parity KPIs and CHS/donor diversity reporting."
    - name: "job_grade"
      expr: job_grade
      comment: "Salary grade band — used for compensation equity analysis and succession planning."
    - name: "nationality"
      expr: nationality
      comment: "Staff nationality — supports national vs. international staff ratio reporting."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire — enables cohort retention analysis and tenure distribution."
    - name: "separation_year"
      expr: YEAR(separation_date)
      comment: "Year of separation — used to compute annual attrition rates."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of staff records. Primary headcount KPI used in board reporting, donor staffing plans, and cluster coordination submissions."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active staff. Core operational metric for capacity planning and surge response readiness."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Sum of FTE percentages across all staff. Normalizes part-time and full-time staff for budget and workload planning."
    - name: "avg_fte_per_staff"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage per staff record. Indicates workforce utilization intensity and part-time prevalence."
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary expenditure across all staff. Key input for budget forecasting, grant cost allocation, and ICR calculations."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary. Used for compensation benchmarking, equity analysis, and salary scale reviews."
    - name: "separated_staff_count"
      expr: COUNT(CASE WHEN employment_status = 'Separated' THEN 1 END)
      comment: "Count of separated staff. Numerator for attrition rate calculation; triggers workforce replenishment planning."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible = TRUE THEN 1 END)
      comment: "Count of staff eligible for rehire. Supports talent pipeline management and emergency surge roster planning."
    - name: "expat_staff_count"
      expr: COUNT(CASE WHEN contract_type = 'Expatriate' OR duty_station_country != nationality THEN 1 END)
      comment: "Approximate count of expatriate staff based on contract type or nationality vs. duty station mismatch. Drives expat package cost forecasting."
    - name: "avg_years_of_service"
      expr: AVG(CAST(DATEDIFF(COALESCE(separation_date, CURRENT_DATE()), hire_date) AS DOUBLE) / 365.25)
      comment: "Average tenure in years. Key retention indicator; low values signal high turnover risk and institutional knowledge loss."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution and cost metrics for financial oversight, grant compliance, and audit readiness. Supports IPSAS and US GAAP dual-framework reporting. Aligns with SAP Payroll / Workday Payroll run-level reporting used by large INGOs and UN agencies."
  source: "`vibe_ngo_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Payroll run status (Draft, Approved, Posted, Reversed) — primary filter for financial close monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Regular, off-cycle, retroactive — distinguishes planned vs. exception payroll runs for audit purposes."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Monthly, bi-weekly, weekly — used to normalize payroll cost comparisons across entities."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Staff grouping for payroll processing (e.g., National Staff, International Staff, Consultants)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payroll run — enables year-over-year payroll cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) — supports period-over-period payroll variance analysis."
    - name: "pay_period_start"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Month bucket of pay period start — enables monthly payroll cost trending."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flags retroactive payroll runs — retroactive runs indicate process exceptions and potential compliance risk."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies unapproved runs that may block financial close."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs. Primary payroll expenditure KPI for budget vs. actual reporting and grant cost allocation."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed. Represents actual cash outflow for treasury and bank reconciliation."
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer-side benefit and pension contributions. Critical for true cost-of-employment calculations and grant budget compliance."
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total statutory tax withheld. Required for tax compliance reporting and regulatory filings across jurisdictions."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions (tax, pension, voluntary). Supports payroll reconciliation and benefits cost analysis."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run. Baseline for detecting anomalous run amounts that may indicate errors or fraud."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs processed. Operational throughput metric for payroll team performance and audit trail completeness."
    - name: "retroactive_run_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN 1 END)
      comment: "Count of retroactive payroll runs. High retroactive counts signal process failures, late contract processing, or system integration gaps."
    - name: "avg_employee_count_per_run"
      expr: AVG(CAST(employee_count AS DOUBLE))
      comment: "Average number of employees processed per payroll run. Tracks workforce coverage and identifies runs with unexpectedly low employee counts."
    - name: "total_icr_applicable_payroll"
      expr: SUM(CAST(total_gross_pay AS DOUBLE) * CAST(icr_rate AS DOUBLE) / 100.0)
      comment: "Estimated indirect cost recovery (ICR/NICRA) applicable to payroll. Critical for grant budget compliance and donor financial reporting under US federal awards."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual payslip-level compensation analytics for staff cost breakdown, allowance tracking, and grant charge verification. Supports IPSAS staff cost reporting and US GAAP Form 990 compensation disclosures. Aligns with SAP HR / Workday payslip detail reporting."
  source: "`vibe_ngo_v1`.`workforce`.`payslip`"
  dimensions:
    - name: "payslip_status"
      expr: payslip_status
      comment: "Payslip processing status (Draft, Approved, Paid, Reversed) — primary filter for payment completeness monitoring."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Staff payroll group — enables cost breakdown by staff category (national, international, consultant)."
    - name: "is_correction"
      expr: is_correction
      comment: "Flags correction payslips — high correction rates indicate payroll processing quality issues."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flags off-cycle payslips — off-cycle payments represent process exceptions and additional administrative cost."
    - name: "pay_period_month"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Month of pay period — enables monthly compensation cost trending and budget vs. actual analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of actual payment — used for cash flow analysis and treasury planning."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code charged for this payslip — enables grant-level staff cost reporting required by donors."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary across all payslips. Primary staff cost metric for budget vs. actual reporting and grant financial reporting."
    - name: "total_net_pay_local"
      expr: SUM(CAST(net_pay_local AS DOUBLE))
      comment: "Total net pay in local currency. Represents actual cash disbursed to staff; key for treasury and bank reconciliation."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance AS DOUBLE))
      comment: "Total hardship allowances paid. Tracks field incentive costs; high values indicate significant field presence and associated donor-reportable costs."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance AS DOUBLE))
      comment: "Total housing allowances paid. Major component of expat package cost; tracked separately for grant budget compliance."
    - name: "total_expat_allowance"
      expr: SUM(CAST(expat_allowance AS DOUBLE))
      comment: "Total expatriate allowances paid. Drives expat cost-of-employment analysis and informs national vs. international staffing decisions."
    - name: "total_income_tax_deduction"
      expr: SUM(CAST(income_tax_deduction AS DOUBLE))
      comment: "Total income tax withheld across payslips. Required for statutory tax compliance reporting in each operating jurisdiction."
    - name: "total_employer_pension_contribution"
      expr: SUM(CAST(employer_pension_contribution AS DOUBLE))
      comment: "Total employer pension contributions. Key component of true employment cost for budget planning and IPSAS employee benefit liability disclosures."
    - name: "total_allowances"
      expr: SUM(CAST(total_allowances AS DOUBLE))
      comment: "Total allowances paid (all types combined). Enables allowance-to-base-salary ratio analysis for compensation structure benchmarking."
    - name: "correction_payslip_count"
      expr: COUNT(CASE WHEN is_correction = TRUE THEN 1 END)
      comment: "Count of correction payslips. High correction counts signal payroll processing quality issues requiring process improvement."
    - name: "total_payslips"
      expr: COUNT(1)
      comment: "Total payslip count. Baseline volume metric for payroll operations monitoring and audit completeness verification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_employment_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employment contract lifecycle and compensation structure analytics. Tracks contract types, salary grades, and allowance packages to support workforce planning, budget forecasting, and donor compliance. Aligns with Workday HCM contract management and SAP HR contract administration."
  source: "`vibe_ngo_v1`.`workforce`.`employment_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (Fixed-term, Open-ended, Consultancy, Emergency) — primary dimension for workforce composition analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (Active, Expired, Terminated, Amended) — used to filter active workforce for headcount reporting."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category (National, International, Consultant) — drives compensation benchmarking and donor staffing ratio reporting."
    - name: "is_expatriate"
      expr: is_expatriate
      comment: "Expatriate flag — separates national and international staff for cost-of-employment analysis."
    - name: "hardship_tier"
      expr: hardship_tier
      comment: "Hardship location tier — determines allowance levels and informs field staffing cost projections."
    - name: "duty_station"
      expr: duty_station
      comment: "Duty station location — enables geographic distribution of contract costs for field office budget planning."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Contract start year — supports cohort analysis of contract renewals and workforce growth trends."
    - name: "labor_law_jurisdiction"
      expr: labor_law_jurisdiction
      comment: "Applicable labor law jurisdiction — critical for compliance monitoring across multi-country operations."
  measures:
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Count of active employment contracts. Core workforce capacity metric for operational planning and donor staffing plan compliance."
    - name: "total_base_salary_committed"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary committed across all contracts. Primary input for multi-year budget forecasting and grant cost projection."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary across contracts. Used for compensation equity analysis and salary scale benchmarking."
    - name: "total_hardship_allowance_committed"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowances committed. Quantifies field incentive cost exposure for budget planning and grant budget justification."
    - name: "total_housing_allowance_committed"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowances committed. Major expat cost component; tracked for grant budget compliance and cost-of-employment benchmarking."
    - name: "total_relocation_allowance_committed"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowances committed. One-time cost tracked for budget accuracy and expat package cost analysis."
    - name: "expat_contract_count"
      expr: COUNT(CASE WHEN is_expatriate = TRUE THEN 1 END)
      comment: "Count of expatriate contracts. Drives expat-to-national ratio analysis and informs localization strategy decisions."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND contract_status = 'Active' THEN 1 END)
      comment: "Count of active contracts expiring within 90 days. Critical operational risk metric — triggers contract renewal or recruitment actions to prevent staffing gaps."
    - name: "avg_icr_rate"
      expr: AVG(CAST(icr_rate AS DOUBLE))
      comment: "Average indirect cost recovery rate across contracts. Used to validate grant budget ICR calculations and NICRA compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline efficiency and workforce acquisition metrics. Tracks time-to-fill, requisition volumes, and funding status to support talent acquisition strategy and emergency surge planning. Aligns with Workday Recruiting and iRecruitment (SAP) reporting conventions."
  source: "`vibe_ngo_v1`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current requisition status (Open, In Progress, Filled, Cancelled) — primary pipeline health indicator."
    - name: "recruitment_type"
      expr: recruitment_type
      comment: "Internal, external, emergency surge — distinguishes planned hiring from crisis response recruitment."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables staffing mix analysis and localization tracking."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, fixed-term — supports workforce composition planning."
    - name: "duty_station"
      expr: duty_station
      comment: "Duty station for the position — enables geographic recruitment demand analysis."
    - name: "is_emergency_surge"
      expr: is_emergency_surge
      comment: "Emergency surge flag — separates crisis-driven recruitment from planned hiring for response capacity reporting."
    - name: "funding_confirmed"
      expr: funding_confirmed
      comment: "Whether funding is confirmed for the position — unfunded open requisitions represent budget risk."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies bottlenecks in the hiring authorization process."
    - name: "opened_year"
      expr: YEAR(opened_date)
      comment: "Year requisition was opened — enables year-over-year recruitment volume trending."
    - name: "gender_marker"
      expr: gender_marker
      comment: "Gender marker for the position — supports gender parity tracking in recruitment pipelines."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total recruitment requisitions. Baseline hiring demand volume metric for workforce planning and HR capacity assessment."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN 1 END)
      comment: "Count of currently open requisitions. Represents unfilled staffing demand; high open counts signal recruitment bottlenecks or funding gaps."
    - name: "filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions. Numerator for fill rate calculation; measures recruitment team effectiveness."
    - name: "emergency_surge_requisitions"
      expr: COUNT(CASE WHEN is_emergency_surge = TRUE THEN 1 END)
      comment: "Count of emergency surge requisitions. Tracks crisis-driven hiring demand; high values indicate active emergency response requiring accelerated recruitment."
    - name: "total_budgeted_salary_committed"
      expr: SUM(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Total budgeted annual salary for all requisitions. Quantifies total hiring cost commitment for budget planning and grant cost projection."
    - name: "avg_budgeted_salary"
      expr: AVG(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Average budgeted salary per requisition. Used for compensation benchmarking and salary scale validation."
    - name: "unfunded_open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' AND funding_confirmed = FALSE THEN 1 END)
      comment: "Count of open requisitions without confirmed funding. Critical budget risk indicator — unfunded open positions may not be fillable without additional grant funding."
    - name: "cancelled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled requisitions. High cancellation rates indicate budget instability, program changes, or poor workforce planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel conversion and candidate quality metrics. Tracks application-to-offer conversion rates, diversity pipeline, and selection quality to support equitable and efficient hiring. Aligns with Workday Recruiting analytics and INGO diversity reporting requirements."
  source: "`vibe_ngo_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current application status (Submitted, Screening, Interview, Offer, Hired, Rejected, Withdrawn) — primary funnel stage indicator."
    - name: "application_stage"
      expr: application_stage
      comment: "Detailed pipeline stage — enables funnel drop-off analysis at each recruitment step."
    - name: "candidate_type"
      expr: candidate_type
      comment: "Internal vs. external candidate — tracks internal mobility rates and external hire ratios."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruitment source channel (job board, referral, LinkedIn, NGO network) — identifies highest-yield sourcing channels."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables staffing mix analysis in the pipeline."
    - name: "gender_self_identified"
      expr: gender_self_identified
      comment: "Candidate gender self-identification — required for gender parity pipeline reporting and CHS diversity commitments."
    - name: "hiring_decision"
      expr: hiring_decision
      comment: "Final hiring decision (Hired, Rejected, Withdrawn, On Hold) — enables offer acceptance rate and rejection reason analysis."
    - name: "grant_funded_position"
      expr: grant_funded_position
      comment: "Whether the position is grant-funded — separates core and project-funded hiring for budget analysis."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application — enables monthly application volume trending and seasonal hiring pattern analysis."
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest education level of applicant — used for candidate quality benchmarking and minimum qualification compliance."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total job applications received. Baseline recruitment pipeline volume metric for HR capacity planning and sourcing effectiveness assessment."
    - name: "hired_count"
      expr: COUNT(CASE WHEN hiring_decision = 'Hired' THEN 1 END)
      comment: "Count of applications resulting in a hire. Numerator for conversion rate; measures end-to-end recruitment effectiveness."
    - name: "rejected_count"
      expr: COUNT(CASE WHEN hiring_decision = 'Rejected' THEN 1 END)
      comment: "Count of rejected applications. High rejection rates at late stages may indicate poor initial screening or misaligned job descriptions."
    - name: "withdrawn_count"
      expr: COUNT(CASE WHEN hiring_decision = 'Withdrawn' THEN 1 END)
      comment: "Count of candidate withdrawals. High withdrawal rates signal offer competitiveness issues or poor candidate experience."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across all applications. Tracks candidate quality trends and validates interview panel calibration."
    - name: "avg_screening_score"
      expr: AVG(CAST(screening_score AS DOUBLE))
      comment: "Average screening score. Measures initial candidate quality and effectiveness of job posting targeting."
    - name: "avg_proposed_salary"
      expr: AVG(CAST(proposed_salary AS DOUBLE))
      comment: "Average proposed salary for applications. Used for compensation benchmarking and offer competitiveness analysis."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience of applicants. Tracks candidate pool quality and alignment with position requirements."
    - name: "distinct_source_channels"
      expr: COUNT(DISTINCT source_channel)
      comment: "Number of distinct sourcing channels generating applications. Measures sourcing channel diversity; low values indicate over-reliance on single channels."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff performance rating distribution, review completion, and development outcome metrics. Supports talent management decisions, succession planning, and calibration quality assurance. Aligns with Workday Performance Management and SAP SuccessFactors reporting conventions used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review completion status (Draft, Submitted, Calibrated, Approved, Acknowledged) — primary completion tracking dimension."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating (e.g., Exceeds, Meets, Below Expectations) — primary distribution analysis dimension for talent segmentation."
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Annual, mid-year, probation, exit — distinguishes review types for targeted analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables performance distribution comparison across staff categories."
    - name: "duty_station"
      expr: duty_station
      comment: "Duty station — enables geographic performance distribution analysis to identify field-specific challenges."
    - name: "pip_required"
      expr: pip_required
      comment: "Whether a performance improvement plan is required — flags underperformance requiring management intervention."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Whether promotion is recommended — tracks talent pipeline readiness and succession planning inputs."
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Retention risk indicator — identifies high-risk staff for targeted retention interventions."
    - name: "employee_acknowledged"
      expr: employee_acknowledged
      comment: "Whether employee has acknowledged the review — tracks process completion and potential disputes."
    - name: "review_period_year"
      expr: YEAR(review_period_start_date)
      comment: "Review period year — enables year-over-year performance trend analysis."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews. Baseline volume metric for review cycle completion monitoring."
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN review_status IN ('Approved', 'Acknowledged') THEN 1 END)
      comment: "Count of completed and approved reviews. Numerator for completion rate; measures HR process adherence and manager accountability."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Key talent health indicator; significant deviations from expected distribution trigger calibration review."
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score. Measures workforce capability levels against competency framework standards."
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score. Directly measures staff delivery against program and organizational goals."
    - name: "pip_required_count"
      expr: COUNT(CASE WHEN pip_required = TRUE THEN 1 END)
      comment: "Count of reviews requiring a performance improvement plan. Tracks underperformance prevalence; high counts signal systemic management or workload issues."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommendation = TRUE THEN 1 END)
      comment: "Count of staff recommended for promotion. Measures internal talent pipeline depth for succession planning."
    - name: "retention_risk_count"
      expr: COUNT(CASE WHEN retention_risk_flag = TRUE THEN 1 END)
      comment: "Count of staff flagged as retention risks. Critical talent risk metric — triggers targeted retention interventions to prevent loss of key personnel."
    - name: "employee_disagreement_count"
      expr: COUNT(CASE WHEN employee_disagreement_flag = TRUE THEN 1 END)
      comment: "Count of reviews with employee disagreement. High disagreement rates indicate calibration quality issues or management relationship problems."
    - name: "avg_values_alignment_rating"
      expr: AVG(CAST(values_alignment_rating AS DOUBLE))
      comment: "Average values alignment rating. Measures organizational culture health; low scores may indicate safeguarding or conduct risks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization, balance management, and compliance metrics. Tracks leave consumption patterns, R&R entitlements, and approval cycle times to support workforce availability planning and duty-of-care compliance. Critical for field operations where leave management directly impacts program delivery."
  source: "`vibe_ngo_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (Annual, Sick, R&R, Maternity, Paternity, Emergency) — primary dimension for leave pattern analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Leave approval status (Pending, Approved, Rejected, Cancelled) — tracks process compliance and bottlenecks."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables leave utilization comparison across staff categories."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — identifies geographic patterns in leave utilization and R&R compliance."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type — leave entitlements vary by contract type; enables entitlement compliance monitoring."
    - name: "is_rnr_eligible"
      expr: is_rnr_eligible
      comment: "R&R eligibility flag — tracks rest and recuperation leave compliance for staff in hardship locations."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Retroactive leave request flag — high retroactive rates indicate poor leave planning or system usage issues."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year — enables annual leave utilization trending and carry-forward liability analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', requested_start_date)
      comment: "Month of leave request — identifies seasonal leave patterns affecting program delivery capacity."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests submitted. Baseline volume metric for HR workload and leave management system utilization."
    - name: "approved_leave_requests"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved leave requests. Numerator for approval rate; measures leave management process efficiency."
    - name: "total_days_requested"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested. Measures aggregate workforce absence demand for capacity planning."
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total leave days actually taken. Actual workforce absence impact metric for program delivery capacity planning."
    - name: "total_carry_forward_days"
      expr: SUM(CAST(carry_forward_days AS DOUBLE))
      comment: "Total leave days carried forward. Represents accrued leave liability; high carry-forward balances indicate staff are not taking adequate rest — a duty-of-care risk."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total time-off-in-lieu hours accrued. Tracks overtime compensation liability and workload intensity in field operations."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance remaining after request. Low average balances indicate staff are exhausting entitlements — a burnout and retention risk signal."
    - name: "rnr_leave_requests"
      expr: COUNT(CASE WHEN is_rnr_eligible = TRUE THEN 1 END)
      comment: "Count of R&R-eligible leave requests. Tracks duty-of-care compliance for staff in hardship locations; low counts relative to eligible staff indicate R&R policy non-compliance."
    - name: "rejected_leave_requests"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected leave requests. High rejection rates may indicate operational capacity constraints or management issues requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff learning completion, certification compliance, and training investment metrics. Tracks mandatory training adherence, learning outcomes, and cost-per-learner to support capacity building strategy and donor compliance. Aligns with LMS reporting (Cornerstone, Moodle, SAP SuccessFactors Learning) used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status (Enrolled, In Progress, Completed, Failed, Withdrawn) — primary completion tracking dimension."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Mandatory training flag — separates compliance-required training from optional development for compliance rate calculation."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome — measures training effectiveness and identifies courses with high failure rates."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Online, in-person, blended — enables cost and completion rate comparison across delivery modalities."
    - name: "course_category"
      expr: course_category
      comment: "Course category (Safeguarding, Technical, Leadership, Compliance) — enables investment analysis by learning domain."
    - name: "staff_type"
      expr: staff_type
      comment: "Staff type — enables learning investment and completion rate analysis by workforce segment."
    - name: "is_certified"
      expr: is_certified
      comment: "Certification awarded flag — tracks certification pipeline for compliance and professional development reporting."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment — enables monthly learning activity trending and training cycle planning."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of completion — tracks learning throughput and identifies completion bottlenecks."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total learning enrollments. Baseline training activity volume metric for L&D capacity planning and donor capacity building reporting."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN 1 END)
      comment: "Count of completed enrollments. Numerator for completion rate; measures L&D program effectiveness."
    - name: "mandatory_training_completions"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND enrollment_status = 'Completed' THEN 1 END)
      comment: "Count of mandatory training completions. Critical compliance metric — low completion rates for mandatory training (e.g., safeguarding, PSEA) represent organizational risk and donor audit findings."
    - name: "mandatory_training_enrollments"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory training enrollments. Denominator for mandatory completion rate calculation."
    - name: "certified_completions"
      expr: COUNT(CASE WHEN is_certified = TRUE THEN 1 END)
      comment: "Count of enrollments resulting in certification. Tracks professional certification pipeline for compliance and career development reporting."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total training expenditure. Key L&D investment metric for budget planning and cost-per-learner benchmarking."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per enrollment. Enables cost efficiency comparison across delivery modes and providers."
    - name: "total_learning_hours"
      expr: SUM(CAST(actual_hours_spent AS DOUBLE))
      comment: "Total actual learning hours invested. Measures workforce capacity building effort; reported to donors as evidence of organizational development."
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across enrollments. Measures training effectiveness and knowledge retention; low scores trigger curriculum review."
    - name: "failed_enrollments"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed training assessments. High failure rates on critical courses (safeguarding, security) indicate training quality or staff readiness issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff time allocation, effort certification, and grant charge compliance metrics. Critical for US federal award compliance (2 CFR 200 effort reporting), IPSAS staff cost allocation, and donor financial reporting. Aligns with Workday Time Tracking and SAP CATS (Cross-Application Time Sheet) used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "timesheet_status"
      expr: timesheet_status
      comment: "Timesheet status (Draft, Submitted, Approved, Rejected) — primary compliance monitoring dimension."
    - name: "is_grant_chargeable"
      expr: is_grant_chargeable
      comment: "Grant-chargeable flag — separates direct grant costs from indirect/overhead for donor financial reporting."
    - name: "is_billable"
      expr: is_billable
      comment: "Billable flag — identifies time that can be charged to grants or contracts."
    - name: "is_cost_shared"
      expr: is_cost_shared
      comment: "Cost-share flag — tracks cost-sharing commitments required by certain donor agreements."
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Field deployment flag — separates field vs. HQ time allocation for operational analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables time allocation analysis by workforce segment."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type — effort reporting requirements vary by contract type."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code — enables grant-level staff time cost analysis required for donor financial reporting."
    - name: "work_period_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of work period — enables monthly time allocation trending and budget vs. actual analysis."
    - name: "effort_certification_required"
      expr: effort_certification_required
      comment: "Effort certification requirement flag — identifies timesheets requiring formal effort certification for federal award compliance."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheets. Primary staff time investment metric for program delivery capacity and grant cost allocation."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours. Baseline for workload analysis and FTE utilization calculation."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. High overtime indicates understaffing or surge conditions; triggers workforce planning review and duty-of-care assessment."
    - name: "total_grant_chargeable_hours"
      expr: SUM(CASE WHEN is_grant_chargeable = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours chargeable to grants. Direct input for grant financial reporting and effort certification compliance under 2 CFR 200."
    - name: "total_cost_shared_hours"
      expr: SUM(CASE WHEN is_cost_shared = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total cost-shared hours. Tracks cost-sharing commitments to donors; insufficient cost-share can trigger grant compliance findings."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage per timesheet. Measures staff allocation intensity; used to validate grant budget effort assumptions."
    - name: "approved_timesheets"
      expr: COUNT(CASE WHEN timesheet_status = 'Approved' THEN 1 END)
      comment: "Count of approved timesheets. Numerator for approval rate; measures timesheet compliance and manager accountability."
    - name: "total_timesheets"
      expr: COUNT(1)
      comment: "Total timesheet records. Baseline volume metric for effort reporting completeness monitoring."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total time-off-in-lieu hours accrued from timesheets. Tracks overtime compensation liability and workload intensity."
    - name: "uncertified_effort_timesheets"
      expr: COUNT(CASE WHEN effort_certification_required = TRUE AND timesheet_status != 'Approved' THEN 1 END)
      comment: "Count of timesheets requiring effort certification that are not yet approved. Critical compliance risk metric for US federal award audits — uncertified effort is a major audit finding."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_separation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff attrition, separation cost, and offboarding compliance metrics. Tracks voluntary vs. involuntary turnover, severance costs, and offboarding process completion to support retention strategy and organizational risk management. Aligns with Workday HCM termination reporting and INGO HR analytics."
  source: "`vibe_ngo_v1`.`workforce`.`separation_event`"
  dimensions:
    - name: "primary_departure_reason"
      expr: primary_departure_reason
      comment: "Primary reason for departure (Resignation, End of Contract, Redundancy, Dismissal) — key dimension for attrition root cause analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type at separation — enables attrition analysis by employment category."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables attrition rate comparison across staff categories."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station at separation — identifies geographic attrition hotspots requiring targeted retention interventions."
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Rehire eligibility status — tracks talent pool quality and identifies staff who left in good standing."
    - name: "exit_interview_status"
      expr: exit_interview_status
      comment: "Exit interview completion status — low completion rates reduce organizational learning from departures."
    - name: "safeguarding_clearance_status"
      expr: safeguarding_clearance_status
      comment: "Safeguarding clearance status at separation — critical compliance metric; incomplete clearances represent organizational risk."
    - name: "system_access_revoked"
      expr: system_access_revoked
      comment: "System access revocation flag — IT security compliance metric; unrevoked access post-separation is a data security risk."
    - name: "separation_year"
      expr: YEAR(effective_date)
      comment: "Year of separation — enables year-over-year attrition trending."
    - name: "knowledge_transfer_completed"
      expr: knowledge_transfer_completed
      comment: "Knowledge transfer completion flag — incomplete transfers represent operational continuity risk."
  measures:
    - name: "total_separations"
      expr: COUNT(1)
      comment: "Total staff separations. Primary attrition volume metric for workforce stability monitoring and retention strategy evaluation."
    - name: "voluntary_separations"
      expr: COUNT(CASE WHEN primary_departure_reason IN ('Resignation', 'Voluntary Resignation') THEN 1 END)
      comment: "Count of voluntary separations. Voluntary turnover rate is the primary retention health indicator; high rates signal compensation, management, or culture issues."
    - name: "total_severance_pay"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance pay disbursed. Quantifies separation cost liability for budget planning and financial risk management."
    - name: "total_final_settlement"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts paid. Comprehensive separation cost metric including all terminal benefits for financial planning."
    - name: "avg_years_of_service_at_separation"
      expr: AVG(CAST(years_of_service AS DOUBLE))
      comment: "Average tenure at separation. Low average tenure indicates high early-career attrition; high tenure loss signals risk of institutional knowledge drain."
    - name: "avg_leave_encashment_days"
      expr: AVG(CAST(leave_encashment_days AS DOUBLE))
      comment: "Average leave days encashed at separation. High values indicate staff are not taking adequate leave — a duty-of-care and accrued liability risk."
    - name: "incomplete_safeguarding_clearances"
      expr: COUNT(CASE WHEN safeguarding_clearance_status != 'Cleared' AND safeguarding_clearance_status IS NOT NULL THEN 1 END)
      comment: "Count of separations with incomplete safeguarding clearance. Critical compliance risk — incomplete clearances may indicate unresolved safeguarding concerns requiring escalation."
    - name: "unrevoked_system_access_count"
      expr: COUNT(CASE WHEN system_access_revoked = FALSE THEN 1 END)
      comment: "Count of separations where system access has not been revoked. IT security risk metric — unrevoked access post-separation violates data protection policies and donor data security requirements."
    - name: "exit_interview_completion_count"
      expr: COUNT(CASE WHEN exit_interview_status = 'Completed' THEN 1 END)
      comment: "Count of completed exit interviews. Measures organizational learning from departures; low completion rates reduce retention strategy effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit enrollment, cost, and coverage metrics. Tracks benefit uptake, employer contribution liability, and coverage gaps to support total compensation management and duty-of-care compliance. Aligns with Workday Benefits and SAP HR benefits administration used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Benefit enrollment status (Active, Terminated, Waived, Pending) — primary coverage monitoring dimension."
    - name: "plan_type"
      expr: plan_type
      comment: "Benefit plan type (Medical, Dental, Pension, Life Insurance, Medevac) — enables cost breakdown by benefit category."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category — enables benefit cost and coverage analysis by workforce segment."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — benefit costs vary significantly by location; geographic analysis supports budget planning."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Enrollment trigger event (New Hire, Open Enrollment, Life Event, Termination) — tracks enrollment activity patterns."
    - name: "is_dependent_coverage"
      expr: is_dependent_coverage
      comment: "Dependent coverage flag — separates employee-only from family coverage for cost analysis."
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "COBRA eligibility flag — tracks continuation coverage obligations for separated staff."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution frequency (Monthly, Bi-weekly) — used for payroll deduction scheduling and cash flow planning."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total benefit enrollments. Baseline coverage volume metric for benefits administration monitoring."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of active benefit enrollments. Measures current benefit coverage scope for duty-of-care compliance reporting."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions. Key component of true employment cost for budget planning and grant cost allocation."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contributions. Measures staff cost-sharing in benefit programs; used for compensation benchmarking."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment. Enables benefit cost benchmarking across plan types and staff categories."
    - name: "total_life_insurance_coverage"
      expr: SUM(CAST(life_insurance_coverage_amount AS DOUBLE))
      comment: "Total life insurance coverage amount across all enrollments. Measures aggregate insurance liability and duty-of-care coverage scope."
    - name: "avg_pension_contribution_rate"
      expr: AVG(CAST(pension_contribution_rate_pct AS DOUBLE))
      comment: "Average pension contribution rate. Used for pension liability forecasting and IPSAS employee benefit obligation disclosures."
    - name: "dependent_coverage_enrollments"
      expr: COUNT(CASE WHEN is_dependent_coverage = TRUE THEN 1 END)
      comment: "Count of enrollments with dependent coverage. Measures family benefit cost exposure and informs benefit plan design decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_staff_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff deployment, effort allocation, and grant charge distribution metrics. Tracks how staff time and effort are distributed across programs, grants, and field locations — critical for grant financial reporting, effort certification, and operational capacity planning. Aligns with SAP HR assignment management and Workday staffing used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`workforce_staff_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status (Active, Completed, Cancelled, On Hold) — primary filter for current deployment analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type (Primary, Secondary, TDY, Surge) — distinguishes permanent from temporary deployments."
    - name: "staff_category"
      expr: staff_category
      comment: "National, international, consultant — enables deployment analysis by workforce segment."
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Field deployment flag — separates field vs. HQ assignments for operational capacity analysis."
    - name: "is_surge_deployment"
      expr: is_surge_deployment
      comment: "Surge deployment flag — tracks emergency response staffing capacity."
    - name: "is_cost_shared"
      expr: is_cost_shared
      comment: "Cost-share flag — identifies assignments contributing to donor cost-sharing commitments."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Funding source type (Grant, Core, Cost-Share) — enables staff cost allocation analysis by funding category."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code for the assignment — enables grant-level staff deployment reporting required by donors."
    - name: "hardship_level"
      expr: hardship_level
      comment: "Hardship level of assignment location — drives allowance calculations and duty-of-care monitoring."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Assignment start year — enables year-over-year deployment volume trending."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total staff assignments. Baseline deployment volume metric for workforce planning and grant staffing plan compliance."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END)
      comment: "Count of currently active assignments. Measures current deployed workforce capacity for operational planning."
    - name: "total_fte_deployed"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent deployed across all active assignments. Measures actual workforce capacity deployed against program needs."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage per assignment. Validates grant budget effort assumptions and identifies over/under-allocated staff."
    - name: "surge_deployment_count"
      expr: COUNT(CASE WHEN is_surge_deployment = TRUE THEN 1 END)
      comment: "Count of surge deployments. Measures emergency response staffing intensity; high counts indicate active crisis response requiring resource monitoring."
    - name: "field_deployment_count"
      expr: COUNT(CASE WHEN is_field_deployment = TRUE THEN 1 END)
      comment: "Count of field deployments. Tracks field presence capacity; critical for program delivery and security management planning."
    - name: "cost_shared_assignments"
      expr: COUNT(CASE WHEN is_cost_shared = TRUE THEN 1 END)
      comment: "Count of cost-shared assignments. Tracks cost-sharing commitment fulfillment required by donor agreements."
    - name: "distinct_grants_staffed"
      expr: COUNT(DISTINCT grant_code)
      comment: "Number of distinct grants with staff assignments. Measures grant portfolio staffing coverage and identifies grants at risk of understaffing."
    - name: "safeguarding_trained_assignments"
      expr: COUNT(CASE WHEN safeguarding_training_completed = TRUE THEN 1 END)
      comment: "Count of assignments where safeguarding training is completed. Critical compliance metric — all deployed staff must complete safeguarding training per CHS and donor requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case volume, resolution, and compliance metrics. Tracks case types, outcomes, and mandatory reporting obligations to support organizational accountability, safeguarding compliance, and donor reporting. Critical for CHS self-assessment and PSEA compliance monitoring."
  source: "`vibe_ngo_v1`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Case status (Open, Under Investigation, Closed, Appealed) — primary case pipeline monitoring dimension."
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case (Misconduct, PSEA, Fraud, Harassment, Performance) — enables risk categorization and trend analysis."
    - name: "is_psea_case"
      expr: is_psea_case
      comment: "PSEA case flag — separates sexual exploitation and abuse cases for mandatory donor reporting and safeguarding compliance."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Investigation outcome (Substantiated, Unsubstantiated, Inconclusive) — measures investigation quality and case resolution patterns."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of subject — enables disciplinary pattern analysis by workforce segment."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country where incident occurred — enables geographic risk pattern analysis."
    - name: "is_mandatory_donor_report_required"
      expr: is_mandatory_donor_report_required
      comment: "Mandatory donor reporting flag — tracks compliance with donor reporting obligations for serious misconduct."
    - name: "beneficiary_involved"
      expr: beneficiary_involved
      comment: "Beneficiary involvement flag — cases involving beneficiaries carry highest risk and require priority escalation."
    - name: "case_priority"
      expr: case_priority
      comment: "Case priority level — enables prioritization of high-risk cases for management attention."
    - name: "case_opened_year"
      expr: YEAR(case_opened_date)
      comment: "Year case was opened — enables year-over-year disciplinary trend analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total disciplinary cases. Baseline misconduct volume metric for organizational risk monitoring and CHS self-assessment reporting."
    - name: "open_cases"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Count of currently open cases. Measures unresolved disciplinary risk exposure; high open case counts indicate investigation capacity constraints."
    - name: "psea_cases"
      expr: COUNT(CASE WHEN is_psea_case = TRUE THEN 1 END)
      comment: "Count of PSEA cases. Critical safeguarding metric — mandatory for donor reporting and PSEA network compliance; any PSEA case triggers immediate escalation protocols."
    - name: "beneficiary_involved_cases"
      expr: COUNT(CASE WHEN beneficiary_involved = TRUE THEN 1 END)
      comment: "Count of cases involving beneficiaries. Highest-risk category requiring priority investigation and mandatory donor reporting."
    - name: "mandatory_donor_reports_required"
      expr: COUNT(CASE WHEN is_mandatory_donor_report_required = TRUE THEN 1 END)
      comment: "Count of cases requiring mandatory donor reporting. Tracks compliance with donor reporting obligations; unreported cases represent contractual and reputational risk."
    - name: "substantiated_cases"
      expr: COUNT(CASE WHEN investigation_outcome = 'Substantiated' THEN 1 END)
      comment: "Count of substantiated cases. Measures confirmed misconduct prevalence; used for organizational risk assessment and prevention program targeting."
    - name: "cases_with_external_investigator"
      expr: COUNT(CASE WHEN is_external_investigator = TRUE THEN 1 END)
      comment: "Count of cases using external investigators. High external investigation rates indicate serious case complexity or internal capacity gaps."
    - name: "donor_reports_submitted_count"
      expr: COUNT(CASE WHEN donor_report_submitted_date IS NOT NULL THEN 1 END)
      comment: "Count of cases with donor reports submitted. Measures donor reporting compliance; gap between required and submitted reports is a critical compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_expat_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expatriate compensation package cost and composition metrics. Tracks total expat cost-of-employment, allowance structures, and package utilization to support international staffing cost management and localization strategy. Aligns with Workday Global Payroll and SAP HR expat management used by large INGOs."
  source: "`vibe_ngo_v1`.`workforce`.`expat_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Package status (Active, Expired, Pending Approval) — primary filter for current expat cost exposure."
    - name: "package_type"
      expr: package_type
      comment: "Package type (Standard, Enhanced, Emergency) — enables cost comparison across package tiers."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station — primary geographic dimension for expat cost analysis and hardship allowance benchmarking."
    - name: "hardship_allowance_tier"
      expr: hardship_allowance_tier
      comment: "Hardship tier (A, B, C, D, E) — drives allowance levels; enables cost analysis by hardship classification."
    - name: "home_country"
      expr: home_country
      comment: "Staff home country — enables analysis of expat origin patterns and repatriation cost planning."
    - name: "tax_equalization_applicable"
      expr: tax_equalization_applicable
      comment: "Tax equalization flag — identifies packages with tax equalization obligations, which significantly increase total cost."
    - name: "dependents_covered"
      expr: dependents_covered
      comment: "Dependent coverage flag — packages with dependents have significantly higher total cost."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status — identifies unapproved packages that may represent unauthorized commitments."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total expat packages. Baseline expat workforce volume metric for international staffing cost planning."
    - name: "active_packages"
      expr: COUNT(CASE WHEN package_status = 'Active' THEN 1 END)
      comment: "Count of active expat packages. Measures current expat cost exposure for budget monitoring."
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all expat packages. Primary expat compensation cost metric for budget planning."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowances across expat packages. Quantifies field incentive cost; high values indicate significant presence in high-hardship locations."
    - name: "total_housing_allowance"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowances. Major expat cost component; tracked for grant budget compliance and cost-of-employment benchmarking."
    - name: "total_education_allowance"
      expr: SUM(CAST(education_allowance_amount AS DOUBLE))
      comment: "Total education allowances for expat dependents. Significant cost component for packages with school-age dependents."
    - name: "total_relocation_allowance"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowances. One-time cost tracked for budget accuracy and expat mobility cost analysis."
    - name: "total_repatriation_allowance"
      expr: SUM(CAST(repatriation_allowance_amount AS DOUBLE))
      comment: "Total repatriation allowances committed. Forward-looking liability metric for financial planning when expat assignments end."
    - name: "avg_employer_pension_contribution_pct"
      expr: AVG(CAST(employer_pension_contribution_pct AS DOUBLE))
      comment: "Average employer pension contribution percentage. Used for pension liability forecasting and IPSAS employee benefit obligation disclosures."
    - name: "tax_equalization_packages"
      expr: COUNT(CASE WHEN tax_equalization_applicable = TRUE THEN 1 END)
      comment: "Count of packages with tax equalization. Tax equalization significantly increases total employment cost; tracks this high-cost obligation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position management, vacancy tracking, and organizational structure metrics for workforce planning and budgeting"
  source: "`vibe_ngo_v1`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Current status of position (active, frozen, closed)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position (regular, temporary, project-based)"
    - name: "is_vacant"
      expr: is_vacant
      comment: "Whether position is currently vacant"
    - name: "is_supervisory"
      expr: is_supervisory
      comment: "Whether position has supervisory responsibilities"
    - name: "is_field_position"
      expr: is_field_position
      comment: "Whether position is field-based"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of position"
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (core, grant, project)"
    - name: "pay_grade_band"
      expr: pay_grade_band
      comment: "Pay grade band of position"
    - name: "vacancy_reason"
      expr: vacancy_reason
      comment: "Reason for vacancy"
  measures:
    - name: "total_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Total number of positions in organizational structure"
    - name: "vacant_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END)
      comment: "Count of vacant positions"
    - name: "filled_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = FALSE THEN position_id END)
      comment: "Count of filled positions"
    - name: "supervisory_positions"
      expr: COUNT(DISTINCT CASE WHEN is_supervisory = TRUE THEN position_id END)
      comment: "Count of supervisory positions"
    - name: "field_positions"
      expr: COUNT(DISTINCT CASE WHEN is_field_position = TRUE THEN position_id END)
      comment: "Count of field-based positions"
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Total budgeted annual cost for all positions"
    - name: "avg_budgeted_cost"
      expr: AVG(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Average budgeted annual cost per position"
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across all positions"
    - name: "avg_max_salary"
      expr: AVG(CAST(max_salary AS DOUBLE))
      comment: "Average maximum salary across positions"
$$;