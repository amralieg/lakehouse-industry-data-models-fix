-- Metric views for domain: payroll | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_pay_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level KPIs tracking gross pay, net pay, tax withholding, employer burden, and worker counts across pay cycles"
  source: "`staffing_hr_ecm`.`payroll`.`pay_run`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
    - name: "check_date"
      expr: check_date
      comment: "Date checks were issued"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of payroll run (weekly, biweekly, monthly)"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle, correction)"
    - name: "run_status"
      expr: run_status
      comment: "Status of the payroll run (draft, approved, posted, voided)"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the payroll run"
    - name: "tax_quarter"
      expr: tax_quarter
      comment: "Tax quarter for the payroll run"
    - name: "branch_code"
      expr: branch_code
      comment: "Branch or division code"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of payment disbursement (ACH, check, wire)"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross wages paid across all workers in the pay run"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to workers after all deductions and taxes"
    - name: "total_tax_withholding"
      expr: SUM(CAST(total_tax_withholding AS DOUBLE))
      comment: "Total employee tax withholding (federal, state, local, FICA)"
    - name: "total_employer_burden"
      expr: SUM(CAST(total_employer_burden AS DOUBLE))
      comment: "Total employer-side payroll taxes and burden costs"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total employee deductions (benefits, garnishments, voluntary)"
    - name: "total_fica_employee"
      expr: SUM(CAST(total_fica_employee AS DOUBLE))
      comment: "Total employee-side FICA (Social Security and Medicare) withholding"
    - name: "total_fica_employer"
      expr: SUM(CAST(total_fica_employer AS DOUBLE))
      comment: "Total employer-side FICA (Social Security and Medicare) tax"
    - name: "total_futa_tax"
      expr: SUM(CAST(total_futa_tax AS DOUBLE))
      comment: "Total Federal Unemployment Tax Act (FUTA) tax liability"
    - name: "total_suta_tax"
      expr: SUM(CAST(total_suta_tax AS DOUBLE))
      comment: "Total State Unemployment Tax Act (SUTA) tax liability"
    - name: "total_workers_comp_premium"
      expr: SUM(CAST(total_workers_comp_premium AS DOUBLE))
      comment: "Total workers compensation insurance premium for the pay run"
    - name: "total_regular_pay"
      expr: SUM(CAST(total_regular_pay AS DOUBLE))
      comment: "Total regular-time wages paid"
    - name: "total_ot_pay"
      expr: SUM(CAST(total_ot_pay AS DOUBLE))
      comment: "Total overtime wages paid"
    - name: "total_dt_pay"
      expr: SUM(CAST(total_dt_pay AS DOUBLE))
      comment: "Total double-time wages paid"
    - name: "total_per_diem_pay"
      expr: SUM(CAST(total_per_diem_pay AS DOUBLE))
      comment: "Total per diem reimbursements paid"
    - name: "total_pto_pay"
      expr: SUM(CAST(total_pto_pay AS DOUBLE))
      comment: "Total paid time off (PTO) wages paid"
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Number of payroll runs executed"
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run"
    - name: "avg_net_pay_per_run"
      expr: AVG(CAST(total_net_pay AS DOUBLE))
      comment: "Average net pay per payroll run"
    - name: "employer_burden_rate"
      expr: ROUND(100.0 * SUM(CAST(total_employer_burden AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Employer burden as a percentage of gross pay"
    - name: "tax_withholding_rate"
      expr: ROUND(100.0 * SUM(CAST(total_tax_withholding AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Tax withholding as a percentage of gross pay"
    - name: "net_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_net_pay AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Net pay as a percentage of gross pay (take-home rate)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_pay_stub`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Worker-level pay stub KPIs tracking individual earnings, deductions, taxes, and net pay by worker and assignment"
  source: "`staffing_hr_ecm`.`payroll`.`pay_stub`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
    - name: "pay_date"
      expr: pay_date
      comment: "Date payment was issued to the worker"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, biweekly, monthly)"
    - name: "pay_delivery_method"
      expr: pay_delivery_method
      comment: "Method of payment delivery (direct deposit, check, paycard)"
    - name: "stub_status"
      expr: stub_status
      comment: "Status of the pay stub (issued, voided, reissued)"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate (hourly, salary, per diem)"
    - name: "workers_comp_code"
      expr: workers_comp_code
      comment: "Workers compensation classification code"
    - name: "tax_filing_status"
      expr: tax_filing_status
      comment: "Tax filing status of the worker"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross wages paid to workers"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to workers"
    - name: "total_regular_earnings"
      expr: SUM(CAST(regular_earnings AS DOUBLE))
      comment: "Total regular-time earnings"
    - name: "total_ot_earnings"
      expr: SUM(CAST(ot_earnings AS DOUBLE))
      comment: "Total overtime earnings"
    - name: "total_dt_earnings"
      expr: SUM(CAST(dt_earnings AS DOUBLE))
      comment: "Total double-time earnings"
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem reimbursements"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_ot_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_dt_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions from worker pay"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withholding (federal, state, local, FICA)"
    - name: "total_federal_income_tax"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_state_income_tax"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "total_social_security_tax"
      expr: SUM(CAST(social_security_tax_withheld AS DOUBLE))
      comment: "Total Social Security tax withheld"
    - name: "total_medicare_tax"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withheld"
    - name: "total_workers_comp_premium"
      expr: SUM(CAST(workers_comp_premium AS DOUBLE))
      comment: "Total workers compensation premium charged"
    - name: "pay_stub_count"
      expr: COUNT(1)
      comment: "Number of pay stubs issued"
    - name: "unique_workers_paid"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers who received pay"
    - name: "avg_gross_pay_per_worker"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per worker per pay period"
    - name: "avg_net_pay_per_worker"
      expr: AVG(CAST(net_pay AS DOUBLE))
      comment: "Average net pay per worker per pay period"
    - name: "avg_regular_hours_per_worker"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours worked per worker per pay period"
    - name: "avg_ot_hours_per_worker"
      expr: AVG(CAST(ot_hours AS DOUBLE))
      comment: "Average overtime hours worked per worker per pay period"
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(ot_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)) + SUM(CAST(ot_hours AS DOUBLE)) + SUM(CAST(dt_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked"
    - name: "net_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Net pay as a percentage of gross pay (worker take-home rate)"
    - name: "avg_effective_hourly_rate"
      expr: ROUND(SUM(CAST(gross_pay AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)) + SUM(CAST(ot_hours AS DOUBLE)) + SUM(CAST(dt_hours AS DOUBLE)), 0), 2)
      comment: "Average effective hourly rate (gross pay divided by total hours)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_earnings_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed earnings line-item KPIs tracking hours, rates, and gross amounts by earning type and labor category"
  source: "`staffing_hr_ecm`.`payroll`.`earnings_line`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
    - name: "check_date"
      expr: check_date
      comment: "Date the check was issued"
    - name: "earning_type"
      expr: earning_type
      comment: "Type of earning (regular, overtime, double-time, bonus, per diem)"
    - name: "earning_code"
      expr: earning_code
      comment: "Specific earning code"
    - name: "labor_category_code"
      expr: labor_category_code
      comment: "Labor category or job classification code"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker (W2, 1099, temp, perm)"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status (exempt, non-exempt)"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code (day, evening, night, weekend)"
    - name: "line_status"
      expr: line_status
      comment: "Status of the earnings line (active, voided, adjusted)"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the earnings"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross earnings amount"
    - name: "total_hours_quantity"
      expr: SUM(CAST(hours_quantity AS DOUBLE))
      comment: "Total hours worked across all earnings lines"
    - name: "earnings_line_count"
      expr: COUNT(1)
      comment: "Number of earnings line items"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with earnings"
    - name: "unique_assignments"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with earnings"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across all earnings lines"
    - name: "avg_gross_per_line"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per earnings line"
    - name: "avg_hours_per_line"
      expr: AVG(CAST(hours_quantity AS DOUBLE))
      comment: "Average hours per earnings line"
    - name: "weighted_avg_pay_rate"
      expr: ROUND(SUM(CAST(gross_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_quantity AS DOUBLE)), 0), 2)
      comment: "Weighted average pay rate (total earnings divided by total hours)"
    - name: "total_per_diem_rate_daily"
      expr: SUM(CAST(per_diem_rate_daily AS DOUBLE))
      comment: "Total daily per diem rates"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_deduction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction line-item KPIs tracking employee and employer contributions for benefits, garnishments, and voluntary deductions"
  source: "`staffing_hr_ecm`.`payroll`.`deduction_line`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
    - name: "check_date"
      expr: check_date
      comment: "Date the check was issued"
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (benefit, garnishment, voluntary, tax)"
    - name: "deduction_category"
      expr: deduction_category
      comment: "Category of deduction (health, retirement, garnishment, etc.)"
    - name: "deduction_code"
      expr: deduction_code
      comment: "Specific deduction code"
    - name: "benefit_plan_type"
      expr: benefit_plan_type
      comment: "Type of benefit plan (medical, dental, vision, 401k, etc.)"
    - name: "benefit_carrier_name"
      expr: benefit_carrier_name
      comment: "Name of the benefit carrier or provider"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family)"
    - name: "deduction_status"
      expr: deduction_status
      comment: "Status of the deduction (active, suspended, terminated)"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed"
  measures:
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total employee deduction amount"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount for benefits"
    - name: "total_arrears_amount"
      expr: SUM(CAST(arrears_amount AS DOUBLE))
      comment: "Total arrears amount being recovered"
    - name: "deduction_line_count"
      expr: COUNT(1)
      comment: "Number of deduction line items"
    - name: "unique_workers_with_deductions"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with deductions"
    - name: "avg_deduction_per_line"
      expr: AVG(CAST(deduction_amount AS DOUBLE))
      comment: "Average deduction amount per line"
    - name: "avg_employer_contribution_per_line"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per line"
    - name: "employer_contribution_rate"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_amount AS DOUBLE)) + SUM(CAST(employer_contribution_amount AS DOUBLE)), 0), 2)
      comment: "Employer contribution as a percentage of total benefit cost"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_burden_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Burden rate KPIs tracking employer payroll tax rates, benefits load, markup, and gross margin by rate type and scope"
  source: "`staffing_hr_ecm`.`payroll`.`burden_rate`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective start date of the burden rate"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the burden rate"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of burden rate (standard, custom, client-specific)"
    - name: "applicability_scope"
      expr: applicability_scope
      comment: "Scope of applicability (client, location, assignment, worker classification)"
    - name: "state_code"
      expr: state_code
      comment: "State code for state-specific burden rates"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (W2, 1099, temp, perm)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (employee, contractor, temp)"
    - name: "burden_rate_status"
      expr: burden_rate_status
      comment: "Status of the burden rate (active, expired, superseded)"
    - name: "wc_hazard_category"
      expr: wc_hazard_category
      comment: "Workers compensation hazard category"
    - name: "branch_code"
      expr: branch_code
      comment: "Branch or division code"
  measures:
    - name: "burden_rate_count"
      expr: COUNT(1)
      comment: "Number of burden rate records"
    - name: "avg_total_burden_percent"
      expr: AVG(CAST(total_burden_percent AS DOUBLE))
      comment: "Average total burden percentage across all rates"
    - name: "avg_markup_percent"
      expr: AVG(CAST(markup_percent AS DOUBLE))
      comment: "Average markup percentage applied to pay rates"
    - name: "avg_target_gross_margin_percent"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage"
    - name: "avg_benefits_load_percent"
      expr: AVG(CAST(benefits_load_percent AS DOUBLE))
      comment: "Average benefits load percentage"
    - name: "avg_overhead_percent"
      expr: AVG(CAST(overhead_percent AS DOUBLE))
      comment: "Average overhead percentage"
    - name: "avg_fica_employer_rate"
      expr: AVG(CAST(fica_employer_rate AS DOUBLE))
      comment: "Average employer FICA rate"
    - name: "avg_futa_rate"
      expr: AVG(CAST(futa_rate AS DOUBLE))
      comment: "Average FUTA rate"
    - name: "avg_suta_rate"
      expr: AVG(CAST(suta_rate AS DOUBLE))
      comment: "Average SUTA rate"
    - name: "avg_wc_base_rate_per_100"
      expr: AVG(CAST(wc_base_rate_per_100 AS DOUBLE))
      comment: "Average workers compensation base rate per $100 of payroll"
    - name: "avg_wc_experience_mod_factor"
      expr: AVG(CAST(wc_experience_mod_factor AS DOUBLE))
      comment: "Average workers compensation experience modification factor"
    - name: "avg_general_liability_rate"
      expr: AVG(CAST(general_liability_rate AS DOUBLE))
      comment: "Average general liability insurance rate"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing KPIs tracking federal and state payroll tax liabilities, deposits, and filing status by jurisdiction and period"
  source: "`staffing_hr_ecm`.`payroll`.`tax_filing`"
  dimensions:
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the filing"
    - name: "tax_quarter"
      expr: tax_quarter
      comment: "Tax quarter for the filing"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of tax filing (941, 940, state unemployment, etc.)"
    - name: "tax_authority_level"
      expr: tax_authority_level
      comment: "Level of tax authority (federal, state, local)"
    - name: "tax_authority_name"
      expr: tax_authority_name
      comment: "Name of the tax authority"
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level filings"
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the filing (draft, filed, accepted, rejected)"
    - name: "due_date"
      expr: due_date
      comment: "Due date for the tax filing"
    - name: "deposit_method"
      expr: deposit_method
      comment: "Method of tax deposit (EFTPS, check, wire)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for the filing"
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability amount for the filing period"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total tax deposit amount made"
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due_amount AS DOUBLE))
      comment: "Total balance due on tax filings"
    - name: "total_federal_income_tax"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_fica_employee_tax"
      expr: SUM(CAST(fica_employee_tax_amount AS DOUBLE))
      comment: "Total employee-side FICA tax"
    - name: "total_fica_employer_tax"
      expr: SUM(CAST(fica_employer_tax_amount AS DOUBLE))
      comment: "Total employer-side FICA tax"
    - name: "total_futa_tax"
      expr: SUM(CAST(futa_tax_amount AS DOUBLE))
      comment: "Total FUTA tax liability"
    - name: "total_suta_tax"
      expr: SUM(CAST(suta_tax_amount AS DOUBLE))
      comment: "Total SUTA tax liability"
    - name: "total_state_income_tax"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "total_taxable_wages"
      expr: SUM(CAST(total_taxable_wages AS DOUBLE))
      comment: "Total taxable wages for the filing period"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed on late or incorrect filings"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on late payments"
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Number of tax filings"
    - name: "avg_tax_liability_per_filing"
      expr: AVG(CAST(tax_liability_amount AS DOUBLE))
      comment: "Average tax liability per filing"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_pto_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PTO accrual KPIs tracking hours accrued, used, forfeited, and current balances by worker and policy"
  source: "`staffing_hr_ecm`.`payroll`.`pto_accrual`"
  dimensions:
    - name: "accrual_period_start_date"
      expr: accrual_period_start_date
      comment: "Start date of the accrual period"
    - name: "accrual_period_end_date"
      expr: accrual_period_end_date
      comment: "End date of the accrual period"
    - name: "accrual_year"
      expr: accrual_year
      comment: "Accrual year"
    - name: "accrual_year_type"
      expr: accrual_year_type
      comment: "Type of accrual year (calendar, fiscal, anniversary)"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method of accrual (hours worked, pay period, annual allocation)"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the accrual record (active, suspended, terminated)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (employee, contractor, temp)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for PTO compliance"
    - name: "record_type"
      expr: record_type
      comment: "Type of accrual record (accrual, usage, adjustment, payout)"
  measures:
    - name: "total_hours_accrued"
      expr: SUM(CAST(hours_accrued AS DOUBLE))
      comment: "Total PTO hours accrued"
    - name: "total_hours_used"
      expr: SUM(CAST(hours_used AS DOUBLE))
      comment: "Total PTO hours used"
    - name: "total_hours_forfeited"
      expr: SUM(CAST(hours_forfeited AS DOUBLE))
      comment: "Total PTO hours forfeited (lost due to cap or expiration)"
    - name: "total_hours_adjusted"
      expr: SUM(CAST(hours_adjusted AS DOUBLE))
      comment: "Total PTO hours adjusted (manual corrections)"
    - name: "total_payout_hours"
      expr: SUM(CAST(payout_hours AS DOUBLE))
      comment: "Total PTO hours paid out (typically at termination)"
    - name: "total_current_balance_hours"
      expr: SUM(CAST(current_balance_hours AS DOUBLE))
      comment: "Total current PTO balance hours across all workers"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked (basis for accrual calculation)"
    - name: "accrual_record_count"
      expr: COUNT(1)
      comment: "Number of PTO accrual records"
    - name: "unique_workers_with_pto"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with PTO accruals"
    - name: "avg_current_balance_per_worker"
      expr: AVG(CAST(current_balance_hours AS DOUBLE))
      comment: "Average current PTO balance per worker"
    - name: "avg_hours_accrued_per_worker"
      expr: AVG(CAST(hours_accrued AS DOUBLE))
      comment: "Average PTO hours accrued per worker per period"
    - name: "avg_hours_used_per_worker"
      expr: AVG(CAST(hours_used AS DOUBLE))
      comment: "Average PTO hours used per worker per period"
    - name: "pto_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(hours_used AS DOUBLE)) / NULLIF(SUM(CAST(hours_accrued AS DOUBLE)), 0), 2)
      comment: "PTO utilization rate (hours used as a percentage of hours accrued)"
    - name: "pto_forfeiture_rate"
      expr: ROUND(100.0 * SUM(CAST(hours_forfeited AS DOUBLE)) / NULLIF(SUM(CAST(hours_accrued AS DOUBLE)), 0), 2)
      comment: "PTO forfeiture rate (hours forfeited as a percentage of hours accrued)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_garnishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Garnishment order KPIs tracking withholding amounts, remittance status, and compliance by garnishment type and jurisdiction"
  source: "`staffing_hr_ecm`.`payroll`.`garnishment_order`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective start date of the garnishment order"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the garnishment order"
    - name: "garnishment_type"
      expr: garnishment_type
      comment: "Type of garnishment (child support, tax levy, creditor, student loan)"
    - name: "garnishment_order_status"
      expr: garnishment_order_status
      comment: "Status of the garnishment order (active, suspended, terminated, satisfied)"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the garnishment order"
    - name: "issuing_authority_name"
      expr: issuing_authority_name
      comment: "Name of the issuing authority (court, agency)"
    - name: "withholding_method"
      expr: withholding_method
      comment: "Method of withholding (percentage, fixed amount)"
    - name: "remittance_frequency"
      expr: remittance_frequency
      comment: "Frequency of remittance to the issuing authority"
    - name: "remittance_method"
      expr: remittance_method
      comment: "Method of remittance (ACH, check, wire)"
    - name: "priority_order"
      expr: priority_order
      comment: "Priority order when multiple garnishments exist"
  measures:
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total garnishment withholding amount per pay period"
    - name: "total_arrears_amount"
      expr: SUM(CAST(arrears_amount AS DOUBLE))
      comment: "Total arrears amount being collected"
    - name: "total_obligation_amount"
      expr: SUM(CAST(total_obligation_amount AS DOUBLE))
      comment: "Total obligation amount across all garnishment orders"
    - name: "total_withheld_to_date"
      expr: SUM(CAST(total_withheld_to_date AS DOUBLE))
      comment: "Total amount withheld to date across all orders"
    - name: "total_administrative_fee"
      expr: SUM(CAST(administrative_fee_amount AS DOUBLE))
      comment: "Total administrative fees charged for garnishment processing"
    - name: "garnishment_order_count"
      expr: COUNT(1)
      comment: "Number of garnishment orders"
    - name: "unique_workers_with_garnishments"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with active garnishment orders"
    - name: "avg_withholding_per_order"
      expr: AVG(CAST(withholding_amount AS DOUBLE))
      comment: "Average withholding amount per garnishment order"
    - name: "avg_obligation_per_order"
      expr: AVG(CAST(total_obligation_amount AS DOUBLE))
      comment: "Average total obligation per garnishment order"
    - name: "garnishment_satisfaction_rate"
      expr: ROUND(100.0 * SUM(CAST(total_withheld_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_obligation_amount AS DOUBLE)), 0), 2)
      comment: "Garnishment satisfaction rate (amount withheld as a percentage of total obligation)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`payroll_wc_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workers compensation policy KPIs tracking premium amounts, experience mods, and loss ratios by policy and jurisdiction"
  source: "`staffing_hr_ecm`.`payroll`.`wc_policy`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective start date of the workers comp policy"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the workers comp policy"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of workers comp policy (guaranteed cost, loss sensitive, self-insured)"
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the policy (active, expired, cancelled)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for the workers comp policy"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the workers comp insurance carrier"
    - name: "wc_class_code"
      expr: wc_class_code
      comment: "Workers compensation class code"
    - name: "ncci_class_description"
      expr: ncci_class_description
      comment: "NCCI class code description"
    - name: "loss_sensitive_program_type"
      expr: loss_sensitive_program_type
      comment: "Type of loss-sensitive program (retrospective rating, large deductible)"
    - name: "premium_basis"
      expr: premium_basis
      comment: "Basis for premium calculation (payroll, hours, units)"
  measures:
    - name: "total_computed_premium"
      expr: SUM(CAST(computed_premium_amount AS DOUBLE))
      comment: "Total computed workers comp premium for the period"
    - name: "total_estimated_annual_premium"
      expr: SUM(CAST(estimated_annual_premium AS DOUBLE))
      comment: "Total estimated annual workers comp premium"
    - name: "total_deposit_premium"
      expr: SUM(CAST(deposit_premium_amount AS DOUBLE))
      comment: "Total deposit premium paid upfront"
    - name: "total_minimum_premium"
      expr: SUM(CAST(minimum_premium_amount AS DOUBLE))
      comment: "Total minimum premium amount"
    - name: "total_audit_adjustment"
      expr: SUM(CAST(audit_adjustment_amount AS DOUBLE))
      comment: "Total audit adjustment amount (positive or negative)"
    - name: "total_payroll_subject_to_wc"
      expr: SUM(CAST(payroll_subject_to_wc AS DOUBLE))
      comment: "Total payroll subject to workers compensation premium"
    - name: "total_ytd_premium"
      expr: SUM(CAST(ytd_premium_total AS DOUBLE))
      comment: "Total year-to-date workers comp premium"
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Number of workers comp policies"
    - name: "avg_experience_mod_factor"
      expr: AVG(CAST(experience_mod_factor AS DOUBLE))
      comment: "Average experience modification factor across policies"
    - name: "avg_base_rate_per_100"
      expr: AVG(CAST(base_rate_per_100 AS DOUBLE))
      comment: "Average base rate per $100 of payroll"
    - name: "avg_modified_rate_per_100"
      expr: AVG(CAST(modified_rate_per_100 AS DOUBLE))
      comment: "Average modified rate per $100 of payroll (after experience mod)"
    - name: "effective_premium_rate"
      expr: ROUND(100.0 * SUM(CAST(computed_premium_amount AS DOUBLE)) / NULLIF(SUM(CAST(payroll_subject_to_wc AS DOUBLE)), 0), 4)
      comment: "Effective workers comp premium rate as a percentage of payroll"
$$;