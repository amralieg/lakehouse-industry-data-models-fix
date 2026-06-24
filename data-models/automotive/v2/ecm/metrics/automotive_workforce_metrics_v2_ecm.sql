-- Metric views for domain: workforce | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics. Drives executive decisions on workforce size, diversity, attrition risk, and organisational structure across plants and departments."
  source: "`vibe_automotive_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active, terminated, on-leave — primary filter for headcount analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contractor — drives cost and capacity planning"
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity and inclusion reporting"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level workforce distribution analysis"
    - name: "work_location"
      expr: work_location
      comment: "Physical work location for geographic headcount distribution"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial allocation and workforce cost reporting"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort and hiring trend analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition trend analysis"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records — baseline headcount KPI used in every workforce dashboard and board deck"
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees — primary operational headcount figure for capacity and cost planning"
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of employees with a termination date — used to compute attrition rate and workforce stability KPIs"
    - name: "contractor_headcount"
      expr: COUNT(CASE WHEN employment_type = 'Contractor' THEN 1 END)
      comment: "Count of contractor employees — tracks contingent workforce exposure and cost risk"
    - name: "female_headcount"
      expr: COUNT(CASE WHEN gender = 'Female' THEN 1 END)
      comment: "Count of female employees — numerator for gender diversity ratio reported to board and regulators"
    - name: "new_hires_count"
      expr: COUNT(CASE WHEN hire_date >= DATE_TRUNC('year', CURRENT_DATE) THEN 1 END)
      comment: "Employees hired in the current calendar year — measures recruiting velocity against headcount plan"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and efficiency metrics by pay period, employee, and cost centre. Directly informs total labour cost, overtime spend, and net-pay liability — critical inputs to P&L and budget variance reporting."
  source: "`vibe_automotive_v1`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll run status (processed, pending, error) — filters for confirmed payroll data"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll amounts for multi-currency consolidation"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment for annual labour cost trend analysis"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for monthly payroll cost reporting"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost — primary labour cost KPI for P&L and budget variance; triggers executive action when over budget"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed — cash-flow liability measure for treasury and finance planning"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay — high-value cost control KPI; sustained elevation signals understaffing or production overload"
    - name: "total_tax_deductions"
      expr: SUM(CAST(tax_deductions AS DOUBLE))
      comment: "Total tax withheld — regulatory compliance measure for payroll tax reporting"
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deductions AS DOUBLE))
      comment: "Total benefit deductions — tracks employee benefit cost absorption and plan utilisation"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record — benchmarks compensation levels and detects anomalies"
    - name: "overtime_pay_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Overtime pay as a percentage of total gross pay — key efficiency KPI; high ratio indicates capacity or scheduling issues requiring management intervention"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce absence and leave analytics. Tracks absence volume, duration, and approval patterns — critical for productivity, compliance, and workforce availability planning."
  source: "`vibe_automotive_v1`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, FMLA, etc.) — primary dimension for absence root-cause analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the absence request — identifies unapproved or pending absences requiring HR action"
    - name: "absence_year"
      expr: YEAR(start_date)
      comment: "Year the absence started — for annual absence trend reporting"
    - name: "absence_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the absence started — for seasonal absence pattern analysis"
    - name: "reason"
      expr: reason
      comment: "Stated reason for absence — supports root-cause categorisation and wellness programme targeting"
  measures:
    - name: "total_absence_events"
      expr: COUNT(1)
      comment: "Total number of absence events — baseline volume KPI for absence frequency tracking"
    - name: "total_absence_days"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total calendar days lost to absence — primary productivity impact measure; directly tied to output capacity and overtime cost"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average duration of an absence event — distinguishes short-term from long-term absence patterns, informing return-to-work programmes"
    - name: "unapproved_absence_count"
      expr: COUNT(CASE WHEN approval_status = 'Unapproved' THEN 1 END)
      comment: "Count of unapproved absence records — compliance and HR governance KPI; high count signals policy adherence issues"
    - name: "long_term_absence_count"
      expr: COUNT(CASE WHEN total_days >= 28 THEN 1 END)
      comment: "Absences lasting 28 or more days — identifies long-term absence cases requiring case management and potential disability review"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics covering hours worked, overtime, and approval compliance. Drives labour efficiency, scheduling optimisation, and compliance with labour agreements."
  source: "`vibe_automotive_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, training, etc.) — segments hours for cost allocation"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry — identifies unapproved hours that may not be payable"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre for labour cost allocation and variance analysis"
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work date for annual hours trend analysis"
    - name: "work_month"
      expr: DATE_TRUNC('month', work_date)
      comment: "Month of work date for monthly labour hours reporting"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total regular hours worked — primary labour input measure for productivity and capacity analysis"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — cost and capacity KPI; sustained high overtime signals need for additional headcount or shift restructuring"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per time entry — detects scheduling anomalies and part-time vs full-time utilisation patterns"
    - name: "overtime_hours_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked — key labour efficiency KPI; high ratio triggers scheduling and staffing review"
    - name: "unapproved_time_entries"
      expr: COUNT(CASE WHEN approval_status != 'Approved' THEN 1 END)
      comment: "Count of time entries not yet approved — payroll compliance KPI; unapproved entries block payroll processing and create audit risk"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance review completion and rating distribution metrics. Informs talent management, succession planning, and compensation decisions at the executive level."
  source: "`vibe_automotive_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "overall_rating"
      expr: overall_rating
      comment: "Performance rating category (Exceeds, Meets, Below, etc.) — primary dimension for talent segmentation and calibration"
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (completed, in-progress, overdue) — tracks review cycle completion compliance"
    - name: "review_period"
      expr: review_period
      comment: "Review period label (e.g. 2024-H1) — enables year-over-year and half-year performance trend analysis"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was conducted — for annual performance cycle reporting"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews — baseline for review cycle completion tracking"
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of completed reviews — numerator for review completion rate; low completion rate is a governance risk flagged to CHRO"
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews completed — executive KPI for HR governance; below-target rates trigger escalation to business unit leaders"
    - name: "high_performer_count"
      expr: COUNT(CASE WHEN overall_rating IN ('Exceeds Expectations', 'Outstanding', 'High Performer') THEN 1 END)
      comment: "Count of employees rated as high performers — talent pipeline KPI used in succession planning and retention investment decisions"
    - name: "low_performer_count"
      expr: COUNT(CASE WHEN overall_rating IN ('Below Expectations', 'Needs Improvement', 'Unsatisfactory') THEN 1 END)
      comment: "Count of employees rated as low performers — triggers performance improvement plan (PIP) actions and informs restructuring decisions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and certification currency metrics. Critical for regulatory compliance (ISO, IATF 16949, safety), skills development ROI, and audit readiness."
  source: "`vibe_automotive_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Training completion status (completed, in-progress, failed, expired) — primary filter for compliance reporting"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year training was completed — for annual training volume and compliance trend analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month training was completed — for training throughput and scheduling analysis"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year certification expires — identifies upcoming compliance gaps requiring renewal scheduling"
  measures:
    - name: "total_training_completions"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN 1 END)
      comment: "Total completed training records — baseline training throughput KPI for L&D investment reporting"
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assigned trainings completed — regulatory compliance KPI; below-threshold rates trigger audit findings and corrective actions"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across training completions — measures training effectiveness and identifies courses requiring redesign"
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE AND training_status = 'Completed' THEN 1 END)
      comment: "Count of training certifications past their expiry date — compliance risk KPI; expired certs on safety-critical roles trigger immediate remediation"
    - name: "distinct_trained_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees with at least one training record — measures training programme reach and coverage across the workforce"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident frequency, severity, and lost-time metrics. Mandatory for OSHA/regulatory reporting, ESG disclosures, and executive safety governance — directly tied to legal liability and insurance costs."
  source: "`vibe_automotive_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (near-miss, first-aid, recordable, LTI) — primary dimension for safety risk categorisation"
    - name: "severity"
      expr: severity
      comment: "Severity level of the incident — drives prioritisation of corrective actions and root-cause investigations"
    - name: "is_recordable"
      expr: is_recordable
      comment: "Whether the incident is OSHA-recordable — filters for regulatory reporting compliance"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category — enables systemic safety improvement targeting"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident — for annual safety performance trend and year-over-year comparison"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident — for seasonal safety pattern analysis and monthly safety KPI reporting"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents — baseline safety frequency KPI reported to board and regulators"
    - name: "recordable_incidents"
      expr: COUNT(CASE WHEN is_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents — mandatory regulatory reporting metric; directly impacts OSHA 300 log and insurance premiums"
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity IN ('High', 'Critical', 'Fatality') THEN 1 END)
      comment: "Count of high or critical severity incidents — executive safety KPI; any increase triggers immediate board-level review and regulatory notification"
    - name: "distinct_employees_injured"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees involved in safety incidents — measures breadth of safety exposure across the workforce"
    - name: "distinct_plants_with_incidents"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of distinct plants with recorded safety incidents — identifies high-risk facilities requiring targeted safety investment"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_talent_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline metrics covering open requisitions, time-to-fill, and hiring manager activity. Drives recruiting capacity planning and workforce gap closure decisions."
  source: "`vibe_automotive_v1`.`workforce`.`talent_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the requisition (open, filled, cancelled, on-hold) — primary filter for active pipeline analysis"
    - name: "job_title"
      expr: job_title
      comment: "Job title being recruited for — identifies high-demand roles and skill gaps"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the requisition was created — for annual recruiting volume trend analysis"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the requisition was created — for monthly recruiting pipeline reporting"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total talent requisitions — baseline recruiting pipeline volume KPI"
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN 1 END)
      comment: "Count of currently open requisitions — primary talent gap KPI; high open count signals workforce capacity risk and recruiting bottleneck"
    - name: "filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions — measures recruiting effectiveness and throughput"
    - name: "requisition_fill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions successfully filled — recruiting efficiency KPI; low fill rate triggers review of sourcing strategy and compensation competitiveness"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and candidate pipeline metrics. Measures application volume, source channel effectiveness, and conversion — directly informs recruiting investment and employer brand strategy."
  source: "`vibe_automotive_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Stage of the application (applied, screened, interviewed, offered, hired, rejected) — primary funnel stage dimension"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel (LinkedIn, referral, job board, campus, etc.) — measures channel ROI and sourcing effectiveness"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application — for annual application volume and hiring trend analysis"
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application — for monthly recruiting funnel reporting"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total job applications received — baseline recruiting funnel volume KPI; measures employer brand reach"
    - name: "hired_applicants"
      expr: COUNT(CASE WHEN application_status = 'Hired' THEN 1 END)
      comment: "Count of applicants who were hired — measures recruiting funnel conversion output"
    - name: "application_to_hire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Hired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications resulting in a hire — recruiting funnel efficiency KPI; low rate may indicate sourcing quality issues or misaligned job descriptions"
    - name: "distinct_source_channels"
      expr: COUNT(DISTINCT source_channel)
      comment: "Number of distinct recruiting source channels active — measures diversity of sourcing strategy"
    - name: "rejected_applicants"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected applications — combined with total applications gives rejection rate for sourcing quality assessment"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure and cost metrics by plan type, currency, and status. Informs total compensation cost, pay equity analysis, and budget planning for the CHRO and CFO."
  source: "`vibe_automotive_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Compensation plan type (base, variable, executive, hourly) — primary dimension for compensation structure analysis"
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the compensation plan (active, expired, pending) — filters for current compensation obligations"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation amounts — required for multi-currency consolidation"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the compensation plan became effective — for compensation trend and annual review cycle analysis"
  measures:
    - name: "total_base_salary_cost"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary across all active compensation plans — primary fixed labour cost KPI for budget planning and P&L forecasting"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary per compensation plan — benchmarks pay levels against market data and internal equity targets"
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_percent AS DOUBLE))
      comment: "Average bonus target percentage — measures variable pay exposure and total compensation cost risk"
    - name: "total_target_bonus_cost"
      expr: SUM(CAST(base_salary AS DOUBLE) * CAST(bonus_target_percent AS DOUBLE) / 100.0)
      comment: "Total estimated bonus cost at target (base salary × bonus target %) — variable compensation liability KPI for budget and accrual planning"
    - name: "active_compensation_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Count of currently active compensation plans — baseline for compensation programme coverage and audit completeness"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_labor_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labour cost allocation metrics by cost centre and employee. Enables accurate product cost accounting, overhead absorption analysis, and budget variance reporting — critical for automotive manufacturing P&L."
  source: "`vibe_automotive_v1`.`workforce`.`labor_cost_allocation`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost allocation amounts — required for multi-currency consolidation"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year of cost allocation — for annual labour cost trend and budget variance analysis"
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of cost allocation — for monthly cost centre reporting and variance tracking"
  measures:
    - name: "total_allocated_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total labour cost allocated across cost centres — primary labour cost absorption KPI for product costing and overhead analysis"
    - name: "total_allocated_hours"
      expr: SUM(CAST(hours_allocated AS DOUBLE))
      comment: "Total hours allocated to cost centres — measures labour input for productivity and standard cost variance analysis"
    - name: "avg_cost_per_hour"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_allocated AS DOUBLE)), 0), 2)
      comment: "Average labour cost per allocated hour — key cost efficiency KPI; deviations from standard rate trigger variance investigation"
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage per record — identifies employees or cost centres with partial or split allocations requiring review"
    - name: "distinct_cost_centers_allocated"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centres receiving labour cost allocations — measures breadth of cost absorption and identifies unallocated cost pools"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit enrolment and cost metrics. Tracks benefit programme participation, employer cost exposure, and coverage distribution — informs total rewards strategy and benefits budget."
  source: "`vibe_automotive_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrolment status (active, terminated, pending, waived) — primary filter for active benefit cost reporting"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage tier (employee only, employee+spouse, family) — drives per-employee benefit cost analysis"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrolment — for annual open enrolment participation trend analysis"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the benefit coverage became effective — for benefit cost accrual and budget planning"
  measures:
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer benefit contribution cost — primary benefits cost KPI for total compensation budgeting and P&L impact"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee benefit contributions — measures employee cost-sharing and benefit plan affordability"
    - name: "avg_employer_contribution_per_enrollment"
      expr: AVG(CAST(employer_contribution AS DOUBLE))
      comment: "Average employer contribution per enrolment record — benchmarks benefit cost per employee for plan design decisions"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of active benefit enrolments — measures benefit programme participation and coverage completeness"
    - name: "employer_cost_share_pct"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution AS DOUBLE)) / NULLIF(SUM(CAST(employer_contribution AS DOUBLE)) + SUM(CAST(employee_contribution AS DOUBLE)), 0), 2)
      comment: "Employer share of total benefit cost as a percentage — measures employer benefit generosity and cost-sharing balance; informs plan redesign decisions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification currency and compliance metrics. Tracks active, expiring, and expired certifications — mandatory for IATF 16949, ISO 45001, and regulatory compliance in automotive manufacturing."
  source: "`vibe_automotive_v1`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Status of the certification (active, expired, suspended, pending) — primary compliance filter"
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the certification — identifies specific compliance requirements and skill credentials"
    - name: "certification_body"
      expr: certification_body
      comment: "Issuing body of the certification — distinguishes regulatory from professional certifications"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year certification was issued — for certification vintage and renewal cycle analysis"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year certification expires — critical for proactive renewal scheduling and compliance gap prevention"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records — baseline for certification programme coverage reporting"
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications — primary compliance coverage KPI"
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Count of certifications past their expiry date — compliance risk KPI; expired certs on regulated roles trigger immediate corrective action"
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Certifications expiring within the next 90 days — proactive compliance risk KPI enabling timely renewal scheduling before gaps occur"
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees holding at least one certification — measures certified workforce coverage for audit and regulatory reporting"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning and budget metrics by org unit and fiscal year. Enables workforce plan vs actual variance analysis — a core input to annual operating plan (AOP) reviews and executive workforce strategy."
  source: "`vibe_automotive_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan — primary time dimension for annual workforce planning cycle"
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan (draft, approved, locked) — filters for approved plans in variance reporting"
    - name: "actual_headcount"
      expr: actual_headcount
      comment: "Actual headcount value — used as a dimension for plan vs actual segmentation"
    - name: "planned_headcount"
      expr: planned_headcount
      comment: "Planned headcount value — used as a dimension for plan vs actual segmentation"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total headcount budget across all org units — primary workforce cost budget KPI for AOP and board reporting"
    - name: "avg_budget_per_plan"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average headcount budget per plan record — benchmarks per-org-unit workforce investment levels"
    - name: "total_headcount_plans"
      expr: COUNT(1)
      comment: "Total number of headcount plan records — measures planning coverage across the organisation"
    - name: "approved_plans_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Count of approved headcount plans — governance KPI; unapproved plans block budget commitment and hiring authorisation"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and disciplinary action metrics. Tracks disciplinary event frequency, type distribution, and resolution status — informs HR governance, legal risk, and workforce culture health."
  source: "`vibe_automotive_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination) — primary dimension for severity distribution analysis"
    - name: "action_status"
      expr: action_status
      comment: "Status of the disciplinary action (open, resolved, appealed) — tracks resolution pipeline"
    - name: "reason"
      expr: reason
      comment: "Reason for disciplinary action — enables root-cause categorisation for culture and policy improvement"
    - name: "action_year"
      expr: YEAR(action_date)
      comment: "Year the action was taken — for annual disciplinary trend and year-over-year comparison"
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions recorded — baseline employee relations KPI; sustained increase signals culture or management issues requiring executive attention"
    - name: "termination_actions"
      expr: COUNT(CASE WHEN action_type = 'Termination' THEN 1 END)
      comment: "Count of disciplinary terminations — measures involuntary attrition from conduct issues; informs legal risk and severance cost planning"
    - name: "open_disciplinary_cases"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of unresolved disciplinary cases — HR governance KPI; high open count indicates case management backlog and legal exposure"
    - name: "distinct_employees_disciplined"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees with disciplinary actions — measures breadth of conduct issues across the workforce"
$$;