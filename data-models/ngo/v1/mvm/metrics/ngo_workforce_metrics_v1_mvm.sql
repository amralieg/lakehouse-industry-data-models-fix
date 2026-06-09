-- Metric views for domain: workforce | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_staff_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce composition and cost metrics for the NGO's staff population. Supports headcount planning, salary benchmarking, retention risk analysis, and workforce diversity reporting for executive and HR leadership."
  source: "`ngo_ecm`.`workforce`.`staff_member`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the staff member (e.g., Active, On Leave, Terminated). Primary filter for active headcount analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment arrangement (e.g., Full-Time, Part-Time, Consultant). Used to segment workforce cost and headcount by engagement model."
    - name: "contract_type"
      expr: contract_type
      comment: "Nature of the staff contract (e.g., Fixed-Term, Open-Ended, Volunteer). Critical for workforce planning and donor compliance reporting."
    - name: "department"
      expr: department
      comment: "Organizational department the staff member belongs to. Enables departmental headcount and cost breakdowns."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country where the staff member is stationed. Supports geographic workforce distribution analysis and field vs. HQ comparisons."
    - name: "gender"
      expr: gender
      comment: "Gender of the staff member. Used for diversity and inclusion reporting, a key accountability metric for NGOs."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the staff member. Supports national vs. international staff ratio analysis and localization strategy."
    - name: "separation_type"
      expr: separation_type
      comment: "Classification of staff departure (e.g., Resignation, Termination, End of Contract). Drives attrition root-cause analysis."
    - name: "separation_reason"
      expr: separation_reason
      comment: "Stated reason for staff separation. Provides qualitative context for retention risk management."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency in which the staff member is paid. Relevant for multi-currency payroll cost consolidation."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year the staff member was hired. Used for cohort-based tenure and retention analysis."
    - name: "separation_year"
      expr: DATE_TRUNC('YEAR', separation_date)
      comment: "Year the staff member separated. Used to track attrition trends over time."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT staff_member_id)
      comment: "Total number of distinct staff members. The foundational workforce sizing metric used in every executive headcount report."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN staff_member_id END)
      comment: "Number of currently active staff members. The primary operational headcount KPI for resource planning and donor reporting."
    - name: "total_base_salary_usd"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary expenditure across all staff. Core input for workforce cost budgeting and grant cost allocation."
    - name: "avg_base_salary_usd"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per staff member. Used for compensation benchmarking and equity analysis across departments and duty stations."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE allocation across staff. Indicates workforce utilization intensity and part-time vs. full-time balance."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement payments made to separated staff. Tracks separation liability and end-of-service financial exposure."
    - name: "staff_separation_count"
      expr: COUNT(DISTINCT CASE WHEN separation_date IS NOT NULL THEN staff_member_id END)
      comment: "Number of staff who have separated. Used to calculate attrition rates and assess workforce stability."
    - name: "rehire_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible = TRUE THEN staff_member_id END)
      comment: "Number of separated staff flagged as eligible for rehire. Supports talent pipeline and surge capacity planning."
    - name: "exit_interview_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exit_interview_completed = TRUE THEN staff_member_id END) / NULLIF(COUNT(DISTINCT CASE WHEN separation_date IS NOT NULL THEN staff_member_id END), 0), 2)
      comment: "Percentage of separated staff who completed an exit interview. Measures HR process compliance and data quality for attrition analysis."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_employment_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio metrics covering compensation structure, allowance costs, and contract lifecycle for NGO workforce. Supports grant budget compliance, compensation equity analysis, and contract renewal planning."
  source: "`ngo_ecm`.`workforce`.`employment_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of employment contract (e.g., Fixed-Term, Consultancy, Volunteer). Drives segmentation of compensation cost by engagement model."
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g., Active, Expired, Terminated). Primary filter for active contract portfolio analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff classification (e.g., International Professional, National Staff, Consultant). Key dimension for compensation equity and donor reporting."
    - name: "duty_station"
      expr: duty_station
      comment: "Location where the contract is based. Enables geographic cost distribution analysis."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "ISO country code of the duty station. Supports country-level workforce cost reporting."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade assigned to the contract. Used for compensation band analysis and pay equity reviews."
    - name: "hardship_tier"
      expr: hardship_tier
      comment: "Hardship classification of the duty station (e.g., A, B, C, D, E). Drives hardship allowance cost analysis and field deployment incentive planning."
    - name: "is_expatriate"
      expr: CAST(is_expatriate AS STRING)
      comment: "Whether the contract is for an expatriate staff member. Enables international vs. national staff cost comparison."
    - name: "salary_currency"
      expr: salary_currency
      comment: "Currency of the salary. Used for multi-currency compensation analysis."
    - name: "ingo_salary_scale"
      expr: ingo_salary_scale
      comment: "INGO salary scale applied to the contract. Supports benchmarking against sector compensation standards."
    - name: "contract_start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the contract commenced. Used for contract vintage and cohort analysis."
    - name: "contract_end_year"
      expr: DATE_TRUNC('YEAR', end_date)
      comment: "Year the contract is scheduled to end. Supports contract renewal pipeline planning."
  measures:
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN employment_contract_id END)
      comment: "Number of currently active employment contracts. Core workforce sizing metric for operational planning."
    - name: "total_base_salary_cost"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary cost across all contracts. Primary input for workforce budget forecasting and grant cost allocation."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per contract. Used for compensation benchmarking across grades, categories, and duty stations."
    - name: "total_hardship_allowance_cost"
      expr: SUM(CAST(hardship_allowance_amount AS DOUBLE))
      comment: "Total hardship allowance expenditure. Quantifies the financial cost of field deployments in difficult environments."
    - name: "total_housing_allowance_cost"
      expr: SUM(CAST(housing_allowance_amount AS DOUBLE))
      comment: "Total housing allowance expenditure. Key component of expatriate package cost analysis."
    - name: "total_education_allowance_cost"
      expr: SUM(CAST(education_allowance_amount AS DOUBLE))
      comment: "Total education allowance expenditure. Tracks dependent education benefit costs for international staff."
    - name: "total_relocation_allowance_cost"
      expr: SUM(CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total relocation allowance paid. Measures mobility cost associated with staff deployments and transfers."
    - name: "total_compensation_package_cost"
      expr: SUM(CAST(base_salary_amount AS DOUBLE) + CAST(hardship_allowance_amount AS DOUBLE) + CAST(housing_allowance_amount AS DOUBLE) + CAST(education_allowance_amount AS DOUBLE) + CAST(relocation_allowance_amount AS DOUBLE))
      comment: "Total compensation package cost per contract including base salary and all allowances. Provides full-cost view of workforce expenditure for budget management."
    - name: "avg_icr_rate"
      expr: AVG(CAST(icr_rate AS DOUBLE))
      comment: "Average Indirect Cost Recovery rate applied to contracts. Used to assess overhead recovery efficiency across the contract portfolio."
    - name: "expatriate_contract_count"
      expr: COUNT(DISTINCT CASE WHEN is_expatriate = TRUE THEN employment_contract_id END)
      comment: "Number of expatriate contracts. Tracks international staffing levels and associated premium compensation costs."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN employment_contract_id END)
      comment: "Number of contracts expiring within the next 90 days. Critical operational metric for proactive contract renewal and continuity planning."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll execution and cost metrics for NGO workforce. Supports payroll compliance monitoring, cost center expenditure tracking, and financial reconciliation with grant budgets."
  source: "`ngo_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current processing status of the payroll run (e.g., Draft, Approved, Posted). Used to filter for completed vs. in-progress payroll cycles."
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (e.g., Regular, Off-Cycle, Retroactive). Enables analysis of non-standard payroll activity and associated costs."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the payroll run. Tracks compliance with payroll authorization controls."
    - name: "country_code"
      expr: country_code
      comment: "Country where the payroll run was executed. Enables country-level payroll cost analysis and statutory compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run. Supports multi-currency payroll cost consolidation."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of payroll (e.g., Monthly, Bi-Weekly). Used to normalize payroll cost comparisons across different pay cycles."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Logical grouping of staff within the payroll run (e.g., International Staff, National Staff). Enables segment-level payroll cost analysis."
    - name: "is_retroactive"
      expr: CAST(is_retroactive AS STRING)
      comment: "Whether the payroll run includes retroactive adjustments. Flags financial periods with retroactive cost impacts."
    - name: "pay_period_start_year"
      expr: DATE_TRUNC('YEAR', pay_period_start_date)
      comment: "Year of the pay period start date. Used for annual payroll cost trend analysis."
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of the pay period. Enables monthly payroll cost tracking and variance analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs. The primary payroll expenditure metric for budget monitoring and grant cost reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to staff. Measures actual cash outflow from payroll operations."
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withheld across payroll runs. Critical for statutory compliance reporting and tax liability management."
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer social security and pension contributions. Quantifies the full employer-side payroll burden beyond gross salary."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions applied across payroll runs. Used to reconcile gross-to-net payroll and validate deduction accuracy."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across payroll runs. Used to assess foreign exchange exposure in multi-currency payroll operations."
    - name: "payroll_run_count"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs executed. Baseline metric for payroll operations volume and frequency monitoring."
    - name: "retroactive_run_count"
      expr: COUNT(DISTINCT CASE WHEN is_retroactive = TRUE THEN payroll_run_id END)
      comment: "Number of retroactive payroll runs. High retroactive run counts signal payroll process inefficiency or contract amendment backlogs."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross payroll cost per run. Used to detect anomalous payroll runs that deviate significantly from the norm."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual payslip-level compensation metrics for the NGO workforce. Enables granular analysis of allowance structures, deduction patterns, and net pay outcomes by staff category, country, and program."
  source: "`ngo_ecm`.`workforce`.`payslip`"
  dimensions:
    - name: "payslip_status"
      expr: payslip_status
      comment: "Processing status of the payslip (e.g., Approved, Pending, Cancelled). Used to filter for finalized payslip data."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the payslip. Enables country-level compensation cost analysis."
    - name: "payroll_group"
      expr: payroll_group
      comment: "Staff payroll group (e.g., International, National). Key dimension for compensation equity and cost segmentation."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the staff member was paid. Supports multi-currency payroll cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., Bank Transfer, Cash). Used to monitor payment channel distribution and associated risks."
    - name: "is_correction"
      expr: CAST(is_correction AS STRING)
      comment: "Whether the payslip is a correction to a prior payslip. High correction rates indicate payroll data quality issues."
    - name: "is_off_cycle"
      expr: CAST(is_off_cycle AS STRING)
      comment: "Whether the payslip was generated outside the regular payroll cycle. Tracks off-cycle payment frequency and cost."
    - name: "program_code"
      expr: program_code
      comment: "Program to which the payslip cost is allocated. Enables program-level staff cost analysis for donor reporting."
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of the pay period. Enables monthly compensation trend analysis."
    - name: "pay_period_year"
      expr: DATE_TRUNC('YEAR', pay_period_start_date)
      comment: "Year of the pay period. Used for annual compensation cost reporting."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross salary paid across all payslips. Primary compensation cost metric for budget monitoring and grant reporting."
    - name: "total_net_pay_local"
      expr: SUM(CAST(net_pay_local AS DOUBLE))
      comment: "Total net pay in local currency. Measures actual cash disbursed to staff in their operating currency."
    - name: "total_allowances"
      expr: SUM(CAST(total_allowances AS DOUBLE))
      comment: "Total allowances paid (housing, hardship, field, transport, expat). Quantifies the non-salary compensation burden."
    - name: "total_income_tax_deducted"
      expr: SUM(CAST(income_tax_deduction AS DOUBLE))
      comment: "Total income tax withheld from staff payslips. Critical for statutory tax compliance and liability reporting."
    - name: "total_statutory_deductions"
      expr: SUM(CAST(total_statutory_deductions AS DOUBLE))
      comment: "Total statutory deductions (tax, social security, pension) across all payslips. Measures full compliance cost burden."
    - name: "total_employer_pension_contribution"
      expr: SUM(CAST(employer_pension_contribution AS DOUBLE))
      comment: "Total employer pension contributions. Tracks long-term staff benefit liability and retirement fund obligations."
    - name: "total_employer_social_security"
      expr: SUM(CAST(employer_social_security AS DOUBLE))
      comment: "Total employer social security contributions. Quantifies statutory employer-side payroll burden by country."
    - name: "avg_gross_salary_per_payslip"
      expr: AVG(CAST(gross_salary AS DOUBLE))
      comment: "Average gross salary per payslip. Used for compensation benchmarking and anomaly detection in payroll processing."
    - name: "payslip_correction_count"
      expr: COUNT(DISTINCT CASE WHEN is_correction = TRUE THEN payslip_id END)
      comment: "Number of correction payslips issued. A high correction rate signals payroll data quality or process control issues requiring management attention."
    - name: "total_hardship_allowance"
      expr: SUM(CAST(hardship_allowance AS DOUBLE))
      comment: "Total hardship allowance paid to staff. Tracks the financial cost of deploying staff to difficult and high-risk environments."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position portfolio metrics for NGO workforce planning. Tracks vacancy rates, budgeted position costs, FTE allocation, and position fill efficiency to support headcount planning and organizational design decisions."
  source: "`ngo_ecm`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Current status of the position (e.g., Active, Frozen, Abolished). Used to filter the active position portfolio."
    - name: "position_type"
      expr: position_type
      comment: "Classification of the position (e.g., Regular, Surge, Temporary). Enables analysis of workforce structure by engagement type."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the position (e.g., International Professional, National Staff). Key dimension for workforce composition analysis."
    - name: "duty_station"
      expr: duty_station
      comment: "Location of the position. Enables geographic distribution analysis of the position portfolio."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "ISO country code of the position duty station. Supports country-level workforce planning."
    - name: "is_vacant"
      expr: CAST(is_vacant AS STRING)
      comment: "Whether the position is currently vacant. Primary dimension for vacancy analysis and recruitment prioritization."
    - name: "is_field_position"
      expr: CAST(is_field_position AS STRING)
      comment: "Whether the position is a field-based role. Enables field vs. HQ workforce cost and composition comparison."
    - name: "is_supervisory"
      expr: CAST(is_supervisory AS STRING)
      comment: "Whether the position has supervisory responsibilities. Used for management span-of-control analysis."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source for the position (e.g., Grant, Core, Shared). Critical for donor-funded position tracking and budget compliance."
    - name: "pay_grade_band"
      expr: pay_grade_band
      comment: "Pay grade band of the position. Used for compensation structure analysis and equity reviews."
    - name: "headcount_plan_year"
      expr: headcount_plan_year
      comment: "Planning year for the position. Enables year-over-year headcount plan vs. actuals comparison."
  measures:
    - name: "total_position_count"
      expr: COUNT(DISTINCT position_id)
      comment: "Total number of positions in the portfolio. Baseline metric for authorized headcount tracking."
    - name: "vacant_position_count"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END)
      comment: "Number of currently vacant positions. Directly drives recruitment prioritization and program delivery risk assessment."
    - name: "vacancy_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END) / NULLIF(COUNT(DISTINCT position_id), 0), 2)
      comment: "Percentage of positions that are currently vacant. A high vacancy rate signals recruitment bottlenecks and program delivery risk."
    - name: "total_budgeted_annual_cost"
      expr: SUM(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Total budgeted annual cost across all positions. Core input for workforce budget planning and grant cost allocation."
    - name: "avg_budgeted_annual_cost"
      expr: AVG(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Average budgeted annual cost per position. Used for compensation benchmarking and position-level budget variance analysis."
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across all positions. Measures authorized workforce capacity in full-time equivalent terms."
    - name: "avg_fte_allocation"
      expr: AVG(CAST(fte_allocation AS DOUBLE))
      comment: "Average FTE allocation per position. Indicates the prevalence of part-time and shared positions in the workforce structure."
    - name: "field_position_count"
      expr: COUNT(DISTINCT CASE WHEN is_field_position = TRUE THEN position_id END)
      comment: "Number of field-based positions. Tracks the NGO's operational field presence and associated staffing investment."
    - name: "grant_funded_position_count"
      expr: COUNT(DISTINCT CASE WHEN funding_source_type = 'Grant' THEN position_id END)
      comment: "Number of positions funded by grants. Critical for donor compliance — grant-funded positions must be filled and reported accurately."
    - name: "avg_days_to_fill"
      expr: AVG(CAST(DATEDIFF(filled_date, availability_date) AS DOUBLE))
      comment: "Average number of days from position availability to fill date. Measures recruitment efficiency and time-to-hire performance."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_staff_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff deployment and effort allocation metrics for NGO programs. Tracks field deployments, surge responses, effort certification compliance, and grant-funded assignment distribution to support program delivery and donor reporting."
  source: "`ngo_ecm`.`workforce`.`staff_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the staff assignment (e.g., Active, Completed, Cancelled). Primary filter for active deployment analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., Regular, TDY, Secondment, Surge). Enables analysis of deployment modality and associated costs."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the assigned individual. Used for international vs. national staff deployment analysis."
    - name: "duty_country_code"
      expr: duty_country_code
      comment: "Country where the assignment is based. Enables geographic deployment distribution analysis."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source for the assignment (e.g., Grant, Core). Critical for donor-funded effort tracking and compliance."
    - name: "grant_code"
      expr: grant_code
      comment: "Grant code associated with the assignment. Enables grant-level staff cost and effort analysis for donor reporting."
    - name: "is_field_deployment"
      expr: CAST(is_field_deployment AS STRING)
      comment: "Whether the assignment is a field deployment. Tracks operational field presence and associated deployment costs."
    - name: "is_surge_deployment"
      expr: CAST(is_surge_deployment AS STRING)
      comment: "Whether the assignment is a surge/emergency deployment. Measures emergency response staffing capacity utilization."
    - name: "hardship_level"
      expr: hardship_level
      comment: "Hardship classification of the assignment location. Used to analyze staff exposure to difficult operating environments."
    - name: "raci_role"
      expr: raci_role
      comment: "RACI accountability role of the staff member in the assignment. Supports accountability framework analysis."
    - name: "assignment_start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the assignment commenced. Used for annual deployment trend analysis."
  measures:
    - name: "active_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN staff_assignment_id END)
      comment: "Number of currently active staff assignments. Core metric for operational deployment capacity monitoring."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across all assignments. Measures actual workforce capacity deployed to programs and operations."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage per assignment. Indicates the intensity of staff allocation to specific programs and grants."
    - name: "surge_deployment_count"
      expr: COUNT(DISTINCT CASE WHEN is_surge_deployment = TRUE THEN staff_assignment_id END)
      comment: "Number of surge/emergency deployments. Tracks the NGO's emergency response staffing capacity and activation frequency."
    - name: "field_deployment_count"
      expr: COUNT(DISTINCT CASE WHEN is_field_deployment = TRUE THEN staff_assignment_id END)
      comment: "Number of field deployments. Measures operational field presence and the proportion of staff deployed to program locations."
    - name: "effort_certification_pending_count"
      expr: COUNT(DISTINCT CASE WHEN effort_certification_required = TRUE AND last_effort_certified_date IS NULL THEN staff_assignment_id END)
      comment: "Number of assignments requiring effort certification that have not yet been certified. High values indicate donor compliance risk on grant-funded assignments."
    - name: "safeguarding_training_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safeguarding_training_completed = TRUE THEN staff_assignment_id END) / NULLIF(COUNT(DISTINCT staff_assignment_id), 0), 2)
      comment: "Percentage of assignments where safeguarding training has been completed. Critical compliance metric — NGOs face reputational and donor risk for safeguarding gaps."
    - name: "cost_shared_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN is_cost_shared = TRUE THEN staff_assignment_id END)
      comment: "Number of cost-shared assignments. Tracks multi-donor or multi-program cost sharing arrangements for financial compliance."
    - name: "avg_assignment_duration_days"
      expr: AVG(CAST(DATEDIFF(end_date, start_date) AS DOUBLE))
      comment: "Average duration of staff assignments in days. Used to assess deployment patterns and plan for assignment transitions."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Staff performance and talent management metrics for the NGO workforce. Supports performance cycle completion tracking, rating distribution analysis, retention risk identification, and promotion pipeline management."
  source: "`ngo_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the performance review (e.g., Draft, Submitted, Approved). Used to track review cycle completion rates."
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Type of review cycle (e.g., Annual, Mid-Year, Probation). Enables analysis by review type and cycle frequency."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating assigned (e.g., Exceeds Expectations, Meets Expectations, Below Expectations). Primary dimension for performance distribution analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the reviewed employee. Enables performance comparison across international and national staff."
    - name: "duty_station"
      expr: duty_station
      comment: "Duty station of the reviewed employee. Supports geographic performance analysis."
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country code of the duty station. Enables country-level performance trend analysis."
    - name: "pip_required"
      expr: CAST(pip_required AS STRING)
      comment: "Whether a Performance Improvement Plan is required. Flags underperforming staff requiring management intervention."
    - name: "retention_risk_flag"
      expr: CAST(retention_risk_flag AS STRING)
      comment: "Whether the staff member has been flagged as a retention risk. Critical for proactive talent retention planning."
    - name: "promotion_recommendation"
      expr: CAST(promotion_recommendation AS STRING)
      comment: "Whether the staff member has been recommended for promotion. Drives succession planning and career development decisions."
    - name: "review_period_year"
      expr: DATE_TRUNC('YEAR', review_period_start_date)
      comment: "Year of the review period. Used for year-over-year performance trend analysis."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Approved' THEN performance_review_id END)
      comment: "Number of completed and approved performance reviews. Measures performance cycle completion and HR process adherence."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN review_status = 'Approved' THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of performance reviews that have been completed and approved. A key HR governance metric — low completion rates indicate management accountability gaps."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Tracks workforce performance trends and identifies high/low performing units."
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score. Measures how effectively staff are delivering against their agreed targets."
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score. Assesses workforce capability levels against the NGO's competency framework."
    - name: "retention_risk_count"
      expr: COUNT(DISTINCT CASE WHEN retention_risk_flag = TRUE THEN performance_review_id END)
      comment: "Number of staff flagged as retention risks. Directly informs targeted retention interventions to prevent loss of critical talent."
    - name: "pip_required_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN performance_review_id END)
      comment: "Number of staff requiring a Performance Improvement Plan. Tracks underperformance prevalence and management intervention workload."
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommendation = TRUE THEN performance_review_id END)
      comment: "Number of staff recommended for promotion. Measures internal talent pipeline strength and career progression opportunities."
    - name: "employee_disagreement_count"
      expr: COUNT(DISTINCT CASE WHEN employee_disagreement_flag = TRUE THEN performance_review_id END)
      comment: "Number of reviews where the employee formally disagreed with the assessment. High disagreement rates signal management quality or fairness concerns."
    - name: "employee_acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN employee_acknowledged = TRUE THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of reviews formally acknowledged by the employee. Measures process completion and staff engagement in the performance cycle."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and compliance metrics for NGO workforce. Tracks leave consumption patterns, entitlement utilization, R&R compliance, and medical certification adherence to support workforce wellbeing and operational continuity planning."
  source: "`ngo_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave requested (e.g., Annual, Sick, Maternity, R&R, Compassionate). Primary dimension for leave pattern analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the leave request (e.g., Approved, Pending, Rejected). Used to filter for approved leave in utilization analysis."
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of the leave requester. Enables leave utilization comparison across international and national staff."
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of the duty station for the leave request. Supports geographic leave pattern analysis."
    - name: "is_rnr_eligible"
      expr: CAST(is_rnr_eligible AS STRING)
      comment: "Whether the leave request is R&R eligible. Tracks compliance with mandatory rest and recuperation entitlements for field staff."
    - name: "is_retroactive"
      expr: CAST(is_retroactive AS STRING)
      comment: "Whether the leave request was submitted retroactively. High retroactive rates indicate leave management process gaps."
    - name: "medical_certificate_required"
      expr: CAST(medical_certificate_required AS STRING)
      comment: "Whether a medical certificate is required for the leave. Used to track sick leave documentation compliance."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year associated with the request. Enables annual leave utilization and carry-forward analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month the leave was requested to start. Enables seasonal leave pattern analysis for operational planning."
  measures:
    - name: "total_leave_days_requested"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested across all requests. Baseline metric for workforce availability planning."
    - name: "total_leave_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total actual leave days taken. Measures realized workforce absence and its impact on operational capacity."
    - name: "total_leave_entitlement_days"
      expr: SUM(CAST(entitlement_days AS DOUBLE))
      comment: "Total leave entitlement days across all staff. Used to calculate leave utilization rates and identify under-utilization risks."
    - name: "leave_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_days_taken AS DOUBLE)) / NULLIF(SUM(CAST(entitlement_days AS DOUBLE)), 0), 2)
      comment: "Percentage of leave entitlement actually utilized. Low utilization may indicate staff burnout risk or operational pressure preventing leave-taking."
    - name: "total_carry_forward_days"
      expr: SUM(CAST(carry_forward_days AS DOUBLE))
      comment: "Total leave days carried forward to the next period. High carry-forward balances represent a financial liability and potential staff wellbeing risk."
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total Time Off In Lieu hours accrued. Tracks overtime liability and staff workload intensity in field operations."
    - name: "medical_cert_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medical_certificate_required = TRUE AND medical_certificate_received = TRUE THEN leave_request_id END) / NULLIF(COUNT(DISTINCT CASE WHEN medical_certificate_required = TRUE THEN leave_request_id END), 0), 2)
      comment: "Percentage of sick leave requests requiring a medical certificate where one was received. Measures sick leave documentation compliance."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(DISTINCT leave_request_id), 0), 2)
      comment: "Percentage of leave requests that were approved. Tracks leave management fairness and operational flexibility."
    - name: "handover_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN handover_completed = TRUE THEN leave_request_id END) / NULLIF(COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN leave_request_id END), 0), 2)
      comment: "Percentage of approved leave requests where a handover was completed before departure. Measures operational continuity compliance for field staff."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational unit structure and budget metrics for the NGO. Supports organizational design analysis, budget allocation monitoring, and field office capacity planning at the unit level."
  source: "`ngo_ecm`.`workforce`.`org_unit`"
  dimensions:
    - name: "unit_type"
      expr: unit_type
      comment: "Type of organizational unit (e.g., Department, Division, Field Office, Program Unit). Primary dimension for org structure analysis."
    - name: "org_unit_status"
      expr: org_unit_status
      comment: "Current operational status of the org unit (e.g., Active, Inactive, Closing). Used to filter for active organizational units."
    - name: "region_name"
      expr: region_name
      comment: "Geographic region of the org unit. Enables regional workforce and budget distribution analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the org unit operates. Supports country-level organizational capacity analysis."
    - name: "is_field_office"
      expr: CAST(is_field_office AS STRING)
      comment: "Whether the org unit is a field office. Enables field vs. HQ organizational comparison."
    - name: "is_hq"
      expr: CAST(is_hq AS STRING)
      comment: "Whether the org unit is headquartered. Used to distinguish HQ overhead from field program costs."
    - name: "funding_model"
      expr: funding_model
      comment: "Funding model of the org unit (e.g., Grant-Funded, Core-Funded, Mixed). Critical for financial sustainability analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the org unit in the organizational hierarchy. Used for span-of-control and organizational depth analysis."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the org unit location. Used to assess operational risk and associated staffing constraints."
  measures:
    - name: "total_org_unit_count"
      expr: COUNT(DISTINCT org_unit_id)
      comment: "Total number of organizational units. Baseline metric for organizational complexity and span-of-control analysis."
    - name: "active_org_unit_count"
      expr: COUNT(DISTINCT CASE WHEN org_unit_status = 'Active' THEN org_unit_id END)
      comment: "Number of currently active organizational units. Tracks operational footprint and organizational capacity."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Total annual budget across all organizational units. Primary metric for organizational resource allocation and budget planning."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget per organizational unit. Used for budget equity analysis and resource allocation benchmarking."
    - name: "avg_icr_rate"
      expr: AVG(CAST(icr_rate AS DOUBLE))
      comment: "Average Indirect Cost Recovery rate across org units. Measures overhead recovery efficiency and cost structure sustainability."
    - name: "field_office_count"
      expr: COUNT(DISTINCT CASE WHEN is_field_office = TRUE THEN org_unit_id END)
      comment: "Number of field offices. Tracks the NGO's geographic operational presence and field delivery capacity."
    - name: "total_field_office_budget_usd"
      expr: SUM(CAST(CASE WHEN is_field_office = TRUE THEN annual_budget_usd ELSE 0 END AS DOUBLE))
      comment: "Total annual budget allocated to field offices. Measures the proportion of resources directed to program delivery vs. HQ overhead."
$$;