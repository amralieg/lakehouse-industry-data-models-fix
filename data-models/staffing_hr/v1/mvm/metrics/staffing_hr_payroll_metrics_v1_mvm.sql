-- Metric views for domain: payroll | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_pay_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution metrics tracking gross pay, net pay, tax withholding, employer burden, and worker counts across pay cycles"
  source: "`staffing_hr_ecm_v1`.`payroll`.`pay_run`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of payroll processing (weekly, biweekly, semi-monthly, monthly)"
    - name: "run_status"
      expr: run_status
      comment: "Current status of the pay run (draft, approved, processed, posted, voided)"
    - name: "run_type"
      expr: run_type
      comment: "Type of pay run (regular, off-cycle, bonus, correction)"
    - name: "check_date"
      expr: check_date
      comment: "Date checks are issued or direct deposits are made"
    - name: "pay_date"
      expr: pay_date
      comment: "Date workers receive payment"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the pay run"
    - name: "tax_quarter"
      expr: tax_quarter
      comment: "Tax quarter for the pay run"
    - name: "branch_code"
      expr: branch_code
      comment: "Branch or division code for the pay run"
    - name: "company_code"
      expr: company_code
      comment: "Company or legal entity code"
    - name: "is_multi_state"
      expr: is_multi_state
      comment: "Flag indicating if pay run spans multiple states"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross wages paid before deductions and taxes"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to workers after all deductions and taxes"
    - name: "total_tax_withholding"
      expr: SUM(CAST(total_tax_withholding AS DOUBLE))
      comment: "Total employee tax withholding (federal, state, local)"
    - name: "total_employer_burden"
      expr: SUM(CAST(total_employer_burden AS DOUBLE))
      comment: "Total employer payroll tax burden (FICA employer, FUTA, SUTA, workers comp)"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total voluntary and involuntary deductions (benefits, garnishments, etc.)"
    - name: "total_fica_employee"
      expr: SUM(CAST(total_fica_employee AS DOUBLE))
      comment: "Total employee FICA tax (Social Security and Medicare)"
    - name: "total_fica_employer"
      expr: SUM(CAST(total_fica_employer AS DOUBLE))
      comment: "Total employer FICA tax (Social Security and Medicare)"
    - name: "total_futa_tax"
      expr: SUM(CAST(total_futa_tax AS DOUBLE))
      comment: "Total Federal Unemployment Tax Act (FUTA) liability"
    - name: "total_suta_tax"
      expr: SUM(CAST(total_suta_tax AS DOUBLE))
      comment: "Total State Unemployment Tax Act (SUTA) liability"
    - name: "total_workers_comp_premium"
      expr: SUM(CAST(total_workers_comp_premium AS DOUBLE))
      comment: "Total workers compensation insurance premium"
    - name: "total_regular_pay"
      expr: SUM(CAST(total_regular_pay AS DOUBLE))
      comment: "Total regular time earnings"
    - name: "total_ot_pay"
      expr: SUM(CAST(total_ot_pay AS DOUBLE))
      comment: "Total overtime earnings"
    - name: "total_dt_pay"
      expr: SUM(CAST(total_dt_pay AS DOUBLE))
      comment: "Total double-time earnings"
    - name: "total_pto_pay"
      expr: SUM(CAST(total_pto_pay AS DOUBLE))
      comment: "Total paid time off earnings"
    - name: "total_per_diem_pay"
      expr: SUM(CAST(total_per_diem_pay AS DOUBLE))
      comment: "Total per diem reimbursements"
    - name: "pay_run_count"
      expr: COUNT(1)
      comment: "Number of pay runs executed"
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per pay run"
    - name: "avg_net_pay_per_run"
      expr: AVG(CAST(total_net_pay AS DOUBLE))
      comment: "Average net pay per pay run"
    - name: "employer_burden_rate"
      expr: ROUND(100.0 * SUM(CAST(total_employer_burden AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Employer burden as percentage of gross pay"
    - name: "tax_withholding_rate"
      expr: ROUND(100.0 * SUM(CAST(total_tax_withholding AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Tax withholding as percentage of gross pay"
    - name: "net_pay_rate"
      expr: ROUND(100.0 * SUM(CAST(total_net_pay AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_pay AS DOUBLE)), 0), 2)
      comment: "Net pay as percentage of gross pay (take-home rate)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_pay_stub`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual worker pay stub metrics tracking earnings, deductions, taxes, and year-to-date totals by worker and assignment"
  source: "`staffing_hr_ecm_v1`.`payroll`.`pay_stub`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency for the worker (weekly, biweekly, semi-monthly, monthly)"
    - name: "stub_status"
      expr: stub_status
      comment: "Status of the pay stub (draft, issued, voided, corrected)"
    - name: "pay_delivery_method"
      expr: pay_delivery_method
      comment: "Method of payment delivery (direct deposit, check, pay card)"
    - name: "pay_date"
      expr: pay_date
      comment: "Date payment is issued to worker"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate (hourly, salary, per diem, piece rate)"
    - name: "tax_filing_status"
      expr: tax_filing_status
      comment: "Worker tax filing status (single, married, head of household)"
    - name: "w2_eligible"
      expr: w2_eligible
      comment: "Flag indicating if earnings are W-2 eligible"
    - name: "workers_comp_code"
      expr: workers_comp_code
      comment: "Workers compensation classification code"
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account for direct deposit (checking, savings)"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay across all pay stubs"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to workers"
    - name: "total_regular_earnings"
      expr: SUM(CAST(regular_earnings AS DOUBLE))
      comment: "Total regular time earnings"
    - name: "total_ot_earnings"
      expr: SUM(CAST(ot_earnings AS DOUBLE))
      comment: "Total overtime earnings"
    - name: "total_dt_earnings"
      expr: SUM(CAST(dt_earnings AS DOUBLE))
      comment: "Total double-time earnings"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_ot_hours"
      expr: SUM(CAST(ot_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_dt_hours"
      expr: SUM(CAST(dt_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem reimbursements"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions (voluntary and involuntary)"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withholding (federal, state, local, FICA)"
    - name: "total_federal_income_tax_withheld"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_state_income_tax_withheld"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "total_social_security_tax_withheld"
      expr: SUM(CAST(social_security_tax_withheld AS DOUBLE))
      comment: "Total Social Security tax withheld"
    - name: "total_medicare_tax_withheld"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withheld"
    - name: "total_workers_comp_premium"
      expr: SUM(CAST(workers_comp_premium AS DOUBLE))
      comment: "Total workers compensation premium"
    - name: "total_pto_hours_used"
      expr: SUM(CAST(pto_hours_used AS DOUBLE))
      comment: "Total PTO hours used"
    - name: "avg_pto_accrual_balance"
      expr: AVG(CAST(pto_accrual_balance AS DOUBLE))
      comment: "Average PTO accrual balance per worker"
    - name: "pay_stub_count"
      expr: COUNT(1)
      comment: "Number of pay stubs issued"
    - name: "unique_workers_paid"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers paid"
    - name: "avg_gross_pay_per_stub"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per pay stub"
    - name: "avg_net_pay_per_stub"
      expr: AVG(CAST(net_pay AS DOUBLE))
      comment: "Average net pay per pay stub"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across all pay stubs"
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(ot_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)) + SUM(CAST(ot_hours AS DOUBLE)) + SUM(CAST(dt_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of total hours worked"
    - name: "net_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0), 2)
      comment: "Net pay as percentage of gross pay (worker take-home rate)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_earnings_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed earnings line item metrics tracking hours, rates, and amounts by earning type and labor category"
  source: "`staffing_hr_ecm_v1`.`payroll`.`earnings_line`"
  dimensions:
    - name: "earning_type"
      expr: earning_type
      comment: "Type of earning (regular, overtime, double-time, holiday, PTO, bonus, per diem)"
    - name: "earning_code"
      expr: earning_code
      comment: "Specific earning code used in payroll system"
    - name: "line_status"
      expr: line_status
      comment: "Status of the earnings line (pending, approved, paid, voided)"
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flag indicating if this is overtime earnings"
    - name: "is_taxable"
      expr: is_taxable
      comment: "Flag indicating if earnings are subject to income tax"
    - name: "is_fica_subject"
      expr: is_fica_subject
      comment: "Flag indicating if earnings are subject to FICA tax"
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Flag indicating if this is a payroll adjustment or correction"
    - name: "prevailing_wage_flag"
      expr: prevailing_wage_flag
      comment: "Flag indicating if prevailing wage rules apply"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status (exempt, non-exempt)"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker (W-2, 1099, temporary, permanent)"
    - name: "labor_category_code"
      expr: labor_category_code
      comment: "Labor category or job classification code"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code (day, evening, night, weekend)"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed"
    - name: "per_diem_type"
      expr: per_diem_type
      comment: "Type of per diem (meals, lodging, travel)"
    - name: "check_date"
      expr: check_date
      comment: "Date of check or payment"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross earnings amount"
    - name: "total_hours"
      expr: SUM(CAST(hours_quantity AS DOUBLE))
      comment: "Total hours worked or paid"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across earnings lines"
    - name: "avg_ot_multiplier"
      expr: AVG(CAST(ot_multiplier AS DOUBLE))
      comment: "Average overtime multiplier (typically 1.5 or 2.0)"
    - name: "total_per_diem_amount"
      expr: SUM(CAST(per_diem_rate_daily AS DOUBLE))
      comment: "Total per diem daily rates"
    - name: "earnings_line_count"
      expr: COUNT(1)
      comment: "Number of earnings line items"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with earnings"
    - name: "unique_assignments"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Number of unique assignments with earnings"
    - name: "avg_gross_per_line"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per earnings line"
    - name: "avg_hours_per_line"
      expr: AVG(CAST(hours_quantity AS DOUBLE))
      comment: "Average hours per earnings line"
    - name: "blended_pay_rate"
      expr: ROUND(SUM(CAST(gross_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_quantity AS DOUBLE)), 0), 2)
      comment: "Blended average pay rate (total earnings divided by total hours)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_burden_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer burden rate metrics tracking payroll taxes, benefits load, markup, and gross margin by rate type and scope"
  source: "`staffing_hr_ecm_v1`.`payroll`.`burden_rate`"
  dimensions:
    - name: "burden_rate_status"
      expr: burden_rate_status
      comment: "Status of the burden rate (active, expired, pending, superseded)"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (standard, custom, prevailing wage, union)"
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the rate (internal, client, vendor, regulatory)"
    - name: "applicability_scope"
      expr: applicability_scope
      comment: "Scope of rate applicability (client, program, location, job category)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (temporary, permanent, contract, seasonal)"
    - name: "is_eor_model"
      expr: is_eor_model
      comment: "Flag indicating if this is an Employer of Record model"
    - name: "is_peo_model"
      expr: is_peo_model
      comment: "Flag indicating if this is a Professional Employer Organization model"
    - name: "state_code"
      expr: state_code
      comment: "State code for the burden rate"
    - name: "wc_hazard_category"
      expr: wc_hazard_category
      comment: "Workers compensation hazard category"
    - name: "wc_ncci_class_code"
      expr: wc_ncci_class_code
      comment: "NCCI workers compensation class code"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the burden rate becomes effective"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date the burden rate expires"
  measures:
    - name: "avg_total_burden_percent"
      expr: AVG(CAST(total_burden_percent AS DOUBLE))
      comment: "Average total employer burden as percentage of pay"
    - name: "avg_markup_percent"
      expr: AVG(CAST(markup_percent AS DOUBLE))
      comment: "Average markup percentage applied to pay rate"
    - name: "avg_target_gross_margin_percent"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage"
    - name: "avg_benefits_load_percent"
      expr: AVG(CAST(benefits_load_percent AS DOUBLE))
      comment: "Average benefits load as percentage of pay"
    - name: "avg_overhead_percent"
      expr: AVG(CAST(overhead_percent AS DOUBLE))
      comment: "Average overhead percentage"
    - name: "avg_fica_employer_rate"
      expr: AVG(CAST(fica_employer_rate AS DOUBLE))
      comment: "Average FICA employer tax rate"
    - name: "avg_futa_rate"
      expr: AVG(CAST(futa_rate AS DOUBLE))
      comment: "Average FUTA tax rate"
    - name: "avg_suta_rate"
      expr: AVG(CAST(suta_rate AS DOUBLE))
      comment: "Average SUTA tax rate"
    - name: "avg_suta_wage_base"
      expr: AVG(CAST(suta_wage_base AS DOUBLE))
      comment: "Average SUTA wage base limit"
    - name: "avg_general_liability_rate"
      expr: AVG(CAST(general_liability_rate AS DOUBLE))
      comment: "Average general liability insurance rate"
    - name: "avg_wc_base_rate_per_100"
      expr: AVG(CAST(wc_base_rate_per_100 AS DOUBLE))
      comment: "Average workers comp base rate per $100 of payroll"
    - name: "avg_wc_experience_mod_factor"
      expr: AVG(CAST(wc_experience_mod_factor AS DOUBLE))
      comment: "Average workers comp experience modification factor"
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate"
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate"
    - name: "burden_rate_count"
      expr: COUNT(1)
      comment: "Number of burden rate records"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with burden rates"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with burden rates"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing and remittance metrics tracking federal and state tax deposits, liabilities, and compliance by jurisdiction and filing period"
  source: "`staffing_hr_ecm_v1`.`payroll`.`tax_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the tax filing (pending, filed, accepted, rejected, amended)"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of tax filing (941, 940, state unemployment, state income tax)"
    - name: "tax_authority_level"
      expr: tax_authority_level
      comment: "Level of tax authority (federal, state, local)"
    - name: "tax_authority_name"
      expr: tax_authority_name
      comment: "Name of the tax authority"
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level filings"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the filing"
    - name: "tax_quarter"
      expr: tax_quarter
      comment: "Tax quarter for the filing"
    - name: "filing_period_type"
      expr: filing_period_type
      comment: "Type of filing period (quarterly, annual, monthly)"
    - name: "deposit_method"
      expr: deposit_method
      comment: "Method of tax deposit (EFTPS, ACH, check)"
    - name: "amended_filing_flag"
      expr: amended_filing_flag
      comment: "Flag indicating if this is an amended filing"
    - name: "eor_arrangement_flag"
      expr: eor_arrangement_flag
      comment: "Flag indicating if this is under an EOR arrangement"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for the filing (W-2, 1099)"
    - name: "due_date"
      expr: due_date
      comment: "Due date for the tax filing"
    - name: "deposit_date"
      expr: deposit_date
      comment: "Date tax deposit was made"
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability amount across all filings"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total tax deposits made"
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due_amount AS DOUBLE))
      comment: "Total balance due on tax filings"
    - name: "total_federal_income_tax_withheld"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_state_income_tax_withheld"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "total_fica_employee_tax"
      expr: SUM(CAST(fica_employee_tax_amount AS DOUBLE))
      comment: "Total FICA employee tax"
    - name: "total_fica_employer_tax"
      expr: SUM(CAST(fica_employer_tax_amount AS DOUBLE))
      comment: "Total FICA employer tax"
    - name: "total_futa_tax"
      expr: SUM(CAST(futa_tax_amount AS DOUBLE))
      comment: "Total FUTA tax"
    - name: "total_suta_tax"
      expr: SUM(CAST(suta_tax_amount AS DOUBLE))
      comment: "Total SUTA tax"
    - name: "total_taxable_wages"
      expr: SUM(CAST(total_taxable_wages AS DOUBLE))
      comment: "Total taxable wages reported"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged"
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayments"
    - name: "tax_filing_count"
      expr: COUNT(1)
      comment: "Number of tax filings"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with tax filings"
    - name: "avg_tax_liability_per_filing"
      expr: AVG(CAST(tax_liability_amount AS DOUBLE))
      comment: "Average tax liability per filing"
    - name: "deposit_to_liability_ratio"
      expr: ROUND(100.0 * SUM(CAST(deposit_amount AS DOUBLE)) / NULLIF(SUM(CAST(tax_liability_amount AS DOUBLE)), 0), 2)
      comment: "Tax deposits as percentage of tax liability (compliance rate)"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_deduction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll deduction metrics tracking voluntary and involuntary deductions, benefit contributions, and garnishments by type and status"
  source: "`staffing_hr_ecm_v1`.`payroll`.`deduction_line`"
  dimensions:
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (voluntary, involuntary, benefit, garnishment)"
    - name: "deduction_category"
      expr: deduction_category
      comment: "Category of deduction (health insurance, 401k, child support, tax levy)"
    - name: "deduction_code"
      expr: deduction_code
      comment: "Specific deduction code"
    - name: "deduction_status"
      expr: deduction_status
      comment: "Status of the deduction (active, suspended, terminated)"
    - name: "is_pretax"
      expr: is_pretax
      comment: "Flag indicating if deduction is pre-tax"
    - name: "is_fica_exempt"
      expr: is_fica_exempt
      comment: "Flag indicating if deduction is FICA exempt"
    - name: "is_arrears_recovery"
      expr: is_arrears_recovery
      comment: "Flag indicating if this is arrears recovery"
    - name: "benefit_plan_type"
      expr: benefit_plan_type
      comment: "Type of benefit plan (medical, dental, vision, life, disability, retirement)"
    - name: "benefit_enrollment_status"
      expr: benefit_enrollment_status
      comment: "Enrollment status for the benefit"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee + spouse, family)"
    - name: "deduction_frequency"
      expr: deduction_frequency
      comment: "Frequency of deduction (per pay period, monthly, annual)"
    - name: "check_date"
      expr: check_date
      comment: "Date of check or payment"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed"
  measures:
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution to benefits"
    - name: "total_arrears_amount"
      expr: SUM(CAST(arrears_amount AS DOUBLE))
      comment: "Total arrears amount"
    - name: "total_annual_limit"
      expr: SUM(CAST(annual_limit_amount AS DOUBLE))
      comment: "Total annual limit amounts"
    - name: "total_ytd_deduction"
      expr: SUM(CAST(ytd_deduction_amount AS DOUBLE))
      comment: "Total year-to-date deduction amount"
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
      comment: "Employer contribution as percentage of total benefit cost"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`payroll_wc_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workers compensation policy metrics tracking premiums, rates, experience mods, and payroll exposure by jurisdiction and class code"
  source: "`staffing_hr_ecm_v1`.`payroll`.`wc_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the workers comp policy (active, expired, cancelled)"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of workers comp policy (guaranteed cost, retrospective, large deductible)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for the policy"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the insurance carrier"
    - name: "premium_basis"
      expr: premium_basis
      comment: "Basis for premium calculation (payroll, hours, units)"
    - name: "loss_sensitive_program_type"
      expr: loss_sensitive_program_type
      comment: "Type of loss-sensitive program (retro, dividend, deductible)"
    - name: "co_employment_flag"
      expr: co_employment_flag
      comment: "Flag indicating co-employment arrangement"
    - name: "eor_flag"
      expr: eor_flag
      comment: "Flag indicating Employer of Record arrangement"
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency of policy audits (annual, semi-annual, quarterly)"
    - name: "effective_date"
      expr: effective_date
      comment: "Policy effective date"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Policy expiration date"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year"
  measures:
    - name: "total_computed_premium"
      expr: SUM(CAST(computed_premium_amount AS DOUBLE))
      comment: "Total computed workers comp premium"
    - name: "total_estimated_annual_premium"
      expr: SUM(CAST(estimated_annual_premium AS DOUBLE))
      comment: "Total estimated annual premium"
    - name: "total_deposit_premium"
      expr: SUM(CAST(deposit_premium_amount AS DOUBLE))
      comment: "Total deposit premium paid"
    - name: "total_minimum_premium"
      expr: SUM(CAST(minimum_premium_amount AS DOUBLE))
      comment: "Total minimum premium"
    - name: "total_ytd_premium"
      expr: SUM(CAST(ytd_premium_total AS DOUBLE))
      comment: "Total year-to-date premium"
    - name: "total_payroll_subject_to_wc"
      expr: SUM(CAST(payroll_subject_to_wc AS DOUBLE))
      comment: "Total payroll subject to workers comp"
    - name: "total_audit_adjustment"
      expr: SUM(CAST(audit_adjustment_amount AS DOUBLE))
      comment: "Total audit adjustment amount"
    - name: "total_deductible_per_claim"
      expr: SUM(CAST(deductible_amount_per_claim AS DOUBLE))
      comment: "Total deductible amount per claim"
    - name: "avg_base_rate_per_100"
      expr: AVG(CAST(base_rate_per_100 AS DOUBLE))
      comment: "Average base rate per $100 of payroll"
    - name: "avg_modified_rate_per_100"
      expr: AVG(CAST(modified_rate_per_100 AS DOUBLE))
      comment: "Average modified rate per $100 of payroll"
    - name: "avg_experience_mod_factor"
      expr: AVG(CAST(experience_mod_factor AS DOUBLE))
      comment: "Average experience modification factor"
    - name: "avg_schedule_credit_debit_pct"
      expr: AVG(CAST(schedule_credit_debit_pct AS DOUBLE))
      comment: "Average schedule credit/debit percentage"
    - name: "wc_policy_count"
      expr: COUNT(1)
      comment: "Number of workers comp policies"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with WC policies"
    - name: "premium_to_payroll_ratio"
      expr: ROUND(100.0 * SUM(CAST(computed_premium_amount AS DOUBLE)) / NULLIF(SUM(CAST(payroll_subject_to_wc AS DOUBLE)), 0), 2)
      comment: "Workers comp premium as percentage of payroll (effective rate)"
$$;