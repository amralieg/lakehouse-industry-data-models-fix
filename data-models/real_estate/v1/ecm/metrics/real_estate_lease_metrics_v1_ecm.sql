-- Metric views for domain: lease | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core lease agreement KPIs including portfolio value, occupancy economics, and lease term analytics for commercial and residential leasing operations"
  source: "`real_estate_ecm`.`lease`.`lease_agreement`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease agreement (active, expired, terminated, pending)"
    - name: "lease_classification"
      expr: lease_classification
      comment: "Accounting classification of the lease (operating, finance, capital) per ASC 842 / IFRS 16"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio segment classification (commercial, residential, retail, industrial, mixed-use)"
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced, used for vintage analysis"
    - name: "commencement_quarter"
      expr: DATE_TRUNC('quarter', commencement_date)
      comment: "Quarter the lease commenced, used for cohort analysis"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the lease expires, used for rollover planning"
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Type of rent escalation mechanism (fixed, CPI, percentage, stepped)"
    - name: "has_renewal_option"
      expr: renewal_option_exercised
      comment: "Whether the lease includes a renewal option that has been exercised"
    - name: "has_termination_option"
      expr: CASE WHEN termination_option_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether the lease includes an early termination option"
    - name: "has_exclusivity_clause"
      expr: exclusivity_clause
      comment: "Whether the lease includes an exclusivity clause restricting competing tenants"
  measures:
    - name: "total_lease_count"
      expr: COUNT(1)
      comment: "Total number of lease agreements in the portfolio"
    - name: "total_leased_area_sqft"
      expr: SUM(CAST(leased_area_sqft AS DOUBLE))
      comment: "Total leased area across all agreements in square feet"
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE))
      comment: "Total monthly base rent revenue across all leases"
    - name: "total_annual_base_rent"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE) * 12)
      comment: "Total annualized base rent revenue across all leases"
    - name: "avg_rent_psf_annual"
      expr: AVG(CAST(base_rent_psf_annual AS DOUBLE))
      comment: "Average annual rent per square foot across leases, key pricing benchmark"
    - name: "weighted_avg_lease_term_months"
      expr: AVG(CAST(lease_term_months AS DOUBLE))
      comment: "Average lease term in months, weighted by count, indicates portfolio stability"
    - name: "total_lease_liability"
      expr: SUM(CAST(lease_liability AS DOUBLE))
      comment: "Total lease liability recognized on balance sheet per ASC 842 / IFRS 16"
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value recognized on balance sheet"
    - name: "total_security_deposits_held"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held as collateral, represents tenant credit exposure"
    - name: "total_ti_allowance_committed"
      expr: SUM(CAST(ti_allowance_amount AS DOUBLE))
      comment: "Total tenant improvement allowances committed, represents landlord capital obligation"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used for lease liability calculation, reflects cost of capital"
    - name: "avg_rent_escalation_rate_pct"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate across leases, indicates inflation protection"
    - name: "avg_pro_rata_share_pct"
      expr: AVG(CAST(pro_rata_share AS DOUBLE))
      comment: "Average pro-rata share for CAM cost allocation, indicates tenant expense burden"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants in the portfolio, measures tenant concentration risk"
    - name: "distinct_asset_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique properties with active leases, measures geographic diversification"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent schedule KPIs tracking rent steps, escalations, and straight-line rent adjustments for revenue recognition and cash flow forecasting"
  source: "`real_estate_ecm`.`lease`.`rent_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the rent schedule (active, future, expired, superseded)"
    - name: "lease_classification"
      expr: lease_classification
      comment: "Accounting classification of the lease (operating, finance) for this schedule period"
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of rent escalation (fixed, CPI, percentage, stepped, market)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of rent payments (monthly, quarterly, annual)"
    - name: "is_free_rent_period"
      expr: is_free_rent_period
      comment: "Whether this schedule period represents a free rent concession"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the rent schedule becomes effective, used for revenue forecasting"
    - name: "effective_quarter"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the rent schedule becomes effective"
    - name: "step_sequence"
      expr: step_sequence
      comment: "Sequence number of the rent step within the lease term"
  measures:
    - name: "total_rent_schedule_count"
      expr: COUNT(1)
      comment: "Total number of rent schedule records (steps) across all leases"
    - name: "total_annual_rent_scheduled"
      expr: SUM(CAST(annual_rent_amount AS DOUBLE))
      comment: "Total annual rent scheduled across all active rent steps"
    - name: "total_base_rent_scheduled"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent scheduled for the period, excluding escalations"
    - name: "total_escalation_amount"
      expr: SUM(CAST(escalation_amount AS DOUBLE))
      comment: "Total escalation amount scheduled, represents rent growth"
    - name: "total_straight_line_rent"
      expr: SUM(CAST(straight_line_rent_amount AS DOUBLE))
      comment: "Total straight-line rent for revenue recognition per ASC 842"
    - name: "total_straight_line_adjustment"
      expr: SUM(CAST(straight_line_rent_adjustment AS DOUBLE))
      comment: "Total straight-line rent adjustment (deferred rent asset/liability)"
    - name: "avg_rent_psf"
      expr: AVG(CAST(rent_psf AS DOUBLE))
      comment: "Average rent per square foot across all rent schedules"
    - name: "avg_escalation_rate_pct"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average escalation rate across rent schedules, indicates portfolio rent growth"
    - name: "total_percentage_rent_breakpoint"
      expr: SUM(CAST(percentage_rent_breakpoint AS DOUBLE))
      comment: "Total percentage rent breakpoint thresholds, represents upside revenue potential"
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate above breakpoint, indicates revenue participation"
    - name: "total_lease_liability_scheduled"
      expr: SUM(CAST(lease_liability_amount AS DOUBLE))
      comment: "Total lease liability associated with scheduled rent payments"
    - name: "total_rou_asset_scheduled"
      expr: SUM(CAST(rou_asset_amount AS DOUBLE))
      comment: "Total right-of-use asset associated with scheduled rent payments"
    - name: "distinct_lease_count"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Number of unique leases with active rent schedules"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease payment KPIs tracking collections, delinquency, and cash flow performance for accounts receivable and treasury management"
  source: "`real_estate_ecm`.`lease`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (paid, pending, partial, reversed, NSF)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, wire, check, credit card, cash)"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge being paid (base rent, CAM, percentage rent, late fee, utilities)"
    - name: "is_delinquent"
      expr: is_delinquent
      comment: "Whether the payment is delinquent (past due date)"
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Whether the payment is partial (less than amount due)"
    - name: "nsf_flag"
      expr: nsf_flag
      comment: "Whether the payment was returned for non-sufficient funds"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was received, used for cash flow analysis"
    - name: "payment_quarter"
      expr: DATE_TRUNC('quarter', payment_date)
      comment: "Quarter the payment was received"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month the payment was received, used for monthly cash flow reporting"
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year the payment was due, used for aging analysis"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected across all payments, key treasury metric"
    - name: "total_amount_due"
      expr: SUM(CAST(amount_due AS DOUBLE))
      comment: "Total amount due across all payment records"
    - name: "total_amount_applied"
      expr: SUM(CAST(amount_applied AS DOUBLE))
      comment: "Total amount applied to tenant accounts, may differ from paid due to timing"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all tenant accounts, key AR metric"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash (prepayments or unallocated payments)"
    - name: "total_late_fees_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees assessed on delinquent payments, indicates collection issues"
    - name: "avg_days_past_due"
      expr: AVG(CAST(days_past_due AS DOUBLE))
      comment: "Average days past due for delinquent payments, measures collection efficiency"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of amounts due that were collected, key performance indicator for AR"
    - name: "delinquency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_delinquent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that are delinquent, measures credit risk"
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned for NSF, indicates tenant financial distress"
    - name: "partial_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_payment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that are partial, indicates collection challenges"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants making payments in the period"
    - name: "distinct_lease_count"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Number of unique leases with payment activity"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_cam_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Common Area Maintenance (CAM) reconciliation KPIs tracking estimated vs actual CAM charges, tenant recoveries, and reconciliation variances for operating expense management"
  source: "`real_estate_ecm`.`lease`.`cam_schedule`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the CAM reconciliation (draft, sent, disputed, finalized, paid)"
    - name: "reconciliation_year"
      expr: reconciliation_year
      comment: "Year of the CAM reconciliation period"
    - name: "cam_cap_type"
      expr: cam_cap_type
      comment: "Type of CAM cap applied (fixed, percentage, cumulative, none)"
    - name: "cam_cap_applied"
      expr: cam_cap_applied
      comment: "Whether a CAM cap was applied to limit tenant exposure"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the tenant has disputed the CAM reconciliation"
    - name: "credit_or_charge_type"
      expr: credit_or_charge_type
      comment: "Whether the reconciliation resulted in a credit to tenant or additional charge"
    - name: "reconciliation_quarter"
      expr: DATE_TRUNC('quarter', reconciliation_period_start)
      comment: "Quarter of the reconciliation period start"
  measures:
    - name: "total_cam_reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of CAM reconciliations processed"
    - name: "total_estimated_cam_annual"
      expr: SUM(CAST(estimated_cam_annual AS DOUBLE))
      comment: "Total estimated CAM charges billed to tenants during the year"
    - name: "total_actual_cam_gross"
      expr: SUM(CAST(actual_cam_gross AS DOUBLE))
      comment: "Total actual CAM expenses incurred before gross-up adjustments"
    - name: "total_actual_cam_grossed_up"
      expr: SUM(CAST(actual_cam_grossed_up AS DOUBLE))
      comment: "Total actual CAM expenses after gross-up for vacancy, represents recoverable amount"
    - name: "total_tenant_cam_allocated"
      expr: SUM(CAST(tenant_cam_allocated AS DOUBLE))
      comment: "Total CAM allocated to tenants based on pro-rata share"
    - name: "total_reconciliation_variance"
      expr: SUM(CAST(reconciliation_variance AS DOUBLE))
      comment: "Total variance between estimated and actual CAM (positive = tenant owes, negative = tenant credit)"
    - name: "total_credit_or_charge_amount"
      expr: SUM(CAST(credit_or_charge_amount AS DOUBLE))
      comment: "Total net credit or charge amount resulting from reconciliation"
    - name: "total_cam_cap_savings"
      expr: SUM(CAST(cam_cap_savings AS DOUBLE))
      comment: "Total savings to tenants from CAM cap application, represents landlord expense absorption"
    - name: "total_cam_exclusions"
      expr: SUM(CAST(cam_exclusions_amount AS DOUBLE))
      comment: "Total expenses excluded from CAM recovery per lease terms"
    - name: "total_admin_fee_amount"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total administrative fees charged on CAM, represents landlord margin"
    - name: "avg_actual_cam_psf"
      expr: AVG(CAST(actual_cam_psf AS DOUBLE))
      comment: "Average actual CAM cost per square foot, key operating expense benchmark"
    - name: "avg_estimated_cam_psf"
      expr: AVG(CAST(estimated_cam_psf AS DOUBLE))
      comment: "Average estimated CAM cost per square foot billed to tenants"
    - name: "avg_tenant_prorata_share_pct"
      expr: AVG(CAST(tenant_prorata_share AS DOUBLE))
      comment: "Average tenant pro-rata share for CAM allocation"
    - name: "cam_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tenant_cam_allocated AS DOUBLE)) / NULLIF(SUM(CAST(actual_cam_grossed_up AS DOUBLE)), 0), 2)
      comment: "Percentage of actual CAM expenses recovered from tenants, key profitability metric"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAM reconciliations disputed by tenants, indicates billing accuracy issues"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants with CAM reconciliations"
    - name: "distinct_lease_count"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Number of unique leases with CAM reconciliations"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_accounting_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease accounting KPIs tracking ASC 842 / IFRS 16 compliance including ROU asset amortization, lease liability movements, and interest expense for financial reporting"
  source: "`real_estate_ecm`.`lease`.`accounting_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the accounting entry (draft, posted, reversed, adjusted)"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of accounting entry (initial recognition, remeasurement, amortization, interest, termination)"
    - name: "lease_classification"
      expr: lease_classification
      comment: "Lease classification (operating, finance) for the accounting entry"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accounting entry"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the accounting entry"
    - name: "modification_flag"
      expr: modification_flag
      comment: "Whether the entry relates to a lease modification"
    - name: "practical_expedient_applied"
      expr: practical_expedient_applied
      comment: "Practical expedient applied per ASC 842 (short-term, low-value, etc.)"
    - name: "accounting_period_year"
      expr: YEAR(accounting_period_date)
      comment: "Year of the accounting period"
    - name: "accounting_period_quarter"
      expr: DATE_TRUNC('quarter', accounting_period_date)
      comment: "Quarter of the accounting period"
  measures:
    - name: "total_accounting_entry_count"
      expr: COUNT(1)
      comment: "Total number of lease accounting entries recorded"
    - name: "total_rou_asset_additions"
      expr: SUM(CAST(rou_asset_additions AS DOUBLE))
      comment: "Total right-of-use asset additions (new leases and modifications)"
    - name: "total_rou_asset_amortisation"
      expr: SUM(CAST(rou_asset_amortisation AS DOUBLE))
      comment: "Total ROU asset amortization expense for the period"
    - name: "total_rou_asset_impairment"
      expr: SUM(CAST(rou_asset_impairment AS DOUBLE))
      comment: "Total ROU asset impairment charges, indicates lease value deterioration"
    - name: "total_rou_asset_opening_balance"
      expr: SUM(CAST(rou_asset_opening_balance AS DOUBLE))
      comment: "Total ROU asset opening balance for the period"
    - name: "total_rou_asset_closing_balance"
      expr: SUM(CAST(rou_asset_closing_balance AS DOUBLE))
      comment: "Total ROU asset closing balance for the period"
    - name: "total_lease_liability_opening_balance"
      expr: SUM(CAST(lease_liability_opening_balance AS DOUBLE))
      comment: "Total lease liability opening balance for the period"
    - name: "total_lease_liability_closing_balance"
      expr: SUM(CAST(lease_liability_closing_balance AS DOUBLE))
      comment: "Total lease liability closing balance for the period"
    - name: "total_lease_liability_remeasurement"
      expr: SUM(CAST(lease_liability_remeasurement AS DOUBLE))
      comment: "Total lease liability remeasurement adjustments (modifications, reassessments)"
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities, key P&L impact"
    - name: "total_principal_repayment"
      expr: SUM(CAST(principal_repayment AS DOUBLE))
      comment: "Total principal repayment on lease liabilities (cash flow statement impact)"
    - name: "total_straight_line_rent_expense"
      expr: SUM(CAST(straight_line_rent_expense AS DOUBLE))
      comment: "Total straight-line rent expense for operating leases"
    - name: "total_variable_lease_cost"
      expr: SUM(CAST(variable_lease_cost AS DOUBLE))
      comment: "Total variable lease costs not included in lease liability (CAM, percentage rent)"
    - name: "total_short_term_lease_cost"
      expr: SUM(CAST(short_term_lease_cost AS DOUBLE))
      comment: "Total short-term lease costs (practical expedient applied)"
    - name: "total_sublease_income"
      expr: SUM(CAST(sublease_income AS DOUBLE))
      comment: "Total sublease income recognized, offsets lease expense"
    - name: "total_lease_incentive_received"
      expr: SUM(CAST(lease_incentive_received AS DOUBLE))
      comment: "Total lease incentives received from lessors (TI allowances, rent abatements)"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used for lease liability measurement"
    - name: "avg_weighted_avg_discount_rate_pct"
      expr: AVG(CAST(weighted_avg_discount_rate AS DOUBLE))
      comment: "Weighted average discount rate across the lease portfolio"
    - name: "avg_weighted_avg_remaining_term_years"
      expr: AVG(CAST(weighted_avg_remaining_term_years AS DOUBLE))
      comment: "Weighted average remaining lease term in years, indicates portfolio maturity"
    - name: "total_maturity_year1_payments"
      expr: SUM(CAST(maturity_year1_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due in year 1, key liquidity metric"
    - name: "total_maturity_year2_to5_payments"
      expr: SUM(CAST(maturity_year2_to5_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due in years 2-5"
    - name: "total_maturity_after_year5_payments"
      expr: SUM(CAST(maturity_after_year5_payments AS DOUBLE))
      comment: "Total undiscounted lease payments due after year 5"
    - name: "distinct_lease_count"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Number of unique leases with accounting entries"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease termination KPIs tracking early terminations, holdovers, financial settlements, and derecognition impacts for portfolio churn and risk management"
  source: "`real_estate_ecm`.`lease`.`termination`"
  dimensions:
    - name: "termination_status"
      expr: termination_status
      comment: "Status of the termination (pending, executed, settled, disputed)"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (early, mutual, default, expiration, holdover)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for termination (business closure, relocation, default, downsizing)"
    - name: "initiating_party"
      expr: initiating_party
      comment: "Party initiating the termination (tenant, landlord, mutual)"
    - name: "lease_classification"
      expr: lease_classification
      comment: "Lease classification at termination (operating, finance)"
    - name: "holdover_status_at_termination"
      expr: holdover_status_at_termination
      comment: "Whether the tenant was in holdover status at termination"
    - name: "fee_waived"
      expr: fee_waived
      comment: "Whether the termination fee was waived by landlord"
    - name: "restoration_required"
      expr: restoration_required
      comment: "Whether space restoration was required per lease terms"
    - name: "security_deposit_processed"
      expr: security_deposit_processed
      comment: "Whether the security deposit has been processed and returned/forfeited"
    - name: "termination_year"
      expr: YEAR(effective_date)
      comment: "Year the termination became effective"
    - name: "termination_quarter"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the termination became effective"
  measures:
    - name: "total_termination_count"
      expr: COUNT(1)
      comment: "Total number of lease terminations, measures portfolio churn"
    - name: "total_termination_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total termination fees collected from tenants"
    - name: "total_outstanding_ar_balance"
      expr: SUM(CAST(outstanding_ar_balance AS DOUBLE))
      comment: "Total outstanding AR balance at termination, represents collection risk"
    - name: "total_security_deposit_amount"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held at termination"
    - name: "total_security_deposit_forfeited"
      expr: SUM(CAST(security_deposit_forfeited_amount AS DOUBLE))
      comment: "Total security deposits forfeited by tenants, indicates default severity"
    - name: "total_security_deposit_returned"
      expr: SUM(CAST(security_deposit_return_amount AS DOUBLE))
      comment: "Total security deposits returned to tenants"
    - name: "total_restoration_cost_estimate"
      expr: SUM(CAST(restoration_cost_estimate AS DOUBLE))
      comment: "Total estimated restoration costs, represents landlord capital requirement"
    - name: "total_unamortized_ti_balance"
      expr: SUM(CAST(unamortized_ti_balance AS DOUBLE))
      comment: "Total unamortized tenant improvement balance at termination, represents landlord loss"
    - name: "total_rou_asset_derecognition"
      expr: SUM(CAST(rou_asset_derecognition_amount AS DOUBLE))
      comment: "Total ROU asset derecognition amount for ASC 842 compliance"
    - name: "total_lease_liability_derecognition"
      expr: SUM(CAST(lease_liability_derecognition_amount AS DOUBLE))
      comment: "Total lease liability derecognition amount for ASC 842 compliance"
    - name: "total_gain_loss_on_termination"
      expr: SUM(CAST(gain_loss_on_termination AS DOUBLE))
      comment: "Total gain or loss recognized on lease termination, P&L impact"
    - name: "avg_notice_period_days"
      expr: AVG(CAST(notice_period_days AS DOUBLE))
      comment: "Average notice period in days for terminations"
    - name: "avg_cure_period_days"
      expr: AVG(CAST(cure_period_days AS DOUBLE))
      comment: "Average cure period in days for default terminations"
    - name: "termination_fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fee_waived = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations where fee was waived, indicates negotiation outcomes"
    - name: "security_deposit_forfeiture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(security_deposit_forfeited_amount AS DOUBLE)) / NULLIF(SUM(CAST(security_deposit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of security deposits forfeited, indicates default severity"
    - name: "holdover_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN holdover_status_at_termination = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations where tenant was in holdover, indicates lease management issues"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants with terminations"
    - name: "distinct_asset_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique properties with terminations"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`lease_percentage_rent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Percentage rent KPIs tracking sales-based rent above breakpoint thresholds, tenant sales performance, and audit variances for retail leasing revenue optimization"
  source: "`real_estate_ecm`.`lease`.`percentage_rent`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the percentage rent reconciliation (pending, finalized, disputed, audited)"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual)"
    - name: "breakpoint_type"
      expr: breakpoint_type
      comment: "Type of breakpoint (natural, artificial, tiered)"
    - name: "lease_structure_type"
      expr: lease_structure_type
      comment: "Lease structure type (base + percentage, percentage only, tiered)"
    - name: "audit_right_exercised"
      expr: audit_right_exercised
      comment: "Whether landlord exercised audit rights on tenant sales"
    - name: "sales_report_late"
      expr: sales_report_late
      comment: "Whether tenant sales report was submitted late"
    - name: "tiered_rate_applicable"
      expr: tiered_rate_applicable
      comment: "Whether tiered percentage rent rates apply"
    - name: "reporting_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of the reporting period"
    - name: "reporting_quarter"
      expr: DATE_TRUNC('quarter', reporting_period_start_date)
      comment: "Quarter of the reporting period"
  measures:
    - name: "total_percentage_rent_count"
      expr: COUNT(1)
      comment: "Total number of percentage rent calculations"
    - name: "total_reported_gross_sales"
      expr: SUM(CAST(reported_gross_sales AS DOUBLE))
      comment: "Total gross sales reported by tenants, key retail performance metric"
    - name: "total_audited_gross_sales"
      expr: SUM(CAST(audited_gross_sales AS DOUBLE))
      comment: "Total gross sales after audit adjustments"
    - name: "total_net_sales_for_calculation"
      expr: SUM(CAST(net_sales_for_calculation AS DOUBLE))
      comment: "Total net sales used for percentage rent calculation (after exclusions)"
    - name: "total_sales_exclusions"
      expr: SUM(CAST(sales_exclusions_amount AS DOUBLE))
      comment: "Total sales exclusions per lease terms (returns, taxes, etc.)"
    - name: "total_sales_over_breakpoint"
      expr: SUM(CAST(sales_over_breakpoint AS DOUBLE))
      comment: "Total sales exceeding breakpoint threshold, represents percentage rent base"
    - name: "total_percentage_rent_calculated"
      expr: SUM(CAST(pct_rent_calculated AS DOUBLE))
      comment: "Total percentage rent calculated based on sales over breakpoint"
    - name: "total_percentage_rent_billed"
      expr: SUM(CAST(pct_rent_billed AS DOUBLE))
      comment: "Total percentage rent billed to tenants"
    - name: "total_percentage_rent_collected"
      expr: SUM(CAST(pct_rent_collected AS DOUBLE))
      comment: "Total percentage rent collected from tenants, key revenue metric"
    - name: "total_audit_variance"
      expr: SUM(CAST(audit_variance_amount AS DOUBLE))
      comment: "Total variance between reported and audited sales, indicates reporting accuracy"
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage_rate AS DOUBLE))
      comment: "Average percentage rent rate across leases"
    - name: "avg_natural_breakpoint"
      expr: AVG(CAST(natural_breakpoint_amount AS DOUBLE))
      comment: "Average natural breakpoint (base rent / percentage rate)"
    - name: "avg_artificial_breakpoint"
      expr: AVG(CAST(artificial_breakpoint_amount AS DOUBLE))
      comment: "Average artificial breakpoint negotiated in lease"
    - name: "percentage_rent_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(pct_rent_collected AS DOUBLE)) / NULLIF(SUM(CAST(pct_rent_billed AS DOUBLE)), 0), 2)
      comment: "Percentage of billed percentage rent collected, measures collection efficiency"
    - name: "sales_over_breakpoint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(sales_over_breakpoint AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenants exceeding breakpoint, indicates retail performance"
    - name: "audit_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(audit_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(reported_gross_sales AS DOUBLE)), 0), 2)
      comment: "Audit variance as percentage of reported sales, indicates reporting accuracy"
    - name: "late_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sales_report_late = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales reports submitted late, indicates compliance issues"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants with percentage rent provisions"
    - name: "distinct_lease_count"
      expr: COUNT(DISTINCT lease_agreement_id)
      comment: "Number of unique leases with percentage rent activity"
$$;