-- Metric views for domain: lease | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core lease portfolio KPIs covering active lease exposure, rent economics, TI investment, and ASC 842 balance sheet obligations. Used by asset managers, CFOs, and portfolio executives to steer leasing strategy and monitor financial commitments."
  source: "`real_estate_ecm`.`lease`.`lease_agreement`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current lifecycle status of the lease (e.g. Active, Expired, Terminated, Holdover) — primary filter for portfolio health dashboards."
    - name: "lease_classification"
      expr: lease_classification
      comment: "ASC 842 / IFRS 16 classification (Operating vs Finance) — drives balance sheet treatment and disclosure requirements."
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio segment (e.g. Core, Value-Add, Opportunistic) — enables performance comparison across investment strategies."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Escalation mechanism (Fixed, CPI, Market) — informs rent growth forecasting and lease structuring decisions."
    - name: "lease_commencement_month"
      expr: DATE_TRUNC('MONTH', commencement_date)
      comment: "Month the lease commenced — used for vintage cohort analysis and leasing velocity trending."
    - name: "lease_expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the lease expires — critical for lease expiry roll-forward and re-leasing pipeline planning."
    - name: "renewal_option_exercised"
      expr: renewal_option_exercised
      comment: "Whether the tenant has exercised a renewal option — tracks tenant retention and lease extension activity."
    - name: "subletting_permitted"
      expr: subletting_permitted
      comment: "Whether subletting is contractually permitted — relevant for tenant flexibility risk assessment."
  measures:
    - name: "total_active_leases"
      expr: COUNT(CASE WHEN lease_status = 'Active' THEN lease_agreement_id END)
      comment: "Count of currently active leases — baseline portfolio size metric used in occupancy and leasing velocity reporting."
    - name: "total_leased_area_sqft"
      expr: SUM(CAST(leased_area_sqft AS DOUBLE))
      comment: "Total square footage under lease — fundamental portfolio scale metric used to compute occupancy rates and rent per square foot benchmarks."
    - name: "total_base_rent_monthly"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE))
      comment: "Aggregate monthly base rent across all leases in scope — primary revenue run-rate indicator for asset managers and CFOs."
    - name: "total_base_rent_annual"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE) * 12)
      comment: "Annualised base rent (monthly × 12) — used for NOI forecasting, valuation cap-rate analysis, and investor reporting."
    - name: "avg_base_rent_psf_annual"
      expr: AVG(CAST(base_rent_psf_annual AS DOUBLE))
      comment: "Average annual rent per square foot across the portfolio — key benchmarking metric against market comparables and underwriting assumptions."
    - name: "total_ti_allowance_committed"
      expr: SUM(CAST(ti_allowance_amount AS DOUBLE))
      comment: "Total tenant improvement allowance committed across leases — tracks capital deployment for leasing incentives and impacts free cash flow."
    - name: "total_lease_liability"
      expr: SUM(CAST(lease_liability AS DOUBLE))
      comment: "Aggregate ASC 842 / IFRS 16 lease liability on the balance sheet — critical for debt covenant compliance and financial statement disclosure."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value recognised on the balance sheet — paired with lease liability to assess net lease obligation exposure."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average contractual rent escalation rate across leases — informs revenue growth projections and lease quality assessment."
    - name: "avg_lease_term_months"
      expr: AVG(CAST(lease_term_months AS DOUBLE))
      comment: "Average lease term in months — measures weighted lease duration, a key indicator of income stability and re-leasing risk."
    - name: "total_security_deposit_held"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across the portfolio — quantifies credit risk mitigation and cash held in trust obligations."
    - name: "total_cam_annual_budget"
      expr: SUM(CAST(cam_annual_budget AS DOUBLE))
      comment: "Total budgeted CAM recoveries across leases — used to project operating expense recovery income and assess recovery ratio performance."
    - name: "renewal_option_exercise_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_option_exercised = TRUE THEN lease_agreement_id END) / NULLIF(COUNT(CASE WHEN renewal_option_count IS NOT NULL THEN lease_agreement_id END), 0), 2)
      comment: "Percentage of leases with renewal options where the option has been exercised — measures tenant retention and lease roll risk mitigation effectiveness."
    - name: "avg_pro_rata_share"
      expr: AVG(CAST(pro_rata_share AS DOUBLE))
      comment: "Average tenant pro-rata share of building expenses — used to validate CAM recovery allocations and identify under-recovery risk."
    - name: "total_termination_penalty_exposure"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total contractual termination penalties across the portfolio — quantifies downside protection against early lease exits and informs risk-adjusted NOI."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent schedule KPIs covering scheduled rent cash flows, straight-line rent adjustments, ASC 842 lease liability, and escalation economics. Used by accounting, asset management, and finance teams for revenue recognition, cash flow forecasting, and compliance reporting."
  source: "`real_estate_ecm`.`lease`.`rent_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the rent schedule period (e.g. Active, Future, Expired) — used to filter to in-force cash flow obligations."
    - name: "lease_classification"
      expr: lease_classification
      comment: "ASC 842 lease classification (Operating vs Finance) — drives revenue recognition treatment and P&L line assignment."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Rent escalation mechanism (Fixed Step, CPI, Market Reset) — used to segment rent growth profiles for forecasting."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of rent payments (Monthly, Quarterly, Annual) — relevant for cash flow timing and treasury planning."
    - name: "is_free_rent_period"
      expr: is_free_rent_period
      comment: "Indicates whether the schedule period is a free-rent concession — used to quantify leasing concession costs and straight-line adjustments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rent schedule period begins — enables time-series cash flow analysis and rent step tracking."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the rent schedule period ends — used for lease expiry roll-forward and future cash flow modelling."
    - name: "cpi_index_name"
      expr: cpi_index_name
      comment: "CPI index used for inflation-linked escalations — relevant for benchmarking rent growth against inflation benchmarks."
  measures:
    - name: "total_scheduled_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent across all schedule periods — primary cash flow measure for revenue forecasting and NOI modelling."
    - name: "total_annual_rent"
      expr: SUM(CAST(annual_rent_amount AS DOUBLE))
      comment: "Total annualised rent across schedule periods — used for portfolio-level rent roll analysis and investor reporting."
    - name: "total_straight_line_rent"
      expr: SUM(CAST(straight_line_rent_amount AS DOUBLE))
      comment: "Total straight-line rent recognised under ASC 842 / IFRS 16 — measures the GAAP revenue recognition impact versus cash rent collected."
    - name: "total_straight_line_adjustment"
      expr: SUM(CAST(straight_line_rent_adjustment AS DOUBLE))
      comment: "Cumulative straight-line rent adjustment (deferred/accrued rent) — key balance sheet item for financial statement accuracy and audit compliance."
    - name: "total_lease_liability_scheduled"
      expr: SUM(CAST(lease_liability_amount AS DOUBLE))
      comment: "Total lease liability recognised across rent schedule periods — supports ASC 842 maturity analysis and balance sheet roll-forward."
    - name: "total_rou_asset_scheduled"
      expr: SUM(CAST(rou_asset_amount AS DOUBLE))
      comment: "Total ROU asset value across rent schedule periods — used in ASC 842 asset roll-forward and impairment testing."
    - name: "avg_rent_psf"
      expr: AVG(CAST(rent_psf AS DOUBLE))
      comment: "Average rent per square foot across schedule periods — benchmarking metric for market rent comparison and lease quality assessment."
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average contractual escalation rate across rent steps — informs rent growth forecasting and lease economics analysis."
    - name: "total_escalation_amount"
      expr: SUM(CAST(escalation_amount AS DOUBLE))
      comment: "Total incremental rent from escalation steps — quantifies the revenue uplift from contractual rent growth over the lease term."
    - name: "total_percentage_rent_breakpoint"
      expr: SUM(CAST(percentage_rent_breakpoint AS DOUBLE))
      comment: "Total natural breakpoint thresholds across percentage rent schedules — used to assess overage rent potential and retail tenant performance."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average incremental borrowing rate used to discount lease liabilities — critical input for ASC 842 present value calculations and auditor review."
    - name: "free_rent_period_count"
      expr: COUNT(CASE WHEN is_free_rent_period = TRUE THEN rent_schedule_id END)
      comment: "Number of free-rent concession periods across the portfolio — measures leasing incentive cost and impacts straight-line rent calculations."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease payment collection KPIs covering cash receipts, delinquency, outstanding balances, and late fee economics. Used by property managers, AR teams, and CFOs to monitor collection performance, identify delinquent tenants, and manage cash flow risk."
  source: "`real_estate_ecm`.`lease`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Posted, Pending, Reversed, NSF) — primary filter for collection performance analysis."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge being paid (Base Rent, CAM, Tax, Insurance, Percentage Rent) — enables revenue stream decomposition."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, Check, Wire, Credit Card) — used for treasury operations and fraud risk monitoring."
    - name: "is_delinquent"
      expr: is_delinquent
      comment: "Flag indicating the payment is past due — primary dimension for delinquency reporting and collections prioritisation."
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Indicates a partial payment was received — signals tenant financial stress and triggers collections follow-up."
    - name: "nsf_flag"
      expr: nsf_flag
      comment: "Non-sufficient funds flag — identifies returned payments requiring immediate collections action."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was received — used for monthly cash collection trending and variance analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment was due — enables aging analysis and days-past-due cohort reporting."
  measures:
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected across all payments — primary revenue collection metric for property-level and portfolio-level cash flow reporting."
    - name: "total_amount_due"
      expr: SUM(CAST(amount_due AS DOUBLE))
      comment: "Total amount billed/due across all charges — denominator for collection rate calculation and billing completeness validation."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total uncollected receivables balance — key AR aging metric used by CFOs and property managers to assess credit risk exposure."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to charges — operational metric for AR reconciliation and cash application efficiency."
    - name: "total_late_fees_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees charged to tenants — measures enforcement of lease payment terms and ancillary income from delinquency."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts actually collected — the single most important collection performance KPI, benchmarked against 98%+ targets for institutional portfolios."
    - name: "delinquency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_delinquent = TRUE THEN payment_id END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payment records flagged as delinquent — tracks portfolio credit quality and triggers collections escalation workflows."
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_flag = TRUE THEN payment_id END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payments returned NSF — early warning indicator of tenant financial distress requiring immediate credit risk review."
    - name: "total_amount_applied"
      expr: SUM(CAST(amount_applied AS DOUBLE))
      comment: "Total amount applied to open charges — measures AR application efficiency and supports reconciliation of unapplied cash."
    - name: "avg_outstanding_balance_per_payment"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per payment record — used to identify concentration of AR risk and prioritise collections outreach."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_cam_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAM (Common Area Maintenance) reconciliation KPIs covering estimated vs actual CAM, recovery variances, admin fees, and dispute tracking. Used by property accountants, asset managers, and tenants to manage operating expense recovery accuracy and compliance."
  source: "`real_estate_ecm`.`lease`.`cam_schedule`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the CAM reconciliation (e.g. Pending, Sent, Disputed, Settled) — primary workflow status for CAM close process management."
    - name: "reconciliation_year"
      expr: reconciliation_year
      comment: "Calendar year of the CAM reconciliation — enables year-over-year CAM cost trend analysis and budget variance reporting."
    - name: "cam_cap_type"
      expr: cam_cap_type
      comment: "Type of CAM cap applied (Cumulative, Non-Cumulative, None) — affects tenant exposure and landlord recovery risk."
    - name: "cam_cap_applied"
      expr: cam_cap_applied
      comment: "Whether a CAM cap was applied in the reconciliation period — tracks cap utilisation and landlord under-recovery exposure."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the tenant has disputed the CAM reconciliation — identifies contested recoveries requiring legal or negotiation resolution."
    - name: "credit_or_charge_type"
      expr: credit_or_charge_type
      comment: "Whether the reconciliation resulted in a credit to tenant or additional charge — used to analyse over/under-estimation patterns."
    - name: "reconciliation_period_start_month"
      expr: DATE_TRUNC('MONTH', reconciliation_period_start)
      comment: "Start month of the CAM reconciliation period — used for time-series analysis of CAM cost trends."
  measures:
    - name: "total_actual_cam_gross"
      expr: SUM(CAST(actual_cam_gross AS DOUBLE))
      comment: "Total actual gross CAM costs incurred — primary operating expense metric for property-level cost management and recovery analysis."
    - name: "total_estimated_cam_annual"
      expr: SUM(CAST(estimated_cam_annual AS DOUBLE))
      comment: "Total estimated CAM billed to tenants during the year — compared against actuals to compute reconciliation variance and recovery accuracy."
    - name: "total_reconciliation_variance"
      expr: SUM(CAST(reconciliation_variance AS DOUBLE))
      comment: "Net CAM reconciliation variance (actual minus estimated) across all tenants — measures estimation accuracy and identifies systemic over/under-billing."
    - name: "cam_recovery_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(reconciliation_variance AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cam_annual AS DOUBLE)), 0), 2)
      comment: "CAM reconciliation variance as a percentage of estimated billings — key accuracy KPI; large positive values indicate under-billing risk, negative values indicate over-collection."
    - name: "total_tenant_cam_allocated"
      expr: SUM(CAST(tenant_cam_allocated AS DOUBLE))
      comment: "Total CAM costs allocated to tenants after exclusions and grossup — represents the recoverable expense base for income recognition."
    - name: "total_cam_cap_savings"
      expr: SUM(CAST(cam_cap_savings AS DOUBLE))
      comment: "Total landlord under-recovery due to CAM caps — quantifies the financial impact of contractual CAM caps on NOI."
    - name: "total_admin_fee_income"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total CAM administration fee income — ancillary income stream from property management; tracked against budget and market norms."
    - name: "avg_tenant_prorata_share"
      expr: AVG(CAST(tenant_prorata_share AS DOUBLE))
      comment: "Average tenant pro-rata share of building CAM — validates allocation methodology and identifies concentration risk in single-tenant buildings."
    - name: "avg_actual_cam_psf"
      expr: AVG(CAST(actual_cam_psf AS DOUBLE))
      comment: "Average actual CAM cost per square foot — benchmarking metric against market comparables and underwriting assumptions."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN cam_schedule_id END) / NULLIF(COUNT(cam_schedule_id), 0), 2)
      comment: "Percentage of CAM reconciliations with active tenant disputes — measures reconciliation quality and tenant relationship risk."
    - name: "total_cam_exclusions_amount"
      expr: SUM(CAST(cam_exclusions_amount AS DOUBLE))
      comment: "Total CAM costs excluded from tenant recovery per lease terms — tracks non-recoverable operating expense exposure impacting NOI."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_accounting_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 842 / IFRS 16 lease accounting KPIs covering ROU asset movements, lease liability roll-forward, interest expense, and straight-line rent. Used by lease accountants, controllers, and external auditors for financial statement preparation, disclosure, and compliance reporting."
  source: "`real_estate_ecm`.`lease`.`accounting_entry`"
  dimensions:
    - name: "lease_classification"
      expr: lease_classification
      comment: "ASC 842 / IFRS 16 lease classification (Operating vs Finance) — drives P&L and balance sheet treatment for each entry."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of accounting entry (e.g. Initial Recognition, Remeasurement, Amortisation, Interest) — used to decompose lease accounting activity by event type."
    - name: "entry_status"
      expr: entry_status
      comment: "Posting status of the entry (Draft, Posted, Reversed) — used to filter to confirmed financial data for reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accounting entry — primary time dimension for annual financial statement and disclosure reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the accounting entry — used for quarterly close reporting and SEC/IFRS interim disclosures."
    - name: "practical_expedient_applied"
      expr: practical_expedient_applied
      comment: "ASC 842 practical expedient elected (e.g. Short-Term, Low-Value) — tracks policy elections affecting balance sheet recognition."
    - name: "modification_flag"
      expr: modification_flag
      comment: "Indicates the entry relates to a lease modification/remeasurement event — used to isolate remeasurement impacts on the balance sheet."
    - name: "accounting_period_month"
      expr: DATE_TRUNC('MONTH', accounting_period_date)
      comment: "Accounting period month — used for monthly close roll-forward analysis of ROU assets and lease liabilities."
  measures:
    - name: "total_rou_asset_closing_balance"
      expr: SUM(CAST(rou_asset_closing_balance AS DOUBLE))
      comment: "Total ROU asset closing balance across all leases — primary balance sheet metric for ASC 842 / IFRS 16 asset disclosure."
    - name: "total_lease_liability_closing_balance"
      expr: SUM(CAST(lease_liability_closing_balance AS DOUBLE))
      comment: "Total lease liability closing balance — primary balance sheet metric for ASC 842 / IFRS 16 liability disclosure and debt covenant monitoring."
    - name: "total_rou_asset_amortisation"
      expr: SUM(CAST(rou_asset_amortisation AS DOUBLE))
      comment: "Total ROU asset amortisation expense recognised in the period — P&L impact metric for lease cost disclosure under ASC 842."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on finance lease liabilities — P&L metric for finance lease cost disclosure and interest coverage analysis."
    - name: "total_principal_repayment"
      expr: SUM(CAST(principal_repayment AS DOUBLE))
      comment: "Total principal repayments on lease liabilities — cash flow statement metric for financing activities disclosure under ASC 842."
    - name: "total_straight_line_rent_expense"
      expr: SUM(CAST(straight_line_rent_expense AS DOUBLE))
      comment: "Total straight-line rent expense for operating leases — key P&L metric for ASC 842 operating lease cost disclosure."
    - name: "total_short_term_lease_cost"
      expr: SUM(CAST(short_term_lease_cost AS DOUBLE))
      comment: "Total cost of short-term leases exempt from ASC 842 balance sheet recognition — tracks practical expedient utilisation and off-balance-sheet exposure."
    - name: "total_variable_lease_cost"
      expr: SUM(CAST(variable_lease_cost AS DOUBLE))
      comment: "Total variable lease costs (e.g. percentage rent, CPI adjustments) excluded from lease liability — required disclosure item under ASC 842."
    - name: "total_sublease_income"
      expr: SUM(CAST(sublease_income AS DOUBLE))
      comment: "Total sublease income recognised — offsets gross lease cost in ASC 842 disclosure and impacts net lease cost reporting."
    - name: "total_rou_asset_impairment"
      expr: SUM(CAST(rou_asset_impairment AS DOUBLE))
      comment: "Total ROU asset impairment charges — signals deteriorating lease economics and triggers asset write-down disclosures."
    - name: "total_lease_liability_remeasurement"
      expr: SUM(CAST(lease_liability_remeasurement AS DOUBLE))
      comment: "Total lease liability remeasurement adjustments from modifications or reassessments — tracks balance sheet volatility from lease changes."
    - name: "avg_weighted_avg_discount_rate"
      expr: AVG(CAST(weighted_avg_discount_rate AS DOUBLE))
      comment: "Average weighted-average discount rate across lease portfolios — required ASC 842 / IFRS 16 disclosure metric and input to present value sensitivity analysis."
    - name: "avg_weighted_avg_remaining_term_years"
      expr: AVG(CAST(weighted_avg_remaining_term_years AS DOUBLE))
      comment: "Average weighted-average remaining lease term in years — required ASC 842 / IFRS 16 disclosure metric and indicator of lease roll risk."
    - name: "total_maturity_year1_payments"
      expr: SUM(CAST(maturity_year1_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due within 12 months — ASC 842 maturity analysis disclosure item and near-term cash flow obligation."
    - name: "total_maturity_year2_to5_payments"
      expr: SUM(CAST(maturity_year2_to5_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due in years 2–5 — ASC 842 maturity analysis disclosure item for medium-term liability planning."
    - name: "total_maturity_after_year5_payments"
      expr: SUM(CAST(maturity_after_year5_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due beyond year 5 — ASC 842 maturity analysis disclosure item for long-term liability exposure."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_ti_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant improvement allowance KPIs covering capital commitment, disbursement progress, budget utilisation, and construction milestone tracking. Used by asset managers, development teams, and CFOs to control TI capital deployment and monitor leasing cost efficiency."
  source: "`real_estate_ecm`.`lease`.`ti_allowance`"
  dimensions:
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the TI allowance (e.g. Approved, In Progress, Disbursed, Expired) — primary workflow status for capital deployment tracking."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of TI allowance (Landlord Work, Tenant Work, Loan-Structured) — used to segment capital by delivery method and accounting treatment."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of TI disbursement (Lump Sum, Milestone-Based, Reimbursement) — tracks capital release structure and construction risk management."
    - name: "is_loan_structured"
      expr: is_loan_structured
      comment: "Whether the TI is structured as a loan to the tenant — affects accounting treatment and credit risk exposure."
    - name: "asc842_lease_incentive_flag"
      expr: asc842_lease_incentive_flag
      comment: "Whether the TI is classified as a lease incentive under ASC 842 — determines balance sheet treatment and amortisation schedule."
    - name: "lien_waiver_received"
      expr: lien_waiver_received
      comment: "Whether lien waivers have been received from contractors — critical risk control for property title protection."
    - name: "construction_start_month"
      expr: DATE_TRUNC('MONTH', construction_start_date)
      comment: "Month construction commenced — used for project timeline analysis and capital deployment velocity tracking."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the TI allowance became effective — used for vintage cohort analysis of leasing capital commitments."
  measures:
    - name: "total_ti_budget_committed"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total TI budget committed across all allowances — primary capital commitment metric for leasing cost management and investment return analysis."
    - name: "total_ti_disbursed"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total TI capital actually disbursed to tenants — measures actual cash outflow versus commitment and tracks construction progress."
    - name: "total_ti_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total undisbursed TI balance — represents future capital obligations and cash flow planning requirements."
    - name: "ti_disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of committed TI budget that has been disbursed — measures capital deployment velocity and construction completion progress."
    - name: "total_ti_invoiced"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total TI costs invoiced by contractors — compared against disbursed amounts to identify payment processing backlogs."
    - name: "total_approved_spend"
      expr: SUM(CAST(approved_spend_amount AS DOUBLE))
      comment: "Total TI spend approved by landlord — measures change order management and budget control effectiveness."
    - name: "avg_ti_amount_psf"
      expr: AVG(CAST(ti_amount_psf AS DOUBLE))
      comment: "Average TI allowance per square foot — key leasing cost benchmarking metric compared against market norms and underwriting assumptions."
    - name: "total_leasable_area_sqft"
      expr: SUM(CAST(leasable_area_sqft AS DOUBLE))
      comment: "Total leasable area covered by TI allowances — used to compute weighted average TI per square foot and assess capital intensity by asset."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Approved spend as a percentage of total budget — measures budget discipline and identifies over-run risk before disbursement."
    - name: "lien_waiver_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lien_waiver_received = TRUE THEN ti_allowance_id END) / NULLIF(COUNT(CASE WHEN lien_waiver_required = TRUE THEN ti_allowance_id END), 0), 2)
      comment: "Percentage of TI projects requiring lien waivers where waivers have been received — critical risk control metric for property title protection and lender compliance."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease termination KPIs covering early exit economics, penalty recovery, ROU asset derecognition, and security deposit disposition. Used by asset managers, legal teams, and CFOs to manage lease exit risk, quantify financial impacts, and ensure ASC 842 derecognition compliance."
  source: "`real_estate_ecm`.`lease`.`termination`"
  dimensions:
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination (e.g. Pending, Executed, Completed) — primary workflow status for lease exit management."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (Early Termination, Expiry, Default, Mutual Agreement) — used to segment exit causes and assess portfolio risk."
    - name: "initiating_party"
      expr: initiating_party
      comment: "Party initiating the termination (Landlord vs Tenant) — distinguishes voluntary exits from forced terminations for risk analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the termination — enables root cause analysis of lease exits and informs retention strategy."
    - name: "lease_classification"
      expr: lease_classification
      comment: "ASC 842 lease classification at termination — determines derecognition accounting treatment."
    - name: "asc842_derecognition_complete"
      expr: asc842_derecognition_complete
      comment: "Whether ASC 842 derecognition entries have been completed — compliance control for financial close process."
    - name: "restoration_required"
      expr: restoration_required
      comment: "Whether the tenant is required to restore the space — tracks restoration liability and associated cost exposure."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the termination became effective — used for lease expiry roll-forward and vacancy forecasting."
  measures:
    - name: "total_terminations"
      expr: COUNT(termination_id)
      comment: "Total number of lease terminations — baseline volume metric for lease exit activity monitoring and portfolio churn analysis."
    - name: "total_termination_fee_income"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total termination fees collected from tenants — measures income from early exit penalties and offsets re-leasing costs."
    - name: "total_gain_loss_on_termination"
      expr: SUM(CAST(gain_loss_on_termination AS DOUBLE))
      comment: "Net gain or loss recognised on lease terminations — P&L impact metric for ASC 842 derecognition events and financial statement disclosure."
    - name: "total_rou_asset_derecognised"
      expr: SUM(CAST(rou_asset_derecognition_amount AS DOUBLE))
      comment: "Total ROU asset value removed from the balance sheet upon termination — ASC 842 derecognition metric for balance sheet roll-forward."
    - name: "total_lease_liability_derecognised"
      expr: SUM(CAST(lease_liability_derecognition_amount AS DOUBLE))
      comment: "Total lease liability derecognised upon termination — ASC 842 balance sheet metric tracking liability reduction from lease exits."
    - name: "total_outstanding_ar_at_termination"
      expr: SUM(CAST(outstanding_ar_balance AS DOUBLE))
      comment: "Total outstanding AR balance at time of termination — measures credit loss exposure from tenant exits and informs bad debt provisioning."
    - name: "total_security_deposit_forfeited"
      expr: SUM(CAST(security_deposit_forfeited_amount AS DOUBLE))
      comment: "Total security deposits forfeited by tenants upon termination — measures credit risk mitigation effectiveness and recovery against AR losses."
    - name: "total_restoration_cost_estimate"
      expr: SUM(CAST(restoration_cost_estimate AS DOUBLE))
      comment: "Total estimated restoration costs for terminated spaces — capital planning metric for re-leasing investment and asset repositioning."
    - name: "total_unamortized_ti_balance"
      expr: SUM(CAST(unamortized_ti_balance AS DOUBLE))
      comment: "Total unamortised TI balance written off at termination — measures sunk cost of leasing incentives lost to early exits."
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fee_waived = TRUE THEN termination_id END) / NULLIF(COUNT(termination_id), 0), 2)
      comment: "Percentage of terminations where the penalty fee was waived — measures negotiating posture and income leakage from fee concessions."
    - name: "derecognition_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN asc842_derecognition_complete = TRUE THEN termination_id END) / NULLIF(COUNT(termination_id), 0), 2)
      comment: "Percentage of terminations with completed ASC 842 derecognition entries — compliance KPI for financial close quality and audit readiness."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_percentage_rent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Percentage rent (overage rent) KPIs covering tenant sales performance, breakpoint utilisation, rent collection, and audit activity. Used by retail asset managers, leasing teams, and CFOs to monitor variable rent income and tenant sales health."
  source: "`real_estate_ecm`.`lease`.`percentage_rent`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the percentage rent reconciliation (e.g. Pending, Billed, Disputed, Settled) — primary workflow status for overage rent close process."
    - name: "breakpoint_type"
      expr: breakpoint_type
      comment: "Type of sales breakpoint (Natural, Artificial) — determines how overage rent is calculated and affects tenant economics."
    - name: "lease_structure_type"
      expr: lease_structure_type
      comment: "Lease structure (Gross, Net, Hybrid) — contextualises percentage rent within the overall lease economics."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Sales reporting period type (Monthly, Quarterly, Annual) — used for cash flow timing analysis and reconciliation scheduling."
    - name: "tiered_rate_applicable"
      expr: tiered_rate_applicable
      comment: "Whether tiered percentage rent rates apply — identifies complex rent structures requiring additional monitoring."
    - name: "sales_report_late"
      expr: sales_report_late
      comment: "Whether the tenant submitted their sales report late — tracks compliance with reporting obligations and triggers audit rights."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start month of the sales reporting period — used for time-series analysis of tenant sales performance."
  measures:
    - name: "total_reported_gross_sales"
      expr: SUM(CAST(reported_gross_sales AS DOUBLE))
      comment: "Total gross sales reported by tenants — primary indicator of retail tenant health and percentage rent income potential."
    - name: "total_audited_gross_sales"
      expr: SUM(CAST(audited_gross_sales AS DOUBLE))
      comment: "Total gross sales verified through audit — compared against reported sales to identify under-reporting and recover lost rent income."
    - name: "total_pct_rent_calculated"
      expr: SUM(CAST(pct_rent_calculated AS DOUBLE))
      comment: "Total percentage rent calculated based on sales over breakpoint — measures variable rent income potential from the retail portfolio."
    - name: "total_pct_rent_collected"
      expr: SUM(CAST(pct_rent_collected AS DOUBLE))
      comment: "Total percentage rent actually collected — primary cash collection metric for overage rent income."
    - name: "pct_rent_collection_rate"
      expr: ROUND(100.0 * SUM(CAST(pct_rent_collected AS DOUBLE)) / NULLIF(SUM(CAST(pct_rent_calculated AS DOUBLE)), 0), 2)
      comment: "Percentage of calculated overage rent that has been collected — measures billing-to-collection efficiency for variable rent income."
    - name: "total_sales_over_breakpoint"
      expr: SUM(CAST(sales_over_breakpoint AS DOUBLE))
      comment: "Total tenant sales exceeding the breakpoint threshold — measures the volume of sales generating overage rent income."
    - name: "total_audit_variance_amount"
      expr: SUM(CAST(audit_variance_amount AS DOUBLE))
      comment: "Total variance between audited and reported sales — quantifies under-reporting by tenants and the value of audit rights enforcement."
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage_rate AS DOUBLE))
      comment: "Average percentage rent rate across leases — benchmarking metric for lease structuring and market comparison."
    - name: "sales_report_late_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sales_report_late = TRUE THEN percentage_rent_id END) / NULLIF(COUNT(percentage_rent_id), 0), 2)
      comment: "Percentage of sales reports submitted late — compliance metric triggering audit rights and late reporting penalties."
    - name: "total_sales_exclusions"
      expr: SUM(CAST(sales_exclusions_amount AS DOUBLE))
      comment: "Total sales excluded from percentage rent calculation per lease terms — tracks the impact of exclusions on overage rent income."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_security_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security deposit KPIs covering deposit holdings, return obligations, interest accrual, and credit risk. Used by property managers, treasury teams, and compliance officers to manage tenant deposit obligations and regulatory compliance."
  source: "`real_estate_ecm`.`lease`.`security_deposit`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the security deposit (e.g. Held, Partially Applied, Returned, Forfeited) — primary status for deposit lifecycle management."
    - name: "deposit_type"
      expr: deposit_type
      comment: "Form of security deposit (Cash, Letter of Credit, Surety Bond, Personal Guarantee) — used to segment credit risk mitigation instruments."
    - name: "credit_risk_rating"
      expr: credit_risk_rating
      comment: "Credit risk rating of the tenant at deposit — used to assess adequacy of deposit relative to tenant credit quality."
    - name: "interest_bearing"
      expr: interest_bearing
      comment: "Whether the deposit accrues interest for the tenant — relevant for regulatory compliance in jurisdictions requiring interest on deposits."
    - name: "reduction_schedule_applicable"
      expr: reduction_schedule_applicable
      comment: "Whether a burn-down/reduction schedule applies — tracks contractual deposit reduction milestones."
    - name: "return_processed"
      expr: return_processed
      comment: "Whether the deposit return has been processed — operational metric for deposit return compliance and tenant relations."
    - name: "deposit_received_month"
      expr: DATE_TRUNC('MONTH', deposit_received_date)
      comment: "Month the deposit was received — used for deposit vintage analysis and cash flow tracking."
  measures:
    - name: "total_required_deposit_amount"
      expr: SUM(CAST(required_amount AS DOUBLE))
      comment: "Total security deposit required across all leases — measures contractual credit risk mitigation coverage."
    - name: "total_held_deposit_amount"
      expr: SUM(CAST(held_amount AS DOUBLE))
      comment: "Total security deposit currently held — primary balance sheet liability metric for deposit return obligations."
    - name: "total_applied_deposit_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total deposit applied against tenant obligations (e.g. unpaid rent, damages) — measures credit loss recovery from deposit utilisation."
    - name: "total_loc_amount"
      expr: SUM(CAST(loc_amount AS DOUBLE))
      comment: "Total letter of credit deposit amounts — tracks non-cash credit support instruments and their expiry risk."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_amount AS DOUBLE))
      comment: "Total interest accrued on security deposits — regulatory compliance metric in jurisdictions requiring interest payment to tenants."
    - name: "deposit_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(held_amount AS DOUBLE)) / NULLIF(SUM(CAST(required_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of required deposit that is currently held — measures credit risk mitigation adequacy across the portfolio."
    - name: "total_next_reduction_amount"
      expr: SUM(CAST(next_reduction_amount AS DOUBLE))
      comment: "Total upcoming deposit reductions scheduled — forward-looking metric for treasury planning and deposit balance forecasting."
    - name: "avg_deposit_months_rent"
      expr: AVG(CAST(deposit_months_rent AS DOUBLE))
      comment: "Average deposit expressed in months of rent — benchmarking metric for deposit adequacy relative to lease size and tenant credit quality."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease amendment KPIs covering modification activity, rent changes, space adjustments, and TI commitments. Used by leasing teams, asset managers, and legal counsel to track lease modification economics and portfolio evolution."
  source: "`real_estate_ecm`.`lease`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Draft, Executed, Expired) — primary workflow status for amendment pipeline management."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Expansion, Contraction, Extension, Renewal, Termination) — used to segment modification activity by strategic intent."
    - name: "asc842_modification_type"
      expr: asc842_modification_type
      comment: "ASC 842 modification classification (Separate Contract vs Modification of Existing) — determines accounting treatment for remeasurement."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Escalation type in the revised lease terms — used to track changes in rent growth structure across amendments."
    - name: "remeasurement_required"
      expr: remeasurement_required
      comment: "Whether the amendment triggers ASC 842 remeasurement — compliance control for lease accounting close process."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective — used for time-series analysis of leasing activity and portfolio evolution."
  measures:
    - name: "total_amendments"
      expr: COUNT(amendment_id)
      comment: "Total number of lease amendments executed — measures leasing activity volume and portfolio modification intensity."
    - name: "total_revised_base_rent_monthly"
      expr: SUM(CAST(revised_base_rent_monthly AS DOUBLE))
      comment: "Total revised monthly base rent across all amendments — measures the aggregate rent impact of lease modifications on portfolio income."
    - name: "total_rent_change_monthly"
      expr: SUM(CAST(revised_base_rent_monthly AS DOUBLE) - CAST(prior_base_rent_monthly AS DOUBLE))
      comment: "Net change in monthly base rent from amendments (revised minus prior) — measures the revenue impact of lease modifications on portfolio NOI."
    - name: "total_revised_gla_sqft"
      expr: SUM(CAST(revised_gla_sqft AS DOUBLE))
      comment: "Total revised GLA square footage across amendments — measures the aggregate space impact of lease modifications."
    - name: "total_space_change_sqft"
      expr: SUM(CAST(revised_gla_sqft AS DOUBLE) - CAST(prior_gla_sqft AS DOUBLE))
      comment: "Net change in leased area from amendments (revised minus prior) — tracks portfolio expansion/contraction activity and absorption trends."
    - name: "total_ti_allowance_committed"
      expr: SUM(CAST(ti_allowance_amount AS DOUBLE))
      comment: "Total TI allowance committed through amendments — measures leasing incentive capital deployed via lease modifications."
    - name: "avg_revised_rent_psf_annual"
      expr: AVG(CAST(revised_rent_psf_annual AS DOUBLE))
      comment: "Average revised annual rent per square foot across amendments — benchmarking metric for re-leasing spread analysis versus prior rents."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate in revised lease terms — measures the quality of rent growth embedded in amended leases."
    - name: "remeasurement_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remeasurement_required = TRUE THEN amendment_id END) / NULLIF(COUNT(amendment_id), 0), 2)
      comment: "Percentage of amendments requiring ASC 842 remeasurement — compliance workload metric for lease accounting teams."
$$;